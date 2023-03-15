Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA7C6BBF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCOVbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:31:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1046085;
        Wed, 15 Mar 2023 14:31:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z5so20859873ljc.8;
        Wed, 15 Mar 2023 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8EXqb+vzuEedIXDU+Y/gsh00ij7zHnJ78mT7aXzro4=;
        b=X/vz8vjvU2EwwdFbP0pEE3xLKxUyGtXA6V0GJdS0R/kQQfnKf7HIRpFuJqw0kyFpsP
         AmKptKJqqP04vR5PGTap40RbKZA/LAcn/3rJrPnP5chLlR7lJC0Jya4yuUyb796EFxSF
         HcS9qMlrPTwb1QsTCLGMS7X033m0jDhwQWJQgdjo+j4UFPtTKnTM+FDLubWktuR14i6O
         KUlAK1a0B5uBvBjDtK44G7zcuJU7odMQ0pj1I42NQVVDkLQVU/89vGvjWC/SWcemQSPu
         viP45oJddbdajuU1I5cnU8RDNJhfnxbb0SGNePpVlKISufxb/n/sAXbl+nCDxrj1Rhvw
         mFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8EXqb+vzuEedIXDU+Y/gsh00ij7zHnJ78mT7aXzro4=;
        b=bB0o1HKT/B4OPpZepIACr151HUiMvdl2X+PYPHoz4iLCBudUPtkHTIPZ1SwoDATQBT
         uBYjFqe2LG8mhZAg/M8MWLEWwrlcCqycTmBJH5X297bIgUG0dik/H7tk4cw0Y7/yN3p3
         Uen+1jp/Oo8oQPyL0c5/cFYK4fIzKYcCSzOuvmwYIdSsfeHXh0ipd9Hl5ZN61hh4RmDj
         +qlT6m/CrZUz/mEIe524ckZQyoIzfA9YFVYeQkGcuttz7pNWTWL1j5diPJTctbe+CU7J
         E7Ioxl8euv7RC8m6/cCeACmsNRzjEGx1/QuhRaWpMa2Z8b0XPfKqNaSxeq5LJIzaZAHh
         DDYw==
X-Gm-Message-State: AO0yUKXqh5IwcDgiWcqbXEyyR4Nt0tNolvBOGxP143pLjLJNWSDbOj4i
        r6qEbLf2hvTmEFdqZZjrdRs=
X-Google-Smtp-Source: AK7set8BrAU/06F8hXvSRekDWz8Z5wrqqLyP5IyTjxbmtyNPApXy6bqz2Zcuccf5EicY/69bYyqU+A==
X-Received: by 2002:a2e:bea6:0:b0:298:aa96:4e37 with SMTP id a38-20020a2ebea6000000b00298aa964e37mr1869131ljr.39.1678915865200;
        Wed, 15 Mar 2023 14:31:05 -0700 (PDT)
Received: from localhost ([46.211.236.75])
        by smtp.gmail.com with ESMTPSA id t16-20020ac24c10000000b004d4d7fb0e07sm951417lfq.216.2023.03.15.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:31:05 -0700 (PDT)
Date:   Wed, 15 Mar 2023 23:30:54 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Message-ID: <20230315233054.5ac21db0@gmail.com>
In-Reply-To: <20230315210135.2155-2-pauk.denis@gmail.com>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
        <20230315210135.2155-2-pauk.denis@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 23:01:35 +0200
Denis Pauk <pauk.denis@gmail.com> wrote:

Tested-by: Holger Kiehl <holger.kiehl@dwd.de>

Pro A520M-C II/CSM is also tested by Holger Kiehl 
https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/

Could it be applied as single patch or need to rebase over "Pro A520M-C II"
patch?


