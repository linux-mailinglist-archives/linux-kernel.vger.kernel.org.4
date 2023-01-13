Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15035668B05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAMEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjAMEuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:50:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE895B4A7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:51 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D4YZCX014882;
        Fri, 13 Jan 2023 04:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=FPIijprSd3AxAhjJX/6ocSu09zVMbaD/b4ongNthS3E=;
 b=Lh0jmYv/WdSxVBafwbXvlSWRPz4FSeMxu0nghtUa+AO4i1bcUzVelXhgrIKMnAu7Ac07
 LWIKW5gFjERpJZS/ESzJJTFIVxjZO9epumpUnlObsfRwFIKo/zQ7GgAvlVcGSZq7GcOb
 fGkI0g0w6RvZIQka9pkZCoNR5aS1K/NRV33WAp1iBYqCnL3PozuoTcsf33DF+pRym3JG
 nCnH1iVuIH0e448JI/tPWY8Joa+kGK9Yf5nNmPzt2MRGZ/ijrY54Gg++B6H4n/tYX8mQ
 e1PfZcRF7l3UmjFwIrM+UodFU0QwxLslsddKPh6mEUO6E4VFRIrMv8j3z3etnF1n7VHR dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n2s9k0jxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 04:49:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30D38ubL022612;
        Fri, 13 Jan 2023 04:49:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4g5xhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 04:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha8aNyiDHu1F0CAJJJXY+bhZyhvlpt8V1ajB16YzSN8tChsHZnD/0eC39466/PbDUtLBtDVpABF+DLT/oCM9EuwePtztgZKZoG1RRMWyh4deKkBTllFoLnXC3oIn+Uw8i/0TiFstV4ArW0Fe0e8cKBBZPvbW+Psvf89lOTHcq+5zmul6Wyve7NWcbBZQXg6Ef+uEvzGdYcIvLx6GhXjHi46yj0AGDWufhWZ7wmqj4eTvd99y+xo6iFxd7XLywhPDUkw7ftGikUCD0LkyCvI7R9iau6xAWDE7wOP7tg1p4ubdAW+e55B9LkvZUnRPQqv96GPQd+fPBG7J7O5IOti+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPIijprSd3AxAhjJX/6ocSu09zVMbaD/b4ongNthS3E=;
 b=i8KvvqRwlHxtMxVGbsPKviLsR3Me8bKOso8IKvSZ97EwotpvUdruxrs4J5ICwtmMi99HYyiCJ1iRvYkwfElze8Ej5algPwYoMyacMlbB1BHHfUTRLU1HAX3uk2We3+ES6kv5ZmoRbwlopGbiLhyu7hYKWRV+a8aJHuMcxUN7SdkSuMBzMny4wEZThCntqgursaijr4f25e1C9dgm21lO9Z24/EFNl9N0hPqdEiAOUFrsqR4mXIJ6QjIiOU4mdPo7vpzkhaVMQoachlTNvRsbrkm2nrXfKLQya8EplPEwKdPj/f828rMqqvNgAELKNCrdlu2wEEgAkTMTx9XDRN4F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPIijprSd3AxAhjJX/6ocSu09zVMbaD/b4ongNthS3E=;
 b=aZ/ebk8JuMG+aMCmtKk/fp7rt7ZJXjd42U9PwTdnKFhVGczgiBhfEslUmgFuekX2Ur0J4djcR8/UPgLGE3o64Sp8n7vDIP+5rzx4xI7AlGhOD4cU1gzT4K4n8Fw4sUco/CGN3VxEKzbVEXGJUavw1JdDfBZYetIrGUOgrj08lsw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 04:49:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 04:49:23 +0000
