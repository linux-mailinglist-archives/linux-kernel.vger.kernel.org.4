Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D3718F63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjFAAIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFAAI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:08:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312F124;
        Wed, 31 May 2023 17:08:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKlVXJ020034;
        Thu, 1 Jun 2023 00:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NFHJyiTWyS6Fz5W9l2lNc+PwnhCC1e39D4yEkf4rieU=;
 b=VlosdDj/4lIlCtWTXCK96nyt1rLygdjxt0PZEAEJ268yazcg+55Hd6B7KYQiCQmJLZ+g
 oH/HlawfwrXt1//hvKq0wc1q9fe6Fp6Anpi2E3N5SiFFRPXMn10A0sB45R2n2G+Enggc
 BldkgsnVJ2B9QTh3kbv1z6XruQb2/fx4alpZAuQriODyewcWGtQ+bvfhuJe5kqtVl5vb
 /UGtjNdqSCmn4WM9Y3QpxFbZA6L+jbpIUIydweyFs/6Dw7sVd5w/Hl6dA5Y19fwEEq51
 qChn7k3CUZMUZQK8/j+E48hiAtXIhGTMU/OHOuW4Le0/7z4+YTBiMUg+7ZFXxm8QOH8r vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh7a81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:08:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VNuSRF000471;
        Thu, 1 Jun 2023 00:08:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qawvkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 00:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k21+3rtx0moP2c/x7gP3uR0TDfmi8ZhXCUUcfu0rcmKIpnEtuqWAWpIqojofi/9w/uzXRErcxOQjGQ/oau1xVAOIKPyBNuZFda1UayP7LtNGJqcq7uIDQXFCOLmZFBHlfRuGchvielHPhvm8XmrcG41ECXLkMUE3BEM/azUPsJyCrnuHchFAdkkjR2cr2jDXAJ7/FrR+qjCPIxRcZbKHE7DbNqZkJFkehJkJv3ZioKlPkVi1wGwKZUJ9yyK170FHNhPS94OhowfFsCi4PvY9m/IFpZIXDVWuNCPrAqpN7KHeRb/3NvozcfqUFBBBFPuKgU7ziW3FSkr/ZS7hnVLXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFHJyiTWyS6Fz5W9l2lNc+PwnhCC1e39D4yEkf4rieU=;
 b=gzRdWMSIRVaw5MYNc9+n3/ppJO7QQp8wRL9/XQOY2mXIaKElDA6jfSFGlf2z3kv3gPcOuSVhLOk9toQtsnNgk1IAasiRo8kwYYKuZ9loaZBkPmYr1fBS1m2oQ4xgNF0yz8wNlAq3McHSFnPf2Lrj1iOHgWX/Z046ahf72lOSNs63xmkISTqdb8oyZPZpxgd1y8qwF1WvmWOcJXz9EtFcw76Sk2vPHJVhZ+e1y3xUyKUsNWX4ihRLG8vcW1zE8xLtOQq3736vENQP/0l4W0e+o6m3J6mFKsAWitEm9JYAShA/fRMxnxsfayxtI0OLFPJWvhOCVw4wCS8mTqS3fvz09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFHJyiTWyS6Fz5W9l2lNc+PwnhCC1e39D4yEkf4rieU=;
 b=r5EZKIgv0F/0glDhcSH2cvTjgE1JWXoR3Ef+u8pe5ypyj2JwOGczat155TBGwRwgom38QaHA7GSR0TWQbtJOSVqQKfv5yONg3hksZr9gLCjWsbmmMU2bnrvMawdmpsdsbf0jd5X4jlxmInYRcz70RK1xJoVP6WpGD6HTDR+uRus=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6490.namprd10.prod.outlook.com (2603:10b6:930:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 00:08:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 00:08:06 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Use vzalloc()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz2gavtu.fsf@ca-mkp.ca.oracle.com>
References: <a1179941a6d440140513e681f4f3a1b92c8d83ae.1685210773.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 31 May 2023 20:08:03 -0400
In-Reply-To: <a1179941a6d440140513e681f4f3a1b92c8d83ae.1685210773.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 27 May 2023 20:06:37 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c39318-2369-447a-af75-08db62344662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV+AQmmbcWeMv0OY8NUjH5GAFnICn17wlQZ4CZp+Vxq0Za95Jbdm8qpTqCSYFM/XnS0z+ACYhAfB0lT0yew8Qca4FeazTRY10x3zgUaED0clWcDQqCh/6UCn9j+SDosHxEG62Ad3UMjCATsyyZSeytw3KT/M1YOxejHVIn5ge9ptEDhZYGJ5+0AO3YX2VxIxcNNx5ObZGmflPdHtSha5qksoDQforS6M9r3g8Lbi427Dd2ewu+hvYUfQUDLW4McUnY2bYXQNg+yWUYKAH5InO0EqnF6AnK6+01a2CoG1aMe83xXl0H4lrSlHc771LMzo5AB6WznpnEFepPwJx0Tg7+Gk44k0jp+ZDnyIuh25HJZSoxZ70QGB+HdbNn+P4DU53TarA6gDz5q0y+xcnQ8cejAqXwEuQyFVtk4YHSUA9OL83n5waugRDGzSk5Kes6sVsKcmRLCdI8SxQXsQDccXdlMX5rDa3wIk5q7s5uX8xcUM/vADLjudFZ3cmWVJL37psWDGauzTFrSeAdYVy/SOIeMfF8MKEteXxleeW1v7vZRAp3gANpuFuVBzv+jrqKg5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(186003)(41300700001)(38100700002)(26005)(6486002)(6506007)(36916002)(6666004)(6512007)(478600001)(54906003)(66476007)(6916009)(66946007)(66556008)(316002)(2906002)(8936002)(5660300002)(8676002)(4326008)(86362001)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRWEzx5/SBtHpYaTuatTsk2u+OV/BVndQwo28l9FB+D6mP7TmkzMsGpSWGr8?=
 =?us-ascii?Q?aObjBj7+3x8Kt2HVX8CtmaV4WR7pjsLZoSQmKgIz8bafpLn9oyqLXmS9mpQN?=
 =?us-ascii?Q?lRuMZ76XLFPReVA1PDfY6BWAiPQby31eB2eqeN8g76ESfvGaAWUK5ZvMgcs+?=
 =?us-ascii?Q?zvWhSTZ+ynLUmjbfIrJS7eAfkR5ui4Pz5vaq2Ce03Hr3q8DO932ojpjMGnCM?=
 =?us-ascii?Q?B4HiDHNm2IkKKrvri83DxRIb8A/2gDfAu2kgUGlPnRCRql0NqCR2J2Lf68Hv?=
 =?us-ascii?Q?Q2rckLNq8oysQZ1OUUUxDLwI1lBYK5CyQqEIMfNpkayfRhqMmVJBz174YwKU?=
 =?us-ascii?Q?ev8PeeA2MzmMvuCL1KBuzON7mu2qxRp6xbQCtjoRGX3oYwnqyvGqpQddU86l?=
 =?us-ascii?Q?zFQLQGF7FjyePHkf4vjpLS78u67leZMAud49lWAvnxjo4S6boJOt6+9eWS2d?=
 =?us-ascii?Q?FXbdj36x6Qj/gd5qMoAmpfEKHKYizSh0eP9gmvfzRP0ml+W1KIRr+KWnt9PP?=
 =?us-ascii?Q?It24i1ngf9Xnh5W/9X6SiPlG0kI/zy4cGcTaUDk4NSVYo9wRSu3TIxXtg+bX?=
 =?us-ascii?Q?JY9nYwYzi1YhHeogJw7axbTSqlv43me/ZyHyl9u04LpaGTvZ4Ci/eOkr8mKv?=
 =?us-ascii?Q?i1LALEpEHVBUipdGgeXin2CSCeqAZlK5jncDX29TkHq/bkPM5RAj4EuVhHzP?=
 =?us-ascii?Q?OsrRKssggbHks+Xa0DXpbPFfYi2eD0bu9btcUQ7rveIDIyrpTNx1M3g3Iscc?=
 =?us-ascii?Q?aK7+JSNnTn7qLbqo8o8g8Ef8gxukytKzhC3U0zPefUsxGLZPx+v2xVDikBMB?=
 =?us-ascii?Q?uM5YJAtHttJqUx5zxf/ln0TKbDiwvOt5gGGoXWkzqDsSg9eracp/EcsECK29?=
 =?us-ascii?Q?9B229qoBGOppOKOh4S+0TXd+dx+Kd7USIn7Ct6Ql8Pi9qQrCvlZOcvDkeeEg?=
 =?us-ascii?Q?4SSw0g6kjipWnpr4Y9IRdHWO0islcWoxJupDenLOkNvcsoBbjXJ3OBEzu0AQ?=
 =?us-ascii?Q?gl/4aKgej5grTRdJwUHLcwRpV0FEmlDSKwR03Z+57uHRlxk0oBoO3rXQJk1X?=
 =?us-ascii?Q?dr79q7CYzKZjNZGsrwyA3GmTzVIdnCW86sMr4URD0h+Kti7Z2PmVYd7aFaVi?=
 =?us-ascii?Q?8/S1LZpQDpFcUrrGMafjiGpyWJGAdIh6vkOjNkPoeQmAuy26u5EZubUn4s2U?=
 =?us-ascii?Q?9MvMJ5b77h7hD7DFKysAzYpVmFvOiphvfBmDdq8VkeAv8AUmOjmQhEys33Rh?=
 =?us-ascii?Q?WuugvpgnrbphIOTiJJ9jM9bO86zM5aHdMHhJmDMfliIkstFlk398c3h2Fzau?=
 =?us-ascii?Q?f7vAqXGEyxTnrx+26U6G9Rh3qaES5sJ7oXb91omXsWdaQ6oBDPr9fbKFgQjr?=
 =?us-ascii?Q?+CHcr5TTP932/1KQUnFBbTLKpStqCIPaX4qSDfhgdGiGJRi1qcaosmk/wTnz?=
 =?us-ascii?Q?/RzJwSGxrUCEhQ8eevn1IInb66l2c3ofCKW5IC+gpTDvNjbA1OGjwTainOhL?=
 =?us-ascii?Q?6NzwCSg2abvNQZTX51rRG3FpjscNh2LB5xGNQx98RKJHspPgvzAJKVwwlWY1?=
 =?us-ascii?Q?YNehN6272oj5+nGKDtQts/+1v0lZtqGvWuSFJoK78Y6zVfDdRVQj+XHtQYad?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +8PNpHEsd6IfXfmULnKIrSX8n0xf0vPaK4NIwJpVyPxUN8djhUmRlX2K1c6CVKWCo/NgTIWn/BksBEdpX2tF43ujF359dLSd7Y+VLyTNSjZjyuUSWk6t/T5ddMnaFh6/RNnHuZRi5xM2vtAS4Em8GgbQTqaoDcPuj/zcyErbbHYYNGhb6kelCpntcId+godhJMggatTNNStUwoS0mQCAWS3/JAnmBK6S6RwDf/rqTiooZ9e3yffDXfpdCsnRa/NB0Th/UZtCaRxS0JLFMcGBrGy9X0w9jbihrBHiXKVIVrq3pCegSIRe1m2H2NO5/G9CLlQ8VlbQMY6Ee/AeUU5HdL5lFLCaNL02d/z/nhpYadqLjacaV1YsVbecLt1QVZFmAZsA5pR14iNghWznTF7XIj8u7ZvBhUybFcL2A/jvWBhWuHjI/Rhxxltgzs/5X2fW6tcp7MplzhL27983KMMLxk9esEHIs1vN/EKDViu+/+1ppZp6nlAExGTyRHIRQ5iVhPYIqJ4WBw2tg7PEj7I6ha7qT6ngmCxeLjNwEzzGFGegNvQ9uCZQSa6Gh2bKWJYCQyVeGTddci/jlKKT4/boJm5yAEqnSFvI1/yXymxhPPJxWkbpwENu+d0uKk6M6vPQtZidrtke7GJqyyaVzk5QbSpjJRbmJ0Z9RCLG1cHL/Q01oVm821U4SEU2rKV+v36EM3twpLlAPNqPmM6d+pK7/cQRpK8cGBeN1/LYYqUViaL5MZZV6M546m9HG+VXGP5Tjov1ElISFEKaj0ERmUd2g7Wyt69AFNd9eHSys5Cq2Qz4EceGa5uBxJNL8xIsF4pVcLG0lkQ+eyHTTt8L7C8IP4VSJBOpOLulkaWDDxmRDYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c39318-2369-447a-af75-08db62344662
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 00:08:06.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RB23jhnG0bWsBoQnZXsYKvqOpwv2/vYSAHjFcqHkxJ3qDL1ZCI1rOWgljGQnDtK9fWGEttmehR1IF7hKyzvF2vEcLgQ330WFtkP2QTE5L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=785
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310204
X-Proofpoint-GUID: CYGZI-j76BiEhWWZmB3VEspv07K3jpi3
X-Proofpoint-ORIG-GUID: CYGZI-j76BiEhWWZmB3VEspv07K3jpi3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> Use vzalloc() instead of hand writing it with vmalloc()+memset().
> This is less verbose.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
