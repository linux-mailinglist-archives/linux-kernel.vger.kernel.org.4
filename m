Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F16C9CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjC0Hog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjC0Hn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7A5260;
        Mon, 27 Mar 2023 00:43:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7UXru011933;
        Mon, 27 Mar 2023 07:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nDoC24lVfShOVXR9i3dk8W6SQsGYGg1ltJYLMJanUDQ=;
 b=ARi7pozybbhOv1N5ODKahjXKB4Uk5eLDXBdXPt9b9wbOxSqmYhq/8c6mOsqtg6czr/8y
 WD3LWs09j0oLGMgqHi+GjdW1h+WZOAcQeI8UqL2pyaSaBpKbErnnJrCMjCy5VkHbcDK7
 ZSn6ksBiW66gg0F9Wngc5NoPhYnKmUpNwBD46dCGjbe7V1OIMjJcGdALyuyiHHnaZ5op
 lTm2Rrbzieu1C+1Ne6ScY8HoUgHOUpEqeqpcI2JQJdCVgd6Xe3zXIozegeQSaNsJgyHw
 ll518HRq0E6JzXCGRSh5CgieikP9F82RwXZBVwfDLpk1J65UNdfOJbxcFBqUPQZxOtbG tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6t581q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R5wg03005499;
        Mon, 27 Mar 2023 07:43:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4d5j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQaQOnjkbKw3k+/TFvaTQijPEH+zY23Js4UiTdFPlYPypb3wwXk9f/KZHFMWDMCAeM09CVRya1SK3OJ+sQ2/YlnoEyRELSQfnXZ7lErAK+HU2PcZ9H3eZ8YMnd72rirBDixQp67AlW4xI1eouLctW5871LsG6LuBp2WhVAJr/M6V32aAgJhut9uln7Py99TExNnSEsWzU23UIXJC2XQ4DNgr3jjaxmQ8QEmrWo+yydLZ5X9jl+yJuIN61GHU231s1N+ct1zkNKBG5032gXVwNYqSdJKi3qwaEfYSOciJSAHW+1TiDz1Vcr4o/QCgRU47tS8MtQRuKnLp2XR0ZM0cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDoC24lVfShOVXR9i3dk8W6SQsGYGg1ltJYLMJanUDQ=;
 b=b3MAzIBRdc+wVDerYsqR4+Qxr9pnyEi85nh63YisZ6KyXaci1C35T71Cqxw3bwglcvcHej+9F8Vo7G2SUNppcEFHhk01CSf45GhLZpJQk1QqBIA8kUHQq+8muCYAKJbJGTp2SshDh76Z6U5qdhh1YbYLaI8wSwEBjqZQWIi4Pnc7oobGvSjnOmzSiYLK3SjLDbgDFcmTAMKZ/Ie4mJ7E4deSxgA7jbQaYHZk8d90KfPulpPS0yuqqWqy/HmPuKjYXzjPPv/wx2HfgmJaDi5pfSYBpzAZMTp2m7folo6otGnJrEKAT+HeJs4+0GWwaJgpxiWyHDimg7yZ0k8xcia9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDoC24lVfShOVXR9i3dk8W6SQsGYGg1ltJYLMJanUDQ=;
 b=vm1GMVX4pAid68h4zXlsch6uiakZtjJUuAzln13ntvGlkFzb+3gITOFf8tnMW9eJUUew8q/I4QiwUE7sfmX2zAsHzamoJ38VN5oBYeXhhs/HsmhX3TDb5A+9bvQFrzlt+QupXxorpqbTJwEl4qt19hnUG7z3dVBvB6Toso31eRQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:34 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 11/11] scsi: scsi_debug: Drop sdebug_queue
