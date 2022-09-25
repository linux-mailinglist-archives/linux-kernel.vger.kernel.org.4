Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FD5E949B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiIYRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiIYREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:04:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80612CE19;
        Sun, 25 Sep 2022 10:03:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9RRKF027780;
        Sun, 25 Sep 2022 17:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Do41cl9n+7LOHgRgI3nfUkW5N0MYD/Yhb5q4QcWEe18=;
 b=UjCP/gNHA3xE3Wuq6wcu2a62eOP3/XGorkNFViRMnb2Swri5TPna4IRw3STqYDY9jliL
 LsCmxfSQFxYYwL7OBbJQ4x49nf5+bRVQEQiQiY88XoNhK8ynRau6qh756xUoQw6YY8Xy
 ErVSSe4H8rgF2lCoRYTZDDIs7TGk8cbrKiYSdp5qwWjjYsjtKkOv1tGEO8fFvyAcN0aZ
 0jCz8MrbdLAQB7FpoQ8G9sHQF9Mknqm8cT3U+woHkN1Xi6F8toHrVZYSn4EQ0fFrK0fs
 uMIUWaV88nwSQ+3q0P6Nv1ylLU20efY5T7ehNwX7oAe8aIM8ouzavQe2dgB3MP4VeJu4 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrw9xm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:03:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCHBQL001462;
        Sun, 25 Sep 2022 17:03:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuxuexw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 17:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrhY39atfIR0ek2znVUkEId0r4FfS4yn54/t9ISrZYYdVjz2O3J6t5gimCxd4b+ee4yteKFUPskCSWp/tuufdSXCf61jiRf9kAXFnjMOsdR6+38o+8T5EJxKaGblugEHEqHEYTRYTQiqUa1rnVET9KET8wDFRMzYbyqkle+Cz3D0Ix7mjNroWRva1rP72gocR3abkPdptv857/7mCx1MnR4oocJYqo9O69AvRsqZP4eudhaFfJCyrQfr98FUD2KL6fA2zz/Et6BiCcfYaeG0YRym39Yi24mkEDbT1dce+Ebmv4Xp1J2HFQCXEVooABgQAzMULEf97ZcRDGDzGBAqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do41cl9n+7LOHgRgI3nfUkW5N0MYD/Yhb5q4QcWEe18=;
 b=SUnQy0n2rTFrUo4OpOFINXAZV2UcXA2cxQGH2RwIGmHO1wxVkT2sMbYvp09G82CIw+crSIYughAWotigkh965eJTrmeG+9f1FGQSsxhMPCVEuZq9z4VkTG9nBX0mzHXQaua9PRsrteXNwCf0djd9i4GL3V0GuDbB51qIBQ9ogeU/ddakoGwmdeIhLpWF55Oq2cC2TEX96+blAYWkD6GNvkyyCeDbXHFqiYazGWRpeXM8AP0qIlJPpyuCCrkuyQb7UYHRnmKSn6SMWr1IJRqmPQfA4xGzQdMyNwAvZnrv9nxz7fEDY0DFRDW1p8jgIpArxebZkE2ejMZyXcNMOw74tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do41cl9n+7LOHgRgI3nfUkW5N0MYD/Yhb5q4QcWEe18=;
 b=0ANAnzA05li1qhTbu7ha6CJ7AojaD77/LTrflF2r1caNfTPaJVhCKEIiwmY9Wrubo4Frx4jY9PMcE4Je/5cyJ0eijzgC6SMYQC7c9wl9HNRF4lDbxmZ4Tt7C8pHW/6Z9JN6guEZxF/m/Wdly5WIpH1k6yJHo1iYkusoLLzDdR1w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 17:03:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 17:03:42 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2][next] Replace one-element array with flexible-array
 member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu4vqtcy.fsf@ca-mkp.ca.oracle.com>
