Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A55F057C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiI3HH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3HH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:07:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F51D1E05;
        Fri, 30 Sep 2022 00:07:26 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TMMAgO031279;
        Fri, 30 Sep 2022 07:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cpe9+CyMBbm0Fzdft0P4vpebJzoY8GmmZAAYH2YkQxM=;
 b=GWOtmdDXbCV+dGm5hnzHwkEh9d06i10c3cV6M95V5Ax2Hc9z4aY7tnzsBl0n51iBg/Rv
 ygS0IuSrWcFBWmbqENWOZgyvNONYGida7EvPPtVCGpxlHXJe2wKLybLg3OpeYLvyEGvZ
 RdwOaLjVDqNxmaNqiASXV0/pcac6So7A/EWzNLZ0wC0DSfklmCX6A0wLYU9+0iugIWQa
 GINuNYpxt+Kxg/c+dd9RBMd6zpAvaxvR0Ons97cqs+AMqoBmGJxLGl8EIfaa/eOd7Cw5
 iwGYYT/i1SOorlTRnvQaN7YC7zd37WbNJGHUmmAun30IT3jNakT4m/MxnNz6zhD6ZlfP Aw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwc0dk0jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 07:07:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28U77JUa001345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 07:07:19 GMT
Received: from [10.110.86.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 00:07:14 -0700
Message-ID: <686c07a8-1b53-b60b-940b-bcb659aaf026@quicinc.com>
Date:   Fri, 30 Sep 2022 12:37:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V14 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Alex Elder" <elder@ieee.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <c286f5e35348253809146ef45840339509e36ff8.1664383851.git.quic_schowdhu@quicinc.com>
 <20220929162357.53u5shcmdrkivzue@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20220929162357.53u5shcmdrkivzue@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FyANFbQI0Ez_WOzKH54aE_k3nXQXFsZH
X-Proofpoint-ORIG-GUID: FyANFbQI0Ez_WOzKH54aE_k3nXQXFsZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300042
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2022 9:53 PM, Bjorn Andersson wrote:
> On Wed, Sep 28, 2022 at 10:41:12PM +0530, Souradeep Chowdhury wrote:
> [..]
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
> [..]
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:		Base Address of the dcc device
>> + * @dev:		The device attached to the driver data
>> + * @mutex:		Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:		Base address for the SRAM dedicated for the dcc device
>> + * @ram_size:		Total size of the SRAM dedicated for the dcc device
>> + * @ram_offset:	Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:	Memory map version of DCC hardware
>> + * @ram_cfg:		Used for address limit calculation for dcc
>> + * @ram_start:		Starting address of DCC SRAM
>> + * @sram_dev:		Miscellaneous device equivalent of dcc SRAM
>> + * @cfg_head:		Points to the head of the linked list of addresses
>> + * @dbg_dir:		The dcc debugfs directory under which all the debugfs files are placed
>> + * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
>> + * @loopoff:		Loop offset bits range for the addresses
>> + * @enable;		This contains an array of linkedlist enable flags
>> + */
>> +struct dcc_drvdata {
>> +	void __iomem		*base;
>> +	void                    *ram_base;
>> +	struct device		*dev;
>> +	struct mutex		mutex;
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
> It's idiomatic to carry such information in a bitmap, and if
> DCC_MAX_LINK_LIST applies to all versions (not obvious from the code
> below) then replacing this with just a fixed unsigned long would be a
> good move.
>
> Use set_bit(), clear_bit() and test_bit() as needed to access the
> individual bits.
Ack
>
>> +};
>> +
>> +struct dcc_cfg_attr {
>> +	u32	addr;
>> +	u32	prev_addr;
>> +	u32	prev_off;
>> +	u32	link;
>> +	u32	sram_offset;
>> +};
>> +
>> +struct dcc_cfg_loop_attr {
>> +	u32	loop;
>> +	u32	loop_cnt;
>> +	u32	loop_len;
>> +	u32	loop_off;
>> +	bool    loop_start;
>> +};
>> +
> [..]
>> +static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
>> +{
>> +	int list;
>> +
>> +	for (list = 0; list < DCC_MAX_LINK_LIST; list++)
> It's possible that there's only dcc->nr_link_list entries in the enable
> array.
Ack
>
>> +		if (drvdata->enable[list])
>> +			return true;
>> +
>> +	return false;
>> +}
> [..]
>> +static int dcc_probe(struct platform_device *pdev)
>> +{
>> +	u32 val;
>> +	int ret = 0, i, size;
>> +	struct device *dev = &pdev->dev;
>> +	struct dcc_drvdata *dcc;
>> +	struct resource *res;
>> +
>> +	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
>> +	if (!dcc)
>> +		return -ENOMEM;
>> +
>> +	dcc->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, dcc);
>> +
>> +	dcc->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(dcc->base))
>> +		return PTR_ERR(dcc->base);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	dcc->ram_base = memremap(res->start, resource_size(res), MEMREMAP_WB);
>> +	if (!dcc->ram_base)
>> +		return -ENODEV;
>> +
>> +	dcc->ram_size = resource_size(res);
>> +
>> +	dcc->ram_offset = (size_t)of_device_get_match_data(&pdev->dev);
>> +
>> +	val = dcc_readl(dcc, DCC_HW_INFO);
>> +
>> +	if (FIELD_GET(DCC_VER_INFO_MASK, val)) {
>> +		dcc->mem_map_ver = 3;
>> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +		if (dcc->nr_link_list == 0)
>> +			return	-EINVAL;
>> +	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
>> +		dcc->mem_map_ver = 2;
>> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +		if (dcc->nr_link_list == 0)
>> +			return	-EINVAL;
>> +	} else {
>> +		dcc->mem_map_ver = 1;
>> +		dcc->nr_link_list = DCC_MAX_LINK_LIST;
>> +	}
>> +
>> +	/* Either set the fixed loop offset or calculate it
>> +	 * from ram_size. Max consecutive addresses the
>> +	 * dcc can loop is equivalent to the ram size
>> +	 */
>> +	if (val & DCC_LOOP_OFFSET_MASK)
>> +		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
>> +	else
>> +		dcc->loopoff = get_bitmask_order((dcc->ram_size +
>> +				dcc->ram_offset) / 4 - 1);
>> +
>> +	mutex_init(&dcc->mutex);
>> +	/* Allocate space for all entries at once */
>> +	size = sizeof(*dcc->enable) + sizeof(*dcc->cfg_head);
>> +
>> +	dcc->enable = devm_kcalloc(dev, dcc->nr_link_list, size, GFP_KERNEL);
>> +	if (!dcc->enable)
>> +		return -ENOMEM;
>> +
>> +	dcc->cfg_head = (struct list_head *)(dcc->enable + dcc->nr_link_list);
> Turning enable into a unsigned long bitmap, will clean this stuff up as
> well, as you won't have the need/urge to allocate the two components at
> once and then do pointer math on them...
Ack
>
> Regards,
> Bjorn
>
>> +
>> +	for (i = 0; i < dcc->nr_link_list; i++)
>> +		INIT_LIST_HEAD(&dcc->cfg_head[i]);
>> +
>> +	ret = dcc_sram_dev_init(dcc);
>> +	if (ret) {
>> +		dev_err(dcc->dev, "DCC: sram node not registered.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = dcc_create_debug_dir(dcc);
>> +	if (ret) {
>> +		dev_err(dcc->dev, "DCC: debugfs files not created.\n");
>> +		dcc_sram_dev_exit(dcc);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