Date:   Mon, 27 Mar 2023 07:43:10 +0000
Message-Id: <20230327074310.1862889-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0b4ced-7563-4234-2009-08db2e96f806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ky43UUNCbFBPWVwMb1hVelU2AJO5VrbmyXDP0EGWTITmdu6HDIcqfoorcO67AR1TRxlMNnCb09g2ZhERMogZqPdLQAOMHNKZecgovjoQ6owfKXpwB2r+CK/K/JXZLFQjPS3Ht+xn9t8qlvF6KeQHq9dLNfgnzw1LZctVJTu56lCEEKc+KaBlLBWiJuDSAjCyjrw/4GpbTUO+q6LVyR/TeF5Aovf3ccN7ZWIEmLH3dEXuRVlreinDbrvBPdumVpAgbA6TDI2EqT9ie9NvSA32V9zD2yHo2LACOAbQ+duhCWJuWNK9v+Vl/QlVA8FFr36jm5esbXmqQ/HuI2Aj6hDI/MLWbjiBtq6bES/so/kmN3WhwNtLzh4mbFO3zs9dxjHiwtUTPVQ+izmXVt7MushNHkPdzwbiJSGMn2xVJ2zIWS/BpIck7jc+G9HjZ3ALxseP86ypm+JyJk8bqIHOhCuZu0wzH+uuqqi7AXa1NO31Z+xGD3fqPxCxvfLoupiFI6EIqeY5p/vs9+A4yDAtUg/jJqhLTdtcyEhzp1rcgZNP7HtMou4T/3buqsGAIiC5nltPJptC7YlbuIDuLgynRWH6k20IWcKW7cLC8o60Mm/yzy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(30864003)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uOksgQ4ECDkxScc6wqp4cO7DVVUbQlphfOLaHYPxPmdHttHcwypzuthAzRUh?=
 =?us-ascii?Q?bXzyi+duXP6FQ1b5GRTb2ixAi6CvQiTgKYJMQLqupoQwpyRz1M48ASJjd3kT?=
 =?us-ascii?Q?QktfBeLMKvzwnlahzOi+sVR7JfpyLgDmgKrynvy01LXaXFfo1HCAPOqsZJRH?=
 =?us-ascii?Q?iJzrsYr7C87bTXX2S9BYqhtUBNbhfqkgKX6oz1C7qOOcNtRfkshW8z6X15ux?=
 =?us-ascii?Q?3Y/AoA6Fhk5h2YqaoQV+G6mtRvv9JsgUiJrGI/5/vxBARAKqxpt4w3FpNEjW?=
 =?us-ascii?Q?oxOKy9PsVRuOfo3YDbMMQaY6Xxs3TmJ5NI0Bxg0TU812+BQNuLMwZebU7Igm?=
 =?us-ascii?Q?dth2uGIdREIH2eCgqi9zTNNX6FktcSRnn0AHsjTK2m50hPpPcdFXVJ0gXSLs?=
 =?us-ascii?Q?or1k5chadvUt+jatVcxG1r+X0u/4FvTE8wcwzj1HD4cbjcQugowlTYD+RayH?=
 =?us-ascii?Q?XfmUQ8T89vfolwYt7vwm8vFTv1SXoX9sAf8gVGlXj035rAsLIE/1dJ/tnF3v?=
 =?us-ascii?Q?cJFJCI2AYniuYCah5PCsZwB+iyxBSSYUywioC8CWt0BFyJwh0MTBU/deeEoV?=
 =?us-ascii?Q?nU5PE2wP4m/vZkBGhU3oc/cUm6NP95oUBi82moSkB2m9UWtH6B1nzxmySS1V?=
 =?us-ascii?Q?+4W9WtGPboz4/1Jt9++2u1PdkUxHRTsnN7yzScUvafZ7Oy/KhkOYamn/gbcE?=
 =?us-ascii?Q?gkn++UbmO75K3JA7LMQAE5t/Hf9T1D5Up994tagaxhihTRBgaVILD3OPmUgV?=
 =?us-ascii?Q?JMuvM4C6KOjRXNaLubm5yS4mqMTDcooFVNcOVeTjVU12ULniv21Dy/qE//GT?=
 =?us-ascii?Q?nM3j9RXcXdygBTFivd44gwTqwOIMDX83xlxK7WHX9zqdLlqcveMEOlkNIEYJ?=
 =?us-ascii?Q?rA8VECKlGd2cVymng/PP0EbDOGh99FPXRe92nSIokdtSX8qlW4/thqsqRu+z?=
 =?us-ascii?Q?yzCb0OkgnAob9Qfde4SCV0CiZJPAH1vG+BGl0Y/2ahWG7J9Sf6YvWg5QCDqo?=
 =?us-ascii?Q?h2QD2VaLfR1JgNtCQtkV6Byt29tycSBlQPEBw3XI2V9fBzXspaHM86VhiFIU?=
 =?us-ascii?Q?vF1oac74hqVMgiDY3wnJoQtE2S3fWRj7sarZ1erNJu7KpFBES6fwCiAk76GH?=
 =?us-ascii?Q?15ETm7+0rZbuQBrUH97dVubN5enjbE+7VtzBEhy8F9bJILRplGA4epT6tLmu?=
 =?us-ascii?Q?gbf8dLix2DIpQEf/pngyQIJp4e59VauiE6G4RdhUInqJb8rlfg9ZUI+D6CRR?=
 =?us-ascii?Q?Zxwb6Jgq9qB/dJEeZV8t9jP3wP6RYirVdU1sqBoZvHVRKKaLpJRKLWH9gxMl?=
 =?us-ascii?Q?jORNT7kvRVoMU/E9roXS2Vpd874/hGP4YCI1pDBDmTwkn8UHUN03sx/T40Dk?=
 =?us-ascii?Q?EDKKiWxIzZQenA6dSPC6HA/NCq33+tw0O7IOAP3lwMx+voe8kgrfndKuK+HU?=
 =?us-ascii?Q?ZCcw2C8Vuu3SYe+3Jw57OVCHcfWTcdMJ0TBwp7sqvOPWtEyFh+ZmrfpdSKfE?=
 =?us-ascii?Q?lQVriS+1qPo7QQM6UyFispL1Z359qlk0LaG3a0FQxKB7oEJ7679pl6cCGev0?=
 =?us-ascii?Q?IlQCTc5zNYRupjUMc4J7PYZOaJ4QOE+jcRAOSZa1rKmKaKitHV+yEXRQArka?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tQhqe+p4qT33H4u6Q8aImdl37/N2BuPrzPgM7105y2pAm0OEST2mUg+MQwIr3h0i+sYMfy6w/eXwlOTJBGwYfoA9cNODfoFfs0MbNpFeIFuXRFGWRr7zMf/Nn9PdqMyqopU1tfrvkB+hRAFU3+Ie+7f9vjXkqzh39uzfJPL5Vazn1B/a1b0hLPepbrm7tg+w0CtghKI+2sqN3E6QdIVqjPbwqMYCX531D2FT9mu3gBr9n3PFwuKV5w/y+gu5IFDISer772SQbM9gTrAggjRmNsYyzWsw4uGTu5ndr6ztzYyBhcBV/u4ytUuNvIAsk2DZphkUD4ip+zRgZXjMCE5at0fMOinijMfnbiZX4mzI0IHF+gml3US0CflT0y8av6vuAtW3wBFxg2of2nZzQdGNd8iJgKPjtytn+d1xYRBhIIe2qOFjQr6DYh+5xKX6ajHLyj1KIrrZU48J6s6GmDxN/K2paSEqAr6hL2PBtIR3woAtcbsZWzXd25figK/oU4I2N+74+Tt1nKz4KJfHGVJSFDrkqa9Xhi4EuKcfhg/u+AilMCvLplm5gIJLmDG4RCGQBnlARooZAisefusnAAQ4mWKerPCluHvw4VJOqXFRsXZI2xjYlzKIAWfy5FxM9N3pAwS0GBjViKJr/OZYz7hW8ri4I8jQGrgQK5lHaAaH3SKdI9dBuIDtLUih3GEE8TBTd/CMjydvCRDpJkJAM2epHwFK61RWpWEG3rl5tGHGRim1PYUTZSSqsAZ8jImd0sLA78H5hvb8bAwEVuXz+HkEturHxCBmhXYoUJbyQWgR0E5wJV6XoAAPusuf7biYhxgprxvK3EIvsvan6QiSTQCfppypjOAb4d4LdxCp+6eJ92Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0b4ced-7563-4234-2009-08db2e96f806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:34.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAAaIJ8vxIEHraM0+u9V3At32Tn6NT4gUZ5XdVC9paaU+VplOlkp4nzz+8ru1N7OonTNMzk5L9DiqVbNhiS9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-GUID: sIlN3UnDFsnxCnAkI7fegMAJBVLDb6yW
