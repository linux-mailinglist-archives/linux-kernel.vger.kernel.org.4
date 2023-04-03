Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD96D4B27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjDCOze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjDCOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:55:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9F29BEF;
        Mon,  3 Apr 2023 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1680533693; i=frank-w@public-files.de;
        bh=gkNhZo5WW9JiUEfy4bmabMQloAjSbFROujFS1ASy7wI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FnNK3+zZEsxo9v5MO1V6kmIwFfs2pS1tnIpJ1svTVnTBSAQuR0LWBAWJOm+SVwloC
         dCnzlyxWJD5KMqoREQCANsLU9G8JgjW9drqHkPFDsvh9jfBJcJjRQF82M1zwNAv4s1
         +1WffXDpxap/TFB2HIzSLuyxlEacS+1CWi6vk2SozpglnnVKQZhT01mEEaNlVN+KPA
         l6FdBnJflSCplFhlRfn9AmMxph/FGHyHroOQ+8BXxKc/UIxPM31dTeHbCCCzyB9n1c
         RWjWumHl+3Kx7nKAjDH4zfAKuTJghAJqQ/4viWyQK6MLLZqmUwoJC55vAboVJ0kdLX
         p4cWNUT+NMztw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.94] ([217.61.152.94]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Mon, 3 Apr 2023
 16:54:53 +0200
MIME-Version: 1.0
Message-ID: <trinity-cdcc1156-f62c-40ac-b064-c2592e29e9eb-1680533693486@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  Re: [RFC] arm64: dts: use size of reserved partition for
 bl2
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 3 Apr 2023 16:54:53 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0f43fa98-4fe6-bc9c-ed8d-be7cec0dda42@collabora.com>
References: <20230403105818.29624-1-linux@fw-web.de>
 <601a8435-8e2a-2c25-5fe3-40be62269469@collabora.com>
 <trinity-f48dda5c-6787-4732-978a-a409bbb0a74d-1680530175673@3c-app-gmx-bap35>
 <0f43fa98-4fe6-bc9c-ed8d-be7cec0dda42@collabora.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:eQxPOhKQxRCjG+y+jb7ldEpx7Cd2jWY2jXjipOo/8vv/3VqJyHQ+OR9DxI+jxPbv/eOWv
 wBSGVypHtet6WG5zHJd8c4qlq7DxpFCLwNDZo+9+Mt2O/xUQuTJJUvBQW114xcy61NoEKMzRRXeJ
 xyLu4D/z+1RGKo7DRoYEg2QhFM3mArz4YcRFkRQHGXIbvEW79cWzUV/D3BuyO8xKCRYBk/WMMB7r
 ZqyB64IVHNvwIUKTUXlgD2Ngk3UaLTThtPuYgleO8KbtIloJfgMJsnfquH0/LfVNYaxMBG9Ku+cb
 Es=
UI-OutboundReport: notjunk:1;M01:P0:ONbDQDeXwwc=;EmsoxrBGcGtICvod1XbsvYeF8hk
 NASSFUo53pUcG9GdMsv7cMgyoy7oDFoL+VHy1Dzy24j0gtNX21x/Tsi/Y2SDgxeUgeOXCZf7w
 ko9vX6iptgPC/sXgVvV26v2RXgMtr995wsrzPvgPAoXOLgkxd+h4KOlp/RBEu7GB9rZjfmHZl
 DW2N2gXnrFg3sCOr/QrXjn7+h9mitt4ypqmnb4STc7xqOy82oAB0BlpNMMkyQxl01Xvju2puk
 lK9t66ZKdRzijMxmRUH7ZMr6iZxuATwFZNhtX4MZ7dVjnE3Yag1tC5EO2AQOnWUSxNjTzczeZ
 0QuuKOwiNSym15jEnP+n8J19nXVnlp5oUDOC+Y9d7Wm/VipGdmT/DrxKyJoL/vbN101YrJowr
 2HKZ75RLgdfdYl+x4rmcov6r8CfiVySj0Cs+UjK3FR8HkV3fgWeP+/+h9+mf7q+FhhY4sTqhB
 bZOkwewf8+7ViYEY50n7lzBtGDQ1Mk/NCDBqumZbuasMRX9EJxjBcCf7LFg39tWJ03eI6FneS
 rzTWdUSTAipwHFcguKoIsrzaf0+PTzxdZGYZquDjFoQ74dz7oB1iepmCegOqOd58xlb7ixwum
 um3/AlvS2rf2mTaxfG+jv9FejJNbD48ji89EgjjSP3y88iireZDyBhZ2URJyenoffpK63qQ/L
 pX1iID6ffw89/EZGR9/gImGLBY0HngehqhwoSjqtXxKc2KUwN2h9FtExTJ3lnipc/xrbhmY7G
 4TjIQaS3TeNEDqbAj984SKJ8TQsaGeKz1XSfb6hdHkkM6fVanSC81EVoDQuo+useil2H5Faz5
 kefX/BiWBXy5FFsIpSzIm2wA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Montag, 03. April 2023 um 16:04 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead=
.org, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof=
.kozlowski+dt@linaro.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, de=
vicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@l=
ists.infradead.org
> Betreff: Re: Aw: Re: [RFC] arm64: dts: use size of reserved partition fo=
r bl2
>
> Il 03/04/23 15:56, Frank Wunderlich ha scritto:
> >> Gesendet: Montag, 03. April 2023 um 14:43 Uhr
> >> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabor=
a.com>
> >> Il 03/04/23 12:58, Frank Wunderlich ha scritto:
> >>> From: Frank Wunderlich <frank-w@public-files.de>
> >>>
> >>> To store uncompressed bl2 more space is required than partition is
> >>> actually defined.
> >>>
> >>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >>
> >> If this doesn't get changed anymore, I'm fine with it... but a questi=
on arises:
> >> did you send patches to add your BPI-r3 board(s) to upstream u-boot?
> >
> > currently i use the rfb dts for r3 in uboot: arch/arm/dts/mt7986a-sd-r=
fb.dts
> >
> > this file in upstream uboot has no partitions defined
> >
> > https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/mt7986=
a-sd-rfb.dts#L144
> >
> > but i added them there too and i wrote content by offsets to main devi=
ce (not to partitions).
> >
> > https://github.com/frank-w/u-boot/blob/2023-04-bpi/arch/arm/dts/mt7986=
a-sd-rfb.dts#L154
> >
> > so yes basicly it needs to be send there too, maybe as additional dts.
> >
>
> I strongly encourage you to send this change to u-boot as well as changi=
ng the
> kernel devicetree... and when you do, you can add a reference to the lis=
t and/or
> commit @ u-boot on the commit that you'll send here for the kernel... bu=
t there's
> another question...

imho uboot needs an own dts for the board (copy from rfb) for this because=
 of another change
(tick_dly) and i have no rfb for testing.

> ...what happens if you run the kernel on a device with an older partitio=
n layout?
> Does anything break?
> I don't think that anything does, since this is read-only anyway, but ju=
st to be
> sure... :-)

i have no information about the second partition from the old layout...it =
was only named reserved.

as openwrt also uses 0x40000 it should be save to use this value here.

if the bl2 does not fit into the bl2-partition (cut off), board simply doe=
s not boot,
thats why i want to increase it now. my current bl2 is 197K for nor and i =
had this problem.

> Besides, you have to fix the commit description, but you knew that alrea=
dy.

sorry missed the mt7986: part in title, or did you mean another part?

i put the additional information below --- to not be visible when patch wi=
ll be applied.

> P.S.: When you post a RFC, giving it the right commit title helps someti=
mes! :-P

yes, missed the mt7986-part here, just wanted to hear comments first if th=
isis the right way
