Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452A6722FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjFETpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjFETpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:45:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D66F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:45:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso38757931fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994338; x=1688586338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcZ93fvlNJOqEO0Tdnw3u/AdHxtIux+b0q18hlD/gSA=;
        b=hJfacGJKJPT71X6jtrr8ZfxHcePnVyeBvNVQMNHCgz/Lf18kj3AceRWGUXv1oJvSpK
         vzK/wFbc9scOgbo8HjoXwk7uFFyj2O4s3rm7N4OlnZ25cwhXlywk68ySWCPWX8OEmeEw
         fgzDBmTl7/5IuJR97Yp57a8DrXtDLE6XuOa/rIJzbc/14k5xTuvrl3CfEEJ6VOxV311E
         DZi/IneYbXGp6Ga09fRl4PE9t5iM4hTdYGvxEidbav0IOBydjVErJhSwR9yzWJJM9S4T
         +dEZg2wlKiIZO4AMTBAbGSYDYhWzhpLCPR4gTC+bK2HdM3hGxIH1Ea2Am542CKmSh5N+
         Cb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994338; x=1688586338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcZ93fvlNJOqEO0Tdnw3u/AdHxtIux+b0q18hlD/gSA=;
        b=Aq/BLuFPNBYS4wyRqhoHYRRs8HNlLrn3NTdAB1ssbd1/F4plSiDSSkwAyMofrkX1uY
         QQnpyVvj45OP1sbEzZGRtDHzPN5sFJOtCD0yV077tb+sdOZQtkja2bbwk7mDQjjkSWOw
         lgkpqu/MPc4H9Beof7sn20698Y90HBul3Aiusv4kSY2CM5CO5/SmXuHAhgEyphgstT0C
         JYatYroFIG6i53IpSuirMfukPmwmG9j1InlWRVOHrtcn1SSaG6y0Pgtxhj6syCRsb3ms
         lGbh+/PErw/p63c/aEqzlwCuDtOwKkpquPVDFgqUHtSRjfWyPojMbBP257V7efi8r/tz
         Rjng==
X-Gm-Message-State: AC+VfDwNodvO2IcEw7qvZIfguiLA8DQ07i/RfJSUrK2qL8WT1Xq+vmXy
        hUU/RyX7ZL5dXCcUUF41ia4ORQ==
X-Google-Smtp-Source: ACHHUZ6XGScdOXdySH1nJFnHwOrswCz1ofcR8yZ684/kUM758Hm/V8LTD7XLvT62BZKKf135ntqRAA==
X-Received: by 2002:a2e:3515:0:b0:2b1:b6e9:b803 with SMTP id z21-20020a2e3515000000b002b1b6e9b803mr147678ljz.17.1685994338211;
        Mon, 05 Jun 2023 12:45:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id i13-20020a2e864d000000b002a7853b9339sm1575768ljj.119.2023.06.05.12.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:45:37 -0700 (PDT)
Message-ID: <909e2780-80d1-3c9d-7be3-bd2d0c0c6e69@linaro.org>
Date:   Mon, 5 Jun 2023 21:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 09/14] rpmsg: qcom_smd: Use qcom_smem_is_available()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-9-e0a3b6de1f14@gerhold.net>
 <0f48649e-27d6-97f7-98b8-fe10b99d0236@linaro.org>
 <ZH407yP8RQmTlQtf@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZH407yP8RQmTlQtf@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 21:18, Stephan Gerhold wrote:
> On Mon, Jun 05, 2023 at 08:56:44PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 5.06.2023 09:08, Stephan Gerhold wrote:
>>> Rather than looking up a dummy item from SMEM, use the new
>>> qcom_smem_is_available() function to make the code more clear
>>> (and reduce the overhead slightly).
>>>
>>> Add the same check to qcom_smd_register_edge() as well to ensure that
>>> it only succeeds if SMEM is already available - if a driver calls the
>>> function and SMEM is not available yet then the initial state will be
>>> read incorrectly and the RPMSG devices might never become available.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
>>>  drivers/rpmsg/qcom_smd.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
>>> index 7b9c298aa491..43f601c84b4f 100644
>>> --- a/drivers/rpmsg/qcom_smd.c
>>> +++ b/drivers/rpmsg/qcom_smd.c
>>> @@ -1479,6 +1479,9 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
>>>  	struct qcom_smd_edge *edge;
>>>  	int ret;
>>>  
>>> +	if (!qcom_smem_is_available())
>>> +		return ERR_PTR(-EPROBE_DEFER);
>>> +
>>>  	edge = kzalloc(sizeof(*edge), GFP_KERNEL);
>>>  	if (!edge)
>>>  		return ERR_PTR(-ENOMEM);
>>> @@ -1553,12 +1556,9 @@ EXPORT_SYMBOL(qcom_smd_unregister_edge);
>>>  static int qcom_smd_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device_node *node;
>>> -	void *p;
>>>  
>>> -	/* Wait for smem */
>>> -	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
>>> -	if (PTR_ERR(p) == -EPROBE_DEFER)
>>> -		return PTR_ERR(p);
>>> +	if (!qcom_smem_is_available())
>>> +		return -EPROBE_DEFER;
>>>  
>>>  	for_each_available_child_of_node(pdev->dev.of_node, node)
>>>  		qcom_smd_register_edge(&pdev->dev, node);
>> Hm.. we're not checking the return value here, at all.. Perhaps that
>> could be improved and we could only check for smem presence inside
>> qcom_smd_register_edge()?
>>
> 
> I think the goal here it to register as many of the edges as possible,
> so we wouldn't necessarily want to abort if one of them fails. That's
> why it's enough to check for only for a possible -EPROBE_DEFER first.
Hm I guess that's the better option, killing the entire platform (no
rpm = no anything) because one edge failed to register would be not
very user friendly..

> 
> But more importantly after this series this is legacy code that exists
> only for backwards compatibility with older DTBs. The probe function
> won't be called for DTBs in mainline anymore. So I think it's not worth
> to improve it much anymore. ;)
Right!

Konrad
> 
> Thanks,
> Stephan
