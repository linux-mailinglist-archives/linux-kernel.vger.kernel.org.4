Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89271864C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjEaP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjEaP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:27:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCAE69;
        Wed, 31 May 2023 08:27:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERHLo020019;
        Wed, 31 May 2023 15:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=H9VamHpeiV+SisNCfhoHAd1myops+8tYorMBH3nN6rc=;
 b=b5PnlKtTN2wDC1E7sjFEqKyj+c27m8T+qsfDqf9AvOktXwLcCOg/X0D5EgzZIt1eDNjg
 O9WKD5u2VP2io/j/7CaojZD6zmho9Xyjplsu3NvO9WsWiGxrizefFG/HesnagUcajthc
 LdCC+obu3csZJLmSrl2+x8dJXBqblq7WN0/qVyveHkN8uI4jjroCZHI7qn8PZgaqqniX
 jiXsQL3gO4bFOxilMymDGVEMzNY2TnJzVnqGSLjYM/OnJZITgSCNQWNAHQvgqVATXZSx
 Dpf3GB0usaiDOGUtKfGJhNFESS0O7MPaUCCZ0GFVLKsl9kKBI0ybD/ka0Byn+kNCuHac wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh65n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:26:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VF5cYS014581;
        Wed, 31 May 2023 15:26:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a5r72p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTd0SfhxAWZZsqIhyPSDim1GQGkPbzYNbFmKxYE8one4r+F8hUK3JJUvYXW0tFtvneb2HPNqkJiOKyvY5RHAXYb2iamYhcD0HPWTLH4CBpJVwALEwqpN4xjxfl9KM2ySVM+55PbPYJ4ciNuJ4cOcL7qYgeo8wO9VYUmHQu0MoXwatFJaTq1yUhscR5OGydYEWHW6gUSEdWa3HdmQnN97gdUWB8Va/Z67hX+CR/1CQQIv5Rl0P1oLj8JYc1n8kIK3JendayM+1tqxQbnWhRzDhluyeh+E2/ZfB6j97d9HcCtG1neO7ksInVVmnvXZBkDWkk8u4C36YuB9dBelCJrloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9VamHpeiV+SisNCfhoHAd1myops+8tYorMBH3nN6rc=;
 b=RWV6mwP3O18AgvP5XZGDdUpmLu6nz8Aje6A2m8gbCZdStzzHG37jp8w1o2kQ6QfEvV/ljhvq01s+nqOGDXc5wvDZdXoBd5owq2JHFq4/xhJ/jxF/kRs0nUBMXbejMVwF4StxcM/92Mo2vtQa9IXO8SLxi2bfmdrNPrtnDjDKQzqdteAKMNCsya/z9F9gTZwU9zvNh554PryX8VuKxl5dfJO9qpCxj27zE3tsnbPJW9wtJ1GaAsH3Bl3kbSxrgtQEyVdSJlZ3VdPae5+U4luaF4ZTLPHBjrN5ffpVS9BNtyKWNqkx+jl+135fv8RLlaYqXwcmLt090C8mg3xtoHV6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9VamHpeiV+SisNCfhoHAd1myops+8tYorMBH3nN6rc=;
 b=HRYGyE2sddT1SCgCs+2MMEw5iF6WnkFPwOOVa3ngoqEaLL7XZEkQZhMZrspDclDbBogMkP0YB9IZFws023W+wbxpyhq9HDTlirYyO2LDDw4VXxb9v2qN2jpDLiXN4uEa+lmh/PUdxaampq28X2JVY2jQ0XRS/0xaboBWTW/Fc0g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB7636.namprd10.prod.outlook.com (2603:10b6:806:376::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 15:26:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 15:26:56 +0000
To:     Justin Tee <justin.tee@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Justin Tee <justintee8345@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] scsi: lpfc: Use struct_size() helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1leh4froo.fsf@ca-mkp.ca.oracle.com>
References: <ZG0fDdY/PPQ/ijlt@work>
        <CABPRKS9ykHvaOGUboDXZ261LLPS78+YFpOZAcJEeLKGfEUe21g@mail.gmail.com>
        <202305261041.4C23B96F@keescook>
        <CAAmqgVPcSa36H7J2ABPmgCkkn8d7Asy+Wdn-xmQLuPqTupE5Gg@mail.gmail.com>
