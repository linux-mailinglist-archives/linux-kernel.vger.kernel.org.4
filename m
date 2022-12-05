Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709864375D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiLEVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiLEVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:51:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2669D60
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:50:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KOZQZ017782;
        Mon, 5 Dec 2022 21:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TZXzPIeFBsutiEi0JMPfG1T5BTh2PKUksWUzS39hlqU=;
 b=wyyikjQQZeJKPOp9v+wCZUbo1nANtT5koyhgkb/rJedBboBFLxSVUHsLY9e9G+MkgC8H
 SxiwNF8GIdwzu2tyVGm0K7iC2ResCrp6PA9+ylNbfGRSmmPV/pRiDA9w9Rii0a9OMh5t
 isTVXPXx/DUjDdG1hz9J1xe4bqhej0DO+UF6zqiqJ9iqTOvUUYx5aJDpbCs1/LBo/5Cy
 c6SwVV2JQp0Y681AISjGPpyNyCf7ZKBkkNQt4ztU4VD5JMMAv0u+8s9samMkcDPd41r7
 xQLsea57EnCI+sE46Isi4OnXtn1hzAjK8orfK4zPkV6QthQzBOxHWMwX/ImKwpbL/IKK Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqn8tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 21:48:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5LWj8n009377;
        Mon, 5 Dec 2022 21:48:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugeur3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 21:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNoL3BY8MUOw2DfVh2X97ePsgfHQ/0C3u2V6b+QJxriPj/kGxrrBhGQpOTSN4SQb4U+TUdgzOkFfDXB4B8OQ2bGW1BsePcf4valWJGKtolOi6cUbnrsvHpUyaXMPYazDbh7NS41x3F1TTOaMBEejlSQ0AeimFJrqFnBkReeJZ2zIkSQxi4XLl1ecXkhYixPbcipfKGOmBqB9VFgxMRUg11IpkRkXXeuo2ITX45qooEPRbg8wKHSfzgjHRzxffbc0c41VcIsUSiGBoNvOI7fHnf7ZCnVkl8vgwmNvKBPNqRFlO3BnFS2zGFCEiLO3ej5E1LjhoO1nT2aIIqmNItCj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZXzPIeFBsutiEi0JMPfG1T5BTh2PKUksWUzS39hlqU=;
 b=DPZt3kpkiooyKBsS3XGNWn4o7T1FTcuPLFcRpoihm6z3VTpHP8qJETcJrITo8rNh9OecEwkVvg5UJU140YzaTAnYy+n+4zNkrBbpawTkxFuw9D9uj0BfifvprbEFvIQoO5GGN34WUrdyD6MKtoXXva70ynNLhfpa04gDiqCXGzbcQfkT6BJ2vNKlBHO1hvfzTU4QFuyjKOqAt/E0Zf/XGL20DWjHkd0Ge70oyKSIOv4VYMZFpqM8EbW4kXjBsgLAnwBcUCUs9yfBMiLOLCn5wlR3BTTvqnz4ka5DrbXU4QDHGoItZiIqFJuwvnR5VAR7DYiJ37oXtM47tBH4BWrBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZXzPIeFBsutiEi0JMPfG1T5BTh2PKUksWUzS39hlqU=;
 b=fJr++IAJlt+9pAikmp5oD9w3IONIY3Nb631Hui9X3lI1EUyVaO4INdPyNqvt2uxl6Z2mJywD4PO+esl1A95WVU5pi7Y/QfrbrECKVVxsoVeVymmaUE1hws9O2b0P83IXnKr+chFjdeIjuPrRpJlFUqhsnYLzy2wPcYdm5Ndiw1Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:48:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:48:02 +0000
