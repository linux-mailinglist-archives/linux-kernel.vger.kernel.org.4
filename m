Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775269359D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBLC2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:28:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583B126D8;
        Sat, 11 Feb 2023 18:28:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so6129343pgh.4;
        Sat, 11 Feb 2023 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab8nNZ4NnCwidI3E6h4UCYw2TR2ZMGv/20qOsG7NwTM=;
        b=n8IzhMCBorVm8WspAg4UaM1+8V4W7WTk4BxUtb/0Ukbd92LL3Mym657GCcgI9YNnWs
         PQM3I2IwINepHM5FlCPKa1Bciij4QC3VSY/he0jTbceuBB6Mr+8y8GGcQ9NZAJc3oDA+
         sPQ3+e0SOMT2fSDmPFBbvkqoSWzTneMDzUCg743EgDbeCeVt68MfyMvOy73CkZlSd1xf
         Rk4iZ2LII3JzMGpAVrzFmEk5hiAraaRQg5fXynt6MUaRCAEdZeMSo/YdfagOoDQZZP3e
         HKLeWZY5YHYC7JpotSbsLEzCHiIQdjEMcRrs7uzTqGUK+M9yN1BhzVVP9HP9nHq+4kjl
         K/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab8nNZ4NnCwidI3E6h4UCYw2TR2ZMGv/20qOsG7NwTM=;
        b=5RnsLclMkQxJPkYy4y/MhEealhrkO6pOf5Ho6TBNT2qVLVBRy1NMojZGQCGegaLeWy
         Vm5uVf7JtObJz7Fbzp9s8pOEq2fYE6XFYz8SYugAzse5K4JtZCJThvwdPJDinKnAjeb5
         auMfhUTKA27ez6YoZbgXY/ll6Ttc9DnGmWqaNAYVEMAZdI9BwDfoQXEsuv14N4Q6qU+3
         BP/r/LsBIjoRAFOhjsHgGLGrKtA4oFYBfwvx6JKgkqujyW+Y2n6fhdApYPSFymwNwCNf
         eQcK3QL4XKYGedSqS96qIdF+0Zxo2O5vRYlN+iUiU7qUsm2Flm+OBfJFtuv34d7fYpZd
         jCOA==
X-Gm-Message-State: AO0yUKVFUCIkltMnnLn2dYk9RVC2iSYXhR0fduNo9JQsIxZkVAOd5qdy
        LNV5dvyMRmcAaYksHQgiyJw=
X-Google-Smtp-Source: AK7set+uDpGVsDrcx/dLYEkzE2vlOl5xVXPo1q2n0pMBCsqKmh8YPINqp1Y8TS0ExOdEyVDwZbtKiw==
X-Received: by 2002:aa7:9419:0:b0:592:5d7e:b01c with SMTP id x25-20020aa79419000000b005925d7eb01cmr16434482pfo.11.1676168908429;
        Sat, 11 Feb 2023 18:28:28 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b0058e1e6a81e8sm474044pfo.38.2023.02.11.18.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 18:28:28 -0800 (PST)
Date:   Sun, 12 Feb 2023 13:28:19 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230212132819.7952164c@redecorated-mbp>
In-Reply-To: <Y+fIr5Fxozjkg6yo@duo.ucw.cz>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
        <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
        <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
        <Y+fIr5Fxozjkg6yo@duo.ucw.cz>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 17:56:15 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > 
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)  
> 
> > +	backlight->hdev = hdev;
> > +	backlight->cdev.name = "apple::kbd_backlight";  
> 
> ":white:kbd_backlight", plus document this in
> Documentation/leds/well-known-leds.txt so that we keep it consistent
> accross machines?

As in "apple:white:kbd_backlight" or just ":white:kbd_backlight"?

It seems like most examples I can see by grepping around use
"apple::kbd_backlight", "asus::kbd_backlight" etc, without any colour
information or anything between the two colons.

Would we want to start having the led names in new drivers (including
this one) as "$vendor:$colour:$location_or_description"?

I do notice you've also suggested doing that here
https://lore.kernel.org/all/Y+I7xNqkq%2FX6Lag+@duo.ucw.cz/, and that
conversation suggests adding the colour won't stop userspace tools from
finding the backlight, which is good.

One alternative would be to have the colour of the led stored in a
sysfs file in the led's sysfs folder, not sure if that'd be better (it
does mean the names stay the same), but also I'm not sure what the
empty space between the two colons in the current led names is there
for, if not colour.

> 
> Thanks,
> 										Pavel

