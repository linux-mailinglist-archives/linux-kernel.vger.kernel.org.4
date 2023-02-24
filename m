Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29296A146E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBXAxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBXAxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:53:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461017159
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:52:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NGwhpK003586;
        Fri, 24 Feb 2023 00:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=TMEt4GJaxPX+Lao6n0Wu38rtJxa8aqq50O9zFhwF86Q=;
 b=Ijy80s8x3Rrnhba+tdXGQXE766IWlJYJCmSvSryi9arcpGY0QSy+JdMvyBnFvTZ6k6C8
 IARLrveg4Tarm7y/bP9kLcMz0lYBPvKSRXNPk5RYBMQ5/Avsy0+d1SpuIJs3gBZ8aVK6
 9NbKoGxF637qrzTkgcJjKAkp7i66cEqdawPRmxXJB+owsjSc9bTbgMzpxzXOByDR+r8o
 0cbOdCxWMLTU6eJ6garVd8UKbvF/YaXGeJFocI6TUpXvSHtSdFeGdS9sRqsUDG+TkvyB
 f8ruwbu5puuRSqVdBIG56KiRRjEbxeFda8njQY3had68CuMrD+fmjcb3R0O6DH6qeQ21 yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dv0md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 00:52:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31O03cup013430;
        Fri, 24 Feb 2023 00:52:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4fe3qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 00:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYPPNvRw1nvUTrYoUWFWIYoH6TbCpb/+zWiiPMBMx+UhyUI+HXi6tBNftp+0FcnAIjYb5K7B7+t4cR0DnbfYu1GRdLBDWXjc+c5v3AaZompr91WzBlu7YpD+ZnryXhwVIhEZwTfJS5Bbjpchlo78BzaR292jGXEXlg3ANg0xj6SdiljHDi1kSiClZaFq22J7Fj9mpx3RQCINWMfB46bmSqUtn1U97yzknIq4rnpdpHx1bqRkfd25JHZzA0CsqC6KGQhZXlIp4DahsGRATyxuUL6MzF9KCXRhmTueGW5q1VRZAWzWb0AlgLXYQCxrsVZDZq41O3ngkYcZbOD7MdumBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMEt4GJaxPX+Lao6n0Wu38rtJxa8aqq50O9zFhwF86Q=;
 b=Hu+LiExYb4PzDotSN2/2uuisI0p5osd3KDCXGpIbDXgwT8DHvvzAwIZZGzMZkCqAG3T/K8H7R6pY8ZFxdQ69AsIpYuBhkS9iXUEn8IvLXORmSSz91Y1TY9qxvU5b0RfQh25CyNusSvS7DknMkV997R96k5ZdqjpUSC2RWYAL23funWkVBAMFMxZqiljCk5ss/SjpHBEdiUTi3SXqx1uivq3oLefbXgg9eNoH2r9AvLE+5YGovmWkcLVoNRo+3QYVXvf8Xz+WzG7asUTUdP0qXmp7h0A++WIEqb26IC5elrYStb/5u2yavDQEOBVs3RMWdTobl/xsJ2BKp8XPrVb7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMEt4GJaxPX+Lao6n0Wu38rtJxa8aqq50O9zFhwF86Q=;
 b=PJYOKcSMUoasIYyhpnqijW86n4klBPQyt4CNZbrTN7+7QcreZ7I8e+Z/A0LgLLSZmdO7eeXV6/IJEwcN7plCQZ11mpD6XxCF7CGR6bzlItO0P4p5MIGfbxXtrBCuM2jI8XcQOvfPwFPmHx+PZErI2MUmtBw6eAACjyYJPSudQLk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 00:52:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 00:52:09 +0000
Date:   Thu, 23 Feb 2023 16:52:06 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: simplify hugetlb_vmemmap_init() a
 bit
