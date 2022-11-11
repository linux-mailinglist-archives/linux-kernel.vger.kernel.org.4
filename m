Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4D625ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiKKP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiKKP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:57:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FAA155BA;
        Fri, 11 Nov 2022 07:57:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E254E23A;
        Fri, 11 Nov 2022 07:57:05 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5BC13F73D;
        Fri, 11 Nov 2022 07:56:58 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 05/23] arm64: dts: Update cache properties for arm
Date:   Fri, 11 Nov 2022 15:56:53 +0000
Message-Id: <166818151335.1567438.16719941767975470739.b4-ty@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107155825.1644604-6-pierre.gondois@arm.com>
References: <20221107155825.1644604-6-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 16:56:53 +0100, Pierre Gondois wrote:
> v2:
> - Update/Add patches for missed cache properties requiring to be
>   updated for the following platforns: bcm, amazon, arm, exynos,
>   freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
>   Missed cache properties were detected using Rob Herring's branch:
>   https://github.com/robherring/dt-schema/tree/cache-rework
> - v1 of exynos, tesla were merged.
> - Updated wrong reference in commit message.
> - Added received Rb/Acked-by.
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[05/23] arm64: dts: Update cache properties for arm
        https://git.kernel.org/sudeep.holla/c/59fb813f9742

--
Regards,
Sudeep

