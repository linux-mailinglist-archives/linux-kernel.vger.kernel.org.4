Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76470B0E4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjEUVgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUVf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:35:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A30CA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 14:35:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E3AE5C00A6;
        Sun, 21 May 2023 17:35:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 21 May 2023 17:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684704955; x=1684791355; bh=GJdvBqJXvaOlMagoboueinEIeThZBHqWFK0
        PV3GrZeQ=; b=I0zhgveBSGlTDUeO8KCCyl346fy7fEgLe78cDEe7ZLmX5xqg7da
        4E6Dof5XyxO8/1X9RQVXNWP70GFaw6EyTp/LHhGiELxQvhT+hiYAJTMsUvRkuEJn
        f9NejLkQ2Ni5H6SJswxy+f6/6/3iNkAY4M7QHdVWGKTAW1M0M3SdXzQGE1T20/rx
        9sQl0RFP685ayI7iMvZchaSjy0Wm1UCCGFreUd0H9JUA4yWAc491nEv+AxjNEhLx
        qw6wcoS1K6NdWb+f0jhVQmAGr+I+2YjWMcuESQJkHW843NvkVR9siTF+TVMaJhzQ
        CtYGb4vmRPiZuHja/j53MZDbrUfHNcGBchg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684704955; x=1684791355; bh=GJdvBqJXvaOlMagoboueinEIeThZBHqWFK0
        PV3GrZeQ=; b=ougvpP8amAQdZZr9yA0kQn+rMxIxiQFlhF04WU1HVo+ubz0msYU
        0XYKVDEVOf9Qy/l8rpKGuo6RlSbvs5i6y7q78Gsof7MZMPzSOu6nc9oIQUCUOjAZ
        2jyxlSmEJ+P5KTVI6X8BxqQ7rDeNmWohG/cKZPTydk3hQ0u13aTuQ7uP1B+1c/KZ
        /EJ5gWtESh4tprvNo/kpf82T5vu8LKMPLqfmgiFCzrm69+7XMV6vHgo7S27+z7jZ
        jG2VxwFJcdiuOxqWFhHR9SKYYzLUd3DlOw3RiPy9XHTtQE/3zLrUdLvtzcJ+4uKE
        05m9wIPLNgj123+dklGrDTNq41MN4O+Ma0A==
X-ME-Sender: <xms:uY5qZL-Wq_Lh5OBWuTv6-nyRq6rCrp3Nd0IBPxZXP5-6AfXJ6wXPXQ>
    <xme:uY5qZHvliF7Lk18liQhZLmg__C3IFXeIsDFk15Rrn_lVUuCrGxfWor5hZxCwMiTh1
    4uvh7lzUqItIq09gCU>
X-ME-Received: <xmr:uY5qZJCPOm1i495iOqPluy0rgl76Trfjb_buu2ZJB2j33tfZOM5eJhpwJD6pChDCg6kEtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhukhgvucfl
    ohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepvd
    etteekgfelhfegueffleeiueegteeggfdtkeekvdettddttddtgeevheffieeinecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhsphhinhhitghsrd
    hnvghtpdhlihhnuhigmhhinhhtrdgtohhmpdhhphdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvg
    hv
X-ME-Proxy: <xmx:uY5qZHfsjZy3uZZa5dDlK_IPmKtLcMztL4_dpDc5t-1rat9NyGIZ8w>
    <xmx:uY5qZANd2JZoJ2LiGsqyBm1MIps47lTK6OhOdEykUJaPw0CSri-HKw>
    <xmx:uY5qZJnoWndAudW_KUdSM3oSz3fsYdu0hKCCiZeUoqnBGKbCkmSC3g>
    <xmx:u45qZFtIIpW-OjEesj2zBpj4EK9eqE8bXX5EnsfC9h0HtYVfpW3C2A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 17:35:47 -0400 (EDT)
