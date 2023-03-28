Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4316CBFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjC1M4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjC1M4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:56:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EEB107
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:56:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98BB960003;
        Tue, 28 Mar 2023 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680008202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSlLQghHIFL3M5xh3xr1rj4t1TXCqa427YGaNbcDRjM=;
        b=XD+Bokt0186NupiJEabVssWUp8xwPGcTAcJC7SuuKWFoA0dHZ0FhVxKIg8nRLHIrXsaqLj
        1Qrq0LaY15Fr/ZdMTcitYaVBRbQ08mJOClcm1kod5m1reV96Gn3zUll+nvwxI6vrCQ2Tzl
        C/j/kSsbJlS0bqhpHmr2aEDyCFGTJsGw4HvmQfrXH2mWfn12jLXrsMM+4o3sa87EDM1JRj
        aG3Cp9eTRCZSGydhbxs2396AwHgvD5ejAndoUl+DVFYXcTPWMcQV1pZNbsUB+Jv8jpmObj
        M2kSMaHFCaI9AD3s9wv0xeE8HIXynn5YMOi27iFlMubK5lblSlXbJugvJg0CkA==
Date:   Tue, 28 Mar 2023 14:56:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Chuanhong Guo <gch981213@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Felix Matouschek <felix@matouschek.org>, <kernel@kempniu.pl>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
Subject: Re: [PATCH v3] mtd: spinand: add support for ESMT F50x1G41LB
Message-ID: <20230328145639.1aef44e2@xps-13>
In-Reply-To: <20230322151625.791131-1-mmkurbanov@sberdevices.ru>
References: <20230322151625.791131-1-mmkurbanov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@sberdevices.ru wrote on Wed, 22 Mar 2023 18:16:25 +0300:

> From: Chuanhong Guo <gch981213@gmail.com>
>=20
> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.

I was about to merge this patch but it turns out there are conflicts in
the tree. Can you please rebase on top of nand/next and send a v4?

>=20
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

Thanks,
Miqu=C3=A8l
