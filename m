Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0F61395E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiJaOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJaOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:52:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701A10FF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:52:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCVxXm032281;
        Mon, 31 Oct 2022 14:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=i9qdJH1cvoUSFKUsRz5JhXs2jUBfw8t48bpSYm4p1V8=;
 b=O6Q4twrgSwORHM4awObuqld3WWCGY5f3QWFL0KHE5KzYNtuXYM7h99dqmL/PK3QsV6XZ
 mm4T4QvuB9t7YSzpb5x6Gpoaw8gTBDvWIlQk19ilRklJTGT/CzZMPw+sDxwhX62ymPfl
 Y+kDORsh2pREqQ8FctRyFhnuYqxgqfgVeQtd5l8CFiKovDfqmuxfXShDlZ3kaMNp7F0c
 z2PngKiJEF9oj19iW/Q+vyT/WkDWAp+zdDRqV6lMR9JEY9A4flAsGHgCZx0eYP0p4Ebl
 GCPdeQ12sw+9EXYyLXB37kSq0h01U71M2FXHIQLh489xrPLEHt48BjbsN8L/qfz+ihiv nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtbted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 14:52:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VD5bAu017139;
        Mon, 31 Oct 2022 14:51:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3d1v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 14:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyof4I16PmKGtIzW3ChlvuhPEbnU2MK2aFE7Y83fW11h80FpDUip6lrCxEVq1rxGrILacRiZlhhjOCSRj5caJJFQOA/yU5se3Id8B7We2YEkVnq3l60R4xE8YzOwchVnEgfn4u6qoTuZY3OqtiXSjm0qXwQTvMzdJReJ9nYYHpFsF5Me6/M8fruiwVzStrBCLwX3d9WiSkp4TKOPGbOnVnC8jJwETkg588201kAuInVdeUErTt0ZMsBXhdk9BnApFXatii5Lu8rKSZFf9mpW0mxOCVZCt+eRJax0BsRdEyjp2D8v8A3ALtTqPHm21mbi9ugYxPNHO7Rn2ojy4TLS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9qdJH1cvoUSFKUsRz5JhXs2jUBfw8t48bpSYm4p1V8=;
 b=PMIdHKfX9WDHiJLNF4o70jdNPEdQPREAwoXAds5k3botDgR4GsakXTsf83eYUJvKghVXwqq0AY6TXOlk9GUG/weRJR5WHxu+TvtBBj6PLk1A5NxCzkXK5m4NHMFplkMzoNqIE/rfoN7vP8m30qZkU01RJ9I0iq3vXAVaUc3Zwb8/9x+8cqURiyyrjSBluYsMACvVZC8T8VKSoh+snYjz8ndjLDKBbUNhBdAYpf0wPv06VscNlwfH16Ufg3a81Y0jaW3JEy7a/oYnJbbMgYfyMVqWT/PShaHLjd+EJZErO9eYkE5d1ebCmFav8WmUOdc6IW/YXCtIvi4qH2E/ucEVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9qdJH1cvoUSFKUsRz5JhXs2jUBfw8t48bpSYm4p1V8=;
 b=iLZqrxTTlx09k8WUS+G+Uy/bRD0T3Y9cecL6Q2Wo0B85YwOf/22QWw+GgtFdJR2TNTgKLNDODwrMhPbFLKpkC9BGA3jfPHnPTZglHfWXf7OYBXIma57KhkDJCBAzdHMk75xw8+CvemBWnM48x5Wunu268UmBOoH6lvT2I4uTYzU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 14:51:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 14:51:57 +0000
Date:   Mon, 31 Oct 2022 07:51:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 1/9] mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to
 folios
