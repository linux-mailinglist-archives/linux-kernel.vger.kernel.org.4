Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC468C8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBFVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBFVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:30:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48F10E6;
        Mon,  6 Feb 2023 13:30:52 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316L60SI002709;
        Mon, 6 Feb 2023 21:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zbR5LulAkMDAwasH7HVAV3wgUEtOGkuSRw4Nc4x62YI=;
 b=U7SjhRJYz8CwVbM+Xari4paPf0x+K8tf2HQmofDjj6yK8FgStyhkIRj+aLXm3uQL16NQ
 IhtvdS3WM6bAvk/IfjjNOkQ2fcKiqEKbRnHcJRFwfdmg0t2qVuj27TDRLtJHQveovxqz
 1Aue84D4wC1YW9Wg8qprUmNnkp5q6hfgKhY9DnmZMKIjyEy7jCRFMBnpMJ6N9IAEbgo9
 avDhY1PsMou/JeafaWTfxNIjOtj1A4qyMCFq6jNbT+CliGcRpQt2ayMatwucPAuuCRXC
 zeLEmmDW8xccOQmr+RztXgtKduhA1qdYK50GuSvfEgn9eYYH/rv71UVVOfu2hvq6nKTG aA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhey74rxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 21:30:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316LUVHl025673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 21:30:31 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 13:30:31 -0800
Message-ID: <7d73182d-9662-196a-2831-6ab50fb08040@quicinc.com>
Date:   Mon, 6 Feb 2023 13:30:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 22/27] virt: gunyah: Add resource tickets
Content-Language: en-US
To:     Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-23-quic_eberman@quicinc.com>
 <20230206095010.GF332@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230206095010.GF332@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vxeY4GnvZkx7rE5pfUFshOJZXft8JnD5
X-Proofpoint-GUID: vxeY4GnvZkx7rE5pfUFshOJZXft8JnD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060186
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 1:50 AM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:21]:
> 
>> +int ghvm_add_resource_ticket(struct gunyah_vm *ghvm, struct gunyah_vm_resource_ticket *ticket)
>> +{
>> +	struct gunyah_vm_resource_ticket *iter;
>> +	struct gunyah_resource *ghrsc;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&ghvm->resources_lock);
>> +	list_for_each_entry(iter, &ghvm->resource_tickets, list) {
>> +		if (iter->resource_type == ticket->resource_type && iter->label == ticket->label) {
>> +			ret = -EEXIST;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	if (!try_module_get(ticket->owner)) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	list_add(&ticket->list, &ghvm->resource_tickets);
>> +	INIT_LIST_HEAD(&ticket->resources);
>> +
>> +	list_for_each_entry(ghrsc, &ghvm->resources, list) {
>> +		if (ghrsc->type == ticket->resource_type && ghrsc->rm_label == ticket->label) {
>> +			if (!ticket->populate(ticket, ghrsc))
>> +				list_move(&ghrsc->list, &ticket->resources);
> 
> Do we need the search to continue in case of a hit? 'gh_vm_add_resource' seems to
> break loop on first occurrence.
> 
> Also do we have examples of more than one 'gunyah_resource' being associated
> with same 'gunyah_vm_resource_ticket'?  Both vcpu and irqfd tickets seem to deal
> with just one resource?
> 

I'll mention this in the commit text as well.

Resources are created by Gunyah as configured in the VM's devicetree 
configuration. Gunyah doesn't process the label and that makes it 
possible for userspace to create multiple resources with the same label. 
The kernel needs to be prepared for that to happen. IMO, this isn't a 
framework issue, so I've chosen the policy to be "many-to-one": resource 
tickets can bind to many resources and resources are bound to only one 
ticket. If the resource ticket handler isn't designed to accept multiple 
resources, they can skip/ignore any further populate callbacks.

>>   static int gh_vm_start(struct gunyah_vm *ghvm)
>>   {
>>   	struct gunyah_vm_memory_mapping *mapping;
>>   	u64 dtb_offset;
>>   	u32 mem_handle;
>> -	int ret;
>> +	struct gunyah_resource *ghrsc;
>> +	struct gh_rm_hyp_resources *resources;
>> +	int ret, i;
>>   
>>   	down_write(&ghvm->status_lock);
>>   	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
>> @@ -241,6 +314,22 @@ static int gh_vm_start(struct gunyah_vm *ghvm)
>>   		goto err;
>>   	}
>>   
>> +	ret = gh_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
>> +	if (ret) {
>> +		pr_warn("Failed to get hypervisor resources for VM: %d\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	for (i = 0; i < le32_to_cpu(resources->n_entries); i++) {
> 
> minor nit: not sure if we can rely on compiler to optimize this, but it would
> be better if we run le32_to_cpu once and use the result in loop.
> 

Done.

>> +		ghrsc = gh_rm_alloc_resource(ghvm->rm, &resources->entries[i]);
>> +		if (!ghrsc) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		gh_vm_add_resource(ghvm, ghrsc);
> 
> Shouldn't we have gh_vm_add_resource()->  ticket->populate() return a result and
> in case of failure we should bail out from this loop?
> 

I'm hesitant to treat the resource ticket rejecting the resource as a 
bail condition.

Userspace is able to detect when functions didn't get set up and I 
wanted to avoid adding further complexity to kernel drivers.

>> +	}
>> +
>>   	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
>>   	if (ret) {
>>   		pr_warn("Failed to start VM: %d\n", ret);
