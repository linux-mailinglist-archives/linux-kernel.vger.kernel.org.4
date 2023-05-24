Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182970F75A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjEXNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjEXNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:09:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141151BD
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:08:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OD5i5U006391;
        Wed, 24 May 2023 13:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=k4HYIRIl2vP1HgBKrtAEjh+g3ThFPua7i1Jq1Jz0y0Y=;
 b=D8gG3BcVKbo38C7UaSmwT6yBd2O9p5KJnwRQXFmTf3fT8CeDVDOfksrksoaA7XSFRm5L
 mmi6R5oXXGYJ/IYvb/A/0urO76lAwaAZyuzO2gkAn9PSBx3wmqbig9FMDR0eSc1PJspO
 VXy0fnJpC62o1DKXn41j3NwtHnZLwIec7bS15Qbza+8ASJUIxmpKU1zJPmV6c39GEQ1R
 BKlZgrnELxh++42Y50eocMCyrMe3T3VQTGG7M0inJVqMhq8tLZaA5Nu7BGBumntsczg0
 AUD3/0a+xcNGkGXZn3KvXJgXxGB0imWj0/GETZWizwRcxJeZ0c5e8IJLcaBUNbhiiCEJ dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsk5pr06f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 13:08:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OC1vgL028512;
        Wed, 24 May 2023 13:03:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2sf3f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 13:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmfrBuw/J6cZuAqAl9LltdML0Byqvz9jTl57zMvrABFRDWf/yz22iqX090Qk9cf2Hwr+ADFm47wifKodNsM2TgFKqyDUuEdJlpdBz6F4B9QHgqfeik7N80Ki0e9hHxGd+9jrkCTkGLO3FCmDozmR19kWMzzADBT4E9MMvwlHEcqZwDQ8+IkQG3NghVRibdGIRaz5dc9XKHjhLBRCU3npDm0pvHDIyosEqSRTGs/A+VmuHlWyAD3vrlZbqNmqtVUa0YvrFfEWC2S0gVf6FyJxzeRSpFm96GZmaL7v2Ws48QRICALFWuChzTHqCSZ/MqpRZgYRVA21/aoSjmMmHrELuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4HYIRIl2vP1HgBKrtAEjh+g3ThFPua7i1Jq1Jz0y0Y=;
 b=SiutZPXLVyfi2SN9JDCZS5QRSXsob3S4Bc6xYYGcRcsG0b25PLHMf0UAttTAZZYmkRwi4+tQdphYMDXLB9Mu3SlvRY+mLzkV1lWi/okpfTQfL7m9MULZHT9zsTxFB/vV+s3c5yLUn88ZBJSv6Rvw1htnVoCC9TQTwAoeie3upyYcD46RNgHMpd+qqnRLDiNPAkdEu6LBKrYu6UQCEjqn+9AmzAJuwYcfrVKiqY/eBt0Jmgpny9qA+fXRp+HQGOr1OEonT7xTGyZvzewPqyiDXD926V+flS8HLGjk3vjY+Z3g3eoWvRGeOrdRKANILQf7IcMLX1D7zy7jdDioF3S7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4HYIRIl2vP1HgBKrtAEjh+g3ThFPua7i1Jq1Jz0y0Y=;
 b=xAAxvkMWyi72VEKNdFp+X7VILns64AxWJQmRWMtdaKpUSm1hd/t6UjRIBEU2iePjpTniW8Dyy0Vv1Aie8rzcewj/yVw1gpRl1EInmAv8dW5Z2RG7YruE9ZMHxycHxeeIzLx3/Q3mTOIdIfnMSPn4i4XhputhJ46TX038kroDkVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6158.namprd10.prod.outlook.com (2603:10b6:8:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 13:03:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Wed, 24 May 2023
 13:03:22 +0000
Date:   Wed, 24 May 2023 09:03:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2] maple_tree: Fix a few documentation issues
Message-ID: <20230524130319.mc7yl47465yi343n@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230523134646.gelsru64qvny3fi7@revolver>
 <87ttw2n556.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttw2n556.ffs@tglx>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 12adc933-a303-4519-d2b1-08db5c574098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSk80OQ4/J0Z6kVD+UsU9WGQ1e8G+LzV+QhrBDbA/2JfgfTrwB+jlf2Y62AWpJcFRsZvvMPy0bqZNKXPTaIheye09ReTddndiHDglH4MnSnv84Ase1CBnfSO3KSL5HPMP2Kj4Uo9Uicv+O+nZfX73/MSrCuuqyFwGIhdbCZZYjhdlGB6PPhqRQODSY4uy8L4AO/HoMHE+OzIV0P3pyNfgY3qyRifauDqTkkNmj90uZQ7GHZFXEri48s5qtC6Be7YkD+F+qoMMeUmHxryulmeV0yEYqI7ibBHVNOM4Cd+rQykt148Rmy0Cd+D7P0Inf8/kdob7Rh8z8gHx7WUEdKVXfqA/BHvWyYSLqDutAEpfqLgFfLGHx87ZGQHGMjbSjt43V6hijYgI84Q+kxHPZ61SQvq8571/sRo8bhZbN7NX50AlPVTMXkP6geSthk4gR0djNJwtFiZrdcp8WXSZw6+vbDD3Z6PU0Him4uGAiCDfeQjbNzgPT3e+ykXwyTd76kxWZaNxfbeaAYtLKmSs8n96feOX0V6NtVCahFwcUsYmxBfNGmkmaVIrEGxphxObN+m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(5660300002)(6506007)(26005)(1076003)(186003)(9686003)(38100700002)(6512007)(83380400001)(2906002)(66556008)(316002)(6666004)(4326008)(6916009)(66476007)(66946007)(41300700001)(6486002)(54906003)(86362001)(33716001)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SchMnoFNi8/IqrH7DB/ZLeNbpQT8lAWWscinUZdaM0tq3JTjaqur2izfBaLf?=
 =?us-ascii?Q?+QrUHDHNFqEM90S9So2CGIrrx7sbRLoyxXwOQRkP/JJ09tuDkQzyb/VfVeFh?=
 =?us-ascii?Q?D8+tEsO8UlON7BotTby94nYzR2YztIudtBRGCP/ed9jbDF+JGioDXEAMiMRE?=
 =?us-ascii?Q?/RWGxwf+isa6cnyb1vRvle/fRnVdzIhnHT1iRPn9u6tuvvlu6xvpxpqQmmx+?=
 =?us-ascii?Q?BPJRw+n4HXf7eeiMLpM+c4C8DePt9mpzKpuJzv2WWutmynHgm8gEXIqsBEy7?=
 =?us-ascii?Q?mR6uSkevry+IO64SIGR6f/HG/zc/IB0iJZCoVbf9x77ESZZgqGI0vmOZalQf?=
 =?us-ascii?Q?Skek4sAl+373tTA0IpWMg4kLx3kgbaA0Ef608YahmVxhgafcm0lDU4yQWZ2/?=
 =?us-ascii?Q?g9tgoffOZl3chFMdg6QYjIWXWIJChLVdbrc807WKy8Ss6T6c/g65TIJ25Vkn?=
 =?us-ascii?Q?TPsCVg7Oys0bg9oW6moUc0kux/WT9SgApz/VWogVeqVeUcsNknqlfbdhAAVd?=
 =?us-ascii?Q?wuFqOOaxzsjFsQHGW2DOgdbaKv7SOO1zHxwnOl0ago6N1+ABWskYgE0+UFjA?=
 =?us-ascii?Q?+h9mHd34htRSura3v09bYNE6nR1HY+unrAv2V+etVUyWLZTPQWE6uoKJRRi+?=
 =?us-ascii?Q?+2H3/4YPH00XDT0WgJTla7kdmZ3LeR3izSOWhZ+Ab+WWw/SMtkUwH7coWl1f?=
 =?us-ascii?Q?IOJmI21SNVPugeZaNiCNt5xe3OmuaI2q/Uw9pMEz+1XMveajEvw10MyqdKpd?=
 =?us-ascii?Q?y8VBnFFq4Ew9TDKvByfRxSiVqv8JNkMX9WQ72WCZzV3Ukm6ojRRzfp7vY0lw?=
 =?us-ascii?Q?2OpLDyjEK3nQlHofl3RqzunK+FVzlCHBJ+GsYfHVj7A/yRgTp+owsRJtEZvn?=
 =?us-ascii?Q?SJdXG3SYQLopo9iWaZxwoqGnCLdMpwCd8oihBVheH2iqX5dfLuqMBtd/4tId?=
 =?us-ascii?Q?h9T50H8UtN7XdA8YhgDl1TItUuoCH2An0Qr5lkyA7HnWKuf8hG0nX1iqQQ7P?=
 =?us-ascii?Q?Z/j6fuNQPiqxSg58fIzmJb5MzRUW9lk1K0yoFwLRrnp5tWQdM3J9llJn5Vj+?=
 =?us-ascii?Q?qZmqKYnuOx+ozipV8IIWqhDsYxHcigYCHzXNbN6cBEjNqlc6InTF1AWOuLYR?=
 =?us-ascii?Q?R8r7K8HB/Jxa0mQ0GkjjKYmt4fMM+FNqk3tf183Qr5NJM6AK3O082x08CZcZ?=
 =?us-ascii?Q?+cR31KKE7Q/d4IXpn0F2ObLqYrWsi3jY8K4iDXouViV1m9+QJmgKUOjeAoeY?=
 =?us-ascii?Q?d446mSkyZn/6zjL4OQS8BSNCBEFTupPFgJfZtY3gE2Yo3LaL+LHG2Zzu1pvv?=
 =?us-ascii?Q?Lb48ooOhPK4cRwJOcQIFZ5HnXqu7AaGD/WQI8PtjfTkYq058fr3p/hwxEegd?=
 =?us-ascii?Q?/ysI/A044AMgYHnpOeSUdIpDVLt6zdYiwL9oUR32F34SYVHcFNbqXWXdWkmL?=
 =?us-ascii?Q?A9Oqjrd0DbEzYPgQkhWvOcCj+tzTzawBqwC91A/TfkcjsYzPCMrZRBRP3r3z?=
 =?us-ascii?Q?Yu+HKZgeOGmnaRYKDoDB0xxyK314O2j2OS4c4kGK24PKGVIDHLM6RCSboZjG?=
 =?us-ascii?Q?vCdoLpKsOyQSom07oOpEdLQasRYW3XOuBXBzFknZ3McP5Y9Zhh6TKY9zocQf?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2zbG6esnucqAwT6BftmYHHERCm5qZ8/AtS8iHZ0+OHXjnxjHQ2CMZysT3qqpXa7lc44cA+GCCUCD1k2S6ny399f1je8pOplYigriDRJDkEpudg6vB3xoDjTurIAU8LWzFGgyrO1ThLjxaX3jENJWqF9+0tCNmDPNlW8nuKlQPsWK4PSW3dk7Y3HVas9+ii1zlIXZhoC1D467SC6gQ6vpXxwxpSgJfOyS13kyPTgoXp9mIxXJ5KIEY6BlFl0t/4fYyaqDIFXg29PtMcMoijSGvwCdHeZnPtuKe1eRH6btTMdBW18roF3zUXKuj7rh23h+bpOpbfM1y6/2TR/5GdhCs1PSrSYf0lTXZPK0rplHPGENQpj6T4+K1e0w4OJ2HIhyCOr1xy7aFubmQEGftSOq9RRs/3FEuoZ6eb8K61DEsyHO78EbKKumZIKpkZLXkc9oPqsXXqi1YDP9GmHQEzkNFXY5oyrsLT46lfQ0cBU6Yc/39nqHs5NtUpaVeRg6EQCA6gluxz7XNfHPHO+vAgSFqB4Gy57QVvl42QIgZeGHl4TZaYHYfuEcYInuDg6sWJLAZng9kCEWJWUU2o7LeXQvFEW1xTs0Me2fM5BxE8aDJe1AOqAabnKRQUiJxGRSgR/Z2OFQapIrfJDrEDIWjYOb7QW3o6RDroxQp2L8PyExsS4LC58mrxdk2FKCyRwwTQ/d8t6Pbo9PE7SnUD3ayCfA2bs8VENY11jO9/ioqreBkPYSxre0MLBXrPEtknOPgzrF31Yp39vHkIk61xltk+kpsYGhBUBGqRxou6DZFnl+xSaKbqES6th7zPBAz42iidmqu6B6VUThxmmihlZkb754K2M5FNMvY1/bYxT32fNgR2Fupuu88Q9JLGcwxJ8YzHUcaGC/GehfzQrrHfvp2pZXKQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12adc933-a303-4519-d2b1-08db5c574098
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 13:03:22.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67osgTgjLYCK5RjbvNeiQDpeYhDBB5t2/5/i7ZsrhBD/cL0lngeDeB7lh1+J8EpDjlITQohTIZzWEdnyYu5cPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_08,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=788 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240108
X-Proofpoint-ORIG-GUID: LE1kVo-F8MY52Tka3NnE7HY8co2LjJIB
X-Proofpoint-GUID: LE1kVo-F8MY52Tka3NnE7HY8co2LjJIB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [230523 16:51]:
> The documentation of mt_next() claims that it starts the search at the
> provided index. That's incorrect as it starts the search after the provided
> index.
> 
> The documentation of mt_find() is slightly confusing. "Handles locking" is
> not really helpful as it does not explain how the "locking" works. Also the
> documentation of index talks about a range, while in reality the index
> is updated on a succesful search to the index of the found entry plus one.
> 
> Fix similar issues for mt_find_after() and mt_prev().
> 
> Reword the confusing "Note: Will not return the zero entry." comment on
> mt_for_each() and document @__index correctly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> V2: Address review feedback. Add pointer to documentation, reword the
>     zero entry and the index explanations. - Liam
> ---
>  include/linux/maple_tree.h |    5 +++--
>  lib/maple_tree.c           |   26 +++++++++++++++++++++-----
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -659,10 +659,11 @@ void *mt_next(struct maple_tree *mt, uns
>   * mt_for_each - Iterate over each entry starting at index until max.
>   * @__tree: The Maple Tree
>   * @__entry: The current entry
> - * @__index: The index to update to track the location in the tree
> + * @__index: The index to start the search from. Subsequently used as iterator.
>   * @__max: The maximum limit for @index
>   *
> - * Note: Will not return the zero entry.
> + * This iterator skips all entries, which resolve to a NULL pointer,
> + * e.g. entries which has been reserved with XA_ZERO_ENTRY.
>   */
>  #define mt_for_each(__tree, __entry, __index, __max) \
>  	for (__entry = mt_find(__tree, &(__index), __max); \
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5947,7 +5947,11 @@ EXPORT_SYMBOL_GPL(mas_next);
>   * @index: The start index
>   * @max: The maximum index to check
>   *
> - * Return: The entry at @index or higher, or %NULL if nothing is found.
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
> + * See also: Documentation/core-api/maple_tree.rst
> + *
> + * Return: The entry higher than @index or %NULL if nothing is found.
>   */
>  void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
>  {
> @@ -6012,7 +6016,11 @@ EXPORT_SYMBOL_GPL(mas_prev);
>   * @index: The start index
>   * @min: The minimum index to check
>   *
> - * Return: The entry at @index or lower, or %NULL if nothing is found.
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
> + * See also: Documentation/core-api/maple_tree.rst
> + *
> + * Return: The entry before @index or %NULL if nothing is found.
>   */
>  void *mt_prev(struct maple_tree *mt, unsigned long index, unsigned long min)
>  {
> @@ -6487,9 +6495,15 @@ EXPORT_SYMBOL(mtree_destroy);
>   * mt_find() - Search from the start up until an entry is found.
>   * @mt: The maple tree
>   * @index: Pointer which contains the start location of the search
> - * @max: The maximum value to check
> + * @max: The maximum value of the search range
>   *
> - * Handles locking.  @index will be incremented to one beyond the range.
> + * Takes RCU read lock internally to protect the search, which does not
> + * protect the returned pointer after dropping RCU read lock.
> + * See also: Documentation/core-api/maple_tree.rst
> + *
> + * In case that an entry is found @index is updated to point to the next
> + * possible entry independent whether the found entry is occupying a
> + * single index or a range if indices.
>   *
>   * Return: The entry at or after the @index or %NULL
>   */
> @@ -6548,7 +6562,9 @@ EXPORT_SYMBOL(mt_find);
>   * @index: Pointer which contains the start location of the search
>   * @max: The maximum value to check
>   *
> - * Handles locking, detects wrapping on index == 0
> + * Same as mt_find() except that it checks @index for 0 before
> + * searching. If @index == 0, the search is aborted. This covers a wrap
> + * around of @index to 0 in an iterator loop.
>   *
>   * Return: The entry at or after the @index or %NULL
>   */
