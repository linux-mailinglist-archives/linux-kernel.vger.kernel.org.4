Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872DB708416
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjEROl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjEROlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:41:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28A110
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:41:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6Ir2K012414;
        Thu, 18 May 2023 14:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JKQyuemN/QjFVlTJvvWiT6i9cgw/AmjoOxjS0XsVQcI=;
 b=pafEPz71qdWuxyBvI8K0OEnDeb6lDZ1zraUkAZb79CMwHx55IF8IaRqkZuSw2EY8SzE6
 e4FUeWYxxc2MIUJJ3s8AcEIPXiFK9NWGNbSvxP1Rg+6p7FlEJhngEtj3iprblo2kFvSR
 sMiAI/ybpXkU+N2fFFsgvCd1V0AUtpCr/LMQBuWNz8pvLWOjKC5i2v+jkQkszJ34zpef
 B64HY2ANV1d2iqMJjQl8areAUwDA5bErm351m8P7y1beIkaogQozHKkO7rIyPR99lUSR
 bgs9BD4Txa9Gn7rnx6zQQA66AElwEoDyAEnLLo4HLBuaYl5o/cdE7Z8mJAb2w3cuyIWo sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjq31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:40:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDV503032131;
        Thu, 18 May 2023 14:40:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cw4dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faqK8SVJCmtmeyolCSuVXBl0WR41IlpARhyw8aqkH31mFkkcXvBQWbRO+zUVGy9ODx52LRtRvx4qEA0xW/2JCEHGtre42aXwlUUwkls7L56cpnc4nGIJuZb/8W4+ClmMeDzqP+CHM5w02Be4N+IJh/nbRGkVdq8FmUqSATAEAxQIsmAP6qa6BBW2kqbl7hhY59ei57SEVUHfdi9rExpAMpmtxXxtWukqvctHIoWrcd5qpMp6K3g0OUgh3mkvI9B0oCNrekdmtvJRG9iXSioKMj/MHhTqwqyeEnsysP96f9LOQKbNVSwur/uYELL5DM+YJmAm/z89dHoF1zOC3isfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKQyuemN/QjFVlTJvvWiT6i9cgw/AmjoOxjS0XsVQcI=;
 b=Np6CJMTrq1OSIjjO2tSDcnxvEglnEhhBgTA3N6pmSOYNtVNepDmJ8gjd2b9AFqCf084FZRSPB6d/ou4PuhGebo/dByybYXFd+RPUV1RocsUOHtifCh4iWZDXlaTTpchLvJP8t0D74TrSNMf/9cJbfNKZcnqptS5hXOTzi4B3QvYWFfmWrMctPqaBewg084yezM/HKyJ6FQ2t37BNnqs7pRg2YiWygVrH4bn1y1jLNB+WjiILFghqLZZw01L+EbAUaLQ3VZzMQxnOW0Y9PB3i8ER14AQIZB5rOII6Z3Z1gQ/3FQ1di/MEuV0PRfqbcc+gjxJOuhI5lgYq/lVr2P6Kbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKQyuemN/QjFVlTJvvWiT6i9cgw/AmjoOxjS0XsVQcI=;
 b=Id3djTFTU681N7wwoiOVpUSRkoPgn1Vp03XpWRtyYu/YLhBbaeQ/YHkG2NvYuGmpxgF2qHjjqoHnvc/PLWySp+ypfqLwHWHd8W8qWIM/V0YlNVlPqIQi7RK8n71F4yRC2mzAOupDAOIhSdzYYRsRzTCuu8TY0e6vdoXYeOyIEh0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 14:40:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:40:56 +0000
