Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CA672CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjARXvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjARXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:50:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53B6CCEB;
        Wed, 18 Jan 2023 15:49:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmlTV021452;
        Wed, 18 Jan 2023 23:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=EXYWpVqE0PxC+SoDQUSsF78CzONG/6IuB0WLRefEDfk=;
 b=fY/fcK2hzl1TrV5uwH4ynPfjHmZOHWU13/wM9EvlmxatKYJaChnq0fh7wLBpXZlR4q94
 +8fSOOanALUruqHpO02JooxNscATrasJ16Zxuiq1nzy7m4mJUVagaGgUjNBkSaCysO0z
 AZB35kpG9Fjf+SKNnvN3sV6FFzGy1gBG2fymsHnbTMkmr/IY36duxNQ3+MCaCvrxL3WB
 +egNUmuRiX+ce1FBoz8qIlLZKYbvti6jW0elohFG9nijgy3/UYzK4FoT2JN/cvvZm66+
 uBzpayDl939S3TPyYDgDOIyZV6rW7/lUw8ooFX2CYJjaTgHUGl95hTztDhq+vJJI6LPd Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0trx3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:49:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMLMQ8031771;
        Wed, 18 Jan 2023 23:49:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quax3ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVKBdmC54Oo8/B/UmaAKmn07J9ygwxJrwdyReF8QdF5AcsG90OFuGNyBw5zZFe1IjMg464yVrLFbknoPxlG95GnUqZGxPg30WasIuN1umh5X/VDdhrpFJKxP/UqF29d06zXOapMWn++4QPNNsEOQb7cihIXfh2/Ccynsiym0ze3qZhhOTPi6vmSFF/P+unhuEbZtnBCV8yYpnK4oS+WECyno41tSiYJC3K9z4ZMD9Jnt4rfTuYtHPyFqqki5RM/UluyTM7Do8g1npfY96vpqShPYAo/xq2NMlxMifkiBcSdBRsBjXhYxdyOXdefvJpU7wuZuuetWFPTq6nRe8gWNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXYWpVqE0PxC+SoDQUSsF78CzONG/6IuB0WLRefEDfk=;
 b=UlQ+GOzIteKBjFgzpZduBFZj9wxKHx20AXVrJfPNywXIXXIm0MsyYWN3c5dwwwmIfdzqhpr0EHI6ZCWNtMR/7EJZpYilY6uGh3tPan3g+lt6Tc25oGE4CXmnd9ulHnQuBCikR5T/hwzB8HkxTtpuK4wZPpSmhERbb1IdGiWE3XWNl4VUcKggNzpLdjU2Phti+ORO1io6AqtxZNUMrtzJHMIraezQ4m6SK7Mso3LPmRgBoIZo2HUv3LAXZZkgyw7sspRpesc1nrhT3JzHhejGpk3WRDG24lDeINnjN0FzMo1ytmPxJ2dngxA+0xFsNiu7zadN7KhSk4F8UkJv0Ofwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXYWpVqE0PxC+SoDQUSsF78CzONG/6IuB0WLRefEDfk=;
 b=g/SMFuw/gEOv39YcOnVtiTtFPkJOHlQJCQh+ChnU2bfpZT15rzhzTgQteXlvlIB44ynB234n36JwdnVhc+mLsQ6tyisSvKGbl7L9LAPR31PsR0/CMkXKuYM2Ql3QS/6g4U+hOvw/oSkY9t5ZMefaSvMHs48JG17i2/lnthW1XGk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 23:49:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:49:02 +0000
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND] dt-bindings: ufs: qcom: allow 'dma-coherent'
 property
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0vro13x.fsf@ca-mkp.ca.oracle.com>
References: <20230116164236.18958-1-johan+linaro@kernel.org>
Date:   Wed, 18 Jan 2023 18:48:58 -0500
In-Reply-To: <20230116164236.18958-1-johan+linaro@kernel.org> (Johan Hovold's
        message of "Mon, 16 Jan 2023 17:42:36 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:806:24::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: e11aeeac-ffb1-43b2-8b94-08daf9ae937b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3r+Qf5MHQnFW8FpdJ660h56q5WzuUSw7ExfSe7pVKvjRCStz8/ssJrwQKoq8ElMxGVGdWvojxVJFybtJeqb1sDykNJa4aGtKGGYqb0GnVrJCmyD2yFxTgK28+39ycCZ28gEPUzeVYou7zhVaGTiRbwhXe0412Dn5J6J1ihMdHm8A4NidDRf7jbyCM3NxKZiJJwFPSMV237h8XG6oVdlY1V4EftTbp1V7y/8S55lzDvY/LhrJejnPmJElgyL8f6zVMHn0rXtdZrhiONlU9Yq8e5ErznenCM794O9YSLloa1D3bjLpijFLT6AW3sNA4R1+IEiyIT1IiYgrOrE4eCOsewiIJ5MLwjb9Nor+pe65fJutOAHPbYoJWd5eJR/fk8REhAh9s8Sb04pA7rVFonIrXO/MBBr2b/hruORsoeFvHfY3uK7n9OC8Q0mO07ONo5nAzyb2jRsUjjgmNyEeqIQ0tyFctZ/gdN7YNKxz4VTBQrGSrqPy0NuJ1nrrYt7jvIIN9BXjOt4CZg5vYO94v/1+h6YDn1Gkymx7VvgnC8C8qk5CnKqH/z7uIZZoIdtsQg8HOy7XvuR/qElb69U+0W4rIbpeWBcUq4SabDngrV+fwmhnRxpUOCttXDOO/5sPfVpZHnqw+5dg/+rinL2HRw9xqPkgKVLuw0kZVO7xMlz48AYqgHdTYB1jHjAPuXzni7I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(38100700002)(558084003)(316002)(36916002)(86362001)(54906003)(41300700001)(66946007)(66476007)(4326008)(8676002)(66556008)(6506007)(5660300002)(7416002)(6486002)(8936002)(6666004)(26005)(478600001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F79gLU9/CmWYL2SqSRI4sYpUX8Xm8BWR83IwTrGbR9Eg3ylCyoLERZjLGfaw?=
 =?us-ascii?Q?UvvQQGcrQdGOIW+5LaqGwrOXWSp46QAf/dWFZG2/7qVyhpMGtIZLzMsXh9Rt?=
 =?us-ascii?Q?zM1B+kDWnLrC1wlo0QGtaHwevMnETgFpaYfWp1fF4veKU+CsdY4Kz4apLMUU?=
 =?us-ascii?Q?1tJ/eDYR/kLNzAXffXttAPFWGsei238tiOJrZc+O2wPZBGT1YhWEsxeWP8+Y?=
 =?us-ascii?Q?cgAI4/AAHX8YGmL86k1I7nP2a6Il4I3oNi9nEEP+d5H90TY56wxlY0XEgOvE?=
 =?us-ascii?Q?pMVn+i8kya30yT8CL56QUpVdpAo968K36pJZKwo+q0AQliqpblQ+8vQQLeSj?=
 =?us-ascii?Q?MfZfQCyxOY6scx/vGeSA3mson7+2LUDaCNdBzEPn2o16mGNrw+cJE3T00mTg?=
 =?us-ascii?Q?ee7sldBifPhnZjYUy1T0JW3XEWCJF6SXcsCnJfujkkUanJ/0NYYyhDvFg745?=
 =?us-ascii?Q?3mIwxpMOu8rB4C/rSXvOtNEnypanwoH+1soicEfRnKdNpB9h/0xsbt3zp05/?=
 =?us-ascii?Q?ys60t39kefu4Ea+s7r2YNNn2Iy1hp+WByWBGSRynQcls5UCuTNr6b8dCbP+0?=
 =?us-ascii?Q?zHRgqSp4xMw4nPL+yH2/PBwDdsSMKPb+YpJj1cuouFv0rAomMnFYFsF45RTK?=
 =?us-ascii?Q?QYchZtDLrVQ2Dl2SPpBG1s9mBmJdckLoFodDPLe9ios5T1GruHHrn6SgDby4?=
 =?us-ascii?Q?SMxyuX1x6w3A8OW5ilRiDSvf3ux4cp6uQDrD7Mg32SfCFGsPOTMlyjbx9r1f?=
 =?us-ascii?Q?rkzuLyHQlyaTJ8b6K9OJ3ZtsP7EI9xjLD7FILre877Gly5/N0VeYdr239Zje?=
 =?us-ascii?Q?6SsTDnal+0yBeeR3ZJs+oeNopOBSA+8QeWop98UDHS/2u/HQQbjneVw5sDHQ?=
 =?us-ascii?Q?WAfcLmfwV8kwRoRogsAszWAS4CUc/+iUaoN+COlWGbLzqpMjrNU4tNEdB+ZE?=
 =?us-ascii?Q?forz0W/Slv+KViuwX1hpr9q87SSBjlhplfxRcWLAFagxnenC4Jix5CZkZA1j?=
 =?us-ascii?Q?dw3vKsUjOzi/i1fLq9zf/94zDOfdK9RIO+fkd8RskGJTLnPz1zve/7jEIYn6?=
 =?us-ascii?Q?omzmuWjqfSHuQjzMxQOS91S9mrwZqIBUZtl1OYbdMnM3gIJxQ7HmtEkrD+Ir?=
 =?us-ascii?Q?KcWh812jq3Bp2UN8p99fkojkqPYz7lXscZFSDH1VYgTA6lLTNbxQSYV1ptTL?=
 =?us-ascii?Q?E8bTsRMGGl6slnHOvOFgbgZmK8MdkVI8btNqfZL+EE4fELwjjrKOQkZhoYip?=
 =?us-ascii?Q?41OUT5oJGIvpTY7u8g9kJoEmBMkcStad3JjzdpSjSgI8PVezae4tiehjKK2G?=
 =?us-ascii?Q?W6E3F0cknasUHiJjyuEwdJiPvIrucqWd5c3ouNo2b1LsYRxVtqN2cIuhnwV2?=
 =?us-ascii?Q?BpMSbwtaexGcU3TlfJdr/d1BN5Lfn7/2a0x5KfMmBZpx3rsbQA1Apii8T/qi?=
 =?us-ascii?Q?cFIY4c/EY9lNEGAZ6Jh/byY3KsE4VWM6WcY6UOfhZ5E9WoPDGla7Nq3D73oJ?=
 =?us-ascii?Q?wDVI5nfe51K4Rc3zobvEcwckIuIcnuo1fK+oB0n4PvAvrrbApI/QPpKN3HsA?=
 =?us-ascii?Q?NVZ+rU3TFgZBqpuhvoeg3nwxjNrMbm9gIB8gOnSrI+t2TsdV1n0sCZrkmNvF?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kWcnJr+8Qu9hJWzBVfl4uCSyHVt+jlqKwvHgFix8RWCnVkGKfB2WfLCJYmaG?=
 =?us-ascii?Q?M/U9kOs9D/gpS74/CWBmtgbYUeKZUe2GHvrvVjct2aqAYkui53xKdSw1k13B?=
 =?us-ascii?Q?qM/kdifzTo2IIuUoKlDWK5w3Oi8/1ILrvFauhkFcgpat/dG610OU+CQVmJPC?=
 =?us-ascii?Q?jA8c8H8L80yKoqR6XehhH0CTOOs+gCXAsTfUKB7HyO/1R8Fwc3uk93xiIfSS?=
 =?us-ascii?Q?YuvgXGCsnk2IaoD6uYJEpHSmoOTqomj2Y3alyVZucvjqSuujxSZyx4WVCFl0?=
 =?us-ascii?Q?CQN1JW7GZmTAq717a/1+tCK2qmwexAlqaj+abg4iWVoUjUmrSMK7rInImUKG?=
 =?us-ascii?Q?TNPIpDfysHcDwyn8BWd/VTBR6XmySoYaGqU6UyEsP3DKNjnN8FAlIcwnt8BP?=
 =?us-ascii?Q?491s2amGeMrQAtth9MUpXftk5ziqp2TJX2tvNJhNzSJi8hSMgFDra3u+bcym?=
 =?us-ascii?Q?WNze/dXPdFEW3lxjrIvxmjtotJvjASLtb+QOjN/dB3yIfQM+FON+LTcMe1W4?=
 =?us-ascii?Q?5YFguET66bUIXDjnQ7ghlA/TKYkakeV/bmmmtgdkgXpVDpFyfb543+Esp2i2?=
 =?us-ascii?Q?Pmu19Dn0siH7fZnnhe4a1WlZeUj4C1NkuqxIUHO4vNy0IfNw7WmIKVSXT1/2?=
 =?us-ascii?Q?2QM34JVA7+M1GaAIoBHUnniLVabNjq+s+QhdbunfL9VuLQPnVjy+C1Fmn/pR?=
 =?us-ascii?Q?xQaVt/2kvDS6G5RkiymJvEp+CuEKB5iQFuUcvwqBf18KPnekpHLPEqx5G3nk?=
 =?us-ascii?Q?Iy1EoZVf+kakJIW6apvibznXEh6pB/W7KotqCCgpDEGjE+UiEpeyM+hkG6aH?=
 =?us-ascii?Q?gc/ncEimlO7/nHQXhFAMJRWegQcJJgHmmKeIWweR4xLZ6/zQAryYQ2DI4Mdn?=
 =?us-ascii?Q?p7x9WMZ95y1GGT2/fBU49A40nCIUDDraihTK35IoqC9nGoy5MRXV461OvfIi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11aeeac-ffb1-43b2-8b94-08daf9ae937b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:49:02.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaQvnsYUDUa4u91/uRcQMplczraLYNV6g/4G1giRsX9nASpc18LVmuBVeR0j/rekRtVs4FDJgHQJCCwS2tb3Gu44qJ9Rm/rlGfvIeVzQ2hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=865 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180198
X-Proofpoint-GUID: EauW81XLHAVCwQeztERmIkrfCcXfozOl
X-Proofpoint-ORIG-GUID: EauW81XLHAVCwQeztERmIkrfCcXfozOl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johan,

> UFS controllers may be cache coherent and must be marked as such in the
> devicetree to avoid data corruption.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
