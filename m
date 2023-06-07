Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918A726999
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjFGTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFGTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:19:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C353A1BD4;
        Wed,  7 Jun 2023 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686165596; x=1717701596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMEomkbMgXMC6d/m4cFrF1CnpOyHNvyL7lkPILSp6Lw=;
  b=fQPb8aF8qdtMVLXvYyBUJ3xIgQZqGuA4GkA0R8keiu1X0jfQ6lEMKhp9
   LlcXmiIIiGjUXRHz/bqxCXaxHTvh1iWBfaXy96bKfAW+BE/O2y9natdtw
   c89JoHVJdOQz1c/SvxQItx2ne1kEYbm9v8ur6CyBPAfMW7R+LdVzBnbsI
   Brt2WUk9cxh43rDzaqgdLSKvQHmc2Fd15L/mX2qigETjlNbUAsa7swGh1
   vzARdqT90BKYR1hS6digg1NcsyAwoz+EKXiEoGDGrUWdxICfsiYK8qGDg
   UDgnc8ieCG9KMRggenGemfsxjO51Ur7GVsYo8oLUzpyU+8uIRtkwEasYs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360415927"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360415927"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956411568"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="956411568"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.21.116])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:19:55 -0700
Date:   Wed, 7 Jun 2023 12:19:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
Message-ID: <ZIDYWlPb2Mc883MR@aschofie-mobl2>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
 <20230602-vv-fw_update-v2-3-e9e5cd5adb44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602-vv-fw_update-v2-3-e9e5cd5adb44@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:20:24PM -0600, Vishal Verma wrote:
> As more emulated mailbox commands are added to cxl_test, it is a pain
> point to look up command effect numbers for each effect. Replace the
> bare numbers in the mock driver with an enum that lists all possible
> effects.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 403cd3608772..68668d8df1cd 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -21,42 +21,56 @@
>  
>  static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
>  
> +enum cxl_command_effects {
> +	CONF_CHANGE_COLD_RESET = 0,
> +	CONF_CHANGE_IMMEDIATE,
> +	DATA_CHANGE_IMMEDIATE,
> +	POLICY_CHANGE_IMMEDIATE,
> +	LOG_CHANGE_IMMEDIATE,
> +	SECURITY_CHANGE_IMMEDIATE,
> +	BACKGROUND_OP,
> +	SECONDARY_MBOX_SUPPORTED,
> +};
> +
> +#define CXL_CMD_EFFECT_NONE cpu_to_le16(0)
> +
>  static struct cxl_cel_entry mock_cel[] = {
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
> -		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE) |
> +				      EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = CXL_CMD_EFFECT_NONE,
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> -		.effect = cpu_to_le16(EFFECT(2)),
> +		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
>  	},
>  };
>  
> 
> -- 
> 2.40.1
> 
