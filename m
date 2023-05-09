Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A96FC375
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjEIKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjEIKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:07:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 924365246
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:06:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35101063;
        Tue,  9 May 2023 03:07:43 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 462753F67D;
        Tue,  9 May 2023 03:06:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation
Date:   Tue,  9 May 2023 10:40:56 +0100
Message-Id: <168362508668.1113402.9080221651556899000.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
References: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 09:33:49 -1000, Tejun Heo wrote:
> scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
> Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
> interface and using 0 for @max_active for the default setting.
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation
      https://git.kernel.org/sudeep.holla/c/44e8d5ad2dc0
--
Regards,
Sudeep

