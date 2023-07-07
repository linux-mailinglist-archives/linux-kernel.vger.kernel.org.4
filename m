Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3774B400
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjGGPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjGGPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:19:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB55268A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:19:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FFmjE015884;
        Fri, 7 Jul 2023 15:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=paeMW62PVMqfW6BHCNH9zuUmQ0ys4aij+fZh2ljkdA8=;
 b=HJNSyplWlSF3gn7/UgEvuEwN7SPyAU6VxhTsqVwEsLjDyiJT/BQ+AxsPzg9vXu7MqFLI
 lwjEYNpvVNJKL0KDaqUNg86s4MhT4qPd5kGZWjADj4ATeqQv7ygC3CLEvqbJG3RPiM0I
 AjNofXXlKwU7y/mIxBGT0rKNvOpbaOSaX3sMZkzseoKl98GvvfWGcJl5aA1KSakrkPRm
 NGD5jNCDnN8ul62Af2RfCWaFinKJQGpC1FO8VVlKK2K9sqTOiA0IpB4Zoxq8PusuIi/S
 uNlBPQPkNaGSPj0nZhGv6q6X1TNWSS7H98P3mheKojCU4+eJv1TlDKfJ3tvcNz1NhkpF YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpmk50429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:19:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367E9KVv033283;
        Fri, 7 Jul 2023 15:19:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8rqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 15:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjVklIYlj7I6xEVDbsF/pOFBgHTtzdl7kpO6bQs/CKzdt1sHu1R44+DKNBrG+TewiB5+X+mMuga2SvQrzF+SoLEIATwzlsn7tbFbbrtGggE4y0wpBinLEXjNGg5Epw3VV1Vgzq+6klWzF+HZVHjBUc4zPTACOtLuYyNOjynnADDamnySnyy55FB+53tlz0u9fVz+fVN1dE+x3ZgSiJInL9rMPbH+yGE9Jc/aHUf/mMmaMXQPzn3TKbdfKRDNd4Pas9ZQH+lSV7TCi2UaWIQi+D6C/QbKKuI4H/Da9kUBWeaZhjDe4snuhRF8NbKzeujZycxfcOLEa2GcW15dIp8WOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paeMW62PVMqfW6BHCNH9zuUmQ0ys4aij+fZh2ljkdA8=;
 b=ZvKGGAMO1dUwmRteRQLh+eYQuXrjkegN1ILO7/KqqvOJqVGMPemfQWOI+Eoun9I2IzyHHmnFaF7uciX7ovSbXrtiIzLepvsS8NURJrv+T9T6MgwMtCEbFYvGZtkSRzt34iOtSo2Lzu1I+IKVCl5SGE9TJbjiMr03+TAYO6gTfucajftL1URMnpeY6ecErbTNpDl+Cf4dKCy3W5IEXGawtTG1LSsgZHOeQgg33wUfL0n9dwtmjKAexp22RO/GBsWLE0UGgwwAI3tbwiThu0UvhOUwrxngoAz6unrfFJiOqvJKWwKtTPyLUTZaFpIlCXndf/lEZJvdnfx7qUH+l7IuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paeMW62PVMqfW6BHCNH9zuUmQ0ys4aij+fZh2ljkdA8=;
 b=f6wPpDFnjbKH6/qWzOkuKmxmOwTROqPWMP6ZChWHh0PZiTmIH5T33te8HMlIZKCJ5CHrx5tClsitf6tI/4cbz4fWWVtqJ0aY5m0Ue10L4GIDWhQRw9rAUpH6QCiUA0rj4W3ApQoXiEPqiVcK0UxN9XP0R6TVH6z5ZcgpReVZvj4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:19:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:19:23 +0000
