Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B39965EFD4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjAEPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAEPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55E5C93F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:07 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3nRx014083;
        Thu, 5 Jan 2023 15:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ps3BoiAio0MOdjqrZtSNcNm+B6RZlc4pw1ST8PYID/8=;
 b=lH88vob+WW0Z5lt3+bB08sAzI/ml6xfwkPHO7kPnzMHxYLmkX0DAV2ScZBzcennP5dOv
 j1PDTFLwmqP1//3Md+ERHnLcDBNPVEyBocrQaDNd6xdDMMhDENwjPCyMDexouaOJtjzj
 1UPLMycctDTqBeUpwxLFdsOBAiAfOBLemuWOD3LyOSBC4EEBqWZ/EwUXgd79kKBQxz14
 bW2HXnYMHX44uypW+tTPFAVEmwF3bBbvAC8hV9s2qAxkFR7MacsiJTkjzpdndp9fME0s
 EsTguMKMQR7Qh+GiLaKA/CTqWey1unyFqaHC0ibxRX7xXQPTAF5XwBzqtzP9cofQJfyw AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c953y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPLm5012026;
        Thu, 5 Jan 2023 15:17:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0hpae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF8YwEAuTawspda7K+7O2v7sVmxVX/hqbgbTZ/yTwF7jcjkj4nXVRUAr6gmgjzX9GRbtEotgfYiTubO5+mHiT8bAzti/gvI3rnWDJRzA/bcYLe2GQ4RKGf897zwIK7GLPpevhdTq2/wn9X/oaBOJPX3xcrDB4/8lAuvcLdCDbBMd9N7wyQOrH0WncOhaAg8zLypI41pNjz12bf3dalUa/+POkV/sZuUWVi5janAb06zXNavpZtZrCiKr+/FT4DdsHmHufPE8o1shAyEFI6WvdvGeHimS0O4D1LkUUrbl6T3YQSIr3CNyVJnKuiqXbU8L4xw9NjBBl/Vwp4CZhf1B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps3BoiAio0MOdjqrZtSNcNm+B6RZlc4pw1ST8PYID/8=;
 b=gRKbqouOY5SOjJ2TQtZ7R+CiwMSi8OWTPyiDNM5lZspdM8uD4qcl7/yKLEfuBWYO3lW+4Wp+k4TDneCOz4OKK4fkGMwDGQIGVPK2uJegQqXWmPzMgraoy/AvXlIx1kV1BsFuR21g7b948wDv35snWF5cW8fUPffopnlVTPxO+EnN6aU74vGWYz6qpzvRShEp/cTwaDY+FOkucaTuOPKa7XClOYQvnlPBbms77TcmcJ0aIsBnT1Xc+sUIPE4gdBl30uNybUlQWjum9AEMrhzFbKxrRISHo4jVJWejQyTBBTMtq57KaDeogWmZw7KeG0cLc2eSYL/5lQNS47xqdj6spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps3BoiAio0MOdjqrZtSNcNm+B6RZlc4pw1ST8PYID/8=;
 b=cGMbwzxPkpO3cEFXsmWrR4jZSOR/GoJvH30jAyVDLu9MaA7jgz20SbtscCIexzMbIlypwuxBNwivhm5addVlIUNY3awClYY4xwgnd32sLT/fgfhFgn3DThegHWZLax1kSvIMyRL21WgLnLwa5vaY/bFKj71J4Akcb3GVHv6Co4I=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:35 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v16 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Thu,  5 Jan 2023 10:17:08 -0500
