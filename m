Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC16A0F70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBWS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjBWS0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:26:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8315BBA5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:26:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NGwlev016293;
        Thu, 23 Feb 2023 18:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=liGim/yxm3G5DHs2B+aar2vaa6dxAIF3Vr9z49zS9UY=;
 b=2qFZEbYnqNmzU/Ee32s8rVMGHjQ0ok3ig607AkLFxm0I/MUm08ocvg0CSnohOMqSygit
 LJGDYfbalRzqyK7aLupFZG1HofZSoRoCRxsPZEGiiwEeBCyVIMq7wH9hy/W6z51nT6si
 XTYdIje6s5cLSOMMm5bVlZbZbuHTsx3VMo2i+vCb4alNREVLvmTa72dpNI5+jk3eoaDf
 ChgR4QkEILBGyld1DeioLkJHSsDLroSZnWGgGRVXAxBgof6VFz5q0Ihlz9an6EM/3Qb+
 w8SBkgNaT10JW02iyHKvWYkCFihbmVulvNxj/uHsM26aIhpC4+Re8GDIKRYAls2oVKYt Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqckcxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 18:25:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NIKHWn025912;
        Thu, 23 Feb 2023 18:25:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn48dt0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 18:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFflQUkrAZjzrXDPKQ7t+9zxkBlAGD6Mzgm85yrnLWYu3mrbjXN2VJJr6ZxzCCtVohq5NyGW48H9bXa2GSL0tPSYFWmsL0BSnGvZ6u+CL+Uffnqk2zJEE2zaveboRzLgNSwPgK+oSWaGQ8xgCS65fNo8BKLrrcGmJBnCGMLttqSvSTWCvElSv33zA4IFiE1VddHidVaQ4wDitJceaBWpRiZ9CHwOOW28lveQzmKnLRMnkm1KAOzcka6qpDHIyER9ahE8+x9tnCGrqVS4Ku2HkwLAFg8lM4/bmSM4vNeyOcohq747FQlnrHmIVSK0sLwsQvmwEClpzBYUaiSFZXZIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liGim/yxm3G5DHs2B+aar2vaa6dxAIF3Vr9z49zS9UY=;
 b=Vbu9/T07nBH4cBg0LvPfNJ/ox/bUdvwpv2HJP2iGD/M5m3Obm8mkOFOsso9HNqM5ksPheGgbqc3DtXLLUjFxLvho2SiuMt6riCmN5/QMLGxDvCCa2bD4lF79sp8xRnOau9lWudZBFY8Tb33DT06yBXh8Yu66I6vNJ/KoWIBPsqPIEyGHFMEFbwmtIZ1H4dfxsm/RfAtWIqZDWCeLY3S4+sALCbmaqOhw0DUqCA6aeftKD5v3mYCtFyY91EI1NIGlfAMSN/rIgGjwjY5+iJuz1yay3ChJSeE/nmRTwvUp0G2owdF9kf0xs/LcxSMfpl+x5hJygAAQpzN+QuONjWSDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liGim/yxm3G5DHs2B+aar2vaa6dxAIF3Vr9z49zS9UY=;
 b=bLO4rqkpY831ztdpNlAbSQ+JPfKkXXm38QqYUKqOkS/tJafTb+emgS4zCK6pTmGRF0Tg4FuqwpKqTVEgsCIcmMw/eR3eCJfhi9btajF1+m8pCdFHah/MqwBPpQmGVGeBURWP9x25t/J6v1jJqkd0Ex6auRJqeItWZDPLY7/03ng=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Thu, 23 Feb
 2023 18:25:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Thu, 23 Feb 2023
 18:25:38 +0000
