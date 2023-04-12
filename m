Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64BC6DF963
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDLPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjDLPLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:11:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBC65AA;
        Wed, 12 Apr 2023 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1681312277; i=frank-w@public-files.de;
        bh=rqVjKHBgGD009ldYSsk+/seWGZgvzvn/D8ANy1/A438=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y+S4FnaZtL5I/U0A/wed+gda0MO9rdx9o2ORKO2z4f31ifZEG5gUcHA6Yc16gizND
         EPM3j/pfkq/KmeniIiBSNA4/hxrS1eBnJwi18Ex7B9pLJx2+d/q1OYErTS8M2hhAwl
         4LRfsaylk8iYIXd9iqn9gi/oK0iw26b53qIK1rL0mpUBAzVdH3EtFknKzp5+C+LX0n
         QAsca7OzMvxDzDBQ7E4wqd8hv7jiDiHyZ08JqLla9gBnU8L+3aD7ZKOg94TiB57CSg
         8GIPSDkZWatwBM3jraW8x8lFtJnuY2nNMJEQgQwaioTwuxpUOvgbgcuQluCjKWQ/rB
         D4DhCdKiO47Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.203] ([217.61.157.203]) by web-mail.gmx.net
 (3c-app-gmx-bap50.server.lan [172.19.172.120]) (via HTTP); Wed, 12 Apr 2023
 17:11:17 +0200
MIME-Version: 1.0
Message-ID: <trinity-489cdc3b-e861-49d0-b1ec-e964f00388df-1681312277092@3c-app-gmx-bap50>
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
Subject: Aw: Re:  Re: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate
 gmacs, mt7530 switch, and add port@5
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 17:11:17 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <703ad8a8-f84e-6404-4cce-5386bfaa2bd7@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
 <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
 <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
 <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
 <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
 <trinity-899c01a6-0fc5-4900-aea8-2b43802c8329-1676814734826@3c-app-gmx-bs35>
 <trinity-3f46d325-bc45-4ee7-ae86-c8db4467aa94-1681303779505@3c-app-gmx-bap50>
 <703ad8a8-f84e-6404-4cce-5386bfaa2bd7@arinc9.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:u6GFzg6pOcWqX8zGUBq6aqA1eVvOXgiODPGrvbT/KrzCmOVPknlh/A1ThikyZLO+nEXzO
 LaKlbvyfTjPFoOcun91BJQ7KtZIwSov5xChMOzlfkyYuUcpRg2XLlXqOa7Tc6nMqwLBOBI5wwBq/
 dm2ApV+g+ZIEX1oKC1/HpgOQ0iNigAqP40UgaSqtC+2OoPpTYwftZnC84NvGOVO5mv6fHTkk4OFC
 T7zPc01fIT8NQfzUuwDBrtxbY02atQqQUCw1y2xno2A220eXOHSEqCFapF88Qem6GXkSj+FvogqL
 Yc=
UI-OutboundReport: notjunk:1;M01:P0:wiky/k8vdBM=;uI1fbKp2Pxc7LqTwFPA3iJFNsjz
 DolfLJ2/jUi/tB8mZr0h3tTYUKFPvfKOFpbtiQoiS3Ef6y2haaNBZSov0UP9eKeir624vWyiL
 TkGE74CTdikZdtOfea63+M1F3eukE0rAZLRVfFCHQybA5Vdq6Mj46mIDm5ffVMKQzz7lVs8ba
 FDRYDEs3pzKtOjA+Bq6C0youwytVBoz4M4IBfudtYmjciEQDuv75sanrXGsGBAGLEcRrxAIdA
 iDItV4jHcEH299EGyWYmupw4sodnP584AA7jEwn75v1ODPNBLcF9u2y9HSer9XwNan1fxpyvs
 OCRJlaTXflKqukGB/6so+XZ+mT7kBm5OFL40jXvqRjZo7kUXTnVRCL0aHIYsmI5Y5FymICUaR
 2G9CU5XSmNurqi42j9SQZImwUsg3BcJpIw83HF3jCLimVrf+Apna2Lpkchn6vE0obV7vwcwlW
 S6pErjcS7MnU8LzRG6l/oOp83oJiBxkAnSwjlpMRK7f4qgz25UkXaUI/2Kc5u+whGU1sfAz9X
 9D/3MVH0sE2ZE33YOlyMJjdJlXsElsifmJxDyj4W3sYCUpJOvm9SeNaVBAIlievlY8CiUCWGu
 ETd197n8VpciRA1TKgiAhsYk4RYoDR5Zx/MU4h2CRjI/uq0eK1UvjNnWJAOw4cD+C920saVyr
 WVN/SD9tTmx7N09UKtxZljw6SxiYAeaVqKZn+Ogjuf/oBVidlxjaWc8SKuptWW1IN83C0z62F
 VfFoOQzX5nS3Oju1z60jiCH1uLFOjdyqOt0UxMAGugxkSgiuzm1HA5onxNHHvzO+BIO/0ih8R
 y8lpHgIoHL47GdDcw4WLz6lA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Mittwoch, 12=2E April 2023 um 16:31 Uhr
> Von: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> > looks good so far, but i have not managed how to change dsa master fro=
m the preferred port (eth0) to the second one=2E=2E=2E
> > any idea how the correct syntax is for iproute2?
>=20
> https://www=2Ekernel=2Eorg/doc/html/latest/networking/dsa/configuration=
=2Ehtml#affinity-of-user-ports-to-cpu-ports
>=20
> In short: ip link set lan0 type dsa conduit eth1

