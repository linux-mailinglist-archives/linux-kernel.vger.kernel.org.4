Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD1744329
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjF3UZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjF3UZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:25:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81D44AC;
        Fri, 30 Jun 2023 13:24:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UIxSgu020497;
        Fri, 30 Jun 2023 20:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=GojUsqHa69LHOsVTRhddKZ00eY79UlSc1oWu/p8W0WQ=;
 b=SeGRBo8ygjxhaxcbYb3OVMdZcYIPCXcVIgSGYAktfI1Rll05Tfufl6EafFNMEp1M6Uac
 fzvU24fTuMk6oG2r0wNIhYN6YQRv2+auuFNIJyckZf0Q0R8sd3bn3VJ73cEwYLziwkyn
 D9jtx+3XyPkzzX9zsJrdUJb1COSZyO7PVTNc8HFrXOLIRaN4UPArH/GAgP1WcBN2W2xB
 vsZp18HanMJD18erb3WmbHbOm9YCBsPVNuUjrgF38kT5Rvonp22mmWSs9vxknYj8yHyk
 RyunPk7e9WSJddkPoCPFeucxtlmq1YPol5GgbXkgnzK991n+ohvoKxy7Teh75G7b6Am6 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40eg3rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:24:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJJP7f004046;
        Fri, 30 Jun 2023 20:24:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxfd436-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 20:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVIRK9ce10gBaRu03ptUN9Czd9u4T8U5+rLqmiVGmlBe83671hzkf49GS8rkiFZCjGRNtluT+1WFQBNozWE3nKOihmgzFKIaUFhMkW8rCch9ACvRcRCl6TMwmDESbQ8aPQ/Ywvc3FU54ht8sEr7zmEEPbJbrKDV4suXyC1G3jej91TvZzmpkBhkKBzMejVMAhehKKx4h5vwqUI8NVLePoz/cD+VgKvsKhkJbegygAURqiUgh8x96b9oeP9PNuAGM9PcZYvmeliWsmJH1ZYR9HUzdMtKQ6Hs8vrzaFBb7TzEQScGclYTXja6RGoYSKMpABNSzgAOKHJPxbevD9epmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GojUsqHa69LHOsVTRhddKZ00eY79UlSc1oWu/p8W0WQ=;
 b=fg5rA9q92VPjpktSpwPJHFlwgMTFSWt+eqXw8tSs7VZEQ0ZP8rQ3JkshP5yCUlec4U/ZBSUGNpsIBYpdVB9PjZ14hUJrSaIWdDeYvWEoZ8AhHJ+aRX6aTHrN3H2Y/Ix3OMGupAHk/GY5HyZpK6K4coIFX2C/cEqnvf1NQ2SXj3oMstPlT2WkGHWR5ApU8AVOhH+exoeOKuG2LeH0dbSgkpm1Jej/3eKJD/RFziLeYogOTiFWh5TwDkzp8mUdT9Zg/lsI+366Zr7ZGrWnjwL1MdncGRqDVeCXLGjMllcL6X3SZpTySqLWauBIl2xPscdcwXmwR5sRTi59PQc2O5dLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GojUsqHa69LHOsVTRhddKZ00eY79UlSc1oWu/p8W0WQ=;
 b=c56Z9mWTwRtsQ05i4VovLOfPTXOJzmgtWBCvhPEDaCpRD/PHt3QFZzdtWAOoQf1RWpKoYTdgAeHcudNTgyFP8PGcinh4wQfp6vHRZrTc/muD7x7bZLX+FwPr1aqOgG0vZkE+H6OqkzS/l7HM0OIDIWsI+rH22vrEERthAhh78ac=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 20:24:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::de2:4e3f:62c2:865b%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 20:24:24 +0000
