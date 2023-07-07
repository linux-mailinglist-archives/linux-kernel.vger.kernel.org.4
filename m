Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33F74B527
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjGGQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGGQjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:39:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7942682
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:39:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367GRv5M004654;
        Fri, 7 Jul 2023 16:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=XXpLQDB3sdDXAD02ZHUU4rdwMk6xXpDtCYH64uoHs3o=;
 b=FYP2HexM2clCnRct0xV+nzOD/JKlOezvqA5V2JgBhj4qrSI2ZOytujNgG8hc+x3bCCFS
 +TcvddnB7ZHfFYSr6ood5VymvTCjntriSMtnLFhIxsvg2j9LNhvjJmL1uRpC5uNNDujV
 79xerpfDHO26Xsub/5hzpDMvev7rTQcoSTMkN2V2TfvkBrqFkuJbC2ysWi1rad+2PDIv
 QopA16YPaPwjJUpGa145hT3N+p1B2gjy3SQH95jwJqp4AO5XIaIEn1rlqDA6n+xVqMex
 VhnZWvUzh4XnqGQpPO9LMRejnVcBjVhpe7Yl8663CxDupcK19gguMRxuXM/qElIVpFVz Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpk6ugf4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 16:38:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FWswf001661;
        Fri, 7 Jul 2023 16:38:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakeng45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 16:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA7QPF1y7mMI8I1AIJLj+jDe81sVX1I9krcttgSLd0ln2Weqy8CjKjMPv2T9tkqelySpo9mGbdp8SIreh0LBIcm8ocnf9+3vDLhurg06ZSupM19pUSlI3R+7Fi9u1dOXiBsQ527z1FmITgdcM61JiNs2X6+zR5jICxdDrwONCOXzrrtUwMhLxLdTP+GJC5obzTSgVSHvzPkZ8arhl+2wlgcnGKQ2LmhF3/gTMI1+WO4Qmy7gLYUhlczfuYvdrMC71wK1pDSA7LgXgsY7QO2PTAjZvrPepoBj1czNs6WRtsneQsvM9RvUEfCfKY/3iSe3xIkUXS9DpiDLfZzQrTGxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXpLQDB3sdDXAD02ZHUU4rdwMk6xXpDtCYH64uoHs3o=;
 b=QkG0PRh/UOaWr/14r9hWV9iZoielHuG3NylKTJbGppKFHHqIpuKMOGqzU6+Su+C0FTiqz3CNUvb57u3qUQJSJlXXx5wfnUFOBdGLZ2ItKNgDV7KbpRADv+s+15qnTo5yFe4dWcGo3e7Z1203jWHJbkO2Cy1kaH8Gi/R3NvKCj7YsdkOj8x3SPPurysk+3wtjnrgqkEboNTyHKlgg8mE1rA08lP9Cg/+EqK2I3ZMQ7KKmqFSOYEb/8CQIzXQh/wygLXSjQRq1E3luKNhcixXe5guR6Za86AOZ0rHC6lpR0V6ppJHcc98xcTsOki5p0zJLxuAyWfus4i1GAWyvX6OLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXpLQDB3sdDXAD02ZHUU4rdwMk6xXpDtCYH64uoHs3o=;
 b=a4c1AY8kr5ttAINk//OXym45R0UJdRzw27XMhDATv8WM7t1BTEYOLJornJKXBlwJ6WfkcPkWWArifwwz4Q6K2uH2zb3DjxkNh+7swboyXBf1iiXssdWdYvIGRSz2bD2Z2M65K/8IfMZuQXZyPXfh/2oiPlGtM1LWCrq9y/bTV50=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:38:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 16:38:18 +0000
