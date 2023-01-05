Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B065EDE2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjAENxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbjAENwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:52:38 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD14FCF9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:49:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id p15so10000947ilg.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EfeHl/1IP+/07uVo+FHPk5/ivN0KbKakriNv0+4520=;
        b=Scqia4TJZnPMkNtHlIxXKtrvV2pTkX4dtZU5j1YO32Afq2FImMOQr1YDeT33Q044Hn
         Rj+rUZMYactEz/ol9Pd2SzaYfMZUWjxR6HK6fbf2L7LJIrxdZ8e5AYxTbq2FG2QtD7gB
         Zb20cRO/p6Tq7PxbcZBXFd6bmUx8BvNmFyVbgkQafC5i9gB/QY9MtEHv9GQ+wj1Llbr8
         o250+sAHctdBjpv+9U3VJcfuED8UHWJQSJkjOyl2+yiZLdUw2aXjyu9/QWTWzkaH5aFO
         bU3zjM+CsJQBacFlqOH0gTM9/l3CRFsF+nlaRkf6lcRZEcfDtINUz+MXicfhFp8dipJ/
         OvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EfeHl/1IP+/07uVo+FHPk5/ivN0KbKakriNv0+4520=;
        b=17IphBbUAojjJRT5fj1Cq7qKaBmdFOrbj5/d2SQQocRk2jUcmDP5scfjGGwdx7KSYq
         fys2YaXV3RWIEKHgs3Wqcl4PiFQthbjTxFyi0++6hASz+pqPPinOUL6CBuQ3gQpDL15Q
         8jwTKiiPsy9h/Q3HVQzK/Tjfgucgh1jEp6HOVslRNCexQ0CZgIHeVZVB+haQVkS0TaEG
         VFj1GpBdvpTI1I5pWc0rPe/wQNZehFjbzOW3IMWRlmsdksmnUiVazteVdGKEzMiHrspZ
         QAzXYR/aD6qR0fkMbmngP+v9zv4lR7rOS1Ce6ris1XFEeRwTosD0jFFz4ru9Et3E4IXd
         ZwwQ==
X-Gm-Message-State: AFqh2kpO+74HALxuzKQF2CeFCtMGDyzMBrbde/gErgwu+x9M7mmF8d+Y
        CFL8pC2GFWduWxglENg3iiFvZ8z6LkjL8O/y
X-Google-Smtp-Source: AMrXdXsC/WGH3nsIZ+TZSjxmRvA1203bSoNwX7Pc2WkYE+Bmrki+6Qsf4Uual2d6s1+XRLim/sHbqg==
X-Received: by 2002:a05:6e02:f51:b0:30d:6d3f:59e1 with SMTP id y17-20020a056e020f5100b0030d6d3f59e1mr4692702ilj.31.1672926583566;
        Thu, 05 Jan 2023 05:49:43 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id v14-20020a92cd4e000000b0030258f9670bsm11499428ilq.13.2023.01.05.05.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 05:49:43 -0800 (PST)
Message-ID: <70de4cd6-1bbf-24bb-a5c2-209cc4f8f555@linaro.org>
Date:   Thu, 5 Jan 2023 07:49:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] soc: qcom: dcc: Signedness bug in
 config_reset_write()
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <Y7asNqoIapctHmbI@kili>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <Y7asNqoIapctHmbI@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 4:53 AM, Dan Carpenter wrote:
> The "ret" variable needs to be signed for the error handling to work.

The fix looks good.  I'm sorry I missed this one in review.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Fixes: 4cbe60cf5ad6 ("soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>   drivers/soc/qcom/dcc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
> index d4101f79cb5d..1e2cbefc1655 100644
> --- a/drivers/soc/qcom/dcc.c
> +++ b/drivers/soc/qcom/dcc.c
> @@ -808,8 +808,9 @@ static ssize_t config_reset_write(struct file *filp,
>   				  const char __user *user_buf, size_t count,
>   				  loff_t *ppos)
>   {
> -	unsigned int val, ret;
> +	unsigned int val;
>   	struct dcc_drvdata *drvdata = filp->private_data;
> +	int ret;
>   
>   	ret = kstrtouint_from_user(user_buf, count, 0, &val);
>   	if (ret < 0)

