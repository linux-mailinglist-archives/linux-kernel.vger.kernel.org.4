Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0006A8992
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:38:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C818A86;
        Thu,  2 Mar 2023 11:38:43 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322JC1vM018092;
        Thu, 2 Mar 2023 19:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=734FQkv3trw7HTDOdeX9a882SC5eWhFgOLlXfTMhuDM=;
 b=IbUR3Cdjaqkpc5WcDPXs8MjvyWbzNv1zfHUCNiU5r/6nFFERoHbGoviynWOF23kcANf4
 vBMn223VeY4eMLB4w/kqEyTRolN7mfOD3905THUoGkSCVgbWefzo3sEro7DByqrS6HHa
 p+LOxH8jBs0IPut4o2a5jgsNaykM3o5s5+o+fihYycjzq0B7O8jffYEdipnsQlTMX4V8
 M8T2fiuXSV8pCD2OBxDPBQca1WyIdVGKejbQ/7Lijtp08dRk+KJxMwscDwLl0jcbey8d
 6nj9ZQhQxjVh0Ef75GLfAwkeOoDLm5BgxZqy/LP9NHeMewHVMf2UD+/38GyvpFmWAD00 yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p31r9gke1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 19:38:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 322C3MZJ008890;
        Thu, 2 Mar 2023 19:33:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nybcue7v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 19:33:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 322JXaY127525548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 19:33:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FC9E20043;
        Thu,  2 Mar 2023 19:33:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF6B020040;
        Thu,  2 Mar 2023 19:33:35 +0000 (GMT)
Received: from localhost (unknown [9.171.62.161])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 19:33:35 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
In-Reply-To: <00000000000016493d05f56d0aae@google.com>
In-Reply-To: 
Date:   Thu, 02 Mar 2023 20:33:35 +0100
Message-ID: <87lekfne28.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HkIfg4vXCLVBqHL7zUniKwNnyjB6v6c3
X-Proofpoint-GUID: HkIfg4vXCLVBqHL7zUniKwNnyjB6v6c3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_13,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=553 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

we are seeing a similar problem on s390x architecture when partitioning
a NVMe disk on linux-next.


  [   70.403015]  nvme0n1: p1
  [   70.403197] ------------[ cut here ]------------
  [   70.403199] WARNING: CPU: 8 PID: 2452 at block/bdev.c:845 blkdev_put+0x280/0x298
  [   70.403207] Modules linked in: nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) nf_tables(E) nfnetlink(E) sunrpc(E) binfmt_misc(E) uvdevice(E) s390_trng(E) eadm_sch(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) sch_fq_codel(E) ip6_tables(E) ip_tables(E) x_tables(E) configfs(E) dm_service_time(E) ghash_s390(E) prng(E) chacha_s390(E) libchacha(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512_s390(E) sha256_s390(E) nvme(E) sha1_s390(E) sha_common(E) nvme_core(E) zfcp(E) scsi_transport_fc(E) dm_mirror(E) dm_region_hash(E) dm_log(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) pkey(E) zcrypt(E) rng_core(E) dm_multipath(E) autofs4(E)
  [   70.403247] CPU: 8 PID: 2452 Comm: fdisk Tainted: G            E      6.3.0-20230228.rc0.git67.058f4df42121.300.fc37.s390x+next #1
  [   70.403249] Hardware name: IBM 3931 A01 701 (LPAR)
  [   70.403251] Krnl PSW : 0704d00180000000 00000000800cc56c (blkdev_put+0x284/0x298)
  [   70.403254]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
  [   70.403257] Krnl GPRS: 00000000858a9720 00000000ffffffff 0000000000000009 000000008102d600
  [   70.403259]            0000000080a6c454 0000000000000000 0000000000000000 0000000082023c00
  [   70.403260]            000000009f3a49f8 000000009f3a4800 00000000484e109f 0000000082023c00
  [   70.403262]            00000000b0932100 000003ffa56c3b18 00000000800cc32a 00000380036b3cd8
  [   70.403268] Krnl Code: 00000000800cc55e: c0e5fffffbd9      brasl   %r14,00000000800cbd10
                            00000000800cc564: a7f4ffaa          brc     15,00000000800cc4b8
                           #00000000800cc568: af000000          mc      0,0
                           >00000000800cc56c: a7f4ff68          brc     15,00000000800cc43c
                            00000000800cc570: b9040023          lgr     %r2,%r3
                            00000000800cc574: c0e5002a2d96      brasl   %r14,00000000806120a0
                            00000000800cc57a: a7f4ff58          brc     15,00000000800cc42a
                            00000000800cc57e: 0707              bcr     0,%r7
  [   70.403319] Call Trace:
  [   70.403321]  [<00000000800cc56c>] blkdev_put+0x284/0x298
  [   70.403325]  [<00000000800cd4da>] blkdev_close+0x32/0x48
  [   70.403328]  [<000000007fcee9ce>] __fput+0x96/0x290
  [   70.403332]  [<000000007fa1dfe0>] task_work_run+0x88/0xe0
  [   70.403337]  [<000000007fa9e5a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
  [   70.403340]  [<0000000080625996>] __do_syscall+0x11e/0x200
  [   70.403345]  [<0000000080635162>] system_call+0x82/0xb0
  [   70.403349] Last Breaking-Event-Address:
  [   70.403350]  [<00000000800cc436>] blkdev_put+0x14e/0x298
  [   70.403353] Kernel panic - not syncing: kernel: panic_on_warn set ...
  [   70.403354] CPU: 8 PID: 2452 Comm: fdisk Tainted: G            E      6.3.0-20230228.rc0.git67.058f4df42121.300.fc37.s390x+next #1
  [   70.403357] Hardware name: IBM 3931 A01 701 (LPAR)
  [   70.403357] Call Trace:
  [   70.403358]  [<000000008062559a>] dump_stack_lvl+0x62/0x80
  [   70.403360]  [<0000000080613eb0>] panic+0x118/0x300
  [   70.403364]  [<000000007f9f3a40>] check_panic_on_warn+0x70/0x88
  [   70.403367]  [<000000007f9f3ce8>] __warn+0x108/0x150
  [   70.403369]  [<00000000805e8d76>] report_bug+0x18e/0x1e8
  [   70.403371]  [<000000007f9a11a4>] monitor_event_exception+0x44/0x80
  [   70.403374]  [<0000000080625798>] __do_pgm_check+0xf0/0x1b0
  [   70.403375]  [<00000000806352ec>] pgm_check_handler+0x11c/0x170
  [   70.403377]  [<00000000800cc56c>] blkdev_put+0x284/0x298
  [   70.403380]  [<00000000800cd4da>] blkdev_close+0x32/0x48
  [   70.403382]  [<000000007fcee9ce>] __fput+0x96/0x290
  [   70.403384]  [<000000007fa1dfe0>] task_work_run+0x88/0xe0
  [   70.403386]  [<000000007fa9e5a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
  [   70.403388]  [<0000000080625996>] __do_syscall+0x11e/0x200
  [   70.403390]  [<0000000080635162>] system_call+0x82/0xb0

The problem appeared about a week ago.

Regards
Alex
