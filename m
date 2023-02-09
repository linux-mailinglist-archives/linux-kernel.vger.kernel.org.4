Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D368FBDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBIANS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjBIANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:13:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51A20071;
        Wed,  8 Feb 2023 16:13:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwuGr006621;
        Thu, 9 Feb 2023 00:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=nyj9H9JLcy0DvLpxCC244Amiih3oBhXeaEhsDImrVEA=;
 b=b4bvuw42EO0E1pbcEBMab35zPFOekpCa+bPMtZ3HM4mGz3PdnTyBrfAgNrkwKS5ST9KJ
 iHO7Pe1ue9W8gEhuJ80rJCycZd/RoS06aUWCGl9Jr5fVTXPMWIovX4lTnANqSwnyOQjR
 D/MVKitEt08KxzO0whmdcMpMXzKyuonQUKNbu2YIQ1bMfOKlQzZS9K7I4lld3n/iWkwl
 f7MOGVLu5ln3nMOMNXjqHpOgbXX7IeZcWGZ5ENQw5en7fDkkiYIljA9NsPe1OYG5dzvD
 an9QsArF9Kbbts/iUjUIf96uPkod0yeWwQJga6ti6icFawabhZb1BHGPjEJpbMySGoFy Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53hm5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 00:12:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318N7KJa036277;
        Thu, 9 Feb 2023 00:12:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtf1e36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 00:12:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSd5NKaI/A3Mzl1iNWqNOaPPindHTLIRgRKiTHEq4sdINIHJ8dnOrmBL0CnVPcRVRBJER0DauOw+c4ncj+iEqsABUkpOWKTenTTnkopRFVf1mdWhXpevFHC5U2VaoU51XRr8SEUe+eY5I0N3jlUr+F0/TqeVMXcWkhG37AFsRtR3VMbN5El5icu8M8oDhpaIBNr4jh/CyNYG+cWaJ/3eq2CuZqTlQiyj63CoPo0PDhb3HBTvP0krGZdDytzZTVqVguyqfj9qoDe4mVSAAvHZMCzzA84kp1NMoDi+pC4UnsOAC+2PahtE7PYeEB2UmIQounbY4ZITFhvN6iAOAw1CrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyj9H9JLcy0DvLpxCC244Amiih3oBhXeaEhsDImrVEA=;
 b=C3r0CpYRlWVgRcRv0MoHhl/SqbYeo6NUnzbuDepjDq4tZfvQjOQybNL7uVeS/BmN3hBFmF2oBum2LKq3uYoV0eHffyTbqGuYTNnzpMe9nmk9LGjUQIbhOhA0xpCA/tZIAQxjX56XLfgz8c4bPuMRDmcdqd7uG1XDvcbEbCe50jNC0Kd636JVsn1TUlXBuibV/B4OFbtoxsDUMuC6jAva8VeXXytULaEYOnGZzypu0HWecGF78YqnGqJbsNGCJi4uCJUX08XNZrFfsymq/MoJTRa+zX0/MRLQn+JdB7M1ST+hN12zv1+F6H8ywpTtcDvl+cLddU0EOo8ntpcn80vQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyj9H9JLcy0DvLpxCC244Amiih3oBhXeaEhsDImrVEA=;
 b=wBSdgH/WOYWT6EoMtAX9GxsLmtauP27/Bq1thS1/1vswaAVTu+TAZDZFaSdRjbZ2jWhMLWf9mfbBQC9o5/BX0RumbX4Ys3H4WxW0TwzHkWAOBG9SGcIpoT5aWaOH9sRSfA50OBNfLKW7QlPkYQSltG2FYWB+0BPOc/28/fEKi9Q=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5225.namprd10.prod.outlook.com (2603:10b6:610:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 00:12:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 00:12:40 +0000
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     yanaijie@huawei.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.garry@huawei.com,
        damien.lemoal@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aic94xx: Add missing check for dma_map_single
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qmzy9w2.fsf@ca-mkp.ca.oracle.com>
References: <20230128110832.6792-1-jiasheng@iscas.ac.cn>
Date:   Wed, 08 Feb 2023 19:12:36 -0500
In-Reply-To: <20230128110832.6792-1-jiasheng@iscas.ac.cn> (Jiasheng Jiang's
        message of "Sat, 28 Jan 2023 19:08:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 341a3c56-da25-4a22-9511-08db0a325b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMLMysepkK5cru4gjPs65sBbsq1LMxBEKeUeejkcBv2uVpFyui76lC5bWbAmQsxqTQGH6901OW0QpOOkqCoFXWsclOYbjnfa8a5KUFM60xiixfio8xeg5bAbHl7f9yF0M/5VTYU3D+Nya9vCLfaufHVFZW6hCvo3goZtRgKg+s0HHNjqYiffyuWC0+vOy1HsQMEjOLBYsFVxqByJKPAjHhWVznStmCcHc04ibbOtlUdhkR+aDaXMUWUfTFKvwY5hEccVNVZRoz92h7NK80d5vuD5Q9EJfe+WvizkH1S3xQlyrIwcOvLVeVZON8ewpkkwvcTsROfVjhcDoTfhxParEGzhTr+ZQqsrFWoXdJoNZwGyo67i5UBfzSdt3MbZuRfdDiXKh+zvCWtYewJpKPw78hbVMJtGtwRD8GZCVdl6rEnRK/TIaB1CwPZh3JOLvvs1N5ALS9l0mhPRipzWJjQivlHV6dNfgLGbJQUl50+0PGYrBpNohsXpmhmYk8D5HRSqfyqUDdsCE5aKc8sDmfBJ4KsGcf7Gs1B9hDbsYasgavahYKKgnKu72+RHxtMYB+H3uWtwni/W9h+lAcLqTOEWwJdeMNkT0yA8ZvDx48h1fpMYcro41vXIvDMkzOJPtDHFeaRSpgKcOxT9mq/KbqTq+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(558084003)(5660300002)(66946007)(66476007)(4326008)(66556008)(6916009)(86362001)(8676002)(8936002)(41300700001)(316002)(2906002)(83380400001)(38100700002)(6666004)(6506007)(26005)(186003)(36916002)(478600001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2O1krkHmplTl/6jywHk1UHmnuyT9LiJ8ZZAec/rCsA0hkRgjTS59rAqwJeD?=
 =?us-ascii?Q?VV3iMdvnzRp/3Hop1tCZEHgyGoFdeOvNDm69NSrmDBO3XEYYO+jsaH7gIi0l?=
 =?us-ascii?Q?wKl3MTZHQoqkwdjH+cp0MlF7Dr04X4BegU7s2KAE61W2gvS4MrFOpPD9nTPl?=
 =?us-ascii?Q?lre26BZZ7wjROdLGqFp8xSRRfgBjaUgF7a9oETCD8LWZfLHD2Z2xPUwEe+iN?=
 =?us-ascii?Q?JP5sm42Xfwfdkm0JuuyJopGQSwBYJdYlhrpT/HLguR5C9cDK6zgJ47txCKS7?=
 =?us-ascii?Q?bwoPDOaR+eLki4RYGTJE+t3Doy/FgQsrayuQkekao9XyXKwXWNT6Akuow95f?=
 =?us-ascii?Q?pLSZ0kDNOhJGAcNKNbiBPiUjwkg1SNhOsUEOUXYFPkAEFWhSbPKlBSpD9wZt?=
 =?us-ascii?Q?hq1p8TcJG4ZWdefKrVSzDCkNRyKGZV/HgO4C2ht1At4T9/wRDZoli+K3hs5V?=
 =?us-ascii?Q?yb0A6YwMsHwzNpY5DQB/b1wJHed4b6HbNWckKx4C8zspHL+K7pSK4FG/I51p?=
 =?us-ascii?Q?5MONNB84nqAZTvcpPOFODZdUm+8E1lPivvIzdUce+GN9EjSSXFcPKUrU7dfL?=
 =?us-ascii?Q?HVJF4/7zWHfwCVXH9gvF1a3DJC+0l5VySdLQXFlzN0nnNMMhiHxmxJlbrQN+?=
 =?us-ascii?Q?GU//s3bfwkJx7tpH+E/riYjK+cuU5IInyE9U281qy50t+39VhYYLDIR2tYye?=
 =?us-ascii?Q?vFO7mOqGWJQ2n3YUAvawNTmvSKRGB9EmLThdWLvKfQkhwKShmvgF+/EIRDsX?=
 =?us-ascii?Q?SRZkOS4FutcTpZk4PFYah4m+4XRoZqgOtVzF09ELCtuIjBaSTYV//Q4uGNFq?=
 =?us-ascii?Q?P4czqxU8OP8Dq3A2eahs1oPHnLK0iLTjVcqEY//1Ag81SNLBK0h/X/HXS+kr?=
 =?us-ascii?Q?mDo4j1BSCN29iv8n9w6m0ycWhzVfmVLNeKhEB3NWbhSSO0I8xs7rRr5Pqkk1?=
 =?us-ascii?Q?a1+gpFuAWMHe/xnSN/P0+S85FhO8SxSyBMTMRv1yrASlCfDKR9N2SWMZO/9i?=
 =?us-ascii?Q?XvG9TrM3tOMB/TFpU0rzOLf/eFaCJjUABSemqn3VEPjv/ImDgVo+TnJzXNSc?=
 =?us-ascii?Q?AcHlY+hM7LgfG4ikV+E56gNxox0+j7VPK6h1SvPbgYO10f+1Bv/nJGzfYFqa?=
 =?us-ascii?Q?bR5miCptYokRTI9smY+gfN48DtSOtW/IHtYAqSSBAWVkUpDe/geOV7Z5SnGr?=
 =?us-ascii?Q?SyQVCXiu/w/f2QO4WmRzlLifqY5vV28FPASxZCQhRlWDCct5hcNS0q6rt9ha?=
 =?us-ascii?Q?OSlRhSc4aygaIo4DSrV7OMr1BV5fFNscheoyYaoEHJPm5lHV9ypUdAvnKKuN?=
 =?us-ascii?Q?efiRkNcG4yVOCE18xwpi6LaIxfJ9s3wtCwqhRWFXB+OIzZW+XfETbNDFWsTT?=
 =?us-ascii?Q?ckubsRVXV0upvnGqs62+3HNgSSr/aoMrNsUKFRHt/0mv/AfzD28ORgVPt9Ax?=
 =?us-ascii?Q?QLx0Tv3oU8VFSnqyYubwY+hMTEOsjTuA/zrUdg3sccS/7/MX6CxLWHtCA1Ff?=
 =?us-ascii?Q?z2+WGXIiyi1YB/WdEhkFPM6VZmFEMopsJDglYgo11LJ24SiHOwgM1RrXzcjz?=
 =?us-ascii?Q?k/+YZBKy3MsC8srgCGGjq51b3f47+bSWok0pCA8OANbn9tHyQCnnNSj84MGe?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sa5z9R6aaj/OFfuxdkYD3k0V1TRGdo2MU8IELkMbR1Yf7nDKyMWbofvBYNOJ7byvw+1zBou1T8xAqi1kB7Z1K6VcuImBkRvsESbrZ9fiil/Tuw3uYMNgVS2mIzkFktQngrctDJoz8mMLBF6NGo1SXcROckRLWGBeSW72ssf5F+fsncvB5AHAsMHTo+liKRRjSzqa3ARVhHU+PdUNdXFHjZ4wEbcUElUyMTGYXPTUncD9GmJ6Ter8pY7kXpbj6lkNW7lFEAUEDgksQ6VX0y102MYs7hIVKeVarBNO0hxcIODa8NfjsMP4VxktrJkqK0yM6SY5cub7Fx8/68foOPSvcpi6Z/UwTznt6qelf3htrp0Fb/DJJaX+169452a8PebBikE8F/YwxKVAbhSXgUGbbYxSR3HS8Jt+haSG1918zY6T76SCq5nWjB11o6FivhZuo/PF2mFmpOjPZp5gqliHyI06Amd3Jf9pexvZS0TE/UXFrUyGPzBmdh9U0VxpI+UM/DO0prGhwuCFyFfzJSfeA1abe53zKOCX+NxN3iJ1neBpKvWvf1Au3GnpYZcGS7o0vflnmLxzphxaRzY8qtYNMtZWFRaKKlmyguaHY45znrf4JPR1Oi3flLVFpiGwoo+V6J1Fpeta/I6Y28M+IFJ6rR9jlDVEcAww24B9Zj/A0YpRzIq7QpKmIp7Auxh981Jmb6lRMdKecNUbdfXU2u1CWbiLyPFPZ1OHAHLfc3oRfCYSjFUfk/PQIN/+0BiOrAuGuOyQ+XspE6eHv9N1Atlx6DG0hzcy0tsaKfnppVwo8d4xDoA2t2CRXzj0DtOA27qnEUP0NC4X7bZaM9k/X4B5QG9oAp2Sz/Jg19stRKOWkpohS1dqcq8XCbg+Jd8t5ST3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341a3c56-da25-4a22-9511-08db0a325b37
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 00:12:39.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMcPNfm7aHeeiA8YAYOisT2MNuTSoPiOwT9vHdnSyt2uUV1qZrypYpKkY7XeRfKq1/+M/3yTWtBXm4MVpZMeEd4De+lCDI32AOI+lLfN978=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=726
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090000
X-Proofpoint-ORIG-GUID: kLoefCjGZy7j3rqj0BYKrE_Q515p8WdN
X-Proofpoint-GUID: kLoefCjGZy7j3rqj0BYKrE_Q515p8WdN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiasheng,

> Add check for dma_map_single and return error if it fails in order
> to avoid invalid dma address.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
