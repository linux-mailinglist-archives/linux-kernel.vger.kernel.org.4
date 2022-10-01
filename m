Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFEA5F1B9F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJAJ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJAJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:57:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26BFA0FA;
        Sat,  1 Oct 2022 02:57:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2913Bw4D006806;
        Sat, 1 Oct 2022 09:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3xKK/xm0geVKfuD7xGRa85jf0N67e4zmN9SNPWaD178=;
 b=Q4X5tTpvATL5NFbkiawuOKxTV6ocpkbZ4U6+GlWVVjwK54igux9AmOvvzbobR+TXvlo0
 MGcpxaj8azWqz70iFYfrsLw0BMTiNXw6uFLI00JxN1vZeQJgUzSCGZeFFVWcGSyet3SL
 WI2qpxPOikALDweqDzrwhvxNtioIHugQSx8S9eezO3cotPNLUbIKgQ6UbqtJzrnqgVxy
 8uuCn8iLZ5QWsGMhgGh39MngQgdr+OCDL+B2EzKGDGuDx66Ri/lWYhKDEuK0Wk/cYSmq
 affxVkkzUF2Jvu+Y31/8+bFl/7aCTtHPKR0ylBVAvJREKgCQp9/scbfzrWKUzdM7VKBv gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea0dy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:56:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29180GVH016504;
        Sat, 1 Oct 2022 09:56:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc01xbf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 09:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cssl6pKyCmI3R4hE0ZE0c0VTmSW5VQ7sU2C35YKhghmedipnJdxR+g36ySKMApdOK+wX95Vl6EIHeRmOtDf/VoELwODUxXQgA502KmSFxrI+BqcqQwcLHq3JYYtCpBx2R6cJoUu/+jPbvaTUTOY5zoBeXId39yO72FS99giUKeGxqRfFFjny1eu2KFEXPDVVeR0rK8i8O6EvBrL9O+D/XEHZ6JU8jfRwLFtgp0PHtERG8z1EWMQv/Iwf+B5VNOwQjU/RGGk7iULGA1ISHEqrLtu4Xg3nUb5mhDUl6GRGMWkMtInujzL9150JUJj00swVQkimPKVX6QkRhVALME040Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xKK/xm0geVKfuD7xGRa85jf0N67e4zmN9SNPWaD178=;
 b=TwwKSPmf5vlW40EDvysjTBuOlQE0bukLMSIj6XPWJd2v6y0RQ5LZKbrJbC2076RgmlaY38OcxjyFhJResKbDcx2P0MrdwCUVnmWIx0LABtipQblLyIePQZd69CrPk2T/EPp5Yy708F0BIPfhyCpv1uHjzWJRBGw7R9Ycyj6T3nosDnk8FVQYxVSahhqdfCii/spNXUGo0VmkvGOauzf3Lf7C/+FS3Mv5YgBbxR6Fgay0yNfv8wS4w7TxbnFkGV+5zameOlHVIDiqeFrbzmA4WT2B036GQJjAv8ip6nquXxZDTXR1EhMX/EurhcUY83CPo5AopkMzP1j2n/FP8CBDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xKK/xm0geVKfuD7xGRa85jf0N67e4zmN9SNPWaD178=;
 b=GWg+jZTJ+vHtJyCB1ojV5qtPb0tSA32Q66zdsv99tuwC26WiaXAcH6klkwEE9X8B7NVKWU6vSOs+zhY7ovv1jUwB8y4sD1kiu7qyLhKswPSgUOyKXqmxcOut8U0XLZDasJCPetvQZ3G90oqLHUFaPCXqMxlslB5rnKn6wWwTAPM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sat, 1 Oct
 2022 09:56:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 09:56:54 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Fix spelling mistake "unsolicted" ->
 "unsolicited"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jwnkgti.fsf@ca-mkp.ca.oracle.com>
