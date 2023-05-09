Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911736FC254
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjEIJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEIJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:07:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C126A3599;
        Tue,  9 May 2023 02:06:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951571063;
        Tue,  9 May 2023 02:07:42 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8443F67D;
        Tue,  9 May 2023 02:06:56 -0700 (PDT)
Date:   Tue, 9 May 2023 10:06:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH v3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Message-ID: <20230509090654.fv2aqmczn447ceab@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230423110335.2679-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423110335.2679-1-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 07:03:33PM +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
>
> ---
>  -v3: update requesting shared irq code due to pcc using mbox_bind_client.
>  -v2: extract cmd complete code into a function.
>       unrelated types regard chan_in_use as dummy.
>  -v1: using subspace type to replace comm_flow_dir in patch [1/2]
>  -rfc-v3: split V2 into two patches.
>  -rfc-v2: don't use platform interrupt ack register to identify if the given
>       channel should respond interrupt.
> 
> Huisong Li (2):
>   mailbox: pcc: Add support for platform notification handling
>   mailbox: pcc: Support shared interrupt for multiple subspaces
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
