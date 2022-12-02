Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FE640DFA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiLBSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiLBSzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:55:02 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDB3AC1A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:54:57 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670007296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF7YyY0zCO4x691PE+6++2gBpkKD4tpfGa6u+JeBMx4=;
        b=EXkS9mLpz+vLNs65I4j2M/dADkhs3aXj6C2J9/QQBDtzZvHcNqfe16I74H5FqC54X6IZh1
        vDlLk2ztWLvPpDhIQey3K7nj4r9t8dEgpELG+MGppVJXr0vTOFEn8BqpFWmyYmdKr0UKQZ
        7KgvNJRzvcj4Zw0lGfzfhiHCt5vdOM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/3] KVM: arm64: Handle CCSIDR associativity mismatches
Message-ID: <Y4pJ+wnzHv0Rpws+@google.com>
References: <20221201104914.28944-1-akihiko.odaki@daynix.com>
 <867czbmlh1.wl-maz@kernel.org>
 <Y4jyn+aMUGcaa6Ag@google.com>
 <87k03au36k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k03au36k.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:14:43PM +0000, Marc Zyngier wrote:
> On Thu, 01 Dec 2022 18:29:51 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > Could we extend your suggestion about accepting different topologies to
> > effectively tolerate _any_ topology provided by userspace? KVM can
> > default to the virtual topology, but a well-informed userspace could
> > still provide different values to its guest. No point in trying to
> > babyproofing the UAPI further, IMO.
> 
> I think this is *exactly* what I suggested. Any valid topology should
> be able to be restored, as we currently present the VM with any
> topology the host HW may have. This must be preserved.

Ah, I was narrowly reading into the conversation as it relates to the M2
implementation, my bad. SGTM :)

--
Thanks,
Oliver
