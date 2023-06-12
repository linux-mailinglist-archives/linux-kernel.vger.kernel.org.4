Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710072D0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjFLUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjFLUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306E19B4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNuv4031467;
        Mon, 12 Jun 2023 20:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=YWh9QtKre8qPF0kIOowyvx9CFrhhgmHxNHGpnZVxya0ddAbbQ9/UZzLYq1LcrhaafMGt
 ZprWvhn2RqWrkjYUyMYGuCJJJV8eW+FQeofTfqIUzlb/FkWbIThi6HhZgq+zRHs+WYa1
 uEQCJzrUyfh3t5/HQf8OahGPppw/hdOwO6LG2wNZYo2KR93W6XzU5z837KTuYq0OVXkf
 WQlTvdOjLlITiZUiIIHzEre/vn4Vj0cMAR4sTIP7CnHpNwdlh5Z/LV/P7pCo6AUgvakD
 jhaFIdWMYAyBI/V8InyF9HIx9jHf8yJU/UQ8ACheEEn4l7/l3AXJy/TLfRV0wqKGiZh4 Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstusxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKZi76008325;
        Mon, 12 Jun 2023 20:40:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm9hddv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsXDpD1eLBOO/+idjkgk/aEkoingnUrzztS6QQ8pUW0Evz0pJGjic7mcFFxVmEpKHHSRZMyPzHmzW1aYwFVOl42qjuOTSqK4pyNf2yqg42IWj9cv9QsVwqarO8t7je+lpj3qvQJZB3n+hHqdyWhp5b5AM1uAqewcKoVEKlg4as6XvOuLXkIcGALSEWNmjPAjjYhGrNh31yNVF/esQQIzVVUIUwHFcSauA38Qtv6CRbthF/Nb7Qu7SIhgAf+K1HlXOK1Hto66tXSAFd+3SfnIpCfaF86SY3JwWL6FVS7k8/fmuYei7WWt2lXhErK6zKUyiPAvYQUhCLEWQBHJFy0GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=HVYIEi3Sf5uyviIpNIoCB2CUNzvxH7uUGr1z4wU2tP1FKNZ6HVkXsLtbvui+tKye5QYOW0AQ/UatQq6pZtbxxIuCJvCm3yYfMFJvefFvvmC6TpzbsOA/xT7ZUbN5IwyWC0hBjlTMwYBLs+qLcPsTOmlVEhcCh6vjMQI1v2ZS8xs3GdoEUh7hR5o/B1LeGEq1J7rDqUx3i/7DMYmCwOsBqyTtpHysemMNtSO2YzLEcCw5veAi1Go3RCpuC/V2sJWVuA2E5b5mwM1WAnRQJ24ecGaZNqEokFlCWMCf0YFdr5Uo60Vq/jIJ+KCpTMIJh0XFDVKM3tkdGn0SCDSiGc920g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xbWsBeaPIGtK6mfcigFaEI5C+wIlDGWBRAKirJxgb4=;
 b=TSfws7VJM1KNcwM1INp8hR0FktpXXAGkliu0ZXogjCRBXj/eAMQOPehXCI6fOqugBiUOX5K9tQdnrUM7y3XKHCw84SF43TsBenWrRaFHDdSs824ImIVAGEfOOFwx0TA/+QBNr6CUIDIvkKVYOZJui1uoiBY1XQ+xfJkMLysCAJg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:11 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 05/16] mm: Remove prev check from do_vmi_align_munmap()
