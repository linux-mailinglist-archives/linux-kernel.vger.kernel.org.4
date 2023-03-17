Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1F56BEDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjCQQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCQQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBF67713
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0616960B39
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B87EC433EF;
        Fri, 17 Mar 2023 16:04:14 +0000 (UTC)
Date:   Fri, 17 Mar 2023 16:04:12 +0000
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
Subject: Re: [PATCH 10/10] arm64: mops: allow disabling MOPS from the kernel
 command line
Message-ID: <ZBSPfBvvH8yfyiP7@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-11-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-11-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:12PM +0000, Kristina Martsenko wrote:
> Make it possible to disable the MOPS extension at runtime using the
> kernel command line. This can be useful for testing or working around
> hardware issues.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Yeah, I think that's useful if we want to test new cortext strings
routines for example.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
