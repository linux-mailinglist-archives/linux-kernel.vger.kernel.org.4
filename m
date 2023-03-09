Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97C6B26AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCIOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjCIOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:22:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6A773035
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:22:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0373AD7;
        Thu,  9 Mar 2023 06:22:44 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76EFB3F5A1;
        Thu,  9 Mar 2023 06:22:00 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ye.xingchen@zte.com.cn
Cc:     Sudeep Holla <sudeep.holla@arm.com>, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: remove duplicate include header
Date:   Thu,  9 Mar 2023 14:21:55 +0000
Message-Id: <167837166451.2095096.2591702681322565256.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202302101520071730986@zte.com.cn>
References: <202302101520071730986@zte.com.cn>
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

On Fri, 10 Feb 2023 15:20:07 +0800, ye.xingchen@zte.com.cn wrote:
> linux/of.h is included more than once.
> 

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: remove duplicate include header
      https://git.kernel.org/sudeep.holla/c/418a406d92cc
--
Regards,
Sudeep

