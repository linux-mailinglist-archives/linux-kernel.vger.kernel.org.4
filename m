Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46D65EAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjAEMgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjAEMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:36:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8B4103B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:36:40 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE61B418EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672922198;
        bh=kzh51tjZf6BbDdOPHf1kZXyHTEo9Dw/XL/zrdcGX7xw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YcuqlDvxZx2hL7xIWUQ+yAHUDnBlvuJIWy6uyizaA3KRQTcNFxPa+napu8KgWd9r7
         t+65Gg7GXjajDQakXvHr9/VnPUkpH4O+BltyYxdXRd9jjZClSRAop9EVEG7h55QArP
         qIG6Ki9B9JhMYxI3ltgl5v0Oa7y52sPsV4QB0T+HgXV8Wq/xQTkGz3qJMYcDza7RuP
         3sL/NWhjcn3xT7aBLW941w7to6wMwv05Gf4EO00lMrB/ZY9zG+ednYJ56Xt3N/NioV
         EKB/n5YZFoeVz5RikJT/ssqgCe2S0dVGfu1i1Ho8tNuMS/pdEDg/RoAG0M6mLyFIcD
         JVF0t8fmCNk7g==
Received: by mail-pg1-f198.google.com with SMTP id k16-20020a635a50000000b0042986056df6so16836022pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzh51tjZf6BbDdOPHf1kZXyHTEo9Dw/XL/zrdcGX7xw=;
        b=d3EJ8WFsKsYBlOvJ02MF9uGq9KdR7BemgXKSGFsHOGZD07NHSDQmwsMPnOnyvmYfMo
         w4K3ZN3JPXB1qPsLYt4NLP36xpsv8rXUXAOcXVVVrp9Wr+kI9JWhvBwZatvc/3CC2CCE
         CIjz3vyP+15+97VQBU2m/4I77RnBMTwNSFAiYBxaGUMTMX3nrDjf2iCEgbHAmiWQJUIQ
         fSjCCwVy6eO/ENvmtfBsJPrHibnlBOMDtni1jgkxqpbG16a6E3OU9371NLPDpNWhdT3P
         m5uxSiuFV9cD3RmUDBWQFrOQ5S4kSsMWK3uP9fObvD3VlH33tUqFq7Ob1uBzc7V1UXHM
         TW/w==
X-Gm-Message-State: AFqh2kqE5I1VAClokLEzS/eBAh/YXzV5Lh695J4RUapZe70XPp+oB+CI
        uGjNfKmqI5yVRgG21HCAW06fOkx00QZqtbmlx5HEEwWNg34QcJ63MWedjq0pRDXfX+KUtLFxhEh
        Dye6UADfu4S0kLmnLhQOdU+5YhXb+yVfObKmCsEYSpCB5MfWIpvBfBcT/6A==
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id pa13-20020a17090b264d00b002261564643cmr2141351pjb.206.1672922197315;
        Thu, 05 Jan 2023 04:36:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuun2bnIY+7fARFwqKZukGuDM/4YSe5TQaJtRRag9XzMpW4qx7Lfzm80FSsGQJStYmB3SRogQZy5gR1d0VvdPc=
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr2141349pjb.206.1672922196882; Thu, 05
 Jan 2023 04:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20220719144753.252231-1-kai.heng.feng@canonical.com>
 <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz> <CAAd53p6ru7CJ=pJ2knCL5pgU_Y+nA=yTPscKk225zTD-fv4qQg@mail.gmail.com>
 <34bddb2f-dc57-c08c-358e-26cf7824c203@perex.cz> <514f0fda-9475-e163-fd64-0bc675dd3447@linux.intel.com>
 <CAAd53p5xkjKkpvZu2nNu5EaJC9d060g5GAhV_gRD2ouGjKY9AQ@mail.gmail.com>
In-Reply-To: <CAAd53p5xkjKkpvZu2nNu5EaJC9d060g5GAhV_gRD2ouGjKY9AQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Jan 2023 20:36:25 +0800
Message-ID: <CAAd53p4Jcfo1_jsCd98_HxzkfqhUxS_7h7vM5a2dcK4fRYS1RA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:55 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, Jul 20, 2022 at 9:31 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> >
> >
> >
> > On 7/20/22 02:52, Jaroslav Kysela wrote:
> > > Dne 20. 07. 22 v 3:45 Kai-Heng Feng napsal(a):
> > >> On Tue, Jul 19, 2022 at 11:41 PM Jaroslav Kysela <perex@perex.cz> wrote:
> > >>>
> > >>> Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
> > >>>> On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
> > >>>> light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
> > >>>> topology: use new sound control LED layer").
> > >>>>
> > >>>> The micmute LED itself is still working via sysfs, but it doesn't follow
> > >>>> mute anymore. That's because unlike vendors like Dell and Lenovo, HP
> > >>>> laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
> > >>>> laptops, both SOF and HDA create captures with
> > >>>> SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
> > >>>> there are two different kcontrols and one of them is not muted.
> > >>>
> > >>> It does not mean that it's a wrong behavior. When both controls are muted, the
> > >>> LED should be turned on. It just requires that all inputs are off (and it may
> > >>> be the default - probably we can set in UCM or so). If you turn the "Capture
> > >>> Switch" off in amixer / alsamixer, do things work as expected ?
> > >>
> > >> Yes. When all captures are muted the micmute LED is on.
> > >>
> > >>>
> > >>>> So skip creating captures for HDA when it's called from SOF, the
> > >>>> captures are already handled by SOF.
> > >>>
> > >>> The capture controls are for other inputs like external analog microphone. If
> > >>> it is required to suppress the MIC LED for some hardware, just skip the
> > >>> "spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
> > >>> "codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
> > >>> if the topology really sets the MIC LED flag.
> > >>
> > >> AFAIK the external analog microphone on DMIC laptop is driven by SOF driver too.
> > >> If those capture controls are indeed needed for external analog mics,
> > >> use UCM to mute them by default won't work either.
> > >
> > > Could you describe this ? I though that only DMIC is handled by SOF when HDA
> > > codec is in the system. There is a separate analog codec for external analog
> > > microphone or the HDA codec is somehow connected to SOF/DSP ? If so, how ?
> >
> > The HDA codec is connected in the same way in all cases, there's no
> > hardware/electrical/routing difference.
> >
> > When used, the SOF driver will handle ALL links, be they DMIC or
> > HDAudio. The difference for HDaudio is that instead of a single DMA
> > transfer (DDR->FIFO), we have a first 'Host' DMA into the DSP SRAM, some
> > processing and a second 'Link' DMA from DSP SRAM to the HDaudio FIFO
> > (reversed flow for capture).
>
> So is this approach sufficient for this issue? Or should I explore
> other possibilities?

A gentle ping...

>
> Kai-Heng
>
> >
