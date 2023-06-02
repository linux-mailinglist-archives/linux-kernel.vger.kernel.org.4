Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70A720218
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjFBMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjFBMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEA1AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F5D64FE5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42382C433A1;
        Fri,  2 Jun 2023 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709204;
        bh=/O2xZ09FDSgTEYVe9qZzO2dIrEE7abCB2muTMmEKShY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7gwH3D6WMkQyeyMQynO5lxELnAv+Tilg3Gmagwz3v6l2ga8IMxB8JoPg0NhjW0UY
         x4gtWm6XB72YjpjmHFUKQwXxgJJBaBSxw8ZiDDZ69SLrBQlLpQsNNtuI0lDQdfGorG
         S4yMhJ1MfABNknueJMvwOoitMFfLfRMDgQb6P1QNbquCPHj1hcXzsFcg4AcA+FCzt5
         zFElgGB7xjgZpsEpNUNGzShpVdlDF5BMYdLp3BrSs6aNE0ppKGrFu1MYEnKiejLp6a
         YAcpfK9X2ih05VBPeTQzXwGalYiS6G0Tl0XDNRujT4YAjdvyPo3zhSP0oslq64P9Uu
         TdIWwnSMnOnAw==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: pass original fault address to handle_mm_fault() in PER_VMA_LOCK block
Date:   Fri,  2 Jun 2023 13:33:17 +0100
Message-Id: <168570736489.522333.367811133664601205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230524131305.2808-1-jszhang@kernel.org>
References: <20230524131305.2808-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 21:13:05 +0800, Jisheng Zhang wrote:
> When reading the arm64's PER_VMA_LOCK support code, I found a bit
> difference between arm64 and other arch when calling handle_mm_fault()
> during VMA lock-based page fault handling: the fault address is masked
> before passing to handle_mm_fault(). This is also different from the
> usage in mmap_lock-based handling. I think we need to pass the
> original fault address to handle_mm_fault() as we did in
> commit 84c5e23edecd ("arm64: mm: Pass original fault address to
> handle_mm_fault()").
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: pass original fault address to handle_mm_fault() in PER_VMA_LOCK block
      https://git.kernel.org/arm64/c/0e2aba694866

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
