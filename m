Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB868C449
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBFRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBFRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:11:32 -0500
Received: from out-133.mta0.migadu.com (out-133.mta0.migadu.com [91.218.175.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2ED298FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:11:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=armcNc6KFMbkE4Jo9laBBFL+ptwPVauwQbZCWayn/8c=;
        b=NpBlqveckIMXyx3Lwkj+vADx4sDcp+mmPvHru6FEie7iAwHJQjKfikGQbGs5XiHs7bFPLF
        xdL6kfqrRq2a271R+EYuhC/OC4g8hK7KLe9H56yPCt1XC+7FWMUhDo1LS9cwzmTDKQJlbQ
        renU7mDUCgppcrswaH8HTjR1J5EYOdw=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] irqchip/apple-aic: Correctly map the vgic maintenance interrupt
Date:   Mon,  6 Feb 2023 17:11:22 +0000
Message-Id: <167570346270.3822233.7990679414480648662.b4-ty@linux.dev>
In-Reply-To: <20230201164056.669509-1-maz@kernel.org>
References: <20230201164056.669509-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 16:40:56 +0000, Marc Zyngier wrote:
> We currently allocate the vgic maintenance interrupt by calling into
> the low-level irqdomain code. Not only this is unnecessary, but this
> is also pretty wrong: we end-up skipping a bunch of irqdesc state
> setup
> 
> A simple "cat /proc/interrupt" shows how wrong we are, as the
> interrupt appears as "Edge" instead of "Level".
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] irqchip/apple-aic: Correctly map the vgic maintenance interrupt
      https://git.kernel.org/kvmarm/kvmarm/c/ad818e6010ef

--
Best,
Oliver
