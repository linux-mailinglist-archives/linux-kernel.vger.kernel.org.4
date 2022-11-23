Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B56358D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiKWKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiKWKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:02:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ED69FAE98;
        Wed, 23 Nov 2022 01:54:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F981FB;
        Wed, 23 Nov 2022 01:54:33 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EEAB3F587;
        Wed, 23 Nov 2022 01:54:24 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:54:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ACPI: bus: make osc_sb_ffh_opregion_support_confirmed
 static
Message-ID: <20221123095421.ffolxbq2csqirw7u@bogus>
References: <20221123034215.119461-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123034215.119461-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:42:15AM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of bus.c, so marks it static.
> 
> drivers/acpi/bus.c:304:6: warning: symbol 'osc_sb_ffh_opregion_support_confirmed' was not declared. Should it be static?
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3241
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Sorry for not replying to the original report which I meant to and for some
reason left it in the draft. Anyways in order to fix another bug, this
variable was removed thereby removing this build/sparse warning. This
warning should not appear from today's linux-next.

Thanks for spotting and this patch fixing it.

-- 
Regards,
Sudeep
