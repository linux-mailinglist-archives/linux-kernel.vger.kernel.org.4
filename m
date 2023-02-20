Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0736D69CA17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjBTLpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBTLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:45:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD621EC53;
        Mon, 20 Feb 2023 03:45:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h31so557666pgl.6;
        Mon, 20 Feb 2023 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQQ4SoAuUv1jRYgJ9+jggXgvoVrSMDksG2ZxS3S5548=;
        b=Fl1IYAJT2mLiDNZQl844lpLC/YWSN6mYXpPIODlsLe6UsIaZs1uwZXFnTtPo16BBaB
         BCRqCBQiLpzBqhxCc9aTpKAL+Lh6F8NupJMQiVp6Q4fXwXFAJ7joac03v2UKqZU+QEMc
         5LYub/0iFFxz+bFirKkvNhgA9LVi8Y94NMRy7j68jmGVgrFoAiSQLdfJh7haUsw7nYIS
         i4dOMDYeGVMoXjASoA66v7P+PKrX5Jo5wrXY5WFPHqAqcbo3uYuQLRJvlFlRwEVJ75My
         XoMiI6ApMj1kE3is1ZpAW+3b/xsu5b0Mb5Z42CxXSbRs2h5ir3Y5FLm9JO9KN1tP8ZEn
         xUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQQ4SoAuUv1jRYgJ9+jggXgvoVrSMDksG2ZxS3S5548=;
        b=AqRkZ91vKpiTqPB+iHLYhHlvGTmEleUJC/VbhT4kRtLybMlVJ8WsvPcx0+UmuR2nH8
         poJN3uXDlErvZmFCWxugJIY/jzotgPGCA3nyarQq79/VmRro+RGaj9CXpTtL0AQjeLLI
         yHVTcwhpWB+v6chR37RO+Su1uAtZnsYhCC1oUmrnyTIt5Qp3rhDqh4HJcD3/GW5TmYe3
         92c6g0iTSJ/AJNElCggwIJfWb6DX3WAtAa1VzFoqzOlDnvhcP9Luq/7EPfKDQKTpVhKq
         D3RlIf9dHY9xHnZ5iHcmH3QlNbcuhKI96p6QOa0oUIEK5+KOOxzj8bSAdcEvfO9nqojL
         OpIg==
X-Gm-Message-State: AO0yUKUe+OPkwyljfsDi64AbIXnWO4OCU7g2Pyu7rLPU+VO04d7lHHJZ
        /e8TQY/IcMcO0B3lPRsUcZ4=
X-Google-Smtp-Source: AK7set9Y9436fW+4i+iWxcXDtm9qUYTotP5VCmaHCFXxpaMReuKiMm05DFtAW3j48Y5e7XQqBczy4w==
X-Received: by 2002:aa7:96ee:0:b0:591:3d20:3827 with SMTP id i14-20020aa796ee000000b005913d203827mr283357pfq.21.1676893513222;
        Mon, 20 Feb 2023 03:45:13 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id x9-20020aa793a9000000b005a8173829d5sm2407136pff.66.2023.02.20.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:45:13 -0800 (PST)
Date:   Mon, 20 Feb 2023 22:45:00 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        Thomas =?UTF-8?B?V2Vpw59z?= =?UTF-8?B?Y2h1aA==?= 
        <linux@weissschuh.net>
Subject: Re: [PATCH v4 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
Message-ID: <20230220224500.0486bc3b@redecorated-mbp>
In-Reply-To: <Y/NZm22JQKeF1+6R@smile.fi.intel.com>
References: <20230218090709.7467-1-orlandoch.dev@gmail.com>
        <20230218090709.7467-3-orlandoch.dev@gmail.com>
        <CAHp75VeF6ypA7mSYZrMsNr777f6zjEJ6nkygEc_NQe-nMhjRFQ@mail.gmail.com>
        <20230220180932.2a7aa6b1@redecorated-mbp>
        <Y/NZm22JQKeF1+6R@smile.fi.intel.com>
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

On Mon, 20 Feb 2023 13:29:31 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Feb 20, 2023 at 06:09:32PM +1100, Orlando Chamberlain wrote:
> > On Sun, 19 Feb 2023 16:09:26 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Sat, Feb 18, 2023 at 11:08 AM Orlando Chamberlain
> > > <orlandoch.dev@gmail.com> wrote:  
> 
> ...
> 
> > > > +       help
> > > > +       Say Y here if you want support for the keyboard
> > > > backlight on Macs with
> > > > +       the magic keyboard (MacBookPro16,x and MacBookAir9,1).
> > > > Note that this
> > > > +       driver is not for external magic keyboards.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the
> > > > +       module will be called hid-apple-magic-backlight.    
> > > 
> > > Is it my email client or is the indentation of the help text
> > > incorrect?
> > > 
> > > Hint: the text of the help should be <TAB><SPACE><SPACE> indented.
> > > 
> > > I believe checkpatch.pl at least in --strict mode should complain
> > > about this.  
> > 
> > Looking at the hid Kconfig, it seems like some have it as you've
> > described, and some just have tab (and a few have just tab for the
> > first line, and tab space space for the rest of the lines).  
> 
> Okay, I have checked in the other MUA I'm using for patch reviews and
> indeed your Kconfig indentation is broken.
> 
> > checkpatch.pl --strict didn't complain about the indentation so
> > hopefully it's alright as is.  
> 
> No, it's not. Must be fixed.
> 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#kconfig-configuration-files
> 

No worries, I'll fix that in v5.
