Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF35B78D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIMRwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIMRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:51:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB10857F9;
        Tue, 13 Sep 2022 09:50:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c198so12303296pfc.13;
        Tue, 13 Sep 2022 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C/Zpre7KVq932UhCKk2b8U74PyD3gWhFjpSTlExGJKo=;
        b=kNFu3fVmyF76kXXgisnaNtqCCgCvCofZWNlRryAy45oKUnno1ZmYeGfrcL7XJJ4Uzo
         KuYlcAndeJmoZaZjsRMne1mpRucbxAUg4QWNtSLWbK4EWNY/hr1+eI4DTJh+aoRIaYJE
         yaZovKB6KvVeNcNnlhX8r0PPdyGujK4sza9iMyN+VV8jzVKd8tmWnYFV8bsdxYn+VGmC
         3AYwRFZe4eBCIZov6AS4y/ooi9FwEGW802ovnky/lH3maY0FJwtHj8qfOnkcwVkT5gCx
         aWh3CGi8rKLofyemrSXuzVRAKpSOYu+m4gFaQL/zVzMZnnrHr5RFglTpXtrNm5f0Yef/
         iSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C/Zpre7KVq932UhCKk2b8U74PyD3gWhFjpSTlExGJKo=;
        b=Y3NUoTSPtz171IS5wKD5uo35FCZtbM+qMrWaS8jZflTVIYP/hpsdD8VsRLhoUl8LmY
         TmEwFCzAkHiNpqB21DwstfSIPVFAN+Hb4Y6OH45LNkQfCGBXkZEtK7UMZCQXavvnfKQb
         8nekmqfxg+ogZ713MtbadBari749XcjvxsoGMvl9w0DiMYhP3iI/Zqb9I3RJHxKAlxNC
         hjE1ziVInJcZf2TgWtYyMTlVjqM4KNeaGyVisoSdKm60W09PgabtXi3ZMlqshznwmL6u
         1rrXzP1DdE/HEglcDEwRzxbWGEeDYhnDorrC0p9XDXFz8z3/q7PIo8OHv89l+TAZ9Ems
         xQ7g==
X-Gm-Message-State: ACgBeo1nqh9sYKcy0KfPGeu+N6evlACaZm3vz/2WXlvri2ax0DMEBBnB
        RTB3O/0SzBnZYdT9XZmcXg4=
X-Google-Smtp-Source: AA6agR6FazlqsHgyQOy58ovOrNGJZwWwn6mCwACT6p/fAUAIOC3di22kmXKFHplJuKmMlvsiyBcY9Q==
X-Received: by 2002:a63:8a4a:0:b0:439:49b3:6586 with SMTP id y71-20020a638a4a000000b0043949b36586mr2418825pgd.44.1663087814628;
        Tue, 13 Sep 2022 09:50:14 -0700 (PDT)
Received: from rog ([2a0a:edc0:0:701:a220:c777:e1f2:5de1])
        by smtp.gmail.com with ESMTPSA id ch12-20020a17090af40c00b001fbbbe38387sm1981538pjb.10.2022.09.13.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:50:14 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:50:03 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 5/6] acpi/x86: s2idle: Add a quirk for ASUS ROG
 Zephyrus G14
Message-ID: <YyC0u0nedouZemfq@rog>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-6-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912172401.22301-6-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 12:23:59PM -0500 schrieb Mario Limonciello:
> ASUS ROG Zephyrus G14 is affected by the same BIOS bug as ASUS TUF
> Gaming A17 where important ASL is not called in the AMD code path.
> Use the Microsoft codepath instead.
> 
> Reported-and-suggested-by: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * New patch
> ---
>  drivers/acpi/x86/s2idle.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 9ee734e0c3c5..4bdc7133d2ea 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
>  		},
>  	},
> +	{
> +		/* ASUS ROG Zephyrus G14 (2022) */
> +		.callback = lps0_prefer_microsoft,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
> +		},
> +	},

Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
