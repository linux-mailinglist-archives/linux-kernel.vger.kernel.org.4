Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD471373D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjE1AC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1ACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:02:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D5A8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 17:02:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-969f90d71d4so291673266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codux-tech.20221208.gappssmtp.com; s=20221208; t=1685232168; x=1687824168;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pn96ezoRd+kD6OC2feIeXuvQ04GPTaNsZwk75x3SKpA=;
        b=5QJYWg6lkvic6q8CB3VDg5QlHMs3aRaVAulnB6hctcs+bVGJvYvdEyopC1GnvCF2fa
         9dd3n6DcNkZPFcM0ro2T2KBUKhG1AN4kBxnAmyKmZviVuzietWMtudvjDdDskkFHyh4I
         bJbTHn5JLK7OgefSEcWi7LT1+XHkqcbBdyWGpX1lVvh03iSxBtSu7tSf+oYQs5/+W803
         Hsl/4canGASw3Gs3k8OOl2YPnkRELRO39VX4o9p+tguEkBGob5ic88Y1EZs+Grj13dUO
         ugcn2clfa0Ql1XK+L54rYulum9tYKjCdKBKIWvWk0EJFPQSJ90lVf7UonOPECXDTbYom
         yjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685232168; x=1687824168;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pn96ezoRd+kD6OC2feIeXuvQ04GPTaNsZwk75x3SKpA=;
        b=Ts9PSdpCarSgDV2FAj/ntahynTWhyfFHmhlsQJoqJelK2mGSIzNR21OZH1/JUzYvfr
         SmwvOKRwd+f73o4IJQA2txddBn0yNHOmfuKpzmwDBT1TgVcd9EQnFu/KhsOSJIpfG5/e
         tWzQ+nMhN9rbjS36Kdvn9nQ3MvPgFh1czdjDgDbV/wOrP1TmR5/6jbnuAVnSqhWMk1xQ
         MxkTW2Aw1siSVX/4L+UXpPOQ/EXFFg89xdz1k0PQii/J7Yy10QvdMplCMbiNiTKVbRDT
         ltN5bSwu5zCssAiq5bT9gdKk8EjItygeCQNZh0C2ZkwzIegv1dgr0dU7rqB6tJxS4vCm
         rn4g==
X-Gm-Message-State: AC+VfDw7JkfxhwZL757p40yAsSVhHC9AqbNEDiGWvxg45XPZy0noGYoS
        hcN6ECcauTf4SBWBC9rY+yAGIA==
X-Google-Smtp-Source: ACHHUZ5k4uUZCxIXm/MMV4I1In8fofzlnJRv4MR9ALBC0GRjigS0SQxp5kgZOaiqb2oUqPwnDPD8FQ==
X-Received: by 2002:a17:907:a08a:b0:973:943e:f715 with SMTP id hu10-20020a170907a08a00b00973943ef715mr6025607ejc.41.1685232168665;
        Sat, 27 May 2023 17:02:48 -0700 (PDT)
Received: from deepblue.zlan.intra (wan.zappel.net. [90.187.13.225])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906244900b0096629607bb2sm3979325ejb.98.2023.05.27.17.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:02:48 -0700 (PDT)
Message-ID: <12102f7419c5e44cd2133aa769e25dbd16f4e0c9.camel@codux.tech>
Subject: Re: CSC3551 and devices missing related _DSD bits
From:   Armas Spann <armas@codux.tech>
To:     Luke Jones <luke@ljones.dev>,
        Stuart Henderson <stuarth@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        sbinding@opensource.cirrus.com, perex@perex.cz,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com, ealex95@gmail.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Date:   Sun, 28 May 2023 02:02:46 +0200
In-Reply-To: <19d69a5da8f1d4017ac14ed87f927ab82278073d.camel@ljones.dev>
References: <1991650.PYKUYFuaPT@fedora> <87jzx3zaf8.wl-tiwai@suse.de>
         <b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensource.cirrus.com>
         <19d69a5da8f1d4017ac14ed87f927ab82278073d.camel@ljones.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi, Hi Stuart (and of course, all others in here),