References: <20220928222116.68294-1-colin.i.king@gmail.com>
Date:   Sat, 01 Oct 2022 05:56:52 -0400
In-Reply-To: <20220928222116.68294-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Wed, 28 Sep 2022 23:21:16 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b90d772-d5df-47df-0588-08daa3934543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ic/74iAfqq2H1KnlNnPM330NMhWVsLBMgfadSrfOWjxa54Fysp4I6Q8qs+yygWlz1QUl3SuXuSTsl5c5daMkWOhHWXjxnTRFt14h9H2TJKAL3PIklBOWOqNZKz1Y3T0fDb7n94t8Q3dRop1etCRNPOG/XR3301tpy320xm5WSBGCdjOdSvmbTtge3sxy7QOf4ZWROSt/76Xt/uBHv9lVqMS9NALjIzJbHkm5XJDTK8i0mxps43tG7lHv+8U8TcsDu2XHLSqOWoe7kf5RPBRfKaZpWfq7L50yA82JkPp+D5xwv4hOunrr+CXlalVorWPJ8CBz9GI55vbfOGr4L3azzqgCEYSDiMDmAYPEsYmJiivDg3FZxQ9oEBlyR7aG5NXwcLpd2TAc33gkgHXRw5HUoivTRz5wYKSll9Jiddnlbl0S5iSleiP8F5mBaghOowmJ6Djt2pb7jEPzPnX40w4Aveked4wxKBXYf1k+AoFLWYnHJGMZaJBZQ/ecERXW87kvUgI9Z1rZB28ow7YmGkgCji3YLkmPVDRi+k3KgJ4GvT8h+W50KCJzp3S+/HzR7JXNbGyy5iBmwTZf9A24Rq/0N5CIt+3QxAr+gqaQR3FnOZVyEkkIjy3MzeRE9tF6xvWMS/Q/JEfy1EpJlbFYkaqNZGk6BhAvPEo98oPfet0/kxvXK1gBchSnvjfk5rNNEg9gPl4+3BQWIB/uu1GPXSgfIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(6486002)(41300700001)(66556008)(66476007)(8676002)(66946007)(54906003)(5660300002)(6916009)(86362001)(4326008)(38100700002)(558084003)(8936002)(316002)(6512007)(26005)(36916002)(186003)(2906002)(6506007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WoKB4j7dAPTEk54HZ3o3wMXxe2o93YTzd9yuQAGQsEFoAHzqjxeKDyUkdxjQ?=
 =?us-ascii?Q?yJkAT75XCR0rWaw57ofpSP3wze05wYYJyLFoZpIph5hXRHF18TLM34T4gFwt?=
 =?us-ascii?Q?iV7wbLXwdRoQZOETEFAQM5TNbN8mr1JYOTXKNtz4uPjUATIMKlxpYW+QbDi4?=
 =?us-ascii?Q?v/5lRPHSBPQvzuswTQGL9I3AZqF80Q/8duzLCrF7XomIJW0wfgcIBVrTtXOB?=
 =?us-ascii?Q?TgNNtK2GG2n3HPfWt35P2ZaBetsYVau27DUQt2DSSAxL4MHyZpMbXg6E6xna?=
 =?us-ascii?Q?itzoATw1KySlaoI5Pf0Fre3tHorN2LYuUFtzCGu9g+slJ1mltXUPOVoV12FA?=
 =?us-ascii?Q?V+NhXrS/HDGK+tnTUvMS4/D9hfJqt7lHgZAf4sb4D/kryQMApVaE6k9UpM7e?=
 =?us-ascii?Q?xXBBQhorrb9Mu6SpH/yz0HYuKyFtHzVv/PMCghQ5LviTRcnO194ac3dO/Vma?=
 =?us-ascii?Q?r5CwGw7ueAqiSe8uPXklM/zYn0lzylgjjxes5wN4u+wwuxewbNfkzZrSSG1Y?=
 =?us-ascii?Q?4gbHXK05zLxB7eSXUUXZmU+Ag+fqZgqNSiB1kHVMdGdJjn39v/BS47ViCLmG?=
 =?us-ascii?Q?zi292h22+xWVp4rDNDyJhRjXiOXviDiphGKHQMXKDVKSbXayTEqANO7DGfLc?=
 =?us-ascii?Q?wsuOpvQDGCZiCx8y0IY9yRhJErPOCTcpUgOvOE0zfCKWuOdAtDZeA73i9JjG?=
 =?us-ascii?Q?GZhE3V7IeCRiu3Wo0fw3V67drk2srIOGiOWVPz9fRnj8pHeXVbQkze32AHnf?=
 =?us-ascii?Q?pQYS4qSwk7eh5NsJizlNiOAAyHmqf1Jmrrl4OatlXrtZYZbXgfAisdk7rhAn?=
 =?us-ascii?Q?V8SNKq2T0dryfX0OD/LT/q12o5OCp1bc7Lw/y0shsL5M7B/Rnm6HmW0pjAUn?=
 =?us-ascii?Q?OcLOu3PdVL5zN7vG6Nq5j9/3rPUImdR6RG+hB3d+6afNo3XkMoCnwIx35M95?=
 =?us-ascii?Q?xFEGi9utxSr7QApfqE25ws1V+1asAvfMrhpyjVNo0QIy3A21EgHVk5IERMKK?=
 =?us-ascii?Q?/nkoTIynBBiKMI2IprywXv4aYfmgjZMqUOvar0UPPxJdXEC02Q4SqAiy7olv?=
 =?us-ascii?Q?nBq6xdrb2B5W+NV599XWxyN1RhjDsz4zedMpGB53MKrnNhv18FfzmuQV511W?=
 =?us-ascii?Q?Z+8lVDOMvWG/MIr24L+TfJOFT8SmjwQHl0ldvpP0f7jdY+bsVbCcQ+jcz4Ia?=
 =?us-ascii?Q?EQEf2Losb3WYxeZcjJJuJgD/39KbO9mXClIFmcasG0FfQTr3PgebjcQJDHQu?=
 =?us-ascii?Q?yMk1sWpoe/E3wdDNebVutiDs1EvIoiB4q6fpA+ORb8lr8cDdeq3H9NRYnx6t?=
 =?us-ascii?Q?DB3Coat0rD9qjnhcXM+5qSQSF+AE7zLcIlT2oMKfAgiv9Y6IMNVgjFVp/8KJ?=
 =?us-ascii?Q?M7O5AN5MYDfghWa4Lgd7+Q0rlvVORxONaXILxy4+ndAicSJE0nOg3s/DyusP?=
 =?us-ascii?Q?dUl6z8Anw8FfFcK9eTxtu2z/pOB8EPKO/jTaVYfhixPSheUfWAyTIoVlrsF7?=
 =?us-ascii?Q?cQQQu/P6RtAsZrKmsj+8cPvGyAHPH1cNszjPGUbZpowX4RRBYYv5KxQ7owIt?=
 =?us-ascii?Q?QIhfbWSjFc5pU1soIvfc1urGbxyevUFdbN5/wLNrZ4/iLmZ0+ivvNgBpjOKZ?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b90d772-d5df-47df-0588-08daa3934543
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 09:56:54.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TurlSSmJkmdO5mPGefe4f/9/Aox8prCv5632P7QQgj8kE+RXmZaj8eLAPuj6F1eXAqFjHNxwgmIT8tzutVfC2fwqv6v6n/hfZ9slSLADUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=854
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010062
X-Proofpoint-GUID: r3YUGgUIJ-_OPX40QcTzWtNka5ESfCO_
X-Proofpoint-ORIG-GUID: r3YUGgUIJ-_OPX40QcTzWtNka5ESfCO_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are spelling mistakes in a log message and two comments. Fix
> them.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
