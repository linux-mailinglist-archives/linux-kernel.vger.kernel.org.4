Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEF6DFA77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDLPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDLPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7856193D6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F55361093
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CD3C433EF;
        Wed, 12 Apr 2023 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681314012;
        bh=SOZnI39cwRQjTGxNKArn1UZA26sCfIsiiea1FTr6vqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crKJkqwG9Pw7VKspen3kDqck2/7ZRzWD3O5gaTkRDyR3fXol/vNwZSDQab1WgnPuO
         goD5hOkP6rtS2bftHwsPI0RhN9cCHOgg0QTB7dPx7H/Y85Nm+wj45SON2YwXsw5j1i
         m9Sdw/c4NiMglVr4QkvMtF5r8y7G6KipPErfL61aQ5dAYGB6Lj9guPBwuRs21R+PJN
         +6+Pu4RL9sD1iJthwrTKIy/1h1t1T0gJ/KAB/47zsvK/k7Y/8KZHTOt2fUjZ5EXWMe
         wgX90uDxlV7PfnmjqKleiih8e+fNJDuSoAVr8AyjCPwj8pUHL2c0JMSExSak/NXeZF
         krTgCrOIW+sRQ==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, broonie@kernel.org,
        Dongxu Sun <sundongxu3@huawei.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] arm64: Use specific checking for TPIDR2 and some comments update
Date:   Wed, 12 Apr 2023 16:40:07 +0100
Message-Id: <168128890996.2435369.17923143228760096259.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230317124915.1263-1-sundongxu3@huawei.com>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 20:49:11 +0800, Dongxu Sun wrote:
> We should use system_supports_tpidr2() for TPIDR2 handling.
> And this series update some comments for sigcontext and ARM SME.
> 
> Dongxu Sun (4):
>   arm64/signal: Use system_supports_tpidr2() to check TPIDR2
>   arm64/signal: Alloc tpidr2 sigframe after checking
>     system_supports_tpidr2()
>   arm64/signal: Add tpidr2/za/zt sigframe size in comment
>   arm64/sme: Fix some comments of ARM SME
> 
> [...]

Applied patches 1, 2 and 4 to arm64 (for-next/misc), thanks!

[1/4] arm64/signal: Use system_supports_tpidr2() to check TPIDR2
      https://git.kernel.org/arm64/c/e9d14f3f3fb7
[2/4] arm64/signal: Alloc tpidr2 sigframe after checking system_supports_tpidr2()
      https://git.kernel.org/arm64/c/19e99e7d59bc
[4/4] arm64/sme: Fix some comments of ARM SME
      https://git.kernel.org/arm64/c/97b5576b0116

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
