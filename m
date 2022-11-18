Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3B62FE19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiKRTlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiKRTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:40:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC46B17E08
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:40:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BD66275F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17134C433D7;
        Fri, 18 Nov 2022 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800457;
        bh=xiRe4wJsB3h2rq2huV3tdxGloU5tv8YjYEHo+FHNOSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cz6IiXYTCc9TafUq8T3aG1zhhfe/iiEvv/6cMpzu7iUUTdSa8X1ptWHmrlvME1s3P
         jahJ7w7cKYh/Pv9RRcp7KMAhHNh3KP+TS/OuVCz/rCO+Ron4sMvOQBtxu+UzJhqS9u
         TN0vwensVp9n1QOhzCwklQT1+ThnNkRGzm8WokUrNf3vHXQA1TMsKaZkaSHRWPCw7a
         B1P5pBDWI+4Unu/l4nMIMI2Jdur2QKU6McgNGCIoa0akpgHOKLT6vJ+yqv/z8cerjD
         XYhpZqt+9tIPBcEMSKvMPhGB69TfxlzthOgToUwuTu/yiXJlV1N1r3j+1Gf3rmQ0WW
         W3+sb6XG1HeNg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop unused restore_ttbr1
Date:   Fri, 18 Nov 2022 19:40:39 +0000
Message-Id: <166878224542.1786066.13506500051191292958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221117123144.403582-1-anshuman.khandual@arm.com>
References: <20221117123144.403582-1-anshuman.khandual@arm.com>
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

On Thu, 17 Nov 2022 18:01:44 +0530, Anshuman Khandual wrote:
> restore_ttbr1 procedure is not used anywhere, hence just drop it.
> 
> 

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64/mm: Drop unused restore_ttbr1
      https://git.kernel.org/arm64/c/5b468dad6e5c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