Message-ID: <Y/gKNulzbHYxzpuL@monkey>
References: <20230223065947.64134-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223065947.64134-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f79b4f7-d573-4e02-509f-08db16015baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfvChuypy2IrhXqOnXhrEpuQKDj7KDe+hWFFqSexI0c+YoOzW7JF1OhtUADSNP15uWadrCi81Xkc3tck8f0bPPFXlOUv2j+maTE6YHniT+Gk4BqmDOpE45zlkNjqLV8AgLjmOxwPtiwCl0dznUPcRDxghny5sK85pwjlS4A6eaScu9+eEeq3zuQ5TRw04RL7b82lqMvdxbdKTfF6NOgI5x9TCz/BHZ4XA6Ll8tEi9c5DWQSzEJUTKe22J1CXuPy//lwGFkYb4mHI/EVWl+0mE2YZfpK31dpz7qQyPVCgjSCCfUbRUOAEOCFWkZ8Jwq6ud+sfEgxNglnofJw5Woj6+19EWnEJBrGLovhtZhLA9XRXE3anTv3Q04k+j4sVEP0r5pssFAn+E7qvtbnvHwc5yETbowm0UnMbq6TRzopeWMhMB02fJYggMUy0i5hdPpnho1nx9bxBwWinnkuEcPsRSWqBlS/L2QJYQjPqEoMfEZSKY86iZwZqPz73/MFwkslQndTqrFcCvheIMF5n7l4QxGmWqod9BmK2HJNUWdt3oGpq1DVcE7FxZjIhdbRXSDk67OVnh0U1SyFHi6vF+FIvD4ok0M/QI4x5v56s72KmOkInW2EThpXWVy4ASnFSoodbuyI2szm6q/tkp3SLWu3MZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(33716001)(66946007)(83380400001)(316002)(478600001)(6666004)(44832011)(6512007)(186003)(6486002)(53546011)(41300700001)(26005)(9686003)(8936002)(86362001)(5660300002)(6916009)(4326008)(2906002)(4744005)(6506007)(8676002)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlNjH4fEoIqXJjosKlOmzeZlYM1gbOG/kD5xy2oE0rGLURCc8UzyAOFEOOLF?=
 =?us-ascii?Q?BPn9hshDJ5BHi+U9AIVyvwZbLFhfyKxctr5JKbBVON/9soR6hF6oaKf7DCLa?=
 =?us-ascii?Q?7JQK2GS5ePtT1krJLen76pmOSKNuQu6xzQPtNxQDj9Bx3EiteFMzOIZ+ZjPv?=
 =?us-ascii?Q?O5uhzmaHpUfAeqk7D7zwB81e01ZGjbkJcWUTci6cG/rw4Tw5UD8MrtVIsIYi?=
 =?us-ascii?Q?uLuEa4AScUVL+5uhexvcJsI96J1hNgb17opA/0ojubOqrb9OXeigpEF9AI5N?=
 =?us-ascii?Q?UycAvVdPu3MeeO1hIR3ZT7Wi9OJcdKEK3bMbbfr0sO1GTOqi1j7AFbh81Zkw?=
 =?us-ascii?Q?3lx9ufpzMlrgepoc9riJSqr88DLTTg+TSvXuDjTqBj0fWPPatPZyXLMoqFAM?=
 =?us-ascii?Q?NTNcWNfq9uVGOTCJMYicRqnBsIbPNVEDerz01d+TcOo/yRlboLR90idV9hcn?=
 =?us-ascii?Q?tspalyK1wVTK+sas8oKd8sran0IxGnAsWl2+JyEtfbHwj45vaghx99KqEbSS?=
 =?us-ascii?Q?wPVNZV8oJgH1574CYqsBbBpB6LFxm2ouP8Ls1nvzpXZlS1dGy9RoxrnuhTMe?=
 =?us-ascii?Q?Osd4Bl99mOVUGQ5NSttjrAvxQr546ry/vp4WQRhoM7W5U7OQiULf4g9N194z?=
 =?us-ascii?Q?wuIdwuTVWysrwyBx136yrxqw8GjIZ2zWPPHuXZCTEwQCDAu4vYH5IL//1/SK?=
 =?us-ascii?Q?5uKN7ppwNA7/irJgmBvTcRzHYP4omfflKbqD6kOHqctGlK2xK2DbmMBDs8br?=
 =?us-ascii?Q?5X/MKC8sd5B1QXKAWGsLb+jrI1Iuqv9g7mbA8qWB/0MPk1OYRUpD5d37frg2?=
 =?us-ascii?Q?iGTr+DaSDbp8NzLqtDAYkHcUiH6xCqBjUblUPB/KAW0OPiHLl5jvm/XPK7Cx?=
 =?us-ascii?Q?DQWiFx56DEbcboIDoE0sFj4pn+DPMQ6OkKi9ivvZQYbvtvPdmsbY6QT6O5gd?=
 =?us-ascii?Q?tk1U/726bxs9xmxNRm4bK9LgBEGv/3Habg4vADVaVnbpRjHKEktt6GJfyj9d?=
 =?us-ascii?Q?tuq8IowwFLNk37XdLQVBfFbNl30VRxprD4JjBRdfvmBXQKP/I3yJNRK8vDNy?=
 =?us-ascii?Q?/X4VyZb2MmgL+h3GX0vF+pihM+sJ0Wb/JolGIKMLipphGXwJFvjE9eh5BOw9?=
 =?us-ascii?Q?BerWxBa19g+ZlWAUI3mgxBP2eM9iAFlztNoHFXbAR8ky/ALtYYT0Zar8cgY1?=
 =?us-ascii?Q?8nHHB6pn3BbfCT3d+/pPkg3KG4SXV/ZOKPVV/eDpPa3vxJtp7FIfC4nzcPP4?=
 =?us-ascii?Q?1vhPourrB/IEQsKyuP1t4u49HAq2v7oxUEY8wAiMkOok3GCmT3xMIc+KkZ+2?=
 =?us-ascii?Q?6Ge9lk0WRMzthwPK4kK6MiCsCVrhunV/ZPVQxWfi9gB6Lkkj73v0rohWOyOU?=
 =?us-ascii?Q?5Q3LKq+DxRvuwjsQUEXVqaKXn9cYT0UOvNEziVoiYN8lr88wbVJ2b4HtIcU9?=
 =?us-ascii?Q?pkMag6RDl5dBEeYMf9TmcrnmgBCws039gxOg1Dr8qnifxikWkTqBtPrxfd0h?=
 =?us-ascii?Q?MHttJRK5yuDCEDSCy8zZK3yLm8ixDsOXnr91thHwID6VY6+UFuq6/38e5O5I?=
 =?us-ascii?Q?rtxMKTpXhhi4WwED34cpE+I5igTr+cUZXrqMtiZeeFPoew4s96uOdecMwn5v?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +U/8tBPr1FRG6H7Ma44PSTIUQNd/6E6TuDq5vJkwxSFG1+BVbZZxpCxT4zNqMhGLQig/5mdNplXAV9frbqfUkPAVnTCtsNkmFbPGOG63jo/47xHQq/NIoFEAj7oCGK8hhJQsPKTto9mnCPBDDvnKkqrPuY4kzJq21W6rFMieRLDQDa10IwlqyXejzwetvPYFWc4k3wIYhzPyaOX34ECRZjffbSedPP+dbm87kECjELQWHBJeIJNvv27HsnD0Y2kJsAT2hmKblYwo5KLK5i74XPSxXLw6BLObcX3VI4DnDI6R6hpU2AqXWfrFkNYBGd8a2CPYWdpHL7cR8VH3W5oRa+uJOKEb4nxkYHzoUAdPC6jyGQoQDiPkzxRKHsqQU0FLkNrc+uJtKTduE0WsCMfJ0cKf4bIjJq2gUk9+uszFSUsYUhuKVAGiTnleWre7xHe5jMx8AYh5Kcd7zsf+jHy0Rz8vP7w3oXhZlKikhglx4ckLYQyNXYvXZIbdfcEuSpb9Y7gDD/OsbtOkrSTjVtudBPCyHvhqz6FeB9QyVdnNEg7xon+3PUJ+qCHxd24laKrX7TiD7Tj71tr1IeZ3HnMy1K6kU1GtIHfCZgEHYAA4b1wftn0YbjnE4JzJMaeBBXFusi5g/rBxyTnfZ9Cbjl4yflyLPnWZuklAon8ZyaaPWehmB5Wx5KoztgM32A82syQREon8sWSNMXIxtRVmOaRYB99tvVw6G75ZDNLx5+KUrSLiZY+ir/lMDRPrc0plI2auM14CIT49L8rj1s95Cn3sGWgIzwyi0uC6fNSRKzUgcS5uYIc96FTIuPQGbwPKzjoQUyhicqw3opCNh9u5fOWcYYat5aKECvz16v/m027YICW2Ib23WRfEfexfsXpRqmNVdUeNql9qtk5Ql9nwY0c4OYxwNM5hSbAhg7Tjk8lwCKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f79b4f7-d573-4e02-509f-08db16015baa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 00:52:09.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpDjpPfj7ntRLqieFGYHtKAMySSTaRWT6/r/6s4SExIAJ669h1BgvfOi3fE9eulRbSMoV4m0Pv9P9fNRRxV0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_15,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240005
X-Proofpoint-GUID: kLcAgMv1DsSwLvBD0gfdkDFslK9VYToG
X-Proofpoint-ORIG-GUID: kLcAgMv1DsSwLvBD0gfdkDFslK9VYToG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/23 14:59, Muchun Song wrote:
> The check of IS_ENABLED(CONFIG_PROC_SYSCTL) is unnecessary since
> register_sysctl_init() will be empty in this case. So, there is
> no warnings after removing the check.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
