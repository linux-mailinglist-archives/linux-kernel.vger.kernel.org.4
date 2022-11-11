Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAC6252E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKKEzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:55:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581367671;
        Thu, 10 Nov 2022 20:55:33 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB4iDjS017104;
        Fri, 11 Nov 2022 04:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=bSNMtQ7RRVXUezWBU6/StIY5X7qvabopkcZS0gH1A5I=;
 b=ekH8b1BI4JFY1y6qgJPMulGrsaDnwoy/yf8zss+ZdCH7enkiDrAwbcUupLG0XeuanxDh
 aFxR8bQ8LNXvFyL/SAkKkUAXO2WLI+jZvpTA+wlNbzusnudFSMkdmpG1xHdRQWEGSDz6
 RgkDSMDvaCqrEM+8Dls6gF2TclilbIZOY6foluG5UxkQtDA4P96wdJ5YZnJL37K5eUgC
 LhU5YB0Clc2DexxOcL1hBzHaY1/s1808YpOGB9MPQkKGN+BwxWKn9C5ADC5b3Ci57kir
 sBg38BVjMQe9uMTMvOPJHMb1tqYLOPvDc1NR8fXun6je15xVdxs6d3+KH7JtPM5sWV1U RA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksfm9r6pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 04:55:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AB4oeHM006790;
        Fri, 11 Nov 2022 04:55:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgg637-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 04:55:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AB4tCWR5898986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 04:55:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 456C452050;
        Fri, 11 Nov 2022 04:55:12 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.108.238])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58B855204F;
        Fri, 11 Nov 2022 04:55:11 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [6.1.0-rc4-next-20221109] Boot time warning
 kernel/module/main.c:852
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <05a91775-e4fa-4d70-8303-898339c4ea01@acm.org>
Date:   Fri, 11 Nov 2022 10:25:00 +0530
Cc:     linux-scsi@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C37C3E0-3F2E-4FF6-AD38-30BDCF48AB2C@linux.ibm.com>
References: <06C70AFA-75C5-49A7-9EB4-27AF20A80EBB@linux.ibm.com>
 <05a91775-e4fa-4d70-8303-898339c4ea01@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nJS8csZ4UwhBR6rMvZBRwxRDBHIOC29y
X-Proofpoint-GUID: nJS8csZ4UwhBR6rMvZBRwxRDBHIOC29y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_01,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211110028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> [ 8.809079] [c000000007c37e10] [c00000000000cffc] =
ret_from_kernel_thread+0x5c/0x64
>> [ 8.809086] Instruction dump:
>> [ 8.809090] f821ffc1 41820034 395e03c0 7c0004ac 7d205028 2c090001 =
3929ffff 41c00010
>> [ 8.809101] 7d20512d
>> [ 8.809101] sd 1:0:0:1: [sdc] Preferred minimum I/O size 32768 bytes
>> [ 8.809102] 40c2ffec 7c0004ac 79290fe2 <0b090000> 60000000 38210040 =
ebc1fff0
>> [ 8.809115] ---[ end trace 0000000000000000 ]=E2=80=94
>> -next-20221108 was good. Git bisect points to following
>> commit 0b25e17e9018a0ea68a9f0b4787672e8c68fa8d5
>> Date:   Mon Oct 31 15:47:25 2022 -0700
>>     scsi: alua: Move a scsi_device_put() call out of alua_check_vpd()
>> Reverting this patch gets rid of the warning.
>=20
> Hi Sachin,
>=20
> Thanks for the detailed report. Does the patch below help?
>=20

Yup, thanks. With this change applied I do not see the warning.

- Sachin

> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c =
b/drivers/scsi/device_handler/scsi_dh_alua.c
> index 693cd827e138..d2cf15338724 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -1025,7 +1025,7 @@ static bool __must_check alua_rtpg_queue(struct =
alua_port_group *pg,
> kref_put(&pg->kref, release_port_group);
> }
>=20
> - return true;
> + return sdev !=3D NULL;
> }
>=20
> /*
>=20

