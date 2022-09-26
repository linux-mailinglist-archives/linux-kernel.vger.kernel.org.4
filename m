Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB88A5E9D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiIZJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiIZJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:20:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906A42ADD;
        Mon, 26 Sep 2022 02:18:42 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8WsIa029971;
        Mon, 26 Sep 2022 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XLgB/8EEH2jKiQKzTA9360NF+GWxgxC0slXTZGETzO8=;
 b=JmctX17jDg7/dh7BwlLA5G1EbWyrnFoxqFEZfLJ/XJNThcO+pL3R0cpiTCUw5sasJyBK
 gagc3oX9E5VMVnQvtRtcUlGh8O4RKrQK1oEWPo8t61s+8fvfQOVePXmHiudVPiGpi3Hp
 QGgNcCiZ6krXYZVOkiXIk2aE6gRUZ64KlkMmwYtPz7+JJtUCwrFH5RrPwKwZO2h+xVPz
 /71kUYNm1klxPe6o3QNReQchF76aoiGfUvGrUbbD0viInOr1iA9N0JWYVFrVm3FY4/h5
 S9eN0sMdbxG7vWPrbohRgXzT9zIE0rB8a8M+kLNt1A70lgY17qTcTmye3wpAUqo2N9X/ yQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ju8nw16t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:17:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28Q95fH9006260;
        Mon, 26 Sep 2022 09:17:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9a71v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 09:17:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28Q9HZq746006584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:17:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 977314C044;
        Mon, 26 Sep 2022 09:17:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBEBE4C040;
        Mon, 26 Sep 2022 09:17:34 +0000 (GMT)
Received: from [9.171.69.218] (unknown [9.171.69.218])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 09:17:34 +0000 (GMT)
Message-ID: <e0754578-1735-5811-0533-19ef0c6be2b0@linux.ibm.com>
Date:   Mon, 26 Sep 2022 11:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/3] s390/pci: remove unused bus_next field from struct
 zpci_dev
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-3-schnelle@linux.ibm.com>
Content-Language: en-US
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220922095239.2115309-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KpW4pxW8ycrRGg4j2w_y2g-zcISFQ00s
X-Proofpoint-GUID: KpW4pxW8ycrRGg4j2w_y2g-zcISFQ00s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260057
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/22 11:52, Niklas Schnelle wrote:
> This field was added in commit 44510d6fa0c0 ("s390/pci: Handling
> multifunctions") but is an unused remnant of an earlier version where
> the devices on the virtual bus were connected in a linked list instead
> of a fixed 256 entry array of pointers.
> 
> It is also not used for the list of busses as that is threaded through
> struct zpci_bus not through struct zpci_dev.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


> ---
>   arch/s390/include/asm/pci.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 7b4cdadbc023..108e732d7b14 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -117,7 +117,6 @@ struct zpci_bus {
>   struct zpci_dev {
>   	struct zpci_bus *zbus;
>   	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
> -	struct list_head bus_next;
>   	struct kref kref;
>   	struct hotplug_slot hotplug_slot;
>   

-- 
Pierre Morel
IBM Lab Boeblingen