Date:   Fri, 7 Jul 2023 11:19:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 8/8] maple_tree: drop mas_first_entry()
Message-ID: <20230707151920.h3qscfr4cdomztsg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-9-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-9-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fb88df-b290-4d92-a74a-08db7efd8b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PG2Nz6zSuWREXIm1WNU17wfZwJGxGWnk87oZW3JVrtjPOhV5Fy69vD9nDJV2WFW+WagQWatoKMMEkYjpNDyN9U6adxlPpEhSDnB6tWRutPZTt8Or80MPkOtQ36SpL3LxpMdZrL19xPppt1FH3T25OM2sG8zg10McXrRlm/wtjukps0jvYmMFDGJDtUduekfasphRdR9JG3Kx8g4cK1EtyhajlA6cCBVrOuyaKCd4EP52Uwvale34TVuRQr1HQPT0q079w4GNOrInYbYIoPq0J9h2pQBNO4YdycFRFKpU4gxvrYenUgBVZq2YH5hTyO4hwL8EtXnbXmXdNjbUUQOw4J6gCEqHxmiR1pIaZsm+NPJkWf5XqxOxXH1Mw23OKnOZqcuLGSkOXroBLV82/Zp8hwiFaX6K9OV4YI6J1VRVMfWOLtjg3nb5JUGkK987yn0wnifOopwloJxMhBGcgEbbr07aYClrgEzqrh7bnrScU0DWUQfpjankiX4vnzIxCT6sA7/Nj6nF9ogSmsMRQYsqsArfXm71yp9H9sYylJ2vwryCWEnbNatwp/cOvIwrO5HH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(6512007)(41300700001)(2906002)(6486002)(33716001)(83380400001)(38100700002)(186003)(1076003)(26005)(9686003)(6506007)(86362001)(66476007)(66946007)(478600001)(6916009)(66556008)(8676002)(8936002)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qS7ECoPG3/eELk36llQXc/WVmP+a3GAF3Jqw80l9CuDiN9yPNaGZ/HA3JkeC?=
 =?us-ascii?Q?g/0H8dntSChk+r48FYqS9MdawbxwTbFXO4bCFqg4m4LGPl+XxdDPVhpjrOyB?=
 =?us-ascii?Q?DpFhOHVKbS40XtNFhBli+8ZyUd9+saDKSswiztUnGnFF/essPgYJNhNO7n57?=
 =?us-ascii?Q?wkPAjYZYDRQCph5SxNWpekqow/P96liak7Z9Zxbx4RHFE8q0Heuaom0eAYT5?=
 =?us-ascii?Q?c7sP+I8kk1NCnuAHRbXnpVgRTpmP47IHdONhk5XfonMhW/0kXaonzdh9o6Nx?=
 =?us-ascii?Q?1zQyzajQb9/SwcY1sMW6pjtGh9Q2pB+Z6/QcCrryEb+PhBflMaN+EhtwylPc?=
 =?us-ascii?Q?SbmRkhoxMNJZCfjuiNbeT56vpH5IPereC1rrhlunBbtfCoPSqTKaebGX9X71?=
 =?us-ascii?Q?+f0a7OmERNuvO5Ho0uyQQLQsyTfyVV0mkjQTZTHUdCyjeeum2D2RQB8iA05E?=
 =?us-ascii?Q?A1BUZ2RtIixNA8CMXLLVLOXzMLT88nkD+X4b4NPNQSQ9rS+wKSQB5E+ZcQyy?=
 =?us-ascii?Q?7je9tpxVCfkogw3abiyI5RT2GSXhznXGJeHZ8axjrgPliivOUQZz+7SUFS5T?=
 =?us-ascii?Q?K52K48+9GM+pOjjOvLHPL574gdZPY6DrXb3wFcfJkghkFNZP1IYLytLS3cHX?=
 =?us-ascii?Q?CJHO9Leug2QFkAnN74Ic7O/HpQTdy+ig7M0edXYpRYVFnGaxA1bvy285T5N/?=
 =?us-ascii?Q?93UL0Ax6TcBsb5qYZsfoQiGRHYhqARRV81KcdcuzhvhEy8xhdn0K22EjbjDo?=
 =?us-ascii?Q?mhG0/sY3vNb0D8SdXQfMWCDTS0UYTz1+gL7KQys+VNnUl2PyiI+yRqQs2hNL?=
 =?us-ascii?Q?czpfbMf9dn4aZ7qlVWsfxcMAkI+uiN3ChTFwXtE/PZTE+7RCAJdGjPBn4yMm?=
 =?us-ascii?Q?7BTngCWEyFqs9rOxngoNh772PkjOYHag8lr9Nbj7SXPV34Vlqx3NjKvhvRIg?=
 =?us-ascii?Q?KS0RoQCxKJhDRf5GLDDWMfRZ4CbD15l2Jbx6VZ/6uK59IdJyJCV1r7xG14JG?=
 =?us-ascii?Q?86P5JeTxPc8gbJi3IGzsDq9cbqT7PmyEjYHqewuK2rmWwaJQsWpuXo1PZa4U?=
 =?us-ascii?Q?JJg2i4+NE656seiSuCu4grY83vKz+sL9KdH2A21reOTOFMFhgTUYEDXNW7x+?=
 =?us-ascii?Q?ias7cBQ7nmZF6jJp9B4GYX7+U0jmKqqrglAlwBXnkkwQi5XrHUuKqaNCMHRD?=
 =?us-ascii?Q?aYJ/lW0J8WLwOaDiqJ9oMd/DdKLy0Qzlmgc6OUV9F+NvbdcEBPSAbUhhgbnH?=
 =?us-ascii?Q?SG3eWKFQ6GVlCoqmwmU8LLEJjg4R3kvSriiujelxo6Y3sv0EMxETd9vjCqDK?=
 =?us-ascii?Q?sc8uya6d05cThaXrjgBZDqxngD+zdW8HsDoJSsAqo34Uv4GBwvmD8mNTbACY?=
 =?us-ascii?Q?rmTu2UUE4g6O6zL00a42UAUO1d9vNB6UGtpDSDakE4OvFAB1C9Fjjz50luJL?=
 =?us-ascii?Q?3z3ZLB3gl2eCoHEMw/PsOsnEfHXrbz3tgAsw5vpmJL7H3QA2SXC3xGrA/aOm?=
 =?us-ascii?Q?rEj558E37Yeedf1QAweBrxlSjI/GaxybZfW/Z++IbMG+fv1lk9QRpjio7DmF?=
 =?us-ascii?Q?W6SLc8+4H2DDzY+6SshJwEyGsJ/RT9hIoJyaF4rcfEunoM74JX+M40ZsReu/?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9QDPngJdw6kQnOUmUoD306xup/eTFw3lImOBSoQeFzXJiamh4h3zMjbJWk+4?=
 =?us-ascii?Q?4orsdtQOi+WNM0K9upHDkHQcyWpIFezklGEZux3R7MmIKAujM99MWX7SuzyG?=
 =?us-ascii?Q?pVjIUIbsBFHdGfMH9A6KRUi3m8jdOxSTlOwE3NIhkf/KqgoHJrWk/l9olGJB?=
 =?us-ascii?Q?hQ1Ozhsbx9hdhT21RLt16XKIZG9Spjn9CL9FAHpGNvrnI1+sZ5NfobtViqrN?=
 =?us-ascii?Q?DMmsTYoBedDIK79xDXO7QrLULHosLRjbC3WiZ0GFobkuVMYox4nm2WtpeCYJ?=
 =?us-ascii?Q?4pmylFfDgU/MWkiiYd3oG7TNJcC1qn3ojN1euzDwYFnfysVpTu3EMAvytBXw?=
 =?us-ascii?Q?HBI4fmazcyNcv5W00KYuEilgHIX+v8tD9P3y90U8kAEBvEqp6B2+2jTyuwdx?=
 =?us-ascii?Q?dTW8GZzfygGFj1Liy3LAhs7J4AJJHvNPmPbsdICGEXFya1oJSOjT2f0M7fF2?=
 =?us-ascii?Q?uh7TjkJw6kr3gLNXITOR0eCNrdUl7VQR2Ksdr1qswwCGK/yV8l2gm8yz5sok?=
 =?us-ascii?Q?7fvX3xZV9UWTk82fO9NyJQMeEfli5Nb5BaeDtfT6U9hAV9yjgh7J+BQjcr9a?=
 =?us-ascii?Q?t9IFjnJypFkHqwP9tScypjdtN3vMl6Gg7nOl4r7zSFJ0qKlA5VC06COdDQdk?=
 =?us-ascii?Q?qZZaHwoWLcmT44FbyrJ6PgnPs6iHpT9uxGmSTpulduPbO8Gr9rTT9uRE5zYc?=
 =?us-ascii?Q?YSlW1yyi1hB6zIlu+ce7MXUp8zm8/vVoVaa95Tij4OpMGolgl+nXpal4aBva?=
 =?us-ascii?Q?UzBpDhogN0CC2d0ZndyygSkyaF/a6EhAnnAYTz4NO7gzZPj10CidKvr1vZa1?=
 =?us-ascii?Q?TnnKt16wH8lTA4TRCEgzdBKBfEXworaNNI3uMiyBmX/WeOgIKpOSK4l5wWqM?=
 =?us-ascii?Q?sGx+mc18NYgKj0wbRA8HCsaZixxZ9E1c1Q/hux27Rl/l9vrfAYcJ9iUrPnep?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb88df-b290-4d92-a74a-08db7efd8b35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:19:23.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DvDUp2JXfo8saXKS49PgsjvoWHKtbrCG5NOYQh0xhS73UCsmFTciith5pehtwRep7amQ3rPx5jnx9WaWBhyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070141
