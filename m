Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA216981D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBORW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBORWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:22:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054726AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:22:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FH4iNe014000;
        Wed, 15 Feb 2023 17:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=m5cg55FRJJOr+DWn70aVHkHFBO5wl1Ew2m5Q09vUVFY=;
 b=hSx9ubI1xKyJ7YArYKlY3JPax4pNXluczFJcIqKPqQKAi1bsbvSHdyXc7No9WkHBU4Y7
 muIyiYQD15r8rA3ieBLh3gStz5mj7pt/f01KAs0GkXWSd2XUIcJ1biAEqTMw7HBXF7NP
 +W9BHv8kRB5rAxmY5om2DhrJS17mYABzCW9gFcJDp9G+FAsqkxiWar47ceM/WLfwiFOJ
 er+z+DZFgORR8+Qr7lS52x1YbgPxiou16fZRoTAtt5+TvgMed+3WIO5dLE4l2Q/X2f11
 NBV8+5I1TZnkXQ4xYCYFSxbPn65IuK1wPDz9JqXg5LrcIUkJdBaKRmIqaQTvp0hdHIdf FQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m111g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 17:22:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31FGFdtf013504;
        Wed, 15 Feb 2023 17:22:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f74sv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 17:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtdDI55NSetPlq93kWAhUmQ0TlV1ms323bqVlWCqhcusgbFhaSSEsXRXmaPThk36LY7yFLq4qWsYXZmdRmRL4giqFZS5/0Ime4YE1X3fivOlnRktVSop8Z1jAovLiTjUa1+cuSbZa5pzh808xrAP+L0w2ZeJpyjXE8I0MrQMLOq7pVmEsZJChGzEB+ApwVqEf/Ab0MBuENbjTrIRjiLTmpBIWjekhS1sxJEAvI1VP3E3HviuUt4radn5DwRJTcBPGMHm8304/6QRivyEScyP91Hl1jphCPON6nsTb1g3cvr3+GWKAAXqfCWZ7smw+r0VE/vUbB8HamNxN/EJnzJETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5cg55FRJJOr+DWn70aVHkHFBO5wl1Ew2m5Q09vUVFY=;
 b=K8r6A8/L2TgdE/tYfPGfDq2I8t1767GxLBha5mV7MKPaplpJflN5dXvehv9+5RPAC2Wm6JzKXSU/aqqKQDz9+I6wh3QHcRIibVAUVCRpwdS41ClG2/il6gjFC4tUh2f7eBkq42wb6jHibqQI+7m9jP6raI1NdnMeCa8++iy6z5A28RjyWuGYQBCy70lgtbw++snAX+oy2NJxR5wLrX8Bz5JOQVpBQ78veeA8k6AaOidAZqUBXhv/avZkRSYF+9ZCmd4p7G0srmwhDQSihcJ2G0JO1bLzgroMlioX31MHNFD7+KA5NhrEAJ1fwSsqUIG31Rie/KyywSQ8eREp1ryS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5cg55FRJJOr+DWn70aVHkHFBO5wl1Ew2m5Q09vUVFY=;
 b=bxx/9iNmTrDbik5g9U72N6qvLc5h8smL/njNrHc29T1FNcPRVxJt3saXaXP/e5TFRJKbde+2CghJqKYmFbuakbqKdxNQqcdN4rPEHCRl/DkXwjD0UymAtHLYKaKjYhFonSVCpk6anoTMKkMfcbWF8aGfBMST58lU7Ocj+P9IUkE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Wed, 15 Feb
 2023 17:22:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6111.012; Wed, 15 Feb 2023
 17:22:28 +0000
Date:   Wed, 15 Feb 2023 12:22:24 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vernon Yang <vernon2gm@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] maple_tree: reduce stack usage with gcc-9 and
 earlier
