Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993E700999
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbjELN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjELN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:56:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F403ABF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:56:48 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDs767012349;
        Fri, 12 May 2023 13:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KTDOx6h/UMhmTE/sSTcdwVcxe//C6dpveBF9KDxqiM0=;
 b=pi+XcUh4SrrkGjQKPoFL2yz0+tNGlls0QQfgea/X5NAbj/iiUAfkfc2zTftfZ6X7t/BD
 y5nXyaryUoJ20KjDm7EXzWqGae6LN6vBK4FN36qB1euYnf3jtfpxWy94yNXOnVlaUELp
 W8SyMosW3HIeG3wX3VfIDLl+HEBs0zxdR7Wbpqhyex6fRQblH56bChDLQHLSTVmmffaw
 ZmcEnhwgt9VaF42qqPyL48dIUKBu5eV2Osy/Rd9M+uFKOsRuk29WHBG883czbD4cR40D
 YR2YDBNgnY2a5jAN3L+SabAVvnLv+HQcz+2+Ks2SC90SYLVI/m+nOgs2UeQ0WT7Xg2Do qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77djj4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 13:56:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDFDFv011967;
        Fri, 12 May 2023 13:56:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf814v751-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 13:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKla82bbQYZsPyXqe1OtxzI+uJ7PP6OeGQmDFfcNi2O9dfdex7d/o2TjtZJBhbK/6NVi7g5A9YrRAztj9qj90+gh4K+yRm54mE8rsfbLDauK0r9pHHsbEx8adPiY2It9m8AE6vZdTePqw4hkhFV9Tt5dF4hfw2lvUig8MTK6pcFofThwjZPzuk7LUCy75JeeuUxJBha828AknYgrgg+tnvDKxJ9BXysFUAL9QnXG20IAgI5U9rKp6ODAkXM5dVYuanODS/mMEWmbNJ3ZEAtoT+1hMhQk28T3QI2KDrdJt5XPfL9cM4Z1A/U615HyFOfGcclqxSuk0QAaENTm5aZPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTDOx6h/UMhmTE/sSTcdwVcxe//C6dpveBF9KDxqiM0=;
 b=VY6CQyalLUWPOxms488w8lvhlO1YVDDDgLAbwzRYiC6UOu+FeVYK1fmDspHxPm6J1hYl0lH1ky3sy6G7j+/Pb+g70dYZIZ8VJbWPhB7SxQTf+plr3S+wkOQhNDH4wVy/M1U2sWfrGXEZBty+BYDwUMTrz3+T8CxFYDFvQbDmvjoT6k/HyiVR6iKHTijsUgwlr8ieGFBqyqaQcaRkZ+fnUemm93KL7kL55V3doxNERYIQ0hb9HOBlaKNPeIo+nLSDUmoFRf4AJBwhPGZ7oUPQF7RK9VnxR76aB/vYKD4G0AalVBk275+e0D43UqALctP0Du3OnYpJLGDlAyoZnyJ7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTDOx6h/UMhmTE/sSTcdwVcxe//C6dpveBF9KDxqiM0=;
 b=y62vAkm/6GD6zGOAOi702tY+doFlv/pOxzOD3F+7NCAXRmgSgmtHmV+ZD8/KsJF4ln0a2usvsgEIW75+hreUObpfySi28MZvhK/XDFx7aXV23IX3XvwvklCgveY1hr9ZaZUxqpOIRFMu2+eEuyYs5eE5tNb44RRT+nJ+xl21nlE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.25; Fri, 12 May
 2023 13:56:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 13:56:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Thread-Topic: next: WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
 __alloc_pages+0x2e8/0x3a0
Thread-Index: AQHZhNY3bXnUQYyknE2sxxtPxlRzIq9WqWIA
Date:   Fri, 12 May 2023 13:56:30 +0000
Message-ID: <DC7CFF65-F4A2-4481-AA5C-0FA986BE48B7@oracle.com>
References: <CA+G9fYvVcMLqif7f3yayN_WZduZrf_86xc2ruVDDR7yphLC=wQ@mail.gmail.com>
 <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain>
