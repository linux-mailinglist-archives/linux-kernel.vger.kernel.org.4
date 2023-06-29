Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBF741DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjF2CDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjF2CC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:02:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEC1FC1;
        Wed, 28 Jun 2023 19:02:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SKnWBw002772;
        Thu, 29 Jun 2023 02:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PIf4vA/jjlAP73nhz40toeTTfUCkuQRoSB7aYcLilH4=;
 b=YIezz+6/mYZkIkx5RfjDcBnC0SBBg7qFC0BVmeq/uKCwzLryheFZK3EAdL/eyrHBxVzm
 7mzQdFrA6DgzcPZjfunf66uOe+pKtAt6QoZVefUKhqmxefN2mk2s8QUh88XKRcXutupK
 vVIupf4teIm7uL9+gI/MCX85Hl2ti3T3kl++pDzI4SVn3bAj8eSHusRhQ3+mo1GaUnl9
 EeLu4MwOOcTNUb6tAtRpcZxT+e3mTN3s3dte0C38rO7tURfSJB2uCIHWs1N3KHUYcuyM
 1MkWoOP6A+eR1Kvkq97qzJjo/x0jOke4kJmtKQkbJx/DtvxTo4SvpU9lWS3qDEEbg2hH HQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93a1dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:02:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0EASN013075;
        Thu, 29 Jun 2023 02:02:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx7289k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwRS7JobisLc/Vth8q3EFWMvddYAUrM7qje/wJVerUtTdQ373q5FgXPkeV1aSetpQ5A+9j3rE9ewSTs/C02NWWNXWvkX/w/UtYMy60O9OPOc/O5BzR5n2cmODAx+RC86I+AeJgEHzprtLeRRRwsgNUF7+TVy/BlfXfQlF5ap+aPW1Uwyks36yvALkn94PxoSm0MUZwpgI/ovrg0suCw2k9Gmy94Hwtul6rzpMkC3+Cihf7zlADs3oiy31bntb9IJhCu6hNRXKMTZJ27VC7z7op4RW11nlBTjlC+gze8sneC2cn05Y7UnWVgTVaWxhHuTCu1JQSK7EAkDlDooqm3yWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIf4vA/jjlAP73nhz40toeTTfUCkuQRoSB7aYcLilH4=;
 b=n11J8+oSwF+H2sfDLud3nVL4YAxsfn7ke0VpOrOEbVcw2wShPwa2nrN9AiwfgJKz3BhypMeZ/Mlwevrww5RnkqfImxiA7e4fkZvgc6cpRFHNMhRHErm6B1UmnDGwGHh2F8r4w7vmgdHyfCxemwMEGknxRNdZBnEV1F5/qEzOYi2WxVwqh3qBGdBHDMrCy01mCFV+1DbuUgTRo7NBEsKj5xzLR2XEchl1+UnIcQ987y2L6Lsg4oW3+sB+GYX2rY9BpXqhsI6qhGlm/KhMkhk3qsCohpDWF3+sC4t55AI3AB2jGq2n4Sdoso+wymbDZkpQ02jakzwa10ib5FSLVNjtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIf4vA/jjlAP73nhz40toeTTfUCkuQRoSB7aYcLilH4=;
 b=t/wq5VnOE3jgs3a46WScZz2j2vFsE3+Uh4E7xGKVoB/Ht4CFYp033DOmrUBq4ci4FvHwnesdnLUrRJIfX2CjsoA3ieGekFbYiv7RzLz4+V6nj95uthd8yE6r0MOhHrAvMFJYXPdCTmWAM05BXFFWrhDOF5IQwTtOVz1KioZfQGY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5736.namprd10.prod.outlook.com (2603:10b6:806:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 02:02:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:02:41 +0000
To:     Chao Yu <chao@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, hch@infradead.org, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
References: <20230310123604.1820231-1-chao@kernel.org>
        <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
        <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
        <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
Date:   Wed, 28 Jun 2023 22:02:35 -0400
In-Reply-To: <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org> (Chao Yu's
        message of "Sun, 25 Jun 2023 15:07:40 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba47fa6-002c-47fe-0891-08db7844ec02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf/Wd++vdeBPXLGAwvQ1oPmV/B6ik5ftxNSitohDJgWZa5VXtRl463Dyk05nXgZ8ZV75GLc1MTfhprOSXnYOP/RwCBu7UJyuixXbQNrzfZW6nwcijb7lKFLRTUs4tFNMAm4ODA25ubOSucOs60mX8kd9Zq3TCAw6VskSUAZn98uK1hsz3gs6t1jXW/xtkWbBXnFT9bVtQW42KQrjXjDMk6btPDHmolGt4owiJ04jARi5/PwuUblvIZV7TUEoX2m2UQhOMFqp8Onw0bxaY7Z06ZNABehbqBkJzqnj6oP/xNXNdoF7e+szgbPBr3FOI2T7AERoUhW5wGktRtXAr06l9jnwQKgZnDt5tJLCZb6Z9KJwHZFqeXVlfP8KwaqNXdMDmpgrwyzkNlGTVZugPlRONsdzRcZsLXPFASdN1zMARgEXKBIPZ5EdZv0NwpMwtkK8nBaZ32F0vX0lGxPfyyQXwCInD75Nm9IQFw0gE9FvU0Rh/RVKAn04+lLzCqt+X0uxg3ATs/lupg8HkNooEkU1cyg7WZBsZ0Ms2m9Ky9aK+96MaYyIX6e2fVLYXzUQi7xV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(66476007)(8676002)(41300700001)(66556008)(316002)(8936002)(66946007)(6506007)(6916009)(26005)(186003)(6512007)(478600001)(36916002)(6666004)(4326008)(6486002)(2906002)(5660300002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzdxJ/EwkWPKpCxFqYQCRscPRVch4fDZhj9VLfGgFbO7+wjYeYRMMX63YqFN?=
 =?us-ascii?Q?kbqKylrLRFyiXzS8Dhigt+wdg62C/M9QjMfcKaoijee2ZZ+cGkir8OVX20YR?=
 =?us-ascii?Q?arleMHLU8j0Cl5XJpA1tZh+d+3lByr+ntUWUKOkNS4MlMHeDls7Mnjq3R1PG?=
 =?us-ascii?Q?nwXrdfVUG9oab/0wSYEC/SLw7SrIXIS5JPkxmLN4jo189Ty8ztWKjgp6T83W?=
 =?us-ascii?Q?DBlhVM1DA4JuCzEfeGWgodMrW0nadQKzAhf16bv0fYdSc3FZZc44+nEtSgs1?=
 =?us-ascii?Q?LBLG+LqrSblwFs2+0Io79K4jsm6UHCwojxat7XHFPswwOJjSllNDewH5kKL6?=
 =?us-ascii?Q?irhgDb9iPfSQOOVOVMPZQILrZwdR0uZ0ChdS0+4LT9gyCoEA95hVxvr9EVDd?=
 =?us-ascii?Q?jC8gOf4/Cx57ygqupYNcI67BgOLu0pFo4gMOmUPKHR08iTHjnNl8lpa/HaEf?=
 =?us-ascii?Q?O6DgKI2tZi0W5PgWeT5CKR9gvMzhIDQwvoWtSHgG+U+Uh4xImpH2MRx3erqd?=
 =?us-ascii?Q?PjV/NfvR5LLQu/xECutO7y905QTY7RpTzzr+eXe92tfJZqow1fbodLC6gKxq?=
 =?us-ascii?Q?J1L+8q2739p7Sd9d0UhLNFDtftzRY0vTrDWtkgpaZOTxon4u6a8XpP4JkhlI?=
 =?us-ascii?Q?xq3HYR0BIkFlSXx6BQtObJ6Z+BD3uopVtpJfilgVSm5LvteE5YDTvxIi4qox?=
 =?us-ascii?Q?sH8dQqSe6rZWFyqLjkrx90UbZU2WYRRLdwdcj+05pKdVv7O5pYIjg9IyZWdy?=
 =?us-ascii?Q?B5jqzDZm1wFpC3jtboYK1j31FrbyGZj09HA9vHHZI+MLnTE7aNQKeGFP/RsF?=
 =?us-ascii?Q?AyUHXpQkMPMuOBOPrMZt9gVaKUdOMUYhCxvxYc8C54f/7zduYXuGMyeU/EVf?=
 =?us-ascii?Q?ipWpGxqDYTsOHhI9fq7NYrSOvNbx4KpStiIp07eS8p2cUdhWkM1AsX6cvdSP?=
 =?us-ascii?Q?KLJ0RhByqi5PqeO6pA6HSP+gi1KWCYLa/pg+7UtIuojKSJgf0tgcntw1wWhb?=
 =?us-ascii?Q?4fc1FRddG2ZmbsPFiJiU0NbbBkvsETrHqYh4mZP/IYEBxdcjedLOxZQPypep?=
 =?us-ascii?Q?xhv6j882yttJT5jiQrXGAyYHtAo+sFIl9Yh0CrDq0kSGOz8cWlnq/RQ/HxgO?=
 =?us-ascii?Q?Cjy3z9b9sOlEazDIZnNYlNfmvStTTqODnXIcyk7T4XH6flFl+DmjsBE1nrfM?=
 =?us-ascii?Q?kCmckvkKwfZmUKLvYJOYdobSd/seQzlq8r1wRdXWbGzleatZV23X4rYoZGG+?=
 =?us-ascii?Q?gbju0s95Du3XcuHyex+xuCvzzcN4s9n+Hn4FSaZwVfkqkOQ6ndtLVRAWHuiF?=
 =?us-ascii?Q?HHEFrtgeBpe7n2S0pxXfioyI5F9wHS1ILSKmoHJthmA1vfQWAKTRNe99/pEi?=
 =?us-ascii?Q?xiqnl+HAbcjbjvJyzOgp09RseOrRIl42nW6Q65Hc5QUM02+2tvS5FgFw4Fy6?=
 =?us-ascii?Q?HDHu2Y6dIQzwlD0jbmBSlTDajJDavnZ2RxUPOA7+z0eAou1rtvdeUCqCOiA6?=
 =?us-ascii?Q?SZKM3BpjggVZ6EuHVMR9t+5EfeLmJG5ofR/64nrABGUmkLrRsd8+ujfxlCPg?=
 =?us-ascii?Q?DkYALcSAk9KZLhoKYmVu+ChHj95Jj/brHvEgU/SriJnBpuXiW990tH9F29y0?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i9QLiFOQaYRvCfyl0SPx2VFvj6gMYnWkDoRt8FHHYF33NHqA9oRiAYicZCdIMJ51OW7MV6OFUtKnscQZUU7D/Y1dwpl/rFPMM4ycO7bden7TbW30NdTNWJupvOzqDi/XEVXik4CPvHVpRqRMyBdWHh2KEZU207ZNJRcJ70ojZIL6figDWWNHVpPAV98mUqx6WUVUmuUjOJheU+zI3M8x4eMwer8lIRDP0wNZRGwW8vptosjnPzm7dQZ8ZiggSG6RsmGLsy6WMmxKpzt3oUmzJhQezNinsXl/YNhsDFDqkRpPsUwwSLfHEcmYofJp1qWkjpxrkZ0hwwT3fOoyUy5Pwpq12kWyl3fbeIMLosUJVlXrr3WjfQiEGx+yQIh48z9jK2zNkDS06ldNbLLo33pCh+NVstrGj4gbtnqGK4SJhONeWeJ/K6/CGCMQLzRYZfEX3DF7k9xW0JdpvbYRAZy/kUUY3h4AHzQ6X2wYailAJ2u94cWXeA6k0azmgTzylC/YejQFpXKXtKOa1Wlx4SldI87+cqwMYR2Ontyv6fraaJVziwFqZ40SxCnoqcKFA+/6pRmYo1acU3Yc/KGw9MJazV35o8e47eDqzmfyzVvoHxZzhx1O4/nBnAfRlnltUIQOQvYB7s9YAhTZswDYnQrj49NLT4fhgaKKuh4aoebkkxyt8ezkS4bgisOYc2Jf4jwoyCejuRnIqDcJw/5xLvUz3nE9roCchuTMXJ0NlVK50riZWhmonBSMrlv0lCdh0l1tzhwFbTVdLBPuY8P02Vn/lmVxonXJZ3I3Bq88WBd48l8YPRo0T4FdpCNUBM4LtFw6+4sEc1jw8jutbl21Rh4d+TTK8UQZqaiPa4SSz01uFb95GSBmfnEieyoOv4iJdfsS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba47fa6-002c-47fe-0891-08db7844ec02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:02:41.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPj/ZvZKkovXFIczDSSfkxkm9QEx6pnrxDAl9H6GgOC2IJFtPWcNui6qr2nyrKbqNq86saWeubncRaXtFp41AX7XYstE9jtMPYQKg0sFxGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=667
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290017
X-Proofpoint-ORIG-GUID: eDsyJDyyoRHigBIwppOG86wH8Z8_7moR
X-Proofpoint-GUID: eDsyJDyyoRHigBIwppOG86wH8Z8_7moR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chao,

> Any progress on this patch?

I'll resubmit this series for 6.6.

-- 
Martin K. Petersen	Oracle Linux Engineering
