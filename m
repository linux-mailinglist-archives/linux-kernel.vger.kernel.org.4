Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A56605F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjAFRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjAFRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280A1A1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4565961EFE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5691EC433D2;
        Fri,  6 Jan 2023 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027446;
        bh=tET+i312I7vgtoiLpfEfjAE5lEdjkhoXZCa+piE6+q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMk6mtjG41oP3ZQNRWwavT9jasuiNT89XiFMsStm7Vragms8lvTGUzEcz04bOFNLX
         tp6ILOR/43vheohfSSAHzoF02UEH9JW9Ee1FKwcbemDaRWVaT4vu6eLoOrDoFx0LJQ
         Nb0cMZ8p5lxCVlSFwZvUBDiKkbXb9OQz04MVh3PTXWRTmahEr+cLPNg8iJJu0e9sGH
         bE/dBr5gkCYY2cQGgJqVLlY28Pl2m0TPDErI5QTawO0vOAIXT0jBfk9QOi9NVAFeA2
         nJibKQgtTPK5iG9CwGGFYxF71fLvEJLGbrFOT95tEhFAL7h2qs4n/H1TGOSh9zFeVd
         /tbCuiqCPu1Ow==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] firmware/psci: Don't register with debugfs if PSCI isn't available
Date:   Fri,  6 Jan 2023 17:50:36 +0000
Message-Id: <167302518922.215165.14813774923377153099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230105090834.630238-1-maz@kernel.org>
References: <20230105090834.630238-1-maz@kernel.org>
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

On Thu, 5 Jan 2023 09:08:34 +0000, Marc Zyngier wrote:
> Contrary to popular belief, PSCI is not a universal property of an
> ARM/arm64 system. There is a garden variety of systems out there
> that don't (or even cannot) implement it.
> 
> I'm the first one deplore such a situation, but hey...
> 
> On such systems, a "cat /sys/kernel/debug/psci" results in
> fireworks, as no invocation callback is registered.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] firmware/psci: Don't register with debugfs if PSCI isn't available
      https://git.kernel.org/arm64/c/cef139299fd8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
