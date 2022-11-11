Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB89626587
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiKKX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKKX3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:29:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D84C271
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:29:01 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABNLnj3010286;
        Fri, 11 Nov 2022 23:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=C0P0Drfa1ExnV5zBMv3rPs2a21igirGLHaQndULmyWA=;
 b=WXgLbwBktfU2aA3IniYXFTJQ69m20fD/g861N7LC5x6caSMw64ltkt+2VkuYqw94RrQu
 sR30Vq2VikIugArXAwqXbG4f1KzEIb+5rSmZV65NxMwqDf/rbdHic2eDDnvnD8K5SVZj
 fwF0RplcMftwEq4g/k6gd1NY5jhwMqo+hQ7H6MlZsUWKBiKiVuCQDmFy+hjsryoqQOhO
 cyxNnenZZlg7tho2u5D0HTcZhmGQJLZ6yGW8YYEGub54J+af6ZLIDZbl3z7BcmVPvBxC
 O6SXhgnRlhDJujZqnTq/MI1JMb+7BglApJd+0dRp8HruCGgi4O0UXtFWNKv59luLSu/N OQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksyktg16e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 23:26:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLAMjC022424;
        Fri, 11 Nov 2022 23:26:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytuch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 23:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCR7YkGLTAUezjauL3nFXcdy1jotCxgdcAnEFx2LxXjibZl3wKYRTWs5BFC8q68DQiulXp7h9PnnWtBgifCgjGuPVDYbfwt8UY1vLB8EetqDMxN/UZg6MVcGqlAQ90HWkUIHAbt4RL9q8Pi9c2652eYcQlvBYafSoMuAW60L++rP3u8Oxt/6XxuXKYaLcwQI1ipis8JUQJmS31bRV6oTEk+In7qX/KkdzLzWpAHsgf1ohMlp0yDjKJyMUOb8XCrnHUv2hnB5tdb3V4FU8Z8J61Qw82f+LzjkoA8JJenhfRumYxTjwU9O4mvZW0cfKFTeX1JXl+CFLJah6IyUYVRvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0P0Drfa1ExnV5zBMv3rPs2a21igirGLHaQndULmyWA=;
 b=T3vcNH/UnVZia4mbFzxl7uJVhGfs3svIR93PIsnaC0oeBhhWf0MkDcZ4RFLVILQbDcL/TQ053q8f5z7kzkvdwF7ABj2Puq9ZRWiOEk6RnNNgeVCOqheOLQSsxB1OtWJwZOhGK79/48q754F9IQRm/UBFuoJvhd8n+4/bQaxTe0svC006rZn6O+gETN/XnBi7EbwcwhJ5rSFx10TUHQK6FBjpn0BflUoUtFop0r2UmbimTp6G3t95ZMlHHREq2KrUvkwDZpAcEfQW6Sy5Z9vHxTfrIFYoiv5O3GM5UMJRiCSnVzoopAFspFJzPgZRAFXAuc2Aj9OafT7w2QKQM/waAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0P0Drfa1ExnV5zBMv3rPs2a21igirGLHaQndULmyWA=;
 b=lLLbdZcQe+2/0YVkV9LrB6xG4OOcozcgcecdCMInBGE4k+Gog8A96VqwlcivvsUuPtVwqt+T9z8ShdaZl9czWOjbWqstdkolfkGNe9ncur1gBfA1h6Q7B/DoCcQU733WcmsOgOsQqOP9l2BdMsqnnEm0LP9ZRLGUdSIZnauQBsA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 23:26:33 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::4786:1191:c631:99da]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::4786:1191:c631:99da%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 23:26:33 +0000
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
Subject: [PATCH v9 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
Date:   Fri, 11 Nov 2022 15:26:25 -0800
Message-Id: <20221111232628.290160-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DM6PR10MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 613513ef-d377-42af-3f36-08dac43c2b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcuFkLtJVpXJUV+agl0xuI1qmzMVRNMjsXxXI6aYWeaEXI5uIeZtzZeKdnWcq8ipB/JYltztozChOA+Gvgtu+gumgJKdPX5t4fJstFKm+WnnQBn7wG+/dzPTTyuhCRpztRaZU/Ltn9YeZutNz6tsXIrl/Vy6FRpJtZYmYkLBkV6tDiwJuohM/v9kYnoNOuuY2Cz72yb72NkIIHr1qJXgeE+XZpwGlkZ19zev7KxKTU8fCp/MOTYH5qyYO5sn3myyLmHAFg0LvXWd5GPGYO9luPJ9htvKgsumPWgaS+3U7Y/S+NiIwtt+UOUhPQeCliuxciUIlmMH48+K0oEhHkauoQyzmf4MjReigwj+408EO414/uFvRILViNooMxEob7DhWJO1WPcVjnOZnp+pyihBcXgxSppgZUtjAAAuH/7tg6Ev/ZfdgqrfUao6bgunovU0/fP0maVnvWJ8Kiuh98Sz2gbUU56tPVEKbnS0Epg8olfjAQv9ZQKHGMBeSN+iTAiom/31uiSunnGOcNqmz+tSvM8JjuLPyevXfiLFVotkGqEsZuFba4OAte3LexqtU1m9UnClIIH65ftVNoqlv5hk3e9BmWtyY3V53XTGyIMx/lciXb/TOzGJzuXoKDRj3bvy/qgxqmTMUIic5WIh/gQsh9DoO/KfPoBX27mDWfB47Q5itH9ZofQddLTj7cbuD6K4/7TRRnjomezzW2QnG/HBPlw/71d6qxiwS3coEyYH1/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(66946007)(8676002)(66476007)(66556008)(316002)(44832011)(4326008)(38100700002)(83380400001)(2906002)(41300700001)(86362001)(26005)(6512007)(5660300002)(186003)(7416002)(1076003)(2616005)(8936002)(36756003)(6506007)(966005)(6486002)(478600001)(107886003)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHEr8YUqHkucn/m5jtuuqr/8LIsZf4hrr/pvhtCRCkY6kExxialpxHBELpDV?=
 =?us-ascii?Q?Y3MMGuVHJgaKIPptDfWiDubcbS982pwoPJpXty0qIOqbSOyFHE0f9rgzTcjs?=
 =?us-ascii?Q?F5wl3V46oT+Zsq8rvKdIpme6IQvbdckRLF7hZm7Os0sFJjeV1auIwCwy5vXb?=
 =?us-ascii?Q?vs3T97YeF/rBi1ARnjrg8Ns61RU6Go98pXgbl2ivUMLiymjZJZKqQULsnVPF?=
 =?us-ascii?Q?Wv6SGmNGLYeYzl37w8NWdgwlrghjpB44OsdvuCfO0DUt5a9FT+j7BmV0sQJE?=
 =?us-ascii?Q?5b0EiNTav0pvwRT89LXohGOR58z0YOsUWEyILmuwnsWT7OXCl6dQvJPA11o3?=
 =?us-ascii?Q?kmYfuD4Q17eNeMslFBZhM3xfaqn0ki8mGdrtB23CUxjvvRuNlYW4mLyzVBZF?=
 =?us-ascii?Q?W4VExQnQ8DKRLnnIB+3yLBvjzJMa5aVcVz0YKxtSaXJ4G6L40trcnBjpUnoD?=
 =?us-ascii?Q?eB5au+53qNwlRlpwT4WNpRBiwN+Pbv3DWudK/5/g8rdyvfmammaED3FD67K0?=
 =?us-ascii?Q?UteCoQXI5NcUbX+jZtDC1cvqm4Oc3n3MUn9mNS3VJjEt8b8Eyjy5HcE3cLKW?=
 =?us-ascii?Q?DhFyqq7DtAVjsqgzbhOfLVQ8/Pd6WGYJ/qZqWh/luGpVjUxQfjmAGHlacZKD?=
 =?us-ascii?Q?Lws/xH7svpiUxGO1iEQ8uMD7BgUBGgjbVu3ZTUjuMFF6JV+6OvsNHj7XBvCh?=
 =?us-ascii?Q?PHyFrp4xgU+EjRJsfxtKfRYBlb10HC/XQ5RCG5LAdy5StszBzM7i0nLhRZkL?=
 =?us-ascii?Q?05uJxxhI7umr0vQE3H7eHLNZoMswA2uYY2qgZVnSxR+N0IVMKb9t79fHDSkp?=
 =?us-ascii?Q?gC1KXsYSWCsziGYrxMmVmrkbCFgKtidmdyF6ad/MMgiG3RA3y9W4vaaMnDwa?=
 =?us-ascii?Q?fKci7WCbbW3jFPCbA2Hb63N6x+H2tqQSf4FdyxUA43jIfdfBgvNxe56Hw6EU?=
 =?us-ascii?Q?wPKWx0iSo7BHDGwGjsbuJjb2mRxpEZFOoX3TyowJQu2D7gigHoKaE7atC90p?=
 =?us-ascii?Q?BKMgSEA5GVPrKvfhvJqvwS1V/aQfkw606s4jydS2rBGelsM+Dcm6ueJRyRSK?=
 =?us-ascii?Q?qqsVC20yaKe/3uA7uw4AAfJUn0NvueTZsknubqU/65Q7U+6X20LPsoFquDVh?=
 =?us-ascii?Q?DiL6Q9dBqu+C7scesVKn2xhhqUDEvbN3xxUrprlOpeDzclshfww/d3VJOljb?=
 =?us-ascii?Q?6703fmaGHYa7+lOS8kAlJmXj60HIFYDQdjPiBpjYM+sfASb5s4OfpvzkWIgA?=
 =?us-ascii?Q?T48Fez5EB8uepiM7OrpFhJiPTTy6L5Xfy82jsqNQdwBIuLamDxZTgUjjhhEO?=
 =?us-ascii?Q?Mcf+sjvLKhs9J1AxscL7Ui7suKtwdVxxa7tKAx0NjlINNTzW1+UIZo/8hHWZ?=
 =?us-ascii?Q?Cj6PehLtHRop7WfH/DGdWv7PhA8U82R7j7Y8aRLJ2nM/ZQGuFORNBsxZmpbo?=
 =?us-ascii?Q?8oivGvK12ugmB2XEQDmxME5UNGe6JUQRIwIr+WiYq+ILJVjNLoTvpX9JPZFw?=
 =?us-ascii?Q?MDDQ69v5afHOEXurZTL7jpZMW4TA01lDL39foQnogbl4Fp+1CsSpjQpdONEO?=
 =?us-ascii?Q?o3lG8dS0DEqsGwatBiz5U7+eWzPf7YPcfhSUyS1MqxNKV50ygFgZ1aVEDpax?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BWCn9D8dlwCAaiLop1ItdQReVJWNMletXDaD2sBD9V6UUjjlgZoB0N2U46ry?=
 =?us-ascii?Q?tr/liAmCC4oABaHn2J2ilSBFSYjKs4KhI1Fo9+0vH/bukn95vvUA6GoZ2xoE?=
 =?us-ascii?Q?dRblT76AAhYUEJC9tBofl+ga95ipL2C2P5QrsdCD3VEN1jOOndTgrrNbZoQV?=
 =?us-ascii?Q?Tp1zjhCmDPt/F8B9EYNpsly+m8jdRraGIzkWYHWc9cP31c+RS04Lmbe4gLia?=
 =?us-ascii?Q?ads22pymjzx86EHWhJrLoneC3a9jLnIM1qnhNXVzjZuTFadWOW8zM6beNxKX?=
 =?us-ascii?Q?eMmdqTlkA1GHRciW8TibmBqSUArDa4uyeOkR5Otd5zCB1SKw4ZOsL02GsYq2?=
 =?us-ascii?Q?yeGeeKdlG52V+gWzJjuEMvo9P3kbjLunX0lsBR/88Lui8dTX3bn64z5//gLg?=
 =?us-ascii?Q?PCib2Ti2VjHcF3glT3R+K1k4dcA9LNXVlynzjoYxwYBb5L9e8MMZyP5YMp8b?=
 =?us-ascii?Q?i6Fc2f+nZQwJ58XCekwHp7Wi2qN8iNrGcmBrafBV3vi8/BZWZiOGo/Z2u5nm?=
 =?us-ascii?Q?DBu+fcBdl8EY+noKF1cNOwPssDvnWfMpVcLAfgcO9U9wMEw6+rFd73EOoyjw?=
 =?us-ascii?Q?QmSR8KajC4tlf4YjEw2WS3nI9mTWAwxRabJyCtDUH9bouhjLDTFR9B4TqUdy?=
 =?us-ascii?Q?p3xdZX//IAWCZ1P7au2bN2pQ6trvSBsFzp2EYzAcesQ/NNvLCFg7UGQDGwvs?=
 =?us-ascii?Q?wLN0PjB6u6L8eluD6FhRtvwT+P7bMMLXf/S+VrRaUeOiRmaeMq/F+WhJElJw?=
 =?us-ascii?Q?HGcMQdeyxlCYnwobeEwJohaITO2Rm68xjyJW3w4VcaTOBkHgGUV0iwce3IYG?=
 =?us-ascii?Q?BNffI0CY8QxC2md80AmV1PGTMNtffrgjV0/qLMXkVkC520y2kNmVQfJ/XNc1?=
 =?us-ascii?Q?cAHeCsG61/2BtcLaK4XbxX35s/9JVV7AXDulhAoHBvJARIxPfzQxqQAsMGnP?=
 =?us-ascii?Q?Fo3Mjgwftwp8Y/sCjaVwy0wXNF2qX2c8LCIj4J7rEMj74wNkolvQTnHDwpmG?=
 =?us-ascii?Q?Cr5aJFtrQY+YLqzYXK4CXFDZSIAFol7LjoAja2YzzTCt8Zm091+A9xz5jnjb?=
 =?us-ascii?Q?autkxL27LmcnfEGfrU2PjlBY1xf8hJLUmdf+UwFJXLFMlPl6M+I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613513ef-d377-42af-3f36-08dac43c2b48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 23:26:33.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqKg0gTm5Qd+hgMxMgKjDT0sIEIvZlhl9tGfMlk/uNuV26B+GM1dKz7SlRTtjnob9TBHIfYhw0P5mC445iWjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=599 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110159
X-Proofpoint-ORIG-GUID: qENKSsXrhjJaozMhCAdA_CZxqRjErGlp
X-Proofpoint-GUID: qENKSsXrhjJaozMhCAdA_CZxqRjErGlp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses the issue first reported in [1], and fully
described in patch 3.  While exploring solutions to this issue,
related problems with mmu notification calls were discovered.  The
first two patches address those issues.

Previous discussions suggested further cleanup by removing the
routine zap_page_range.  This is possible because zap_page_range_single
is now exported, and all callers of zap_page_range pass ranges entirely
within a single vma.  This work will be done in a later patch so as not
to distract from this bug fix.

[1] https://lore.kernel.org/lkml/CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com/

Mike Kravetz (3):
  madvise: use zap_page_range_single for madvise dontneed
  hugetlb: remove duplicate mmu notifications
  hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing

 include/linux/mm.h | 29 +++++++++++++++++++++--------
 mm/hugetlb.c       | 45 +++++++++++++++++++++++++--------------------
 mm/madvise.c       |  6 +++---
 mm/memory.c        | 25 ++++++++++++-------------
 4 files changed, 61 insertions(+), 44 deletions(-)

-- 
2.37.3

