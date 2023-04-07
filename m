Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67A6DA671
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDGAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjDGAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:07:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1A974D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:07:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EubiZ015327;
        Fri, 7 Apr 2023 00:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lnBB9twVg2T0SaK2qRqCeXCqfRoZJRWJQcQhv8oAn2o=;
 b=ujEQ+Q+SCc8o/Y7Ra1DLmIhZqR3BmGBrVo+d4+CTqArFFEX0yZmc1ztj+uCf2ozp6J0M
 +Z9wrK/J07v8egBS9DVJweTIkhYVwgAam7V+A1o5MvHRNDAOsSXpJ8E8e9q8ZoKaDDIe
 YGmzdahcB5PfDgRzxDYrMHKOUnpGfdRWwzZcdoox98sOOz/dKhumUbI8AAUmO41NLShA
 0PfBpw/f9667yafrtxGENbWKhFXgVGEx6NfmRc6ZIP7Hy5Wp1YE1bCx+LJVS2nvGwGp2
 9632yhWubk9JHhMTHfK0/n9pNDKXiSop0FoI4YcX5F82McczgK0jUCOWPWrXDQRL7pQq Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u41p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 00:07:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Moa4X027413;
        Fri, 7 Apr 2023 00:07:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptuttgrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 00:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW/rWoYtsouyBT+LSk/0Nhj1MDbJFtEzzd7zpIzsLTqWsV9Nsj/S90zHujyELAxKtzm3Ra7WFh+pkl4AZ1Vz23wxIr48IUe8Ue1J+KwVKU6MeEGVd4PBUQ+WWa6dIn4ozsGJMd3RlEZBgXrhjEeyWhWLMFxdenwQ5i4zM4xsJ1sfsR6+savh+pXJYcQ5xPoI4QiT9gRaARDMvYiIFEAkFLqwrsDbXAQALB1yxk7izzKykUmz+x9ApPFod3wsFXY4cW1qvQQzDg5aJ+iBmWcF1R8lHTaNgZmOjwE3JK65CaE+TQ4cJJsPTk78/5Xm0P0qXhRHGzlJUNKjEa56FWNRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnBB9twVg2T0SaK2qRqCeXCqfRoZJRWJQcQhv8oAn2o=;
 b=g7LBnsXu76aFtLE1n6GH0/dpSYXpExAWO0OPFgZr2i6eAr58WVPFblvEXWuI8QGDA/3uQ62pXI1zIfXPCBWj3iPT0Ag0oam84K7PrB/vNlTMJxE4zUjjctmS6VqA7thzUdV4bBXMlu6bDja/r42bCYGK82YbYHyz3o8PEBxCfrRpkwAMi+o1LT0fY1ITjiZnrA+QT1jUrvLZ+cv0rhCw5rhvTV4Os7AemeL6n/neIWF9IgYoDHSTutmKaJXJ089LqrklGWOzq76cTXcRT4qr6h4x9wEn27pUlu/VcowyyjCg7/MkycSFIsGehhLOQcXgyGSGIX6XnHhINHZKb4cG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnBB9twVg2T0SaK2qRqCeXCqfRoZJRWJQcQhv8oAn2o=;
 b=ZwISj7Q9l9Y+G0im+aRnhMNbdGA9dl6rFmC50jBxQerNkDh+bGRyeCdd6sSeiUWotixvhQepALFrfY9slTLVvOhKQtCau5172/o8uIGylXpNLIbG5qcJBwlApd0hMI5fypzAesZS14co8pZ/PO7QG/0Kix+XaR7fcrcv9k7W7vs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 00:07:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.030; Fri, 7 Apr 2023
 00:07:05 +0000
