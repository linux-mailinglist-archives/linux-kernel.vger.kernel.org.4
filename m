Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1437720A92
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjFBUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjFBUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:53:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967FE43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:53:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Hf6LY023450;
        Fri, 2 Jun 2023 20:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Vmmgx4DKVp0CIvvEsUte4NChnlv6FFJXrikxBUdFab0=;
 b=BbEvKtau2T+604Oahcha1EK7Q0omPIxipqBT1JZH0U9HD3YStcUfm60TtXAA8bTSD3Bf
 632VtrMynMR5J3TxqPapduha/BOo4PRPdAeobNiWm2m2V67enZoSmrXdtkxmJ9zDuOeF
 BD2FHnQC7NI17+fBDbsc0sG/bx+IAMfmZkRPGecBTkjMVfh8yAk4xl0XAsn2vdLifIFH
 4nxGxpHyWSRviumoVwoNFFbIFBc7P6EOTo4LfnQKyai5QxxPPJObfPu7JzwqOPO1aL5n
 WRiXNE5cWIQrOnXdVr6YBN1HIUczKPvh8ycfPcCnI3dThUmPL4J6N0k+cD/T5B39Hst+ Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwkn3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 20:52:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352K57Nf004658;
        Fri, 2 Jun 2023 20:52:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8afn3gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 20:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8yWGF8FjOIlVZsmcdWlIR8b454hQGyXpJqLwVhqKw6qjzi+z+nn6aOGJoArmCn7ioNDqhCz7OzNYmScQuxceMbgJHmtLnCvQSzPi5tFNxi4wt9KEWwaoN/ntCi6enufrWkf6FxjKb1UpVlWYgAHl2oSqg76jciicrsVsUbBOqs4CqEDHIA/y97zpCHgMr5XtouJKo3gW/Zh3WShOdMOftAw4LQYGhJ7IoGbhTAV0Ubx7Z8EQUxBtCK45AkjMo9YOxCOcPTpKxXcwu5UAI/Nw3+yY3ewF+fZABWynH6HBavnNHf9IszO0YQa6gv8xPKpLClq8iC/A5sXL6cTagVR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmmgx4DKVp0CIvvEsUte4NChnlv6FFJXrikxBUdFab0=;
 b=PlySXOG51KkaxQUTdcAkiXMUlM9ENPPr8jD0trC4m5CX0RkpnvRNMIM6tiE9EvfX2YNailF7ws5DzzeN0RAog7R30+8SC0Rx9YuEVzp0erzZF7G74J8tDf/KCKyCNLB/0UQNKFP7HIih4gdV4EW0GXEpmCFMksJyzrs2ZE+UqdSNtr/yUlZpao00K/5IncmbcnO/Dy7Ds2iVcCSIZwdzIBe+ZSu1oLLtoDVGfXt3Jkg+cbqIJKLjH+eC2BqMRIVErVyuPSbFX6LYh9JP1e1xPb03oVgiYHb9Wkq9D7iGjaLRiHO+100a4luH0XSlP6RdBJxSAL2IiUuBWfSC+9GG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vmmgx4DKVp0CIvvEsUte4NChnlv6FFJXrikxBUdFab0=;
 b=lhK610rLswwjjMih2llVJIIr6qMJ+syx6AfMY8z2QElMtULGiQN9z6BMWQv9SUJZ2kb30qkJ1iOOeyPmzA9nO25OP1SyLyy18T+9ufzr+SF8G6pDY6/Qq55RPP3ej4++AUzOzeZhf2KxIQoOq8AUW79/Z5ruJ5vV5A2Hv4vVGuk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 20:52:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 20:52:42 +0000
