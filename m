Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35174A692
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGFWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGFWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:10:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1410B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:10:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366KnwVZ031502;
        Thu, 6 Jul 2023 22:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=u2bvqVA/3lrIuYA/L9/Q8HvU74A+LUn/Oqy2CtLfvhM=;
 b=RHps8PpHK9RDXBoxqnkz6NR6VnKRvjHblpbFy2R81KhTcFTMzfOsh48CStANUCWIxjWu
 F6plDDida+B9FzriRnMvBIyJUYjAD9d4diisPLZvBJ/OitO7n+W5pkYJjY0fjmyIMIoz
 7utHZnoLYKT7h3uExeu5dSjGKzFSnGz13bI5cQdxPVKe0GjC6Tjx9QM5CCA4Vir18ke/
 BlR5wFxe0gzYPaZw0dHoqOTFv585eOyGCI+9OQD6aumfne4rJhRd04qDWdqXB9C2eExP
 KgRKxOq2J1gWVzVT/Lj5fa681TWw+4IqWr1CcdRNVevDSyReB+/eEk+syo0zuTr2aORR UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp507r39q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 22:09:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366KKEOv024594;
        Thu, 6 Jul 2023 22:09:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak850y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 22:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoO7dAlX9IN/iyKyQOKDtDubVLjM5HFo6Ht+t6gjlGXztLlI+6PAdpaQJ6++Ayufn36SByo85AIpOeYXMnUN/fVsHs27sgeULwvJujZSljdfO1wGEtMEqZE6aAVpLybQ9+hrunH7q2/M0BNfN1eox3aeQpuT508dgH3wZE6cAw1y8HTww/tkkQ49XC0Ja9ZwQYN9HujwzhLiMvWmPfndRyUb9MkVw9XD6fnXykvv9MEfBef0xgzxVtTIN6phL0Eyqhh+PATPDasQaPZskD1thYY34sD9ZlW975/iXu8c/vBHLj8k6nWK/WLCZPDQrYIHqvLST1xoxtJGC60qnqtjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2bvqVA/3lrIuYA/L9/Q8HvU74A+LUn/Oqy2CtLfvhM=;
 b=X2qsXh7W89rP/EhGv7XwSCSLbV87t+6/QaUiMMtBfbwoWUn2hp67xmCjFqeLzdsg8CPDDE1vY5ewK/FuYIKH1B6QPpl3N6Xuf7veNaW0W5Gj15Pf1KQjrgCa9XngBL5XSoFWYiAQPvhy1f0VgpGADZ+kBhHuRRFp5v4HnwyeYzoXiLWOBR6Koh0uF9t5TbpIRX6RpqwVyDyf1bROVYvEiVwllrnCel5Iio991b4bzp0NDXqGoHrz88CRJWv7b9q5Tpzk266YV12WQLEcPYF6HTABPwyCC4ktk388sGxNJLSVsSri27y3rBdPKENa7W3cwIaFOx4wEAQIGLLpCPvwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2bvqVA/3lrIuYA/L9/Q8HvU74A+LUn/Oqy2CtLfvhM=;
 b=z/wCJ4SxLTOFwqFgAZ2B5jhDlRH+XgsudMgdBYO3e6W2y5LWGj5GKYPbpNqTLaEfMSTfdBr7Xcb0ukPgcssP2TJRM7y/oxbAXvhuagjCH338CfdizFZFtdfOvOSYBWitunN+CIUiSCH61KtFLT7YS7hfKxwx92s2h2eaDLDBaEc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6859.namprd10.prod.outlook.com (2603:10b6:610:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 22:09:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 22:09:27 +0000
Date:   Thu, 6 Jul 2023 15:09:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 3/4] hugetlbfs: improve read HWPOISON hugepage
Message-ID: <20230706220919.GB3768@monkey>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-4-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-4-jiaqiyan@google.com>
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c02e27f-a673-42ad-c30f-08db7e6daa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd6YOaEFjqINtcw29Txe8zw/dvnPthHuCzxigBd852WlTrbHJnoWsq7O//mY4xwA+U1dAUTignpP55rOKqxZv/Gnz1j3U/iu3aCdDHtB47cfkNEVxJZcLB45W5qmDW7Ipk7eoYztL6ReavZYaX1RzRGX5tNgRyBjYysERL9qICG0OLfZ11dy8sEVhX+bdFOpmsmYSvPpN5xn4/P8BvKEtxlVZWK0/1bQkTL7L2xrG5LKIL8Rx54ZRIzrna3A5twRFSkCugno1zP6VEgwPogot7x2DUvq46uqfFH4Z8AG/umbdTpyJYZws4MazMo2H4qBGCB898oIqVKOB0gfpa/I32/WybMIS4uU8Yv7TnHTWCTO/5uIQXlntll2OId/2qU7Ov0Dyl0LI42iAhh9b8nOlZM3vxwsTKepIn/9OkPCJibAqNLV2coDz1krNHY3Di1qyEdHsvWYDjppaUyNpcU7CEYjGCVT01VObZiR6Nk7ZGt5Qch2+J3WJVR7xwavficPlecRePjSSZyEs13/po60zSDP7FOJ1syh7QhP09GeCJBh8FAaQ1vKIX7WPPMkxpd1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(1076003)(6506007)(53546011)(186003)(38100700002)(6512007)(9686003)(26005)(33716001)(83380400001)(7416002)(86362001)(44832011)(478600001)(66946007)(33656002)(66476007)(66556008)(6916009)(4326008)(316002)(41300700001)(5660300002)(8676002)(8936002)(6666004)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y4GCpiX5BpfaWKxtx8WeVUJk+ZsVqJxmoIGWww9rfc9SoaO8qhIKhvKWP9ab?=
 =?us-ascii?Q?UMXyEQOqi6CRbh6LX6+QI2nWyAEMH//zuK2yR76yYvoOC/pWix47gojsWG/k?=
 =?us-ascii?Q?93fi92E5gGp3YwEV1rJgmj2mMZhyf2XokPJH5+2upbMlN+ZDIm3TdAlub6md?=
 =?us-ascii?Q?YlCMNjFA393cnFj/DcwIjXT835Hl/kWbS7Du0UqDNaBFsN5rNkFO0kMMxRxY?=
 =?us-ascii?Q?C3iixs1iKzxfIJSzRifcMTutGNSs3CIsC+1tp+mih19etFJwWLJrDrBI2Wu3?=
 =?us-ascii?Q?QAeZbp5ezyzDsyy9PR1BTELTPUVwfdtfLw6+qgN40YWkVTyILP0Dy7UH54nx?=
 =?us-ascii?Q?5DqVAOUIGa0ovGbm/mRF32akx2inEAek6oku/7IDVlw6Oqx4OaKPOTH8vWSS?=
 =?us-ascii?Q?pQvQ2TplI9lvpBOPwQMTv7W0IM/RP0OxhupPZmplY+h25fRAKVJ4FnvMeZ0z?=
 =?us-ascii?Q?2pgOclahJyOef9zY+w05HYtIab8+bgWL+oFqloqIgOd1919RAUFGa3iGbxKi?=
 =?us-ascii?Q?oHkTBhyJLHdPiD+pkga36VLFrzNGYQhRn2vOx8DJ/NXnJSDpcCdPxGBHAXe2?=
 =?us-ascii?Q?aVjQsabjNzI5bhZATstO2YbUDPe/qc/fqD0jb+fBMOFGeKnMVBvc/Thyw+R8?=
 =?us-ascii?Q?4yDhbu+w53OW5nRoKTUrIeA+NcfaNUXC6gGeD9ue2ZaNVdg7ler39MSDYVDO?=
 =?us-ascii?Q?5kwSNJO/cX8gX7GFDMCJMStY5Lbwx15B2P/dBG8f0QEYmsFmbAdezwee866D?=
 =?us-ascii?Q?ordWrxGrhWG3Hn2jmuynMH1a/OAU3slBZBPGWIZbB468rZBYbYAsNxIkL8ON?=
 =?us-ascii?Q?0fpXTO3HYYCe7xa35l7YFpyi4zlk2iToMjQk9yKpVS26SyN8fPCYrzPoPxQl?=
 =?us-ascii?Q?SmpSmKKXxJAtnVpbKtxRNH6nXSrTJwJWQrrGK7N6Dws++PoqUSTBSiKW4lru?=
 =?us-ascii?Q?Og4EZAA+2KWUd7OBa4QKDHkgBHaAaCYlT7hys60AFGic2HAE3lmxU6VhYaum?=
 =?us-ascii?Q?YhVek71+egat4dSA+2komuQz5LW54ExweoFl1pU/B7RQ4+4YwKmpT8MBYL/S?=
 =?us-ascii?Q?ETG7DVtL2mcFsr48TiKh1rMvOcI4IOniOEEdrwPnk9tHO5ddux3csgTjzVcm?=
 =?us-ascii?Q?cp8rkzTRNqrKf1Dc2O6uokhxyWhbogUVLhKohrDbvw76FMiV0RNCgfvAeiTU?=
 =?us-ascii?Q?50iTtoxQXT6xYR5i/Gc0l83N8i+UW5FqQNHBqOktuh0/UYgRzBC1McA6YTR/?=
 =?us-ascii?Q?z1Li9jcmqdnj4GMYiC5DF/9d4N8+68lXlewOhG9/JukWzz601HCQ126EM6Ge?=
 =?us-ascii?Q?kWdScfOsbQseqyyktbAaL6xjvOhaVGQXHXrJra2UgtU+PTgofzMm27uNOyu2?=
 =?us-ascii?Q?i211LwVyvXU4f6y1qbRJaAO2ihx5whQcgum/OEU4/L7Ugu8JvTZyIzenFEF6?=
 =?us-ascii?Q?J91EZM4HR9p5/3HmAb2pUlrQ4LGlImaWKALrhLKESoa6vmRlLHKaW0rIlbzi?=
 =?us-ascii?Q?GiLoAooePHzQdhaSXVbNONtQ470ahBheyJ05vDxULrLKzZYGhjFDt/46vOJL?=
 =?us-ascii?Q?J1/cBbvQpcNWz8Cg8mBmlrMQu2YoLuqIdBiTyWMqXJYbi7LkXpjj4d+74284?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4cPkwwyDQFGKVigLWwZkPXhditpyqJcxU31eGVQxMMDRst8bcnq3nZJfdlcY?=
 =?us-ascii?Q?dPJgBXRnhydeBvvMgLxuREH6wDEO5jwxxP8aHWhp36jAmEt79p7r6s27wat9?=
 =?us-ascii?Q?xx758l3NoT4RTuOUTNIxdPtAvxzCLgj1F6AFl88L6RZQlntqtq6slEw8Ml60?=
 =?us-ascii?Q?q/1z2LbUMVTYH9aWreRFmRFTx1KyMNBREXoW+0MFF/g5Novi4KJqOWer72fj?=
 =?us-ascii?Q?VEmK6G9P4iCMJR4+vplV1pvs7MeKPIvf+tZr4Fkjz3vYHSNpxMexOrUiEgDA?=
 =?us-ascii?Q?xsl2pv4/e9N1W2CVZLGmGtQ09G+xGwv0hXrbZ7ZvKAx9aYLKqqM718FJS0dD?=
 =?us-ascii?Q?vTTuhYd0hlXbYMNutcfE/Zn59kKkbtKFyAz/e0KjrM1nlE+AGz2jrqNEz15n?=
 =?us-ascii?Q?KS5wmN/5uDmrOPCVvSrF9IVIUJ8HDcpTUqjxIqLljzE3YD40VFzvLKWfkL0F?=
 =?us-ascii?Q?sAnaSS76EaQtiIKJIuSDH+ApYAizKgGX2ZgAkZNgJTNIvQBGi7OVHkcw+BtQ?=
 =?us-ascii?Q?/Pjmbdkc3sr9FUV10cdFarxGGlJyqI3DeLMCiWodTh5hdiJc2s7pze8wBLrR?=
 =?us-ascii?Q?RIKoHtgGyM+2Tx969RAVwC2DkGYucVmmvBOi0an4G4BJnmW59y3t33IUVU+f?=
 =?us-ascii?Q?9a0k/O+TvH1+vTmEFRS7WT2IQk74vsNbKYBn1B9h62okKw0iwMrGnF/eDbhO?=
 =?us-ascii?Q?Q2fb3ry6Z0aD8eYW2uyFAeG1kpK+tYg8fzqUBt7MIWKQbub9IEDzkxRtHRTm?=
 =?us-ascii?Q?vJAL/PPdAnJQmD4NUP5OCx5zhIdcpbDLZZwpssymYypiPMjUwS/f0RswWepD?=
 =?us-ascii?Q?mK7M5gg4vVag4FSwriq8Uu7xTpukhHi0dwj2hoaPHeskDLqukZ250xY6s7Qu?=
 =?us-ascii?Q?5qAvBJp1HR7ED9Wf8z+coZ+b6/6rn/jwotL0oaBWFTrYfUu/g1wXthO7EUSY?=
 =?us-ascii?Q?/xcPHjo1griZlnxIaBUItKW8bKxtUk4OX1cZ7ZDY900=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c02e27f-a673-42ad-c30f-08db7e6daa20
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 22:09:27.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q9K1N8jx5ZI6F6bpUHIdO7CJEr79V/q/6NR7Cm070CJeJTMG0eI9QDyBtsLmXJ5q5i2GawCgWtlvoYkmmSlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060194
X-Proofpoint-ORIG-GUID: -pPof8znbL7NyNcJ3B8jWaTE-ANxYKAh
X-Proofpoint-GUID: -pPof8znbL7NyNcJ3B8jWaTE-ANxYKAh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/23 16:40, Jiaqi Yan wrote:
> When a hugepage contains HWPOISON pages, read() fails to read any byte
> of the hugepage and returns -EIO, although many bytes in the HWPOISON
> hugepage are readable.
> 
> Improve this by allowing hugetlbfs_read_iter returns as many bytes as
> possible. For a requested range [offset, offset + len) that contains
> HWPOISON page, return [offset, first HWPOISON page addr); the next read
> attempt will fail and return -EIO.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  fs/hugetlbfs/inode.c | 58 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 6 deletions(-)

