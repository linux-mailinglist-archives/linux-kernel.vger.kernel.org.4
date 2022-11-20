Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27974631490
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKTOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:01:00 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB062982B;
        Sun, 20 Nov 2022 06:01:00 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id e15so6494003qvo.4;
        Sun, 20 Nov 2022 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrGFajuaE6Xv9x/0EnfDOnn2ge80VTC1ISooKEwT92c=;
        b=OQSyGq0gzVWn9vBHyypN9EoDShQugtszI2esRSz/iAxhyDKdviZFgR/02AzyViLWV/
         phe9xCla0qvr411Ir5bHKSqt1ewdr2xI79QvXgH8ymNqQluX3+85434Do2NR0BUgj6kw
         9WseFhALizgblvo5qAOkxZGdhw1zRz2h+Vrp6g2HuAIybulfU1LAInE6QFNbdtkh2TBl
         lJvtfL5iiAdOwIAKVMrqg+MbtujIaAplPuqNmolVAbSe/l8/ALP1niTUjuGI3wZvGd+t
         AMQ7ZJus1HgN0qm8cxp3kWy70AC64OhCBDDbgMIDJhZb64woC4c9NFg/0grVfojAKLqt
         Py2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrGFajuaE6Xv9x/0EnfDOnn2ge80VTC1ISooKEwT92c=;
        b=LLbw6IAHPt5wWMYBXHElXJSDaFnmKTkllKCDWxt6Pn0vr6rmSF31iFBU1wvLc4Cxsg
         Ww3A71NMYovq/1m9OWJ9u+IMCS7YNKHi+XHkw1Pzgf9dx5RfAX9YPH9buh6GduwN1jiF
         184YfqnuRo/5jO4vbe7LBF13HcoAQV75qOCI+pi2z1G5Xx1zH3ArSHX3QDbzb3+TnleQ
         EcuSN1URTn5XGuzhhbRICCh7M/Sw2iGznU2mkYGBCxRAaHEgUHfQj0yKkZVoo6hod2at
         4/LMDIlPN+tFjdLcZjViehX+ux1FbdcWRJMRguVoSU8J0EvW/lJCJaUDtdKX7c2IetIS
         mU/g==
X-Gm-Message-State: ANoB5pm3qM4rXie+36oyqpHYkYuhv2l3IDcW+IBtPSNmm5lRcbZES+zC
        HSbPz8oZimSBMnDZ9+PU+Gk=
X-Google-Smtp-Source: AA0mqf6C0ty8C7ELFdItEJfAJncVp71eSlAVjYcadI7phPXdIPW5rs7P9I3GnRBZbQRWnNdwI3BGzA==
X-Received: by 2002:a0c:cdc6:0:b0:4c6:9069:97d3 with SMTP id a6-20020a0ccdc6000000b004c6906997d3mr11931782qvn.106.1668952858950;
        Sun, 20 Nov 2022 06:00:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fab68c7e87sm6575879qkp.70.2022.11.20.06.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 06:00:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 06:00:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Dawson <matthew@mjdsystems.ca>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add definitions for ROG
 ZENITH II EXTREME ALPHA
Message-ID: <20221120140057.GA1788720@roeck-us.net>
References: <2407243.vFx2qVVIhK@cwmtaff>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2407243.vFx2qVVIhK@cwmtaff>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:36:22AM -0500, Matthew Dawson wrote:
> Add support for the Zenith II Extreme Alpha.  It is basically the same
> board as the Zenith II Extreme, and has a similar sensor suite.  The
> DSDT is basically the same except for some address, so use the same
> board information as the non-Alpha board.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>
> ---
> v2: Add missing Documentation change
> 
>  Documentation/hwmon/asus_ec_sensors.rst | 1 +
>  drivers/hwmon/asus-ec-sensors.c         | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/
> asus_ec_sensors.rst

Your patch is corrupted. The line above is split. If I try to fix that, I get

error: patch failed: drivers/hwmon/asus-ec-sensors.c:466
error: drivers/hwmon/asus-ec-sensors.c: patch does not apply
error: Did you hand edit your patch?

It looks like tabs were raplaced with spaces. Please fix and resubmit.

Thanks,
Guenter

> index 02f4ad314a1e..a4039f2f9ca4 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -23,6 +23,7 @@ Supported boards:
>   * ROG STRIX X570-I GAMING
>   * ROG STRIX Z690-A GAMING WIFI D4
>   * ROG ZENITH II EXTREME
> + * ROG ZENITH II EXTREME ALPHA
>  
>  Authors:
>      - Eugene Shalygin <eugene.shalygin@gmail.com>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 81e688975c6a..ac0459be04c7 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -466,6 +466,8 @@ static const struct dmi_system_id dmi_table[] = {
>                                         &board_info_strix_z690_a_gaming_wifi_d4),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
>                                         &board_info_zenith_ii_extreme),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
> +                                       &board_info_zenith_ii_extreme),
>         {},
>  };
>  
