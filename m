Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120862FE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiKRTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiKRTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E68C4A7;
        Fri, 18 Nov 2022 11:41:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EC97B82505;
        Fri, 18 Nov 2022 19:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FEAC433D6;
        Fri, 18 Nov 2022 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800460;
        bh=RS1lv+FW9z1amfhyPMQoQGhqhEaSIsgx5sWtN3v6S1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlN3L7EA6wJiXKJJXU6MvR46FzDtxduqXi58vaeihXy1ICE2BcaO143y+eRjDX/gE
         YWZ6udX67LZhgefbEKVghYWUvq+wJdxxd3o1xXF0EmJ1q5uJTpO5KqsUq3bJEMZVUt
         A58RXxzqLp9fjIEqLywD1Xi8I1gOCqfxHWsgWKTW1h0bE+9HjSxI5lhaHfpNvsovdq
         IYfRN0ORyldJ0UEPlQw1AyfiwUgV23nPpJ4gIZszZOixkVoHLI+/oohR976NNZJsYq
         7ED7uBGniI2d4KJfnTKWQ9ixpta2G0AHt2wd9o8cxIrlwrDTYdrRUeyHxUz3BPuu/e
         u6H6yYCQ/DJwA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3 0/2] arm64: errata: Workaround Cortex-A715 errata #2645198
Date:   Fri, 18 Nov 2022 19:40:40 +0000
Message-Id: <166879036104.4045194.6085821745248609037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116140915.356601-1-anshuman.khandual@arm.com>
References: <20221116140915.356601-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 19:39:13 +0530, Anshuman Khandual wrote:
> This series adds Cortex-A715 partnumber and workarounds the errata #2645198
> which gets triggered when an userspace page mapping permission changes from
> executable to non-executable, corrupting both ESR_EL1/FAR_EL1 registers
> when an instruction abort is taken.
> 
> This series applies on v6.1-rc5.
> 
> [...]

Applied to arm64 (for-next/errata), thanks!

[1/2] arm64: Add Cortex-715 CPU part definition
      https://git.kernel.org/arm64/c/07e39e60bbf0
[2/2] arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption
      https://git.kernel.org/arm64/c/44ecda71fd8a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
