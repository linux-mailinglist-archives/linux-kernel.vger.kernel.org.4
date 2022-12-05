Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5255F643829
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLEWcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiLEWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:32:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D9C60C9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:32:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5KOYRr004391;
        Mon, 5 Dec 2022 22:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6Uw/e3BEbP4zA3vO91HjwbtObrvcsaUAEK6qT2a5s90=;
 b=pIVwLMBUiodXi94maJao/TUaqr3CZx0odVSDi27gFy0d+iAnvwh1gaEjmkKdc198Sore
 CzD6tuhzOCMvjC79iUyEFu4u6SISq8/uKyDQ2ufyxiVy/cSZvF3HJ+BBydpfVi7niORN
 luBEP2iqHvdEQHdqryI7Au+haaU9jWWjz8vY8+bjT09cNgi+lhWzy/HejuxmIEXDij5T
 PSBCQ9q2ecPvMaYCiNXRMxyMHjCjIgajAhGGShDvtnZoPaGBfvvHKouvgtUqqklREHZh
 69fakYhCPSugJTppOD8Ozc3zZM/eI8RLX91upNfH7md8kuln9a4fa7D4p8KEStIGHmMP vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgnek5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:29:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5LLaSI009370;
        Mon, 5 Dec 2022 22:29:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugewa4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 22:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPFraz33PjHism62CbImSk/RGraMwelABcWh3vzU2CsaPqs6UPXQFteI16UbtuT8DXU3aDng3gZOAO/DvdKNMj4Sl6QE4TLDXy9eSz1SaKxj6QHuJNDGeK+gDeuPyRmX/E66bHJzwUrgItrmUXH/gUtL12/vx11+KVjaJ9OPO+gZdqiWK9ea/f5ty/fga6i6GpMimOv3tHBtWiW6ymtfEvw7ZiRmtNhWX1RoPogknmXWMSCNa3Bq2Sg95Rsh3h2aVC5/SOYegHkInLEHitsedx4waj1rY9eIrpRlEwzOBXnjarN7AETDIr2MZns3H3sSaUYZgOh47XIMZGfD6nUOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uw/e3BEbP4zA3vO91HjwbtObrvcsaUAEK6qT2a5s90=;
 b=BfrqHy5bmNpfU5S1UeXijUFlq/Q/Eeo7dQZ+ji+3ZNNJ6y2z98w5x0+YZt00kjQe8QNi1GyT4SB80PO+UGd3bZxPNeF3wLVa/VW8f9dzB64GFwulNLB2HsUzFuT2Urjt4I11pG/2d/FEN5XwnJDKWFt2mqMWjb1MlHxRQgJB1ehDFNWS2AaooXn9u3Sb0cu8MhjyVoK5+9P822TtediEe2cPj5l8h12U0cN2zeTM/rIxPceGVI0cWLnPeSSS0xNbl/kzdOYlAemyky9RpWFw8b7CTLBcIn+cVqdQAGOgfXKT4/ac6sYLSbZR8CWlex7LoNmu5hiOJ/fKDtCHexQ2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uw/e3BEbP4zA3vO91HjwbtObrvcsaUAEK6qT2a5s90=;
 b=p/GRgnUWd7NiYmEW4Kg3EgG0mLh02U4RhrOOUv8UZgvovxYYeQcT25y9ABW9PhuInemD90Ao4xSWXmKUY5hts4eJpHBTSiqzDDszQsaJJYwyMrHBz6S0nTc5YEDH6Gt7NNszmPIpei4EMPyYHWAUyqHaALg7jIk+Vh1CHfuutVY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 22:29:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 22:29:46 +0000
Date:   Mon, 5 Dec 2022 14:29:43 -0800
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
Subject: Re: [PATCH 06/10] mm/hugetlb: Make hugetlb_follow_page_mask() safe
 to pmd unshare