Date:   Fri, 2 Jun 2023 13:52:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, sidhartha.kumar@oracle.com,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH 2/2] mm/hugetlb: Use a folio in hugetlb_wp()
Message-ID: <20230602205239.GB3941@monkey>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-3-zhangpeng362@huawei.com>
 <ZHpORDg3JltVUwNb@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHpORDg3JltVUwNb@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: e1534101-b292-4987-80a7-08db63ab4ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRQnpPlNUh20DRacE32LDPNB1Gf8TKE2bF2U97tY4NtIj3zC3Ji3yo8gKFkqJoYCnuZTysAvv8L7WLfiYTFKXCnGj4EbHCX4+uz36LqR+sL0v+f1VFRPWABWi7RiU1Ot4Bsspc7vjzSK5i2vInDxv5vlptjpmUt5T9mq0+/19jeKRJvA5c4lGoePXh4eOYxlbX7mgXAl/jnySESzL49yBSri/+0oA8IW4ouCr4MrMINjw+jqvGNBn8tyYN4M3OpJC8XBkhGSBmCQC6q5hPZJAAkjQEumGJs8j+mP8Gk7ZbUz7ndX+5qMEOISQ0U45qJGW2YfvVk3+XAMzs9ITXtnlJ9rjqZx/MHMNji9O6Xufc1+/UV/FMzFMk0RtZakRNWdkz1sBByiO16+3NuaVkTsu51TBl4R4uhFyuvoO7UvwuQhDam2865wk/cW1j4o5YrWliYGhasOt3jxtWS1xfb5K1lr7afVCpAHn7hd/BpaPWiOUz9QcMbjnp6BRh+RLaBWr7zzdBLtALfWIcNR/F5o4c0pfAC4KLVCmHfx7s/rNhNOLbZdf1RxxGHiI7D85c5c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(5660300002)(8676002)(44832011)(2906002)(8936002)(33656002)(86362001)(4326008)(33716001)(66556008)(66946007)(66476007)(6916009)(316002)(41300700001)(38100700002)(186003)(9686003)(53546011)(26005)(6486002)(6506007)(1076003)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKZ4E9BT28aQ2NoylF4BLQoKgJtl4FxzEaZY2+w89piQ75KDgbaT1dHHnXE/?=
 =?us-ascii?Q?fqpqoEez5nO1ydi3Gn8/leH7fYlL4Mj2by9+rRi1JFPKXb3domXBTvc+eMug?=
 =?us-ascii?Q?8PRHCtVRLKByZhAz0JPjG/B9G4BBpv56xUEhWVucaKAE0b4x2N0Y+rNIHJ4j?=
 =?us-ascii?Q?7D3wYU8HO2nyzjf3VXXEuhyjkiuq8WT4zqJ/gYGt1w097Nq/ditoa5vyF2Y3?=
 =?us-ascii?Q?cNhc98VeI3t5c6NYBb3LBCwaolKUr9M4ihysT39bSNaypFM2ZOTMIi4P7Iwv?=
 =?us-ascii?Q?4PsexswhsbQjLreDGAMbV2RseRSN1rUOFUsihDonsz/AXf68/ZmTYuE3Vuwb?=
 =?us-ascii?Q?8IZkrg/23imYUQab4eeeqjtHvk82D2+vkPqx7V1ZK9BkFGs9Ojbri222OKOL?=
 =?us-ascii?Q?/WeJKirX4/wvKPYQU2efWqgzXmhXBaFDsMp0RRU+0FEtAjPz47pOY1q0u/g4?=
 =?us-ascii?Q?SCndnMRsNthk/5GyTGa6VkMC05xieyLaa+86ylzTOZElQ+Ij/XvzA0zdzzJP?=
 =?us-ascii?Q?lZWff9rhRxE/6zKRJ+Wx3Ridmo2w2P8MQHTA6nsbzabJT08YPWty4fueQxWn?=
 =?us-ascii?Q?pNgzPORdihfx1iySQC30PC4EsR1gb2pP+LejjIIX+0HvpsE650iVVKW0wNqI?=
 =?us-ascii?Q?E1gBJOG5ZXbNimaHUVzimD9bmVt4udIzoKp3etG80B1ebhd/TW5Ek5AjlcdS?=
 =?us-ascii?Q?sartXyhaJB9dyZZGyy6s21/T7DoYVqsUGodgdkNfONRal+NqiK2yhdUwS35j?=
 =?us-ascii?Q?Dn2+jeXZdIZ3QOy/FIjICfBXfHPL4UEvNpDXQi/lJw1gpMMV9rs8FplR10O4?=
 =?us-ascii?Q?wu9HmA/kgjGvN7b5ee5GieO8gUR8JVozGfm7ziXz/WrvvSJbIe2spkVbyCY8?=
 =?us-ascii?Q?OGMGykNaSHausPl3kTSLrkqPW6TM6d1RzbwUHWGxZiwlEVnfOQ+2ZAhnNtXN?=
 =?us-ascii?Q?dVMH24DAUqCEtHN+tf23g11QCZM2RJnsaOhbE5mAj8G/Wo9QfJDddrU8zef/?=
 =?us-ascii?Q?kb0qq0qmXfevt+jlUgvlbZ4yNnVoSGIGiam7lWaIOcZIRrCjrMfm59t11cx2?=
 =?us-ascii?Q?PDWOp1oUHTxeY4xoRNSrJGbkB6QU5iK6NGZ5n1cTPiLX+N1Fb7qqPyuVu2Sv?=
 =?us-ascii?Q?/lD3y9Xjzs1TxBQstn7Fh3Kb+B+zAebtHr55hTj/CkVCZPsZ86rmGpm1ajT7?=
 =?us-ascii?Q?MsXZJTKCRT47FUagROzWuqJxinkqRN9pv9LKSC9JxTqjMtPSy2Srs1i6jUwi?=
 =?us-ascii?Q?OcZWna2qaWxByfjwXsjR7HSYFlu1d9Ma8K+9WcsgUo+x/BM0U15AMKm3+dUv?=
 =?us-ascii?Q?MfRizF5YDsgLUQCEIC3nN6cxOcaQ1Tve2o4x5uqeLkb5+iXrVk8gfyfEpK4L?=
 =?us-ascii?Q?wxe0SX0dKUM7JFv7IjZkdJ6vJj35fX56ivT/peieFH2804cUIu5053zA2OYj?=
 =?us-ascii?Q?vcyoAKcuzszHHeuSbit6tZbICBvTFjm+WlTZbc5k9r+4aOREH2xQK/XbwFn8?=
 =?us-ascii?Q?iUgDF/CGFYsoFzTlSmfm6Miq3lTl8gZZYkUo8PqRsDQ3GRerjhmcwR3AUys8?=
 =?us-ascii?Q?SML1WaACn1LNIj2q0NMFhC4CEU/40Z0dDHvh+N3B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9mpu4iA50j7VTl1sytzkTexOZQv+/XfbxT2BblpxYcHyLDsIhHsei6vmeTcq?=
 =?us-ascii?Q?jCG3frYuwim/vhmfZjRLpo9FjFLNYjG2wjX883a7vR328JrMAGa8Rm3WY/X6?=
 =?us-ascii?Q?OvBW4QrqF33gps0K0mPMNG3StqSK9rQsR559+yh+ugTlAsF2evZ5qAD+1fcI?=
 =?us-ascii?Q?DCuJjm7Ah7MJYABxB7HPPMu/PwnNgaY5S2hl2WfJ1dWEy6Mv3aVmJgaTsvDd?=
 =?us-ascii?Q?lkLhCH6lMPkkBNTJuNqaiVghJLENwdlvDbhNPc8fBaelkYnCVj4l7gl/amKo?=
 =?us-ascii?Q?N8Q//4sGxROXDQcOgNI8wWPIYISt5mMOMAEKoBuc9+BFFhqFtxHMxdyAwWoz?=
 =?us-ascii?Q?dA/7jTkRYC0yJd8p795Dqn5JOBaYe4jV/YNYJvGnBp7l0RrLNZ3qEahcIIL4?=
 =?us-ascii?Q?1l2ycyenAPxXpxwJkT3QkW8rIHcuDcfSsBqENyQ74wH/7wbySZrDKx8N+DFB?=
 =?us-ascii?Q?nzTZbhrZ867OURhFn+a2QmWbrXoHpfNB0KDvpYcKdP51H1x9H6OBjqEMMyEy?=
 =?us-ascii?Q?KhLgXQQt1z8Rk+oqWobtzxcwaRmmsWIFAfAZbKrVltRL6DkpCx62t06FsLnH?=
 =?us-ascii?Q?7fqukZIssO4K5wcV4j7rs5ZR1C6upkPYoFlk5LaV+JLFd4Xl5bYjqYdTAhgq?=
 =?us-ascii?Q?DGmEDNMyZCwOg9DaBOgNsWB06A0Kg6bUnJ5KqmVnqUk26dmNKib+deLhwjM7?=
 =?us-ascii?Q?GNGPsrJWqF7zf1/Txwo06HWTH/COXOtKcu7umKv7dVSbKeqLzPEWD1uz3jdx?=
 =?us-ascii?Q?zD9z6+jpFTF8uHKvdcNPeD7GrI0W1P1Ve5nwnz5CI9+0+cDo3PB+u6x3OtTY?=
 =?us-ascii?Q?6rOzdbsIJMxeN0Y9MXc27gxThD/87BvsAcpb6VlVxL5APWnohdXECK1VGRxq?=
 =?us-ascii?Q?mIILx4HvSiT402LV9RU8QpGCrZ4Y+YSVOXvk4YF7S9EIn0hOVkynec7t+ptF?=
 =?us-ascii?Q?0ttCabWYvzEE6r8IxbN2sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1534101-b292-4987-80a7-08db63ab4ef3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:52:42.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoMYtTj1E9+YMOF5PcBL2yzAbzfivp7l/nR0rnrf/xwsb3QeOiwNCxoA9rdyd1VitpqTjUI4CERCxnfVwvkbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=727 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020161