References: <cover.1663865333.git.gustavoars@kernel.org>
Date:   Sun, 25 Sep 2022 13:03:40 -0400
In-Reply-To: <cover.1663865333.git.gustavoars@kernel.org> (Gustavo
        A. R. Silva's message of "Thu, 22 Sep 2022 11:52:45 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c7b262-3d8b-4790-54d9-08da9f17e681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KphtdWl/HtJ6qi+GK97k2QCUqe2uzTgaUshy2d1+YaluXLX1QUadc4URzRaynxUqai73B1bC7Z+vae3C1pUD14/E/xsWEbO5yoeud9TBSos0yGXsaGSNAa/qwK+nMS0gwuREKoJTwJ59at9FaUyXNgCbiTRuF5+WPDhTOSZrlMEtMZNe5u9ujvy75Lago/Wy8ePlqoG4NWy2p1ch84sQWaniysd3aBtfWSBakxKjZyNFe2kL91T1p/+5brxS2sTtgVPv6LXWYRUt3iGhMAqJsGBeHIWBNHS9ofHfZNkF4U4uC3Rfg2lPSQ+DvceCfD3W3W7I4vNw0tj/a0sOD8WUAZMLK3Ye714eiy1G2U2+J9BSXhbouijJnowpp+IhNI1e3UtlZS/InKbh30hxBoFmco/FvmIpXicqtxH3HTaYgtMp33BqrDt/rYtjpbHChMd3Cgf+kimE03tO1dj6yELsJ1+usahozrI1lfVdqfRinhP4g+lyGutueWjGrVj26wjQIGP/SPnG4cL6RrgFfZh/w1c5VA6NrBlhdySWvIIRp8AS/6275ke179ChTjEj8MrjpXavcPcV/03xs84VNlOPF2Yryz+gFYGWoqayxCW1qLcLyvtDaTWMR+8hnOI1c00UgaVy8+iqyKN5k85rJTNTq1nJjuBGUttZesjjZU6tyGb1tiyYwtgHqpcBfME/+rxIW+EiiUFE6JGaTtNoJSiTQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(54906003)(6916009)(38100700002)(316002)(5660300002)(2906002)(6512007)(8936002)(86362001)(26005)(186003)(4326008)(41300700001)(8676002)(66556008)(66946007)(66476007)(6506007)(36916002)(6486002)(558084003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zv31djLkR419KaRbNoS/VokYHlc1MOFQHduoQmZdPkditm32B6Nbjxo8xOKq?=
 =?us-ascii?Q?7prKU+7AXAyqjons3N+NSv4W3cPZu2i2NPP5JhJLXRmNbO9CkvSinRFzds2T?=
 =?us-ascii?Q?ED0yy6l/yR7XxtZ1+i+aDYdhM2fQqdlsCv6LNHhhdqtDLoGQFv8ikkdjWsBc?=
 =?us-ascii?Q?2QhBFgqesPVZq4On8X35R0A5zpZRMeq11qf0KV+Zthrgnx/UERTjaIw8WaM1?=
 =?us-ascii?Q?5lVSR7LHzZBb5cYO1XvSrgPOiE9mrRPKgKW5TZTLib2pyZF+RnHf9fiL4vbL?=
 =?us-ascii?Q?6fUopTNB5iIlTKuhuD3abwnqgbjPrxJebrQSryr3T/b6J+wWwazR1WDlpnGK?=
 =?us-ascii?Q?VK+U14uXoLSbAUoqKvrC25ixttuLKdHuc7TC35j/WefPONEwD1d0zhECs3rL?=
 =?us-ascii?Q?CFu1vy4M1Rg8+dyWXiVh1+X0A8iLj8wc8tLFafE2rCICME9jA69u+wBsuu9C?=
 =?us-ascii?Q?1b23x5s414qNtEHYX0IyDtlOK9fjTbfs2DFHBeH+PZWUC3K6/UhjHeQwzYfP?=
 =?us-ascii?Q?QlHwydVr8HkGjk8OMNXXEl8RTXhUkfW3ZSOEd6dw8gWV4sFq2KBaeVXafLzK?=
 =?us-ascii?Q?STENGxcY91oW3WIqU95mlxjAoQlYVoQokSCDKzXQ9ki8u7bpLISazk+js90I?=
 =?us-ascii?Q?W6YnHMFqO++sW5hOhAtYhMoomx8tdaeF6RoedClO37kFJcqYc2Y+FbvIqjTj?=
 =?us-ascii?Q?VgxL9f2yK+cEpqM6+KqITZcIpYzbtjPfAPZV2ruXJ6OEi7224LDa8sIPZbh5?=
 =?us-ascii?Q?307V+7QFZYBGoEOH/LmxZD26N1EUh6SMqMN+1uUqJnTVwAc5TuvdgA6eHUiP?=
 =?us-ascii?Q?SlLGq7N+5DMGKSAPqe6nq5ZbJB+qw6O/erED/DZrnJ05Z55G3RH9tAHA16iN?=
 =?us-ascii?Q?vxO0urr25T1FZwaXIA1yZ3QYLq9tklb1y3J3AqbXhT7h+9s3BYf6KCo9pZxX?=
 =?us-ascii?Q?asNygWtwa4HaDqRGWZERUdqPMkoYlTfBtPMjsp1D5EeeF6M9oOWCAeIiiC/3?=
 =?us-ascii?Q?m/+yst1t51pfN6GHESaWQKksmjFsEWPH3w/9fwEB5CZOzjEk+ySbDS5UBaCs?=
 =?us-ascii?Q?uee16hAhDzzBbVyGdEy7ipqmJCsnJ8R+gujA1EaaIubbImJoWyB7jeO+gWUw?=
 =?us-ascii?Q?7immcMEZCGFPlaiBILgSDoVxOD1fmFrJ3Yz81uRfON7Sj7UnKKdRZQo9of0K?=
 =?us-ascii?Q?nTUZ06KFT9kgZ4CMn3GYu76lJCMT0l8yPutmJb46Z6uG10TyeTe9odLXSZS0?=
 =?us-ascii?Q?qozn3Jbs2Wf9UCyCcthtK3m4KsjTxIa/N5ydDDSSGjPm0h0szjSPlpL4J/rp?=
 =?us-ascii?Q?BMZZJxR1KBGSrxNz6XbQuauAtRxuu16BGoAKTIFLOdaWsI3XxaPnDf0Fx0Yn?=
 =?us-ascii?Q?M1p5kwvpRF0TvjJtvx9um5wyGejKwOa3uw5EYF4Ys83RVEcxxAR+QM+iakkc?=
 =?us-ascii?Q?OCt5iSw47ipd7f50S9LHSFMdXZxfMvY8wn2x2qUdaPy0iOQLNwmHBfSwZ8WP?=
 =?us-ascii?Q?4hJGQLoy2YSfHK9rnW8osrs7rRM1ljn/w0rtFz7d6VoczQ+e49Lon2BgLdKp?=
 =?us-ascii?Q?E8AoxAQ//+dP2f48vnX11gArLbRDZ+PCmWbPzTHtjVJYob44Jav4nDu3T05n?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c7b262-3d8b-4790-54d9-08da9f17e681
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 17:03:42.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndA+KUfrJNoT8AdNzTqMkbJCmf4lW2I5ZTrO+NqyTJs61RAD4tPXTZpSObTyfghr1r4aPimNPkN/cFf+xTAzLdB6HrIa9QAeeaB4aWSJzbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=590 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209250125
X-Proofpoint-ORIG-GUID: VJasYGoA9OfxHUsy6sawtyfnR4-e8p22
X-Proofpoint-GUID: VJasYGoA9OfxHUsy6sawtyfnR4-e8p22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> This series aims to replace one-element arrays with flexible-array
> members in drivers/scsi/hptiop.h

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