X-Proofpoint-ORIG-GUID: sIlN3UnDFsnxCnAkI7fegMAJBVLDb6yW
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easy to get scsi_debug to error on throughput testing when we have
multiple shosts:

$ lsscsi
[7:0:0:0]       disk    Linux   scsi_debug      0191
[0:0:0:0]       disk    Linux   scsi_debug      0191

$ fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read --bs=4k
--iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg
--eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
jpg: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
...
fio-3.28
Starting 40 processes
[   27.521809] hrtimer: interrupt took 33067 ns
[   27.904660] sd 7:0:0:0: [sdb] tag#171 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
[   27.904660] sd 0:0:0:0: [sda] tag#58 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
fio: io_u error [   27.904667] sd 0:0:0:0: [sda] tag#58 CDB: Read(10) 28 00 00 00 27 00 00 01 18 00
on file /dev/sda[   27.904670] sd 0:0:0:0: [sda] tag#62 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s

The issue is related to how the driver manages submit queues and tags. A
single array of submit queues - sdebug_q_arr - with its own set of tags is
shared among all shosts. As such, for occasions when we have more than one
shost it is possible to overload the submit queues and run out of tags.

The struct sdebug_queue is to manage tags and hold the associated
queued command entry pointer (for that tag).

Since the tagset iters are now used for functions like
sdebug_blk_mq_poll(), there is no need to manage these queues. Indeed,
blk-mq already provides what we need for managing tags and queues.

