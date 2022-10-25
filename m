Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D960CCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiJYNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiJYM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:59:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155C72715F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F071CB81A9C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F583C433C1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:55:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mdZvmCoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666702507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpyH1D/2XK23AKm0sBvO8GEEBnx0Ia1hn6gpjNKkRH0=;
        b=mdZvmCoI7sTcb6SLTN0bP54admX73iDo3rQwL6tUg1bBk9vzeE95gShW1kMLECnN9v71u0
        qbNAvMCooQsC4n6SKuNKn7rf2TB1DtUeT52+jU8q12C235/mzydrzLBOB+gXOvlWvh0dtW
        +FVkJCDhNLF8kgQTpcZWzgXOVcHFIJY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e9d2a8f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 12:55:07 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id 189so9563647vsi.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:55:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf07GSj+SZS2a1BSCiO4TmL+VWEPg62wSeEqKgJ2Es0mrLH8NxX+
        9WsmMYpo0t7lW2biC3xPFQ+vuds+GfB1GWmuExI=
X-Google-Smtp-Source: AMsMyM4SLcBwHpOsukHpimIDiERGrmDNG5sM1JcAcFHIpJFL2Zkg33awQqoaxph0sE5ov1sU8J1UuTE7aA2f7VdroRA=
X-Received: by 2002:a67:c297:0:b0:3aa:3cac:97b6 with SMTP id
 k23-20020a67c297000000b003aa3cac97b6mr535993vsj.76.1666702505606; Tue, 25 Oct
 2022 05:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <202210250456.vKv5zoLb-lkp@intel.com> <20221025000313.546261-1-Jason@zx2c4.com>
 <87bkq0s9rw.wl-tiwai@suse.de> <Y1fRvWfcU4NT1HTU@zx2c4.com> <87fsfcqdbx.wl-tiwai@suse.de>
In-Reply-To: <87fsfcqdbx.wl-tiwai@suse.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Oct 2022 14:54:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9qkJk0vH2n7gz1XFyo-W5EMffGA6Hd4Fd8twKSRWz12nA@mail.gmail.com>
Message-ID: <CAHmME9qkJk0vH2n7gz1XFyo-W5EMffGA6Hd4Fd8twKSRWz12nA@mail.gmail.com>
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

On Tue, Oct 25, 2022 at 2:48 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 25 Oct 2022 14:08:29 +0200,
> Jason A. Donenfeld wrote:
> >
> > On Tue, Oct 25, 2022 at 08:21:55AM +0200, Takashi Iwai wrote:
> > > On Tue, 25 Oct 2022 02:03:13 +0200,
> > > Jason A. Donenfeld wrote:
> > > >
> > > > With char becoming unsigned by default, and with `char` alone being
> > > > ambiguous and based on architecture, signed chars need to be marked
> > > > explicitly as such. This fixes warnings like:
> > > >
> > > > sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
> > > > sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
> > > > sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned
> > > >
> > > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > > Cc: Takashi Iwai <tiwai@suse.com>
> > > > Cc: alsa-devel@alsa-project.org
> > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >
> > > Applied now.  Thanks!
> >
> > Thanks. For this and the other patch, applied for 6.1 or 6.2?
>
> I applied for 6.2.  Was it an action that has to be fixed for 6.1?
> If so, I still can shuffle.

Well, this is code that's broken currently on ARM platforms, for
example, where char is already unsigned. So it's arguably a fix for
6.1.

(And if you're in fact not going to take it for 6.1, I'm supposed to
take it through my unsigned-char tree for 6.2.)

Jason