Date:   Fri, 30 Jun 2023 16:24:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6 1/6] netlink: Reverse the patch which removed filtering
Message-ID: <20230630202422.vmstht7yyo2rhcsb@revolver>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-2-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614234129.3264175-2-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: b9189da1-ce0b-4da6-570e-08db79a7feb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3FhoAbwqJRAb7m3PXzZfdCiJuHBhDUUgRplMruU8MVT/8a0bgYzhn4Z0etzsn68Db9AKatpKvJ1hsDaN6r7aGG+m9wHGVm3qoW1BQK4lX8AETwbSA9RF6RKlP6NnIPBXKZ7bQ5unLRca2kAzuOVNVu2S67OW54gMCphTi+u7C59hoTsfM+fnZvL9vtIaL0GE7yW1mhHdEdNzW1UdSew94UOvRWqtnOptBZv+tDlbFR0330mj1HKTsboJgcJdYD7d5mFI1pmOHkwfOKsXuSImr01KGWULSzp9nP0Sqy0mqCThz3Jq/5ahXKkTqG7tyItAz+gslzEgbpq8nJuuI+d0+mLLttj7+2hWGaZNrSRZPaXrUHgRJpclTpbd1XtSHYAaNcMVNCOuwQre6X8c5UeA73H7/gR8JDym96T4Pr2QNmfYs2symD2cuHjJY2fNGq2ZtkJcbr6vgpF49vcIG+vmBImcW3A87Fxwvql16w1N3l0FmWQVGdbsib8lg6UkfCvz18gaXhPtsJLN/tLyW9zVnAbNOp/4gXugaLqEdIBTXfZB4Oe3qqeVOeGHKvmMnTb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(2906002)(33716001)(38100700002)(8936002)(6862004)(8676002)(5660300002)(86362001)(6512007)(41300700001)(66556008)(66476007)(6636002)(4326008)(316002)(66946007)(6486002)(478600001)(186003)(1076003)(9686003)(6506007)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzKggYfpX9Orovui8KHr94K6DM5WN2Hvl7+a/np8kXNYEzDJMO21lVnzfhPX?=
 =?us-ascii?Q?KoHiLG7Ulwtci8qIwll7D2nZ0kisp0XaM3bwsH6FEr1G85JC1MDW8Nc/6V99?=
 =?us-ascii?Q?t6UpSsoIEOgkDAWU6eY10YhVh96hL5f4H5ynIBrNY4mKHeaTHAOuF2zRxtTI?=
 =?us-ascii?Q?egYEnlo3/mgnkziyJXGxTn/vJmp5WtJDWos5ylnO58OqazZAYIYXx0do2a1d?=
 =?us-ascii?Q?sttpBqmf1+dis5BJ0jFAqEjoEF9az1msQ5wStXkYg8wjTpSbvE5XRhE9hRx9?=
 =?us-ascii?Q?chC8xHDN7di8EBVqEJ0vc+UBaChLzuCRAymMjdAab1htdEnUeTHMYQp53nT2?=
 =?us-ascii?Q?n/ih+CSQ8i3LzVYZdEN5l+kWU4VWe5L2TODJxMbgA50UXIXEti97smqgNTlE?=
 =?us-ascii?Q?ETHV538mGrI6/VmgkFMGifedNB0dbPlCHJeaSXIp/oTgJudnCAy4N1QYd/eo?=
 =?us-ascii?Q?yecZHWgOKCqdlwJ/NTDRXlOm/WN1FLFjQpoWHZBPEwczlEBk88yr0+n3+ggg?=
 =?us-ascii?Q?WkbMY7Od1Y9TRxnbYg1a2FCWkpz5OEE/2svxftHLma/wDgM9hp0Nfqu6h22O?=
 =?us-ascii?Q?99mCHty/Z/AiJK90vy15evpin1XlDQBNenZdUk01GQUSYjS2EB5IGPIRLxtr?=
 =?us-ascii?Q?z6HTJiYILacxKU/AgRgWJNAA3ofZzPgw7acRUNuSyrr8lleXt4Qk/OuY2tQX?=
 =?us-ascii?Q?JQKp2dl15ApeV7F+hEQHP0VgPvSEyr9iFjfXbbPjyRT4RaT7JK+qIwkhaVj0?=
 =?us-ascii?Q?rNouyUUuOuebgurgrMFndy2XyuUGbEgXyaSHXtIEObckMz711ig2IR/SyS8n?=
 =?us-ascii?Q?IrJUOFuOJPpr8+agRz6/w3WppP2jynxr/W+AYOOqEfl42UEpP+g1nezdEBiN?=
 =?us-ascii?Q?cUvcFA0kYCQKskmZCOGrRxINQhpnweSh14snYjA/QnAmqaNBistIK/SP9xSq?=
 =?us-ascii?Q?r2bEURRLgmi9kQAHLwpMjmt41ov9I8SwzqJfRXq2q05Quvo9HfAw1eUWDFxH?=
 =?us-ascii?Q?9C4BV3TY/tTmHGDhgYYTgCOXv8Qd/WJ1vvhf1U3K74vGsmBIhjdR78v1t8kK?=
 =?us-ascii?Q?FGZ8FzDZ7ZvxIoLwy9U2DFq0uRk2NPnyjon1i3ccoNQcaqsp5m29RTE/wqH7?=
 =?us-ascii?Q?d4pj9BJDS/XH8pf4HcTdC8aABdEcW3yI3cbRJ1U5DUzbs0NTLpjnxA/YO9T/?=
 =?us-ascii?Q?TXQfU77X5uGnzE8aaaz74NdHMclnTqyP7dhIu54CU4C7ewywGunBvib7I4rA?=
 =?us-ascii?Q?J3FCanYcH2Z/54inUbwwTds97kabkaiYa6f/nMNoMgLwnvKYkzcxhEatYB0K?=
 =?us-ascii?Q?SZ63m5hztWEHEdnMIatctSJu19No+6ZwZ3Wd5gX5FBSHlFQMLbwXc/r8SSpw?=
 =?us-ascii?Q?3cfS5w+79cIWDbOBOYIzlNoK/lu+FN8V3xHGKzcQ/SaIe45zL0qGScLEwOG7?=
 =?us-ascii?Q?oHQ9B35e9F3mfVqDZMkmWbzaizJsVgpAhdDGoJney8jQHJq6uV7CbuAKSjVv?=
 =?us-ascii?Q?0YKGZiRg8JY7LTSfkxvYtjhWMV8LFlJYdGmxGpZUUmu7e6aIN8Fj5dgjvAM2?=
 =?us-ascii?Q?/vs/YmaaYvVtrpnQPT1Y1mnLIRz568QLsf0OAuqTb3Ag+9sDm1M58tOediMz?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?to3LFODPW3a8IXqxKpAEqHD9cYYeFhw0b6yE5zIm/d8vClvFqfoaZ7MmapH5?=
 =?us-ascii?Q?gUuRO3UKnpDSQJc8Fs8FYxo8gjJIZa0HPWGqqp/Jocxf5QfOytrvO0PW5yjZ?=
 =?us-ascii?Q?wW6l2I/zvp/kwwQmj8f4npqs5evO+Alnb/nOd6OISA8HWQlLoo8aUDsCgTCG?=
 =?us-ascii?Q?YUGyQwTkFVrX7q1XC8PpszyQQjhxkm3BpqQP+nU4jFe+7F84KTVOyGx2rVlb?=
 =?us-ascii?Q?YNPIt0mSs3WgA9mO6paKQQMwHfRYTV1VXIDK3hTXTJ4olmqAg9w60bSGoejf?=
 =?us-ascii?Q?6pmqHrcvxWq20UWHTjHDRO3xudUS2P5Ye37Zj6uuv6e5TvmeVUyGE9GgzU/4?=
 =?us-ascii?Q?z3TQamaLOBbHatzw3LKEgUbDjOhnSFVK+lYhqghxEKhMBQu3DbDGOQLzy7SI?=
 =?us-ascii?Q?f0FKw1CXLIHOF5Ue2fbmm9T6XTLcsDSMjkZxEEiUYeWXh7IUCj1S2IATQmyS?=
 =?us-ascii?Q?YYpwu+jgTdT3OXl6+T/LhN5Da7GqWVAFn82FLDvHe4mibiJKOimyFJXLJNYk?=
 =?us-ascii?Q?pdm+MUNioN8J1iaenSk62B9MuCHwpQnT6KlW+95aCcNi5iYK06ZJj2J4M1g1?=
 =?us-ascii?Q?fsgV3fh9K7wgqKpNIcrNcHXOnzBm+4Z0LFUmSakUAp4CK7PKunmwop7gwMAw?=
 =?us-ascii?Q?aF9o/o1GZ2RgUQ8YygTF8Dzi3jsnLlFKLhTm7uWme4BGrUDuXkF60qHU16XR?=
 =?us-ascii?Q?rlJ8v312ogp6hOcWat7hjXMK9E/WxK7iUUzo2gaHjeHIUoQXcXq3H6Efi5p1?=
 =?us-ascii?Q?q5yHtcI4Ha+C9S4s2vhdd+6DGeFKC0DjAfiqXyf1W7rKW6EmMgbHdF0xff2Q?=
 =?us-ascii?Q?c6M92/7UDM8/7kiTkS5w5Thj3UcV1vLuTki2xXap7zsL4d0ozKJjV075wDGA?=
 =?us-ascii?Q?hA4s5I3jE5PB8DaWJVmGF4wKotY3qu7BIBYDERpwzMWVPDqQ3InXFYdGwHQt?=
 =?us-ascii?Q?f4Y1REVl/PZNOzfK1HNf6xxNhJbEPi9CJ9K15aokhd3jY//N0mdwmCD6H374?=
 =?us-ascii?Q?K3dnaEkP8LgpZX908wdM5uNngAdhWa21f5cC0QcVaQ6RGGV66Dg8nTdtX3dP?=
 =?us-ascii?Q?eZUhd6bSC/kD6OkmAsy+wTWtGb+iAQHx9TRTd7JgROLlXAbuprNXdRH7JqOe?=
 =?us-ascii?Q?qVztYINUbObSQJf1mFGGLLHIgLzYKQ+ekH6TwCihTpq3OHpqH8AMgio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9189da1-ce0b-4da6-570e-08db79a7feb4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 20:24:24.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZfzsN/bj1SQBxyN02GAOkN2qm+et/7S19SMAsIUOZW4UWybNrto8L9KACtE1F28RnijFh/r6PFNvmL2Hlalbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=965 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300178
