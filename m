Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB6722B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjFEPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjFEPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:42:26 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [IPv6:2001:41d0:203:375::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2331B1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:42:03 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685979719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vE3qz2IJG9FXtMC5do8DKxh24CXgTlhxDJppkemDRI=;
        b=PwIscskWzGW+xkGcfpDemDLACxtF5hKhwrcMhCP1iDbpL8o2YScovP64XLDLuZJNAN3598
        EDTiJB93XKt1zo8Vti55c2XI4cLsHunuwDx4e78MoJIwszv8oM1w4IEpsJIe/KT69I7x6v
        O9oqY7WzxnY2TtyL2bnTm624zUao3EM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] KVM: arm64: switch HCRX_EL2 between host and
 guest
Message-ID: <ZH4CQhZLdJy4wVni@linux.dev>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-4-kristina.martsenko@arm.com>
 <ZHnz+Tgx8uHp5qmC@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnz+Tgx8uHp5qmC@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:51:53PM +0100, Catalin Marinas wrote:
> On Tue, May 09, 2023 at 03:22:27PM +0100, Kristina Martsenko wrote:
> > Switch the HCRX_EL2 register between host and guest configurations, in
> > order to enable different features in the host and guest.
> > 
> > Now that there are separate guest flags, we can also remove SMPME from
> > the host flags, as SMPME is used for virtualizing SME priorities and has
> > no use in the host.
> > 
> > Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> Same here, it could be good to have Marc/Oliver look at this.

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver
