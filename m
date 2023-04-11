Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD626DE5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDKUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDKUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:49:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396DF1BE6;
        Tue, 11 Apr 2023 13:49:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BKRFcH010765;
        Tue, 11 Apr 2023 20:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r0vK+wl4SMxBod+g47ckhsBivn+LupBy8MmSpCjVf0o=;
 b=Hd0D+Xc9E0Rnf1wCI5Dztudo6NY7MFnbtA0Qdl3QsHveKeCDj9oFFuJMzHRu2StuWv77
 Z+42p4slkICsFO/BD1LxE8YIU4jmz75fpo0jewBQjPbwNHeVNc7shDwvy7GquxE8KP4b
 pOzCCwaxWyV3UYb5rYjkJs4wgqeUcqthvarSfQMfivmicyEs4fLCBLjlr1gPzCQHVHym
 9WqciYLIPxxzHKoAigRgDem+afJQbLqGfivJtTztboHhGaqsaNfl4Xs825Dn9MpUsa0C
 r9BO8Qk4arXjqom8im07C3tZFjpxWFKLlSIiuqcL0DzPysQLDs09yodniwC6S3pNdBEl dw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwe6m02s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 20:48:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BKmirN003665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 20:48:44 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 13:48:43 -0700
Message-ID: <030888c7-1e32-1663-589a-55e998963ab7@quicinc.com>
Date:   Tue, 11 Apr 2023 13:48:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-11-quic_eberman@quicinc.com>
 <37bc641a-77b9-a740-a08e-8b86d0b50630@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <37bc641a-77b9-a740-a08e-8b86d0b50630@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 41EwfTKumxaNX_Md7CEUUj-4wSsvdCeI
X-Proofpoint-ORIG-GUID: 41EwfTKumxaNX_Md7CEUUj-4wSsvdCeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_14,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110187
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:25 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> @@ -129,6 +131,7 @@ struct gh_rm_connection {
>>    * @cache: cache for allocating Tx messages
>>    * @send_lock: synchronization to allow only one request to be sent 
>> at a time
>>    * @nh: notifier chain for clients interested in RM notification 
>> messages
>> + * @miscdev: /dev/gunyah
>>    */
>>   struct gh_rm {
>>       struct device *dev;
>> @@ -145,6 +148,8 @@ struct gh_rm {
>>       struct kmem_cache *cache;
>>       struct mutex send_lock;
>>       struct blocking_notifier_head nh;
>> +
>> +    struct miscdevice miscdev;
>>   };
>>   /**
>> @@ -593,6 +598,21 @@ void gh_rm_put(struct gh_rm *rm)
>>   }
>>   EXPORT_SYMBOL_GPL(gh_rm_put);
> 
> I feel like /dev/gunyah code would more appropriately be found
> in "vm_mgr.c".  All gh_dev_ioctl() does is call the function
> defined there, and it's therefore a VM-oriented rather than
> resource-oriented device.

I'd like to keep the gh_dev_ioctl where it is because it keeps the 
struct gh_rm explicitly private to rsc_mgr.c and thinking this helps 
keep the design cleaner long term by preventing new members from 
sneaking into struct gh_rm.

>> +
>> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
>> +{
>> +    struct gh_vm *ghvm;
>> +    struct file *file;
>> +    int fd, err;
>> +
>> +    /* arg reserved for future use. */
> 
> Do you have a clear idea of how this might be used in the future?

Not yet. I have some vague ideas to use it as a enumeration of "special" 
VM types. We might have special number for VMs which use "protected VM 
firmware"  for the Android boot flow, another number for the "Trusted UI 
VM", another for "OEM VM", etc. Passing 0 would always be the 
unauthenticated VM which we are creating today.

We're considering bumping the info to a separate ioctl since additional 
info needs to be passed from userspace to configure the VM. Userspace 
would do GH_CREATE_VM(). Another ioctl like GH_VM_SET_PVMFW_ADDRESS() 
would imply that the VM uses the protected VM firmware for the Android 
boot flow. Another ioctl call would be used to imply the "Trusted UI 
VM". In any case, we're still in early design phase.

> 
> I was thinking you could silently ignore the argument value, but
> I suppose if it *does* get used in the future, you want the caller
> to know it's being ignored.  (Is that right?)
> 

That's right.

Thanks,
Elliot
