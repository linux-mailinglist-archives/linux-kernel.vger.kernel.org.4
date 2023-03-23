Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A916C6F06
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjCWRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjCWRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:31:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045A2823C;
        Thu, 23 Mar 2023 10:31:26 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NFgsjF024916;
        Thu, 23 Mar 2023 17:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=MNoS4Gyvfm8TosyaqhjyVn5ODMUmahFiqFYTcJIr4/o=;
 b=pNhny9ifE0nNUadSDSsy3qDaEfC7GYSakjO1mO5IiNSS9JJpNe6nIhdP+8bwXjXTM/1j
 cAEhzMwHfPrnKmRIXkuIuOdJ6q6BHNo6IDecRkBVy2LTbu+Tuk8zRcSAVxWMBQDXWh2O
 ve5IQO6Ck9HJhW1i3xvseagi+7/nyDIXpfrbcGOxc76rFMRPC91nkAtuxiXbI3OdGLq1
 zbhx1SrpVkdAQjXo2R4rrZLGIXKvK6De9LJ0A7bcDswOn7nToAlEMVfZ4FrHGO9anPa3
 dHCEWCmf6r6ju+uyEO0F4CBvymwu9+zcJioQPl3DBw33q84m7cMq8lrX8v2HvJNCnaNN Wg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgmu7k4rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 17:31:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDlMbY014687;
        Thu, 23 Mar 2023 17:31:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6eepn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 17:31:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NHVCEC24052346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 17:31:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E91C220043;
        Thu, 23 Mar 2023 17:31:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD73820040;
        Thu, 23 Mar 2023 17:31:10 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.34.166])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 17:31:10 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [next-20230322] Kernel WARN at kernel/workqueue.c:3182
 (rcutorture)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <fbb628c1-08bd-44ff-a613-794b134f6d46@paulmck-laptop>
Date:   Thu, 23 Mar 2023 23:00:59 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <233B28DA-70DD-4AD8-9C72-1FFCA6EFE56D@linux.ibm.com>
References: <139BEB3F-BC1C-4ABA-8928-9A8EF3FB5EDD@linux.ibm.com>
 <fbb628c1-08bd-44ff-a613-794b134f6d46@paulmck-laptop>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3M356xG5GLdKkxm4sUicxH7aE3_zQHtU
X-Proofpoint-GUID: 3M356xG5GLdKkxm4sUicxH7aE3_zQHtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230124
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> [ 3629.243407] NIP [00007fff8cd39558] 0x7fff8cd39558
>> [ 3629.243410] LR [000000010d800398] 0x10d800398
>> [ 3629.243413] --- interrupt: c00
>> [ 3629.243415] Code: 419dffa4 e93a0078 39400001 552907be 2f890000 =
7d20579e 0b090000 e95a0078 e91a0080 39200001 7fa85000 7d204f9e =
<0b090000> 7f23cb78 4bfffd65 0b030000=20
>> [ 3629.243430] ---[ end trace 0000000000000000 ]=E2=80=94
>>=20
>> These warnings are repeated few times. The LTP test is marked as =
PASS.
>>=20
>> Git bisect point to the following patch
>> commit f46a5170e6e7d5f836f2199fe82cdb0b4363427f
>>    srcu: Use static init for statically allocated in-module =
srcu_struct
>=20
> Hello, Sachin, and it looks like you hit something that Zqiang and I
> have been tracking down.  I am guessing that you were using modprobe
> and rmmod to make this happen, and that this happened at rmmod time.
>=20
Yes, the LTP test script rcu_torture.sh relies on modprobe to =
load/unload
the rcutorture module.

> Whatever the reproducer, does the following patch help?
>=20
> Thanx, Paul
>=20

Thank you for the patch. Yes, with this patch applied, the test =
completes
successfully without the reported warning.

- Sachin