> Boards such as
> * EX-B660M-V5 D4,
> * PRIME A520M-A,
> * PRIME A520M-A II,
> * PRIME A520M-E,
> * PRIME A520M-K,
> * PRIME B360M-A,
> * PRIME B360M-C,
> * PRIME B460M-A R2.0,
> * PRIME B550M-A AC,
> * PRIME B550M-A WIFI II,
> * PRIME B550M-K,
> * PRIME B650M-A AX II,
> * PRIME Z590-P WIFI,
> * PRIME Z590-V,
> * Pro A520M-C,
> * Pro A520M-C II,
> * ProArt B650-CREATOR,
> * ProArt Z790-CREATOR WIFI,
> * Pro B660M-C,
> * Pro WS W680-ACE,
> * Pro WS W680-ACE IPMI,
> * ROG MAXIMUS XIII APEX,
> * ROG MAXIMUS XIII EXTREME,
> * ROG MAXIMUS XIII HERO,
> * ROG MAXIMUS Z690 APEX,
> * ROG MAXIMUS Z790 EXTREME,
> * ROG STRIX B660-A GAMING WIFI,
> * ROG STRIX Z590-A GAMING WIFI,
> * ROG STRIX Z590-E GAMING WIFI,
> * ROG STRIX Z590-F GAMING WIFI,
> * ROG STRIX Z590-I GAMING WIFI,
> * TUF GAMING A520M-PLUS,
> * TUF GAMING A520M-PLUS II,
> * TUF GAMING A520M-PLUS WIFI,
> * TUF GAMING B660M-E D4,
> * TUF GAMING B660-PLUS WIFI D4,
> * TUF GAMING X570-PLUS_BR,
> * TUF GAMING Z590-PLUS,
> * Z490-GUNDAM (WI-FI),
> * Z590 WIFI GUNDAM EDITION
> have got a nct6775 chip, but by default there's no use of it
> because of resource conflict with WMI method.
> 
> This commit adds such boards to the WMI monitoring list.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Tested-by: Nick Owens <mischief@offblast.org>
> Tested-by: A. M. <de99like@mennucci.debian.net>
> ---
>  drivers/hwmon/nct6775-platform.c | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-platform.c
> b/drivers/hwmon/nct6775-platform.c index 0ded82ac7fd31..2c1a47e756bf3 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1058,14 +1058,26 @@ static const char * const asus_wmi_boards[] = {
>  	"ProArt Z490-CREATOR 10G",
>  	"Pro B550M-C",
>  	"Pro WS X570-ACE",
> +	"PRIME A520M-A",
> +	"PRIME A520M-A II",
> +	"PRIME A520M-E",
> +	"PRIME A520M-K",
>  	"PRIME B360-PLUS",
> +	"PRIME B360M-A",
> +	"PRIME B360M-C",
>  	"PRIME B460-PLUS",
> +	"PRIME B460M-A R2.0",
>  	"PRIME B550-PLUS",
>  	"PRIME B550M-A",
>  	"PRIME B550M-A (WI-FI)",
> +	"PRIME B550M-A AC",
> +	"PRIME B550M-A WIFI II",
> +	"PRIME B550M-K",
>  	"PRIME H410M-R",
>  	"PRIME X570-P",
>  	"PRIME X570-PRO",
> +	"Pro A520M-C",
> +	"Pro A520M-C II",
>  	"ROG CROSSHAIR VIII DARK HERO",
>  	"ROG CROSSHAIR VIII EXTREME",
>  	"ROG CROSSHAIR VIII FORMULA",
> @@ -1094,6 +1106,9 @@ static const char * const asus_wmi_boards[] = {
>  	"ROG STRIX Z490-G GAMING (WI-FI)",
>  	"ROG STRIX Z490-H GAMING",
>  	"ROG STRIX Z490-I GAMING",
> +	"TUF GAMING A520M-PLUS",
> +	"TUF GAMING A520M-PLUS II",
> +	"TUF GAMING A520M-PLUS WIFI",
>  	"TUF GAMING B550M-E",
>  	"TUF GAMING B550M-E WIFI",
>  	"TUF GAMING B550M-PLUS",
> @@ -1104,16 +1119,20 @@ static const char * const asus_wmi_boards[] = {
>  	"TUF GAMING B550-PRO",
>  	"TUF GAMING X570-PLUS",
>  	"TUF GAMING X570-PLUS (WI-FI)",
> +	"TUF GAMING X570-PLUS_BR",
>  	"TUF GAMING X570-PRO (WI-FI)",
>  	"TUF GAMING Z490-PLUS",
>  	"TUF GAMING Z490-PLUS (WI-FI)",
> +	"Z490-GUNDAM (WI-FI)",
>  };
>  
>  static const char * const asus_msi_boards[] = {
> +	"EX-B660M-V5 D4",
>  	"EX-B660M-V5 PRO D4",
>  	"PRIME B650-PLUS",
>  	"PRIME B650M-A",
>  	"PRIME B650M-A AX",
> +	"PRIME B650M-A AX II",
>  	"PRIME B650M-A II",
>  	"PRIME B650M-A WIFI",
>  	"PRIME B650M-A WIFI II",
> @@ -1124,20 +1143,33 @@ static const char * const asus_msi_boards[] = {
>  	"PRIME X670E-PRO WIFI",
>  	"PRIME Z590-A",
>  	"PRIME Z590-P",
> +	"PRIME Z590-P WIFI",
> +	"PRIME Z590-V",
>  	"PRIME Z590M-PLUS",
> +	"Pro B660M-C",
>  	"Pro B660M-C-D4",
> +	"Pro WS W680-ACE",
> +	"Pro WS W680-ACE IPMI",
> +	"ProArt B650-CREATOR",
>  	"ProArt B660-CREATOR D4",
>  	"ProArt X670E-CREATOR WIFI",
> +	"ProArt Z790-CREATOR WIFI",
>  	"ROG CROSSHAIR X670E EXTREME",
>  	"ROG CROSSHAIR X670E GENE",
>  	"ROG CROSSHAIR X670E HERO",
> +	"ROG MAXIMUS XIII APEX",
> +	"ROG MAXIMUS XIII EXTREME",
>  	"ROG MAXIMUS XIII EXTREME GLACIAL",
> +	"ROG MAXIMUS XIII HERO",
> +	"ROG MAXIMUS Z690 APEX",
>  	"ROG MAXIMUS Z690 EXTREME",
>  	"ROG MAXIMUS Z690 EXTREME GLACIAL",
> +	"ROG MAXIMUS Z790 EXTREME",
>  	"ROG STRIX B650-A GAMING WIFI",
>  	"ROG STRIX B650E-E GAMING WIFI",
>  	"ROG STRIX B650E-F GAMING WIFI",
>  	"ROG STRIX B650E-I GAMING WIFI",
> +	"ROG STRIX B660-A GAMING WIFI",
>  	"ROG STRIX B660-A GAMING WIFI D4",
>  	"ROG STRIX B660-F GAMING WIFI",
>  	"ROG STRIX B660-G GAMING WIFI",
> @@ -1146,16 +1178,24 @@ static const char * const asus_msi_boards[] = {
>  	"ROG STRIX X670E-E GAMING WIFI",
>  	"ROG STRIX X670E-F GAMING WIFI",
>  	"ROG STRIX X670E-I GAMING WIFI",
> +	"ROG STRIX Z590-A GAMING WIFI",
>  	"ROG STRIX Z590-A GAMING WIFI II",
> +	"ROG STRIX Z590-E GAMING WIFI",
> +	"ROG STRIX Z590-F GAMING WIFI",
> +	"ROG STRIX Z590-I GAMING WIFI",
>  	"ROG STRIX Z690-A GAMING WIFI D4",
>  	"TUF GAMING B650-PLUS",
>  	"TUF GAMING B650-PLUS WIFI",
>  	"TUF GAMING B650M-PLUS",
>  	"TUF GAMING B650M-PLUS WIFI",
> +	"TUF GAMING B660-PLUS WIFI D4",
> +	"TUF GAMING B660M-E D4",
>  	"TUF GAMING B660M-PLUS WIFI",
>  	"TUF GAMING X670E-PLUS",
>  	"TUF GAMING X670E-PLUS WIFI",
> +	"TUF GAMING Z590-PLUS",
>  	"TUF GAMING Z590-PLUS WIFI",
> +	"Z590 WIFI GUNDAM EDITION",
>  };
>  
>  #if IS_ENABLED(CONFIG_ACPI)

