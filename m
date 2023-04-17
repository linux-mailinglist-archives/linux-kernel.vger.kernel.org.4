Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49EF6E480C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDQMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:42:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B70840D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:42:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8487168F;
        Mon, 17 Apr 2023 05:42:42 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 184E23F5A1;
        Mon, 17 Apr 2023 05:41:57 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] bus: vexpress-config: Add explicit of_platform.h include
Date:   Mon, 17 Apr 2023 13:41:52 +0100
Message-Id: <168173489108.1885873.12046093132176694657.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410232727.1562115-1-robh@kernel.org>
References: <20230410232727.1562115-1-robh@kernel.org>
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

On Mon, 10 Apr 2023 18:27:26 -0500, Rob Herring wrote:
> vexpress-config uses of_platform_* functions which are declared in
> of_platform.h. of_platform.h gets implicitly included by of_device.h,
> but that is going to be removed soon. Nothing else depends on
> of_device.h so it can be dropped.
> 

Applied to sudeep.holla/linux (for-next/vexpress), thanks!

[1/1] bus: vexpress-config: Add explicit of_platform.h include
      https://git.kernel.org/sudeep.holla/c/04ebdc354895
--
Regards,
Sudeep

