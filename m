Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3C6B2666
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjCIOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjCIOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:11:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B391A6152D;
        Thu,  9 Mar 2023 06:10:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0435EAD7;
        Thu,  9 Mar 2023 06:10:49 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94FC63F5A1;
        Thu,  9 Mar 2023 06:10:04 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Clean up a return statement
Date:   Thu,  9 Mar 2023 14:10:02 +0000
Message-Id: <167837075462.2091199.3854987429917984262.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <Y86im5M49p3ePGxj@kili>
References: <Y86im5M49p3ePGxj@kili>
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

On Mon, 23 Jan 2023 18:07:07 +0300, Dan Carpenter wrote:
> The comments say "enabled" where "disabled" is intended.  Also it's
> cleaner to return zero explicitly instead of ret.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Clean up a return statement
      https://git.kernel.org/sudeep.holla/c/8ab5059dc4f4
--
Regards,
Sudeep

