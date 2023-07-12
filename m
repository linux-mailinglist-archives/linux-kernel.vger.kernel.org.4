Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23261750A88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGLONr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjGLONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:40 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153B19A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E691FF80B;
        Wed, 12 Jul 2023 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aoe77zogQM/JrZN9fDZ1l1iMzgvgYHaA8MVLV9JAUKk=;
        b=GdyrsJlPFThQRGJTzYM+sokK1vvdoex5J069c3HVdVCnIIwKddwPy7Tuw2PYrKWSDcp60k
        8SMmkgrcG103vgSvMsJ768newar5I0vK+ia8c1Jez01z6UlLj6E+6dQCRJveyqvy5vFaXw
        UmEc3yPS/cdXVbIWJApQdBFJGrGkZzEtWMp6sFNpbRK6dFs5594j6iRHpyUg/poVBDMlMk
        Xb3GdovSUBH0XCSfRvUSmulFHbYWVAYidheRK7Kq86Duu2ScMb4sgf4m7kAWpU8DFbWNrz
        CnodeuM8sHq83ecPUI5HhmEr6mlI6vMqyHg56y6wMchZvf2CHG8E6gsuvNWWfg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] mtd: lantiq-flash: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:34 +0200
Message-Id: <20230712141334.354864-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-14-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6145e07e9c77a99cfe98f10b6544beef8026ce28'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:18 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
