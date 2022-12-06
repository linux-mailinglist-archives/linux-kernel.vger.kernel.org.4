Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10D643EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiLFIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiLFIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:45:08 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56876EE29
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:45:06 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 03866C000F;
        Tue,  6 Dec 2022 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670316304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6cl1rnR3xranXCRqFQ12KKT4gDfqUOI6n42Vu7Vwzs=;
        b=cIX1sS3YAek55j7cj+1xmwnnV+vAU3/SwWh8NEi7Y3XpdNV3pwW6HjiekX8LWO411xIszN
        62xvEsApMcIsAedb0tZtKfsrDKtxDURrnHbyaV2ZhvnAu69sd2VaeiLdMaO9pDiwHxMgDM
        Uq8oEGYrHuKdP4hmC0IyWwK0sGqeNYhVwJ+PfAD/zcJVVzTgwpL2iBvG4rKnjSfu8x9r0C
        sh2j1/YXXgSdlj5DV7aRgwhiJeXKqYNHuzB3GhMMR2vn5/3cWNwdT1GXJy62VWXnvL9ZpE
        3iFE52dofzk1IVgNhxeyRA7uyiwf84DFgC5LagfggR3xfisg3w2x/aENFxdlxQ==
Date:   Tue, 6 Dec 2022 09:44:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vlim <vlim@gigadevice.com>
Cc:     Michael Walle <michael@walle.cc>,
        Victor Lim <victorswlim@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>,
        "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
        "alejandro.carmona@amd.com" <alejandro.carmona@amd.com>
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
Message-ID: <20221206094459.6c581ebb@xps-13>
In-Reply-To: <TY0PR06MB5658CAF1B83FF3CF92846AA0BB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
        <dee37d18f8de5af7d07388031fc08571@walle.cc>
        <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
        <20221206091846.02f6396f@xps-13>
        <TY0PR06MB5658CAF1B83FF3CF92846AA0BB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
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

Hi Vlim,

vlim@gigadevice.com wrote on Tue, 6 Dec 2022 08:27:02 +0000:

> Hi, Michael, Miguel,
>=20
> This is to add many part numbers to the gigadevice.c so that Linux would =
recognize these part numbers during booting up.
>=20
> Can I make one patch for all these part numbers? Only one file is affecte=
d.

Have a look at the diff, if it is not obvious that you are trying to
add a couple of part numbers, then it makes your patch wrongly written.

Thanks,
Miqu=C3=A8l
