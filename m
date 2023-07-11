Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730D574F7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGKR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGKR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:58:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A410EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:58:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGweQF005734;
        Tue, 11 Jul 2023 17:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=reH4NmCsABZ2vZrw6xWnxLxEZk8Zgy2DYy4qt77+BgA=;
 b=ylZALf7/5adpZpK5ZTbHMLyIgoS8DixGI8g8XBZxY4u83lM+wM/NsbOqiAuC6JvUdqG/
 d5VdDTB6/Uu9xEaaD6LzkfbIqYFi1J1Do2E921ZM5WEMPQ4mS0dfa0EBHQm9aCyX0VW3
 rVJaXtwqihhi0LO+fm8xLr+yI98BZwpOh7Meh6He6hHLRybbK90GwKCgyMhkd8koypKq
 lt+t777XLD1sU28lQNEyey53GpHyIPh7Rc/e1w1vhPRiQyNoKPVVAXjGySnOZVuXUb5Q
 3pojNQ/bI4PZvCWiOdU28snfYJI1Pe++UEnc0OlYFy4nZUQtIXRiOhHZRz04cWn72rrG Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmhb1gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 17:57:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGVYCr007096;
        Tue, 11 Jul 2023 17:57:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8585x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 17:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCAmpr1i5iql4uKnQQmCTSSrzS8YZ1jgZLCL9eT9gDTwHabKrK7Feym30eGtDyS3hXvMxUBDzUthUkkpN4N2gHJNT9HbxtBKRZFK7rj+Nc7QqpLJwjto8E3OaUeESQEdKUeK4nyynozC2G07Z66Myhl2igacB4pOiObYyqck2YWYI+hPq4fMX9UN0Vuq3MjTr6ppqzD4PDJkrbeALEZzjtVUaQsOSwc+bzGjeYGAh1Gs3sqgmLdiFlJyRsnaOTvLv1pQs9DzhwskTFZejLdog0DVMw8+MJzsUnfdnq0+E51+bhwc47ANs9igrip632pzWVea8rvx/itoV+5aZa+H4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reH4NmCsABZ2vZrw6xWnxLxEZk8Zgy2DYy4qt77+BgA=;
 b=MU8gb+7hr3AENWmssoVyx2upKyVewh0/3KQ2SDl3ydyXicJuVC+yDohl5AK04KjLqbZnfCdhDgjFlwb4E+dc0QeodppmGEb732bjMxPB7Gw5oplvA5piMIcaapDm1mjIZitaGwXJ4GV17GjVtp/RMvrxXNTwP7cCRQCq6fOs3gySu3s1nlNRvR0Y8bDUuPfR7BwqPdoG83d9IuRgQjnos702gelss68zd6ivZuhMba7o3/1opv+ahF7rMqlwDXLvWUApKps+BYTWN+n7DtxbUNsoEttCCAdVUItaIibijPvOkhb6UbY7enYljnEciGiCOHE9xZVQKLFt+K1jRqAi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reH4NmCsABZ2vZrw6xWnxLxEZk8Zgy2DYy4qt77+BgA=;
 b=BHFeo4GCFTYipeEX0GG6zTDr3esOPcWJ15oQcGitoXyvOGmOjNaW4+8jgaITGimSSbpRMUPeO12K3LDgGAAeQcibwEbga9Wbzjm4/gp+QvYUSrQt8iu3gbKn72pXUv4ePj6tNJTzzJc6saf3m3cHUrDtd1em7vUu7o+wXWUX5M0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6023.namprd10.prod.outlook.com (2603:10b6:930:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 17:57:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:57:56 +0000
Date:   Tue, 11 Jul 2023 13:57:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v4 18/49] mlock: Convert mlock to vma iterator
Message-ID: <20230711175753.lnswipnu5ri3mtdc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-19-Liam.Howlett@oracle.com>
 <50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com>
 <20230711152734.hith252qxjbnz4bt@revolver>
 <6fa76b99-24b3-9410-66c4-d765ef8f4c52@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa76b99-24b3-9410-66c4-d765ef8f4c52@arm.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c9e24a-7912-4c70-ebac-08db82385b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r95Hkvl9r+Z2HPvkAxSyC7BQpOMCsu3QDtLajHQEiGbo1vDxYcFMsEYBsLn29oUKVlRepyQntn9VsQ7dlvrG2aMTS369y0KrlaB35zcFikZUrrnpYVzqzaf3y5dAUkzJhCPHQbd06I0hNTKMsBuDqbgGdwl4WF086+vfXzgRDJs+olcY9F7tKq4xi6Q1UsxcvAk3EWMz2NU/ND9rvIOet68d1Oy+STdTvwN6ZMa8aW68Qn3iAtoguT6CLWk7UmXNqppYtJYCooGg2FyRcPJwuhCuSAF/WR7MJf8Gp4bxsf+Exp2UUzw9OxIyTPnLjlKADhtGSCfb+qCL+1FPbs8MfktlKkAY4TSKD9JcRvbYOle/c33rxBxZ2EkFr3iMM+TdNAh2ZifNb6VbDi/I6ocP0IPsFSuzfqZadBkvrRJi9Ki0v1x3oFxx/PtMvgB66cbbpTzx5+HA5M85lbPnbR8YMmcpmETorBDFC8k56x6Khvj7Q+rpC82Qsqpfx0UTGF6qRQ/xRRPqNNmIbIIpt/DfBxMnhgxN/mXbWg6D3DMOCYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(83380400001)(41300700001)(8936002)(4326008)(6916009)(66476007)(66556008)(8676002)(316002)(1076003)(6506007)(53546011)(38100700002)(26005)(5660300002)(6512007)(966005)(478600001)(9686003)(6486002)(6666004)(66946007)(86362001)(33716001)(186003)(2906002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwLhO9wUrCSKlFrfCEXr4Ve5xNr6iSYu2CpsjZRnwzyjZ429HDf1lJMbtZcV?=
 =?us-ascii?Q?GC+ouclYFowUGUGX/KXPzEz4cz0JkXCIfXTcMu1O1VekrG7I7SrlwM/yQCSg?=
 =?us-ascii?Q?CKGrp/lZwd0W+65A4N5htUGUj1xBblU5nWRYUxQoemLJUPuoHAjIPO3dQdF1?=
 =?us-ascii?Q?m3czaL3r3UyMZO2jdNTqX+DlkqkJRNN+gRibsDRQyOvSxtYOVWTY72uytoPM?=
 =?us-ascii?Q?eu4o119qwA/wBaFH/pgC2LsnVY8BTur2B3uVRZ4vuG4rhPpR6pTiezlcwSmO?=
 =?us-ascii?Q?aSDgOhGM4TMxhVc/MD1bsJbeM2akuymjVX4v3sLDkHWCYEN/Akge5VQ/Df2P?=
 =?us-ascii?Q?mhN9b8t7Xghy+4+GFUiPvc4LP68GsnqUBGQv8wjuNin8koM5tLw4GEd6fmZ3?=
 =?us-ascii?Q?5bEHvikuvDV5ejyCh4YGU1SXSEA0Ix76WiJ6I69OQudHMd201fgZsjQMx3Mw?=
 =?us-ascii?Q?GZOQxt2ujRvLYTrnsc9OEkhv0h+GdfQDW47fFHqf/hQJLfYZeRfBp0m8fHjL?=
 =?us-ascii?Q?pAfldPKai2Q5a/IsI0nft1CyxV0WJxhuTlxbYK87soBnEXLuOmXkOtShmylm?=
 =?us-ascii?Q?XN4b7mIuEuDfYnafDUBEeB510vSMr9MUVjWZDQzW8H1pyoOPFN6HPfoHGbkr?=
 =?us-ascii?Q?JqkHfT5eiywdp1MOabRV3PpgtazySJnH2xKmuoLmx91qx+2uil6xioB9tHiH?=
 =?us-ascii?Q?Df9hGesDBXn0I7MYY9eCUPS4fqrInremsonV/0qInO38A1oKdNpx2FkDo0YJ?=
 =?us-ascii?Q?Jk6WRnEaqXSaGDK8whQCHhGIoi8ayDIJ8UpI9zmIzqHDe34AUFH2ZCyjhEGF?=
 =?us-ascii?Q?39ZQ/zET1aN9kK4TnoeuCA5fY5qzvKtsAuuH05XwH4BC0Ltyd9EzzD3kLcqU?=
 =?us-ascii?Q?u9IH+uEff8fJRo02qvoTvETODCCdnlRmvX44WKu1lSp3LSUp+ITrnq1TpK8l?=
 =?us-ascii?Q?a7aqEVNkmmQHhNZLTPW1mYOPKQUYkzfGb+L7kTj0uN5yydmGK6ku3cWzM8Qh?=
 =?us-ascii?Q?EKMtlDPc1ntIVHPf/rBz0qZQLSPonLOhpgLzTS4j7a04aio3qg6eWWPa9oW/?=
 =?us-ascii?Q?IqC+BX6EtbjbuaEgGUNq9Kt12Fb2nXaXbE0+Qr4E/s6VhGq0y/f5PR9ZS70S?=
 =?us-ascii?Q?fBB3l1+t2ARxS8gX7mTIV685MHqoAKE8RfsCtzP7x4PRm83GvJsB8B8WHnjt?=
 =?us-ascii?Q?TVjioCiFSOnqF+S7eWeajtpFNde4vdp1evQNv1SWfd/bdZpe0vXGisdApLW2?=
 =?us-ascii?Q?IJYCllstvLo/Rz4opTduOQnBjqZ+fkmJI2Gy3BUSeoFoSN3QdEoTVhUCuQPT?=
 =?us-ascii?Q?zhvzJ/WeV2Dw3IZK+nqk8qJLGPcIAcG1gD4Z5wk3fcGLDGl+31PIMB1HztF9?=
 =?us-ascii?Q?YRoKLSIFJGTvDaG4ROByGenwerTpeTwd39twDXhQa798spJhfKH5y8SdfvTV?=
 =?us-ascii?Q?zaUHABApCoMnyMwb2yCkKMXjqk/pd1TdtdSCBJTKbYhdbZOl34F+J9uw5+XP?=
 =?us-ascii?Q?Sd1W/ueu8mHaIXqKEjNIcHgW6HW06FjB0263NTtZf6QFU8Pg7DScriNIKFqT?=
 =?us-ascii?Q?T7RaxIB0OVknDL3h7cFr39Vo0hPOzX173gkbwJvgohspILI+mZyDgNVC0TUK?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 24T+2L40sLepug6QzL4MIIxlVrpu/nbyFmkPuYsTZkZxmH1+sy1FSzpVsDQ7twIklQwNhLPTmbPMwX6uLknVzNi38hBcEx8HIzHPz1+s8mdxF5njKpOBV72gwdwnh9LzUbYnW1PLBy2PqtIDTNN3ExDGVnbUGvgtrkmTmDQaauktKy11XaEuGDfHBOmFlPsJBrSZ/Cc/fSTAyWJ+uLsVNrHgplOEs3LM/3ct76xGgrTWOXRbISwaUJ5KyXBEaD75syEiiCsmbN5fR0MoCxqmNKQZbbbzhdJRujsxgl3nGjsNVWlP70cErlv9TvyjK64j3oesOBYrPorRgiSCjZWJ5VnSM/1pBqoR8VZWO0Mig4xy3+eFeQA+w33N/1AVeI8GoecyBVsrULrg3IymGH3RvPejB9yUuUOAM7uXG7Mmc13rxrb9HwdNvD/HUMCt7CzagEXwVjAPbxLso2UkzeXx9vYY8AlMu7LHJEKc8MbPFM5dHyXA7CXmk5MCYALg+3aIWtr1STv1M9dgBemaE5GCRaMhJG2GQdNM1xIwsETBPs7nmfeJgWyvL5jIsU+CS+zakk12eGabMHSpEvlxGBnm+n34Uk/6M1/cR/4NyIuvM/Ijle2uL59tld7sbs8RovAGspxxihTSDXYsH0ZwF+BDt+LBhA5GtBhyhTerNxmQdPNKFxqQojPCNZA5pgWzN7eFLpZXVb6FdrppNkXeQIv3bZVTZCpWbuW1CZsMNmcjq+RLofj5Uy6z1n3dnyIBPz8c7Ve/HAr6toGh8+8PTU8SPrc59KB2dxZiC4KMTKm6yNd8Q4YXLwUKlcwln1bYBmRpb9hVrcLePJK9TEc8HSLGAmK8zieSbqgkUU8N8SSP1QCBOOpUnhe29WNipWjWGhjkb76F2JCtOy+6++O9hwGmaQ5JeamHflmA4nm5UaIOo4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c9e24a-7912-4c70-ebac-08db82385b19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:57:56.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxccMAitWhoiZVPrzQJ144L1QjmA8mLiQWXrzdduoXqEkcVmMCEtSVkwx3cpuuYLeZE+/ZECf44Uhr5IVyICKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110161
X-Proofpoint-ORIG-GUID: nwX-83OqI_X7enwK_-29BzYZ5FFvwy0W
X-Proofpoint-GUID: nwX-83OqI_X7enwK_-29BzYZ5FFvwy0W
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ryan Roberts <ryan.roberts@arm.com> [230711 11:30]:
> On 11/07/2023 16:27, Liam R. Howlett wrote:
> > * Ryan Roberts <ryan.roberts@arm.com> [230711 10:09]:
> >> On 20/01/2023 16:26, Liam R. Howlett wrote:
> >>> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >>>
> >>> Use the vma iterator so that the iterator can be invalidated or updated
> >>> to avoid each caller doing so.
> >>
> >> Hi,
> > 
> > 
> > Hello!
> > 
> >>
> >> I've bisected 2 mm selftest regressions back to this patch, so hoping someone can help debug and fix? The failures are reproducible on x86_64 and arm64.
> > 
> > Thanks!  That is a big help.  Where did you start your bisection?  I
> > assume 6.4?
> 
> Yes, I'm working to get all the mm selftests running (and ideally passing!) on
> arm64. I working on v6.4 and it was broken there. I went arbitrarily back to
> v5.10 and it was working there, so bisected between them.
> 

Annoyingly, this is similar to another bug I had fixed in another
iterator across VMAs.  It's the same pattern and I did go back to see if
I had broken other places but, obviously, I missed this one.

It's annoying enough that I'm trying to figure out a better way to do
this in general.. A contiguous iterator of sorts.  I will add this to my
maple tree work list [1].

[1] http://lists.infradead.org/pipermail/maple-tree/2023-July/002683.html

Thanks,
Liam