Date:   Mon, 5 Dec 2022 13:47:59 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 03/10] mm/hugetlb: Document huge_pte_offset usage
Message-ID: <Y45nD5HjHYtBjJ5V@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-4-peterx@redhat.com>
 <Y4biOcQzE0yJ82aE@monkey>
 <Y4d9opX7wok4GCdb@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4d9opX7wok4GCdb@x1n>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 83750962-7a6a-4b57-1727-08dad70a6204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdAR0qQDef1kJDpNePjd8BZXoZNKi8RUwGT+ZN2XSBgdEwH8BInLMZlyf3m8KHuXHCpkSJ6q5bpna+hRmtqhU/m0JfDEbmQJJNM7DPeE7Yq2XFd5SvJtdcvj9BoMXD2lBQt4gxDEFOOYervMF4wpUoQ1suD3qy/rGjmGxcG6cO+Tx3zPqdBsnCcmNTU5F3kWiL2PAme0GSHnQOt3iRXZvlf8uFCE2RHsZI3m1sBibvHqDOmBYeoNV8fZrpz4kwos/J9f/Haq2yxcOMai8fDEjy+Rra3u1veq+dYrC6TXUuQY6azHhxZG0DOPu60HUuuiXY1wEucy381EaQ1rLN9RLyeiH6XHp7DYNZzJfACOFr2DB9lOpJu9sx6tL3SZ3BwdIbu4klm2XMgGh3P6ClO6HmVmnrjZbMVxo16v5pJxPapbQQg53Uh3z6n1U+ipq+rja1iTTbuTEX2hNcKDyR1lxNNgpUeEf+E/TYG4/KzmL58A0GHes+j/xNre3hs5DzORNW/0HWB4moj6T6kFnaRn4oCM1Vaf+MpTfEH4qTyBMNBUsIUMBIp0Q0QEMsU1N269aQNiiKSsP7djp57cbLoAVAPLzQpZRWyM8cEYsH4n845e89G47ZU44Mdoy/HRJWbhABf22ZruwmXfm+HmIpO8W2lhnY8vSNwuQMv9EzYU9EP+hcLKjS/xI5It68YbpCCJd05I9Uv7n10ley/dtnvlyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(38100700002)(86362001)(41300700001)(2906002)(8936002)(4326008)(44832011)(7416002)(5660300002)(83380400001)(66946007)(478600001)(66556008)(6486002)(316002)(54906003)(6916009)(66476007)(8676002)(33716001)(6666004)(53546011)(6512007)(9686003)(6506007)(186003)(26005)(10944003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ddHap48rPDI1Xp28my/2GRn/bO0uj/FmtLGL9X0HLIqqmb8KEleRtgAgmsb0?=
 =?us-ascii?Q?iLCPrrldhr/agZPm/E0/NNWDfsWr8hn2dpO+uTuhcYSUUVFD+Kvy7j1dMgar?=
 =?us-ascii?Q?/OtGrFnUvnPHYltDsmquPeVmPEta6AkZ6ZQ6nY6LDvU8kIPsm44zKTuCYqQz?=
 =?us-ascii?Q?NCLYMICGAyciU+bkwisgYQU6MuOa9fDAebS76YTbM89FU13uqfu8qYlazzy7?=
 =?us-ascii?Q?tA6CoGUmdHpUlYsdbA6t25T8DLGfsKqP//KqEPoH6s6LMQP2lWlHNvDbLoRr?=
 =?us-ascii?Q?D5Tq0fq9nHkvIJx1Sz31aNh7GtfJeUZKsLcDWaey+Th+hj/ZaEwAsK+56KiS?=
 =?us-ascii?Q?yzd/tt/oYzCpFOS4/y+EFQTS4UegmwLGmGooA+LxvKAbSpHhetSX98Avusok?=
 =?us-ascii?Q?aFg2Xlx9tthUEuPKhXzsUerF9LK3thVyPr8KRR/WD+kuhgUph4Uvb1vCh3ip?=
 =?us-ascii?Q?F3Fwz06n/KhJNRHAGbpy/ZuPCPDARKEJjouQuaSucAI2gSjzH9kYiqaDvauY?=
 =?us-ascii?Q?J+wap/IGUTpcTL5QyHnYqPe7m2pPuPhoK3sJQ9we4WFH2GYwWDLousmj38t3?=
 =?us-ascii?Q?zlRk0+EO3Xy/A5InhCwY7nLLboTRzHp1XFwwoY9iZrh5Dch5X8klfgFCwkHp?=
 =?us-ascii?Q?U+tvUPv/FKPCP12BNCxD/UzvIxqllwwTnFhmxGehOeyG6tYK6elX5Txy3dkC?=
 =?us-ascii?Q?GwvhKCo53996sxtY7jRzdN6OJi0GVcIqhzLKVTiZ/zksPdA6I07xHsN4Hcg0?=
 =?us-ascii?Q?HvcHfWzdB2TL2uuXlHBm3bb9HROnAuOADGN7XJeBGCisLuSsMGcQTFD0NZyM?=
 =?us-ascii?Q?EO1gEkUXqxS+bX6HWVdJU//NSrWDcCpZS2ymnMGI1SoQjLrBmazwH+wuAgQK?=
 =?us-ascii?Q?ubKOISqZ05JCxxg8oPwcST8MQtf0JfzJLkzr3bneRqUpQ1D8CFaIvb7SskiR?=
 =?us-ascii?Q?C+5y6/ULotB/ya7cj7EmdY5HfQxpzPfpLD7VUoMVt5yCv+dMHMj1yrtPH0I5?=
 =?us-ascii?Q?E9/+8uUQO61xArd9pc0B2GYyeDaNLlaEht28/6K90TJZVWGGo5HYL1YPoROD?=
 =?us-ascii?Q?0YBOLglR57XBwVebqpdL3USRLODGNPzScb0bBxLTv/oQ93A1um1jAxa/dmnA?=
 =?us-ascii?Q?Tq8s4DdqjUZnRHlchohr1aY2j/rmPFNypooRQbun03cGVPAk8zxWiUU44JD9?=
 =?us-ascii?Q?fReKeNoakjDNPBqvKY/f7sd6qqHnFMt30hJtaiN4JMhcg4cMT9lQ0bWVaSDo?=
 =?us-ascii?Q?oblpUZt8lzH7fZnHR0XsZAnlQXjaJQy95xfibMNssom/KfBFyaqLdMI+eXaq?=
 =?us-ascii?Q?X/hqS9K1+YWz+/gj/3aoc2lo8R0ebVU5HnOWrh3QmaptGVL4+1W/AhbZhRSo?=
 =?us-ascii?Q?X1miv0T/U4qQA/Brt9uk2lv0w7PVEETssTMBcJ6dZjuxKRiAsCUME9/O5VN6?=
 =?us-ascii?Q?VX1iTmlLVr3YMLK834dx1qccUnxSb1b3x4LIHNqsusQpAqebKlE71aaTtaGA?=
 =?us-ascii?Q?d+/C9aSHpoUgalOqGSPyztdrtx7OHqNtl+hqyNYDjcLPn41mz0nLKJRkW6L9?=
 =?us-ascii?Q?v27+BXfvLpB0v/Pk23xKKw4cwD6pG2LMmvk6un1JZOF420hxu7H2vQ928ea5?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JEglgBt77UdqszlHX2Nam8UOeVp10VXthks5w/priX/axeVdLb6DLJF8nEcJ?=
 =?us-ascii?Q?ZGmOp0Li/gu7n1QIieqf8APuy3wxqDk4PgzifXbfkETPjBMNsFrMeHagY18s?=
 =?us-ascii?Q?gKmuhZtkfSsCqP1WZJPzokq82+8oifS4JFoJO7gTBRjftIp/a2HqpX8NLOuL?=
 =?us-ascii?Q?yP26MP2Dt7dF8HYGnr1k+K/9/d4l/13a/7x8JOsjpkYlT+tI81NRmfGkZ76r?=
 =?us-ascii?Q?MZtVB64Ztbrh9R/kSSQAruHTJsDRgv3XXGGH63KM4syApoHArqywTqQol3+C?=
 =?us-ascii?Q?kM3P2yOVqyCoShfngc7UCyA/J6gbEGQQJi0dKjvrRq96HzCJzfM5utnlPXOI?=
 =?us-ascii?Q?oK78HGOl+NOAA2qjCeM92y2z7oEtkyoxQ+xa5tONWdazLBCDfTvvCpMCqTmi?=
 =?us-ascii?Q?6wzQKuGjzV2d7UuTvkdDOC0TO7Exie6iGp+3sWotIHiLzVoPCKMZ469/08vY?=
 =?us-ascii?Q?JY2kLK1BrW88SQVVY9Z2ecU6UXp5MmXNFNg+h5yGshGHWTv7MF0/t64GSBNb?=
 =?us-ascii?Q?HZrWiHp0+2YAZpTDe/JTh0iOjqVipbuXvPdGLHRwXD+zbVuxIabEhpXZ0nj9?=
 =?us-ascii?Q?MZPftTC5sy06nel0E+dZZMYd3VnnHGAQzWrg7EtRpVb/DmpPXtOZOudU7wKi?=
 =?us-ascii?Q?RtvNwv+w6Z/HEeM3muznxdPndAOmeL+9wrP6cv+ovnTNz1rFM3vl7YxxNRjW?=
 =?us-ascii?Q?QLUnrL9h6AV7ogVB2dXG1i2PTc6omYPGJ7IJwNvuq/K/t1TY73xaQZ4KYCAh?=
 =?us-ascii?Q?8FP6EI/NBc4w7DMx+HOunrCV/admRG3U9Xw4gvqI4ZT7GWdlI+deEs+/qxp1?=
 =?us-ascii?Q?R8FpnZOPRMnKV6gUehl/cn4CYlUr+lk8kuW/iK2aUcEOu/h6i8ojiLSy9RuE?=
 =?us-ascii?Q?M52VIc+1Ey5id8r0GOq310hLCBhpTh8IWtMGJ9RJkKj6XjJh9x5EGTVxCW2d?=
 =?us-ascii?Q?Gz1tPYPPVCCiAuPHG67TPXa+sKBFQZHTmzrxFXyXUmmhrn6ej+gHt+SS2g87?=
 =?us-ascii?Q?Xmjb3IzYxpe6xvtOT7xXASxdGvQQYJeOtIs0f+6ovSxIJfta4UZI+RW9LuVp?=
 =?us-ascii?Q?F2AgMKMplfIU8W3P0RkNN6WDK8MY/8DLkDvdKrkm1RBbm3gRYRU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83750962-7a6a-4b57-1727-08dad70a6204
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:48:02.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6ALN7EjeyYDTGWHKfPCehT3/u7sO5X0tT+etDVniuJ1GIdXfuvXkOce9w+QuRBP5/omRSIOrbnfYqDO8S4dUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=805 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050183
X-Proofpoint-GUID: Xs0syBod6qzz-IXy8QWdhiQObdY3LqO3
X-Proofpoint-ORIG-GUID: Xs0syBod6qzz-IXy8QWdhiQObdY3LqO3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 10:58, Peter Xu wrote:
> Hi, Mike,
> 
> On Tue, Nov 29, 2022 at 08:55:21PM -0800, Mike Kravetz wrote:
> > > + *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
> > > + *      pgtable page can go away from under us!  It can be done by a pmd
> > > + *      unshare with a follow up munmap() on the other process), then we
> > > + *      need either:
> > > + *
> > > + *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
> > > + *           won't happen upon the range (it also makes sure the pte_t we
> > > + *           read is the right and stable one), or,
> > > + *
> > > + *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
> > > + *           sure even if unshare happened the racy unmap() will wait until
> > > + *           i_mmap_rwsem is released.
> > 
> > Is that 100% correct?  IIUC, the page tables will be released via the
> > call to tlb_finish_mmu().  In most cases, the tlb_finish_mmu() call is
> > performed when holding i_mmap_rwsem.  However, in the final teardown of
> > a hugetlb vma via __unmap_hugepage_range_final, the tlb_finish_mmu call
> > is done outside the i_mmap_rwsem lock.  In this case, I think we are
> > still safe because nobody else should be walking the page table.
> > 
> > I really like the documentation.  However, if i_mmap_rwsem is not 100%
> > safe I would prefer not to document it here.  I don't think anyone
> > relies on this do they?
> 
> I think i_mmap_rwsem is 100% safe.
> 
> It's not in tlb_finish_mmu(), but when freeing the pgtables we need to
> unlink current vma from the vma list first:
> 
> 	free_pgtables
>             unlink_file_vma
>                 i_mmap_lock_write
> 	tlb_finish_mmu

Thanks!

Sorry, I was thinking about page freeing not page table freeing.

Agree that is 100% safe.
-- 
Mike Kravetz
