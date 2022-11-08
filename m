Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDE621ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKHRjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiKHRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB751C12
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34797B81BE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80979C433D6;
        Tue,  8 Nov 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929139;
        bh=mqfsf17//0/isn+/08NYUF61MiAk4w+15OSNUwJdrUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSSt7S5aOsKgn8a1phdxK9wMKdROSc9snNrfjs6YLlf0r0U9Jo/JI/zCASw4bPQC6
         HIVDlaEY5lfcy3z5c2g20JrxjzDEUj02IGNd7sh1OQIR2PKLEzVTYewH20Su0Ipgb4
         l+CLCjQl9Q8xdtJQnNgGyJqsxggsSXpXGJXIPjWnROHP/9HlMh0ian7hfBbQFlHSSf
         8Yn6obn6PgplH113YSsRlpTrfeM1yet0bc/EgKBmtS7rWuWrIo/dUH0t6jQLEZTGZv
         MepqA48AdfIQpMlTIsF6F4tZZHVqqH1qAJMREV4ljaQHXRZcX7ITr2DUbOIrbctz52
         ZKfmUFEASUyMw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Adam Langley <agl@google.com>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Enable data independent timing (DIT) in the kernel
Date:   Tue,  8 Nov 2022 17:38:39 +0000
Message-Id: <166791912755.763730.5286516806941074687.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221107172400.1851434-1-ardb@kernel.org>
References: <20221107172400.1851434-1-ardb@kernel.org>
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

On Mon, 7 Nov 2022 18:24:00 +0100, Ard Biesheuvel wrote:
> The ARM architecture revision v8.4 introduces a data independent timing
> control (DIT) which can be set at any exception level, and instructs the
> CPU to avoid optimizations that may result in a correlation between the
> execution time of certain instructions and the value of the data they
> operate on.
> 
> The DIT bit is part of PSTATE, and is therefore context switched as
> usual, given that it becomes part of the saved program state (SPSR) when
> taking an exception. We have also defined a hwcap for DIT, and so user
> space can discover already whether or nor DIT is available. This means
> that, as far as user space is concerned, DIT is wired up and fully
> functional.
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64: Enable data independent timing (DIT) in the kernel
      https://git.kernel.org/arm64/c/01ab991fc0ee 

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
