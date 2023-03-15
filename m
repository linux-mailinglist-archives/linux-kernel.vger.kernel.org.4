Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB386BA785
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCOGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCOGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:08:42 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36ED1FE0;
        Tue, 14 Mar 2023 23:08:38 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F5xnSf012042;
        Wed, 15 Mar 2023 06:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=k19s+03om2lx/PE8c1eeHo6ZijEK4kzbvIjQ7gXbisY=;
 b=X5AH0l5O4iqcUpk1xpt/XjjFXYmboBOtdUvF0ziBi+qD9C+rSLrIbrYS4ulRKqNcbOLj
 oBQlzHjSn8yX8VQc2bDED85JZDy9k7DIEwlj7CnOvCX4DUcomhAsmKB1DIqz/lIm74CS
 eVZFuxx4R8ms4VxPM9m0wozaljHlrlnVgqUsxnVeMr3JIxSQPxcFVp4AHxwlM/Ad91gh
 sV+rZ3Ai/xARXntowREACrijtDXTncyv8OUl1ALoEpCX3jupt71j4hPmwW6BXzAW+IKY
 EPYXc6jm9p1Pp3oljtEfOBMM8L1Q01nlrotxrWOBej7E0vi/zppI/MVKn5k54cFxqZXm bQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pb5x8s3e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 06:08:35 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0C7A7806B45;
        Wed, 15 Mar 2023 06:08:34 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Mar 2023 18:08:21 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Tue, 14 Mar 2023 18:08:21 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Mar 2023 18:08:21 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Jueebau4EuR25kxVFKaBpfSPJxdmY2En6Ef+hmYExwGxHD7Ur0exj0O3lujgmwd2XdRwtw0d1+jU6wDZk8/XkQ3jrJCRibO2AV4diLbiANTjZq62Qp5+XMO9smuzwU08fXWTuglryuuqT9juJfyOzWozn7FIoxWF1KOUbQnXViG0N728CldkzGkt8mCm2VdVQv/XV/iCP/gkogpGf1QqNk5KpdIi68Wr0ac2fIbjev1gwhHZC5rp71ep3gpVH6SGFQd/6NUAL5QtSrXAklpsOn3MNN9ZPs9cquXIkHQyeyF1IHUmZBqt58Lr8wYx4eKhBJIXiW0vYw2eKdfPrUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k19s+03om2lx/PE8c1eeHo6ZijEK4kzbvIjQ7gXbisY=;
 b=f3rfMM756DPCpj8Ly0Bi9a8COKRg0OAT/yybcGzldX1K395hewL6RO6sl6zBM1l0qZlpLAfA4qH3MEw2/ri2HiVI8GBDCJrD5JEciLM3gYRMGOKcmn4PYRzhyCAHKAorkQFBa2Oten4EXaE45uXL0PK59c8t5WkYexmwlAi4PRluS7cbA6XVoUcYT0d/KW4BNDmKCkcp5vGSA4spfkLQVJUm3RR6BCWSitiSyN8IwKuaKYCCbjwwDq59EoLD6lYqFmSHNS5Os0XG9YhWXnRAJqAHEoPOv4tqvk5V4L9QPCVELnIMJZLgS6mGtgDBLzQ8/qrbzTEKo5wWvJtSDYeZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::7) by
 PH7PR84MB1535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 06:08:20 +0000
