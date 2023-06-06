Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE0724B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbjFFSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjFFSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:44:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140110F1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:44:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYlVx009063;
        Tue, 6 Jun 2023 18:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mPlLxo/deV9r5o7eA7zVAmf9bGrXIbrMe49ObvXrTXg=;
 b=kxywxC2EYHCHB8b+I/h2ht2pI6BwtxleX2xXYR8lwzvRWTnefVaiFdqVkFQHXbH+qZ6Y
 7RTts+KcjS+GEqq3IiWFqBsMdq4oDhXt4zTH7wMKPBGFHMzkxC9jqyjojNL6vy6UzTyF
 uk1w3r/cOShLXHXIw6Fk4G4a2lH0IzFS/qs8MHpFOG95gqa77Vf5t/ih7oOuuCDJeYf9
 LgPRpRyZy8Eg3YUdiSKeJN7B5AN5Df+saLoV2VracCKpFdpuv67RtYupTOgBm4T6/1RR
 aY+SyVLfhpqhW3K3sSh2u7G0yjokO6DNUIJuYf1TpkJFEuMU2etpcFf6AUZCAdBElVG9 fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rg0n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:43:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYCAb035890;
        Tue, 6 Jun 2023 18:43:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6qg8tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NofD7CB5jSnEMsdL2rAkdjj66WEawSO7Yru+SWSwgiQM3QUaqygqaPucsc/g70AsQWrfPyYdYHw65UmSxSuU+muBtCDd2gK6nUcGnUD6Uw5cbs8gzglRxeN6uOtiJkDNFPDeQVJkLKWkVz9gFg3slWRPOofRTJ0m99DXWHbGPE8OMK7bZ8t0AHW2W1JfB6RfW5lLfGNkTGqyGfbEH3tdNAoNeNkUPdT6swqYPOWyrWC0lwtscm+0cKa6JMpSwyo8O2l3HLuKeLUaZcSgb9nYT0ZVKJUnU3D7zK+jtcWhtGc+54UezU+OL3e9i37SYYGxsF0+UZpLb6gNIGTmMsVJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPlLxo/deV9r5o7eA7zVAmf9bGrXIbrMe49ObvXrTXg=;
 b=TRF8Dlqh+cnnSTq6qFUIBnXZ7bSndf3KMN+Qxvs8yjEi1FDzi9/nYCfUl6ZQf05LQBIMSpFl+KutUJKOamxxczU1h/FLX55b9mR1Ogy/w2ozVi1f0lkPsHW/BRvPfmxI5El5VRQBZxoofnfm6Hxj/4LTP3GUysfJZ+WMSUfJbinBBu5sMLV0NNKFyGuSy/LJdTAVUpo3AkuLvdCQkyFaKHi713nAnYsfplRrjtBkjb7p0jApwQALe1/od6s8d6os9fTDwOccWPyM7OHw4k2wRBHh25b13sm6F3ilOJ6nxbD6aLfQfNrCcdDMe5V6OSwQrBGt1XESUz9xJECEy4nt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPlLxo/deV9r5o7eA7zVAmf9bGrXIbrMe49ObvXrTXg=;
 b=oUWg/IHU3uigkLz9JPUjg6i76AvXXAW8m6Sa/STW/jR52wPxbxeB3DT8zZu/Wui5Fo+/AILJwv6FEMZgWcRmCR1foTFbWBx3cVW1TY+Bv9kHjEFxMAbMIArtsAAaPfwkRc71F9YhxZGAGHavkZDX+A64QFpabZSGg9C95GHvKJI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB7171.namprd10.prod.outlook.com (2603:10b6:930:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 18:43:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:43:23 +0000
Date:   Tue, 6 Jun 2023 14:43:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH] mm: Update validate_mm() to use vma iterator CONFIG flag
Message-ID: <20230606184321.cmrdmkxfdxfw7vsi@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org
References: <20230606183538.588190-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606183538.588190-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: dc994bb0-5d2d-4ef6-92dc-08db66bde867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5NWc1T+A/Lird6OMP3pEKCUdzsr2/WO3m3WnKv2HJLVfsU/ETBMUvC3R3pGVENmNGAjK4su0gu+1vaNHfLGP3GDPywSQZWvOxhoyb+MqjAEmoPzZ38fEE2OnZJLuXR7Wa0ALEuRs7Y5Q+tIobMDoPBM0HfCQtYuhlLOR547cWqMPR4YUebsgofWI4abigupinKa93sLA2X7DwKBZKHFXXxjou3uxlumDahbTUcqwjtSRkxwWYk+gvyyfRWgwNBLnc4JG6/M30P+vgBbimxdII6PDk3e+mTIDtgvgBOaHWA6/iyDltb0DdH44bBOHJW/c+LOFA5n6gTOM+PMenfkXZxrSA6ZZ+s9tXQgw0/4rQYu/lbcwI6zqJZTjdw0p6yxBCBQjKsR2wAC0hl+1LiCW7uu6LN1cpdt5A/OBsI2kmCmCaFlwP0HkGlAbTv6jkiNL63wqBk8veK9trOABTrGVxyQQg1SKkDRxiwsMTrImEsnbY15kCPdV69YwmbgB5r06VvdkCNkkgekHtS6lLy0eCqfO+grJsZURVAQF2CtciTMo3yT6lblcc23XWsT0L1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(86362001)(83380400001)(478600001)(8936002)(8676002)(316002)(41300700001)(54906003)(66476007)(66556008)(66946007)(38100700002)(6916009)(5660300002)(4326008)(6486002)(2906002)(15650500001)(6512007)(26005)(33716001)(186003)(6506007)(9686003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtMh58g6Z/XXiPqNkZqZlD1RYL7aK3OGWE7A9vrY3MPEWRe0gmLTn2m5NCnc?=
 =?us-ascii?Q?80qOpFK6k9dl+AJq2fAVRIE+WVZVWA5llLEE14QY4BAU7+qPRtW3dHmxT2dF?=
 =?us-ascii?Q?bImxM03vOFK9mXMrgeCRaMDO2hbpWhOeTBm3utLUsSrVUJXruvv/CJnaYRr6?=
 =?us-ascii?Q?5oIgSSU+gWZcu1o8AZU1UYEDEguabae+ffgNJpav446/OfLL8bToLe5tc1P1?=
 =?us-ascii?Q?6dmzqB1PUkFk2/FDAUj5Bf+3vohjXvBJw9SjlGnHdn/IoxBqJCTPN0lynkjX?=
 =?us-ascii?Q?PwJdimv/j73OJ7EHISz7/qw8GRqPD74+8RBJFEWVhx7f9gIlb27Lxg8Kw7Vx?=
 =?us-ascii?Q?V7op6sidBfU7vgMpoebzsDoZj4TDuR2E/RJpNR1K+/k5/YVHDZdig5RBOYke?=
 =?us-ascii?Q?6C9R+6TQi2Cq1SoJh55MQWwULtfsnuKhqMgVFnotrXsbN8AvWLo5VEJU0bKT?=
 =?us-ascii?Q?Z3jI9nx3W/zFeuXU3LXv7zA9v/rRew4lATSJ/LqUfSJv4QNFRg4x9r1l5jSw?=
 =?us-ascii?Q?XPLayxvVZrAsWDYGNXriE+YY5M0PIEcri/EE5FVbmDDDx4z0JK3M7paQVyrm?=
 =?us-ascii?Q?a/STdTuSZ1+GO4j5SWIqGVs9kSgUrYiRD5nEsfs2eKvLrOsFB8LGduiOHtok?=
 =?us-ascii?Q?dk1ddD76EZR8jkkdqyifbaJbNhTMFiaO6Uoe/TVTcZMzUlGoKNl6eQpRws3+?=
 =?us-ascii?Q?N/QQIZdQS6ydXvIlHGoDQqKSR4JFZPVNHFqL5NfHikTvyjfACGDEJMnlDS3q?=
 =?us-ascii?Q?szCSMrNsPQ7IzGjYdNBhTbCdjCuspxizNeadeXcvVgWFdQjNNM/ViKEtDHfd?=
 =?us-ascii?Q?Y99SfzUV64+fYlu/G14zVqr86DZVY3TChb8XSR+mzsT8ScP0ozI1/mVVexfY?=
 =?us-ascii?Q?lpq6da/DL3ldx0uE18yFJHZRIr2GKGf3GnqY4WFoKWMVFT4OUXRhrZoqwmbL?=
 =?us-ascii?Q?3C/HYkCyQoxkpQ9AzEMaNPkCnfNXItKCcf6M5NG1Mg9jfO3od6AS4wPd6zfe?=
 =?us-ascii?Q?PzXUIcdvCNqYVFKJFaGrRube5di+psrf2CPKqer9SwtPkQ2wjSGU5dHwWlVA?=
 =?us-ascii?Q?qgXgxpScm6LukA797TLkkK/LTcFJ5g7TPWsbEpylaUnijHUhFwfl5TROgKnA?=
 =?us-ascii?Q?KE1PojMM4uMjZqwmdENnd+X7BpYZK9jMhMaHAWTgizrnoh4rPKPSwqkvKdVJ?=
 =?us-ascii?Q?xZy69P8E1GvCGBDjifDBQJtiOHkxD6TwTeMPVPUAH2FZ4I+61C2S+cVUrHSm?=
 =?us-ascii?Q?eRyRARIj/ReeHHfmx15NUTp4zEwgTmQQzJMqBbDLuQIkTbKuI+1q9b3NjMX/?=
 =?us-ascii?Q?uP30HsI/6GnBXmHBHGGM+LkDEb+z8vUAgt43Y5AbNtm6idyLmhxjx+6cv+06?=
 =?us-ascii?Q?NR5x6z1PpAANx+9GvWUcMEUoY05U1nMeijDs+9ngj8FBV78tUdRLSFW15rAC?=
 =?us-ascii?Q?X3DjE3AcAdtCNBNqJBB03HW+hLJBGu68CtgDSIUmkkq1MsFOQNE53kHYuJsE?=
 =?us-ascii?Q?8dEe4QL/9qt8JTZh67r6oGm0PhBUQnjfnd9N+6WQi2tPb0JOZADOMPk4WRac?=
 =?us-ascii?Q?5Ml/+oWhM2ZopUwZUQbED0597MT/Soh+KNYLNw0muDkePh6tfTcF+8zO+xrs?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BOA78aFNtNotmYDs86t3sdgdM8A2cbPGqrjolBMOywIM817OFjqzdSP9iuzr?=
 =?us-ascii?Q?zCsVIHBfQD99bM1MRkKs/Qezj5xKalKntQFVe7awX1untI31slg5Y5bON6ow?=
 =?us-ascii?Q?U4QI5I/y7AW5jYPiHeFOogo8DqROwdq+BhPb+zl5XdQPs4x43LnaL0Q92tjo?=
 =?us-ascii?Q?aCJEHN/TdKRg381XxMLM6qguIyzk8Nl8YBwBoo6aarEbvMchozpyod7dV1Zw?=
 =?us-ascii?Q?cRn1sfhY29tm54hOBMX77TYm4l4bKJ7f1XfQnvWI/w4efhnIWoBguwhyO6oU?=
 =?us-ascii?Q?r2g+LkXenz83HNj7yzJFeMuKlxGBTMDxf/NTma3hFOLBc3dkMtrrq1q/50wJ?=
 =?us-ascii?Q?+DAobklYFvhkfOE6jqE5DBnRbQtBEwMZKsB2Gb1cgk+xxsareUnbmIuBTQ8c?=
 =?us-ascii?Q?LO1Il2nTX9z100q6r0p5r9k/mD8QAcUgZvYSDNZMUaIbJR+ocHpSCMUQwu7b?=
 =?us-ascii?Q?UOgmyfhnWYZZO/0Nmtjf9Wp45KtpX9RAUk/dYkp9gBnx50HuVLyaXRfv6Nes?=
 =?us-ascii?Q?75xzY9os/Shao/WDoYNoRavTzxWzNQ/MUnx0PgE6IZwHjdWfNVyd0Zk6e0NH?=
 =?us-ascii?Q?3J0XBJwgg4eztZLFzy8sv7U8ZloYjNWof9eO0tlPGM2ZIi2rlrawdo/mo2Tx?=
 =?us-ascii?Q?gFI8+fcv7BBecPQXQR7sT5Jv1DnQqESMtDuq4scS4gsMHBswZcZCenceYhFk?=
 =?us-ascii?Q?rau+Km5/BaYyS79oX6dQfYJHrVDiuLcEzQHXrWHBAJUPoGUZZS2tlAzdbbWk?=
 =?us-ascii?Q?fh4og6vYa9jU38xpx+UGx6cD/nE6/XuUAFi7uis0xCCTqn7q6rhXxYUgmt33?=
 =?us-ascii?Q?q5iAAghUC4+0fk4JnxxGPqs0uBbE6CUzrYYiyTH4UD+ontNHKIIeBYEXiXya?=
 =?us-ascii?Q?+94swEkjvFXaRL/Ma8lBBDVxaDbCmCdtby0+Or1+HgcH4HbsltRAPa+Hzfmj?=
 =?us-ascii?Q?PBOcwo9/DMssFTOSVZ7aNbdGniYVHwHhUQNHyUZZvxs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc994bb0-5d2d-4ef6-92dc-08db66bde867
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 18:43:23.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03BUgbElny1yVkudlT5wBE8EAP9+O0F3uymswQ0V40YDsabIT4JPOfGsfhH5HgLGdw5llF4DEtBb4KGiuP4KzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306060160
X-Proofpoint-ORIG-GUID: NjiPXk0aaWs3Kb4aGuVt0d6da9noa6bd
X-Proofpoint-GUID: NjiPXk0aaWs3Kb4aGuVt0d6da9noa6bd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I should have added some more Cc's here.

* Liam R. Howlett <Liam.Howlett@oracle.com> [230606 14:35]:
> The validate_mm() function was deemed too heavy to enable with
> CONFIG_DEBUG_VM [1].  Revert the config option to
> CONFIG_DEBUG_VM_MAPLE_TREE
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
> 
> Andrew,
> 
> Please squash this into your mm-unstable commit e9c9b8e9753d ("mm:
> update validate_mm() to use vma iterator")
> 
>  mm/mmap.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 71733953ff83..7c106a164c0f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -299,7 +299,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	return origbrk;
>  }
>  
> -#if defined(CONFIG_DEBUG_VM)
> +#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  static void validate_mm(struct mm_struct *mm)
>  {
>  	int bug = 0;
> @@ -307,10 +307,7 @@ static void validate_mm(struct mm_struct *mm)
>  	struct vm_area_struct *vma;
>  	VMA_ITERATOR(vmi, mm, 0);
>  
> -#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	mt_validate(&mm->mm_mt);
> -#endif
> -
>  	for_each_vma(vmi, vma) {
>  #ifdef CONFIG_DEBUG_VM_RB
>  		struct anon_vma *anon_vma = vma->anon_vma;
> @@ -353,9 +350,9 @@ static void validate_mm(struct mm_struct *mm)
>  	VM_BUG_ON_MM(bug, mm);
>  }
>  
> -#else /* !CONFIG_DEBUG_VM */
> +#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
>  #define validate_mm(mm) do { } while (0)
> -#endif /* CONFIG_DEBUG_VM */
> +#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
>  /*
>   * vma has some anon_vma assigned, and is already inserted on that
> -- 
> 2.39.2
> 
