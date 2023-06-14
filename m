Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5676C7305EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjFNRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjFNRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE626AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04CEE644DB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A85BC433C9;
        Wed, 14 Jun 2023 17:19:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 00/14] arm64/sysreg: Convert TRBE registers to automatic generation
Date:   Wed, 14 Jun 2023 18:19:05 +0100
Message-Id: <168676313901.1670320.10279207705636079324.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614065949.146187-1-anshuman.khandual@arm.com>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 12:29:35 +0530, Anshuman Khandual wrote:
> This series converts TRBE registers to automatic generation, after renaming
> their fields as per the auto-gen tools format. Although the following field
> still renames in arch/arm64/include/asm/sysreg.h, as it cannot be converted
> (shares bits with other fields) in the tools format.
> 
> #define TRBSR_EL1_BSC_MASK		GENMASK(5, 0)
> #define TRBSR_EL1_BSC_SHIFT		0
> 
> [...]

Applied to arm64 (for-next/sysreg), thanks!

[01/14] arm64/sysreg: Rename TRBLIMITR_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/92b1efcd9d9d
[02/14] arm64/sysreg: Rename TRBPTR_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/e01e1737e348
[03/14] arm64/sysreg: Rename TRBBASER_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/90cdde836c43
[04/14] arm64/sysreg: Rename TRBSR_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/7bb948826610
[05/14] arm64/sysreg: Rename TRBMAR_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/b7c3a6eb4d2b
[06/14] arm64/sysreg: Rename TRBTRG_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/dae169fd63f3
[07/14] arm64/sysreg: Rename TRBIDR_EL1 fields per auto-gen tools format
        https://git.kernel.org/arm64/c/f170aa51e6c5
[08/14] arm64/sysreg: Convert TRBLIMITR_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/eee64165a54e
[09/14] arm64/sysreg: Convert TRBPTR_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/6669697733ca
[10/14] arm64/sysreg: Convert TRBBASER_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/cbaf0cf005f0
[11/14] arm64/sysreg: Convert TRBSR_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/46f3a5b01fd7
[12/14] arm64/sysreg: Convert TRBMAR_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/3077b1db9d57
[13/14] arm64/sysreg: Convert TRBTRG_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/a56035c95ec6
[14/14] arm64/sysreg: Convert TRBIDR_EL1 register to automatic generation
        https://git.kernel.org/arm64/c/f0d4627f6459

-- 
Catalin

