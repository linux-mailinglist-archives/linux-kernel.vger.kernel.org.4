Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB1738A21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjFUPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFUPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578DBC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE166159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FBFC433C0;
        Wed, 21 Jun 2023 15:51:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, chris@zankel.net, jcmvbkbc@gmail.com,
        steven.price@arm.com, vincenzo.frascino@arm.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        jeeheng.sia@starfivetech.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH V2 0/4] Remove WARN_ON in save_processor_state
Date:   Wed, 21 Jun 2023 16:51:43 +0100
Message-Id: <168736259084.605458.4732376069158804322.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023 15:50:45 +0800, Song Shuai wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
> 
> In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
> is not defined, but the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
> We also don't have to check it in save_processor_state.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

I couldn't tell whether this series would go in as a whole but given
that the patches are independent, I picked up the arm64 one.

[2/4] arm64: hibernate: remove WARN_ON in save_processor_state
      https://git.kernel.org/arm64/c/615af0021a61

-- 
Catalin

