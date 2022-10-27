Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E360F43C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiJ0J7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiJ0J6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:58:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EA7F081
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:58:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R917XX020261;
        Thu, 27 Oct 2022 09:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type : cc :
 subject : from : to : content-transfer-encoding : date : message-id :
 references : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=L+9XOmACLht5QP2I1utUuI7THJOIQPdUVyUh6XlpLtM=;
 b=OxgGWw1e/L5JyZ/L6FH/MW90oQZveFkXBTPNLLb2TuWY1V6u0IguehMTQmi8TLJkUhAV
 XXx9REJmdb7ChP7Q4gigKsn2/OkwDhBzaFPM/5QOvzLJgWZew9YfY3OuQtgerwxc2dD4
 vFrmncvwAor7fPkGLKDd8e6zbDUpNfzBBIkBeajSgUQShQCj7eSdG5lyPKpMjzlDXQZR
 M8+2Y5EWxmIJjAtUhT7H02ZDRhig5nWGftIrZy5h8TTCjDAT9lfhcKjP2Qso4Q9jLa5E
 /Y1dXK64eQAK2hmkZ3newQFOy9CpMc/b0aKKvgHJlUetwQlLkd+bgV1I6iztRCOrOXC4 dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7sg4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 09:58:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R7HvEB009606;
        Thu, 27 Oct 2022 09:58:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaget8gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 09:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUiS9lsmv0QBjXRrlzi6KIxDBncZZkpdtVoNB5Vb6trSXbOyz9g5TcR05P1HOhGqRbA1vWrH/qxoQ/YSsASSqXGbDw1rGLfmvllRi78skf1jY/vgZzdiEJm3wa1mQmqrTei/sUkeGabYsLot4uYUELFhaLiyVbxx6Uq3NtkTxvSDqLpadRq2DS1eKBcaHdRqDDo0IMJMrTwxFN/VhSz/+fNLVamvGwmRUGKzuuFLoywKw9k/KF/xptsZZs2NGcD4kZlRreu4ceKFuH4fbTZUbD5eT/sjDlPuXHQqPpdAcImLl8Y7AJiF5KcCaO71XZ2uL+1ofFcLwjNYz03EjBZ0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+9XOmACLht5QP2I1utUuI7THJOIQPdUVyUh6XlpLtM=;
 b=KZxXOlUoAvLhpTID7H/yYexFfdVrpkD24IBErQprduyn7Yq8fcCtVn5ZteoeJ/f+qRayaj361PHg/YgLEDtCY7v4facv6iLlWxbrnB/H0rddvda366Yd2t5/sa9Z2OZ3hhKl3tmYigwa9TwSVp4ljPBYyXW5yGQwavh+QfrO1pdOJ77+3eva3GfIY1luhETsU2U9GlZSq/25AjOvonP8cR6DOqKnXdGIYe9KBTIpOHJkGRRVjUIMS5ZWETtaaaiNijOuZ8ZLN0/HGwg28wYhf1rOFPcViVVPxeeW96aT8DZZJp5uBo74AYof0Uk9VVvqXFwXQjMniFEsO4VplEiGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+9XOmACLht5QP2I1utUuI7THJOIQPdUVyUh6XlpLtM=;
 b=sHMJWw2nnZOaSjTHo7/v7kbnMBJUQ+4aPigpjyW2Cez4fhnVItGtP/nGjGTJgYl5+Wi8xZVjfodoOZazTW5v68yeHhBrr3UC/R1JOOQFa6qX83IZsHG6Y4GW9tNUAOVIUthdE5lUpYfOa4aJUhiO1YCiRmuW3N9zotNVOMJRyN0=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 09:58:03 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::ab16:a248:e8a1:8f17]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::ab16:a248:e8a1:8f17%5]) with mapi id 15.20.5723.026; Thu, 27 Oct 2022
 09:58:03 +0000
Content-Type: multipart/signed;
 boundary=252c76f8d031a49761ce5a41027e81479ffd8306ebe67cb05cd04a5ad947;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86/alternative: Consistently patch SMP locks in
 vmlinux and modules
