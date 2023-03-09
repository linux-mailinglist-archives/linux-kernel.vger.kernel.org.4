Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A06B2665
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCIOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjCIOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:11:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 240315A921
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:09:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56AA9C14;
        Thu,  9 Mar 2023 06:10:42 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 298CD3F5A1;
        Thu,  9 Mar 2023 06:09:58 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix Raw coexistence mode behaviour on failure path
Date:   Thu,  9 Mar 2023 14:09:56 +0000
Message-Id: <167837075463.2091199.17368511990837321245.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223152330.2707260-1-cristian.marussi@arm.com>
References: <20230223152330.2707260-1-cristian.marussi@arm.com>
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

On Thu, 23 Feb 2023 15:23:30 +0000, Cristian Marussi wrote:
> When SCMI Raw coexistence mode is enabled make the core stack probe
> successfully even when basic Base protocol exchanges with the platform
> server failed.
> This behaviour enables the system to boot with a broken regular SCMI stack
> but with a fully functional and accessible SCMI Raw debugfs interface that
> can be used to further debug the issue.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix Raw coexistence mode behaviour on failure path
      https://git.kernel.org/sudeep.holla/c/b2b76e977fc6
--
Regards,
Sudeep