thanks, it changes the master when i upgrade iproute to 6=2E1 (from debian=
 bullseye-backports), but i cannot do any traffic on it after switching to =
gmac1=2E=2E=2E

5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue stat=
e UP group default qlen 1000
    link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
    inet 192=2E168=2E0=2E11/24 scope global wan
       valid_lft forever preferred_lft forever

see no p5-TX/gmac-rx

root@bpi-r2:~# ethtool -S eth1                                            =
                                                                           =
                         =20
NIC statistics:                                                           =
                                                                           =
                         =20
     tx_bytes: 5156                                                       =
                                                                           =
                         =20
     tx_packets: 61                                                       =
                                                                           =
                         =20
     tx_skip: 0                                                           =
                                                                           =
                         =20
     tx_collisions: 0                                                     =
                                                                           =
                         =20
     rx_bytes: 0                                                          =
                                                                           =
                         =20
     rx_packets: 0                                                        =
                                                                           =
                         =20
     rx_overflow: 0                                                       =
                                                                           =
                         =20
     rx_fcs_errors: 0                                                     =
                                                                           =
                         =20
     rx_short_errors: 0                                                   =
                                                                           =
                         =20
     rx_long_errors: 0                                                    =
                                                                           =
                         =20
     rx_checksum_errors: 0                                                =
                                                                           =
                         =20
     rx_flow_control_packets: 0                                           =
                                                                           =
                         =20
     rx_xdp_redirect: 0                                                   =
                                                                           =
                         =20
     rx_xdp_pass: 0                                                       =
                                                                           =
                         =20
     rx_xdp_drop: 0                                                       =
                                                                           =
                         =20
     rx_xdp_tx: 0                                                         =
                                                                           =
                         =20
     rx_xdp_tx_errors: 0                                                  =
                                                                           =
                         =20
     tx_xdp_xmit: 0                                                       =
                                                                           =
                         =20
     tx_xdp_xmit_errors: 0                                                =
                                                                           =
                         =20
     p05_TxDrop: 0                                                        =
                                                                           =
                         =20
     p05_TxCrcErr: 0                                                      =
                                                                           =
                         =20
     p05_TxUnicast: 0                                                     =
                                                                           =
                         =20
     p05_TxMulticast: 0                                                   =
                                                                           =
                         =20
     p05_TxBroadcast: 0                                                   =
                                                                           =
                         =20
     p05_TxCollision: 0                                                   =
                                                                           =
                         =20
     p05_TxSingleCollision: 0                                             =
                                                                           =
                         =20
     p05_TxMultipleCollision: 0                                           =
                                                                           =
                         =20
     p05_TxDeferred: 0                                                    =
                                                                           =
                         =20
     p05_TxLateCollision: 0                                               =
                                                                           =
                         =20
     p05_TxExcessiveCollistion: 0                                         =
                                                                           =
                         =20
     p05_TxPause: 0                                                       =
                                                                           =
                         =20
     p05_TxPktSz64: 0                                                     =
                                                                           =
                         =20
     p05_TxPktSz65To127: 0                                                =
                                                                           =
                         =20
     p05_TxPktSz128To255: 0                                               =
                                                                           =
                         =20
     p05_TxPktSz256To511: 0                                               =
                                                                           =
                         =20
     p05_TxPktSz512To1023: 0                                              =
                                                                           =
                         =20
     p05_Tx1024ToMax: 0                                                   =
                                                                           =
                         =20
     p05_TxBytes: 0                                                       =
                                                                           =
                         =20
     p05_RxDrop: 0                                                        =
                                                                           =
                         =20
     p05_RxFiltering: 16                                                  =
                                                                           =
                         =20
     p05_RxUnicast: 11                                                    =
                                                                           =
                         =20
     p05_RxMulticast: 38                                                  =
                                                                           =
                         =20
     p05_RxBroadcast: 12                                                  =
                                                                           =
                         =20
     p05_RxAlignErr: 0                                                    =
                                                                           =
                         =20
     p05_RxCrcErr: 0                                                      =
                                                                           =
                         =20
     p05_RxUnderSizeErr: 0                                                =
                                                                           =
                         =20
     p05_RxFragErr: 0                                                     =
                                                                           =
                         =20
     p05_RxOverSzErr: 0                                                   =
                                                                           =
                         =20
     p05_RxJabberErr: 0                                                   =
                                                                           =
                         =20
     p05_RxPause: 0                                                       =
                                                                           =
                         =20
     p05_RxPktSz64: 17                                                    =
                                                                           =
                         =20
     p05_RxPktSz65To127: 44                                               =
                                                                           =
                         =20
     p05_RxPktSz128To255: 0                                               =
                                                                           =
                         =20
     p05_RxPktSz256To511: 0                                               =
                                                                           =
                         =20
     p05_RxPktSz512To1023: 0                                              =
                                                                           =
                         =20
     p05_RxPktSz1024ToMax: 0                                              =
                                                                           =
                         =20
     p05_RxBytes: 5156                                                    =
                                                                           =
                         =20
     p05_RxCtrlDrop: 0                                                    =
                                                                           =
                         =20
     p05_RxIngressDrop: 0                                                 =
                                                                           =
                         =20
     p05_RxArlDrop: 0

maybe i miss something?

i'm not sure it is a problem with richards Patch or p5/gmac1

> > at least vladimirs patch should be included when applying this series
>=20
> I'm currently cleaning up the DSA driver, I'll get to this at some point=
=2E

regards Frank
