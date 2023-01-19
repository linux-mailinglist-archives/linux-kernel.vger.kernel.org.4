Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D6674180
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjASS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjASSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:55:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D6737B52
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:55:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGwk3v014196;
        Thu, 19 Jan 2023 18:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=PIjmT/dLpu+6+5SheREb/bJSD8PIeBjVcW8GMjUQY2I=;
 b=lD/i4obZCTCFn7kqL5Vii108XfQhBQy/DTfDJCyi4aM1CxYfE6OlLL6tQvI1tGEU680J
 iUzpj63W8E+7NTgVHaXEJQAf/OXmVArDvQHXsQNLkY+NSBSPF819888A+ZFp3URpzFlk
 LFWbtvS3GKVkaXGG/euE0AlBSCrCY1z1UWepa2USe4frJAXuzs/P5JngAcXJWgnaeNKr
 NLRZeRsuU90Od3KDaCdBDEY60uI0x2IXDwQ32aFbIL8a0WtOGwOuxiFn01yEOTCdWiPB
 ECHnWVGWIKGvWmoi03lSipEfvXjpcBOdq8wQ5S+G6p0GkSnzERiM9HdL2inA4cQ/MYGp 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdjcv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:55:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JHkX1W013541;
        Thu, 19 Jan 2023 18:55:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qme3re3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwET04TGtfxJzvy+FdwHORxltPKPcZOLNrrYOEf7zH8pOpfL0T1dQZqNUG5hW225z4bQ7XmNmTwbZDo9O0/3Hd+IW9HnWw228DwnBjPBvhGYWFdBFrtCi2zgfdcFOr/uwqboZAAxHe6Ds7MLEHeZgHyBBY6h3i1a/hIivxH/475fKqD+/9u8KzspRlaCgoD9JzGm6FvJcHdchQpd+IvJP/7HMdP7UiIn+049kcB1GvBcE5eFtKemvf26JLkFq6kdbBipG9L7csCU7XejqKEUABDEhr8qjMlWh4VdCsLd5LHk+SGZB9FCQ3zDqh+aBwdI8o8AqmIabWS5qu8RPRsGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIjmT/dLpu+6+5SheREb/bJSD8PIeBjVcW8GMjUQY2I=;
 b=WysfPlDkdmuS5ar8fJRUw3IPtixhpsVnMU04xsRiVrLsUQJnlEWEJqKOo+3IPBZUiBMdV74CdTED1k90Jjrh29eMl2kbkJynLvDBmrL3jtFJxYhRUi0Q6FVP0sgsbk4+6pizkz/dT6oxKF0SkzOVgV97T2i3NlCy29cdsUUqsh5lBlDZxoo9C8VYF4fVo4WH6eL0zjm/nSlYzCgk9h0anPxaDFIUyPBHAtoOTn1RNaA97lx4NB98+/Zf7syG+AyL0dm+AzmI76ClGYi359A9Tl9axZHMfQmsfjB8admBCebnE9W4Ol2ZngpVYyMz5lXxduSXw+N5URJn8ZDh7YPCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIjmT/dLpu+6+5SheREb/bJSD8PIeBjVcW8GMjUQY2I=;
 b=GLUIKw7yjYis+DWh2a5HApJfPv1hyjkNjSMXWUf2X0pUbhQOHDVR1VCorpIL0pZ5JoWhyUu3lC3g4QCeU1jylV2pF5CKyZipj1aX85iQAfr51D+gwsKAZDfipq4Y1CdTTTNPzuvGWeOjSeV3yaKBMR9HO/4Z43qlp4wqK+qJ5uU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4448.namprd10.prod.outlook.com (2603:10b6:a03:2ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 18:55:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 18:55:06 +0000
Date:   Thu, 19 Jan 2023 13:55:03 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
Message-ID: <20230119185503.wapuhphnjw2sn7wt@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        SeongJae Park <sj@kernel.org>, Daniel Latypov <dlatypov@google.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
References: <20230117224734.c4lo4spezufwsims@revolver>
 <20230119020050.2156-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119020050.2156-1-sj@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad7686c-d967-426b-fe5b-08dafa4eae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNZkdzkT9ft31Xm+QvEYuND1a1IQ9TtIxT+7WGzfMN2FUGunnodo+sC7hIXtpuKqE2X62xSS4DYm1qgB37IEVRHpl/pCsFYMrGwpghFCyWYQ9mhrUlhDtodBao0Q7hchpckHf7kkm1EzXn5BIx0e9vpN9iLDO9bZ5vsx6vfqoaOJncRwpwhyI3zswaUr2BmwSMtjo3MRARpuFEatcL0++paEyLnd+clCGWbeVW8oiF1/QoJlth5+j3pfGFBTbYEFT2AeoluivnjngQNQY1D37IT2HbqMdct8A+XlDhzcAMrXp3HTDNT8WwZvKOwolzwrKY8bmd6ma8dAvfbMWzMtYjJ+v7M6HYuJWg/Cf/GpWm2H7UoxQMEFZvDk71tujNfzn/IGzFHi4UzKXy7vnmq3txEMdOh/7LFbLN2DmLjwRrTv5qLw4sAxV6jiJkI4hRmyCK+A8ABn5W4X599Re26aWwnlmPT0HS9LEgEV1skU9Q3vEBRBqM+BQBxAi8mvZHPRyte2ek+TY+5njbdyEJ/KsYL2uuNi8A2uY54l/EHf9rfSotZ/VVeuKwnDskNC3dc9tI/qmj2T1R93KD3eFGlLHhnfDUVZX0hEi0r3G/QM/Ez7dJrCYAOkoD2wELAMoQ2mBLXqLyCrfndarRFBq3JaCuuQjTwWdXsKFGx/+fBVcjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(6506007)(53546011)(6512007)(186003)(26005)(9686003)(6666004)(6486002)(966005)(478600001)(316002)(1076003)(54906003)(2906002)(66476007)(66556008)(4326008)(66946007)(8676002)(6916009)(41300700001)(8936002)(83380400001)(7416002)(5660300002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUiaDDzIz5xC/0WQGtzKeezieKjeRGFrVgHhef6YjLTblWLQyWREUA3JBm7b?=
 =?us-ascii?Q?5PdYYiqBQkzVbunl+4YYSR24Frelr6pXc5mAb99DLQFoQgDIlUTBu2KHW4NO?=
 =?us-ascii?Q?/ioBbADxrQ8zKzOCax1qVhdiN+KUW95F5gei+hHPrqvcuo5HuBHih3mkM7t+?=
 =?us-ascii?Q?h5wkJjt8i3ReBLQM9MNfZsdBccSiYsAuxzFnEesvNTHov0FWej00Cfzy2ZHK?=
 =?us-ascii?Q?d1kIpYSxxKyVIpBctMtacK6MPUpOcM2tDKvyeVrY/2TSzmpvfNpLjWrZRmDm?=
 =?us-ascii?Q?L/BWeavoMq0PUQ4GxQ+qM7u96WypZ4bkNlPi1C/sLZfKyk4LWa0rLohs8PWa?=
 =?us-ascii?Q?RQIPE98BOSrS0W8uKZp6YCGtRr+kMww10EMrBXOBMoigzd3sS92s1bIYDXUZ?=
 =?us-ascii?Q?Zx08Al68U7Ei6YyXqU9+5adspneKEffvws8HvelambGrGeHgKdsV94oW1h7V?=
 =?us-ascii?Q?5X29nVTaYNsdqsB6z52Om+aZyFMwY5KZeL/mPtbvf1VsEVa+iud7SENat/eg?=
 =?us-ascii?Q?YY+uT3KoCSl4LgdXGoeSMwupy0xTgnFrMSV3mZQ5DMBk4I/DRSy0yh6WhBMa?=
 =?us-ascii?Q?mfqNwGUsYSlS4N7AB6qIE4kwPtfV+QpYard12couhU1yp7Wi4V3wh6rPZUn2?=
 =?us-ascii?Q?kqMBZNct/kJukJRXTIoMk6u61wvEb+/wQJFD8GR+87k4NlVqCOulJatvypiU?=
 =?us-ascii?Q?rx9IlkDO8EDBPdu4FhPrx0n8bzDa3BvNvKeWOrjaUN/OTMnQ4+eGgIaOSRXl?=
 =?us-ascii?Q?jYjetLnZBdWbfB/q/1H6Z3kh3/cVQly0hg8MC07nysDlDgVei77KA8jq4Y32?=
 =?us-ascii?Q?0hSckOCTcx9MCgjkCK4eUoM0T2cf7rIpBPNPlEZtrw35ruryCuF97R4DavDi?=
 =?us-ascii?Q?mVZXX26dbhcM6K+0s1+GHR3hJfdLWpGd6fewBqq8SBPvr1i3ZN5Rd1kgZ4gy?=
 =?us-ascii?Q?jNVfSS0s80qFz3ywq8qMao0Me0Sd98Q87Gdp9wma65wPmHrwdawEs8jcTYGs?=
 =?us-ascii?Q?B3eSorFZz4uJmBApxZL4tJ5n6dRKgGEer8lhlDNH3AXAeAyfFtFdVOxblSUk?=
 =?us-ascii?Q?QWJGSquQxpF7o0zMXz0vn7ULQDHl6QhdWu322MhW7uUXQMIfVLLjRVixwSbz?=
 =?us-ascii?Q?wYyyBi+Vq4bq3DSS+ZN+CSg5KQBgW+4kBRblUN2vRFTSfGFhclmvO3pmHIQ6?=
 =?us-ascii?Q?2xZgnvgAMBnDOo/34L70aoKGXdVWuK2ODx6bJf10Qgn2dEfE1Pwh6aAnSk2+?=
 =?us-ascii?Q?9QpPs/O+omvN47oUMNa6TbmM/L3fSlarcH2qmAQR8U4h2J78aTBgs57m5cpR?=
 =?us-ascii?Q?mFpmSzgjGvhdh4C+UzJtSJ5SFRFPC3ZH6QHKLt2ZK1RXjuGxNzaEdNOo9FsF?=
 =?us-ascii?Q?1hz0THzo7/Wxpr+Ut21J1OWEO+WvCxZ2FExGEG9bdss/qi2NXbGWvnhrBwjP?=
 =?us-ascii?Q?xW3lS8y8S/gyqWaOtDBjQDx8cMMfWCspJtnnbYMZzSNdD6K4vBRZnFVaaGRd?=
 =?us-ascii?Q?DQQiO3XWF82Ik0zFE1+oI7CPSRx9KM3R/mxJXh1SuzeUX1uxy1bKUw97uju8?=
 =?us-ascii?Q?r+OyatQR656VJkVuUs/+aD/uXhAS35LeIFUkgHBr4uE3T/jCA9SONExndxZf?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W0x355tvAPaNPGft9IqIGGGgXYL/1EeYk1TzS7IcZ6rAc+E7kbOPTcyek0a4?=
 =?us-ascii?Q?AZDgTz3YHVGICLE1T+AhjLHLANMdRlFG/y31G3R7zhvsp0AineYVpj5sVH76?=
 =?us-ascii?Q?ntyM3biztVXl7+qBpk1yZi3qCPmZsCHVI39NKMYRCHJcIpUEQZ+2PS95imd0?=
 =?us-ascii?Q?sajvmbMYyvHJ2aqkc+iWpSKJsWq8ZtCBykb2MVaapDZqsrj9yK62KJj9Z57Z?=
 =?us-ascii?Q?pLZG6KtYhL8oPcIKq0GkMFkgRMHKTIJYZXsUh0P1SGxU/ENyLRybYCLaLyMA?=
 =?us-ascii?Q?tpq98DsorE40Hv1qer8wrrc6rbQxJ5XDWuSEqZTI9eqopzRJYH7SKQylMm6R?=
 =?us-ascii?Q?uECXLZp/HHlh3lhwF5DR/4f/5MxPzYl2Z5CUYVfHeVKt+UIXbebpi0z0GoXQ?=
 =?us-ascii?Q?8nWpA5pzRW/gaZLqwe5jvEe+yFGLO3cpFNd2FIdQCenV/Goy3A/baQgv4VQd?=
 =?us-ascii?Q?MD93u18UR9OV1xOPea9M4yjUyPCqTnrECWdh8kBfwm8W1253O7mkb99sfGXU?=
 =?us-ascii?Q?P8ROFO8Vk7GP54VPI1oY7ThI2guDw1DLclUV4LWoN3fcFf9u/LK7+Ou4/keL?=
 =?us-ascii?Q?SOpxP7LqRtulOkwLISesFqXVeOod1Y4kLwlrmhS+avG9m6+iC9eQL2jEEbn/?=
 =?us-ascii?Q?mOgwPiMY3xBVEFE9BhFGGTZYuxuE+lEFiW/PghPKE4eCvsTlher6Gh9JUrvn?=
 =?us-ascii?Q?W5X3/H8Z3lmfvPC434GA9li79/CtpmJoYbhWAtuGY9Lqy4Ebv8w7XJE4ih6o?=
 =?us-ascii?Q?Y2Ks8e8wSASPj3+A7rPSXPxOezfiSEYjobI02haOslfsTEaevx+nktyq0z8V?=
 =?us-ascii?Q?tHNm/PzEe+Nocd1zKdEVXKORCPFEY7NMIUpIpB8wvFSwUuWO/ls2KMgPseCn?=
 =?us-ascii?Q?xNPwCtOI2xqEB42iJhslKCZRbmlY9Jn5NeI6C4ABmb3HlZSSYhjZCg351tOs?=
 =?us-ascii?Q?MMQjf2y7hOtzdE/f1PLx9n1O3E4ud4mc9r5CKGz8sESPJc/QF7YRCtD8QkeO?=
 =?us-ascii?Q?HvYPtlSyr+Cp/qNXbmuHKNjotmvum5T50rKAhI9fzxSJ5MkaryurTp/a4xF/?=
 =?us-ascii?Q?UOh+Opv+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad7686c-d967-426b-fe5b-08dafa4eae01
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 18:55:06.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+t7Ix0nvjdr/bBpMQBKHcnCzw4Ce29n+R5tkOcS1zJGBhFuUGpGNSl33oyhg8WEbXCIfABjs0+EYUzAAQJicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190158
X-Proofpoint-ORIG-GUID: bPX4kQ3ckoYoF8S7aQFg28Kuh_AXzLYM
X-Proofpoint-GUID: bPX4kQ3ckoYoF8S7aQFg28Kuh_AXzLYM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [230118 21:00]:
> Hello Daniel and Liam,
> 
> 
> Sorry for late reply.
> 
> On Tue, 17 Jan 2023 22:47:36 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> > * Daniel Latypov <dlatypov@google.com> [230117 17:20]:
> > > On Tue, Jan 17, 2023 at 11:11 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Cc-ing kunit people.
> > > >
> > > > Hi Liam,
> > > >
> > > >
> > > > Could we put touching file name on the summary?
> > > > E.g., mm/damon/vaddr-test: Stop using ...

Sure thing.

...
> > > >
> > > > In case of the __link_vmas() failure, I think we should skip this test using
> > > > 'kunit_skip()', rather marking this test failed.
> > > 
> > > As noted above, I'd suggest we also pass in the `test` object to
> > > __link_vmas() and call kunit_skip() from there.
> > 
> > My thoughts were if we are testing adding nothing to the list, then
> > there is probably a problem with the test and so that should be
> > highlighted with a failure.
> > 
> > I really don't mind either way.
> 
> I didn't wrote '__link_vmas()' to test vma manipulation functions it internally
> uses, but just to offload test setup for 'damon_test_three_regions_in_vmas()'.
> I agree that the detailed failure reason could be helpful for better
> understanding as the function can now fail from 'mas_store_gfp()'s memory
> allocation failure.
> 
> That said, I think we can get the detail from the return value of
> '__link_vmas()'. I'm further worrying if passing 'test' object to the function
> makes people think the function itself is for testing something inside it.
> 
> Also, I don't think the function returning non-error for zero value 'nr_vmas'
> as a problem but just expected behavior, as previously commented[1].
> 
> So I'd prefer doing kunit_skip() here.

Sounds good to me.  Thanks for clarifying.

I'll make the necessary changes for v4 of the patches.

> 
> If I'm missing something or wrong, please let me know.
> 
> [1] https://lore.kernel.org/damon/20230117191614.116521-1-sj@kernel.org/
> 
> 