Drop sdebug_queue and all its usage in the driver.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 189 ++++++++++----------------------------
 1 file changed, 51 insertions(+), 138 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b6e5b1f2a746..c1706b9dabba 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -341,8 +341,6 @@ struct sdebug_defer {
 	struct hrtimer hrt;
 	struct execute_work ew;
 	ktime_t cmpl_ts;/* time since boot to complete this cmd */
-	int sqa_idx;	/* index of sdebug_queue array */
-	int hc_idx;	/* hostwide tag index */
 	int issuing_cpu;
 	bool aborted;	/* true when blk_abort_request() already called */
 	enum sdeb_defer_type defer_t;
@@ -360,12 +358,6 @@ struct sdebug_scsi_cmd {
 	spinlock_t   lock;
 };
 
-struct sdebug_queue {
-	struct sdebug_queued_cmd *qc_arr[SDEBUG_CANQUEUE];
-	unsigned long in_use_bm[SDEBUG_CANQUEUE_WORDS];
-	spinlock_t qc_lock;
-};
-
 static atomic_t sdebug_cmnd_count;   /* number of incoming commands */
 static atomic_t sdebug_completions;  /* count of deferred completions */
 static atomic_t sdebug_miss_cpus;    /* submission + completion cpus differ */
@@ -848,7 +840,6 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
-static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
 
 static DEFINE_RWLOCK(atomic_rw);
 static DEFINE_RWLOCK(atomic_rw2);
@@ -4903,20 +4894,6 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return res;
 }
 
