Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1C6E4810
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDQMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDQMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:44:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D854CCF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:44:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5724F168F;
        Mon, 17 Apr 2023 05:44:44 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F07463F5A1;
        Mon, 17 Apr 2023 05:43:59 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix xfers allocation on RX channel
Date:   Mon, 17 Apr 2023 13:43:51 +0100
Message-Id: <168173500399.1886197.2762979819765120755.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326203449.3492948-1-cristian.marussi@arm.com>
References: <20230326203449.3492948-1-cristian.marussi@arm.com>
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

On Sun, 26 Mar 2023 21:34:49 +0100, Cristian Marussi wrote:
> Two distinct pools of xfer descriptors are allocated at initialization
> time: one (TX) used to provide xfers to track commands and their replies
> (or delayed replies) and another (RX) to pick xfers from to be used for
> processing notifications.
> 
> Such pools, though, are allocated globally to be used by the whole SCMI
> instance, they are not allocated per-channel and as such the allocation of
> notifications xfers cannot be simply skipped if no RX channel was found for
> the Base protocol common channel, because there could be defined more
> optional per-protocol dedicated channels that instead support RX channels.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix xfers allocation on RX channel
	https://git.kernel.org/sudeep.holla/c/b2ccba9e8cdc
--
Regards,
Sudeep

