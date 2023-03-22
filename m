Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694B6C5015
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCVQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCVQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:08:28 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A194166C3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:08:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D2991100004;
        Wed, 22 Mar 2023 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679501304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvvMWTp5RgpCN5ryxWKANDiAM7qABSSubTXji+1S0AU=;
        b=i55O9CaO/uaXLS/PDe3k9SigaTYTvafI1j5ZL3XbQgwIm2sls5x3SK5Kxe2fn5c1w7fp7/
        G2aWh1B/Z8UKkjQBEFs9yEdOuJ//ifu1QPK1tEdHLjtJJC5uQahSnnq5598AdT4HvLdRih
        Dy0b5g3YhtKmxeUFfkvolfoIX8+/P6dLq/C9RolhMNZwevj8eQxKH2o98rvNeohpQrUFpw
        XfJkVFWNV8L5g1K34NhJrmXVqY8fEJOt/uOnFfJ3MnkoNXARQzxPNnagGifH6Yj7WFfnG4
        WLz9lqfr9p6lzmNDmlEnNJy2m5gAPPXI1L/aDC4Y+jq/G9+yX3LxkH1Qucfw+Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bang Li <libang.linuxer@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdblock: tolerate corrected bit-flips
Date:   Wed, 22 Mar 2023 17:08:22 +0100
Message-Id: <20230322160822.2232771-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314165653.252673-1-libang.linuxer@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e6b0922a9c614d7689393391325c943b34afd6d4'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-14 at 16:56:53 UTC, Bang Li wrote:
> mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
> particular condition should not be treated like an error.
> 
> Signed-off-by: Bang Li <libang.linuxer@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
