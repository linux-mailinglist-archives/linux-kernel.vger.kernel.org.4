Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B16CC214
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjC1OcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjC1OcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:32:03 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F794BB8F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:32:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A90F2000D;
        Tue, 28 Mar 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680013919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJsUxV1GCYJmepMN7qDxXfeGUt0LBtGmEOWRiNNJIVU=;
        b=CL/4ceslVvnWZODI6nvZVXQHAY6b1WfBFDeXLjcRMvSadFLxWx4Wh/E5ns043wxzQNLMqP
        2cuXRtayeY2QO3fczgGf4U4sn1+VGHSHHaoE4+r/7GUlTMA+nx+F1Oh4Usa+9Bkg9E+DMY
        pZw0VVSEn1mFamQaJpqUQfWivO5uYjeGfFxCj+3WPMq5uChFf+HBUmEmz0peuMi5vNscLO
        Mh0xIs/oFPfJ4VriKptstPt/MbdNiPE6gTbU5sOtOo57Q73mW0LUFSowqDHdn/V04Smswu
        8eA6LDOvrdqClOFsScPmiqLTd4wrmQG6O+GsCvPSAaxdH6Ze/9t/mokv4v+M8Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        krzysztof.kozlowski@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] mtd: rawnand: stm32_fmc2: depends on ARCH_STM32 instead of MACH_STM32MP157
Date:   Tue, 28 Mar 2023 16:31:56 +0200
Message-Id: <20230328143156.441625-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324155105.826063-3-christophe.kerello@foss.st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bb685c1f35c357e9b935880b2946b402d6860ee0'
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

On Fri, 2023-03-24 at 15:51:05 UTC, Christophe Kerello wrote:
> To be able to compile the driver on all STM32MP SOCs, we move the
> "depends on" on ARCH_STM32.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
