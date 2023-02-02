Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84403688182
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBBPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjBBPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:16:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12692EE8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:16:44 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mc11so6810132ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD84VEFRzA59hsw0tKWfWwMdLIT0/a/+q7byCEgsbro=;
        b=IMIUFGidYMeJej6oq94xPl74Wcf3pVaqArds5hGhIzbPUuF5dHMF9yNZYDmIOk3v6p
         2ACOat8NrDDe45iu7fQvD3MB7dtxQ+P/Cag1we22A8GTZNwP0K0jkdezNpiTvwBgjfqV
         Rc0rhlIqGTrhsUmudjHXSYJygcXDXMb11OUikN96dkYI/lcvaWiLgujWvQtd+oJD028B
         bF2p/Wx6CbRzqPlViY4Qi/25j5sOSAo7/6bC1bl/rEqygNlbJq5xinXF+i4Gio+/DvH8
         vJOcPm2LkXl88woWJxPQiPwV3tIItKDiAg0eWeDnb9ys2pCe8zjfbS5zXRropFM1mpFk
         lEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD84VEFRzA59hsw0tKWfWwMdLIT0/a/+q7byCEgsbro=;
        b=gHNtQzILYNDUXqiJlUiqcqQekeRIBLbUprOqasvLVF6cyS62rsWt0rqhfqJdCU5mUf
         wJRwv2/Mne+RPIHjY7wNm+EHCctyroVICXVFz1qWbStU24spV6o74UEdn582JzgRhVax
         qYnkWuuD+ITGPz8UYbohJhJBFMCz5vZls5EQehpeqPm30aghT8W0gPCpIKDyBaSuoFuN
         FUw6YorfY7sukiFdFc2nJiN6Q0vTFl1q1Wjmrdl7SKt+qBQqssGZcL0NBCqWKVNtEXvU
         XVNzl0ZZre/whEAzaH6+5zpKalDe1rHro/KuOGein/TW43uojvPXTx6uJJ0Wtn0SR+s/
         UFTQ==
X-Gm-Message-State: AO0yUKWrFiqqmI5NprpGpkctyHVUwywkPXnZAt5fp0xcGyc3fOyCc+LZ
        hbJXJomnQQzqZyFz+zSRJTNx1g==
X-Google-Smtp-Source: AK7set9OLG5Fl/HxkXD3qR5wWeHKevH2Mgcbc8T5JAFPGupVN5Uy75fuy7rPSjLpC8lnqsI6ByX96Q==
X-Received: by 2002:a17:906:5dcc:b0:884:930:b014 with SMTP id p12-20020a1709065dcc00b008840930b014mr6436385ejv.6.1675351003380;
        Thu, 02 Feb 2023 07:16:43 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b008775b8a5a5fsm11590784ejx.198.2023.02.02.07.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:16:43 -0800 (PST)
Message-ID: <2433c2c7-664d-0d1f-12ae-374cbd093dc0@linaro.org>
Date:   Thu, 2 Feb 2023 16:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 5/6] mailbox: qcom-apcs-ipc: add IPQ5332 APSS clock
 support
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-6-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230202145208.2328032-6-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 15:52, Kathiravan T wrote:
> IPQ5332 has the APSS clock controller utilizing the same register space
> as the APCS, so provide access to the APSS utilizing a child device like
> other IPQ chipsets.
> 
> Like IPQ6018, the same controller and driver is used, so utilize IPQ6018
> match data for IPQ5332.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 0e9f9cba8668..9d1f1b8671fc 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -141,6 +141,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  
>  /* .data is the offset of the ipc register within the global block */
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
> +	{ .compatible = "qcom,ipq5332-apcs-apps-global", .data = &ipq6018_apcs_data },
>  	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
>  	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
>  	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