Received: from DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe]) by DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7040:7ebe:4715:31fe%7]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 06:08:19 +0000
From:   "Seymour, Shane M" <shane.seymour@hpe.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH for-next] scsi: Implement host state statistics
Thread-Topic: [PATCH for-next] scsi: Implement host state statistics
Thread-Index: AdlW08zNHKI7PyClSKC1+KomWCdnWg==
Date:   Wed, 15 Mar 2023 06:08:19 +0000
Message-ID: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1373:EE_|PH7PR84MB1535:EE_
x-ms-office365-filtering-correlation-id: 6a371f80-1e8e-481a-1112-08db251bacf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqifadiZ99BmblEIQBTEnPdJnaQ9T5Dtq+h9BTXQsq0nqKBGraY+EUqvhPdwZMp4OA2lp9ndDaatWhvBuAmDmnlzZ3H2Y9/GB41u2ddlSvFgNWr1fciKQKYc/hcuXXC3sbnsULagTZgX/JEA+XV4zW0uOr4EC06bx9u1A8mSvlRLNiP6E84+ygQZ2vT2HQpmSY6FED+8wuTef99g0i2ytszgTUFnI2SS7NSIv/soYmCrog7nnDGIYI5dKPBD2rELtrIR2LgmbHGxqIT8Nigyj6Nr2/28nG37Hq3+NmLXqpxYbfGbZewz2sl2LQeVI9NX4fjzDmR2/1mDFJh0pc9HVTvsf1KYpUu0a47HIAVZ2BCQq14Hx5UsVdlU4XlBXBjYU4QKf5PfwZBwh/mtMVoylK5VaxC287HMVrHGK5v6HJYNHP+nmyEUewL1SVB7JA2tiLcsH4KcwuBex+RdXoKmIhJlRdf7+4bwoTU2EZpgaKF9PhYWWuo0I6Iv7py3ndbA7RQ2Vg2ACQPZaXwvwg0tRYORteBPrNhMx/QSaBXMINzGX12qwVr62pX+RFsynT9pLJCNAfQO9seoWdgiKuShP2B1b/tKaPbOQmC6jaakWQeZr5jmDfa+xcH0iTh+nia31VH2xA3P9qhWhiHyFIEbLUMcJh+kJn5IpBvom4MaA1N/boiVDdSnHWeHHPUwJnqktgEAtXmDv5SogUV/wsnWRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(2906002)(122000001)(82960400001)(83380400001)(30864003)(55016003)(5660300002)(8936002)(8676002)(66556008)(66446008)(76116006)(86362001)(4326008)(64756008)(41300700001)(38100700002)(54906003)(316002)(110136005)(33656002)(38070700005)(478600001)(66946007)(66476007)(52536014)(186003)(9686003)(26005)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmP3wjz0gt2pf5Ml8b7mouvqESYOObOYbkHfWBlnc9NwhPsmVDwnLym2GNKy?=
 =?us-ascii?Q?SyQ7IVjjwp5HhY5JNXi3NEqzq1eK3+qRFS+wTeoynVYqg3/qiCVmPC3YkVIR?=
 =?us-ascii?Q?zfa5kGKhwUDe7zp+KxNghT+YUgeaaywE5fJ/lt5NBrcNNYet2cH8Gb3nm+mg?=
 =?us-ascii?Q?jlXeRUtoHOp9jnXmxDTVR9QPjlGXQvCBGfPHX6mhjqQM2Nb4Ap3GOG87tdZ5?=
 =?us-ascii?Q?5cHSZqe9dW6fk+Bqqi1l28Ed/+w69g3LQSBCx5YNfkazj6uJS3wDjStv2V65?=
 =?us-ascii?Q?BdjZ+ekH6/iFb8KAg251CW1opQMQrWbNcamCfmcvhOG2y74GVGXhTh+4yEJC?=
 =?us-ascii?Q?5+RvKyFqS6FOtHLKNVufq3XeDL71PwpZtKVansDMwsCwCZ62lYYOVRjmwLKi?=
 =?us-ascii?Q?GPVnisDwjEokadizsoe5E+szMDn5AiPj22AzS78iUejAWS8/gBv3vjwtfTqT?=
 =?us-ascii?Q?CGVCEu1gYOyJ3oBjytWB7BReV4iIYkoLU9pNARAu/WBUpBrvJjgG8ZVoqMxG?=
 =?us-ascii?Q?JZe00Kgc595CyubGPrGb3y1M4IgXSTwiSMDeOBwOw+GgFu+WrfizlpICyEdn?=
 =?us-ascii?Q?q7dhZXqasvrQ758I3RRSdJzQZzSJf4iYMJYNOKiees4g6Axa4AsxjES2iLBS?=
 =?us-ascii?Q?EtgNUVGqfUfar2FOSMBhc4f7x0/Orra9QD4MgB4f1wVdXgZnr7QAQibgnB+r?=
 =?us-ascii?Q?3Rq1bLmY+Wwhz1unDx+K8r6O9yil+oaRBZgInZcO43sK/MqU/Zb1fVmL+JsZ?=
 =?us-ascii?Q?oovyVjyReFMr/dkT19VU1M4SOgZHKRDfiTAFhFaKPE3ySVVq04aBT1qgt1sj?=
 =?us-ascii?Q?MNfHb22AAActnhFyEDzpQ6rEo14Mj5lP6OLzYvHj6IZwaFh5bTQibtT6acUQ?=
 =?us-ascii?Q?UPa7iyRYuNvGHv5Zfhk2dXXGEBYBlXd8ir4P3wbCo1UsbHOxecezxCmCvg5R?=
 =?us-ascii?Q?yvPnOu/m8Bt/56XtbGUSt7gSZjca3CJYHu9AAi6odX7SribnmWWH5vnCqMn5?=
 =?us-ascii?Q?uVEnlecqVte5Fvoj28/9LO7nFzzMOC85PphexluuNPJEeJ6WyxEcmU8Pplwq?=
 =?us-ascii?Q?09vbfLsLZBDbvjOl20eRao7PVlkeV5hWa3U0FNiFPzi7LtxXQ+pxHZuZF4M9?=
 =?us-ascii?Q?ba8JB4gn3vHzt2cZNrshVQVo6kUtyukfgKA8fNeg6T5ky1MFnjRzJ0mAqyzw?=
 =?us-ascii?Q?lThNAUoQo5EvYLd6MvR58aqqbPYeBDIFJMHhQIhgHHE4GjHXVco1y1xrAkrL?=
 =?us-ascii?Q?nXblWiZl+9VlO6HRPA5GbNAom5pR0LYogjBoHbVWcshl779Fnf9hWndlZfku?=
 =?us-ascii?Q?aMNJe1PNkdXmuo55jgMytgq0qjjh122Af8lxzhXzqUZlXR1OHIt7Q7/R4cBA?=
 =?us-ascii?Q?BuF9FNY933mefMocKNldEld53hh0T1zCGKq5TQL1FqpJ2eXkRjrY1ju98DGX?=
 =?us-ascii?Q?FFKuVLTppodQW71tlgbK+3gQkTvRxja4VQVwLYrUHx9jwndrgAfRxfhuBp5c?=
 =?us-ascii?Q?1S+GKZwqhK/udp8C8dKTnOBT5AjuHQIJE5AnaMtAVbztOHFrpwCRYyRz7ZRr?=
 =?us-ascii?Q?b6snrCcNdjFjtBf+n4Wgz7pIZAqFLKJHXYU21+Nh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a371f80-1e8e-481a-1112-08db251bacf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 06:08:19.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCYx+AKrRC43IpMKla+RUgJQ7+B+iIJQ3U3dGesC/S7rGhXZgEaoeuYTSOxksDLDW6FQ80uPeSCcIeFoMhGkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1535
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: tNkmDJuSTA6BGzPW_XS8zGeagVRO9SdI
X-Proofpoint-ORIG-GUID: tNkmDJuSTA6BGzPW_XS8zGeagVRO9SdI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_02,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch implements host state statistics via sysfs. The intent
is to allow user space to see the state changes and be able to report when
a host changes state. The files do not separate out the time spent into
each state but only into three:

