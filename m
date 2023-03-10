Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E866B53C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCJWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCJWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F0104F54
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhxkZ001664;
        Fri, 10 Mar 2023 22:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=WFj74BjVDsDk91gUZrRUu96xe91VWTAKOq3E5PuYr9s=;
 b=Gip1Tgh57u6WQrq2vXSAvm1P9fUqc/2DINKsNDgLMqTNy3VZG5iPwZutfTlb6xa/qgQP
 x9nkby7r5sB1uKVY6AGeMwnj7J1IlzejvNDkjTNh+oj/uyDZC0/Tv2bQNcslxPwLkQAV
 1G9yEMoArfMg1XntDgm/hwyRM9kM9XVmWF0MZQQ41js2QCsZreNY70dRVHZ5conQTHPQ
 0+k3NtRo0xGi9f9DCOMS8htYh1na3tI0UviTPM+3l9x20TJjQQR/pZKp7cEESNnFfCEl
 d5jhftZYYb64h8iffz3URlvRacrKVNsWuVsGVuSx2xQIYXnblqXPk4cx1SoeOgKH3xQJ JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4181643q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AM0NIX025577;
        Fri, 10 Mar 2023 22:03:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g490exs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFzubORAc//SgDbIpztEkYdeuvoGFlOdYEpmgPTTsqIOqTBuVpFphWQrI8H/kkxs51x1iAltLVAwJk8fIYB1lyJ7hKS388rKc5F+vAgbZCf8aPOTp+bLDWeGbxKO6aZnH4nXMANOFJ1VqktSlWFFMd/sr1PQkATCTXu0acsQLHCXecgasfaCdGVUzO0x3JPK9luQIzahCaBo4/mn0xFzJOi1sbwSP5dtIeWWElqqdkxKqDW4N6Czu05MtXTz1+OzeMlOcIT+LIiqP2JMwz97B00McIcoEJqnHGt1V91PhkyJCXosQPUifpvFyeZGXl6u6qO49XRmVxmCiL1fc7eKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFj74BjVDsDk91gUZrRUu96xe91VWTAKOq3E5PuYr9s=;
 b=ULRDZC0M5a2ifta2RGhPnz+599Ym0LNXxAMcoxJozBJXRBpB5X5LTP/Pyq7psykFysoYs5IycCJAzxlc8sVVvXcxGSHaf5jsg4qF316NyMpG3N+jy4uBiUwbQ6WdGJW12U+USvcQ/uQujkb8iCmEAz4Ak+wkxS3ejrqHSLF7nOWMgtHjpAvPBJOBMngCTEGIZ9skmpT9DbRmyrpVOFvAeIWpOx/+ZvkgeMpQWjoDMFdnKVhbfJaYydPvM3MOoXfyP3bE9dRY2DYXWwAOtzaXcYXJcNVQ9Ib6ddwtEYqMXzug83DeExW31BJhvX640zp4fh7CYkLEKAG7EZTq8hzaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFj74BjVDsDk91gUZrRUu96xe91VWTAKOq3E5PuYr9s=;
 b=t+7kjJ73+TO5d0lNn3xsc6AhH74riE2vb/+ddnGckqYJAkkYhpMsT/9OgDInuD7mkS958sTXZX6SkpY5O6Mru4pKuG1N6hS8ThrPQoATbykaVetZBIUd/Hn8elQ3enykeGo+PftFc/lEfl7nneeaAhQ/V2LQ8+OGrZhbdpy1siI=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:40 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:40 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 03/11] kthread: Pass in the thread's name during creation
