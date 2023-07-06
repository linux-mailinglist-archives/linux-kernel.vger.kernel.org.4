Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45774A28C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGFQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGFQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:53:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43548171D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:53:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Fx47B012837;
        Thu, 6 Jul 2023 16:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=H/TANZpQsppmOBN/VPSGCge4OI20ruXAuK8+Mb3Xipk=;
 b=UA3hclpS6A1hpCi9A/w3RQVkWQ8B/CLI6qGVGZb0Eq5q/fERzT0yilpaqpEyZCkZ0oQf
 8GP6m6dQineKWuBxtxI64ut2zpG/hPab4d+sJitfLErHVKtsW2RNlH8IJAyJSDf41f7e
 r+RS8uPCrApExn7HnPR12OEZRFYSR7kz3CSgdu1EoPokppzf/+bs5DFwiv+NKicI1AJ/
 xFNZ6gBP+N03jwRFzYRw4hZi2gsxri7RDMjjhSdXVoltESGwPb0w7m2LfUlrj7+cDXAE
 dpOkaqvXtYdP+1zJYwE76rI+Om9CGxCx21fsQ1+P7nCp/IPzzoHipSv/rdTUXkivkeVL zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp00sr95e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:53:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366GiBr2001749;
        Thu, 6 Jul 2023 16:53:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakdaamc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 16:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+/esdfoBUFJGmTf76qdtD2EVLmcLIYqP9ly/iSQQtWMC31iV2XjJ+qREq0qWMaOVgeIArlgtuPMVioj8FLZD03CEut0nFu32b0m4RJsr3N7qFS9KUzO/nW8X9Hcy3VJWDu6Wl9f9p5Y2QgKYRVUFBab+wmW3m89Vv1GF0wL1qfKQT8qyDDGAEA0amK8v6QhGsIQSpRazUn7VjIpQ7QjKHLHLqxIutOo8gPEjlQ9P9tNlRPLswRmR23lAIDrSYGH1nVDtq/dg8p6KEXPE8ddHj0oYeJOcSbl+IZH+TMkO6eMnzICsCuIp2bpGBOcXRO5qOwDSq6rbgL5qAbip2vUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/TANZpQsppmOBN/VPSGCge4OI20ruXAuK8+Mb3Xipk=;
 b=hSJL4ZiRJqhr5rjhLEl3nLFO+qVznxuyp+JmJr2RCVdr+rD1are1iOVthoMqn8uTYZRjJWaHzGT3MCXbr4tQ9/PBBs52grklNQho7orlN5WxMPf5mrrZL/tZOTVCvCRsGtNUqqycXdcpaJj6XORPIH003+1dN19/DVVkOaR9IJHO9XomOqFFHgmOAYdHMYRC1jgMt047lok9b1YQplctzlC+JTv9Tr88A0sEWNtDa6T0j8KCn55So9pQSbze9UorzTuXB6x/f+mkZ0dYl6Bsoq6qocshLEN3i4H/GbNdBksmzKlRdz3wYd7ZdbG/rp5MM8gUt2zIebhM94bZxiXzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/TANZpQsppmOBN/VPSGCge4OI20ruXAuK8+Mb3Xipk=;
 b=seqRDtwKCxezltqmqR5iM/mZSLF64OTmLD9TpaYb/TU6dHrhc+/T38Nf6mzsy6bLdWAzWUFKXkl6Fk/UtERCztj9ANHSpmlE5DMnAXf2ML5Xys3GuwulRdC+IdtqMuUaFGJTbnex53XtDeF2QeXlsvbdcjvMdgZAUozcrYDzyO0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5902.namprd10.prod.outlook.com (2603:10b6:8:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 16:53:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 16:53:38 +0000
Date:   Thu, 6 Jul 2023 12:53:36 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <20230706165336.zoxgd4dj2qh4u4ds@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <000000000000607ff905ffc8e477@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000607ff905ffc8e477@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:208:35::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1debb6b6-d023-4d9f-887e-08db7e418b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHfaopy/x6tL241nR5ij3nWVGz8//otByNL1j3PsLi681iIrBlq4XpAuhLDWHnsmA3FpxTSIhCe24i9yKGe0eUMmrTnSHiy+dAkBYNMhVkCDj5XTLrgzUFYPNKLguBCiq+J0QqkPG9NNjQW7ngXDKqtGAqDVinJm13CqCP6tbLyZsovkoU1Mp3S+81bn8dbJzisQ8UNmBBaQzpeqq2xKdEnWxhNw39MDKP5bffUTLR+NxtlXqmfzCbCkGX9q2/KeXWUV60pFXRKg9wJ0shIScJGjF4meD0nnC9twB+3DgJ0XN2/hCNkH0jIxrDL6FeaduaUuIPCE5U1MFl3QMax/mDg1YoVTuAFrGdg0YSvkql7W5tZT5XXMiuT95818DymFQb10/9qTptodR86D9WtIpCo00cWmSnZgy1wP0PVFFczZaL5KwbLOCqCkmWPKxUNUYfmSONoc3eQL7gyNHG5xOi0jNyQZwBcKgW+hVoAimpqKz7kSkAi1br/yTKs/jMhJjwjw/LFwjjWFqqpYPmhHCm1Ns9wAx95HCTPKkRQUR/zGE+4/IxS43U8iSFe71FIr7s6oCR5HKDYUdA0feM7S7icrXaONnKi8RaFmnQh/UXKjJHdiXwsBHkRrUAch9fCbdn17kVHmA4H1BSnimGob3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(41300700001)(2906002)(5660300002)(8676002)(8936002)(33716001)(86362001)(26005)(478600001)(6506007)(9686003)(1076003)(6512007)(966005)(186003)(4326008)(66476007)(66556008)(66946007)(316002)(38100700002)(6486002)(83380400001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9vKIZYINxeHtXrWh7Dca0zFyO2hNf/7Pf45nxE8Hhmhndne1C+Etji5QdKa?=
 =?us-ascii?Q?6wxuTZyqBG/bOmWDoQpvTP/XhjCLeAY4KYkS8NY5lkC0x0qycn90mEC4hWlH?=
 =?us-ascii?Q?QCoC/XZ8kn8jJOq3kNf2nfaUCcLOtHHjP/K7YJY7sRFd5k7wNoYBL6n4wIgE?=
 =?us-ascii?Q?3PILwXOTQ4kdBlqS1wkFzWyGCtOveZkubVXfvsgxqGXMW7IPUWfsJPGxKbuy?=
 =?us-ascii?Q?f4rvqyqwp00IFuh+tp6g4D4v2ua5JWpqJhDH/cBfarL2HQHR5S3kyFz73Owx?=
 =?us-ascii?Q?CCg+mprUMlReutcEgpVoeLQV9slgORlrlOmMrYsYJcjHDEMRfTtJdPWtjFoL?=
 =?us-ascii?Q?1MiyRf2chnsyDf/gMo8Ry1qDQlaTedXSefRf9d/beZNklKReLSrOql/cF4kY?=
 =?us-ascii?Q?cX5WvHv3VGmgg01S0WZpV6z+7TIhuD6CLPJuGseUYJb3Nv1paWaLGRmy9wdk?=
 =?us-ascii?Q?PZESeNceGz4qF4MkmkF0Aw736xbq5ssPXkZHUtD7uH9qxdju/AY+lPiDtP2T?=
 =?us-ascii?Q?l9AZaKsAogHn1xTkQvqd6WBXc1LxwFpP9yrIKImJ29gYl3GUDv9UrHSsmt8U?=
 =?us-ascii?Q?wxFTjr9nO7u7ssSuve83JoZAfF2v8FMiVn4yxB7y+sMzO01kR//rwkKbZnPi?=
 =?us-ascii?Q?CPmkmTwqNCouoM/Zx02DoKjbDAGbGLRutGGTuSR7P8QZnKHP4Qplumm6CVvu?=
 =?us-ascii?Q?8Py3yaoTEgb2/mApGpVqUnzMLUKQUaO5u31EWoZ/f/VU7r4/aCNvevPJSuoK?=
 =?us-ascii?Q?Rh8lBSgXH6pu/Feir0vItqJV3FHP8SL/LuBGLZ3SROObCUPSUZb2+tVaTMXZ?=
 =?us-ascii?Q?PzDeunCKWmvXQjQIia3JuQC54j+yC0obRN4zreggBCYkaWyySpnrFBVi4yt3?=
 =?us-ascii?Q?OTPW2pDMS7iOVMxAubKFOZkdUJaF4h9w6vWamKwu4u0KP9/B8DcWjwqHkcc7?=
 =?us-ascii?Q?OlESJCeFcD3iKpO/UFM/Od35KVzM1n3tofZil83iXHb7MzaHLGzcg/d+Xvcj?=
 =?us-ascii?Q?5AgaAeFFUjtDOZG0n3TsdrYSJf7/fiEsImocKxtsN3fea29QjEadHdQZKaZ0?=
 =?us-ascii?Q?0hmfwTVt9Od7Ofss5qD6KwR5j7RlM3smfmD2qwo8GF4lqT02V36C8g9QWRIX?=
 =?us-ascii?Q?ptjW65yjnRnj5jlQlDt54sl5YYuGu2RMvnvHZT74dU/xjtR7TS1BGdFTMPxq?=
 =?us-ascii?Q?9EeFggId/8EcttZo1cE8PfYMt79PNICtLwSGvQlQcWxAHVygjfsHaVZQ+3kG?=
 =?us-ascii?Q?JULLUVHsijBgCP9M+/qUWeo/3NxoJrecCjFNxpnG7Kojt0q4TIYLpTBHp5Cv?=
 =?us-ascii?Q?DkynN8y6UM2QbW9Ab25WS2n13+0vI6E7NVgw7SgjzjEIJD2fWpJXpyoErqUw?=
 =?us-ascii?Q?sF7KYVB904rzj0A41NTnHAr4kBWZ7uUtR1nP0RrAwL28l3QwGzWy853LS3IG?=
 =?us-ascii?Q?3IqH4uSMK+g8HS1a95UTY9u3UqeUifPlTjMuW8qnS7HSw5TvEBZshT9xRb1P?=
 =?us-ascii?Q?ELpsCgGX5KcojNnptImir0I0DfmGz8RyxqBCYja89JfbQ4mLmnHpmi3Ust/8?=
 =?us-ascii?Q?apoHLsPAjR4z/JBtcw4D7v5XluUdmlexsLJHhNCyAHhWTqnaTxJbelNh0gS2?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eQkDdW+FqEOIDx9jEUIILJ3rrzEMq974g4xH+ov/xVsRh6M3hnbuzjSua+Ay?=
 =?us-ascii?Q?C9dub6sFplpHGbuoVdkrFn6ab9EDuZqSU5RauYtm/s9hxe14+nlEdFR7bWbJ?=
 =?us-ascii?Q?3O6TJf7MZj+qSYPVV0p+Qjge11NugXdfqR+tTqhplvPUdAeSOoKrX80lTOdt?=
 =?us-ascii?Q?9WyaQvFfJ2oXRmgy3eX9wc410an6s5MniZ5aleTKp5y+EPJV19MvvhpvStPl?=
 =?us-ascii?Q?AZvKEe52g7fCicJLSNrjxFFM73nFVZhC17JqS9CU+5edNKls+VaNvnp9EZeO?=
 =?us-ascii?Q?HVNjRAg2ey9ouWCxcqKFG/0iFY8UXXdkjjAm5iQLzDM8i4ZmlCqwP9Z/esww?=
 =?us-ascii?Q?fHGRZOoSBuKDGICrCEUWepQ8QbZ2kTjGROdSqdhxRnU4c4mHZq13cDENmk5K?=
 =?us-ascii?Q?h2qnI8fe5OAITNS3I8eruoeHfOe0zkJ8tDTH23podTWa43ZE0Y2m+gT7KRSd?=
 =?us-ascii?Q?grhoXL5O6WIIJKKbVFsaRbWoNm9K8rloxK7ZjbyvlvIQFD92PHpRjMfLdmnI?=
 =?us-ascii?Q?x2yFHge+/Y7qlfjjusWz1Gbff0g1qpwG3SwyJSDW1wWXjMMHIyp+bttd9MID?=
 =?us-ascii?Q?5NY4bb5HwdxvSUJ+jMeVOVgSJf//1GGYDfyJNNdba0PIFWH+zCP2u5QsZDip?=
 =?us-ascii?Q?kDxqBzK7I4emkyrur7Cb4tjtApaGDNFU2zEIvEXUTTnUor72KGeGtzYRZ0BE?=
 =?us-ascii?Q?v1yoCIFKEN4/GBjQaOa2qrhyjV1guFfEysT1SQznZv6sGzJj9C/VvJgELKYA?=
 =?us-ascii?Q?ArlYC0FAWkc/6twmyA/uH0ChcTa3AFtXbglr57TNYIzaXh7ezn9+8/PdIedj?=
 =?us-ascii?Q?zytpLvrlv9h5+Ds6ROWAd7OHrfTNkrctvinC/5ewOhvZDm9zoprPajvGAXVy?=
 =?us-ascii?Q?qzKSICnfsjhOeleqm3UcJteRoiDKgrUxd82hIyPwI4lm+OLPv4Yc12L9UJE1?=
 =?us-ascii?Q?ckaPVv7T7ztM1pYcFlImsQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1debb6b6-d023-4d9f-887e-08db7e418b8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:53:38.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPwjRcF6dxH+aifqbjOzPky3yBRdJB0f39nm65mFrP4fqvElSi2HbS3NNOPyIYl2N1rtGxiNIW19OlUXZuXdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060153
X-Proofpoint-ORIG-GUID: AmOj7YM0hYrWg5U61ncqCCD1k1oGWJaq
X-Proofpoint-GUID: AmOj7YM0hYrWg5U61ncqCCD1k1oGWJaq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a duplicate of what was reported on lkml and fixed by Linus [1].

[1.] https://lore.kernel.org/lkml/ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020/

* syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com> [230705 23:22]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=105632c8a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db74cd5aa6878807
> dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3e7b15164da6/disk-a901a356.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9880c1d81d68/vmlinux-a901a356.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6d5b0c0d9670/bzImage-a901a356.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
> 
> SELinux:  policy capability cgroup_seclabel=1
> SELinux:  policy capability nnp_nosuid_transition=1
> SELinux:  policy capability genfs_seclabel_symlinks=0
> SELinux:  policy capability ioctl_skip_cloexec=0
> =============================
> WARNING: suspicious RCU usage
> 6.4.0-syzkaller-10173-ga901a3568fd2 #0 Not tainted
> -----------------------------
> lib/maple_tree.c:860 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> no locks held by init/1.
> 
> stack backtrace:
> CPU: 1 PID: 1 Comm: init Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  lockdep_rcu_suspicious+0x208/0x3a0 kernel/locking/lockdep.c:6719
>  mas_root lib/maple_tree.c:860 [inline]
>  mas_root lib/maple_tree.c:858 [inline]
>  mas_start lib/maple_tree.c:1402 [inline]
>  mas_start lib/maple_tree.c:1392 [inline]
>  mas_state_walk lib/maple_tree.c:3861 [inline]
>  mas_walk+0x4e8/0x7c0 lib/maple_tree.c:4980
>  mas_find_setup lib/maple_tree.c:5924 [inline]
>  mas_find+0x1cb/0x340 lib/maple_tree.c:5965
>  vma_next include/linux/mm.h:865 [inline]
>  validate_mm+0xd2/0x470 mm/mmap.c:301
>  do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
>  do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
>  __vm_munmap+0x137/0x380 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f36cc8e9817
> Code: ff ff 76 10 48 8b 15 10 36 0d 00 f7 d8 64 89 02 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 35 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff12a54cf8 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f36cc8e9817
> RDX: 0000000000000000 RSI: 00000000000415ce RDI: 00007f36cc6b1000
> RBP: 00005613cf216bf0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f36cc6b1000 R15: 00007f36cc72a16d
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> 6.4.0-syzkaller-10173-ga901a3568fd2 #0 Not tainted
> -----------------------------
> lib/maple_tree.c:816 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> no locks held by init/1.
> 
> stack backtrace:
> CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  lockdep_rcu_suspicious+0x208/0x3a0 kernel/locking/lockdep.c:6719
>  mt_slot lib/maple_tree.c:816 [inline]
>  mt_slot lib/maple_tree.c:813 [inline]
>  mtree_range_walk+0x602/0x940 lib/maple_tree.c:2976
>  mas_state_walk lib/maple_tree.c:3868 [inline]
>  mas_walk+0x393/0x7c0 lib/maple_tree.c:4980
>  mas_find_setup lib/maple_tree.c:5924 [inline]
>  mas_find+0x1cb/0x340 lib/maple_tree.c:5965
>  vma_next include/linux/mm.h:865 [inline]
>  validate_mm+0xd2/0x470 mm/mmap.c:301
>  do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
>  do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
>  __vm_munmap+0x137/0x380 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f36cc8e9817
> Code: ff ff 76 10 48 8b 15 10 36 0d 00 f7 d8 64 89 02 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 35 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff12a54cf8 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f36cc8e9817
> RDX: 0000000000000000 RSI: 00000000000415ce RDI: 00007f36cc6b1000
> RBP: 00005613cf216bf0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f36cc6b1000 R15: 00007f36cc72a16d
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
