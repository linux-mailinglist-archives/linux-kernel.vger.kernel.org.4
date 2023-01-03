Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F383965C743
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjACTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbjACTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1614029
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:14:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JDsAe000998;
        Tue, 3 Jan 2023 19:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=W8Gt85xMEtaiuPPD2gNNoJcGHU+DxcUImoOJ0P8kcsk=;
 b=U9eypNmhX/36UN8EFWlGEd3wYL4ifhhhflK0/hz44UB8X6QyTLoSl71sigkA/2lMbHzF
 +73QhtbztenBeK6tQWhBIvUmYjdqhB0Jlgz0vdamfDENihMmNnTAtyesnJg7sjqzin8z
 R6fdHtxYO4yn2lDfpEAUeU0LdRZUw+HytO5FH8zLNAalzMlLeYT5oA11wKPIzJvpHp/+
 yneP3Qk44i5SVTmg/N63hOmiyFWBdMjbuaiuRaGkZrcpCA53+9n4dw8Dx/11V7JjtaJy
 LahHx/+y55qBqfyaBT8LWe3kXZ0pNE+PsAy0mSnYaCmfwdMu+lR69Ih4ucxs4dmvFD8w 2g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqmxh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303IOtmN012258;
        Tue, 3 Jan 2023 19:13:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh58pxg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 19:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmjhcLiQ61hNFOThzYTUXM5be4VWcYoKuR2q6DWuYfRCNL1NnzJPx2rxOUOBhuqbWj2W0T2z763jVmjZR1RJPdBaz7fA3m49veQ7rSxXoHAzFf+VuUu9lVd6Q3zIJSJaQmtJlboqnWwmhidZVtaG1/m5FG8rG3S5y1z0lS2a1RmQSMsrZcEPlGOptqjzUNmzIxMnktqZczTEft35YLgxTlfs6HIrXbHmYXwe+JAxbH+3s1F+EpyxvNXsSgRz33/cwbRTW+38G+GcvyZUv3mXr6+v1FZXXEHRWujeVUUEE6wm0FeYHwT9vz2ennySbadi7cam5PIbwKgQ98V2JMFNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Gt85xMEtaiuPPD2gNNoJcGHU+DxcUImoOJ0P8kcsk=;
 b=Chjo87XQUWO5pTg2he5Z4cGzsEDWbQumAlSXTSBH99kuiUDbSxgSsvOlhO+Hr0fozhVsDwwL8kW9MYlhtBjxUqU5kh2aL3bQhMVAUletZQNSOL1SMJtnAYcyOlsE14qCkp57fMo4UOIHzFJcaGOTO8ioBtqBis0QADkDwnH9n76UTbBRLQ52iZaDSCtDixkou66VvqFOypS3cCpQUwaFRx5JCaJu4kbY/Cy+P+2m3/JsoFN6GCQRdMeQKKCvBnoWHXJ+rT+Tlt8ZD+EB/G70Ef5uyOP5uyiuOPT3SRgm2fKaNnxQrNbnCrSzqZJZT6HnTGSzVSl4odCzNhehs9t/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Gt85xMEtaiuPPD2gNNoJcGHU+DxcUImoOJ0P8kcsk=;
 b=S+GJJ/VDhieBWpd6d3d/KQlK0bF4bK92GIa0nBJ4k80lU0saQmqYi1xD5JsTzbNNc6LSpnbOPIa/nCHduDQjNbp8V+LPnvGg1YHJuRw65FYMDjUeAnVTzvoAWgWNpFaVR4S+JSCeHUx0grlHTc600VyDP3chdZ3AjVw9v30Dz6c=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:13:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:13:47 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 1/8] mm/hugetlb: convert isolate_hugetlb to folios