-static struct sdebug_queue *get_queue(struct scsi_cmnd *cmnd)
-{
-	u16 hwq;
-	u32 tag = blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
-
-	hwq = blk_mq_unique_tag_to_hwq(tag);
-
-	pr_debug("tag=%#x, hwq=%d\n", tag, hwq);
-	if (WARN_ON_ONCE(hwq >= submit_queues))
-		hwq = 0;
-
-	return sdebug_q_arr + hwq;
-}
-
 static u32 get_tag(struct scsi_cmnd *cmnd)
 {
 	return blk_mq_unique_tag(scsi_cmd_to_rq(cmnd));
@@ -4926,47 +4903,30 @@ static u32 get_tag(struct scsi_cmnd *cmnd)
 static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 {
 	struct sdebug_queued_cmd *sqcp = container_of(sd_dp, struct sdebug_queued_cmd, sd_dp);
-	int qc_idx;
-	unsigned long flags, iflags;
+	unsigned long flags;
 	struct scsi_cmnd *scp = sqcp->scmd;
 	struct sdebug_scsi_cmd *sdsc;
 	bool aborted;
-	struct sdebug_queue *sqp;
 
-	qc_idx = sd_dp->sqa_idx;
 	if (sdebug_statistics) {
 		atomic_inc(&sdebug_completions);
 		if (raw_smp_processor_id() != sd_dp->issuing_cpu)
 			atomic_inc(&sdebug_miss_cpus);
 	}
+
 	if (!scp) {
 		pr_err("scmd=NULL\n");
 		goto out;
 	}
-	if (unlikely((qc_idx < 0) || (qc_idx >= SDEBUG_CANQUEUE))) {
-		pr_err("wild qc_idx=%d\n", qc_idx);
-		goto out;
-	}
 
 	sdsc = scsi_cmd_priv(scp);
-	sqp = get_queue(scp);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 	spin_lock_irqsave(&sdsc->lock, flags);
 	aborted = sd_dp->aborted;
 	if (unlikely(aborted))
 		sd_dp->aborted = false;
 	ASSIGN_QEUEUED_CMD(scp, NULL);
 
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		pr_err("Unexpected completion qc_idx=%d\n", qc_idx);
-		goto out;
-	}
-
 	spin_unlock_irqrestore(&sdsc->lock, flags);
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 
 	if (aborted) {
 		pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
@@ -5255,21 +5215,18 @@ static bool stop_qc_helper(struct sdebug_defer *sd_dp,
 }
 
 
-static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
+static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd)
 {
 	enum sdeb_defer_type l_defer_t;
-	struct sdebug_queued_cmd *sqcp;
 	struct sdebug_defer *sd_dp;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
+	struct sdebug_queued_cmd *sqcp = TO_QEUEUED_CMD(cmnd);
 
 	lockdep_assert_held(&sdsc->lock);
 
-	sqcp = TO_QEUEUED_CMD(cmnd);
 	if (!sqcp)
 		return false;
 	sd_dp = &sqcp->sd_dp;
-	if (sqa_idx)
-		*sqa_idx = sd_dp->sqa_idx;
 	l_defer_t = READ_ONCE(sd_dp->defer_t);
 	ASSIGN_QEUEUED_CMD(cmnd, NULL);
 
@@ -5285,22 +5242,13 @@ static bool scsi_debug_stop_cmnd(struct scsi_cmnd *cmnd, int *sqa_idx)
 static bool scsi_debug_abort_cmnd(struct scsi_cmnd *cmnd)
 {
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	struct sdebug_queue *sqp = get_queue(cmnd);
-	unsigned long flags, iflags;
-	int k = -1;
+	unsigned long flags;
 	bool res;
 
 	spin_lock_irqsave(&sdsc->lock, flags);
-	res = scsi_debug_stop_cmnd(cmnd, &k);
+	res = scsi_debug_stop_cmnd(cmnd);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
-	if (k >= 0) {
-		spin_lock_irqsave(&sqp->qc_lock, iflags);
-		clear_bit(k, sqp->in_use_bm);
-		sqp->qc_arr[k] = NULL;
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-	}
-
 	return res;
 }
 
@@ -5559,7 +5507,6 @@ static struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
 
 	sqcp->scmd = scmd;
-	sd_dp->sqa_idx = -1;
 
 	return sqcp;
 }
@@ -5578,13 +5525,11 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	struct request *rq = scsi_cmd_to_rq(cmnd);
 	bool polled = rq->cmd_flags & REQ_POLLED;
 	struct sdebug_scsi_cmd *sdsc = scsi_cmd_priv(cmnd);
-	unsigned long iflags, flags;
+	unsigned long flags;
 	u64 ns_from_boot = 0;
-	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_device *sdp;
 	struct sdebug_defer *sd_dp;
-	int k;
 
 	if (unlikely(devip == NULL)) {
 		if (scsi_result == 0)
@@ -5596,8 +5541,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (delta_jiff == 0)
 		goto respond_in_thread;
 
-	sqp = get_queue(cmnd);
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
@@ -5616,33 +5559,12 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		}
 	}
 
