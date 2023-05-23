Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D070E45E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjEWRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbjEWRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:53:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47351A6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:53:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHorXi020824;
        Tue, 23 May 2023 17:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KvLYlPXB/XPBNYdVJiY/FjuuoysLSHF1K5pXP4hYsp8=;
 b=i6f/a3TynjG14fS4m+tcEdgk8rMMupY0A4JuU0OLjinNrSEPs77tbuHj3NgpDYcO0S+j
 +xSpe6NM8VH4l/prtGHL0RDlqlU+aAT/m0S0dsyZuTfjV1CJq65Fg2LcaXd0kzPJjlc1
 FH/Byx3PtboQshFPPm7XcD8Fomeelx9ct6HlfKXK5nq1XX0r9mFQPSzAtgu3oXyacjKo
 s1pDUGhHvvhSeuNgH76/xl1NoxLJuUT8bPvjFdIGGAA3zmwsVFif/n143CfuNC23HLIb
 NGU9nOdOKoy9bQ/uaq8KuB4fJ+LHY7S1snK7g8qNgcBUNkPLfU/5G33eTfwCDpSk26BB Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp425ssh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:53:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHO8Dh029074;
        Tue, 23 May 2023 17:53:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2b68yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV5+kULhodnsmWL7HYxAsSbvv1GYMFvv7gAsN3SOsO6Bz0ofiEX/2oNAuA20iPm6co642BOXExfx7prdcCeejwN1ZUbXz1KgzgPRrILHBNVdx42+Y8y9GlsPCqIOY1hoSRmdASKn5ZmOEmSjeGpP3opWwaCftnUNQHI4+tU6xAa5lE8ZTBFuBbssmT9rnOfbDEfWwJL14Nd81gXr8t+ovgkUBF41Qu0HZpd5rLD7rhLFfZusmYzyTbb6n+OHaymE43bmLhl90duWNRO8K11wC8UMhZrFRDZWCqEsMzXfGNwCRHxW/S4phufiqgCGH9nyOe8S8Wr67Q90zUDpVd/MgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvLYlPXB/XPBNYdVJiY/FjuuoysLSHF1K5pXP4hYsp8=;
 b=b/m126DFUvpcV4ZcaW12IA5AF4tIdsFDp7eM0T8F/rvSqz16ZMvlGOqo4k6MEyYjFPPgU3DBVd5P8J10XRRd0HaZ92MPRZEmJHmHULZHHO4LK0rV3I3Vg+8+w8Oqe8hFU289CRzsi2Ti0rdmHMN0k5BC/iNEiRULguAUsNaKWVu6k9QlXfeOL0WGQ7k3fIMwo3vc2rqVFPR7hGAkM0FeoqX06vujEkre1mV7Zc8LXlbPuG40XVid4lrvZNNwvzIxijCPZNmLd3L5T/BsmaoYbwaKpyUq916x8LbKgbxVO1kSOXXXuzhnLD0aYVoRnYu8QQFmR+ZSMixQQY7wefVCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvLYlPXB/XPBNYdVJiY/FjuuoysLSHF1K5pXP4hYsp8=;
 b=qNtuaJFzTvLcZjAIAPaqVn9VpPS/kyF8senRxAufvnJi9vJ8VRDOKq5AcTvRgMkeF9ztMHaINp9v2i0i41zsNjDljt2GRfirHrmvy3V23Fy43P4ivxMjk7mVuYVpXFh+agX35s9GFfcZuj0rkBAbtDd+O/yLpixeuKvmEq8sscs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 17:53:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:53:03 +0000