Message-Id: <20230105151709.1845-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) To
 CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: b236afb7-662c-402b-c535-08daef2ff916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iM1Zso81uviN6nyMzNRzSiz2El8zxFu1k6vXQzwSokXNf3aAD1KYlVFCoa8jEgrGkdrvLVjAP1tWRSLUC3Jq/ETyRmCCBQzwM251z1mtKDLcFrRcZZ+8bPww+ulI+wvpN7Ufu3WS6pt0v7XGifAAn55PHqW967gvWohqVLilW9hquw5jt1IH9Drk8YroMZkFB94X1OYb1/uUt9O43oYf4cBQ39/HJdCiW8rJ+eQc1ASkaZbq1kucdLvsCP3dbTw0Oyx5Sj25RecXzj0tYm7gyHEHEQZ5wJcgkmEAOWJ0GNXDv6hn9AhOeyayjrFXubT5ejxoZzOK01xZLf4dOyWQvatm52yS1gRFOOBc9Ea3/SJ4C/8bUpUDlx2PCYvO+HOG5ZPjg7UGIgt3rKyMA0y8KQeZIfmj9txkzdPWpOd2txHOXl9dJAo6aejsxTBl9Tmt7C14vl83hdYqbQY3srMOEVXm8wfvS1HfCaSddgh7Y9WWzaKzjmv6bZ3iqvQnAOui3MPUBMfyaEoQjzX7unp3TqCgN0XfT2cBXqQfWWXjIRLGVU9JV0EVllcVVEtMUHHqxdwHNIdojc9TLTxGboJFo/vIO/fL8nc5u+bdAQ3SC2fCygyQy1O832ZmLIcOdXSJKcreu1ySuj/OUPAz2DFAiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(4326008)(8676002)(107886003)(5660300002)(66476007)(66556008)(6666004)(66946007)(8936002)(41300700001)(316002)(7416002)(6486002)(2906002)(478600001)(6506007)(38100700002)(26005)(186003)(2616005)(1076003)(6512007)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DyuNRlYE0jTLZ20mo+v/Gi6oY1ncoIemLYOIS9xlbH5Kh/ham0bdZxA+4It?=
 =?us-ascii?Q?y/xoVYFzAZGU3zghtIAHpk32hqnHfDF/VfOBf0+OvcuH8f9MDZqPrRVqoGx8?=
 =?us-ascii?Q?AuhpQO7RTyW+ghVuyyaFMcBeEcQtASYscdHTqOJNHLo4UaIMpCsmWKTJ4zZF?=
 =?us-ascii?Q?3Edo1cJnkNfdyQB44JtShesm7kBnNaRX2Z6Le67bqzGpA06+EFh0r1QjHeGp?=
 =?us-ascii?Q?fhdtxG/2z1JTUGIv6jwBIq/vZeLm1DeszEJ/oGji/00E4X+o5lUju+I6bZ6S?=
 =?us-ascii?Q?JvaGNcc6F3DiU6Hk1+aE9FJy4byl8t37o3vBvou8NpUJ0LThtSTgvaUDxss7?=
 =?us-ascii?Q?4fiwr+D/B6aoPR5oW0xWCMRQPn5iXmfUSqLjnDDSiR8yVF8W6mJBdg1P+Zkx?=
 =?us-ascii?Q?K4t+rQpvXhmu7aVOHZCLT7tg6ukCcWCXN7VLiubRmIcNqajyoab3B66Q6LM8?=
 =?us-ascii?Q?c5CC+9eS3IDfUq/8AEqaGgxjysfK6dPt4STYVLdA9+wTTyX1DjH9KsRxY1If?=
 =?us-ascii?Q?xEmJqeaDfxygOi1dy8FxQAwOiuW+4fFUxbsoPVTD5dCkizqlZ8T4WOYcei5m?=
 =?us-ascii?Q?ZgCHTQ06W0zEOx7L/rpANjISQAOG7sUJVysWSuiKBOuMXmrzXA032xkEkBWl?=
 =?us-ascii?Q?ImFSN/1OIPRLmbgxShJQQNxAKPvLHud1lDUX6Xg+WMSp6FIRf7LBIZG3n0yx?=
 =?us-ascii?Q?bq9nheUsR8BDA+8T8OTYYWtNTTzKo+ofAsWS9GLsq3KAafPqMGCr4sYGsr/l?=
 =?us-ascii?Q?0n1YXgtzgHVl9WPO+bcoZRr0eIrNQW94fsXcfVaniR7dBhZEosGSc8/ydKfY?=
 =?us-ascii?Q?UWuCL7Ba9MhzcgZXDelLt6DOTzzZcLB7+FwPMmJIDJq/kw57EE8o4SKHLebl?=
 =?us-ascii?Q?xmniM5GaXa5S9wNBGu3at+Qr8VQ1cJUEhvuDs6oOpHDogAK2Z4YCrA/M0bBb?=
 =?us-ascii?Q?SJyiORDkRs5fqP7ZHpkZJEnfweXYlL8x1yd1wLLxV+Qb/dOUS4/0Dq53c4Z3?=
 =?us-ascii?Q?Q01yGHeocN2V8LdvSYgPYC8JieRu4eUkj1cmkrNNXNhBzDLEos7psi+lzbx0?=
 =?us-ascii?Q?PhjML7rGSgKcR9mEDixqBosfrUwUUgZFklASte+Y11vmtPLtxV8Fs3RaEvuS?=
 =?us-ascii?Q?gtUeVdDWFPA1nTi25NJACtdfnZrDy1FdYn2MIHMFv/eFUlV5AYQAcGP/844W?=
 =?us-ascii?Q?tJq+u+X25UxUiBf/aWFrX3i7DgvUPBnfRt8eA1XnO5aa842kvAE86jovz444?=
 =?us-ascii?Q?uRUs6eQEO+diisGsAl2ATb67HPceDZIkq1pbG3WQFDNYgw5rt2JV3f8kXZ/R?=
 =?us-ascii?Q?yc7ScCPowwxcBhNcYWZsKGD820VcE1krS5dakuJESQML0TaBFdMGJFCgOFNf?=
 =?us-ascii?Q?wZaishxYc2sZog3TkntyeJAGJFk8DEMHUqv2Uu7WblguNb6Q8JKj4gu2w4B6?=
 =?us-ascii?Q?9DiZCH/PGrcsBQ1ShPBNVEXHeO5rCGpiba4PyZnaciysC2g4O0+vjNBWhv3c?=
 =?us-ascii?Q?9VoT1j7ctUZ+DCYHg7DcX6dSkWYk1hTUieBZdEw857zSDp33TAsmwT0hipvd?=
 =?us-ascii?Q?Y8Rchjb2YNZ/aMMt2hVaagMpND9CqgPTKOUJQivQ3W9WaYtWTQyrFudRCXJP?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qKdEuHb99nIhFUU4aaIQLFP68eVQs6TCfYYjfbbcjN40++QI9NTX9nhAzspi?=
 =?us-ascii?Q?q2P1JokpKqa7cfkKWfx3UmbEhHuZewriSwmkxRT7GN9qMme881JbeNfR5y3P?=
 =?us-ascii?Q?JxHKnYizp4R+6PXwoLlZOZfeYrIbxNLsWPPFKLqxyWohwYlnfPiMR4CnQt+b?=
 =?us-ascii?Q?knioOQ594cnYbY/+hbuKuiWG3h7qW/+GlUOq5k505GXozkmJfHdFoXq3EJih?=
 =?us-ascii?Q?2GmhO2Wz2oEQaTwils4m+RS0693it+9bxsUeeoLpKhiJj+SEMGESn95hPF8R?=
 =?us-ascii?Q?Od0tdyJYndTr5Ud3is5HF+0W5JV1pC8uUFbb4j5T+7s11z2xPTwpUxkOwaaE?=
 =?us-ascii?Q?evozuucYIj5kqjUlCaWh0yM4lkyOfg1JAVk363WpDFCrUa59li5GH19OJz1H?=
 =?us-ascii?Q?Ln4z275WMxhLpMhH6zw165fd1SyuyNvi7vpQyMfNvXgza0E6kcmecQ4HqEI6?=
 =?us-ascii?Q?MoC2FGCxAT1zegoq7m6Szq7Vg3CuGp1PR8e4Gt42sSWdVDGpppAF8S8mtXqn?=
 =?us-ascii?Q?HtZjy7immf+VLb1JgHQc2PtYG2gcuETAe4OSxthOt2KQFK9tfp3tMmC/vnf1?=
 =?us-ascii?Q?8Ug0SifzNE13/cQuVGi6NH8McNC+6C7R+BFVpUDODOTMtHWUBZ5zhyEKvvaN?=
 =?us-ascii?Q?99xPhrTdGCwlOjbKirVjuQCIQ8lKbzC40zFZTDG8C8GD3maiNRhnhxkwa6Rq?=
 =?us-ascii?Q?1q7yZX2YEYuak4L1mElj21G5wdAKFCGEIOh0/omtZjgcAcUiR0RR1Iu7xpau?=
 =?us-ascii?Q?/VqO/o2C5HDDPyuTlzjMARl+16zpwbOX7/JUe0PBDlaYC0qBeDfHAbohyBBY?=
 =?us-ascii?Q?pVqGdLUd4i/LJLfjGnJpEUTtFcuLfp5NwlFGvByalDZFP5mRMuceXV/p0Gm9?=
 =?us-ascii?Q?WLhd+BX64rjwjV/Bk7iccEYptDdgdZUxiqUBdALzkn/8dfw1u/heYE4QNfIt?=
 =?us-ascii?Q?AU5mCPQWyY+R34WVMkNYTHYH9oM7Ox6n31UfPIyvy/7Cm7SgHIsZLMDmcf7t?=
 =?us-ascii?Q?5kEnJ1cWg1opsAIHvpQ+8dPtRj1+uzRAbOnrR5dUOs3w0Ijt+qPLkFSCbxOR?=
 =?us-ascii?Q?68V7vVNtiaVNsli6TVw3qc+D/89q0zLeQ0kcmBI6d8axLlYcKoEVyhjRc6Ad?=
 =?us-ascii?Q?1AJAVpmIYyGgayWSYYVI7BR0BJog5KHu5x12lhg+cjs2dHJTTP9bm7g/BqUJ?=
 =?us-ascii?Q?wtuKGWnNReleam0dJ8/cJZSyk8MK38UTWkAPBIDgMP22ickSDbEHoguWEZ97?=
 =?us-ascii?Q?sjOfMOI3Z3vEPknyNeUTBOv7+TwOLJzFUd+isdPN0p0DzQhp2ECDKNdouHbO?=
 =?us-ascii?Q?brfodL5gBJraSJijaRj4x59nYzbWk6AZRwJQSAJnFKqGTA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b236afb7-662c-402b-c535-08daef2ff916
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:35.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeF3rXjKfuF7uYg0iffr50TGE5afFxXsnplyQnEB0xHcOxXO5IK+RWb9f4xiVzv8DWSiORxNE8eh9Gtn7Z0tZdGbYz3U7Ho8Gij5oJQl56w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=995 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-GUID: zpRfaj7Z8CU3rbg_WYCe9-FsQN1wc4AK
X-Proofpoint-ORIG-GUID: zpRfaj7Z8CU3rbg_WYCe9-FsQN1wc4AK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will fail for CPU events, thus allowing userspace to process
cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..0c8dc3fe5f94 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe98fb8d94e5..a3f37cb57d79 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -495,6 +495,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -894,6 +904,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a1838699d7b2..0b1ad1ac06e3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -512,6 +512,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

