Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730696E60EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDRMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDRMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:14:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4979449C6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:14:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E6E1691;
        Tue, 18 Apr 2023 05:14:30 -0700 (PDT)
Received: from [10.57.21.174] (unknown [10.57.21.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 511963F587;
        Tue, 18 Apr 2023 05:13:45 -0700 (PDT)
Message-ID: <f4227609-ec24-58f8-e4d3-073434fd7ab3@arm.com>
Date:   Tue, 18 Apr 2023 13:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: SMP enablement on Cortex-R52 (using PSCI ?)
To:     Ayan Kumar Halder <ayankuma@amd.com>, mark.rutland@arm.com,
        lpieralisi@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
References: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
Content-Language: en-US
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/14/23 12:24, Ayan Kumar Halder wrote:
> Hi PSCI developers,
> 
> We have a SoC where there are 4 Cortex-R52 which is distributed in two clusters. So we have 2 Cortex-R52 in one cluster and 2 Cortex-R52 in another cluster.
> 
> We wish to enable SMP on the 2 R52 within a cluster with Xen hypervisor (EL2 software) running on them.
> 
> We are trying to explore if we can use PSCI for booting the secondary cores.
> 

snip

> 
> I wish to know how do we wake up the secondary core if PSCI is not supported.
> 

It looks to me you need to provide/use platform defined method. I see that
Xen provides struct platform_desc with smp_init and cpu_up callbacks...

Cheers
Vladimir

> Kind regards,
> Ayan
> 
> 
> 