Date:   Tue, 23 May 2023 13:53:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 04/10] maple_tree: Simplify mas_is_span_wr()
Message-ID: <20230523175301.6i2rgr2stcts6szw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0071.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dca9eaa-28e4-411c-5460-08db5bb68e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ke9qQ3QtAMD6U5lPixlHVgHOlG7HPr8HtiJ8xoDmNOVnqTQTMTuragFGJ6y6gUNhwtWJVMCuuEQUDmRClK7fddGdaWyvfJ1DDyTKoOv4iTd4grlnHbHv8gooAFjthUChBjforf4eFd9o5nFAH6ay7CBXvSjGM9qjq7ozpygmY/DxdT+JcnjVY5S2Lo1mOkEsAq7rfib1bp2xG6zrt+3/WsBSTYbdMCDGqoShkuaGySh1HPo1ZL1BlZgLc415HhQIaNUKo1wDH2z5XOOcrgSiQvXMxEX4IyOw6MVkXpGoD+CSL82FAQzFihYTRGVnQ+G7cW9yNIUUlG9Rss8d5coEboZdx5xK8JZOWaEsbjGhrUV8/MYbq5t9H5qfBcTgXNhzqmYeVRj2bdC8UurtmotR6dueL8tIsivSC+4+QDzdtRPb3qCig3mHol77FwOeTI+zLM7s0ymVh85zGMqNra4ke5l4/EPIHW4nhx8LQtAVLjKEaND8+loHqmCbLVV6Eis6zjPQ2a7LHvERNqA89vsADhLQjtKR9MDTjtYml5T09GVJQhbXctrPQOTCxfFYvQa/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(478600001)(33716001)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(41300700001)(316002)(5660300002)(8676002)(8936002)(86362001)(38100700002)(9686003)(1076003)(6506007)(6512007)(26005)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kv4ouOhGk1EfVJfdklMt48uN5vRXm0LdQj24C0UUnsoDm0+jlke5CDL7FDE5?=
 =?us-ascii?Q?omhAFcvOaYGicZsz7guKglLiW1gMZPZximLWEifDfpyWZEmUvD8mHBI0nGsJ?=
 =?us-ascii?Q?xIfYNiL2ArICL2LadQB4GsoSqTh6wQErYMNS5PUfzuU4jeBtxhJ1MjrH5eJw?=
 =?us-ascii?Q?srHmwwyjOoVZ+QMDK/jaqoD+j90gg/QUil2XiTDjkB/nHbupztzGaddMNTKR?=
 =?us-ascii?Q?Ya+qQqQImw+NL2+/AwczI4mGbAGX+KO9xW6rTEuU4t11GX7vTODm6SYUIuyv?=
 =?us-ascii?Q?+EIq8QeC3aVBvziUE5bZKc/vKnGa4XS4hGcWnXy6Q3jxmZOIBsImceRMVMs8?=
 =?us-ascii?Q?sumFi+LUFOjTuHjvZliwZ5LAZ1Jgsr/lC8IYK7G9GDjerxu0cNnTUd9Kpuoz?=
 =?us-ascii?Q?gIwoOSldG8IpE4oOd6d7vA4m+gObn84jbrpB+7B+mKMjSOB7BwNQzCuBpuxn?=
 =?us-ascii?Q?zAAEf3YZlU1Cpvsi8vJablt9lYyhpTS31yHuSWOZW1cePo1dGZAXdB+5utXQ?=
 =?us-ascii?Q?2P/qxG03yrqxx7fuWB2Von0VOZNQxVVMZ1txzc3lekFo52hn+sH+u3KUjU5Y?=
 =?us-ascii?Q?Q/w+xYjapNE5eBhEhhmZnbF2v/iFzzHwk56242yaMVmy7OhVWTtoh9V8r9HR?=
 =?us-ascii?Q?bbjjSEIY9tSrjxHTEwEvgg56M93PPC8E/mEJ9DKABd6mPwHzdE3ox/NEYx0c?=
 =?us-ascii?Q?lY6Q+COs/fsg1tHwyQUjSpOmY2SpnNa6Ne8bkqj2+65qKHf8MycuP32ozKMz?=
 =?us-ascii?Q?Q5wxOvDPVoKaZJ9UF1KhDuYULisWfYdUhGyrZB5VnjEl8DbR+Jc0iqJ5wipr?=
 =?us-ascii?Q?GoZ9Gxo402STUvFoXHuUq3CjQCdlznRSqEDJV1WJ7HYXV6Hrq0EGP3VgQ3UL?=
 =?us-ascii?Q?tjm/R53F3kQEKIojpXhm4JICzSPS0Ul/Q4gUUEjnXYoTtdlFQgiCTW5Rv32t?=
 =?us-ascii?Q?do3Uv764TV5DJ5x7xcIVwk2RKa8vcPl/0iV5e8NkT+ZsIn6VrpJj1Gx1iLEH?=
 =?us-ascii?Q?aJvo4wAZqEASvpinfw19HykUTgU8p2zNolY6qzHZGFP40cbZXdMlMALiw059?=
 =?us-ascii?Q?2GiKDW//7PJYW3v1c3nwWDxnl3kp2Gk7XTJlkd30mbj7JMw+PHnUsxFQiPGL?=
 =?us-ascii?Q?u8FHyDLxIKHE6TG7rbcHU1raDMMWqqx5N3NC4vFvZMfq/JjNFw81NMEXkMQI?=
 =?us-ascii?Q?pUtTwcWrb3REsJ5fBkst0A6lezvBv1D8xXp7rAFfuT+xXKBoeQK8+cvIz5mu?=
 =?us-ascii?Q?POHN/xUrGuywu8oulaKw5Zr0dxKoKs7CjmkopcB02IysLC4WxaGlAjIKs21v?=
 =?us-ascii?Q?tcDe+CE9GrJ9R0QjvJ9+0Og905zpQzfYKIWrIpkHcsesxJ7/I051yVvtz7vP?=
 =?us-ascii?Q?slQoLCS2WX8smvndRV0ULdjg5V39vdHMDMd19q1ERyn4p/eHcdg6nJmb0L3n?=
 =?us-ascii?Q?nQ+5uyOwMrKXUHPJXDxzfQP1/WYRkHR4B2wBnEJQcrMvmlt4/r06/UeEIP+L?=
 =?us-ascii?Q?J1pEEF2c9Am9lyT6c4kZDczW+KPyKOFQuCxM6Teo+qmkkWrpbe4lsKsOPcFF?=
 =?us-ascii?Q?ec85S4iY1wZL/4Mw0EW1wBMxQZgA7Qk5iACTB9q7LH5QGCsd/7beJTyutgEG?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8oOMBg3zwNsxy4dF5ovsbbiZ/DvQndGY07qacEfs4/DlV3Jd1EjDAh81jag8?=
 =?us-ascii?Q?mFIYl5+vmDIxKDRPTuWi8MOpcVnh3fbPNltsElNEqmwZh5j4M8WeNZ3gha4p?=
 =?us-ascii?Q?xobohSZAWtjy0ln9dcR1alTKzezCDRyzoUZjwVuNcPf03ZUThk40U+q4a0yO?=
 =?us-ascii?Q?CK2uYDpiXeO7HgtKTyLcNU0vd5Y1+ZvPqHRpjZL+EjURnXgLso7AYsFFFPLB?=
 =?us-ascii?Q?e27sIYiEje3gJgzvVdzTb7KDXvoMGRQksmR3Y0K0Ziw5koo8KM4oeFV75meB?=
 =?us-ascii?Q?6KFoulY70pzY3j7LL71tT827/DdPtL/dUlK++qJdvgcNgWGAqpSoPuGx2EEP?=
 =?us-ascii?Q?8I9Aj6qvhT7Dfd+pDf+N55AP7iLwCrMOUJrpU1eGaSBB5wQ/sPeSUETCgllG?=
 =?us-ascii?Q?M6NZd5Q5HEJUsLtKGmlJzQogfQKOGcQ5F2b7+3dAuIMMOdtiW0+SzX/Pu6VA?=
 =?us-ascii?Q?fcWpRPOmBeMjqBcY4r1fmaeaSixye41eMDWTaI5Y+kkG/cxuAg5Wcuim264I?=
 =?us-ascii?Q?nTbLK+6EyStKexrTY5+CkKOGaFCg8rI2ZtctwSI71ngl1Iz4+Y079a2guzEt?=
 =?us-ascii?Q?bzDuQw6MkbBDNDHl2Mo0CjDUg8ED8L6vz3VlIa/q6tnzA+Voo4ioV2EiDrf8?=
 =?us-ascii?Q?vvD8JjcMUePO3mzyIEMV2gWFr0ak6g/RffV/zyGY/1A2NimLZ2lxgdToPPWU?=
 =?us-ascii?Q?far2YNqFyDI4mMSVdq3KlCDWlFrV9ZtUnTCaEJqm7+wLI89sI/MA54OHDpNu?=
 =?us-ascii?Q?LDhgFIZDYuAzjghGzSJp0r2qupAy8gmCjpGpgiiSf6f6SVTd8mwWt73MLdnX?=
 =?us-ascii?Q?OktPpbvqpbWWVMFJPPFyRkMJW7GKL+NoQ1itpSLAeBi7fS9VmdlgRB24t52l?=
 =?us-ascii?Q?SmoIbWO/XBhQqCPiPWu++qK5MxdFb+wk/5PNUq8FxTVn3hhCd76yNVEQ4aU3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dca9eaa-28e4-411c-5460-08db5bb68e94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:53:03.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VyTDpc1C99SMfhcI7wfN6ZfKsE+gi6PMUcvhhUxBUaznA2wdPqYSDOrjMZ+CqU4zS+riaA/n/XTrXX90AyBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=556 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230143
