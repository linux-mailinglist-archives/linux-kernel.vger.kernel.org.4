Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE540628DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiKNX5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiKNX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:57:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3670FCFB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:57:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AELDo1l025717;
        Mon, 14 Nov 2022 23:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=VPPSt08uUzVOjjlup/WgRlm3neDn1ahbKHMnfHdh9ok=;
 b=x7jJ1MTJf2TWbSLZ5LP02EEYLKvL3nv5tXWJLsbwIcVfYTj2cxLi8BDnRG89giAN71ox
 0XU5bL+bRQaSqH25G5A9EqGtitKI9xaNVt+ULrTpJ/cE6PRQELa7TihoEztaEsJ1rU42
 hhDpXYVOA5ClbwBBD6iTRmIOGER+vz3Yl7xKkmemaIkmkXrMfZwBm/6xERrhIG8b34/k
 Hn/CPSZ9p0D/hWt3dvZQevHp9u2iBFCsGbxVUxMQ46KFjn8a/jZPJmdYWWM/m6BWxs45
 5e5FFaIEf6b3vf7BultyVUVOrYejBTg8v2bM/lygmy9fUtHu02lvw2AyWpLZhsqaD0gf bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2eh2rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 23:55:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AENTSSv031835;
        Mon, 14 Nov 2022 23:55:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xaxyb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 23:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5GjcZHp+uYezbxqpHjN5QfGxO48v+TKy4Yl7rvgpmjbVgzN9MU7Q4Z1Z3mUj6YaxmE/MejB5FlGpiODOL4Igt/vB6FOD75Q6DTTvEbnY4ll1VTUYdc2DVCwJAAi7lYBVTd8IFQ4IQO1ICS4Jrp5Yk3L3YQAhGRutmG914vs7hlT3ITMQkcBqGgPguFESk2chhoS7mrpWHl1dQ0u4gqGSgk7/dwuKQJJKliQnOPVmiG9LGsvPXxx+RjCczh5vwJn4YJE6pXvW+y0GBalqEpwNix/pCdaJFlRbldWALGJ5XL/e6ZB8webQeiWo3Vzjkdmm+EbzcbGmM0Ys6ljvVaWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPPSt08uUzVOjjlup/WgRlm3neDn1ahbKHMnfHdh9ok=;
 b=NPmS63Xpvpq6H1bMdt2mhGcVPV6gQpetbriaE5u1fVZok9RqsmpshPxJF04IwN+MtK9JRccXYFMyz/2M1FMDIuuteNu9r/ZWuTuqcoKgctF20KCnuaWBTtV11uUyQQlLQAq2eOLLhjhq2wKP03wB5IvAUYg+qmMAzCYS1lZJCd5pHM+yz9Oiv229du5VeByn2ZER3GoJNMmkZ9BOSqOo75yzUVs2U5zfRDUaVbpShOAwNQlahglWgHFIe6MwKPK2Iz6n0N1UhwIMyf2FxzJ1wtVYrfSrnAgK+H+ppi1xaB8DWMHGvv3nr7gyhCSSuSffVWXnVg3sJwYScSgRZv7PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPPSt08uUzVOjjlup/WgRlm3neDn1ahbKHMnfHdh9ok=;
 b=mSyk5067qaSkurjUL2xCDSTKb2tCRyfe8Oo4ltz1o4E81OBZXHKCG3CegnUtp+nbBNon8oWhFom/XZZfwU5nN34Ae36px/YyBHy5XCEYUGr0xe6HgvRU84f6K3GqFM+1ZKEsyfooR68A3nMgo9vThaz8gL82JfR1ZAfNChXjNwI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:55:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:55:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v10 3/3] hugetlb: remove duplicate mmu notifications