Message-ID: <c72a2f28a6e5c2c3c9ed17269bd56e7484df960c.camel@ljones.dev>
Subject: Re: CSC3551 and devices missing related _DSD bits
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        sbinding@opensource.cirrus.com, perex@perex.cz,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com, armas@codux.tech,
        ealex95@gmail.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Date:   Mon, 22 May 2023 09:35:40 +1200
In-Reply-To: <87jzx3zaf8.wl-tiwai@suse.de>
References: <1991650.PYKUYFuaPT@fedora> <87jzx3zaf8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-20 at 10:14 +0200, Takashi Iwai wrote:
> On Fri, 19 May 2023 00:26:22 +0200,
> Luke Jones wrote:
> >=20
> > Hi Takashi (and all others),
> >=20
> > We're beginning to encounter more and more laptops from ASUS in the
> > ROG range=20
> > where the bass speakers are connected to a cirrus amp, and the
> > driver for=20
> > cirrus is unable to pick this up due to being missing a _DSD
> > section in the=20
> > ACPI (SSDT). I've emailed engineers at ASUS I have contact with
> > about this but=20
> > it is unlikely that we will see corrections for each and every
> > model + variant=20
> > they have. The models we have seen so far are:
> > - GX650P
> > - GU604V
> > - GA402X
> > And there have been numerous forum postings in various places with
> > the exact=20
> > same issue for other models from ASUS that are not in the ROG group
> > I deal=20
> > with - oh and also some Lenovo and HP devices also.
> >=20
> > Some of the logs are:
> >=20
> > [=C2=A0=C2=A0=C2=A0 5.542312] Serial bus multi instantiate pseudo devic=
e driver
> > CSC3551:00:=20
> > Instantiated 2 I2C devices.
> > [=C2=A0=C2=A0=C2=A0 5.717261] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0:=
 Error:
> > ACPI _DSD=20
> > Properties are missing for HID CSC3551.
> > [=C2=A0=C2=A0=C2=A0 5.717269] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0:=
 error -
> > EINVAL:=20
> > Platform not supported
> > [=C2=A0=C2=A0=C2=A0 5.717286] cs35l41-hda: probe of i2c-CSC3551:00-cs35=
l41-hda.0
> > failed with=20
> > error -22
> > [=C2=A0=C2=A0=C2=A0 5.717734] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1:=
 Error:
> > ACPI _DSD=20
> > Properties are missing for HID CSC3551.
> > [=C2=A0=C2=A0=C2=A0 5.717737] cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1:=
 error -