$ ll /sys/class/scsi_host/host0/stats
total 0
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_first_change_time
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_last_change_time
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_other_count
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_other_ns
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_recovery_count
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_recovery_ns
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_running_count
-r--r--r--. 1 root root 4096 Mar 13 22:43 state_running_ns

They are running, recovery and other. The running state is SHOST_CREATED
and SHOST_RUNNING. The recovery state is SHOST_RECOVERY,
SHOST_CANCEL_RECOVERY, and SHOST_DEL_RECOVERY. Any other state gets
accounted for in other.

The current state is not accounted for in the information read. Because
of that you must read:

1. The last_change_time for that host
2. the current state of a host and the uptime
3. each of the above *count and *ns files
4. Re-read the last_change_time
5. Compare the two last_change_time values read and if different try again.
6. The total time read from the *ns files is subtracted from the uptime and
   that time is then allocated to the current state time.

The first change time is to determine when the host was created so programs
can determine if it was newly created or not.

A (GPLv2) program called hostmond will be released in a few months that
will monitor these interfaces and report (local host only via syslog(3C))
when hosts change state.

Signed-off-by: Shane Seymour <shane.seymour@hpe.com>
---
diff --git a/Documentation/ABI/testing/sysfs-class-scsi_host b/Documentatio=
n/ABI/testing/sysfs-class-scsi_host
index 7c98d8f43c45..2ce266df812f 100644
--- a/Documentation/ABI/testing/sysfs-class-scsi_host
+++ b/Documentation/ABI/testing/sysfs-class-scsi_host
@@ -117,3 +117,75 @@ KernelVersion:	v2.6.39
 Contact:	linux-ide@vger.kernel.org
 Description:
 		(RO) Displays supported enclosure management message types.
