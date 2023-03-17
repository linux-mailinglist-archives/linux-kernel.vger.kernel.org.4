Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7295B6BF3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCQVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCQVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:22:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BAC796C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:22:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HL1nYY024725;
        Fri, 17 Mar 2023 21:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=diBignMzdEGkUcMw4ioLTpqZlMYMezyF8IDD0/KYzTX7yNWVCUwgMtOIRKK9oHvKgdAx
 zXBSRHw+5EdZYxe6KdLZwlRqZzAy1XEpe4Akb1RJBgMrXnwXL2vSx+BqfiY3EPkPRG9z
 dAvBWHNOIJaEGuw6oqplfBVLUsWh7JoL87hH7gkAFJpR200JLr55EfgnniEGYnG2McwW
 25jZGWJN+GcjIYJfmY93MjYsGyHGJrjZPOUBAOugU0gpiQyF89P6hyqs1zsNkGBl8Xa2
 9JNF3kEes0mNBeXzOkzdtPQbXk2LRrcLLDhUjMJDyYHv+L4pyM4c0Otw+5lTCGIavCmY Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs294seg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJNwnt001119;
        Fri, 17 Mar 2023 21:21:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq78jjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 21:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJNG1PGbMjp0wqkjNpyB6F6R+vUj0K5P9+5T8DzsVc7Mng/r7/8p7v2sLYXMnFRXqdeyDYNTnXQtUQ2CvXikA6uVPPct3bknrOOKcnpprU5r/NieKFCHV5AsvaapBBLLK+f9mEjImB3ZdjBX4tZdrlgDO2Fpdg/IRGPMX5+oXJKhoNJc8XsA5ykbf018ZR/b9mbUgd4iY5iJ/QuZo9d0swzt/lojLWsmO3q0xePE09xKlES9iJusxa8jGOHyBB2WU58tixy5sTCVcn6MttZ8uVKOSz+V8rkv3b3mjdHDej3aaejd1DrcHvHQ/rwfLijw3Hd1Yhdmv1goakAMTrIkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=e9H9n3fCd/5tkegc1Qo1SS+i07VQYZcjkqYSP/Uyp6UyRxvv6y99rNm7acg3XOaJTjQfVMZZ73LXp4Nls3s6+FiRut0KujpQlJCwzOk67SqnKa+aMhL6DN4Fa+znPSvKMsHSzJF///kPOetfWRbtCAN74tChKg84Kwh+IXlxaMraDb3aRyjpnSQPEu0bIsg3uGfREGSpvcNgTJ6liADCcfxPkYCX8hFls8PcOwtOdXdX+heBnFRS2/uwBt8VZbvppJixRZBgq6OjoRLhZvXViWqMoPSwnlnVLSalktnBD1OrmkFZuxtMNqbYhqqsQMQAw4uxrjBRVfsATCdK+KHXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z39c7i32oLUZ4ubge8eBGitLtIahF77IQjSiLkcr4yY=;
 b=H+QjnQQduv6CQdBI+4bilVn34PQvjqfhdkFasD2fZyYVhn4uVgU1AeMEYQpw4g4pUgFz4CSqRh0kO7RHTxj30ViiGtgML4/s1YU9sLERBegu9oDBOcQsPkP6bx+6Szw0DdIKENhAyHOSoKwxStI/movQX/uxxWI1tswnfcfzXNQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.35; Fri, 17 Mar 2023 21:21:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:21:52 +0000
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
Subject: [PATCH v20 5/8] x86/crash: add x86 crash hotplug support
Date:   Fri, 17 Mar 2023 17:21:26 -0400
Message-Id: <20230317212128.21424-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317212128.21424-1-eric.devolder@oracle.com>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:5:14c::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: df57ee8a-33b6-488c-3bc1-08db272da0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFaGoHlyDWfVsuQ84cUukZ1EEi459Z+Gau3ltYVpvGfLD0Rmdiczuoxuip+LloCpvz0xrb/utMfEkr/CVN3WfzjLdRglMGpM/tyBOxWWwXyeKlKnlZsRIGAbLamPuzYS8U5qlDtGOalr7Zlmn92pjWf89tyYtAwt44IkDqkijkd5qZjxLQsaYezOORwSw6azGw73guCBmY9apSvAF40NaF1hZ4CvGpF73/zzEOdDq2dgxS+RE3ymDLIJvgnTBkq24C6t2EPqEB+LLwc94B49yAgW2uBKaXHwKakXIelbD9hteKK1xU6zO8/8qucWxUbbyApEe/irRT3kEY/OAVwicHcawPiPw+oBlTUM5/EX32dOXSwQb9zJlriiBjvSVHY4J/Qbwm+OTfS2AAOYi+9n269k1/gGwZdnaCAu3cgzaCvgT8OSlDyHp3qXvyENqlLl+KxqxO82LWNUd13zpDYSiPbX1Tww/OS5G2e+f0CL353GVe8gVe/eje8WK0zqTEhyrPPea3FPQhOkp0I9I74Z/5dQd8NpOFED9NMjvD57UP4C5FNhwXq3rmiDui4f4mWhmUyNLGKwCQSRHdSdomPeYTqiWqdUPxsA8YWdRmMHjO6bsCZI3RPiDhaURqYCFxasWLj03pTp7XQVnmXwmCDe5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(86362001)(36756003)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(8936002)(4326008)(2616005)(6512007)(186003)(6506007)(26005)(1076003)(83380400001)(107886003)(316002)(8676002)(66556008)(6666004)(478600001)(6486002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mj0VBWgjmdBFM2NJenCc0wOwSjgdIdV5dz/7wBzEoA4ZqFmYJWCkBQKq0cMF?=
 =?us-ascii?Q?eQ60SykIfdBm4UQ0A8zeSayYaUvMdN6TDpIWxfSvKnZSZBGaRyjQSeF5hDMP?=
 =?us-ascii?Q?iEVg1MWfXMx5HWwqs+u6k+JU12A2IxHdqTb5Yissy/Hdg2hE6iqpDRxc5FSz?=
 =?us-ascii?Q?M33mi7GqgMq5dOuO6qOP5hgbSTS1ZNWS7llc2l+4KrmzPyZbzhd84ai0cCEF?=
 =?us-ascii?Q?UAxnrdNrFtRgpWtbEOtnp9lShBZoGdl4ASD8y0o/0V0JvGHVEauV/1YGsqCn?=
 =?us-ascii?Q?5r+1Yuz03vBRALj4ULa2Koz/n2ybA0/sWs4DQosqIcRYGsWuiyRb1nFZH9Vz?=
 =?us-ascii?Q?q0wqfrWJ4Webo4NKz2L5ZSvzPS2BnCOLrvHTkKmpNawE3YrRgyp9mKFYkldm?=
 =?us-ascii?Q?fDCay8uL2yOHWP9eKQfYcOpCkc2ztuflo/oLKah62Dhv8L6esrXxVTr0pJHQ?=
 =?us-ascii?Q?sq5dSwRFd0IxpaZp5zsg6bEFkjTb6x435PTp+yQKodKAFot34vq8g/myzK3d?=
 =?us-ascii?Q?VP9CVfUHGmPWZlic3fnQFBTqyRSAA5NfzdZCCmy+/2OjpdAwNaksJDkKOfoA?=
 =?us-ascii?Q?7qXJOnjgr2ytfnXw52u6hokEqD7vQjqwTweAlgrEIUX2hbP8jk3BJNztOh4F?=
 =?us-ascii?Q?0OYKLi3vu2bzseUnflMdLqnSDyomay8i80rrwCDejCJm7jB3CbhKGUFFRp7J?=
 =?us-ascii?Q?wHL0J58I+8pOQYNBmWWelUk5AErh18YfM/gk5W6ErQBTwH9S+oMtUy/hJrfg?=
 =?us-ascii?Q?qcmCsOQyioEqQaIes9/FhqgRSq95mKv2dGuhgW7AO2Qk5lOxIw5h7C6oAvXF?=
 =?us-ascii?Q?MWrUwOptWsi/yGiax7PI2d2dIZo0gZZO0K877f07vOzxwHdglD12uizGuQtg?=
 =?us-ascii?Q?8EIaBUJUMcqMkX3tGLl0MTrGLENfnyz2WWRZGmfKxUZr1mySzeZIn+mdB05L?=
 =?us-ascii?Q?N4KBQljmYfbc9xT3OXUOLPQfon8Aj66z9QQyGYXDLixlQG9JJcIMWwhZ5CjD?=
 =?us-ascii?Q?kXxUH9+fkeBpS1mUgHXt02keOVULQ4qqrtWd580FiRWp1atd2WWCCAwFg1Ye?=
 =?us-ascii?Q?Dval5cEqFV6MjNb+LGLyhbMx+ynYTQeeEheRG2AlYW9MHNlpqFnImwvsgS8q?=
 =?us-ascii?Q?ZKFbpGqO58+OInut1DYyjYZGFfVpuukdBDdodeIEtFeqBjf2sXDOZOsHOf0T?=
 =?us-ascii?Q?EP9g+B5b+3+vDTyCSdYnqGIYQhljWy9fTLZAs2ZOV0Go3CRRvie7FqteDOa6?=
 =?us-ascii?Q?bq1t9a2W1SbMiF1U+4pFIyt9nwbzXHEZDajUNsJaDQB4Wp+sW28oXGL9ZCgL?=
 =?us-ascii?Q?yDys5IDKVEqWHnVzL9mknmaxReh0no4l9N0/7A0Ln9KvSdlpnHB+l3K12aO6?=
 =?us-ascii?Q?fAw7HgxM1ubBqDC1RJgkjwmzfarxM7ATxUcvF5rd9mk7FUxLdlI/vu+35wfx?=
 =?us-ascii?Q?OV/cNfg05WgGAndLSLkzfA9wx78L/Zke+LPRf/h46GMC+pxvqwZByxmVqJ7u?=
 =?us-ascii?Q?DkTN3TILV7Uk7Fk9o5WEw/mdFCErUE4EgMd92SQUOcqTJX47KglH3gQ98YA3?=
 =?us-ascii?Q?Vaasl8rSHpDRe3sDUWLTAJmwPoSvvABHbl0o8yg1p7arbeyZdmZOODOvURlG?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Itx5tT2s0POOP4cVq+uoU2lIUWGLAScnUKaY63IAAXC0RybfmzgCMcuk0pmv?=
 =?us-ascii?Q?vD/pQfmTqC6+lNJeaw2HiVkqc/qOFR+55RXTP397G30eQAc7nuni74s/R0vR?=
 =?us-ascii?Q?sxI+B5s5gWNXTLegcN4VlmkL6RV5NFvlKY9B0Lpv3Zc8ugM0clJH7DtbMAxr?=
 =?us-ascii?Q?wf6vBY3FfBUfTBEC8NQngeck19OClGwQ09ZpD66RfPmOSaSc4AePCB3jTGMx?=
 =?us-ascii?Q?+02ON6i+00WP1UE9A5sOtZfRkXdx2iVh69P2g07aUSe0+/9AFBOPf5o6aunM?=
 =?us-ascii?Q?t7LTEBy/SuUC4Hiw2bFCpTVr7zTJbxky5ZUMrWIo20+HvZ7ZH4toMixPEqJL?=
 =?us-ascii?Q?EdTXidSpZ70zvbhIYj2NTI/4jTQlR1ha/0/vFOxdX10sSWIhsfCYEbkCAh6W?=
 =?us-ascii?Q?okzKjTi7nqy3vVITz/RQ6h6UdtgqDeUE2Gq8MD2U2uwr61NSuZw2B+b7jobV?=
 =?us-ascii?Q?AX5lcTwo/B5bhWBPoNVgtZpOyBJKNXK9ylxKeyVIqYGMtVbxcJVH2q+A71VI?=
 =?us-ascii?Q?IpHS0Hf5trQGBgzSxRolZDmmSFjHVgV3/2JtuLPMQINE9gLvXbSzdhwdDF0i?=
 =?us-ascii?Q?31b9l09I1KCuv/nK+w/G7ooGUavNkMqq+IStWo2QEpQPoJfxy5k//LLhyW/4?=
 =?us-ascii?Q?qYUBEXG0Uz1u0kpRL3xHvhnQxzTUWqq2/BSnEzspuV+kuNy4ZePbJAX0P4Ab?=
 =?us-ascii?Q?Me0jvPNU9u1ocR2Dt5VkyPK8JiMD5cXHbshqB7rDDD78syhatmyOoRoYQ6JL?=
 =?us-ascii?Q?F0khnh8OcYy2e2VYs3Bai6BjxWg9/2ClkFHwWm6oMDNKeq/Qy/wb98vsB6Bu?=
 =?us-ascii?Q?ZQly+xsQj//k1Y767pXgqJXfidr2+2z1VOwzpo5fB7y/tNAfZQ+4NUAo7zLe?=
 =?us-ascii?Q?yGqtKy/5BfaC29Dl80Q+LqN4TQbvAQnCSEVATGkCHrc7OLFQbaxt7vvCdrY9?=
 =?us-ascii?Q?MsRNyaHgdtw8zMI7C8whfrJCfkEL6pfpAIg2gC84UZDuv0E7Yj0eC2aHzfqE?=
 =?us-ascii?Q?kiywRiWo+wzBN9xSJ9ftd9AzvNbd3dr5Aqe8tWAWqcf3jHsDH2axhlQKNoTI?=
 =?us-ascii?Q?7O4P12fnW7qDOQuhUsQgq4J1h/wmAzn7Ys/xzP9maJmE2YJXzktJf1ks3feK?=
 =?us-ascii?Q?uiwZHgEOM0vliEf0sWiHHWadzxz8MbvEGhmrELcN5/HPFazhf9i10Gc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df57ee8a-33b6-488c-3bc1-08db272da0bb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 21:21:52.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx+eXMDHDgk04Qm1UUfyibYNvr9UcVR/TYiD0kaLs8LIUORgo/bBz8Zqnjt9I7O4ETSSzL42TmATjkpFT6clH90tlfCse3y39AC8qgcKhl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170150
X-Proofpoint-ORIG-GUID: 8weVSYYs08WI2NxRHGj3E8nweGNr2ins
X-Proofpoint-GUID: 8weVSYYs08WI2NxRHGj3E8nweGNr2ins
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

The segment containing the elfcorehdr is identified at run-time
in crash_core:crash_handle_hotplug_event(), which works for both
the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
is generated from the available CPUs and memory into a buffer,
and then installed over the top of the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
only on the kexec_file_load() syscall; for kexec_load() userspace
will need to size the segment similarly.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
enabled, it is necessary to move prepare_elf_headers() and
dependents outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/x86/Kconfig             |  13 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 119 ++++++++++++++++++++++++++++++++---
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..316fdaa9a68e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,19 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..0c9d496cf7ce 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -41,6 +41,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -158,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +244,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +262,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +273,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +388,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * Ensure the elfcorehdr segment large enough for hotplug changes.
+	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +436,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * The new elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

