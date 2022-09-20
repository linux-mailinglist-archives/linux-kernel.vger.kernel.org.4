Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBF5BDFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiITIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiITITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:44 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BA65556;
        Tue, 20 Sep 2022 01:16:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61783E001B;
        Tue, 20 Sep 2022 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhe0kx9mZdHekynlKwEdYBZo6jjFfeCj3Xo4r+vAAk0=;
        b=fjh+TfqcsoL0V2uunqIH9zoeATg8xYowmcbSq6+LOPxzGI6RwdD8kFqG0sB4+Lu4/OU7tv
        aUAbUYJpQiO2d1eXAf89f9TOWeMBrFnN9IzjA955g09JC2wBAcJEJg9pQsyXBIVANz1afE
        KWpOEChwIqxAN0UdbDv1CkxYdcLzhE3tOoINokIKkTboQsaCcA+rg+1drbksW4izphQLid
        Rw0i2rWO2AcddjvjA7Gyi1Oia02q4OU9c/P9DmDy2FPey7v8qqrU2N0mNN5ymM3QRRLxqB
        3h+YBK6cS56E+oJqpp3oseLit3rCoiXXLIOhMjzGsvyFtTRKOMj9kZO92x+BVw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 7/8] mtd: rawnand: intel: Remove unused clk_rate member from struct ebu_nand
Date:   Tue, 20 Sep 2022 10:15:58 +0200
Message-Id: <20220920081558.598152-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220702231227.1579176-8-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1b9bdc213cf8a917ad7eeedb39909dd928bd6678'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 23:12:26 UTC, Martin Blumenstingl wrote:
> The clk_rate member from struct ebu_nand is only written but never read.
> Remove this unused and unneeded member.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
