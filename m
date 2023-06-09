Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1428C729DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFIPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFIPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:07:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8763198C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:07:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso2374607e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686323224; x=1688915224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HRF2b1CvR2hajy1IOanokuAFQMVHjoB8ThV/p26Mgo=;
        b=f1PxIDpuX/zlqFfWw+blXBSi9DeKzHcZsnncbPmp9adn2niqylXij/tJltEQSZatdt
         Lsl7s4HX/edkwJrU2V14/47oNsmDYTIx7JGn/AYXNsXsrQScpuLRLlcl8zJS2Hocs40C
         VDMzuZ1YBYGfXVQz9rtcVLe6CEl7DE099a5fhu9VVW2OcVCrNIc5AakezLanqhoZENv8
         9MRvR9QD8LwCxHSZFg8qP+L7pKYntsUZy30z6bu+uQ2e0zrJ8bYOLRXUGgzaXy0H+0bD
         WnwFreMG69jOZojwbQ6ZipGcGxZZtNE2wEzzbFTJRYbOnv1yV+DitQxj//8v4SYvMFGc
         sDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323224; x=1688915224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HRF2b1CvR2hajy1IOanokuAFQMVHjoB8ThV/p26Mgo=;
        b=CdgeZ06GQhGiPZ0kcbv4At1B9Ux6rD+Iv6mkpuQuh4DKZFGpm6Hux0hN50mKpz6PK0
         w+0XDloCdfwzQJlQuHPxrUYx7rtqHaOjzeSD/xJl8CqJEOGzrP7ud4TMtjiGT3z59MES
         HSS11lWEwHvVvTPyQkAwckrV7Fkdldb4JqWltRIh03hZhoXSfbiQo/XUdMDMo7iQJZRe
         d1bV8P0kXiFnyXcjaLk+ByCUiugoDcTc9i3EMslCDBlj9lWODcJ9fOSMAFyW41xQ/gfJ
         YWqcqvZhoYSF3h3aONJAn6uxKFkDP5CwDwz791IK3gE1kRrw+lSl5VAhwX5DBNuxBMjI
         tzMA==
X-Gm-Message-State: AC+VfDwxPflsI72KDiKBIE4WsKV3d+95my/FW7G27X9yqsyfU+DfJatf
        oX+UY2zxVPjFzEgBCr0vQU0Osw==
X-Google-Smtp-Source: ACHHUZ7SHhOs7l2r+XB9S3ahIrZZvIAkME/tcLdio2OOfNuWXJq5cfITXW3St68pwNFU5EN8sFje/g==
X-Received: by 2002:ac2:4643:0:b0:4f4:af2c:97e with SMTP id s3-20020ac24643000000b004f4af2c097emr1110419lfo.11.1686323224152;
        Fri, 09 Jun 2023 08:07:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y8-20020a197508000000b004f3b4a9a60esm581582lfe.106.2023.06.09.08.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:07:03 -0700 (PDT)
Message-ID: <6b55b3f6-6424-4d7c-4782-d2de41df1f85@linaro.org>
Date:   Fri, 9 Jun 2023 17:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 07/12] rpmsg: qcom_smd: Use qcom_smem_is_available()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
 <20230531-rpm-rproc-v2-7-56a4a00c8260@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v2-7-56a4a00c8260@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.06.2023 09:10, Stephan Gerhold wrote:
> Rather than looking up a dummy item from SMEM, use the new
> qcom_smem_is_available() function to make the code more clear
> (and reduce the overhead slightly).
> 
> Add the same check to qcom_smd_register_edge() as well to ensure that
> it only succeeds if SMEM is already available - if a driver calls the
> function and SMEM is not available yet then the initial state will be
> read incorrectly and the RPMSG devices might never become available.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/rpmsg/qcom_smd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 7b9c298aa491..43f601c84b4f 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1479,6 +1479,9 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
>  	struct qcom_smd_edge *edge;
>  	int ret;
>  
> +	if (!qcom_smem_is_available())
> +		return ERR_PTR(-EPROBE_DEFER);
> +
>  	edge = kzalloc(sizeof(*edge), GFP_KERNEL);
>  	if (!edge)
>  		return ERR_PTR(-ENOMEM);
> @@ -1553,12 +1556,9 @@ EXPORT_SYMBOL(qcom_smd_unregister_edge);
>  static int qcom_smd_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node;
> -	void *p;
>  
> -	/* Wait for smem */
> -	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
> -	if (PTR_ERR(p) == -EPROBE_DEFER)
> -		return PTR_ERR(p);
> +	if (!qcom_smem_is_available())
> +		return -EPROBE_DEFER;
>  
>  	for_each_available_child_of_node(pdev->dev.of_node, node)
>  		qcom_smd_register_edge(&pdev->dev, node);
> 
