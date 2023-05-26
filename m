Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA2712367
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbjEZJWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbjEZJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:22:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD0E46
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:22:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso552737e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685092949; x=1687684949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRfQU9Vgx/AzcJ7ol3cHzzpIjDBNKolCIVxAtbmZ+2k=;
        b=FBoQT+ybvWYeW9/YpA+U8h2BGehqbh44Y88VaoliiN1jPt+ySVKQTOKP3pPtA3OFaC
         tPYoxwU8Z7PgZo1QxHxGNVr9d6Fiq4o0HJE5xDAM0Mxs7zoU4YKvffB7Bk2rWr08JvTA
         FXjjWnP6PGkXX37VkDpY2RbXde/2ypr5CFzmb0yzziMirZ/ogn4GvalIgOx2MVqqPQ7i
         66hnwsV+pq4QCeYELO2a7Tm3JWXKEGd22JGYPymf4glrFMMh6jK6jvKROA4l19GCWEVr
         BXXG7bRy3tlT4gqJtlF48xdggvD8hyNF2ot8Hl42Ufb3iMIMcZ3HjGFOhiGEm3NJa25Y
         nJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685092949; x=1687684949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRfQU9Vgx/AzcJ7ol3cHzzpIjDBNKolCIVxAtbmZ+2k=;
        b=ZvpaNja47xKYDmKHbFr+O/vepkguEh0KOFceI/ETkXvkZf6hr7ppGMGTZqh+eP9md2
         Npd7ypwp6sxgqJeWzxg/zNC+HH1FxNi1WfuBW74IP/St4IG2RPuoiCe9VjFkDmVCbsfy
         HupjP6flTWEpt8nE3WbywTH+JEzJttQV97X8wcEOtuk7a3E1Gp4s7eGcjv1h89R4ca9A
         FsnoKI2xzybvasGVQMfBU8e+Rh0rHwfQjM8laBSsjkVN6hNbQ9h04lgPQfudsHRrJwfn
         lJLZA0ZkyuHMJf22pxFNwsM+xYued0Fi83NmRlHIe6xDrmJu2Ft1mDndNs6DkwuajBm5
         DqkA==
X-Gm-Message-State: AC+VfDyTSvUyQk4ie67iIqAucDqUZEp9E4Vjj5UNI2KQoZCsU8GwjpPm
        23FrupOw66npB7E479SVlFWzQA==
X-Google-Smtp-Source: ACHHUZ6RG4YuWSKICAIuktxXn4kzfb0Nie5r9PXVptRAPFG/2zbVsWO2c5h3I7AvD///nnFNOUOi4w==
X-Received: by 2002:ac2:598a:0:b0:4f0:1a32:ca23 with SMTP id w10-20020ac2598a000000b004f01a32ca23mr387006lfn.40.1685092949431;
        Fri, 26 May 2023 02:22:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004efefb9fcb3sm532702lfq.268.2023.05.26.02.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:22:29 -0700 (PDT)
Message-ID: <a5891478-bf4a-8389-e1c9-00244c5b406e@linaro.org>
Date:   Fri, 26 May 2023 11:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526091646.17318-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 11:16, Johan Hovold wrote:
> Add the missing module device table alias to that the driver can be
> autoloaded when built as a module.
> 
> Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> Cc: stable@vger.kernel.org      # 5.14
Looks like the commit referenced in Fixes is from 5.13-rc1, perhaps
5.13 would be more fitting here?

Konrad
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/mfd/qcom-pm8008.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index 837246aab4ac..29ec3901564b 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -199,6 +199,7 @@ static const struct of_device_id pm8008_match[] = {
>  	{ .compatible = "qcom,pm8008", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, pm8008_match);
>  
>  static struct i2c_driver pm8008_mfd_driver = {
>  	.driver = {
