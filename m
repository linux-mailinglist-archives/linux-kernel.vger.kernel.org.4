Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9169C536
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBTGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBTGQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:16:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE9CA27;
        Sun, 19 Feb 2023 22:16:28 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K498m8008705;
        Mon, 20 Feb 2023 06:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : content-type : content-transfer-encoding
 : mime-version; s=pp1; bh=xtPFKjb9YO06vvbeT3eGAeZ6kaNdYYOr8xqecdHfZVE=;
 b=KxYrsYI4B+daZ23zObGgkgtqY3dboXIYTxa/wUQ5S7jsmAs1qJlvoclQC0pSlWvXUTFd
 PJ6DAeuHZ/A7mqIbCKi3tIQ1CoqaJncxvOrWtZSk3eXEsf7SH2wVmApBzI7ag/GnEZyb
 pnn3Cji84V+41jCHupUp7Z6zisUEqSUno5mgnqeQipMzAv5FP2YSWQev9GjXRScNIk3E
 HojUOO3Zt/Z73rdfBvLcxjxPYxRHO6QyztN7a7ZiQX+icJK1GdgiUixQfyu2vkh/Anot
 NPyCo3tyPz9ozQEkEN6KoS2ZNC7/SzKXXzhQs7dy300My+L/zA3PxkDd0+DoE37fGdHD lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6cjr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 06:16:08 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31K6AGo4017367;
        Mon, 20 Feb 2023 06:16:08 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6cjpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 06:16:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JJo9Pt003913;
        Mon, 20 Feb 2023 06:16:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6a8by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 06:16:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31K6G3CL15663838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 06:16:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAA9420043;
        Mon, 20 Feb 2023 06:16:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214F72004F;
        Mon, 20 Feb 2023 06:16:00 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 06:15:59 +0000 (GMT)
Date:   Mon, 20 Feb 2023 11:45:59 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de, ming.lei@redhat.com,
        sumanesh.samanta@broadcom.com, michael.christie@oracle.com,
        john.garry@huawei.com, johannes.thumshirn@wdc.com, axboe@kernel.dk,
        osandov@fb.com, kashyap.desai@broadcom.com,
        gregkh@linuxfoundation.org
Subject: scsi: Recent kernels drop into emergency shell
Message-ID: <20230220061559.GJ159593@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q_FFShONENndKhcn2C1hC8fcVPy1MWV5
X-Proofpoint-ORIG-GUID: hsu9NVMQI1kCCczkUXdm3ofCw7W5FqB0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_04,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a freshly installed system, booting latest upstream kernels causes the
system to drop into emergency shell. The reason for dropping into emergency
shell is system is unable to mount /home partition.

The system was able to boot properly on v5.18 kernel, but failed to boot
v5.19 and 6.2-rc8 kernels.

On the recent or failing kernels, I see the below msg when kernel drops into
emergency shell.

lvm[1370]: /dev/sda3 excluded: device is not in devices file.
lvm[1370]: WARNING: no autoactivation for /dev/sda3: system.devices naa.60050768108001b3a800000000000097 current missing device id.
systemd[1]: dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device: Job dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device/start timed out.
systemd[1]: Timed out waiting for device /dev/mapper/rhel_ltcden3--lp9-home.
systemd[1]: Dependency failed for /home.
systemd[1]: Dependency failed for Local File Systems.
systemd[1]: Dependency failed for Mark the need to relabel after reboot.
systemd[1]: selinux-autorelabel-mark.service: Job selinux-autorelabel-mark.service/start failed with result 'dependency'.
systemd[1]: local-fs.target: Job local-fs.target/start failed with result 'dependency'.
systemd[1]: local-fs.target: Triggering OnFailure= dependencies.
systemd[1]: home.mount: Job home.mount/start failed with result 'dependency'.
systemd[1]: dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device: Job dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device/start failed with result 'timeout'.

lsblk o/p when system has fallen into ememrgency shell (aka bad kernel)
NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                          8:0    0  100G  0 disk
├─sda1                       8:1    0    4M  0 part
├─sda2                       8:2    0    1G  0 part /boot
└─sda3                       8:3    0   99G  0 part
  ├─rhel_ltcden3--lp9-root 253:0    0 63.8G  0 lvm  /
  └─rhel_ltcden3--lp9-swap 253:1    0    4G  0 lvm  [SWAP]
sr0                         11:0    1 1024M  0 rom

lsblk o/p when system boots normally on v5.18 or earlier kernels
NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                          8:0    0  100G  0 disk
├─sda1                       8:1    0    4M  0 part
├─sda2                       8:2    0    1G  0 part /boot
└─sda3                       8:3    0   99G  0 part
  ├─rhel_ltcden3--lp9-root 253:0    0 63.8G  0 lvm  /
  ├─rhel_ltcden3--lp9-swap 253:1    0    4G  0 lvm  [SWAP]
  └─rhel_ltcden3--lp9-home 253:2    0 31.2G  0 lvm  /home
