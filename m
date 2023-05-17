Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884AE705F25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEQFRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEQFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:17:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2038.outbound.protection.outlook.com [40.92.19.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B83A8D;
        Tue, 16 May 2023 22:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um/HfWKK8gF920agBOsCmuRBcO7+Rywm69v3DkFLjfHQeOKcbrt/xgtFzVZ4Zmc1wQM//uiYddvTGcDtFI/CwJEqeT1X5FbyC1VRISufOxBCRWTzCm6uhoXq714jRUyw3wqgUwm+hyPX17NoiIg8/EPTQ50bT9CouQbMrX28e1SBW9jtaJRST9TvsjoZSttkq6aR0FMa3D7Uye/hjHEfrdYc9psOAxtw75gAzTZ7J/HuSy3eQfpkF9752yXCnVUicXb8taqJJcl+7/elXfMUXaKnOcAyhG+KfIsgSb6ztqpya6uGNLcbnL0mNUsMZ+0i41nrdbROco3rnVdgkAJR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8R6b+X4F2RnyylEY2G7XperLB25Lwcu3eBLPv+mvpk=;
 b=JSVvX0pVOf4UtJWl6OieZ9/+otTd0miMEfSRk/uXJP8I7NX62gqgmQ6OrnJ/P0Twv/RkbNQBgZDQTajh+M5XykWosTTYrkfJuSCFffYovVMRshhMxmx+NMNf4z8q4/0gdHsPojaktsd5+7XoR2YaaM8xdE1yerU9VhYUmAJ2kH2tqX/2jxV/CCgARky8KSmiwdA8hT2H8lM0PNilIxjT3kYG2hCVCfLWfRvkAo+PZsn0eLF2+hGmWvXPAsNr9NAzVfo0/eDNab+iTaoE+at1F4jpzeBDyKcxYth5IhIrClYUgFmZWHH6eV63D3jWqooCAIvPj5IFMguXpfVJ/1R+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8R6b+X4F2RnyylEY2G7XperLB25Lwcu3eBLPv+mvpk=;
 b=W7EC6iNRF3Cg1pa714XtICQA47GONVWUz2vPdKpyWIoFg/fuTXyTodsecVjCySlSq4By3gcoC4/GanG3TecSBHI71Y+YDAI9Nkfr4z5YxdlndQmGcaaoy7sLWTuA5+Jxz8X8kH3afI4XcPKoFp8T1GdvZZoRmtrJJshWro43+YoAOcYxP67fqI6GUX1C1CHlWblCmSERSkpTSmufsWHIhhGKtOYdpeqtLvlhQfYtNg1ZhFIaoVPk/Th1y2mQic1GAs/yMNvikg9aQrn05+CO7F7gkhJ4KKAcZf5jFjRQWdFvYtyn5g7J9HX0tcCQN2kpVZLcj0lB1ULFf4v4zqxoTw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB3741.namprd20.prod.outlook.com (2603:10b6:806:f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 05:17:49 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 05:17:49 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: RESEND Re: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 17 May 2023 13:16:52 +0800
Message-ID: <IA1PR20MB49532A7223FD732E7A7812ABBB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4950f67bf989a7f5eba462c44d6bdbffb34485d1.camel@maquefel.me>
References: <4950f67bf989a7f5eba462c44d6bdbffb34485d1.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VkVAD33Zi7WIaHAE1Ck7IhmoW7wwNDu9qt28PqDjBFQ=]
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517051652.934771-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB3741:EE_
X-MS-Office365-Filtering-Correlation-Id: e010ef34-3a90-4eb2-d58b-08db56960ebc
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3mlyp2+JOGVZPNsiRYtPAhIoM4YV4bEI+zNWPC4VUjHXVJQcf9OX6G8Afj8cb2f3M+8yPqOO2GZJlPUOHX7asH0r9049rLdFGeLPT2chrLiPB9KUzUh9HWqg5ELACGeuDKhYmUMws/Bt4pulmo6SJAXD37+Z6pMBldp2swzBoOPqBxyAQG5e1KjN0z7RvLV7ZdQLQoSy3911X9cb5dWXF3m+O1FFINJKtefoSmASOsf0X2fs5J/70Sgc3fXKVx+x8o2bZD66oFeyXHxx5FfhLCHVnE/zZbNHpgi3zMP4qMFPbzC7dUbOVJ/VBl4+P9/0gQ8L801/XHX5BoIO7FVvWGKoTI6S4IaD3A62tR3JwKAsvU5Xv7G+IPN7CO3wo1Yo8h8h6cV1P7+ruaS7q88GxVc4aCgQOxeeTBsxt1wmX3lDqhYEwVnSsrmxM4gqf2WSRp8ieU5N52ZJofuA9rnlKb9DACx0M7xP7bOzMtcSiWHdeWZi2TUbFUkBcOLYYo2qCRNLdSvjT0WHxOVoGCUNcbcSWrDIe2VZnRfQpWPMENr3rj0jy6RoytBNMzmNsZY+uyV8tmHiqxWBBA6YtSVNQewvPR6mJGjBuj3b+WLmkINbxeSFzzDPvp26ANOvhs0RTjK0+NtYfQzUmHN9ZdO4yrj/VuZhC/8h1brWVsiX/w+fZUWagHhCy4WHnTBvbm8D9CmKfAzRpEw8ywCHf+flZS9I5Gy90cXmPuhAEGx9aJjKZcUyOaEOVp2YEeZzGZq0V/ZkT4uRxW+U9VqhEZT2Igc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoUm6JnawyPWAAV7ntUsEazdczqndlVurX4Fvn2NLgSoqwnShri97UKl9EGZlw5+3eW4xRh/fJGDiA95a/vSDM8uOjZs+T0XseESmDnkTR1Y8DkeKOaT0e5uyquwIr71+4Hf8BIkPIUUye2F/DCdOcLU2JTd0kJiiUQ50cvlGOEOQmMhFu7WuHGWPrL/ks3LTfHtaoPM7dq7RvGFTJPiwM5BnuFL1Soi3JW+GdVdEkskrAtE62tcpqRXsy+6/KUQbnNW7H8LTi0Z2iyffJkbkbkbV7Klk1BqzOPW5bkywgMvw4kl/nlqY+3kX3vJvjbcmcxNci5Y/X57yfqGldbsAgqKRHTtKKeWUGrGRfFHsRoB/mm9nqsjqh93L3TELOMiXalmnNRmzLknZ+87JLDu4vYA700j1nvoo2uEToNUGeYNq8sw9j9dYFHugkgSLqRyP25dHcxvyOtD+ICTxL4Ert2Uk5Oo4Wq5od3qOXI0bKdhxucuUX58ekqpr7EeDX+1qV104O/iZUmiDD+mQwsHlukn5XayiF0l184/IXVV2cKICyhxqTmedh18JcZPBqjRdn7zCnperRwYVVS1Ew+MFzslxP91vNi2ybXw/r0wBSqaYamC5hm39vZHgMpCFzgj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3kvS3o2j/nfYvgyEOF27OZtH11EaJsFQUdNPMox0RGDn6MFf1XbgfTWnq1s?=
 =?us-ascii?Q?JAkIdUdjn1i0kw4Dfsso558aklZ+C87pfY9Rw67EEtobit+JSpyK33Pixem+?=
 =?us-ascii?Q?WKc2aIAbiN0eo3GYckZTcskQMO8Z8TUPz+hbcN9y0IfKcVRy4iBMCt6Etkrl?=
 =?us-ascii?Q?VPg5caXZuWOck6rB/r2vPPehPkh0V56FciALpIZnpM8yK7sMVniW8eVUphpH?=
 =?us-ascii?Q?RazhWdmFVI6EuOYT/KVsIRx2q32hXoaZAECumqFZvfOYzQr8fOgdqGvdyVK8?=
 =?us-ascii?Q?aaHJUFHpMuZiT/J3+TSiiXzP96fU9nc2iSM4L2WiVAU++t7K8yeQ9dLEumV3?=
 =?us-ascii?Q?UdPHl5x9rIXgZXWyVyA/XrZ+MmbSmyQZwqB7Dj6ToNvmRcrdle2mG3fHRzsG?=
 =?us-ascii?Q?ilA5KaZ01aaD5lad9wZaNLKilHTzWJzK9HnT2+87Veby5kwFy2rdt9oVfwLw?=
 =?us-ascii?Q?JgeGBE/5L3bMkiSb52iv8nW8/skIoxhKWe+ArkKMRpkPZEV25nob1v/7RcQ5?=
 =?us-ascii?Q?sDimQn/0CzvY/aCzK/w+20UgHEanV5r2twcESNOJ/nR/G+Y6idC45DWyOAdF?=
 =?us-ascii?Q?O4/LJNbNqGbtLlTSUpWhhKtaUZed4F2x21pWbGnHTLtwuZkjBUziYWwWgJEk?=
 =?us-ascii?Q?wPKmYx5OtI59R9CLPfhvOarG24m1pl5n/a7/zq5TkiO8G0du98DF7Wso2Kvl?=
 =?us-ascii?Q?Gwco4C0HvhYi6dBR9Z5tlkUYcn3NdzSKQ3fBHrYbmkiK9UXnkfv1N9KdUtJi?=
 =?us-ascii?Q?GIPH1fg3TOrJsiBfY0eQpc0G0H0KJjMSHqtSjLc1NfXmB2rzceaGI/nwlAhD?=
 =?us-ascii?Q?Z0w9Mbxwo5pnc2jKsGkZ4JUV/QwVSoU4RVbkLi9MXlCB0rG2Pp0bBMHDkRJk?=
 =?us-ascii?Q?KxfEBwpmkhHPwk0BbTVlHpi8JlmHICnhSn/OszOXgEF61bosNijLx1oXxRyV?=
 =?us-ascii?Q?laQs6ey7q9VRJi7Kw71yGrHiyoNEE9JTQ50BzkiqLfyupq6GdPKF91uZ8qxB?=
 =?us-ascii?Q?9jxal9CU5UuO78C5HCarfSpkLrF9CL/vw3HQRF4Bl/1UFJprJ6zytlbJoW7y?=
 =?us-ascii?Q?7716/M0GDOrfPxvXvBPR3hFxtMJpIyQ2oMB7aaLmvZjPAhRtx19OeFcwakyB?=
 =?us-ascii?Q?R7h7unEQ2RdAdHsmfmjo8EMQIfKODX7EfDfjwF0PUgN8uTAongroqeHeVbIs?=
 =?us-ascii?Q?L/hZ/Yv2UDljvFRKaJ5TimI2klYTRIpeitHr34fQG2PWEHw3cw4KxH5Gpck?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e010ef34-3a90-4eb2-d58b-08db56960ebc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:17:49.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB3741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As my last email is correct, this is a resend.

>
> They are not the same - they are different in many ways. And c906 list
> seems more complete to me.
>

They are different, as this summary:

event id range   |  support cpu
 0x01 - 0x06     |  c906,c910,c920
 0x07            |  c906
 0x08 - 0x0a     |  c910,c920
 0x0b - 0x0f     |  c906,c910,c920
 0x10 - 0x1a     |  c910,c920
 0x1b - 0x1c     |  c910,c920 (software defined, >= 0x1b)
 0x1d - 0x2a     |  c906

This table shows it is not very different. The events of c910 and c906
are complementary.

> I think you should drop wildcard (it shouldn't be used anyway) then and
> name it c906.
>
> "0x5b7-0x0-0x0,v1,t-head/c906,core" would match both c906 and c910.
>

Drop wildcard is a good idea. But I choose to preserve t-head c9xx id,
as it cover all events for c9xx series.