In-Reply-To: <6c7a89ba-1253-41e0-82d0-74a67a2e414e@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5076:EE_
x-ms-office365-filtering-correlation-id: 5d80cd45-fa03-40ed-7b3b-08db52f0b036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55FwUbMxSQQ9IgJDUak+Jt2ZtaQ7PfN+H9zDJRcZx59q+5jn5REIjjwxHwcSS7lhNVEWcXs/nBR6s56EvoD2m/Kqbsi7HnNYkgME8euVB2ssNqFjbDQ6uV/PQkqkrxfzByPAXk2f3AtHe8jGEF25hsCUVDn1rgt/uq4//H9Oyz9ONd8uCxUl2bNLfrCnuUlYhQg4A1O37bP9xP8VjRBUZJ9bRjeV3CfohPohvJDjKeajLPgOtorwTgE/p1Dc89MSfZV7NvM9UDOuAFOKTwKWShItML7DJLamo68IKTFCdDFcGARwWQHH41IsACLBtvYFiP6YnfAa7c7voy12gXKbOuGIbIJKqtt/U5XkQTzZDfLDIrIAcgZ0pS0bVb4MCElnz/9C2n0iZqmQY4TvDxZ2SBvfCc0tuqeln2JTDyeytJdY4t5+QeuJZBPMAZ8+TfWnYhfqdCD4p3WtsuCST5LA9bTQHwlUOHrWOAWZJSM+PG8Vo9oc8DpZVRithAn1yDAS1R5r536x7br+xyqf97QQHwGjpk1gEDLfcMp4XtImQ3JjpmuH7tIY1rFT7VBFPdi1GeBLJMlfPkQR5MjbciibudxIgeeJx+db4s3FGo/QCRjRWEIgSWvlE44dX4P7iIgDCtz2ZzyKk/xCfGUdWZ2zbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(38100700002)(6486002)(38070700005)(54906003)(110136005)(316002)(41300700001)(71200400001)(45080400002)(36756003)(478600001)(86362001)(91956017)(64756008)(66446008)(66476007)(4326008)(66946007)(76116006)(66556008)(6506007)(83380400001)(26005)(2616005)(186003)(6512007)(966005)(53546011)(122000001)(5660300002)(8676002)(8936002)(7416002)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JcZZwAPWYCujUAwDp5OsfkOCS3tc57hy41U1FK8q0iKzfrYYN9ITX9fKzrVJ?=
 =?us-ascii?Q?ADahWX3u0nHUr8YN2Lqjjbxw0cQN08xvdchdjz0VEYJovGjkULyvNpGF7Y/p?=
 =?us-ascii?Q?qzJY7a16RragyW9InmQ+puIzCcyies9Tm5M2+J87rpNBtUAtOUnLJ3uPwSML?=
 =?us-ascii?Q?I1YTOyh4m9QaUK+bYW2vNKL1JkCIBxgszmi+Qf7mwVYH/xA70FAK9zL2xLL/?=
 =?us-ascii?Q?8PUb5FDS49rkk6LYpdWfijworA8aL40eZPGMZ+ZHWUg3NYZZrgWB8cBrTlW1?=
 =?us-ascii?Q?P/dfUoHjEXqSDSIF5EWUsT5SQDTWcN5v+Zg5y+MgE1qVBJyl/n8VugVtS0rJ?=
 =?us-ascii?Q?gvLC8gXruMsyPk+0vg1511WIPNZf5RRNaNs6yzF4cpd6cV9mAVkBdf3t/g7X?=
 =?us-ascii?Q?PH+aR37yToOn7+sVjDZP2lan5KLwwpp1BsEBsMd5PNQcVwulzVwuvVn2UvE3?=
 =?us-ascii?Q?dt8NCewb4I3e6Ch+tKfbcEegAMb6PAc2Oy//5nNh82lBiQHKa3nwwYi2DYR9?=
 =?us-ascii?Q?dg8S9nyepHzO1774OWR9rj81WYGvZKvt9rua8KOzscVi4ten0CufQSgy63Um?=
 =?us-ascii?Q?kDciQEx3AZkMdMuMPFAjwlcHqKI51xqGUZCRPzdY3JoII7diOOubiZg++7Ba?=
 =?us-ascii?Q?MtimdG7OECgvDPLZoxGbI5bS0X2VQy0yFxLdoiXdyiatGmDHC91cj2w/JDJI?=
 =?us-ascii?Q?EC5hZBf2DLGr3s+maZGO16+oHlWFuPft/MTjlKqTaCcEOxB8iADPgUBH00r+?=
 =?us-ascii?Q?QNHYGoDNL0DREecP9LMyP/c9ks6GJ+1md3rZHFBk9zx6U3AQeMTrf814zjHr?=
 =?us-ascii?Q?hNPwo5nTtzOHYgYkNAi7y4lhCjPkbPLDb0iYeLtpg4xUL04Ex7yMfZ/tOaip?=
 =?us-ascii?Q?9YjNqZlrnC6wIpjyi/wdIM6p2veoNqnrS92t0Mwml4o0XKsBVfsPGtlqyafd?=
 =?us-ascii?Q?Jd5rkQHvFrjHPgr+MrvUfZYLVFRTyU4QxPP17xZNiviVC9CqmUhR5o0gDpOI?=
 =?us-ascii?Q?PPqH3z2dxpoIxGkY+kVxBXwDaYlj4ngo3Xd6Ew9ORDtUl5g5+n9zirjyqPTK?=
 =?us-ascii?Q?T+AOSKBsha1n/tdhZOtcZSVCVFRcjo/D80jXt3rS8xi5CeKVBUymoGh02PBL?=
 =?us-ascii?Q?bc8XfibzWSDQX2jQPLJ/x7UhzQrZhx2jru7EkTfLuipdd6w4dJQzuRD6caGB?=
 =?us-ascii?Q?uEhjBrgOYtbwK4B3VfXZLtmeqHqvokEip6NlMAAO6WXxHsTm31ljfXy/5YQm?=
 =?us-ascii?Q?FeN6cXjALT3sjD+7AWC/SfHSYZl6KgrgQxUnl2ac4jAKVT5T0T23w4/iQYGJ?=
 =?us-ascii?Q?LBeV6KwRmeFZM2IzcNQKj9i95It2pSceRSCEIAwYqKFd1VEas+a3XHQvJ+mC?=
 =?us-ascii?Q?EZyfl9nLMV+1u26aY3pd4OOym307TvijAff4g9TkmsHcUTFrqE9XBFS3SaSf?=
 =?us-ascii?Q?Aw8TGbqGzVyx6OACTpbqmibq+LYEYdxPdDC3bL5btnfh625WmLRVYzWVQAlG?=
 =?us-ascii?Q?bbD5uJ9r83PD0ezevZ6lPggH1nESLVboufLsvIGEGLkMtcLeghJ8iwuIFD0u?=
 =?us-ascii?Q?+7MClyGgdO8fIyL/P42sIGl1DjWt3bmrzwDlsF3MsEjSnU0bgd2DIJ1w9LP6?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD2634576582694E85B1A2FFF2D9FE48@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LTp8/azrW5ClWPaRmZHqPHmFLsnSUiWrOOc+eYZcojtzYdCUzTjCs/EKwllk?=
 =?us-ascii?Q?Yj9GDJVvR+gs5Ey8Tzi36/y+iAXWiq1bBT69X3q+AYe4fml5fxnqJz8JTsSr?=
 =?us-ascii?Q?aHjfAT9koxKx7QEwRKUwugKTdvUyJp7nd1toPiiqz5ouPemI7Vz73+R9n827?=
 =?us-ascii?Q?SJhMBhzjs8UJV9W/SI85AjGx512b2xzEK4Gfm83BCwKNqAKa5+K9vdB/khQe?=
 =?us-ascii?Q?nJiJMZrWBNm/cdOkEMavcf5VTQrt22gkZqONFRU9EDuAuquIkHg0xIkGZz/e?=
 =?us-ascii?Q?bnsqj6litybIYS0ZhjYuiVvQMbMXXIlcVEgMUUhgWmfeAo/9C7duSmdfV0cE?=
 =?us-ascii?Q?2f8H+eSqpLTsSNCkteQfscbrUVrjD0PBlAtRO4TWJIgNC0Y4PAxBg+4F5ArO?=
 =?us-ascii?Q?kfSb0bLjNmKnGgTsnTz4MusjgHbsaxqviHP4AYKke9eTMmqSpfTYWe1nhSgd?=
 =?us-ascii?Q?6NzXDOLSj6HG6N/pz6mcpt86nFm4XOEelFeu72/Vq52BzEi9U/knlI/TqiiO?=
 =?us-ascii?Q?Az1AdbT2GFYdaNkwFekgxrOx9L4CAeAI3D2cYZuSr7eaEa4h8GLgER3ocecg?=
 =?us-ascii?Q?osb6hw4AbFpYCw51HWT2FWl6i3of9KnXvZuxNDpjMzwUA5yrfUzox0yjKM9G?=
 =?us-ascii?Q?4NPFSXy7n76NuMCDfMFkKiSiS+/x2V4C549dMrfI7niMD4SVcwL1l8eydXgj?=
 =?us-ascii?Q?395nxYc3WyGtPOD0x2oaVOGBgOy2LiqItTghvCXn2hpL1rxW1TewO5MU+Krq?=
 =?us-ascii?Q?ZytyVvV8cycgtj/oFq3bFuZYlv32qBmtkNtFMsC71UaOBcFfEQmCKxBrWMyg?=
 =?us-ascii?Q?zdaCvIGxrZUKQDcyVQImiKdxWCmiNJAjMOt+sUIIo/pKyZdk3aV8kUyLKAkH?=
 =?us-ascii?Q?zEnfga/q+aPagSjrFWzPl67ZHbzeoIKW7ugVHSkh30gNhZup9599Ni8DwxcV?=
 =?us-ascii?Q?5Dzdr9xHJws5fg5lm3bYpwvWh2ZYpuaz3gWP2/OtAxs7qkwgcZ4R/OeE9/bl?=
 =?us-ascii?Q?cHgSTEeVCB7SEPgwj3dWxvWrgv/hMm6kpe4F1Yj9SpPa6FRMw8JSZi8ORzPB?=
 =?us-ascii?Q?Sg7xsDOWmx1nVw6iVMgv10amExbyjA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d80cd45-fa03-40ed-7b3b-08db52f0b036
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 13:56:30.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiOm07MPLt/rUiTHUJY7TauxLjRRC9AgbhR3Hgs8JWgUuJIuZv15Bz1WsMrQA/eq1CzpfheEA7Ov0/1z8hSYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120117
X-Proofpoint-ORIG-GUID: XkKanV7gCIA_wDgVCB0LUS1t3V7NZle-
X-Proofpoint-GUID: XkKanV7gCIA_wDgVCB0LUS1t3V7NZle-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 12, 2023, at 6:32 AM, Dan Carpenter <dan.carpenter@linaro.org> wro=
te:
>=20
> I'm pretty sure Chuck Lever did this intentionally, but he's not on the
> CC list.  Let's add him.
>=20
> regards,
> dan carpenter
>=20
> On Fri, May 12, 2023 at 06:15:04PM +0530, Naresh Kamboju wrote:
>> Following kernel warning has been noticed on qemu-arm64 while running ku=
nit
>> tests while booting Linux 6.4.0-rc1-next-20230512 and It was started fro=
m
>> 6.3.0-rc7-next-20230420.
>>=20
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>=20
>> This is always reproducible on qemu-arm64, qemu-arm, qemu-x86 and qemu-i=
386.
>> Is this expected warning as a part of kunit tests ?

