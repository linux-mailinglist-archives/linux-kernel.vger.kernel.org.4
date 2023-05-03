Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B826F6160
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjECWmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:42:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49445268C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hoq2v014461;
        Wed, 3 May 2023 22:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3oNs7VjZoRQtLk6+NTns46Uuyq7OZDe54A7/naaX6YQ=;
 b=N94HDfEYBfh8QfZiGYgOzO+PKG7uvUnlTQjGmq/DPfuW1d/ySHn8V1lyO8bk6uZgh1Ej
 M/gc9xaZtvlH4ssXcyowqCFVwM4AL44T6sM5ADMTfe9f5e7TrGHM4uh+1Ok5b8nSMkk7
 Y0Bp+ciVKiMTf7JSfkX6I1m9eSIioFBPQlr3mSbzrYYIAmAJsKvzrmIypkc48NaOuJNq
 wbMj0fynulk9zi5d/mEWwofeWO06Hu1UGC78qvvbXMhVgAbTzHBHg20kS53CC+ioBZxo
 9JNJi10Lxe/tUPsoqQHakh1vpDLXNLacHzN9PAVmn69zWUrXnJCpVLFD2ovi1pZ8TeP5 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140mm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343MDhMG040507;
        Wed, 3 May 2023 22:42:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7rs86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZiW6Gjx00Js76fqIKGKRUsPq60fZUWFpwJzrV6c37f7HEsF2ZZuq2OMmzI0Vh+P9hxLVeOJApIA+vf+vNIfo7ULGAHY7kZlrkEt3xhSM+aGEIf9EiPNo+W58zZ4I/0L8ZCP9gQXMNpGqRlrBZBeyJf6LuLTo2w8SNrz6Ae/Pvf5FAbT0z4/VySBPeeGL1CYsZfQjE5riWDYg+tA9M6psx+GcOgkXPmDyi6m2ErhQptEo4SUWPK1T9UXkyOLJqRasUl7lwamhqXbmc3vD5khBPsBhdTps2QeZIQW+lRbtyvPu70m5SHDGJvkghF4M64U+683ldld5o2Lm2bNGlzzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oNs7VjZoRQtLk6+NTns46Uuyq7OZDe54A7/naaX6YQ=;
 b=RQgj0Ca6gctJ/QLrDXsp1s5H1sZdcoTQxVPTVqevbJaccr/Rwg4DU8NBgcoSb7PZ28teMSSkNxbsk50937/APXqpswvAzQpCNZ1jJNsk76l0wl430AUmgeSVHfl2RsnvrjwhLiarupOjOfNPKuty0YPRwBYUpIhR4bm3GRBXLXKlB3P9Qyv03MXnZ/ICQzCvobzqrglICuLXlO9CG3O811M3eiBnAdURL0GGorPOjN1NGyRS6v6d6KgluNkbminPxgMo0GjVDdxTGmh1VuX6RjqfUDYKntOcrHarhp+bnU8xWx1Wy1xzw5zRorepW/gsk5exbdqCSjFoQ+0Gba1mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oNs7VjZoRQtLk6+NTns46Uuyq7OZDe54A7/naaX6YQ=;
 b=Cwjxsb340AriqPU7MhFnveqbOza6SYkJSR6Y1IkruMF+k2oAAgaSfAxgUFxC7h3ekdI+WxyBAxZY+rvg6fGS0M2ygA/6I7/2PHlNiKl18KBdCtyiRW2RtLI3g4rDQBLc4oa3ceST4P7KaIZ7g9C3OkbIvtAMOq6VSCqeqoS2k8U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 22:41:57 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:41:57 +0000
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
Subject: [PATCH v22 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Wed,  3 May 2023 18:41:39 -0400
Message-Id: <20230503224145.7405-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 22761ec0-fecb-41ee-2397-08db4c2799e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLquuHKGCqPIPuLJUyuZ0CFod26e8TZA/FspGrTLqpnwFuidrYS2UaA1hJSFNpWjuR1+Uq+S8C0Wi8rCxlRCygK6wUZcC0sP5lxHpNKk/8wpRw/XlP/n2Rfkfi4HoYsgPIKaWsxKcKx76dA66A2JV6uIv0j5PROuBVaPUB7d5g3wkF/23gaQwmJ0/7cHAvMvhyZGM3D075LaWoIzz0CPe052lSR31POsqNHuNvGziVb4KaHURfs7gHkb8APM9cgbsodwnuWqEM1kfvc4iuykEGyra0xeGoJJo+HB/pYCz08BcQC/K9c6t97/yVbNjgB9R4fYN+hNAuuSvfSgvM+6YeORojR6aPBzh5EUJf1HMZmNZxEMtZecvFj4VfsJiVMFEUAoG6hrRvZ4LzLxEhXuPmnIpoD78eJ52kr62M81yLHxDd7QEN6dz4GPciRcTxq5//tf79d/50upcryhzgJ9wwiXaGuDUaESo0SfopQVtYTaamh1sN6WfOVzjLnq2r7cEVHxoFk+N9Sz6tMLg3CzItBAzrPsQLRQU/3MYTo30Xwp/FNOWMCBOlxQKcANhA5C/uf0Rkvk1/KqfqhtvHIZadTUoIfks3oVxd3qh7mRG34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(2906002)(107886003)(38100700002)(83380400001)(2616005)(6512007)(26005)(1076003)(6506007)(186003)(36756003)(8676002)(8936002)(66476007)(5660300002)(7416002)(316002)(478600001)(4326008)(6666004)(6486002)(86362001)(41300700001)(66556008)(66946007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xTZCul1d+BvB4+Q0bo5kzGCIMyOKXAk4OZ7UtH6EZzGbT640buZi069nc4bf?=
 =?us-ascii?Q?pqG7ioJxYwykDD0uUWb2nt6lsA5MR0/H8GC7n6cbqzv0Q4hIPmPuHj/yUw3r?=
 =?us-ascii?Q?3WKInpVupPGeWyQ10T6ds+hHZ2Ohn7jxzDZGs5ia3kpgbhmWNbBcog7cxMYd?=
 =?us-ascii?Q?p1tluAbK/7On7QLq9oTo0jh4LBCc6a+gLAGGTk80KFHpRviOigpyCkf1uVmC?=
 =?us-ascii?Q?zU7gwuH4G2TQAMb+1BdnS+zBMInngQs3+Dg333c7O4vrvT+b2Kioi5QKRBfP?=
 =?us-ascii?Q?bx/qg5aoN8S9A/AFh1NLx8zoR5tCFRGGesleWdD+uv7SzbcLwOKJlSYi6M7h?=
 =?us-ascii?Q?YRjgDfiIJAi63A1LXVmCGbAtkwz/KbYUGZxhdrlSpxfP7aafpkjHNYY8hoM/?=
 =?us-ascii?Q?UyNSUREiSJELfdayCAfskgZLISOyaalqpspNlqAqnJAJa8RoErSgKrGQL/Wz?=
 =?us-ascii?Q?8xZjG95P5SNVs/KDXg4ZgSJTHZ65scQcGN7MteywtxpVjuH5BCIjbU0rv77F?=
 =?us-ascii?Q?r5712gFai7SzJWgJaLVn2IWyoF3ljUs6t7deNm/4DEhQPAJAVA2rD30TeQCS?=
 =?us-ascii?Q?ExeAwPr0l1PClryLPM3bjjhul4V86CvE80dgKylt22NJEWEl22e9tYG6nkMU?=
 =?us-ascii?Q?doaY0BeKV2TOyusWzvK2BHv7evHqB6qAxhl4RE/6Zq2k6uskXNGnt4VkP5Oc?=
 =?us-ascii?Q?XUcUcqiHYHZJWbMGB3ImktH7PSnPiJ3yRYhw6CIupvch4icQ2NpY/xBqdeDm?=
 =?us-ascii?Q?43nVYN8CtB989AlY/VUwObxsPJ5lWn49OavVOImUdQsTinUAmpDAB/W3nvFl?=
 =?us-ascii?Q?uhcj9i9ZMqTigWGGNoRFoPtRyAnn+zCp9LgDH3EZgLV2lyaoH0TNRyp1Ct8E?=
 =?us-ascii?Q?VIWQLcIEKwvt+7e77Eu6ryLrSEa9IJ+wkPRZU78Am8Ginuc9evBGESQPeCOo?=
 =?us-ascii?Q?N9iTpe6hrpEMx6j37TB5vcW2fa3+0C1OZjIZEsUtZZdHCF1j9yRS9cSSyX/+?=
 =?us-ascii?Q?UHpauXoOORPnnrTh1Y79jSU4hRLnasBFmuHaVeVLKCNgNPxB4ZHazF/q+dng?=
 =?us-ascii?Q?D75KtibFZ0vNlpZfahXS+RMTpvDIpNPqdHLBRfC3AIX+5w9rAmU7ZiJjBTLW?=
 =?us-ascii?Q?jTeixRvizdqBpX7UP18xNB8N3sn55kA6jFXscJiq0WhoW1IuAnTCUl/6vhUP?=
 =?us-ascii?Q?TdGOZP1rBdANXAUxA44SWARKvb2gNsyDqUkO4jREzAkC9BRGG8Y9YLPam3dY?=
 =?us-ascii?Q?a5N6Kb6e5wr0yAZxnYbw59RDgQgZJu4ZLMxxLL4V4tpJrJyU4gNedsr4xAb7?=
 =?us-ascii?Q?llH8jITtOHxWIPJH8eFTqFouq991OpPMRJzeQXmrUxlWmQIqQEsIV3thqwdt?=
 =?us-ascii?Q?1YGMSil29Idc8I4s74+dNG/bctnv4ZAi+iK6QqdWIm8R5Bb8Bv9Duzfc7F7a?=
 =?us-ascii?Q?QlWGSltUWfF8MfA2hxqmLlm9tJACjT7OESMylWlSp7Sj7Hx0fPeIvk8bPLAH?=
 =?us-ascii?Q?8pEj1wCCqEfZaQp0ZdF5Q2C2r8+JOxvgm8UTPigVFOVE8XL9lsSDEHiXiugZ?=
 =?us-ascii?Q?cz0mho29h7dZiSdmWkCPhvnruo/C5DvMDwzyoqfRGbgimcDvoTGdXYvDFXZw?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VL52c0T14ysK85OoULIme79DR39VkGHhd7uq36pMcBerhxAYPn2MEJCfKn+9?=
 =?us-ascii?Q?OPpAUCKJi3k/E5VbEXWcc/XYrM+agwdFHW5Spwq1j+Mqy1r6tlSc14fHivFA?=
 =?us-ascii?Q?QZiYUlJtU37cn5xYCHflz1wvAip6D2wZji8SyAeGNi8TbYbvGGyGlj5HL/jT?=
 =?us-ascii?Q?hEoHuYUTBGEZ0Zt5lq7fjGVSNQXXySEiMe1kmmlwfDHKx4E/c66FJMnOf889?=
 =?us-ascii?Q?C+mtpml6CN2z7tIA075CaH2A15SPDJa2g3EaggYKihNIkWUzSbWxgxplllG8?=
 =?us-ascii?Q?noCQU7yCfViabdP6WBTZYU2rr2DMfvHshcaLsROtTsJBZ4FkMgm+b+gyFQpZ?=
 =?us-ascii?Q?B5NHPQGge1a5trptRvTq89/lrwLQNtHWOma3nB2bSwrQnDXCNsHg9uKcoQtS?=
 =?us-ascii?Q?vz8eg7QWjXhtJh0GX37H2b+iCRB24/OyYpbsUcxVPszIUVhvV36BMBE56Xc4?=
 =?us-ascii?Q?lUkH2FVsJIM4tNnzdWPUQixcveYkx0Rl8t2M+SwYQYkPhDMbwZ/gew1IBco4?=
 =?us-ascii?Q?ddicxiA5JDxfCviTHAmqENuxbtBxTGPaXxB8WbEiwD7NSPj5xlbgtTAK5mwj?=
 =?us-ascii?Q?EKqCNXzjd9ymB+fgnWoHHbhUKiHNti0pVWODJVeLm08Xn91xHCHmLUc/7g7E?=
 =?us-ascii?Q?kZwGt2czIuMTRRLN51RuAxC+kMXDGmNeXAKnWyZFQwWbBsRztatk5b1ZmX8a?=
 =?us-ascii?Q?9pZ+0xnRJs1s8iV230wxmiqkuS/WLfmCd9ijQCpBdXlSuI0q9SE1Dct7/IuL?=
 =?us-ascii?Q?v4VK8sUe4ZSYbBV3Sop5LSo5Yce8fylwjqyjdcxYnfvfqD9KUhyLvHD39S9m?=
 =?us-ascii?Q?AIVDv8I4lg9i2mjP1Q4ySjTfP4NKWozlpDJAwE0x8AMcqS5T5u8dmWc4TRuF?=
 =?us-ascii?Q?iONFZWrzdxIULJ43M2XPuBxFQIASnxtMTYYJsWfy0G8IxuffQiT/YJYAwKDK?=
 =?us-ascii?Q?O/J5kBfQAU5rPkYYh4lC1gZszz7JA0iHpYGqMMO0aOOK8RYkOTk6GG6LRRh9?=
 =?us-ascii?Q?DW1Cd3L3gYE0PHiq+KLd58yVhK3K19pyoc5B/aacU3zwQzgde6w1Y/TSlKQS?=
 =?us-ascii?Q?4qA1VpMxr+fcarLMrrrThjoTGdRz0mwJrjdpsDhvPMymNz7+kcmFY1nKuub/?=
 =?us-ascii?Q?IUzTTeXzzTw/0lg+0kADcbiOiUk3y4LiQgxe63R15CfouW/DvjNp+1g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22761ec0-fecb-41ee-2397-08db4c2799e4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:41:57.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzJ58J4332SaWfPO7OrQyUX4BBgMSLNxgwzHCXlGC5t5ISEg1wXvXasFMEqIqNz37phhCj+IGpjAge4NeitMJLvQKARgFUPW4wmnRscZ74I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030195
X-Proofpoint-GUID: mxBkNIOZ2XcNnRSJYm8mZRSXL2k5NIH3
X-Proofpoint-ORIG-GUID: mxBkNIOZ2XcNnRSJYm8mZRSXL2k5NIH3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, this is the last state in the PREPARE group, just
prior to the STARTING group, which is very close to the CPU
starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see the discussion in the patch
'crash: change crash_prepare_elf64_headers() to
for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 4 files changed, 168 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..ef6e91daad56 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * When the struct kimage is allocated, the elfcorehdr_index
+	 * is set to -1. Find the segment containing the elfcorehdr,
+	 * if not already found. This works for both the kexec_load
+	 * and kexec_file_load paths.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

