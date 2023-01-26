Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DE67D992
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjAZXYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjAZXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:24:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338164C6EF;
        Thu, 26 Jan 2023 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674775486; x=1706311486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+xT9AgXpdl1/3c5BvBnA3g4wo3hRTBdAyWmjHwNvjU=;
  b=d8M+Qj9UUwfQMBBTah6DPU7mASgdiUetTRiCBnLrwczpxwuf6gZ6xl2e
   5E7x9PzO3GMTMgYLCaoBd9pErGmcckhrm2z+KoaMBIJ29yyj6RJh/+dV6
   FR+7UcGyYTAICO+8w6ztDXy7PZBW3RHwW1Ij/s5yuCHziYJkFGPXjRPkv
   LSfegyvi6V542g4VzxVTLN2BtRZrIXDleVdekSSjAtLM7w9PFAQL2dabJ
   y4pDc85XAIQQ2108Gsl0oTUb+zpMshvgwRtRbnkwoUpbPchj3GW46AV3V
   LoNju85f13VCm6NhzhwXiaJmWGa//WWSu85N32DGvoPzeWb1RFj5RiOZk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329110364"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="329110364"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:24:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656387197"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="656387197"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.115]) ([10.212.112.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:24:44 -0800
Message-ID: <099e9e5b-88dd-ae5f-307d-6ea9f16586f1@intel.com>
Date:   Thu, 26 Jan 2023 16:24:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119130450.107519-1-rrichter@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230119130450.107519-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 6:04 AM, Robert Richter wrote:
> Only unsupported mailbox commands are reported in debug messages. A
> list of supported commands is useful too. Change debug messages to
> also report the opcodes of supported commands.
> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a48ade466d6a..ffa9f84c2dce 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -629,11 +629,12 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>   
>   		if (!cmd) {
>   			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> +				"Opcode 0x%04x unsupported by driver\n", opcode);
>   			continue;
>   		}
>   
>   		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
>   	}
>   }
>   
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
