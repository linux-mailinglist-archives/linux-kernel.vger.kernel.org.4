Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862F6742DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjASTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjASTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:31:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CF6395740
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:31:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5406C13D5;
        Thu, 19 Jan 2023 11:32:21 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91B7E3F67D;
        Thu, 19 Jan 2023 11:31:38 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Ludvig.Parsson@axis.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, james.quinlan@broadcom.com
Subject: Re: [PATCH 0/9] Rework SCMI initialization and probing sequence
Date:   Thu, 19 Jan 2023 19:31:34 +0000
Message-Id: <167415666655.1301843.11494809761405438346.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221222185049.737625-1-cristian.marussi@arm.com>
References: <20221222185049.737625-1-cristian.marussi@arm.com>
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

On Thu, 22 Dec 2022 18:50:40 +0000, Cristian Marussi wrote:
> under some configurations the SCMI core stack, which is now initialized
> as a whole at the subsys_initcall level, can be dependent on some other
> Kernel subsystems (like TEE) when some SCMI transport backend like optee
> is used.
> 
> This has been reported to lead to some awkward probe loop which, even
> though successful at the end, leaves a track of errors in the logs coming
> directly from the core Linux driver model facilities.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/9] firmware: arm_scmi: Simplify chan_available transport operation
      https://git.kernel.org/sudeep.holla/c/7a75b7afd8ff
[2/9] firmware: arm_scmi: Use dedicated devices to initialize channels
      https://git.kernel.org/sudeep.holla/c/05a2801d8b90
[3/9] firmware: arm_scmi: Move protocol registration helpers
      https://git.kernel.org/sudeep.holla/c/9115c20ac1ee
[4/9] firmware: arm_scmi: Add common notifier helpers
      https://git.kernel.org/sudeep.holla/c/53b8c25df708
[5/9] firmware: arm_scmi: Refactor protocol device creation
      https://git.kernel.org/sudeep.holla/c/d3cd7c525fd2
[6/9] firmware: arm_scmi: Move handle get/set helpers
      https://git.kernel.org/sudeep.holla/c/971fc0665f13
[7/9] firmware: arm_scmi: Refactor device create/destroy helpers
      https://git.kernel.org/sudeep.holla/c/2c3e674465e7
[8/9] firmware: arm_scmi: Introduce a new lifecycle for protocol devices
      https://git.kernel.org/sudeep.holla/c/ee5dcedaf72d
[9/9] firmware: arm_scmi: Split bus and driver into distinct modules
      https://git.kernel.org/sudeep.holla/c/37b5be828032
--
Regards,
Sudeep

