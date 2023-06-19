Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC5734E38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFSIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFSInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:43:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC234204
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:41:08 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687163988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBpU7AIkXRCDEn5VIdJgj1KNTfxQfZBfQc11JlGsmGk=;
        b=hq9KsprMfBHZ32nc9FYq8mjIBs/pOX/FM44ns3HbKPfWcmykAKM3SOURVVmsj2MQmKSsnJ
        hN7pMjGrlj82CRW31mIT8IIHdCTMEx9exyobhjshjrez+F/ZLjSuEH2EGk3RGAt0ccCCLg
        Y92GMpDtHUvhgSmSSqCIJQGph0Pya+r/NXh93LsDaLTVxeUGDrt/UnmFTZLNjwlujnqOEP
        PZauLzsdWvln7F/Stf1MlK/9c0jbNZhBOTxUF/XI4UdOVzygQwaqmXYY4A5/xBMem5sDPZ
        e8y+dmDhsHEUxFGZX++hHX1TsLZlqJ6NFTr4YulspkKRyjKq2vZjcu7FXB8vUw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF563240014;
        Mon, 19 Jun 2023 08:39:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jaime Liao <jaimeliao.tw@gmail.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Date:   Mon, 19 Jun 2023 10:39:46 +0200
Message-Id: <20230619083946.2940494-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615094015.3780078-1-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e87161321a4081d36c4af95af7f0950137569dfe'
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

On Thu, 2023-06-15 at 09:40:06 UTC, Arseniy Krasnov wrote:
> Support for OTP area access on MX30LFxG18AC chip series.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
