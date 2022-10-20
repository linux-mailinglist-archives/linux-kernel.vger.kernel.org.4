Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59355605B53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJTJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:37:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698916F401;
        Thu, 20 Oct 2022 02:37:46 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K8clux024665;
        Thu, 20 Oct 2022 09:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=/Sipbaw/Vo0+MW3rolamGoLn46TO7W2aqL/jh2yhdZc=;
 b=dBHYACGrhbWb1eTlyuAXNRk4/5fRrpU15MNX/Cp2BfkbKd3GkOJF53AXbjhfmhkR9I2Q
 jPV3OHQR1JB9YBzqQCGkAn/0Ps466e4UU/Mav8pJddybPZY+62Ka4pK3vnzI5lIl9sYy
 uoIiT0g9BcJbUIsRB4budBk1WGHW8P7/EeAvHjnsx+vmgmdcmUPEFauLtbMkDLejzdAt
 kA6raDUc24TjvVUvLoQjFffWHHRSowd2AC/coY5H5F4gd6AIxtbz0zdpdRbF+mC1ne2f
 GnKRHeGJQNuO89RKKAqS98GCWvEd9ok1TejoYALeYbXx5zS560DURfluCK18ZgnDHYC8 8w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kb29q38ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:37:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K9ZQVd008491;
        Thu, 20 Oct 2022 09:37:22 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3kapd5660f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 09:37:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K9bKnl721620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 09:37:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7483458055;
        Thu, 20 Oct 2022 09:37:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CF725805B;
        Thu, 20 Oct 2022 09:37:13 +0000 (GMT)
Received: from [9.43.91.85] (unknown [9.43.91.85])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 09:37:12 +0000 (GMT)
Message-ID: <a8dce54b-e494-81c9-1798-6475861cd399@linux.vnet.ibm.com>
Date:   Thu, 20 Oct 2022 15:07:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux mainline/master] [6.0-6.1-rc1] [SRIOV] WARNING: CPU: 3 PID:
 690 at arch/powerpc/kernel/irq_64.c:285 arch_local_irq_restore+0x230/0x26]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KltvPbc3TQS8HVJ-7JTPmqIdY2yj8ezY
X-Proofpoint-GUID: KltvPbc3TQS8HVJ-7JTPmqIdY2yj8ezY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_03,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=510
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux mainline/master] [6.0-6.1-rc1] [SRIOV] WARNING: CPU: 3 PID: 690 
at arch/powerpc/kernel/irq_64.c:285 arch_local_irq_restore+0x230/0x26]


--- Traces ---
[   19.877841] ------------[ cut here ]------------
[   19.877855] WARNING: CPU: 3 PID: 690 at 
arch/powerpc/kernel/irq_64.c:285 arch_local_irq_restore+0x230/0x260
[   19.877865] Modules linked in: mbcache jbd2 sd_mod t10_pi 
crc64_rocksoft crc64 sg mlx5_core mlxfw ibmvscsi ibmveth 
scsi_transport_srp be2net psample ptp pps_core ipmi_devintf 
ipmi_msghandler fuse
[   19.877891] CPU: 3 PID: 690 Comm: modprobe Not tainted 
6.1.0-rc1-autotest-gaae703b02f92 #1
[   19.877897] Hardware name: IBM,8375-42A POWER9 (raw) 0x4e0202 
0xf000005 of:IBM,FW950.40 (VL950_099) hv:phyp pSeries
[   19.877903] NIP:  c00000000003f830 LR: c0000000000b4b7c CTR: 
000000000000a6a4
[   19.877908] REGS: c000000071ac76a0 TRAP: 0700   Not tainted 
(6.1.0-rc1-autotest-gaae703b02f92)
[   19.877913] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 44222284  XER: 00000000
[   19.877929] CFAR: c00000000003f684 IRQMASK: 1
[   19.877929] GPR00: c0000000000b4c3c c000000071ac7940 c00000000117ad00 
0000000000000000
[   19.877929] GPR04: 0000000000000000 0000001031a81794 0000000000000000 
4009287a77000005
[   19.877929] GPR08: 0000000000000000 0000000000008000 c000000071997700 
0000000000000040
[   19.877929] GPR12: 0000000000002000 c00000000fffae80 c0080000058af7e8 
c0080000009efde0
[   19.877929] GPR16: c008000004eb2830 c0080000058af928 00000000ffffffff 
c000000000fb47e0
[   19.877929] GPR20: c0000000029947d8 c008000000d79b00 c008000004e9eff8 
aaaaaaaaaaaaaaab
[   19.877929] GPR24: c0080000058b0ae8 c008000000c90000 0000000048034f65 
c008000000080000
[   19.877929] GPR28: c0000000029ce0d8 0000000000000000 0000000000000000 
c0000000035f0040
[   19.877989] NIP [c00000000003f830] arch_local_irq_restore+0x230/0x260
[   19.877995] LR [c0000000000b4b7c] patch_instruction+0x26c/0x340
[   19.878002] Call Trace:
[   19.878004] [c000000071ac7940] [c0000000029ce0d8] init_mm+0x0/0x5c0 
(unreliable)
[   19.878012] [c000000071ac7970] [c0000000000b4c3c] 
patch_instruction+0x32c/0x340
[   19.878020] [c000000071ac79c0] [c000000000060c4c] 
apply_relocate_add+0x76c/0x960
[   19.878026] [c000000071ac7ac0] [c000000000233490] 
load_module+0x1b60/0x20b0
[   19.878034] [c000000071ac7ca0] [c000000000233d4c] 
__do_sys_finit_module+0xdc/0x180
[   19.878041] [c000000071ac7dd0] [c000000000034eb4] 
system_call_exception+0x164/0x3b0
[   19.878048] [c000000071ac7e10] [c00000000000c6d4] 
system_call_common+0xf4/0x258
[   19.878056] --- interrupt: c00 at 0x7fff7f5df1d4
[   19.878060] NIP:  00007fff7f5df1d4 LR: 000000012796f06c CTR: 
0000000000000000
[   19.878065] REGS: c000000071ac7e80 TRAP: 0c00   Not tainted 
(6.1.0-rc1-autotest-gaae703b02f92)
[   19.878070] MSR:  800000000000f033 <SF,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 
28222244  XER: 00000000
[   19.878084] IRQMASK: 0
[   19.878084] GPR00: 0000000000000161 00007fffdfffa8d0 00007fff7f6b7300 
0000000000000002
[   19.878084] GPR04: 000000012797b5d0 0000000000000000 0000000000000000 
0000000000000000
[   19.878084] GPR08: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   19.878084] GPR12: 0000000000000000 00007fff7fbbca50 0000000000040000 
0000000000000000
[   19.878084] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[   19.878084] GPR20: 0000000000000000 0000000000000000 0000010017ee1b20 
00000001279798d8
[   19.878084] GPR24: 0000000000000000 0000000020000000 0000000000000000 
0000010017ee1ee0
[   19.878084] GPR28: 000000012797b5d0 0000000000040000 0000000000000000 
0000010017ee1b20
[   19.878141] NIP [00007fff7f5df1d4] 0x7fff7f5df1d4
[   19.878145] LR [000000012796f06c] 0x12796f06c
[   19.878149] --- interrupt: c00
[   19.878152] Instruction dump:
[   19.878156] 0fe00000 4bfffff0 60000000 60000000 ebe10028 4bfffa95 
4bfffed4 60000000
[   19.878166] 0fe00000 4bffffd0 60000000 60000000 <0fe00000> 4bffffc0 
60000000 60000000
[   19.878177] ---[ end trace 0000000000000000 ]---

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center