Date:   Tue,  3 Jan 2023 13:13:33 -0600
Message-Id: <20230103191340.116536-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:610:b2::9) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc1d1be-4dd7-43f6-6a23-08daedbea345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbYCFoT7MLvZWVR+shvq9XxVImVDcdgfMV9gfxNY0KGC3/MVZZa+SXrLsdzjZOPBIRGr9yat1PPohdrWwxjD1L8p5NulcpYc1VRPFYaL4LS7/+DS2WRgfq2KVgYRSiy5mdl7dYHTrvz71b0bgWRsBU/rduvK1ubdKInO/5WIOBqrRq15UXXi6vN+3bdPCm4PIKj2gHdRr6Okqpq+zpHfdSShbK3SEd8RXHF8EEiiy9PiNYf3Wqw6ZP6iC6Mm15hn1nMhp6Fbzn1CXalTGzYNP7jjk4lNHXnEPDpfzt1BU7+c1wz6ttWVvxptkD1JsiIfZhy21g4bUdWivI1CyWSHE5DY0M5HuFrO+5uvVFXKyy62wdrWXhq+AS8eZA9z83xDESF4l77KX09LRP+jZ9FwEdiW7iQ5v9SDeTuWNDGB6b5pcjRGKI2RDS75t1q/XhQVJg9Qp4+98YjNtJOK7ebNAURzl101HpWd9+djvDlOyAoAKWh4/7haR4FXortbOC1qEjpZk2v/6c0eCD+dyzC9gLSA1xRglSe0uBfDvojTBU80rWjvAF1CClnZfcKtx8VoCGYsJT7bcuFzb57u5zYLrrerYYJud3q9EHCZYiV20LxiRv/XdUnbgYB5xI/aPNj8mT2iZYcrnwsulZOjwSIAeZevHFdeB+WiA+r515auGQFRgUTWAf6PZKdOuC7sgZlO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(66946007)(66556008)(6486002)(107886003)(26005)(6512007)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqCyXaJoxfj9v9OyNUfYRZ5Mvu3q4AntYWXMOXqZWAv4RT8nZTGfrqz+KGV9?=
 =?us-ascii?Q?tUPQSeta8K6bozmB+fE6dXCncoxAYEOBcEuUAKm6Ao4DVlcy5lg1eIu77eI6?=
 =?us-ascii?Q?lcyqFxrooKYbwgkwDIk6hE6UzpAuC11CO3QyBkxhH/AsTNTopIyz+7A3iyEF?=
 =?us-ascii?Q?G4QDD8cQ2wVN83OdyBLnduCJF/Hfku/xpPd4U3gute/+A/CMCc0Q3AkMTOHC?=
 =?us-ascii?Q?JiA2cY66gVJrcEfNDKQXVAcOossMq7ZB1oi3Oy07IfKWlJRHflZtPcxnMDjq?=
 =?us-ascii?Q?/pit74t/k2WdqiqFKHiLgSXMFRhpnKbyYJ+HbEk6ztLCeWcNGNNZf1u/5d3a?=
 =?us-ascii?Q?5oIS65U8d3ngyYHvigPuljdQL9xT+TvDg7R19YE9U5p6mXVWZA5lUkBmZmd2?=
 =?us-ascii?Q?4dDpI6VkLNPNJTTZjedI49fDyDWBPHT951VomokUSpz1SI2hxz9YuroNKN0w?=
 =?us-ascii?Q?PAWCUnHXrz205cPUui2SP4Bx9vLY0Zqb97vkd7iD/f3nDWoo9a9KyzVciyUF?=
 =?us-ascii?Q?BLVt34cH9fKK2iWCV3oa+RlmUl/72YELHRbxwhlz8IKlezF07uXqpFFbWoWx?=
 =?us-ascii?Q?DLCRMqhFY+LDJ+v9e6oz9UML0qJwaybEEI78sT65pi6oLey3y9O+uVzuBGd/?=
 =?us-ascii?Q?6JVkIDx2UIoGSJVcyZ+rPcQkbLyneKLy6PmrV8KUs5Q2v7SqvERl+g16/e78?=
 =?us-ascii?Q?AEkGuggSD2qBKm/QHqNWJ2b1ljeK4xgKxZ3tNEWDbiqR4aIuuY37S/7RwluC?=
 =?us-ascii?Q?73KWSVKKS9C9cTMIBTSHQOq2jscS6pKNsaAAvCYHuiN6eNHTdGD8qtDIg208?=
 =?us-ascii?Q?CIXNcITMjgqcvB4hdvA0BEFdmTniTJ9ot5wrV/uwsHjHwwm11tVFnrD2Uc1U?=
 =?us-ascii?Q?dzM6beJPNlMmmVESw6/hY/jSRtcXpUotsmmE7rlZcBa7cAH08qPs+7sbCVmP?=
 =?us-ascii?Q?5c5MfefrdS5edytr3zP479jh+lF5MLcX2mm/6YO8RMUqkzqfJKE9UVjkP20c?=
 =?us-ascii?Q?NlXtWMmBoKv3MCPbRZs1z+RiyrIvPY7TUGduYM/CyYrHDkLl+GBIwTHPHu/U?=
 =?us-ascii?Q?AIjLUUX6SkYdsw8JZcHjoQw+8QZDnvcSI/kugrSRPs3yjWRdD/fmKIa/TAMU?=
 =?us-ascii?Q?q6/iO7i2GC/+RlmIAFv8NPRyrUom68HsgHimEGAt8U4xW1YxFUfErPhK+vQw?=
 =?us-ascii?Q?yn03mjrArbTtdAyw8CZn1WaM0+3sp1xmiymi+3YdsHPiPEvvPzqc3rg8cWz5?=
 =?us-ascii?Q?S1hgpUTeR8h1nZfOXRAyJzo+3QmHr+RMbexJ4PXVlyYiGTWabYiz1LnL7b1V?=
 =?us-ascii?Q?GbvSKIUjhrARZUiW/eYjq4Z8sHqA8emu9nLOYGXr1aZV24IcvHNiPol/+Gad?=
 =?us-ascii?Q?YFKlEu2K3a9lbq/B6Q7ySl4NwOPnoOtsAKwza06B883EiBhYqcEXq8boXbpC?=
 =?us-ascii?Q?ukFGyLoyBOK7bGyQa3+vK87ZuPxplwh3men0DhqaiXdE9g8kULI/J6wQQE+h?=
 =?us-ascii?Q?1/IwdZ+hoOtDn9SX496x5doUN6tRR5qu1rCrO71mN0MWxPYAviNmKp1Hyw1M?=
 =?us-ascii?Q?Np+B1Ngrg/Fo6U6Xeq1UX2gKwC8h5eV/A/mwyY9MzQHw5QOhUXmpKd4pge2y?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Z9fb13iXKKmY+y7y6ZHev/RI3RszxFORlmOASuYr2n0IsMTVQNzkIxqSjsu+?=
 =?us-ascii?Q?HLXJ4cbuWXRciSKXegTm9SKmY81Plco+NDtJbryBoc+ctweeyjM+Z9QGYYDa?=
 =?us-ascii?Q?XkXaA9yuWFMFzt4CbEOe2YH7gF6Kc4GjBwHYU+uLMo1gVwbPXdax2JSEozw4?=
 =?us-ascii?Q?Uk6TbqIgNbwU+dZfwyqrJTpBvRXFq21+HV48Cq5vRO0av8Z3SXGf9zHo9rsL?=
 =?us-ascii?Q?lzByFX6Khn/XzLKa9+6xTyUcW2+liy6lrtBlycE33iE6PSPwvBK93IDvj774?=
 =?us-ascii?Q?rAGXVrUcA7fV3hy3b4SLo8Zc0QZuPbvNMQshOVYNjFgZEgav+f6SLuDZvGV5?=
 =?us-ascii?Q?4aEgCVQ3fuKCx4PNpJAnY88E86vrxBI/YOuTJyzTWwQwUDrwKmx2Ps+7Syvq?=
 =?us-ascii?Q?X6r5T/ind5lhFLC4qxLA5b5gaadQJrXZdPy0iNR7U3EfiDNZRYj4WeqKJ0x9?=
 =?us-ascii?Q?pq9L0fI/JlATgro34hE0P3Z/xHf/YoRczbKSt/5xvSrfaqdgTUbbZzmvXL2U?=
 =?us-ascii?Q?kbND/qb1F77FXy04xKsxAhgBiDu0ghKY/XkNI22lJ7/Kkq32FQx77nbAnMJ0?=
 =?us-ascii?Q?4Mq47LftPE5DxpuDNymfFyXH6lFjWEqp1lE7g+gZTQJuSKKXCqdJ93gZgInU?=
 =?us-ascii?Q?lNXB3+8rnA/qkabCwkeCVJIcX1AVSgWUiolAMlHud9uzygXyO2Nxx4pAxf0N?=
 =?us-ascii?Q?+t9CNLl0/KgWVjDORF08+vxx0/niOYc6hfpNHozRw6g6GsgdgT3cLhGt9KL9?=
 =?us-ascii?Q?zBzLAuRMZ0PF/hEPQjTE3WZDqKg/2L4u7NI4FuCr0j0hpKhkPqEyL/euNVHb?=
 =?us-ascii?Q?qbWs3MZUlNQo8dHznai5ZSJAEPUVv05fkMgpGzy3WslHKN0d7gNWGg4iSRpC?=
 =?us-ascii?Q?FM9zzjOYdvXRZ/1KTMQ6ZVee/DX1V4NqFUZDrauJjcQBLamjJfAPPuOU+L1T?=
 =?us-ascii?Q?Jc/VIKmpFB0nNaiuIT1UyrmgFfdacwrY0LSaE6Jz0Ts=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc1d1be-4dd7-43f6-6a23-08daedbea345
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:13:46.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+TZK73zCspayRfUjchOIS5VHCQHlnLXqzOZ9i9p8819YyZeKlmQxZPMklO2fo5e5gzspSd49dR8Aj2dZ4jiaFhkQvu6pE9Bkx09Oa60sjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=926 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030165
X-Proofpoint-GUID: 1eLh2ZmeRyzhNUdijLwG2NABm9zz9l7L
X-Proofpoint-ORIG-GUID: 1eLh2ZmeRyzhNUdijLwG2NABm9zz9l7L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert isolate_hugetlb() to take in a folio and convert its callers to
pass a folio. Using page_folio() to convert the callers to use a folio is
safe as isolate_hugetlb() operates on a head page.

