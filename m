Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D532174C8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGIWLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 18:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6C120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 15:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE9960C82
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCB8C433C8;
        Sun,  9 Jul 2023 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688940665;
        bh=ma7tEGuHSYjHITgP4MYxB4e0bcIEjw4JgUIHf5e1gJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMcrL1SDsLf7drm4Gah/e2GnvPFqsNogUesvRfa3k0aiElx5gR+GOpmm7VHzNMtLb
         5Jc3nHdUV2zlZevyof/Gwj/31+yNQnXmGiPoM/tjy3NoCkICPc1decBcFN2p9UwBkG
         Q+Vlbo87ZI+ywHFhI3jhP9xYWEd9G832gfjAm7vx64Qb+QOn4q9reRM1nlwt13OGYV
         sqWxAcFcDIzn2AkdTtiz3oEpOJbb0SUZ1vAL5i5t4hU40Smp1YBAK4qbGiwlEmhV12
         Kht+cKbdXX1A0xYcqPdooJvcIKZCl9njWVwxyonCDxeoEg0C2jBsoHLEXR91V6TkVq
         TS6kxGVzFkM7g==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Date:   Sun,  9 Jul 2023 23:10:47 +0100
Message-Id: <20230709-rundown-unsettled-403e8bf5cca5@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=333; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ZqxGtemNh+CFE525qDR8fge9nYf3AFjKNEGQkQg0Cxc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmrDVLXODSpmCZxWGgtcDuaMpO3u8s+eLdZuXhOne1JA dcVPOIdpSwMYhwMsmKKLIm3+1qk1v9x2eHc8xZmDisTyBAGLk4BmIgbO8P/ILYjvUmyKhtq+98t 0YqZbPpVS3L9rAUWllu7PjwVTllbxfA/ipHZ12PvrMINrT0f5WdFfJycesNeievpqszDnYF668I 5AQ==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 25 May 2023 14:18:36 +0800, Jia Jie Ho wrote:
> Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> crypto dma engine.
> 
> 

Applied to riscv-soc-for-next, thanks!

[1/1] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
      https://git.kernel.org/conor/c/1fcaaa1d489c

Thanks,
Conor.