Date:   Wed, 31 May 2023 11:26:49 -0400
In-Reply-To: <CAAmqgVPcSa36H7J2ABPmgCkkn8d7Asy+Wdn-xmQLuPqTupE5Gg@mail.gmail.com>
        (Justin Tee's message of "Fri, 26 May 2023 11:06:55 -0700")
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: cc45a265-e786-400a-64b6-08db61eb77cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZoUDeHz/rzKVzkueeujC2jSBAlOT6Q60pwginqa9vinJ+ZDmg0Cxj7DzCV0fnk6qq0N8FgexRzr+x8F99kPGevzjGNaUafk+C2iyo1l1QP3YeQkJtK90udub59cLMc6/fBTcx+WaME2ZJ4rZ1Mx3/vj/JcXl9bnZKNFtoDFdPdX2ZwJ06PJItw+Iv6PQ6AwqOQaNar8pfshbL96Tz/l6dAZXejYTnXLIQhnG6NlYDX1Te+JgZSzg9PLlQVJTQl1luXgOSbpgJ7KqkUcLfGMegEpTVWZ+BUDLpaW4vDeNW7QRapONI3jZjIwKzdRL3Et03F11psL4Yy/LptbcvTDdfIb/xOW2Fh3yj8tsmowamD8FIkCNApP7fQBarxQI6PE+uMRlN6VFaatQw9XV6HK3db/6yPpNt6cU1UKvadA2c/CSJddtO5dBJ6n7yoi64Nus3YP7M1YX7Trxy+vKwo+HFcrJubQZGr6s+kQIxvTn9LYwc/9RskGjuxsXUXyHiFMYkdL+BRBX2ZP4QyhhIMYydgH9CXdnDGqTbn0pkmKOGeIcMb/70giOrClsaz3sMVo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(66556008)(66946007)(66476007)(6916009)(186003)(4326008)(478600001)(86362001)(2906002)(316002)(38100700002)(26005)(41300700001)(558084003)(5660300002)(54906003)(7416002)(6506007)(6512007)(6486002)(36916002)(6666004)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plCD1d88nlC4GvWwRj5PbYWG8acFAxkvBWtx+xST8H4WPl6a5iV5g/UQ0ogh?=
 =?us-ascii?Q?LsqpCB9rhQjXD411yV3u2IQ1692JRaq9MJcKUcomL+fltNnnki0HyhgXACnb?=
 =?us-ascii?Q?TqH8KafmjldTwDHtbwqdZY9jG/Q102NVTadtE92H4wzwv+/5CLHLHCdhLTdJ?=
 =?us-ascii?Q?Wo0VJntoqdD0Jj3rqGEiZmmfSxm+vrOQZwwfJDLy3vHIfe28NmklbJpfcZsu?=
 =?us-ascii?Q?L5rYSr9Xe5fXONS5VaSvgp1Y+jHzY6QdaEIgCL6z3yTrRBMzyOYIM8b+goUs?=
 =?us-ascii?Q?pt/4jg1ZPAWgxaq40WNRc6cBEcTaduMZ6wx9Z9jaHm83CqoF07ls+nCetAsw?=
 =?us-ascii?Q?T+bW5x0OfZP2zwkKkG6Eyrdj6wQhNfosiBZQBsINbGFmMM+5QQkVgD9xS3ZV?=
 =?us-ascii?Q?9/tDvPlgtXm8azMp68zx3BG/JcXP2vnYoNUkSiCYFAZGpRXFbr1fuNQ+ACV5?=
 =?us-ascii?Q?pqnAnUKkzvjb4zbcodf+V4JFMOXGNmMORapKbk2pmkwcvYpRrpi5323E9IMK?=
 =?us-ascii?Q?gXKA3ksoF31cPQJ+WtoIb/FjQxQIFsORczKJffhWT/ob8ahUAxmCJt4HmHNn?=
 =?us-ascii?Q?IgMM8MWFz6LrWEj7Qex8zjQOL7c6t046RuJDx0EU5emr3QCr0DH2K/xZHzLb?=
 =?us-ascii?Q?WYXvbZ0Fey6wQOhdMN4H6+Qkp/E3mf3B33YVUIkEB9LJYpxm4ULL00yM+l7T?=
 =?us-ascii?Q?00ZZVj8YqVYf/QXdOm9rBqjDmUARfX513iKf0FNfLIwT7fTcfouUdQahiHNh?=
 =?us-ascii?Q?5cB1LWqgzZKMlcPePsefH5dQhpg8ZVX7BzgqFnCA/mJVai9s58T/53pJunUj?=
 =?us-ascii?Q?jnPyAKWrKir5rtE7CXMc+vMl60kCoZ51OgtCg8As5pvrnF/rGISwo5fOKz3y?=
 =?us-ascii?Q?owg4zA9DtdqVfLaPT/LW11ds4OGDvd/hgUJNT+qqVbDFGuswRHZOI+6I6jUA?=
 =?us-ascii?Q?MODjKyQuIiaI22AxR7s2pHqZxWdWWszGVCOdvn0fPnaeBOnuWTrdv0tD5Bxm?=
 =?us-ascii?Q?9Zo909ff77hqwk2Ipdn9rD+RsNyYUgDH1JqoxfBfvcbnN9mOlVX/fXXZyGTU?=
 =?us-ascii?Q?+dDL49/ncwaeYN0wb5PMa3jOoL4w2Bp0GE4Hfy24VyjAx/HcWWrm8DV9Ni0P?=
 =?us-ascii?Q?JyxLAYU0GIDQ9h9OFtOB2psuvUYJnTr17VKgK28kA3EBmV3gxy1jun/7hGXF?=
 =?us-ascii?Q?6kshOi/dx5FzVZyuF0bdBMLj2KRmW/IEKbHy0kWuqogzx2TukLVAcYDfIEyQ?=
 =?us-ascii?Q?11c3OmQ8N70PfV2Dl+/3U6gOwjONGcopjqmLaKtkvHs2L4uvxr4+UbaiPCG4?=
 =?us-ascii?Q?jhJi1RolWMrBDLBTWu5Sln4060YMY9GX1ylrIHYhFR+tSPFmN34eqGJ/4GLk?=
 =?us-ascii?Q?Lpmxfz5Pm8v8M8CR0jIiIf0ilvr4Tz55ebog4zMX70E8n/c+L/XpO0FfSckI?=
 =?us-ascii?Q?FR0Ja41v5jZvk1P7+SxV2VoDmqSCLd1n6kdWAZZOq/RFzT3nI7/wyQarXZmk?=
 =?us-ascii?Q?fvl2ejZeyWNMet5L2HDKggIrXDv68CDcuEF3U1xOM4jOYR98+5fgkMlldGDT?=
 =?us-ascii?Q?g4Pw12Br7ZbOmTnhdtqY4ks+ztWAdclnV+kDaSdu1aknvSKYz+mVXD5WScmJ?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BYbLGC9TjMVkUo1A/2OtzaRBjrDjrXw64Z6UU5Zk6XpWtqMQmAiVMLvxwAFjCKzQgx2bFCtPq0mHstyj+UJg5mDJpkcHh3Bjk107aXWhJWRNJLO/RlMr68maOmcfxyxQRGk00h7ciuYuiQwUWyW0UhWYzuhKjjyP7bVlqqfIu765HNsMJFEsjx0mlG/KE9FtKZRrLq/XEStdJ+SGVP7rokAWptOU+NQxfUAKPMMcapDGF3NI87y4/jycZrhL7jxHGMPjYOrqW3UvN8JMrncE75AD5S2pw0snZ0CizKRNDhgtFjIykBRIyK9ebCrLOwPYETmtQ2RsIyCWeZ7J9izxFOZJHhnDcLiyYqQoLC94mI8rrEu/w49ARYFPJJBdGsKJ+FL7DwBN3+lMbhKlKXi8g4i0bpPeIhXT6naqAAJfpc0AaMn9B0q6NIT+pDcBiQ/5HC+qfcgIToCemoeqETuUAKz9KcHYzfZ9reVuaiIs2odxzvbuv4i+skVWPkxyPypJnA1c5BcpMNIZ3wRFcGJ8vNCi/kdn8qMLOgwCXtzVA7rhcntqE6m4O8g2YTxpzLpOzEdF7EJkFea3pO1eeQeLUSjm2R2x1minB6dWSlt69Vd1rBu5GqRzs+07yg0FMB6Cq73zG3BUcIt06QHjQSlClBMScxzoLRA3IhwX3zat+d9W6T4reB9an9fOBrhsJiXA1KxBCBYkHo6C6sqlxBTRX5wldSGxQmpqZJkhRgVftEAC8xpMUYSx5cVn3fQuCtf6eMk4OVW5woQ3qSmVB2E9Eiw9/2RYuDdW5zPLG6S3Kkqj2Kyyr17lzWsHVzCs4YX/n3F7diYQ2/wvnOp0lESd/iV5TGqzbBK9dart3wDUTkM7JZ6f4gxtmyueL0g8c0hGhvv6B/6ylvgHNSWjH2uENaM8VWYIbWsJVNzVOjDLU3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc45a265-e786-400a-64b6-08db61eb77cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:26:55.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD+ho7YjVDfabAxiCAkkjYb0afQV2geh/rZGThr0xFHHmPl7Ta7qZTDbVSlrC5D4rvImy1KE3sCldgJnNx3ZrqQ8sjejRuc68/sl6rJX1zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=741 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310131
X-Proofpoint-GUID: E_kdF7S1pPJ8PXbzWqNWr1kHHodW0w-t
X-Proofpoint-ORIG-GUID: E_kdF7S1pPJ8PXbzWqNWr1kHHodW0w-t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo/Justin,

>> > We probably should have declared no_of_objects as __be32 to have
>> > avoided this confusion.
>>
>> Perhaps this patch can add that too?
>
> Yes, please.  Something like this is fine:

Please send a formal patch. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
