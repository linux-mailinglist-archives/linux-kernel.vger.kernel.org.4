Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B58613E66
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJaTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJaTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:38:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49962E1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:38:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJUX7U012753;
        Mon, 31 Oct 2022 19:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qOnxTD9uvK7GatwqmrbxCzU7J9OyJCt6kUejHwNFjG4=;
 b=TFKY6mr/tzMcAcNdIBbTm2e14Z3mRfRKfIX891VvfvQ8SW4rv2FtLjPNtEKT7ey3qJu3
 hPTxSuRFO8iFivn7gfgY8yfDaHdqgK3yb+3hm6PK72BmttFUQxmtq1LmiuEdAYyyWzpK
 1zPG3Hyx9XbWQxE2P9P+gsrJHJXja6OCO/evMQpGt1SpVxCP5Hp8M499FAk/4+pv9I8w
 0oF67zearCait0gS5twHDSs2vGSkz9hnzS5Bqrg39ai5wr5JL7YjhvZayopKwRDVYtrg
 ociuFRqoe0XgEdcD8acswAXmKs9zi3qv4X4j/SumTyfi+5XQImjdtKaSuHF3yM6jvbQd CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2vvdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:38:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTjLn025880;
        Mon, 31 Oct 2022 19:38:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9x891-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glbx2E3x+9HI9SC3+PInkw3kfwTYI8KSJry1s+wWXPYNWMRuSJk/AMZBXltIP2DymnImTZp5JyeCZ9Ty0UN03dFxYZBgykjXQ8jUYCgTa8U+hi0g8k1o+bXIAzuMJeDg9/k8JeH1FrEgrGQxhn2FtcfTR1iVut6XXiHlPeTtXBVwFDreOG0lM+cp5ixz1snBnn4I7sJgnyPwk6sm8bVfR9MGtxLR+OKBJyhVEHUwxQJuxWFU4B10LRg6yMb9mh2skdB4/t2brUcYJUeg0uehqLk9LrIzEyc/8A9mFogn8JlR4O84VYYIy+HuwoJts5hRiHcTnXVITu377TOuPZQMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOnxTD9uvK7GatwqmrbxCzU7J9OyJCt6kUejHwNFjG4=;
 b=D4Y1lARLM3N2ZGpAA813w8CFYq23yKPCT7ncz6cZscrITOfXzE3wsJymycxNc20AkimK9vewJt8kpMrPS8VrWMsjCukf2qufkK/krWkvjJNeMnbUxYgQco7TcoapPPfkZJaZ9r87ZRIOYzB7xw0hIn1g2mUKugwgW04I8tJ7Z1XVe1jW4z8gVWtUTO6XQ1o/nqNoy4TpryazoybHy6LsxljfLjpx1ncxk3Olk1nyaZGAO2j0lO0vWbpotnSP6LtxgyJhzuhuAwxRHaCaB2uh3CEMRN8eFnkbAeHcDKW5tzX15eqV9+tCpoFDtUh8sQr090s/Y1hdjDCgN2ZNTwX0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOnxTD9uvK7GatwqmrbxCzU7J9OyJCt6kUejHwNFjG4=;
 b=0N0oYYMLihj7ABg4//FJFSGGi4b2ALIBHyKX7TKdHc4bBuViSuqFtxM1dpXWsFPaYUy1/oZPJYgRRK9kMvKVYPvkHgFlV2xrrN5tDECDvsBj2TcWTF72SV0GHwattTjvr1wPvk+v9/KJ2yrj/0yWLvviEIVq9ZE7a9LZbeyO4Kw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:38:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 19:38:04 +0000
Date:   Mon, 31 Oct 2022 12:37:58 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page to
 folios
