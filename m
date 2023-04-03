Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E86D4CED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjDCP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjDCP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:59:29 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D313A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:59:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 08001100005;
        Mon,  3 Apr 2023 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680537553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dp03hIsI/cteiZu/GdKKxTFMnCgcRr2K9r6OCmhzmao=;
        b=RkfJH0jxjTJbojxm6hZEW6QIsItd/M0lbu7oquAWovMfXF9HWSz/5twP19Fqk7EjCBQ4ex
        ppeyUMt7OQYwMYGw2k/vXXASwwhJnarKdxskLhF52jJI+SIbfzCsT5UfNkeOot9CckPMgB
        mRo7UC81lpN01Qm/PiNwGZOkGWzvEGGXtHItWWZRNPLqz1Ftinkj+euD1TGXzpEALwdmwZ
        KP9hb2nWnneCreUVmeGwcrZ6E6mtx80rlmUL5ktn4AKjXD8YlpcCTDe14ip10pEa3zCIUS
        iiFdnId9tEyAcW3dGgWiK2lVIF4extNt8sxnzhstwEiFCUzLVf3WekTfABZqXQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v2] mtd: rawnand: meson: fix bitmask for length in command word
Date:   Mon,  3 Apr 2023 17:59:08 +0200
Message-Id: <20230403155908.137562-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3794ffbf-dfea-e96f-1f97-fe235b005e19@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'93942b70461574ca7fc3d91494ca89b16a4c64c7'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-29 at 07:47:26 UTC, Arseniy Krasnov wrote:
> Valid mask is 0x3FFF, without this patch the following problems were
> found:
> 
> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
>                   bit-wise majority to recover it
>    [    0.947384] ONFI parameter recovery failed, aborting
> 
> 2) Read with disabled ECC mode was broken.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