Date:   Mon, 12 Jun 2023 16:39:42 -0400
Message-Id: <20230612203953.2093911-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f433b13-a517-48c2-50e4-08db6b853805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NygcBW41Wcss6CtZt3zJ5hH0Q6qZ+sPv4OZtwF0GWOQNh1YTJmFqIVwtHZkxX16gvxXyvkphAZgr/YYHK8II27JkiL289EHix+cIAAiJqn9zCPyx4NOxQQI6lC11xS3xrz4fboBkLs19ycMzLeqX43urnsAl71qZoeCKrqX0cCPyCLKSXkZ7PR7kTukVQdYt3IvqO6/ChLp2gxS2Pw1XREqcL1UhP3U4oLepD4scGMIakRmnpNPOL2CZccXodCFs1y8iljBwr+4amo+fnOQWK/tgswgxXzRE5YsJciZWBpaDSyZ7ZFu6eEFz6wgs84xgPdEXZ64Z0+bQEVd8V/LcmVcUxi8gsN/qN6OIE1a8oN77hA4gjy/+i1t4bUw+BhopHapWKdkp/Jfgvm/J2g5PWDZf2dSnIM4EuRfx3TRsdrVTcIkOe1EZdIEacToxtR8QgGzAFlg8pE8Oo3HGZlOBE7Jtu5v1+VTQgSno+HaReQgM9g++V5bIl2lUkm7n1kRyqlhhjn6sicSXEOmRvyN+0DgyerYOPenDA+FzEUPlSEhwtrMiQlpsquRHXDR182Q/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(4744005)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPEARgMiYskREwXEaKVyX/5y+Ewj0cq4BjJjoE4X72eKcYy4d+DZHWM259Dr?=
 =?us-ascii?Q?ZB8U6CqfRpixWgzVrhz2+8FEVeAV8ghTKxWM5e4bwR21iQY3U2Cz7lkePDY/?=
 =?us-ascii?Q?M1lJrJ5hn7+pc2ZydwlIlPze29TkAVepP2nbE1ioRGBhTfqDsdAnzHzgBCV7?=
 =?us-ascii?Q?7sPo/0CxLMvzW0xCPSqvzh6vRpnzMFe2ZbbeKuidWTysxgLkYir9bKiRu4dY?=
 =?us-ascii?Q?9VFukdP5999txYKUG77SG3C/qfoMRSjQ/y2p55QMdJs3SDEBWmsHILOWFfSU?=
 =?us-ascii?Q?xivvJuZra+ye8Xb32f5UqBwPmUGkCoDb3GeAL3Zsa01O2k+eQpUXtKzyi8qR?=
 =?us-ascii?Q?qMg2V3gU7hsXcgCqEO+oCckVTMV0koPt0HU3Veb3So4R9V8X6SzIS6nKkTV/?=
 =?us-ascii?Q?rTCILvGijsN5EjEIVvK2eRB8WkKBtDQ1hfHZGo2AZFR2FKxkjz32T+mmsNv+?=
 =?us-ascii?Q?xDMCSbXP8GbTSjIezCA0ZtXAPtEYk+v2lsCi7v12UQgB55dUw9rLmzu2gxDy?=
 =?us-ascii?Q?Y9kTKSi4Q8X3/iDzonjQNmx/xyNETkpRNTDVlo1NR8YuBtLwCuDXm/admImt?=
 =?us-ascii?Q?BXKVDLgtOy56OpFDDwI5PuQSgtYhd5Dzf5dODsfOK+7gCF+FmQziFG3fWDFW?=
 =?us-ascii?Q?YvzctVZ9qw7pxlDYQI7r4Fl6jZvIrrPKCjhoPG2pyuO9pCThSfkHaRzyEshb?=
 =?us-ascii?Q?5scHspWS29ZmFosRbOUYRFbtux0O32Ks5liJg6FZstnIVY1yIms0bFJUzoHJ?=
 =?us-ascii?Q?835eEMRTDTXwvdCI2ulNgZMm37sGJ6l2CSm67r+vvXyWTgc218fSix4SU6Yd?=
 =?us-ascii?Q?ZszBA+2cXh6hMd0k9yagUX3glKqIZL3Nc4gS1nhDwKWVkmrUPxReqeoU8HfW?=
 =?us-ascii?Q?V1z8OWY9KlbibUU43wGeITn76H15izQKW2QStdA3qO6EG3r5CaYEJog8oQmb?=
 =?us-ascii?Q?uwnRio14wfQVwWCzV80x7OD85wjOOrVyvObLmNabwzzFdAoGQRhUKD5q32B3?=
 =?us-ascii?Q?DMPwzhEuGRbu08RYnZAef3NZNkLhElFM78Jk/BfmO8KowJn8NsZvyhiPnKKC?=
 =?us-ascii?Q?WWnfMrH+vu1fA0tkdFJl5RqJ61utbrRliovQWu78EzVIv7LhLWVq6NiO2dB2?=
 =?us-ascii?Q?EJMW5+rWz34j2qoay4rNeWTP+QGu2tQf0eJD3KU3+P/CJb6qSk2qQEFsTE+X?=
 =?us-ascii?Q?z8QSHAJTp5DB7vUzSqhTh04bN+Hb70IpfwBB16EnzpYDczHv2udxLkGEHNvA?=
 =?us-ascii?Q?SCE19LtQKttYJ9JPa1r9qyQE9fWt0N5TpCC3ryVpEiePZ9bzUAAMhqCp807e?=
 =?us-ascii?Q?FlIouT5uiqUdMFP9dglw/nY+HE776fvSE/HyUzIheZLAn3ax6vCOHom2Iuqp?=
 =?us-ascii?Q?KgHHnA8jQv7O7bz5MGryjtR9/ybvPSsY5k8tdqCudCVI9IPd/qmr0q7H5lCL?=
 =?us-ascii?Q?Y9F3Z+PTPvD2tgd3gnt1pPz49VZhblDdpmCCSRKLsq+JU4TQzy10whY8Fjlh?=
 =?us-ascii?Q?3FVeV8C0fynHt2wKKSDwkqU/9aQtUo+h5faea62Kv+coJUAjclq/IwYMWHmR?=
 =?us-ascii?Q?F2ECjjxg6yFRrUqSb5ifLWVdzOy8aNsk48vzwmxB/w8PEVv+YPMRgeFfQwCd?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fL4MfQHj4JEg4l3x8P0JR3X0s2sSuPG+K25N46NCKcN0LU5y8oBjp3e30Wsh?=
 =?us-ascii?Q?wpLEIvH0OAPBJXEVAbmkSZHYOU5UQ7t8QTa8diXvC8VC6YLcBicB1iso4GVW?=
 =?us-ascii?Q?mTP7HkPeNcdHtQ1H4eRk312U4gRuokfO1fHnuxM0b5Ki4L0VZGAmG+BHN19/?=
 =?us-ascii?Q?0VqJ2kPmP3NdsvaM8Pirqfoi9cH/R7aR4poEiErAKUuZI6XVnOUezIWW/J5t?=
 =?us-ascii?Q?OQGBiItyBI98OnpWpOfA1HeaxGieRXjvuzbkesNsiN6VJRpNFwqzIEZIg8gJ?=
 =?us-ascii?Q?nPEDbASXG96Kuseqq9v88vBXWMkImmGpDKjul3ui4rgVxPkO34I4OMcdQtDB?=
 =?us-ascii?Q?UF37H0cXgQyOzOkIsmE+aPQcpuv/ts4dlLX6DOgUWlCSrpvkePCQ6cBRdzp1?=
 =?us-ascii?Q?RUXiNRAM0yzBLjSJUCntCnr6zbSJLIPeLexN9NktG8MdpiDSFv5gBx8CUICt?=
 =?us-ascii?Q?O+VFN3zHFlfbJRyELE+3NczPVnpBfMaHSln4HhUANgtgmFAwroQfQYIxZe0r?=
 =?us-ascii?Q?mUE30MQJl8qGT/duDSJmiItcIcnCWtyTc1BX+X8iaEadQT5dC/L2eF9Agw+G?=
 =?us-ascii?Q?Q+07FumSElIbMb18FCDrgvQRJKpAhqzSNIdth4CqO/GozK+FbVsp0wO9Yq3m?=
 =?us-ascii?Q?6u1+lz0P25Uzc65gahqcKOznY/3nhQpNtiwMTtWGrJQM0laq7LS0KAbmOLtR?=
 =?us-ascii?Q?JoM5pxkeET8lw7FD/zU5Q0Fg30W7EOMANio7XkjWrSdyfXDRGv4+gLoaLoLK?=
 =?us-ascii?Q?nVdAccCfa50ZyQOzi6f8dvqHugBJnU8xrVwfm9KoBwShTDlWqO6TJpIWpLu+?=
 =?us-ascii?Q?8Gf+/Zru/2Z989qaKwarQs4xWd4GoPnwLl4KnwEKtqTJgnypVrAmzrG+LhLp?=
 =?us-ascii?Q?u2aK4bwr5EpoRaFf9haklzH3I0Mk1RNji8fm+Ccm+pbUsvd9AR+ijdI8HfRY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f433b13-a517-48c2-50e4-08db6b853805
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:11.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOVlukJSHsshqXcs09W5deG4UmopUbsbyViZxh6kTrTh4SserryFp5re8vvtL92PxfpG6H6gAvzcx+CJMf5qWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-GUID: gTK6XWWAqcaBl5Nssr89L6WX2KKfrOCS
X-Proofpoint-ORIG-GUID: gTK6XWWAqcaBl5Nssr89L6WX2KKfrOCS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prev does not exist, the vma iterator will be set to MAS_NONE,
which will be treated as a MAS_START when the mas_next or mas_find is
used.  In this case, the next caller will be the vma iterator, which
uses mas_find() under the hood and will now do what the user expects.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8e5563668b18..fd3f505b40cc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2402,8 +2402,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	prev = vma_prev(vmi);
-	if (unlikely((!prev)))
-		vma_iter_set(vmi, start);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
-- 
2.39.2

