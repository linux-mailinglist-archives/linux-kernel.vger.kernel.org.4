Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519F5B5CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:06:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978A18E10;
        Mon, 12 Sep 2022 08:06:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 29so13243057edv.2;
        Mon, 12 Sep 2022 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R9TasW3U1ES5+xQbETQaGhpr/jDiXAoY2QYlAY9EYk4=;
        b=daE/7/pQav9bPFrgprVQCih02XkYCMOOtpQpZ85bVO0CurdPTrOSZQtMpwmChykG0O
         LeoPuI72p7gWVZABVq/t1NNxBdTjHkyG4oWEDh+q3PEE3fXfQ81wI2UFVJWqa0socl2Y
         EQNSNjQwqYCerw4uQD8aZ9EO2mlTe/huGxmnGwBzRVe7cwlXDGN8QGEWOnn5th8HzHAG
         8vbhjOYuJY3/FuC3/Zggb9a02M8tnmXcwUAE7zA2zs/MVwUcfpFi1YZQSNXsvxvdndK7
         XToX8M+25hSVmw45ffKCWxEYZa0EqNDKbW+P0D9/0usdyP0s2zVlkkI81DwHulE1ZAaK
         C21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R9TasW3U1ES5+xQbETQaGhpr/jDiXAoY2QYlAY9EYk4=;
        b=lCq7edcVPmozNlL0UIzrByUyT/tWrXnv9cFheOSzawb3RzENIVIiubKwvZpzftLNcD
         X4YSldwXPwJP5bDJ5wUwciCxSULSZ8El+nfVKjV9GSHgXhN/cWyMo3dNzpV1LM/cMXY2
         JhydSBHJXLv8MWbMYyvJtiUBDKCok72qRhwcZImorQ2Voy5R/PVUCILqefWXWpO2yfNj
         rHuKNXfCihM9Bua6PTRspBN699RT01O4THahvKA6dJrDhn9+6oelnuTpKq9pNDcshly4
         X6XQ/zk0SnBBYodHXW9xMLii2ZIjK86rBpyuLajc42gqrAi7jNCxMsHUyUGTCnazkzgn
         51HA==
X-Gm-Message-State: ACgBeo3MWi4cUagkPnryaj4z/tmjOgCU5rHTI/8WVrXDhsRzM6rH+DXx
        zhZ+aIb/GOf9UWLR45qXivs=
X-Google-Smtp-Source: AA6agR5zH5KWZAMafL2wbpBq3T+LhLWxlpVQXykDWjwSN47z+pMw0enhUp9z1S4zKoWh4Qfj2CbenQ==
X-Received: by 2002:a05:6402:5ca:b0:445:c80a:3c2 with SMTP id n10-20020a05640205ca00b00445c80a03c2mr22351620edx.247.1662995190548;
        Mon, 12 Sep 2022 08:06:30 -0700 (PDT)
Received: from rog (dynamic-046-114-143-092.46.114.pool.telefonica.de. [46.114.143.92])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b0073d6093ac93sm4717138ejf.16.2022.09.12.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:06:30 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:06:27 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Message-ID: <Yx9K88pXilS6qqL9@rog>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <Yx9ItlBjl6bxxu2H@rog>
 <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello, Mario:
> [AMD Official Use Only - General]
> 
> 
> 
> > -----Original Message-----
> > From: Philipp Zabel <philipp.zabel@gmail.com>
> > Sent: Monday, September 12, 2022 09:57
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar <Shyam-
> > sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> > acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
> > 
> > Hi Mario,
> > 
> > Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario Limonciello:
> > > It was reported that an ASUS Rembrandt laptop has problems with
> > seemingly
> > > unrelated ACPI events after resuming from s2idle. Debugging the issue
> > > proved it's because ASUS has ASL that is only called when using the
> > > Microsoft GUID, not the AMD GUID.
> > >
> > > This is a bug from ASUS firmware but this series reworks the s2idle
> > > handling for AMD to allow accounting for this in a quirk.
> > >
> > > Additionally as this is a problem that may pop up again on other models
> > > add a module parameter that can be used to try the Microsoft GUID on a
> > > given system.
> > 
> > thank you, these also helped on an ASUS ROG Zephyrus G14 (2022) with
> > BIOS version GA402RJ.313. Patches 1-3
> > 
> > Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
> 
> Did you use acpi.prefer_microsoft_guid=1 for your system then too?
> 
> If so, I should re-spin this series to add your system's quirk to patch 4.

Yes. I also tested with the following diff applied instead of the module
parameter:

----------8<----------
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 6a2c94fdbeae..a247560e31de 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
 		},
 	},
+	{
+		/* ASUS ROG Zephyrus G14 (2022) */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14 GA402"),
+		},
+	},
 	{}
 };
 
---------->8----------

The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ", but
there is also a near-identical higher spec model GA402RK.

regards
Philipp
