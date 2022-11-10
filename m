Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAC624AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKJTtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKJTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:49:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9D47308
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:49:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAJSjrK007490;
        Thu, 10 Nov 2022 19:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=2TK5OuCQGSqDy6tAZB4zuIRkRhRBQgz9pjak5bcpwkQ=;
 b=OLETXcyuUKCSOuDgYNxfPn7VshLVkhZ9JaUCnPt9Q9TtocbYynIa9YWvigSRVw4MFyvy
 7fSLKk2QeJJlgpg5xV60QwKXXv8ZaZOAwWxLkBo/AHovjXmuLzpXPpx6nyIAK6sGbij0
 pBsWErSsTHE7K42SpMTfBOWDTNS1PiGqLYIuh4hFRaKDzIgzORbLfMWqqY4TJfgjAlR+
 xXfwTkP7U4V8B9qGqboeVtPIVqKzVq7gy0ewc8abRjsSBI7SHLhz6YG8IP3IEVolg3Z+
 BYmZxP/UcmhwNiPL2YNzkEDPzpqeZ2tbIyYGhKleJdH45j1YAXMjKiO4OhSh6f4CdACl 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks7g683pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 19:47:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIuSug023084;
        Thu, 10 Nov 2022 19:47:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcysbbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 19:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLVc083uyvUpIKjo/lEQqu5S7oyltFw0KCOkCYxU+xqa8xgExEoATgv8IhVRx4siGr5JZ34qS4l2LjbvNyl/KkKVbwnRToePiFBm/6fM5lPbFFB3p3k/gjcc6eRiXYx/QxJYuwPQc3isXoPCExQXiUTXmFw/Ja6ZDg+lb24bMbWLN9lxqZkA2nQb1fe8FycTi8coPfwnZPMqrxTXk9O/0d7YeSC9y8wf0ETThhinXTt9jc2Po+VaGs1Ae6njHPqpyRvMYL2TZchNhoPYVJSS3f+LQOFRqPMMDUXaTgYToGD+PppjxPU1vSreOF7gRrsWkjkfbOJ/x7emj64dlfgQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TK5OuCQGSqDy6tAZB4zuIRkRhRBQgz9pjak5bcpwkQ=;
 b=ZhJEMrsWK1JrZCmUhffGBiIconJPulgYPsag6rewLj5R4ysWKLMo/RpOfVGz0ESM64xdp2B3xX7c3cs2honlHgUNtUIazWDSmrpo7rnRfbH4bmtPtv8+dSnehWUC6Qxwv1/GSd1dbt2KIc5Hf5hjdQS3QVg59rSwMFgeLevJeLwcJXK6q1ORu/PoAct+h7rW1i7Olzgr/gou2d5MbDiZFbjhTS3UcHr5LWq/O3UEZV3i61FzddsIaHNK1ukdid2wKHuZoXp2dLkjVZTv9LAG7j2ZvcDaWUXUanKcmD7IFph8jozCDc+yHnZqVxrz2JenzY3JUXyHvma/Y6PyuZ58tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TK5OuCQGSqDy6tAZB4zuIRkRhRBQgz9pjak5bcpwkQ=;
 b=o3y9b/JxTh+d2ilGOBk+90xQeY+lyNqug0/A0T0JYjd78mTFYJB8Xb7ez/x/ENS64iRWIaAM4BgeiFalkL3lMI23YeiQ2mJAytM9Q6kXmNZFsC8ESVG7TkPypEMQDFnK8OKAekGSpUjqWYWprPDFlILR0Zw9j7NQf7On+MI4rGM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6812.namprd10.prod.outlook.com (2603:10b6:610:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 19:47:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 19:47:07 +0000
Date:   Thu, 10 Nov 2022 11:46:24 -0800
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 0/2] hugetlb MADV_DONTNEED fix and zap_page_range
 cleanup
