Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA0F74F836
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjGKTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:00:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A984E4D;
        Tue, 11 Jul 2023 12:00:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDGfC025098;
        Tue, 11 Jul 2023 19:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=go7Z0vesYAjBnKsXrx0qbcHBLDgQJQJCXDKColpYGEk=;
 b=izHieUTzeWGhScd5tMBlergQd7TUluNal/XKtvyQy8Eo/oDBLaAiixk4EbAwSX0YU5Di
 4vNlffj0PlDBAl09F4Tdc1DJh71zN8QKHgx1qXGT+RoMpk4hEyUk3bzOrnulCgYQ1yiV
 Ws9FLdplG4TfrXjaHtIznPPSwFigPislW9SWLojJVtJdoM3f3RH38FM9yLUFqio/FdPe
 G0OF82Rho1udV9O7M1y7wBhg/vbQI6a7Fs4dzPonwfunHQNG4gS/HsxeLQTEQWGBC6o1
 rB9H9RiUiC7Ag/eaoqtBaWRjx570NZAg4JmX3wO7RaqQY7PdyrbAPncqtfuk5wiaLLOk 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmhb5m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 19:00:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BI3dTM008366;
        Tue, 11 Jul 2023 19:00:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8bk5tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 19:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVaTqufcJuXfZRV3l6I+pmAC5dz7rvhOkgKY9L4An19qg87ai/KqCA4yi/W8yYPv1brzKrCzLtYnCFsbzpLIMOC4ZDIgTIeFXLBscvd2X/zkCoZtrtCBUwjjh7y1939jAuj4r1cBZfe+VhZNFm062LliDMGkorCdyKlXVDwB1AG+56QszcSeT17HIHiEFH9zNOj8z6uPg4tOI0R7FSOPmrxTRLo8NT4aXjKCjq/dhSJ9G4O+aOiL+TmqnRKofzknd5XqWRewoHOXdEHi+olLfNsWCNi2LYzCeVsgv9lf8QKjI2xl9c58wObRsMhQi8GWXpwHPUjk3OZnYaMcOBWCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go7Z0vesYAjBnKsXrx0qbcHBLDgQJQJCXDKColpYGEk=;
 b=Wl/DlwN9tyMhUNHwFR8e+t3/3WpAaeKAetvxGIU5J0aT2VmuBpwlSNbnfSlgYOuRGcCGzInjiGmL5+tWs6goazgIpkXX8LZLPqeY/0rSsOkMPRSrK/i2iDwB4aKN3VRW5XkdBlq5NXTkdR455+9CDJHAe1p4Z4AagG6LYANmLtfXrk5C8oeZt0Ln39vKwkjZOja44dJ87HhHZIsZ7Rbp4hczu1FEFsQaeFRJrowbvPnzgjZSa6i7UQypw5Cc44EKOVQMY/MNAgwJQbNntXQrPXTTIYU6E8dVdBI4I535q2B3Q2szNZZFxb5wWjbMVy/m7ucctc2grlKR/WIwZ//j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go7Z0vesYAjBnKsXrx0qbcHBLDgQJQJCXDKColpYGEk=;
 b=uMNTEYXIZrY9Wf/A0GnHa0MCva0yCbaGrJgVuenPciHHfr0oGMdpqzon5K0U5Id3ON4UWO2EWxDpnfp3xN7pK+aiGOAPHE9rucwzhXx0VdarmlJP1cdgSl4Bs1l6SqmlOuX5PwdnM3niyB9jht5fQCePKO6BLp73KjYgZuOD6BI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW5PR10MB5715.namprd10.prod.outlook.com (2603:10b6:303:19c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 19:00:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::101f:466f:718:4375]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::101f:466f:718:4375%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 19:00:31 +0000
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>
Subject: Re: [PATCH v5 0/2] Add MCQ support for MTK platform
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs5uff40.fsf@ca-mkp.ca.oracle.com>
References: <20230701124442.10489-1-powen.kao@mediatek.com>
Date:   Tue, 11 Jul 2023 15:00:28 -0400
In-Reply-To: <20230701124442.10489-1-powen.kao@mediatek.com> (Po-Wen Kao's
        message of "Sat, 1 Jul 2023 20:44:39 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW5PR10MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3e4ae4-ea60-4f6b-44c7-08db82411953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/8Cke5BNyoSuoHUfEDtA8Rf53G0vGMWS63sc4/vuzJiNmEl//N2MQ69oC+alTq14PkfCaVn3DUxE/LhAPt5i6i2azyVwHIE2Bsr1ibtx6gzh3I1S8GLEFbc5uAUeRh4bSv0Ww+VHgq3+7vfxl8nJNk5ioBlHr3iOvYjpsiiUisxYrBYmQe4uFATIyHTUoIekSeaMVEEeXyVtSz+gbk+4454lfFuESpIUNM6easJhV0+TKVPjMuB9or7KVXzfsj615GGs1t+WkFwJ7wPw222VauVgxPbdYabD05EOQeLNses6MDDkcA+5s9NFRoWiRUt5E+HCeA72mrp+25wAUpN5XfgT9qQqeL/KBbtXkjdlSalkPNo/Z3xc3q1LQaOmAXaDj3X0fiYNhppJnaUO4iO/RO6sobqfqZg2cnRxg/0LlPpQOvsYMa+jhNVOjLeYirqRQBm4vaEq9GV9+eDnwGyswKSu2vZwmQZVsMMPTuy5ZPoJA76056czZQWO3CxaDH0Vot+tV+MToxQ/RMuW8bYZRL6ZCVyyxnXPzQWNDfutdxjbydWYm8VdmPPQnNKRgq5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(38100700002)(86362001)(6666004)(36916002)(6486002)(54906003)(558084003)(26005)(6506007)(186003)(6512007)(478600001)(2906002)(7416002)(316002)(5660300002)(66556008)(66946007)(6916009)(66476007)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1a5ARIJAoM1MfL4878dYXSloxY1gbahQbiipDSqJ+U/ZGCrMU8bil/sV2h2J?=
 =?us-ascii?Q?/bmtsDtEKhHloOrKf5ZHQqD4J+JrW+mfVxyatw/dUyNJVKBJgCkZpyqBwjlU?=
 =?us-ascii?Q?rpU6kMdZPv0E/Gh5tsHqpEk2mScm2wkp1uka14aM/TWnmUnsCip3Ucd1oLgh?=
 =?us-ascii?Q?gq2zDekcJjAmhY4bf+29u+WrqKPRcra/RWFzF11sWJToSjweFwFgucsbqhVS?=
 =?us-ascii?Q?FeROR92D1wppN7XI4jVNQQ/czrF8Z9Y4J2Dtsc/pnkBGsFmL8B1a/M7Q07UB?=
 =?us-ascii?Q?WfzVpcR1tj2JMIdfNmHdmyMahs2L/3mub+lsTMvri/waGSUKXUoRlBKIPZGG?=
 =?us-ascii?Q?ZrLWjTcBdnuRIomq51yKKvMREm+cToK03S8sEBL1rqpMgvGJR+CGg1J2AfTH?=
 =?us-ascii?Q?oA3hjjuu8Hjpswiucm6wmbCOIVk38xXS0xLavFDBdp84Jatzc08BmxOM0Des?=
 =?us-ascii?Q?+1j2THYly55W6aNeKvo+kTLt78TziKs0k80o4nR8H7SnpdISJj/HIEgxBMcN?=
 =?us-ascii?Q?CPkrTX4ZZWd2i8K9u50QGQMgimPyZlmCqGGpX+YUIPn2mHjORXdAw8T5tCci?=
 =?us-ascii?Q?Sl4W7mHwLsevJ4QtA7CYjb4yK0obscbu+9bopFERDbxIs270qZRa1mGQbP13?=
 =?us-ascii?Q?BaJ7Y7Y8MD05o9EO2OYYXDpv3GW2EC73rOQhfQv88Xmhy3g/rcdeJamPFAW3?=
 =?us-ascii?Q?dM8ngqDiXwaNwVSujFiJPYtNiTGJ3RZhrDxmzVH7jWyuemeH7WtY0573JunV?=
 =?us-ascii?Q?A5jz2xQOqFwWwNE8uUY8DXLvCAuPO9xvuYhCoCYIPPUhozOSFPU4M9r/YeBP?=
 =?us-ascii?Q?EHjl9Q0O5tfhrc/IwXMiBjqPBPi6o14l/4cMrusEXvApWuluLakdg+++sM1j?=
 =?us-ascii?Q?+lSZHWLzZ00K59gMdP/DPqx6pegOZQ2Ah0HTWS2O26EGm5mdmsnwc7J7FUlT?=
 =?us-ascii?Q?61oeQQ3N7DbLSkuub7qQzlyQ7sTBhEAU2YxuAnivBE9XGFm/GJvxG2aabxtJ?=
 =?us-ascii?Q?kAEknP3j6dILwLfjqH2qvc7Op1BJTgei/qphubS31DKqrxYSNYYuhmnEYioG?=
 =?us-ascii?Q?S6IAQZ7pgkJC9GLHrcywoFOjj/qwAsvm8tV+/CCPhO6YjqXIhgZPTCOB0HJz?=
 =?us-ascii?Q?mQvxBaWcAlFTlH4etReEl/rRzBEOOLPCK8tUtCta1xEgrOCFaqPva7lHyZLx?=
 =?us-ascii?Q?ikEd4KZY3M2lU4bbx+p3W2rovgDoqZ1Aqr+xtGLI2nWGA9yIKm/i8Ch1D6bj?=
 =?us-ascii?Q?xiLNIaEfU/jqh+W4VY8MgYiWV2dGj9d0yk5wPjwnbOrymuOC0x56etRzoy3o?=
 =?us-ascii?Q?gzS1a8gKC6eFM8eTjcnpNRq2OZgWI/e+NnhLneJwFmmoozudjkPBZGK5op/x?=
 =?us-ascii?Q?UhG0k1EQiSTcVgPzSvuNEgK2I+0THh4Z/RXhmLBAvg/dh9ho7BDrjhAK9tbq?=
 =?us-ascii?Q?d+a3edbG7A25y8pb/ZBRoiErcUwKUGmaqNtpxMYj/YseRSZo0Kg5tLZFrVAg?=
 =?us-ascii?Q?CBqXqtG0umooC7C13+gG7VrHaNwtNgg0377uLv3EfaZTijlTmq7/frVvz6sd?=
 =?us-ascii?Q?kOnNyKcLMkAZOp9jr2R8Eca7w7zcIqrJI3zqMdKmk4s+fxcxSvVbf9EP/YVT?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gabCd0XEJb6qtZBdVEG+0tdBwDS0PoTbNfL+TH/8u8F5kO5/Xhaf6fx537k7AlIsJV4Kq+Q4ONXaIvapMHZbi/F6A94+xhMFL0hsWBd9Hd3sHL98qjtv/lCYbwB/SoLtlkcRha57wI+NSx+9tfHITSaUlThe3GaV79nx3rzAZZYdQa+Uq9vrC1p6j7xjWkpu13z0kAPVaXHxTMirZzVYix0nJh7fbckezM9NXmhYcLEMdyE6+3ResIv9ibHT3k8iezOSFO5uZNVgPYb6bW3fZFH2fQs+i/KyS22lD2CVA9KS+GkkiaTjo1JdUzBrB+wGwJW+24FLebWDIUZDzbkfCwU64icSVSbInxY/VDsIjdcuv3jZCtOoG4tUjBmvtkpDyGAIoLaE4o4L70A5X+J+q3YU85IKNDCKjzWWlZk7ClJsG/022bDBwm6U/wzziAQpP9W8nKE/q6nhU67wN2enc+K0kBjT2Y+AaAiedT403DZ7qBqOLdylYo94LbC0quNHBW3A3J3/Sm2qQx1cFUzzevhcZErtDPENQKuP8SMXXoShdu8kH9UvlXwr5fCbm44+Ow4pyvoFyWlLm7ID1gcmk6jyln5t+0yNstHA+CSr5yoC/aCOwIMWil6y1yBcV5P0MDk91XkQCbZVnp/XR79HONoeVIU+4zimgnQix5Xbtat6ekY3qvfW4AGUzkFh32lLSvHoYZvgY7DzQ07qKFKd9KYrsI1d+cHJRQPlMf8LH9qTtITUgTnCHiS+u5aT2y6lkWaVPiJ+9LI0z7aZT5PvmCBaGywRCD/30JJBzUSJbws4Pfjq9hzJLt173/M6K7c6xe8pLu6Q8M1T21HQb++U6Fk3Kb+JO05aIeUTvVt1zOxBYuH+7k7aiiIKNyvggFwRw1iChgrXbVFiCoA6WhIxQDB7gW1GzIvHvC8GnofK8IA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3e4ae4-ea60-4f6b-44c7-08db82411953
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 19:00:31.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyFXP7uvQgssQ9DnBp0719z3142nMoPTb+odWrE6OkrIzmA+dtoE/zVR8YHiGWgsgNAOQUYx8/MAmiZGMcGw90XpOU157G0beODb7C5tKbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=875
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110171
X-Proofpoint-ORIG-GUID: glLi1-WV_Cgr1gU8PIVR9NVPkz-a79If
X-Proofpoint-GUID: glLi1-WV_Cgr1gU8PIVR9NVPkz-a79If
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Po-Wen,

> Po-Wen Kao (2):
>   scsi: ufs: core: Export symbols for MTK driver module
>   scsi: ufs: ufs-mediatek: Add MCQ support for MTK platform

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
