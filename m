Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22454655B20
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiLXThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 14:37:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0D8FDA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:37:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so7239540wrs.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QD23sbwH8r0k8Mg6nLVRzWsdSmM875tPfpoqYqTuCc0=;
        b=D/ZL92Ok+p9CEJDf2BZhwcyvi2CpZbNqxS6WyQtG9N8AfUrWKKSNrsdG7VclOKgsce
         xR/bvHwnChLhNeowok7Z5V+nSQigDNV/b0JOJe5aaNIvPBNx7L057WZYJy7g23jjOFiC
         EdcAXnl6zXy6OCyHIxzZEPTeB5c5Th4LMzeRAbmzPaq+biwJImd3nCv0nwjekRz6pmNu
         qi2kL2VLStw2KDKqTpXChp+Thlubo+ICzQ7pgRP5pgzMnwWnsu8sFr8YGI7zkHWn+liv
         1Ylw5r9W0nDUPFLZdSD51Tvunj1tHtKVLoB4vqw2rp/b0YqIVoYjrj1FzqVyeAWZ3Fjl
         yDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QD23sbwH8r0k8Mg6nLVRzWsdSmM875tPfpoqYqTuCc0=;
        b=NaKSXCSCDV3QVWpFEigtfEV1imjMO2EUP8Tj7+znN/Ue/fnMt9zOZ7gPmxC1fmoBJJ
         ISBIRRm8aO4owhlSUf3mvmBQ9eGLTeYufxAEQM1EnPd51wp4VE+5m6lqNKK3xRvU/SWf
         3KYuLHp3Hhme35k7tuWPB+JfOFlhXgEy6eby15K26nELBQ6a7s0YfCgrIsoAMSRfayDx
         lufQAroEDg+asdqxDeT50GK8j5X8INHt8j1UXmUbU9Mf0HfQFRREWIhQiV7MxqYAv5wp
         ESGPd3RnTQ6677sXMxu8zTH++7YIn6g5fTf5hmtA4HkAvNmy8wZ04DCBN3I72epAaMyS
         Ds/A==
X-Gm-Message-State: AFqh2kr/ocvdXkTdaHgdErnYPo7850dGIBrQAj4LK8F8bUigJ2enDeNi
        t9hlGqKPPKNzDhLzbBo3Azk=
X-Google-Smtp-Source: AMrXdXu34vx3L2agFvuyAzhKsrsjLoXzZBURtkE9N1+fMXFNvQF1t0YqYXLlXAqQ/LxgA8jZN8xPxQ==
X-Received: by 2002:adf:9b99:0:b0:241:fa2d:dea0 with SMTP id d25-20020adf9b99000000b00241fa2ddea0mr8806061wrc.3.1671910620379;
        Sat, 24 Dec 2022 11:37:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm7530886wrg.72.2022.12.24.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 11:37:00 -0800 (PST)
Date:   Sat, 24 Dec 2022 22:36:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn:
 replace divide condition 'pin / 8' with 'pin >= 8'
Message-ID: <Y6dU14Smv0Zh6/rP@kadam>
References: <202212181140.EAWl7FKx-lkp@intel.com>
 <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com>
 <Y6dTX2wx/SXlswGC@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6dTX2wx/SXlswGC@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 10:30:39PM +0300, Dan Carpenter wrote:
> On Sat, Dec 24, 2022 at 05:19:27PM +0100, Andy Shevchenko wrote:
> > 
> > 
> > Lähetetty iPhonesta
> > 
> > > Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
> > > commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO registers on cascaded chips
> > > config: ia64-randconfig-m031-20221218
> > > compiler: ia64-linux-gcc (GCC) 12.1.0
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > 
> > > smatch warnings:
> > > drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> > > drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> > > 
> > 
> > 
> > 
> > I don’t think this is a good advice. If we want to limit that, we need
> > to check also upper limit. But. The GPIO framework does that. So,
> > changing / to >= is bogus.
> 
> 
> How is checking pin / 8 not mathematically equivalent to pin >= 8?
> 
> I don't understand this code at all.  The divide is inscrutable  Is it
> storing something in in the lower 3 bits and something in bit 4?  In
> that case it might be nicer to just check (pin & BIT(4)).
> 

Or a macro which does:

#define GET_UPPER_BIT_THING(pin) ((pin >> 8) & 0xMASK)

regards,
dan carpenter

