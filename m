Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62245FDB64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJMNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJMNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:48:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2091.outbound.protection.outlook.com [40.92.98.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5BA11B2C6;
        Thu, 13 Oct 2022 06:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+8v32CNFZHVfbWflig5NqmZqnmSGKlRxdBCQv3r3AnsEUNceTY4FzoLV+vKzkCAETLS9SWLckjxiwi3Axc/l9A0d07ZPs1Si2FddtVPoieNNYVwcaKDdGmmo6jhgnsLpyzF3QAjGafg9SbmP2dMo0QuZUxpliW7NMMIEKWCV8mudXJBMwmDo2CUYjyR1G/rdnA0vqf0iw4cwoMlKfg0z03RjQ2GjeaZq7RR+WR0gAsOq2TcbCj5faROFrtjySot0B3HkoHfVImTr5Z/oipNYmxsSJzdFIXQIfDXKZLxIT8w8ySIL4O1tqgGolrD4eqotO9Id3AyMjvOEFSxDizj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+3EvavTsoWN6VaBVcrcI4IN20boKXa/gkD+3f3mW9A=;
 b=Gf6FTyvOjlJB5HgEUpF4XLpjQsNVyWT5fb+DGi4mxqAK/raytUzYQs0Y3qlKXRPaNDEWwh0ERJenZ8QkRnSz4oDSyyIPH/8daXM021znHYfKmV0ZfcDlFLGLeuiu55Z2IF0yHBENSSnt2QO8w0hZfv/xtzNpYh60eCAilVdoDjoo7A8q1nIRCXCiKXdzt2dCb6E/JX4/FfnF188z3RrOPTkpaZncyQG/fi2hM73KdooDtzapa9tqHlLBBNEarlrnJ/8BRReQtYDMxFQdGQSj4141ZKT49WoilSLpu11V0pGux49UfriZUUlgKqIC5eY6fqbaOrDNboG+F+aUrszEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+3EvavTsoWN6VaBVcrcI4IN20boKXa/gkD+3f3mW9A=;
 b=r4CYRI5AE+kI30U+tSFDmBIFKSNjERPjMpMsvZn9dYitB5Ho/7LgxJkwwwNEyKjJVXdqPMUQSHwPfifPuWyCRJPQFS2YdYW5kN+Xs1Kp9H31pT6C/i2IdzuFUNNoDj5pLeWcoJHHTea+2kAZigD4uCCo0QjAu1anpzGF8At3YAYP1AjUiN4KXHe2T714kB5un8+FqpBabBxOIhww1rLhQpLHNLkrO0MViI0vR29HPZgDbfaO3FqVcM6ag+a+P6hOp3/4Pqg3WhEPWSoOo6O7X9AP94EW2/kZq4cQNflOdCtuViBDoBkfjGEEL2nRZrD1+hNESNBlGcgetTs9StfhYg==
Received: from OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:82::12)
 by OSZP286MB2412.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 13:47:52 +0000
Received: from OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7fa1:f154:53ce:939a]) by OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7fa1:f154:53ce:939a%8]) with mapi id 15.20.5709.024; Thu, 13 Oct 2022
 13:47:52 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     yukuai1@huaweicloud.com
