Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE396E7703
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjDSKCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDSKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DA1E83D9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:02:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDF9A2F4;
        Wed, 19 Apr 2023 03:03:02 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8233F6C4;
        Wed, 19 Apr 2023 03:02:17 -0700 (PDT)
Date:   Wed, 19 Apr 2023 11:02:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, rafael.j.wysocki@intel.com,
        vschneid@redhat.com, ben-linux@fluff.org, Pierre.Gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: kernel: smp: ignore disabled cpu node
Message-ID: <20230419100214.x6y6jgpvnupmgplr@bogus>
References: <20230419094039.3140521-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419094039.3140521-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 05:40:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> If the cpu node is set disabled in device tree, we should ignore the
> node. i.MX8MP has some variants, which have one or two or four A53 cores.
> The current imx8mp device tree use the full feature SoC. With such
> device tree to bring the variant with one or two A53 cores will cause
> issue.
>
> The firmware will update the status property, and kernel will check the
> property before bring up the core.
>

IIRC it has been discussed in the past[1][2], has anything changed now ?

--
Regards,
Sudeep

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174324.html
[2] https://yhbt.net/lore/all/1524697712-20208-1-git-send-email-rokhanna@nvidia.com/