Message-ID: <20230215172224.joi2edqzippydiet@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vernon Yang <vernon2gm@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230214103030.1051950-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214103030.1051950-1-arnd@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a62027-1e87-48fb-8b4f-08db0f793690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLSlcpzhCbrOtI9I5X6sREkkwaFk3G/F4C4YRaKHNtq9yFcMdP0WczgXIoFls4rzExCxg33kXx4nxT92/MmFhf9+zpssm8LDdMh6W2qbfvvQrUi3l/G1BW6LWdD11Z666HLzpRg+Ezh7II27rLIwLOcG2FAPGrOP/pdA42uLxV5SFBWhdzFl6WJ58WAC/3p2f2ifzNN9O0XhrwE+q3ySz2zUxLMVn9b3RnlXmoeKVc6wugsSjZevxWbieamasLora7mO0mZcKqIc6vQlixTgHbGQP25QW2K8NQYBBYYr9Ah2c5FrUQACGzeUlnaKuu3IZRLXJoAea72BnG7GKrmIqx/Yufzc+foT4XiyfwarJVjuohiceUREd8uCgRGnXVK4MjJYjZgh0SZbyHeFUrDCbkNkg6dHsaAFOKG3ZuSV50O7q9Zm8hgtXgtgrk8TeOmLenxHRlb6+o7PyzINlUzikm0zmdE4HxGx1QIGzpPWSP8OoImDub0tWtgNfcVGwVHjo3n7KaG8Sg42o33NEnD21oEpII7l8IqHumlvAT6iNoC5repDj79i++MNCH5T4aKxyVXRszWwiIcPw1uvp75bJTIQGyxsYOS674wdIOlYLDine8beI/hvYC9zk9YhLsF0OtYvRCcDYr7Vpk94Pc5Irg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(478600001)(8936002)(316002)(6512007)(186003)(9686003)(38100700002)(6486002)(6666004)(26005)(7416002)(5660300002)(1076003)(86362001)(6506007)(2906002)(54906003)(41300700001)(6916009)(8676002)(66476007)(83380400001)(66946007)(66556008)(33716001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c5s3iJUXfviX8jg7DIt7PjLL26CVklehs/vBiBmHdJo4SW6EaKpaeWzasN6r?=
 =?us-ascii?Q?/BNC4JsJt6DwDHbt6DI5Vt474OyrBDPj7rAc8ZZRufY1uzNVZnD1C3CTTEVJ?=
 =?us-ascii?Q?8k5NgorUE8VccpPslk3d7FL/MIr86Q4GCdWQqqG+7xQR2SOYsdc430JEw+rz?=
 =?us-ascii?Q?sYM2mTnW044vjoANV3m1dxkRWpe2uBIST8FQHAyWHVTYyQKfB+Cc7mMmLLGA?=
 =?us-ascii?Q?taLHrhrvNo421ibrEBzXpX3VD+pD3H2UX/excSxetabys9wix2W6NyL6P9lP?=
 =?us-ascii?Q?JID1ekAmJPvmEWm8/nQgrpt0sX1PK0GYjxXAc3iuuQYnab6KOkcWVn75bLm0?=
 =?us-ascii?Q?JyR4A2YAr4ryMnuzb1Hl4TmufReiYxpxN5HfvQNA4GBG8aCGTGqjSbbZnd5J?=
 =?us-ascii?Q?PcFXVryvejPNzQwuMdKPD/02wvYPmxZDgVkfX9IYieihH4rh2ZBtO/wTvl0b?=
 =?us-ascii?Q?Z9VOyGvSm/qUDE0mWfVa4PgLKAvUmn3dCpHbjI41iYoz2Knxzj9tCWLbwINT?=
 =?us-ascii?Q?rrMSbOHlxmfgNw8hXw32V+TU2iifmr60/V5FzsaSD5Uc8+Z0krAMadK/4IPt?=
 =?us-ascii?Q?P4RIZ2RrxPHgfrImquCZAPTvJ0wsZmcI9vkv9jgYgt8SSOdCehTPFzuRByG2?=
 =?us-ascii?Q?WzqD1FA2K8XJhA7wqsiSCS8j71wAH5zmBYi1fdVA8INXzMzzM+JajmCLc0nz?=
 =?us-ascii?Q?fF0yHbSGPippoy1L8PHeK6uOrl1Z6w5TAaKGLhjFlKVhYSZ/BSZCRG0WutCd?=
 =?us-ascii?Q?oaVI3BY3FZCOJjEyj6gQEWaB8cRnl0RYGJ47/XZo9l/2nrChL4r6O5/kB3t1?=
 =?us-ascii?Q?eyQV06fZNgYNb/hwOR4fiOho/br+0jy9eVRwpWklbBwcxRqISkYxDZEsxBzA?=
 =?us-ascii?Q?ebSL4+8y7KPHFmK9kufrFbP1UOzvSmHaipWfKKyfnmrxP5NJASoIJlf6SOHo?=
 =?us-ascii?Q?txv9zbVvY1FsSjUWzKHKRNZ+U8aKIExZNjr5Z2dVZ8aXvFZMqWaKy/KAbfBh?=
 =?us-ascii?Q?js2/VafviQ2OroFmHPiv1dC1RzF+LF/Qhl/lLjQB/Z7JHwzDgcotoJN2vSHK?=
 =?us-ascii?Q?/QXYaAKVofFlsMMo5K9+qgDfm/s85nVmzont9U/xVfwg6k9TIqnGQfJXaIP6?=
 =?us-ascii?Q?0mmbysDDD3KwZ6ZJhizBi5WBftt9NlPum9L1DUzfRcRCFQm5ilQJwVBr+r3s?=
 =?us-ascii?Q?QpFHC8xVFUlcS9EG7afYVddhQoJeNwZm6OOuHf/V+xgdE/zDgviqlMr9WzB4?=
 =?us-ascii?Q?+6wwbuXQMtxWJYZOTHXG4w8vkTjzQR1j28S3KDIesOFVW9xTAAToGq6daC0K?=
 =?us-ascii?Q?Pa58oElPuhGeBeI9duBNBWlGKexKABqjUxSZkIRbe0XvQ3ecgNwVUmZwpB/z?=
 =?us-ascii?Q?OLz5fYnLgR26KY1mU9R3z633Dg0dRRxwtLs1hsOzdJ3ADPYq+nytLFHtrU0e?=
 =?us-ascii?Q?ZPkNoza2P36BlM27Ru/hYqmdTciXwxRJP/H7wo/JZFvC7yOrI0+DMUcDUqRp?=
 =?us-ascii?Q?9Rr7/UWfQSlRdvMawRJdC84b4oN+7PIZHW79avyR0TzafK3cgR9x4W+ao3DU?=
 =?us-ascii?Q?Vrhspuh4zfyYZXZgy0RyQpiJaSAcJTbdzO8S/2gF5cB0soD6HYHdzza8bAcq?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?w7q3qc7NadnF6ITpFrbFwaFYHZQ2sDMxDnzv4c52KrOAGsQWGpmvrocITiDZ?=
 =?us-ascii?Q?f+x9fObMSQ1zycwzcMtAcSPu6APK6y7FjqodJNq0PWLzwcq9Kfwm/TwQ5FjW?=
 =?us-ascii?Q?fwYjYVLJu9cczOhrPckE4IChBmABQBJkojWNQcG6YBDQSLn+E96cEA3SwodN?=
 =?us-ascii?Q?DqjdXIFM2Is25NgK/3EsUiHXsn2lkJt0AvGn0RW4UPZPSovARyEMMNbklTfb?=
 =?us-ascii?Q?OTPT5Mzix/wWnQ3KYrzxeQQQGxJEtGQ831+XkeAIIrKPDxZtJmYvVCd6kLN8?=
 =?us-ascii?Q?5o6PXkcMLesfCsoM8WPevog9j9oSK+mb2X2AUZBNpqZpjdpcIls0YSDcKmrb?=
 =?us-ascii?Q?AiXKiB6AxqSRVLp+vcCGmJPnbVFU9/iRKlhuusUSh1SkyyrEBlrSJetYf2DP?=
 =?us-ascii?Q?YR+/UsTrYxpkA5yVKM6zwC+zPw3VFjAw4Sc73/QPzn5wQ7F75DqbS1J1FhNC?=
 =?us-ascii?Q?NKEw5h2d4bRwT8uth75lmbiQM9x4uW9W6tj/vh9QJYjpmRCw4WLBZPqjPgdL?=
 =?us-ascii?Q?okgEdXl0sE1pX7ic19FkvdrNv0hikOev+R5EAUellgbwA5O6YAZA+zlKxFLB?=
 =?us-ascii?Q?2eCnXohZ2yHWIDvPRDiL4bCaJMjfGXL1I4dmt7HAE4+xWFHmp6VzGDKkv/9U?=
 =?us-ascii?Q?sHaRqJN4ZVjRIefly/b6jP0F+TQrwOCPV7rNEjBEbQgpKjDjJU9d2iDFntbH?=
 =?us-ascii?Q?vENGv52vgIV4VJUe2n5ANwa1423ejXT5j5iQhLYolsDiyKcqr0dxcegLKzV+?=
 =?us-ascii?Q?rCZ0rNXeFkWUWGWsK2pwRQHc4VYa53lfNiMYs1f5Q345VZhqlZLYpa4z5UHv?=
 =?us-ascii?Q?VaUwVY8aiaYmuAA2JUt64n7cFhNmCE8w3nW5h++qXay7vkHI0L7hJzVK3Cqc?=
 =?us-ascii?Q?igfkU+/Bd01iPPxNDhgbYKjr1qfbp1pKrN0t+RDY72Q0aLVLzhwVLOcYbVfv?=
 =?us-ascii?Q?xzq29IQLRhaX4yhMjJ+BsjAFpeORoeqsaF9xS4UOY4WlaJVS9W/Dv294xwlX?=
 =?us-ascii?Q?pOz7gD8PKFQxOQAIKjSaNHKKcg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a62027-1e87-48fb-8b4f-08db0f793690
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 17:22:28.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71s4o2EnS1YHHZZV9nRNNBAEucbDyTOid2gYH7R3TdobeHNJY6qjMMM/abuSuU1LzDBgcnspVTTb0c4H2MDnmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_08,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150155
X-Proofpoint-GUID: SFosIgNU2Sr1V3BfzGb5PVsM1FIxghMT
X-Proofpoint-ORIG-GUID: SFosIgNU2Sr1V3BfzGb5PVsM1FIxghMT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [230214 05:30]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 changed the way inlining works to be less aggressive, but
> older versions run into an oversized stack frame warning whenever
> CONFIG_KASAN_STACK is enabled, as that forces variables from
> inlined callees to be non-overlapping:
> 
> lib/maple_tree.c: In function 'mas_wr_bnode':
> lib/maple_tree.c:4320:1: error: the frame size of 1424 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Change the annotations on mas_store_b_node() and mas_commit_b_node()
> to explicitly forbid inlining in this configuration, which is
> the same behavior that newer versions already have.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/maple_tree.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 5e9703189259..646297cae5d1 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -146,6 +146,13 @@ struct maple_subtree_state {
>  	struct maple_big_node *bn;
>  };
>  
> +#ifdef CONFIG_KASAN_STACK
> +/* Prevent mas_wr_bnode() from exceeding the stack frame limit */

nit: Should there be more info in here?  You did add it to two functions
and it's a problem for frame-larger-than=1024

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> +#define noinline_for_kasan noinline_for_stack
> +#else
> +#define noinline_for_kasan inline
> +#endif
> +
>  /* Functions */
>  static inline struct maple_node *mt_alloc_one(gfp_t gfp)
>  {
> @@ -2107,7 +2114,7 @@ static inline void mas_bulk_rebalance(struct ma_state *mas, unsigned char end,
>   *
>   * Return: The actual end of the data stored in @b_node
>   */
> -static inline void mas_store_b_node(struct ma_wr_state *wr_mas,
> +static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
>  		struct maple_big_node *b_node, unsigned char offset_end)
>  {
>  	unsigned char slot;
> @@ -3579,7 +3586,7 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
>   * @b_node: The maple big node
>   * @end: The end of the data.
>   */
> -static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
> +static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
>  			    struct maple_big_node *b_node, unsigned char end)
>  {
>  	struct maple_node *node;
> -- 
> 2.39.1
> 
