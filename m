Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04505E9D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiIZJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiIZJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC532BAA;
        Mon, 26 Sep 2022 02:24:01 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q9FOuZ027172;
        Mon, 26 Sep 2022 09:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Cif+7TgFRVilkLXoKeIdvg2g/inFUxsmAymcuvW782c=;
 b=AR+rmzQ8VfE9VpEmZAO0fAPJtp936ZPxplR9SQ9bLojCUFvogO6bh0wSwDfIx5ka9UBI
 jpmkr4JH5Bb4KVdKxJb4kCdJ9udLKexyBHpefck6SB7V7NK/O+42dqJL88UjRcPbvgtE
 JWGTb6jyfrlXyP7d6ew7umanTcE2NdwyFkULmOHz/P/GPaZMxgLEvVLiwgAYy9haGg1s
 5SlpVBcQLoMamec5vNSckhhEqXk728336NAFMY/n+6bi3enJxLnjg+DWlFdjec84du71
 CGzXg44tvNq1pp29a5G9ojosc7AP21pEf20NkP1o/dWwfO3YiIaEGHFU/D/uLepbI+Bz 1A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ju99j05sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:23:46 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q9KJmM031545;
        Mon, 26 Sep 2022 09:23:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3jssh8sn1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:23:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q9Nffn1507948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:23:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 042534C040;
        Mon, 26 Sep 2022 09:23:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A534C046;
        Mon, 26 Sep 2022 09:23:40 +0000 (GMT)
Received: from [9.171.69.218] (unknown [9.171.69.218])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 09:23:40 +0000 (GMT)
Message-ID: <8ba5cee2-5e5c-6b73-3ac7-56e78e432698@linux.ibm.com>
Date:   Mon, 26 Sep 2022 11:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/3] s390/pci: remove unused bus_next field from struct
 zpci_dev
Content-Language: en-US
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-3-schnelle@linux.ibm.com>
 <e0754578-1735-5811-0533-19ef0c6be2b0@linux.ibm.com>
In-Reply-To: <e0754578-1735-5811-0533-19ef0c6be2b0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jg7UzVdwapWDme-DJ5wIli1NdMHtC_1N
X-Proofpoint-GUID: Jg7UzVdwapWDme-DJ5wIli1NdMHtC_1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260057
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/22 11:17, Pierre Morel wrote:
> 
> 
> On 9/22/22 11:52, Niklas Schnelle wrote:
>> This field was added in commit 44510d6fa0c0 ("s390/pci: Handling
>> multifunctions") but is an unused remnant of an earlier version where
>> the devices on the virtual bus were connected in a linked list instead
>> of a fixed 256 entry array of pointers.
>>
>> It is also not used for the list of busses as that is threaded through
>> struct zpci_bus not through struct zpci_dev.
>>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> 

Also couldn't it be detached of the series and posted on its own?

>> ---
>>   arch/s390/include/asm/pci.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 7b4cdadbc023..108e732d7b14 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -117,7 +117,6 @@ struct zpci_bus {
>>   struct zpci_dev {
>>       struct zpci_bus *zbus;
>>       struct list_head entry;        /* list of all zpci_devices, 
>> needed for hotplug, etc. */
>> -    struct list_head bus_next;
>>       struct kref kref;
>>       struct hotplug_slot hotplug_slot;
> 

-- 
Pierre Morel
IBM Lab Boeblingen
