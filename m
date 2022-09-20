Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0405BE031
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiITIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiITIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:33:34 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D43CE1E;
        Tue, 20 Sep 2022 01:33:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ABABA2000D;
        Tue, 20 Sep 2022 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CV8RRbNvkUpFnsCo59JCiSq0IUT9sDhM+Ha7hqQT4Cw=;
        b=A8j5LZyLw1iRMxlgBWdc/Mb92p7NEELS3QYTgYX2i4MvquxEuINMCDOLdTs7rZItXi+j6B
        UDwe9KiMbQTPqcTHaGnYBVAxRW6U81E7rLhLuHl0kZfldjKMMTYYTCbejGWj/bSDBiTIUb
        qCTTdPxH9VA/qB4bz0N8npkRF6O1PSSgQHJUR50fZzFYSj+bo4UM56OJR6w9u63yZF/3oT
        ASE6BU2jrEYN4nR1B9lHRajAvy4y9SNtPcdectpLHos5FRYybSbRikgaS8U7qyrdubvWfI
        pxUfwVTJf18JIQwOSjhJ2HSztc2LqSPeuKRzLUYMbDUPTrV6i25EZZ9rB+5hFQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 3/5] mtd: rawnand: meson: refine resource getting in probe
Date:   Tue, 20 Sep 2022 10:33:21 +0200
Message-Id: <20220920083321.600926-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907080405.28240-4-liang.yang@amlogic.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cca5eedd2a5747bc626e4ab8e560a657cd559e8d'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-07 at 08:04:03 UTC, Liang Yang wrote:
> simply use devm_platform_ioremap_resource_byname() instead of two steps:
> res = platform_get_resource(pdev, IORESOURCE_MEM, 0) and
> reg_base = devm_ioremap_resource(dev, res)
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
