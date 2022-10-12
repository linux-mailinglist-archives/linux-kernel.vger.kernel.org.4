Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45AF5FC216
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJLIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:36:31 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FCA5D0E3;
        Wed, 12 Oct 2022 01:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665563766; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iTHb5+/Ton2ywbFeAnvcpWBaQqEtiYRUXopNwM3NU4LDYmlNiBucaN/rATHdzVmGSvyf0bJQG0KNtqjPDILtYTNbpVJt/IXWEFBJnSoe4RX/FMxNXTUaGjmAfmnoKszc+ppN7rg8thlcLQHN85gDV05u7jaOWUNS6/0lYkMToYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665563766; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hHLT6AQP2FgyeTao9iTLVODR/49BzpgkuGb3Oh6vHCM=; 
        b=nUdhN6G6kJv9ZQ59wyEUpB5haqsvJfulLf/tMC/lxySpqIFS2G0blW406nirPEDoTNnVQwZoAb6LuMa8i4kl3I8qGenqIPQ+FQbITFgPjsSaiDpf0SMe7YLCSzujufaJoguuhVm7R94UMQBebkcSGbHNIsVhvFM61+R5DiDDZ+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665563766;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=hHLT6AQP2FgyeTao9iTLVODR/49BzpgkuGb3Oh6vHCM=;
        b=VGT2kSxjtpnSpo+OnFer4DKWLYk6K17O7ACmBc931GymGnKLRy8VHgmyiG7WAkXX
        StBm47gXpGjXRyCEPVT7iIy6Va9Ggt/V3elUWSlfO3qoHj6x6HR9I/HeOwc7INMFI4V
        xEsg9b/UkybWd3RpURW0vnL3B3zlBcCRCO81mAZ4=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665563765635216.59596370853365; Wed, 12 Oct 2022 01:36:05 -0700 (PDT)
Message-ID: <695a13341db63965a22799dd78698751ed95448c.camel@icenowy.me>
Subject: Re: [PATCH v2 01/10] mailmap: update Icenowy Zheng's mail address
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Date:   Wed, 12 Oct 2022 16:35:59 +0800
In-Reply-To: <60a2cb70-bde4-4423-9a54-7abc1ba466f8@app.fastmail.com>
References: <20221012055602.1544944-1-uwu@icenowy.me>
         <20221012055602.1544944-2-uwu@icenowy.me>
         <60a2cb70-bde4-4423-9a54-7abc1ba466f8@app.fastmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-10-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:31 +0200=EF=BC=
=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Oct 12, 2022, at 7:55 AM, Icenowy Zheng wrote:
> > Due to the SMTP provider adopted by AOSC applied some more
> > restricted
> > rate limit that is not suitable for sending kernel patches, I
> > switched
> > to a mailbox hosted on my own domain name now. In addition, there's
> > a
> > single commit that is pushed to the mainline kernel tree during my
> > internship at Sipeed the last year.
> >=20
> > Map two AOSC mail addresses (both aosc.io and aosc.xyz domain
> > names) and
> > a defunct Sipeed mail address to the new mail address.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>=20
> I don't see a patch for updating the MAINTAINERS file here, if you
> haven't already sent that another way, you should probably change
> both at the same time.

Good point. If this patchset is going to have a v3, I will contain it
there; otherwise I will independently send it.

>=20
> As a driver maintainer, you can also apply for a kernel.org account
> [https://korg.docs.kernel.org/accounts.html] and use that for
> sending patches and forwarding to another address.

Well I am in China now and not so easy to get my PGP key signed...

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd

