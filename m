Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818E5BDFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiITIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiITITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A265260;
        Tue, 20 Sep 2022 01:16:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CFE1840006;
        Tue, 20 Sep 2022 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4lJLYtNdnYyxGkQOr2/EKomoBqLaYzUWakFfl52hdZs=;
        b=FtZPgkxfKqhHuH/hHTgESkkTb0Rvid23Lr7g8ftlSnIC8ZbmBWAFV2lKKi8GH/MQ+M5AN1
        u6A3N280Yk8XU3ZvCN9ncAvAcRjyne7rtujGalpc7Xj6w4Gv3+IstML4peVTyLibefuQK9
        xFcq6bienaNUsfe5OvfJ85201Ulu+J9xUAA9IyWm3lrpJITrcJHH1J24qZON9kPRloidjd
        yckV/ATNXtTvKqdq/xiHR/mGodD0dIWM+OqXvrAvYgt8/dZGja3AnzW5JCvI3EzND7ijVQ
        t7J2knbtcEHy3c0t6iT3Rp6wZ1LUzHOyvnCVg42BqN2mLm0lA7cObPRaIVfeug==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 1/8] dt-bindings: mtd: intel: lgm-nand: Fix compatible string
Date:   Tue, 20 Sep 2022 10:16:19 +0200
Message-Id: <20220920081619.598320-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220702231227.1579176-2-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c6d7ce0a7e0562846431dc3c7c390dde7d0c0c42'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 23:12:20 UTC, Martin Blumenstingl wrote:
> The driver which was added at the same time as the dt-bindings uses the
> compatible string "intel,lgm-ebunand". Use the same compatible string
> also in the dt-bindings and rename the bindings file accordingly.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
