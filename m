Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCE7194D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjFAH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjFAHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:55:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05409F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:50:46 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685605845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5tKeXBQGOxCiGGH+X0yQrUCgcSw61PZ4qp/YMQjszs=;
        b=NcK49nVvK/dq7bJUT7V+yj5/6pFo3ELcIiLvrtP8rMO+OlBBJ+9Eklu0eGwLzqp/SNavSp
        7FcfDcet5KbSCqbyUIe6MQeg9AiLSR6AZ2XKgha0bTCntxCIfGu+pPShThIBDo3sdKDWHJ
        uXDl0v5bvyz2IuHXihEUDtECKUyvU/rrtwQE7LMFS+vDBNQyKRpII0qXNMfu+CRuRfni5J
        8UC8af/0tD97Xb+ognzW5G6Ys8k6CduB9AgzIyOVoHNmij7M1CuzwUT7Ktis6KX7Y9FAKU
        vvGP4OLsR9MMcCUOlu/4YZcAhPKlEOXSrS9/cbMoywAEGE8yn7ckwZHs8hA3Yg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD43E1BF204;
        Thu,  1 Jun 2023 07:50:42 +0000 (UTC)
Date:   Thu, 1 Jun 2023 09:50:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/6] refactoring, fixes and updates for Meson
 NAND
Message-ID: <20230601095041.30d646d2@xps-13>
In-Reply-To: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:43 +0300:

> Hello,
>=20
> this patchset does several things:

All the fixes should contain:

Fixes: <hash> ("log")
Cc: stable@vger.kernel.org

>=20
> 1) Fixes value of ready/busy command. This new value was suggested by
>    Liang Yang <liang.yang@amlogic.com>.
>=20
> 2) Adds waiting for command completion by calling 'nand_soft_waitrdy()'
>    instead of using ready/busy pin and command from 1). This is really
>    needed because I don't have device with such pin implemented.
>=20
> 3) It moves OOB free bytes to non-protected by ECC area. Here are some
>    details:
>=20
>    Current OOB free bytes are 4 bytes (2 x 2 user bytes) under ECC engine.
>    Here is how it looks like in the current implementation:
>=20
>    [ 2B user bytes ][     14B ECC codes    ]
>    [ 2B user bytes ][     14B ECC codes    ]
>    [ 16B unused area, not protected by ECC ]
>    [ 16B unused area, not protected by ECC ]
>=20
>    All 4 user bytes are protected by ECC. This patch changes OOB free
>    bytes in this way:
>=20
>    [ 2B unused area ][     14B ECC codes     ]
>    [ 2B unused area ][     14B ECC codes     ]
>    [  16B user bytes, not protected by ECC   ]
>    [  16B user bytes, not protected by ECC   ]
>=20
>    Now OOB user bytes are 32 bytes instead of 4 bytes and not protected
>    by ECC.
>=20
>    Motivation of this layout comes from problem with JFFS2. It uses OOB
>    free bytes for cleanmarkers. Each cleanmarker is 4 bytes and written
>    by JFFS2 driver (small remark - cleanmarkers are always written in
>    case of NAND storage for JFFS2).
>    We have two ways to write this data to OOB (e.g. user bytes):
>=20
>    1) ECC mode. In this case it will be ECC covered user bytes, e.g.
>       writing this bytes will update ECC codes. Problem fires, when
>       JFFS2 tries to write this page later - this write makes controller
>       to update ECC codes again, but it is impossible to do it correctly,
>       because we can't update bits from 0 to 1 (only from 1 to 0).
>=20
>    2) Raw mode. In this case ECC codes won't be updated. But later, it
>       will be impossible to read this page in ECC mode, because we have
>       some user bytes, but ECC codes are missed.
>=20
>    So let's move OOB free bytes out of ECC area. In this case we can
>    read/write OOB separately in raw mode and at the same time work with
>    data in ECC mode. JFFS2 is happy now. User bytes are untouched - all
>    of them are ignored during non-OOB access.
>=20
>    I've tested this with mount/unmount/read/write cases for JFFS2 and
>    nanddump/nandwrite utlities on AXG family (A113X SoC).
>=20
>    Here is link to discussion:
>    https://lore.kernel.org/linux-mtd/a9f8307a-77d7-a69f-ce11-2629909172d2=
@sberdevices.ru/T/#m3087bd06386a7f430cd5e343e22b25d724d3e2d7
>=20
> 4) Replaces calculation of OOB related thing with macros. This is just
>    cosmetic change.
>=20
> 5) Checks buffer length on accesses to NAND controller.
>=20
> 6) Removes useless bitwise OR with zeroes.
>=20
> Link to v1:
> https://lore.kernel.org/linux-mtd/20230412061700.1492474-1-AVKrasnov@sber=
devices.ru/
> Link to v2:
> https://lore.kernel.org/linux-mtd/20230426073632.3905682-1-AVKrasnov@sber=
devices.ru/
> Link to v3:
> https://lore.kernel.org/linux-mtd/20230510110835.26115-1-AVKrasnov@sberde=
vices.ru/
> Link to v4:
> https://lore.kernel.org/linux-mtd/20230515094440.3552094-1-AVKrasnov@sber=
devices.ru/
>=20
> Changelog:
>=20
> v1 -> v2:
>  * Add patch which renames dts value for chip select.
>  * Add patch which moves OOB to non-protected ECC area.
> v2 -> v3:
>  * Change patch which fixes read/write access according discussion link
>    in 1) above.
> v3 -> v4:
>  * Remove patch which renames dts value for chip select.
>    Here is link to discussion:
>    https://lore.kernel.org/linux-mtd/20230510110835.26115-7-AVKrasnov@sbe=
rdevices.ru/
>  * Pass 1 to 'meson_nfc_queue_rb()' in case of NAND_OP_WAITRDY_INSTR.
>    This fixes ONFI page processing during NAND driver initialization.
> v4 -> v5:
>  * Move update of 'NFC_CMD_RB_INT' to the separate patch.
>  * Replace code which uses extra status and READ0 commands for waiting
>    command with 'nand_soft_waitrdy()'. In fact this patch adds second
>    mode for command waiting by using 'nand_soft_waitrdy()'.
>  * For OOB layout patch see changelog in a patch file.
>  * For check length patch see changelog in a patch file.
>=20
> Arseniy Krasnov (6):
>   mtd: rawnand: meson: fix ready/busy command
>   mtd: rawnand: meson: wait for command in polling mode
>   mtd: rawnand: meson: only expose unprotected user OOB bytes
>   mtd: rawnand: meson: use macro for OOB area
>   mtd: rawnand: meson: check buffer length
>   mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
>=20
>  drivers/mtd/nand/raw/meson_nand.c | 234 +++++++++++++++++++++++-------
>  1 file changed, 182 insertions(+), 52 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