Date:   Fri, 10 Mar 2023 16:03:24 -0600
Message-Id: <20230310220332.5309-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:8:57::13) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f18f69-ff10-4767-2c94-08db21b34e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Hl3o8Uw4hM+qEvUu+Vl6xQvxZHP+HnOMEhm0GUAm9jPmIFL1tXyp3wL/WH2nffyhNxnEuO0nqsL5JCu1a7rKukFQRx4BAQV+vbGPYmcUosupjYIVzgeNc//fGjE9pW7peamqecKy7M6s2C15F1qMrt5jtj7ijGv8QZmdS75UIGOLGviUNvyGWAlyVIE/bajNdEXUbvdereNXyEcTBokNYhGUg3hY1kYyFuSgJhwgyD8Zez4wxaz7a8a527/iTAW/+C+IwFSPo7ggN0bJqlca75bnqVOvb/vw1UBNC5eLJDaz6vSrJYF5cYaPiNOEaszvZQne9MRJ0RdpQtNYZfGKKKwJZ2F0Uo1rDa/8SDQmNxs5cUkSpfTGXE6z+s33NtXEsh278X/fDM4azTat1faIwGNF7By/X8JK0mKr3dHPH0IKY7+nIhzlxwm7poqE4jdl3mxgcuP1nt1c3JoeRQDAPzOgPHfDDBhQC1elTWzEOZ/0vFk2foonc/qzd9o2Cxuo556D0DJ0S2TuI1s1ablViZEbol05wVDGNX8QyaztNAcwW8h35Phm2TY2Y91uN3d4genBDckNJuZ+nG4tleWWStbWDW31adhKM+r2lXY6MQzHj5EZuQRgsga+Ot3ELtLpYRUshFyz0KT8hDSpzFEgC9rsgdNYIP8LjjF3H0oR9PwO4YjUBLp8gNWX8SihQZG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(107886003)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(4326008)(41300700001)(5660300002)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L00NhVzd1LJqTqqGFojzWozAg6HGBI+Xw24ffjl0HZdE8oBVCmyUkC3w1GQa?=
 =?us-ascii?Q?GabzJgqfMvrHcp3mz1s0SWouIvK1rI50s4yOq76uTZtFAhAssqXKV0lr4Pxg?=
 =?us-ascii?Q?BowZ2XicRI2Crecz+agPVGiBcWywr3zBZmN41n6K1QFP4OgdYofNkjeFoCgF?=
 =?us-ascii?Q?0cBDmi8ZgWB8iLMlyvAAAtTJNctdlnnknMLk4hUJvXNC2WtdS0Q/NOGBU2sS?=
 =?us-ascii?Q?SrB6Vzmavl8Ot2rFOhYZLDHdyL91CupdWH+aqvEOjVP9fS/ZEA9xOGTXssxW?=
 =?us-ascii?Q?G47PEHhodtLmX7gPI1ayAE7fYHuhjr/ZlG2xYL0xDvBFL72R/colw4JSFq5W?=
 =?us-ascii?Q?idyXZW4CHh92dRceWpMZzasEHJBUtPae1S7sY94cE5WmPcHyCksPIepK8Fad?=
 =?us-ascii?Q?4V8UasGY3v7JKEuTVWPzVGHWgk/XxmYEQekkH1tLKhXiDxncS5WNyjK7fXnP?=
 =?us-ascii?Q?4VW9X5Re+enOg5zE3Keu6OFU8gMuzhbB2azQvJ6k6kjBh74ektoWhYoiHGlR?=
 =?us-ascii?Q?Ov2pRgRa0x6LIokmg/lMHGQXlNvIq98V03DCfBrG12wzbVIdYGDFIK1zBXnF?=
 =?us-ascii?Q?bov11ArDC7+yx+uP+8I2YgDFbPEFJAgReFDx+CAT759Jx0PfFsFuDI/GwgnS?=
 =?us-ascii?Q?MhaO4DegPjOCJdSN+VxYA1Y1AuHuTHBtmMZHueREHwPYxS9ANjSxazSb3Pl8?=
 =?us-ascii?Q?aWhLzw9RyIHth1XUkUsIwC+GDsIm98RqGfCNGKJWAC7zXR7a+2UXSZIXQJHM?=
 =?us-ascii?Q?4ywwFCmh2ZPG5aqsFJbgugXi/DM3K+0us9bgMRFzPmlbb9nFR8WIEP2zxMCb?=
 =?us-ascii?Q?57mbv7fQXWAAmAnvecO+mn02pyxLjot3ccWQap6NDcM9aD1rTQs6YuZKGrTh?=
 =?us-ascii?Q?Nuu72+t7ML7MAjlD2ZYYCu0O5jGtBrlcHbng6eHV382C5kNp34drKoa+WeOx?=
 =?us-ascii?Q?MYpM8kmVUXoZ7LpQ58+mzX8kPD41TfPSO6v/iScLPo+2VrtCJGlCgHm3N9v9?=
 =?us-ascii?Q?8Xv4UzyUT1U49NXiDVCgD5i0O2KEv2EsnXiAtxGL7nUzqh1omy3fj8meKMDe?=
 =?us-ascii?Q?7aoIQsSDD3Yg6c24KIG9OcfjglLP0guWNjC3U2TtNZktyxIPrZlGZhk4I+Kc?=
 =?us-ascii?Q?jSxt6G0kSvv5SIqJ9G43e87w+s40X0VPRFwYucKuNXHda87vMmGaWembKegG?=
 =?us-ascii?Q?lJI9M13N0VR4DMN6CFr/VqH7DrKPG4nxDoGWaILTBUzc3ZE5QvX5lZyXKL2v?=
 =?us-ascii?Q?dbZYMi6CFOf/KELztnPoeDr97N/a0HwNBedZlccXgTLhdPNn0V5ROgwAb/9Y?=
 =?us-ascii?Q?eHfrGiddlvyc74TWJ1F+GiZFBTLaPsejavf3X9TVIRyrLRBWRW+/kNblEBK4?=
 =?us-ascii?Q?f5PppMrpZ9BJy5bS4cRf3Zzqi1DLo5zFAstiOageRjoeNBHiwnBqG59D4ugy?=
 =?us-ascii?Q?NIg9uOBWi/MtNgeQ8O0nQ1I1Oysky36hG7iDvhPSFfIoTppjGu7U5X+8tUPN?=
 =?us-ascii?Q?zruKJ9q9H3OVM3olGG/EcUhE80w5FpG8Sk6j2jeXfML16VXusjSAmaeT8C51?=
 =?us-ascii?Q?HvYvWvzQPaxjCReniuz3NGkxeYnHW7g0Ao37pe+kh7Z3QQLWpVRwWjE/LvWN?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CsijrVVbkfskwhMAdQNwt08ahNLEenZDm7G9CBuS4cRl3R5VBNJhVwr3iFty?=
 =?us-ascii?Q?MGSNY/efVhKpdBV954OkUegEujRRHZDqwnwqGt/H77Y5bkf5GVaS+YX8lkBv?=
 =?us-ascii?Q?h3/CJY5+rfQLQD3YxzunyQsYvJF4tW15WktbGGTnUZKgeh6uIrcNmXJ748E1?=
 =?us-ascii?Q?dGs+ubi98KaJ+AWwtuS4Cj6ZdEjkAuw1GlJ/5Ua/iqP1njkS7/UXJPeEvtg7?=
 =?us-ascii?Q?sAivEVfpkD2UYqRrG8kNXn/EQKhoRgBMWyOozcR7IpPm5O4gB6EH/gwPudDy?=
 =?us-ascii?Q?BuBBsNr9Ez6ixVY7c5LcgB7zMjT+S77KOB3o3KT8bI54JGJBTg47wZ3TCkOU?=
 =?us-ascii?Q?ryC5Na0RLpOSB23rXZJasvZwR9bwa3wTqfBD44RW0DYVeJvy5JgsmbWH0i1w?=
 =?us-ascii?Q?gcgqo5e2vbePSPeKcFL2+oAkxgjKHXwIkAPkrNk2lQeX3kH/dt2acml+XSzT?=
 =?us-ascii?Q?6a7QJL/XNOMtzySOfq4s/11URbGYVbiyIfxDGmR6/B89/5Cx52rOqWb+hKMg?=
 =?us-ascii?Q?ZEjL56jNloKZUgCpXFtaJv4bVVknh/RLBVFm0V2SzVi+05Ygm44h6fNRKD9e?=
 =?us-ascii?Q?rOX9n+HX2bk+xElKN32ku8X+YatIEvJzh6u1nUwjugPfJVtHlp44gJAZbMmH?=
 =?us-ascii?Q?3Bahf+SL3+6sf6m8oS5tylW81uqtqO0OkmEWVXcmvR9SCYwn/y9iIC2h0dos?=
 =?us-ascii?Q?bYKkcnOmkIdUV09/OtUXqdPgqElq+EQsvSIwPQ7pntKBs9bHnbolqpRhNVuH?=
 =?us-ascii?Q?mKxHClCfv/NHBDHcF/YJwnU9YOp8SWCI9vLDhf/DKH3I+Mp4Cq1YoYW6AidF?=
 =?us-ascii?Q?ue7BRkZN+7VxnjLA+8x+5Zgf+9A41g7/kxkG25w4NZdoBjh6y89DnH9g9Z7o?=
 =?us-ascii?Q?S6tz50ReaUR159/a/k8uLCPoAH61cnbG2sR7KWnhfPNOKGrnEfDWfuuBmsMt?=
 =?us-ascii?Q?akjw8u7XFiU5yZRvjEJvdnnAqenIqHJGQSVokJSGNwzWpQZ2hhfCVOTGz9ts?=
 =?us-ascii?Q?BSlLMVbZCEqZ19QYeJbviZG3dQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f18f69-ff10-4767-2c94-08db21b34e58
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:40.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwnlTw4QJgM9K8M+DdKKZE0XEeRSDMSwCBnLKQP9oFnvF2osaEs9edw07L2BDz+siyUm0qqOKU0lrozd/IUNgcV0m3pk2XdHG0TxKkpe2Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100176
X-Proofpoint-ORIG-GUID: VyAX3ytKY0PC4etlzF91RLUPcDXd2w4M
X-Proofpoint-GUID: VyAX3ytKY0PC4etlzF91RLUPcDXd2w4M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has us pass in the thread's name during creation in kernel_thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/kthread.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 63574cee925e..831a55b406d8 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -38,6 +38,7 @@ struct task_struct *kthreadd_task;
 struct kthread_create_info
 {
 	/* Information passed to kthread() from kthreadd. */
+	char *full_name;
 	int (*threadfn)(void *data);
 	void *data;
 	int node;
@@ -343,10 +344,15 @@ static int kthread(void *_create)
 	/* Release the structure when caller killed by a fatal signal. */
 	done = xchg(&create->done, NULL);
 	if (!done) {
+		kfree(create->full_name);
 		kfree(create);
 		kthread_exit(-EINTR);
 	}
 
+	if (strlen(create->full_name) >= TASK_COMM_LEN)
+		self->full_name = create->full_name;
+	else
+		kfree(create->full_name);
 	self->threadfn = threadfn;
 	self->data = data;
 
@@ -396,12 +402,13 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, NULL,
+	pid = kernel_thread(kthread, create, create->full_name,
 			    CLONE_FS | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
 
+		kfree(create->full_name);
 		if (!done) {
 			kfree(create);
 			return;
@@ -428,6 +435,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	create->data = data;
 	create->node = node;
 	create->done = &done;
+	create->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
+	if (!create->full_name) {
+		task = ERR_PTR(-ENOMEM);
+		goto free_create;
+	}
 
 	spin_lock(&kthread_create_lock);
 	list_add_tail(&create->list, &kthread_create_list);
@@ -454,26 +466,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		wait_for_completion(&done);
 	}
 	task = create->result;
-	if (!IS_ERR(task)) {
-		char name[TASK_COMM_LEN];
-		va_list aq;
-		int len;
-
-		/*
-		 * task is already visible to other tasks, so updating
-		 * COMM must be protected.
-		 */
-		va_copy(aq, args);
-		len = vsnprintf(name, sizeof(name), namefmt, aq);
-		va_end(aq);
-		if (len >= TASK_COMM_LEN) {
-			struct kthread *kthread = to_kthread(task);
-
-			/* leave it truncated when out of memory. */
-			kthread->full_name = kvasprintf(GFP_KERNEL, namefmt, args);
-		}
-		set_task_comm(task, name);
-	}
+free_create:
 	kfree(create);
 	return task;
 }
-- 
2.25.1

