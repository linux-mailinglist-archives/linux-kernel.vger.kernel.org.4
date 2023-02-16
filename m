Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A36989C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBPBRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBPBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:17:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7C3C784;
        Wed, 15 Feb 2023 17:17:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k24so391083pji.2;
        Wed, 15 Feb 2023 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg8TeDWkPF48KtftvDSL6IEhuDjKb+MEbGQmIe+Hmag=;
        b=Vwqo4dw3E5kLCRVqNv2Xi7yQIV0/M4fnwU0EV0TrBJWkOFSU0yR45EwnAsNoJp0mt+
         S2wI4Gg7CFOSBqXC/G2E0wckoW4MbVrjwHXWnV/Y7GFpiMorWge0h7jFVIvgTMucVkQw
         V4zTE4G9EXEKhEwjyim+wHWGvQRM0b/3KrEr20mUXvDuXdxs70PL7ZGoqsXSZWJ0XOYr
         u1TzBieNBw/bzLJ3a4eBAXgH41uaudk3oGw4tw3y4UWPjNudZqNYiBkskDSB/OqTNxST
         cz5m+RGs6DQNiqxS3EaZeW6ySXDEMhBTHKANSdJlWS5ABA3SppevdiJeDAyviNmnVoKh
         9rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg8TeDWkPF48KtftvDSL6IEhuDjKb+MEbGQmIe+Hmag=;
        b=GpjJoVz9GFGYX3Z151ovyR6xLXLVzLeYObC0xkiZ0m2xF6fLtI7QguLlR5gkxmj9jF
         6gqsChhx87vsjTWLaiWFec1OkxOfgC2KpB64/8qouhqQob1jAcf9Qk3xtNUMJ4jbAJNE
         yxd/42SfOv4ZGX0oZIRjdDUrJ0WoEK26LQP91V+8bkEhhM64OxX6Rcgd/JiyO6NaKAKj
         m+6lQoYfcHodz6vlOC+3Ju/YtNBCejtkXN7kvIZm7eLKzI5h9SGmDy1b6/ol7XC5Scvp
         T1kT5vz4FC298NNIPE1A4W9MMmAt0Sdw/ydgmJ7lfxhuCaXbosZ2ZIuqR1qj+hSyQ64w
         L09A==
X-Gm-Message-State: AO0yUKVwfXu3nSDdoxwWR0g7fsO536jFdYq2WU+9HrZyOk/ivHDngrh7
        Wk2gLA9B/GIM541Ddr1B+Q0=
X-Google-Smtp-Source: AK7set8b0IYWS1H7+D9dUU5DUlzDDEMVujA2jGO25CpyonJFJr7RCWYYydafqIVXFo9sMvkxY9BD9Q==
X-Received: by 2002:a17:90a:5c:b0:231:20a8:6fe1 with SMTP id 28-20020a17090a005c00b0023120a86fe1mr4972482pjb.8.1676510237450;
        Wed, 15 Feb 2023 17:17:17 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a3e8500b00233ccd04a15sm2043799pjc.24.2023.02.15.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:17:17 -0800 (PST)
Date:   Thu, 16 Feb 2023 12:17:09 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Andy Shevchenko <andy@infradead.org>
Cc:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230216121709.04c76b9d@redecorated-mbp>
In-Reply-To: <Y+jLCebet+aekGRv@smile.fi.intel.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
        <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
        <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
        <Y+jLCebet+aekGRv@smile.fi.intel.com>
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

On Sun, 12 Feb 2023 13:18:33 +0200
Andy Shevchenko <andy@infradead.org> wrote:

> On Fri, Feb 10, 2023 at 03:45:15AM +0000, Aditya Garg wrote:
> > From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > 
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)  
> 
> ...
> 
> > +#include <linux/hid.h>
> > +#include <linux/usb.h>  
> 
> Seems lack of some header inclusions, e.g. where struct led_classdev
> is defined or -ERRNO codes.
> 
> > +#include "hid-ids.h"  
> 
> ...
> 
> > +static void apple_magic_backlight_power_set(struct
> > apple_magic_backlight *backlight,
> > +					   char power, char rate)  
> 
> char is a beast, can we use u8 here and in similar cases?
> 
> ...
> 
> > +	/* Ensure this usb endpoint is for the keyboard backlight,
> > not touchbar
> > +	 * backlight.
> > +	 */  
> 
> /*
>  * Multi-line comment style
>  * goes like this.
>  */
> 
> ...
> 
> > +	backlight = devm_kzalloc(&hdev->dev, sizeof(*backlight),
> > GFP_KERNEL);  
> 
> > +  
> 
> Redundant blank line.
> 
> > +	if (!backlight)
> > +		return -ENOMEM;  
> 
> ...
> 
> > +static struct hid_driver apple_magic_backlight_hid_driver = {
> > +	.name = "apple-magic-backlight",
> > +	.id_table = apple_magic_backlight_hid_ids,
> > +	.probe = apple_magic_backlight_probe,
> > +	.remove = apple_magic_backlight_remove,
> > +};  
> 
> > +  
> 
> Redundant blank line.
> 
> > +module_hid_driver(apple_magic_backlight_hid_driver);  
> 

Thanks for pointing out all these, I'll make those changes in v2.

