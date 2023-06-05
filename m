Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EB722BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFEPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjFEPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:13 -0400
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [IPv6:2001:41d0:203:375::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E4E40
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:45:45 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685979914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5LUtWzKmYjDV4nZKzC4q3Djt7pncEjD8QMEpJ4KCyA=;
        b=R5NBp7zZ7fiJGgGmahE2wkbha2vpqQfOgtOabW8PjJwXnaosJWHnULmmToS920oLU0j9ES
        DEOKTJK+7rtQvtvhIS3UP4Pj6JgDkZg65I4gS+iTsOdBUr0TzShGEMUXB+AAhDzMXFGjzv
        WQrK4vu1z4npD7q+hvPMu+N8pqIR9cs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] KVM: arm64: hide MOPS from guests
Message-ID: <ZH4DBoFv2CkoxFmX@linux.dev>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-7-kristina.martsenko@arm.com>
 <87ttvpndhx.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttvpndhx.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 09:42:18AM +0100, Marc Zyngier wrote:
> On Tue, 09 May 2023 15:22:30 +0100,
> Kristina Martsenko <kristina.martsenko@arm.com> wrote:
> > 
> > As FEAT_MOPS is not supported in guests yet, hide it from the ID
> > registers for guests.
> > 
> > The MOPS instructions are UNDEFINED in guests as HCRX_EL2.MSCEn is not
> > set in HCRX_GUEST_FLAGS, and will take an exception to EL1 if executed.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> This is very likely to clash with Jing's series that completely
> reworks the whole idreg series, but as long as this is on its own
> branch, we can deal with that.

Yup, we will definitely want to get that ironed out. I'll pull Catalin's
branch when this all gets queued up.

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver
