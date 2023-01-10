Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D2664162
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAJNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjAJNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:14:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE0D382
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:14:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso13376786pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqolwS2i9Vzx5E9jrKgCxuzRWSZRqxSvHs+d5JJ759s=;
        b=DVarO2Y6TWzflIQwftuuQY+Qp8rsIzGWwSyZ+gbPjBsdscRgGSo9Hws8D/V4H8TrQj
         e+gqzvcipir15fpkNgqE5bN2Lrlup2ffrQTf4R9/A0tDCi79MOdovib0rYzmOMyDxLTa
         K+UHD4h1h0e3QYi8d/MtV2GCrcDYZD0qMDtNly5++1WgcxOdOk3ia7mOEZ9CQ9AD3gaz
         ya+n5QjjkqPZv9hO824RACEYcpUPYFsbwqQXoa23x4plAsmPk/tlUjGOKsSP7LyhRE00
         2pp3gfYveJJNsH3S3Nv0kgOJll8WWzgNgjOAVQbEpVKh0V7UIaxwYXP0g025Dp7ph+ay
         dxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqolwS2i9Vzx5E9jrKgCxuzRWSZRqxSvHs+d5JJ759s=;
        b=nVoEAOGl97cXgWGbZXQFdxjcdje3aVDuH/o82SSJfoeprwKBJ+TY70kQ90tNvNS9N7
         nRqDc/50baRHE7bX0XXr1qTFcDT1MOGQhQxAEVROcjFLgQiDLQ/9TT1vX1daiyL9/W6i
         pgZVGhJNS5K6rsKr+5oOu/S+0K4+R2gJj6H4wOHew8alVzlsR3axlDYoGttDRhg0vY9T
         2+ZhSMjVCk1CIJt4OS3Lc9imFvis06n0eW7UuA1vHG6Nfn8fIWuLBcvoftNG12IX3Q+D
         Jua6Di0X/Xd23SO0PSVuOTFFf3ALvsQmFGXsIkDQWaXGaHG0BHN8wnE74FC+LWU3IkOR
         gk1g==
X-Gm-Message-State: AFqh2kobGt18rv9yV8ZZ8p4Fc+b47w9ZGE4WDKLS7H5yGrXg8OQRqPtX
        ZhnGv5KuTguNfddFNba6pdr0ey8zpZchFw==
X-Google-Smtp-Source: AMrXdXuUa/ukpIFK2Mxbu9LqL/r/JQgg0+RlG6jjSuu0d+zrKbX8MtWa2LTdy0j9v/D5HLMraBImpw==
X-Received: by 2002:a17:902:ef93:b0:193:2bed:3325 with SMTP id iz19-20020a170902ef9300b001932bed3325mr8766929plb.15.1673356469003;
        Tue, 10 Jan 2023 05:14:29 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902b40b00b001931c37da2dsm6724580plr.20.2023.01.10.05.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:14:28 -0800 (PST)
Message-ID: <50adbdd5-7d2d-ad3f-ce91-5b322ae7691b@gmail.com>
Date:   Tue, 10 Jan 2023 22:14:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] extcon: axp288: Replace open coded acpi_dev_put()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230102202919.15925-1-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230102202919.15925-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 1. 3. 05:29, Andy Shevchenko wrote:
> Instead of calling put_device(&adev->dev) where adev is a pointer
> to an ACPI device, use specific call, i.e. acpi_dev_put().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-axp288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 180be768c215..a703a8315634 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -393,7 +393,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		adev = acpi_dev_get_first_match_dev("INT3496", NULL, -1);
>  		if (adev) {
>  			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
> -			put_device(&adev->dev);
> +			acpi_dev_put(adev);
>  			if (IS_ERR(info->id_extcon))
>  				return PTR_ERR(info->id_extcon);
>  

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