Date:   Mon, 14 Nov 2022 15:55:07 -0800
Message-Id: <20221114235507.294320-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114235507.294320-1-mike.kravetz@oracle.com>
References: <20221114235507.294320-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc96700-109a-4945-4ea2-08dac69bb169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8wugrLrt62cio3RX1j9476oN906a6Q/20mZCw3Ryj+08XNFD6Lg7bkLCyMuC+Lfq3/kygps3Ii13/rBDhaqrRDyx0rIRyow6elERrcnDAzU65N+S/YFw3bHlxIbS2zG5PTrDUw1dqsPDi3SpOznvI/JY/ivtXaieJa413DFp20dPtVZbLb9WFwKaN7GoUqdcJF2ZUMX+0e0InayaZNjmGvvcTLqbG3J7ssFAoq0DYsSaSL6JJlpIgcTmM2jMkI6kI9+wUg+T3yDMoiiNy5awCjM5/luyxWH0qyLQSMvKKULpTeCChAegMErajK+9LYrfMJ5ntrQWLoEwwdbcx/eqB6YwkS83EDyC8osUGFj5GZNGJb6LAh1VTd7GBIu5PejsbbYVRgJyFtV71bwFwxRNCb5PmrpiYR13UXu2+lKkpz4z+JZH5s6d2CkaXN01hMr0s0tbu+xh+n8o+bZgff0p8yhGHfQ2LEsaSqVJr2e8FNNm7WVysrPbc9CY0WQSyYNUO32oe6LmJqHBWD4mHOsGOSwVs4RgCaoUUxNfAfFhOrrdojXBfm+dP+pD5jPwQojpfCawiiWm9o5fbkbOnQBpIExITlvBU3VFfXVHzRrvn3J7W+EPx6CwPD+L/00kuTMsguKwnVo6PgiIYIzf9Uk6o5T6Vg+eEnqwxOuprfvUodUev5tX22ZNXILHhD+wd7/xH9EhuDJ/q6n8GILTvnJTbassIk5agannPru9f4kcP2ExH7P+nrfgc4hRvPMEbIq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(2906002)(4326008)(66556008)(2616005)(6512007)(66476007)(8676002)(66946007)(41300700001)(86362001)(36756003)(1076003)(38100700002)(316002)(6506007)(54906003)(83380400001)(8936002)(7416002)(186003)(5660300002)(478600001)(15650500001)(44832011)(107886003)(26005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJGXeqnq8xJWvPLkpxYGtKIZ5XPP3ESAFBDwGLJGHndBxy9OZsUks5+lkvc9?=
 =?us-ascii?Q?YK3X29FddfGHjBU/ceqAaTZJ/kD7O8bcRnpaCuGFtld1eULhvS5i5JVa61AF?=
 =?us-ascii?Q?nnqKow/xKuC7KrIwwfAOAsnwMow7rD++Bl8P+XTfadMWbYiMn97I9JwIUaCq?=
 =?us-ascii?Q?Hz8BKuxsQRmtuKX48aE3QYkD3Vpvb/hUUvyUiLlt83Dx1SZfWh6FM672hnXo?=
 =?us-ascii?Q?NjL1R8x1IP+WRlqj5SeEWuqX6nW6WyCBrsV9zmyUpmqTmK8gX7MC3r3QzI/Y?=
 =?us-ascii?Q?TU4QqEzVefMUGTfo06xAwSVWzn4DH4gzSND3z0CI1ROuEtUOMSCZEqkpVZBv?=
 =?us-ascii?Q?q4blvtyywGyL8b8suQOW4Ot3QRd8uU+GEiFH0ujcUH7A5hF/PiLrrn2LEOrC?=
 =?us-ascii?Q?kc3gy9+/uYHCysYulkwVAV6CcqprmLmz/pALEFneNjocnZqnfnwCNTbJwII2?=
 =?us-ascii?Q?um3L02teEdv161oyMwab6Rz175mQ6nHRUkRd1gpZ8UzyVJW/NPAXUf4IYAO3?=
 =?us-ascii?Q?/wf8EJzXEw+cu3/j1da7QIZbHUXIHuOgQQsZIsXUU88GrXzbADkn2pHLSjMt?=
 =?us-ascii?Q?p3D5+bziQi93P4Rh0/tLJ9i4gEmvwAX2raSSEQ4FoHAYTlq0eOc9cOFfq2y3?=
 =?us-ascii?Q?v0XN3jnvDKGEns5DldfP0+oCt+23tok87MXjKebMsrUFD+r/JdRz3FltvlXC?=
 =?us-ascii?Q?hUwMbqudoJwICcOGggxhxLSkaQTj+3HgFc0Zw2Ai/Do0SsVeQQRSqXbLRPa4?=
 =?us-ascii?Q?DmpS4m8EWIwNzuT5EuVnwbCN8Q94uHgeIS9iiHZaBO3C5eD+kxfc07Q6Gkt6?=
 =?us-ascii?Q?R3WGlW4rDLlMwonw2PgPcHiAnC9k8nHJFP7a0DOEPii76zJGieP4RBunE6kk?=
 =?us-ascii?Q?XrCnQ8OLS6WgrnKpV/BRn+b4wlWswqFVBGcx/bUCvHfKFRrF+u0TGXHfEStU?=
 =?us-ascii?Q?rcPmT4lnEayssUllGOupVKs4Vh9qcaBM8wB8C0RjMCH9JMIRllRZglpJbzhQ?=
 =?us-ascii?Q?nyogbs5YuPYmClVDmc5aBUxpnfPU+cfpUuGRiF4KcjF8n8xmz7gR8uaeR+aQ?=
 =?us-ascii?Q?CieZC1QqSTsN5oKGN2TxT58alxFQcLXaE1QLX2dI13v0FwVOtHig3nMN1e60?=
 =?us-ascii?Q?hPSYbU2t+bY5O6DqJIEXl0KK91GLHr5POQSsxnJJdie6dYH0LgofW1z5YzO8?=
 =?us-ascii?Q?Mm1uWvHsUtPM02UsUotfGp3FTn9DeoDuDCwGSv4bn6ECH17lMIEfJGK5F7C6?=
 =?us-ascii?Q?zqm3StO1PuzPVLSVl00stGBXIr4HhRGxsMt8wknP6Qx9oRxaKrJ/cY8yZb6J?=
 =?us-ascii?Q?KohiJqIrn+j3dpYOoydgNLtJcemdeR+6BA2CNWWDC3VfmP5i9saLHp2hCC6V?=
 =?us-ascii?Q?s1hCUStpHam4lxa8nNcD/diSo5nkgxTkoZVdFM2zYUBp+KaF+g4mFF2wzFEI?=
 =?us-ascii?Q?ZQ6Fk4HJG1hZfIUuaClNvpPIEXtMvdkCxSMj+78UEZ2FtagdSZCdrG/xpFVx?=
 =?us-ascii?Q?K39R97m0awwioTO/5vqaQ6C9xOjaHE0IIMHmSeP+cQoUbpVDScA+vGbgK9IK?=
 =?us-ascii?Q?WRVShzqh3l+k0ZS4TSZfnkRCFuAAmF9KG/mUK+1lAKLMcFVOz6+0WnQ75bho?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1Pl8jx9zgcBMVkLY+zG4GYUbKkuHPjwDrY0mIXNMnT13jimcnw5xxdDsX3fK?=
 =?us-ascii?Q?4gb+tpHPRvYSv0q/9ur67mrbFyXOEy1S0rjvTr2he7H6Ir+hLBOt5atBSq8c?=
 =?us-ascii?Q?ei5vPL1TI5QX96taFl2UJn3apXcjWFM2VF3ECkl3HGmD2/DYV+MmAJqa1Py8?=
 =?us-ascii?Q?CKs96XBm8vsjLymVGxwX8OauODTPkL1qOV+J1iEPUUs7lq7YDsquDe+KIsE7?=
 =?us-ascii?Q?PxLEIxK0jrC4gV2MPJqpHQou9di/7K8qkHqnZtz3/g03qe0Q2+pP+9qGEyJ6?=
 =?us-ascii?Q?4FDDuFe+QDBpY8geTJeLw4cGopxb2IoWy7J0ou4B/b1q89A0LwzZhQJOuFaT?=
 =?us-ascii?Q?rXkNKiQosyXuOpnzQ2lZM5PskmdpPOYWIyYaSS71hI0yiAQpLXm8Rul+wSUA?=
 =?us-ascii?Q?0gn01ZYWiiVjO81BAI+tRPadrW446O4iCJADzuLPOi+GkeSk2KnUJrta3fXI?=
 =?us-ascii?Q?EVVpzeHlZxHwKfPj+MBl5Gvyi3z1EDpbFOgX/b0IMtq0VEL74H+vysc0ljUL?=
 =?us-ascii?Q?5RNvRXuLHg81eweGvDG4+hC5YFMNmkQZhdNUO6zmDjNQPDASExe5y+NtrgJ2?=
 =?us-ascii?Q?3xqRy5unCI2y/VKeSXpadnhnWeq/oYjfbOcOKN52fLbPmBGJXzMLOUguY+Ru?=
 =?us-ascii?Q?/e5hX95L4H+Hke+suRCxZQ3oQ+gU9QDldJ8/C3lTiTKxuLd4FhSqXc1P79l1?=
 =?us-ascii?Q?vp0lpJiqQTGhgUvy4Y07nhiQlHA2uf9waWaRHIQs6simlUL+2WSrdnGVlAbV?=
 =?us-ascii?Q?Yd6G9qtzzbiNfDPKFZHu1ElPO9dlZQ0t8RDS8zpPcAIrRdIOdTgl/F914v+F?=
 =?us-ascii?Q?GkEytw5m39tSr/TbYb8HQ+QaVP0IwXdtvZsDglUx/DtwJq/8eRnP0cfiFHYI?=
 =?us-ascii?Q?iFlpzBBv73Msr+qi7ECCQ2hgx1h0AxqJtTZEwDwL+h2+omYp2lzzJT3wzzY8?=
 =?us-ascii?Q?TLkQUzMd4hVXyHA61mQQExpshVD3bM51DEnC8egt/QmAmNoDaVUwCBpjUvQc?=
 =?us-ascii?Q?VE0ZeBwWm8LeLEnZVu9c0jOqX5GaRwlo1jjuKErrbkKMYR7QbB3TZGh7QU+R?=
 =?us-ascii?Q?/tVqRdV7+YkZ5oduhN2t9Z02kuMOPFCq9e8HCMAe6A2RaLEkxKg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc96700-109a-4945-4ea2-08dac69bb169
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:55:22.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 555MH+6zYauQcw5wLjtFgZTQNbASmyzhNOwzuzMjlQj9AcsNFv3Ig2mFEmUlrfbDw7H2pyw0B5Fak54IjR21sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140168
X-Proofpoint-ORIG-GUID: 3eslPMFgPWOTHRGhIK3cSlPdlYMG2Luo
X-Proofpoint-GUID: 3eslPMFgPWOTHRGhIK3cSlPdlYMG2Luo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common hugetlb unmap routine __unmap_hugepage_range performs mmu
notification calls.  However, in the case where __unmap_hugepage_range
is called via __unmap_hugepage_range_final, mmu notification calls are
performed earlier in other calling routines.

Remove mmu notification calls from __unmap_hugepage_range.  Add
notification calls to the only other caller: unmap_hugepage_range.
unmap_hugepage_range is called for truncation and hole punch, so
change notification type from UNMAP to CLEAR as this is more appropriate.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7559b9dfe782..0cdefa63f474 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5074,7 +5074,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5089,13 +5088,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
 
-	/*
-	 * If sharing possible, alert mmu notifiers of worst case.
-	 */
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, mm, start,
-				end);
-	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
-	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
@@ -5180,7 +5172,6 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		if (ref_page)
 			break;
 	}
-	mmu_notifier_invalidate_range_end(&range);
 	tlb_end_vma(tlb, vma);
 
 	/*
@@ -5208,6 +5199,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 
+	/* mmu notification performed in caller */
 	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
 
 	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
@@ -5232,10 +5224,18 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 			  unsigned long end, struct page *ref_page,
 			  zap_flags_t zap_flags)
 {
+	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
 
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				start, end);
+	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
+	mmu_notifier_invalidate_range_start(&range);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
+
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page, zap_flags);
+
+	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
 
-- 
2.38.1

