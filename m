Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E006756BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjATOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjATOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:15:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6126B99F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:15:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37E314BF;
        Fri, 20 Jan 2023 06:14:49 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 937E53F67D;
        Fri, 20 Jan 2023 06:14:07 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] firmware: arm_scmi: Clarify Raw per-channel ABI documentation
Date:   Fri, 20 Jan 2023 14:14:02 +0000
Message-Id: <167422401738.1420811.6428308989054316310.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120122326.1932614-1-cristian.marussi@arm.com>
References: <20230120122326.1932614-1-cristian.marussi@arm.com>
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

On Fri, 20 Jan 2023 12:23:26 +0000, Cristian Marussi wrote:
> Explain more in detail how the per-channel <m> identifier is chosen.
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Clarify Raw per-channel ABI documentation
      https://git.kernel.org/sudeep.holla/c/32a55bbdd74e
--
Regards,
Sudeep