sr0                         11:0    1 1024M  0 rom


lvdisplay o/p when system has fallen into emergency shell (aka bad kernel)
  Devices file sys_wwid naa.60050768108001b3a800000000000097 PVID iws5FZqBFBVE12w874dFuppLWkQUyEcb last seen on /dev/sda3 not found.

lvdisplay o/p when system boots normally on v5.18 or earlier kernels
  --- Logical volume ---
  LV Path                /dev/rhel_ltcden3-lp9/swap
  LV Name                swap
  VG Name                rhel_ltcden3-lp9
  LV UUID                pzxuKG-ofVC-7jBY-HXn9-RDPN-G3hP-K5gdcI
  LV Write Access        read/write
  LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:21 +0530
  LV Status              available
  # open                 2
  LV Size                <4.01 GiB
  Current LE             1026
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/rhel_ltcden3-lp9/home
  LV Name                home
  VG Name                rhel_ltcden3-lp9
  LV UUID                XDcVN6-kP6V-0LtL-nLM4-rvLv-gMQm-uaDRwi
  LV Write Access        read/write
  LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:26 +0530
  LV Status              available
  # open                 1
  LV Size                31.16 GiB
  Current LE             7977
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:2

  --- Logical volume ---
  LV Path                /dev/rhel_ltcden3-lp9/root
  LV Name                root
  VG Name                rhel_ltcden3-lp9
  LV UUID                sJlMVf-eE2v-UKJp-Esqg-uxis-wA1Y-gOXFnO
  LV Write Access        read/write
  LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:36 +0530
  LV Status              available
  # open                 1
  LV Size                63.82 GiB
  Current LE             16339
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

git bisect start '--'
# bad: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect bad 3d7cb6b04c3f3115719235cc6866b10326de34cd
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# bad: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad c011dd537ffe47462051930413fed07dbdc80313
# good: [7e062cda7d90543ac8c7700fc7c5527d0c0f22ad] Merge tag 'net-next-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 7e062cda7d90543ac8c7700fc7c5527d0c0f22ad
# good: [f8122500a039abeabfff41b0ad8b6a2c94c1107d] Merge branch 'etnaviv/next' of https://git.pengutronix.de/git/lst/linux into drm-next
git bisect good f8122500a039abeabfff41b0ad8b6a2c94c1107d
# good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# good: [f7a344468105ef8c54086dfdc800e6f5a8417d3e] ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()
git bisect good f7a344468105ef8c54086dfdc800e6f5a8417d3e
# bad: [fbe86daca0ba878b04fa241b85e26e54d17d4229] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad fbe86daca0ba878b04fa241b85e26e54d17d4229
# bad: [f304d35e59958ea4be399f78e5be08d4a0c4db75] scsi: mpi3mr: Update driver version to 8.0.0.69.0
git bisect bad f304d35e59958ea4be399f78e5be08d4a0c4db75
# good: [21c2e3418d07955c7b87fc3f75688cb1c2b04a32] scsi: ufs: Remove the TRUE and FALSE definitions
git bisect good 21c2e3418d07955c7b87fc3f75688cb1c2b04a32
# good: [671a52f2aeafe2f42bddb53dcfe3933b1f641843] scsi: fnic: Remove unneeded flush_workqueue()
git bisect good 671a52f2aeafe2f42bddb53dcfe3933b1f641843
# bad: [d657700ccac71da19a4d1a591fafcd598ce0dd6e] scsi: core: Do not truncate INQUIRY data on modern devices
git bisect bad d657700ccac71da19a4d1a591fafcd598ce0dd6e
# good: [c5acd61dbb32b6bda0f3a354108f2b8dcb788985] scsi: megaraid: Fix error check return value of register_chrdev()
git bisect good c5acd61dbb32b6bda0f3a354108f2b8dcb788985
# good: [dc1178767cba9d67f5100fb370670fd613319362] scsi: mpt3sas: Use cached ATA Information VPD page
git bisect good dc1178767cba9d67f5100fb370670fd613319362
# bad: [e17d63403076affccd72d195f93bbf3f39514005] scsi: core: Pick suitable allocation length in scsi_report_opcode()
git bisect bad e17d63403076affccd72d195f93bbf3f39514005
# bad: [c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b] scsi: core: Query VPD size before getting full page
git bisect bad c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b
# first bad commit: [c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b] scsi: core: Query VPD size before getting full page

Commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
went in between v5.18 and v5.19.

Verifications:
I have verified that reverting the said bad commit on top of v6.2-rc8, v5.19
and on top of c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b causes the system to
boot normally.

-- 
Thanks and Regards
Srikar Dronamraju
