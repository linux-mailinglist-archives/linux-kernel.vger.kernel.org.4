Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535BE6A7571
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCAUfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjCAUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:35:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45531BAED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:35:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321FwnWk028270;
        Wed, 1 Mar 2023 20:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ygOx+aTPCszQ3wDfSu8JgztLMdXn8rTTRYlFBMwvlJI=;
 b=zS6Mssr8z8HRHzC3nspPr0oEDgcAnP5nY/3WsQ8OjT1WJgiq/X5SzMUh0Vs4JimV8sTE
 OSJJrQ6I56TljWKHhQ3TSUkcyMo54cc1sJkSyfsq4w92fp7NyB1zBHxCUPiqIe69W8J5
 3fC3HiDkPTwuFFPejhP4hJGhyfmFqmkp6UsuFiHKhK2P48D6rCLlgSJqCgrcX/J5eJAQ
 HnbtvjKQ/5IyJu1xrC4MyD5ayjUDSxQZke0+N13/O6AU+frm4Ujq3Hd8qJmXu9tKBEl9
 H+667vRh3PLPXfyQnOYZoc3YL2frfVmqdey90WyQrUQRepgCi+nYH+v+yulrsI6eqySE PA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72hwvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 20:35:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321JFJ9g013149;
        Wed, 1 Mar 2023 20:35:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s92q04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 20:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEqS43d6Kc0BvKana6U0Y8RT90417lHw8E79asybW93B2eXU8aJKz1FjW54C4jGivFHLvBa8JKdsOhxbFAUDBhmPBG0IRBMLt0NmXEkTCC/FYV3EGx1Lva1MRfAeET1avEDdEAwk0wloKhDextOq19Md5JMxhbCeAaY0zHftknX8sS5DRH1pjmDI3E65d31kKNJOg4dPnwHh40QQCJbqRLerb6hem0iWBIfymvwDhVbM94QBMLUMpuyhMekhzpJUdOT+9p6odAigv+VYEw+rSkHO7MK32BMX8ueRiDdh5l1OzsUyMEASPYcUkuYVg5eDGR+GqY0uBG35eELXBNU/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygOx+aTPCszQ3wDfSu8JgztLMdXn8rTTRYlFBMwvlJI=;
 b=H0RjIiOENqmCbxFpr7iCUpbDBNzIdqP7/IsBzUAlW/1/L/qoshCHGQI+CUc6iJ+r/o2SX/Yyycj4/zcLh0ST5c3BVPQCHyiEyxKzkCxsiBCM4/CPV2ZPuv71ihWd5dBlYOTUBkMWG9nqMQjS2IGjv+qFiUELJjZh2BsmxyPIkORDCmVCNO5dD27E9azU1bbX3Z6MfLJE6R0hbecL6cmGqkz9vDflfKG1RHbl9gP3AXXGUPj190NVTTePCSAv3xskfbXie5AWWGTjHJoftpAqyGgAUgBEofi1BswK4FcNEjfq0dE8w9UGEbQeqdswrw0C0up0QGBxdwB5Nj5yN9xztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygOx+aTPCszQ3wDfSu8JgztLMdXn8rTTRYlFBMwvlJI=;
 b=jwFu/H8aNavtw+ai55snkf/LuOb8paLFWF5HEs5MaBu+DZJXPWd+UEHyPzKzGK8k840xH+GN+IzpOzYKpZYsbKv2AywQASzu5IrHukfQlApHCMZya3T93XPtDNPzXbgHaFC1IdLBLHbmSuYN+UH5wZ6EbjSk1YQYIg9Q4frMq54=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6858.namprd10.prod.outlook.com (2603:10b6:610:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 20:35:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 20:35:16 +0000
Date:   Wed, 1 Mar 2023 15:35:13 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [linus:master] [mm/mmap] 04241ffe3f:
 Kernel_panic-not_syncing:Fatal_exception
Message-ID: <20230301203513.jhyqva4dup6r7nlz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <202303010946.d35666d1-oliver.sang@intel.com>
 <20230301165036.mal6lkb6qhpjyz2r@revolver>
 <45eeb539-ed82-4984-197b-3f88cd765a59@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45eeb539-ed82-4984-197b-3f88cd765a59@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af96284-72e7-4614-ca5a-08db1a94770f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjC2kk0L624bvu5xKSvVAE7rid4find2/AD9x37Qpzj0ZYpOZpjw4bYTLklNExA4m8/2t0JOagBxEeVr49Ipeu+oJeGNk9xqTP5hdXpUcpWIAvUR7Kyqp4m37/cW9ULkGpL/KPhJUf+keVzzuHQMEuEd1etSA0H1NDlwCvNCoDAXJq8BbZv06Wkuvl698B9BXPeLZvRKovfMKZwOfbnfez7+QKp/yRWUw2PsFDzxQZvS1JInlpsAP++EnpKtsKmvmaN5UQkCs0rUGNi8Tb5ZdnsV0cFc/tAOgTM8bM+lRHXqguN+j0nDKZVvnCKX1HlA+FNqVdi+qe3LRc6IAI7hwwm/XjTIEJSIaH7CVTK5TYiUHTc27qXYDA/+CZ0/IL6pRbhJ0HEBog/ven34gZAHRnkkh7WcSC391akiMyzMbn2nlpCmC9g8y6fDon+oc9ZbFYGc+RHmjtppapWKgXp8guave2KIUeJH69cUHOiw/Sx4Ug18so6Q2g8HYAYext+4tHouKyQs1puGeyM97SS3xNZMdVeQX0QJJ/TdVkdn3HSS3/EHAcHJSQHBuJTW9NuYuJlC2V7V0eSPxbl5mwhcCYajwveM6WUITQ1hnbsrtcaE+P+px3d30IFm3y09G/7KCtVgxOZ23X85sAXfYiNsFg7jqGP8aHSIblI9pCfZaSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(38100700002)(86362001)(33716001)(54906003)(66476007)(8676002)(6916009)(4326008)(66946007)(316002)(66556008)(6486002)(966005)(26005)(478600001)(6506007)(1076003)(6666004)(53546011)(6512007)(186003)(9686003)(2906002)(5660300002)(83380400001)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LM5MuhHj5PL93ah6fa7nrq7rwsJ2MOe+rKVfvkrAe7phJntrQtsutEpUyDE/?=
 =?us-ascii?Q?aex516h+EqiVJcRX/Kbw0IBT53GYbV9q5ToWeFbWgnwdCvHQMQhy69kp+U+2?=
 =?us-ascii?Q?stMC/BJFb81oeixlDF7SrJrFAvq8sEpLFlc4KPhu8fPFBb/L7qwKXTDT4B+P?=
 =?us-ascii?Q?8IIeVEzYUX7FJY5Kd8FN7xLyIzM9zBowoewjZ2JuylMqqNEGaBz4Ylfvvt/F?=
 =?us-ascii?Q?j0NCeU+V6s4uJqUPK75eoTc58Fp7uBIYhuGFm715FEHwI40sJ9a6w+qUUgJk?=
 =?us-ascii?Q?M7EDPJeCfajW3oaZSUSj7+5BqpPLn2lqPkPUdjk/30mE4jw4C28KowqBtCEs?=
 =?us-ascii?Q?ZXprGbcPkwvDwY0TrBNUYnZm1WDJZm1zlfweXX3bSwRp+5DhDuFQ9EfERDTL?=
 =?us-ascii?Q?zy+UnTBHYbZqEgcKbBxFuMV2bp+h4VtLXr+01/b0jj8aHnV4cPixCzgnnGTJ?=
 =?us-ascii?Q?Fhe9mswlzrpL7KyQm+fT9MW34uPjteU42p5ANhi3yBfP8nC3CpTqr6UJlcTY?=
 =?us-ascii?Q?ghp8Q9c1x3ML86LLWBfgiCbqOLwdTsChkYSxKNRpgg1bEjiza37qsBBh8jA7?=
 =?us-ascii?Q?SgK6trvmZs7CI68sn8u5cXLZWAP6mLdW8v2fcQi+KVl6pCeQ1MCGAKHccSEi?=
 =?us-ascii?Q?BCTJj7LSHxXXv1cNqAZlugduVJwxL8Rdb00EUWuXLm/IpoMY+X3o5UTDBYNu?=
 =?us-ascii?Q?p41aTlKwAIred+TyXmmf76lvCHUurobtLaa7nASjR2wlna/D768KfK2ACZ98?=
 =?us-ascii?Q?8R9Wliw1/s7xWCoIs5/IRSnpPxLMX84EsjDWZAqLUyJ1pg65S+ortlzygBPS?=
 =?us-ascii?Q?ZaUU9QhrytkOJNkMqyK1Uhy/f2WMAQQ8ZIEIe7WfUyR8QVMmtWxW+HwFGCjx?=
 =?us-ascii?Q?nlytLKXOntUp8leWVMtgJfax9xdJwqJYmyR317ZY3+wW1kRT2SRU61r1wUiX?=
 =?us-ascii?Q?4EtFUttrv0lpSAgL70VHRfNMzSsJGKt9Ufg/9dBDyQtl4kmBNjVeMn7p2qno?=
 =?us-ascii?Q?qmV3fXI+Vh+Y01S6CslLPBEgKLYBXF9ANmHNjuqyr9YAzX2Lkm49cyLDU2qV?=
 =?us-ascii?Q?Yj0AOHCbloc0Pi4/TBiQXqqJ3WwqHno9heJqEeBNLCLJGt63t5AzhqD7HgEm?=
 =?us-ascii?Q?bpQFpIT7bth5VtxYPyESflIRs0QbUABQViqczCqJ1XzLlmCBGUcjxLUTDyLA?=
 =?us-ascii?Q?6bjgP/L9/WWhF9PTmZt/EcgerPOR+HjO1M4FHjBboper13/E0O08bGZ+7S5C?=
 =?us-ascii?Q?3UnbILmt8rhheOfzaYI98p8xEUIIRbaAtcAIW6osMxJJfR4QzAFs9FiwnAvx?=
 =?us-ascii?Q?gWK49ljeF4/+dnczF+nHzLoz6+66f3wQKsCfAoXxi5LX6mg9lxcZgocfho7T?=
 =?us-ascii?Q?HRb7CS+5WRRs1WA7inD80M/K+qBno8j8utblfxTEGQge5FyFfjT4rarlMQuB?=
 =?us-ascii?Q?9GjrdTPfMyfQmP2T6fOYaT+efRTjQVaol7kYqOmMnesxnw8PEHAO2VPSqxl1?=
 =?us-ascii?Q?x6572RzOBgqydLi1KJwy/TSbbNx3E+CMVbiMaFVSA/CShotfI/9N2HIveYCY?=
 =?us-ascii?Q?pbIeJw8o8rKRtTwSpJ2cYRHqKnBoS3sNz5+FCH3G9LJwi1r85cpkG5UKz2K/?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Gv4Dlrh3VtUy5X2jBzbP3bXYF0c9hLxNGhpylM1tjf0cDk1/GnJ/ooRA41qE?=
 =?us-ascii?Q?L6/odyZmg7O/L1+5bY2E2hScNG+rDExgrGlgv5JlLvjMU3X8BDpGZGG3Ja4Q?=
 =?us-ascii?Q?+hBTNm0mXEFzA9wQx5KF8fl31iH6L/lvW6xQhxgoqtRCrqBETG/m++tyCSFO?=
 =?us-ascii?Q?pqdaAsTWH6nRcXHzEvxUC30eju6QtJyybsdZdiKrxDiRHqj6C1nBJHSgyKQp?=
 =?us-ascii?Q?vLVqe8iek3TGTOxqlBTN3FKDklKE/hhrd4zqpIHICv1jnuFJEd4YJNjm+2mC?=
 =?us-ascii?Q?MMoXd9TncgI2XNrqs89o2o/PbJinLKo+PosuFxTb634+QSpt276xhC89PP+U?=
 =?us-ascii?Q?47SkAMK8T/gWfJWqHIP7BzzE6QWvrpgWFpexBZCa56mgsYbYQCYqq1WabhvR?=
 =?us-ascii?Q?7qnriRySyhgqt111mS8opNzY+G+FkaS8OVFebPx42I+z24+91/d6WKB9dqR7?=
 =?us-ascii?Q?KU6b5KRcGYXEnEwtd3K+POHnSzD5uJz5luOHDKzvHLe9g1t88S53oBpsrLWF?=
 =?us-ascii?Q?Iklu7XnmpUk9U1lteWm4u/4xbaCHA5i9MOFnhZm7+H9bhMB2KvM3HcfAzI03?=
 =?us-ascii?Q?6iPxxPUozYNyCH0aPbnmr8WeV804IJClHPP3YcWp8Buq4KbXfTK96JZ45hNX?=
 =?us-ascii?Q?mciY6FXLfMHzCTh3gLlrZD++DjzNJWS/mS4PtfG3jWvDpAytTo31P9p/jH4R?=
 =?us-ascii?Q?YWIE5jmIQyXOQARZ89ZqSVtlYIKjyARAnNkOhiXwOdWPRMeBtqz3JONiNiXE?=
 =?us-ascii?Q?6Tt67z1OxS36cSKEK9yCIVdEyKYrwgpctdN7qAJPg/q6P9PIjxHJNSnnU2Ur?=
 =?us-ascii?Q?uEMheHREKc2GF0TwBZ9Ey8/LZ6WfJuysziH+dJARg0WbsCs4vZINM/d+mgVT?=
 =?us-ascii?Q?2abK7BpqFBMUxunV8mVP6Yrrii2TsJD3xwi13J82HJNaliGQFgDJoU6c/q5u?=
 =?us-ascii?Q?GKBJbJaSQTF+GIZFV09TvA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af96284-72e7-4614-ca5a-08db1a94770f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:35:16.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1CP/bAAfMNE7tCYKGMy/UMIsmRRQn3Z5zGTU1ymHGvjkpotf/6U0lMo2ZYN1pSFDlvHEIixrnW++pHC5TEmlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010162
X-Proofpoint-ORIG-GUID: bXuxXFc5sMmlRmkdrvWkFN8rYAPC2ikW
X-Proofpoint-GUID: bXuxXFc5sMmlRmkdrvWkFN8rYAPC2ikW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230301 14:10]:
> On 3/1/23 17:50, Liam R. Howlett wrote:
> > * kernel test robot <oliver.sang@intel.com> [230301 02:21]:
> >> 
> >> Greeting,
> >> 
> >> FYI, we noticed Kernel_panic-not_syncing:Fatal_exception due to commit (built with gcc-11):
> >> 
> >> commit: 04241ffe3f0458d54c61cf6c9d58d703efda4dd5 ("mm/mmap: introduce dup_vma_anon() helper")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >> 
> >> [test failed on linus/master f3a2439f20d918930cc4ae8f76fe1c1afd26958f]
> >> [test failed on linux-next/master 7f7a8831520f12a3cf894b0627641fad33971221]
> > 
> > I tracked the problem down in that commit.  The fix is simple enough:
> > 
> > -----------------
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -802,10 +802,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >                          * If next doesn't have anon_vma, import from vma after
> >                          * next, if the vma overlaps with it.
> >                          */
> > -                       if (remove != NULL && !next->anon_vma)
> > +                       if (remove2 != NULL && !next->anon_vma)
> 
> Oh I actually did notice that one too, but as it was only temporary within
> the series and already baked into git, thought there's no benefit in
> pointing it out. A problem for bisect obviously as was just confirmed.
> 
> > ----------------
> > 
> > However, that will not fix the problem in linux-next or linus/master
> > since this code is completely changed shortly after.
> > 
> > You need the fix from Vlastimil (Cc'ed).  After cherry-picking
> 
> > 07dc4b186203 ("mm/mremap: fix dup_anon_vma() in vma_merge() case 4") on
> 
> Which tree is that?
> The mm-hotfixes-stable commit is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-stable&id=4c6759967826b87f56c73e0f1deb7b76379ccd23

I got that git id from the build bots previous report of the failure.
It appears that it isn't in any of my trees, so it must be from
linux-next daily from some point.

> 
> > top of linus/master, I don't get this particular failure anymore.
> > 
> > I do get the "kernel BUG at mm/filemap.c:155!", so it might be masking
> > another problem. (Added Matthew to Cc)
> > 
> > I think the right thing to do is to include Vlastimil's fix.
> 
> Great, thanks.
> 
> > Thanks,
> > Liam
> > 
> > ...
> > 
> 
