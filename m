Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9116D464B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjDCN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjDCN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:56:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61427195;
        Mon,  3 Apr 2023 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1680530175; i=frank-w@public-files.de;
        bh=Xb/Aqcr8/6tCqOXQhpDwDqrXqkHQUMERdzS8z5C5aaE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WVgWtMLNJip3AWjjsW3c2NEI8/oR0kJHkFcWc8LIzEOS5noCTYVSWlKivGM7TXk1c
         sK3FeMkjgroYVQ3pq9/jXOA/krprjV0Bo5aBA+WYVI5C6LTCvEImrFpQchEzyDb1yx
         a3aBhQKOsaZCzFlOuvmHSkvCx8qwAPPxF7E0pFZcRRjCz/QjfXqOQd2YxVPo7YM0kq
         KEhaRcLyaEOp80/+npwZJ3jiasFpzsOFHWlvY/uy92PCK7FaLBVkQkdDvwNyalxwfo
         DvWZQIHjFOzeCwyadhDttGjYi1HXl4etdfE3/DRigXd5yjn/hCt8DDvIyFpOcSScDQ
         qzxZURiAEGDMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.94] ([217.61.152.94]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Mon, 3 Apr 2023
 15:56:15 +0200
MIME-Version: 1.0
Message-ID: <trinity-f48dda5c-6787-4732-978a-a409bbb0a74d-1680530175673@3c-app-gmx-bap35>
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
Subject: Aw: Re: [RFC] arm64: dts: use size of reserved partition for bl2
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 3 Apr 2023 15:56:15 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <601a8435-8e2a-2c25-5fe3-40be62269469@collabora.com>
References: <20230403105818.29624-1-linux@fw-web.de>
 <601a8435-8e2a-2c25-5fe3-40be62269469@collabora.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:1JUsxUleXcKrPCYwE3ay4MIocxMSb4QWHITw42EQ/QR0OVKQS9PGhbSC81u83cP4k1dMp
 S1et19Ypg4uLyI/QckCamlb8kcfn1bY4ymdZGUt3Ph7J38bdfIThEnQiirBQ6gDDvAfpskDhC+P6
 iAaYJxwyc3Ig+PTlA5twYw1xpSilLarg7i3GTbuHqFpqyBgCdnHX6WwQ+lK3PVIU4Auvh9i7MFsR
 8HzZea3gQDUcfZU9yxOEsCuh6ks7UdS2t6Umh1jTB9ziiDqmfpdBfdAzSirOnHnF8S1u0fg2yuGG
 Vw=
UI-OutboundReport: notjunk:1;M01:P0:jg4AmhsdSds=;mWrtOAomhXxgFe3ThMYoz+s7nVN
 UuwqaM8J8aThcXwF6VoXk7wWF86T5cbejRDTAscqE70dN6DVg8E/hbaOApM9Js/Fj06u7OPBg
 6RvF+zfTf7ndIiqqJVngOJMK01wmtK/ks5CPPuihiK0qKKIQo4L5BkxCefcCfoggy8VzL8vz5
 jUnILjCxNfiAlQLRxG4z8c2xaKZYrGwfyEdLs0Kn+fCf505U5h8WHRamHwgbjAZPPMfWv37kD
 r7J6OXsLD4QF9lmQZgIAzUISCBc1KpG0H3M1sl9mlUx9mW4rm25w6J9bsYL4c5S1r9sb9dRSr
 +wUoLpj0DFhK1ulSPiZ9abTnlBSV1M0fI1odhYuaaP+ULGffm1/8e3qR7VjCnNhSWarH4rd/a
 oItMUBls4M4r+zQWlMEmM5dQVzKWjknmYCVSh4OkdocNRZmsbeFNlUN6vBvWqdATlvVAKowIa
 5VZ5FpSJpn9dgxzWNmew5FStWODYHIM8UbrB31WAGL7J7SaSKy1kngfjYvoTiOc8ZIXNG2VLa
 DZA6YIdkOL8SrpOvtyeYa/wSwLq0QtAhq3JARS/F5YarnjRsd6IJcTW7FV+T4kWx1W9uLz010
 1camxgAhtwkgpCHT1qSS6rxcapHJymGBOG0AeVQISr6GrSjHxcqbJOLoWW+8il8Qs5QekwQOG
 lW0xPUBY16DQyG51Il7TTjUOeAbhM9Z/F4m6AJAZxLgkmHs18Ab6VsqZn43rZhZ02/vA81yHr
 aor2OlljU+S+V+JvVwc5/aPNxYey30TGMD+tW1TQE+efQoMwB3aag4VqhFhKq2zQTkLcWe/0f
 WawLAgD/5bBkNVgGvh48HFEwGo+Cz69aBk6LjPV0ryBqjQdgm3Ehw+FCuzQl7U4BpRRLv6Qqk
 6XB0KjI07hnPTIA==
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

> Gesendet: Montag, 03. April 2023 um 14:43 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Il 03/04/23 12:58, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > To store uncompressed bl2 more space is required than partition is
> > actually defined.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
> If this doesn't get changed anymore, I'm fine with it... but a question =
arises:
> did you send patches to add your BPI-r3 board(s) to upstream u-boot?

currently i use the rfb dts for r3 in uboot: arch/arm/dts/mt7986a-sd-rfb.d=
ts

this file in upstream uboot has no partitions defined

https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/mt7986a-sd=
-rfb.dts#L144

but i added them there too and i wrote content by offsets to main device (=
not to partitions).

https://github.com/frank-w/u-boot/blob/2023-04-bpi/arch/arm/dts/mt7986a-sd=
-rfb.dts#L154

so yes basicly it needs to be send there too, maybe as additional dts.

regards Frank

> > ---
> > I used the definition i got from mtk used in their SDK uboot.
> >
> > Openwrt uses also the first reserved partition to give bl2 more
> > space:
> >
> > https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/l=
inux/mediatek/dts/mt7986a-bananapi-bpi-r3-nor.dts;h=3Df597b869abc80d1a73f4=
4ebb85ad4da17376bb52;hb=3DHEAD#l22
> >
> > so imho it should be same in mainline to not require complex bl2
> > compression.
>
> Regards,
> Angelo
>
>
