Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA67305A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjFNRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjFNRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DC13E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2011638A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9723C433C0;
        Wed, 14 Jun 2023 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686762384;
        bh=utdEvYUpXqsQufHduirjZptaosbT7iBSaT04oIEZrB4=;
        h=From:To:Cc:Subject:Date:From;
        b=alv7HhvCb3WZqMW/enyiPr4ngdwS1rtv6z1vKcBRoOD6uoo28XyXL2wsQGEyMWh/d
         dZTOW7IP+SxdtL0DZZkdmPYb2rnu8Siw6IUVzViHZbpRTdTaEtPPzO8B91YzYKfFyZ
         5LVhyo8qSKwjCddIBXhz7p0kQLHrRoMqIfh3jlga35isUoJKH/00nIrqg1KON/mdrv
         Wpxt5BE9F9YZ+NTffx2F8GLMTYImiF5iQmh8NDHaeazzlzjkmsPbueUZB/L0YrObE1
         63qrSDUZbqfGbAs7+1GqMFcn6KaMO9DCH2slAMDwJ/x2HKgDeNWQAzLkQjWnfmqK2P
         +7gGVC6TFtHQA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] riscv: some CMO alternative related clean up
Date:   Thu, 15 Jun 2023 00:55:01 +0800
Message-Id: <20230614165504.532-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists of clean up patches of the "riscv: Reduce
ARCH_KMALLOC_MINALIGN to 8" series[1]. Per Catalin suggestion, I will
submit the enabling of riscv ARCH_KMALLOC_MINALIGN 8 in next
development window. However, the cleanups are good for submitting
now.

PS: Conor's reviewed-by tag is included.

[1] https://lore.kernel.org/linux-riscv/20230526165958.908-1-jszhang@kernel.org/

Jisheng Zhang (3):
  riscv: errata: thead: only set cbom size & noncoherent during boot
  riscv: mm: mark CBO relate initialization funcs as __init
  riscv: mm: mark noncoherent_supported as __ro_after_init

 arch/riscv/errata/thead/errata.c    | 7 +++++--
 arch/riscv/mm/cacheflush.c          | 8 ++++----
 arch/riscv/mm/dma-noncoherent.c     | 2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.40.1

