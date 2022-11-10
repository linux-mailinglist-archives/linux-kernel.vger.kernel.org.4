Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A394623FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKJKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:25:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5406713EA4;
        Thu, 10 Nov 2022 02:25:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BF11FB;
        Thu, 10 Nov 2022 02:25:38 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A23D3F534;
        Thu, 10 Nov 2022 02:25:30 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:25:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 1/3] mailbox: pcc: rename platform interrupt bit macro
 name
Message-ID: <20221110102528.6kuznowxtqkouvlb@bogus>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-2-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110015034.7943-2-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:50:32AM +0800, Huisong Li wrote:
> Currently, the name of platform interrupt bit macro, ACPI_PCCT_DOORBELL,
> is not very appropriate. The doorbell is generally considered as an action
> when send mailbox data. Actually, the macro value comes from Platform
> Interrupt in Platform Communications Channel Global Flags. If the bit is
> '1', it means that the platform is capable of generating an interrupt to
> indicate completion of a command.
>

This is touching ACPICA header file, so it must be submitted to ACPICA
separately following the guidelines in the github and imported into the
kernel.

However, I don't see any point in this change. Yes the language "doorbell"
is not used in this particular context in the spec, but it is implicit from
other parts. I am not opposing the change though if Rafael is OK and ACPICA
project accepts it.

-- 
Regards,
Sudeep
