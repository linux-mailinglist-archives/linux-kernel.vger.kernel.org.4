Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C76742E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjASTc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjASTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:32:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64DA84DCC3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:32:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 076B013D5;
        Thu, 19 Jan 2023 11:33:32 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B0A53F67D;
        Thu, 19 Jan 2023 11:32:48 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, vincent.guittot@linaro.org,
        quic_kshivnan@quicinc.com, nicola.mazzucato@arm.com,
        james.quinlan@broadcom.com, f.fainelli@gmail.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        souvik.chakravarty@arm.com, tarek.el-sherbiny@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com
Subject: Re: [PATCH v8 00/17] Introduce a unified API for SCMI Server testing
Date:   Thu, 19 Jan 2023 19:32:43 +0000
Message-Id: <167415672224.1302057.3184661393643906075.b4-ty@arm.com>
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

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[01/17] firmware: arm_scmi: Refactor xfer in-flight registration routines
        https://git.kernel.org/sudeep.holla/c/9374324e8d78
[02/17] firmware: arm_scmi: Refactor polling helpers
        https://git.kernel.org/sudeep.holla/c/d5552a45c828
[03/17] firmware: arm_scmi: Refactor scmi_wait_for_message_response
        https://git.kernel.org/sudeep.holla/c/ac49e46c453a
[04/17] firmware: arm_scmi: Add flags field to xfer
        https://git.kernel.org/sudeep.holla/c/0eb24e5a0ead
[05/17] firmware: arm_scmi: Add xfer Raw helpers
        https://git.kernel.org/sudeep.holla/c/aaa9d521b01a
[06/17] firmware: arm_scmi: Move errors defs and code to common.h
        https://git.kernel.org/sudeep.holla/c/5e15c2197fc7
[07/17] firmware: arm_scmi: Add internal platform/channel IDs
        https://git.kernel.org/sudeep.holla/c/5b6034808c96
[08/17] include: trace: Add platform and channel instance references
        https://git.kernel.org/sudeep.holla/c/bd752cc79916
[09/17] debugfs: Export debugfs_create_str symbol
        https://git.kernel.org/sudeep.holla/c/cade53b60a04
[10/17] firmware: arm_scmi: Populate a common SCMI debugsfs root
        https://git.kernel.org/sudeep.holla/c/f5bc54a5041b
[11/17] firmware: arm_scmi: Add debugfs ABI documentation for common entries
        https://git.kernel.org/sudeep.holla/c/b5dc013d98b4
[12/17] firmware: arm_scmi: Add core Raw transmission support
        https://git.kernel.org/sudeep.holla/c/e789a8ab15b0
[13/17] firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
        https://git.kernel.org/sudeep.holla/c/25376d813405
[14/17] firmware: arm_scmi: Reject SCMI drivers while in Raw mode
        https://git.kernel.org/sudeep.holla/c/9e834da670ce
[15/17] firmware: arm_scmi: Call Raw mode hooks from the core stack
        https://git.kernel.org/sudeep.holla/c/a6fb9dc05c8c
[16/17] firmware: arm_scmi: Add Raw mode coexistence support
        https://git.kernel.org/sudeep.holla/c/145f03626257
[17/17] firmware: arm_scmi: Add per-channel Raw injection support
        https://git.kernel.org/sudeep.holla/c/eeb087fa365a

--
Regards,
Sudeep

