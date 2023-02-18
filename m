Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B169B960
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBRKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBRKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:24:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175B11140;
        Sat, 18 Feb 2023 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1676715866; i=frank-w@public-files.de;
        bh=yVrDaub62HuqRk2C0zeAgvtpey2w2onmZg2Tso2bcx8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hn7nm0/3OZtO+vZuNNd8CtEEQ3pO51L6FCbqj0lv+k0YCr4d5pNZymwVoKGwIaPwG
         MhZsXjl6/8KmKNpsPYvII+s19fSk2xtSmj3vDiWZ7OWuYWHV6mGfei2chBxuXwfUJa
         8Me2uxChRpNTwgfjAUOdHRh8ahKgFmZ7dGi/XGiNGyQyholYWzp736PbSi7cMriZca
         QYzPaGfp3nucwSovXsmpbNtMxzvJ2q5WLT/o6OHvG89/rmTbHjHkGvsx3uZFjLXbhV
         s4DNUYE0gplhFNQCkU3J9x653S3snsXvsCq5XUT7+gBEU1qhUnLEV9mGtzLKY9Wwlk
         IorxvCJx0s26Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.5] ([217.61.153.5]) by web-mail.gmx.net
 (3c-app-gmx-bap53.server.lan [172.19.172.123]) (via HTTP); Sat, 18 Feb 2023
 11:24:26 +0100
MIME-Version: 1.0
Message-ID: <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
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
Subject: Aw: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs, mt7530
 switch, and add port@5
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 18 Feb 2023 11:24:26 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:dlJes5PJE7yl4BFksi3ruUFwrsZ+gOjgCEWZwdqImKbxOQ4mJrY+hbKHZzDTcwAZDU36r
 UpRlrQ7x5zDoSLhDZdPvfsI3BiqXWEmZnTLzI57EZMBkg4LdBGn5StwAqnnfKLwFPClt6aAzhuSn
 k/5vebZpSKTW4ExKvXSZZ1+0GNXrzUTsmm03eyImJXzmBgtvu+tU7JAjcVfOsMyUHNFPz+YuOp+v
 BV6YnVgXyKtyKY86UJGqMvhS6XqlYisRfv39FXmAkX+dibjvkfE0RMtRC1xPOYTO6MZnpqHFd6BS
 r4=
UI-OutboundReport: notjunk:1;M01:P0:3sNueGfNIgM=;V01yQ6u4y9GW9Z9zZ6gAk5ljJBd
 prWDMJFESH7D4902GrYDOpaCb+jK9F3i9mScgBqxZo2xr5UHU+DDDGXfPf0H/Bf9LiFV3vVia
 fe/OmiReOA6NaQCsMj6UKAxsq4hESdzUceB+AUz3Ulvup7teGD42xnFa1EiZstHPEscBS3Z6C
 tCTxS+x3eFa0J5VSNG2xPbOgWuosgYc1dasnxXQgxWJr7SmnyiFM7OORH0LVPTOaiehHk5BcI
 0OoHP8rrh+qAm81TRS8AllYc27UNMnESK43CskotlMTXxl2aqtWBbWJuZSSZF7JkWtQX5b3qm
 O5entk1YqHWOEBz3lgVwOW8fYu7lUl6h+u6DanTeeNcuxCfAtyhdojkWVQFQtHklZVb5oK9/w
 KR6Aqayulcd+Mgv16+Jy3PC6+xs/NJXvbT1Sk3KFLOMJgQTA3yBwW+yMPc3oeuTa17n8Ng84s
 uEB70aPxm6R8cDfbPTmezSSlo0wNKvJr0mqWzZLel0sqp/p0I+eOTRmtn8F5oeJ9DysDX/aoG
 xAojxISbDudD4aWPblC+cyg2UyePdQZPqOzx2Cd+AW0JqCmiYtU8pnBr8IwtO5l4dD20F9AXF
 XwIMvLB9oXHqzDCVcavVtWq+NpDkdtALV8OQy57E4YU6xa5yX7WVTwd+zI72HFqJktM3Cwpyc
 qLBiHiL1Ww1U5Jl733mr/emypkw74fq1umFlVmAnZlqMK1GJDpmU4vZ0zjPszpqPQu2ZM3GuX
 4hGoMqe4YSIJp+EvIZI4Wb9TIgDZFKinWSlyX1AVvtDEgEqTcd6o4Aqgbomll6oF0FNTGmzN/
 lZppnwZ7+UxkhmB5ccptNXGg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

finally get some time to bootup with this series on my r2.

I see that inserting the port@5 as cpu-port maps this as default-cpu becau=
se dsa-core uses first found cpu-port as
default (dsa_tree_setup_cpu_ports in dsa.c) and because of lower bandwidth=
 (rgmii instead of trgmii) not the best choice.

But it look worse...network is currently broken (set both gmacs up).
I see arp-packets reaching remote side, but reponse is not received by r2

I have tested it on 6.2-rc8 (wan-port), maybe additional patches are neede=
d?...userspace setup should be right.

so i added series on top of net-next (no additional patches except some ba=
sic like build-script,defconfig and such)...same result...

i'm not sure if i change the mapping from userspace back to eth0, so disab=
led port@5 in switch, now port6 is
cpu-port again and it works...so something is wrong with port5 of switch o=
r gmac1.

regards Frank
