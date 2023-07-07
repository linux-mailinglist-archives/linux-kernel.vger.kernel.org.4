Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CD674B2B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGGOHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjGGOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:06:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5312D5E;
        Fri,  7 Jul 2023 07:06:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Cx1hU023983;
        Fri, 7 Jul 2023 14:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zOuXbhuGOp5uXOOxQd3RK1JehGaS+kIeLNtyckcS3Uk=;
 b=zqGpaOp475pZt42e7pHEa6mihH6E3FoglTXggk44i+FpcbQjeWH5mCY80v9UtVYj4LsU
 03U1kBSW0+Ld9Ioj2WzGEwSB/+AIW2oyvtr542p949O4UFzvUuEF6LhDewDL1h93VTw8
 2AT0SVlCbVVhUeloDqBuEwV9A2SuU6cBWoPqYpnkE91XaMmjkMnDR2SlNKtbA0uatYs7
 EtLAtIiIet6Dyqq1CVzEG8KxTJd8W1Z1hNk40GhLpc2a/x9qq/9j1w6iTb4KpbdZ7iuU
 sbCYKfh+mBSizKqU3EqhJRHwVTk6GEVCyDVgPMcGB2QG1KG21ArGQkoEXK/MDMVQ3Y4H 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpfhprggy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:05:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DZcSU013508;
        Fri, 7 Jul 2023 14:05:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8gt10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNYyiL/dX00dDp/n9DmBHnT5hEsRg7NlrqpD8Uf5yrlc1RXdpTbUqSKOtNEhRBvMS/cslzbOVsEQfp11ZGSpZJun0Epvdt5l79w+N5qKphMOVq2LK0s+kKxzkJWv73EObfzjF7kpnoU/PBiBrL4zoukm/fRfqNNi8ArQK0vyEwAB2Oxdto6/9lszV0eldW2Pkf64Sl+Vuc5iKhJ9PqEChVCjhV0wdM51qwu/XIkudXojHkj1o0GHzo9la6x/Xm/QNWZNB7IArU45Cp7YWXRSlZNTBj08HnL1O9oZ3o9P1PJESnErt72s8lrmrEfHWX0wegbQ0dTD/GHqoxrSBdiXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOuXbhuGOp5uXOOxQd3RK1JehGaS+kIeLNtyckcS3Uk=;
 b=m9fgmMNGkcwT1AkChNFdCRpcGzeLLmIsSEgBVwyUCO80RT6w4mLNy2H9qCT0POfeWaiGzXXfNlF6d+gAzOQQuddeAjRnGT9USVR1WGAsP0ekHi5wuhaKymFX2hSQN91v1frNK1vAx1pmIo2EoFAaJqxWfWXh4qeEW0dVE+tbtcHp946MdgGr7PeP2rdZI0agnqklKYO5VD7DE5gXw5QRDgShsPEpmwhctI/fk8gOogoigRpK82ixD8hMXtLwL/+ehXsidpMpfGC2KmnUAVZyiPRR6kyXfCUuphwoHIOjRZP0WDcXZmVt1v2HDWIzuKXIr8ynLb+35rS1quh8fHwMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOuXbhuGOp5uXOOxQd3RK1JehGaS+kIeLNtyckcS3Uk=;
 b=z4DRrAu1MYlBkVa63JFB69mH440/VOPosoQEI6gCRD8qqga3fvQp5eMuk5uUHkQKK/UoWg0aAO4OEDTZXEVg1msD3Nw93meUrFupwnejYcVOUO0UIIGFMG2ub8wWrHptoWQ7F49TmuP20iXH7fXtTDkOHzbzbDaOhi2J0hNcZ3c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4836.namprd10.prod.outlook.com (2603:10b6:208:326::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:05:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:05:03 +0000
Date:   Fri, 7 Jul 2023 10:04:59 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 3/6] connector/cn_proc: Add filtering to fix some bugs
Message-ID: <20230707140459.qsyjw5i6chpbzqwj@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-4-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-4-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0187.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: b6064b02-7345-4ed8-1e79-08db7ef32879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcYpqnmGiWWSHDVLb+dDQ/gMlrS0V1uqdSMGg0SosEoNTSwIOsNpoY9Psmc7ItAcnDMfOewWSqoD95+Cs6qN/EEB8NClufZ+/ujho1eME7sO9dcPF1N94jg3aLh1/LRoz1v2aIBwzp9KnFNNY3EHsk+FTo0LAz2Tr2An68YoeVB/kEkWNrOG/DoTBB3D+79xFpv2Vc7HIPeAMACOpbYfsosyqaw/tpcqj+7IRN58jM31d2lmvfdyN7T4nI4YYFkxr/j8w2LyUpwKp8QU3i5fBnkM2WPP/Ueq6xWbUNJY/29rgKC6RQt55/lBVHec7HELV0PY/zv7powshoQhQfnTQXHooFh5Vi/A8CSzBIs66Zo1Ues2gAncUpG4x6fmJkZjL3ecEb3gbtZFEoB8CAvxPUdPavPVgsn79aHSFtb40r4Q72Sr+ua/HR53q30qIAEwuHsDTidetSs5jDM07Cf9Rr6e0MeVpV8HYp3QXHXcRitESTUq42gmkP2Ykpn5UK2HQ/pm6DNdm3YaCl/zR3ZZx5Onaj88exSOV2tLXfXuHm/eQ6J4LI55RVius3g4tPjh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(33716001)(2906002)(478600001)(6666004)(6486002)(8676002)(7416002)(41300700001)(8936002)(4326008)(6636002)(316002)(66476007)(66556008)(66946007)(83380400001)(38100700002)(6512007)(5660300002)(6506007)(1076003)(6862004)(86362001)(26005)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?intFEJXnGz+o23wlttqSqvrApTF1C8SA8NffVe4K7fXcexDq9M3HrV0hcDNc?=
 =?us-ascii?Q?E6rnUZ1k5Pp1lqlhA/pBRdfARkI/XO81Ch9d0szapJacEOuCfpNzVt7cD/tK?=
 =?us-ascii?Q?bijdRCZlhA2xKHY887CO/K7qvkv8eP4rJb9gI1rTRjKxo5K1/CQB5RUNBn6k?=
 =?us-ascii?Q?nGhYb7fzIQ/bF3F01+mLdKRn18XEjjfCH/d4DNpeprNMEmVncYn7hRMJ4x63?=
 =?us-ascii?Q?T6mtLFWL322v0sAlp3CXHCPxaclAegVwj1bbvFAw4gBS3dKBi3Tw/1VJMfq7?=
 =?us-ascii?Q?mMqlvvcL+SVlf7y87fwGohlIWfyqJOdX6V9CyDWfuUzEaQj5Rq/4L5Odw0Ha?=
 =?us-ascii?Q?CbmlRZ+Xj+aOToUV+93lqkDyRWBOXlzjSbvR7cZbLV4bhJjGHpNqstgoBwPD?=
 =?us-ascii?Q?SIHUbKjJFFnmr3orLEU620figrta7mC1iEyOM/bXNgJarOLO9rjEIccyPra4?=
 =?us-ascii?Q?83NSzoxYI6qapNJe1jqXt41UO6ngQ0GQXO9DMTfjWEhTE76CxNDnH4XtzWQa?=
 =?us-ascii?Q?+z53adJd1RfURIjo7qkozjN9Cmpj/j+1UT+1AibGrLVYLr31BWc7ZZmX3sLw?=
 =?us-ascii?Q?z9aulXN2rGwiIv8Xn5u+3J8aAv2hINJnKIvYlRzwVRyg6WfmfKafejRnOkUG?=
 =?us-ascii?Q?XhQmpxUfW6e38zeMXm5TaN6eG2wYDwKwZFZ79J43rgQgRyfM8gqjMKQ+1Upb?=
 =?us-ascii?Q?04X01w4gBOtq/DdOwhuSmfP612Lxht4wZJBF/WaTZ220aCuD5DSW2ZJtKvzB?=
 =?us-ascii?Q?5XDr0jhpn9HT3p682HPdgOBjjpKn44aPakFkLa/6vmbBAG3vJSQLNAHcA+Po?=
 =?us-ascii?Q?QGjoLWwOc6tFHR5fscJiZ8Xv/UPZnWNUmE/MdAyHNBQnfxhNXoY5SsiIQDYQ?=
 =?us-ascii?Q?RR9qCgxRDL9YQNSHyhC1nmhjwfzlO/Kb1WF87KlCv4T3kQN2oHvpMVVGX4bo?=
 =?us-ascii?Q?nb0A5fCiaD46ZgTZ3grLBaqCAyyU+5g/aNz6bW8uXMmNYGkHr2a5BKrRborE?=
 =?us-ascii?Q?nc3Gy0G2CsF2n45+4xSnb3mKp7U0CTfcAjbGlBmzVpEznrF9O29WwWewCl5P?=
 =?us-ascii?Q?aUuL+UnOuqijgMoutLzT9Q3A5G67/JBuPeEZ2AGCD7FG1QDmwqqZ4Glg8xzB?=
 =?us-ascii?Q?5szI8cQv7+mYzR+oXMVUP4grXbR/V/sy5sSupWiqKr1vPLuIFO148csiZa82?=
 =?us-ascii?Q?pCy9RU62UUW6pH+ueY6u4Ha8ML8bQen8DJFwGYxXOvzyiNcY1y9Khu+4H9FK?=
 =?us-ascii?Q?5YI04IbH4+b7C5GS750OSpUADf5a/SHblXP1yn6khP+CBdkmsF++/IA+VjL/?=
 =?us-ascii?Q?aQRFdXLg8pndPAlnHX3k9fn7IaJ1H6WDYjNRzk0KEdoqIkawb1nF09t6UacC?=
 =?us-ascii?Q?IWWa8nkil+F/CG5b6ANW8am4pLnSKQzHF86/T/mnsDUkrhgCjEjgdvap9EUT?=
 =?us-ascii?Q?o/7WDR6q3SQ91aSLgC8A/8WcC6SjnCfAM5IeV1qWPj6a/RDxDuAa0Inlkovr?=
 =?us-ascii?Q?452h6NvTOtS8wcWPmpFoxF0ozEN+IfgKbovNmZpoJ5Fj7PbIk5m2ZMZyDikl?=
 =?us-ascii?Q?iuijjN+M+ssBe0FbQa1MtXDNwQ6JcUXBnmUJ3YkgRMVMTH6r56T3D0Gep5UY?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bpnbklY/5s6uEYBRUOAJ+4Hh/av532slTrO38sGC3Tb7c6Nnw3h2l1QzWHRz?=
 =?us-ascii?Q?4K9rIkHA52bKPKGNPT4edK0ta1KFSlp5fXppGr7wi/kL7KlWO/NLTBbkYgdU?=
 =?us-ascii?Q?oFADbLrqGcAfVmF+qbyH7wSirEh8UnwtFtm9MobqQ3OblhKJ5VTONNDTujtg?=
 =?us-ascii?Q?/T5WN87zzbU1XH5FlqyJZjS8W8Ovp/K4rxnZgvLWqBhMp8tp7W2mqXI/bNhP?=
 =?us-ascii?Q?ekj68hhzUJa74RZqbomFWE6ZCY9Q4kVZ6CFYVd+dW0SYzA1WJwN7ExChm8ry?=
 =?us-ascii?Q?VGmplA7QPso0uhx5ErLyI/Yj+lXvc7toLOyhW4ieNEKM+1DdzwKql6TC/C+r?=
 =?us-ascii?Q?epPbOryVV9MqXDPi1srYp9Oh8x5vENNLZbPN+lwJW+gMy+XDkHbRPKSaw31v?=
 =?us-ascii?Q?yy1op+S5P691zXJG67GYOa6cD6DP8S0wRxMhSQkHwl/efd7NZMv64+wCv6tW?=
 =?us-ascii?Q?miIV6tr48bfMD511/8Q3UE3IyVIA/FBrnXFtXhKz4EFqWXkqEsxCaWNcaCbs?=
 =?us-ascii?Q?kyiVum87CvzKSoNRphO5xcJ3Ke58TxFWI6LYqDyMMbArQhKgtY+MT/B1Ry/R?=
 =?us-ascii?Q?81LPjG+YVjSbTPGNvjHnD6ncJWvNkWULUWPWGgwaFW7eje/yI5r1UN6ofFrM?=
 =?us-ascii?Q?Qf2y/ZSPrT+EOIeDY/5PadLJXq6APID7SLKBdPMBdrppH6RYz0R5dTVSlwx9?=
 =?us-ascii?Q?hPILqwOvU4EH8b1UUkXBqOdqGH4jqZfr142RiPGjt+O2o4MGytPoLtUSa90a?=
 =?us-ascii?Q?QbowJ+5fYkrV4XA5g95Q4WNW5znhI22zxtZWZBsaypUc5vj+LERRQpHWxCFk?=
 =?us-ascii?Q?YE6IjR/sdyNwf8oJHbRM5E5BT7iK+OPmylhZn9FnU/Z31+jZPo0RsYN3SrT9?=
 =?us-ascii?Q?RwxoKWlxxAcvSc/aI7D8iRoEueYllWXb52cB5DaE4b9NJD1h9TpM/asMR/wU?=
 =?us-ascii?Q?q/0NBjboB+IkcbY2ACqsieY4AXewIgQrQ7ZX1cLoRNiDikwvL1+qamoTB2t4?=
 =?us-ascii?Q?XrfyXSXmozdUlE1OajrdsOjqLcWzKpKVda4+OesxrNZnaHNI0b9tr4wn+uKV?=
 =?us-ascii?Q?J+lmoaqIpfBo4Eq11EI9CyWeX/ETkeBuHOp+xwA4fo4FfBtgWqs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6064b02-7345-4ed8-1e79-08db7ef32879
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:05:03.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RC6wn4fVNYOfNYdVx15cdeRijmneFhrT/qvrzWVue4WiGutibUmGZgnv/ranTNpBT9bxfwS4UuKHNpHoNcZt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070130
X-Proofpoint-GUID: 4E2kmAW3vmtJ3mKZtohPae929xWjDqi3
X-Proofpoint-ORIG-GUID: 4E2kmAW3vmtJ3mKZtohPae929xWjDqi3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> The current proc connector code has the foll. bugs - if there are more
> than one listeners for the proc connector messages, and one of them
> deregisters for listening using PROC_CN_MCAST_IGNORE, they will still get
> all proc connector messages, as long as there is another listener.
> 
> Another issue is if one client calls PROC_CN_MCAST_LISTEN, and another one
> calls PROC_CN_MCAST_IGNORE, then both will end up not getting any messages.
> 
> This patch adds filtering and drops packet if client has sent
> PROC_CN_MCAST_IGNORE. This data is stored in the client socket's
> sk_user_data. In addition, we only increment or decrement
> proc_event_num_listeners once per client. This fixes the above issues.
> 
> cn_release is the release function added for NETLINK_CONNECTOR. It uses
> the newly added netlink_release function added to netlink_sock. It will
> free sk_user_data.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  drivers/connector/cn_proc.c   | 57 +++++++++++++++++++++++++++++------
>  drivers/connector/connector.c | 21 ++++++++++---
>  drivers/w1/w1_netlink.c       |  6 ++--
>  include/linux/connector.h     |  8 ++++-
>  include/uapi/linux/cn_proc.h  | 43 +++++++++++++++-----------
>  5 files changed, 100 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index ccac1c453080..1ba288ed2bf7 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -48,6 +48,21 @@ static DEFINE_PER_CPU(struct local_event, local_event) = {
>  	.lock = INIT_LOCAL_LOCK(lock),
>  };
>  
> +static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> +{
> +	enum proc_cn_mcast_op mc_op;
> +
> +	if (!dsk)
> +		return 0;
> +
> +	mc_op = ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
> +
> +	if (mc_op == PROC_CN_MCAST_IGNORE)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static inline void send_msg(struct cn_msg *msg)
>  {
>  	local_lock(&local_event.lock);
> @@ -61,7 +76,8 @@ static inline void send_msg(struct cn_msg *msg)
>  	 *
>  	 * If cn_netlink_send() fails, the data is not sent.
>  	 */
> -	cn_netlink_send(msg, 0, CN_IDX_PROC, GFP_NOWAIT);
> +	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +			     cn_filter, NULL);
>  
>  	local_unlock(&local_event.lock);
>  }
> @@ -346,11 +362,9 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
>  static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			      struct netlink_skb_parms *nsp)
>  {
> -	enum proc_cn_mcast_op *mc_op = NULL;
> -	int err = 0;
> -
> -	if (msg->len != sizeof(*mc_op))
> -		return;
> +	enum proc_cn_mcast_op mc_op = 0, prev_mc_op = 0;
> +	int err = 1, initial = 0;
> +	struct sock *sk = NULL;
>  
>  	/* 
>  	 * Events are reported with respect to the initial pid
> @@ -367,13 +381,36 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  		goto out;
>  	}
>  
> -	mc_op = (enum proc_cn_mcast_op *)msg->data;
> -	switch (*mc_op) {
> +	if (msg->len == sizeof(mc_op))
> +		mc_op = *((enum proc_cn_mcast_op *)msg->data);
> +	else
> +		return;
> +
> +	if (nsp->sk) {
> +		sk = nsp->sk;
> +		if (sk->sk_user_data == NULL) {
> +			sk->sk_user_data = kzalloc(sizeof(struct proc_input),
> +						   GFP_KERNEL);
> +			if (sk->sk_user_data == NULL) {
> +				err = ENOMEM;
> +				goto out;
> +			}
> +			initial = 1;
> +		} else {
> +			prev_mc_op =
> +			((struct proc_input *)(sk->sk_user_data))->mcast_op;
> +		}
> +		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
> +	}
> +
> +	switch (mc_op) {
>  	case PROC_CN_MCAST_LISTEN:
> -		atomic_inc(&proc_event_num_listeners);
> +		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
> +			atomic_inc(&proc_event_num_listeners);
>  		break;
>  	case PROC_CN_MCAST_IGNORE:
> -		atomic_dec(&proc_event_num_listeners);
> +		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
> +			atomic_dec(&proc_event_num_listeners);
>  		break;
>  	default:
>  		err = EINVAL;
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 48ec7ce6ecac..d1179df2b0ba 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -59,7 +59,9 @@ static int cn_already_initialized;
>   * both, or if both are zero then the group is looked up and sent there.
>   */
>  int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
> -	gfp_t gfp_mask)
> +	gfp_t gfp_mask,
> +	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
> +	void *filter_data)
>  {
>  	struct cn_callback_entry *__cbq;
>  	unsigned int size;
> @@ -110,8 +112,9 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
>  	NETLINK_CB(skb).dst_group = group;
>  
>  	if (group)
> -		return netlink_broadcast(dev->nls, skb, portid, group,
> -					 gfp_mask);
> +		return netlink_broadcast_filtered(dev->nls, skb, portid, group,
> +						  gfp_mask, filter,
> +						  (void *)filter_data);
>  	return netlink_unicast(dev->nls, skb, portid,
>  			!gfpflags_allow_blocking(gfp_mask));
>  }
> @@ -121,7 +124,8 @@ EXPORT_SYMBOL_GPL(cn_netlink_send_mult);
>  int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
>  	gfp_t gfp_mask)
>  {
> -	return cn_netlink_send_mult(msg, msg->len, portid, __group, gfp_mask);
> +	return cn_netlink_send_mult(msg, msg->len, portid, __group, gfp_mask,
> +				    NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cn_netlink_send);
>  
> @@ -162,6 +166,14 @@ static int cn_call_callback(struct sk_buff *skb)
>  	return err;
>  }
>  
> +static void cn_release(struct sock *sk, unsigned long *groups)
> +{
> +	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
> +		kfree(sk->sk_user_data);
> +		sk->sk_user_data = NULL;
> +	}
> +}
> +
>  /*
>   * Main netlink receiving function.
>   *
> @@ -249,6 +261,7 @@ static int cn_init(void)
>  	struct netlink_kernel_cfg cfg = {
>  		.groups	= CN_NETLINK_USERS + 0xf,
>  		.input	= cn_rx_skb,
> +		.release = cn_release,
>  	};
>  
>  	dev->nls = netlink_kernel_create(&init_net, NETLINK_CONNECTOR, &cfg);
> diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
> index db110cc442b1..691978cddab7 100644
> --- a/drivers/w1/w1_netlink.c
> +++ b/drivers/w1/w1_netlink.c
> @@ -65,7 +65,8 @@ static void w1_unref_block(struct w1_cb_block *block)
>  		u16 len = w1_reply_len(block);
>  		if (len) {
>  			cn_netlink_send_mult(block->first_cn, len,
> -				block->portid, 0, GFP_KERNEL);
> +					     block->portid, 0,
> +					     GFP_KERNEL, NULL, NULL);
>  		}
>  		kfree(block);
>  	}
> @@ -83,7 +84,8 @@ static void w1_reply_make_space(struct w1_cb_block *block, u16 space)
>  {
>  	u16 len = w1_reply_len(block);
>  	if (len + space >= block->maxlen) {
> -		cn_netlink_send_mult(block->first_cn, len, block->portid, 0, GFP_KERNEL);
> +		cn_netlink_send_mult(block->first_cn, len, block->portid,
> +				     0, GFP_KERNEL, NULL, NULL);
>  		block->first_cn->len = 0;
>  		block->cn = NULL;
>  		block->msg = NULL;
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 487350bb19c3..cec2d99ae902 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -90,13 +90,19 @@ void cn_del_callback(const struct cb_id *id);
>   *		If @group is not zero, then message will be delivered
>   *		to the specified group.
>   * @gfp_mask:	GFP mask.
> + * @filter:     Filter function to be used at netlink layer.
> + * @filter_data:Filter data to be supplied to the filter function
>   *
>   * It can be safely called from softirq context, but may silently
>   * fail under strong memory pressure.
>   *
>   * If there are no listeners for given group %-ESRCH can be returned.
>   */
> -int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 group, gfp_t gfp_mask);
> +int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
> +			 u32 group, gfp_t gfp_mask,
> +			 int (*filter)(struct sock *dsk, struct sk_buff *skb,
> +				       void *data),
> +			 void *filter_data);
>  
>  /**
>   * cn_netlink_send - Sends message to the specified groups.
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index db210625cee8..6a06fb424313 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -30,6 +30,30 @@ enum proc_cn_mcast_op {
>  	PROC_CN_MCAST_IGNORE = 2
>  };
>  
> +enum proc_cn_event {
> +	/* Use successive bits so the enums can be used to record
> +	 * sets of events as well
> +	 */
> +	PROC_EVENT_NONE = 0x00000000,
> +	PROC_EVENT_FORK = 0x00000001,
> +	PROC_EVENT_EXEC = 0x00000002,
> +	PROC_EVENT_UID  = 0x00000004,
> +	PROC_EVENT_GID  = 0x00000040,
> +	PROC_EVENT_SID  = 0x00000080,
> +	PROC_EVENT_PTRACE = 0x00000100,
> +	PROC_EVENT_COMM = 0x00000200,
> +	/* "next" should be 0x00000400 */
> +	/* "last" is the last process event: exit,
> +	 * while "next to last" is coredumping event
> +	 */
> +	PROC_EVENT_COREDUMP = 0x40000000,
> +	PROC_EVENT_EXIT = 0x80000000
> +};
> +
> +struct proc_input {
> +	enum proc_cn_mcast_op mcast_op;
> +};
> +
>  /*
>   * From the user's point of view, the process
>   * ID is the thread group ID and thread ID is the internal
> @@ -44,24 +68,7 @@ enum proc_cn_mcast_op {
>   */
>  
>  struct proc_event {
> -	enum what {
> -		/* Use successive bits so the enums can be used to record
> -		 * sets of events as well
> -		 */
> -		PROC_EVENT_NONE = 0x00000000,
> -		PROC_EVENT_FORK = 0x00000001,
> -		PROC_EVENT_EXEC = 0x00000002,
> -		PROC_EVENT_UID  = 0x00000004,
> -		PROC_EVENT_GID  = 0x00000040,
> -		PROC_EVENT_SID  = 0x00000080,
> -		PROC_EVENT_PTRACE = 0x00000100,
> -		PROC_EVENT_COMM = 0x00000200,
> -		/* "next" should be 0x00000400 */
> -		/* "last" is the last process event: exit,
> -		 * while "next to last" is coredumping event */
> -		PROC_EVENT_COREDUMP = 0x40000000,
> -		PROC_EVENT_EXIT = 0x80000000
> -	} what;
> +	enum proc_cn_event what;
>  	__u32 cpu;
>  	__u64 __attribute__((aligned(8))) timestamp_ns;
>  		/* Number of nano seconds since system boot */
> -- 
> 2.41.0
> 
