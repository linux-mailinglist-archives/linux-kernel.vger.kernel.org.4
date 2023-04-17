Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7966E4C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjDQPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3BF3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8700162521
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931A5C433EF;
        Mon, 17 Apr 2023 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743788;
        bh=EenNM5rlyO67QhwZZbk0khwOfny3tM6/qNjsa8+rwH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c96S8PGY0tuAZ12JvYhBSRbiIkSnsc/500BlPY2CrUUbm/x1iXStlBlMzAJempLu7
         JOMUkZIWkTH7V+X61n+mCtIMWSxKQDM5UchoMDyT0fmvX7hCYhUzKw7MUHPKyY7ow8
         XMFSb57dWggC5k8T4vSMEvdzqfI7eay9xFb3alzjkQ6poPBgO+KFN3EylE9gaX3a4u
         kelroPNbtso/QcjfS8Bje8VbWoLX53OtEKAaRZ4pYGf/xTWrsc2JwBkKQueBqK1NMx
         6pDRvJKpvQxt8pwSuLNU6xcHeouwe7ldPHK9a7Jr170yZ1/aoQ2f2WeaP+vane+xwm
         gkLMiCFcdMgwA==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64/cpufeature: Use macros for ID based matches
Date:   Mon, 17 Apr 2023 16:03:01 +0100
Message-Id: <168173299497.3662080.15394085934941488516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
References: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 18:13:28 +0100, Mark Brown wrote:
> As was recently done for hwcaps convert all the cpufeatures that match
> on ID registers to use helper macros to initialise all the data fields
> that the matching code uses.  The feature table is much less of an eye
> chart than the hwcap tables were so the benefits are less substantial
> but the result is still less verbose and error prone so still seems like
> a win.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/3] arm64/cpufeature: Pull out helper for CPUID register definitions
      https://git.kernel.org/arm64/c/876e3c8efe79
[2/3] arm64/cpufeature: Consistently use symbolic constants for min_field_value
      https://git.kernel.org/arm64/c/21642da214a9
[3/3] arm64/cpufeature: Use helper macro to specify ID register for capabilites
      https://git.kernel.org/arm64/c/863da0bdb17b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
