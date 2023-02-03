Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9ED68A150
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjBCSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjBCSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:10:46 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F24918AF;
        Fri,  3 Feb 2023 10:10:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19BAAFF805;
        Fri,  3 Feb 2023 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675447843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bjPh0iT94QVZCkysZQQHnFLioRTLBYvi144JTODXNU=;
        b=XhDkeWUlEurhZ3Bgl+5msyAWrbPKfkj3YTYEnmQLMeVYVWdU5m6CKF7q3531ClOozMraox
        HUAr/RAHLitM46YO2BSWtH+lIbL2yWIQjAQYvF8vtpuCEthQk/mjToEbJ0mwtZruv9q6th
        KoImtBb7r6XfuhLTdzENxcsC9lRcLUf4nTfVtKGfEiyhSz1+mp/RJHPJV/vQdG/ojbts+G
        y/mBMCjwvBe9gVAvX0pGzfuVUlhkte9YcvMSleuAlo8MOyNYJQO1MzvSktgG4s4sZHkOI8
        4+z42D78om4UtgsLdXkboKguxmJHFHkqDwUenexArPJb6bUimaXbAh0/5cwxOg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        benliang.zhao@mediatek.com, bin.zhang@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: mtd: Split ECC engine with rawnand controller
Date:   Fri,  3 Feb 2023 19:10:39 +0100
Message-Id: <20230203181039.436352-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201021500.26769-2-xiangsheng.hou@mediatek.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3af7ade257649d8e2e17eae96422b7868ed215a8'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-01 at 02:14:56 UTC, Xiangsheng Hou wrote:
> Split MediaTek ECC engine with rawnand controller and convert to
> YAML schema.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reported-by: kernel test robot <lkp@intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