Message-ID: <Y21VEJm48uCNRaKd@monkey>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108011910.350887-1-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5453ce-0963-4912-7fdc-08dac35459c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmA5czyQh5haKgN9xC8qevze4kO5Yo+X/MGBUpOKgs1u5t2NKCo3T7LBB+5eemWv+sVAIAdFMA78cenhkQ6cD2SC+b3Xnq5pdA2SfYSFhEnOvpWx6bmxsYbuuCzAEACPe55Jxon0DfhpV3Vo7tfZusnspibHmj1NT23Zl/FHU+UHQASAwCgc7MF6G1oxTuR9JIjjoeX9efG4QCqMKFQWU3L3WcvmOVb6zQQzGRz87HhK/qH6msBIt52qe4drPnOraHXdXcfrMM5+MkuuWbKcAIfK4YVCXzy4ePnEySXbdGWFeF0M11LFrkXq7AO5/n6RaDLPzI64sSEtwyDpkvL5yavduLvWZbAvOLjcJKnKFbOsmJ/GxBoqQ8icTGBlYH8Zb8XRkUi/8oQQNdIsTXKN7iTM/iW8b5C0Fcko9gkbPxhR2Oy8sWC15SzDMUcQpNqotZbPciTCMhFu0c+OsVRU24pfvovtMiqXTxqT1gH75vSeaFiUfmKcNeuvD1TVv8x+/skdVit3w3BqwGLOl0wPq+cDamkDV/kQaYgark+BhfIQh/YBEsQ1CAowHprYrCg94QL4nxCney/3EcldLJp/oCOX1Td1Cd2Vv218tczQ8UdsIaDm2nQG04CQlcaAF5b95Xu7N1wpBbAGbPX11YrZGNdY8ffsUO2Q8jJ/S9wEsOuY+NP6xRokpJGRGsMZlck/PNcFDNPlLJdsgriHfHhntA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(86362001)(186003)(2906002)(38100700002)(4744005)(44832011)(7416002)(8936002)(5660300002)(41300700001)(6506007)(478600001)(6666004)(66476007)(9686003)(6512007)(26005)(66556008)(66946007)(4326008)(53546011)(6486002)(33716001)(54906003)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBNLjaDxrCu85D3H9wAr6/KnNN4MVOsBevOU5JpmPKsoBOyozLDM1d3FD2nu?=
 =?us-ascii?Q?DK9aT7Szskp4E7e0ng5O/hl0Ex8i7JqjhiQnWjSSlrVoS+1Bwy2NqZiK803P?=
 =?us-ascii?Q?Pb39OL5b+4yhEOlfxKa+K0pZwczaYILU5EEm8YvOn6n5affDs+0a0KkstyKS?=
 =?us-ascii?Q?rAWIikUEbU/o6kmol/Du9ypvSGVObwy2+pXtNt5Yjq9Wg2RtIo2HrIgD/EsR?=
 =?us-ascii?Q?QNWaZC5uUxcup00aVO4leOlMncqXhW3ocWVLl3tojAG6/7yrwT39TP+zIkYG?=
 =?us-ascii?Q?qXDG+n2wbujm6d6dPlZQi9hqdIRh99gjYIoN4bW3AQ6XuMQU9rEcIKx2bYTp?=
 =?us-ascii?Q?qVmzCFADE1av470H/NMrn37HYSpi5eUK4Q26O/cEnOP5MuZOgWF27b5sghuu?=
 =?us-ascii?Q?D0OCSrSqr5Zcb4rAVPpRe6FTkp7mWsLrNssxAnIW9ZYixrgIp948g7X2RmIT?=
 =?us-ascii?Q?KkPQ7Gmwtpvd2n/ixDAQkQM4ex8IMTFCh3DxsJ5aRoM+yDZmDvUJW8EYT52Q?=
 =?us-ascii?Q?2Ab6ZkNXZd2QT1NiqfC0xeM88CeLmlT7aVNPCB4rDNU7aG8bKhA/DFCexgx3?=
 =?us-ascii?Q?6KOaHNy807S7pcTrhidsY8U2io/2Ld9Womj0scwkLlNVq4ooLHq7xPJ5x/Im?=
 =?us-ascii?Q?CffMqPyQqh6V3CtRTw/2sxmshp+bXA32tQqQxW6wkMwVqM3/sNYtJS7/9zoW?=
 =?us-ascii?Q?SknSmENoTKkpbcqTJ0TN++peuG1B0pChDxjWM13Rf7Aj0XpQriB8HEH4Hbm4?=
 =?us-ascii?Q?R4BtCFo8dKEyUBr1qmVNpOfDX1/i9wtp2oqMcRvSfViXlmQsWPVkyJhup7AV?=
 =?us-ascii?Q?Il5+iq1m6WnlRqOAENrFGrTcjI5rZdv3M65pdhNEdSEe3vv0w5fZ70lTwAek?=
 =?us-ascii?Q?219Jw7roysca9bADqjS0IP8MNlYh6xesiiSOJa0lip2SqNcAlZBC+FM5iIIG?=
 =?us-ascii?Q?5MaK1OSXq5pEOWnTcsfrOitnOV/mrZkc5YrbZqW6fmFpoLqILkG9e8BGnQO8?=
 =?us-ascii?Q?jdMozGapDpMcqYfhfmjlabl3WHp5Wp3TdX9VXW7zes+89DRxsBYFwgyj4f9R?=
 =?us-ascii?Q?iPFMV/L3pdcXTrYffMziahtOXhfA6IEPXgs2VZSfsgW+h5Ie4Iocu0Ixr4gr?=
 =?us-ascii?Q?t0VWKopv6NPfOdv6Si8QAXrESB12vgS3IcaticzXUFbuAGU7S6sM823M6u/c?=
 =?us-ascii?Q?1dN/OhkWz3JmVReMFr9sPkckasXh1nT4H4ok2rzTFA4xCJ1OXncw4AQI7sSl?=
 =?us-ascii?Q?QCVvHhduMjfDSsMYOSit1AJapYkr6428Y9GJBPyQ5xKOoMgIk/zhEq/yD60C?=
 =?us-ascii?Q?qZnqkjNQJMIomoYvaU9VRAAeSR4H+QpkTIM3jsPV57DhXqdZEUGsBtRai6y1?=
 =?us-ascii?Q?RuRLm2pj/JRVTzH1pmyCtzJk60i3GCYKchOoqPQQEZHihi5MUblTXKj2svxB?=
 =?us-ascii?Q?x6q4Zgtd1XpN90RT/f2XFSTZ2eyFA4g/LAYbAow4R1wdryAsOJ0s7eOTPDrQ?=
 =?us-ascii?Q?dLWk0AEWzcprecA+3e54Hix7f65neyTtcVjvmV9h7O7BoMpuZTbBGR0xrDDc?=
 =?us-ascii?Q?C0Hk6nw10t2xlpsMEbGGK2yQDVs/YplmYo+whS7BZ5h4VAaBSu3nKJwDOAfP?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5453ce-0963-4912-7fdc-08dac35459c8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:47:07.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOoYzpaUft4ACwzXc6Lsp2yu8msHxqS6LCNwkU8DQ9/qdInUzf6IWaoNx8UxJxHRzRmhQHps9S+tBkX4WieoJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=813 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100138
X-Proofpoint-GUID: bxOhMECsPyjnOomYN7eWRTyzdIPZKdsq
X-Proofpoint-ORIG-GUID: bxOhMECsPyjnOomYN7eWRTyzdIPZKdsq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 17:19, Mike Kravetz wrote:
> Sending v8 as a two patch series.
> Patch 1 addressed the huegtlb MADV_DONTNEED bug and should eventually go
> to stable releases.
> Patch 2 is cleanup which removes zap_page_range and changes as all callers
> to use the new zap_vma_range routine as they only pass ranges within a
> single vma.
> 
> These changes inspired by discussions with Nadav and Peter.
> 
> Andrew, I would suggest not replacing the patch currently in
> mm-hotfixes-unstable branch until there is some feedback here.

Any comments?

Because of previous churn I asked Andrew not to add to his tree.  v7 with
zap_page_range fixup is sitting in mm-hotfixes-unstable.
-- 
Mike Kravetz