+
+What:		/sys/class/scsi_host/hostX/stats/state_first_change_time
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is the time since boot where this SCSI host saw it's
+		initial state change. For most SCSI hosts this should be
+		relatively close to the time the system booted up (if the
+		Low Level Driver (LLD) was loaded at boot).
+
+		Looking at this file will help you determine when the host
+		was created.  The time value read from this file is the
+		number of nanoseconds since boot.
+
+What:		/sys/class/scsi_host/hostX/stats/state_last_change_time
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is the last time that the state of the SCSI host
+		changed. This can be used in two ways. You can read it
+		twice - once before reading any statistics and once after.
+
+		If the value has changed between reads you might consider
+		re-reading the statistics files again as the data will
+		have changed.
+
+What:		/sys/class/scsi_host/hostX/stats/state_other_count
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is a simple count of the number of times this SCSI
+		host has transitioned out of this state.
+
+What:		/sys/class/scsi_host/hostX/stats/state_other_ns
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is the amount of time spent in a state of other.
+
+What:		/sys/class/scsi_host/hostX/stats/state_recovery_count
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is a simple count of the number of times this SCSI
+		host has transitioned out of this state.
+
+What:		/sys/class/scsi_host/hostX/stats/state_recovery_ns
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is the amount of time spent in a state of recovery.
+
+What:		/sys/class/scsi_host/hostX/stats/state_running_count
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is a simple count of the number of times this SCSI
+		host has transitioned out of this state.
+
+What:		/sys/class/scsi_host/hostX/stats/state_running_ns
+Date:		March 2023
+Kernel Version:	6.4
+Contact:	shane.seymour@hpe.com
+Description:
+		(RO) This is the amount of time spent in a state of running.
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index f7f62e56afca..1a010488b52b 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -64,6 +64,49 @@ static struct class shost_class =3D {
 	.dev_groups	=3D scsi_shost_groups,
 };