From:   "Julian Pidancet" <julian.pidancet@oracle.com>
To:     "Borislav Petkov" <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 27 Oct 2022 11:42:51 +0200
Message-Id: <CNWLW5AZPIFG.15HUZ3CU0R36S@orcldev>
X-Mailer: aerc 0.13.0-17-g4e3fed7ea030-dirty
References: <ed7a508717bb8bec6273c2740418f0dc2df9eeba.1661943721.git.julian.pidancet@oracle.com> <Y1l3lqPTNAcqwtRT@zn.tnic>
In-Reply-To: <Y1l3lqPTNAcqwtRT@zn.tnic>
X-ClientProxiedBy: AM0PR02CA0153.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::20) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: bc23b629-7198-4ada-7db6-08dab801bd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0KttjblDkVDsckedkUokUYUUil67uaUAar/10GAgbufOKVF2ynb5lhgViQm20o5YgwFdTWH1XlDpi4Mxw1M9SlW9wGt+6wXgcSNUOra/ucXIvjzUWDTKCBqUiWCbRVP6IByGneDegx35Yl5aqIQYCvvX04HyXTj2L28i84+2eEoTvfO4JiWmZMKTrOCly1uMh5wOSQpjL1NLwHLm4fidBMMgJ3pEMifStieGLqD4NYO0X6ItQl1e1Eg42+MHxbxzlHd6SXNVDa6NrwbOyyeJLD62XSVamhPtycLwBCrG5SnyKZYlJqmPEjUTUyIZjm7dCEHWTcyMtNHnN7GiG3HEzaaNfY3t1C+V+Ey4HWi56MqTWNeJ5Jrr7DUeJhY2F5Wki3LWxqiZFarYsac+FSWBhe4JyKaaQ/oGrdy2U0MPX14GMd1t4UTTBxPUxU1e5n7Od9ufLc9wivURHVLvtRwF5UdF13UEatZuekq/KHhDCTm/JknkmJCG2Tdw1I7/gT5jleYDfYxPJ8gr37y3eHEPapkZDu8OibtxWYjMyCk+xo8PmLPCK5+DJEaH7jXfk9i9uOVwYgHjk037N6Q9PCDi4xx9kdQQ0Dzyt1mVXn2D/yYPpTbBI2wWjUY6NbDLCDOwIYAxTvuoe/814b9vpk90snRc2IIODgtPzJKNd5ex7DQbKzY1NeM6OTwelWtjYyMNuXMqvyFkv0i/44RgdDkEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(66899015)(33716001)(33656002)(8936002)(478600001)(5660300002)(4326008)(2906002)(6666004)(38100700002)(8676002)(6486002)(86362001)(316002)(6506007)(186003)(6512007)(41300700001)(9686003)(33964004)(6916009)(66556008)(66476007)(66946007)(54906003)(83380400001)(21480400003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXV1YUR1NGhZK21HNHNURXo2N05XVlFzTUVaNkZmZkMySWpvRnNPQUF4VkEw?=
 =?utf-8?B?RlFjZXBmTWtlRll0ZnJBUWZjRVVqZldyUjM3Y3E2U1EzVGhQZ0ozT01xcWRy?=
 =?utf-8?B?UEVCTlJBZ2Ric2l0dG5JUGpVZmI1SjBqOUpzVnU1aWhVVjN2WDRRQytDVTc0?=
 =?utf-8?B?WFBzeitDTHY3Ly9EckpZTjJYYVZUMFdrZ1A3Z2xkVXVieEFJMjd0OG9BOGwr?=
 =?utf-8?B?NkFlOXJEa3FGdXJxZ0xqcHBwOVFpakxMT0lzN3B2aytrUGc5QUJkSWUwUS9s?=
 =?utf-8?B?T1kvOXVLeDBtSjViNXJPaVBsam1XSWg1QzVHZlZ3SjZ1WGpCUy9ET0o1cXI1?=
 =?utf-8?B?QTJLOElSVXEyWWh2N1NIODhVSFZjY3VoR1UyOHNCR2I5NzdwdnJTandML0pi?=
 =?utf-8?B?bHNQZEhnWUt6V1NFOXQ4NWZQdFczbGdzbmF0enRoSEpMMjZHc1o2bC9ySGdG?=
 =?utf-8?B?VC9OQ1VhM2t0bnNmOFlTODV3SVdwNGdoMmJIeTJMTEhTMUlXZURMb3JkemVO?=
 =?utf-8?B?K3lydlI0UFFJZlZ3RWtkQnYxT2lZOHR0UUEvQzNabzVnbXhMVHdrdTJNRlZy?=
 =?utf-8?B?RXdBSWNKT0c4cVNMTmIwY0xwbUNDQm4zUmpVWXhmd0I3Rzk3em84dGhSTXUx?=
 =?utf-8?B?cTRSMXFyT3VJTVMrNklRdlhkeVNQUXluUUZPNG9YYkdNOWJMcm03enZmUk1q?=
 =?utf-8?B?WE1HbWVVYWEzR1JyYW4vQWtIYnZQMXRDRGUrYjhnWlJObEdoUEVjQTNSL2Ns?=
 =?utf-8?B?TnpWWEtzRndvTGxNdkRxb1lLRFJzNHlNSTNIT2lUL3l5MnhXS1VwL0drZHNm?=
 =?utf-8?B?L0hBQWxtK0VCM0VyUFlQY2xEcjMzUG5ZdVNvcjc4T0hjZ01rMm4zYXp3ZjJn?=
 =?utf-8?B?eXBtS1JCMHBSWm1NKzF1QURpT3dFZThtTWRQNVFWbWFBdkdySTlvS0F6WFJX?=
 =?utf-8?B?eUFmdGdOa2dCUS82WHBJTnUyVm0vbUhVbzNMYUE4S0pVWmlDSW1XbmcwdGN6?=
 =?utf-8?B?QmpVaDU0YVNmcTVsZENiWmNZcjRBandhOTdKc3IvYjBRZzN2S0I2SzJmWm5I?=
 =?utf-8?B?QytYUmhXMFBmWjdMQnduS2ZRRnlJMU1LUWtoczkyaThSVzhEWm9kMEZVamh5?=
 =?utf-8?B?SitvQjVobkx3OTc3MTlTTGJLRVJXdHhaTDZsZlZVQ2VzbTNjMW9JZXlleVZv?=
 =?utf-8?B?THJSblF4MU80OUpkcW1uRU9STXg0M0lnaXdjVlJIUS9mNGJzN29WNVhpcW5Z?=
 =?utf-8?B?c1lCSXBibU5RYWxBRmdobHdNQndoOGVETy85eW9uNkdTVzUrditZMTlTZWtU?=
 =?utf-8?B?ZjZralhrbS9KTEFveWdHRlQrUlJscE9PWjNvaTN6a2ovM25JbGFIR3dkd295?=
 =?utf-8?B?dytqTVhCSjM5L3psRmpMSUNWWHhsOTdoU1hPMXdDRWhhb3BCcFJWdzNZNmZR?=
 =?utf-8?B?M3ZzTDI1Tks5d1FmdHI0ZEhBd3hRTm41bnExOUZkQlkzM0RvQlFjU3Vmbnlj?=
 =?utf-8?B?c2xBRzJaUlR1QTg3ZTdJYnVWMzNTaU0zbjlhclhKUjNGNEN2ZFVWQy9LNFVa?=
 =?utf-8?B?dHRheTZqc0xvam1ibXJGQ2pwMnpHNURjTzVLN2ZTUC9QdXEwdWFxZUtBM2tL?=
 =?utf-8?B?RkhHdkk0QVdiTWhiRkJrb2dmNDJEQmt1UDV3S05XcEtDeUI3OFJocmR1aWZk?=
 =?utf-8?B?YzNBZ1h4S1V0enMvWUpOdC9maG5sSUc1anplMit4WDNCNk5La0c5NFFDSFA0?=
 =?utf-8?B?NFpoanQ0NnM1dXpEbFR1NjVZMWsxSVN1M1gvOVRVV0dXMlE3ZSs2ZFRYV2RF?=
 =?utf-8?B?Z083M3lzL21IemEzL2QvTFk1QnVzcndqQXNMbWtMTTBHdlNtejJIc0RJTXpV?=
 =?utf-8?B?RkluS1B4MkRnOTQzc09INE4xTHhLSHNvOU15Q29wcjQ3eGFmd2FOKzBmc3ZG?=
 =?utf-8?B?cE9RUEMxMEMvQUJ2b2F0Q0psNm14c0MyTlFIT3h4dUpnYTJ2b2w3SU9MbE9u?=
 =?utf-8?B?ZDRSbkZpd3pDN0VybDVoRGtXdzhFMDd3RVNPdndKcjlTS2p4eU5EOXJieldv?=
 =?utf-8?B?NnNUUGd6SEJ5ZlY2cHBiZDRsRnYxNkpWcmNpNmJBbG9CNkNGWndJTWdFQjFQ?=
 =?utf-8?B?a0VYOWpLZm9KR1pFUjhnU2Jpck5ueWp4eExLL0lHSW1WUUdxRkxra1QxR3E5?=
 =?utf-8?Q?bIrm1C0MgrejeXTGstAMTc4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc23b629-7198-4ada-7db6-08dab801bd18
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 09:58:03.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUOclGyfY7oZnsSq2/0MnOi+k8ehCh1rj+2PD1Z29CO8WNPazyR8k3egqeYIRr7g0wQp3Wwd2rnySoTw3jqBgd3CIfWgBuY3QnVeyXgb6D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_05,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=968
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270056
X-Proofpoint-GUID: cdHJDjopVFioVhZXVlrzO-OoL1P32Lx2
X-Proofpoint-ORIG-GUID: cdHJDjopVFioVhZXVlrzO-OoL1P32Lx2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--252c76f8d031a49761ce5a41027e81479ffd8306ebe67cb05cd04a5ad947
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 26, 2022 at 20:08, Borislav Petkov wrote:
> On Tue, Aug 30, 2022 at 09:42:37AM +0200, Julian Pidancet wrote:
> > The alternatives_smp_module_add() function restricts patching of SMP
> > lock prefixes to the text address range passed as an argument.
> >
> > For vmlinux, patching all the instructions located between the _text an=
d
> > _etext symbols is allowed. That includes the .text section but also
> > other sections such as .text.hot and .text.unlikely.
> >
> > As per the comment inside the 'struct smp_alt_module' definition, the
> > original purpose of this restriction is to avoid patching the init code
> > which may have been deallocated when the alternatives code run.
> >
> > For modules, the current code only allows patching instructions located
> > inside the .text segment, excluding other sections such as .text.hot or
> > .text.unlikely, which may need patching.
>
> Is this something you noticed by inspection or is there a real failure
> behind it?
>

We do live patching of the kernel code at Ksplice. Before applying a
binary patch we have a safety step that compares the running code with
the code that the binary patch is expected to modify and abort if they
differ.
This problem was picked up by the tools that we developped for this
purpose. We have a workaround for this internally, yet the inconsistency
lies in the kernel, so we thought it best fixed there directly.

> > This change aims to make patching of the kernel core and modules more
>
> Avoid having "This patch" or "This commit" and so on, in the commit
> message. It is tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > consistent, by allowing all text sections of modules except .init.text
> > to be patched in module_finalize().
> >
> > For that we use mod->core_layout.base/mod->core_layout.text_size as the
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.
>

Thanks for your time looking at this. I'll reword the commit description
and submit a v2 shortly.

Regards,

--
Julian

--252c76f8d031a49761ce5a41027e81479ffd8306ebe67cb05cd04a5ad947
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQTd3Z6iZzTygRNy7F4XFh3U+bgUcgUCY1pWIRscanVsaWFuLnBp
ZGFuY2V0QG9yYWNsZS5jb20ACgkQFxYd1Pm4FHIOogD/eQAPPmCZ3btzLC1jMnt6
6YDKrlqZUxBtqCnabRlHzOYA/1/pRMC2EobR96f+OMG7FdHJ4557ERuFCfH5Sr/r
a8oI
=Pj5Z
-----END PGP SIGNATURE-----

--252c76f8d031a49761ce5a41027e81479ffd8306ebe67cb05cd04a5ad947--
