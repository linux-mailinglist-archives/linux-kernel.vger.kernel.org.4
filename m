Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0066A2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjAMT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAMT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:27:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99485C95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638075; x=1705174075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5u4Kp0bgcQd8YGZWdDp2WoHL7Cok15NAaaaXWbpFWd8=;
  b=ZD6d2dALCqKdxlr0BrTg/N3+/nj8gJtpqHOydFOrKs+SFr6zfeguyBfJ
   lywvgosgfDFugdL+hcKS9KZ+RpwpW8bz1xTwjN048IfqoCpmoZsjNFdyA
   OommD0dpAdjn4VfM1/XID1uuxAMFtbhLErQQbDY+/+cX3zJ3dwSYe2ReB
   VzZw4OPaPyut+RX7JWt/qmD0/5eVggdlNxWhta2CpE+OzT+qmNWRPdomJ
   m76z/BGhzxZ1tZxOH5kNAJyPPH51PMpDtbxMsxE0hj0UHWZdntlia1Rwl
   ktM7mNHNQ7hhf7vWHI7vljZ0Q4P78b3GkOF5gC8vHGJsvA1DNuB2qpKfw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="322777269"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322777269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608257489"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608257489"
Received: from rerayess-mobl.amr.corp.intel.com (HELO [10.212.13.223]) ([10.212.13.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:27:53 -0800
Message-ID: <420258d4-1f66-5288-f421-b26b2a2a35ea@linux.intel.com>
Date:   Fri, 13 Jan 2023 12:41:08 -0600
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <78741dee-9257-77c2-8950-0519ccb462e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	for (index = 0; index < 2; index++) {
>>> +		if (response_buf[index] == -ETIMEDOUT) {
>>> +			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
>>> +			timeout = 1;
>>> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
>>> +			no_ack = 1;
>>> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
>>> +				nack = 1;
>>> +				dev_err(ctrl->dev, "Program SCP NACK received\n");
>>> +			}
>> this is a copy of the cadence_master.c code... With the error added that
>> this is not for a controller but for a master...
> Its manager instance only. Our immediate command and response
> mechanism allows sending commands over the link and get the
> response for every command immediately, unlike as mentioned in
> candence_master.c.

I don't get the reply. The Cadence IP also has the ability to get the
response immediately. There's limited scope for creativity, the commands
are defined in the spec and the responses as well.

>>> +		}
>>> +	}
>>> +
>>> +	if (timeout) {
>>> +		dev_err_ratelimited(ctrl->dev,
>>> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
>>> +		return SDW_CMD_TIMEOUT;
>>> +	}
>>> +
>>> +	if (nack) {
>>> +		dev_err_ratelimited(ctrl->dev,
>>> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
>>> +		return SDW_CMD_FAIL;
>>> +	}
>>> +
>>> +	if (no_ack) {
>>> +		dev_dbg_ratelimited(ctrl->dev,
>>> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
>>> +		return SDW_CMD_IGNORED;
>>> +	}
>>> +	return SDW_CMD_OK;
>> this should probably become a helper since the response is really the
>> same as in cadence_master.c
>>
>> There's really room for optimization and reuse here.
> not really needed. Please refer above comment as command/response
> mechanism differs from Intel's implementation.

how? there's a buffer of responses in both cases. please clarify.

>>> +static void amd_sdwc_compute_slave_ports(struct sdw_master_runtime *m_rt,
>>> +					 struct sdw_transport_data *t_data)
>>> +{
>>> +	struct sdw_slave_runtime *s_rt = NULL;
>>> +	struct sdw_port_runtime *p_rt;
>>> +	int port_bo, sample_int;
>>> +	unsigned int rate, bps, ch = 0;
>>> +	unsigned int slave_total_ch;
>>> +	struct sdw_bus_params *b_params = &m_rt->bus->params;
>>> +
>>> +	port_bo = t_data->block_offset;
>>> +	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>>> +		rate = m_rt->stream->params.rate;
>>> +		bps = m_rt->stream->params.bps;
>>> +		sample_int = (m_rt->bus->params.curr_dr_freq / rate);
>>> +		slave_total_ch = 0;
>>> +
>>> +		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>>> +			ch = sdw_ch_mask_to_ch(p_rt->ch_mask);
>>> +
>>> +			sdw_fill_xport_params(&p_rt->transport_params,
>>> +					      p_rt->num, false,
>>> +					      SDW_BLK_GRP_CNT_1,
>>> +					      sample_int, port_bo, port_bo >> 8,
>>> +					      t_data->hstart,
>>> +					      t_data->hstop,
>>> +					      SDW_BLK_PKG_PER_PORT, 0x0);
>>> +
>>> +			sdw_fill_port_params(&p_rt->port_params,
>>> +					     p_rt->num, bps,
>>> +					     SDW_PORT_FLOW_MODE_ISOCH,
>>> +					     b_params->s_data_mode);
>>> +
>>> +			port_bo += bps * ch;
>>> +			slave_total_ch += ch;
>>> +		}
>>> +
>>> +		if (m_rt->direction == SDW_DATA_DIR_TX &&
>>> +		    m_rt->ch_count == slave_total_ch) {
>>> +			port_bo = t_data->block_offset;
>>> +		}
>>> +	}
>>> +}
>> ok, this is really bad.
>>
>> This is a verbatim copy of the same function in
>> generic_bandwidth_allocation.c
>>
>> see
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fsoundwire%2Fgeneric_bandwidth_allocation.c%23L38&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ccac3e7985a9347a69be908daf3f1ea8a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090517594233520%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=MhN0eJYtggAnkUyb6mDIWW8LvwGeS8JJ%2F2UBHkHHOYo%3D&reserved=0
>>
>> You only removed the comments and renamed the function.
>>
>> Seriously? Why would you do that?
>>
>> And in addition, this has *NOTHING* to do with the master support.
>>
>> Programming the ports on peripheral side is something that happens at
>> the stream level.
>>
>> I am afraid it's a double NAK, or rather NAK^2 from me here.
> Our intention is to implement our own compute params callback.
> Sorry, instead of making a copied one , we could have exported this
> API.

ok.

>>> +static int amd_sdwc_compute_params(struct sdw_bus *bus)
>>> +{
>>> +	struct sdw_transport_data t_data = {0};
>>> +	struct sdw_master_runtime *m_rt;
>>> +	struct sdw_port_runtime *p_rt;
>>> +	struct sdw_bus_params *b_params = &bus->params;
>>> +	int port_bo, hstart, hstop, sample_int;
>>> +	unsigned int rate, bps;
>>> +
>>> +	port_bo  = 0;
>>> +	hstart = 1;
>>> +	hstop = bus->params.col - 1;
>>> +	t_data.hstop = hstop;
>>> +	t_data.hstart = hstart;
>>> +
>>> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>>> +		rate = m_rt->stream->params.rate;
>>> +		bps = m_rt->stream->params.bps;
>>> +		sample_int = (bus->params.curr_dr_freq / rate);
>>> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>>> +			port_bo = (p_rt->num * 64) + 1;
>>> +			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
>>> +				p_rt->num, hstart, hstop, port_bo);
>>> +			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
>>> +					      false, SDW_BLK_GRP_CNT_1, sample_int,
>>> +					      port_bo, port_bo >> 8, hstart, hstop,
>>> +					      SDW_BLK_PKG_PER_PORT, 0x0);
>>> +
>>> +			sdw_fill_port_params(&p_rt->port_params,
>>> +					     p_rt->num, bps,
>>> +					     SDW_PORT_FLOW_MODE_ISOCH,
>>> +					     b_params->m_data_mode);
>>> +			t_data.hstart = hstart;
>>> +			t_data.hstop = hstop;
>>> +			t_data.block_offset = port_bo;
>>> +			t_data.sub_block_offset = 0;
>>> +		}
>>> +		amd_sdwc_compute_slave_ports(m_rt, &t_data);
>>> +	}
>>> +	return 0;
>>> +}
>> this is a variation on sdw_compute_master_ports() in generic_allocation.c
>>
>> You would need a lot more comments to convince me that this is
>> intentional and needed.
> This is intentional. We have a HW bug, if we go it generic bdw allocation
> API, when we launch multiple streams, we are observing noise for shorter
> duration for active stream.
> To avoid that, we have slightly modified the sdw_compute_master_ports()
> API. As of now we are enabling solution for 48khz, 2Ch, 16bit.
> We will expand the coverage in the future.

