Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810946FED8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjEKIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjEKIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:07:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D922A268
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:06:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so21006a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683792414; x=1686384414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KljiQtSFqo+YtWAuOB2h9MgfsMKO5eDxysmOsAT/+yw=;
        b=PHg2bnJhagsGAiFrglfHm2V7DArMp4AhZIz75pfeKg5hc+suQNxDqTW9aBWmE/t6hg
         3rSf8UPSojB2gZKxGqG0/UowHOztzw5p5lAAZN2Vf1+yYAvtQXP3WQwlktpGpRAGhsul
         76cey6/H6ww4hompKMHNsShE7/U1XoH7zaojTGiDwydB9LaW0aT7/i8vC0qUT8y86Dt9
         JfB7dNFSVg2UZLT7eIRIS36WtPlTHetOw3MQyJfJk3tuRS2EvSoKDQXZrkS+IWzOvqzy
         7r8ipLmCkEC7Puc12VedDlEC2mtTOCK9n6IlSQ+mCAvCUGx1glZoNdF46C3J6OtNfh4E
         UINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792414; x=1686384414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KljiQtSFqo+YtWAuOB2h9MgfsMKO5eDxysmOsAT/+yw=;
        b=gYa3w8c7KLk6kJEsOm5Rh4ylJnxhD/kXKePwNPg7GBvWr/yPJRt3/DcK3xTHWB+Qgp
         anhGc3MGED56lq50XF8uWzj6z39LYCBtCbjQmQ/Ts/wUcbqOd4gI8XleHD7hiWaSAGKD
         EP/kmk0P8dWPSEvXnBAij8bZkjm9fs3JZpcp6HdpjPc27H333DhVUgElvr62PqyKds05
         Ikvebfks8WBZwhU4/iH6ar8QyLW9n9JuKH1jpFW1Uotf0XeQsJseRU34E8hoSIGz5TGA
         demqhZlWGldesHtFzD09UOTmUM7jD4Ha4MQxSMrPDfYNHmII6L4HSQvJ35qSDgbV245h
         udoQ==
X-Gm-Message-State: AC+VfDxVSQw8Sak4LzI9ZbkxXaCGVSTt93SKBtk9KPuOlQ1ZiDnd+k6O
        Lrl0ZXN4YbUIKpNSKM323nQwF98bv3nq5cqy3DWexQ==
X-Google-Smtp-Source: ACHHUZ5LaN5TDvN1FyO5MhQS0lmIkF5TXzwK6Dj9VdmOKW2CYodVmwm4+rhlyyeuU7KXDssjyC5Y6cQ5ZlwMYKZjXrE=
X-Received: by 2002:a50:d71d:0:b0:506:9116:dcc8 with SMTP id
 t29-20020a50d71d000000b005069116dcc8mr31791edi.7.1683792414065; Thu, 11 May
 2023 01:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230504092142.4190069-1-yixuanjiang@google.com>
 <2023050644-dwarf-shabby-d44d@gregkh> <CAGJzVQGxDHa83uV0w4Q35UaGpwNhLpKzcZ5y_qsfd4ELDi+OnA@mail.gmail.com>
 <2023051045-ransack-lullaby-a127@gregkh>
In-Reply-To: <2023051045-ransack-lullaby-a127@gregkh>
From:   Yixuan Jiang <yixuanjiang@google.com>
Date:   Thu, 11 May 2023 16:06:42 +0800
Message-ID: <CAGJzVQEy2E9WZOgiMtmXq0F=EEcse3YgQdrrqXhBS0dQmwtVGw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2023=E5=B9=B45=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, May 10, 2023 at 07:59:49PM +0800, Yixuan Jiang wrote:
> > Greg KH <greg@kroah.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=886=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=881:56=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> > > > From: Takashi Iwai <tiwai@suse.de>
> > > >
> > > > The existing locking for DPCM has several issues
> > > > a) a confusing mix of card->mutex and card->pcm_mutex.
> > > > b) a dpcm_lock spinlock added inconsistently and on paths that coul=
d
> > > > be recursively taken. The use of irqsave/irqrestore was also overki=
ll.
> > > >
> > > > The suggested model is:
> > > >
> > > > 1) The pcm_mutex is the top-most protection of BE links in the FE. =
The
> > > > pcm_mutex is applied always on either the top PCM callbacks or the
> > > > external call from DAPM, not taken in the internal functions.
> > > >
> > > > 2) the FE stream lock is taken in higher levels before invoking
> > > > dpcm_be_dai_trigger()
> > > >
> > > > 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> > > > lock are taken.
> > > >
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > [clarification of commit message by plbossart]
> > > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.int=
el.com>
> > > > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > > Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > > Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis=
.bossart@linux.intel.com
> > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > Signed-off-by: Mark Brown <broonie@kernel.org>
> > > > ---
> > >
> > > What is the git commit id of this patch in Linus's tree?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> > For this patch I think it is [3/6] b7898396f4bbe160f546d0c5e9fa17cca9a7=
d153
> >
> > >From https://lore.kernel.org/all/163953384515.1515253.1364147710634891=
3835.b4-ty@kernel.org/
> > Seems there are total 6 patches.
> >
> > [1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
> >       commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
> > [2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
> >       commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
> > [3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
> >       commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
> > [4/6] ASoC: soc-pcm: serialize BE triggers
> >       commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
> > [5/6] ASoC: soc-pcm: test refcount before triggering
> >       commit: 848aedfdc6ba25ad5652797db9266007773e44dd
> > [6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
> >       commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df
> >
> > These 6 patches could directly cherry-pick to in 5.15 without conflict.
>
> Then please submit them for stable inclusion after you have tested that
> they all work properly.  But first, what bug is actually needed to be
> fixed here?  What is not working that this patch series fixes?
>
> thanks,
>
> greg k-h

Hi Greg,

The bug is, in 5.15
It will always deadlock after stop compress playback.

The patch A
  ASoC: soc-compress: Reposition and add pcm_mutex commit:
aa9ff6a4955fdba02b54fbc4386db876603703b7
From patch A comment it is about to fix the issue by adding lock hold
becasue patch B will check if lock is held.

The patch B
  ASoC: soc-pcm: Fix and cleanup DPCM locking commit:
b7898396f4bbe160f546d0c5e9fa17cca9a7d153
Patch B remove lock aquire then check if lock is already held.

In 5.15 it only include patch A then cause the deadlock.

[  198.670679][    T1] Call trace:
[  198.670690][    T1]  __switch_to+0x174/0x328
[  198.670744][    T1]  __schedule+0x5d0/0xaec
[  198.670784][    T1]  schedule+0xc8/0x134
[  198.670803][    T1]  schedule_preempt_disabled+0x30/0x50
[  198.670820][    T1]  __mutex_lock+0x39c/0xa70
[  198.670845][    T1]  __mutex_lock_slowpath+0x1c/0x2c
[  198.670862][    T1]  mutex_lock+0x4c/0x104
[  198.670878][    T1]  soc_pcm_hw_clean+0x38/0x16c            <--
Patch B will remove lock aquire, if no patch B, it will aquire lock
again then cause AA deadlock
[  198.670958][    T1]  dpcm_be_dai_hw_free+0x17c/0x1b4
[  198.670983][    T1]  soc_compr_free_fe+0x84/0x158             <--
Patch A aquire the lock
[  198.671025][    T1]  snd_compr_free+0xac/0x148

So is it better by revert patch A because purpose of patch A doesn't
exist in 5.15 ?
Or just backport full 6 patches series B to 5.15 ?
