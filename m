Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A04639399
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKZDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKZDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:14:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704F55ABE;
        Fri, 25 Nov 2022 19:14:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ3473s019611;
        Sat, 26 Nov 2022 03:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xiYn2n/DGqYAvLdOAGiXvLWwomNeDtPARyoaph2FIAk=;
 b=dhlARISX6B4015+qQZgT+d+8LCC34nbEAALRUoqiCym1jSazEkAgSLZUTP7RZLna24vy
 AxsCOJpHZCySTAb/anqUM/D8p1+nappZVODmqpcM6W33wMtO5Y28pTEp7AYw5T07SD9l
 Ezetaafb8YiNpsj6tgnFAY+Q5au1I4frniSBInj+0lcwFJsMqfhThGIPG8ZDSdwl/zNW
 ixtDITnILc8kieZh0TDcgsBgwLyskMBvDnsW7UC+QoAFJrpGsl8tL2HF6KSGVARHSXMI
 amq1VBVyNxyh7sutjOJUrYNyTz3iuu02FX2Xd/5vcUs3ydl7aRnNPi75Hdm/coHRJdZj qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397f81xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:14:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1X3lb032163;
        Sat, 26 Nov 2022 03:14:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3982arvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 03:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL/g62MGhVwpTcShenjhQUdLzqxa8n+Lg72BPfhDP69IIER/0OWfCc06uBCEBSyt7ZixEyf2NBrWO/soYG8v+FybwbOQPR8ypJuqFxcFftTqkrv8FzdtmqA/pPF1G3dHvFtWQj2N6DUKcR+ES7w2ijKA4wqrv9ajcOkUzqt1qEF7Lmxgc805Eu1uy2YAqrPS8eNjHORTPgHStCI3MXBeGwsaqS2kmu8/pGbviBiNrFtC1Kd/M453jPHiysXhz33D99ekm4ed+wrGta8gbGk1ccN5SSBeQ04LHcMybJfUmERkuQKVA80ydfi7Y9u1usIkFLmJwI0ko7BTUwX0JGScFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiYn2n/DGqYAvLdOAGiXvLWwomNeDtPARyoaph2FIAk=;
 b=FlJJXapZeRmiEGxwvw5iA5RcqSMnf+JnFycQxLKb+p9h+O5SOFwI1fat1pnzR7iAk0i7kDy49TTf2IRdZPTtXuYMl5pM6R4xnJUGzDOHXQIjkxiH4WfBQTKmJjeRBh31nEDNHEeZb8LZ7xmnlyVmN0BbEGaDQiaWVR/QovuyNPAzz1js1yAzlUHfMEgRREqMeb5jeXvCQWobLN1SYkKPCj4ciNA1U9nDdSmlPeAEhVF/9IjEIVp/nnvzWpLsWk2sTtbKts9PEx2QyeVNYEvoy07+N5+oePK6ssztFgwnazbl7f6bGBiBqT4Bsy+D1rYNb04L2vrQICMqbk7qKhEURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiYn2n/DGqYAvLdOAGiXvLWwomNeDtPARyoaph2FIAk=;
 b=G9B3jp2BIdLV10dokhWmgURsEsAebI7xJy6rbYt1CzcYba2JwZ+nASlMJXWEoyyL6+oIIWl3zYDE2fwMM+r3gRChGXkgb9QxQT2sZwEmOqRh1b90TTndZ8sAnmg7zOAv9Rz2PRMjRy6Ssw03Q0vgph6Up0UEqlmvdedPwTYfKWQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 03:14:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 03:14:04 +0000
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, dave.hansen@linux.intel.com,
        David.Laight@ACULAB.COM, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCHv2] scsi: Fix get_user() in call sg_scsi_ioctl()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qpqmmq4.fsf@ca-mkp.ca.oracle.com>
