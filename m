Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7729565D130
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjADLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:06:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9097E186C6;
        Wed,  4 Jan 2023 03:06:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13AD91FB;
        Wed,  4 Jan 2023 03:06:53 -0800 (PST)
Received: from bogus (unknown [10.163.75.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF1D3F587;
        Wed,  4 Jan 2023 03:06:05 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:06:05 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [RFC-V3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Message-ID: <20230103041826.qo67fp45vzpch4os@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
 <ef705471-0dd3-fef1-68df-6a5761410946@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef705471-0dd3-fef1-68df-6a5761410946@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:57:51AM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> Can you take a look? This patch series works well for type3 and type4.
> 
Hi Huisong Li,

Sorry for the delay. I have been away and will be for some more time.
I will take a look at this ASAP. Thanks for your patience.

-- 
Regards,
Sudeep