> > EINVAL:=20
> > Platform not supported
> > [=C2=A0=C2=A0=C2=A0 5.717750] cs35l41-hda: probe of i2c-CSC3551:00-cs35=
l41-hda.1
> > failed with=20
> > error -22
> >=20
> > and:
> >=20
> > [=C2=A0=C2=A0=C2=A0 3.343851] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0=
: Error:
> > ACPI _DSD=20
> > Properties are missing for HID CSC3551.
> > [=C2=A0=C2=A0=C2=A0 3.343854] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0=
: error -
> > EINVAL:=20
> > Platform not supported
> > [=C2=A0=C2=A0=C2=A0 3.343855] cs35l41-hda: probe of spi1-CSC3551:00-cs3=
5l41-hda.0
> > failed with=20
> > error -22
> > [=C2=A0=C2=A0=C2=A0 3.345544] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1=
: Error:
> > ACPI _DSD=20
> > Properties are missing for HID CSC3551.
> > [=C2=A0=C2=A0=C2=A0 3.345546] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1=
: error -
> > EINVAL:=20
> > Platform not supported
> > [=C2=A0=C2=A0=C2=A0 3.345548] cs35l41-hda: probe of spi1-CSC3551:00-cs3=
5l41-hda.1
> > failed with=20
> > error -22
> >=20
> > So there are SPI connected, and I2C connected.
> >=20
> > Alex has already submitted the related patch_realtek work for the
> > GU604V and=20
> > no doubt there will be some follow up patches from myself or others
> > for the=20
> > other models. Alex has attempted to patch the Cirrus related parts
> > in kernel=20
> > direct with:
> > 1. https://github.com/bno1/linux-xanmod-gu604/blob/acpi-hack/
> > patch03_gu604v_speaker_acpi_hack.patch
> > 2. https://github.com/bno1/linux-xanmod-gu604/blob/acpi-hack/
> > patch04_gu604v_spi_cs_gpio_hack.patch
> > both of these patches have been tested and working for over a week.
> >=20
> > > From what I see the patch04_gu604v_spi_cs_gpio_hack patch needs
> > > to shift to=20
> > the cirrus driver sound/pci/hda/cs35l41_hda.c, and that driver must
> > now have a=20
> > quirk table - unless we can somehow add the cirrus related bits to
> > the realtek=20
> > code? I've personally not played with this beyond keeping an eye on
> > it all and=20
> > am reluctant to begin work on a solution until I've had some input
> > on the=20
> > direction it should take.
> >=20
> > In any case, this is not an isolated issue and we could benefit
> > from putting=20
> > in place some quirk or similar to accommodate for laptops where the
> > vendor for=20
> > some reason does not include the _DSD parts for use with the cirrus
> > driver.=20
> > The trend is looking so far like this practice will continue
> > regardless of the=20
> > vendor.
> >=20
> > Known reports:
> > - https://bugzilla.kernel.org/show_bug.cgi?id=3D216194
> > - https://www.spinics.net/lists/alsa-devel/msg146434.html
> > - https://gist.github.com/lamperez/862763881c0e1c812392b5574727f6ff
> > - https://forums.linuxmint.com/viewtopic.php?t=3D392762
> > -
> > https://h30434.www3.hp.com/t5/Notebook-Operating-System-and-Recovery/En=
vy-x360-2022-13-b0074TU-Audio-not-working-in-Linux-Fedora/td-p/8644641
>=20
> The problem is that this can really easily blow up your machine if
> some incorrect bit is applied.=C2=A0 And more easily applicable, more
> chance to break by novice users, simply by believing what a chat bot
> speaks :)

Yeah, it's an unfortunate issue for us. But I can't really see any
alternative solution.

> That's the very reason why this kind of change should be via ACPI
> table officially set up by the vendor.=C2=A0 That said, the question is
> only who and how can be responsible for this kind of change.=C2=A0 It's
> no technical issue, per se.
>=20
> If BIOS can't be updated, at least, the configuration change has to
> be
> confirmed by ASUS people.=C2=A0 If ASUS still ignores the inquires and
> requests, we may put the quirk but with a bit fat warning (and maybe
> complaints to ASUS) to be shown in the log as a very last resort.

I'm all for this.

> Let's see what happens.

The list of laptops with this problem is growing. I've received word
from my contacts that it is highly unlikely that new bios will be
rolled out for each and every model + variant with the problem.

To put it in to scale, these are the laptops now known to have the
missing _DSD, and does not include the others like Zenbook, or from
other vendors:
- G834J
- GV302X
- G614J
- GX650P
- GU604V
- GA402X

Some of these may have a CPU variant, in which case this means an
additional bios build. And they all have anywhere between 2-4 GPU
variants which means bios builds for each CPU+GPU combination.

ASUS is not going to address this, so the only way forward I can see is
to introduce a quirk that sets the pins etc *matched* to either the DMI
board_name or the realtek codec which appears to be unique? I don't
fully know about that so i defer to your judgement.


I can at least get some confirmation of pins from ASUS. This is much
more manageable and justifiable to them than updating dozens and dozens
of bios builds.

Can you suggest where I should start with implementing something like
this? I can have it tested on all the laptops I listed above after
getting verification from ASUS.

Cheers,
Luke.
