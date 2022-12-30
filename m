Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A3659C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiL3VF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:05:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5811A17;
        Fri, 30 Dec 2022 13:05:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUFxmNf024550;
        Fri, 30 Dec 2022 21:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rbBI2QIAKxBA5IqLgHYHahyhBpJZwoqkYxpN3ybfums=;
 b=PPEEuAWoNiXpZ7UN3jsSWd4gCqZexfmvmKtQ7+aDYWef6yXXg04eb09vGRfY347Jpe4N
 vuWm27nY+3WFwMihTV8KrGyA8X+g+48SOFB825iX1FTi6kYptF46Zr6KPdKC35Y1vmaQ
 xI1UxSZXws1KTgVINWku07KG+YQqrby+fKnRUTZm+zmt6XBo2KNFyfjwteFhkgGJ+f23
 +ibXlapIfFFEeYbeYNqxBwQeLqFO3b3/gtAOJv/GmDX566bSABdA8V9DjqGm4qPcnxdL
 hdmOCEdm//iKzs2pd2pQIqFDkhVyrsvWPCC9wprBDxuMU8aSz289LpAiax58hlwtiwmu QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnr11gm2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:05:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BUKhdJp024254;
        Fri, 30 Dec 2022 21:05:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqve1f00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB5PcnIw7asXvBJFfkiA/1R8mcY/ctKocIatduMuZc7ghNpSScpa1ICSXktL4HS1zVa8s8eu+6ThbmJhTiJrKd8R7FGlu6thKcSf63+ldagp1YI4/QtS6mw+bAlrwnU0GDLLNKcaMtgk6bjqJRt0U3KGGeu5Yu6p48QvkFCySxQGnEXUB7suwXT8I6jHWY3o5fgAsPR+WhkrWuQi5Il0lhPDm6s4+IJphYITub8VYqOz2ctgfReyT//tmtNsc5wWmuSfbW/8JSvP/fTnExP0Iy98745nZh4izpeTWIncrxueVynwTIkiMIAl1oflayYVwjL2jVb8fUlwyahYETqTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbBI2QIAKxBA5IqLgHYHahyhBpJZwoqkYxpN3ybfums=;
 b=FYU/bqC6bciDpDUAvEpSgDR0Jqir8sThRwbPSVq8k7idPo42dKO46g51BkBzftSxiORm1joewYLc8D8XVfgcBsY1eLZ2MPwYbOb14nAT04hyRqmR516mczQoSG2e5ZaXzwYSTHQbYDYVecmmGdHqltPJzme49l2aSSS+3LcQ67pB5g84n1iaJL72T1cizpNF4A0S7B0wRjWIU7HOFAV+ytqUCCkEf+D+8HpN2Hnp5YW0dbRWBqALDb9t8bOyKWkydauq0LAnzlAC6WkZeNnoAxAYFahbYtcZWz14DZL+JJQ7/iDDnQJ+U4MPcn+u5yv2ObPFkoQ0vNCdxxEvHPP51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbBI2QIAKxBA5IqLgHYHahyhBpJZwoqkYxpN3ybfums=;
 b=S2WwYOQKhRHFo26KR+Gaxgij2O6RlXIPDf3DkgtNEhxTS1YEplwts8kOo5BII3caaIWAH0K5MtJVcVrHmlzux8RT0YKSfFENluZZA3VhlMbHdtDTVXSkSzfGKOs0CMqUoUZt1aklHStoQDfHeOHio0oWQFbC6vvhm2b0g42MTUo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 30 Dec
 2022 21:05:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 21:05:30 +0000
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] UFS Advanced RPMB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a63461rn.fsf@ca-mkp.ca.oracle.com>
References: <20221201140437.549272-1-beanhuo@iokpp.de>
Date:   Fri, 30 Dec 2022 16:05:27 -0500
In-Reply-To: <20221201140437.549272-1-beanhuo@iokpp.de> (Bean Huo's message of
        "Thu, 1 Dec 2022 15:04:30 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: cd287957-e2ea-4993-6a57-08daeaa9956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggYW5oKb/t5exPwkZbcEnZTBnorVkGkaBzMLfs76FA90hDdEQwA8Hk7ylf8CrIut3R7XBj+OLPgn289VpSVgopDgPbZ9j/15lzCfov7wBnnITcuoNq2wjuckTpVlgsCkEm+zZPOOZzQz9OwD3dvEQ3jumozwsxYvr/Dmj0aZNPbC0e0XI08OFNVY17pZjL68pysjR0NElEZZSWYEhq23Nf2DI47gNFDi9ACtm+PDivkdZYhxx0263CPY2c+b74a8/3Fbyi2u22FmiVreLykQn0cQUpMIWTbJJvOlJv7Nju5E6mdimloXzcU7VDn+JGoe///PDOMPw2b4xgZXw0P98almd+mBRQuwxvrFYMP887vmORLk4dh+HQNKLUkF6kdy8FVjTbaskhTKVtNNXjkm+WpCsuPiYbhcKZ64HMcEvs3Iln4gH8jXXDg9xiH+dln2pCsLRca57YGQmB9TPLLu0cj3m/TShzqvrapcnTfS2BDxE2LrdMM10ZMBtQBa7F5L64faEwy/QkZ6TLvEVZcdRDXoAEZKD57OMfXk4nJnpQSoHIcAdycYNrGzOsHT+G5cnGdSPucn1CYuQiGRLTjuZau+ZCQEg7SLRAOEinNQg+H9NjFao5gMcB/fUXNxh5Oc+5yyOMuUceuQrm8VAet3Dd2R1mcYXUz3cdwEx2hWsMpZcoWgQSzZiQQfu0VX0q2Q7wgBBhKD02mH3A7W/6JFOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(38100700002)(86362001)(2906002)(4744005)(41300700001)(7416002)(5660300002)(8936002)(6506007)(6666004)(478600001)(4326008)(6512007)(186003)(316002)(26005)(8676002)(66556008)(6916009)(66476007)(966005)(6486002)(36916002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvEVqc15fhjhaRqNSoooFHRzpV0H8nhY/4aSwxmQfHZx/h7RX/bApx+8S0qV?=
 =?us-ascii?Q?5i8uvtiPmlYlNkmfoRFxodSWciBwtyosJa9JUCvL+FjYNnGTQjyRnXjOzsh6?=
 =?us-ascii?Q?gQ26EyymN1oLyglOC4Rekf46NCzHcqjWyCxDCNv6NJxPrZy9fbgUiIavoKjG?=
 =?us-ascii?Q?whcA8pUd+xeX1RCsM6CJBy7hG7U4deQzuMMMaWo5toEAXubgOxliwfD7916F?=
 =?us-ascii?Q?9QmAnX9cUAUht91WLeGy8P7uFA7QLCxd+wrR/65PXio91w+3V0BclDPwdCnJ?=
 =?us-ascii?Q?1jjF36UtSdYkPiqDOe1PNdvTII990mcK4AgcpkfCZy3IWLUc4etLDlWv3oqE?=
 =?us-ascii?Q?skv9INXlFUrhYl+Fzx3TltDQzbx6fmno/DSfpTwZ/JwsgvWQGICYvdtU7KXl?=
 =?us-ascii?Q?6jfYN57fP4akSkXiNAuan/74TqEIfZQ18WRmEBay09ozehJvoJvGjnvVhijb?=
 =?us-ascii?Q?lBczgFzc0BL74O4KjPbhwG2XpXkPKl0Qc1z7Yn+4RoxVrFBzUxdllwODPAzm?=
 =?us-ascii?Q?lmjdbEczm9OjZIpNI5466C6zVVAw6pR7aDVHwU71AwuV5x2R1R7LiA6A1eBH?=
 =?us-ascii?Q?t8yRVnl4Pq4YmvNSSBur555Mi+5Pv9ju5hJEBKpoYVnce60fnUjSxV26Y170?=
 =?us-ascii?Q?qLf24nGIUeaggfTYWLii1ruPWNnlbC3PqP8orQI8vDj+euImvxPkY4Rlqgf8?=
 =?us-ascii?Q?FZeBcqtVVF6naS4bBZR64lkedKpAWT8eEp61WBBsDZwUnqvNUM/+iPxRo8W/?=
 =?us-ascii?Q?mTU9sG9tDCFmLqLpkxLgPo/HSANYk3JroHEafKyR8alpuVc1necjNkS/sLF+?=
 =?us-ascii?Q?5whAT3K7UnNgmmWXQNWgZ1TIXB6UqW3fzh7NPutY+FSU9KrQ25lw3EOK96G1?=
 =?us-ascii?Q?8kOppV3MPzTQOO+WxlFFL331FiAh8aWVHUEYCXFdxb9N/zSAQmCYJcck0Ap6?=
 =?us-ascii?Q?DgRZhj+otJiFujfjXOjMi9a9qHCM+1Rdac+wYFVOWb70LMlWPw4Y66XGhsix?=
 =?us-ascii?Q?rY+3P37VkhX9bdssUZ2O7UAiI3jQIrBNr4FMDUv2LgRg+hEnk6p4PYFHm0HG?=
 =?us-ascii?Q?qX84oyy/obBbEP+KNqEkF2TMyw62MRKg2IDt3W4JnNIElM1HOwusONqABvGq?=
 =?us-ascii?Q?gMfzkOklQkRp0chq361ozErlKedyikx2v6f2BTe18OB8dCnTs49AtteQdSJd?=
 =?us-ascii?Q?tEClKnkv0bnt1kWpZkLSUfB1gSerP0iYpNvjQiW5PK2oqxglqkoVXIgJPy9N?=
 =?us-ascii?Q?VGnOHk7zXiqWj2i1bme4L4RCh7ak4WeXQj+xt+D/iwD6Em4tyi3w+96qIm/Q?=
 =?us-ascii?Q?4bxz66ayXKy/XNckch0aV26QNhvFE+fVYclh2/JM5MPhSfqtP4KStWIf+XOd?=
 =?us-ascii?Q?F2QPpH8NKB6iRWkKlPvbw/04ZROG4D+NG3UPGjzCB+aQaNI6yv+2znlE3Lc7?=
 =?us-ascii?Q?lewdan1pnUH0in8pqcPFAAmYxffcVGzPdE9vQLksyg23hDI9Wtic5T8TXcg3?=
 =?us-ascii?Q?/GnKxjDk8Gh0i9PYRCHtKzP3CcDMtLRj5oJE98QEQ6iLwP18yvhwZYWDinTQ?=
 =?us-ascii?Q?+iVV/NoIFFjZiHZcQqCbVt0LyaIhRy6wsNH9Lmd3MiMVxMGAxwDj1oJTiPHh?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd287957-e2ea-4993-6a57-08daeaa9956b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 21:05:30.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3VJuau9rM3YG17WLd/wBMuWYNkNrslLyPlSgioG977aWFBtEwyUrSFjg//BsD8xIvZnz8XljKuDUw/kiW3s2qFKZgEcnwIUSGVPn9iaRmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_15,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=788 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300187
X-Proofpoint-ORIG-GUID: Sb2PhN_k4RW12Z8NVSkB42Ynh9zKIlXN
X-Proofpoint-GUID: Sb2PhN_k4RW12Z8NVSkB42Ynh9zKIlXN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> This series of changes is to add support for UFS advanced RPMB in
> ufs_bsg. The advanced RPMB application of user space is ufs_utils, the
> reference code is
> https://github.com/beanhuo/ufs-utils-Micron/blob/ufs_arpmb/ufs_arpmb.c.
>
> Changes to ufs_utils will be pushed to
> https://github.com/westerndigitalcorporation/ufs-utils When ARPMB
> patch is merged into the kernel.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
