Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA586B1307
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCHUZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCHUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:25:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F273D13FC;
        Wed,  8 Mar 2023 12:25:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Jwjaq018311;
        Wed, 8 Mar 2023 20:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UDvhfzukpdfsnCOO/LwrdXHFhZP5K3KvzpQHAqy0DMA=;
 b=kkofvUJ8EmRcJRI0bePdiwnFcVXxvR4ddFx1wHufHvGR6mKQQrI/78FFr92txTpKBzT9
 EeWPm9i9/E/1s+iWXFkxd5//j6xPi7lBijFgnBe0CsvVBgV8kVlxG2fnHHHyzbDA/IuQ
 yQ0jTBCl4iogwIy21KW7qjUbNZKJqCnfoAbH9L+L26HnuqDOOBQQJblcv8w+n0it8egz
 Ws/tpDFy9jYPe/7GG5fzWdGJBHgN0jPxqAOJb9i60maEwBf3XduKnNrcvzk52llar9TO
 oN7dvAGoIinMwj9/Fv7arZqslr/aEZthpxFFTMyC7jHRkxCwpLAo8Dntmyy+mEGQkWOo WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ch4rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:25:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328J6CWf015486;
        Wed, 8 Mar 2023 20:25:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femsq9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E04mPRcJMsvjHT/EQyiFnt4GaDWVqmiJ5t8cVxzwBqc29P1fGA7KdexGterVorZwiRmL0fGy35+qm46k5/BW+37MaXZH8ymSzKxlWG7/OpH1IufKGpsDZGCAvGAXW9rZ8UXm+tZjZlek2sBTo/R80HZJ1y/bOfPL0YG8VE/O6PDHAZUC5W6uDdPINzrV38eokfxig6Bw5iVMpqoxBARFJ1s63kEFnN/fa1R4Cmr7EJVxxKpGvf5iT4uPFG5wEAnk8XAnmpj1eMaid8xEVDUZgXQlwxq4tzapNEYWChQ1CjursNTFTTiYEvXKbtLo52W6FxYRI+Rq/nrvK8DugyT88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDvhfzukpdfsnCOO/LwrdXHFhZP5K3KvzpQHAqy0DMA=;
 b=UHx92UYKwXTYFTSYKV9qLBDt2MzEBW/iXBmKAPf5/YMYcRnR421MUT8B6k2wPsT/GzbLpJwqA+HThJ7dbE93aRjEGUEwaTKD/+n8GluOCQEVXcCbLnTMg7HphG88NXj4pJmfo1Lly1wZTtv1sSnBieSb7BgO0W6r0md/fvMbMgvUznGAJPj+llq+nHZY67Ffdy/tZM8U/3I70oQKSZcpMy/4z3wcPuf0QRS/bl/eC21NGmgrkUDi6F4loSOlnTcOSa8JU+l/YPzoMNdBwzZSNH0QZMGK1kqOlFVfeb1akNa4zsEngor+lsviHi8E3UOHqffv0wNIPW2ukoMMF0+E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDvhfzukpdfsnCOO/LwrdXHFhZP5K3KvzpQHAqy0DMA=;
 b=KB/UNEhh+L+BMY0z7TUEk0AXgARRkcscyGLFdyDYOLSSt2aDiW4jAQ3Ule2Y7ttVofY+NUTQs68nnnjjK2Iog+9wLVPaLL5uOm+PLacyU/EvIv6vGx6MuE35/d7D186aAnLsCq/oYVx2xp1ufSW14Wq5CKY/QyVWg++JAf9Akhw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 20:25:14 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 20:25:14 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 15/27] memory: tegra: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-16-nick.alcock@oracle.com>
        <c6f39365-e840-d782-8ec0-e34ec3681b98@linaro.org>
        <acc27e8f-73ce-39ee-3666-461f5c72d39d@linaro.org>
        <87h6ux7qhp.fsf@esperi.org.uk>
        <16bee433-0088-d651-9592-96a2bb827b7f@linaro.org>
