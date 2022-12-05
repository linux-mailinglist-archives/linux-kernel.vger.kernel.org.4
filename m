Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E986642C22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLEPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiLEPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E65A1B9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5058B8113E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E573BC433B5;
        Mon,  5 Dec 2022 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670254991;
        bh=cxX7OqX/cXJwBjusfM54M1kq63daJR6r2DWENROPhRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W70Fqw8zkk+4fTK8lr0LcVwP0d7hjqMTDPrpFw26PozXRH9YJBr/KwB+XSn7HPpBK
         /BN8TZppkiUBSWmZG3dUCbLzLcnxsg9fgdIz6qRHaHM/GksM1cbHGw0zAp3E/C71UO
         qa6DW1v0hsGeZhbHhq7AixdWffAThz7AGFN+QWv3S4/fEB7LRqIE1ITG0AJjuERl4v
         oOfMrcE4B3qyoSMsaciCJWwSX9QUiz72Di2L5PeQcdeZsPbVhLT14K1V6es4bjioOH
         +PU8kmDGfBphV18LccHLP3boebycnE4fGg3OrkL0uT/0yhDfX9dJhudjWyS8AiMM22
         Qk52JyhvmGMxQ==
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] arm64: alternatives: add __init/__initconst to some functions/variables
Date:   Mon,  5 Dec 2022 15:43:03 +0000
Message-Id: <167024802631.265501.9713886317204741032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221202161859.2228-1-jszhang@kernel.org>
References: <20221202161859.2228-1-jszhang@kernel.org>
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

On Sat, 3 Dec 2022 00:18:59 +0800, Jisheng Zhang wrote:
> apply_alternatives_vdso(), __apply_alternatives_multi_stop() and
> kernel_alternatives are not needed after booting, so mark the two
> functions as __init and the var as __initconst.
> 
> 

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64: alternatives: add __init/__initconst to some functions/variables
      https://git.kernel.org/arm64/c/67bc5b2d6d48

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
