Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581D8605B62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJTJmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJTJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:42:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41495159D6D;
        Thu, 20 Oct 2022 02:42:22 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K9CdgR022799;
        Thu, 20 Oct 2022 09:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=8jz1r/nSXZHAVV1eh0np8c+bkjDvnPMv1zF7VbM3Ymk=;
 b=Kfa2w3WnryhWDxP10KF4C8oAQFC59MDbW7ISPrBRQC5DRdxHqWgKyy8A1EEekPhYOHu2
 ORjW6ChN83qbPzvsJ+US3C5UyS9vqDU42xrU0t2GqgXpLi1hMq6vKuh2qrX/kM9ecejL
 KRhl6T9y1EI75wkvH1/s1vlFtdHVjYEkKuv4Luf8kpkSy5+1k6OEyUCF4mY9MC/1wnCJ
 eb+GWZIAzKhKMtiDTsAW99K0pMM3ZLc0TiXfw1jbIlmECZ7Do3ktrRs5vLdOe/xFH6+6
 WA926Ca//vMMB8vDAb2mpxKy0oKkNtTwvvZ/+MO6qoa8wYJPS38DloqWMCA0JiLFWofz Mw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb3g7s1jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:42:21 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K9bAVm025046;
        Thu, 20 Oct 2022 09:42:20 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3k7mg9dj63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:42:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K9gJHp8454868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 09:42:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E6A58067;
        Thu, 20 Oct 2022 09:42:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DC6B58066;
        Thu, 20 Oct 2022 09:42:13 +0000 (GMT)
Received: from [9.43.91.85] (unknown [9.43.91.85])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 09:42:12 +0000 (GMT)
Message-ID: <7e3ace01-4960-0951-c708-dde0cdd6cf6d@linux.vnet.ibm.com>
Date:   Thu, 20 Oct 2022 15:12:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [6.0.0] [linux-master] Kernel Panic seen during boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VtZTl-92owPCN8CxYoyCK6UhEk9-ILIG
X-Proofpoint-GUID: VtZTl-92owPCN8CxYoyCK6UhEk9-ILIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=773 lowpriorityscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[6.0.0] [linux-master] Kernel Panic seen during boot

--- Traces ---
[    0.057420] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(0,0)
[    0.057423] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 
6.0.0-autotest-g66ae04368efb #1
[    0.057427] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
0xf000006 of:IBM,FW1010.32 (NH1010_135) hv:phyp pSeries
[    0.057430] Call Trace:
[    0.057431] [c000000003703ab0] [c000000000d1e71c] 
dump_stack_lvl+0x70/0xa4 (unreliable)
[    0.057439] [c000000003703af0] [c0000000001513fc] panic+0x174/0x428
[    0.057443] [c000000003703b90] [c000000002005794] 
mount_block_root+0x26c/0x2a0
[    0.057448] [c000000003703c60] [c000000002005b84] 
prepare_namespace+0x1b0/0x204
[    0.057452] [c000000003703cd0] [c00000000200502c] 
kernel_init_freeable+0x390/0x3e8
[    0.057456] [c000000003703da0] [c000000000012734] kernel_init+0x34/0x1b0
[    0.057460] [c000000003703e10] [c00000000000cf40] 
ret_from_kernel_thread+0x5c/0x64
[    0.077448] Rebooting in 10 seconds..

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center