Emacs:  Lovecraft was an optimist.
Date:   Wed, 08 Mar 2023 20:25:09 +0000
In-Reply-To: <16bee433-0088-d651-9592-96a2bb827b7f@linaro.org> (Krzysztof
        Kozlowski's message of "Mon, 6 Mar 2023 19:25:26 +0100")
Message-ID: <87zg8n3s9m.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0332.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 33720a2e-71e9-481b-17b9-08db20133998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfR5KewToH24szRhrkrvklfVH+fnwivLeJ3tQiEqeEiM7a9Yvz0BXiZTxfZsmXmWS94QKc4FhW6fnpJMPbEjUI3WiZRIdSaBGV13uPiF0BXNbhBGR+ufkAE9HHPClEm+TvluljXR87oWrmOTmRrrlhJ5jvf+rGbsJi/LVUEOYi5L5EGe/tyP0COmmAD5U1OyD29GeWghuoKr+IuPvfJ8sf4997ohnV694YtczxtxZXFhx4IOcHP92BdQR3KubTH9gBbeYKcpk68/OQ+7SHucrRXWxWFVemN/WTAODZxAi5SR/f5a7KAd1DvlRmR79j1eQ8+4taka/gB0Ai2zAWAXCY2Dd5UJrjfN7Q7E+m6m6OM1zG39VQT4BSDU0QVcuuIbEw0flEybU74RPD9zA813PfKtt2utTH3FTxhU3CwJzsfGGXptduUMszPR1cfQqcj/jleAeSaqaVesn1VlYP6APxjpn0lw0TehoUEaH26Np0Tc6Nb5ZF8QGVyl8gRY3+dcM/JTI2ud+5T5KU68mMrKckYCSBj0HoG+yOxZc57cfmmnJ6eVe56My3zGJBx/ocbNHqwnuCwiYmnQGV6986a9uhqeJm3mSWm1UNsegDr7G8w9yHWDS+T8b9Ms32c5r+sAsMAfzx96+yNyRTS52Pj3NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(4326008)(66946007)(8676002)(66556008)(66476007)(6916009)(41300700001)(316002)(54906003)(86362001)(478600001)(6486002)(6666004)(6512007)(6506007)(53546011)(9686003)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oc0N/ZBB8uS5l/b9an8eokNrPwVvUXQc2mQhNaHg176QvkS6nZjLE6T7LqGc?=
 =?us-ascii?Q?kukshsb0HqwR5gba51snhfEVhCa5RyQF3NwFHSFPWJU4wAFP9rgozrFVEXcs?=
 =?us-ascii?Q?dYR49OijAfA7OQCzE2ydmGMzgiuvBGAp3efYUoLwM44OLxOsDi+HJcqjS9mZ?=
 =?us-ascii?Q?sHFsSK6ZMldJuOP9EjXgA58PHDnkZKUv1IrC7NCeWQ06nqB6UEf/jsbj/6W7?=
 =?us-ascii?Q?K/6KrKfBmbLHDssgFqA5iqimb6csujy50zrUzG5Z9kmMiB4Q4hzM0bkcTVPE?=
 =?us-ascii?Q?5PGT5f6COLFFceEvZlr5wBkjE1Mpa+X/HBTIQqUIXPbATyTKZjiTtxwfUW6a?=
 =?us-ascii?Q?ZGaM4VduXfthKwA+8Wv8un45QeK2emCYD40KNFfxMXy+0adACaWJA9tAcmnU?=
 =?us-ascii?Q?3UrLxBdmwxsTQKhqcg9rjTvdUkyc+fWwnJNoyRpqvO7xZuiDlVNE1n0gy1YI?=
 =?us-ascii?Q?5dpsJgo7BICPu6svP68gsqFALsfa/6ztfkVOXAlFCBbC2z6sJeV6fFji3PXJ?=
 =?us-ascii?Q?9gcD6D+g10aJeY8NUn2BfGobxAcwnUVBV6EGu3Ef1PjIDGZGb8NvzMDoTqti?=
 =?us-ascii?Q?z0YAON/mARj6lNJGdSdglUJ9QKyRYX6HRM+4p3xC/c5KxFllQJmzTI/bYfo0?=
 =?us-ascii?Q?CCRD5jiuP2KWehl7Av2V+XAmak4MJ5XpnRwNB5eRiut7nz059zpW+Z2g0afM?=
 =?us-ascii?Q?sHt/jaYB/ouYAUmFNAfhRhWB3aO9yutF0OnGmz8FUUlBezk19SyiiAabbBjM?=
 =?us-ascii?Q?Bv39UK6qbNic88YrU+58MY7qIEYdZjbGn06edZCD66n9PuhdAc/PCDa3xm0G?=
 =?us-ascii?Q?vb6MvlbjmF7QlFLRCVWxmdX+icn/8NzzEon72q5y7qdkEIF94PRSjNixusM0?=
 =?us-ascii?Q?JpltsU0a1GcPuzyxfzQy+YyYb8gVeQBpkgKjZnLQ29e2/EarnPk44HJZzU58?=
 =?us-ascii?Q?kKUeaE2iYc01Ts2bdFaaAkhyAhk1obt/xehOuX8oQTjvV1wYtgTFlJbJyZZB?=
 =?us-ascii?Q?6MjjVAzP1LunlmE+LMI7Hc1aXpLFGxUL4ZSvD0m4F0QxJiBXbFkQxwOzF+PI?=
 =?us-ascii?Q?FK2vhvZsFhon4tKZanF9Jesy7ge2S49yBr38CBOM2HbDjVLp7VD8hssX468V?=
 =?us-ascii?Q?2bRToTPIbw53S+YVpUHWxAuW83NIJ/jtuNxgYoXlHemiSFxAbCmILKjdt48R?=
 =?us-ascii?Q?uPV1VhKQ6Xcppq/2gfoMWidcvBjHtouDuPXzMZqSwOagoXDucCL421lKk90w?=
 =?us-ascii?Q?/L+kVnBB9H9Qr33VPOroHt5mGKoTFWZ1gg9ShErmKBM8SeLPJ99qiCG/lr+k?=
 =?us-ascii?Q?pJYWjW0219erCGuLiQkdASf/TWD1wHMG/811CbD14mW98ENXqiJlbO7dWKDo?=
 =?us-ascii?Q?TIZXJzxtdOHFLkCzO+amCjZqIcVHBJL7bvES6/XbtGRFJZjnCDD3LeEBA/5u?=
 =?us-ascii?Q?nJDJh4Sg5Fda5fzQgeSbcIW0BtbticnlK7WBmnociDi8MWfySbrjl7Nmmad/?=
 =?us-ascii?Q?zNMgFwCWG3eo9Hqm2HYKeMRJFwlPsdeeF4fYP3KojH7WM7e88yDbVwUXBRp4?=
 =?us-ascii?Q?V2kODWj6jIhWNg4LXcqdMO1+f6VdfwdMil4Ep+vhPY0qhm4alIg9ltUdJbsL?=
 =?us-ascii?Q?2Qqvb12Krl5GAvCpueUJFTg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /RgLQvoowOMu7ihwsqSsIIUl5TmvbrHY3vvDYm3vXOchRRb8iCVs2gB3Y7AyuQnBTpo9u2LmhQqy+lC/xZueeCqEcv5hIUZZTwZ8vBELRbTAcplGG77Kl3iOdRV3MWzsDYDsCWyLJ27mPuS6fNTj0wZX7nSSat0kPTW7r8BxI+tss/1Cx74DWQkboXaQ0Kqc0IUf4TYJ2aat/6N0X17omKBsWC2xyYru6hs9oVzx0Rk6VHXsSOHVck3fE0L8LfAe6TmsttO9Sa74kcx/W1MG72qWhbjEs4RLEdRvsA4NEm9/7lKufyl7fPOtOgZtNnhTC2pFTu5Kx2iZBoETK7tRmr+6WvpCDIFxVfBp8IPTwdeHC5FJ7FDKnDmf08ZKcrxlGmkm8wnxDPNIHyyklTicvi6NKIgxgsYoF+vplk4rx2lZVl7JQ/2feAtLEIKTnCN27cQhkIAf47LIVlGOmnU7wKTyTj/H16ysyClx4sV+6HY5D6Np6z+OCrmFVRO+1L8ZaDn9sp5FUPMh12R6y5forezxRV6LzWZcsnlvXqZwxJEPSKbUiKamMxnJzieq3d/WmLU9/WIfFcHhVFX6wp9seiWbYfiPAjOy22+xWD9DlFogjPbaBaV3qhPXKMx9QwvfxKeUXiaQ2DyGLH//OJo0AwYREsHRMaEAofeuHyBT0PaZi3BbVrH+TiL1WP/zhAnSOreZsNzG6eWTh92Olo2U400eJtf2Eqdi47ysVTTTZG42ZUXtU5IdP4cnvVyT/Ds4TLBivWB+L0Gsyok1IwIXYgP7I7C22oUMek0JEUt4ij7avELdJUk8BWA6Bn0Oqp7hXwXdLbCkFqUrWnQS3FQgR6CJJCJCuHBa4+Euu4OFmAagtrIgQ/zQsId8wHpjF1BUgFaBTGDHeUsh7g8+Kxx3xA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33720a2e-71e9-481b-17b9-08db20133998
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:25:14.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sn6lREfXy0Q6RbMAevqTKjJ34AJmsqQJUXUtap63YiNYmrkElwA6q0wuP7jEdzLkvfWGeI3X4mXYPp8CwHbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=762 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080171
X-Proofpoint-GUID: JEnu01dpFQG0TduvNrCKGST2pZUXc4-o
X-Proofpoint-ORIG-GUID: JEnu01dpFQG0TduvNrCKGST2pZUXc4-o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Mar 2023, Krzysztof Kozlowski stated:

> On 06/03/2023 18:13, Nick Alcock wrote:
>> On 6 Mar 2023, Krzysztof Kozlowski told this:
>> 
>>> On 06/03/2023 15:30, Krzysztof Kozlowski wrote:
>>>> On 24/02/2023 16:07, Nick Alcock wrote:
>>>>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>>>>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>>>>> are used to identify modules. As a consequence, uses of the macro
>>>>> in non-modules will cause modprobe to misidentify their containing
>>>>> object file as a module when it is not (false positives), and modprobe
>>>>> might succeed rather than failing with a suitable error message.
>>>>>
>>>>> So remove it in the files in this commit, none of which can be built as
>>>>> modules.
>>>>
>>>> Applied as well. Squashed with next one. Same subject messes with b4, so
>>>> prefix should be corrected if these were to stay as separate patches.
>>>
>>> And all dropped. Run checkpatch before sending patches.
>> 
>> So... which of the 27 patches n this series is being dropped? It would
>> also be nice to know what the checkpatch problems were, because all I
>> can see from checkpatch is one error per patch, an apparent false
>
> The ones I responded that I applied - so the memory controller ones.

OK, resent those three (now two), checkpatch-clean and fused identical
subjects together. (Not adjusted non-memory-controller patch commit
logs, to avoid causing disruption with those that are already flowing
into the tree.)

Hope this is better :)

-- 
NULL && (void)