Date:   Thu, 18 May 2023 10:40:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <20230518144052.xkj6vmddccq4v66b@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
 <20230424223419.6n2z72mocgmcj3aw@revolver>
 <ZEcMhOywwzsc6CN5@google.com>
 <20230425014328.d6vvimziv6je5xdg@revolver>
 <ZEmU8ULSEQhDVyX+@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmU8ULSEQhDVyX+@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 78388b83-7f2f-4655-cd32-08db57ade376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrKgVhZRwb9JQuoOnQt47ZuwmwQEtLsZEx1/zclZbu1+OIWsaWMaR0IXkxUQKkK5Vz/AohVgc5wl8n04zPYZIYbZ2L20K5zQZvaF3u266Lv+udFUoP6NbntEKimkbK9D5fu5oM8J+4BemBwctY2zAvU6TcdTx2iXpLslTYMr40ZuMJknXi6nG+S3KVJmiCNHTnGfeamPGbkS6gG5EAn7+Crdn8Rag99GOOlK1TyPqII4T4XySDRmYQ+m0TW7x5IFdxGYyLvPEtv6P0Fe3+P+5vTuwuzQHRKz8XvRJpD+crDq5qmUeiqytrzoyaLNDi3T7a44L5YGLZ+SpATRnOSEsEwtZgxwPX06R2IR62Qte6rImE1ZkOOqxlsWocZsDwxoi9iKrv+sftDYMWqHNPZjh6BNtmTpHh+MSuU7A9u/J03H351dt1noRjYkSFwJZmA1+aK7xdcVWNhbH7v7Ujx6a2RMAGb555yNUc2sNrvLr0iKXKWU4/RjlpDygr3yRDwiK1u6XQFe796iLlDea3/i3EzLBcyv26VktvvusWjN3NroTYfE/GQb/d3u53Cp7aygB6Yfk04FgXTrmKl1enYtzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(41300700001)(86362001)(316002)(54906003)(33716001)(7416002)(38100700002)(5660300002)(478600001)(2906002)(66476007)(4326008)(6916009)(8676002)(66946007)(8936002)(66556008)(966005)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJtRn//drIHPwExKA2Lcj41G1y2w6Xvq4AAlif5NIn0JTb5HxXQrbg9eMpRA?=
 =?us-ascii?Q?S8BLTOdFvPfd0qFcAKZ/iq2Z2ytrnaXaFo4+k/O0pLi/NrP7lKzsEI/oLcxp?=
 =?us-ascii?Q?IyDM1MkGHWWW4qX1XMglSWNoGbkGLHlNeO3SU0gftoSXZ1i/j2OKx10khQ6m?=
 =?us-ascii?Q?TLOFoRAL25BddzzwsPb+gf7y/3K+KPyvEQ6VCRLgahzgtvL+RKt0OHye/qRP?=
 =?us-ascii?Q?dVlW6hA/3Y3zcD0gzCPOSkXlv9/m+tudNgm0O4uJfp8RutGZUq1ZloE57y4l?=
 =?us-ascii?Q?Pap3daHolwhbeDnYBCDUq6Lwkk0v/P3qJdqbF7ZUSuBmZjoTT0FnjCezwMhj?=
 =?us-ascii?Q?HeCBtxXkXAbgD8jbngSnawtdZM6XgA+jUNXoPMJiIIFff9yKbrd47nBLqP1y?=
 =?us-ascii?Q?lGzJk/l8uUJhlPl81LgTeq1qAuEkqnBgXCVL4H8QJwq9HF/1TS4qqVvn3aU/?=
 =?us-ascii?Q?6uOaJ0gnCsc/8XgdEaHKbIlKhY1fjEvRDhzcIVxfvqEvrIqf5JyBa5zkh7Vh?=
 =?us-ascii?Q?1sxG8NLnxjgE+gr3I7pEGRh90XQFKW5jnUqZ7TEOnIcMZAW4j39YRIeVtZje?=
 =?us-ascii?Q?ew9l7CmNJiZszVXhS865+joENE5sbE0v3Q0YyaaOnwCuXhoDIOOYB/Xks/PZ?=
 =?us-ascii?Q?OrF34tUvzU17jKptgupcjpKkQ5Y2oMFfBxg1NvwJGhxrASmCmEcrlWobZeEl?=
 =?us-ascii?Q?VkJz+Uts64uo3jdvECs8ysEMbw8HNtX4OuV/8JzwHq98XauaxUT3ge6SjQcX?=
 =?us-ascii?Q?QTpNRFf0yvDdXMVfwKbJdz/o6l143Mn5EeFu0lZSCf98cF6G3hU9ohOgB8XJ?=
 =?us-ascii?Q?ZSiL/NXzgTDEdZxinbbSb/erFp6fMGtkz3xEtvpRULukWY1s/G0Or5PLHmiF?=
 =?us-ascii?Q?9iJXQJpFVpWUhCwyABDHElHgOHmGlAhKbR4NTDJFG2LTICq1Gk99qj8Rlpqd?=
 =?us-ascii?Q?37Vs6EycpoTYxUKvlUfBwrrWQU0XiiL/BQLIBt+etGMV4h5su40WHEPOA8DG?=
 =?us-ascii?Q?prVP54wO/69WUqW90HSmeAilzGrmKsdsc1qONtdm1ifNPo0eHIPexhS9hbXs?=
 =?us-ascii?Q?AMU9UK9+xkgYouu8gEMcTjDsZSD7PNkyKF4zRNm1wmKnrqFeXHzmNTrK6OlX?=
 =?us-ascii?Q?5C7OX+qdvSwvy0fWZpf9YpX6AvfbeKApSgzYcSJBCnEklpDysMQhwFXsErW+?=
 =?us-ascii?Q?xHgDWaXm0/1mLYygWhxpn7xReDvmUT6hGdpNXodxgzp7Mt4xqqQ/ZVKPFr1L?=
 =?us-ascii?Q?jPhNgrHm6TD3LZn75bOpKhXpNbmELDsuaf+Xm7fbVUUNWMsbiKuYzFo4HMgX?=
 =?us-ascii?Q?CERYOFcQl8XNdCJr4+o036+lCIvEepRBwU9TORcb5og2MUCKJTVvFm9nJEcX?=
 =?us-ascii?Q?wzMKXxGwpSSZlbp0rOAnz8QALgjDPy8NmW0LxhPq/RroVut/jzcMO6ZpagW5?=
 =?us-ascii?Q?z3wa9zf8Y3jjKDOUWi1ngp/AdlgebYQxnYjx6uVWebVLtU65NBaOppl0kmL/?=
 =?us-ascii?Q?do+7bZl7r6miWFUZm2NRjUPggYRc8rOemM3iQKXw93EQ7o/iIXdLoAqG51bb?=
 =?us-ascii?Q?pyknWU/ISSQaLHvJZzQTGNu9JjgGR7XI7vNoCb0R2bWh+/B5DQz5GkIp3imO?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XYALuExDJBI86YwzBvNaGemvWHXnn9anYj7R1Qhf+KWQ0AU3xiQV+3cg09NH?=
 =?us-ascii?Q?V1QcPr4Q/UpEtWdspRK1ISzHDFjfB8kPLYvW7J8WVANmAMamN7A1srqvmbkL?=
 =?us-ascii?Q?BviKAoYyedWTsr2L9Yxw+dw1E+DFZJQwiE3S4gu28Nw1rTDAEu0UqpP4MDWP?=
 =?us-ascii?Q?Wqfqc5drMVhvWsunF1+k07lI//AU/DLw/b2pojgx4aI08tvyhan+LI5Ts1N5?=
 =?us-ascii?Q?1nqduZydFMEALSeOwUS+lCEJqDqlz1cEf6TEzTFpSj5twz0PR9Coby/2AlT9?=
 =?us-ascii?Q?ODAgqNc6marGGEG5RDRH2tv4N47mUAxzwcC62iYxZ+pDNVkZHP9EdNkppSC3?=
 =?us-ascii?Q?DJFlVPiMFl7tuUo275xGJ7WQenIBgVMXtUWMRBu8AEgvODk47eIRJQwAMjmj?=
 =?us-ascii?Q?nrhoImKPuzhpLAshlw21VhGNUAihpTOIJVlgz/zNDT/KGNpo7ySYv4GR7+9I?=
 =?us-ascii?Q?8V9PfrlmXzJWYvZSG0zgYmuM0hkBbiIU4G5/80wUgue/Ig+FywBT9T9qYa8X?=
 =?us-ascii?Q?paZl7HJXHGqcbmdSW7H+veOUURd1FSTH11GQZVvpFqdAOM3LQWektEUwObQ0?=
 =?us-ascii?Q?xt43zcjxccruDsv5ncXvb1YBXTgm3WkRJ37thluO7b4oBy/mcPAOyByDg7y2?=
 =?us-ascii?Q?7AUb2+/XW8IEVMWgaCNMsYxONAqqfMizoas7vIKPyAc3MTywkdQRrmYuDK8P?=
 =?us-ascii?Q?EYeXDswrv8PDFsG4RKe3RXk8n+Xm1xaMYnn8Kw33tizYZgmOVe4ToKrv1N1v?=
 =?us-ascii?Q?5SHlLSoTUA0h67dI1QN7k11hAhrewW5ZLUYO4WI8o4ffJTIG8wYjdBI91t2+?=
 =?us-ascii?Q?kBtU0kGoepwL8BGICgBnoIWgiBAiYQBBUv+G4aydiw0LT4So4m9EeB/36XLI?=
 =?us-ascii?Q?rhjqJfYqi+sAiHIK2laA2n8ccYJKochFWFD3Ax+ErOdYThSGQ6hQOlNknwhv?=
 =?us-ascii?Q?9PkOWNox83MPzDV8H+msc1ipGp7Tbw/h3xT9HPemyrE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78388b83-7f2f-4655-cd32-08db57ade376
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:40:56.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcCc7LWCdD68vlHEM3EiHcqr6W9qthWjyGKUqPb7Ys/lYJwegqQ8hF2Y/YLe+tFmJ6o3NBOlZYzNyQ4UB3ZL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180118
X-Proofpoint-GUID: TxxDJpqc7HY10c78et6MpUgqQXcZq0_C
X-Proofpoint-ORIG-GUID: TxxDJpqc7HY10c78et6MpUgqQXcZq0_C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [230426 17:17]:
> On Mon, Apr 24, 2023 at 09:43:28PM -0400, Liam R. Howlett wrote:
> > * Carlos Llamas <cmllamas@google.com> [230424 19:11]:
> > > 
> > > The specifics are in the third patch of this patchset but the gist of it
> > > is that during ->mmap() handler, binder will complete the initialization
> > > of the binder_alloc structure. With the last step of this process being
> > > the caching of the vma pointer. Since the ordering is protected with a
> > > barrier we can then check alloc->vma to determine if the initialization
> > > has been completed.
> > > 
> > > Since this check is part of the critical path for every single binder
> > > transaction, the performance plummeted when we started contending for
> > > the mmap_lock. In this particular case, binder doesn't actually use the
> > > vma.
> > 
> > So why does binder_update_page_range() take the mmap_read_lock then use
> > the cached vma in the reverted patch?
> > 
> > If you want to use it as a flag to see if the driver is initialized, why
> > not use the cached address != 0?
> > 
> > Or better yet,
> > 
> > >It only needs to know if the internal structure has been fully
> > > initialized and it is safe to use it.
> > 
> > This seems like a good reason to use your own rwsem.  This is,
> > essentially, rolling your own lock with
> > smp_store_release()/smp_load_acquire() and a pointer which should not be
> > cached.
> 
> We can't use an rwsem to protect the initialization. We already have an
> alloc->mutex which would be an option. However, using it under ->mmap()
> would only lead to dead-locks with the mmap_lock.
> 
> I agree with you that we could use some other flag instead of the vma
> pointer to signal the initialization. I've actually tried several times
> to come up with a scenario in which caching the vma pointer becomes an
> issue to stop doing this altogether. However, I can't find anything
> concrete.
> 
> I don't think the current solution in which we do all these unnecessary
> vma lookups is correct. Instead, I'm currently working on a redesign of
> this section in which binder stops to allocate/insert pages manually. We
> should be making use of the page-fault handler and let the infra handle
> all the work. The overall idea is here:
> https://lore.kernel.org/all/ZEGh4mliGHvyWIvo@google.com/
> 
> It's hard to make the case for just dropping the vma pointer after ~15
> years and take the performance hit without having an actual issue to
> support this idea. So I'll revert this for now and keep working on the
> page-fault solution.
> 

I came across this [1] when I was looking into something else and
thought I'd double back and make sure your fix for this UAF is also
included, since your revert will restore this bug.

I do still see the mmap_read_lock() in binder_update_page_range() vs the
required mmap_write_lock(), at least in my branch.

[1] https://lore.kernel.org/all/20221104175450.306810-1-cmllamas@google.com/

Thanks,
Liam
