Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCD6C500C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCVQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCVQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:08:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9E2D55
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:07:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 32DC5100003;
        Wed, 22 Mar 2023 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679501276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMNRn5L+CaeB59tcwag0gxW6LL0loCqp1DLAG5DxHE0=;
        b=nOP2Odox8fG1yzMRTLe71QAaBJiw3BMhKjlGTyUZgFKn7I27vSjMlNQnzuiIZ9pyt6tHF8
        CleOUFiD8hWifzswVuB66uveeMSsHCxTlN+indvbCh5QjRAPyAfOJjajU1GWUtL209E6VL
        ZrLDlyE6auMsL08EeABhoeLEVaXgFIVns7HCPJNGN81RbqtJl8IO3oiISXqpP+lA1Tz1W/
        F6GweoMQ6RVffRlizsqEvjg584YqLFiMTHSNqkyq8iicwJLSjRj1Js13kKQQ5ZAcmuelqi
        mLsJens0IkEYRjVuqNy+NXw0paHG78albya8Pv92cAM58HC+3cFvSJiQ2V6AqQ==
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
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling ECC bit
Date:   Wed, 22 Mar 2023 17:07:48 +0100
Message-Id: <20230322160748.2232587-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e732e39ed9929c05fd219035bc9653ba4100d4fa'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 07:32:44 UTC, Arseniy Krasnov wrote:
> 'info_buf' memory is cached and driver polls ECC bit in it. This bit
> is set by the NAND controller. If 'usleep_range()' returns before device
> sets this bit, 'info_buf' will be cached and driver won't see update of
> this bit and will loop forever.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
