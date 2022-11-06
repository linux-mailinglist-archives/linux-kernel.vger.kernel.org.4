Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAA61E4D4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKFRWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKFRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:22:13 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9EE95;
        Sun,  6 Nov 2022 09:16:04 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b23e29e36so10454531fac.8;
        Sun, 06 Nov 2022 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEv5IfnJcbTamlVtUpqiTgyx6Ij9nPLIySLxf/hjkbo=;
        b=noua/yFqm3voDQ4vK/Xnwv2lPUhv/bjeNBEioUMO1caiY+cqjqktx+Pq+DRvesZCgA
         d//QuwBhkaum3ZBYqfka1bjS4ugjvhz9zNrSBccZhQnCtF5iSpOiT1aqW4lzlyJCKvrV
         dQx6PgpGJKBWIl75kdxQhvPvNmohvGiU9mjOOPYyrhjV6FiChPpKXEJGdG1Z//cOb2uy
         YmEf79V1DwuecsFIiSRsvbyzi1fqNHa8BDzUHl5y5Pv1lOKXCOWge8VhqhweK8+mq7T6
         oc9rMh9QUnrWGArDAbXUF3fHSqvgREeIP7GukLeCHvRT4nVTCvhAgf+vo2IbBXnnMtFo
         +RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEv5IfnJcbTamlVtUpqiTgyx6Ij9nPLIySLxf/hjkbo=;
        b=B4saOxUWObXoIeHMz4chsbVqbxLXAtrngkjK4bArT4Wryf7VgAZ1E503idW2DW8izb
         1x5AKSJUFmOdp4iCk0rEJFAqtOmixgiGZBCZzZQfPgsIpgwi5PJ9eW7cF0kk3s1Zr4HX
         8NvFkdF/D0opNCS8gK64qIoY+ShcNGUPveVOv3FxfjurMl+1Ck9lefykjds9zjW0LQ9O
         +l10BSd1+3x4OEmpA4Yfn92o73f5Isb4gY5xpuMK6cEqtmpyrinDs1BBF34m7Y/HH3d9
         lnuh9WcusIWZTZhFCiSx23hq/mCzwTB5a6DIXPEjz7zRIonhwnjNgZb4xdJqVqXL9kLe
         l6Pw==
X-Gm-Message-State: ACrzQf0/U6YK4tJNDrciZdq+am2cIpQKyHNHqUMmW/PThV7gwZ7ri3nf
        ZQCMd+fo9WeJr1M2UU4e2YQ=
X-Google-Smtp-Source: AMsMyM5bzIlrUuIFBGzNbqYQ02V6lN7ciCTOZDwHAvBLO5/YGgrsTnGI/pK4hMCO3nar5mewI1/zCg==
X-Received: by 2002:a05:6870:4612:b0:13b:775d:511 with SMTP id z18-20020a056870461200b0013b775d0511mr37349401oao.81.1667754963323;
        Sun, 06 Nov 2022 09:16:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w52-20020a9d3637000000b00668953207b2sm2022492otb.80.2022.11.06.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 09:16:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Nov 2022 09:16:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Juerg Haefliger <juergh@proton.me>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Riku Voipio <riku.voipio@iki.fi>,
        Huang Rui <ray.huang@amd.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Guillaume Ligneul <guillaume.ligneul@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Roger Lucas <vt8231@hiddenengine.co.uk>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH] hwmon: Include <linux/kstrtox.h> when appropriate
Message-ID: <20221106171601.GB105056@roeck-us.net>
References: <0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e819645f8d607f7b4550c8aaf4a563b1404bf40.1667730675.git.christophe.jaillet@wanadoo.fr>
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

On Sun, Nov 06, 2022 at 11:31:27AM +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, include the latter directly in the appropriate files.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The goal of this patch is to eventually remove <linux/kernel.h> from
> <linux/watchdog.h>.
> 
> This patch is needed to avoid indirect inclusion, via <linux/watchdog.h>,
> in fschmd.c, ftsteutates.c and w83793.c.
> 
> 
> Maybe, just including <linux/kstrtox.h> in <linux/hwmon.h> would also do
> the job. It is likely that this file is included in all hwmon's drivers.
> Let me know if this less intrusive approach is preferred.

Include it from <linux/hwmon-sysfs.h>. This should cover almost all
drivers needing it. The remaining drivers (if there are any) should
include it directly. Almost all drivers registering the hwmon device
with [devm_]hwmon_device_register_with_info() do not need the include,
but (almost) all drivers registering with an older API will need it.
Those drivers will also include <linux/hwmon-sysfs.h>.

Thanks,
Guenter
