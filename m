Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADE681D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjA3Vnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3Vnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:43:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95C768E;
        Mon, 30 Jan 2023 13:43:42 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULPRQ7019525;
        Mon, 30 Jan 2023 21:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J9CFGVL6rsoTrkTF9qPIzObggqcrRWiKnHc9DU+7ZE4=;
 b=WEIK9zmNlP1nvCtp3g6RtjTwBY9V0/TW7zeRSTFjp0AifK/SyoqC9DAbSW+TEaqW/6Zl
 W50hSGosGNnm9Z0ch+QTRjxlvkUABksuVUZx36wEo03tYRUXmPVdstwVTDu7yAEMeHBn
 JAHfNdjsd68gtgO/IMQ/dmnXMMSO1FfVHyAawC5L02+47M6wSPX62qwgRf+huHf3x4Zs
 nB6xGlI6kZTA7pTVurW0Ma20XgYYulybdsY4zy36TTiiG3KgLGpIBt11+eUzXC62imBw
 +CUPakto6nBQRJ+OS+ulV81AAJxzzU4wseg+VPDv4sfiAybRgaS7V/nlLCmx3xGz/Qa6 tw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncw0g4kra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:43:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULhT6E012092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:43:29 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:43:29 -0800
Message-ID: <0d201cd9-320a-173e-1f90-5d6b3fc373a9@quicinc.com>
Date:   Mon, 30 Jan 2023 13:43:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 10/27] gunyah: rsc_mgr: Add VM lifecycle RPC
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
 <20230120224627.4053418-11-quic_eberman@quicinc.com>
 <20230125060929.GA3779774@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230125060929.GA3779774@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zBERMXMths14wZs_iBcJVS40yuelQe__
X-Proofpoint-ORIG-GUID: zBERMXMths14wZs_iBcJVS40yuelQe__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=789
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300201
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 10:12 PM, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:09]:
> 
>> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
>> +{
>> +	struct gh_vm_stop_req req_payload = {
>> +		.vmid = cpu_to_le16(vmid),
>> +	};
>> +	void *resp;
>> +	size_t resp_size;
>> +	int ret;
>> +
>> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
>> +			&resp, &resp_size);
> 
> Why not use gh_rm_common_vmid_call() here as well?
> 
>          return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_STOP, vmid);
> 
> 

gh_vm_stop_req isn't the same as the common payload.