That's fine, it's perfectly ok to have different strategies on the host
side. Exporting additional functions from generic_bandwidth_allocation.c
would help, you can pick what you need.
  
>>> +
>>> +static int amd_sdwc_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
>>> +				unsigned int bank)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>> +	u32 channel_type, frame_fmt_reg, dpn_frame_fmt;
>>> +
>>> +	dev_dbg(ctrl->dev, "%s: p_params->num:0x%x\n", __func__, p_params->num);
>>> +	switch (ctrl->instance) {
>>> +	case ACP_SDW0:
>>> +		channel_type = p_params->num;
>>> +		break;
>>> +	case ACP_SDW1:
>>> +		channel_type = p_params->num + ACP_SDW0_MAX_DAI;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	switch (channel_type) {
>>> +	case ACP_SDW0_AUDIO_TX:
>> you'll have to explain what you mean by 'channel_type'
>>
>> This looks like the streams that can be supported by this master
>> implementation, with dailinks for each.
> SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
> whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
> 
> Each port number on Manager side is mapped to a channel number.
> i.e SDW0 Pin0 -> port number 0 -> Audio TX
>     SDW0 Pin1 -> Port number 1 -> Headset TX
>     SDW0 Pin2 -> Port number 2 -> BT TX
>     SDW0 Pin3 -> port number 3 -> Audio RX
>     SDW0 Pin4 -> Port number 4 -> Headset RX
>     SDW0 Pin5 -> Port number 5 -> BT RX
> 
> Whereas for SDW1 instance
> 
>     SDW1 Pin0 -> port number 0 -> P1 BT TX
>     SDW1 Pin1 -> Port number 1 -> P1 BT RX
>     
> We use this channel value to program register set for transport params,
> port params and Channel enable for each manager instance.
> We need to use same channel mapping for programming DMA controller
> registers in Soundwire DMA driver.
> i.e if AUDIO TX channel is selected then we need to use Audio TX registers
> for DMA programming in Soundwire DMA driver.

Ah, that's an important piece of information that should probably be
captured to help reviewers. On the Intel side the assignment from stream
types to ports is handled at the machine driver + topology level.


>>> +static int amd_sdwc_transport_params(struct sdw_bus *bus,
>>> +				     struct sdw_transport_params *params,
>>> +				     enum sdw_reg_bank bank)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>> +	u32 ssp_counter_reg;
>>> +	u32 dpn_frame_fmt;
>>> +	u32 dpn_sampleinterval;
>>> +	u32 dpn_hctrl;
>>> +	u32 dpn_offsetctrl;
>>> +	u32 dpn_lanectrl;
>>> +	u32 channel_type;
>>> +	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
>>> +	u32 offset_reg, lane_ctrl_reg;
>>> +
>>> +	switch (ctrl->instance) {
>>> +	case ACP_SDW0:
>>> +		ssp_counter_reg = ACP_SW_SSP_COUNTER;
>>> +		channel_type = params->port_num;
>>> +		break;
>>> +	case ACP_SDW1:
>>> +		ssp_counter_reg = ACP_P1_SW_SSP_COUNTER;
>>> +		channel_type = params->port_num + ACP_SDW0_MAX_DAI;
>> There's obviously a dependency between SDW0 and SDW1 managers that you
>> haven't described?
> No, both are independent manager instances which are connected in
> different power domains.

if they are independent, then why does the channel type for SDW1 depends
on SDW0_MAX_DAI?

>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, ctrl->mmio + ssp_counter_reg);
>>> +	dev_dbg(bus->dev, "%s: p_params->num:0x%x entry channel_type:0x%x\n",
>>> +		__func__, params->port_num, channel_type);
>>> +
>>> +	switch (channel_type) {
>>> +	case ACP_SDW0_AUDIO_TX:
>>> +	{
>>> +		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
>>> +		sample_int_reg = ACP_SW_AUDIO_TX_SAMPLEINTERVAL;
>>> +		hctrl_dp0_reg = ACP_SW_AUDIO_TX_HCTRL_DP0;
>>> +		offset_reg = ACP_SW_AUDIO_TX_OFFSET_DP0;
>>> +		lane_ctrl_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;
>> This is confusing. Is this about enabling a stream or selecting the lane
>> for this port? Same for all cases.
>>
>> is this saying that the two cases are handled by the same register -
>> unlike what is normative for the peripherals where the two concepts are
>> handeld in DPN_ChannelEn and DPN_LaneCtrl registers?
> we have to refer the same register to program channel enable and lane
> ctrl as per our soundwire register definition.

ok, please clarify with a comment. It's fine but different from other
implementations on device and host sides.

>>> +static int sdw_master_read_amd_prop(struct sdw_bus *bus)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>> +	struct fwnode_handle *link;
>>> +	struct sdw_master_prop *prop;
>>> +	u32 quirk_mask = 0;
>>> +	u32 wake_en_mask = 0;
>>> +	u32 power_mode_mask = 0;
>>> +	char name[32];
>>> +
>>> +	prop = &bus->prop;
>>> +	/* Find master handle */
>>> +	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
>>> +	link = device_get_named_child_node(bus->dev, name);
>>> +	if (!link) {
>>> +		dev_err(bus->dev, "Master node %s not found\n", name);
>>> +		return -EIO;
>>> +	}
>>> +	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
>>> +	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
>>> +		prop->hw_disabled = true;
>> same quirk as Intel, nice :-)
>>
>>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
>>> +		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
>> And here too. Is this really needed or just-copy-pasted?
> No, It's not a copy and paste. We have seen issues bus clash/parity errors
> during peripheral enumeration/initialization across the multiple links without
> this quirk. We have also seen device alerts missed during peripheral initialization
> sequence.

ah, that's good to some extent that it wasn't the Intel IP behaving :-)