Message-ID: <Y2AkFpUVwbUoQwxm@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-6-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: b6353c45-6d0f-4c53-94b7-08dabb776d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+TxOtEVFyZY+9kaR1dM2Hhcq7/29QESVtap6VpGs/pN+ScijZ6BHFr5RX5RXMUCx9IrYMWsJA1zuOEgoWYe3v6pu0frpjw5MBkvOpV+EOuIptIBTqjSTmEebUQ2bOUrWMpwk/16Ouz3NEH6myemNEKl/x1WrP2ZkrsHjbe+g6JQzKWiSERfeUuZ6aqDU38ruOwlQYhrHHDQSppv/i/WuicWnUf7FQ82aqAS9F2lSGNMQNWKKW4s0Ze+l12T4PUf1F+9yORXB1bYHDZkxQ7eMhEUcPLBsjEroRIC8VK76GIDBfpuyXCPwLn3GnfnJ23rWeRxEQrq8YG0RecXQeoZNmjIX2050HCRzlihGlF66sQrQVgx39lQM1HWDHFo9NJF+T+3tBq8gAZkXIdtNU09cozCRG8q5YWemfTuGnHr1Q43hBTRhcredWxcFi03pberfdt9ocITQGxILq96pGPp4cALYgrB1Cp/hti095UFVo7e/geYgJ+MEuRMRHbKNP2jBcSljn3+aobvVfw/7zhRM00fgumGN0+RTthyiN4SzqXDl7T9SbtPTvRsiMaGmELvRvO0FUyj+fWkovMjS8x2HyPmUjN/v5lGHhL1FVRdCkJ2XD2KOG9tF7rS6mwqhz695FeaNq2RaO4cR+Bts9/dSCMFo0Y3r2b8DwKR/oA5/ypNBIJyl7rtB7TeIlRK8QfWCpnOrBqmfX/mcyKUhg73y3ng2jIXETMZnLyJpwAIKunb3MW//xcLwbemT4lPMu0s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(83380400001)(4744005)(33716001)(86362001)(6666004)(44832011)(2906002)(5660300002)(6486002)(38100700002)(26005)(53546011)(6512007)(6506007)(186003)(9686003)(66556008)(66476007)(4326008)(66946007)(41300700001)(6862004)(6636002)(316002)(8936002)(478600001)(8676002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ThsVS8PeieNCwR3wNqSMH24pSSzRkBqPGHNZkgGxRoa5OYM3E3f6XbmSlIJq?=
 =?us-ascii?Q?h7/Xj5lKEL0Tl8TrQqChMeQHI7ChFRZ0cFVEM6tQWC0Kr/ZAxI9tqPCNjpCH?=
 =?us-ascii?Q?a4X/KarcNHcdo+vaT1F64V/vdVOmU/+a+ZawjahnNe8QC2xYqRtehcMMxvSe?=
 =?us-ascii?Q?vA8uqUxwCKu6t5t5D08DGWtynCQNFovPXZ3V68jQTy8w/8Kk4dWjFK0w4Kgo?=
 =?us-ascii?Q?LFgTkHK2OKv0TwJBFT/aW6FXFXODBHQbokBhZ/8MA0BqylNEHzeJuGFpKaoc?=
 =?us-ascii?Q?6SmkPQwACv1mpuRRoxbF36SJRXu9BtCHg1V1GGWMkZS0C12tI96dlGcYqRN2?=
 =?us-ascii?Q?GB6UYhxDli0VLrpd4eUXAuxzP0tJR0TY8l10KJTNTfpWVgNwA9hUffbT6PtP?=
 =?us-ascii?Q?GAVBE2WFU7CXu1zKw7AknzzYbs2NGcrqvCZkCXInG03P90UfHZZEOohujsHz?=
 =?us-ascii?Q?Vj374S0Dnz720wTNzI96/hmEwyG1qBEf2MxNj3hfx2MR/bkAtHhWPK6WIScH?=
 =?us-ascii?Q?1rJrBlNsi/rkwbzeDa4FngHD6SGKfvR9oR3SDvaQ5KiY2jzczQchd0Av6iTY?=
 =?us-ascii?Q?vCxGfq0ff6g8d1Zm6er8XjY/8G1CmaaTOYd/eFWzslW4lIUd8ZiYYmueq/H6?=
 =?us-ascii?Q?ZYAS+TK9OwcKf8MUp1vp75qTyUkTR1gUi9R8TeXtioRZYae5UzToFnMCdoI0?=
 =?us-ascii?Q?VQMkl3hFsnDpoJbB7yecPPGVrBxL7eM3rEJGlI9Wln6Dpnhrh0LOKmPvKSP9?=
 =?us-ascii?Q?EcVer4uThk9ytrDyPbOa3C7gVsJD99yMNtQuped5fMLN339D6Dnp+lnpxI51?=
 =?us-ascii?Q?PUM4qi0iSgR7eUU+eVIQG1ADPx8DaRlw1ISwXugu0llNFe7RDVnSFjFK2R/Q?=
 =?us-ascii?Q?yrGWCme4AKD/B0MWzuBbKHCz2uvCNSoWQIgB6ZZiWQ2rEo+sHzjVu7+iLdRe?=
 =?us-ascii?Q?A8Hy5xkLTzmA5a2xcXYkJhRrBXe+QyhpI8jCn5+d6jwkyh3U6qTpNlQHEQ7A?=
 =?us-ascii?Q?rc7xXHe9ma55jOC5+0iYDoydmvqH864IxKettLakR5VWjZUeNXsGQpO1SgtL?=
 =?us-ascii?Q?eMSp4wTjDhA9lvAwqRXgLrGIBWxnG3Hg8H1kIneSkQO4YQqIJptFsrvd3+vW?=
 =?us-ascii?Q?EeMjaWNAH1oHgy++7zIAXKfzCt3O56/v9r/eaPDhnNfLol1diFGRJ23PXMSs?=
 =?us-ascii?Q?qOiwH/YvyBI+iyUUaOj2aVmO9m780dyR0Wf6Mu6cV5KH7D35PEuGk8F0jW+5?=
 =?us-ascii?Q?LlijIhLgXROInulC+QakO/61dSw1fB/8qs7ITrgVBVKIvLYmqsYxRU+MDzza?=
 =?us-ascii?Q?8AmRotVenQmAs542jQXCk4DecyuOCpnMlw9C3goHT5xaz80n1cLAGvhn9BZD?=
 =?us-ascii?Q?wicmb4fC98ARnqUCIlnQcA64pKoN3yxitYLajYKOtwZ0tt/4lZd8HHpeyM6x?=
 =?us-ascii?Q?fMogslKX31GU8jGT+Gtx6/QwjVM2loTleOEvaScmdOt70uA/+ZSbk9TZ9BYG?=
 =?us-ascii?Q?J1cJBuRn/2OSm9zDhqok8iai1tT8rQQuCrSmoB6PLQhIv6DIlcVzNjPN1HxB?=
 =?us-ascii?Q?Pn7WtaiA3Mat/ACFQk41AZ7BwqLNUBFnThgKKd2OjINnOC5gEGVa+ADKaZXZ?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6353c45-6d0f-4c53-94b7-08dabb776d89
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:38:04.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8sbEXNSZFlPo74vclx+KIcXESGEt5Pyk4nVolzCIrMzUN2+ypbZHAFm0jT8lUROuV2RniyVIp9jvwaOhA/Nfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-ORIG-GUID: iOP5Q4iO9EMfkyFpvlpLZf2YhQYauxWk
X-Proofpoint-GUID: iOP5Q4iO9EMfkyFpvlpLZf2YhQYauxWk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:12, Sidhartha Kumar wrote:
> Removes a call to compound_head() by using a folio when operating on the
> head page of a hugetlb compound page.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Looks fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
