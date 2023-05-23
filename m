Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C170D90F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjEWJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:32:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6494;
        Tue, 23 May 2023 02:32:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 692C81BF208;
        Tue, 23 May 2023 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684834363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9Qn8AqTo/sXg8jlDCBz4izis3PpHn0GZ9QSR6MiR2o=;
        b=nDLTR3vUfrTOLo3EM5MuxyetQ0aQdZJM+Ho1A4w2GfIirH7p4eH4c2TDG/3OEXvma9vKPC
        obbBH7nmZo1SiIwLKlU/noxPyVUnR1SsgXwrP5iRZCGDyCaU7xO/Vk7vWlbnLit0NmV8kV
        m02z5NwwFnxYe40ugcnK7LQmb5c+jb8MwLtLJfdcoV5cUZMb2QnzyuzEauviQLaTcLqw6m
        2ya4z3/LN47E29vcHLvs21LUmJ/zNFLig5VUwQni0fOM8/6P94Hx0DxoYg7aecPc0wmLND
        6dqjmGBlVobsq2X/SZb7YaYswGocBo6i9e+marQku6QRSGtv5Ak72OaDQiwxew==
Date:   Tue, 23 May 2023 11:32:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 22/24] mtd: block2mtd: factor the early block device
 open logic into a helper
Message-ID: <20230523113236.7003c303@xps-13>
In-Reply-To: <20230523074535.249802-23-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
        <20230523074535.249802-23-hch@lst.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

hch@lst.de wrote on Tue, 23 May 2023 09:45:33 +0200:

> Simply add_device a bit by splitting out the cumbersome early boot logic

I guess you meant "Simplify..."

Otherwise lgtm so,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> into a separate helper.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mtd/devices/block2mtd.c | 53 +++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
>=20

Thanks,
Miqu=C3=A8l
