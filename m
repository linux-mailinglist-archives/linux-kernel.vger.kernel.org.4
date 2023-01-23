Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEA6787BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjAWU2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjAWU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:27:50 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663B26AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:27:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674505668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptopzaIr3YmZ/jpKKhYwyqWy8pmjYpRDY1paJTvdAEU=;
        b=fQrKEQXy3DMKiZgO6ZL0sDHVPNIuNZI/BwkvJwLVjzk2lq64ILx2tN+7QLtT8fumdDmjlM
        sJPXYvqMUqAe55xZY4AYbRHpNxQvBum/428M1wdSXjd4um0SI6cdZBt2d2QEG96r5qFhCv
        Cy9H7UoP50tYu31MYig/bjWPiCp+osE=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        asahi@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] KVM: arm64: M2 vgic maintenance interrupt rework pre-NV
Date:   Mon, 23 Jan 2023 20:27:33 +0000
Message-Id: <167450413533.2570626.8104319764447216703.b4-ty@linux.dev>
In-Reply-To: <20230103095022.3230946-1-maz@kernel.org>
References: <20230103095022.3230946-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 09:50:19 +0000, Marc Zyngier wrote:
> I've spent the holiday break reviving the Nested Virt KVM/arm64
> implementation[1] and allowing it to work on the Apple M2 SoC. The
> amusing part is that it actually works!
> 
> However, the way the vgic is implemented on this HW is still at odds
> with the rest of the architecture, and requires some hacks, some of
> which are independent of the actual NV code. This is what this series
> is about.
> 
> [...]

Applied to kvmarm/next, thanks!

[2/3] KVM: arm64: vgic: Allow registration of a non-maskable maintenance interrupt
      https://git.kernel.org/kvmarm/kvmarm/c/43c5c868bddc
[3/3] irqchip/apple-aic: Register vgic maintenance interrupt with KVM
      https://git.kernel.org/kvmarm/kvmarm/c/13aad0c00bb1

--
Best,
Oliver