X-Proofpoint-ORIG-GUID: Q-65WywzgRebIR7HqujQW9IJqdopn5nu
X-Proofpoint-GUID: Q-65WywzgRebIR7HqujQW9IJqdopn5nu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Make the code for detecting spanning writes more concise.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3fe6a6685384..c47af84047a4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3728,43 +3728,32 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
>   */
>  static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
>  {
> -	unsigned long max;
> +	unsigned long max = wr_mas->r_max;
>  	unsigned long last = wr_mas->mas->last;
> -	unsigned long piv = wr_mas->r_max;
>  	enum maple_type type = wr_mas->type;
>  	void *entry = wr_mas->entry;
>  
> -	/* Contained in this pivot */
> -	if (piv > last)
> +	/* Contained in this pivot, fast path */
> +	if (last < max)
>  		return false;
>  
> -	max = wr_mas->mas->max;
> -	if (unlikely(ma_is_leaf(type))) {
> -		/* Fits in the node, but may span slots. */
> +	if (ma_is_leaf(type)) {
> +		max = wr_mas->mas->max;
>  		if (last < max)
>  			return false;
> +	}
>  
> -		/* Writes to the end of the node but not null. */
> -		if ((last == max) && entry)
> -			return false;
> -
> +	if (last == max) {
>  		/*
> -		 * Writing ULONG_MAX is not a spanning write regardless of the
> -		 * value being written as long as the range fits in the node.
> +		 * The last entry of leaf node cannot be NULL unless it is the
> +		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
> +		 * If this is not leaf node, detect spanning store wr walk.

The last part of this comment should be dropped now.

This patch looks good besides that comment.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>  		 */
> -		if ((last == ULONG_MAX) && (last == max))
> -			return false;
> -	} else if (piv == last) {
> -		if (entry)
> -			return false;
> -
> -		/* Detect spanning store wr walk */
> -		if (last == ULONG_MAX)
> +		if (entry || last == ULONG_MAX)
>  			return false;
>  	}
>  
> -	trace_ma_write(__func__, wr_mas->mas, piv, entry);
> -
> +	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
>  	return true;
>  }
>  
> -- 
> 2.20.1
> 
> 