Message-ID: <Y45w13WvB9K/G9qn@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-7-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-7-peterx@redhat.com>
X-ClientProxiedBy: MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ccdd45-7116-4cb4-73cb-08dad71036a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNOWjzwC1YuZx6DLAsj2S6JDuusuQyNFif7Z9lZJvdBTLIK6W3787QvytCDFvDW6s2zE0nkAgbrOBDGT5tKWBLuzYY9OfF/A/mMdIIsx4EG8JL0g9tzW7C6NLqZWVXZEeZ6m1HRoWYXrrLsyz90HXZGIPw9DYcFQ97QfkdEklU33gmp/dg9gW3n2nHi/Dwx4SFhDChg/xEFWje25MgoiXOdfBTx50m40yZGjJICMQQVPdjdq2S+rjPryF5M8O/FU6wA2P3A+JT04dolmwcFWVHpY/90xXpUPh++d6BoBkX+VmxtJOgqfBImq5shSLpHWQfmEP9aeUK0my3ZhdhBOp/YEDx+o+JSiRRzry6NOkUmWQYidWQ80sesaWtDlL9g00TFnw6PjJG7KkhPB6qxnO7t57aKDAnuWbC6fn7bijdC0d1hi3nguA/rwpiYGPs81+QCd0i3aYXDK8JM3VH1CdNwgZovNIsqqCkk8wKaG2sZ1X515eo9RWuKM3T0zGCH3HPwJvW2qvg3ovPJagpHgS0Shh+focNL9gEd9EnAWxXu6beQGQTkEouzDy0kKLNKjTjuV4ipOVM8oh0rAlbstJfY9rCBAA2uXY/4knw9VolMMWC9YiWjdsnGn88LfknJnyHojwocIj5REnU0MkCfEVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(478600001)(6486002)(26005)(38100700002)(6666004)(54906003)(33716001)(53546011)(2906002)(6506007)(44832011)(83380400001)(316002)(5660300002)(4744005)(7416002)(6512007)(9686003)(86362001)(186003)(6916009)(41300700001)(4326008)(8676002)(66476007)(66946007)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgCb7CwxGytbZ+X4OqiQsM569G/z2W4aHvC13/drIp77YQHhkgmcUHi+ECyG?=
 =?us-ascii?Q?hxB3Saew0HWIREtI6sbkP2vY9s2rozcBZJHz839DyXdI1Shk1siJLr6FmAPk?=
 =?us-ascii?Q?a9Kz46iTPDFnldwqqmda35dYztflK3KSvkQ3Vue01IkiZU9RJOKvg1JOnTDA?=
 =?us-ascii?Q?L0IoD9B0Ibex9iajkXqq4u/Tsx4LLrYvVgsNNfbdW1YOGNON7i/aeBjZc54b?=
 =?us-ascii?Q?4Y6EXFzB/BmB5B0gscQ3cyvT3DYPebJ9wbtYu4vkqVctbm6FK5U6Fg4TJ89R?=
 =?us-ascii?Q?/Oz03N28bLE/v1mdWc6EPyNigHGPCPGgjlLBTsSAu+xPSjiRz7Nvvxp2h2ew?=
 =?us-ascii?Q?nYHLedO6ByyWq7mcp4LAxfB+MCNPr5Q/KNa8/YCaziLYo+N1j4XDEVe4XGZW?=
 =?us-ascii?Q?rVuAE+UlyYUvtlLLIduXDnkf/u7uDjv2VZw1OBtEFf22blpVIRpHvozvVba0?=
 =?us-ascii?Q?aSmwm3t6/GgIWEuYrIb76Tu2ISQboxxBTOXmOkXfYNid5hjFIbVVtIv2RgS4?=
 =?us-ascii?Q?+TX5ZaGO3TylQxL+NmIUtGGFBT0O5eXTp9CEd4TSwRR3PKXjJ3ixPBEohuq4?=
 =?us-ascii?Q?SY9LbX97IWxV/4D8A6AsYw6KJGRi52n+8pd1AuCCMG1UjuJdBI1+yWTMSdqK?=
 =?us-ascii?Q?vs6mXh9y20PDTozTtL6OtdCg9AWSLD1zmvuhu88VFoYpnjKZ5L0kwrHghXvj?=
 =?us-ascii?Q?GllMk/yzzcFoiNSiufes2agNNPhsZMmg5e9jILzkNy6Rbg4V2idCfzFLHnEm?=
 =?us-ascii?Q?wzFbA7libnRqP4GN0+8eyLz5IevxffeGxxLW0tY+NXx31Zwq+OcqICw495Sb?=
 =?us-ascii?Q?trNLSa8Sd84QpfDQrRkGBGe2AHtMv0vQRaDi+sK/T9RQdGuO7T01ZMmXdeNQ?=
 =?us-ascii?Q?u8ap2MnVhWfy0AUnGjWVjchuv1LywgpWW5+EIjqcs4TiypNfgVX88ia+3ZRp?=
 =?us-ascii?Q?pBuyxhCDYR6tFmKs76+e4h8r/Ad/h49U5JSkIrmMEk2iSdmXnwhsOW0QQZ54?=
 =?us-ascii?Q?NTXtR1j1tNz4c8TUUNVHNRR4BDsIHiG8hES7mp65dXirpyOEEpz1mKVfb66q?=
 =?us-ascii?Q?LuUiz35yOK01VEBYIhD7yAwDtoBFskukA9U4f/Uo0tsl5kHOAAziAakLdZ0B?=
 =?us-ascii?Q?hGFDrUDHrDsUKgoYwkpqBO800M9ssi/ZPzlsCTE+68RiIOEi22rRq3En4fUn?=
 =?us-ascii?Q?su5nJ7JRG0MhMnop1WIo0HXAJXgh+KgOZPCnxak0d6uH3iWdE0eH0Bazcrw9?=
 =?us-ascii?Q?TJOcF3c9Kur4/Z3bx9J1Qy9IOxoNaXPjYniZ4EoO0Uvt0aI1Ds5/Yfk1w3nN?=
 =?us-ascii?Q?n0BzSKG9I3IKXybwbYgU+cx7ICo5ERX+w2ChiK2irloYHDSQDc9sNcGUa79R?=
 =?us-ascii?Q?Ktin/W2Z+iQJFgrdiX3yS141bhZlvCbIccZmj0et83b77lKrbMlgjC91OJZt?=
 =?us-ascii?Q?KxrDELKqDmtXXZUmrN3NHauEwkgoSGYl4VNqjxdnvolU1Br3FBrljHEBQV2F?=
 =?us-ascii?Q?XcA3AkvqoxRh73esM6oyvxEovqgNBGrKuZpwUf1Pn62RL1cWRVwMsrgulMB3?=
 =?us-ascii?Q?YszezuLv0Z2KG2GWg+vFfis7t+3haBfOgg8bJqCvhqywHH4sBcFdj29XUuO1?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fkMHDMYNNV6i0G2pbZKObvlXCJbQ8Q4w6oRLYa/PdWb9wPVQfYyTh8p6vvnF?=
 =?us-ascii?Q?e73BKul6cWuEiV/nmOor/AKxc13PUjycI6Xo44MyCbba656BXkPHVXyKu6PM?=
 =?us-ascii?Q?UjjVpem2xUdLX0YNldzlCHRC+9Phtc+9xP+vyXa0SntAXsZyJI7grdjtuG+M?=
 =?us-ascii?Q?++ZojOicSOZnCsLxy2lJRZXfIdi5039kK/m3VH+oYUiv4IPLRVU5NShjTBi1?=
 =?us-ascii?Q?mJUSZE1woosZCmM/H7nfL+3GTDrUIFr8FOAn+l3EgJzbn2CLMSyLeL5U4Mqv?=
 =?us-ascii?Q?+wnnvYvL0C9TcHqQ/nbVM11WuAMyBFoeifmtXa+v5o6mK03eN//YxcoVrBFa?=
 =?us-ascii?Q?GD/6NCE/wX31zuguUrGb3P8P5w3a/AI9C5NJs+K9UHPGTXmhrjHKZCF6wDl2?=
 =?us-ascii?Q?vkb/g1+3bzmahaw65Zcpz4TQuyZwbiL2usuj9yRuttNqzVX6qakqP74Lm6rJ?=
 =?us-ascii?Q?ZhfX1qph3AXEOSS1NiV2I1vhTDDEK0B3dBx0KkJy7v3Ij7lvfCMfc+H22bas?=
 =?us-ascii?Q?/wn3+Id9GovviLZjGGCT2/XU5iGmFEd0H8LT6dmAoZL+vU+Zid26nNiOtIq7?=
 =?us-ascii?Q?2bThzySYp7dxew1JCvkdbeUa6Q+/9MQ0mLZh5QUOPHLVDlsgysOqNV/ruIPB?=
 =?us-ascii?Q?3AgNVX7HbudJbuqiqRUm1uioPRyDjMOmqj7DxYw0zl1XnQ29S/fXJEoFpOJa?=
 =?us-ascii?Q?E1SUC/6JDupxlvVjvruXkuM/vUvQJrXoJv0MC5JujqDbu419fna+HhEY2h4C?=
 =?us-ascii?Q?ffzizg8K1PqrceNDu/mQEaXAviRVTiAc18zOO8XO+TWIODCkW7al0dNufEW6?=
 =?us-ascii?Q?smLlD4qmxFFM7lB5CcZu1GDXCxGA6O6QnylQJsENVVHuUOFfxvHJ2mLdM3t5?=
 =?us-ascii?Q?ICZlxidzn78g9vk7GMruq0nm7rgWlnQxpznb2dmXXdRl9lfraQfxtNqWC2bM?=
 =?us-ascii?Q?fVav6O9Gx/845tx5VQx/DpPlcSVFObLNyKnn9p753hrherbTpmZ5WTTALym1?=
 =?us-ascii?Q?ObUu0ck5gNzj4tBti7hejc+W6hsF4z+a1yKVH+Ipp0tJSaQHPX3ipPHzjT9r?=
 =?us-ascii?Q?N9mcjsVvCGik0JTCt4as+SI8AXJ3puH+fNXFmPIkxbHxATXOmcA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ccdd45-7116-4cb4-73cb-08dad71036a9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 22:29:46.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+IIqOjmyAsV4JL29rqT3NrRdB6lPvs19ZfHnQZXCL54wqPXK6FymhzrVzzxIGFZ9AHa4lrfuA8jNGjb5hiNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050186
X-Proofpoint-ORIG-GUID: ntkJ3Lc0BsmWLiPhPemwccvJpvMUGY6-
X-Proofpoint-GUID: ntkJ3Lc0BsmWLiPhPemwccvJpvMUGY6-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
