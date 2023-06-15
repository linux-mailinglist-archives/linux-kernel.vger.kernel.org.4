Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C2730C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjFOARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFOARi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:17:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D312128
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:17:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK05Wt010634;
        Thu, 15 Jun 2023 00:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+kIbv3KHI97zLxe7l1PP/6CciLO+U1PO7U2TvoAanrg=;
 b=KIzMa0TJTtC1VB6Icgomw8nA1CnydKTFqwFKPyN3Qth0tN4eNOjZUbP8BztG8BogWQAH
 xnmRGhTEazQshCmuOOY7BFD5xaVoCEKsGy5s0JyS1wimKoxdkbMicXMXrlg42G9Vb8hn
 OqCxquFFXCJfrm8ZdEBmpLuv1tbpJzwiXb3/GyRjDuhqqws+bIvYpoDuUYK8gu2BexcD
 6Pi94Pk/RXLOjcUJCkrIE1WMfw5f9jY7cqxihsd8/FEraX8VeFQ+BS9VOVRo5hDjKGhY
 VLaWV/yk8LxyWzSsOeKEGfde5nDNh6YYU5UzJvhtB7YNCiTzLmUL7/OH+UnTYFZ7B5cg 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs20vj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:17:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EMVpSk016215;
        Thu, 15 Jun 2023 00:17:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm696ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvd2i9E/jT6/mBI2sqcisgzwswj2WadE6z7yeN9IID8bSSpLyV9dVlopvMp0sYWSLtcvh6xFcgWN9Hi19ekt+1NdvHIiN90l9WyEpdqgW6DYLdJ5A7wHjtaVr2ttUopG/QB5Gz0Bj9uL+ABN8W7x20BBcTaAweerBm/dVqe6Xvof76nAlx0JwdAdafIVzp4DSil+S8MaEI4YDWESHu3bXgF4FZt+hD3BrCC4dFVJLYKk/GV1uXQkBW/nfPVnwBeuN3fCbbglyv4bBHTnQH1fka/wsda2i+loX4oAsPWcWs+B19XVEkFp8uRYqGtEV8GQszvhlcs3kOLu08XZpS72SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kIbv3KHI97zLxe7l1PP/6CciLO+U1PO7U2TvoAanrg=;
 b=PZVyX+wed4TOBe5HAFgqMO1TDAEIv1KLa9jqfAF/RVeIFciThpGyZGwT19I0pb9N3k3N7MM6PPOEWtk2n5A1Rv2G9nCHroemZcLCcgg1Jf7/GJ3lNcDGvz73JRZ1wxzv/8EEo7gFnoQ907H2cjTvGGW3e8tXkktTnDZr776IYTSu1wbMWb9mwJ1gof/wM6qB2/eXRNO7zSTic2fzdeCu1ZoA2X+vlMdMQqwEb8i/8zEoPmiE/MuJY2v8S3T5zI9bdxvc/kqmIGvmwewLlTFWgISMjCUIVDUkZu+cR8y90bzRNg7UvUokwN9RulYFZjgTszeZaXZLXeg2V2RQN920FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kIbv3KHI97zLxe7l1PP/6CciLO+U1PO7U2TvoAanrg=;
 b=yaE+LgSgiTCraElcF322Lsu3s4svUXegpEiWlR4UVlYGUcqgb7im0J5K+rF3fqsdonv11aIlS9hgKO5EXm8ykoHkY9AmRrWPqUTu8w3lRJOCpphBF4OwP55uATPJcmeUC59PgXUlakyXZqDgFuhDy0KAi0dwPb5BnfOTDO8LjwE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 00:17:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 00:17:14 +0000
