Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A562CFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKQAnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKQAnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:43:35 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEEBDFD1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:43:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 00:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668645812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1yq7+HlMjVk7Mh1lF9aHzv9fMnW5d57Fj9ITz0qudw=;
        b=VKj6EkJlmRwJ/R9BSNln/48AvN39ZRzjnnqQut2Sebkl98iH4xYuh1yWwPrN5/Ljyxyoo5
        8OELoe35KKjnxshX7VpbR8bk/n97tA5ti5e2q/DThvPqFdjgNukfU1YQj0258KD+EKQht/
        ZjjLqjPgqwbDvsAz1xMWCU42Ooo50bE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 1/2] KVM: arm64: selftests: Disable single-step with
 correct KVM define
Message-ID: <Y3WDsIp6Jk5dVg0n@google.com>
References: <20221117002350.2178351-1-seanjc@google.com>
 <20221117002350.2178351-2-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117002350.2178351-2-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:23:49AM +0000, Sean Christopherson wrote:
> Disable single-step by setting debug.control to KVM_GUESTDBG_ENABLE,
> not to SINGLE_STEP_DISABLE.  The latter is an arbitrary test enum that
> just happens to have the same value as KVM_GUESTDBG_ENABLE, and so
> effectively disables single-step debug.
> 
> No functional change intended.
> 
> Cc: Reiji Watanabe <reijiw@google.com>
> Fixes: b18e4d4aebdd ("KVM: arm64: selftests: Add a test case for KVM_GUESTDBG_SINGLESTEP")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

--
Thanks,
Oliver
