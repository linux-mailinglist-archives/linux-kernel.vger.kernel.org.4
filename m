Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63572CBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjFLQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFLQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:42:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E331B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:42:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGOHJT023200;
        Mon, 12 Jun 2023 16:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2n/E9yE6QvtJg7Irp5OiV8cypFXu4X8OYDoFRpIP/H0=;
 b=cpt/6TMfO98r6QktPOxftc6VNPvzBnw6Q5RQ1dPB2YXe3cALzj0p//o34bfRwGCg1c3J
 qlwVQgdimg0CxihCo28XoHiFnVWS8N//TDX9nZbzOEOW8HTwjAKNBe5IcwCTOdFV6TKQ
 OSS7Knsy5gMyxF+6286U5t1OFTFbRXVbo5Lx9/awS52GglYAgZXy9zJRyfRPmPMghp8x
 ueqa8vw7PNacOoW+a3RjHNT0/8X+AC9zJYV2aMqF4h+1bSZXpscTE9Wx3HhIo0JS3YyJ
 nhLX55btxIlKc9ZeYuys6msdlj1Got+JQXMVFhinUvSpeUodosFyGyJNoek+7Ob5w9KA lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uf8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:42:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGcWlF008272;
        Mon, 12 Jun 2023 16:42:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm991qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 16:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha+Ei0Sab3or8FT4qTOiZ8WvvKRj+ctJFTTjY787duaEWrMdIyt2kIT3nReaqUQiW8ORra7Jjz6biwR59CXgs9/9YuV1zMP/TREjOW1nURbi1tsdlWhASzrBJw/ooWF5jxWPao45ykgeBg3jRlx0WAddgmTJZyJHGx0Mq0NuWLES70z/TuJcbxQ1KUUVHiWmantxkRVrLXl0p3Nelp9rb2iEH8qYPL+oYcU7atFhlgnRhU9smzoEHz8rNaE/zGJF80BfmEEHDlP0qUVTNDYaOQm6GfglrrpQrUzumyHcx2ILFhiRDyXtazV+WI98X13rMzCZYvcJxKfq7IkkeYb2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n/E9yE6QvtJg7Irp5OiV8cypFXu4X8OYDoFRpIP/H0=;
 b=j6GLAt+Mv2ab8KcLrTEVFoXmgi1zWythVS0Yc9q6SwgnZGfzH+7CaduwYo6p9epRdAjXaJ0B2stIJg5YwP6QVha93Kvxsie573ig9tPn+Xtvd5MHdlfqLQ313hrS8/a7Bk41O2OQEqTYbAWqNceM27qte/IkuFNbakj5w51NdhirFOhgWrcrsx16Y9OOjVsiGUn+wZvhETx/5hzoQDAIq9Y8osDSiWOFDt1inHoTdPlkqKuufYj/odSsiWsIsDqf0dRHOBjuq9pBDF0wf3z+eqwj4aJqEVLq0NlTudapcQmo1AEd+r6CBRiQp1S6kKpUbpIVtfuB4qv8QOrbRRdRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n/E9yE6QvtJg7Irp5OiV8cypFXu4X8OYDoFRpIP/H0=;
 b=mQpsLeozwwdri+v7XM1q8z+xZWBwc/O9Mf2YmmH424z+s2hJwC7V2B6RRt1/iZtBNCcEqepnRoX470uBmwggDaNL10tPPoxfn1gTcNoi434fEOErKWJctviyoPazNn3KYo09ltfdcLEyqHHsHlOO9dyji9pSCGp8JNPvDLQ+nfA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 16:42:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:42:08 +0000
Date:   Mon, 12 Jun 2023 09:42:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: hugetlb: Add Kconfig option to set default
 nr_overcommit_hugepages
Message-ID: <20230612164205.GA3704@monkey>
References: <88fc41edeb5667534cde344c9220fcdfc00047b1.1686359973.git.josh@joshtriplett.org>
 <71834e10-098c-7d15-b9d4-36d33a57499c@google.com>
 <fd1c3a84-d3e6-906f-57b0-25eae0933b68@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1c3a84-d3e6-906f-57b0-25eae0933b68@redhat.com>