X-Proofpoint-ORIG-GUID: lbpmR34UBB_vLPR4gKYuplfoKkRffvFE
X-Proofpoint-GUID: lbpmR34UBB_vLPR4gKYuplfoKkRffvFE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/23 21:17, Matthew Wilcox wrote:
> On Fri, Jun 02, 2023 at 09:54:08AM +0800, Peng Zhang wrote:
> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > We can replace nine implict calls to compound_head() with one by using
> > old_folio. However, we still need to keep old_page because we need to
> > know which page in the folio we are copying.
> 
> Do we?  It's my understanding (and I am far from an expert here ...)
> that the 'pte_t *' we are passed *inside hugetlbfs* is not in fact a pte
> pointer at all but actually a pmd or pud pointer.

That may not be technically true in some arch specific cases such as
arm64 with CONT_PTES and CONT_PMDS.

>                                                    See how we do this:
> 
>         pte_t pte = huge_ptep_get(ptep);
> 
> and so the page we get back is always a head page, and we can go
> directly to a folio.  ie this is different from the THP cases.

However, it is true that ptep will always be associated with the head
page.  This is because the associated virtual address is hugetlb page
aligned.

So, I agree with Matthew that there is no need to keep old_page.
Note that if old_page was NOT the head page, then

	copy_user_huge_page(&new_folio->page, old_page, address, vma,
		pages_per_huge_page(h));

would write beyond the end of range as it assumes old_page is head.
-- 
Mike Kravetz
