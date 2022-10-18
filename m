Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD86027E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiJRJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJRJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:40 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071119011
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E4EB240007;
        Tue, 18 Oct 2022 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcNEHm3uRroE+9KMi+2SaJ1+7JpYDEKgO9FYj1dRJ1A=;
        b=CQf0pO15PlAwGKEVET3hbZBNhHeRQXs5H9L5mvp7Tp/OnwotdCGRRz7G3kIh6ixxKoIwlB
        /ABGYGYWZW6X1mbBYD7nw2yuE7531sc1mojak+ZoLM5zQoTnbXHx0LkLqxSvYibdRe42/d
        truulu45a51o24pPGVc4fX8hqSi04wgEHhCCjuny2AptkxaSybCMRVzoYn6oYgUdq1qWqg
        JoLTARSTRcYkQ122G5G6MhInwQ6fwjYGCBaY2BEhIDTh97N46ZCjHPELZMeEAoq4zPV0bQ
        bmpektX/8QIIFDDFhVagepIJfZrADB+pA7CkYIxncv7qvi0Mj2+KYgPu8E4D4w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: rawnand: lpc32xx_mlc: switch to using gpiod API
Date:   Tue, 18 Oct 2022 11:04:22 +0200
Message-Id: <20221018090422.466352-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928230019.2140896-1-dmitry.torokhov@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'782e32a990d9d7029a8400f09a4d02b1ba78cb77'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 23:00:18 UTC, Dmitry Torokhov wrote:
> This switches the driver from legacy gpio API to a newer gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
