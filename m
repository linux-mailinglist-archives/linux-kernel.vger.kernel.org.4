Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8164D60CD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiJYNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiJYNPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:15:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68AA9A2A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F694B81BE0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDCC433D6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:15:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="biBLY8HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666703707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0rdpS3dNPx9OYXlMl8vdq5XWE5nK4qCREZdaGMX8p+0=;
        b=biBLY8HOkTUaS1M/w9SDvxKFNoCnoMCg9PszxA+Ti3gDEu8aZqydUfFFXivQgA06Tr2+Zo
        UEtEYG8Xf5nH3A3G72Ql0sqonaPX7MBHizY3nDthCLQVELUzFWzwYByXnSyIoodheG5E/q
        m7u7kmpjBUNZD+XISUmg4htyVl7Eiq4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dfea5cdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 13:15:07 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id a2so10876614vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:15:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf1jwnkTtyWBfRXa59hpk/beAEkdMsYS75ga9elMfRb30N0iNHR8
        MwSZAfk9PwgJ6Ald98WuAyvHShh9tcMKg7JT98M=
X-Google-Smtp-Source: AMsMyM6h76s4MNoqzcQsufGE4Hbj+I7BTXREeXof+uK6o5SyZwksmudrOXDpiRmBCp/U5oq4neA3WgWIAJymNd9erdA=
X-Received: by 2002:a67:df18:0:b0:3a9:f07f:876c with SMTP id
 s24-20020a67df18000000b003a9f07f876cmr16720373vsk.21.1666703705805; Tue, 25
 Oct 2022 06:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <202210250456.vKv5zoLb-lkp@intel.com> <20221025000313.546261-1-Jason@zx2c4.com>
 <87bkq0s9rw.wl-tiwai@suse.de> <Y1fRvWfcU4NT1HTU@zx2c4.com>
 <87fsfcqdbx.wl-tiwai@suse.de> <CAHmME9qkJk0vH2n7gz1XFyo-W5EMffGA6Hd4Fd8twKSRWz12nA@mail.gmail.com>
 <87czagqc8k.wl-tiwai@suse.de> <87a65kqc4e.wl-tiwai@suse.de>
In-Reply-To: <87a65kqc4e.wl-tiwai@suse.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Oct 2022 15:14:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9p0jDLoma084T30VOiLO2ct-yh1uX5Ru=+BFD9it6CmTA@mail.gmail.com>
Message-ID: <CAHmME9p0jDLoma084T30VOiLO2ct-yh1uX5Ru=+BFD9it6CmTA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: rme9652: use explicitly signed char
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:14 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 25 Oct 2022 15:11:39 +0200,
> Takashi Iwai wrote:
> >
> > On Tue, 25 Oct 2022 14:54:54 +0200,
> > Jason A. Donenfeld wrote:
> > >
> > > On Tue, Oct 25, 2022 at 2:48 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Tue, 25 Oct 2022 14:08:29 +0200,
> > > > Jason A. Donenfeld wrote:
> > > > >
> > > > > On Tue, Oct 25, 2022 at 08:21:55AM +0200, Takashi Iwai wrote:
> > > > > > On Tue, 25 Oct 2022 02:03:13 +0200,
> > > > > > Jason A. Donenfeld wrote:
> > > > > > >
> > > > > > > With char becoming unsigned by default, and with `char` alone being
> > > > > > > ambiguous and based on architecture, signed chars need to be marked
> > > > > > > explicitly as such. This fixes warnings like:
> > > > > > >
> > > > > > > sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
> > > > > > > sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
> > > > > > > sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned
> > > > > > >
> > > > > > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > > > > > Cc: Takashi Iwai <tiwai@suse.com>
> > > > > > > Cc: alsa-devel@alsa-project.org
> > > > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > > > >
> > > > > > Applied now.  Thanks!
> > > > >
> > > > > Thanks. For this and the other patch, applied for 6.1 or 6.2?
> > > >
> > > > I applied for 6.2.  Was it an action that has to be fixed for 6.1?
> > > > If so, I still can shuffle.
> > >
> > > Well, this is code that's broken currently on ARM platforms, for
> > > example, where char is already unsigned. So it's arguably a fix for
> > > 6.1.
> >
> > Fair enough, I'll apply for 6.1, then.
>
> ... and in that case, it deserves for Cc-to-stable, IMO, as it's a fix
> to be done for older kernels, too.  Then it'd be clearly a 6.1
> material.

Fine by me if you want to add that (for this and the other patch).
