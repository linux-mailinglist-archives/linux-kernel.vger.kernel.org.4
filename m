Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F669C06B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBSNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBSNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:52:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC881040A;
        Sun, 19 Feb 2023 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1676814735; i=frank-w@public-files.de;
        bh=gmvlcFd/smi3ohVhvpOwg6d8LqAat/B8RQwKwD+wxnk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hrTYUT5Eu2eVGwfeMs3ZDh4usgGG557Qun1nIumUaxmzkt8djDKUoYgaJstqk3haR
         yC4gTC+IX2WfsSPI2T5ECDdH7z4wpguBiWqNRO+L8o8fWlKWBFuVLC9oyUJhmpIZ23
         Nb20cp25LwPBgVdx0Ez1DqqS7i+bjPqCGVVY+5znr/gcuQMRXLmpwb24pxsprdu49K
         6U4YSwuu61z6kuX+VSMqj6GSpx71FEq6Pe/1E85OHIxwxBMQRw7gJcJxsd5i21FGug
         pwbEwFloOc4KVrJBbNZY0T6kGID1UhlVXKve4ddsqBR90eAWxZSCQoQeBcu8c2W+gR
         oGVKZTalLf3bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.154.15] ([217.61.154.15]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Sun, 19 Feb 2023
 14:52:14 +0100
MIME-Version: 1.0
Message-ID: <trinity-899c01a6-0fc5-4900-aea8-2b43802c8329-1676814734826@3c-app-gmx-bs35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: Aw: Re:  Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs,
 mt7530 switch, and add port@5
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 19 Feb 2023 14:52:14 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
 <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
 <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
 <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
 <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:H8JYLvvEoF162SefwPsSsiN8Aap9QmINpwaEqytkapWmuK4d0GPFziw2QktTM0gGK0HN7
 i1QLFWMQxHj4lg5tjMB3ECYjti/ltonQmox4TQHYxaJPaO+MbUaAifCi6uk7fG10KZb/2gYtnILo
 nAJJEB6+Li9mekl7Y9UaHnBnS59maFhBNCNL3baeaSouPmP2ADrX0Q4a0DufpqbVucvWPdzDizN5
 AcPcKnqWqTEUcPUdIGGPlJTC8Tcn+wtwebQbh00sO9zeDSDfauKkxaweaJEg8ND8GwKGA+Yq3Tzl
 Kk=
UI-OutboundReport: notjunk:1;M01:P0:hi5o1IiP/qA=;6XlLuYPPfufbmPU18XKOO8DkJWF
 lR+B/5CNDwV4bjvwrkxEHaO+Hio6hM9UGqE/i9E6/G705WFtguKNdegLkH9TbCfvFG2vIpInm
 pfEtEUewrPWhJZIVtlN6HFx5SwCg6baXhrJOUuysy83l1hJBtxwKqkCaThqMN3KK95VyfbpLU
 O2TBBEmqyB2BaeeB0i3qt+8HMTGIHNyRMEqTlwx1gZNI+/SXgT/CzvmlAxCqHtbrpWps1blLV
 eqtqB1oG/qNVrT1bvy9iXpZ59I36T/mEBljAFD3hrxfyw87xk2VyGv3/b2xEVaz4EFrj8xJsZ
 Mmko3qGfxBR+IY9J2knN1VHYVWeSgvz8LOr6FwEWMvt5IuniiAWG3HBguVkCxc4U+U/L9PgQN
 pOahQAj33W4flgCHi4ygbcWKvg565VNazKX30vR2Uc6q9cxHEdJV2TgBmKudaZcJDCZH6tsmR
 0899hx0uniLEYRsfUGt2v9R4/ouqgQeFE+wLo6XjebMo+WNKpb5z4vVBPeWlx0Ij+SHHDTD7k
 ncZ4MRVxrXf6xWOwIfBRCTG2Iv6Qg72DJw0FbFTFs7AqbJ25NHfWVKZ2Nx0E2DBA6GQAglLzk
 LaDDPx39nzK6sxhuyYgF63Ga6ojSSaKr7j81YhwHM5Pc5C3t+oWZM8+sPQLlRnDuyghawGlN+
 yOls0iMeFIe711GM3w1pNpWs1WWF6OMjGHh1nAKjyvqqqe5b01A2Yp6mzRhIkGNBoCmDGFB3b
 Kt0sC63x2POGFPkWgkG1lzKTHOzMv+dZ/PxOV+YDZsib5cMmrxYmlVGKJrWmxzpLZptdW0YZs
 nDCsLjVjYA0A1l7LaHJIqo5GEkPqw/KyCPZJK3b4HnwmQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Samstag, 18=2E Februar 2023 um 20:34 Uhr
> Von: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> An: frank-w@public-files=2Ede
> On 18=2E02=2E2023 22:11, Frank Wunderlich wrote:
> > Am 18=2E Februar 2023 18:02:11 MEZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL"=
 <arinc=2Eunal@arinc9=2Ecom>:
> >> On 18=2E02=2E2023 15:18, Frank Wunderlich wrote:
> Can you also remove this from mt7530=2Ec and do the test again? See if t=
he=20
> performance changes at all=2E
>=20
>          /* Set core clock into 500Mhz */
>          core_write(priv, CORE_GSWPLL_GRP2,
>                     RG_GSWPLL_POSDIV_500M(1) |
>                     RG_GSWPLL_FBKDIV_500M(25));
>=20

with these disabled i have a bit better performance (625 Mbits/sec instead=
 of 600) and no retransmitts on first iperf3-run=2E

not yet tried any rgmii-delay option (have no idea which is the right one =
on which position), but yes, mostly it does not improve performance=2E=2E=
=2Eit simply does work or does not work=2E

regards Frank
