Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE35BD171
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiISPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiISPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:49:47 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D5F596
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:49:45 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F26DBC0002;
        Mon, 19 Sep 2022 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663602584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyaBp6838ZDfWsa9W1Z5xVb9/J72KH642dRAR0XAYyw=;
        b=Enlzk3TVJ17XB1rakvBZFpufkh2s4BRGblIwbMqwP9d5tndm5w22BnlJFNx2uYpxnVNjGX
        B45uTgGS691QzXifS3WcxW3uS+Pcqn+xnxsVae3oj2XPmww0zPr8ePjvWfDbF9NyblI5I3
        NCWRGgjd+zqckqhgMLJI1Iy4Nt/ZNtK8/I95rVrueFVEvC1BBUBBIBcs08XFQnWdMx71Jt
        Uk48i2Uw4NTCkRP9fHk8ZFmfqEcAz3kN0SZ0J8b3eIJcjQBMSJOQ0IAZJ3BrwiICyyImCU
        SYNwXFeWVB14+4qYgl2Irgk/Hi+FHzrNNw3l4Kf0RcSoKtvlGYAJ0YJYxQHS5Q==
Date:   Mon, 19 Sep 2022 17:49:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 02/13] mtd: allow getting MTD device associated with a
 specific DT node
Message-ID: <20220919174942.729e1e4d@xps-13>
In-Reply-To: <20220919174230.59f95ca2@xps-13>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
        <20220916122100.170016-3-srinivas.kandagatla@linaro.org>
        <20220919174230.59f95ca2@xps-13>
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


miquel.raynal@bootlin.com wrote on Mon, 19 Sep 2022 17:42:30 +0200:

> Hi Srinivas,
>=20
> srinivas.kandagatla@linaro.org wrote on Fri, 16 Sep 2022 13:20:49 +0100:
>=20
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > MTD subsystem API allows interacting with MTD devices (e.g. reading,
> > writing, handling bad blocks). So far a random driver could get MTD
> > device only by its name (get_mtd_device_nm()). This change allows
> > getting them also by a DT node.
> >=20
> > This API is required for drivers handling DT defined MTD partitions in a
> > specific way (e.g. U-Boot (sub)partition with environment variables).
> >=20
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org> =20
>=20
> Can you please keep me in Cc for the whole series, otherwise I only
> receive a single patch among 13 and it does not make any sense.

I see just now the "applied, thanks", I eventually remembered what all
this was about, so it's fine.

Thanks,
Miqu=C3=A8l
