Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977AC5BC249
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiISEjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiISEjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:39:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623B64C1;
        Sun, 18 Sep 2022 21:39:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J4UP9k030459;
        Mon, 19 Sep 2022 04:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GY6cxSLEjAPqtPGChpgCJd9xrcdtkSAmTq6McigOdqc=;
 b=T/fPpeT5dheBTAfA0/YGOW/jFCjL1B079EEcNP9ua2AuWW6X2yDsMQKKwj7nQIZt7bWk
 w7jwBQsapmBDhUFRM68iM3xt80Txx/adXIkrjv58mZhI1ST7bef+vTvzDUNEB7/ecKFg
 Hr2N5/o5jS9g63d93zDK4nOPV0Ra6vf59VMpPwEbqz6Hvm+1ZiHd2CV81iu6n/4MJIZ7
 Z5JGFSpy7gXE+282ZAyFOQB87KXnScObfYOYODKePl1UPIdEmx/dUtZArdh0DRrL4api
 fj2YscCtBUI9eVb7FjXEIr6xdV/i7PJnlkjqASsKsrCh9AKeGIhMYpRToS0X9grdy+AN tQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6by2ymc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 04:39:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28J4dSOu015672
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 04:39:28 GMT
Received: from [10.110.123.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 18 Sep
 2022 21:39:23 -0700
Message-ID: <862e74d9-6390-f0ab-3708-039f987e7a1e@quicinc.com>
Date:   Mon, 19 Sep 2022 10:09:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V11 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Alex Elder" <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663313821.git.quic_schowdhu@quicinc.com>
 <453efd9a436868a125225226dad9cc28965b75c1.1663313821.git.quic_schowdhu@quicinc.com>
 <20220917001618.au7hlduxntj6i4no@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20220917001618.au7hlduxntj6i4no@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FdnGSan4lP095felKnnSatZGiPC2GqWu
X-Proofpoint-GUID: FdnGSan4lP095felKnnSatZGiPC2GqWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190030
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/2022 5:46 AM, Bjorn Andersson wrote:
> On Fri, Sep 16, 2022 at 02:20:14PM +0530, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers. The DCC operates
>> based on user inputs via the debugfs interface. The user gives
>> addresses as inputs and these addresses are stored in the
>> dcc sram. In case of a system crash or a manual software
>> trigger by the user through the debugfs interface,
>> the dcc captures and stores the values at these addresses.
>> This patch contains the driver which has all the methods
>> pertaining to the debugfs interface, auxiliary functions to
>> support all the four fundamental operations of dcc namely
>> read, write, read/modify/write and loop. The probe method
>> here instantiates all the resources necessary for dcc to
>> operate mainly the dedicated dcc sram where it stores the
>> values. The DCC driver can be used for debugging purposes
>> without going for a reboot since it can perform software
>> triggers as well based on user inputs.
>>
>> Also added the documentation for debugfs entries and explained
>> the functionalities of each debugfs file that has been created
>> for dcc.
>>
>> The following is the justification of using debugfs interface
>> over the other alternatives like sysfs/ioctls
>>
>> i) As can be seen from the debugfs attribute descriptions,
>> some of the debugfs attribute files here contains multiple
>> arguments which needs to be accepted from the user. This goes
>> against the design style of sysfs.
>>
>> ii) The user input patterns have been made simple and convenient
>> in this case with the use of debugfs interface as user doesn't
>> need to shuffle between different files to execute one instruction
>> as was the case on using other alternatives.
>>
> Thanks for fixing up the checkpatch warnings.
>
> I did unfortunately find a few more things as I was looking through this
> revision.
>
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
>> new file mode 100644
>> index 0000000..7e07f1a
>> --- /dev/null
>> +++ b/drivers/soc/qcom/dcc.c
>> @@ -0,0 +1,1341 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copneight (c) 2015-2021, The Linex Fnendation. All rights reserved.
> Something funny happened to Copneight, Linuex and Fnendation.
>
> Should you perhaps also bump the year to 2022?
Ack
>
>> + */
> [..]
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:	      Base Address of the dcc device
>> + * @dev:	      The device attached to the driver data
>> + * @mutex:	      Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:         Base address for the SRAM dedicated for the dcc device
> @ram_size missing
Ack
>
>> + * @ram_offset:       Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:      Memory map version of DCC hardware
>> + * @ram_cfg:          Used for address limit calculation for dcc
>> + * @ram_start:        Starting address of DCC SRAM
>> + * @sram_dev:	      Micellaneous device equivalent of dcc SRAM
>> + * @cfg_head:	      Points to the head of the linked list of addresses
>> + * @dbg_dir:          The dcc debugfs directory under which all the debugfs files are placed
>> + * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
>> + * @loopoff:          Loop offset bits range for the addresses
>> + * @enable:           This contains an array of linkedlist enable flags
>> + */
>> +struct dcc_drvdata {
>> +	void __iomem		*base;
>> +	struct device		*dev;
>> +	struct mutex		mutex;
>> +	void __iomem		*ram_base;
>> +	size_t			ram_size;
>> +	size_t			ram_offset;
>> +	int			mem_map_ver;
>> +	phys_addr_t		ram_cfg;
>> +	phys_addr_t		ram_start;
>> +	struct miscdevice	sram_dev;
>> +	struct list_head	*cfg_head;
>> +	struct dentry		*dbg_dir;
>> +	size_t			nr_link_list;
>> +	u8			loopoff;
>> +	bool                    *enable;
>> +};
> [..]
>> +static int dcc_read_and_clear(struct dcc_drvdata *drvdata)
>> +{
>> +	int i;
>> +	u32 bus_status;
>> +	u32 ll_cfg;
>> +	u32 tmp_ll_cfg;
>> +
>> +	for (i = 0; i < drvdata->nr_link_list; i++) {
>> +		if (!drvdata->enable[i])
>> +			continue;
>> +
>> +		bus_status = dcc_ll_readl(drvdata, i, DCC_LL_BUS_ACCESS_STATUS);
>> +		if (!bus_status)
>> +			continue;
>> +
>> +		dev_err(drvdata->dev,
>> +			"Read access error for list %d err: 0x%x.\n", i, bus_status);
> This can be unwrapped, or it would look more natural if you wrapped it
> after the string.
>
> You should also drop the '.' at the end of the message.
>
> If you want to shorten it down a little bit more, you could rename
> bus_status to status, as there's no ambiguity here.
Ack
>
>> +		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
>> +		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
>> +		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
>> +		dcc_ll_writel(drvdata, DCC_STATUS_MASK, i,
>> +			      DCC_LL_BUS_ACCESS_STATUS);
> This can be unwrapped.
Ack
>
>> +		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
>> +		return -ENODATA;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
>> +{
>> +	void __iomem *addr;
>> +	int ret;
>> +	int i;
>> +	u32 ll_cfg;
>> +	u32 tmp_ll_cfg;
>> +	u32 val;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	for (i = 0; i < drvdata->nr_link_list; i++) {
>> +		if (!drvdata->enable[i])
>> +			continue;
>> +		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
>> +		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
>> +		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
>> +		dcc_ll_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
>> +		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
>> +	}
>> +
>> +	addr = drvdata->base + DCC_STATUS(drvdata->mem_map_ver);
>> +	if (readl_poll_timeout(addr, val, (FIELD_GET(DCC_STATUS_MASK, val) == 0),
>> +			       1, STATUS_READY_TIMEOUT)) {
>> +		dev_err(drvdata->dev,
>> +			"DCC is busy after receiving sw tigger.\n");
> Unwrapp this please, and drop the '.' at the end.
Ack
>
>> +		ret = -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = dcc_read_and_clear(drvdata);
>> +
>> +out_unlock:
>> +	mutex_unlock(&drvdata->mutex);
>> +	return ret;
>> +}
>> +
>> +static void _dcc_ll_cfg_reset_link(struct dcc_cfg_attr *cfg)
>> +{
>> +	cfg->addr = 0x00;
>> +	cfg->link = 0;
>> +	cfg->prev_off = 0;
>> +	cfg->prev_addr = cfg->addr;
>> +}
>> +
>> +static void _dcc_emit_read_write(struct dcc_drvdata *drvdata,
>> +				 struct dcc_config_entry *entry,
>> +				 struct dcc_cfg_attr *cfg)
>> +{
>> +	if (cfg->link) {
>> +		/*
>> +		 * write new offset = 1 to continue
>> +		 * processing the list
>> +		 */
>> +
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +		/* Reset link and prev_off */
>> +		_dcc_ll_cfg_reset_link(cfg);
>> +	}
>> +
>> +	cfg->addr = DCC_RD_MOD_WR_DESCRIPTOR;
>> +	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->mask, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
>> +
>> +	cfg->addr = 0;
>> +}
>> +
>> +static void _dcc_emit_loop(struct dcc_drvdata *drvdata, struct dcc_config_entry *entry,
>> +			   struct dcc_cfg_attr *cfg,
>> +			   struct dcc_cfg_loop_attr *cfg_loop,
>> +			   u32 *total_len)
>> +{
>> +	/* Check if we need to write link of prev entry */
>> +	if (cfg->link)
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +	if (cfg_loop->loop_start) {
>> +		cfg_loop->loop = (cfg->sram_offset - cfg_loop->loop_off) / 4;
>> +		cfg_loop->loop |= (cfg_loop->loop_cnt << drvdata->loopoff) &
>> +		GENMASK(DCC_ADDR_LIMIT, drvdata->loopoff);
> Odd line wrap. Please indent better.
Ack
>
>> +		cfg_loop->loop |= DCC_LOOP_DESCRIPTOR;
>> +		*total_len += (*total_len - cfg_loop->loop_len) * cfg_loop->loop_cnt;
>> +
>> +		dcc_sram_write_auto(drvdata, cfg_loop->loop, &cfg->sram_offset);
>> +
>> +		cfg_loop->loop_start = false;
>> +		cfg_loop->loop_len = 0;
>> +		cfg_loop->loop_off = 0;
>> +	} else {
>> +		cfg_loop->loop_start = true;
>> +		cfg_loop->loop_cnt = entry->loop_cnt - 1;
>> +		cfg_loop->loop_len = *total_len;
>> +		cfg_loop->loop_off = cfg->sram_offset;
>> +	}
>> +
>> +	/* Reset link and prev_off */
>> +	_dcc_ll_cfg_reset_link(cfg);
>> +}
>> +
>> +static void _dcc_emit_write(struct dcc_drvdata *drvdata,
>> +			    struct dcc_config_entry *entry,
>> +			    struct dcc_cfg_attr *cfg,
>> +			    u32 *total_len)
>> +{
>> +	u32 off;
>> +
>> +	if (cfg->link) {
>> +		/*
>> +		 * write new offset = 1 to continue
>> +		 * processing the list
>> +		 */
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +		/* Reset link and prev_off */
>> +		cfg->addr = 0x00;
>> +		cfg->prev_off = 0;
>> +		cfg->prev_addr = cfg->addr;
>> +	}
>> +
>> +	off = entry->offset / 4;
>> +	/* write new offset-length pair to correct position */
>> +	cfg->link |= ((off & GENMASK(7, 0)) | BIT(15) | ((entry->len << 8) & GENMASK(14, 8)));
> Would it be possible to get some defines for these masks and bits?
> Perhaps use FIELD_PREP() instead of manually mask and shift the values.
Ack
>
>> +	cfg->link |= DCC_LINK_DESCRIPTOR;
>> +
>> +	/* Address type */
>> +	cfg->addr = (entry->base >> 4) & GENMASK(DCC_ADDR_LIMIT, 0);
>> +	if (entry->apb_bus)
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_APB_IND;
>> +	else
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_AHB_IND;
>> +	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
>> +
>> +	cfg->addr = 0x00;
>> +	cfg->link = 0;
>> +}
> [..]
>> +static ssize_t dcc_config_add_write(struct dcc_drvdata *drvdata, char *buf, int curr_list)
>> +{
>> +	int ret, bus;
>> +	int nval;
>> +	unsigned int addr, write_val;
>> +	char apb_bus[4];
>> +
>> +	nval = sscanf(buf, "%x %x %s", &addr, &write_val, apb_bus);
>> +
>> +	if (nval <= 1 || nval > 3)
>> +		return -EINVAL;
>> +
>> +	if (nval == 3) {
>> +		if (!strcmp("apb", apb_bus))
>> +			bus = 1;
>> +		else if (!strcmp("apb", apb_bus))
>> +			bus = 0;
>> +		else
>> +			return -EINVAL;
>> +	}
>> +
>> +	ret = dcc_add_write(drvdata, addr, write_val, bus, curr_list);
> return dcc_add_write(); and you can drop the local variable.
Ack
>
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t config_read(struct file *filp, char __user *userbuf,
>> +			   size_t count, loff_t *ppos)
>> +{
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +	struct dcc_config_entry *entry;
>> +	char local_buf[64], buf[100] = "\0";
>> +	int len = 0, tot_len = 0, index = 0, curr_list;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +	curr_list = dcc_filp_curr_list(filp);
>> +	if (curr_list < 0)
>> +		return curr_list;
>> +
>> +	list_for_each_entry(entry,
>> +			    &drvdata->cfg_head[curr_list], list) {
>> +		index++;
>> +		switch (entry->desc_type) {
>> +		case DCC_READ_WRITE_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +				       "Index: 0x%x, mask: 0x%x, val: 0x%x\n",
> Wouldn't it be nice if this matches the format used to specify the
> instructions?
>
> I.e. "RW <addr> <value> <mask>"
Ack
>
>> +				       index, entry->mask, entry->write_val);
>> +			break;
>> +		case DCC_LOOP_TYPE:
>> +			len = snprintf(local_buf, 64, "Index: 0x%x, Loop: %d\n",
>> +				       index, entry->loop_cnt);
>> +			break;
>> +		case DCC_WRITE_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +				       "Write Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
>> +				       index, entry->base, entry->offset, entry->len,
>> +				       entry->apb_bus);
>> +			break;
>> +		case DCC_READ_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +				       "Read Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
> Can't this generate something like:
>    Read Index: 0x1, Base: 0xaabbccdd, Offset: 0xaa, len: 0xaa APB: 1
> Afaict that's 65 bytes.
>
> If that's the case you will end up with tot_len > strlen(buf). You
> probably meant to use scnprintf(), which would return 63.
>
> But either way, the tail would be chopped of.
Ack
>
>> +				       index, entry->base, entry->offset,
>> +				       entry->len, entry->apb_bus);
>> +		}
>> +		tot_len += len;
>> +		strlcat(buf, local_buf, sizeof(local_buf));
> The limit should be the destination buffer, i.e. sizeof(buf).
>
> But why is sizeof(buf) only 100? If you have a RMW in there you will fit
> 1.5 entries in the buffer.
>
>
> I think it would be better to use single_open() and use the seq_file()
> interface for generating your data. That will handle the buffer
> management for you, among other things.
Ack
>
>> +	}
>> +	mutex_unlock(&drvdata->mutex);
>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, tot_len);
>> +}
>> +
>> +static ssize_t config_write(struct file *filp,
>> +			    const char __user *user_buf, size_t count,
>> +			    loff_t *ppos)
>> +{
>> +	int ret, curr_list;
>> +	char *token, buf[50];
>> +	char *delim = " ";
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	ret = copy_from_user(buf, user_buf, count);
> count might be > sizeof(buf).
Ack
>
>> +	if (ret)
>> +		return -EFAULT;
>> +
>> +	curr_list = dcc_filp_curr_list(filp);
>> +	if (curr_list < 0)
>> +		return curr_list;
>> +
>> +	if (buf[count - 1] == '\n')
> count can be 0.
Ack
>
>> +		buf[count - 1] = '\0';
> buf[] might not be \n or NUL-terminated.
Ack
>
>> +
>> +	token = strsep((char **)&buf, delim);
>> +
>> +	if (!strcmp("R", token)) {
>> +		ret = dcc_config_add_read(drvdata, buf, curr_list);
>> +	} else if (!strcmp("W", token)) {
>> +		ret = dcc_config_add_write(drvdata, buf, curr_list);
>> +	} else if (!strcmp("RW", token)) {
>> +		ret = dcc_config_add_read_write(drvdata, buf, curr_list);
>> +	} else if (!strcmp("L", token)) {
>> +		ret = dcc_config_add_loop(drvdata, buf, curr_list);
>> +	} else {
>> +		dev_err(drvdata->dev, "%s is not a correct input\n", token);
>> +		return -EINVAL;
>> +	}
> [..]
>> +static ssize_t dcc_sram_read(struct file *file, char __user *data,
>> +			     size_t len, loff_t *ppos)
>> +{
>> +	unsigned char *buf;
>> +	struct dcc_drvdata *drvdata = container_of(file->private_data,
>> +		struct dcc_drvdata,
>> +		sram_dev);
>> +
>> +	/* EOF check */
>> +	if (*ppos > drvdata->ram_size)
>> +		return 0;
>> +
>> +	if ((*ppos + len) > drvdata->ram_size)
>> +		len = (drvdata->ram_size - *ppos);
> If *ppos == drvdata->ram_size, the EOF check will miss that and len will
> be 0.
Ack
>
>> +
>> +	buf = kzalloc(len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
>> +
>> +	if (copy_to_user(data, buf, len)) {
>> +		kfree(buf);
>> +		return -EFAULT;
>> +	}
>> +
>> +	*ppos += len;
>> +
>> +	kfree(buf);
>> +
>> +	return len;
>> +}
>> +
> Regards,
> Bjorn
