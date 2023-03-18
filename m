Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C556A6BF6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCRAUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRAUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:20:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B5D5163
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:20:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 053C95C00D7;
        Fri, 17 Mar 2023 20:20:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 Mar 2023 20:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679098809; x=
        1679185209; bh=nX0oud/9S89MnfIUf3HEr5T2aFhtLvPiEe1qO71PwG4=; b=Q
        QsazoCl5arG2jecd48M6hA/M6I5A7pE6CeDEVAbIhCAGF936IYBCYnWRU0es8d/e
        7NKIV/AF1iI+oG3mxWcpnklf/GmOmM4oRXdV1yRxGcyE0584KI+YHUvGyRE9qo9v
        yH+SIN2ykXwFZhyEunTnRbaC8DwiREPfM+21TBG54oBIPWVuOIdZIf5qJHCJS36U
        92a3hiYz9oMWQnJ7MpUVBPkSrYa7dnxPoKnbIOLmlgFyW5pCBhGoOwg6cD4TzXRa
        yud7AK3XuD8TPcm1sNSVC2hxWkApHiIgX80FLsP0YD1j1S2N29W9NwOfNtlV4mVG
        EpRwKP7binTjYAO65kKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679098809; x=1679185209; bh=nX0oud/9S89Mn
        fIUf3HEr5T2aFhtLvPiEe1qO71PwG4=; b=AHiaz+UKQv7Bce7Cf1/M8DPnLOCsw
        Gm7ahjBeSWkGwb/eDmJzb1J3p+NTRoJuOpxoTtf4MSYqxb1qkky9G8upGjOXTmct
        nOBuiI2a6XDQ/GDQAMzRL9TpH46tgvaOYUD3OiWIYvo0lVbOGxkedx5yD3BuCiLj
        NxA9CEVqYZdm/8MjiueDfnZzCysJrBuKkRwBQuxdGzu7OTgpyGUTYt61Swir/6Gz
        dfMYtq3Jh/Ub9Kjp/zZoJ2OAHOby6Btsz6TadTxhg12UO/MOeivfZ7gsCUBJn6jr
        Lvtg8PWvcqpQebXUpPfSfY8ea2pe4BGDkN6nsbv5gz+OP4Nw9s+rYgFpA==
X-ME-Sender: <xms:uQMVZA5o38OaCFdcw29IZqvhsjbeeJHZdqrtjIjSxP_zlAISgVIQ3g>
    <xme:uQMVZB7-eXZ2tBBZqOSGp20DsPKgn-e-rXiJzpBkNeDOuNP5KqNVb65iqH1QemkQR
    Bn2Ct1hlOs4BQLonRA>
X-ME-Received: <xmr:uQMVZPd-SEuPe9HsOciV_kQYcGwo6QpxGyldUvAmBpI2cOLLopsP9LwzccezecLjBYxSF5y-rpx2oEeG-86-465h-S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeffedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepheffledvtdeigefhudehvefgveehgeeggedtveek
    ueelfffhjeeghefhudegheeunecuffhomhgrihhnpedugedrihhnnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgr
    khgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:uQMVZFJlh7J7WJ_aYvTbotp8ZpvjAxrS5Z7sCPeAZ6YoQsDipdBEsg>
    <xmx:uQMVZEKUiWi9XygtZQWj5eaYKy1s5IbmxoMtHHymlrcbzI7FfsOybw>
    <xmx:uQMVZGwIhofNBC58_2ulQpt9LsdVZrf8Ny8wLHVd_LryKKXxcLdHvA>
    <xmx:uQMVZLUnJhUnNHV9hUFoQVOsqd3-LLJx7ZFGXaDyLRgJ143st4wlDQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 20:20:08 -0400 (EDT)
Date:   Sat, 18 Mar 2023 09:20:05 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     John Keeping <john@metanate.com>
Cc:     Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Message-ID: <20230318002005.GA84781@workstation>
Mail-Followup-To: John Keeping <john@metanate.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230317195128.3911155-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195128.3911155-1-john@metanate.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2023 at 07:51:27PM +0000, John Keeping wrote:
> snd_usb_queue_pending_output_urbs() may be called from
> snd_pcm_ops::ack() which means the PCM stream is locked.
> 
> For the normal case where the call back into the PCM core is via
> prepare_output_urb() the "_under_stream_lock" variant of
> snd_pcm_period_elapsed() is called, but when an error occurs and the
> stream is stopped as XRUN then snd_pcm_xrun() tries to recursively lock
> the stream which results in deadlock.
> 
> Follow the example of snd_pcm_period_elapsed() by adding
> snd_pcm_xrun_under_stream_lock() and use this when the PCM substream
> lock is already held.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  include/sound/pcm.h     |  1 +
>  sound/core/pcm_native.c | 28 ++++++++++++++++++++++++----
>  sound/usb/endpoint.c    | 18 +++++++++++-------
>  3 files changed, 36 insertions(+), 11 deletions(-)
 
The name of added kernel API implies me that you refer to existent
'snd_pcm_period_elapsed_under_stream_lock()' which I added to Linux
v5.14.

In my opinion, unlike the version of period elapsed API, the version of
XRUN API seems not to be necessarily required to ALSA PCM core, since PCM
device drivers can implement .pointer callback in the part of PCM operation.
When the callback returns SNDRV_PCM_POS_XRUN, ALSA PCM application get
occurence of XRUN as a result of any operation relevant to hwptr movement
(e.g. SNDRV_PCM_IOCTL_HWSYNC).

Therefore I think it possible to fix the issue without the proposed
kernel API. I can assume some scenario:

1. Failure at tasklet for URB completion

It is softIRQ context. The stream lock is not acquired. It doesn't
matter to call current XRUN API.

2. Failure at PCM operation called by ALSA PCM application

It is process context. The stream lock is acquired before calling driver
code. When detecting any type of failure, driver code stores the state.
Then .pointer callback should return SNDRV_PCM_IOCTL_HWSYNC refering to
the state.

Of course, I'm not a developer for USB audio devices. I'm just a developer
for the other type of packet-oriented drivers (IEC 61883-1/6 packet
streaming engine for audio and music unit in IEEE 1394 bus). So I do not
get every part of USB driver. However, from my experience for the
packet-oriented drivers, I have the above concern about adding the new
XRUN API.

I apologize if miss-hitting the point for your issue.


Regards

Takashi Sakamoto
