Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A789B6E03BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMBeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:34:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FC40CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:34:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJTdFY008445;
        Thu, 13 Apr 2023 01:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TF7lquAx17W6GImZSKRz5aNKcLMunc7LVuawXJbwAOg=;
 b=FKVsDQXFNUZAgtvlL7UykRc4KGvwv3mBaZ4a1IrNCmuNVQ+iKlUBbdKlpLFHSzMinAvv
 Y0A2ir3J0oKU8ZN2CbZ6OD8d8zzjEG9y93+TwRL1H3ndekvINYMNzcKRTSOXVwCuXStk
 W9XHFfpoJukA5DVOCt81BjUYlWXl3x7tcsKnnF7qe+ISdHnAHA6ZMotvbcoSzu9gBZqb
 6x5zUM+dIB/kY65ZQVe9D96addj2Q6kIjFfOj9sUhiNAd7LCmqJ+mJRQ6FrceNH7L2ZK
 Ijr9UQ/ADEGsdGlOAc4DlL8DEWN+48kNI/2TkL1BmrwpFgvYaMXxqrdI3B8cLRhJHQSH uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ttstpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 01:34:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33D0Uxbh012665;
        Thu, 13 Apr 2023 01:34:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgq81s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 01:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHU16MWiAQlqGCgOumdoh090aw7coWkHPKiO1oxZMBGLAq3ALoSfXxe4MnCsJodXkgDpS/ya/Fuo6zNlWgMxddkgLpJNo2IKt3LxZo1GrFbaO8oYE8Ym38RM7wLdxm1sho6NvqPNnMRSv2URV++um9bK5RpV6knqsHzvNE/P+XQ2C1LJxbxHr2U1Lefi0+nN+mffdWMAx+Y9RE6lZmPa9rrFnpjHjHe6iOoumlHGKxRxEL3t5SkNxN7pUSMZ5EiT+u8BRLqDzDA+/aL3wDw5ZR2GgNC3WJMn4x2qzVvC+tOWLdoA+ZPHXGnNblUJD2+PJP2vy4MSd3GWMJsSyfVQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF7lquAx17W6GImZSKRz5aNKcLMunc7LVuawXJbwAOg=;
 b=eJTYoua/SO/LWocgGqAjJjbt7ygwdiWhHwLKFzLIiM38wWjPnHI6oeqeGrWDSErn3elWvJw/tVboY3mZmVNu1QWPlv7Fae7Rta6u+QYnLlL1bRNaM8+JUjJadqWGrPNUy+mrBfg+E1IMCSm0jXKy4aCiHQ1K3QoPStcGoeKS3iOprRxoMWMpuzSpmm2VRk/h1nT1peDuiAvw/ORLMnLzyFp1PyVnfY5JgU/crSbICkZqKYZNl43Eoa+NOCwJCJYu9VVR1dWBMVpi5FHXjnUb41YM/8p+L9hNuJSUeJfZ0Hoc/HNyfhobAIp2OBt7guAAyLNg1+J2ybnvMvlOnHdUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF7lquAx17W6GImZSKRz5aNKcLMunc7LVuawXJbwAOg=;
 b=Ux4nyy62O/YAniWUL7s7MMJeC0JZIbA0znvCtI5PIj9q5k0s4lgweGTYLV2J7gwbZDu/HBQunf4LtUAA6kX2B2Jf2VNViv6FIBcKQ/O6YVGv949tspH4gpe7bRlPrzVLlyXce0eMIi65fLoMcHMTdxPb/mB8tIxLboTXCT4xteE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 01:34:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 01:34:06 +0000
To:     hch@lst.de
Cc:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        martin.petersen@oracle.com
Subject: Re: [PATCH 2/2] nvme-pci: fix metadata mapping length
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rewbmay.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
        <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
        <20230412065736.GB20550@lst.de>
