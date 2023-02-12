Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEF6938D2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBLQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:46:52 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9BECDFA;
        Sun, 12 Feb 2023 08:46:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1676220403; bh=rteUewEMc0z9sYe0COPS3/MBHPdzWyYgDvrmI8nUn7A=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=bbKTo7q6I/9+ESnYy2fYo17KuQQ7xHqCQJD0JI5f8mf50u2I+Qg0xuA+5kAy43yHV
         jX1XVylgHEcyiavzBx+7HKulGSWFfTezu7jUyIDDMyW+q42eBoTbQQwvbR8t0j2J3l
         9dE3pLe91fFltUb5tMPt0ae1IOF893BUDQMnaJtk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 00/17] Device trees for Apple M2 (t8112) based devices
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
Date:   Sun, 12 Feb 2023 17:46:42 +0100
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8E4C8F4-11BF-471B-AFDB-DAC237CEB70B@cutebit.org>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
To:     Janne Grunau <j@jannau.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 12. 2. 2023, at 16:41, Janne Grunau <j@jannau.net> wrote:
>=20
> This series contains dt-bindings updates and device trees for Apple
> silicon devices based on the M2 SoC (t8112).
>=20
> Device tree validation depends ont the dart-t8110 bindings queued in
> the iommu tree for 6.3 [1] and support for "local-mac-address" for
> brcm,bcm4329-fmac based devices [2]. The latter fixes validation =
errors
> for the existing M1 and M1 Pro/Max/Ultra device trees.
>=20
> The device trees are tested with the downstream Asahi Linux kernel and
> on top of v6.2-rc5. The hardware is of limited use with the upstream
> kernel. The notebooks miss keyboard/trackpad drivers and usb support.
> The Mac mini does not yet have a boot framebuffer and lacks usb =
support
> as well.
>=20
> The PMU (performance monitor) driver needs a small update which I'll
> send out separately. All other driver changes are already queued. The
> dt-bindings changes should be merged through asahi-soc to ensure
> devicetree validation.
>=20
> 1: =
https://lore.kernel.org/linux-iommu/20230113105029.26654-1-marcan@marcan.s=
t/
> 2: =
https://lore.kernel.org/linux-devicetree/20230203-dt-bindings-network-clas=
s-v2-2-499686795073@jannau.net/
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

For nco, mca, admac binding changes:

Acked-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