Also add a folio equivalent of get_page_unless_zero().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  5 +++++
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 16 ++++++++--------
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 8 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..482929b2d044 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -169,7 +169,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-int isolate_hugetlb(struct page *page, struct list_head *list);
+int isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
@@ -374,7 +374,7 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline int isolate_hugetlb(struct page *page, struct list_head *list)
+static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	return -EBUSY;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e2dd5a37d078..cd8508d728f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -775,6 +775,11 @@ static inline bool get_page_unless_zero(struct page *page)
 	return page_ref_add_unless(page, 1, 0);
 }
 
+static inline bool get_folio_unless_zero(struct folio *folio)
+{
+	return folio_ref_add_unless(folio, 1, 0);
+}
+
 extern int page_is_ram(unsigned long pfn);
 
 enum {
diff --git a/mm/gup.c b/mm/gup.c
index 5182abaaecde..bdb00b9df89e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1843,7 +1843,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			isolate_hugetlb(&folio->page, movable_page_list);
+			isolate_hugetlb(folio, movable_page_list);
 			continue;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c58f6519b9a..90c6f0402c7b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2781,7 +2781,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(&old_folio->page, list);
+		ret = isolate_hugetlb(old_folio, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
@@ -2856,7 +2856,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
+	if (folio_ref_count(folio) && !isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
@@ -7271,19 +7271,19 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-int isolate_hugetlb(struct page *page, struct list_head *list)
+int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	int ret = 0;
 
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHeadHuge(page) ||
-	    !HPageMigratable(page) ||
-	    !get_page_unless_zero(page)) {
+	if (!folio_test_hugetlb(folio) ||
+	    !folio_test_hugetlb_migratable(folio) ||
+	    !get_folio_unless_zero(folio)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
-	ClearHPageMigratable(page);
-	list_move_tail(&page->lru, list);
+	folio_clear_hugetlb_migratable(folio);
+	list_move_tail(&folio->lru, list);
 unlock:
 	spin_unlock_irq(&hugetlb_lock);
 	return ret;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 63d8501001c6..cf60c0fa795c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2438,7 +2438,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = !isolate_hugetlb(page, pagelist);
+		isolated = !isolate_hugetlb(page_folio(page), pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd40f7e9f176..a1e8c3e9ab08 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1641,7 +1641,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_hugetlb(head, &source);
+			isolate_hugetlb(folio, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..4e62b26539c9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -601,7 +601,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (isolate_hugetlb(page, qp->pagelist) &&
+		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate page but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 4aea647a0180..6932b3d5a9dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1732,7 +1732,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			err = isolate_hugetlb(page, pagelist);
+			err = isolate_hugetlb(page_folio(page), pagelist);
 			if (!err)
 				err = 1;
 		}
-- 
2.39.0

