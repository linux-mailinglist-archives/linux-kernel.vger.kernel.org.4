Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DF72E2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbjFMMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242066AbjFMMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:16:26 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373410C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:16:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686658583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBZSAkJAmjdtGZukyV0Gel5hklORumrE8fQLoKUpCwU=;
        b=sFCltlm5AhnbFv4QFXD/QC5q7yMPfKrNOErbqYwG6Xy7f+NkHWrjtmVA7STa65u6PGvw/s
        xJMDtoRZhHsT9hIvRbJlaNw/SHRa0ElwjULMihHNChia3ft70gTF0gR55TWVLmm8yEVS23
        h2ClNu/t8BNLU53ZLQcNBdNTYMvkhB8=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mostafa Saleh <smostafa@google.com>, kvmarm@lists.linux.dev,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oliver Upton <oliver.upton@linux.dev>, suzuki.poulose@arm.com,
        kaleshsingh@google.com, tabba@google.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys for pKVM
Date:   Tue, 13 Jun 2023 12:16:02 +0000
Message-ID: <168665854178.2681974.13725664134174024912.b4-ty@linux.dev>
In-Reply-To: <20230516141531.791492-1-smostafa@google.com>
References: <20230516141531.791492-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 14:15:31 +0000, Mostafa Saleh wrote:
> When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> uses Armv8.3-Pauth for return address protection for the kernel code
> including nvhe code in EL2.
> 
> Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> fine for nvhe but not when running in protected mode(pKVM) as the host
> can't be trusted.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: arm64: Use different pointer authentication keys for pKVM
      https://git.kernel.org/kvmarm/kvmarm/c/fb737685beee

--
Best,
Oliver