=20
+/**
+ *
+ *	scsi_host_do_state_stats - Maintains statistics for presentation
+ *	via sysfs of host state changes per host.
+ *	@shost - scsi host to track state change stats for.
+ *	@oldstate - the previous state that the host was in.
+ *
+ **/
+static void scsi_host_do_state_stats(struct Scsi_Host *shost,
+	enum scsi_host_state oldstate)
+{
+	ktime_t now, last;
+
+	now =3D ktime_get();
+	last =3D shost->stats->state_last_change_time;
+
+	if (last =3D=3D 0) {
+		shost->stats->state_first_change_time =3D now;
+		shost->stats->state_last_change_time =3D now;
+		last =3D now;
+	}
+
+	switch (oldstate) {
+
+	case SHOST_CREATED:
+	case SHOST_RUNNING:
+		shost->stats->state_running_ns +=3D ktime_sub(now, last);
+		shost->stats->state_running_count++;
+		break;
+	case SHOST_RECOVERY:
+	case SHOST_CANCEL_RECOVERY:
+	case SHOST_DEL_RECOVERY:
+		shost->stats->state_recovery_ns +=3D ktime_sub(now, last);
+		shost->stats->state_recovery_count++;
+		break;
+	default:
+		shost->stats->state_other_ns +=3D ktime_sub(now, last);
+		shost->stats->state_other_count++;
+		break;
+	}
+	shost->stats->state_last_change_time =3D now;
+}
+
 /**
  *	scsi_host_set_state - Take the given host through the host state model.
  *	@shost:	scsi host to change the state of.
@@ -146,6 +189,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum s=
csi_host_state state)
 		break;
 	}
 	shost->shost_state =3D state;
+	scsi_host_do_state_stats(shost, oldstate);
 	return 0;
=20
  illegal:
@@ -369,6 +413,8 @@ static void scsi_host_dev_release(struct device *dev)
=20
 	ida_free(&host_index_ida, shost->host_no);
=20
+	kfree(shost->stats);
+
 	if (shost->shost_state !=3D SHOST_CREATED)
 		put_device(parent);
 	kfree(shost);
@@ -401,6 +447,12 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_tem=
plate *sht, int privsize)
 	if (!shost)
 		return NULL;
=20
+	shost->stats =3D kzalloc(sizeof(struct scsi_host_stats), GFP_KERNEL);
+	if (!shost->stats) {
+		kfree(shost);
+		return NULL;
+	}
+
 	shost->host_lock =3D &shost->default_lock;
 	spin_lock_init(shost->host_lock);
 	shost->shost_state =3D SHOST_CREATED;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index ee28f73af4d4..00d41c8820aa 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -428,8 +428,110 @@ static const struct attribute_group scsi_shost_attr_g=
roup =3D {
 	.attrs =3D	scsi_sysfs_shost_attrs,
 };
=20
+/*
+ *	sysfs functions for shost state statistics.
+ */
+
+static ssize_t state_first_change_time_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%lld",
+		ktime_to_ns(shost->stats->state_first_change_time));
+}
+static DEVICE_ATTR_RO(state_first_change_time);
+
+static ssize_t state_last_change_time_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%lld",
+		ktime_to_ns(shost->stats->state_last_change_time));
+}
+static DEVICE_ATTR_RO(state_last_change_time);
+
+static ssize_t state_running_ns_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%lld",
+		ktime_to_ns(shost->stats->state_running_ns));
+}
+static DEVICE_ATTR_RO(state_running_ns);
+
+static ssize_t state_recovery_ns_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%lld",
+		ktime_to_ns(shost->stats->state_recovery_ns));
+}
+static DEVICE_ATTR_RO(state_recovery_ns);
+
+static ssize_t state_other_ns_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%lld",
+		ktime_to_ns(shost->stats->state_other_ns));
+}
+static DEVICE_ATTR_RO(state_other_ns);
+
+static ssize_t state_running_count_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d",
+		shost->stats->state_running_count);
+}
+static DEVICE_ATTR_RO(state_running_count);
+
+static ssize_t state_recovery_count_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d",
+		shost->stats->state_recovery_count);
+}
+static DEVICE_ATTR_RO(state_recovery_count);
+
+static ssize_t state_other_count_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d",
+		shost->stats->state_other_count);
+}
+static DEVICE_ATTR_RO(state_other_count);
+
+static struct attribute *scsi_shost_stats[] =3D {
+	&dev_attr_state_last_change_time.attr,
+	&dev_attr_state_first_change_time.attr,
+	&dev_attr_state_running_ns.attr,
+	&dev_attr_state_recovery_ns.attr,
+	&dev_attr_state_other_ns.attr,
+	&dev_attr_state_running_count.attr,
+	&dev_attr_state_recovery_count.attr,
+	&dev_attr_state_other_count.attr,
+	NULL
+};
+
+static struct attribute_group scsi_shost_stats_group =3D {
+	.name =3D "stats",
+	.attrs =3D scsi_shost_stats,
+};
+
 const struct attribute_group *scsi_shost_groups[] =3D {
 	&scsi_shost_attr_group,
+	&scsi_shost_stats_group,
 	NULL
 };
=20
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 587cc767bb67..e6229567a295 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -513,11 +513,26 @@ struct scsi_host_template {
 		return rc;						\
 	}
=20
+/*
+ * host statistics
+ */
+
+struct scsi_host_stats {
+	ktime_t state_running_ns;
+	ktime_t state_recovery_ns;
+	ktime_t state_other_ns;
+	ktime_t state_first_change_time;
+	ktime_t state_last_change_time;
+	uint32_t state_running_count;
+	uint32_t state_recovery_count;
+	uint32_t state_other_count;
+};
=20
 /*
  * shost state: If you alter this, you also need to alter scsi_sysfs.c
  * (for the ascii descriptions) and the state model enforcer:
- * scsi_host_set_state()
+ * scsi_host_set_state() and if host state statistics are accounted
+ * for correctly in scsi_host_do_state_stats()
  */
 enum scsi_host_state {
 	SHOST_CREATED =3D 1,
@@ -704,6 +719,11 @@ struct Scsi_Host {
 	 */
 	struct device *dma_dev;
=20
+	/*
+	 * Host statistics
+	 */
+	struct scsi_host_stats *stats;
+
 	/*
 	 * We should ensure that this is aligned, both for better performance
 	 * and also because some compilers (m68k) don't automatically force
