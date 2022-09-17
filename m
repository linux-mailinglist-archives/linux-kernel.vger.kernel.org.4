Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3B5BB6FE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIQHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:35:46 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689BB2BB29;
        Sat, 17 Sep 2022 00:35:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C63385C012F;
        Sat, 17 Sep 2022 03:35:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 17 Sep 2022 03:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663400140; x=
        1663486540; bh=gJqSfk3x4iCLYnv4jz2aPipU4stPswF3s9O1AXaEIk8=; b=K
        yeSiCLFwNgP7EFHvr5MCLdJEupXTgKLk22HkEww0btUlIV7goZWBaYt4N3jK2AAQ
        PwlpZJ1a5ZnyBHZnqNi5Hvce5/3iCCGyjrFtzlAJBn9dNKjcsJNHh9HTfBwh0loI
        LU3g+n5gyBBDehX2J6s+x3SLWL7GI981BdAv7hRAfFTfuQujKJcRIN9CHq11ZWsH
        E8AA/5DOqT6tPyi07l38yUvIYYLqxWegfJ88tcn1V/eXr0cBXHdl+6HUOoSlEezS
        A6FLxaZa4kY5oKhZQjN6dCu/ZPlC9VDxYkPx6/8YrPRUL+bkSVZYN7Y1gBc4iAKW
        ci1ob87whdreFCTlstFYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663400140; x=
        1663486540; bh=gJqSfk3x4iCLYnv4jz2aPipU4stPswF3s9O1AXaEIk8=; b=P
        pJkwH0oLvafZS1o1BVtojvUbuXWAUM2x8m+zzfn7TQ8JdRPZy0w/c/yUS7PgRves
        FbWvf2Q+4Cq5Mpm51hhrdm1TDBfi8w4mxS3tVteKS85uqcFiS0pCMHVXN/UdCMd1
        Tb/NW4f05PMaGGyL+F1n3309YaycxvQ3yp9U6K/3qSorhVrd6dpVUPgZFjW8Gt1S
        /5rtayDR/FgzbIXsyLjYCK3GVW8j7eRjcDX/7a6l0MoXuqisZ/t+ax1wneTT38Kh
        z9KdPykqjcYjKipAqR2okXSynYJDy6NJPNRZqXqCgHO2P9Xcoiy9xabSF2bOHY0k
        2Dcl87+Dy40dUrj6wAt3w==
X-ME-Sender: <xms:zHglY_KBuHqRUDZwm-b5QKRPNysMIO5LDXGwh4ifCix1nka8DnCK0Q>
    <xme:zHglYzLcXPRtjJqxS1o7-XP1KlGoenyHj5Jifqef2K4HEE29EaqgLG3ecPWKeM3v7
    oQ08qVYf0_iLQvCZu8>
X-ME-Received: <xmr:zHglY3sF18rGG3jhgpxYgQ1D-7ANAp20mNjEfaBonVj6PsK8HaC6YzcF8dt3qJi3RQ7jCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepteegteefhefhteegleejudfffffghfekleeijeeugfffteeiudefvdetteeuuedv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:zHglY4ZDwYgKEkuh7blhyMc33orS7MBycfnTcFhKXhyAirm7L6YUFg>
    <xmx:zHglY2bov4wxjFAD0h5Gsp8NmS4Q2lhTVZbAD3fqTL8D3O0rNZZ8mg>
    <xmx:zHglY8AzcIvvpUSlw8GfdIuLTmEvEVY6g-oIOr28WSmo7B6EQaXwHw>
    <xmx:zHglY9VrhnqhyFNbJcgPwgT8yDVym_kgr5OnOZ8XOMY0oI6MUf5CHQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Sep 2022 03:35:36 -0400 (EDT)
Message-ID: <a5f1976a3b8e905a09ebb08f3baad0996101c5bb.camel@ljones.dev>
Subject: Re: [PATCH 4/4] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming
 A17 FA707RE
From:   Luke Jones <luke@ljones.dev>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     catalin@antebit.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Sat, 17 Sep 2022 19:35:27 +1200
In-Reply-To: <20220909180509.638-5-mario.limonciello@amd.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
         <20220909180509.638-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, 2022-09-09 at 13:05 -0500, Mario Limonciello wrote:
> ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
> s2idle resume.=C2=A0 It's from a missing call to an ASL method in AMD
> the s2idle calling path. Force the system to use the Microsoft
> Modern Standby calling path instead.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216101
> Reported-and-tested-by: catalin@antebit.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> =C2=A0drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
> =C2=A01 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index a9b0f2b54a1c..6a2c94fdbeae 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -17,6 +17,7 @@
> =C2=A0
> =C2=A0#include <linux/acpi.h>
> =C2=A0#include <linux/device.h>
> +#include <linux/dmi.h>
> =C2=A0#include <linux/suspend.h>
> =C2=A0
> =C2=A0#include "../sleep.h"
> @@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> =C2=A0};
> =C2=A0
> +static int lps0_prefer_microsoft(const struct dmi_system_id *id)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("Preferring Microsoft=
 GUID.\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prefer_microsoft_guid =3D true=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> +}
> +
> +static const struct dmi_system_id s2idle_dmi_table[] __initconst =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * ASUS TUF Gaming A17 FA707RE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * https://bugzilla.kernel.org/show_bug.cgi?id=3D216101
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.callback =3D lps0_prefer_microsoft,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.matches =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI_MATCH=
(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
> INC."),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DMI_MATCH=
(DMI_PRODUCT_NAME, "ASUS TUF Gaming
> A17"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> +};
> +
> =C2=A0static int lps0_device_attach(struct acpi_device *adev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct acpi_device_id *not_used)
> =C2=A0{
> @@ -568,6 +591,7 @@ static const struct platform_s2idle_ops
> acpi_s2idle_ops_lps0 =3D {
> =C2=A0
> =C2=A0void acpi_s2idle_setup(void)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dmi_check_system(s2idle_dmi_ta=
ble);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_scan_add_handler(&lp=
s0_handler);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s2idle_set_ops(&acpi_s2id=
le_ops_lps0);
> =C2=A0}

I'm confirming that this works for another laptop with the same issue -
the GA402R series.

The diff as follows (I'm unsure of how best to submit this as it is
dependant on your work - I don't need attribution for this):


 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e2b73809ab50..0c8348de5cbc 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -420,6 +420,17 @@ static const struct dmi_system_id
s2idle_dmi_table[] __initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming
A17"),
 		},
 	},
+	{
+		/*
+		 * ASUS ROG Zephyrus G14 GA402R<variant> series
+		 * These laptops have a similar issue to the FA707RE
+		 */
+		.callback =3D lps0_prefer_microsoft,
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14
GA402R"),
+		},
+	},
 	{}
 };
=20
--=20
2.37.3

