Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19366E03C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDMBhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDMBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:37:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE240CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:37:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CJT9mW030125;
        Thu, 13 Apr 2023 01:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wmotSqTlKWPT7Kacm94G3KH0YQMuK+t/suvVcL7tAdM=;
 b=pLf67DSOnJ8JUL64ad/TRC9v1I6jJPaTD0xDQoTOAURjpRZUEiq1dMlbGMkMq5za1jd1
 XAWp8XEjw1fiMNRzHMLADQsn6C9oOd2CJXry5V5boiB9kkRhz/L5NmNebH4A8hOjZf2l
 8em65LupIBJ69r0H4ja6wnp1PMSVtnn9jMZ0meNpjgyhwdd4pnAQDUqLbcqSqOElYbNI
 rWmHK8e8GzdwatblMa/RVbHEvYOL9XWaZ0SIJImwivoEOaYA9lvzfHHeJgAnOauJGdDF
 oTyaAGE75fAkK6nW2Mem2fxbnqxxU6aFbaJHPdpBqPoMjFWwl5dOm5t6rNcTYhksGh4m JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq9ss9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 01:37:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CMaQk2025114;
        Thu, 13 Apr 2023 01:37:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdrr3ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 01:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCraOXzNtmNwQU2FuQVqNlAeczEnw9FawXkNtJU8QuOvLtbd8i6ldtjLAiSZZtk3DTOrQ1th9qCv3EnRmtrbT9t3gDRk+AsT8oPATLTkOz32h9uoBXd28jeIt5UiPiE7jio9bI0oYF4AGUQNalNtFnvO65F8ROd4XsLU6CRHDjL/+D2oadnBTpdFixJVVigFVpJ1bXBzlv8Lx+oB7kH7nJZnDpOKqMdtw2JkcoXt+KRwqd8+c0RwI0C9Jiax9eUFU+IFHOgIHMv6fYYOuoIhGFlTe7bW28J42gV20o4oyXj5sHjQS0BEmrvRcbXwbVIwKF8JcCZGA7iu8OLNbaKYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmotSqTlKWPT7Kacm94G3KH0YQMuK+t/suvVcL7tAdM=;
 b=gwIiH90QJFAFxrnH90dh8sqG8KPbN6IT6sxcDus6LyXc53D16yHLa/OnUUSBBhU9EzxJEpOnHkrNHOphVj2BX8yHsVHj7wb5D0AQyBll5Zyo6ZhSc8ACb3OhMbUxBiYCvR9MPQUBJ9M2Ub377ChHR7U5DXx+i1XfJX4ZfJcV3onHqscOQJWiMqyWW9qpXSZxZXKIs3BSD9j+IPk4WlNMC/Qi01WWF/wZFXrAZnpYY5O9ez4EmhOQZsH+Az7ceipZtUjpMfDc07Nq8MkhOXIDqmjmBiQUOb7bpdEHG+seSGBWcrOzXOhQLEaIbOmW75Awffh6kFZWu9UYk079sNdh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmotSqTlKWPT7Kacm94G3KH0YQMuK+t/suvVcL7tAdM=;
 b=schMaAumDU6Uvv3AQBQo927zBHNop338tyEYogI4KuwQAVcAWSzWnlSuUbWN04kq3A7rKxKm2wfn2KODLiu7mk1loNls1/3BAyDbDLoKFzMHp3MqqGNSQ0Uxjmv5PbnrMfU1oFuKMvPH8D8nJtkO606lHT9yHDbLUQDbSKVhg4U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB6304.namprd10.prod.outlook.com (2603:10b6:a03:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 01:37:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 01:37:07 +0000
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq13554bm4l.fsf@ca-mkp.ca.oracle.com>
References: <20230412065736.GB20550@lst.de>
        <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
        <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p1>
        <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
Date:   Wed, 12 Apr 2023 21:37:04 -0400
In-Reply-To: <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
        (Jinyoung CHOI's message of "Wed, 12 Apr 2023 16:12:30 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: a1765f40-b011-4660-50c1-08db3bbf976b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+y4Ts0sKbZodoN5IdowIpT72tr26D2W/W610p+MdOvAP2XGeVhYGYq9R2EFUKSI0moZJOhMcAdWPkhh0XzZgCjQvQrk50egiUHmUdZd2LakKcpjJKm41CRkepNBj695NiwBjh21lZ/g2sx3CKoIsUvoNfi6ABuHsuG2xtIAFfH+lLSeOa9G+1voQrHD7VEipZFmqhOfgW7kATX2AWk8ky7H6slxpWvgGND7jT7lactrV0G9UFTwYJrFt2fVlWIDRk36g3SvSEE1lRCXMEl9Mj+K5K/MTdWIcCkNUkjqucrs/lu42hvmRRpEfmG1z6dZ4iiGDaGLw8oTLVB64/Pq9D80gPgqpWmbycf6rIjODvgeOGlhcAbVVuD3pgAe3fMuL3VmaIojnE30OnSTw3A70293gHiq0ntontWU11O2b4mTfBVAxGG17IzHXPsX1QB65LwUOEXN7gSP8cMLc4ZBSIzkZgxsbsPW81Hng80c7vIT06ycNIZqWadylcBKjTLLuzmlJr7Gk74/F78pd4X50POVyXWfQDtJHh2dodtGdQ7FP+HaxFvbSySNYPmYrEcW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(26005)(66556008)(66476007)(6506007)(6512007)(107886003)(2906002)(4744005)(6666004)(6486002)(36916002)(186003)(66946007)(4326008)(6916009)(54906003)(86362001)(5660300002)(8676002)(8936002)(38100700002)(478600001)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CkRRIGf8gtF/DpR7nMdrLtBcGF7G498TItpmraUDrJGbAzWIJ6NRvYU0uKz5?=
 =?us-ascii?Q?+3BYvFNBEls9kNc/TptvhyPjKYEFsAZp40KBgRmmvfb91F8DC5iBt/BlFARp?=
 =?us-ascii?Q?epQOlub88+DhTfEzyUodlYpw7X59Nr7PVhl/UghHie0Noes6Xlx10lD8XUkJ?=
 =?us-ascii?Q?GAhfut27Pa9d5rTQR0S/ZCQhdc4hWAGey5BOj9yRQzjPVmWm1micYbSSA4j7?=
 =?us-ascii?Q?OnMLSzNLKTMCy6oFqC13xEImCr5tuN1ktZW1z8STtAn4T6RGm49SWD0wBukw?=
 =?us-ascii?Q?9lt4tzp8tiweo6ceNekERZlwOmJRlDW2G4QiiEqu3aPx3oPQ1Eoc9P0nRLXu?=
 =?us-ascii?Q?UhO273yNq0IZHGwokhjq+xT62baOiVbM02ZnWuwCH5fGBJ4A5zzdpW7KFu3e?=
 =?us-ascii?Q?/WdLDT28b1RI+Sc2dGiE64goTYS/rEvh4N26CS82nbuBYuyhoOKxpyjnv4VC?=
 =?us-ascii?Q?CUNAW6wwUMrFkjQ6rIMXjSOBOLh9aoZ2elUZzDfTGbeNN9YlBM295PjH/bSP?=
 =?us-ascii?Q?KMoQdTflkG+IFmnEfx/TtBltazSE8PsWabn6wSWPAnzxPyEhG2kba3FGtKyU?=
 =?us-ascii?Q?vYSfzJanDnklZXZvhbGBzN6MJJefx63c0oTVdPsvC3TrDsCQqmCuRunfahPr?=
 =?us-ascii?Q?cO9emvVh61axDoKRGXQ/Uqx+NQrwdYcL7+u9mJeZotkAdFAKulh1KVzRibyz?=
 =?us-ascii?Q?RsZtzcigduBecWowACbn165TwRCK2C/EQ/sYBtNFISRC9WvH00Bf9s4QY2Ox?=
 =?us-ascii?Q?rx943SA8NgQVG1e++I2ff4y8iraNPkdWPyQ8wHA7Zye0hwxtjXySdhIrBPLC?=
 =?us-ascii?Q?734KW3NLhzHHlr10DkU2+yJLaiAOCyrwzo4+ZVZwf664w9YgApgE1XGP0Uu6?=
 =?us-ascii?Q?Gzeksxsw8QufYCz6SD7hiA06IKtTEyA5hlLVAl5ezZ/2aVlz2Ac1P6RHbTaW?=
 =?us-ascii?Q?ObadBKx0ghJN6JosJyrz4fVoNLtg67OeVVflUlBocvwQdEKHGmWp5X49VMLz?=
 =?us-ascii?Q?liGWkMnh42zOQxDqJbSUkt70fD0nCw+mbjSTGo0hCDS4Ir4VPtCgLBGvUlQO?=
 =?us-ascii?Q?St/mC3KwJUVft+Rlb648U60Bb8mGAb1e2sKFvqRi/li25Bz8GeARha6KgN8P?=
 =?us-ascii?Q?jDOxqDLzELv50bYsVkZ4tFycS/iI8Tm6z0RR4J5ItbgLhILgn9kH2ilC2E1+?=
 =?us-ascii?Q?YvpgDUyt9hXTCVR2H1JPz2gC17WBUrwMqlaoT4Q9biQHbons0CQ67vnIvuiM?=
 =?us-ascii?Q?ue3XXg4zw8JM1K0dB0nnbpM45CW0pnAKMUC7hzYGyPg6loMsiIS+LbQYpaIK?=
 =?us-ascii?Q?5ZfZIP2az3JVPvfw8fFJ644lA8jAyLVsIj639yJ6MRLwdfl7ztzRSY3dhgeR?=
 =?us-ascii?Q?odkuiVZHJ9SZ6dIoqpIuB8++xA3klctBRjIleK8TB9jForLxiSl67s5Zrgd5?=
 =?us-ascii?Q?9P01LecH2a2/BnZS0/DpQIO1L35p+RwY5B3BFVYfy/FZMZf1zKnbO8XHC51M?=
 =?us-ascii?Q?tacfQ94gVdtCAfSpKR5Ng3EEhjN2nP4pAwBunz09lVLMRwDHJkCQHrg8l9Bu?=
 =?us-ascii?Q?Rsd3QIvgalMxkmLXDV3cnduZl8/Bvf3e5IFZjyqkoNmtcxNlwgSdzm4fuC6D?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Oan12rQG9r/QgXw3DWysIy46JHsHJ61OTwGyxOfmcssJPwLNhT4T9yPrZN3s?=
 =?us-ascii?Q?HCnbgi+3hN0N1uTqw7tjmHHZjGe95vPEoE/Y1GZgylHe/6B1qdgJcxa5LzLg?=
 =?us-ascii?Q?CcNGy/CjM2Fnh3JAaZMOrXbsGCyZVRUgYsUQk0tFj/eWul8eAesMAS6Gpd2G?=
 =?us-ascii?Q?aLxCqVX7Z4IQKM9XpdetK9HHl4bLkV7d1tvOHuE24aQts6HexTojzvKt8mhL?=
 =?us-ascii?Q?gLChDXGMZ/STM1jg56C5GJHlM5vf7/NShRU4WEd0rZuinoNAhJ4Nd3638fhq?=
 =?us-ascii?Q?3AjycCoC7R1fiFaBFUrwz7rO+wuok7lvIb78bX9TtLSCkGuwK4l7P+y2S/YQ?=
 =?us-ascii?Q?UDx1Mq5U+W3+7ry6KsNF59rNDjTmod/YY9kq1l1i6xJY3qB/hkiI5MfBIoHU?=
 =?us-ascii?Q?5sowgkd/X427bPkrhZwmlUjWmKm9c6ywfS3VmPLT3aV1DkWSfvMxArcvYRbA?=
 =?us-ascii?Q?W4a0EKUEcN8LPl8AiHsEeWczwUMooaqsLQhQsBntoQPCHuS9n2uvTqYnFguy?=
 =?us-ascii?Q?JhJfodGlliNvtZPMlqKu/UAlejbcWjVpdABCylnkSXEgy/ff0mBR385TPfit?=
 =?us-ascii?Q?aFqBwpYkFOCaAvcXGEjwTXGKJ2ZAus8T2QcSpRKQjh7e67gtf+J88AgyNwWe?=
 =?us-ascii?Q?/5gjQDZLbQMTmisAldmwQLiUSUhp4Mqyn21M7JkrmkIJuytREZp5cf8aWAVh?=
 =?us-ascii?Q?gFzaOiU/OCPJzy+aaYdadIb7UxDxzKboiYrKZUYQlADloTS5e7a76FAuNT8D?=
 =?us-ascii?Q?ndcgvKTssjPUoph+/H4zs4hy8hDZlF8esKvPnqSDgRJ9u6QMC11wlCVwRTen?=
 =?us-ascii?Q?aaiid9GMOJrGxt4PVz2X0Uxhurh7als+e72nD/03wSVtGbkYcQMfBxiRHYNg?=
 =?us-ascii?Q?K3L5u2bP+Zp3zpXNmvPJ5kwWIdT5YNlirDYn7HMvkvpAjP09N+5NHEM3TrHn?=
 =?us-ascii?Q?nkq4pnzP3dsw0KQHXFjF7w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1765f40-b011-4660-50c1-08db3bbf976b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 01:37:06.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWSr1gbbv+kJeWHAdc1RyH5l+TT9Aa0KsDbpdnRuwANNyfEHpRvVXHH/zFXxgixa5YJp3l5aF1EG4Nu+TDcLlSiieTco6rjY3hcLDg7Rm14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_14,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=580 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130012
X-Proofpoint-GUID: 0223pjNQIxf9jivHvDgPXWR7QBoGlBBC
X-Proofpoint-ORIG-GUID: 0223pjNQIxf9jivHvDgPXWR7QBoGlBBC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> I think the problem is bio_integrity_add_page().  If it is modified,
> sg functions for blk-integrity should also be modified.

The bio integrity scatterlist handling predates NVMe and wasn't written
with the single segment use case in mind. For SCSI we required the
hardware to support an integrity segment per data segment.

-- 
Martin K. Petersen	Oracle Linux Engineering
