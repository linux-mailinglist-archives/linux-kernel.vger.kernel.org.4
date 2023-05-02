Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBA6F4378
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjEBMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBMOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95D1A1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBEA36239B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 12:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED5FC4339C;
        Tue,  2 May 2023 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683029669;
        bh=1/q9oaJWAYbygtI6MSJZSoRteibxjGumOWO5zmMsHt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kd3UlKB22a0pehZAQiRu1e4TD7S46oih6Y87l9cgYt6vuCSvIdvqxNjqfFBcOx7Ds
         Z6M5SBlOp6mHG1M12/Zgm6+VK2KvRhTfGtJ3U3FtOXg4o4SdT6orYGNr7zKp+UQlhw
         aWiRtpxzG6jyvEmVLbO2ZB7fAnuklDE5Few5uWaWTypXm47q0i7wNN/5B4aXN6Rwwh
         FZYGnoXA62uz7YsinSw5AtWxKHphAwY439/yB19RFOQoXKQ6mz4GFeKWsQwMku9yYq
         aIe94QZOS2DFn6vdhY6vRV/KVt4MGACZvCjEducJ9i3BACokzLqEoCVr2UheNkh3WO
         lj41EhaCi17sg==
From:   Will Deacon <will@kernel.org>
To:     ndesaulniers@google.com, Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
Date:   Tue,  2 May 2023 13:14:17 +0100
Message-Id: <168302774320.293982.158903211839566977.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230428-awx-v2-1-b197ffa16edc@google.com>
References: <20230428-awx-v2-1-b197ffa16edc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 11:28:17 -0700, ndesaulniers@google.com wrote:
> commit d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
> modified some of the section assembler directives that declare
> .idmap.text to be SHF_ALLOC instead of
> SHF_ALLOC|SHF_WRITE|SHF_EXECINSTR.
> 
> This patch fixes up the remaining stragglers that were left behind.  Add
> Fixes tag so that this doesn't precede related change in stable.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
      https://git.kernel.org/arm64/c/4df69e0df295

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
