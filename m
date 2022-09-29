Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECE5EFC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiI2RzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiI2Ry6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D45283B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 602FD620E8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 17:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABE6C433D7;
        Thu, 29 Sep 2022 17:54:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
Date:   Thu, 29 Sep 2022 18:54:51 +0100
Message-Id: <166447408706.3004635.13204666295846198645.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921074841.382615-1-rppt@kernel.org>
References: <20220921074841.382615-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 10:48:41 +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> KFENCE requires linear map to be mapped at page granularity, so that it
> is possible to protect/unprotect single pages, just like with
> rodata_full and DEBUG_PAGEALLOC.
> 
> Instead of repating
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: fold check for KFENCE into can_set_direct_map()
      https://git.kernel.org/arm64/c/b9dd04a20f81

-- 
Catalin

