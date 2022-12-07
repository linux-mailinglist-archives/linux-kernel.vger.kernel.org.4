Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485964505C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLGAd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLGAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:33:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E8167DD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:33:15 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LIbKa011143;
        Wed, 7 Dec 2022 00:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GR+DZw6Z8FUUgbR9QTqFxMmgDGLxBkpNaBVY8q08AAY=;
 b=Fy/uhEfr1rUfBrUCcxyiOkCiJOa6YmG/MO62MaqaWFq4tEtYAjsPthE/YgJeKJpwfEZ8
 Ha/ja0IF4jQk01EkZeMxasZCeLEOsybz+z9YaLHt2eKb8um74O3fXcCxuOOMxgG72e5h
 7fmewORb00loKlSCsMuBLY0gzND7ktQ6GQy0tjG3AQAJEOSP4r8vT3zvZ9rxhMuutNjd
 riujaVkC018xSeUCBhsqg6lMh1SQuZ2+aqoNR8m52jIpa2QH8ZU4ETqWNvVrFN6ZQYV9
 Riq7KO9pbO7XZ26hs3/iDRdxh8pGPq+X5ZdeG8RDUyKyx3QAe+gBYTchk6QJB7LP5lLV uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqs20c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:33:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6NuBXC030982;
        Wed, 7 Dec 2022 00:32:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa6807pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 00:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSdmPXyv6KMgBfUKTETUKuuewnJmi6eTnCt+n/OKTlZ1xC/ARobe49DuLmuXBbPzat2Zqmro2XE9ElNCTe2pOKF1ROfyouZBNQtM2Z6W/4NQf01DpTKQSB4r5udqvRQ7U46BuRVt3pR+KxyHSppQnEtUjyuvMX735OCahLbRIaGaMCpAYILg7g+8yU7nEvxS1ezwAkx7EdzvI2s0RDgxLDIjDaKXiidrGU+nPhVz3v34+w28l3/kVWqN/0Iklnx9hsSZz0fWk3tcMUgTCkfIWzhrE/bPT7AwXD7okvpCEOJjgFzG67eAFwpPOb1x9Q4Ew1b/L4eCClMcznKwUl8rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR+DZw6Z8FUUgbR9QTqFxMmgDGLxBkpNaBVY8q08AAY=;
 b=LVRZwTI2aw7ox9QSQFbsFHjdW3ew1490e5w0/s1WpcpOdh5TX5fpbsJbjs04SIYgWUwIH92uK7alTiduph6q59MifX6Ss7o51rE6qqRlbsraJP+M9iwZW5hrMZuu9SN6xHLqAir5hR+obGP6BR4NbxM73IUUuixXknYAtXRQXioo/iJuPKpkmQUHG5seidX36x55ICpQMGV+dG2XQmgck4OGL8yQeXRA4VKr80ccXWqEbh9ZNjMj0vpXOS4UsV3lZI/Ok+O5jgYo6TNmu9NQjwWfnA1uT3cYaR61QFU+kZalpvkXFRBsmuN7paI11PdjikzCY3uMStw0q4V589fjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR+DZw6Z8FUUgbR9QTqFxMmgDGLxBkpNaBVY8q08AAY=;
 b=qFF70VxX6UdfhIDYqGVxBTSxjPoqQp1BKp8/I97RmSlrzP0BlxH11Tkq/FAk0gypRnvmlVAkWrYqnd7rwCOXbpwiOVcTF7xEiciMAg+JTFXcW2UEyPpkfmmlMacp+S5re3piEkdjEfKMawkivixsaHCnX6qfg0GBs7Gn33cyeYs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 00:32:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 00:32:56 +0000
Date:   Tue, 6 Dec 2022 16:32:52 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 02/10] mm/hugetlb: convert
 destroy_compound_gigantic_page() to folios
