Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690CD705F14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEQFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjEQFGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:06:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E42136;
        Tue, 16 May 2023 22:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqa5Dw8nBfLkQF73yNm8gv+Hv7xime3n16Dzpe1fINGWIU6zT6xcfv/2NfqiW+ByB7EeYKeE3+hbE3d0Jedgd331USK+vXbvaecwOb2HykGFvZJsmzBpUVHjgA5B64ULsWk5XPjUX+2DI6J91wOkClLYhOGkc0e06bYVr/Bh48Vl/3RWEZOqV7K6UP/z+OfKiOI3GSHTbkzYnRHTBigjO7zi/gp7vViZpH01t7/fFmsR1kaiH98FqKGDP7HbYZsaxo4gz3eUoh7SM5C3l0hdV65EYfE/D44JM9Bm3gBLtyOk49WwgGAY/V9jXQdD75xnKbeDc331mKQlPfa+b1XFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV+2IULZCkNFQKkxK5KJ+3ezPXnhpf3yxnwuaEnZnvA=;
 b=K2OuI/OE7u95I6mW8a5ufGvja8YOXsDJJ1iK+92tfuZbYgQrz0Ynz13RJy4wQMDVGQFwM/xcSTF/mBYy7KkRPu7+GeRArXhzTDkamUo7qXMQS5kkXbJq6LQp/CuwAA5M3Th+BNpXXbW+vl/lwaBo0pIBkuPXZ+dYWsHaFXM27YSvOKHjAfbzqYzljpIa+WsJE0At8OTEKqxHtItSEbBLAjwBWfaJS1hjdT9MnEXpxWjktA+k3nOLePjBd3JtjJKLH0QC6UlsOfr0t4VUxnnNDBVT/J9sbIgTeK4ZHKZZv/Waj0hATdeNUvPPJz5o74aN7ViPutxfibxqQX6Im0VLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV+2IULZCkNFQKkxK5KJ+3ezPXnhpf3yxnwuaEnZnvA=;
 b=gvL8undun+zbQkxQhzj85+cr3x5r/YPoYp+RCNbYiB0GYP4iLOQFXziYVCGLo6Z3Q8tneTXfHM1JmdkBmcJuO5P77TCE1iWppD/X4BzeFMLZzExtlAuNIW+A0vbOsmocslbTUoqhtmjxVrqjOxBXo5gIb85Jp7yt0lrWyCsiEQQZoSYAbLSN3i4lsx+mMeRTLbFmZZDM4QvOnHYtzWQ7/fpHiHFJHZCnAf5zFICDIdBgefGepBKkx81IQVrYh/axBwGDXBDD+ftDdq/9YMunNTMQnMJYrjKmnEjJV6tRO2fwdik1hVeDJnJJomtgX+YI7eJzmlTulrstnxeg6o8mOg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BLAPR20MB3794.namprd20.prod.outlook.com (2603:10b6:208:334::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 05:06:00 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 05:06:00 +0000
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
Subject: Re: [PATCH 1/2] perf tools riscv: Allow get_cpuid return empty MARCH and MIMP
Date:   Wed, 17 May 2023 13:06:47 +0800
Message-ID: <IA1PR20MB4953003EE6D76CACAEC95A5CBB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <28d0792b81db018aeb644096898693694b2841bc.camel@maquefel.me>
References: <28d0792b81db018aeb644096898693694b2841bc.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [y5u3LA3lrewmmDQCH1LDfkXC8sIQwgvasNiq+XeAPIs=]
X-ClientProxiedBy: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517050647.930570-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BLAPR20MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c6fff6-41c4-42a3-6d68-08db569467e6
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmro6QgSszs9gGQWaVOCEuXK4xg9HpCh6h7gv1KObVf/l3AxVITL9Ym3x02MuQLN5PRu9tpoq1sf8drqiyHHq2onDqmV7DKeYy7S/37GNFJ1ZhInAFcq2bzHPcx0F914Mpu7QSV3jaXu/OlkV18gO8DmoltvxZwy41PBDkCXRu8JVCHKIi1Ao5OlO7wAjh+8/AFJeRdN/+3mVDSA0+6I0CceYyHTemI00fzrgxf69sA9wMg2wwPOb6iN7ULbEiTaDe1xhlsurTMTHoOo8gGFkLb0rgfVuTiC8k8oofTcrbQlRRJJl9LAoCWgYPZJEUJdMjDCB5Eeo9XQuLLhRHcAY3r9pW2QDmqvCAdjsrEnt4AoBUXLR+XIGuM+NakBcuobImsLTBMPQOe5QP1qJdGp+tK0+criXtm453oZ8ixT3Csj3DmERPsSjHlfy/NsxzDice7hQwjPrd2R30EEmtXfyeszhR345pjMduZR7Hn4XvhZ102NMftUiqhiCTW+0td0Udg+KUzsCfKIfB3exng+t1ZzTrXIdxmL99+otMaYwwhu7wx3Pw21+mal7wQm9RvMtZpLbENmx17N3jx1tzAA1OlsqxYrbESW5F4SeucvLYvtkxyaUoWPWvvq1kZPKxTW/U8bpP5NqSVWMqY1HeF0T09NRXV4IOK7qMy6CXNdLrkelr5Q7VdstLDqbSGxaCwr2u8/Rm0I3BQgPbnpodZtqfCmr/jjM9Z/G+bx4AW0Z/shxNQA3b9nfmLwdH4VLt2x3dg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKVOATMPq41tci3dnnI4wgL6xZ3th7hVoGVqw6F0BNGmBs8A4FLM2gdUl+EmXn6NGqZpeAtPSjN/umf8MZRPSndP/YchLxDNzU5alZ8hxH1xclFv3mD0BQbxkndpeljdn7KQlsSRf6052s14DL5J9q+gX+QeHpcgHJ44SuECht/Khn6p392EJkEqgO3GieMcYspiKmop6CLUUktccewRMb3JqETRhHFyDxb0Axd+dAXgyUiB7j2FFsA4ewpRNDUMXANlzdeGXiE59JAAAqU2dYR42lDmazjtCBS2gOmUXy/xxVz/a3Y8buRFZ3E4p0feDDm5+llX16g4Ai5u/9TS/FYNYO0lnX4eDw3JQzaJp09rC1M5F6ZXK0bm/TZ07gSpN/vJiBMCI3outWXkiUleQyGtY+F2gH8xn/QJ+02dMpzYCk2rBELhgIFUmGiuHbpqgb6lQMos/h6Wov1Lgf2S4mnByom5cNdTs77FKCsgh1GmsBRWtYE6fiqoTT57WJcmuypNmKcC5PX/JAbKN9XMyTSVgsek9j5VjqdyEoRBe3huyuKp2JbeEjAXdobzui9iBNgT5kIk4UCQ9w8zH/rwSL/mqVw9njj1rEzIcC+uMVlQz3i+zadNiiPedZ2Ony9+/BNS+L2KZhuvnLepaFeMdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OhU6WkB+Ijq3MBPYgf0wQii4u3X9h2x3f1IdthQd4tgVnMJ1iKru3YYKHoSd?=
 =?us-ascii?Q?c25dV3uBL8ZrDSEGjicWSeVRJbvkMEsTbVGyaPw9KOxidLDIoKulTtUv4wbY?=
 =?us-ascii?Q?Cxg8UCrN+rGG2hxG9bBPI0EkjRmKT4jhP99bvkfU3Rouqo+piPnRgTnxc8lG?=
 =?us-ascii?Q?4xNuCcPRQhBrx+DX4CCsDFwGBfXkjBt7oPg4yueLJLIb+XYyOe9LkV6uEyfr?=
 =?us-ascii?Q?L+wiJtou7PJ+Mx/8/BSr0rJSoKMuLi9yYxzNfnZ609d8equP7XQq19KC/h88?=
 =?us-ascii?Q?c19BZtpSFYyoNLM4Lz+AYFno+myyEi5VpvfLtRfU9+0Ju8fElkhr9AGooH6g?=
 =?us-ascii?Q?MjR5MP40OFbZ2Yv4PreSIgKCB8XfsGstEfS4Q/YljckhLSRWWQSByf14IB1F?=
 =?us-ascii?Q?0048x7Pfu5Po5kwfCAYt3y2jHl6DyguLObx6ZVjOyCBhxhm+AQzyJqZaAzC9?=
 =?us-ascii?Q?ss/jgm11qIriti5UeovswFC2T/9KYMSSmpmND5jGZs0vrhtK7RsHaea8bMz6?=
 =?us-ascii?Q?cRvZkI1ZXTQjAJ6G9WsZLfX65CDL+pqibJ6V2f6jxtDWdOPnvbOblJ3lgPKa?=
 =?us-ascii?Q?uv5GfAOV60plCdPY+0o9Es+clv4DBLMJ+scBeneyKnaawG1wfKaRVuemWf1X?=
 =?us-ascii?Q?C8na7imj2Nsxj1g0bHiQUZVOt3TpYkshicPgNSvprY9ec/ZNFZ0kb4yeiX0e?=
 =?us-ascii?Q?e63f3P+lht/LsATc/un48VsBiqg9TOsR8UJ4lrqPbo0HiVz7R3Y+rc9dUXwg?=
 =?us-ascii?Q?CLpijQGqVS6HFEarg8wTJddVYc5BC6dtXzObmgCNTNsFAMau14hzi8c8byeG?=
 =?us-ascii?Q?M78zaunf2BYOuuIOMqBOMyw/Hrm6xvwOGVAy5TX3ka2EfQhfxYpum1V+Yzlz?=
 =?us-ascii?Q?OdnHZquvACEpzxAIa93JHj+ixr00sucCTfbvoNf+nKerr1gEE3SAHi2MwvDy?=
 =?us-ascii?Q?e9VYyJDnVLusdfLE9zUjk3sgdjQU0g8XC8S5dNAqeigrnWNN0zjwosw6hf55?=
 =?us-ascii?Q?c96SKiFy0y0Gv0WZLjFGZYdY+jYmkzxxxoTs3aIaKCRVpbK1YlRQYEvwy4CB?=
 =?us-ascii?Q?WMtJpnjr2TgfbniC7UxtuiVSrS2ohbBGa/9z/kbEuFVP9Xua902un6IgsC6U?=
 =?us-ascii?Q?PfhmIZub2BMWsirBI1nfmn03rJtuVgJOmdedgLyqX23TmC6lWLaMnHe2g5PM?=
 =?us-ascii?Q?LQOdY0EJQwBr0ytfAPdBIuaUh24diZU8wTtw3tqzk7y0cLR6hItwEbl0gbM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c6fff6-41c4-42a3-6d68-08db569467e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:06:00.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB3794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then why do you need first patch then ?
>
> marchid, mimpid will never be NULL they "0x0" and "0x0" strings
> respectively.
>
> How have you tested it ?
>
> There no way "0x5b7-0x0000000000000000-0x[[:xdigit:]]+" will match
> "0x5b7-0x0-0x0" which cpuid in your case.
>
> Just drop this patch.
>
> Anyway "PAGER=cat perf list pmu" gives me an empty list on licheerv.

Sorry for this mistake, I mistook the type of the MIMP and MARCH as
unsigned long. And I write wrong MARCH id in my test container.

Anyway, I agree to drop this patch as there is no need.
