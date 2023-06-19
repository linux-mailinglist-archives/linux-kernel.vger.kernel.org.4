Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFD734E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFSInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjFSImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:42:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9855F30FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:40:34 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687163997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hGb2YZ7DaDL82YmuUT/WVIu7xKhRQVFAm/pL2eduPw=;
        b=VTjogFZjdH83/EgvzlAURJbe5U4opCDZXfAjG+RP12Ss1LtyML8r1j5kYZlLP7M96bokyI
        gvIarwBzRUHKqM/5HxHhq1EQq0yHPazePDmcuG6IJmjy/Px3x0QUR/8aG+Ie6pTZqAOicq
        ohvXgW0h8kX0vz5Ui0HW1Opm/7T4bEg/suLpHno103O52/VKtICpPFJelSLmCYM9gDMBLs
        9JV3EbP+5yumSvra+NLC+WGDX2SpoEbTlM4zh4huqlcdJTBdhnMiydgJmyHzL7EA6mPk5A
        9ySqONX4x4aUcPxzEq1wcHsDPqhKsvhchbWsdwUTelFQ1wFx5k6xVP3BQ3mQ1w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37A4BC000B;
        Mon, 19 Jun 2023 08:39:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mtd: rawnand: add support for the Sandisk SDTNQGAMA chip
Date:   Mon, 19 Jun 2023 10:39:55 +0200
Message-Id: <20230619083955.2940578-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <98811c98-4681-6ddc-8287-bd9b77559c51@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a6a8a1e16c14b5c93bec202ba2f1c8d7c9173571'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-13 at 21:21:06 UTC, Johan Jonker wrote:
> Sandisk SDTNQGAMA is a 8GB size, 3.3V 8 bit chip with 16KB page size,
> 1KB write size and 40 bit ecc support
> 
> Co-developed-by: Paweł Jarosz <paweljarosz3691@gmail.com>
> Signed-off-by: Paweł Jarosz <paweljarosz3691@gmail.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