Date:   Fri, 7 Jul 2023 12:38:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Danilo Krummrich <dakr@redhat.com>
Subject: Maple Tree Work
Message-ID: <20230707163815.ns4kdz7iut5octjv@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 8877ab39-1e85-4878-3a34-08db7f08917c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0VWVUuNmY6q+e3lsoOcpesQ/eeU9kqbUFRF5WMFFWNFhi4wqZHcn05nzbh1OktDaXCTwKqiiagKx/QN8aDHQjuC1c2QYuDXHzT7D9r4nEaPZ+HVQ5eHus+qjwHj2SvBCC9rMCdMId0cCIl+7BU6rd8Q0wEgXX8U/iIdOLVDVCRh4MBMFyIgt2yD6X+NSnlSfC2KADGncuF7cYdUNf6ojTSnd5iGQFM6U/ky+9TLlHcZ2gkBuMmlQYVpBIxOp1nT6OZXHfl/+pAA4cQv++6aEzoHu0OpLv4keH/Jh3IoxtEDnB5JztV2GmjXmGu0OlBQxz9bBmkA9vsEj5xMEMiUhBfriYny+XjRk0yYMrqhvw3RaT5bgif4DNR1ENqF+9P8hWvqpGNAVA8pwDIMCTcQpHltlWikw5hp9sBklZ/8DAA2kS4QFGIdgPrzCYivvIGi6JUwCuhN9RdH1b04m2/RUg1vNCs3VDwuQBfW40kIrdaNxxIIhGkJ733K0gzONM0LytQZE2/GlO0H/2WF3QMeR9kNVXV3vagJ27Xryz1NWsGrogjRH0YzWkIWyaQiSYmYE4XPnTs87fmfS40lVbrAzRYoENI+5zN3xGb9I0ww86qhu2ra6J+POLBVU1HFjgzhhS6e6NwQn6gN6tVzmNeuOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(478600001)(6486002)(54906003)(66946007)(186003)(9686003)(26005)(966005)(6512007)(33716001)(2906002)(66556008)(1076003)(7116003)(66476007)(41300700001)(4326008)(316002)(8936002)(8676002)(83380400001)(38100700002)(5660300002)(86362001)(6506007)(3480700007)(533714005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uF0Fw6gW27AcvwzXwqKbAkHmJdNSok5F7B5MNvj0+3VfwxM47X7y6ccdsdAa?=
 =?us-ascii?Q?stlsa7V2ZQwzaazI80/e0oaHkRS8yBbfe5rj7COxXE63KPqO6P82gUvARYja?=
 =?us-ascii?Q?wC3M2wwgEue7b+Q18qs8DRzH5dbQ7aqUOfGGCfZpMqhjE5GMvkASV7kP87z3?=
 =?us-ascii?Q?Ta+g9ybVBhsP09lB02lbBIuIm0goBXGG2Tzgwcn7wyDRNGuf08TcCj6c0Eq3?=
 =?us-ascii?Q?VyMohapzz0VvZwJ27OajF4NdhzLubtQk1x/hvzcKEaWMLe0BWK05tNUHqcIH?=
 =?us-ascii?Q?dfx26mKtCkark4CXE2thYHEchTztDC/QQh3SUge+jQUTW2yj7H6CTUJ/6Wku?=
 =?us-ascii?Q?iwPb5cBp9vkRnW4Px0buNBmMnozhVOye5o8F+IprN1EF+4HjjXbyj16/VA5S?=
 =?us-ascii?Q?ctkIPgXeUhbMX4kFgDij8Bauwtg9peLtWL5lhZI/IVIkSGmSHl/18PRPABDf?=
 =?us-ascii?Q?TK1kU3KZSh8EpWT+stotFGoznYN639nccFB6rHZ8neVs5DmKusMM3oIy54Tk?=
 =?us-ascii?Q?cUHUz1zxmT6O8GjT9uOiKGUiwhml1BQUAypAwLJZOjoOINGvLBgJkumoDPXf?=
 =?us-ascii?Q?KYYfL8XeN+rjHSHqDMBDgARwYJdkkSxILCcA5Fjf1PbGMk37PMa4LdO215TW?=
 =?us-ascii?Q?fYStVlwGVsAabSF3Fj8PTB0PxxnsDgQfCL+qrqhZrB09PamuqaEazMrY+ZK5?=
 =?us-ascii?Q?Lh5o/pRuU1ke1e7p+G+f/MhxAEK5PbDZ6GqtAWqNhI3xbqW0ILoqhoAFaRJg?=
 =?us-ascii?Q?4EMvWsqroTCdRP9MhKHzFl6P/wFBx8ZEupyjr1N8lb4HetgWMFqOUDEj9h0S?=
 =?us-ascii?Q?dCw7GhMT5GDwCkKTsT4h0YUSSJBF0H69jsvLvqF03/EwChcz719++B3inRUb?=
 =?us-ascii?Q?sxi3eCR76E9xjIAebzEL+5SqV2n7CKcPWPHJSt/5R1GvyJvBNUjvoUEREGV3?=
 =?us-ascii?Q?seMExMyDPfR056v8K3ABVhIHB9nOJ4Tqum19CjtG6GcLFKOCy0L74mJp5v/A?=
 =?us-ascii?Q?4UEXe9e1AHXuN3uCk9goDLeX3zPAflsq+tkPNaOfib4pY/7ynjgNsXuoD6sU?=
 =?us-ascii?Q?z1b/f2TcJMec2Z1eGiPi/NNJ+fw+6j2HXLejhqIgE/hiEPX3QgCnO9BVKKbX?=
 =?us-ascii?Q?GCexCNYrWd3ejHctmj0fQSceXMA62ALIDYOSSfNpMb4ha4f1nxg/yH17s/zE?=
 =?us-ascii?Q?ldkWFuEAOTkF4NUhW4KxSs0SYbqi5TK4cAaRD0/bP3YoI03DRjdpP8/sI0Je?=
 =?us-ascii?Q?DroFuzuTZ1C1ryePdajUrNZwq83DtNNuyoVVDWX6oHw0hKJ4/hy6SlDKuRID?=
 =?us-ascii?Q?zphE0gKRw6JHmJst2a5e4brA5PXg1MiBZAfjSLuPKEVzHcUieRTNrndM4NKs?=
 =?us-ascii?Q?eyCf4bof+Ol1I99J0kcG0tLAbl0J1rV56xWehFN3Br71DnckV4V6/A2Sc0gT?=
 =?us-ascii?Q?8l7K5rzWRCy6vHB8Ac4ZL70oHWUD7ICDjoVhvg1mCcWRUHa1pZUHRgPUWaCd?=
 =?us-ascii?Q?X/4D0PhP+IibRsJAazOuKj37XeUu7cEpp8/KLS+ta0WefcUALJPBQtCddflc?=
 =?us-ascii?Q?n2QdDuvgsd9Pld8Wg+hnB5ffMWbM2JF9W0D+2qGTIDNjL+0kWch5W8na+rIy?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qJIX+/DXu5d1iaYQ328lAvePucVCB+p6sqMNv8QRmtVvmQpDbBi+4Q16lKSFGLTZs2dYhtZ5iRExJ/FnMX5FMSpvCUBbbUc8bvtD7grNcX1SZWXCie1qx+HEBI1PFdOOZU6+N1EgXJdemF/W2tS03HvImqqa4oXhEeM7FXvHaX2fh38jSALG7nEr+WXO01uGqQEt8DTYd0WckzmI47Ra31PCOc0R63tvfdElUfUxaBOrFupWv06Xq3/hntBq9zQaL9v7R/BalDzTZUAWufqTFwlYVZP7xtZ6wGIxhSL1wqfIwxJcAE3tiwffrh35+Avc6UZ9ufsp3YIEp3SWpyZl2q8PUTbllPj8vjBL/XgD/m767ZP70Bh7M/rBygGkke0GMYZ8AcsjFeRrc2e4eNcBCB0MlavH/hHlNajhWFgt7SxgAH7hk04u9xX4RR1PGxdDLEssudCrRxI2Jkxl089smAfIcfFgX6IQqE8jGpUd8BXZ7OFWk4YcBPQBXRANzKurXamnHr6Gq6ziQuNvgJmUBoX4Q8FFCD1YVwMFhH1WH+C9wXBprxmdaisxSgogHYAHA0wZGtQCyred2U5fk9YyhkNR4zqnNJrSB5/2AAHhWtq5xsf5jvkpPKtCAQ5oTmsiY4aKxDsIUdETIiav5npOpgTffrBAvv08A73+b5Ql/gZzTy6fOLPcEfmIx/LQ6R+++PVj6hyZ6/yGUC38MQrY/DREytMt7yI2B59sbW8utvliiVdHGJ9mJDUJkj6nKBdya4sSM7NT9U2bTlL3FrWwkVx4eAoNdtrIxmgoGW3Eda5Q9GoRtSIjzUj/VWwNWaMHohtGwTVdAEihi7glcFeXD6QJPc/24Y7LUu+VgiPTYSS0mfxYiDAaTxUyVOWyXII4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8877ab39-1e85-4878-3a34-08db7f08917c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:38:18.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDUyPHpF7GRn+yVyfLJsROixaV993NPG4Fv69ucZhTzjXpUU9YNxw/gkyu9MV8K+Y92gsM6Nvh2ZH59ZFuLiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070154
X-Proofpoint-ORIG-GUID: B_lYOhnLVIBB1e0pJy_YVnwwVzbsR4yn
X-Proofpoint-GUID: B_lYOhnLVIBB1e0pJy_YVnwwVzbsR4yn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have received enquiries about the status of features for the maple
tree as well as requests for work.  I've decided to track this on the
maple tree mailing list [1] for better coordination and open discussion.

Please keep all discussions on the maple tree mailing list.

I'll send out an updated list monthly with names against people working
on them to avoid work duplication, so don't work on something with a
name next to it.

If you want to work on something then please respond to this email so
everyone knows and I can add your name to the item.  Feel free to ask
questions to clarify the feature or discuss directions.

Likewise, if you cannot work on anything anymore then let me know so
others can.

If you have any ideas, then please email the list.  We can discuss it
and I can add it to the list.

Please sign up to the maple tree mailing list [1] to get these emails.

Features:
 - Better preallocation calculations - Liam R. Howlett 2023/07/07
 	Without tracking the tree status on the walk down, we can
	partially walk down to figure out the type of write and which
	'worst case' a write will cause.  Using this "write type"
	information, the preallocations can be a better estimate. v2 was
	sent to the mailing list [2].

 - mas_store_gfp() align with mas_prealloc()
	Right now mas_store_gfp() is going to allocate once it figures
	out what to do and it does the worst case allocations.  This is
	inefficient and can easily be done better by doing more of what
	mas_prealloc()/mas_store_prealloc() does - or at least will be
	doing once the 'Better preallocation calculations' lands.

 - Tracking tree status on walks down
 	Track in the maple state when the last minimum nodes, space for
	2, or space for 3 slots occurred (height in the tree).  This
	will allow for a better estimate on how many nodes are needed
	for a write.  This can be complicated on next/prev walking, etc.
	It has to be done in read mode since some walk may have been
	done before deciding to write - see mmap_region(), for example.

 - Store type (enum for store type?)
	Extending the "Tracking tree status on walks down", the
	information can then be used to determine what operation is
	needed during a mas_prealloct(), etc.  The operation can then be
	stored in the maple state to continue on a mas_store_prealloc().
	Obviously, this would work out well if we have mas_store_gfp()
	using the same functionality as mentioned above.

 - Full count/flag & Dense nodes
 	There is a bit that exists in the pointer reserved to indicate
	there is no NULLs in the leaves below.  This feature is mainly
	for trees that are non-alloc trees.  We can then know there is
	at least one singleton that can be stored below this entry.
	This is coupled with restoring Dense nodes as a potential node
	type.  The tricky part is deciding on when to switch to dense
	nodes/back from dense nodes (all entries to dense nodes must be
	singletons!).  See mte_set_full(), mte_clear_full(),
	mte_has_null() which use MAPLE_ENODE_NULL.

 - Fork & Dup tree + Delete DONT_COPY
 	This is to optimize dup_mmap() in kernel/fork.c, but other
	users may want faster duplications of a tree.
	This should be faster than building a tree in bulk mode.  The
	idea is to just copy each node and replace the pointers in,
	probably, a BFS order.  Once the leaves are reached, the VMAs
	will be replaced by the copies made in fork, unless DONT_COPY is
	set, in which case the VMA will be deleted from the copied tree.
	DONT_COPY is not common and since the tree isn't visible, all
	nodes should be available for reuse (no RCU worries).

 - Push reuse parent
 	During an insert, new nodes can be "pushed" left or right -
	see mas_push_data().  On a left push, it may be possible to
	reuse the node by making the write like an 'append'.  This may
	also be possible to be done during a split operation when the
	write extends the last slot. This needs examining to ensure RCU
	safety.

Larger Features:
 - 64 bit stores on 32 bit arch
 	A number of users want to use the maple tree, but cannot because
	they need a storage medium that supports 64 bit stores on 32 bit
	arch.

 - wr_mas with alloc instead of mas
 	Internally, we have a write maple state, but the maple state
	currently holds the allocations.  I'm not sure if this is worth
	it, and it will probably need "Tracking tree status on walks
	down" so that preallocations/allocations can be accurate.

 - Big Dense Node Type
 	There are various node types that could be added to the maple
	tree.  One of the most useful is probably a 'big dense' with the
	node being a 4k block of singletons.  This would have to come
	after the dense node type as dense enables more users and helps
	scope this work.

 - Judy Array
	The Judy Array is another fancy data structure.  Mathieu
	Desnoyers has enquired and spoken to us about incorporating judy
	arrays as a node type or other features he has in the judy
	array.  This is in the early thought stages.

Please note that any new features will need test cases added to ensure
they function correctly.

[1] https://lists.infradead.org/mailman/listinfo/maple-tree
[2] http://lists.infradead.org/pipermail/maple-tree/2023-June/002599.html