Date:   Thu, 12 Jan 2023 20:49:19 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
Message-ID: <Y8DizzvFXBSEPzI4@monkey>
References: <20230110075327.590514-1-ying.huang@intel.com>
 <Y74WsWCFGh2wFGji@monkey>
 <Y782h7t10uRVW0RC@monkey>
 <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y79tTXgEeuzzqFho@monkey>
 <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y8ChvzGVG5Tm9tQQ@monkey>
 <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0368.namprd04.prod.outlook.com
 (2603:10b6:303:81::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9039b5-7020-4caf-7a10-08daf5218a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHTHBxdpstlpRDiqHYKuAtsiQIr8CrP9EFX3bXleqC92SnNIVJ/R8kA0esL8Ewk8AaylISF1kIe1rLWyWPIc6V8IQ5lJJaX760P9T+YSDl5TGJpm5CK7kT5WcFFOT09oUQZPQxE9fO7WLo+RhrravYh1g9LoMiE8YnKchvEsHhorB1cpGTFN/NZGE65Twr2i77+V+WrSAy9djJUFDbpT7ER6IQh356Kl56lLt2F3bzZjOI9HAIqeQ7ehRLTwDPtTVRVFgWhoTaXgSuzBR8wmwtn2lfhoTQ9NI6lQZpn2/j/6E9bI5iCmpo3oaLzGYERdxOsMgAgOTeYcD1JlMISoAwWYRD9YhoI4lVmmwqTKoy9IYx9Y3xEXmd+uc/NXmW0lLWo76Jni8j4XeiNeRVCX2L6xPNkA6+osX1oqUONro0xpf26jgBcGxzO88sndF8J1MuaMaEPoYiTWvKANCdFlSRCzNqQFavQwhex7Bmal0s5NJP4vP+m8oR36adIROko00YTzoP1GiE2WFWCzSrciTcRg857w7eMv0X4WcIwUhDEmuUslN582CnHjguX+QEbDeBLAUtjOtBwdQ/qZzylnsxPdlQMPR97xI7vFhqjy/0H7mjjqGXqHfYEDLYYExQ23gtqvRfEJJ9/KqPBYLMZsWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(8936002)(44832011)(6666004)(54906003)(83380400001)(5660300002)(6506007)(53546011)(41300700001)(7416002)(2906002)(6916009)(4326008)(66476007)(66556008)(86362001)(66946007)(478600001)(8676002)(6486002)(26005)(6512007)(9686003)(186003)(316002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzfNB+XEi+HcvL5GcQzrTI+jbjRFQSjCIeUNoRBWuJ7nCcHF8qYncHjeRVqF?=
 =?us-ascii?Q?eGAot+/FI6BprsHngnq2bPyOKeAiwkU9xRrLPsjUO/dAwsGEgEicqQ3A7QQT?=
 =?us-ascii?Q?sd8sVOPbG1KsyG6uBJG3/e4+FLLrk1c8Yo/X4DAZ633w/wrmllw+63kk0m5p?=
 =?us-ascii?Q?qqK/JnLrl6hOCZEDn1kQGBMT6zmmNcLILBpj03vVNjg8iAmSGPwqM08n10HQ?=
 =?us-ascii?Q?qzBDpAVB+0gvDMJx2CzIWqw7+gu1XXAr8wviGY6iJmr9G0s/vCupSBX+Lh4/?=
 =?us-ascii?Q?AZ8gNWcZA7kaumEuLCwWF3o5Qys23cIf5OU+sjnbujUtnsIWr8jIDRS7jqjb?=
 =?us-ascii?Q?PmLSv5FIXqYGYn2EDmEi0XLZMIwxfssLXIb9FykZIscaGwvxhmYQ5qLHezqg?=
 =?us-ascii?Q?IAOhAMxT9atyCkB+TTmRBCOTR+HhpQgUUbBsoe0ywyPe9twm2M445LyEOwl4?=
 =?us-ascii?Q?skFLp8bU15tNKZF31IjUgBAJ+CYspg7IiLmL082gPIJvah8neM3fhEb9R2z+?=
 =?us-ascii?Q?PgCJu6ruV4J6GqV2EoUg3gYbbcvvoev4DrX4fp0sSeIzIg4D+mdU1AwF2Y1D?=
 =?us-ascii?Q?HKdcmDKYkFHZrBt2Hkeda8aIW7ofCD1Oqk+io0CPt40VuRsaEMLdiLsarvXn?=
 =?us-ascii?Q?O95zrAwuy5Y68UYekEF+uVgu8Mn2h7/0WXvTiswri3QVmFfs6qhi58NiJvOY?=
 =?us-ascii?Q?RWqNrSn2HmtZVdvXjEwiC2hJ9IXSU/LayMlpJnDRPSeBzebcsLejh9NXDzqr?=
 =?us-ascii?Q?C1vdKxI9K2jvToQ+JrRT2D6aJ+Jv99JVU9/JoIIWkGrorXsq9tvQxW1gim+s?=
 =?us-ascii?Q?ICMVHCcFK81e1xMswkcPtRP/+JYlaptavylBLiqVMbo1nYLMflAywLplfrN3?=
 =?us-ascii?Q?xwRy9CIsTpRRhN5h5yNPtclTnZazUcQ1K56IQawQnJCD1MuLETyrryKf7EZ1?=
 =?us-ascii?Q?baNZ2m1zLj6uolRrWqDrKah+T9JAXwhSykKQhj86PWo8QuvdgbnLjWTz2r8N?=
 =?us-ascii?Q?XYJFEy29fxi8JBwKYC/SPPGb+ZTNtr4TaxpVpSFp+Rk72PKGIzdAu/Z3m3BW?=
 =?us-ascii?Q?uEXYowlLDj71zE+OItd5Ryppzy51aFgA4wbXpD0aiX7pHEb/HsFPWQoSPNi5?=
 =?us-ascii?Q?0KkrnrPznWM3/dPQAr/BTblC+kuUpXg7JhvV7I5HhHNBHzK2IX/mjLHESrR6?=
 =?us-ascii?Q?lwOXY7iNODZlwaTO5yntLI4W2zeoxaEcfCq0F06UGPwCdccBFY3SHDcPySLl?=
 =?us-ascii?Q?3yKk+n6uv3tgB65qEG4ftVxKS8gWV15ResYEQaewOMZB39xHTd6xXrsZnnLK?=
 =?us-ascii?Q?SEU4ZHmcc+a8CXa85qrU1pJE797TfG9/6GKzCuomPBIImnh12OQbxsQ66BaC?=
 =?us-ascii?Q?w1mEtiFejCXvLdtPbS9hEWBG3xzmh3lnqJFgLEfaJ2Bax9GvIWEyStHPrQIH?=
 =?us-ascii?Q?fmW4EsAWdJTKgS2ZZcL7mIWhMfY81dv9fDMyKcJdKbK8EpnTG2E3LGZq6e/I?=
 =?us-ascii?Q?oCWjJfH7IE60cAvOctwU6zsVa/cLaD5iOSJxoKnTpucfPLWeOJfCloJL8Ce4?=
 =?us-ascii?Q?aWszAGu6mprVT5JyFUSGOCbRIKjJbP0qylQ1LYtyOWGn0qmoME2NdDPDxHlP?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?roTJZlFTD0V/lfQuvCDkgmASR1yqIRhszuDUDKQPgQAPcG33z0zCrInkiyxv?=
 =?us-ascii?Q?igh1gBvXPodyn9rGKwwkQe6o3ZfCVq3DLNIYz04D4SrrGFf+y2hFYzoITSeC?=
 =?us-ascii?Q?7tetTaJZEQM9beCQlNBfvWvmUrQOaXpMiQbOBJnEFUhqokbxFKLbujw1s2Qh?=
 =?us-ascii?Q?rs+c5YrJxffAb0zj9MqdrS8xDF3AarV2ruWot7OHlRdkZJIy39Gy35mknab0?=
 =?us-ascii?Q?TOCnhol/Hf92yGKwwlkthWk8SpQnQIcsv5gvGMGz1vFu5+kzofIzs7viCHiw?=
 =?us-ascii?Q?Qt8QpC3lUjPT+ODGRmTsSYQIpD3Hkvm6uYzWKYGUto0bAtaWNnfm8PSPgkuB?=
 =?us-ascii?Q?QsdjjbdzavOHR9trMDvPLqtBHEjteUBl7967U199/TbbKWrvdJD0pRtvrPFl?=
 =?us-ascii?Q?p/u78KUN+MPxpMDyldgZqDMaoiePpC+oKBYaBOP8f+oQqqgLaIZKS8m+fGuv?=
 =?us-ascii?Q?lflAf/GDDvoF+QPeSWh7yIwbeOmv2W/ru9N28j+F2Lf/KK5YXgUpNOZmJi3y?=
 =?us-ascii?Q?q/ed3warSDqaRldy1F04Acu3KtxVOdiK8hXV+Wn197Ns0UrJ1Uh5ixv+V9OB?=
 =?us-ascii?Q?BOXswFcGtGQEY3viuRJskWfnyKh7M87t7sJXNTwU1ZtKhphWBjukPmLS7fgV?=
 =?us-ascii?Q?+p9X0bF4LpS3X41h/kdNotAhubCEU6Qtzi2I8Qe3+Qu8GZvFnm+WwMZLeRxl?=
 =?us-ascii?Q?Fycg9Mum1OeVNmv1Gnoj3sfZVae2HakWNWlCv9tncS6miDJZHxCKhHPXj/MY?=
 =?us-ascii?Q?daExBK/vGn+BtDh5XKfXAvYZaYgPKOb8TV3TxLW0otgMW3XDdG5sukREONpf?=
 =?us-ascii?Q?bRoEGSNs2waU7qCKWBgvT5f5HQ6KucoymUlud0TXrAJtPqNuyv5HyFc2cQlj?=
 =?us-ascii?Q?J+XHTFIsYF07KW0xnEgbVWbemKnGNowdxIZamxaBHKySW6ao5VZn8luyLNAF?=
 =?us-ascii?Q?bWnfhtSh4Arx0fLWoH+n9g8lnAnP05D3omCymO+/fOud6+39KX7ws2+Zph+y?=
 =?us-ascii?Q?OpA1Uwbr7muSTB05+45NlKbc2o6I0f9+Qfa+0BU2nqngfmY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9039b5-7020-4caf-7a10-08daf5218a09
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 04:49:22.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbyfGT0lxUGfqygR+6r69IpqgXvtLbChLxSFZlqeVHHRHsd/7jd3Yg9JSsrXqhWh0yaS40718q/qM6V9O1CRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130031
X-Proofpoint-GUID: YWECbNigGLM6iiSoQYCJL5Lqox0xlk79
X-Proofpoint-ORIG-GUID: YWECbNigGLM6iiSoQYCJL5Lqox0xlk79
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/13/23 10:42, Huang, Ying wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> > On 01/12/23 15:17, Huang, Ying wrote:
> >> Mike Kravetz <mike.kravetz@oracle.com> writes:
> >> > On 01/12/23 08:09, Huang, Ying wrote:
> >
> > Isolated to patch,
> > [PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
> >
> > Actually, recreated/isolated by just applying this series to v6.2-rc3 in an
> > effort to eliminate any possible noise in linux-next.
> >
> > Spent a little time looking at modifications made there, but nothing stood out.
> > Will investigate more as time allows.
> 
> Thank you very much!  That's really helpful.
> 
> Checked that patch again, found that there's an issue about non-lru
> pages.  Do you enable zram in your test system?  Can you try the
> below debug patch on top of

CONFIG_ZRAM=y

> 
> [PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
> 
> The following patches in series need to be rebased for the below
> change.  I will test with zram enabled too.

A quick test with below patch on top of [PATCH -v2 4/9] (without the rest of
the series applied) makes the issue go away.  Thanks!
-- 
Mike Kravetz

> 
> Best Regards,
> Huang, Ying
> 
> ---------------------------8<------------------------------------------------------
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4c35c2a49574..7153d954b8a2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1187,10 +1187,13 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>  	int rc;
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
> +	bool is_lru = !__PageMovable(&src->page);
>  
>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>  
>  	rc = move_to_new_folio(dst, src, mode);
> +	if (!unlikely(is_lru))
> +		goto out_unlock_both;
>  
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
> @@ -1211,6 +1214,7 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>  		remove_migration_ptes(src,
>  			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
>  
> +out_unlock_both:
>  	folio_unlock(dst);
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