Date:   Wed, 14 Jun 2023 17:17:10 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 3/7] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
Message-ID: <20230615001710.GC38211@monkey>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-4-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-4-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: ce23aeed-bcab-46f7-8d91-08db6d35de99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKrbkLZXQqQ9MUs1eMsFc1zVUPp/JRtz9gsNYWbMn6JdwBAVYkrVZL91gxvnd5pEMaOyU3D3bmviw1UQPdYpxXvw6uAhsevc9DB5Jde1pnlsh14vAAgGL2ZNwC0zILeeBftC16AvlZYfC3zSHL1tw+W1ur2fw9Lr9MJmki7wzW1H4FsfvKNHkmNzBVaCMa9gTChHNH5rzvLZwJAfekyk4dg4U06xTbe/D+LJzEt5tDiuUGN25cw8Mu0mVQqZenc/49WAXD17BJAI5irx5/2qXvvZaSe0lgO0f9HHK6jHMQ+APTq2psUmGD4qUc21UvSiFrLutYJ62TttOTYoVtv007iYoyGTy1kagZReNW1jdJWj+yv8x1iK+u+wRUBqqI0UtMG8M1o+rBkVW8BqtUpwREML/Kn7Mut4qtnqtH8pjFnOG1v3AoBxCi2fCcz0rMnpAnO7SQJs1pkSHWKInJSxB9GtGctXUhLE3sVAXHC+l/bxD+LPDNBQOtnt7snq1VHiRCMIII5EAK7XB472p5VzyGVJml84WvgiOFZBO2KrKaOUm8vmhnbgi08krjzqpg9m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(6486002)(6666004)(83380400001)(38100700002)(86362001)(53546011)(26005)(33716001)(6506007)(9686003)(33656002)(1076003)(6512007)(186003)(66946007)(54906003)(2906002)(6916009)(316002)(8936002)(4326008)(44832011)(66476007)(7416002)(41300700001)(5660300002)(66556008)(478600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sxf/yXe4WajEGX8JQ/C/N4s4qk0arADgE2eXlyXHXZojMYxHGi2jKSsJWK0m?=
 =?us-ascii?Q?1SnMHyBFfwUGBpnq+qMhVHcK8uvzrCGeh/lFcdPK264fizdl3jJZcZnBxE6o?=
 =?us-ascii?Q?oXUlKvEuoYeJcvYnQTTzMLP159pQ/Pbah4xKBcxjsvFTexH1mQUAXQyLQFsy?=
 =?us-ascii?Q?4XmklyhT9j79VMV2G6CmAWmZDLyG4dGD/rB1vOrVniFknVqFwjWov44kcFns?=
 =?us-ascii?Q?xygM5pSUaJYlyRI0kPi+iPwyr7qmPcYkUChQ0qamr9QoDqzQbGp5O2tS/H4y?=
 =?us-ascii?Q?cCAEKGYGuR+X4IPZ6CPCLOgDfKSzh6QDx3lxmSf30EumaodFzlt6YbeEayUt?=
 =?us-ascii?Q?/ffap/6GfYSJ7oRMujEhD5WIvPEoLCfoDF+FftzD1bOQ0pSkMexkM9hEc86+?=
 =?us-ascii?Q?bj/qTGHi3w6RJ3g1Brd0lnRvwQ9kb3nTAx5E3ozo7uBPIHxl49kLvRF68t8D?=
 =?us-ascii?Q?quDCuKm1xJRfl2u2+lDnGSlWqYT6ZgSw4Ljanf/ngtb0tVix8FKJAZdI1Tzk?=
 =?us-ascii?Q?5r2Pe0EAtDWLqde9F0PUOMbcKGFbfi6wQx5OGYGK2xTLdiljnpX/d7fQfr09?=
 =?us-ascii?Q?iwWd+lXurH5Z33DWEdVtGum/DooHrp5K4PR/4BvWQax8UASYJcdOC2+1TGAM?=
 =?us-ascii?Q?rerkcKYGnVU9oasXEgyYqs8ruzH8W4Yq9IUNKMUlODi+29Pwdfcrelk4nQfE?=
 =?us-ascii?Q?Xkex3omWzvEr8YJU06oR/b32TfSrvOmO1wiW+q5vzRLNz8af9jC2kNBnDEm3?=
 =?us-ascii?Q?8XhgUZ835rFzE4h6EJ+uc/WfHFQrw3G5Ngr6K3zQH2WdDQ1eODYY9AU7d2RV?=
 =?us-ascii?Q?dEymRYsVTQQmr+kX5KcrZTxmt6D2ri0rboJpumeIVh444tDC67vMtFel8Q5O?=
 =?us-ascii?Q?NKTU24TT6DOp5//8QRpk25IRdXaCSjPV2DTyszDSHu6fpOSE/vdNMcr/OXlr?=
 =?us-ascii?Q?8uy7/zTqCdb29W3vvdwVNG1e+E1HvdsaTH1HNECY1xx5NWnunsM+oKknSrNx?=
 =?us-ascii?Q?9Ri7cQ0xRyP0rlozOjA9Lge2yvopWsKiWT1neXi2XYlhMkfTs/iSg8FGxYse?=
 =?us-ascii?Q?cxWlefOZgC4KA46N8Z1p4GJq72PAY8oG6j0Umd/X2lFbsDez5nesIMMMjNOr?=
 =?us-ascii?Q?LZBo/vrVifh9INcWa4OOUTVMvlRuljys0EW+5pJDx1LUV5DCN0OPVeTtq3qM?=
 =?us-ascii?Q?tYdEHhHz9UyQ46GkkpJb6vI+MNovPh10/W8UMQoGRz7B0QmrefaPUt7nQ0iv?=
 =?us-ascii?Q?87t386sesThDShlLCsFPor02uxipdjdirxMdlqD9u3KKgrbWxe8cshUk4Bmj?=
 =?us-ascii?Q?a43l3udcJT511PDtEdgv+L67QLTyHVZwJMFhXGTjgviaiUDIiuDzhEOwG92M?=
 =?us-ascii?Q?h2ByaIBT7I+nR614hFM2rCJpEpNBu8hmY8M/ojBX4v2o+W5GnxY2Yozmp1+N?=
 =?us-ascii?Q?oiH7BpyMd4sdZ/WZoXJJY8F/8TuotEysQwCdV8wThntfXvbYo7Xiz+peo8RQ?=
 =?us-ascii?Q?Tu4M1paWg1hbwDNcXqdx65JL9NODjwqydP5oM1kSXdmpe50SjUMldsAtiHuB?=
 =?us-ascii?Q?GDbBmHw42cGgtU34SbQgbtUz70HIzC9oKYpBDqLY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rdIZDiOyje03FNZPSvlw6EYL5bse3Fryz2Jrxz5ZyHbUENsdysjAPUNDIQqS?=
 =?us-ascii?Q?wYOsMc8Rvb5D8Qm4h55iNfpGhj1E5j1Ssga6dIsAv+94gHF18zhQt3FU3ux9?=
 =?us-ascii?Q?wTj25h4SK1tTnp6UgZHB3YxOCKtsFXVJc9QqXa2MVz3KguevvE3Q4vtVfXPa?=
 =?us-ascii?Q?nXQgz0XpozwLg1yBvOo4jmgkjYFtghAO0WPpSfymT0cZc/37PeMXOL+5DPqi?=
 =?us-ascii?Q?Dh21HHUEOxV3XJnoIZnpfh1TwtHN4qFlkR8voVVtH5iViRijXHzADc8EvAav?=
 =?us-ascii?Q?s0Uz2NLbsljzM10qKunwIAVd6osMx8rGnPERUHfVG2qFZM7ciHmaUADiH5qq?=
 =?us-ascii?Q?QGqwD1pt6ea3xtM6VkzNOQhLBJqUYIhQxcKUFKedBuU40C9854ATtkYEYp11?=
 =?us-ascii?Q?+OSglHomCFVlntsJCDLe7hCi4J9y7xJyfh1FCikGvf1+cPwuD0j+m9WYlAvB?=
 =?us-ascii?Q?l0SazXLgUS1R5DZwku8sYv1DxCyhqQsNBly/dzqESeUA9p6UpH6Y2g978xCe?=
 =?us-ascii?Q?VFsats5vF+2V+mwhLv7dsZqFuxYACpe2AXqm0wTiV6v6CeBMc7GAAfzbJ3mP?=
 =?us-ascii?Q?zQ0ASafUP01ohuDWCbqpHUNx3a6EM4PGx4MCaE241wBnMMpteNAAow7Tjofg?=
 =?us-ascii?Q?UjwjxJaveS1UDCcvH+u0LcLWT619u1+Gya5vUSZ5PnI3HXUA8lJPFw0Ymoog?=
 =?us-ascii?Q?B7uZIIp9mG/Cvo+8vKFAfK33+Ukry8GwIIqxJkD/dqhF0aFmUmrf8ypPzYRi?=
 =?us-ascii?Q?BCXXm8X9GFjzcB4F+C9cAHfXtlwNdZsamygKNGc35G4CvoFCvxqz9as+EmEu?=
 =?us-ascii?Q?8ztqiRuB57RhvD7oBEZqoX27rxYh4Rr6cYPL5v84a1dtcY41HINHy6vQya+Y?=
 =?us-ascii?Q?FRqNXIJlY8d9fdt2OAJmShTK7v4x4d0t+9dCwXilVsSAq3bj/21Nbykw7vun?=
 =?us-ascii?Q?VXehwTq8enShfg33Lk5ALaR1Unh1MD0FiEKNDpzYKGhy575KGC4/LaCwc+HF?=
 =?us-ascii?Q?zeIO5eAeA9YwHloabDLQD8B3VsuCRYJvWjFP61Eq2/K5XPZVI9LHJg02nQom?=
 =?us-ascii?Q?hbPrLLOT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce23aeed-bcab-46f7-8d91-08db6d35de99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:17:13.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftb1S1bJXNTPxU981TzwY6Usr/YNA8aCZgkeovT7nBuNW59dLEA1a0G7w/PComx5UPtsZX/8mQjDQ1wCJ84UcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150000
X-Proofpoint-GUID: ILDEUCCb8rYptS3k5GbTt1AMTVYDKehQ
X-Proofpoint-ORIG-GUID: ILDEUCCb8rYptS3k5GbTt1AMTVYDKehQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/23 17:53, Peter Xu wrote:
> follow_page() doesn't need it, but we'll start to need it when unifying gup
> for hugetlb.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/hugetlb.h | 8 +++++---
>  mm/gup.c                | 3 ++-
>  mm/hugetlb.c            | 4 +++-
>  3 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 21f942025fec..0d6f389d98de 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
>  			    struct vm_area_struct *, struct vm_area_struct *);
>  struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags);
> +				      unsigned long address, unsigned int flags,
> +				      unsigned int *page_mask);
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>  			 struct page **, unsigned long *, unsigned long *,
>  			 long, unsigned int, int *);
> @@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
>  {
>  }
>  
> -static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags)
> +static inline struct page *hugetlb_follow_page_mask(
> +    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
> +    unsigned int *page_mask)
>  {
>  	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
>  }
> diff --git a/mm/gup.c b/mm/gup.c
> index aa0668505d61..8d59ae4554e7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -794,7 +794,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
>  	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
>  	 */
>  	if (is_vm_hugetlb_page(vma))
> -		return hugetlb_follow_page_mask(vma, address, flags);
> +		return hugetlb_follow_page_mask(vma, address, flags,
> +						&ctx->page_mask);
>  
>  	pgd = pgd_offset(mm, address);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9c261921b2cf..f037eaf9d819 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6457,7 +6457,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
>  }
>  
>  struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
> -				unsigned long address, unsigned int flags)
> +				      unsigned long address, unsigned int flags,
> +				      unsigned int *page_mask)
>  {
>  	struct hstate *h = hstate_vma(vma);
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>  		 * because we hold the ptl lock and have verified pte_present().
>  		 */
>  		WARN_ON_ONCE(try_grab_page(page, flags));
> +		*page_mask = huge_page_mask(h);
>  	}
>  out:
>  	spin_unlock(ptl);
> -- 
> 2.40.1
> 
