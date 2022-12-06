Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D5644A04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiLFRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiLFRM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:12:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0423EA2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:12:26 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6GwfsV002555;
        Tue, 6 Dec 2022 17:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=MKS5KMdT1NC4AK0qj3JSeR2wpchEk6wkG2zdp9xQkS4=;
 b=mmlAcVbo/+wj/azw1n2FcY8WHAWuwna9huNnjzRfaf6hR+usWiymQnbWL2Wt7rAZE+ng
 Pt7kygGxC0T2GL36B1XBODAaSTNgdFYva1qcY5div/GbkjI6zzHZRqjJ4QBDLC56Fc/E
 RUqg1JKvq8TCDmX/xzsLCZZQx2mkfrfU9Ll/h7k5AKmgJgaDYU+e2Se1QBGCPTqtrecp
 eLPdkER95wqFMIbRShEk4hc+xiIlbHpSnyWTTiLgXLmrjRyOmSSZhJ7gk66yAzKoRodE
 iT81NIfdtfk0IlVPq3wmfm7G3nBybM2vQ76y1Mk9rx1d5qXTtf7eVkQnaiVbrTjkpCLc xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqqxsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 17:10:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6GxKYD013270;
        Tue, 6 Dec 2022 17:10:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8uab6w3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 17:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gndA7rr9gTANm2a9tGCmgntBtk7zuI7lAQulMwQfiT3wseatl3QwCVNl9IqUSe7b7zNJhy/YWrSIy01BhMFo25mxYICWjBOECoPMDC6uyaLYKx/HZvMHdQP9j0E5se1bhlT3O0dzeJ2A5U48rqKjJPqEeGUH1BEpTQsbu/7DKlNI8HtUWeYolmE2JHJEmPzNnS1WpHmgzH/xNkNMS+UR8fbFOyD8s/TnN7XiLHHREgOQZW99NKkyywRQy0ZVP0hwShNFqFie5DmHw2KrLDJCRa/8vAxcTpiUDl7BVNBPO192Ih4Mj+HjLPTx+9Z9zqFCeX3wk+WYui/7tQWmTXqTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKS5KMdT1NC4AK0qj3JSeR2wpchEk6wkG2zdp9xQkS4=;
 b=JNgiwQhzQNyNvxIdkInfe1+Tvl3ikUcUm/zs3yg+RRTUHkLk7TkMlGmsAs14WJj2AE63fFxiHg3lfzWNp1jLnYpRybgC1zt7NjIrCzOzS2g8z96Fj7CuYB+IwDgq09P0uOErysKsB71dnFFI/+h1OGDy7gzq/kiHKxsnSdPJvpGPK89yoaVO6SeYBAnXx1vznbZ0AGmAoPZJc7fo7ZgpcdcRlTwZPXdAZZ2UxJUlFYQ7hfx9y2oPRXqISe4Ghiar+8Co+P6dqMS/y6qU/R/8ItGFYGceapITggjWsgbN278fuCNfH3w8LBgLSOJad9sQTFCNhNChA3Cjlz/0dBZnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKS5KMdT1NC4AK0qj3JSeR2wpchEk6wkG2zdp9xQkS4=;
 b=eEcug6bbPM99zFVRj8oCUgz4MFHDcZvzROemfbSJgo5HCj2I8l+RK3TBw4u80J9z9LvRV4vAZF9bnNczrYPM3rVtS9MMYwz75km7DtuASR9BICicSb4E7mQ05T5d54MPZ6vYCvpvwT2LnU7p6RB2x7Z/NDQiULdB1+Z9/rwyhog=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5770.namprd10.prod.outlook.com (2603:10b6:510:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 17:10:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 17:10:03 +0000
Date:   Tue, 6 Dec 2022 09:10:00 -0800
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
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y493aNfcK7n7s1B1@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <Y46EMlDLCThbrl+E@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y46EMlDLCThbrl+E@monkey>
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e72cfad-ff5d-47ca-c54a-08dad7acb6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bppHbmN6UyijLY+Xro/iS026F2Z6iiXwnGmT/VAxNNfO/wdexSjauANgdDYbfBgwL/Zu4cYCAYxb4FxkZdMZKRNJoT41OM4Joa+gwMfeUQAu13Hk/p2bsYnAA+M5MFgSiZnMHFxJd6/rDEkospkPgg9B39tfkRi0oSq+x18EBDqH3k+E0pmH/uselRUriveBevqFwXTByvOkxkBo9DtaUqossfUTeCC8pTp3gBMApKuD+Ens7uzmBlLnhSlGEASkN13a+wMxvrLAj4Fc9DFVqtAvQ7CGGCH279P21/zIyfzlvco3enuwlkhNo3RF59Fk0SZtikbGlF6Qfw9+KzxVCqg3ZhuOXvHyxWcmLHABOQaxkdGez2gsmSE5Y0TscSH4u4VbvHsyC83vzPWwDsAWNMpArECdhSxHQCuR7HOBuWuCGcEXml+1kK9whMIizKqu/NhzKJbkkRtv9Lh732MIekdnO0DjLZANINegy8S76tq8MpxFuofbHyJoUh+hf4+MNuOHQGFgHDoMiTih3SfaLbYQMK+NkNtiiGjiGKuBSbXs66DmT7MFXSutVm76HdWMN4d7nUFSfTSJo4Dgs01LZfHuPXTw7oCpR7gX24Qw2uGpMh4QT865WbOkfJ5G4V2QLpRhFZV4bEduclbaHa4BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(53546011)(6506007)(6486002)(478600001)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(7416002)(41300700001)(5660300002)(2906002)(186003)(9686003)(83380400001)(6512007)(54906003)(6916009)(44832011)(86362001)(26005)(33716001)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epyjj2yY+5Q+cMQWTgzmYg6vPZD4ppV1iDuulzDdfvV4xCUrg6zXomtau4xx?=
 =?us-ascii?Q?yD2GboNm3EKQQLXK7A7FhsQ4gWHbjnaHD4Lip8TyhhLF7jzAcjJE8VSieOvJ?=
 =?us-ascii?Q?tsghzfDEfKIBSwkEAEZ5P5ghrtt8syTBS05jICrlnJdDNbPdTwZQ4gnBW668?=
 =?us-ascii?Q?ozOWQAQQHyKk2g1I2lxHg3p72MSJzL3AKgPmyKdBjezO2IqVNs3tjEiG/OR8?=
 =?us-ascii?Q?TYVyMV7VFg6jewPP3zoHb4ZUADEXHjJe9Nc55/V9GWDjZ2wxSK4EmlefSB5P?=
 =?us-ascii?Q?RVORSB3Vu2YM43TMKsqP7zBCxYt3mmgxXLMxhS1ak7abkXdlpL2P5NJJHgce?=
 =?us-ascii?Q?myi75m8q1hIEILcmTnPS4zSgVKvucN+vxLfSGf0ZS3Cs0PRq511OFoMHWVj2?=
 =?us-ascii?Q?dKG8IIA2MH2r2gfKD+TMRv33vgdot4zVbcA2a/nNJqYvaQ9vRQN31Fp1cndY?=
 =?us-ascii?Q?CvNqJhncGWxM8jG/KOBgjNYxofwiYtWtsv911H8wAae7uyLl8q+1lauqilJC?=
 =?us-ascii?Q?p6pR6QYP7E4oiA0kdujRafqCj0iGF5D9q9qu2llRhE/+vcg1+e9SAYWufZ3j?=
 =?us-ascii?Q?wHs3GqvBmtsDWpAWe3ACHKZIZf4Up9y2gbUusp844+BJtFey2Hj5VARFHuHG?=
 =?us-ascii?Q?wL7cyDBtO8aQddLgKfNjJ/bDFj3Od3+Lnj1zvF65ce+TJi7jibKTUSWiEof8?=
 =?us-ascii?Q?sFrFmXdqvfqonXzk5mX6lZ/JY5sxmSy0CE5Mg4Y3EIgK3Yi+iF/ShqRYun5Z?=
 =?us-ascii?Q?GhLVYnTvBzJemg9PCO65+anc+JSgd2KRnuo2YzS3eefkH1UkMEB8Xua4Uu8a?=
 =?us-ascii?Q?7VG13pjUmDO+BcmDQP8F2c1ovV/07WR89LqbHIGMMq25GcAizhCcQKXf7l2z?=
 =?us-ascii?Q?QL19fOcUc/eBFVavImewc1K8znjiLDV9uM4GYuNBJiiwPxF4JAo8SlVcmzZq?=
 =?us-ascii?Q?8g0/P9fwR5HIttZVFPcBQOE20Y78CrqEk/7NfUwUs7Tx4UUbF7Eowh5/o5O0?=
 =?us-ascii?Q?kwud7QbZzhfvo5l9N3K7av8mcO7CYe1Daxqg8qUbaLEqSaNYIAfFq+bJYofQ?=
 =?us-ascii?Q?lF0aC7ah/SPfxAXWAnfHbizdAp6dIWzmTG6aHfbbWdS/MBPk954R72OA8zaX?=
 =?us-ascii?Q?HdRmWMgMrB9vPqJdrlYwD9/FTBwXph5ssQY9nmTquihalaSW20gthMAPfpz3?=
 =?us-ascii?Q?HV+KzEUfBfGxuvx8/chgrlpOkZPnIgrbyTdsSkinYqRhl4albTfxFJ/PM+Vc?=
 =?us-ascii?Q?7wtew7zXkrJ/ro67dZI21TT1NNECix32zPyUvt1DIRxAJwYBsv4/Nn7dD2Qu?=
 =?us-ascii?Q?IUu5W3g6O95YxbUaSVqkYFVxPTtn79yMD7tyj+05hFOVreYhWy0zA4VBj7GK?=
 =?us-ascii?Q?Z9INw7VV5RLaOWOOCZXVDKKZhGgSdiyc/RrIo2fcvkYdaqAZ3zfrerI3wPXA?=
 =?us-ascii?Q?7pTUehxzSjF/eh8fTxzwnD8VuWLTeSAxxLmsKzSTZ/8MS9Uj8Qn7K2vMFytS?=
 =?us-ascii?Q?nCVEM9vK60q9wMznq7lGqGprktG4fXfm4m9UDCpFmdziFkxxvCVQnjpmwgBG?=
 =?us-ascii?Q?QUJCP/WIgFCu9oDYOmuTu/y8xvfGnjILAef55J5YTw07KKMnGpNOxKh2jA9+?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?euvNxfKleL5Fl5VIpVKMbjVnqZPdML6SrwhvpAt2xYP6h/Xw2qPElAbAJaLl?=
 =?us-ascii?Q?KtHeBAhb0shffnvlgvYXlOr8I4wOE0LhJtcaAkntR+wMG8dAALS6I0yh2eNY?=
 =?us-ascii?Q?L7WmYT8l7aoHJMDmXve6p1Brl0r2A1My3Ua38GOSIVVtZxY563SM/v4WTeUw?=
 =?us-ascii?Q?Gb5TtZTuuRRXN1LcCwtrnfEIFe69MDAqu9XOqgH6mVNEqjoitVJfJo/0Rwma?=
 =?us-ascii?Q?fOrKXEGc2qoHaYOxug7Cl+aMHSgQ16vJryuNNu0J7wtuZqF4wmn750AbyJMm?=
 =?us-ascii?Q?zb0qi+wYaHnP3kbLJ19oNnWmFf0c+cWNG2ITdtP9/9b10R4jK3KH4IosISRF?=
 =?us-ascii?Q?I4qoPwqn3IaEflvFdFq4iW2jV21ag0mv7MA8zK3Ng11TxLDO8gpY49xjNx/V?=
 =?us-ascii?Q?VvDLYjs+2QmciqEr58L5H/cYjJ36s+2+DS2NZOWrPvAoix6RQeR/EIEbwpUC?=
 =?us-ascii?Q?1Em9l1+A2bDUb/BRLuiQM4wb76cV5Ifa9FIsMMWQVbzIiKLI7M0DBrMqhapj?=
 =?us-ascii?Q?ATq3kB8eg4f3lsVd0RBsxY3JznXB/fa5TNt0u3TQgdIrgqH7dL5n5oheqKQ/?=
 =?us-ascii?Q?hqc/2PSLwIQxrLSf94D3KHNb6sYCLmsDtb7HDU/juceL/w+zQAztThJrGS/M?=
 =?us-ascii?Q?gKKUhQk0osZfqKnk6Fe7XsGo5pChVNwrwZLAjDZaZH4BW1h8+FaKNHrzQ8XB?=
 =?us-ascii?Q?sAnOZCRF+U+BARpzyEDHr9M2ENyUrzYYL+AzVdWQ0dZqhFtplwhcUCGciMVj?=
 =?us-ascii?Q?RCIKKTsXZSDa9jZ+VxJa7l/xbCXFYtw8jiLJzLZHfWkloypdXoYX6lgS73XR?=
 =?us-ascii?Q?Xz6lqcO7R76AFm6fBNqTRIuMp+ANjRN6m1OeQnBtS5xb1Tgek/dvkp2gOf7O?=
 =?us-ascii?Q?ncYYSu+/2AAu4BEtmrzASmHUZH4f2Aw/sfocD+xPULhrKOyQ6PxNZW1m1v+f?=
 =?us-ascii?Q?kewXoT4fOQR4vxbSTqMTbrJi8aCq+ISnaZJZuYhkW6O+pBiCFoKs5ylzQSPD?=
 =?us-ascii?Q?hF1NAWX9pQfubfxnl86XoO6q9BDZg0xBuTuV2rBTaY7Srk8Ou6aLu4COWhnZ?=
 =?us-ascii?Q?eBg+/QCkkr6AoAN15p5de2PdmexDh/vdMLNgTgPfxz7T5mhhgu0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e72cfad-ff5d-47ca-c54a-08dad7acb6ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:10:02.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKjoLj9NkNnr3QuJgNMAVaYzZ9fHUddW5FhN937VNMMmug5OSRsGc30Wd622TZIQeIz4FmkS4tpmnjH2fIigNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060143
X-Proofpoint-GUID: YlciHhsnBYQ-PYtr_k_HWlcC17RMd_L6
X-Proofpoint-ORIG-GUID: YlciHhsnBYQ-PYtr_k_HWlcC17RMd_L6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 15:52, Mike Kravetz wrote:
> On 11/29/22 14:35, Peter Xu wrote:
> > Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> > to make sure the pgtable page will not be freed concurrently.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/rmap.h | 4 ++++
> >  mm/page_vma_mapped.c | 5 ++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index bd3504d11b15..a50d18bb86aa 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/highmem.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/memremap.h>
> > +#include <linux/hugetlb.h>
> >  
> >  /*
> >   * The anon_vma heads a list of private "related" vmas, to scan if
> > @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
> >  		pte_unmap(pvmw->pte);
> >  	if (pvmw->ptl)
> >  		spin_unlock(pvmw->ptl);
> > +	/* This needs to be after unlock of the spinlock */
> > +	if (is_vm_hugetlb_page(pvmw->vma))
> > +		hugetlb_vma_unlock_read(pvmw->vma);
> >  }
> >  
> >  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 93e13fc17d3c..f94ec78b54ff 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  		if (pvmw->pte)
> >  			return not_found(pvmw);
> >  
> > +		hugetlb_vma_lock_read(vma);
> >  		/* when pud is not present, pte will be NULL */
> >  		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> > -		if (!pvmw->pte)
> > +		if (!pvmw->pte) {
> > +			hugetlb_vma_unlock_read(vma);
> >  			return false;
> > +		}
> >  
> >  		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> >  		if (!check_pte(pvmw))
> 
> I think this is going to cause try_to_unmap() to always fail for hugetlb
> shared pages.  See try_to_unmap_one:
> 
> 	while (page_vma_mapped_walk(&pvmw)) {
> 		...
> 		if (folio_test_hugetlb(folio)) {
> 			...
> 			/*
>                          * To call huge_pmd_unshare, i_mmap_rwsem must be
>                          * held in write mode.  Caller needs to explicitly
>                          * do this outside rmap routines.
>                          *
>                          * We also must hold hugetlb vma_lock in write mode.
>                          * Lock order dictates acquiring vma_lock BEFORE
>                          * i_mmap_rwsem.  We can only try lock here and fail
>                          * if unsuccessful.
>                          */
>                         if (!anon) {
>                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>                                 if (!hugetlb_vma_trylock_write(vma)) {
>                                         page_vma_mapped_walk_done(&pvmw);
>                                         ret = false;
> 				}
> 
> 
> Can not think of a great solution right now.

Thought of this last night ...

Perhaps we do not need vma_lock in this code path (not sure about all
page_vma_mapped_walk calls).  Why?  We already hold i_mmap_rwsem.
-- 
Mike Kravetz
