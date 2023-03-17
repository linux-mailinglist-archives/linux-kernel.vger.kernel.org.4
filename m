Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405776BEC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCQPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjCQPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5493A4EE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E1C601C3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B585C433D2;
        Fri, 17 Mar 2023 15:09:35 +0000 (UTC)
Date:   Fri, 17 Mar 2023 15:09:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] KVM: arm64: hide MOPS from guests
Message-ID: <ZBSCrNxFPwZCEuVR@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-7-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-7-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:08PM +0000, Kristina Martsenko wrote:
> As FEAT_MOPS is not supported in guests yet, hide it from the ID
> registers for guests.
> 
> The MOPS instructions are UNDEFINED in guests as HCRX_EL2.MSCEn is not
> set in HCRX_GUEST_FLAGS, and will take an exception to EL1 if executed.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