Cc:     axboe@kernel.dk, chenjinlong2016@outlook.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] blk-mq: put the reference of the io scheduler module after switching back
Date:   Thu, 13 Oct 2022 21:47:33 +0800
Message-ID: <OSYP286MB0344F8B1AC5F35BEA990B593BE259@OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b79a8187-5342-8ff3-73fc-0324bdfb67fb@huaweicloud.com>
References: <b79a8187-5342-8ff3-73fc-0324bdfb67fb@huaweicloud.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [zefX+bJQrlArnJKRaAzuiB9p+6uFwRJk]
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:82::12)
X-Microsoft-Original-Message-ID: <20221013134733.21207-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSYP286MB0344:EE_|OSZP286MB2412:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d3608c-c138-4411-70e9-08daad218587
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGltGXZ5hP6IVfgoZ9qi9retvdSL+iY+H6YskAd2sUnFzx0JGQNJEJqOn0dER4ZMCybef0xTsyhhdgv47IttuQ2wFnHQ1QDooflwrsiuHcLmxxOtHxDic/aPRZM1PrkeAvQzRp6IPnhWmfzwu4kIpBSOn4a3nAnJteHYfYfxGiB5VXl/NWTh6ARg5vUmZg+ExPkWobktJhkS0NTRgK4xNmYTrLeA5eE4mQTo/e3KXpHbS9CRqoK874Kku1ehUSDqPZgfVm/V2jWvPkB0dP4pxGkzUz8Kxm2yhMF/G1//prp6C1RmMu3Oc+jxArHQdhk7hbMDm8SKXD0y2pdgeIdsuZaf3LiLbvW5Eg1FOxhiaq4K/ygn0KdhGdhOmhhJvcaqrgwydCnnmGX6zlJmBlkIVKe9ARGPLQhp9nM6oe6L1wXc3wjGe0yMXi6EOYjxrurHb27FxiT0xvvk5OmHhds2/ELxsOYjiqdVrc3kZu8Le6USlrjbebLlax3hZCtCkvhIge5Hc6+drPTjeYvooKwsU3hs5n/TAsqW0s64BpmcK/N6ow1VO7BgvsxoBGuGZXWDTaneJY74EzfXOrxOSUFytLMcqnijkbi1Be8niESxxUaWuiECz44INDH6iNwo8f631GmnDXb1q161F7bfpIMhtuM8feD7/Tzfyl3w48wFalM4ENKMn0KsILI6WlhvP63KmRCH5WG1RhwhM6cmgPyHw1ehE/+NXmLAwTl/88NiARYk2OQyGF0gzK63j
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ+962e+jPGff3+MVLz90ZBHfwOwXZE2C/7SahWgHlQIldYAXeIiIdpSUmBaqmtfH591DT7EJhVQme0NBI81dKsoaV2EQCMkUjQQZTqCx0+chBiTXQUJSNpu9W82RcSzPubponMoyPVtwAjZn29MMCBA+LlpoMd+ykkF3rVuQvsZT8Xe3Ql5Ra6c1sTWgZFB6mxhtjXUDvYyHyuEhMT5DUDPe6kd17Su+hTnkXF4+QTonzWT9i2u9LrWS8CnsTJHkxbh5fdfi79/dR3+6xt18ymzRsp5Fc0MFsF1kXkIwCIlHdkowFyLYRoOoLX6nLTA/Wu8m1brghwiiz6T30qmxS2IS79eFsFEPrb70q41uSTwh+1+hM8KfCYL18VOtzKAQb91OVDxUMcB/y8QOCq/g6F3r6OfGQRF8HW9FOBp8xHsYOpHFZhUxOaLhWHQgVEPqbfJjeHST/Qn9Yng1iPCDzkInDByI5ktRJiCgKAcEc3VsfXlsPuVHqs7mzLyWyihPHrKKiu7OtJKvbSRV8oa9shaW6NOZbiJnowO9xbbKmMHtrlxyqpiS4NrNyJSXQcjKTGPzBwx38CSD310FjGt+z7hYb5q9kWKmwUoiXM6Idtk0CPWDz7fxpPupgeOeDCFeydjwNYWaQMEi6fUtJoxrb7iTSkuDeXoq4hsNPy4+3ljoyKOj9LqTaDC/111yzB5lOhz0ormBnnOr0jNrSBps/Veg2OsEQhLHZdtbUpTRrE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjjOVqnXPGuiFnyCPYeEtund//XbXFXDp0dZ7+92CB8H+798l5I9V52gvrpc?=
 =?us-ascii?Q?GVRKmBI1RrgfxatgnGVd/QFiIq0yXpb7J96RBe8CBjrqL+1R/K+hc/11LD7R?=
 =?us-ascii?Q?O010Fts55OmuViW7hjTqL+maGP7UnafJ+YJ7SMr1/4nreOk8Rs5klqnPTpta?=
 =?us-ascii?Q?LIkz++0QVYn/JBw+Zq/DKgQDj9m8CEM4utiS3GkGuyTdB2D5nUFlPGp/GS/O?=
 =?us-ascii?Q?/pbYtQqMgBBjS7qIPssR3ONn3VcDmSEQJLSYyALjPW9vJjZ/N80CAoc7JPgM?=
 =?us-ascii?Q?Iqaq/etiBl13L1kB+xFgeQ7FfU7E/5V+wzXZ82ch8+mG3Dv4q02SuHrSMht2?=
 =?us-ascii?Q?Uxn8uiO+YFocQA6kpsiNFBKUIRX4nIeb4/YQMr+Wkac2s77vgNE+RB278H1+?=
 =?us-ascii?Q?UK4RLJOxpv1wqnYCAaBXOWieSUCUQJ0tpY9CIZFJcxglTik1tekRbJncyMOu?=
 =?us-ascii?Q?Be6VRo2yWDMu8LIwx2I+IOqQt2sVKyJUHZJekSebQUVaOi+zdM/mEXkG8dlw?=
 =?us-ascii?Q?QSLMzO6/k0maLITraxFjgeK8mogWgZ0o8eH4Z2vVlLFSfdv083x/kPEINTUt?=
 =?us-ascii?Q?cf72VdpCmfBQxvf40tZ5uXJeYY0knKkM2wEDgYUryjmsBLjTEj0VwI9t3Zf6?=
 =?us-ascii?Q?eyQjb4pAUncCBbOkzPOnImSFBvYcvyuR03CY8NB0TORA4dzl5QwTleoo3QLJ?=
 =?us-ascii?Q?0HGbSdH/Vfdb160QovCBXiz3UVzVHzs5VRf8PLHxoG9R7eoJBei20nPOiCdd?=
 =?us-ascii?Q?eExThUVkJRFPyZAO3QZ7NF5WdEfnILbLDyGreiR/IZiTv03s7cYncXe8aVrJ?=
 =?us-ascii?Q?RGvO1NZYIohqB1A7tEUeHD1n2fNeEAHjQCw1mDF/TLfYRpvivXahkpBFuky/?=
 =?us-ascii?Q?mTvSKEYQmQ2lr4ZXgPUaS55eSd4wWZjnVn5lGcONadHkt63ewps0W0sfRrCZ?=
 =?us-ascii?Q?jFY+eBPply10ftwlrSBSchVEALkbXKQpQ+TzfC4/zUwKcqJJxtt1p2F1BHId?=
 =?us-ascii?Q?YUafIJRll4sODXnYxs3QUq0PB0awt7IWAOJZyWlc0IdRBPQbowMSog5R/6gv?=
 =?us-ascii?Q?nZoiEkMXs4XyhyCPYkWCbjTFdLnIDvRu1trapLAVI3ct6jgcE46TZNMxa49y?=
 =?us-ascii?Q?YoyEuWk7YhEX59MrG/E7Kc9Qo/6WUyaMzy70DALkXS1ipOXeDLLRodu/j4D5?=
 =?us-ascii?Q?zZruYnMFlo/9p/dLrVex3M1UYVbwPW0LC5DZ240bJ3kOeHDPyUv6ZN5QDURa?=
 =?us-ascii?Q?++VF1dalJ1ZufCMX4D+Lt0rljTQr+oqlcbznsZ0JP3xo3+Rs2Qbbi/UviQX4?=
 =?us-ascii?Q?SEM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d3608c-c138-4411-70e9-08daad218587
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:47:52.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2412
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu Kuai!

> 
> I'm confused here, cause I do think this patch make sense.
> 
> blk_mq_update_nr_hw_queues
>   // for each queue using the tagset
>   blk_mq_freeze_queue
>   // if current elevator is not none, swith to none
>   blk_mq_elv_switch_none
>    // elevator need to be switched back, got a reference to
>    // prevent module to be removed.
>    __module_get
>    elevator_switch(q, NULL);
> 
>   // switch back from none elevator
>   blk_mq_elv_switch_back
>    -> should release the module reference here
>   blk_mq_unfreeze_queue
> 

We need to release the reference only if blk_mq_elv_switch_back got its own
 reference. However, blk_mq_elv_switch_back (precisely elevator_switch_mq)
 does not increase the reference of the module it is switching to. 
 Hence, the reference got in blk_mq_elv_switch_none does not need to be released,
 or we'll have to re-increase the reference count manually.

> 
> By the way, I do not test yet, but I think problem can be reporduced:
> 
> 
> 1. modprobe bfq
> 2. switch elevator to bfq
> 3. trigger blk_mq_update_nr_hw_queues
> 4. switch elevator to none
> 5. rmmod bfq will fail
> 

I tried to reproduce the problem but failed, so I found my mistake.

Sincerely,
Jinlong Chen
