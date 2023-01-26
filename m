Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2C67D9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjAZXnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjAZXnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:43:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49562F7AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:43:00 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QNE5ci030508;
        Thu, 26 Jan 2023 23:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=X+L5MFkHihrqdcRaXRdUszWsJTbmmn9Y8iRbdpsP3lc=;
 b=YDbWDKvMUjmlGZ4cdKzQ9R6a9tCbrxiaghiNF0BiwODQi/XnCyVMUEbBPM1WGEnt572w
 DziH4Juk8zHV5cZsjmw7MbQP8ZsO6RQngS8Q7K4t9u1TUt20Kob1wMxJYQn3SeXb3JbN
 cxpL/NNIB/eOiG9L9dEARaTGJr6WQVL6WkoPbqPWLPqmXSrpe3fXt8f5FfkhpJPWPd0U
 man+m0tco0JwQrM9F40GiCFesy8gqbXm2Zyt463r0c3Df5dA1+MZJ53kh9osSsyZwOTy
 J18iSSMLBN/RBbxi9nQGkRJBIFApc/fgyN9zn/hwmA7Cvi7fltPm+xpK71r4RAIkZN/q 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fckrsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 23:42:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QNOIGI034531;
        Thu, 26 Jan 2023 23:42:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8w0ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 23:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmstydQw5RzEeGLJBHI+MW/uo8mBihfeCnf+Qm5CPikIyGNqhRyERA6ePStyf/QQxMzpPQWat4XAHIdiOMNQq7wgGNNxBZEFuVUe8pU5DdGBAzvLcC0mynTokB36i/MAuNubGCISsQKuhpCNdooUYd7jZ/wXOM8KwdgAEM1nt7XFtjI53fMGg9FeM4MCYD+5EVF+6T0aLtqrsYuLSphkM+Q6/SDs8yZaLl/UyBs2agkwvYx0J+jlKOAngTuLTG3q/99vpJGEdA0s9B75fqbOP9r9smNPQsJkf3S9NgdEORdS0z7Btt98rYf+GFdcSRbDUVwrbNmAkCi80ADCe060rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+L5MFkHihrqdcRaXRdUszWsJTbmmn9Y8iRbdpsP3lc=;
 b=fg1GZDHS7y2l8fJwI/9ctrfFDSWd4aBPtdyYAjDHWNmeztMTQvq7w+EmwkUGmOI1q320ABjKFoIrwnmywcWnsFdPmyaYoMH/hM6IdB7faAr+hlOsAMRBQTFQjcS3xPDs/xNPDtPZhAZvjR/AOFLXElzM3GXL+XPoh6i28qjdPqwJxsvesWr7rYMloD5aVorZM1VGDQfJG6DjT5veI9wAQJ5e54pjwTMFYgO5wnxbWXLfLrTZKqIZCPqSSlTQGXhCFNjfh3hKw+T4EumUnytuIyrdWWuiCa1iGSdVFH1Xe/6RRuUBw9Vq1IeF2+ssw2i4ehuEDlUx62YFGXE88aaZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+L5MFkHihrqdcRaXRdUszWsJTbmmn9Y8iRbdpsP3lc=;
 b=iCfpK1FfNsg5Tz6x958P9ERaUReZITK5wialLcIgUJlyTP7WclhLia99kYMuxWwJLs7BX0vIJRO/kevISsNYQO5ojrSLZxPRq2YrwCC+j45bb17pM4d+qfeafKIxoluIvooxCwjhzooWWFoLUjhKlQMmKC5KTyq2KAs/pGpB8ys=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:42:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:42:32 +0000