Message-ID: <Y4/fNOdP+cgDIOlQ@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-3-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a77964e-6eaa-4822-036e-08dad7ea9572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MvOEpQjGxQ06MbxmR2uBnQgvOwbRuDTCbV1zQo4Zf8iBsT0yP5pSuka3TEIrtvE4hBkTHPYZN+venfYh9+mUVLn+Zia/lJ2YAylBJOTcliFhZsgTwUFfOuMkDvSmAkLRw3PniK6MPAWIDpaL1im1F5l47TuqDnTAUfi6LvBEWa62k7Gt3EvMoSpt0D0Fur7Z3kXHWgqBaJ5tbVgX4r09HU7XZEYUxDPoH8C/yZ4aOJzIvL0h6kl9gXXXCH5Ms7ogM2lEmVhb5P/Nli+zkbKpB5RqSZ9Zk7no8JChRDbX3plIJ9jYdXFUPgYCjld6FXdz4tZSZF4pSo8bHJPUZFI3+Ke1r4RhCSNSxroKmH8Wmp5o5hMbvsEkB1waktGtcZsDC9k+aSyDApqs6bG2AC1kXi5/Ajyk5rk8PoMsCtEM5mBglBEHsLh9M1UT2H8H+cx67V0wEDEIxjebDeBhIO+Mm4OCYxN+hVYWQ6B9vOmQlCRZF6C7kMmrKxUkggqTZWIbKS7u5SMnBMoE/bk7Nga1t7c7nkw28XfFPlT7EkogP6QATYnVrIVFlbO+hAbYek4iFoF+DMt4okxsUheBzSqIiHLn9p5UGwFmf+lp1YtYd14sfA1lk6edDbOKfkG7TQM4PHknAN/4LqkJrK6xITxkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(83380400001)(86362001)(4744005)(5660300002)(2906002)(7416002)(4326008)(41300700001)(8936002)(6862004)(44832011)(8676002)(6666004)(33716001)(9686003)(26005)(186003)(6512007)(53546011)(6506007)(316002)(6636002)(66946007)(66476007)(6486002)(478600001)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?020TI/nhbIjd3XyYaLPp5z/0o8WAvyWpbboB2bjjIIX9SQ2YLxpnpq5h3ffB?=
 =?us-ascii?Q?DshVdTgVetTNlcwEbd1ImBEZxfGq4wxgB63z27behv45ZR6eL3zQWSbZLnZ+?=
 =?us-ascii?Q?3L9+dyTricWR77gAtUUm+hA2fR5HB3eJkI/8Md0rRTuJz3JkBib8lYK8dKrv?=
 =?us-ascii?Q?RzoljLwakR8Xj0OIJhQxt7CtsPhVsiMYYSP5fXf8ZyY8DAFcXMnB/b0K4nWI?=
 =?us-ascii?Q?ofsGGMrbK6BaoTa0IoxgPu5CNAfOu//iETArm1IqOh25iEm/kVsjC1dnIgQo?=
 =?us-ascii?Q?cg+EqvroNQobEEwVEwKq7eJf8Ow6rDsbY4C9SCY9Hwc6725PRtCwg65HISRs?=
 =?us-ascii?Q?id4FdthZglRH98a37Xy9QAQwKnvvviL40bWtLYkesNLDmaWw5AQVfGrLQUtl?=
 =?us-ascii?Q?+GVkvrJKHBuom6G0yn9t7ppLxrVG2VIkUpIVrDGqdgFBpVWDZwur9irH24J5?=
 =?us-ascii?Q?wxfRSP2pR8Fd9qOwmaT6bExrRrEstaPNy0DFWReGnnEFS33nMh8F+bm81Qtb?=
 =?us-ascii?Q?BBak0eu1KXl3ehFOWLNK7tIUWIAmfbIXie4Vig/EZYFMpi4z5QrLjWUMG78s?=
 =?us-ascii?Q?ZFCG3K3kwSET4eVNDefHVXwFBOx44rlBusNkkNBK0zV7LGjwcWrqjsd9R2uT?=
 =?us-ascii?Q?rNm20d6BtwzDfh6aYqq85IMt1B7L89WxJ/TAZ7h1FYSb+ood2VtURMtIcvLR?=
 =?us-ascii?Q?OyW3Upj/r65q9B671wftGMf3YdvZoDNkuyIyCHBxWlMcHi57J9KDcPSQJZNn?=
 =?us-ascii?Q?YSivJqBq/EC58GRnJj/3waebK6tAHcN7/DutAPXXR/dlVFgfKSVTGtqgHMMw?=
 =?us-ascii?Q?HhF6ebAHLaqpMIMZiiCJ4ySd+P11zDXZ6R/PVBlDjR7MXkhPWBLV5fpVYJci?=
 =?us-ascii?Q?8XRxG5e3h3Sd9Rnoikug/pZcvvwYlUVbaDTGOpVLmeda7ZcBiyrE6gzUlguf?=
 =?us-ascii?Q?+1gxeBF7bEVECcxkzmlpPSxgFeCwkKsiIWCD9xULTmcMTA51ZHR340qvSBl4?=
 =?us-ascii?Q?X6c/RLGBnVdUzmPt4LJMA4jeS4RSVOVRP1k2jzwPVawOeqKx5lag5DK9GGtI?=
 =?us-ascii?Q?k5lDrmyxhM+KK0YhDz9rXJulgUXMhIgEUJZCALCIy2SIxn455j4E6MGf5knV?=
 =?us-ascii?Q?l1uot1W+6h4eJm+kEzkzdHIlAwlHxz+VG0p+bFvZjry9vUDRsagwpYFckrrk?=
 =?us-ascii?Q?rdZmuS2Bau/DoF536vePrm8Z6P4hItwHJ80/zI7LHnho9gnP+TyvYxFV0TBk?=
 =?us-ascii?Q?R/Cduj1yi5LBzTvyhdVDjaCUI8y7hdKYsI2wUaZvnUdRixS5dhfaxwX67bcN?=
 =?us-ascii?Q?TVOZaWtR5YEnGWFI9LZ0S02u/8jYS2AEme/vlMVGDEbF+bxiGDweSzeL9ASu?=
 =?us-ascii?Q?Prqaxi8L1fbP6QKRXbSakiz7cI0POJda2T29sCZUnONZ5s3WFV94lsJBtgu5?=
 =?us-ascii?Q?JsKCSgYvf+Dq5fx1VYmTG+YK27gU0anqoOh/GSCYN0kWQdo+qECXs6USMu3c?=
 =?us-ascii?Q?DiSUZvP1Hw+KHG/bUIX4pwkXhtBZaHH1oopVfh8/StZTUQIZLiI/uOX0fYbj?=
 =?us-ascii?Q?wBEJrrBSTg0OLKgT17nbBWwVKizpa96dmf6kmAMZ5kuinGYO7/uY4oTX5F1y?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d/PU67s+3QBg3+LVjrs8Gz3kAWSts4wK0vNllsgX7Wx71px4OSw2nIMihmy2?=
 =?us-ascii?Q?SQIagW7Of3r24k48y0ikXLgsK8VbUoHeNpM2OP8TvZDE39WegRRi2L3Lytlf?=
 =?us-ascii?Q?EYn0/Z0fAqjeMe5o6LUEpUfA/VSfHoOsY/yxG7ZmK3u1y66LYieMjmGiPV93?=
 =?us-ascii?Q?pvFDxPxPRtqNzzi0BIY1IUNZc31Y3GyEBC4Z8mN1G2Tz7XUzINzk3/WPQi9I?=
 =?us-ascii?Q?AbC+FpqTX5yn6tyZhPEnJ+vImCSEj/DzJpGsDonSuN8RyxYgJvphjmmq1jvg?=
 =?us-ascii?Q?0giuwyCEsixRBuMJpCuxP7Ll6hVV7fQTYMF/8gfJc7ViRWVwegM88fEBNAZR?=
 =?us-ascii?Q?QVkOIfKMwhBmilCl7FduYgoF062lny3ziWEhpPtNKmdy4idtgg+QTpmznb1o?=
 =?us-ascii?Q?jvkWFrk0pWkVcV/8e1AN3J1XIi7Uf8yZhVunvM0sFTNmRzSUfrcc2c1H4RMM?=
 =?us-ascii?Q?/VgxuySVrDTkpr2EMATKmtp5mNVqM/D1PR8DS6XzlLtxJ/Sve7ZpjLhvwJPc?=
 =?us-ascii?Q?z4PkPahbdD2Dvq9KzwoJegsnEP5YojgkdRXOkJCl9jvQqg5Sufk5B8RLr7zb?=
 =?us-ascii?Q?SKFIDAoD0hs5ULKw7tcSt6SXr8bONEyFUHnYWneAWssd+0dNisAwVruncZ2V?=
 =?us-ascii?Q?Qp7N5Hj/xEX1x8dretpLFcshgcuvEZTgfCLVFL7ZHwKVsXB/Ihs9fc9Wj1Cn?=
 =?us-ascii?Q?yekifEAekcfCTJ4aRkCLvWNXRL6vmfNxp0CBOek5sf2//e/36i84KNP/fMVv?=
 =?us-ascii?Q?LIePsetVMMfEa+LOYzSSWycnSUkZiyEC30UCvoHMkhG9h5oHLyxkYwPAeHA+?=
 =?us-ascii?Q?edirCFAYiiQMaPlHyEm4JwGqCYu7CzgnygTyQIRGcvh4I2FWr64bZ2R6UCCO?=
 =?us-ascii?Q?Lrk+4Me1jEIhRGnmDJYRR+od31dj6ZaTQm/lwqsDijUh8O9dlqt7ylw332oI?=
 =?us-ascii?Q?M7HnqMS5plkyp5kvhHqrNq3T21iu9KnjXwpeazbGvJhaHXmOTHJIg/QJjeuM?=
 =?us-ascii?Q?I0zsbTeWYxxGvLNw9b0ALiHqAR9oiKTsQE3DW/jI4/DrPnF9//O8T5Q+amkY?=
 =?us-ascii?Q?wUEOGNe45t7JNRGXeQfNQwAg7bH2lwUE2tUA7L7/GvaoF11FbCc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a77964e-6eaa-4822-036e-08dad7ea9572
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:32:56.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I4r4eOTlnh1xVOcewJqupVxB+vMAsa6xsRUU/twcFFG9t1BctZPwDOHdkSBMs2Z3rrHHu03L/oM5CVzAEe9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070003
X-Proofpoint-GUID: cWVdFXvYheSn28VanmKfxIdU3Be7Zta4
X-Proofpoint-ORIG-GUID: cWVdFXvYheSn28VanmKfxIdU3Be7Zta4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Convert page operations within __destroy_compound_gigantic_page() to the
> corresponding folio operations.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)

Looks fine,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