Date:   Wed, 12 Apr 2023 21:34:00 -0400
In-Reply-To: <20230412065736.GB20550@lst.de> (hch@lst.de's message of "Wed, 12
        Apr 2023 08:57:36 +0200")
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 817f5884-a843-4db7-2f0d-08db3bbf2bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ti1UdmjSWSOoylRdSeMk1fjP5cBobVYRMvarDlkYq1+nfARro7ZnGGdcLFewOIbp2z6JxN4EWYrK96esJFhQmGABG/XktbOLZnlCQGHoofNFliaTHv9iqg2bEXSfLQCAzMpGva1nbAwIyeSZ3r8HVCSS3oD94TbA6hva/JR7xIGlZ8EKEkxMnlGelkTOYTT5Ia8vXVpC91C1SBc+OEVD7MlsnFq1EJkFuNRs8wUu5uP3CTfpKjgedqdIjOnzITTF3AdP5uaYDgBPyhfR3NN4+WYorEmfl9euRZ0hqpxiYQvT1aPPi126PtydWAMieZxN3FqSI/eTzqB6CUlF1W+LPwYnZMkKnL59VqZdVm7zUF2x05XnPNobPZ0EgP2MGI3XeStckR0LyyGsaPRh66fsfMMHl/VOXhhcQeCEFII82g977tXrU7YgWZPW+UnbNU/izk4olI7bS2qoi9f0Elt8JznYl4s+zgoUXCkkCEDYven8B1xEpj/RCZ12ECrFcySY+wSuCb7IOpA6B2Y4uqLEsR4xS2KyUxGlw6H5ysRvxroOvZ9vkJH1oIW4t36Ic6TU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(86362001)(41300700001)(316002)(8676002)(66556008)(66476007)(66946007)(6486002)(6916009)(478600001)(4326008)(36916002)(54906003)(5660300002)(8936002)(4744005)(186003)(38100700002)(2906002)(6666004)(6506007)(107886003)(26005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHGW7dlbyzefLr3M163nxprg9ZLgvvqjCBR5R4LEjn5yWl62gvCZ1FVKrF9c?=
 =?us-ascii?Q?hfRo/S2nNm9GqiyKHw5wdxewhzGgqRjji+/DnWoAasjzjZqLc6EMJ/y+5hj5?=
 =?us-ascii?Q?tgycoSiCc0YUqTNUiGwb5KurUWnL7dFkLs73onBP1cid+NvL+cPKXxpMQUp0?=
 =?us-ascii?Q?7im/UNvkVSVY8W9icMo4Q099RlKCZK7WXk7VnYs727naYebTu2uUqKuHek4K?=
 =?us-ascii?Q?KjibBHk9Ksl4yNwlLPKLI5jMay6kyY1Dr7L64GihBpUxgXqFSfXYvngWAUu3?=
 =?us-ascii?Q?K/rQrzgvdsUx8KMCBG+H8fj4XXRn6E6zCaEd+ttWhjK0x3Ok29drM9W0R7om?=
 =?us-ascii?Q?9u3y1BdQQYBdcwTC3J28MeTIF330WUSg+N1C7pZAPrn2U1BSkk41750FZMh/?=
 =?us-ascii?Q?jh9qk6PPpmM4gS/ghjuOS/9GvLx1VaY13nxm1ng5p/f6sXwyaMSUdEQZe3fV?=
 =?us-ascii?Q?er5QTbaoC6ch2XskWbdMuX+e29jOW6Qk8oPUpCN6iClWlmq8kUt3n6B5tZF5?=
 =?us-ascii?Q?2dMHhI3iUgLLnnN3QN8Jei5alu+lQArEeXB+s5wma5pbEFZ3M/L9F5rM/0v/?=
 =?us-ascii?Q?ZEXVtFg4phCK4py2awLg9nYuBqBTv31LTY7XC0y1nSy/lINbeAMab4ZeEM4L?=
 =?us-ascii?Q?WwQO7rmQ/ypocp6iZsTf4BaN5/zRQAPV3gVds91uZZo/uYIC85iysQpYOLQV?=
 =?us-ascii?Q?KyJ6hK0BcvYD5SYOn+p5TlD7u4/aSVt9Hq/0l71IlRIpb8HwwVVfMb7A+1If?=
 =?us-ascii?Q?fiaYGBA9E525EXI+C1k32e+on0O2ZSECxoMNxmY5j1ueM5cj3sOO45PwK5Qy?=
 =?us-ascii?Q?l7nuIOzz7CXLyEI+XoywVz8fN2loDUjPBbo84cmcehxiKoFe/DSRMfAYfP5Y?=
 =?us-ascii?Q?d8Ml2Oe5xg1mBWeecHdvEVrJGntO5AjbY/lgdq3U9wdP3TPcj30Iixlc7RFN?=
 =?us-ascii?Q?DfBEUjiHz7EEDSh2Sh7K4tBO1lZxCP7wygzUojQW7ZqwMY8EduSxJXVWZWmc?=
 =?us-ascii?Q?Cg9mTo1qW4dw0PZhj7xs6L4dkYDJmIhFHkz7AJsddTP5vrCNEcFo9oSIeVzs?=
 =?us-ascii?Q?Y2YEUYQ3XhjWAsZpvzz+mgUNYNJ4LEHzygNkY18U/YE9uyGsA5KV8P2eXqEe?=
 =?us-ascii?Q?K1lwrjn/PELynj3t+TIO1pqb1qkxuWAby8b/CThEtHFe8pDMC9C9XTezdX8K?=
 =?us-ascii?Q?h8Gh7g2V6eg+quAvf145wv76Ca+hjVOBJs9Rone+isDokDD7IMm8DgdZihIu?=
 =?us-ascii?Q?6MVthmPpVqwDvpbAsw8WX1j/u0KXgq7dwwkF2EiS08i2OGUuJb9ChZIhWtpo?=
 =?us-ascii?Q?lwB8TnFGBjP2p3pdzr03DBDjBMZ4HBOTIl1agWN1Ra+f9ziqE8ZmrdNht4+a?=
 =?us-ascii?Q?hxdmONDDxFpsstoMEAfIKqPxucT5MH56zL0N4mBB7Cw4gOzgnsDzbDYr4h9X?=
 =?us-ascii?Q?7FPSkTDEs+l+kUVkcRYMYZ9ASdDVXs50pqldnlNHi9cz37Zpvv+BLEqgDefe?=
 =?us-ascii?Q?beenKiSjoprK0DuJWWxAG6s2/ye++XbyamPvHTRFcsW8OutK/BqHVb2XcWv7?=
 =?us-ascii?Q?EDW4Yewle8Rp1CHKgNohjHVjbVyhccjka26CXmDDb+BwO7lNiUZO/QSUOCBk?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?86L4OmmybLPvLj5U6KJLisY0Trq2Q/+DeLBqMfokYMptUFtNk72G1jtru41h?=
 =?us-ascii?Q?Glcxya5tbCJKFaFw7pfCyJgLbCGz/vK3cHcRqAihCFAHLkeNZt364vMnH6Yd?=
 =?us-ascii?Q?yeG20ndvmIO6zUy6oEITfb7kidW0IgdSKeoyBfexh2t+OjltPxC5cLmLGHk+?=
 =?us-ascii?Q?C/l4BIJOHI/aTLy+gLJonTDq3I+czGNla/yYC0prD3ViQx6rDEu9jUs7HJMg?=
 =?us-ascii?Q?wxBZL7CbRzKg1aEeBB7xn9gubeKBz/w23t/PEuuVtjiDY8S2yytarO4gNPou?=
 =?us-ascii?Q?XSXz8cAYd/6C+uyxbcT1wcgZHZrsPYUkXsbwXfB4yHcYakKPru7kJM3zlF2b?=
 =?us-ascii?Q?4hyCcBMdjVavf4OXVAup/v5JLzvDuXzRUXIPdrqUU8DiDq6dm8zuUYKVIOcw?=
 =?us-ascii?Q?ekrWeIj8yZXx3/TBG66LJteNySp272O0lNQLlYHyfbkXqwiJ3eC8EGoJHrPF?=
 =?us-ascii?Q?zOPCG1ZbZ8dV/rfo7Vjjz6zhyK0blDXrSjGCC6+d37kuKFxZu1QbD3yDowpd?=
 =?us-ascii?Q?3WcrlXj2T9ullZj1QWfLa5vtSvvSket7VxWbFs5uUhS9gU4LP1txiJIVOmU4?=
 =?us-ascii?Q?nmaWvGYXWGltUY6J8qRwyb5QwIDJJSeSqrDjSHQnCe52/hiHlNp2cqdm6R4g?=
 =?us-ascii?Q?Rx86VS9nLdrl2KL5SZVcaAMwCOQZaeeIRhYwvr+5y8rrl9lJRHTqOwmptPuW?=
 =?us-ascii?Q?UPdYpZH+RZ7f363Wj+/1Md0fL992yxltzLkbVFnIYTeNzi501criEmqwDYBu?=
 =?us-ascii?Q?TQ/mfUYKlM4OvbLngssO1VAKUOziarFIGiFd+roL6CaJU43bGEPgIdlPAfac?=
 =?us-ascii?Q?/nkfK/vxwWCuycV7eXdXlzA2LA11KcXUOJfBUhe3VTAmPWOKTokA8nYW+Z4R?=
 =?us-ascii?Q?JHFO9FvohGYIhhmwOq0t48X5MBg40NQ+LgE8bSOvR3cqqjzwTLHoLwQBsnVj?=
 =?us-ascii?Q?Ie5ea0NbwjfRqfs/xe/61Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817f5884-a843-4db7-2f0d-08db3bbf2bfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 01:34:06.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jYfviz4xi6Vmi2hi3tJGT7eTLW2sYib4JkhZ/kDHfuz/53Bloy9ZjWs9bhPq7nWF3qOMeSzF5YmGyo/CcBakASCHm6PakhurhzE6mqv968=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_14,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=602 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130012
X-Proofpoint-ORIG-GUID: sG6cW42IjrfWZBhXtA1MpIBb0DpWEDeQ
X-Proofpoint-GUID: sG6cW42IjrfWZBhXtA1MpIBb0DpWEDeQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Even if the memory allocated for integrity is physically continuous,
>> struct bio_vec is composed separately for each page size.
>> In order not to use the blk_rq_map_integrity_sg(), the length of the
>> DMA mapping should be the total size of integrity payload.
>
> Hmm, looking outside the bio_vec is pretty nasty.
>
> I think the problem here is that bio_integrity_add_page should
> just add to the existing bvec, similar to bio_add_page and friends.

Yep, that seems like a better approach. We should try to merge.

-- 
Martin K. Petersen	Oracle Linux Engineering
