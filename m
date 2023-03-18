Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4071A6BF985
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 11:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCRK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 06:59:36 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742F1721
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 03:59:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 88E275C01DC;
        Sat, 18 Mar 2023 06:59:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 18 Mar 2023 06:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679137172; x=1679223572; bh=Mk
        W9Et+iVn3gfjQCXbUm+047kWOOU0mQsCtKGtd8bN4=; b=raIP+VWUD700k1vXKJ
        eJP+SXTT+SKDfaVrW19tAAl3vrLtibws7dE+XVBClS2vYXIjZEiHbAVGEYCt98EG
        hESGqFjOcIR5yhL+9fMrCvh6AXmZLArcF5CcKXoQi4Mw2lKSpzLpHLhhAlG+RrlO
        2wxCZ4xMUCyyBwyXdUE0UkwbxMJvJGrdjbgnp2LG2RLsmGB0OlFV+ltPmX+5xIfW
        Vy+rY/6TOvIiKVBQmCJDPbSDVXDRgQqEoWNY/rstoivamk5tFDaRSixT5AAhfmge
        OdNEDdt+9ehSpG8P9Cf39t14kLTbRBppVZdMHwgTE9QI5te7aml6gy0m5kRPWdZi
        iILQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679137172; x=1679223572; bh=MkW9Et+iVn3gf
        jQCXbUm+047kWOOU0mQsCtKGtd8bN4=; b=Lvj+inqjcjiAy3NvrybjC+6jqaGjX
        NKz89LpQ1paVc5eAjEZMDabm9vVGjEJZliBVq5txSY+ugEojnaQhr80JMtDs/s5Y
        GsLbdAYceNbaIeKN+Eo0Ato1uZHdqFUl0PqZQK+ILReC4x31Be9VmsP9mAnel6it
        zlzCE408Fdsph1Bb/f11sQjTWZQFmV4vzeVpE1nCGDX8ds9YrGl6+ECerBx4CnmA
        +tgDuLkxeIUVWiDSHa0qB5C4pR5+VuXZm3UiLQcClRIEy5KIqhbiPpcM4j2HK/ap
        G3DC/+4wkBHoH5U11JCHmC66wUldmhCvZmA3N1L4zUyx2F71pi7hb/9Fg==
X-ME-Sender: <xms:lJkVZBFyFrH7SmXt6HVAicX6rl5JwydF_tnZZXNT0OGEQaBQohLG4w>
    <xme:lJkVZGXzq75qlVmAdND60k1ZFX8Bx8YCztoq0iF6ARgF-MF7A8ztdD7oAd4dgKvqS
    YhmdRJ0Orw_zYUF6iU>
X-ME-Received: <xmr:lJkVZDK4X5oFWdyMYd3XBWKN-LOhKdalxR7roueV4kX07wdU_GhaUQWFY8feccjsee9vGtWKK5ofRvIWDyncU9uoXok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:lJkVZHHFOSmIjSdjntSrc2NVIrVGqQ7kchc6rjXGgMe6buk15yD66w>
    <xmx:lJkVZHVbbLMePPMIVQHKouyxT-O7TDl3T_nWw0lYMWy0s4osgGo3hA>
    <xmx:lJkVZCOrEAZoz2wKKt8pQSEUyWDL0-lPUR7GgQkaVRvLw_gPpmV72w>
    <xmx:lJkVZEiCeQ3P2lVfuZzqm3LNrujj363JvjW4YT-nih8Uqhz6Khuolg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Mar 2023 06:59:31 -0400 (EDT)
Date:   Sat, 18 Mar 2023 19:59:28 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     John Keeping <john@metanate.com>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Message-ID: <20230318105928.GA87969@workstation>
Mail-Followup-To: John Keeping <john@metanate.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230317195128.3911155-1-john@metanate.com>
 <20230318002005.GA84781@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318002005.GA84781@workstation>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 09:20:05AM +0900, Takashi Sakamoto wrote:
> 1. Failure at tasklet for URB completion
> 
> It is softIRQ context. The stream lock is not acquired. It doesn't
> matter to call current XRUN API.
> 
> 2. Failure at PCM operation called by ALSA PCM application
> 
> It is process context. The stream lock is acquired before calling driver
> code. When detecting any type of failure, driver code stores the state.
> Then .pointer callback should return SNDRV_PCM_IOCTL_HWSYNC refering to
> the state.

Oops. I did copy-and-paste mistake here... It should be
SNDRV_PCM_POS_XRUN instead of SNDRV_PCM_IOCTL_HWSYNC...


Regards

Takashi Sakamoto
