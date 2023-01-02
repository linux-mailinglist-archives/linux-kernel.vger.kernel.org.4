Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C665AFBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjABKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjABKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:43:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3FF2BFD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:43:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so25936069wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EBVPG1vtBPkeRqY7DBzxLu5riwQmsAJMfyM/nogB2w=;
        b=OsyM0VYn9ltZFlrIl5D55eSMrUGkOGg0szNCLdU7NF7ZbYwhPGSrjgmcYMzTcLuxIf
         sZpBII9aOq6RfZD4TfNrEhapAkvMqjJc6LoNU2sGk6+gyqSqHSpC7lEVReJdE9u+yRUn
         U+E1z/YSIURWuX+2gZyCv5lupJZNGi6Dv14IR0q95iOzNqSh5TyB7sn4wtrx7y+hYLYB
         xrCbu3cGRNzxDflxfsCXTjKEOFdD4zwEA3VY7iRvVg8kioAPiaBpNymh4AYNpB+JFLnv
         3IFwVdeINyltK971XMLNu/16uePH2exDqS4I/SMKq5//bxCvN1euMB0z9lllJtkEak78
         x4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EBVPG1vtBPkeRqY7DBzxLu5riwQmsAJMfyM/nogB2w=;
        b=hG/qDAkBtE/72w/2E2NB1o1aAKOVzT9XCBusQI/3HibR+13TyHYFThwU0qOSCpSdnU
         AY3ij3iVqWzbnhFb4FonqRJ5Jog81op3r8DnsSWl9FcoXFnjXtn7SJiqdDWm209iDKEL
         0iQObho+jodY/XXCLZsIcUW6kVX6v5iS+eVo1t0lShZQ9NpcLZpubh3mcJyvSBCoGPiE
         OT69R7mO+j7nO7djT/Fk4pODOfS7//ZXZsjTRdQIHJtbBUhGfa+VW+bxaQggDOZlWJ8J
         eNig7WPoJaMICGLdhvHjvdeFrmWFrN7O9CufIvNHFsNpda9vGFPret+2KD4Yu4Vzob/Z
         Asxw==
X-Gm-Message-State: AFqh2komOSmapn4380MaWHHPG79ksZNCQjDDpfxfl1uXiocSP6Ci1KC2
        yq9X4l9BBw1WgLC38VMj7l12cjA/NUodOQ==
X-Google-Smtp-Source: AMrXdXuu0YuRfTkb5MbAOBAyI/KCaXcjJ0SusBa1+gM7rk+L7/zrsiOAOUhIfzoGg8KOAjVj7wfebw==
X-Received: by 2002:a5d:5908:0:b0:279:4938:eb98 with SMTP id v8-20020a5d5908000000b002794938eb98mr18824452wrd.11.1672656217665;
        Mon, 02 Jan 2023 02:43:37 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d4e4e000000b002549b649b62sm27819475wrt.50.2023.01.02.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:43:37 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 7E219BE2DE0; Mon,  2 Jan 2023 11:43:36 +0100 (CET)
Date:   Mon, 2 Jan 2023 11:43:36 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sergey <zagagyka@basealt.ru>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?P=C1LFFY_D=E1niel?= <dpalffy@gmail.com>
Subject: Re: [regression, 5.10.y] =?iso-8859-1?Q?Bu?=
 =?iso-8859-1?Q?g=A0216861_-_sound_disappearanc?= =?iso-8859-1?Q?e?= on Acer
 Swift 3 SF314-59-78UR after update to 5.10.157
Message-ID: <Y7K1WDmPYi3EMOn1@eldamar.lan>
References: <bebd692d-7d21-6648-6b7a-c91063bb51c2@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bebd692d-7d21-6648-6b7a-c91063bb51c2@leemhuis.info>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Adding as well Richard Fitzgerald and PÁLFFY Dániel to recipients]

On Fri, Dec 30, 2022 at 09:08:57AM +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216861 :
> 
> >  Sergey 2022-12-29 10:07:51 UTC
> > 
> > Created attachment 303497 [details]
> > pulseaudio.log
> > 
> > Sudden sound disappearance was reported for some laptops, e.g.
> > 
> > Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
> > 
> > # lspci
> > 0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
> >         Subsystem: Acer Incorporated [ALI] Device 148c
> >         Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU group 12
> >         Memory at 601f270000 (64-bit, non-prefetchable) [size=16K]
> >         Memory at 601f000000 (64-bit, non-prefetchable) [size=1M]
> >         Capabilities: [50] Power Management version 3
> >         Capabilities: [80] Vendor Specific Information: Len=14 <?>
> >         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >         Kernel driver in use: sof-audio-pci
> > 
> > I am attaching the pulseaudio and dmesg logs
> > 
> > This bug started reproducing after updating the kernel from 5.10.156 to 5.10.157
> > 
> > Bisection revealed the commit being reverted:
> > 
> > c34db0d6b88b1da95e7ab3353e674f4f574cccee is the first bad commit
> > commit c34db0d6b88b1da95e7ab3353e674f4f574cccee
> > Author: Richard Fitzgerald <rf@opensource.cirrus.com>
> > Date:   Fri Nov 4 13:22:13 2022 +0000
> > 
> >     ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
> >     
> >     [ Upstream commit 39bd801d6908900e9ab0cdc2655150f95ddd4f1a ]
> >     
> >     The DAI tx_mask and rx_mask are set by snd_soc_dai_set_tdm_slot()
> >     and used by later code that depends on the TDM settings. So
> >     __soc_pcm_open() should not be obliterating those mask values.
> >     
> > [...]
> > Original bug report: https://bugzilla.altlinux.org/44690
> 
> See the ticket for more details.
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: c34db0d6b88b1d
> https://bugzilla.kernel.org/show_bug.cgi?id=216861
> #regzbot title: sound: asoc: sudden sound disappearance
> #regzbot ignore-activity

FWIW, we had as well reports in Debian after having updated the kernel
from 5.10.149 based one to 5.10.158 based one in the last point
releases, they are at least:

https://bugs.debian.org/1027483
https://bugs.debian.org/1027430

Regards,
Salvatore