Date:   Thu, 6 Apr 2023 17:07:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 6/6] userfaultfd: convert mfill_atomic() to use a folio
Message-ID: <20230407000701.GG14244@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-7-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331093937.945725-7-zhangpeng362@huawei.com>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9c6e29-aa59-47fd-a0db-08db36fc0535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjj+SILwF4WhFyRNCj1BCPUO1/olkv+BOkTL+A4XCrMffdK62o9W0TZofDkbXoq6fCrrCzOAhVm5zROXG7aakKBikJ9iTRa/bbGbnyXHYe2pimOTiNfAjQVPoCojTXXXGwiQrwkQWIthPYLddqpOnW5rPyYw95TPcGjGS8zeASxuLtMaeFmAZrdmSmxOVOtEF61FTbvVjXtpjHbAVzmal5J973CMVfQ1ma/km/Age1cktE9LLKdxGxy5CmhdJdjvMU2MHR5WnKbtiPP1TvzKAOEqLLaywCYbJt6y6bgbu4mEu6VaA6RR+vS3Q034yMBgTQWl87FhCSm45wqsB1lvdQYi6GReCx9RJaM+AnPbDXn2pxSYxlN027yCNipWDF6EvOHE7KPILD08zCXEnDw8Zl59SNuR/UZWP1hGTih+45E6g5ALMxRF1PLe1ymT2jiZQcJKCQx+nLSQ16MXjWKF1RWrA4klSAow4hFBYVsjCxRDTdahp+1B8WXm0bMom/3LCuW9WKUypiBbiBxl+JuD2eXoN3dQETMraoH0OMYla9XGqwHnGs3ecb0jkZwGQc73
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(86362001)(33656002)(316002)(41300700001)(6916009)(4326008)(66476007)(8676002)(478600001)(66946007)(6486002)(66556008)(33716001)(8936002)(5660300002)(2906002)(4744005)(44832011)(38100700002)(186003)(6666004)(6506007)(6512007)(26005)(1076003)(9686003)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxq5dmVpjA5PjiXzmQxTMY2geJOwu3vKq8x2wlj5N4PGZTvVq6uFpYuXUHVe?=
 =?us-ascii?Q?HkMKOPobBvD76gM+BsTSBVNuZWtRFoURXAlzA/wWhLc0Qs8I2ABJJ0Dlf0Zf?=
 =?us-ascii?Q?JiPb2SsSmLfSpgdECLVigBgordEz8sLwUxXXhsGv01LhNN6wdo04yuNSp0+J?=
 =?us-ascii?Q?+8meRsqf21ntWEMsIgDK0eakpgIS0SFsENalyy0z8iuEEwltnoqvgbxscXa/?=
 =?us-ascii?Q?n0vlKUqlXuRbuEcHEtuQt5hczAJUDhDbvyvalrjLmbSWizez0P99dddTyKfW?=
 =?us-ascii?Q?XyPaVVQKfw/Pi2sRsEHxTySGSyTSPMQgSMtavsgsT44cgVBGi33WgvbtGBGT?=
 =?us-ascii?Q?4zygfujTV6WKijxEzlBCvpvDw3C7z+oszA12QsIcRUu9waJMVHTfoZSQSnr1?=
 =?us-ascii?Q?ki3zkzAiyrq09nhpulUrQpo/oVOF/Zs44EOOhlQ6tTIaghEq2jePKoGrxLM4?=
 =?us-ascii?Q?WuIKVY9cJj/xwd8PZDzncf6mhmxC5BhztQbiRqBVUiaJQr6QYP15RGCbKizx?=
 =?us-ascii?Q?wkjYEbIB2ITnuxRIIqhU5AjiQ0b5Vb1oMGmaKP6sAwpr3NJ16BQP8nM7gEvO?=
 =?us-ascii?Q?t51i4IVbf880WirZrqtapxKrz9kPnx2yeyBnB+IpARdCDrXwpuB04OJntICZ?=
 =?us-ascii?Q?t29OhDnyEjGAJ0o8eS82f9m3K7SNWwEQZYPkyhSSN3mo8eWjrCV2XOvp9RIf?=
 =?us-ascii?Q?5SBN/llgTXRp5CGDAjWIiPE825fDzXX+U1L+z5ZDHGp+9x3DYvx5jgzIaqng?=
 =?us-ascii?Q?rAxEJcsHMmRz+uGTApVzwmgvfDwEZOZS0jODJzWPj/bDNXghzChE5q9X2jhv?=
 =?us-ascii?Q?4860PAZtFPeVmk7c9ZHOl6sky7KmRBrcHTIMBHcPphnA+UqrW8S/Q9tWBR4y?=
 =?us-ascii?Q?KGKz/gcVYs7lrnvoD2m8iXWE20lpHh/pKJHw07WgLKK98eikqU/+IYjSo0sY?=
 =?us-ascii?Q?CaR6k7m321At2Wdh8Ih18cHLdNrOaO+JVBrCWMjv7biqIPi/bnVcIPBVFMuL?=
 =?us-ascii?Q?1hEv/mCfxcl/J61EARNpTmD77Qumkz8EyiEj2QR4inZtbg/LHgkgKuUuxfq8?=
 =?us-ascii?Q?G69YHCTMcxUuVJk8IBOOVypT0a/7kdRSUGnrWu95ouJHI4jtL7rfQ8AkSdmi?=
 =?us-ascii?Q?ljSbZA+7PaEJOvSy9lKga530qXU1vU3hw/8qWhEm3g3ML6SohmsVTMshs67b?=
 =?us-ascii?Q?fwcnJv0odytOmU/2zDMbVrXJO+6+P99w38PChpIE4GyOmbedzk1qb1OA9abU?=
 =?us-ascii?Q?mw+oG+lY/QOAS7uFsVjT1OAN1PCqD+0U6SuEIK0Gwjh7yB6N3YKMNC0OA1E7?=
 =?us-ascii?Q?beBT2cAtnMPBJKSK4Ic0DL9VkLsFU0tyC6PPdELKp48vIeQlTFZHXud50fKk?=
 =?us-ascii?Q?XXCkyk7hBpN+N7exWGRqr+eJm9l/v0nWlLIUeZ8yAwyfJUIMN/PNKn23tbmr?=
 =?us-ascii?Q?9IpxYztKTvjIQwvtSQoXO2h0WzN3YpI9aW/NHMwLg4S2RzbppeABMxNWmjzf?=
 =?us-ascii?Q?Owg6JiJHH8bOsb8wE5rE7vG+ca5DRC4rFnpBi/DoH5CtPVjBh51Fx4B5m/nT?=
 =?us-ascii?Q?jT1WlCx5k/x4W9DgRRfXHQ2azhpZ9E79tN5UJmbjmpTSOCaep6IJ8nsTdD0n?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c+cosqaWCbUzQkl6Inxa27aV0nZF8GEQyxHK5Z9Dy0E2ETl8AFSiyKT/FbJI?=
 =?us-ascii?Q?VBt0gS3MLGvOQdOMXz618/QtOTQ7vieQOYGFm9pzDn/hHVlV1Yz0cRgLnuIc?=
 =?us-ascii?Q?Ax8NRFAx3Ebko6svGC7YW9XP6eOXcJN7Ioy+3VKDaIAeTmbvZfiwrWRvUU/o?=
 =?us-ascii?Q?L84VKnvW96/7liVZO0Ro7ivn0dkI2ElgQlEtIik2h2lzIXGVTr31tb36dz14?=
 =?us-ascii?Q?i0pnsJ19DZjmNeB/5hiN1ET8XjpW9O4pTKqR5H6z8+lta7gvLfHkt+9T267l?=
 =?us-ascii?Q?Flewqffo57beEts8fOdOVp0EvYic3aUKy8rZzU4OlnY5VYU3hMZerwlSaDt/?=
 =?us-ascii?Q?Nv+UKQi+CwT9wMg/NgmK2gVOsIj+z6D9t6FI1bQ8hJQ9Kmx3LbW64JRJjXoE?=
 =?us-ascii?Q?k91r8nTeI3MTDiZr4VP9exWVFpmLsZA1PmNZNw2l4YA9G+6gtqOJQLz36Atg?=
 =?us-ascii?Q?0AjrOrRUTV7Q090MsZIyhdFaHWko1oVxsjw3mC5l9sK9MJJP1UtlzKgQG1Fr?=
 =?us-ascii?Q?4E6u0nnbyToiU/UL+K3NU3xjAVZMRmmNbI77difC+yQFF+u/TEssV9lJ+Rtv?=
 =?us-ascii?Q?WEZGRZnCSGyU9IR8yrC9AK3ApWQyXlS8wWP8x0c7PRfqWCllx//wlDPs+ZCh?=
 =?us-ascii?Q?UkSi48L7YOSigTpgLLW4tk8bQMGYsKElU78wqTq+istaV+1Jp0IJ0onT47Vb?=
 =?us-ascii?Q?o3wtUvt8gcin8A2jrazHeUiVsT6axDH+5X0Oya3//4QN1dR8nmebiMqGFZbo?=
 =?us-ascii?Q?63SOopSVry1SgBYaNqsVSdZGE8S77yVuerDUXakZRm5W6WZx+3K7P+oQL5UL?=
 =?us-ascii?Q?iV9KioukimEZuoQw5tKeFkJvaxqD35bKPBToRvRVCJ8T/S3wdxZ8eqjn2JFe?=
 =?us-ascii?Q?1x8aRbKcxir0PnR2pmB8G1+VzUDuUUXwKv78clEhlebR/DPS/vNe5f3Dq4Yg?=
 =?us-ascii?Q?ixkbETZdc9NZ7DPszlAjEQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c6e29-aa59-47fd-a0db-08db36fc0535
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 00:07:05.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbl+A8zoLyrvquAI9KqSNXXAociZ6HCgysv4sem7mttukaHinbUKCJg8gR6QFWbq3gb4uG8t9EIxIR6JXDogug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060209
X-Proofpoint-ORIG-GUID: edYFk9fHO_IBjhx3wB_7ZM92ESkGiQbf
X-Proofpoint-GUID: edYFk9fHO_IBjhx3wB_7ZM92ESkGiQbf
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/23 17:39, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Convert mfill_atomic_pte_copy(), shmem_mfill_atomic_pte() and
> mfill_atomic_pte() to take in a folio pointer.
> Convert mfill_atomic() to use a folio. Convert page_kaddr to kaddr in
> mfill_atomic().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  include/linux/shmem_fs.h |  4 ++--
>  mm/shmem.c               | 16 ++++++++--------
>  mm/userfaultfd.c         | 40 ++++++++++++++++++++--------------------
>  3 files changed, 30 insertions(+), 30 deletions(-)

Looks good to me,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