-	k = find_first_zero_bit(sqp->in_use_bm, sdebug_max_queue);
-	if (unlikely(k >= sdebug_max_queue)) {
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-		if (scsi_result)
-			goto respond_in_thread;
-		scsi_result = device_qfull_result;
-		if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
-			sdev_printk(KERN_INFO, sdp, "%s: max_queue=%d exceeded: TASK SET FULL\n",
-				    __func__, sdebug_max_queue);
-		goto respond_in_thread;
-	}
-	set_bit(k, sqp->in_use_bm);
-
 	sqcp = sdebug_alloc_queued_cmd(cmnd);
 	if (!sqcp) {
-		clear_bit(k, sqp->in_use_bm);
-		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		pr_err("%s no alloc\n", __func__);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
 	sd_dp = &sqcp->sd_dp;
-	sd_dp->sqa_idx = k;
-	sqp->qc_arr[k] = sqcp;
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
-
-	/* Set the hostwide tag */
-	if (sdebug_host_max_queue)
-		sd_dp->hc_idx = get_tag(cmnd);
 
 	if (polled)
 		ns_from_boot = ktime_get_boottime_ns();
@@ -5689,10 +5611,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				u64 d = ktime_get_boottime_ns() - ns_from_boot;
 
 				if (kt <= d) {	/* elapsed duration >= kt */
-					spin_lock_irqsave(&sqp->qc_lock, iflags);
-					sqp->qc_arr[k] = NULL;
-					clear_bit(k, sqp->in_use_bm);
-					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 					/* call scsi_done() from this thread */
 					sdebug_free_queued_cmd(sqcp);
 					scsi_done(cmnd);
@@ -5950,14 +5868,39 @@ static int scsi_debug_write_info(struct Scsi_Host *host, char *buffer,
 	return length;
 }
 
+struct sdebug_submit_queue_data {
+	int *first;
+	int *last;
+	int queue_num;
+};
+
+static bool sdebug_submit_queue_iter(struct request *rq, void *opaque)
+{
+	struct sdebug_submit_queue_data *data = opaque;
+	u32 unique_tag = blk_mq_unique_tag(rq);
+	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
+	u16 tag = blk_mq_unique_tag_to_tag(unique_tag);
+	int queue_num = data->queue_num;
+
+	if (hwq != queue_num)
+		return true;
+
+	/* Rely on iter'ing in ascending tag order */
+	if (*data->first == -1)
+		*data->first = *data->last = tag;
+	else
+		*data->last = tag;
+
+	return true;
+}
+
 /* Output seen with 'cat /proc/scsi/scsi_debug/<host_id>'. It will be the
  * same for each scsi_debug host (if more than one). Some of the counters
  * output are not atomics so might be inaccurate in a busy system. */
 static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 {
-	int f, j, l;
-	struct sdebug_queue *sqp;
 	struct sdebug_host_info *sdhp;
+	int j;
 
 	seq_printf(m, "scsi_debug adapter driver, version %s [%s]\n",
 		   SDEBUG_VERSION, sdebug_version_date);
@@ -5985,11 +5928,17 @@ static int scsi_debug_show_info(struct seq_file *m, struct Scsi_Host *host)
 		   atomic_read(&sdeb_mq_poll_count));
 
 	seq_printf(m, "submit_queues=%d\n", submit_queues);
-	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
+	for (j = 0; j < submit_queues; ++j) {
+		int f = -1, l = -1;
+		struct sdebug_submit_queue_data data = {
+			.queue_num = j,
+			.first = &f,
+			.last = &l,
+		};
 		seq_printf(m, "  queue %d:\n", j);
-		f = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
-		if (f != sdebug_max_queue) {
-			l = find_last_bit(sqp->in_use_bm, sdebug_max_queue);
+		blk_mq_tagset_busy_iter(&host->tag_set, sdebug_submit_queue_iter,
+					&data);
+		if (f >= 0) {
 			seq_printf(m, "    in_use_bm BUSY: %s: %d,%d\n",
 				   "first,last bits", f, l);
 		}
@@ -6944,13 +6893,6 @@ static int __init scsi_debug_init(void)
 			sdebug_max_queue);
 	}
 
-	sdebug_q_arr = kcalloc(submit_queues, sizeof(struct sdebug_queue),
-			       GFP_KERNEL);
-	if (sdebug_q_arr == NULL)
-		return -ENOMEM;
-	for (k = 0; k < submit_queues; ++k)
-		spin_lock_init(&sdebug_q_arr[k].qc_lock);
-
 	/*
 	 * check for host managed zoned block device specified with
 	 * ptype=0x14 or zbc=XXX.
@@ -6959,10 +6901,8 @@ static int __init scsi_debug_init(void)
 		sdeb_zbc_model = BLK_ZONED_HM;
 	} else if (sdeb_zbc_model_s && *sdeb_zbc_model_s) {
 		k = sdeb_zbc_model_str(sdeb_zbc_model_s);
-		if (k < 0) {
-			ret = k;
-			goto free_q_arr;
-		}
+		if (k < 0)
+			return k;
 		sdeb_zbc_model = k;
 		switch (sdeb_zbc_model) {
 		case BLK_ZONED_NONE:
@@ -6974,8 +6914,7 @@ static int __init scsi_debug_init(void)
 			break;
 		default:
 			pr_err("Invalid ZBC model\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	if (sdeb_zbc_model != BLK_ZONED_NONE) {
@@ -7022,17 +6961,14 @@ static int __init scsi_debug_init(void)
 		    sdebug_unmap_granularity <=
 		    sdebug_unmap_alignment) {
 			pr_err("ERR: unmap_granularity <= unmap_alignment\n");
-			ret = -EINVAL;
-			goto free_q_arr;
+			return -EINVAL;
 		}
 	}
 	xa_init_flags(per_store_ap, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	if (want_store) {
 		idx = sdebug_add_store();
-		if (idx < 0) {
-			ret = idx;
-			goto free_q_arr;
-		}
+		if (idx < 0)
+			return idx;
 	}
 
 	pseudo_primary = root_device_register("pseudo_0");
@@ -7089,8 +7025,6 @@ static int __init scsi_debug_init(void)
 	root_device_unregister(pseudo_primary);
 free_vm:
 	sdebug_erase_store(idx, NULL);
-free_q_arr:
-	kfree(sdebug_q_arr);
 	return ret;
 }
 
@@ -7107,7 +7041,6 @@ static void __exit scsi_debug_exit(void)
 
 	sdebug_erase_all_stores(false);
 	xa_destroy(per_store_ap);
-	kfree(sdebug_q_arr);
 }
 
 device_initcall(scsi_debug_init);
@@ -7483,10 +7416,8 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 	u32 unique_tag = blk_mq_unique_tag(rq);
 	u16 hwq = blk_mq_unique_tag_to_hwq(unique_tag);
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_queue *sqp;
 	unsigned long flags;
 	int queue_num = data->queue_num;
-	int qc_idx;
 	ktime_t time;
 
 	/* We're only interested in one queue for this iteration */
@@ -7506,9 +7437,7 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	sqp = sdebug_q_arr + queue_num;
 	sd_dp = &sqcp->sd_dp;
-
 	if (READ_ONCE(sd_dp->defer_t) != SDEB_DEFER_POLL) {
 		spin_unlock_irqrestore(&sdsc->lock, flags);
 		return true;
@@ -7519,16 +7448,6 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 		return true;
 	}
 
-	qc_idx = sd_dp->sqa_idx;
-	sqp->qc_arr[qc_idx] = NULL;
-	if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
-		spin_unlock_irqrestore(&sdsc->lock, flags);
-		pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%u\n",
-			sqp, queue_num, qc_idx);
-		sdebug_free_queued_cmd(sqcp);
-		return true;
-	}
-
 	ASSIGN_QEUEUED_CMD(cmd, NULL);
 	spin_unlock_irqrestore(&sdsc->lock, flags);
 
@@ -7548,20 +7467,14 @@ static bool sdebug_blk_mq_poll_iter(struct request *rq, void *opaque)
 static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 {
 	int num_entries = 0;
-	unsigned long iflags;
-	struct sdebug_queue *sqp;
 	struct sdebug_blk_mq_poll_data data = {
 		.queue_num = queue_num,
 		.num_entries = &num_entries,
 	};
-	sqp = sdebug_q_arr + queue_num;
-
-	spin_lock_irqsave(&sqp->qc_lock, iflags);
 
 	blk_mq_tagset_busy_iter(&shost->tag_set, sdebug_blk_mq_poll_iter,
 				&data);
 
-	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (num_entries > 0)
 		atomic_add(num_entries, &sdeb_mq_poll_count);
 	return num_entries;
-- 
2.35.3

