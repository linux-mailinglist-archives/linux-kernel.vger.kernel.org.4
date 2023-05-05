Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920C6F8CF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEFAAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjEFAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:00:18 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3485BA5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:00:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6069132009C8;
        Fri,  5 May 2023 20:00:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 May 2023 20:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683331215; x=1683417615; bh=+E
        HGl6UIEJr2mYgMnf4UBP4D5+0Gvo5H618eeD5wk4k=; b=kwFzADU6IH0eOjaLEp
        CBLtDD2fkyU4BQ7VLurCa0VAZncUb5EGnM5VGPbBMWbjnb4FIcQpLCMNLXt4XQzU
        hF7SBbHXFynrmfncg4vlcxFJMTMNz5Q7FYp3jCl8Nc04ZG4cA/sGxZujAiSi+0A5
        RVD9snX8wZFEoGpJcHJ2Y+bok920Izu+eW1wCL0qAhupSIo1FsOT1ZynOz3EyzyO
        qDPikeHOqKYAYTHBZmk4JiIuL0QapwxLp/VQvRT8v3xw5FsgUKMNAwo4bontibeR
        oJ0w7zZqqJsZ49pNIBAF91vce5PyvIENZVt7Ua8o8qkc3Sa9jLSK3m3HRE7JWSJG
        6tCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683331215; x=1683417615; bh=+EHGl6UIEJr2m
        YgMnf4UBP4D5+0Gvo5H618eeD5wk4k=; b=El2efMC0Dy0nnub3kQF65f5yP+ogk
        A8V3J99HPT3E3TmlnecNPnBNMc8YiCVoJwuE7FZi/1yc77ol4kYdjAabbcQ6U0M3
        92laCh+pFVHURiMvkIiVio3SvXAuDA5Xo/hhtyVSI74f0j5+JBMp+rnjbdKSdczp
        f3oCR2co5jmAa39OZOqYKKn8Mpszx4RC1EcFtI76q3qR2rOW6tdp9eKy1beKkRTo
        xbzuQ7PsqVGjaRqTrlAAO7hPmMX1Y2BBGm8EiryqNpEDxlzZA/BuZYe36kDzRdIP
        3sulgdWlAJogG5wd4N9s9q4H86xKy0YnTONmNmd+1Uwto2a/pFFqbL3ZQ==
X-ME-Sender: <xms:j5hVZDQw-ZHOJxkw0D8BvskdWPWMSi5I2dmno7lsURvkobbliCaGLA>
    <xme:j5hVZExaTthxu3GpyEcR05PbgbI6_6-bwRp30aJ8-pzPeQk7LOZaWGUU6Fc5mUDhm
    a7fRRWqFdeAFVoFkaI>
X-ME-Received: <xmr:j5hVZI0S7ZtNDvpIoNF8DvrkvcYa046wm6jkauzCDgUT3xth1-w_tZvxKjjpDpdebWH0gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epvddvgeeltdehfeeijefgveegfeeihfdtveetfeetudfhvedtfeeltefhteegledunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:j5hVZDAAeweZKePUSJDrOuYXponq0SJoTqoLTZoQ_sUy4LYeTBk-Iw>
    <xmx:j5hVZMj4Dbrt1LifcutxlJIV4AcwWq9nZmGm2MAGOok2xh9tvGmFfw>
    <xmx:j5hVZHo5vQ4lQ88C80HGsQ5xoMqCpTuvRAH6X4gSV-01ddqV_OMdiw>
    <xmx:j5hVZPtWBJN24GvKuDA6KOCg2ViSNuZMbAyrkuZOFG5H8-PhDyjSrw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 20:00:10 -0400 (EDT)
Date:   Sat, 06 May 2023 11:59:56 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for 2nd ASUS GU603
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz, tiwai@suse.com
Message-Id: <WNM7UR.C0XH9EHBJ0ID2@ljones.dev>
In-Reply-To: <87a5yiizcj.wl-tiwai@suse.de>
References: <20230503035035.254346-1-luke@ljones.dev>
        <87h6sune0i.wl-tiwai@suse.de> <L8Z3UR.OO4MSH3SX5VD3@ljones.dev>
        <87a5yiizcj.wl-tiwai@suse.de>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 5 2023 at 17:15:24 +0200, Takashi Iwai <tiwai@suse.de> 
wrote:
> On Thu, 04 May 2023 02:41:09 +0200,
> Luke Jones wrote:
>> 
>>  On Wed, May 3 2023 at 08:08:13 +0200, Takashi Iwai <tiwai@suse.de>
>>  wrote:
>>  > On Wed, 03 May 2023 05:50:35 +0200,
>>  > Luke D. Jones wrote:
>>  >>
>>  >>  Add quirk for GU603 with 0x1c62 variant of codec.
>>  >>
>>  >>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  >>  ---
>>  >>   sound/pci/hda/patch_realtek.c | 1 +
>>  >>   1 file changed, 1 insertion(+)
>>  >>
>>  >>  diff --git a/sound/pci/hda/patch_realtek.c
>>  >> b/sound/pci/hda/patch_realtek.c
>>  >>  index 3b9f077a227f..4a585050edc3 100644
>>  >>  --- a/sound/pci/hda/patch_realtek.c
>>  >>  +++ b/sound/pci/hda/patch_realtek.c
>>  >>  @@ -9501,6 +9501,7 @@ static const struct snd_pci_quirk
>>  >> alc269_fixup_tbl[] = {
>>  >>   	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A",
>>  >> ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
>>  >>   	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH",
>>  >> ALC294_FIXUP_ASUS_DUAL_SPK),
>>  >>   	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603",
>>  >> ALC289_FIXUP_ASUS_GA401),
>>  >>  +	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603",
>>  >> ALC289_FIXUP_ASUS_GA401),
>>  >>   	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50",
>>  >> ALC269_FIXUP_STEREO_DMIC),
>>  >>   	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA",
>>  >> ALC295_FIXUP_ASUS_DACS),
>>  >>   	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL",
>>  >> ALC294_FIXUP_ASUS_DUAL_SPK),
>>  >
>>  > Could you try to put the new entry at the right place?
>>  > The table is sorted in the PCI SSID order.
>>  >
>>  >
>>  > thanks,
>>  >
>>  > Takashi
>> 
>>  Sure no problem. Sorry, seems I read `0x1c62` and `0x16c2` :(
> 
> So, which number is correct?  Isn't it 0x16c2?  This sounds more
> reasonable.
> 
> In anyway, please resubmit a proper patch after confirming that it's
> really working.
> 
> 
> thanks,
> 
> Takashi

0x1c62 is the correct hex, I've submitted V2 with the line in the right 
order.


