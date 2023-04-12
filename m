Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E616DFC10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDLQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjDLQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:59:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B786A8;
        Wed, 12 Apr 2023 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1681318741; i=frank-w@public-files.de;
        bh=fOcCePvOyVu5eqlb5sp+l70CGKrbBCGwfk0FK1UiB6A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PMxo+v/gXJCJnMg8GB4Ksdf+mxTowXgGzm4T1QjhQIF4wzcrh8hNJZbC2qiasq84x
         Hi3ivkf2PaDzYH/S+/YlRqYsRYCL4JuKfFejRk1GFW2XKWKF0XJUdE2aajcO2ZcN2t
         UYtcIfXX7yUXNMBAL60v7En9ZbE+eXZrATBlz8GC5rMf6ulLWKmpvXetp94OHlA07H
         NWb+TFqqpXCrtAOpTWxAVp6Z/CObmyBWCB9kFjNvMdQlPuo+AhnEwhzz3Q5DS7vZAn
         0aWJehF6hd6bkVcA9veb2dBDD2EUwAPj/dFqlj5Gp7IJ72exPYSlAltLtkN+XzuZ/T
         FfUZRWThhrF4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.203] ([217.61.157.203]) by web-mail.gmx.net
 (3c-app-gmx-bap50.server.lan [172.19.172.120]) (via HTTP); Wed, 12 Apr 2023
 18:53:22 +0200
MIME-Version: 1.0
Message-ID: <trinity-990f3b28-d67c-49ef-9094-c3b7d2059e36-1681318402336@3c-app-gmx-bap50>
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
Subject: Aw: Re:  Re: Re: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate
 gmacs, mt7530 switch, and add port@5
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 18:53:22 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0d242292-16b7-6837-7d1a-b70c41309e6b@arinc9.com>
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
 <trinity-489cdc3b-e861-49d0-b1ec-e964f00388df-1681312277092@3c-app-gmx-bap50>
 <0d242292-16b7-6837-7d1a-b70c41309e6b@arinc9.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:2TgEVklogIPN9QUAHc+I39F76U3lLe2ea2lWUGSEcJ3RvU2i5XuSHdQJ6pvi7JcepqiJp
 i+kF1SQKfSGdpEKFDMk5JKhFry7q/xhTmS/ZbkqN3cyuS4s4+9iw1B4zxnWHYq2gUbFbIdfNs1YM
 J3kaN74CFnKi5rybX+JCfH+SMqCSekk7oXbyLyBxLj/4jEc7Lo10H0LlBl4KB2w1OApUY2Zyn1xG
 41Fgfzzly9PIDY0Z581CNIHF2nkEJx/mTeozgGw7zpRjjtj34v2WjTHkMmdJRSEWGyizDGWy9a1g
 mo=
UI-OutboundReport: notjunk:1;M01:P0:7SjTWPIP+q0=;W0WRwi90fBs/Qt21MFyuovCZP2n
 5q2XvFgv8opMAzG20CGRTfZPJqT7pMHPmMhGdNEYX6EeVSzy2kKtOMjGB9+Gj3KNEwoZ+ro5W
 0FD1jz5/HJd0hsYJ99cZU4MPAzOilR37JhqtiajUypiTZOtH/qJ86/lzHAp7I1Q5bXTgHYh33
 XcVe1nw42tZBtITlS9UVqnL8ipO+HCEdX529vh85yg/mBnH2oqtANY+Q6CtsC7O2gG9pu6LS6
 YSRWxu+i67bmO2KHPEfTIUAkCtZ0GH+G8uVMo2q3DB5jzKVciECADR9oggZlQCAKtoQ92OGUK
 bOBFDfh5/Gynx76q7yDw5LZuAk/d2v8MePFwUqW7ZeoEOCDjXhzsnT+BdnvRGJoWF+xO1jprH
 jCgAGPnanzGrcSFhp8hcFO6X8Pef651yP6qNgCGU/5vk2XNQK0CoChZwOUSJkwP4F30TocWUu
 Beg+q/BUngvOSH3XZ8IbFkh356XN/VobS7svY/f7+ZRt/mJ/fdRdMipLSsKtZ0u0MoY/zzf01
 gUH+NNJlxYFjX+FFwy3VYWIzjwO0hggVR8vcjeiUJJOrxxOb+yiU5cQql2f3gM7OmWXz1KUWT
 7emAU2SFKYNfKh/htvBb/5iFQvAmtnRiSWIF8RXoYaSSFSg9Rw+rTD+4mRJwqiPJWMv+EphSV
 /OIzT+cv9ldRiNq7IySENjKsQEO6JH8P0OS6JxuRU20oX5cu4/8OsaU3lun9/Sn4hbxxotYYY
 ZGl1TOVuTNet193Q66cWcOc5MuB0coIvVZaSShxaU51jYeFu6RHzwL74uGEIVwtiZVT/mODPR
 JbpDXu+ZaUOoS+Gi+siGgUZw==
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

> Gesendet: Mittwoch, 12=2E April 2023 um 18:21 Uhr
> Von: "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=2Eunal@arinc9=2Ecom>
> > thanks, it changes the master when i upgrade iproute to 6=2E1 (from de=
bian bullseye-backports), but i cannot do any traffic on it after switching=
 to gmac1=2E=2E=2E
> >=20
> > 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state UP group default qlen 1000
> >      link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
> >      inet 192=2E168=2E0=2E11/24 scope global wan
> >         valid_lft forever preferred_lft forever
> >=20
> > see no p5-TX/gmac-rx

> Did you apply the vlan and flooding fix patches from Richard?

have now applied all patches i've found from richard (which are all reject=
ed):

fe4495bb3cc2 2023-02-12 Fix setting up CPU and User ports to be in the cor=
rect mode during setup and when toggling vlan_filtering on a bridge port=2E=
  (HEAD -> 6=2E3-rc)
b0641f3e1a69 2023-02-12 Fix Flooding: Disable by default on User ports and=
 Enable on CPU ports=20
cb04b3451524 2023-02-12 Do not add all User ports to the CPU by default=2E=
 This will break Multi CPU when added a seperate patch=2E It will be overwr=
itten by =2Eport_enable and since we are forcing output to a port via the S=
pecial Tag this is not needed=2E

and now it seems working and is clear ;)

root@bpi-r2:~# ip l show wan
5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue stat=
e UP mode DEFAULT group default qlen 1000
    link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff

iperf3
[ ID] Interval           Transfer     Bitrate         Retr                =
                                                                           =
                        =20
[  5]   0=2E00-10=2E00  sec  1=2E09 GBytes   940 Mbits/sec    0           =
  sender                                                                   =
                              =20
[  5]   0=2E00-10=2E03  sec  1=2E09 GBytes   936 Mbits/sec                =
  receiver                                                                 =
                              =20


iperf3 -R
[ ID] Interval           Transfer     Bitrate         Retr                =
                                                                           =
                        =20
[  5]   0=2E00-10=2E04  sec  1=2E09 GBytes   936 Mbits/sec    0           =
  sender                                                                   =
                              =20
[  5]   0=2E00-10=2E00  sec  1=2E09 GBytes   938 Mbits/sec                =
  receiver                                                                 =
                              =20


how do you deal with these patches? do you include them into your mt7530 f=
ixes series? they (and vladimirs preferred cpu-port) need to be applied bef=
ore these DTS-changes

regards Frank