X-ClientProxiedBy: MW4PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:303:b9::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 414df242-ff90-4c4d-8d29-08db6b63f630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeW6R8NthiuVe35Wdt5gbncLNlcq5lEInmwMmw/5Xo44w+vhrmuJfHxdpFKax5P4bO0sAJYk/ISr0OVWzaQyftwOk6q3mLXHVBuqv/oI7cLiaKcWE/ZsiN8iv4GuMkClzDZcEpRzYYFvTPT5W/iysN/Rqi5HFODz+7XOX70X6QSQ1fwxs3pWLNqqSjk+l33bEU0pAQenyTdbORTqzmb3IiGXxxRO8gtMsOWOkx6jdjzSIYL/jGBAyzhMWC0jt0CD0bimyYNwndcaxI5uhqviYb7PvG8XpBxTPnLRVSTLcMbx8BmBJkw1uMD02BIeBLzK8mVVN//IfGj4g1w3FfMkQFp1601/iJMl+BE3wVubrEF///HRa1RnVXgaj9uCaipp8TVAEe1h+B1W9TNgyUyxBxwJ8sQ05570jfZVU87SM4UlRKV3NnkKq3bVQmAQ35Ma9/uLYEZVFImcDmuY6DhDQJfOOi2SInjGxTHDG20UPdatvVVnBjVuuaZ5j5puMA+Wo4SwdlCGCIB2DtQO7TtDZOcE3dvbOgLlD3hWvO9h/iBQGROCe0mj0g2KgWUo9LLR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(5660300002)(8936002)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(44832011)(6666004)(6486002)(4326008)(9686003)(26005)(1076003)(6512007)(6506007)(53546011)(316002)(6916009)(41300700001)(186003)(83380400001)(33716001)(478600001)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ThMhxwue9mf38UxKi0CmjGB/gsdEfhf8YH2eAQ1ahbrt7MMbEhxTtxMCrtl?=
 =?us-ascii?Q?5AyKFD/X9zuB7ImQOkuZKlJYx/WAbf2poaulgmAGBIzu8dc+lSJ8XGQ5Qcgi?=
 =?us-ascii?Q?iJrGZwx/vAmKLzbmXZPGJ0ptPYCbWvdnRRW9o3kPswLZ6qsPGhnUANl68FIS?=
 =?us-ascii?Q?6LYJGhtrLrYblbE1ysCRZyr6osuusaj5/w5J7MBAhsspi52z9ifTr6W1e3Qh?=
 =?us-ascii?Q?n7GGT9rBPpMA4WPNH/ojrpfxb2EDw7PuKc7hhkSS406kMQnyf5wQ2YBCbduL?=
 =?us-ascii?Q?nxz+v1JDB4ZyrsP5twmWlNi55Ngewp1gdbpL4EOOQR7GrtTL7T+AV9QMw7JF?=
 =?us-ascii?Q?UVkLgXr9Sel91ayQ+Pu9yEi1ie/GEs8jARnvda64ecsavb2NrlxLPb1UpqGr?=
 =?us-ascii?Q?JndqUT+6Bwn9k58gjp0EKuBVyulFHX3NcG/wSarCAmrbyW/FwkCiZ83pWX+a?=
 =?us-ascii?Q?fC7qWOqJVXnQr1+FxaJX4GJqkqDQqTolTHWfC/DjWWWQ2hSRJLbVmrGGaoNZ?=
 =?us-ascii?Q?GQIlPWZAd9/hoRHsYj2AVCD7YTXyRVi3NptCnf8QYLgl+RwmFtIrcBqnttHN?=
 =?us-ascii?Q?+3KxuOjw5RUJajt13aMSD1pRWloszPphFhE1JsXlFI5ODB/hvHSXNkXODO7n?=
 =?us-ascii?Q?eUZkAbdyZ5EbQibxRiL6xwDSIFFM9Ea84IogCiWhox3svoBV0l/EEtxE/kB2?=
 =?us-ascii?Q?fdaEuzzPDl4C0yxI2hMp59LkR488L4EzP0EJG9fhSWQBanABQB/BXs0Ic3cp?=
 =?us-ascii?Q?EewBLekwfLQSEnvIy9fqV0Wa+SHbCd+ttxMPBeCupB4fd82NQds8HDV4gMP4?=
 =?us-ascii?Q?YMywPKRgbPJWoSOfx/0apohXRfQ+3fnoEKQ4YFFOKIbLAS/3nbJeL94PDrNL?=
 =?us-ascii?Q?GJOuafum9Ukhj9pvW9mYmiVMMlUULjeiLbQz8z1CK9FNwmCUW8cocgT8YFqd?=
 =?us-ascii?Q?wdeBrt1diJVD7Ibo7dbAx8zv69Tupw3FJJ92zKfB00LxigQRujSSaa1FNCJf?=
 =?us-ascii?Q?gF7jWiLitEMW8HcRgziePVNph9QTe69oHgZsXgNmVoUUsfEdvjyjwskC2ziH?=
 =?us-ascii?Q?UHIxw/z6p+zq9FGF3WDD97YEEL4IBjTeZ6oNoeXb/oLaO3tR0JAQ/2lw4zEp?=
 =?us-ascii?Q?OMLrYzPInZLTeN2DVy0LkrMvbrIS6XDc00t4/HAcW1V2KoCPwvLddqZl8B8Y?=
 =?us-ascii?Q?TpxKr6umkr7uPAiiARNBdfllGTHR/yiPVdXcNGjRuvnZprWco3wyn6fJMwUQ?=
 =?us-ascii?Q?JbhFVkWAyfvHMh4luZ4mVQt480ca0VO6gGU0Ui8XFscIGXsxxrG8B93zTmHK?=
 =?us-ascii?Q?tXy7/vx7xMqRa+YXvDeYwhKzVxcUfe1wyw41niD5xc6qDmCzPa2dCbYWj/rp?=
 =?us-ascii?Q?2/WTc10f+oD0bU7bpTuTdl4kgZqepGHleg5KEgX6O4wYE7BSA07MQq2BK7ji?=
 =?us-ascii?Q?SQ3ujCOSYJbhAV4N0fxyUi2xYt/M0bxYNKU3bEGlcf9kYGzJ0hGPbanOjV7Z?=
 =?us-ascii?Q?8V1TSRjEd95v8F7z8jQq+FTsA7espi+yqBqXUJBpFohLX/76qHXvIMU7mLBG?=
 =?us-ascii?Q?+egJdbo0GP7pDKtvuKKUz1RCbi5o/E7GVdz8t8+3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2+JSc/78Ec4GaiT3PT+UYHpt5nt5jk/LCV3ZLEDwBZ4/EcLHRbDmReSTboTi?=
 =?us-ascii?Q?36BceZ918elMZCyacpRez45sYz4QF8FZuEPgMVYJmDWbd45innNwCLqVyj7m?=
 =?us-ascii?Q?/woW3T0c/6kgXvPUfkt93w3BJyOTs9yGXF0UATZMJhjRitCgjWr9VscegEQw?=
 =?us-ascii?Q?dGWZJD98F2Szhgy3SPww3YkWPOf4nkMDUOlzyaogXykebjDrdPZNw5u/GRNi?=
 =?us-ascii?Q?fxK2WDfKcpjZQyb47AQMS2l9v0duKZ2KUcaDgT9cJIfxQje3FxFZw5VsOsBc?=
 =?us-ascii?Q?1mbDwCWIHdvsjyVE+cMQMS7BNU4cCdT/OmmTSTpMRWbIQAo5+nqYNGNxxGum?=
 =?us-ascii?Q?+yVuiMOdhQID4bArcNKBR2ZfyYH2YUCnCI8UoGzaPMjnaALE6QAArteFp1p8?=
 =?us-ascii?Q?gfrUDWB3dbVzBZHJu1EmohQdePaaLm0BRyE1Hy5s12z5Q47Aki/DXXQVQnxD?=
 =?us-ascii?Q?DYTDfhX48XgoAuwKpDFSAjGdTXJmAH76LyJR1HQYLkYRDn0SSM3o1ZZxK8Hn?=
 =?us-ascii?Q?zO1t33TgKmZLic3sTcfek60TFYKXuFWhl/nYMsXqYtrQW5cNKtHc3xOsTnnw?=
 =?us-ascii?Q?lo6OduiUc/QfSqvbpWw8F0omoocgdc4kO1oDX9GBlaQypIAFg8kZHidQrmOj?=
 =?us-ascii?Q?quR+WGo6pEe/iEKxzXBpD6asKIon3C6TKSn0sKarZGq4Y0buZcdE2nO6S0VW?=
 =?us-ascii?Q?RtlCjGNWQjhAY2w7xpdFdQQKXFKbt5B/1oTArZVobyUZQKGpcAyNGQBdtxXM?=
 =?us-ascii?Q?p/vGMdE9Zprqqk3QdlauVwRJjOeTJ/R48JhimPA6Ynnm7vbdsBRj6vF21Vi/?=
 =?us-ascii?Q?eIJWTeyL59gdXBXuqbe25wr75zKxaj76ShXUSrh4MY3Qnsryn3XmDIElYwng?=
 =?us-ascii?Q?aV0dwjJ2epsFsNrGefF5yx825GnIOsv/UrGbn9C/FdGfFXJCq4jxs0LIF5tg?=
 =?us-ascii?Q?t5lUkYl/CNS8IAtA3pGre2k7TS8VcY9Gi2W2Ji4yzr/KrtHm7uN+BeefclT0?=
 =?us-ascii?Q?9WrU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414df242-ff90-4c4d-8d29-08db6b63f630
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:42:08.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhTVVMTa/5K4TZmHsJAMODhPbrD0XV7fMcPVGRx7Ymt0fKrxRfWOUKshXFOBH4Pru+PszlsHHZKCnBoNRy7+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=781 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120144
X-Proofpoint-GUID: _mYo0se39WecjuPLZRete4VKYR83lDBK
X-Proofpoint-ORIG-GUID: _mYo0se39WecjuPLZRete4VKYR83lDBK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 11:12, David Hildenbrand wrote:
> On 11.06.23 07:20, David Rientjes wrote:
> > On Fri, 9 Jun 2023, Josh Triplett wrote:
> > 
> > > The default kernel configuration does not allow any huge page allocation
> > > until after setting nr_hugepages or nr_overcommit_hugepages to a
> > > non-zero value; without setting those, mmap attempts with MAP_HUGETLB
> > > will always fail with -ENOMEM. nr_overcommit_hugepages allows userspace
> > > to attempt to allocate huge pages at runtime, succeeding if the kernel
> > > can find or assemble a free huge page.
> > > 
> > > Provide a Kconfig option to make nr_overcommit_hugepages default to
> > > unlimited, which permits userspace to always attempt huge page
> > > allocation on a best-effort basis. This makes it easier and more
> > > worthwhile for random applications and libraries to opportunistically
> > > attempt MAP_HUGETLB allocations without special configuration.
> > > 
> > > In particular, current versions of liburing with IORING_SETUP_NO_MMAP
> > > attempt to allocate the rings in a huge page. This seems likely to lead
> > > to more applications and libraries attempting to use huge pages.
> > > 
> > > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > 
> > Why not do this in an initscript?
> > 
> > Or, if absolutely necessary, a kernel command line parameter?
> > 
> > A Kconfig option to set a default value to be ULONG_MAX seems strange if
> > you can just write the value to procfs.
> > 
> 
> Agreed, not to mention that huge pages in some environment can cause trouble
> (some architectures -- or with gigantic huge pages --  don't support huge
> page migration and you can run into trouble with ZONE_MOVABLE or
> MIGRATE_CMA, because you'll end up "consuming" all memory for unmovable
> allocations in the system), and we shouldn't advocate the use of unlimited
> overcommit for huge pages ...
> 

Agree with David(s).  Such an option should really be decided by a sysadmin.

Any reason why liburing can not use THP?  Seems like that would provide the
desired functionality.
-- 
Mike Kravetz
