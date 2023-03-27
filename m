Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258EE6CA862
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0PBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjC0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE54680;
        Mon, 27 Mar 2023 08:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39289B8160C;
        Mon, 27 Mar 2023 15:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E12C433D2;
        Mon, 27 Mar 2023 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929284;
        bh=iviKd5K9/wgG7KfF6zDJQYJw3clnrBqztYiMjgjIA7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPPuGnTARvIcUJ4+oHOZ2HkvqbiXw90CIAu+aiTW3+QORqvj7/OCQQ+gEcQsR+Sgm
         IDpre+1T+HGi72IAAptX+Y0FJUFIuIIhm35p7gdoatgGbFvV00lTk+/mhTBTHWcGWh
         Ifp5twzEpP4YOip6075XqfzH5JGCNYTjjhhnuejr4cqt0Y2xv3QA5gKTy8BtTfElqZ
         xCqVHTmFOCZ+1nIOkWcJOFcUAvdgi+8wMZ/CgMMMO7NQA8xRqHJOXjmiER5Ax1x0td
         HXJhL/eRbFypdX/YVz+NeuKazvID6/TGnac5ES3e8xCcQpZ/ddGRUrhYCnFFFu+KA8
         K34QSCdDn766w==
From:   Will Deacon <will@kernel.org>
To:     rdunlap@infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH v2] perf: arm_cspmu: Fix variable dereference warning
Date:   Mon, 27 Mar 2023 16:01:11 +0100
Message-Id: <167992637873.3835657.18435170691665437274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230302205701.35323-1-bwicaksono@nvidia.com>
References: <20230302205701.35323-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 14:57:01 -0600, Besar Wicaksono wrote:
> Fix warning message from smatch tool:
>   | smatch warnings:
>   | drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container()
>   |    warn: variable dereferenced before check 'cpu_dev' (see line 1073)
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Fix variable dereference warning
      https://git.kernel.org/will/c/16e15834659e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