Date:   Thu, 23 Feb 2023 10:25:34 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Message-ID: <Y/evnsBk/OtjqjAQ@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey>
 <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
 <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com>
 <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
 <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcabbad-7d84-47ec-675d-08db15cb5cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6w8yIEjGaSr7Th+qc7voSZZ0rtBn7IyLw45ywjVb08ct6nx84PWOGKDEGUWfdtOUiWVT2Ll+akwDw8UNRQEoSQxELAe4ocFFe8HOU3o1tqMk5Jm6BVoNNeaVw5H9RbJGsO+B0wcXUvuIoIiFSZmoMOwjyYVKOxYjU6DqJjvjvJpjN+7g8g2QZYGAIShyGUHIYzWbqGzkt1/J53WwJZed2pATtoEbND58/FCgUN0wQq1E1sujSK1ugw0PIqNgOsQ0WSXXzVyMV0hPZOt+R+5fRJlRghUXnh/Qj9C4KhTJlUIcvkFO5eReqQqfDKewchO7pqJTxj2OUUthEiVXs2JhD2g9qOzv3xlMsujpLBUQ3cZXxMAk6gFfO27BCpl5CSics3hTQCKMSaZO1/dkjFWsX5D3FKklOQ/+ePrPcE7xmX58+C1Hc0RMbrMZHsCWtS/R4IG+rat0xv0EA3ZSwdBrM60YceB9bfb7BXcOGJ+/X1yxS3Il/vVgG4kdraQQY3I3z1/OUGj6PkLEz4enlabjpah+ogENp69fe73slIiU/ElZkp2o+9yrNzMNAAHmPgCjjzqdr9aJG8kb4TFVMyBT7AGpXgWQkW0bnD2acRkzJy8/b2j5jHfRjhmvL5ta8oOHf0Y7gyA3/p7wfFK5hxfJ21CIu998NyDUo93Xq+/vEog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(38100700002)(6506007)(6512007)(9686003)(6666004)(26005)(186003)(33716001)(53546011)(66476007)(66556008)(6916009)(4326008)(8676002)(66946007)(2906002)(7416002)(41300700001)(5660300002)(44832011)(8936002)(478600001)(966005)(6486002)(316002)(54906003)(83380400001)(86362001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3WAy5YT2aJby1sjI1m0o++go2/K2yJoic9pmTLnJk/CBOUyp/e401Dy2fJ6?=
 =?us-ascii?Q?hdstDvFa1K5gWFBQu+yrUAgDMKT/zF6YiLqQ9g4Jmdh28IVudDHt24D8QUTE?=
 =?us-ascii?Q?2nH4UZBARCjD4FEGkrxAi8ZJRfTImULHHmctZFsBqMfqoTMHMLBXGaCtv402?=
 =?us-ascii?Q?mzecHLiKBodwTDMIhbXX5d8XnDBZax2X4SkjmhEoqZrloIf7srv2W//z/Agj?=
 =?us-ascii?Q?WRcgees8DIbcmsVNDo3GC0FgRA5QBPdFsA7B2EvpQYxOCWhK6++lUzbn+NvE?=
 =?us-ascii?Q?sJFy1qgY7wtyqx7FbMsInnxvTSmeOD66+CWb4O+LlnIVZSvft/IrSA8LhcIU?=
 =?us-ascii?Q?40aRZmewIwO6ONUBb9DjqLzpUcXp+h7jf3kk5BAmQoj/6kzN6TCJCm0w6z/J?=
 =?us-ascii?Q?w8NCuhhKxNuZO9EeSv8BmIF6lPKlm/9TmBk+1vJNc4aJcCZLr5DHglNSjKje?=
 =?us-ascii?Q?2ZLkyLV1mw+cHCNME1prWQyjPD8bwKcZ1ymOowxFYA6ybooWj23lQ3KJhz3A?=
 =?us-ascii?Q?TVSuiGUnM2BCQ5pnE9tgpYYPA2EA6EHWfbtBPBRdm4cQvmgXlTOiXgTggAX0?=
 =?us-ascii?Q?cAdIM2THg6I/wFcuHw7D4taW78Q+xqhcQyT9YUyzL+X9892ZsFdYh7FR+Atx?=
 =?us-ascii?Q?Tg3Jw1mPWko+OsBldm/UV4p8+aKuUJDe5snaxF06xTSfcEOqBoJOqNT+Vj6G?=
 =?us-ascii?Q?tQGei7vEw5zbWIb3i6/hbwcIv1+0N8LlFV4fWHvrPBulc+mXi8y98y5+qg5I?=
 =?us-ascii?Q?W8bD7xa6Q/SHC+VIv6ZI1taGGwbs2xOwG+3p4yZm436J6K+Fk0KmgMqlFm+e?=
 =?us-ascii?Q?+9g6RShOgW18gw6O+LPYPP+HhMdK5/1JdIjzRS+bpKFz87RiDTDp4JwOy7zM?=
 =?us-ascii?Q?uiEKewJDuDYJJmeeQcLxKtNb5jIiKYMwIbDsMQ7wcj/RIE4YOIFtV+r+SAQq?=
 =?us-ascii?Q?U+Bh8byBDALHBtwCp8HtlR2IIYwW77lH43prE4KHRz+M9CtnoZwn2z65FuJ8?=
 =?us-ascii?Q?IyP/WFjE46uQAxgl8NBspvcoSyIi08972V6P6ttyRhAw022RAtustuuuVTvG?=
 =?us-ascii?Q?No9YV44RYqFiRxWB6043WYNTqU0/GPgA0Syk3dyD5UkEfE7syhCqNj/NuqIp?=
 =?us-ascii?Q?FpQW+kYAoMbt3Fr0pVXVK4G4bXx2e+7Rzh+2bwk/vagZCRc5LQMvp257oHpm?=
 =?us-ascii?Q?aaQut34YTT5JHJl23oiCfbYP6ZE31RC/5mcLUecVMvU5+V8NG02F8x4kg05z?=
 =?us-ascii?Q?q0mCDXjVrH+fEWKF0S2oYDs/YCQxsyOKba0IANCY9CrG+oA+K7hbWwHMgq9D?=
 =?us-ascii?Q?K/AxqUYMbAeZ8H8HDmONNWKtwCiqcH/hKKlxUgXef4uYZ47ChUxfiwEecv0h?=
 =?us-ascii?Q?JXnTw5tzf6qfzVU/LIhKpEPcuIN9poTngN9klyFIoU7iuDAciGrYK1VFXc7X?=
 =?us-ascii?Q?B7V8rPC9//0XINH7aEbcailJZlfcckKmj043WOnT4cMWlhMMa7o99sMs18rk?=
 =?us-ascii?Q?45jd/QNRwft0BkyjV1jIXxL8StvdHQQTV6UO7IPOSXVMgnESUdB0zNpwIW7+?=
 =?us-ascii?Q?YU84iIEn5SfPRYNnQwGdkbvyaN9Le3mBE8d7bl6jyyiSY9+nR9GOSTofmkTv?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E9hPK1T2DgWBHqyx2in3S9HgGCowtQYowEfOwu3GdCcLSeRlN+I4FBwitd2x?=
 =?us-ascii?Q?QUR599J7SkP7K7iWv6zh74EdM/Dc4fjVdJIB0l1ur7USD7ErE8yIWlD1mo8d?=
 =?us-ascii?Q?gyD83HSIH1Wdl5BcUwjUZ7RBIc07CAITAPT4Slj02Znr0LUQRHXo1LntjqF5?=
 =?us-ascii?Q?4ouuX/En41pMzQ4VEwlhSJwYc3dy0I4ry6ue3srZc92gDLHAi5sap/hOcn8R?=
 =?us-ascii?Q?ojxogeeoB1lQ1QUFH0DqrPtZi3Bfo7d0ZdM5xhtd/SdidXcVkOFpXR/5CQY0?=
 =?us-ascii?Q?M34FcF/ZiHGxC33guaMvdnvfw3AVVgr0YvumXtTyT/G+EwRl+cowFljmmTW5?=
 =?us-ascii?Q?ew7T8P9gFCAA8dryiqttSsv7SrWUgdtVAFAD0qksuT9q6Y0fj5KT9CN89yeB?=
 =?us-ascii?Q?pEUK9jKCUWEFC5i8SXVOF2CCMjeYSVhfWe0m6oEqWXZmKD89oYonRMZh6UnP?=
 =?us-ascii?Q?/AwwAWiUFWdjxWGqzwpG/uhpWWrDAIvqLdAZla51Wv4xg+pnbpaSWqW5zo71?=
 =?us-ascii?Q?9i8qQBQ9egOBLPgZtZQRC4t/fJP9ouD3WwCDjTCyloQkgVcpo6jjEsy/wVNY?=
 =?us-ascii?Q?MbdiLVT+e0BbAzNLYzc7WeIp2gxtnJxB3vvDThCHjhjv810+dWixV2qBJd9k?=
 =?us-ascii?Q?5tT+ccHigXD7rnKx9jM1o2qnkOZhwOOemLhyPX0r9+V9vIZE4tHG2/PcDvBh?=
 =?us-ascii?Q?ol2TMZurgxSHYG/Dm+CQ+qsz+uK0DqsaKgL1Rsvr5QIHd6TSrAX4DyW1eVxg?=
 =?us-ascii?Q?t2h6nNecU+wTxUqISCN9nPks8CRs2yD4Y84RkYQXdA+GWiarADP8+9ddZtzM?=
 =?us-ascii?Q?klNlfZM7xUs30VviWGs3UNGKfcYtUSe40py0WiPRUYy8vDASQuDqKPVIhbfL?=
 =?us-ascii?Q?kKJXHqiSmqqpKPN9MbJO4Me32L/PWOS3NmLRQUZ4bkhWyrV5h6eXyLOHPeMZ?=
 =?us-ascii?Q?XvztMNBOdj2JSN1iAFpR3xmHMPtjNMYQH7Yry/K+1d9nYKJI24q/s4vjYWbm?=
 =?us-ascii?Q?Ga6M06G3FBp9CgE7dPw+M6mPty2aE6SLcfTu1hlG1D0mmqkJgztiFg5DBCv9?=
 =?us-ascii?Q?leUKQUeyOSX9PN8FV3uPQegHaPT65I4e9PVNw6GGZGJygOK6r3gkHFrXzb/H?=
 =?us-ascii?Q?zWLe7Rk9TyJHDaHk4A6SSfJNAGtrh7OnPA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcabbad-7d84-47ec-675d-08db15cb5cbf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 18:25:38.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFAEExxEy6+eXnFGxQX3IlSxq3kVAJWkrfZa6bc9r37ASj6ZWfP22QHn3X+4hzpbzx0I2m7ws77fuc60rpQ6JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230152
X-Proofpoint-GUID: h3gqGWELnCGwAgkjYlRRhRdjEiFLQD1c
X-Proofpoint-ORIG-GUID: h3gqGWELnCGwAgkjYlRRhRdjEiFLQD1c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/23 07:53, James Houghton wrote:
> On Thu, Feb 23, 2023 at 1:07 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 22.02.23 21:57, Mina Almasry wrote:
> > > On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 21.02.23 22:46, Mike Kravetz wrote:
> > >>> On 02/18/23 00:27, James Houghton wrote:
> > >>>> This series introduces the concept of HugeTLB high-granularity mapping
> > >>>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> > >>>> high-granularity, similar to how THPs can be PTE-mapped.
> > >>>>
> > >>>> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
> > >>>> architectures and (some) support for MAP_PRIVATE will come later.
> > >>>>
> > >>>> This series is based on latest mm-unstable (ccd6a73daba9).
> > >>>>
> > >>>> Notable changes with this series
> > >>>> ================================
> > >>>>
> > >>>>    - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
> > >>>>      mapcounting for non-anon hugetlb.
> > >>>>    - The mapcounting scheme uses subpages' mapcounts for high-granularity
> > >>>>      mappings, but it does not use subpages_mapcount(). This scheme
> > >>>>      prevents the HugeTLB VMEMMAP optimization from being used, so it
> > >>>>      will be improved in a later series.
> > >>>>    - page_add_file_rmap and page_remove_rmap are updated so they can be
> > >>>>      used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
> > >>>>    - MADV_SPLIT has been added to enable the userspace API changes that
> > >>>>      HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
> > >>>>      changes in the future). MADV_SPLIT does NOT force all the mappings to
> > >>>>      be PAGE_SIZE.
> > >>>>    - MADV_COLLAPSE is expanded to include HugeTLB mappings.
> > >>>>
> > >>>> Old versions:
> > >>>> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
> > >>>> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
> > >>>> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
> > >>>>
> > >>>> Changelog:
> > >>>> v1 -> v2 (thanks Peter for all your suggestions!):
> > >>>> - Changed mapcount to be more THP-like, and make HGM incompatible with
> > >>>>     HVO.
> > >>>> - HGM is now disabled by default to leave HVO enabled by default.
> > >>>
> > >>> I understand the reasoning behind the move to THP-like mapcounting, and the
> > >>> incompatibility with HVO.  However, I just got to patch 5 and realized either
> > >>> HGM or HVO will need to be chosen at kernel build time.  That may not be an
> > >>> issue for cloud providers or others building their own kernels for internal
> > >>> use.  However, distro kernels will need to pick one option or the other.
> > >>> Right now, my Fedora desktop has HVO enabled so it would likely not have
> > >>> HGM enabled.  That is not a big deal for a desktop.
> > >>>
> > >>> Just curious, do we have distro kernel users that want to use HGM?
> > >>
> > >> Most certainly I would say :)
> 
> I'm not sure. Maybe distros want the hwpoison benefits HGM provides?
> But that's not implemented in this series.
> 
> > >>
> > >
> > > Is it a blocker to merge in an initial implementation though? Do
> > > distro kernel users have a pressing need for HVO + HGM used in tandem?
> 
> +1. I don't see why this should be a blocker.
> 
> >
> > At least RHEL9 seems to include HVO. It's not enabled as default
> > (CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON not set), but compiled
> > in so it can be runtime-enabled. Disabling HVO is not an option IMHO.
> 
> I agree!
> 
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y is still the default here; I
> made sure not to change that. :)
> 
> >
> > Maybe, one could make both features compile-time compatible but
> > runtime-mutually exclusive. Or work on a way to make them fully
> > compatible right from the start.
> 
> For the sake of simplifying this series as much as possible, going
> with the THP-like mapcount scheme that we know works properly seems
> like the right decision to me, even though it is incompatible with
> HVO.
> 
> Making HGM and HVO play nice at runtime is a little bit complicated,
> and it becomes worthless as soon as we optimize the mapcount strategy.
> So let's just optimize the mapcount strategy, but in a later series.
> 
> As soon as this series has been fully reviewed, patches will be sent up to:
> 1. Change the mapcount scheme to make HGM and HVO compatible again
> (and make MADV_COLLAPSE faster)
> 2. Add arm64 support
> 3. Add hwpoison support
> 
> If we try to integrate #1 with this series now, I fear that that will
> just slow things down more than if #1 is sent up by itself later.
> 
> (FWIW, #2 is basically fully implemented and #3 is basically done for
> MAP_SHARED. Each of these series are MUCH smaller than this main one.)

By asking this question, my intention was NOT to force HGM and HVO
compatibility now.  Rather, just to ask if there were any distro kernels
or environments that enable HVO now, and want HGM ASAP.  Was hoping someone
from Red Hat would chime in: thanks David!

FYI - Oracle is keen on HVO to use every possible bit of memory. See,
https://lore.kernel.org/linux-mm/20221110121214.6297-1-joao.m.martins@oracle.com/
In addition, Oracle kernel has CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y,
so it can not immediately take advantage of HGM.  That is OK 'for now'.

I will try to ignore the mapcount issue right now and focus on the rest
of the series.  Thanks for all your efforts James!
-- 
Mike Kravetz