References: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
Date:   Fri, 25 Nov 2022 22:14:02 -0500
In-Reply-To: <20221117232304.1544-1-kirill.shutemov@linux.intel.com> (Kirill
        A. Shutemov's message of "Fri, 18 Nov 2022 02:23:04 +0300")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:208:134::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6b1a8f-d2d2-4bb3-0951-08dacf5c45f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IImRsHBoD2pD92Xb8UeO043+Ml9H6iNl16UqTNQF9+isQ5vONpmXM5mmA/62o2nW5n++uLURW7OnQDSl68jIIv1CHkLKCmUvoDWOAJYAWaE9FtLLRBwYRsFBLDOFY72FHmgiocwp1uBoPE51HO8BY4TWbwja2OPhz4nnb4IjoLQs6GsNZDcty4TTvkTAgM7FgE55PdiWpQWloyFbRQZ5bfwTHg/IwPnhNCM24P3N6/ouyeI3jskmq6n/WORqHFOwnJer7Z+/ECeeXAFA9nLL19o09uqimKtG2Jo6SFml4iDW8D3VrBISD+G5d+B20kRUHWvIXIOYeO0fEa1ntMruBy5KllBoIxIOsu88KSUG2/Mjc/pU3ra0YBQ2aL/hIbMup5kjRoHLp7u0YQV87zVQW1r4/vgmmPwRRiCqXng5nnkE7iGZ1IVQr4EirBPdCbDX6zx4BOKNesv6ljDl05gjuCFJdSN+6wadwKBqUvHO17kI7JAFBeI1fFfewx87LdqiDBCtzfS+2OsuD8MfH8IWcY8ESOx22oyeT3BwdNeEmNFVCuGewx+iQuIsXoPFAAdazRziEz2vZkJhlQHQ2ofnP1g4qlDS8g2HQglyYo2Zs6oa0jwsTBXu6pv+DwdoLapN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(6512007)(6506007)(2906002)(41300700001)(26005)(86362001)(558084003)(186003)(36916002)(5660300002)(8936002)(316002)(6916009)(66476007)(66556008)(8676002)(66946007)(4326008)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqy9XC2gkH1nVIkNc9Q6Y8ZK3FoQXm2+Y0rBOu521m2u1BJnlxtuYGOLockE?=
 =?us-ascii?Q?80AkUQPUvCWtyl7T1jZt0qHi/BcdtT3j5unBGvS0xjsblXhVLc9PrEQdqukG?=
 =?us-ascii?Q?gYwqSQTG9P1rvBCCbGf7ZwZqR1gwcASuq/CunwsJGu83DQHf+Uvc/ibjXyza?=
 =?us-ascii?Q?0uSlGhGZ4Wwv3EqBvc2PBf+S0o3r3KZxSMIg9JQVYeZo6YywfqjqQ23CFndp?=
 =?us-ascii?Q?PPfFHonU5liMKO/kadDX1mRqklI+IJUH8aqQQooxdJJiJcyCCOFp4LdFXXEn?=
 =?us-ascii?Q?RSCOSbEmu6rBxhZj6N6xRnrS4D8y+INpTPGSN4rnsS+Tchuzi+iGDcKbY49X?=
 =?us-ascii?Q?EAvM8gUozlCHfcWKq6Q9MSBrd22kcr0BZAw3nswKc2eCWnT6L0PdnkSB5jjx?=
 =?us-ascii?Q?34Y/CvWusokeiUxNeyqBTy2Uh5L0r6Cc2xwP1MKA5XcXCtDo2F+btPI2CE+Q?=
 =?us-ascii?Q?CLbaWfpiM9F1Tjaff799zvZXBRLDLDfDoFD7UpqRtWGQ3Qe2cDDBUvQ2rfZ/?=
 =?us-ascii?Q?+QDuoU2IBA5IHypl6QEXOwPK3qQ/87qkj2IlD5M+IUQ9UV1xdZW+l9+WLAIv?=
 =?us-ascii?Q?ZQup3sVzyRbGe4ur1lsb8mGI7WWiE+/j/UzNJqTCh5S6U4eEJeD+k/tdbwcq?=
 =?us-ascii?Q?h8p9lK/mLs6zqo8wzTl47bUGIM2uJlfulxd7Fntca5BnFCLz4fcCw2vWRG4b?=
 =?us-ascii?Q?PHHl/oPEBoMwi6FypOdWPvR8lPs+dpVt0dBE6srI/DfrtiQLCoAliuRMVRxZ?=
 =?us-ascii?Q?QALg/hLPrANBKQF3o/a4pt/tijWIQu6eq4dmMLrfnty73n0PyPTDLzu8+Glr?=
 =?us-ascii?Q?Sf8CCHDi4XAQehNRCuQVBBNgtQGunXsWGZuWDlJNB2RswknKezPuCYdnfsxW?=
 =?us-ascii?Q?Iu5j8gSpr6T+6ZoIotH2QCNSChpfcdmM3GbQIpuru/zHFCMcPOllGcDimeex?=
 =?us-ascii?Q?wsaWTMk5VbtnwdbeUU0xVUkZ4wBFMBGFK8o1RSiLlyH3PejnH6sZ5BdiNzd8?=
 =?us-ascii?Q?Rq0+6U15aHHPD3t3wUednp6hXvMEtCWLZWyFfUeI9p2Idsw+R1lHo1evMqCP?=
 =?us-ascii?Q?CXgqjq/2Iwz6hDBLV3Rss99hsL7awuvOd/3G50xKiL57aP1vJFLOGQ1Kb8Rx?=
 =?us-ascii?Q?adbPLjyRy0wq7xWqqsa7+3T+trI3+j5L4/rqJkKF0OHftVK9+VWUwznJQ8XR?=
 =?us-ascii?Q?QU/if8tJfJTQ+qYIJfC3dRIYbXGNTM/fA8LB68sNcxVZ3GlgknXZGu1e8uO7?=
 =?us-ascii?Q?B7e7XLjmtjujdJGfXOvyHbbHYj2z7QQUwsC6HpQ3734/LBIhhPw4un9Z8BBq?=
 =?us-ascii?Q?drA9+U5DOdI/ZNgPOgHXpOd0G6zlJ6AZPYtdtqItCDtVPpWB0o3hYkNC1DIb?=
 =?us-ascii?Q?qeHWTzqetPiAUExTmbxap35Gy1HAEdMvfmr6FU/jYGlGneWt8KKu31nlgOEP?=
 =?us-ascii?Q?oXQKbVCepV1Zy+JZWKxbw5fRaXn7vsNDlBioAwbcX8bLWcJiDrRGNqxPurUG?=
 =?us-ascii?Q?Kk6KP179q2v7Ga5rEh5UFvvrhjxS92ZQ0zdqpWtta2GBA5EOh62i/3Ep3x7C?=
 =?us-ascii?Q?v9MjdABtIsl8BCZohzvvFlOewn8jeONpyvpYOniafYBragdCf/TFcHhsCD/D?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qfVYXNJ/YPnLVT5zwItXFHc+dD7egN5Csk6jvGXJotS3b2/mLS9c4JT3OUTe?=
 =?us-ascii?Q?nqurD9jmxAzujBk/Z9TnGuGMMj0XerQj6VJ63aGHZA/tE0D4LDnyp6Ek3H2x?=
 =?us-ascii?Q?/YZRQvZcR04idyMsXJdhIa+SoDUg/bnQ3GuvM8qK/oKT1CA+Y0E80x1CtAc9?=
 =?us-ascii?Q?/QW4aVCsCIeDq5Tk6NjsFBzOpXmUoh1t43mVFNtFC9sid8el6amaesCK6pa2?=
 =?us-ascii?Q?R+KVxztOZGcZV0P0wrSHtKfNoHPtZAuCJkCcVhMedyOjCoOFI0+4jujcW7pP?=
 =?us-ascii?Q?i/7u0m1rUzbo4aeWPqUuVSV25+U0PwcZsAzRj129JxcIK7t4z0mdYQHTther?=
 =?us-ascii?Q?ru4Wqi0eVgV85Z6dLbxi3c1QJxts3/yYORdN/dm5IkJt85EPaByuO0bCId8j?=
 =?us-ascii?Q?yNVcZdSVvtVQA9ZOGfmD1+seEhcBg7OshRo/nEZqDo+6zYpRvISfuw78qBy0?=
 =?us-ascii?Q?FGDolFnwUh4HBMAd71N9EhMwb/e9P3vIEjX6h9IoX+z9M+1bzEE69z1KJ7lI?=
 =?us-ascii?Q?ggpbpPHIoR44CLQ0XCBbCC7eiNq7kLPvVXO1bhE+hcinWB1/2PAj+Vv92+2W?=
 =?us-ascii?Q?XhFyRvRhFrqe+c7TGHTjCj2JN0MjAECnKucznXsRo2gCHCCKUD1wQsKOQwgO?=
 =?us-ascii?Q?mPS/T5mMaZ3XiXyygkKlOMyVPrST8DBGnjMuLqK2UY+DsQVSvGwTk3BXfnzE?=
 =?us-ascii?Q?YA4EyuoNncstovQdiBAfaGyeAKq021YAGmnn44gZDpxdd4svvZjhTDGG75M8?=
 =?us-ascii?Q?nqX1PQRG8VJnPCN9qmahkdPlvjgPNSAwbdOHvEY5kGUo8ORlqjC4xrHwZgBu?=
 =?us-ascii?Q?GiNj/lZpGaKASbsYVJTHHbWNKenN4hnEsfOcvaAptKeUnSPCJ1cN2txB+rSL?=
 =?us-ascii?Q?xQntApPzKAL4DEDKJT3YKPzoQYggiS8B3alw0y6LlR0wlgloAV2GCO9mL4Tn?=
 =?us-ascii?Q?BrFctcfrL/WpLgQWG19+ZopONVXF+Mm3M3C+8lSniHs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6b1a8f-d2d2-4bb3-0951-08dacf5c45f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 03:14:04.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfYcSpNlZfUeC86sZw5L3r/1efjK6Stzum6SxJN4g8/D961Bj0u9IA1MqRx9BBI+UMAB5+iubpCXCC22gPb3wtMgyNSwxoCv4INNbCxLErY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=866 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260023
X-Proofpoint-ORIG-GUID: bwDZ955fqu76DRlRpXZzdYBfUKY9KZeh
X-Proofpoint-GUID: bwDZ955fqu76DRlRpXZzdYBfUKY9KZeh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kirill,

> get_user() expects the pointer to be pointer-to-simple-variable type,
> but sic->data is array of 'unsigned char'. It violates get_user()
> contracts.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
