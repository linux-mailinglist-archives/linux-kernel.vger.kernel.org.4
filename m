Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16775B9362
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIODsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIODsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:48:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F718FD7C;
        Wed, 14 Sep 2022 20:48:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p3so4103827iof.13;
        Wed, 14 Sep 2022 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3t9LmUjVN19CJdbtw/1ndRGrzXOU80MfmqolxOD6MCc=;
        b=CEO3Kh/sVCyUP5laUNC/Ku0FV1V4/yRa7Q16G+sr84oJVUGWFpn9iVzQRAouMFJstB
         psqDEcxTQi7iVdr5ZmYQGd+o0qRdrV8HCRA5nMrgLh98FDkgjc/XaME6VOvPfOLBYKAu
         ARum2voL/eLrmQnzz809rxsGWsoUzsuWG0aWcgvlE8KKNRe5fOBVC001All0zz1ptftw
         DeBbJDAEy9FDxzQ4yncvHNRG1Bip0MVOddeBOqhPzhEWcHsb7e1tHL8PzZwhSuAWZDYp
         qo8suphFXeiiZTHedFrarMBY0PvDIPLselhWeiINf01nm+ldpziVJZJAVW2p8UB2+6Te
         PbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3t9LmUjVN19CJdbtw/1ndRGrzXOU80MfmqolxOD6MCc=;
        b=1sWy7HlR2BdNoovIw0OtSpdkGpH/8SR0ActDAqhlGHd+8b/PeQMLACBaZzBMD4oExr
         5shoVvFeLPHqlf4X7+6nzCErR7a1EAVBt2atCN5b3pgTN1YBR1NdFJMlNHqPEQGduPfL
         d9hx97Eb+gEHzdvFBOAKUJr4WSbpVo/PCaA3nJ5hpFCwVkgDIqMcr9APVXiS5KpPB9NV
         lzc2DQCm75Saaq8wm7RefE2iV9AydUcZbS/1C0FgS28p+TREZxc3VBXd1OdlUJg4SPSB
         7htiw9LFQmJIB5NzRYZJmZT/4TpsEvEV9lDfi7v+0FOMfpKTEEQeZJVu592hpDA6MQ6e
         zDWw==
X-Gm-Message-State: ACgBeo20gE4WMJbRCQTv4vL8YvzqO4ZiPioClYSQ+JTJp9Z/+DccGCyG
        HquRuPdYkXrw+hxGLBhjzCs=
X-Google-Smtp-Source: AA6agR4T0C/oFHWhFhzJQgIfwTBNnWtOk8CNaSXTXCQL0L1qp75s6f3AJMU2efhwIMCnOxQermKwCw==
X-Received: by 2002:a05:6638:3794:b0:35a:28b0:c329 with SMTP id w20-20020a056638379400b0035a28b0c329mr9778632jal.103.1663213719273;
        Wed, 14 Sep 2022 20:48:39 -0700 (PDT)
Received: from [192.168.50.84] ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id m27-20020a02a15b000000b0034c0f2229aasm556389jah.68.2022.09.14.20.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 20:48:38 -0700 (PDT)
Message-ID: <4536a322-df6f-4994-287b-a8e85083d318@gmail.com>
Date:   Wed, 14 Sep 2022 22:48:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/6] acpi/x86: s2idle: Add a quirk for ASUS ROG
 Zephyrus G14
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     catalin@antebit.com, philipp.zabel@gmail.com,
        travisghansen@yahoo.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-6-mario.limonciello@amd.com>
From:   Matthew Anderson <ruinairas1992@gmail.com>
In-Reply-To: <20220912172401.22301-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/12/22 12:23 PM, Mario Limonciello wrote:
> ASUS ROG Zephyrus G14 is affected by the same BIOS bug as ASUS TUF
> Gaming A17 where important ASL is not called in the AMD code path.
> Use the Microsoft codepath instead.
>
> Reported-and-suggested-by: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * New patch
> ---
>   drivers/acpi/x86/s2idle.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 9ee734e0c3c5..4bdc7133d2ea 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
>   		},
>   	},
> +	{
> +		/* ASUS ROG Zephyrus G14 (2022) */
> +		.callback = lps0_prefer_microsoft,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
> +		},
> +	},
>   	{}
>   };
>   

Tested-by: Matthew Anderson <ruinairas1992@gmail.com>

Apologies for my troubles, I'm new to submitting to public emails.

