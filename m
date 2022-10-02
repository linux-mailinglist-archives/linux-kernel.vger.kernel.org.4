Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A245F2737
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJBXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJBXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:31:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2A2AE0E;
        Sun,  2 Oct 2022 16:31:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 292NPqoC009416;
        Sun, 2 Oct 2022 23:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OZzBMFoUgJ5NblhfxO/d/8AT214Y8rmmcdR/ZXi9TKw=;
 b=Jq/od7vWUFihDbeeAo20GDoXsta2AJkFi18uF1vEzVUb+5z8gqeAiJmvNfSC0hiBeds4
 tB+6yz5ssZ/kTUnjE50mlc2DSPdvGqvMCP0w9q8WsoSjCX8KApUf2cGjRsX4tiZVLSQA
 mw1wQvb0PznX7sTvcEa89lhbSq22jAoUiNWSR2VaCP2qfQMqBbvm+tOZXQvSZ9bsswFD
 KW8jsI5/r+2mluuSRI7rT0l4OamWGtqjrsmBLKb3KTAAi8prQwLszrpv2fDZL5Kzf1fK
 LLZ8hxZ9A31ONhitHJDsjhisKZbAQzW9LiKjmII6jmEeUdbi8+/cyoYgpYZnQpHBZjB2 Rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxb8navvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Oct 2022 23:30:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 292NUX79002687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Oct 2022 23:30:33 GMT
Received: from [10.110.51.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 16:30:31 -0700
Message-ID: <1f599b97-9242-3844-4372-1610948f4baf@quicinc.com>
Date:   Sun, 2 Oct 2022 16:30:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported
 features
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-11-quic_eberman@quicinc.com>
 <3c02aad6d8bde70964b403a3cb8004de969becc6.camel@perches.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3c02aad6d8bde70964b403a3cb8004de969becc6.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y-SxWOGjvOMLTZ5hHoe76VMIDI4OrmOO
X-Proofpoint-GUID: y-SxWOGjvOMLTZ5hHoe76VMIDI4OrmOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-02_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210020155
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 12:36 AM, Joe Perches wrote:
> On Wed, 2022-09-28 at 12:56 -0700, Elliot Berman wrote:
>> Add a sysfs node to list the features that the Gunyah hypervisor and
>> Linux supports. For now, Linux support cspace (capability IDs) and
>> message queues, so only report those..
> []
>> diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
> []
>> @@ -25,9 +25,24 @@ static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, c
>>   }
>>   static struct kobj_attribute variant_attr = __ATTR_RO(variant);
>>   
>> +static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
>> +{
>> +	int len = 0;
>> +
>> +	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
>> +		len += sysfs_emit_at(buffer, len, "cspace ");
>> +	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
>> +		len += sysfs_emit_at(buffer, len, "message-queue ");
>> +
>> +	len += sysfs_emit_at(buffer, len, "\n");
>> +	return len;
>> +}
> 
> It's generally nicer to avoid unnecessary output spaces.
> 
> Perhaps:
> 
> {
> 	int len = 0;
> 
> 	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
> 		len += sysfs_emit_at(buffer, len, "cspace");
> 	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags)) {
> 		if (len)
> 			len += sysfs_emit_at(buffer, len, " ");
> 		len += sysfs_emit_at(buffer, len, "message-queue");
> 	}
> 
> 	len += sysfs_emit_at(buffer, len, "\n");
> 
> 	return len;
> }
> 

that approach seems ok for 2 features, but imo doesn't scale for more.
I like the original code with one exception:

	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
		len += sysfs_emit_at(buffer, len, "cspace ");
	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
		len += sysfs_emit_at(buffer, len, "message-queue ");

	/* overwrite last trailing space */
	if (len)
		len--;

	len += sysfs_emit_at(buffer, len, "\n");
	return len;

