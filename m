Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0D724A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbjFFRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjFFRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB51705
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47DCE63620
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA38C433EF;
        Tue,  6 Jun 2023 17:30:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Eric Chan <ericchancf@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: lockdep: enable checks for held locks when returning to userspace
Date:   Tue,  6 Jun 2023 18:30:11 +0100
Message-Id: <168607260525.1438101.16339877591274617563.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531090909.357047-1-ericchancf@google.com>
References: <20230531090909.357047-1-ericchancf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 09:09:09 +0000, Eric Chan wrote:
> Currently arm64 doesn't use CONFIG_GENERIC_ENTRY and doesn't call
> lockdep_sys_exit() when returning to userspace.
> This means that lockdep won't check for held locks when
> returning to userspace, which would be useful to detect kernel bugs.
> 
> Call lockdep_sys_exit() when returning to userspace,
> enabling checking for held locks.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: lockdep: enable checks for held locks when returning to userspace
      https://git.kernel.org/arm64/c/ab1e29acdb33

-- 
Catalin

