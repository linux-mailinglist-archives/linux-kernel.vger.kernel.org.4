Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3B64059E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiLBLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiLBLRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:17:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AEA31DFF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:17:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B255BB80955
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7E0C433C1;
        Fri,  2 Dec 2022 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669979869;
        bh=0LaTTtWUlH8+3BEn/MEriuJPwoMky2IVcCMbgBew5v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h69HEr7OxyY9phIFTR1Oam/DBJ8YTno17K7RL6afgDtKXxyMEU/RrWnTN/+iWcget
         yjkmuVlxKFvxpCigEAq4B9OgJlaCi6xntbtEEC0YQXirkRMa1vVIfsk00zrIeDu9eK
         900FPdby42Cbr6tSmgwFYTqkuebjY04eF8k/+anCpLauadOCMzkyYoOP6PWWMakUz6
         ytwoPkcvfD3MY/K1meaEyoEYkuOnCqPA5moI3fxpu7Z00eHDUceM4qxr40tckSdo46
         DOM5Yhyy4fJN/y4c9tNQ9BVRn6/zqhxIKXKgTZaYqx4rnoHIoZu6ThXBV+SvP6CleT
         CqrHF/qRTE1Lw==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm_pmu: Drop redundant armpmu->map_event() in armpmu_event_init()
Date:   Fri,  2 Dec 2022 11:17:40 +0000
Message-Id: <166997610412.2820545.3765693672381497084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221202015611.338499-1-anshuman.khandual@arm.com>
References: <20221202015611.338499-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 07:26:11 +0530, Anshuman Khandual wrote:
> __hw_perf_event_init() already calls armpmu->map_event() callback, and also
> returns its error code including -ENOENT, along with a debug callout. Hence
> an additional armpmu->map_event() check for -ENOENT is redundant.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] arm_pmu: Drop redundant armpmu->map_event() in armpmu_event_init()
      https://git.kernel.org/will/c/4361251cef46

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
