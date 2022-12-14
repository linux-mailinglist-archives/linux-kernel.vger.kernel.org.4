Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1964C1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiLNBJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiLNBJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:09:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7922534
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:09:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOBuG014274;
        Wed, 14 Dec 2022 01:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=aN+ywxvzoRmQTfk6HW7YVA1GEjucuwhijmhfck4Pvi8=;
 b=Ok2JWOaVPMdxeUrruua0ClgE2H5ncL/wmksvawtUBMYZx9AF5DCldiFaElUY2+02+WNE
 hDIP5WtrdPu4Owu6YXxW1wHF2QvI2QhCPl08uhhpbmEQ4sGoA5vefxwT8R3znznv07Vc
 HSBhVWUiDz7wbnhcO6UeD7YkC0G2ulOe1WNh9dggvEoC1QUS5lRwRI/A6EYmStfjsIMn
 gFYR3cvEYVxkZMBsi+e2Pu3fw0r0Ptj4pOITatE3Axsvc4IimZyss+XHHhQHCBHsOQDv
 L/fFO2J9S+glMZT0f46pAyPlgw+ZYSz7FgR/8Iw/6AUvw3NtoUcWXF2SP5xgCFR2yBOE Sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyew8q56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 01:08:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNXTG1031199;
        Wed, 14 Dec 2022 01:08:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyet5md4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 01:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVVz5UXvxikGElllWXSXgV2DGnMW64P9i4vZ53q/CFHvZcrnV2oenzLlcrd7IJ2m/2QlEdamazH/kyKYZ2ibO4vrPQCe1pGpWMbNcDKnn15Qqvg4kAI2njLjbr/r6UmrWKjsDPzgLmjW5qi9aVlj10ILYUmUW4tXwVrkzu2WN4Jyfcr8t1ABHYA3Zl+c8mIvGNZ2b4e/kq7JCLagBBfwPZkegwahL8zOvRWkJ1cMLhvXn3oSjDCQHI50J5sFCi3rSB4oyS/sQtVvKDipKhZ04Ws8mfr5ZIpMZY/+uM7ttJTJkIT7bSB1nyGCUZ1EgHZ20iQDKx1YXsEZc33XSL/nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN+ywxvzoRmQTfk6HW7YVA1GEjucuwhijmhfck4Pvi8=;
 b=Fas3JEjbeYeFQyF+u01EAEy2KrAxXHUD7GexiYTh5pSfv73K05+EJIdR+PXBnn+dlZfc8mCHkR0vEBXQHl7hhu/WqsIcwRDmjjygFNQ/4MXbn2gf22gjdh7YcAEfFiQQvTuPk4n9KuxdrsvnYDBkbhyEFDlhcewFq4o42P1XyJTr2kc3NiycMOZue4+Of/m2lJ90oZyyRLEGeXAKTLql60I4jsULU3J+8E1zA5g4MC+ZigPrEML9NepuvUGPO8JGT7qdUvlsrm/7zHslbwMGmfozMz53K++3UsKICgcNH2kBBJFKdCoCuUReGAN+qRd/tKE+xiOCt7N7pUEv3K4FMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN+ywxvzoRmQTfk6HW7YVA1GEjucuwhijmhfck4Pvi8=;
 b=fMCL2TA/W2slAbutRsMRzkj7a6eBMIsMJEJq1MU9fALZrrY1sGNxXIrYaC6iIXuICn+fVtRFrxjHOWP3uNGZ/iT1d1KiNK7TZjXQSknwi1ysdyYZ3n+X1lVj4QNCm39oxq4Tjw0AtskysYUE88ZqdBf4UByGx8/gmzmDnGYp44c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6873.namprd10.prod.outlook.com (2603:10b6:930:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 01:08:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 01:08:43 +0000
Date:   Tue, 13 Dec 2022 17:08:40 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 13/47] hugetlb: add make_huge_pte_with_shift
Message-ID: <Y5kiGDfIg+N0q1LD@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-14-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-14-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 54de6e2e-b4a8-4373-be78-08dadd6fbe81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQfMhDqnpXNT7lvvhkrbhmZiy0gjiK13i1esK5HssVEHjZyPJm4tAdIJjNMZ+DqfZRKffpgeBObICh59pl7k48MCcECjTiWEt6BHtfP/thFs5qhJAiNNPVyHwI2y48USuLOLgqc0JMucqflUyjpHOLbTEACcxywy+TNK907sJKycw+S3AQIWSUIJtrHKAdE1Vj+L66h2m4niBp3wnKlTajpks1dc4UnYaabsZwYKgxNxeKxPt/8rn7g5BMEAiRLfvBMtH2aEx4OJez+l3B1zxXEViY9y06V/ZZm3vFGdyflotd+hK6pFhr3Sxtz4usPHZUCwGrY5IRoiJVs3hnnVbDgkWDjkI0KpoG1u8kVFoC1m0PB3/zodhSw7cv6dyz4JAOIEc8ih2/h+sykfHtT0vJA8TN4+wMxgxYu2dl52IgI3CpJ7KoH5y03kEPYKzYUEx0hmpZH86D7Ecbk4ZuaVsD+I0zzlYcVTdjy4M6+hQZejt/1W5w2N9RTrIg0vClj2JdYJ/aMBH8PrFNfX3f6qpLyDwPIXTyo17ZrpSpOF4GOV6EztEGZV6qCdib4Kbbn6ls3U2gqUC7DB3zJZtNvm7+UrXOGo5RUxhC6ri2x6bSNyED9KjwHRmQAXDIyefY8l6we5eQzBH/SemHdFbnSu0bKc1iEYRkyVrmHAQ2KbjiS33EcyFbA/HoXgrwqqYmBgF+Qm8O1mETSKA+TwVA6tGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(41300700001)(66946007)(66476007)(8676002)(66556008)(4326008)(8936002)(83380400001)(186003)(5660300002)(44832011)(6916009)(54906003)(316002)(2906002)(86362001)(7416002)(33716001)(38100700002)(4744005)(6506007)(53546011)(26005)(9686003)(6512007)(6486002)(478600001)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6ocoKhRnesZeJGNK1Wj1CzKPDkdovBJMbxaLbN85Oyfa2A9V9BBygZoSxcX?=
 =?us-ascii?Q?2KIrJcP7mntu6FmUAZus9vihIHNu2lpXkQi8wJJh28Oz+r46uaetB3geb0Bu?=
 =?us-ascii?Q?oNi+n8zEHYTMUSgocNkV8umrpDEhv2c5q2cNW5rIweKyaBiLlmS5NkxTV7Fx?=
 =?us-ascii?Q?qS2hdjllv9vsyl5EaDtPOzIocc1a4DosNkN/S/d65BA2guotCvL7ZnueR8cd?=
 =?us-ascii?Q?eEq6OZgCuT+sAQ6oA7ICm4FetV997xcXzTvq4z/9sLfiCIES5cZA5p0wXt+S?=
 =?us-ascii?Q?fifsb4nOQcl6e6NF+NfTYrWrHJEL1ZmmnYgAwSWeQ1uxGIzDVTt7JDrWubn1?=
 =?us-ascii?Q?eGFQagt3Q/67RZ9B/kV84cu/L0DkmDxK+iv2eEfA3lr2wy4QGVMm7nPgm5Ba?=
 =?us-ascii?Q?IcWMhL9XvZvHcRSfaHQx8NW+MBCGjPlMidBNlVvP/XLRyF3andSZLryhobbk?=
 =?us-ascii?Q?7oeLHl+nQbJCMkRstGCYYafzFAAhl3RJzZhf3zEAXNJpUUQ5zWIa21HjggIO?=
 =?us-ascii?Q?+rdt1la2xlb2IOzxdgyOqaPfvmu6zzhmCUK3yMiFStOVJwV1GOGTLJDdYCad?=
 =?us-ascii?Q?SHYaT5U1WEh3Bnn3TMIZLTfcwLuC3UY2yhHoYxbpy8hHggqj2/dmJPIRpMju?=
 =?us-ascii?Q?/dvICW2H+PJp8tOPUtavwSZNj/v5kbQPbEtKkNxarAIdJzBHtmHumdY8alY1?=
 =?us-ascii?Q?DOJ12n8dLqvnaGpwjnHIC8pkk7d7bNoOxy61iZNXyFSWDhQ36eSlXrpcbXlL?=
 =?us-ascii?Q?Jd/Vqf5aW/63UVupLZMUlvdHU6vHJXY5yrlDIrvtw8Rt0GqRYyL6AT990Vmm?=
 =?us-ascii?Q?Ycqa78e5mama0DDuQrgcP98Ibuw6lfviz1GhfD98iZaogrPR5PHXVklFwrgP?=
 =?us-ascii?Q?+DdC4Uu/j99ndZVwBtdXMhpvmFViN18utWHMgGN/q0nPRlKtGPzmpevYZLR6?=
 =?us-ascii?Q?vCS/OCPmVBMvA/HqC1OjmQ2lht9GULqZgTq9we5GePXXdF+dJrKGZD5IRHWe?=
 =?us-ascii?Q?+8yE+8F2vH78Qsk/CWCpxxu0glGInAt1TXUaWGNHfXB88DovLBcD2mMfnIEN?=
 =?us-ascii?Q?848OH/4nYT36R29S4QA4jPRAwmcgBsl+e79aZfzapj7YL5qjXPhXvuFQ4hyR?=
 =?us-ascii?Q?rMa6rnt3tSDo9Im7f8QaWYwQRVuGl8HI38UFlB9fOkZ4giM4J0yLVTO2GAEI?=
 =?us-ascii?Q?Q21tivMl00tksTHjk7R5FyjYC8GFjC75zHdDjivoDYpdyRCWufIFaofZtHYX?=
 =?us-ascii?Q?98D9zGkffKJEsfwfHRCMKhuZTIWPbtWun0XvXP19C87Jjsl82lc7cc7OUs1E?=
 =?us-ascii?Q?wFwXX9tz3VyfPTM3GBvtVNHXdLWCtSA2/FCiWMzPCGsdWUdTk8g2lqrAd/iz?=
 =?us-ascii?Q?53jyukuWNn9Fdn70OtAyNdnkCPu3RfOYhkV92KDjiQhe7xUEhi9DEknC9nvl?=
 =?us-ascii?Q?YNcPgI121hJzIL5+qWbXtMT+6SjvmRyeL+bgEtjov7I17kSWMc2yOcgoV7cJ?=
 =?us-ascii?Q?NRVQnJuXcmvyUXSYro/K700m1Yuqb4UFdScm6eKlLdYbTR62GjwQCyxdApwL?=
 =?us-ascii?Q?6iPOSV0XHfR8FbesgiIul4zMHFHLlhSaoQgSP5tbLEENIMPE/suvxjgigrE+?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54de6e2e-b4a8-4373-be78-08dadd6fbe81
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 01:08:43.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt8FjUimQvl7lyH0rNLmNozSL06YAbUA2XRSEZ25211gXQhyPNGIh5IS0aAVFoUER05ggRh+NAbfuZ57AqptYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=915 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140007
X-Proofpoint-GUID: Tbs0GMlHzcoVvUStfe5KLMsUUf27-qwx
X-Proofpoint-ORIG-GUID: Tbs0GMlHzcoVvUStfe5KLMsUUf27-qwx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> This allows us to make huge PTEs at shifts other than the hstate shift,
> which will be necessary for high-granularity mappings.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Straight forward,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
