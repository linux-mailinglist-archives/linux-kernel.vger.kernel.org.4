Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509EC6AC7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCFQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:25:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2046A4A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:24:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxGKT013918;
        Mon, 6 Mar 2023 16:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0sBOBhpEoQMqxX3CYrsQSHX/nxiAqsT/1UeBSsRmoY4=;
 b=DKwkiofYwMMGBDgGZLytpLBLwsrS9GkaUaLp9AXiEl9Qi4MlLbdYIaqZ+gSTXqp0kuz4
 wo4k4DTBtN6snqohXKh/ghIwoPXfnsQVqj6FsbdcIZbfCvGAfK44KLzMZM7b1xsvdtZ9
 uwEXRpUcgcK/QuZQ3AH0MFuzw6BjiNiM8oGKXBnwNKYollTnvfdR+ypXopCuEYLIHLWz
 u8IZWdW6Rqm9jXobaLUZNQsrkQtC20LpWhKKQf6jeWh3wHH11NvXmoidu1192bBQo1fK
 6o5D/xA2O3nOLkaRJdbvqz8HJ2Z8Hxe/rTqhAYlK04jBQ+oEA+dbZFEh6lopv4uSWDkH 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wka94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G4u6r026640;
        Mon, 6 Mar 2023 16:22:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1dq61y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVe6Wcnfu4QQsEWIKpxqNyKRhT3hggvu68LwH/7tbCaQfFPjLUXBhSubIwu+HGpfPScMHjiXFpvClZUiDnxtVBW6ewex7yv/U4n7lxZp1pZbIDApzCX8/3nVwcpKp9O+ng0hBQEPWqr5DViIo1gSUx4rgRTHe9NJzNjEm4uKuar47C3ma8f14CBxdUM3+fmFp8+LRt4MU4bHWQPTDq2Yr5jMTwU4/kGJ1SGYfa25QOaUUeEURYWbXMl+AGA64G8sQnXcE+yyX3ld8A+Hb83kJidEM/mH/CRvRNDSINXS7QRuVKhUNWej9YC5xnIuj4siHNIs1dFXw1dufEa7nlDqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sBOBhpEoQMqxX3CYrsQSHX/nxiAqsT/1UeBSsRmoY4=;
 b=aZAQ0YggQTQ6SfW28sh8dcRV/mD7iSA2OkfCRGP6GgRChq0Sktuq4M4MLbgCpguqk93t6jiSMf/vOmOciofUomvDA9c/arM7RJ38n4EuhzGi1wbjSx7DhcFgyI+/0Edx/x60B0Epef44Uh8OP3Eo293ouuIR/qm7zwbeAVAp32VXoENb6Hu82mIJ+dhhoDBdevFwhDPAv70Wy0JbZ+eOulFfVm1AhL5DzhSxRwc0mDB7etugF56aKjJoKT8S0AVgxHj1L1eHqBWm5WTsI+ceTfoDxTTUenfFZo0cdhVF/WhlZc3zCLcP9jli0t2YPe29Ws0O7zC3dvJQKl9Jd+fRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sBOBhpEoQMqxX3CYrsQSHX/nxiAqsT/1UeBSsRmoY4=;
 b=PaJ8mRWIohRSp9dpEh7wzwi4jE+c7S7ElpE2Gg8wEPNB1WpPS1mEUHqFiNoNCMGvc2Dqs6RGjtAkbf6Fq7mMIarGkge1p5r9Xo3gcciVefQSEnsYm6QW7rv2vvO0kv3dmee30H9MV6NTSI69L+CGcqB9+K9vE7Oe8YggG5azf4o=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:22:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:22:40 +0000
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
Subject: [PATCH v19 1/7] crash: move a few code bits to setup support of crash hotplug
Date:   Mon,  6 Mar 2023 11:22:22 -0500
Message-Id: <20230306162228.8277-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0073.namprd19.prod.outlook.com
 (2603:10b6:930:69::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b5abeb-cb1c-4d85-eace-08db1e5f01df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PU+2sWhK41jY98KoFRmTzCfli7uHXrctrBfXo1Fhxu5jjX2kCnmKRqy+pHiq7GG5ld2SmfMcSHC2l1TkEswIzPjUw4v59vIOYCPOYVPjYtI+hYBxPvYplhmIn7gmpW4XF2ss9J/q+WJIk6XbIG/76tN3DBO6PJPWfyenZHrZowapUbrg15NQvet5EAVk38gOAft6hx4irZ8k+w/7L9kbfd1MeC19u5VXCSUoVuqXJNTVmWL1ELwQ2Wno06v8FNP21XE8cMdG6grKerlIbNWvew9UjN1rmevxH0W04zOsgt/sR6CK0WsPLQHh3C+m7Ic3QeRdEGb8UhJySip5mFM9eeQDDdrL0sad+vJfRIOU4Wttg+TmmhL4nMxmjXu4PZIxBy1kTtFZdUfZqsBXlcJ6UNUv73bOB2VpPy3Cg93KUk/3z3mDZ26gEEEVI1Cy/g7HoDrHvmGAlPaSjngI2Vsv+vQl5DW21X5sccOzNYYgtdo6n9blndeQiPVaQ7DX2dnne4FSsKZcnNP6zWAkCzr6nLTWTJ6NdzEPvYAuSAa4DeKN4I3CUQMStb6fVJeAUFQVeDjAX3mzNNM3KYbO53EfpfKDReTH8LpWmKKiXau0OLpzZRHYXWPA8K6xkIYJGrB7Cy/6R2xaBD7dx02fpZV39A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(30864003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56H34vb0m5R0v1v2bSftnOKok8kE9a9ywjjGePOwDvb9N4YPmqqvlxd3BgFN?=
 =?us-ascii?Q?Ho88S0tCsVKmHeetmjo5wqfoVDooVZN/FmvYqcwHc3I+mNIP9xXZoKvLWwWJ?=
 =?us-ascii?Q?m9fSaYnDL2SRozB2/rqS8SbKatb1TXOQGVOqf15attZsTJCmDzlXsajZN/28?=
 =?us-ascii?Q?+CWX3kUlDdc/EOlotqC9Mc5gWwevmZjCud0CSwTXcCE9fGl2xUL5Zpqp2EON?=
 =?us-ascii?Q?zR4OBHAtEga/mjaixSCkDfSn8FEP0yYsGevHitN2lVleSz5YdogHPuo2rHTq?=
 =?us-ascii?Q?A7bAt8VwuAQBk+0xEQhzJsX8B+aTsjhh/kjOOErYSPcsN+8ML/mJh+eR3Z/Z?=
 =?us-ascii?Q?haLY0TmFi8Q3ZCNjFj/ChIimBoJn1nedsJIWLqv9vcoDFwRsGcSWNwCFJHnS?=
 =?us-ascii?Q?OvP0ZPp8JaOEmu64cCQZaS0ScA/3Ojg/PiXKZOPDYWfwKPSlA/NgM+EDSI6z?=
 =?us-ascii?Q?llUHtkGtCY64wA7H/mqqK2gB1qcB6JY6EvcGkmN9oSZnl2ZAT42FuBKk+C3z?=
 =?us-ascii?Q?+3BuvreYW+RrO10dAUh9dX/HR/80dg3sH5vnAD+fT0m1BNNzzxtO/bZ1xyt7?=
 =?us-ascii?Q?HDIhgDyA+Lb+zIP0zZYej1Rb82F0Uy0N5SJPNV1XI3koszbbdYqsuX+74d4R?=
 =?us-ascii?Q?GQcBfY7xdoWAHV8q8yODkxUqLi2+LdU7v6jgwoc0fr92o3+42XrHR0Gi6saJ?=
 =?us-ascii?Q?9ogDhvGaGw4BlVEExOXOT+QZPvzeve4CZjLZCMOQOD+2OoWBWoD5QRq/vCNU?=
 =?us-ascii?Q?aIRRLJ9/Br07JPK2yPQeARwD0FCMFcXESNOyBYWg8/fUSLY6TdR5Gcr9+MGu?=
 =?us-ascii?Q?MV2Qmx+8icacMak7gnn5NbTMXHroNH6ZLVho/Ku92vnQLupdXzr6WIU6mboP?=
 =?us-ascii?Q?+JrkHBpysKPS/rGl/hYP4uabSRmWmqRL6X15Iw6lq3lMR5F11JNJWGyY/9Db?=
 =?us-ascii?Q?CxysKKU7swVRNFiX/EaGSNThy9LNIeo0jFVJfhHNi1g3dxYt1SkpmEAnPgr1?=
 =?us-ascii?Q?yiVTmbZZoJJULa1rnKtZjH98jJGkQsVf70IbSyG4sorlfXyXptSzmFLYRvkQ?=
 =?us-ascii?Q?Ioqb9U3tC4RVQBVDQhHJwCHmOg7S5kKhjM8TCvmOncRWqFkDs4l+AcY5aICk?=
 =?us-ascii?Q?eg6X3kRdYL6tIYBM56GpWmihZXKL7Su24mHBwTi8/4xAxFGv3JEUvhRH4Llw?=
 =?us-ascii?Q?bR6vJfKGzHg1bpWmgEkklt5f+qxTqAJhxaOAqV0i5YUBdQzCY3gcPI702nmE?=
 =?us-ascii?Q?ib4M/S/qntdPgsgi1Aldi0alW98KDdtWo7x4kDcl3zBhOibNFqycLJz+kl8N?=
 =?us-ascii?Q?2ls7rfhtGzoAx7qdcDCp9NIPLkCM5FR5rFQTvY4v6Ov4S5gJevUCTkV1o077?=
 =?us-ascii?Q?YBv47h6rygmhifz0Kw0f5q95Ql2BOS47XxWO2HEyLwFK6d01I0JWqAP2kGSP?=
 =?us-ascii?Q?KDyNb+gR0i+8DpVO2QTFgmMZjM1+xHfKCr1lMScLo3v1ESsB/nlvDhvdSfWR?=
 =?us-ascii?Q?G6wd+1bPp+rerNhkmCDMa2jtpkKtNykkOjlWjQoj8099iUxxUsZa95hIZaW/?=
 =?us-ascii?Q?0jM/6uG8yqIMSK3ZZ5m4+xaIv7fyLMbRa9yWTrwPBEsU3ol5SCAodW7FGVmO?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I/2+7AzTfrLuqlrbWM0HjK1nhTk5RycDBqBFZq+aYR2Ky8+h1v+q1w5eaYuF?=
 =?us-ascii?Q?GaDiarmug62/lI7oohZkwOgnF/EarKppHudYjEl5Rb9eZM0QvZ0TM61RvHqX?=
 =?us-ascii?Q?aBgzhMQvtHowXIxOaMq4rVmt4kNHPRP7KhyP05m8XlIklSUaysNkI9xG0wOo?=
 =?us-ascii?Q?agMDPtQFBqEpYdVg0LrKdbPaotFF81czy9rHIVHw7hc+LM2dTW5t89Aw7f+9?=
 =?us-ascii?Q?32QiWjKPDgnnks39f3zrgchpS1OfJ0GG3/bEUAbwiynXrJeMhfyAh9VmyZpZ?=
 =?us-ascii?Q?pDyCoqEd6X+NYa2Jutl2lbhr1BwBGjnAACWRBGAUz3Db9eyo9mX8GKsuwFmR?=
 =?us-ascii?Q?IyYinjcr3f7unN/is/wgV2yY/AqJ71f1PDG4KIOQsTJ41vLdW+KY2uF6p4Iq?=
 =?us-ascii?Q?3NLWNXd52JHSDfGebJxx+EqPKI8vNSAbJOBX5l78hM0yHi0uDy9ndITA5zpk?=
 =?us-ascii?Q?TJbFtF7OshPKvOu3Cp6+KVxqK8Gf79+aeo0a1A8XxT83Kyglvm7FvSnIFmZi?=
 =?us-ascii?Q?yjKrUPtSGo3YBmXBlgS9WamqTIU9KKzpdH9X+3wvx2ZJysv3o9Idsytw11i+?=
 =?us-ascii?Q?euVX6DtXYVfmRV41jAFUkQqpONOyCwfccfoEaNC4TfCvBLTPsYpCF6pntEov?=
 =?us-ascii?Q?/98WYDJS9WDq9/3JwTjW8SFKOa7EcG0YiPt3FLuHpmTesG5UZYdRYRMi5jb/?=
 =?us-ascii?Q?WHLTD9dKGKvhAvMgXfahvOiizKsb0yJAGiXLXaQ+r/5XdMSdcARE9jhcPosd?=
 =?us-ascii?Q?AntwOoCDwJvkNLR6vrG2huDNy1UnBs180w8UhTauBn4AxJ5h0p/09KujTruj?=
 =?us-ascii?Q?+baTMG3hMX7x7Dk4lxngosXv2B+2Cmatop9MbTHd1DOLKuol2+0w77xhKFuh?=
 =?us-ascii?Q?bnYErn3XYarUyG8CfAhfL6GyUWjtETB7ztFD43WFrS1s8obrUP5P9J1hIgS5?=
 =?us-ascii?Q?O5ONO9eFBgXAyrVzYMUapxzunM9BkLLFBhwOvbUNEiIZuU0jnV5JgKm1ECy0?=
 =?us-ascii?Q?ClUtJZKJzAg8NJulGDV9cDRNJ04QtLh9aP7LXZM1Sm0NNsllif+Nt2ss6eDx?=
 =?us-ascii?Q?3i/gDj8BKt4RmdYn25geKAn14/0vrs/VK4Sl6SyHSv4aapJzEYf2wIpF2dlu?=
 =?us-ascii?Q?EsqDydeHytZrAOn3THgtxTtUhs+vg9PYLmzmhaxdY4TMASLntmAPdEA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b5abeb-cb1c-4d85-eace-08db1e5f01df
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:40.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8WMgCkjmR0bv4G36ne3lqwVfb/Yjc2dn4Q8WMghoQDk03Kh3bcziHhbRSpSBQx3gqFr/0eHNWsp/oRFsvmzOmPQ2yPN4ByfasiNVbLiwM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_09,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060144
X-Proofpoint-GUID: dxgu-m26yJTBGYJ1aKrcJLccxIgfmOxB
X-Proofpoint-ORIG-GUID: dxgu-m26yJTBGYJ1aKrcJLccxIgfmOxB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..582ea213467a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -238,21 +253,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 87ef6096823f..8a439b6d723b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..ead3443e7f9d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1135,184 +1135,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

