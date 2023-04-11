Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B16DDBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjDKNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDKNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A444691;
        Tue, 11 Apr 2023 06:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068756257C;
        Tue, 11 Apr 2023 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851F9C433EF;
        Tue, 11 Apr 2023 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681218282;
        bh=tyTIQwVKdX0/WRB75WkZb/RTdecO4q51O68cOhveqHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxSzl16mHxwmf+HYhIFVwvsIpW77K1Bcdv28LYHljKkj+q/kYFBlZJMJH+XO41cX3
         M8JDOppuX83/32wqcI9OrV0POGJ4VFJzhEV0gljyByHT3LZFdbo1a0QV6rIReYrqel
         CGJasdD8bZtRIGOenRyeGnPjn0uaW/qAF7w4woDlTBKGQ2gn7QD5qYTom5ZqxH2Rgy
         zCnQ5BFfvPduLUmenI7cgjBUDY6Kz7uaCW0D9sUQlH9rhXGR5uA6JJ8XxPgyzz6YzU
         Zco9dHtIch7Bb2R0PU51wsCU3sPBR3h/4m7F/c4cdEUn+NQJrxdS5MlECW0ptOkthX
         NMGB8StFJRiGA==
From:   Will Deacon <will@kernel.org>
To:     Peter Newman <peternewman@google.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        irogers@google.com, peterz@infradead.org, mark.rutland@arm.com,
        acme@kernel.org, eranian@google.com, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v6] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
Date:   Tue, 11 Apr 2023 14:04:35 +0100
Message-Id: <168121292090.358997.14432007488088025550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230411093809.657501-1-peternewman@google.com>
References: <20230411093809.657501-1-peternewman@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 11:38:09 +0200, Peter Newman wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> The mapping of perf_events generic hardware events to actual PMU events on
> ARM PMUv3 may not always be correct. This is in particular true for the
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> architected event, it may not always be available. This can be seen with a
> simple:
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
      https://git.kernel.org/will/c/a30b87e6bd7d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
