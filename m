Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378946753D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjATLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjATLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:52:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC9FF1708
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:52:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38885AD7;
        Fri, 20 Jan 2023 03:53:09 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C28D03F71A;
        Fri, 20 Jan 2023 03:52:25 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        wleavitt@marvell.com, quic_kshivnan@quicinc.com,
        nicola.mazzucato@arm.com, f.fainelli@gmail.com,
        Jonathan.Cameron@Huawei.com, tarek.el-sherbiny@arm.com,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        vincent.guittot@linaro.org, etienne.carriere@linaro.org
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Date:   Fri, 20 Jan 2023 11:52:23 +0000
Message-Id: <167421506003.1401730.7902325240538482315.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230118121426.492864-1-cristian.marussi@arm.com>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
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

On Wed, 18 Jan 2023 12:14:09 +0000, Cristian Marussi wrote:
> This series aims to introduce a new SCMI unified userspace interface meant
> to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> from the perspective of the OSPM agent (non-secure world only ...)
> 
> It is proposed as a testing/development facility, it is NOT meant to be a
> feature to use in production, but only enabled in Kconfig for test
> deployments.
> 
> [...]

Re-applied to sudeep.holla/linux (for-next/scmi) with Tested-by tags now, thanks!

[01/17] firmware: arm_scmi: Refactor xfer in-flight registration routines
        https://git.kernel.org/sudeep.holla/c/b0e924a955cb
[02/17] firmware: arm_scmi: Refactor polling helpers
        https://git.kernel.org/sudeep.holla/c/f21c2b0ba8f3
[03/17] firmware: arm_scmi: Refactor scmi_wait_for_message_response
        https://git.kernel.org/sudeep.holla/c/07cdfc44f1a4
[04/17] firmware: arm_scmi: Add flags field to xfer
        https://git.kernel.org/sudeep.holla/c/37057bf2b509
[05/17] firmware: arm_scmi: Add xfer Raw helpers
        https://git.kernel.org/sudeep.holla/c/3095a3e25d8f
[06/17] firmware: arm_scmi: Move errors defs and code to common.h
        https://git.kernel.org/sudeep.holla/c/936a2b91c2e8
[07/17] firmware: arm_scmi: Add internal platform/channel IDs
        https://git.kernel.org/sudeep.holla/c/75c86dc72dc8
[08/17] include: trace: Add platform and channel instance references
        https://git.kernel.org/sudeep.holla/c/8b2bd71119dd
[09/17] debugfs: Export debugfs_create_str symbol
        https://git.kernel.org/sudeep.holla/c/d60b59b96795
[10/17] firmware: arm_scmi: Populate a common SCMI debugsfs root
        https://git.kernel.org/sudeep.holla/c/c3d4aed763ce
[11/17] firmware: arm_scmi: Add debugfs ABI documentation for common entries
        https://git.kernel.org/sudeep.holla/c/0f62ed0092ec
[12/17] firmware: arm_scmi: Add core Raw transmission support
        https://git.kernel.org/sudeep.holla/c/3c3d818a9317
[13/17] firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
        https://git.kernel.org/sudeep.holla/c/74225707b334
[14/17] firmware: arm_scmi: Reject SCMI drivers while in Raw mode
        https://git.kernel.org/sudeep.holla/c/ba80acb0dfca
[15/17] firmware: arm_scmi: Call Raw mode hooks from the core stack
        https://git.kernel.org/sudeep.holla/c/7063887b5386
[16/17] firmware: arm_scmi: Add Raw mode coexistence support
        https://git.kernel.org/sudeep.holla/c/9c54633e4e3d
[17/17] firmware: arm_scmi: Add per-channel Raw injection support
        https://git.kernel.org/sudeep.holla/c/7860701d1e6e

--
Regards,
Sudeep

