Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3569BB8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBRTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBRTMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:12:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B19F1554F;
        Sat, 18 Feb 2023 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1676747514; i=frank-w@public-files.de;
        bh=/QZ2fVJALgFIPWveyjrrfx0RBUL3rkYxN4JPK2ftSxA=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=L2a7gkVuLS97ixj247xxmtCGYy3+BslW99Wt7EUch9uWYl4y8gw/7DN//IIJoeYLR
         Fg84wpeI/+J/uTZiMCUVjANuuTQGyInz43PxrhlAOOTDi8kVt0iWb1F6V5BYpBA9Em
         SRzH09sho8cwAg0LS9HJ/oq5yBWCVEoipJ0Fw/jkCSi/beY7bKgLIWU7QYxH/Bt6cw
         kU91v/uXdrBkSpQeWSAZ1IdBrMwbwfFKRvL/eY4GVzqOMsa42Nog8CfPYEcXzEAw9O
         h+5SLqfGAwskSdooW6yT/EK1RKlbOp/pSd5TSZllp5HyvmEFKC70lRPVQ9X85oGGet
         Ksgafslzcmbaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.153.5]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1okDpf1YgH-00qBFk; Sat, 18
 Feb 2023 20:11:54 +0100
Date:   Sat, 18 Feb 2023 20:11:51 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: =?US-ASCII?Q?Re=3A_Aw=3A_Re=3A_Re=3A_=5BPATCH_?= =?US-ASCII?Q?v3_0/5=5D_arm=3A_dts=3A_mt7623?= =?US-ASCII?Q?=3A_relocate_gmacs=2C_mt7530_switch=2C_and_add_port=405?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com> <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com> <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53> <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com> <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53> <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
Message-ID: <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QkIJERgTOV6K5peDe7Uvtup9DMZrZ91YUhhhYpp++nESLk1s8WT
 zzm0qdEB7CHcuBUSAFS+G56kcEnpxEgDMNlgYrJcZQgCnBHqRNs3CJox2SGoZtPm3UYKJQz
 QuLwrw0MjN77pEwWDIPzpNSvxPZd0ohDQr4a4s4NGlqcm1AMf1A8n/0hzqSpLic+dnfmmkr
 yX2IbGETdnkoUoQnc/heg==
UI-OutboundReport: notjunk:1;M01:P0:HEGI1U7DpUc=;VqS3r+XbJ2c4sxoSwspnPMdxuoa
 5IWzCb/RsFQwtsZat8Kf1f0VZ/vQWMjPiRPLh1WP17q6NKGI/3rIZmTeHczkyU39VUyvFdPTS
 Dw20kgSQr4v851Ew+ieeUaPGJuVldNZlAGE1ZYZUjzGxll+B2uAACAmo0epLW6kY/1tx+IuNO
 k6xow7pYUfWFLoUkQ95uF4hJB0kGYmMNMGrANLxUHq7te8UbRSIuFDDDW+s3HVkTUirmMsZLj
 CokU8WIUgR1Khtumm9fzH+k2E0zjGM0jxAs+armAa4ip6yiJEAbiO0wSvudgjywFouP2tUdtf
 mSfW+yuAkRWAGIJEiCC94M2/a4Fr0zpC3rmebNd7iXamUDOpXJYo0Qh3jA2xD7EOILHfpMXS3
 JUVH+4to1WuMUrXn0M9l2UUWiK+pFB9RQsxlmdKP7yNwvnvyBgUfKuuhR3b00tpANw5A/rpDy
 yuVvzcCXb2BBCj2IAvAmVCFhgLJEy1DkPuJugo6KoBBzAtCy1pzwAkNKyPTYXuOa6Qini9wnz
 4lOu1RCUyj/yOjMa0dNaWZO63C6kP4NSZ9kwZl2Ae0KtLAz1fLnKx5Ac4Up9c9fkaqcyNIvJ/
 u2cMKfuwoluYN5LawnqFQoCZ1GiuIdm0CaX/ZgSgmAA3HUeqwnUyKvkdX/D+PofYqxANqhMUG
 lyzESEZfNcwNrs/cop5RdkoL5ba1jAfDUX+9W74ThdqZmup2eWWbpH+uwYWHYXAp/h5Iqjqcy
 LSJeGLTtq3TX37czmcj3PF5Kx+fQM2BrenkhjHVxky9gYwN8XMv1jDeYz/TkOdzvV3pahXqA4
 aJIXJHydBrDaUZ4ux+JuyL9ct12ukhpfS3BN9wCq96PL/5a5V5NS0v0UXQm48axwp/GgXICHd
 uS6e2VqVY+fg2+u3C4KKuOqwqYpioPVWOqBxRtxhot8pqIfEPKFnjCCvU2+qW4oKapYFVlTTV
 iXbA1w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18=2E Februar 2023 18:02:11 MEZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <ari=
nc=2Eunal@arinc9=2Ecom>:
>On 18=2E02=2E2023 15:18, Frank Wunderlich wrote:
>> Hi,
>>=20
>>> Gesendet: Samstag, 18=2E Februar 2023 um 11:49 Uhr
>>> Von: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
>>> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
>>=20
>>> On 18=2E02=2E2023 13:24, Frank Wunderlich wrote:

>Ok, so according to your tests, traffic through gmac1 is not very good=2E=
 gmac0 should be the default DSA master=2E

>By the way, did you make a bug report of this, by sending a mail to netde=
v mailing list or some other way?

No,not yet, because gmac1 is not yet used and i had very limited time=2E I=
'm not sure it is an issue in mt7530 driver or mtk_soc_eth, not idea how to=
 figure this out=2E Maybe it can be fixed with a delayed rgmii phy-mode (rg=
mii-rx-id i guess as traffic affected is rx on switch,tx on gmac)=2E=20

>> isn't there a way to leave ports by default on the the better gmac (gma=
c0=3Dtrgmii)?
>> maybe moving port5 below port6=2E=2E=2Enot nice, but then port6 is the =
first cpu found=2E
>
>This could be done but it comes off as an improper way to me=2E

Just thought about a way without the need of changing driver or adding a n=
ew dt property which can be wrongly used (who prevents anybody set the "def=
ault-cpu" property on more than 1 cpu-port?), Or define it at switch node l=
evel not port level (e=2Eg=2E via phandle)=2E

If the 5-below-6 way is not the right one i would prefer a driver solution=
, e=2Eg=2E let driver choose the best cpu based on fixed value (constant vi=
a define) or on highest throughput (trgmii > rgmii),but last may fail if bo=
th cpu-ports have same speed like mt7531=2E

These are the possible solutions i see atm=2E Maybe dsa people can share t=
heir opinion=2E

>> set master in userspace-config? i remember you've sent a patch adding c=
allback for it=2E
>
>You can change the DSA master using iproute2-6=2E1=2E0 and above with thi=
s patch which should be in your inbox as well=2E
>
>https://lore=2Ekernel=2Eorg/netdev/20230211184101=2E651462-1-richard@rout=
erhints=2Ecom/

I try to test it=2E

>The only issue I see here is that, with this patch series, port5 becomes =
the default CPU port which is not preferred for the reasons you explained=
=2E
>
>So once we can have port6 to be the default CPU port of the DSA slaves, t=
here's no issues left=2E

For me this would be ok if the current configuration does not change, righ=
t :)

Thx for your work=2E

regards Frank