I went through the code and could not find any problems.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

However, code like this is where I often make mistakes.  So, it would be
great if someone else could take a look as well.
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 90361a922cec..86879ca3ff1e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -282,6 +282,42 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  }
>  #endif
>  
> +/*
> + * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> + * Returns the maximum number of bytes one can read without touching the 1st raw
> + * HWPOISON subpage.
> + *
> + * The implementation borrows the iteration logic from copy_page_to_iter*.
> + */
> +static size_t adjust_range_hwpoison(struct page *page, size_t offset, size_t bytes)
> +{
> +	size_t n = 0;
> +	size_t res = 0;
> +	struct folio *folio = page_folio(page);
> +
> +	/* First subpage to start the loop. */
> +	page += offset / PAGE_SIZE;
> +	offset %= PAGE_SIZE;
> +	while (1) {
> +		if (is_raw_hwp_subpage(folio, page))
> +			break;
> +
> +		/* Safe to read n bytes without touching HWPOISON subpage. */
> +		n = min(bytes, (size_t)PAGE_SIZE - offset);
> +		res += n;
> +		bytes -= n;
> +		if (!bytes || !n)
> +			break;
> +		offset += n;
> +		if (offset == PAGE_SIZE) {
> +			page++;
> +			offset = 0;
> +		}
> +	}
> +
> +	return res;
> +}
> +
>  /*
>   * Support for read() - Find the page attached to f_mapping and copy out the
>   * data. This provides functionality similar to filemap_read().
> @@ -300,7 +336,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  	while (iov_iter_count(to)) {
>  		struct page *page;
> -		size_t nr, copied;
> +		size_t nr, copied, want;
>  
>  		/* nr is the maximum number of bytes to copy from this page */
>  		nr = huge_page_size(h);
> @@ -328,16 +364,26 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		} else {
>  			unlock_page(page);
>  
> -			if (PageHWPoison(page)) {
> -				put_page(page);
> -				retval = -EIO;
> -				break;
> +			if (!PageHWPoison(page))
> +				want = nr;
> +			else {
> +				/*
> +				 * Adjust how many bytes safe to read without
> +				 * touching the 1st raw HWPOISON subpage after
> +				 * offset.
> +				 */
> +				want = adjust_range_hwpoison(page, offset, nr);
> +				if (want == 0) {
> +					put_page(page);
> +					retval = -EIO;
> +					break;
> +				}
>  			}
>  
>  			/*
>  			 * We have the page, copy it to user space buffer.
>  			 */
> -			copied = copy_page_to_iter(page, offset, nr, to);
> +			copied = copy_page_to_iter(page, offset, want, to);
>  			put_page(page);
>  		}
>  		offset += copied;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
