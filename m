Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2770744C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEQVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:31:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934DB4;
        Wed, 17 May 2023 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684359091; x=1715895091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jYUHuX/9rfLJhrnskJsPzKPCjulcmYzNBQ59CfkqXPk=;
  b=TBukkk4xCjGJrIXy/S3kshFX4SlsLf7Odp/xxAke+venvb/dsb6/UIxS
   61zachntxcrNESDPvyrotSH7I96A4I1uT9Kg+xZ2duoalyEJysiOTLMX3
   AchsF16CmwztFXOf3YujhDwilqbdZ+V9n0rNQoH/lQv/gVArpGbYbWGYB
   fJIvA5FIRslDeBMGj1CBDvdTVCBSQObOE0iU400zufaQthXQaGxh0xGLs
   9Y4NB/Bx1TghgLOfFqfVb6Lv3Rd+6zuzejPmZ1c0h03CM4lGK77V9QtcZ
   63mpCcBU7pW03c1omg/QR4wjMJcRDEA2k0OTsM7RG/rXZ4CITA1b5rkh3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="417544054"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="417544054"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="704962540"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="704962540"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.83.61]) ([10.212.83.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:31:30 -0700
Message-ID: <5fe7e7ef-6c60-fb05-2a55-1e576be09c7f@intel.com>
Date:   Wed, 17 May 2023 14:31:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] tools/testing/cxl: Document test configurations
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 2:28 PM, Ira Weiny wrote:
> The devices created, their relationship, and intended testing purpose is
> not extremely clear, especially for those unfamiliar with cxl-test.
> 
> Document the purpose of each hierarchy.  Add ASCII art to show the
> relationship of devices.  Group the device declarations together based
> on the hierarchies.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Nice artwork :)

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index bf00dc52fe96..bd38a5fb60ae 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -23,6 +23,31 @@ static int interleave_arithmetic;
>   #define NR_CXL_PORT_DECODERS 8
>   #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
>   
> +/*
> + * Interleave testing
> + *
> + *             +---------------+                            +---------------+
> + *             | host_bridge[0]|                            | host_bridge[1]|
> + *             +-/---------\---+                            +--/---------\--+
> + *             /-           -\                               /-           -\
> + *           /-               -\                           /-               -\
> + *   +-------------+         +-------------+       +-------------+      +-------------+
> + *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
> + *   +------|------+         +------|------+       +------|------+      +------|------+
> + *          |                       |                     |                    |
> + *  +-------|-------+       +-------|-------+     +-------|-------+    +-------|-------+
> + *  |switch_uport[0]|       |switch_uport[1]|     |switch_uport[2]|    |switch_uport[3]|
> + *  +---|-------|---+       +---/-------|---+     +---/-------|---+    +---|-------\---+
> + *      |       \              /        \            /        \            /        \
> + * +----|----++--|------++---------++----|----++---------++----|----++----|----++---------+
> + * |switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   |
> + * |_dport[0]||_dport[1]||_dport[2]||_dport[3]||_dport[4]||_dport[5]||_dport[6]||_dport[7]|
> + * +----|----++--|------++----|----++----|----++----|----++----|----++----|----++----|----+
> + *      |        |            |          |          |          |          |          |
> + *  +---|--+   +-|----+   +---|--+   +---|--+    +--|---+  +---|--+   +---|--+   +---|--+
> + *  |mem[0]|   |mem[1]|   |mem[2]|   |mem[3]|    |mem[4]|  |mem[5]|   |mem[6]|   |mem[7]|
> + *  +------+   +------+   +------+   +------+    +------+  +------+   +------+   +------+
> + */
>   static struct platform_device *cxl_acpi;
>   static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
>   #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
> @@ -31,16 +56,51 @@ static struct platform_device *cxl_switch_uport[NR_MULTI_ROOT];
>   #define NR_MEM_MULTI \
>   	(NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS)
>   static struct platform_device *cxl_switch_dport[NR_MEM_MULTI];
> +struct platform_device *cxl_mem[NR_MEM_MULTI];
>   
> +/*
> + * 1) Preconfigured region support (Simulated BIOS configured region)
> + * 2) 'Pass-through' decoder
> + *
> + *       +---------------+
> + *       |  hb_single    |
> + *       +------|--------+
> + *              |
> + *       +------|--------+
> + *       | root_single   |
> + *       +------|--------+
> + *              |
> + *   +----------|----------+
> + *   |     swu_single      |
> + *   +-----|-----------|---+
> + *         |           |
> + *   +-----|-----+  +--|--------+
> + *   |swd_single |  | swd_single|
> + *   +-----|-----+  +----|------+
> + *         |             |
> + *  +------|-----+  +----|-------+
> + *  |mem_single  |  |mem_single  |
> + *  +------------+  +------------+
> + */
>   static struct platform_device *cxl_hb_single[NR_CXL_SINGLE_HOST];
>   static struct platform_device *cxl_root_single[NR_CXL_SINGLE_HOST];
>   static struct platform_device *cxl_swu_single[NR_CXL_SINGLE_HOST];
>   #define NR_MEM_SINGLE (NR_CXL_SINGLE_HOST * NR_CXL_SWITCH_PORTS)
>   static struct platform_device *cxl_swd_single[NR_MEM_SINGLE];
> -
> -struct platform_device *cxl_mem[NR_MEM_MULTI];
>   struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
>   
> +/*
> + * 1) RCD
> + * 2) Type-2 (Accelerator)
> + *
> + *  +-----+
> + *  | rch |
> + *  +--|--+
> + *     |
> + *   +-|--+
> + *   |rcd |
> + *   +----+
> + */
>   static struct platform_device *cxl_rch[NR_CXL_RCH];
>   static struct platform_device *cxl_rcd[NR_CXL_RCH];
>   
> @@ -64,6 +124,17 @@ static inline bool is_single_bridge(struct device *dev)
>   	return false;
>   }
>   
> +/*
> + *  +---------------+ +---------------+
> + *  | host_bridge[0]| | host_bridge[1]|
> + *  +---------------+ +---------------+
> + *  +---------------+
> + *  |  hb_single    | (host_bridge[2])
> + *  +---------------+
> + *  +-----+
> + *  | rch | (host_bridge[3])
> + *  +-----+
> + */
>   static struct acpi_device acpi0017_mock;
>   static struct acpi_device host_bridge[NR_BRIDGES] = {
>   	[0] = {
> 
