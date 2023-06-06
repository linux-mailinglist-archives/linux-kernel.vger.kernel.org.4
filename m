Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA10724A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbjFFRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjFFRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914D171C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6130963620
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2389C4339B;
        Tue,  6 Jun 2023 17:30:42 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH v2 0/7] arm64/sysreg: More conversions to automatic generation
Date:   Tue,  6 Jun 2023 18:30:41 +0100
Message-Id: <168607263650.1438384.7012874887740689575.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
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

On Tue, 23 May 2023 19:36:58 +0100, Mark Brown wrote:
> Continue working through the register defintions, converting them to
> automatic generation.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/7] arm64/sysreg: Convert MDCCINT_EL1 to automatic register generation
      https://git.kernel.org/arm64/c/3def3387f755
[2/7] arm64/sysreg: Convert MDSCR_EL1 to automatic register generation
      https://git.kernel.org/arm64/c/103b88427bc5
[3/7] arm64/sysreg: Standardise naming of bitfield constants in OSL[AS]R_EL1
      https://git.kernel.org/arm64/c/187de7c2aad8
[4/7] arm64/sysreg: Convert OSLAR_EL1 to automatic generation
      https://git.kernel.org/arm64/c/31d504fce595
[5/7] arm64/sysreg: Convert OSDTRRX_EL1 to automatic generation
      https://git.kernel.org/arm64/c/7b416a162229
[6/7] arm64/sysreg: Convert OSDTRTX_EL1 to automatic generation
      https://git.kernel.org/arm64/c/42383388758a
[7/7] arm64/sysreg: Convert OSECCR_EL1 to automatic generation
      https://git.kernel.org/arm64/c/175cea665877

-- 
Catalin