X-Proofpoint-GUID: HAPq8g1191YYPKZBLKnd7Qacp-_QQuzh
X-Proofpoint-ORIG-GUID: HAPq8g1191YYPKZBLKnd7Qacp-_QQuzh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
> To use filtering at the connector & cn_proc layers, we need to enable
> filtering in the netlink layer. This reverses the patch which removed
> netlink filtering.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <liam.howlett@oracle.com>

> ---
>  include/linux/netlink.h  |  5 +++++
>  net/netlink/af_netlink.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 19c0791ed9d5..d73cfe5b6bc2 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -227,6 +227,11 @@ bool netlink_strict_get_check(struct sk_buff *skb);
>  int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
>  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
>  		      __u32 group, gfp_t allocation);
> +int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
> +			       __u32 portid, __u32 group, gfp_t allocation,
> +			       int (*filter)(struct sock *dsk,
> +					     struct sk_buff *skb, void *data),
> +			       void *filter_data);
>  int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
>  int netlink_register_notifier(struct notifier_block *nb);
>  int netlink_unregister_notifier(struct notifier_block *nb);
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 3a1e0fd5bf14..e75e5156e4ac 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1432,6 +1432,8 @@ struct netlink_broadcast_data {
>  	int delivered;
>  	gfp_t allocation;
>  	struct sk_buff *skb, *skb2;
> +	int (*tx_filter)(struct sock *dsk, struct sk_buff *skb, void *data);
> +	void *tx_data;
>  };
>  
>  static void do_one_broadcast(struct sock *sk,
> @@ -1485,6 +1487,13 @@ static void do_one_broadcast(struct sock *sk,
>  			p->delivery_failure = 1;
>  		goto out;
>  	}
> +
> +	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
> +		kfree_skb(p->skb2);
> +		p->skb2 = NULL;
> +		goto out;
> +	}
> +
>  	if (sk_filter(sk, p->skb2)) {
>  		kfree_skb(p->skb2);
>  		p->skb2 = NULL;
> @@ -1507,8 +1516,12 @@ static void do_one_broadcast(struct sock *sk,
>  	sock_put(sk);
>  }
>  
> -int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> -		      u32 group, gfp_t allocation)
> +int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
> +			       u32 portid,
> +			       u32 group, gfp_t allocation,
> +			       int (*filter)(struct sock *dsk,
> +					     struct sk_buff *skb, void *data),
> +			       void *filter_data)
>  {
>  	struct net *net = sock_net(ssk);
>  	struct netlink_broadcast_data info;
> @@ -1527,6 +1540,8 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
>  	info.allocation = allocation;
>  	info.skb = skb;
>  	info.skb2 = NULL;
> +	info.tx_filter = filter;
> +	info.tx_data = filter_data;
>  
>  	/* While we sleep in clone, do not allow to change socket list */
>  
> @@ -1552,6 +1567,14 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
>  	}
>  	return -ESRCH;
>  }
> +EXPORT_SYMBOL(netlink_broadcast_filtered);
> +
> +int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> +		      u32 group, gfp_t allocation)
> +{
> +	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
> +					  NULL, NULL);
> +}
>  EXPORT_SYMBOL(netlink_broadcast);
>  
>  struct netlink_set_err_data {
> -- 
> 2.41.0
> 
