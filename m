Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75A5E6D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIVUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIVUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A231210952A;
        Thu, 22 Sep 2022 13:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BAE6226E;
        Thu, 22 Sep 2022 20:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09FBC433B5;
        Thu, 22 Sep 2022 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663878795;
        bh=urcA7+hARfPA3IhXqmBZCx3ulGuq1r3MPqnSKQa3knY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgYxfhemqOxJ5S7W/lKJJ8AlpQ8LIQGDGSse3HuBnrsyPc7EA6vkA1MGBaRmb2QAt
         ZDW3YD2oxQcESWr/vdaefK+anH8CsHMBp9LA7vM4Q33CegiYyltdSdkyX5u+AROl9O
         QHXlQ9aC7YG2PaERFd/FdCh0QrUvTJrHfZsJxopsFjauRhVQ+wLq4QMFBxKoha2sRt
         hiMCXasAUSJ5JSajDuld2zje0l5TZO9c2NaUiH21U4sku2qnMaIbwYQfYvH2308fLY
         m6l1UQv12B/bGpkQxb+UD1+XVQvCzuCAwuEqnpRojDG1Nho1ILdIBw1mSNT7lypeyh
         a3dRyAD72UbHQ==
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com,
        Jonathan Corbet <corbet@lwn.net>, leo.yan@linaro.org,
        broonie@kernel.org, linux-doc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding through SVE functions
Date:   Thu, 22 Sep 2022 21:33:04 +0100
Message-Id: <166385556279.1475166.2989569100449667346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220901132658.1024635-1-james.clark@arm.com>
References: <20220901132658.1024635-1-james.clark@arm.com>
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

On Thu, 1 Sep 2022 14:26:56 +0100, James Clark wrote:
> I'm resubmitting this with a few of the changes suggested by Will on V2.
> 
> I haven't made any changes regarding the open questions about the
> discoverability or saving the new reg and passing to output_sample()
> because I think it's best to be consistent with the implementations on
> other platforms first. I have explained in more detail on v2 [1].
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf: arm64: Add SVE vector granule register to user regs
      https://git.kernel.org/will/c/cbb0c02caf4b
[2/2] arm64/sve: Add Perf extensions documentation
      https://git.kernel.org/will/c/1f2906d1e10a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
