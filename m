Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B15617731
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKCHJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKCHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:09:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12A522A2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:09:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0701FB;
        Thu,  3 Nov 2022 00:09:43 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD5543F703;
        Thu,  3 Nov 2022 00:09:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/8] firmware: arm_scmi: Cleanup core driver removal callback
Date:   Thu,  3 Nov 2022 07:09:29 +0000
Message-Id: <166745927905.2971610.390378642784084844.b4-ty@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028140833.280091-1-cristian.marussi@arm.com>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
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

On Fri, 28 Oct 2022 15:08:26 +0100, Cristian Marussi wrote:
> Platform drivers .remove callbacks are not supposed to fail and report
> errors: such errors are indeed ignored by the core platform drivers stack
> and the driver unbind process is anyway completed.
> 
> The SCMI core platform driver as it is now, instead, bails out reporting
> an error in case of an explicit unbind request.
> 
> [...]

Applied 1-6/8 to sudeep.holla/linux (for-next/scmi), thanks!

[1/8] firmware: arm_scmi: Cleanup core driver removal callback
      https://git.kernel.org/sudeep.holla/c/3f4071cbd206
[2/8] firmware: arm_scmi: Suppress bind attributes
      https://git.kernel.org/sudeep.holla/c/fd96fbc8fad3
[3/8] firmware: arm_scmi: Make tx_prepare time out eventually
      https://git.kernel.org/sudeep.holla/c/59172b212ec0
[4/8] firmware: arm_scmi: Make RX chan_setup fail on memory errors
      https://git.kernel.org/sudeep.holla/c/be9ba1f7f9e0
[5/8] firmware: arm_scmi: Fix devres allocation device in virtio
      https://git.kernel.org/sudeep.holla/c/5ffc1c4cb896
[6/8] firmware: arm_scmi: Fix deferred_tx_wq release on error paths
      https://git.kernel.org/sudeep.holla/c/1eff6929aff5

--
Regards,
Sudeep

