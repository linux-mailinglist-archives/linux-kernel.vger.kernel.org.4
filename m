Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59A70B7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjEVIcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjEVIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:32:42 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C38C4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:32:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B8036000A;
        Mon, 22 May 2023 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684744359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYlvJImxQgTxQhmjZrIEOJ5armogn5whwUCqvvp5jX4=;
        b=Ep5L39gD1OohHdKJiXuAWFEm9SlLz6vEw45jLSHd/epvVXYGPxTYPOxbFqXQ2BlVTL1tgv
        urBgRvAEHg8VEx+mPW44udSJ3qdLaitwui6lkucib5xv20Ma5uH8uyhSgEqnkU9vKggFZR
        0EbR4lqbc7nWj4oih5Wm9g9Ryk4+bsHXbMWpWStM1E8ImzfRaYl1Zhe883+XfNufDmPNhe
        YTFaHabbXzwL8OAX7nGtoDivaZoqdJc4eJZJ+gjksA1aSPuXcKmSDCxoyjauWbgNKgcLNy
        0kD5BJKNL1Plq1EiPpQlp2WTYUb8TtsPFNE+0ym/coHvZ3H/Jkso57fi0iFS8w==
Date:   Mon, 22 May 2023 10:32:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix cpu schedule in spin lock
Message-ID: <20230522103238.31e17e5d@xps-13>
In-Reply-To: <20230517033030.3068085-2-xiaoning.wang@nxp.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
        <20230517033030.3068085-2-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

xiaoning.wang@nxp.com wrote on Wed, 17 May 2023 11:30:29 +0800:

> pm_runtime_resume_and_get() may call sleep(). It cannot be used in
> svc_i3c_master_start_xfer_locked(), because it is in a spin lock.
>=20
> Move the pm runtime operations to svc_i3c_master_enqueue_xfer().
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: 05be23ef78f7 ("i3c: master: svc: add runtime pm support")

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
