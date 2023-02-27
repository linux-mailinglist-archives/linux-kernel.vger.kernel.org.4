Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7683B6A4B47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjB0TjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjB0TjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:39:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B9B274BF;
        Mon, 27 Feb 2023 11:38:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIhkaM028407;
        Mon, 27 Feb 2023 19:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bF6rjPz5bHarFyowEa7rLMXIviHj70/NjZFGZBki0/c=;
 b=SpSim7ATxeBMFZj53EnI7l3kfKvJzND8vUVObdsBHS3IxtfM7eUu4iXwJB1Ie7DmD3+Z
 86AuUpcmxtxFNIirqYNJFcj1jjamBBunNSUYNhMqZyA7ybQCPkZojaVgnF3J9yXzVnZ3
 KRodn7EhCUMNDiqoVv8POK20Hu3+Py5+ty4N5FDR6CoLrLm36uYslvBvx/wkF8VUYh9y
 7dk5zMSSqFPx3nrz/Zfh4+IKEP7irca4SIBAdYfnlgYOmj8OPHEzzMJIHmh6l1uM8KGI
 jvYzISH7Ab+1eZmk8wfN5PQPwX/6YhFOrgj9wn2tzkYVjCVc8pc2YfZ+DOmOXEvHNYN5 jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72cetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:37:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RIXpA0013045;
        Mon, 27 Feb 2023 19:37:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5rce8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGCCiBEibWFuirs7KpX/82EVeKb8WIDcZdLiYGu4FxEVSzf23m69mAQXdsvDfbWU2a1XM2jE8SKUJfeqFywYvHBR2nsvIc4A1LUv8fgep2UT71Wnq7rqKahh9fgo3LyriFMGmR/fF4hCm/4tOM0R6f/ANg9tQap4WkwidR2BKOjM1XlrhtdbVk/rfI+VOrE594suEI0mshwObSt7M84fn71hBowclP2EbPnxgSO3r/BWFPhvrahidlexgON9jIoU2BdTm9svFq3bU5q6xvXNey1hscRggGAz1t1Ab2jz8HCgrTJAMumsryf4IbgXwgZy2Q3LlggPsD5TePWY+s31qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF6rjPz5bHarFyowEa7rLMXIviHj70/NjZFGZBki0/c=;
 b=GR7VY2to8pbAdJu4eqs4AttsHB0IAkhEj0v5RCdwcd+hKScnDWBbaAEkNqqMKoMePLERwaUzWfPjsGWslqbiqQSj0f4zyGMSt5fPWPCFVCjK+DTkgB68D/DoGEi/peK1v2KaKZXy3LdF2pt9wAvrJm6Hez2QXrMUi1xEOJQFyzGbdBGuGfp9+QT+ugRhrgQ/NOUO0EAQGR/q1MRJVLLuXT/9DfaR5hA8iFGNfoR8c4jCG932bB7ZhrrehBHoAAVBCr5LgscBVRd/CaX0iMmFJhPUKWZiBfoBNK6lnTJDwYJX7aTKd3MWUzO0r7bL2CksmHEDONvOwKzM/j+cFEd/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF6rjPz5bHarFyowEa7rLMXIviHj70/NjZFGZBki0/c=;
 b=axy36cAAMiFgVr0nu386iebY4QV82ssjtrUruOd6ySoPqh2XMWp1USIB+swDpfIpyJT5YfICafqiA4rEha4QXUPSp0XIJIouWWZ7QBRvm83W67xbtyQlJcDaKIgqek3ZGy/hpbU5Y1WoksURJlF4hSqxUG1NRFEJn+5FKWGV65A=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5066.namprd10.prod.outlook.com (2603:10b6:610:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 19:37:18 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6156.014; Mon, 27 Feb 2023
 19:37:18 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-10-nick.alcock@oracle.com>
        <86y1onw02k.wl-maz@kernel.org>
        <Y/jyJFXqlj9DlX9z@bombadil.infradead.org>
        <86wn47vue1.wl-maz@kernel.org>
        <Y/kXDqW+7d71C4wz@bombadil.infradead.org>
        <87v8jni6ls.fsf@esperi.org.uk>
        <Y/0F9SpM1HLO4Jm/@bombadil.infradead.org>
Emacs:  the only text editor known to get indigestion.
Date:   Mon, 27 Feb 2023 19:37:13 +0000
In-Reply-To: <Y/0F9SpM1HLO4Jm/@bombadil.infradead.org> (Luis Chamberlain's
        message of "Mon, 27 Feb 2023 11:35:17 -0800")
Message-ID: <87k002j3x2.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c9d507-cb25-4b90-67f9-08db18fa099e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1Qcv0XDvycRCETu/4PWX6wT31qBa2Ugx6qTDg8IJgQZrt/HuTeQHYS0GE9JFAnHxJvck2POq59G4n1AyrTh/NRV6QUlGjvB5WQfP6jjD3nKe+5bqWk1bTC5+TyiFmi56SkMroX4o5r6CFebmYnKnmCvg969ks8ffgR4K30gQN7DqDzaz3KVSDF5O88529cu5mBUb4m8ywoImArphW/8FJ/OA8Wxwyu1nN6NLPktjht4u4bunRlRGcHI9+TB5usCt1W35FRDeViLjJMeEvdglDSw36s3oTJwsn7xgpd7wiExJGVszNjWoih4F6LMvLscPgrqkcsbBxgMnu2KLf++5tcgs8leUUVr2jwm97IV+Dn+1hqIoJsMjTKHpqQe+z+QzmXRKpHkflyHghgPMZ7JWNL9wT01YEb4XrrgvfXoRR/kr4pTgmhZV/CPdGPqvVrxlY/E5/5xMVjM9JY/88xBehh6xiRo80hb2hVim9gJHYXywocufon9cV7XhPCJub/t9YV9+eND9hpwthJ3DPFkhlpXyGzmDusZ1F+lw60fgb7CYiTqR/CdWC5UAid39XDX+m1GLma3xSLjDvKc6kL4cB7BnciuKFK5q0FGRvjG7g+UrxD1ValDz7kqNI7GM74S+SeL+Vfck3NrG/aCGk8aYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199018)(38100700002)(2906002)(4744005)(44832011)(5660300002)(8936002)(66946007)(316002)(6486002)(86362001)(66476007)(66556008)(6506007)(9686003)(6512007)(4326008)(186003)(6916009)(8676002)(478600001)(36756003)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKVztudE0MKS502d//qjGYF25jy0s2jN93OiIt18ycRz0YrRyj02n/5v9yrH?=
 =?us-ascii?Q?nvV2HfPAIobRtU+XWCkdDVJFsRggjw/ptotjCmfVooZ1ct95h4jCkpGacSO+?=
 =?us-ascii?Q?Ct87+TIAI9x0YYRTzXTElmPhV5mb+qhXtMEcfgjs+Nr0mYTesxstJ//ruoRB?=
 =?us-ascii?Q?cNGGccEm4wOtGS70htHLFzMh1zf9h9VQA/Iul5GLp7O9z2XCYb93ZuP0wPY9?=
 =?us-ascii?Q?w25te023rEXJxrlYSaORBQv3Q01EZGHE8nPrvw6oh6h0F/bRF1MIEijOJ9IF?=
 =?us-ascii?Q?vAHJ3aTp3CYXF6rum0pFYLxKTKMcXehl4RFAQ9t8703yBuXBp0SZ14ShfCMV?=
 =?us-ascii?Q?4ND+gR+7PcGK7ZwFkE33WvTfDqe+Cya17s9yFu7CFU+SqKQpt8/SR313e9vk?=
 =?us-ascii?Q?pWZNBkI2pMB+OGIiwZigcRrsD5x8SGtt8l2wjh4U47xNZCS2CvLpFL5IOgRj?=
 =?us-ascii?Q?+yRckO/EsyHKy7xy/TOLoBhdLIfxVGFdiLJCqeZkBqMXTWL9PYjrG1krOXTE?=
 =?us-ascii?Q?lOPIGMwk52rUJ6UeTMQZrFukutoqK8O7WE/mK8aI9Z89yGpFVWyzct2sC1Br?=
 =?us-ascii?Q?GXuse4gNzVRkaswHUpHCmF6B/x+Gllf2QfkSD84D2xaDN2DjJwvIdnjZsv9a?=
 =?us-ascii?Q?gowQ0rtDr9X8/ex8xXAVXTHypUP8WfsIZTwrJQM/j66e8y6+JojPml0Xeyng?=
 =?us-ascii?Q?dDyVeaEcpwqPZhAJu+uVErG2ocBsISnOdFy2H0MNPeamgOI0bwgQ3SFcVose?=
 =?us-ascii?Q?/hsTwOXV4kbUyMQfzaEsagmGFxjYFVQa3P/SvEgs06jO155EUWd2VDhA6ZVr?=
 =?us-ascii?Q?i9vP2UfPcz1/VqypOlFFhwOOm/IuL+yCw8+75zn1jU39jq9qCSw7QD0zHauU?=
 =?us-ascii?Q?gcDXlowFzFbyBA1sqbi7rWazl9vI46TcX5j/v+umhnCjpYzxBMzcJ9uu1mBM?=
 =?us-ascii?Q?YuV83Ns9Xclj+Xgr/P/zgGXjyxN1IlLgPWbkJrEeibjrlSLzR/D+HP7Dmpfv?=
 =?us-ascii?Q?e3bHx+KVyCMHLdOgeEGy4pmtkSdg648D0BKmEOMAEzC8raB8UuZC0UE7lNCG?=
 =?us-ascii?Q?iDwqz3GQjmfkX4vIpMw84H1dZacpSx8YHh0x62oDbCABfBVnczDZmK9AH5ph?=
 =?us-ascii?Q?8qtfEhORyIvOVdnkfwF0K1lq40/dq9hkQdafKVCRQEFRUqsJicqgc+XSGnbH?=
 =?us-ascii?Q?iioXEM5dNr4+u0sIme+BekiaZgT/AejduSeD5Q+trI7fAuZ0m88UC8qIJa/Q?=
 =?us-ascii?Q?Ml5NHQk9cCYIbOidFJsD94lCXVNRTTjj51EZG7WgssJy66zvktKVtfR0Jsoc?=
 =?us-ascii?Q?XIxeO6wq8mGOWR3sUnTD/Hltx3K6cAvJh41jAwmKsILXbEIgnF6leKK3aWHf?=
 =?us-ascii?Q?3eIkMevXYaF+OTbfHUmpLt+x57n0fROjS/9q6YfVICYfhv02JU8nP0FWoDBi?=
 =?us-ascii?Q?S6ydrShCkR+OnY4ZkPsW6c/e95lblshLogMHHHyPACXgf3efE5x7haHO0wcw?=
 =?us-ascii?Q?UXoN3x7Av3FBEpMUTbITn+y4gu0fAeZJDzdLA4dytAz1Mk/B/IE/TJAnSZ4D?=
 =?us-ascii?Q?mUk5TckcdG43PMyivVNKRdzFQ5o26tMrbhdGcMnJxyNYwIc0oonb0kD09U9Z?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ux7xVUys4TEyf3hqrPeRETnMztAae+X8xSAHoVODmtgQ/XQ2Zs8WgyuNMkDqMeZW4MqfHW1tCObcn84rBnfc7DHXHrC+RybxsrrTqNcIoY+fgPJN2iu2gKyR0f4rfA/6R7Vn0kYLtwjpkxxPzca1DMJuuprVwpMQ2epD2W12iByZQ9PKKheD5PkIe2w+O/g6fExRi8qde6274EroJAeOWVcu8QnX0B2kLYMhYui0wgKs3PviAlPDZDTZorekmACFbDGVm17x/ovUZcPyT/GkbwME9kUQhZhurb7RTvA1NoyyBsn7s7K3lbALaBp5lbk0L5Ejae3GIUd6+MGM5rySo2V/Tc5pCGcsm05/HacYjq2uruuSiX9PlwytKODVHO6vqvjKbXSMcHBs4ou4eoaNQCJhIxnxNPNnlRQNLvdcx5bLUwv52CMFsU1rmpBy3l5bsZAZFnvBBKq7FaAMa4oJfyu9/O8yI25OhoJULe7TiyHApNsbWHeKGO++Kd/fQwn97YlbfsqG5uMDkMIlR7qBFdfpu+P3piVve8RJpYnzHe6N799IgS2VGi1HbltRKHZ+4mdh1qfHUSczx9WweXrYDR3+vOlKb5UfKjScgXgYVyAjKSztCV8F79QkGvIZQMrPlALO1G2xFWdDyhaEQixHOUzJZBvIPOwqH6sbqnNF9/dBTLGkjvWG3BobGiKMRsh26xTuRiP7zRyaCqWJ+TuXg+SKYa/cIweQ8eNDHPZGK0PahELUxk63s6ZVS0qRNls0QmK7p3qzlYpOV6nKax3iHTaB7J7+g3A2sR5PJyPaJPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c9d507-cb25-4b90-67f9-08db18fa099e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:37:18.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJbsWhhaNRDOxGGDXJTkHVSvgOSp38WQ6Ic8p/8on7PyXdQce6ofBqTydpbCkWE4WS7NNnPDd7ftkBInuHkCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_16,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270155
X-Proofpoint-ORIG-GUID: YPUilSyfQ78GVNafblbBOAoja_fJ3Oto
X-Proofpoint-GUID: YPUilSyfQ78GVNafblbBOAoja_fJ3Oto
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 2023, Luis Chamberlain outgrape:

> Cover letters die, commit logs don't. So use it either as part of the
> commit log or refer to this thread on the commit log. You can also try
> to condense / paraphrase my description somehow too.

Hm. The commit logs have partly been pulled into other trees and are
thus to a degree set in stone. I can cite your post in the upcoming
pushes though, and in the -rc3 "whatever is left".

Thanks for the advice :)

-- 
NULL && (void)