X-Proofpoint-ORIG-GUID: xXoH1uLeummlCsFMhWjbGP05Js-adWag
X-Proofpoint-GUID: xXoH1uLeummlCsFMhWjbGP05Js-adWag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> The internal function mas_first_entry() is no longer used, so drop it.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 72 ------------------------------------------------
>  1 file changed, 72 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 8c08bfdc99cf..ad6810ed3231 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6662,78 +6662,6 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
>  			offset);
>  }
>  
> -
> -/*
> - * mas_first_entry() - Go the first leaf and find the first entry.
> - * @mas: the maple state.
> - * @limit: the maximum index to check.
> - * @*r_start: Pointer to set to the range start.
> - *
> - * Sets mas->offset to the offset of the entry, r_start to the range minimum.
> - *
> - * Return: The first entry or MAS_NONE.
> - */
> -static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
> -		unsigned long limit, enum maple_type mt)
> -
> -{
> -	unsigned long max;
> -	unsigned long *pivots;
> -	void __rcu **slots;
> -	void *entry = NULL;
> -
> -	mas->index = mas->min;
> -	if (mas->index > limit)
> -		goto none;
> -
> -	max = mas->max;
> -	mas->offset = 0;
> -	while (likely(!ma_is_leaf(mt))) {
> -		MAS_WARN_ON(mas, mte_dead_node(mas->node));
> -		slots = ma_slots(mn, mt);
> -		entry = mas_slot(mas, slots, 0);
> -		pivots = ma_pivots(mn, mt);
> -		if (unlikely(ma_dead_node(mn)))
> -			return NULL;
> -		max = pivots[0];
> -		mas->node = entry;
> -		mn = mas_mn(mas);
> -		mt = mte_node_type(mas->node);
> -	}
> -	MAS_WARN_ON(mas, mte_dead_node(mas->node));
> -
> -	mas->max = max;
> -	slots = ma_slots(mn, mt);
> -	entry = mas_slot(mas, slots, 0);
> -	if (unlikely(ma_dead_node(mn)))
> -		return NULL;
> -
> -	/* Slot 0 or 1 must be set */
> -	if (mas->index > limit)
> -		goto none;
> -
> -	if (likely(entry))
> -		return entry;
> -
> -	mas->offset = 1;
> -	entry = mas_slot(mas, slots, 1);
> -	pivots = ma_pivots(mn, mt);
> -	if (unlikely(ma_dead_node(mn)))
> -		return NULL;
> -
> -	mas->index = pivots[0] + 1;
> -	if (mas->index > limit)
> -		goto none;
> -
> -	if (likely(entry))
> -		return entry;
> -
> -none:
> -	if (likely(!ma_dead_node(mn)))
> -		mas->node = MAS_NONE;
> -	return NULL;
> -}
> -
>  /* Depth first search, post-order */
>  static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
>  {
> -- 
> 2.20.1
> 
> 
