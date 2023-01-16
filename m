Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4166CEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjAPSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAPSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:18:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A79222EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673892361; x=1705428361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zSrlJOl6mUi04pTIjgeQpEmQFl7alGult2nqhe5MceM=;
  b=PBcHLLyF+6wvmbnr+i/0JnoM46rkjw7opuJfP7laLITnaAQaGNnf5ry2
   4wrvlrndGbuU1x8AX6M1YhLC9fUGHQsXpFjVk+xAM0hL3eELT9NgfmzoZ
   dfbs2BgBlPIXykliuKcLYF2PDdBze4G25tTBfLfcb9LqVHKc7rlUbkm9y
   69IYlHSrwRH0YeubvTlR1CyWIcuWKdF3FEIQog2VY1UJl2IJczUfCM9sC
   Ee7j403Is+xcQk+pzvQlldMGN9YSnBJTawdnRF5J//NRcWrnzuKZrr5ue
   5y1F3TlQxnGiEMdPp+UEpi3iuRmaNuIZefYZVhxkvlbT8KQ0f9zFLU4Ex
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351767490"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="351767490"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 10:06:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="766987448"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="766987448"
Received: from mahdiahm-mobl1.amr.corp.intel.com (HELO [10.213.173.94]) ([10.213.173.94])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 10:05:59 -0800
Message-ID: <d5638ec8-3fa4-4643-9740-ef87a4ba5833@linux.intel.com>
Date:   Mon, 16 Jan 2023 08:57:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
 <991ff630-17a7-eef3-1436-e4a905fe0541@linux.intel.com>
 <78741dee-9257-77c2-8950-0519ccb462e6@amd.com>
 <420258d4-1f66-5288-f421-b26b2a2a35ea@linux.intel.com>
 <dbf20726-3900-9bff-7a72-14608702f636@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <dbf20726-3900-9bff-7a72-14608702f636@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/23 01:53, Mukunda,Vijendar wrote:
> On 14/01/23 00:11, Pierre-Louis Bossart wrote:
>>>>> +	for (index = 0; index < 2; index++) {
>>>>> +		if (response_buf[index] == -ETIMEDOUT) {
>>>>> +			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
>>>>> +			timeout = 1;
>>>>> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
>>>>> +			no_ack = 1;
>>>>> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
>>>>> +				nack = 1;
>>>>> +				dev_err(ctrl->dev, "Program SCP NACK received\n");
>>>>> +			}
>>>> this is a copy of the cadence_master.c code... With the error added that
>>>> this is not for a controller but for a master...
>>> Its manager instance only. Our immediate command and response
>>> mechanism allows sending commands over the link and get the
>>> response for every command immediately, unlike as mentioned in
>>> candence_master.c.
>> I don't get the reply. The Cadence IP also has the ability to get the
>> response immediately. There's limited scope for creativity, the commands
>> are defined in the spec and the responses as well.
> As per our understanding in Intel code, responses are processed
> after sending all commands.
> In our case, we send the command and process the response
> immediately before invoking the next command.

The Cadence IP can queue a number of commands, I think 8 off the top of
my head. But the response is provided immediately after each command.

Maybe the disconnect is that there's an ability to define a watermark on
the response buffer, so that the software can decide to process the
command responses in one shot.

>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	if (timeout) {
>>>>> +		dev_err_ratelimited(ctrl->dev,
>>>>> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
>>>>> +		return SDW_CMD_TIMEOUT;
>>>>> +	}
>>>>> +
>>>>> +	if (nack) {
>>>>> +		dev_err_ratelimited(ctrl->dev,
>>>>> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
>>>>> +		return SDW_CMD_FAIL;
>>>>> +	}
>>>>> +
>>>>> +	if (no_ack) {
>>>>> +		dev_dbg_ratelimited(ctrl->dev,
>>>>> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
>>>>> +		return SDW_CMD_IGNORED;
>>>>> +	}
>>>>> +	return SDW_CMD_OK;
>>>> this should probably become a helper since the response is really the
>>>> same as in cadence_master.c
>>>>
>>>> There's really room for optimization and reuse here.
>>> not really needed. Please refer above comment as command/response
>>> mechanism differs from Intel's implementation.
>> how? there's a buffer of responses in both cases. please clarify.
> Ours implementation is not interrupt driven like Intel.
> When we send command over the link, we will wait for command's
> response in polling method and process the response immediately
> before issuing the new command.

On the Intel side we use an interrupt to avoid polling, and in case of N
commands the watermark will be set to N to reduce the overhead. That
said, most users only use 1 command at a time, it's only recently that
Cirrus Logic experimented with multiple commands to speed-up transfers.

Even if there are differences in the way the responses are processed,
whether one-at-a-time or in a batch, the point remains that each command
response can be individually analyzed and that could be using a helper -
moving code from cadence_master.c into the bus layer.


