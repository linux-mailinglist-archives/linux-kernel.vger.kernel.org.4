Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F496D9CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjDFPwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbjDFPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC734C16
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB4D60E08
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73C3C433EF;
        Thu,  6 Apr 2023 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680796319;
        bh=PvlDGIq5nWRoGB8e4gek8TAf8QIUWmG1TLJtTmkPUpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFuwY/9+epcpAaGOTTJhro0KcoyrlC8dfMS7cajFertrYKorO3Aiw6BMGSfNntcrx
         MwSv+x31XZl6WsareUJsCJcJqTtp9jh0PJ8Cjq660nrKpUYzA58y9I7jU62woyl5Gh
         Bm8l6Grs4RDcQmtJ9RRCi+wMk0qO7U0FVOk2eN/4XgHamodB+uM9YUdmijSFkkiQcQ
         jFAtl+CSszVu+tW0kkxID1rh8STop9QNTlEGyej4+sfLTY7OZGO2UZE28BvhRkE0kn
         l7daFeEOAcLypRSBE6LoGmgzD2q3vk7eEgbOTXBjXcnq/AyKwuIoiEgSm4DU7n+lAc
         tmy86m/2AX76A==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64/sysregs: Generate definitions fine grained traps control registers
Date:   Thu,  6 Apr 2023 16:51:48 +0100
Message-Id: <168079199554.331652.8425095064441880065.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 20:44:52 +0000, Mark Brown wrote:
> This series converts the fine grained traps control registers to
> automatic generation as per DDI0601 2022-12.
> 
> I previously sent this with just the read/write trap registers, there
> have been no changes in that patch since v2.
> 
> Changes in v3:
> - Add HFGITR_EL2.
> Changes in v2:
> - Correct naming of nPIRE0_EL1.
> - Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org
> 
> [...]

Applied first patch to arm64 (for-next/sysreg), thanks!

[1/2] arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic generation
      https://git.kernel.org/arm64/c/cc077e7facbe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
