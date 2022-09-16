Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378D5BA404
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIPBdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPBdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:33:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E43ECEC;
        Thu, 15 Sep 2022 18:33:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FNnCUs020734;
        Fri, 16 Sep 2022 01:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rYJABeZF0C6Fx2BVJDyaPIU9aWDQMbTsnofBYocBf3g=;
 b=JE26tzXfp8p3LBjsGlugUFfz0m48iS4XHgGBicBIrxeJfDNmopv5VJmVQhQyv9yoWfuc
 qk3mklcVaoJglE9hLi8Wd21RJHJ5EpHH03DrfFiz6+SQijJ1OPJkzgQ6TMO07eEUBoKX
 c9OVluWZWl6qXuiDEjyNcM10LGEdehEhEonHuyqgt3G9uWY0Tx/vjTPig99939/3kGSB
 jJZMtL2u/4qDTDjwYVtiwxmeUg8kp6ypI0i6Lu5dmhf9p4kby2mh5D9gGIRKcEa4X3Z9
 KovuE8Gi0SzR2g8TZIFttGpNcWOyOBETICXy+dlqZcJ1LLxNbb51M8sFUla1Hxglv/Ou Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xc9292-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 01:33:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G06JsL004158;
        Fri, 16 Sep 2022 01:33:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xen7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 01:33:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJUKEKigno3a3vtmngqUtE5GZNlPAK0YbmNgtCPq45eFWblCAHlcdjA6r5Ta25ztfJWakE9Fsq+uu/epMJQDzxeKJ4iPzlElEut+Mw8fLxdC13SLYYZiRPgJM2h6IuWZnuOZKX5AYwrHOMCQwUrrvjRs2u8KNHatVTU/NrCJ0DTrKR+rbYWks6aRWaDA+1kH9wdnE+o0wHa/XdUAvfbSrWrooCMTOOd7lauA9GLxLb9FaaJqg2uXAE0lSMwfJ7e5A8eKV6Lg9K60JdT4htG7zFynFnzdTMjfjEZg/wzOGPchEGyPwFzcPfHJEPboR/Z33kzfwi5tdctFqEwso/1VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYJABeZF0C6Fx2BVJDyaPIU9aWDQMbTsnofBYocBf3g=;
 b=fRneldTBLsHSb7YF62wSX6ImPr93iLbB1qTUIEylnjIaU3pkaAM/cRIJsXKc1u1gRUir0Su3L8BBbIlIqkgaBDsSZUTP1zkiSqGBZ5a5GZZE46hy77KDVt/RHJsybVM+X3WKWCNkegmOuzdSETQu1t4BDzEFAoCtoSf6LMFTiIBXlCPyuLiF5wkZF7HrV2jl+zU99h4xLwnM/pmwt0jiR1SFecsncpiNJe2YfzsqjlKY9BujTuJeDp8FsP6XBB6TZ7AkGrIjAET2ZT9W+emNu2yivzUCBp/f2ykJ4/9DqmNRJeVFOyw9xG59mLqWNSsOQeJYqP3O1M63ECpHFIKhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYJABeZF0C6Fx2BVJDyaPIU9aWDQMbTsnofBYocBf3g=;
 b=GgsEaC9qoGx3LGtlld8EZUeZY/mkPHZcgyzUgeMFYusxOtkO/qAEpKy7ipsSF7K+QF2WQ49uZd/8yAxh525l519ZzbybqxdXTloz90kkW5NGdYoeEtvjDfoNojyQF5ZmbGbaV2PIX3mEFJj+SEYs6u1vpRYLagCELOoMsi7HJv8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6712.namprd10.prod.outlook.com (2603:10b6:208:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 01:33:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 01:33:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arun Easi <aeasi@marvell.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
References: <20220907233308.4153-1-aeasi@marvell.com>
        <20220907233308.4153-2-aeasi@marvell.com>
Date:   Thu, 15 Sep 2022 21:32:59 -0400
In-Reply-To: <20220907233308.4153-2-aeasi@marvell.com> (Arun Easi's message of
        "Wed, 7 Sep 2022 16:33:08 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 43433c2d-13ec-4c59-0d3e-08da97836611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4e4GSLCUwEWTCT5PWgoiz4DKMS7tJh9O+0zo6gXILqi4m9TLuat2vKhsu1Fgda0hXuTm5QXiF9d1OAf4kjQkGmjWzf6pfT9vS9DaARwhRDykHaGfKinoo8cBcu46RnSBsXSbPE+77QZBAD8bYpucNto+axPlndlWxzrWt2HLJNRBH2CltG+OeYw5oRmwjLCuftOvoIMG30Jt7BJ9PyrbpqOukOklZvx1IiMoJJiFN1uxajIJsaEDsIDOrfmZYF0pQqHjHPSRKWkGwNWopwTXy7rNqqFgXEE8GKaaZkyYGdHW3xnRM8vD85+loTGjJT1vncVJiKw6O9wehicbftRCRlWNfWoBR5W2CRqAdlNz09QKFVt8EXLyu2mYGhLPhiQ6CRKIerReq2fFUocjS6TJjZh+P594mLkX0SAUOnEdeMbYoalUxjsNeLCnf9xMae9VYe5/Mhyv3TPokzlBzYEV7XV/cGOr/Wdj0Ga5tOKNy7v8JB5DHot0jKuQseEOXycTv3XuildCLgwvGwdTJHVtSzHSIIUxbKaIg2SOPrVpgVmp5b3XscZXX5+BgegqyiNCZGZRwzQRQY45xC6KpD38wi+Y7JR/ci9Lqg2AKQ80qcoCMurgkeSo26SCHN38uuiNcf3vHZq6PuHU5kkG6TFHZQpCWEvtzNB1IMbx5li+7JFSP2o+hP0mDSsuqywUeh9iu0OWsv4uYmNb2PhuyuGGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(6916009)(5660300002)(4326008)(54906003)(66946007)(66556008)(38100700002)(66476007)(86362001)(8676002)(41300700001)(6506007)(8936002)(478600001)(2906002)(6666004)(6486002)(4744005)(26005)(6512007)(316002)(186003)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kw8B3g8e/lCT+Ff8gMWLR/nB45Atg9GbQxKR/UNoL19pYMbKA9mQiqgc0gnq?=
 =?us-ascii?Q?gA50yqzTfHjTd0nJHEdxajnSuFESbP9xXeKHhvcfHE2ii4PiUy5e7tzMMiZE?=
 =?us-ascii?Q?tiVEs1aFa7tS9WAt63NaMyhrwKEu/IJZtqXYhmkUHoCyi9sfjwLM6BDcePJj?=
 =?us-ascii?Q?Fetg/JCcrxXngcGjvt3ZbZbaLWjWgU1HBiKIwOv35ozNU7e4jYv7JfgTFzjK?=
 =?us-ascii?Q?5MCz27CpruOORcOOWI3A9jOHd5poHidw4WihnLlvdSS/ALoVygLqj1b+6U6q?=
 =?us-ascii?Q?pK8HX/5mZ+LvJg4bOA9R5VZzHiiaRT7WgOkKZv2x9pd9sG0uaS/qYLveCrQ7?=
 =?us-ascii?Q?WhtMCYYk5FJO7Vn7M2dE5y0I1uaqqzowX3pPPo/QWbdbYifHHXA8TqzAhY3z?=
 =?us-ascii?Q?+0XOsnRE/HUUSPbHt9tY+Arq0U0cS2lsBMEJnGzGupTbCPD+I63IrZpo2bzC?=
 =?us-ascii?Q?0vn8gUKLOLdMNf5hfzb3Avb3Q2aYI31JAFivxOdAS8wGgkxDN8Om/2YV7roJ?=
 =?us-ascii?Q?57IBkdawJvIqpuLgnAfGfvgy01Dpoi8DY9TseJ5aq3OkUezmbug8itVikVT5?=
 =?us-ascii?Q?pm16jLkn2aFLHd7y1u69EqdNYrKvXQZomlKvnpWUEY/V9NEQCONg0ey3uLTl?=
 =?us-ascii?Q?H4slfb4+y1/dsUuGJEBKTVWDMgQknaCqT47eLsr2qX1IfrWOdF5HMEFfevbX?=
 =?us-ascii?Q?VNCtIn9lONZZ1kdEKj9b3VVAFcOupEumhzWmHghRj4RzzjqQ92QAx9IfcZhB?=
 =?us-ascii?Q?7Kiq2gH3wLWSvGmuO9CMIU8bR8armirBerCbPd3MUJ/ezHuYO6/SjOBpl5Q3?=
 =?us-ascii?Q?n6i4QUixE1M64DLnLmhHE0qFlpVin8ih/tii4WoQwxxn+WVI4PPvXM25hgTy?=
 =?us-ascii?Q?P0HXNDxSHb+H9cFHigikiGCBc6WF94T9/reAfJqU526Mj0mRGloAsVmGvP1c?=
 =?us-ascii?Q?vL7k0UPb2x2xzc6erwkddNMgbpImPyI0t/e05OF81Q0PPaCvGp4Cl5mkcgBi?=
 =?us-ascii?Q?j/DtoeqtubSrYXUn6ZilzT6zGFxLDa8Mz0OwmnWBaDjLMpauv9eAKM0xf0dk?=
 =?us-ascii?Q?FfWqjcGKB/38GQLv3+nAw/vtO7SefnbFvY8X8gW3QqRSUeIXDWLbly36Alik?=
 =?us-ascii?Q?IGw+KPC23T4YlUCjtz5Lx4NtR0urOk5k6z/xLQzUhexAAcV676va+Ztl/Izi?=
 =?us-ascii?Q?nP4SVDRiIh4vG2fIcTzs3b0qrBVVjYb9D7ZJ2fEg/+0JB72c67b7O5JmLYt9?=
 =?us-ascii?Q?ymszdIxaMZjc2TOAQuugWjejIQAwoiisk3q+Te1qCbhnPqtOCymH2bx7jAsA?=
 =?us-ascii?Q?vjqtFbBUYxb7y7x21a8n+fhuNAQUaWXI5929++WO4lzJRw9wFTTWPMRyqBQQ?=
 =?us-ascii?Q?H4I7dIkus9orUE+HsFHzS+kknEjR9GGOBVCiuhGo0b4NM82QNntEE7bEpnTi?=
 =?us-ascii?Q?1U3Q07K+dV+vJoVrOYhs6g0NV+jC471T5HleDM2CPWWzklDdQOsjjoRR1S5+?=
 =?us-ascii?Q?J5WaJob4QFQjm9tbhYWrhWp97wtWEx/c/HvmNmDDLh8MRkUV1hWyVE/UT+ed?=
 =?us-ascii?Q?KCvu8w01kk3lL/X9q4jIqdGlImHaWRPEVw9SGKjDdnafpmDnISvQY+IrNhmV?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43433c2d-13ec-4c59-0d3e-08da97836611
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:33:03.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfMofa4ZvNQmM54QGyFWONLz+wXSl5FnL91JcB8Z4q8snGV4F1h4ZRI6iHeNHc7Zvdj7k9bmKM8dgVvl+UhozsOtxUsm+zg2153h6MYLBe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=913 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160009
X-Proofpoint-ORIG-GUID: -0GeFvrwt1GSPxArYsiOhVXhM1eTNY0X
X-Proofpoint-GUID: -0GeFvrwt1GSPxArYsiOhVXhM1eTNY0X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven,

Can you please review Arun's patch?

> Fix this compilation error seen when CONFIG_TRACING is not enabled:
>
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
> 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
> [-Werror=implicit-function-declaration]
>  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~
>       |                         trace_array_set_clr_event
>
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
> 'trace_array_put' [-Werror=implicit-function-declaration]
>  2869 |         trace_array_put(qla_trc_array);
>       |         ^~~~~~~~~~~~~~~
>

-- 
Martin K. Petersen	Oracle Linux Engineering
