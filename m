Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B9734E32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFSInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFSIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:42:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEF3592
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:40:37 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687164000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQcdAg+9N3g/DyKINT36JlTRkES83NJEq82KHSe5Lvk=;
        b=EMcXEylTKwEflbWeK+AF+2aYNmR+/NaagE5XJMsNxCohYhwczhY/bxI1SpnOHOju8qyOhb
        /l+vPaELW3N+8eoI9NnuIVGH06j+iqtRREtqLEfQObnNGF8KkaTxvMKpbsOR1t4oQ1Le6v
        XAKFhm4jfag4aTKBiODVHJPOEmFwyXOpcPDR89A4/4EUZyMSqiJCWhV0YQ1FzV/qg/8t+B
        XdK1l6UjIgwAY5i3mbkTHSYDaw6QmuW8B+B7yyd5gs9On9qnP7sB7v9kMIQD0uKdeMZeEo
        1i09QAX34SxHPODhDgCcW4bY15Tpc77qFUIp6P8qkq+4adGyTKmZu410e5if0A==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9749120018;
        Mon, 19 Jun 2023 08:39:59 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: rawnand: add basic sandisk manufacturer ops
Date:   Mon, 19 Jun 2023 10:39:59 +0200
Message-Id: <20230619083959.2943156-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aaf4580a-a368-8f70-c9c4-21b5ed4dd599@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'12ac188b9355618dbaa892eb795f48845cf7b1af'
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

On Tue, 2023-06-13 at 21:19:58 UTC, Johan Jonker wrote:
> Add basic Sandisk manufacturer ops support to get
> SDTNQGAMA timing data with the nand_get_sdr_timings()
> function.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