Date:   Thu, 26 Jan 2023 15:42:29 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+83cc82a0254bc0c17b52@syzkaller.appspotmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, muchun.song@linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [syzbot] kernel BUG in free_huge_page
Message-ID: <Y9MP5fmQ28nceDjx@monkey>
References: <000000000000a9dc0705f3105a26@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9dc0705f3105a26@google.com>
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 044b49c1-1911-4375-b892-08dafff6fe85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRbs4n2yR7+XgW9r/3l4GmmSm4D/7L3FZogUuBjxhlmeLYoJS7nsScGUUQsATEi3nBypFkykLN28Fosf3v6OGHG9jYyaPspX9WvkCtUQIM52EfhKJsRj87Gzc5tlPxORe8XLRsEudvtz3b+uC680I/OlY0KOLuVlTQG1MtKA+mniTXhggv54NirbfUTiVM4AxkSTallEd6a7wocM3uFnbBMo5Zb6QuSsWOuvUlFUhVBmkS6jMlkzNRVuJ5uwltyXk+VGfESqBdQ+PIUFya9wUQVXqMRxzQaPeJCOY6sx9NiTnx0oCPvaSI4Q8kF1K6V5IxoukkMXT/WSYs/DmYXTvQUhJ+SkOpM8xxi/tLDF14IwMoEwaKE+koPNsmQXzmzjxFFyXu9Mvd1Bi2jLwq7uArCObW4cZnIPZHPQHqGwz8B4GlGEI5gp61+cDtVP0qXdSffszQxLVp9UuAPv8A6Scd/XwlQzU1YMDIJHnAOXyAxOWLG/KwrSMMnAbK6CmS3nUrIs6uiq5IPZ+6ItPUZXKjPAaDGIXIdQYkKqlxPjgzxL5rVPi25W6T01IorrXUHn7uKPPNHDAJ+B5mXGKe916kSpQJwZ0hcOwyBpFQTpkOEeIMIrjG9qkLqTwbbcqp4YGcaGZDVjZLmJCEg6q46Ncdrh9LsVUF7KkS/6NeemZ3cC34nDXxRA76Z9izo0itcFd14Cz/VEoyocxq56TYwKHn1vrcDQjaIlLAMAl1X1c+RhQEp/aID7kygrCdeFaBe+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(86362001)(38100700002)(66476007)(316002)(66946007)(66556008)(7416002)(5660300002)(4326008)(8936002)(6636002)(8676002)(41300700001)(33716001)(2906002)(44832011)(110136005)(83380400001)(478600001)(6486002)(966005)(26005)(53546011)(186003)(6506007)(6666004)(9686003)(6512007)(14583001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwE1zkXjvt+CuPyc2srr74xoY82lLJJnwZypUrVkBABEfTW0RMm0f3G9W5dA?=
 =?us-ascii?Q?7VwRuuTqi0/255OCNV7j6LJ0NX7glL6OZ31Ci/J6j7l13PYzh8FuTfSt4obo?=
 =?us-ascii?Q?XKKCFui6QCogI8bAPM+UHrckzxyhGMw1a/YUiYM1zPU4xqzl354OwjpbM8cr?=
 =?us-ascii?Q?VSIVSGYy75DLKAXAH7OwwRIjFTy4RcwVhH3IoEgT+SU8BxY0uf9fCgZpnzfU?=
 =?us-ascii?Q?Fl8635vGHudnjtKWPoittpI2asGugtxUxXvx8xKMn3x0nwrCEv6TBkjCsDmO?=
 =?us-ascii?Q?IVVi31Un1qVzRPZrlXBm2ivxqQKq1dohi2z857we1JEjumh06kxH/yfnSyxz?=
 =?us-ascii?Q?C1lYl3l9NDOkKiu6ERe5SX2zR01++Gky38rED1ma9RSwK1NwLHZG3M43+ALw?=
 =?us-ascii?Q?neqarAFA0ko6MUot22IWuMnnIJcibOtB3uf84LQknfdQ2PhHHOOoQHCI5CCQ?=
 =?us-ascii?Q?qtr2Edo5hSysEfhCgKC41xnldJNe3VWxDxKMCjbDi2k2ZOEc7Uyy61T6EiYv?=
 =?us-ascii?Q?xjmAjON1pkQjGNgZCO6VK90jkyexai+E5XMXWf216cyrlncpVTZAt04xqnGZ?=
 =?us-ascii?Q?E9abZQjgSiVNfm/eK2xlqnGke6tbQCo30s6qz7cpbHrUBHaxiMXl31kX6Lux?=
 =?us-ascii?Q?GG3U8VFafkEba50MZdHYbQy5D0Rw1mVl9JPmB7oRG9taYO3csLmQ8QSCGvqB?=
 =?us-ascii?Q?d0D5Uf0thuXY5nteGGlxWoz8leTVwMh5iaxEKc11Ro2L3NCRge8yqUfq9BY3?=
 =?us-ascii?Q?vVeDzp8vcdqQFIN8rXT8b40GjfY+G0gUpvOjOLiNqRKmGoWixocjkvZIwJva?=
 =?us-ascii?Q?M1JIT9JXYmzuu3suunChow2AhSILLBqYdngHE7lxuI8Nxo98rt+mV+x58fgi?=
 =?us-ascii?Q?xESm4Q+dodL+8FPYfbVKrpKrD3bWYNO0BnNyj669Ov2S36dnotOmBTi8x20Y?=
 =?us-ascii?Q?zwNQqTmgeK95i9Ymg7Bc9xBlBiwj2mYRHG48wx9Lv0Jwoqs846Mk9fNwl7PE?=
 =?us-ascii?Q?iPWqD3hVcUuqKCX4hxMav3RitaZV/4GLuKVkrInVXhmCeuaG3sXJOa1dCDvx?=
 =?us-ascii?Q?n3ChaBgf7GCmOW5fHCE91ayQuq6PJ28H7eLG9/MuTjT/v1/KA1Ki3N7T5yk7?=
 =?us-ascii?Q?sn/hV6EEutEy+zlEF5nY38kcXGeWImUKld5lY6VQtHLRxj+zSEQ/ZHe0T8oW?=
 =?us-ascii?Q?VLD/lt8ZMmQKSsfT7TkCn+0ZACfdxhPCmjTeuVxTHhwhYdVjme3qkMGDcvd9?=
 =?us-ascii?Q?id9wqBNuOGxWAm7zBErtIV5X+NlpKDN/h71pZA54IqZrXltw3qsm6jESSDx9?=
 =?us-ascii?Q?ZfQl8Ty/qPur5AlgUOYHRQHtsuaNVjQ4E4Ns9UV7tFunGq/kJH+bonXMDVHY?=
 =?us-ascii?Q?huN4HSzHIYT/UmAMjIvKrkDh7vLB8wbQlm6Ei2ub72QW4gb41ULPJvVu96NZ?=
 =?us-ascii?Q?bQy87rW1BEFN03skfoDkRJqHPfCyF5f68LFT7LWgDPu/eC/NMo+uhEEmO/9r?=
 =?us-ascii?Q?aNwAwqcyOaztMcwsdnW/zSkvDAz2lcAJfl4rR9ygKEz2+cAZXIrtuDrFrwPr?=
 =?us-ascii?Q?BfGzHS59evXPvVPJv+9N3jTx3o1lp2+9N4I20EEvfXOowt3CKn6PIUAhQg0e?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cbJyjJ5kONi7ZWbyzvldgac7iHoIgnJojGeo9W7AcoXtqH3dT0Ktn89Ruy0Z?=
 =?us-ascii?Q?qww2yZZm/kZBn+pbtonEmpqdnCmacNh0uKzUVBKZ8TOBKVn1jpJtfYUl2Dfe?=
 =?us-ascii?Q?dZMuXCIg/LLhoycYtV+srkPn3uY/AnUOwSThkQC1rEOFcSwoYtVVjC0oQKzN?=
 =?us-ascii?Q?mvPEdZdsuNWjtS1vJ5H4ClMFWHG/BRzUJVuQAUg1bn3O8xVSy4tLjuHMQGQM?=
 =?us-ascii?Q?qKZ1tVo1YCiLWJAuitFmC72kx2YHt14kjgQH7fJU+dXipr7SenNzBGTFFQHz?=
 =?us-ascii?Q?KrObkpPncl7BcO74oL2EibphCYPVYYBL6ChsI299t1R+C9Ha3B3e5DMPHnFj?=
 =?us-ascii?Q?VwCkiQayvd5MdAaAl0zOkyr4bUTcBs7ozqbG1Nfc76GV38v4OFoi7lqW00rR?=
 =?us-ascii?Q?pFyXaRQNG2DTMxLeYS8qciJrqV1p+Sq0a2kE7cClaQVm1YqYHnlpYay4Wn3z?=
 =?us-ascii?Q?kcsgV9wYAuQBL7d2by3zQaa3Ay0rEsn5UjdFQUU3QL6CzqQBytxxMLtOgrWA?=
 =?us-ascii?Q?0nOKavEuFlrq2tNEP/STcSVW++r2qXh/46YyGbYv1PvBgdWNUWjiUZFAh0+i?=
 =?us-ascii?Q?JCFOzVOb5G9RXGBMfLifRIVyjFgX+OP77KAtXakoP4MA6QTCeFsQZbyY2x58?=
 =?us-ascii?Q?o8yLfMXSjVLrL3tZFCp9isE9O8EWSnYrzBcOrikbtxsrEmldAmRCQYEzXEuC?=
 =?us-ascii?Q?tZOq4PqIcI9pMvlFjZtMeHIzxNVY1Qg8otW+0ekrdWe5Wrf2BPlW3Gzv5iYQ?=
 =?us-ascii?Q?YjJ9R04EGM32S2veMM84QHuavFnx7t/flsz7glgvFe2MiaIH1tkBBPLYNdry?=
 =?us-ascii?Q?Cj/lg0p12uHmHLzypjxHi1aMBE5CryaQdYQ4Ql5Fj8KjpB1KzWFiZOKUtotr?=
 =?us-ascii?Q?tTTUDB9rN1csDJQTS93Gi6CGFIMO/74wkWMCgblDr4Bj8bIT/VaIfu/aOUro?=
 =?us-ascii?Q?Up9os3LqOeOoB9ERpbjG7GDvqEFVq82nTck8pzmcArbMPhq90MfCtkHPoQpC?=
 =?us-ascii?Q?qJnYTg0a4chTcLe4XA3nHHGPtJv9Nn8+l643e50Cr5Oagh3HqOsFz2f3jsve?=
 =?us-ascii?Q?z1zxTaC2NsX5p6SHrVCaguRn6jH3tfc/AczSZDX0LIdwJDbdP1/UyI62E8hC?=
 =?us-ascii?Q?xwYCDmWClWWowaVyZaQI0xomhJVFuUYNXQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044b49c1-1911-4375-b892-08dafff6fe85
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:42:32.5279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKvOK94Y5d9SlP35kHg46slTHwUEJFV4ePdfMifdlEjCvU64JhzcIB6lgpEQCqXH7QQ0hDYjOfW1+8qbh26BEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260221
X-Proofpoint-GUID: 8dVMLCq4aR1YhhNZT54lv7-hopOhUL7p
X-Proofpoint-ORIG-GUID: 8dVMLCq4aR1YhhNZT54lv7-hopOhUL7p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/23 22:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    691781f561e9 Add linux-next specific files for 20230123
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1393d0ac480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=804cddf7ddbc6c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=83cc82a0254bc0c17b52
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
<snip>
> ------------[ cut here ]------------
> kernel BUG at mm/hugetlb.c:1865!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8927 Comm: syz-executor.5 Not tainted 6.2.0-rc5-next-20230123-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> RIP: 0010:free_huge_page+0xa5b/0xe80 mm/hugetlb.c:1865
> Code: 0f 0b e8 08 98 b7 ff 4c 89 e7 e8 00 3e f7 ff 89 c3 e9 a0 f9 ff ff e8 f4 97 b7 ff 48 c7 c6 a0 6f 59 8a 4c 89 e7 e8 55 8b ef ff <0f> 0b e8 de 97 b7 ff 48 8d 7b 17 48 b8 00 00 00 00 00 fc ff df 4c
> RSP: 0018:ffffc9000557f908 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc900062ea000
> RDX: 0000000000040000 RSI: ffffffff81ca564b RDI: 0000000000000000
> RBP: ffffffff91c45bf8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 1ffffffff21798de R12: ffffea0002580000
> R13: ffffea0002580090 R14: 0000000000000000 R15: ffffea0002580034
> FS:  00007f42bf3be700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2349dabf84 CR3: 0000000021513000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __folio_put_large mm/swap.c:119 [inline]
>  __folio_put+0x109/0x140 mm/swap.c:127
>  folio_put include/linux/mm.h:1203 [inline]
>  put_page+0x21b/0x280 include/linux/mm.h:1272
>  hugetlb_fault+0x153e/0x23f0 mm/hugetlb.c:6130
>  follow_hugetlb_page+0x6ab/0x1e40 mm/hugetlb.c:6524
>  __get_user_pages+0x29b/0xfc0 mm/gup.c:1125
>  populate_vma_page_range+0x241/0x320 mm/gup.c:1526
>  __mm_populate+0x105/0x3b0 mm/gup.c:1640
>  do_mlock+0x370/0x6d0 mm/mlock.c:608
>  __do_sys_mlock mm/mlock.c:616 [inline]
>  __se_sys_mlock mm/mlock.c:614 [inline]
>  __x64_sys_mlock+0x59/0x80 mm/mlock.c:614
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f42be68c0c9

I believe this has the same root cause as the problem reported here:

https://lore.kernel.org/linux-mm/20230124162346.404985e8@thinkpad/

With the code segment,
[...]
>  	page = pte_page(entry);
> -	if (page != pagecache_page)
> +	if (page_folio(page) != pagecache_folio)
>  		if (!trylock_page(page)) {
>  			need_wait_lock = 1;
>  			goto out_ptl;
>  		}
>  
> -	get_page(page);
> +	folio_get(pagecache_folio);
>  

In Gerald's case, pagecache_folio == NULL.

In addition, note that page_folio(page) and pagecache_folio can refer to
two different folios.  We already have a ref on pagecache_folio from previous
code 'pagecache_folio = filemap_lock_folio()'.  The above would incorrectly
get another ref on pagecache_folio instead of page.  So, page would be
short one ref but still mapped.  At the end of hugetlb_fault(), we will
do a put_page(page) and since we did not take a ref on the page, the ref
count will drop to zero and we end up calling free_huge_page while the page
is still mapped. That triggers the BUG. :(

This looks to be fixed in v2 of the patch.
-- 
Mike Kravetz
