Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9442656DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiL0Rq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiL0RqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:46:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B927A1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:46:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso9818094wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVFRVr+KSZVMPZ3bgSDdZDe07uyPuIo4qVJD0MUcklk=;
        b=W8Ob3EalTIaJEmIgGrDiEKysh0LW0YZhynxgWPgL6Pi6xg9ydA858Ee0hblIBW0PkX
         tAP1+NMzbsNcJRZmRdlBPmgiorNMU+MOEZcrxzwgaBeWS1H/HcGT6qK1/4z1iAEpulMh
         LPnjJ/Jm6UM/KyB+Mu2vk4rRpgUqzy/mtyKZ6srgf6uHjIPDSFG8EaAnnvXDcVD2YPnf
         B+c1baPu+1PFs6tTOosatJ15bOI25XNZ+XpY2Zfrr8SkDsSnt4y2v66jdy4hrGxOMX6j
         Sh4jEp2ulcRSoxm+sMrubuF4q/MAUFl8g+EmeVeaKPaSFDwfwTH5NWYDhkUZg9Dd3S7H
         q0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVFRVr+KSZVMPZ3bgSDdZDe07uyPuIo4qVJD0MUcklk=;
        b=cv8k70FblVR5/WwjX2xL0DmBBTCcagM/IUuirJa/7fe2OXb6JoCbyQUoIAzT59B5ii
         vX1MLJsILzI1aR/OFIWV/JIapjS78qGtO/vF5BLdxA6VZ340VoNxSihebLew0a0241OY
         +C3nfV78oq+TNK5cwaS0LOgBRUvytSR8kfDwCP+Sw6D8mL3eOhR7VRT+RCM78SXoseca
         X9gKWWscE237WGkaAVIDjiGAnIj99HrO/sTNSVsJ+lLfbzLEK4Wm5BGwLTEb5FXlu3IJ
         FBIflqRgm6bQ0Uu5JNUGCR1LgtIjsmERJMrhFE6ag8+G4k/O4xMOW0UbaJ+IH49tp64z
         LyDA==
X-Gm-Message-State: AFqh2kr2yyfj+7vkz1X6nYMK/zuUjqNTHUtvjWhmrEmlBjgDRiRGWNuW
        d6YCB/lE5Ah/u/qBd3zrMXU=
X-Google-Smtp-Source: AMrXdXvV4a0JiJpRVeLMRsu3XEv+j2nk1w/KzSd1wjIF29yB4VcySisYxf7shoAANy63dbKQZ7PW2A==
X-Received: by 2002:a05:600c:44c9:b0:3d1:f6b3:2ce3 with SMTP id f9-20020a05600c44c900b003d1f6b32ce3mr20476801wmo.35.1672163177667;
        Tue, 27 Dec 2022 09:46:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003d969a595fbsm18060238wmk.10.2022.12.27.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 09:46:16 -0800 (PST)
Date:   Tue, 27 Dec 2022 20:46:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn:
 replace divide condition 'pin / 8' with 'pin >= 8'
Message-ID: <Y6svZX++B5TYRHBT@kadam>
References: <202212181140.EAWl7FKx-lkp@intel.com>
 <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com>
 <Y6dTX2wx/SXlswGC@kadam>
 <F701A496-22A6-4E3B-B3CB-E5BCF4C30502@gmail.com>
 <C430F7E6-723B-4EA8-BA87-00C84676BD4F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C430F7E6-723B-4EA8-BA87-00C84676BD4F@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 12:50:46PM +0100, Andy Shevchenko wrote:
> 
> 
> Lähetetty iPhonesta
> 
> > Andy Shevchenko <andy.shevchenko@gmail.com> kirjoitti 25.12.2022 kello 12.45:
> > 
> > 
> > 
> > Lähetetty iPhonesta
> > 
> >>> Dan Carpenter <error27@gmail.com> kirjoitti 24.12.2022 kello 20.30:
> >>> 
> >>> On Sat, Dec 24, 2022 at 05:19:27PM +0100, Andy Shevchenko wrote:
> >>> 
> >>> 
> >>> Lähetetty iPhonesta
> >>> 
> >>>> Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
> >>>> 
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>> head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
> >>>> commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO registers on cascaded chips
> >>>> config: ia64-randconfig-m031-20221218
> >>>> compiler: ia64-linux-gcc (GCC) 12.1.0
> >>>> 
> >>>> If you fix the issue, kindly add following tag where applicable
> >>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>> | Reported-by: Dan Carpenter <error27@gmail.com>
> >>>> 
> >>>> smatch warnings:
> >>>> drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> >>>> drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> >>>> 
> >>> 
> >>> 
> >>> 
> >>> I don’t think this is a good advice. If we want to limit that, we need
> >>> to check also upper limit. But. The GPIO framework does that. So,
> >>> changing / to >= is bogus.
> >> 
> >> 
> >> How is checking pin / 8 not mathematically equivalent to pin >= 8?
> > 
> > The point is that semantically the / is better in case this code will ever support more than two banks of pins.
> 
> On top of that it’s paired with pin % 8.
> 

I noticed that, but it's a common bug though that a lot of people
accidentally write if (pin / 8) when if ((pin % 8) == 0) is intended.

For example:

drivers/rtc/rtc-m48t59.c
   132          M48T59_WRITE((bin2bcd(tm->tm_mon + 1) & 0x1F), M48T59_MONTH);
   133          M48T59_WRITE(bin2bcd(year % 100), M48T59_YEAR);
   134  
   135          if (pdata->type == M48T59RTC_TYPE_M48T59 && (year / 100))
                                                             ^^^^^^^^^^
This code is pretty clearly an example of where people accidentally uses
/ to mean "divides cleanly".  (I have not patched or reported this code,
btw so if anyone wants an easy patch to send it's available).

   136                  val = (M48T59_WDAY_CEB | M48T59_WDAY_CB);
   137          val |= (bin2bcd(tm->tm_wday) & 0x07);
   138          M48T59_WRITE(val, M48T59_WDAY);

regards,
dan carpenter

