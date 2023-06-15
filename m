Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD93E731042
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbjFOHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbjFOHJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:55 -0400
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 00:08:44 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1C297B;
        Thu, 15 Jun 2023 00:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686812912; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L6Unz2wogBCGZpNCk/2gHso29R2v034P4hfnLPsJ2uHlUoEw/91KrSQzzKrauhOxYe
    QLBj0RtcSRB/beCifgPIxx0kT38gihAKzCZe7WX4kB2uwOO3lmYQenLXUZst+xO2qJil
    klfLGP8Sw1CRAFNBwHhQV1waUwfydLi2zIOdl5qAfBy5nDtARx8a/eVo2oqVNOmMCB7z
    AdZZM7qHb87PdnD3IQIchCtuFXAcf9oxWzrksiSaFg2zw1bZQL+YomXGPPCnYg2xBxnc
    ag4v7tZjlhYcGKDIO/XGLaGNdrnDcAGFvK9KSyCKaQocbLb74GMR+RbBDg+WdX7fahRY
    nnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812912;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8+qFfB1rN2Sj/O8U/wDDRxw1z4CJQphmlltjDLoIQFU=;
    b=tSAjbAtEsAWBhxQGs1TY183UuZlIbWR3xA/T+9FpUCYYgH/WIbR22bnvWfzB4o//Xk
    48t7wqwXrtvUDk4NX52PR2wUmEDaf8gFey3I8AWgl+PHgs1Ogt5g6DoFAMuXLXu2bPmU
    dnLjuc0ovZHm57YUgsIO+tQrYxa7+gCbYAxonwq2HM8dWv7g86GBjP8oDzHWHWfPiTPu
    GFneu73YJfOSoWOFkHqnG4VRJ+BiBfVvqhonyJYpoQp48SEAlQaM7Ho+h0zOVNT47b0M
    D94KJIMgDNyQgE5jZ1VtHwWIbz6QtTNdFL16CYdX3St+aWvR9b/oBsJulNuEW5pIj2Jm
    Usfg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686812912;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8+qFfB1rN2Sj/O8U/wDDRxw1z4CJQphmlltjDLoIQFU=;
    b=fqsxASzjL94hytAHlMkUBSz2aEPp+JdkcxdjbQvHDS1gaILhHXC6l8eKPjhNBIg9IM
    EBheQZN42MweYYolbuctyWuGz0e/ZRfR0hoHsafu8qvGTht3hN8bQC3NgyULvoJ0YJ8o
    C8MVp1zbKAiiEac/h+wtgU+Rb2800aTBbVBUA7HVfJKYuBIV0eqA6QXAriI+ZEACVqdX
    HIqPMYpKszjTYaIdk1ktSBUVoaPYijhe1dyOj24j3tYeclc7Hsw6L8bUWUD8UcGKEnK1
    VUp+XRvEI1E+6qBu4t5xJ7jO3F8EyyDY5Bq70z8yp+ZkcfbCbQFOwRD/2QlvE/0R5wF7
    V6Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686812912;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=8+qFfB1rN2Sj/O8U/wDDRxw1z4CJQphmlltjDLoIQFU=;
    b=G5prsUdaZypuOfJGqNK67nTIA8+mflVABVlfs7lbDsZEKLKnrcq3m8VVM3kEq2vw/s
    LjwkO1m/d6GaGJy2pnAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id jaf17fz5F78W25s
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 09:08:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230609082348.GK8160@alpha.franken.de>
Date:   Thu, 15 Jun 2023 09:08:32 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <E3586962-A5A0-476E-8B5C-AFB1E1B0C4E6@goldelico.com>
References: <20230604145642.200577-1-paul@crapouillou.net>
 <20230609082348.GK8160@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> Am 09.06.2023 um 10:23 schrieb Thomas Bogendoerfer =
<tsbogend@alpha.franken.de>:
>=20
> On Sun, Jun 04, 2023 at 04:56:33PM +0200, Paul Cercueil wrote:
>> Hi,
>>=20
>> Here's a set of patches to add support for the WiFi / Bluetooth chip =
on
>> the CI20.
>>=20
>> WiFi works pretty well, provided it is used with the latest firmware
>> provided by linux-firmware. Bluetooth does not work very well here, =
as
>> I cannot get my wireless keyboard to pair; but it does detect it, and =
it
>> does see they key presses when I type the pairing code.
>>=20
>> I only tested with a somewhat recent (~2022) Buildroot-based =
userspace.
>> I enabled WEXT compatibility because the CI20 is typically used with =
a
>> very old userspace, but I did not try to use it with old tools like
>> ifconfig/iwconfig.
>>=20
>> Cheers,
>> -Paul
>>=20
>> Paul Cercueil (9):
>>  MIPS: DTS: CI20: Fix regulators
>>  MIPS: DTS: CI20: Fix ACT8600 regulator node names
>>  MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators
>>  MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators
>>  MIPS: DTS: CI20: Misc. cleanups
>>  MIPS: DTS: CI20: Parent MSCMUX clock to MPLL
>>  MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
>>  MIPS: configs: CI20: Regenerate defconfig
>>  MIPS: configs: CI20: Enable WiFi / Bluetooth
>>=20
>> arch/mips/boot/dts/ingenic/ci20.dts | 148 =
+++++++++++++++++++---------
>> arch/mips/configs/ci20_defconfig    |  47 ++++++---
>> 2 files changed, 133 insertions(+), 62 deletions(-)
>>=20
>> --=20
>> 2.39.2
>=20
> series applied to mips-next.

I think this was a little too early. Please see my review.

Best regards,
Nikolaus

>=20
> Thomas.
>=20
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not =
necessarily a
> good idea.                                                [ RFC1925, =
2.3 ]

