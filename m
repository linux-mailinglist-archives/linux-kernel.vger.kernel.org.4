Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874F66EF01C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjDZIVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjDZIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C8B10F6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7966344D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC851C433EF;
        Wed, 26 Apr 2023 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682497302;
        bh=wBsk4FApw4J+ZzmkKrlPkYAlUor3sZ3QCsUeu1RWwXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFOd/usXapjAOI7F+BPh09yDx9NNNdUoKsHC+FVEl8lQAhL/1R+TzZUUhVWI+iOcS
         JSBq3Y5TOwH9qZpJUmBUW0zUOm/4mV+mqb/ESebMTW3e2kaP/FXjHKKJZcs+jrWT+v
         jjWLTdsyLqjB5h/c1R32Nzps7v8pMr1pKa1uPjMCyS+3QLVY77zKmR+e15krEqwwNR
         Qp15vmAJQf03tlEUFeZcS3RHW0XJcvsuKkBZxLchkM/KNh0AxnlyaAsQuHKDQB7otg
         6CX0pxcdOXvPEsUuXiFV6kN4NgAu3I3E0tyWsH+iUateUGpb8jRavVFarcdsGBcpAb
         OztOBqnbC5Qng==
From:   Will Deacon <will@kernel.org>
To:     ardb@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        kristina.martsenko@arm.com, broonie@kernel.org,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Fix label placement in record_mmu_state()
Date:   Wed, 26 Apr 2023 09:21:31 +0100
Message-Id: <168249606570.3365922.11261295817566008357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230425095700.22005-1-quic_neeraju@quicinc.com>
References: <20230425095700.22005-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 15:27:00 +0530, Neeraj Upadhyay wrote:
> Fix label so that pre_disable_mmu_workaround() is called
> before clearing sctlr_el1.M.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Fix label placement in record_mmu_state()
      https://git.kernel.org/arm64/c/4e8f6e44bce8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
