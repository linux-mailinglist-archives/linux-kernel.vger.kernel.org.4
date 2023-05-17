Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D727060DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEQHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:10:46 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02acsn20809.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::809])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02146110;
        Wed, 17 May 2023 00:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkMQpO3eXUlp8GJfonHyuYbseQX5VmQLYHmimZbtUdzb1fYYZFgDTgjJRACwpkkQTx9rfFeC7jWLh0FHxC7MzqKXMYeZiwP7BZZcRc3dHh3nRZDwhVcdPqpAILVpYmlGiwb307VRfF+BN6f/fpuhK+7JopHnvJJ5QctF57lQbf66qmarz3XSlR7JBG8Jx6vX7b9b/54NO9Jb8/jNk7XkcquLogod4QhmehEPu1Zw2p95SOS42pI4GyKT+GcIYJ7ZlPaAECzVDkmW6D0teiO56aFr6sfP00PJK8WRyEX4tss5jUxIjJ1MQfTHEuPp4aDc74dqv8g+0O9R8OICe9g0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgiHAx2Ho4m5kiLv9IhJIUfLNQM5eTFF+/XPozl9InU=;
 b=Q/n33kOjWatZ0IOWXzyOKhUQnB5YJmOsO5BOjFuM7LoYRM9zumnWcuiF4/LGPvHBL9JQ2q0xmEVpqF+ORZHlnRqg+N1Lw5T0AsY2ZZQ6W6OcEkVpuh9hXRgQYSqVjAIDMBYyJvHOrgxwCr42dFXQWX2ZxnkKsNq1OVs4GtsB835l4L7gq7hOdYNtlMz3hBJhfFCku58UXBFpyNUDB4zRsoqai+7V6yPX6oePa/HULG69JGRZIGgcurYY3Hh/wsGZI5aMrgc1Box/A5zXoJERCF++E9j5anAK+lYY4jclJoAfzij/kpfUuJKThMpL6MSTwdzwoLTo8eoXYaJoylpplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgiHAx2Ho4m5kiLv9IhJIUfLNQM5eTFF+/XPozl9InU=;
 b=TFgFxv7aFpJY+JND8nXIFfRmbCbDcb/9lj189r8XLAHP8eIgfwI5hm29n+haCna4Vqqh2/s6UpJe8CggIe2BLCijaf9wwXNGydIV31EFj8Fawem2Vn5QSCltKDO37sqbLc7dGPiOI6oW0rok1SV0GX9sRNmsXNSKBQXt1WusYV7i2bDjN16zhNYOuUWVMsq8SBnYnRNK0G4j/ddC8dOnVLjRoFxMH7gNLNEPGVvoWw1xDXd90pAabl5jSG7akKNZah0+Dp3ABV6d88uF7xMdEq3QkUH3iYcg0C4jpkmUaCXt2aS5TnRPaaXYfGBpWnxQSbdY+0ywzCDmN26O+IyIiA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5408.namprd20.prod.outlook.com (2603:10b6:806:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 07:10:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 07:10:42 +0000
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
Subject: Re: [PATCH V2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 17 May 2023 15:11:47 +0800
Message-ID: <IA1PR20MB49534FFAEA0ED23979E2767EBB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8099fd35bb51cc8618ea41d4a2af7b931fd43015.camel@maquefel.me>
References: <8099fd35bb51cc8618ea41d4a2af7b931fd43015.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nHFxzDVhWnVCIx271nJXm2AVLqXgGZsawjB0l2O1/qc=]
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517071147.975446-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: ae311300-30d2-4206-3094-08db56a5d34e
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQT2DJXK3cIJWagoz3CnctQzpiOWNOisu2fEtAlKto/CaQVK6kdBJBZ/MM7Rnk1wgOzLHpS6YKT51lDYIMJec7OYMhni/MtLfdyGNJNXMmK44D/aHcaA536a/OO5uqvxaWipwdLMVT0CeiUuBntv5Mlxj/4UT564YqBalpwRDDeKUUokd2s5MOt7g//Et01A7NK938j8alOqZqXG+LYkzY0i4IZrKDVyqKsU1Tn9XQu+ZLDqOKI1O9RPL50orxVPDDzDLRPHw1Vsrq3eswhelowP2SvZCdLic1lYUhGIIWe9Yg7/UjFlBBaPtjQmjc+R63xyyW6WvYRTIAJ38IymynT5h3ix6PIWkYe2enGfFTbMiAxPS0a3+o7+fYTPYf9cOoE7N6hSri6JnLKVc/gOzrK0WeNln+l4kcpzrtkv46l+/67c6cCj8qO0pObtHJztIwkvV2zEeVX5Zh6OLts0jbqsMb1b029YD6M0TDxPPQ6JZBbgVaqn8kxbJ4iLbV6d78AzN7Ez7RtQBh/Jz/hYOQSSm/3X6OrE//qgaWb5ad8yr+FgJEhzMef/Wk2eXInqrVq0PiavORv65W8BM+nvMz1bd9e4NDWJJyxrjN7aFQr02ASbKXvxquDOuuq6M/RspLZQfiJVEEo0KXUkq9K5ryhmyG9sDKkZ5shk1TAfDcamxd4xd4rAeVi1DRfZkfuVEjS3s3+F0WQQTQ8ZZogX/YSbeYsP3sHDLDlZ2UXCdwDEliV9GtuvPMmG7K0I0ucUl2x+n/tKyibe8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qi/5AionlUyjlOZvlGYVfwKAhm8wrbnc60GsnbVlKSz6sF02T3b11d3+eyW5LScip/1lg3jqFOsR6XtQjgaUx6hBa4mPuhSmOWkMPAQceKWX4ijveNFTW8v0dJZoaHiYY3zRIRTYwjpfQJ0MGZmahJObSmL3EmMGfY9XoQWLiz4iwUzCR8PM0V3k6xgS1EH2NCoOn1d1OItUt6mQDEbxXD7zlfk+qVjBhCjxuSOES8VtWjvmsIHUdnD1M6zI3KWiIJVNxHUFUSvHUQzqukwBYoonRZWQR2rkDfwFnVYR37f1uYyA3xdFZUYp+2zC6XvretkArNT9aTMhG6FxsghKL+gOcBXd8+7e+fjKrTRn++Ebs5uXC9B0qunTDfH8F8Ykik6Hf71DHQOOYscN8wsE/DFRfUzwvegMBaS1hqK/mrfhkJUvXYotuESmn2Bus6IzAJ+l8I553IumOjPY5ZEGMjDww1a7mCODgwDihLYxhFx1X1gKhDCCp9BN+LDg0Bk5pdnIS6UtcVsLEyJS13hzoxlhTrzV3JCe3+2ktDHq9gct90yYxjcRl9VloY46MjQZIwcw7N39JM1zjJn0LfShtB1jLkkuO+fEo8x8wl50JRPhYs7ZX0t/PsJ6l0sQZ5kmpi51vvLH7Efl04nQegt0Xg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mclnpu9XjAgbhWNGRsuG48CAiSd8MySA2R0FN7idOge1Xa5q4zhH4lLPNjyF?=
 =?us-ascii?Q?/OX/kqTtjP0wzgAtjzaBXt/gUNHVb8IvN0li6WOUXcX/BR4eYJsurTw1YBW3?=
 =?us-ascii?Q?aWDPdiI7p1EAW3LMmTOD3iX4fNpjM4Ng/4cw14saNp2PjSXnG369l9rXkDOA?=
 =?us-ascii?Q?4zQOYp3xjHVAhq+in6bwIFb7TodYeTvHF4LTcDhsZ9VSQD9mex6DVJ10Uhtp?=
 =?us-ascii?Q?/eOGyBcxdnNEPWFs2PIchmy/5Y2J/NvYAfyK/3cf1neV6lcKsVJ5cHKpPzer?=
 =?us-ascii?Q?25RvqI63czgeNHd84t1pRGRXdXtyvaE6K+ZE/KOcAsD/5/KdCBS0WcIv/zFW?=
 =?us-ascii?Q?+3+EOx6xmCPJvNAiwj4tqI5YI5hV7lb17CCqTbhejKMmNiVu7iV3gvHSxWv+?=
 =?us-ascii?Q?e3KqVRX8lvi3SU/iW4Ga3WrhE8v+W21XAqWigKG+lgsEytfMMh1ZzjhjcBUg?=
 =?us-ascii?Q?28lQTVthsy++cQVJYjnM+q8MIjFUdYjVTyldP5g88z3jL2qHQAf04owzE6Ai?=
 =?us-ascii?Q?T8ucclgbR6SDcIgEflAq25Ubgw8o5TEmnnvjJEusopOJkGRb1A0n+Fm+P7jO?=
 =?us-ascii?Q?m9mV8MZAsq2mh/QbDbXz2J4FJilkEZ3sodNzc/pRCjSyX0R5Fq2fUjv3qpah?=
 =?us-ascii?Q?Pv6f2mFK5m5K62eN4QJ8R5lVg/yBKlVAE7V8FpUbDs75Xk4h/S0yBaAGgXbq?=
 =?us-ascii?Q?X3PG/dY1BTeK82Sizngca7PA6fKtIst5VAZGZQIakQQFQo3N6wTHm8Z/L//I?=
 =?us-ascii?Q?s06JfAR+6H2JRV+1+ZykMrgtw70dpufKPm73Tk9XX8JAYZ4eTUCj+hBrkSyV?=
 =?us-ascii?Q?bPMIUjc1kHBeANkpSUBobql6eOYUxkwrgi5RJ2YTMuGVamRSNYzuUB9J30g6?=
 =?us-ascii?Q?JYLTr8KbDLLXmhDbqTHIiTJl1IILXmZdNi0UPOOzCpmCINytVA4UtH/HxJCO?=
 =?us-ascii?Q?NrkTzEAXTbiTQv1ZhHk+GsSoaMAVMBJY17dt6GJXjUpbWZa/pd6Lvu6DtYsO?=
 =?us-ascii?Q?miD+zXnJRggzLcLS2T9uE09s/bHCR5N35T697puHBEGh3CowBJ14ktSx68g2?=
 =?us-ascii?Q?VjCxifXuTASMvpqRcZoWyoWkRU+2eyyjfusHva8utj3ctpz+3loO09pJXTgr?=
 =?us-ascii?Q?kklG9LS2fDXWOvYAUA4ma8hjb4po21f1GkI6p4g+XW2+WlxvF8nEYxN48MeF?=
 =?us-ascii?Q?4YubbgtX8vtBjG6jaOcBaWkT/Z+b4Xz7u5vLyeN5aKklc7qTPYaoQ84XMIs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae311300-30d2-4206-3094-08db56a5d34e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:10:42.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please put change log and example between
> ---
> ---
>
> So it will look like:
>
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> ----> changelog here
> ----> example here
> > ---
> > tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
>
> Otherwise it's too verbose and contains stuff related to OpenSBI and
> not the perf itself.
>
> Also checkpatch show some minor problems.
>
> Also i think a mentioning c906,c910,c920 in commit message and
> providing a brief information about their difference.

Will fix in V3

> > event id range   |  support cpu
> > 0x01 - 0x06     |  c906,c910,c920
> > 0x07            |  c906
>
> I don't see it in the json file.

0x01 - 0x05 are in cache.json
0x06 - 0x07 should in instruction.json

I will fix the left 0x07 and its name in the V3.

> > 0x08 - 0x0a     |  c910,c920
> > 0x0b - 0x0f     |  c906,c910,c920
> > 0x10 - 0x1a     |  c910,c920
> > 0x1b - 0x1c     |  c910,c920 (software defined, >= 0x1b)
> > 0x1d - 0x2a     |  c906
>
> So is this a complete list for c906 ?

This is a complete list for the whole T-HEAD c9xx series until now.
Some of the events can be used in c906 (the line has c906 in the table).

> I ll test it soon then, however:
>
> 1) What version of OpenSBI is used ?
> 2) What platforms have you tested ?

The mainline OpenSBI is just OK.

I have test this on a sophgo sg2042 board (c920).
This pmu node is just fine for both c910 and c920.
But c906 should change some events as it does not support.