Message-ID: <Y1/hBhSTQS/micpb@monkey>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
 <20221014031303.231740-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014031303.231740-2-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 06755a78-0ea4-46a9-c8ef-08dabb4f74d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ig+cLrCuLn5h3Yvj2ftcGtDwpXpywiMU1Q47ZhAmXZszfln0U+OAlgdrCIgM8rBYcrgBLkZ014nph94q0jPVg1DxNtfcc8MCmJvD32uMtJ6GsNPMbtyW6bO0KO70svM+Q/TWuwNQ4u1q0C0lMlhyfnjpi5wn0AuQ5RxZEOs99clHrlqweD9uXJSQ3ZrPtGW8T999JoudLKpmXtVCoVSvXrNTDvmCdboOMR9lPaUP2SJKkugZRbYfw2ZFMsGbogvvnYtZx1OgR2gFR7M0vYyFrXKPo8dL3WdVzrbo1k+jHno6Hv1nEHzbhKNoXvOSYyzIKrZu2FuIJRzwz/Oo+Kcucpj9qETxD8xK4TKA/lJd25ytd4HWy+EU69EfxkALGJ7DP3zZJdnNb314u46SKMgIT0NhR0gJXo260PRI/D7fxqc+kyVyXcbZe7va9366QmAzZumsmI0own5HBPc8C7sCzDn8mXr2mEcGwduKwXIo76JUKt5FG0uVK/1+kLNydqBmpMyrcaTK6dFDsimI4RJ++hEKKHHVXI/eaFFr7vbQ9qPav0s2R3hQhhjSvkCC0Tn66cjJ96lH9dnml9/oKNR4wVNQ7cnwNhvLypGAET9W0oVQhhPySYugd9CP4UmhmvlwrQXJ5jVJO/3FiFv1To7HxQUEPc/DtTb3L3dFE023ecA+MvyvvsftctWa+61fwHoEnm4I4KoB3hUAX7ARE/Sp5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(33716001)(2906002)(6486002)(478600001)(4326008)(66946007)(8676002)(83380400001)(6636002)(6862004)(8936002)(44832011)(41300700001)(4744005)(5660300002)(66476007)(66556008)(316002)(6512007)(9686003)(186003)(26005)(86362001)(38100700002)(6506007)(6666004)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/fstXkr9LtCjVsKUBuyMb2fSmzx59pYSTrAmTRilboTTowjvmtuhw1Q4e2h?=
 =?us-ascii?Q?jSQlTjOUjKMbHvpWZJGSo3eIDAPAjpGx7fcrAbR3ulc/WN3ZXdMw+8Ta9Lb1?=
 =?us-ascii?Q?mPcwXOsnBHZ/KuqpKsZRpg/QB89qCV5mOLiUSPhp4bEuY3M6v/FLgTQQJ0Ru?=
 =?us-ascii?Q?vq8y4FR0b0CYHY3enrXrT17EY8jj2XIbX0ZlmObAF8c3eUCCdTtBWS6zQWrg?=
 =?us-ascii?Q?V4qqi6YPriL+7NDg4hDpviS6gPPm5PE1EfM+kLp5K7Ie3LNMNr6CNyFnTlF+?=
 =?us-ascii?Q?TH29kvjI3DPBVHmKpj6KyYzxuGtMjxkRPKfE/hQIkicrlr9f5sJEaSsjyHrC?=
 =?us-ascii?Q?NDLzGd3Bk04mhopaJIOv5RWxwhW6N5gwC64BX9Z5NYfCL1dbFZT2UgqDHpgb?=
 =?us-ascii?Q?jqSTnqhOFv9vzHf/eyVUJ2q9YAGDWFD8blxkJE9gSlT3PiEbdsAOyKjv4DdQ?=
 =?us-ascii?Q?ThLUOwv0Se6MevC7k6keSiz2hGA1QO0TktJCMSN/E1+5RuYz0wBYq3go4Uan?=
 =?us-ascii?Q?yWvG7yyMHaiGx/i7S5BeJ5P2cbEs+F2bCZ+L+hO+AViE6PChtOtypthiKI2U?=
 =?us-ascii?Q?TE6P1ioEI0+8TfmMmR0vf6X9Fqm7VHLMjJM3oMlaoUZ+6ygB3N+zTrVEAjgX?=
 =?us-ascii?Q?TJo02OP9GVQNXxRtbLT83tIzBaGg4OmfXzYXNpKcp61CMxmtokuzMicH2m5/?=
 =?us-ascii?Q?USQPPO/lXjrPyrMaylT/p6mBxUFF6DRApDD14FC1FvHMmk+yeSGkcer9dXiZ?=
 =?us-ascii?Q?ug6KubBsbYLy2LbQ4YuECynxoU5d1ZacA1X1AUHCDteCS3QFhfKuQTpya6kB?=
 =?us-ascii?Q?8cS+0SNDz3q24lVMFvQ9i68boKNc9o+yC6xRs38fU3kHXNKNgtsqj84EmX6m?=
 =?us-ascii?Q?GCG252FKGStGo+0bM4s0T8NVRRiuk0JX+DmexGy9UFToxsmLjqMzWiD1WyKH?=
 =?us-ascii?Q?aUno2l74URDWf4Bo2YGLCX7qjg/XLZyzviEC5qENUR+eyWlus5maUELDbFOn?=
 =?us-ascii?Q?cku3MESXUkzsjuQAHCDGVeoWTx53sqtKbn1mh3R6pt4qjeVNhjnU/jQmt6sK?=
 =?us-ascii?Q?UkfjkyIHNAJM+qPd45zFdxmqL3A1Ru7CRyKvTTmLRfnXYqxFujVFxXJV8vUI?=
 =?us-ascii?Q?Arap+qHaM0ZbRcefevZf5ydM6Inhf93hXqjYu9qdelrDVIGv0nb0QPnKy+w2?=
 =?us-ascii?Q?IFSJhR2R4RlWeHcLKi5D/lhlMklCcoeITpuLDgItm8EXsw4g7Dt9ZdszRB1o?=
 =?us-ascii?Q?dmmfSrXAJqjipE4VMzzn1NkmY/Zkv5GWpHF017Ma81C4zdDKE5fQK5HaLCa1?=
 =?us-ascii?Q?vpHEZjxJoXmL4EMFhAFL6MLMdoRg3EDPgW3jcicHkIMIyUtuQbvNGGxUTxwZ?=
 =?us-ascii?Q?O1/rNs9RFoW39sZutU9d+/RUY91N8qDVXmLDk10a75IitiRIYp5YHAvp/37a?=
 =?us-ascii?Q?1+I5w31yZ26DLfcoooJVGdVbaVdnCWm30dAnV1Cg8EntqFkdXi/yX/QL/WG5?=
 =?us-ascii?Q?MwGKSdOfqUvK0rS4niEUH9Fa5pirfBgECvrV0rUDrDGsgGLXzFgI4C9lwsEK?=
 =?us-ascii?Q?/UGAA9a2WdpubOn1PhMqBBVlB2xfP8n4t1agd6eRW4hIwOk2KVnhvglIWQgt?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06755a78-0ea4-46a9-c8ef-08dabb4f74d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 14:51:57.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcZGjr5gGhEm2QOtU3gMOoANHhgBQpBAkh2JMao1Qo1nxtTxQpQKy8BkYaumP70ddg6Gl180vDHQrfgqeUPN5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_17,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310093
X-Proofpoint-GUID: 82I8btAs1nYI063bGCb3ekLwScThtBJ6
X-Proofpoint-ORIG-GUID: 82I8btAs1nYI063bGCb3ekLwScThtBJ6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 20:12, Sidhartha Kumar wrote:
> Change __set_hugetlb_cgroup() to use folios so it is explicit that the
> function operates on a head page.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb_cgroup.h | 14 +++++++-------
>  mm/hugetlb_cgroup.c            |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)

Sorry for the long delay in responding,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
