Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9A69761A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBOGEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOGEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:04:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB927AAD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:04:12 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F5mNFG011088;
        Wed, 15 Feb 2023 06:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VXLKvl2YMsbkerFS6bMOE5aYxKa546BNJOaA0eeUAkk=;
 b=qg9gOzhd0VDHR4UvtF4BoNc07GwlCs6ISXLxIGj8oeVPXATqMrmGT1l09DdaVZpvAYth
 XzrSXniRs14Gw+DL5w9cGCOQ+eFTcjVBjYJgt2UFWPPMXQsH6rNBn8fyX5ebnQ4z87vC
 6o+qO1KrQcy5BWob+3E3x8yNE9esMjekP0cbetT1tzRxUenSKIMsud5mTKprqyc50O88
 PzwvLRgPXMm0JB7XfXDpkEQfzedtbmnL7DltE+bL1o1O2Dds3I9JISmWr+uif6OIni3O
 0YLRqSru3r9rEPtuc1QYRZjGuZcBwvb4VHbNYanHr66zp2e5HP+5dtgC2Rsdp4JDa3sJ fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrsjrrcph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:03:57 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31F5s12q001118;
        Wed, 15 Feb 2023 06:03:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrsjrrcn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:03:56 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31EJUl4o010684;
        Wed, 15 Feb 2023 06:03:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6vyfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:03:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31F63plE43778402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 06:03:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5F7A2004B;
        Wed, 15 Feb 2023 06:03:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E6720040;
        Wed, 15 Feb 2023 06:03:49 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.43.40.186])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Feb 2023 06:03:49 +0000 (GMT)
Date:   Wed, 15 Feb 2023 11:33:28 +0530
From:   Vishal Chourasia <vishalc@linux.vnet.ibm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, peterz@infradead.org, ritesh.list@gmail.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH v2] sched/debug: Put sched/domains files under the
 verbose flag
Message-ID: <Y+x1sO2zclDex3UI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
References: <20230119150758.880189-1-pauld@redhat.com>
 <20230120163330.1334128-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r3ixgbmMDEDfIj5d"
Content-Disposition: inline
In-Reply-To: <20230120163330.1334128-1-pauld@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5PaH8M7L2px0H__cX1dpK9Ol_qu5ZMAw
X-Proofpoint-ORIG-GUID: riRMfIliIEl1fCEmp53fElwjezmQyAxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3ixgbmMDEDfIj5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 11:33:30AM -0500, Phil Auld wrote:
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the sched verbose debug flag. Allow changes to verbose to trigger
> generation of the files. This lets a user batch the updates but still
> have the information available.  The detailed topology printk messages
> are also under verbose.
>=20
> Discussion that lead to this approach can be found in the link below.
>=20
> Simplified code to maintain use of debugfs bool routines suggested by
> Michael Ellerman <mpe@ellerman.id.au>.
>=20
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-=
a85c-e3f3aa0db1e9.ibm.com/
> ---
>=20
>  v2: fix comment typo and use cpumask_empty()
>=20
>  kernel/sched/debug.c | 52 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)

Thanks for the Patch.

Tested-by: Vishal Chourasia <vishalc@linux.vnet.ibm.com>

Base Tag       : v6.2-rc8 =20
Patch          : [V2] sched/debug: Put sched/domains files under the verbos=
e flag


# time ppc64_cpu --smt=3Doff   | When kernel is built =20
                             | with the patch, time to
real    17m54.246s           | smt=3Doff is 17m54s.   =20
user    0m0.013s             |
sys     0m4.661s             |

System Configuration:

Architecture    : ppc64le
CPUS            : 1600
Machine         : Power10
Thread per core : 8
Sockets         : 15

- debug files are not created for the case where kernel command line string
  lacks sched_verbose parameter.
- When sched_verbose is passed as kernel commandline parameter, kernel expo=
rts
  /sys/kernel/debug/sched/verbose file which controls creation of the debug
  files.
  + setting Y/N to this file enables/disables creation of debug files durin=
g CPU
    hotplug operation.

Below is the table listing time taken to perform smt=3Doff operation under
different settings.

+--------------------------+---------------+---------+------------+
| kernel                   | sched_verbose | verbose | time       |
+--------------------------+---------------+---------+------------+
| 6.2.0-rc8-patch-applied+ | YES           | N       | 16m58.196s |
| 6.2.0-rc8-patch-applied+ | YES           | Y       | 33m21.774s |
| 6.2.0-rc8-patch-applied+ | NO            | NA      | 17m54.246s |
| 6.2.0-rc8                | NO            | NA      | 30m11.344s |
+--------------------------+---------------+---------+------------+

-- vishal.c
--r3ixgbmMDEDfIj5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyetz6oh8pzQ87ZNz8y5vG2Pik+wFAmPsdbAACgkQ8y5vG2Pi
k+wg/wf/ReooXBhKK8NoBdjxvjIO2xJ9Epg3wrQl/GdFmvBJ9XGYx+VIcd0sBV0l
a880oc3xCkRxnOdDfNYQyqq5WjNdu9YeU4AmbXdOAvd3SJvstirlDFCTJNSaOn1F
KJOXZRkcrBP6Ykk3infiDpX6E/K8dBMXVCrfcRg6DHG2Y+aGJtiAUkYOoGz3OmuA
A7/j00bzn3iFbkmWyh1TMaT77qBIJgs6QM4Zl1mfGCIBiNoLCxHlElbeF7t0tjFC
Jk+E5LwDG2VWZpeC5qlKT6mpchVZTLDVByhEz0ChcQ7N685MH3EcmEkeKLTj1tPF
m1JESxkfHoUcUI1dso4+Xd1jTbzPKQ==
=uFXu
-----END PGP SIGNATURE-----

--r3ixgbmMDEDfIj5d--