would you mind to evaluate this small (pseudo-)patch to be harmless?=20
(concerning the blow-up theory the first answer in this converstion)

I won't push it upstream right now but I want to know if this patch
might be harmfull. I'm owning a GA402XY myself and we digged out that
the initial setting of the cr3551 can be done via:

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 75020edd39e7..eaa06751bd48 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1243,6 +1243,12 @@ static int cs35l41_no_acpi_dsd(struct
cs35l41_hda *cs35l41, struct device *physd
 		hw_cfg->bst_type =3D CS35L41_EXT_BOOST;
 		hw_cfg->gpio1.func =3D CS35l41_VSPK_SWITCH;
 		hw_cfg->gpio1.valid =3D true;
+	} else if (strncmp(hid, "CSC3551", 7) =3D=3D 0 && strcmp(cs35l41-
>acpi_subsystem_id, "10431463") =3D=3D 0) {
+		// TESTING - (Hook for GA402X)
+		dev_warn(cs35l41->dev, "Warning: ASUS didn't provide
the needed ACPI _DSD properties for GA402X series, using defaults..");
+		hw_cfg->bst_type =3D CS35L41_EXT_BOOST;
+		hw_cfg->gpio1.func =3D CS35l41_VSPK_SWITCH;
+		hw_cfg->gpio1.valid =3D true;
 	} else {
 		/*
 		 * Note: CLSA010(0/1) are special cases which use a
slightly different design.

--

Which for our devices(GA402XY) enables the DAC to be used (it's still
quiet, as we don't know/set the right limits for boost/ind/cap at the
moment).

The above will be called in our HDA_Quirk
(sound/pci/hda/patch_realtek.c)

```pseudo
	[ALC285_FIXUP_ASUS_GA402XY] =3D {
		.type =3D HDA_FIXUP_FUNC,
		.v.func =3D cs35l41_fixup_i2c_two,
		// ....
	},
```

The cs3551 init be loaded by the above quirk wich is bound to and
checks its ID internally again(acpi_subsystem_id):

```pseudo
SND_PCI_QUIRK(0x1043, 0x1463, "Asus Zephyrus G14 2023",
ALC285_FIXUP_ASUS_GA402XY),
```


Many thanks in advance!

Best regards
Armas


On Thu, 2023-05-25 at 09:30 +1200, Luke Jones wrote:
> On Wed, 2023-05-24 at 17:36 +0100, Stuart Henderson wrote:
> >=20
> > > The problem is that this can really easily blow up your machine
> > > if
> > > some incorrect bit is applied.=C2=A0 And more easily applicable, more
> > > chance to break by novice users, simply by believing what a chat
> > > bot
> > > speaks :)
> > > That's the very reason why this kind of change should be via ACPI
> > > table officially set up by the vendor.=C2=A0 That said, the question
> > > is
> > > only who and how can be responsible for this kind of change.=C2=A0
> > > It's
> > > no technical issue, per se.
> > >=20
> > > If BIOS can't be updated, at least, the configuration change has
> > > to
> > > be
> > > confirmed by ASUS people.=C2=A0 If ASUS still ignores the inquires an=
d
> > > requests, we may put the quirk but with a bit fat warning (and
> > > maybe
> > > complaints to ASUS) to be shown in the log as a very last resort.
> > >=20
> > > Let's see what happens.
> >=20
> > Thanks Takashi.
> >=20
> > Just a note to say we're not ignoring this and are investigating
> > the=20
> > best way to support released laptops with ACPI incompatible with
> > Linux.=C2=A0=20
> > We're hoping this is going to be less of an issue going forward.=C2=A0
> > Please=20
> > bear with us while we look into this.
> >=20
>=20
> This is great news, thank you Stuart. If you need testing done at all
> on a wide range please reach out to me and I will enlist the help of
> those with the affected laptops I mentioned.