Dan's correct, this Kunit test is supposed to check the
behavior of the API when a too-large privsize is specified.

I'm not sure how to make this work without the superfluous
warning. Would adding GFP_NOWARN to the allocation help?


>> Crash log:
>> -----------
>>=20
>> [  663.530868]     KTAP version 1
>> [  663.531545]     # Subtest: Handshake API tests
>> [  663.533521]     1..11
>> [  663.534424]         KTAP version 1
>> [  663.535406]         # Subtest: req_alloc API fuzzing
>> [  663.542460]         ok 1 handshake_req_alloc NULL proto
>> [  663.550345]         ok 2 handshake_req_alloc CLASS_NONE
>> [  663.558041]         ok 3 handshake_req_alloc CLASS_MAX
>> [  663.565790]         ok 4 handshake_req_alloc no callbacks
>> [  663.573882]         ok 5 handshake_req_alloc no done callback
>> [  663.580284] ------------[ cut here ]------------
>> [  663.582129] WARNING: CPU: 0 PID: 1200 at mm/page_alloc.c:4744
>> __alloc_pages+0x2e8/0x3a0
>> [  663.585675] Modules linked in:
>> [  663.587808] CPU: 0 PID: 1200 Comm: kunit_try_catch Tainted: G
>>          N 6.4.0-rc1-next-20230512 #1
>> [  663.589817] Hardware name: linux,dummy-virt (DT)
>> [  663.591426] pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTY=
PE=3D--)
>> [  663.592978] pc : __alloc_pages+0x2e8/0x3a0
>> [  663.594236] lr : __kmalloc_large_node+0xbc/0x160
>> [  663.595548] sp : ffff80000a317bc0
>> [  663.596577] x29: ffff80000a317bc0 x28: 0000000000000000 x27: 00000000=
00000000
>> [  663.598863] x26: ffff0000c8925b20 x25: 0000000000000000 x24: 00000000=
00000015
>> [  663.601098] x23: 0000000000040dc0 x22: ffffbf424e7420c8 x21: ffffbf42=
4e7420c8
>> [  663.603100] x20: 1ffff00001462f88 x19: 0000000000040dc0 x18: 00000000=
78b4155a
>> [  663.605582] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000=
00000000
>> [  663.607328] x14: 0000000000000000 x13: 6461657268745f68 x12: ffff6000=
1913bc5a
>> [  663.609355] x11: 1fffe0001913bc59 x10: ffff60001913bc59 x9 : 1fffe000=
1913bc59
>> [  663.611004] x8 : 0000000041b58ab3 x7 : ffff700001462f88 x6 : dfff8000=
00000000
>> [  663.613556] x5 : 00000000f1f1f1f1 x4 : 00000000f2f2f200 x3 : 00000000=
00000000
>> [  663.615364] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffbf42=
516818e2
>> [  663.617753] Call trace:
>> [  663.618486]  __alloc_pages+0x2e8/0x3a0
>> [  663.619613]  __kmalloc_large_node+0xbc/0x160
>> [  663.621454]  __kmalloc+0x84/0x94
>> [  663.622551]  handshake_req_alloc+0x74/0xe8
>> [  663.623801]  handshake_req_alloc_case+0xa0/0x170
>> [  663.625467]  kunit_try_run_case+0x7c/0x100
>> [  663.626592]  kunit_generic_run_threadfn_adapter+0x30/0x4c
>> [  663.628998]  kthread+0x1d4/0x1e4
>> [  663.629715]  ret_from_fork+0x10/0x20
>> [  663.631094] ---[ end trace 0000000000000000 ]---
>> [  663.643101]         ok 6 handshake_req_alloc excessive privsize
>> [  663.649446]         ok 7 handshake_req_alloc all good
>> [  663.651032]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
>> [  663.653941]     ok 1 req_alloc API fuzzing
>> [  663.665951]     ok 2 req_submit NULL req arg
>> [  663.674278]     ok 3 req_submit NULL sock arg
>> [  663.682968]     ok 4 req_submit NULL sock->file
>> [  663.694323]     ok 5 req_lookup works
>> [  663.703604]     ok 6 req_submit max pending
>> [  663.714655]     ok 7 req_submit multiple
>> [  663.725174]     ok 8 req_cancel before accept
>> [  663.733780]     ok 9 req_cancel after accept
>> [  663.742528]     ok 10 req_cancel after done
>> [  663.750637]     ok 11 req_destroy works
>> [  663.751884] # Handshake API tests: pass:11 fail:0 skip:0 total:11
>> [  663.753579] # Totals: pass:17 fail:0 skip:0 total:17
>>=20
>> links:
>> ------
>>=20
>> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202305=
12/testrun/16901289/suite/log-parser-boot/test/check-kernel-exception/log
>> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202305=
12/testrun/16901289/suite/log-parser-boot/tests/
>> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202304=
20/testrun/16385677/suite/log-parser-boot/test/check-kernel-warning-ac79d2c=
a0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/log
>> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202305=
12/testrun/16901289/suite/log-parser-boot/test/check-kernel-warning-ac79d2c=
a0f443d407d9749244f1738c9a2b123c609820f82d9e8907c756f5340/history/
>>=20
>>=20
>> --
>> Linaro LKFT
>> https://lkft.linaro.org

--
Chuck Lever


