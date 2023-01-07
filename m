Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0166100B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjAGPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjAGPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:41:09 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3A43DBE
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 07:41:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BBC34C0008;
        Sat,  7 Jan 2023 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673106065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rX0H29McC/C7xK42sgmW/TJ1Y/Q+h/+Kp2qtSE/fOWw=;
        b=kKdDbqy+oitflGNwjpX4pVzJ8wlLk53FfhhWqO/X6VRZ4982zWw2SvSlLC/xsm/mzifhx9
        Y/vjIMzkDwdEf0qZRlf2TB45/Fe+Gb11RDqmssfyW1ATz+PRwvYU6PIzEFZ2cSt9rn1RG5
        iEaYxrQlMR2BdluebwbE3ulEaAga51pGEQww9lc1MMqowHNNUxArfqW5fNYtotVm0SMyQM
        g1/zPXnvV2GSJAUsqOxPySe1Q+Fp14wKcd8R2z6jjw2260LeIv8L1eitEXlyYdXKcYhxd3
        8xmQCLtVO34rpHDcneDG/KtG2kbQHL71HfXq+963AGqm0RQQSWi/2VAwt9axOA==
Date:   Sat, 7 Jan 2023 16:41:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 20/27] mtd: remove tmio_nand driver
Message-ID: <20230107164102.4e9265da@xps-13>
In-Reply-To: <20230105134622.254560-21-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
        <20230105134622.254560-21-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@kernel.org wrote on Thu,  5 Jan 2023 14:46:15 +0100:

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> With the TMIO MFD drivers gone, the NAND support is also
> obsolete and can be removed.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The patch did no apply as-is, so I did the removal manually while
applying to mtd/next.

Thanks!
Miqu=C3=A8l
