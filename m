Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA33D7060E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEQHMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:11:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2051.outbound.protection.outlook.com [40.92.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C30171A;
        Wed, 17 May 2023 00:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx19DwAo5Z2ZBDOIWtUd0ydAG3FxNtdLj1Pc74K4Jt4mP5eerJGy2iqeFA3kODWlIOD38GM3ew8/Ab7BhE0nPFgqv0EkcbB9wQC9gZPTbHxRiR6GkNfQXD6/X2Q7c47UKtoXXLFjRBBIdK8QGnUM3H1gFSdsIgJ9W2lAtQCX/ZNiDR16vokwWq7Bx/VV0bMkh8ZwBwlTl7HdXrh30YlKTx4/5UvASZza7oEcJXrx+ssLNqgIfpSmBGzdOVxzOXGDOIoorG2sq7MFMjlCbOlqJWRAsPT89D4LYo8o1h55bXzAZCjnIAOf36sZ+S2L7M+8pZRW7jJ/uzqWgEaDkmjdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lQEvRsRv6jx1xg4f5EUGZEE9CtwqQmC721R+WVeta4=;
 b=mswYV8IWQpFWMLG2FiW/DQniP5Thj4Rr4WDJg7bpJF98qeMwdViE+G/oVM1zjHrBj/YGYZ82D/BjD0JD4cEKQotVQ+IT5UlIlApNHVxGTLZFUQwCKfr2XpQr3oFp8XBv/wXuVZEgosQ0Y2rQzUOkrhHdOOUp74OWk4X/PFVBTJvhT9Lr0qoMq5/jmfx+M/hvg8CyX1kkgAT3tsuq2KigCzHgfeLvZvYNleKCsM8BgyPVKX3f6USwPzRN3SM2Msay4vLSDMJsvvWTJP1gnmiRxOoFKWOBFajkKye82bOKA61kK+ATQnViXCOcCTO+X81oibmwsA5SHNssCMUGgZ/GEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lQEvRsRv6jx1xg4f5EUGZEE9CtwqQmC721R+WVeta4=;
 b=SnLFla2XpWt7PIG+xq30mpmf1maC2wh+hv/cAYzaMY56KEcN1Ym73RjbTFmwobkTfod2/rVBdE7wTYmLYU3BO4r4OZhn7wEEedsm9eUxlljfYcs4e7tkb7AaI3eyhhbw/R71+nfh8b+w2qBtSd3HCuI7Ks9U6mH+yyTuVEOkj1TXQsN3lOSsAKI8CbzJHR3guHBUkUs5F+85rBS94Ish8cPU/ktkoh8IoF+9GIP5t+N+tTklXDOGBGw4ZGLS8XATBNqOmFsFGrEeMFZFvSdMCNXlxKUETkwb9efKP1FtRzJiRc6Vxvuj5xJrNLcKgHrrUbMNxvJQ4gdlK71XIVQzrg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5408.namprd20.prod.outlook.com (2603:10b6:806:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 07:11:36 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 07:11:36 +0000
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
Subject: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 17 May 2023 15:12:38 +0800
Message-ID: <IA1PR20MB4953B6C4CB711506CF542737BB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YDd4EH7e4qBWG9JA3VlJ+V0nty/DE3nx55hhNv7wm3U=]
X-ClientProxiedBy: TY1PR01CA0205.jpnprd01.prod.outlook.com (2603:1096:403::35)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517071238.975850-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fd33c2-f831-4868-8a13-08db56a5f38f
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQT2DJXK3cIJWl9dZw3G90x6XbO8gux1efwUFZEO//SmpUuJPmnJiw2EatbNArHGLXYKhu8VV2NcEiC6XsL7dcjrWYaaWoSSPLHiucNPLizyVhBUrRxzXxwjCvBNSUOXQaOZSkqXTEEy+GGvnZEt6BnoXtpZP/H9O9mHq8XE+Ru4L6mjNYJGw1GjPxMlOIU91538ZgXTi7WAmgZfa40ehVf5KHJj/PfHS5FUAlK+Kdh02NKg1r9Uv8wW77PVq3bKBg4nCt4hW5dAv4zZ+MhLOxdGYm8RJdTj4sArTiCUT1mcwAJiLXu3glBiesqlo2b8ZapwGIVwAnI9xTjn9iNskGlfcyA3Pr3ReWzX81ahQrzEWBoTVFzR7vbWXvGpUxONidiPrSgfzz5JOXP6kaVv8UogutFxQnOqt37VuP5RMfs47kDyUQ5kdGrIaQUikjR7uGtRjTmHrXOVtUVf185mKLNaeM+eLgEK/j0otEjm3j3qryAT7MhMwcl1TUOkNF7uQRCoy+z/ZkGWD6ymrez4p97Fqvz+DOiBu0aaa7OU33uypivmCGWWyO9CFLHP2+KV7Q93kBqDtcUbRBSmQ5eGhQ5UfSjLbXcK4FbRmem+j5atugry+C3TcV/Y/bPffrwgl2kNHZ44+jbk6zaSLzn4o2G+V/X1nHbdpQq/zU8DrmbLI7zIPVj5w03JrRDAPVWShZHuQaJTkq+eLoTvIYgB/i7K3Ns8Y4BmO+zZBsQWWHa/pwyZq8oLfRwL7vhVfpiLYT3LVST2hE8mZ
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1CnJtLb/pNQT6rKLjHfns+ihWCA4LZ+lrYKH3u1Dfp6uskP3E7pnGWDSStmg0pYS5sUfbU5Ktt+seu9aE/LRplSGCrCgPipjcTG6kTyoqcPSGCprYsBs2YUZJrTGtacVCfCtxhq/CD8B5B+8GUYWfUcaSp2MSGKhJYbfNVIaEBTV6rz4nMDpY3ip+7EWTBHAqwx6vVI6EVY4fdf8/tR8iCYSjWL+pFlM8QydtOiFsZ3TzBdrH/D38uU5y0W9akWNCgF+7kbnJ27O3UFnnxc7itEQMHYu6OoUd+Vfg9+pHmpHOSek/CURiGwYdzYK2S1gOW2hlo6V05sx/j2vY1hs/bz+swvrcqP521SRiw60GUH9NKM7Rf0se4uruxZb049LD53lUGtuIf9u5fGaKZpHW3NJ753MgtKcqktO/CwW1BA4O5OcVGoCZ6Bb0TuKRvRtEm2YXk6TkAHLrs8t9+vqKIKyk3cOqXjDCVyaXvq0b4N5qlarFYLILrh6Xk2NK4mLj72B1C9lPoMI0Ra7xVyqFkqY1OkA0WFqfFHwf6P0RZB7MPfQ+lCmkUZujGm5uA/ORxyv10Sb6MAzaFZkIeUyQVT/5+4/pDKEUT3++tRvXyp3DpHEoOvIU4kjEtWQdtW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bqr0J1TzKdJIQG8sONwFj5BeRBbrQgh6Pdb5EaUCnIx2Vpt+BlCXAHLHVpIc?=
 =?us-ascii?Q?mkMXSRXVfPmiiJ3zX9Hf815o48kjjJ5KSrLirM3mXdkzk8AU6TNr7BL8dWMp?=
 =?us-ascii?Q?IiBpUp/3/kdO52DPgQZSsryPslwL57Jv2wCZKMO6Z2iKw3jCsNA6uwLh+F1y?=
 =?us-ascii?Q?Jp7c/jN3sg4J6V7errFoecAoiRYYK337FT6UFBX+iFwU2uV26qu75KkEDDEK?=
 =?us-ascii?Q?JY62FrusalSD4p5vsyCEh5pq2AycMV6QJdSAwmy/T+GGVXsOPSB8IPqJI+C1?=
 =?us-ascii?Q?u49k8Gu2nc0ht+diEMKy3glWmJ1GwOJUcdnqjatYxMjA5blLc7ssyiJP4tIz?=
 =?us-ascii?Q?ShdHpz51Qad/Mm+6kRqvvb10dv+0OlwT3aFlZrXcb4XtuKzkdoDc/aakKpyw?=
 =?us-ascii?Q?Q9qCmyTQ/TKh21drpIvEJb2pN7RxGxTkYr3OngD77SXaXCKPzpADPDwxhFXr?=
 =?us-ascii?Q?igXinLdehIN8CyXDo1KkPP+kMLGzbE2PeNuM3fvwmfGW3l8TbgD9SbYDBpS0?=
 =?us-ascii?Q?0sIZxHbIq+dDXT6PRUGweWjRia5/4LVVX8SbLHiujd+qzwtFuwm73Ho386XD?=
 =?us-ascii?Q?wykkG+OBOPci7fKSRKEemQXl9OgS9C7qaSNibnPw2N/gm9fN41HvyfIEqInr?=
 =?us-ascii?Q?STgpprW1UNJQzMI5RctBSgWSLnP7NBZPqHRxtonYhfmQLkMlOPy+OXEjbKOj?=
 =?us-ascii?Q?RUrUeGWf69HtcMmbuVtBU1ZsnLX99rVCKyOGgaN9P45MG7PJuH+pSx3a5Hbg?=
 =?us-ascii?Q?AXduOIt0ncrIiv2Q142tU9wOKlSeuK6jAL3lN6tor8IBAlBNdFw4U91bMWTv?=
 =?us-ascii?Q?dcOWfJyrqX96/jFGzEyMnEydnxUnzCcAF6PDvWdH4aqgmQvrK2mtI6xnUi1o?=
 =?us-ascii?Q?N0QWSMITzHhYh0zMiVnCtOPI6pSaU6hwUseeanR1ojqLnY1fTsC4LSO85MeE?=
 =?us-ascii?Q?JNSnasRNKciEJqLRimu0wQscRaB2PJ/DmC8WWVKJVF/KdMCLUq06WGaImol2?=
 =?us-ascii?Q?/ftY3dfko/xqnXdQ3WoZys4CETUAp1QHU4FMpWr0oee76mwKp1QipJUy74iT?=
 =?us-ascii?Q?3c8mok/FbH6Kdguzb96vsbhlCOc/uJab4qK+VuU5u2I8qOkE5ozmSHsBsrjo?=
 =?us-ascii?Q?ajtPn+HmJbuDnwjmnv8PxOMeajXFDnZ/LSE4kFXhwILuHcPYQ87yqRirUkss?=
 =?us-ascii?Q?hKw3ZhT8wR4Oyi1brH77/TqW196z6KkTYFHfn7L7LuiKRC7WsSSlTlSVo2c?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fd33c2-f831-4868-8a13-08db56a5f38f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:11:36.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add json file of T-HEAD C9xx series events.

The event idx (raw value) is summary as following:

event id range   | support cpu
 0x01 - 0x06     |  c906,c910,c920
 0x07            |  c906
 0x08 - 0x0a     |  c910,c920
 0x0b - 0x0f     |  c906,c910,c920
 0x10 - 0x1a     |  c910,c920
 0x1b - 0x1c     |  c910,c920 (software defined for all >= 0x1b)
 0x1d - 0x2a     |  c906

The event ids are based on the public document of T-HEAD and cover
the c9xx series.

These events are the max that c9xx series support.
Since T-HEAD let manufacturers decide whether events are usable,
the final support of the perf events is determined by the pmu node
of the soc dtb.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
Change from v2:
1. add C906 0x07 events to the instruction.json file
2. fix name for events 0x07 and 0x09 in instruction.json

Example:

This pmu node example can be used on sophgo sg2042 platform (c920) with
mainline OpenSBI.
It should also work on T-HEAD th1520.

For the one use C906 core. Only event 0x01 - 0x07, 0xb - 0xf has known
CSR mapping. The other events do not have known CSR mapping in document
until now.
This pmu node needs to be shorten to adopt c906

pmu {
	compatible = "riscv,pmu";
	riscv,event-to-mhpmcounters =
		// event-start event-end a bitmap of all the MHPMCOUNTERx
		<0x00006 0x00006 0x00000400>,
		<0x00005 0x00005 0x00000800>,
		<0x10000 0x10000 0x00004000>,
		<0x10001 0x10001 0x00008000>,
		<0x10002 0x10002 0x00010000>,
		<0x10003 0x10003 0x00020000>,
		<0x10008 0x10008 0x00000008>,
		<0x10009 0x10009 0x00000010>,
		<0x10010 0x10010 0x00040000>,
		<0x10011 0x10011 0x00080000>,
		<0x10012 0x10012 0x00100000>,
		<0x10013 0x10013 0x00200000>,
		<0x10019 0x10019 0x00000040>,
		<0x10021 0x10021 0x00000020>;
	riscv,event-to-mhpmevent =
		// event-id event-selector
		/* mhpmevent3: L1I_READ_ACCESS */
		<0x10008 0x00000000 0x00000001>,
		/* mhpmevent4: L1I_READ_MISS */
		<0x10009 0x00000000 0x00000002>,
		/* mhpmevent5: ITLB_READ_MISS */
		<0x10021 0x00000000 0x00000003>,
		/* mhpmevent6: DTLB_READ_MISS */
		<0x10019 0x00000000 0x00000004>,
		/* mhpmevent10: PMU_HW_BRANCH_MISSES */
		<0x00006 0x00000000 0x00000008>,
		/* mhpmevent11: PMU_HW_BRANCH_INSTRUCTIONS */
		<0x00005 0x00000000 0x00000009>,
		/* mhpmevent14: L1D_READ_ACCESS */
		<0x10000 0x00000000 0x0000000c>,
		/* mhpmevent15: L1D_READ_MISS */
		<0x10001 0x00000000 0x0000000d>,
		/* mhpmevent16: L1D_WRITE_ACCESS */
		<0x10002 0x00000000 0x0000000e>,
		/* mhpmevent17: L1D_WRITE_MISS */
		<0x10003 0x00000000 0x0000000f>,
		/* mhpmevent18: LL_READ_ACCESS */
		<0x10010 0x00000000 0x00000010>,
		/* mhpmevent19: LL_READ_MISS */
		<0x10011 0x00000000 0x00000011>,
		/* mhpmevent20: LL_WRITE_ACCESS */
		<0x10012 0x00000000 0x00000012>,
		/* mhpmevent21: LL_WRITE_MISS */
		<0x10013 0x00000000 0x00000013>;
	riscv,raw-event-to-mhpmcounters =
		/* mhpmevent3: L1 ICache Access Counter */
		<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
		/* mhpmevent4: L1 ICache Miss Counter */
		<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
		/* mhpmevent5: I-UTLB Miss Counter */
		<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
		/* mhpmevent6: D-UTLB Miss Counter */
		<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
		/* mhpmevent7: JTLB Miss */
		<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
		/* mhpmevent8: Conditional Branch Mispredict */
		<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
		/* mhpmevent9: Conditional Branch Instruction Counter (reserved for c910)*/
		/* <0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>, */
		/* mhpmevent10: Indirect Branch Mispredict Counter */
		<0x00000000 0x00000008 0xffffffff 0xffffffff 0x00000400>,
		/* mhpmevent11: Indirect Branch Instruction Counter */
		<0x00000000 0x00000009 0xffffffff 0xffffffff 0x00000800>,
		/* mhpmevent12: LSU Spec Fail */
		<0x00000000 0x0000000a 0xffffffff 0xffffffff 0x00001000>,
		/* mhpmevent13: Store Instruction */
		<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
		/* mhpmevent14: L1 DCache read access Counter */
		<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
		/* mhpmevent15: L1 DCache read miss Counter */
		<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
		/* mhpmevent16: L1 DCache write access Counter */
		<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
		/* mhpmevent17: L1 DCache write access Counter */
		<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>,
		/* mhpmevent18: L2 Cache read access Counter */
		<0x00000000 0x00000010 0xffffffff 0xffffffff 0x00040000>,
		/* mhpmevent19: L2 Cache read miss Counter */
		<0x00000000 0x00000011 0xffffffff 0xffffffff 0x00080000>,
		/* mhpmevent20: L2 Cache write access Counter */
		<0x00000000 0x00000012 0xffffffff 0xffffffff 0x00100000>,
		/* mhpmevent21: L2 Cache write miss Counter */
		<0x00000000 0x00000013 0xffffffff 0xffffffff 0x00200000>,
		/* mhpmevent22: RF Launch Fail */
		<0x00000000 0x00000014 0xffffffff 0xffffffff 0x00400000>,
		/* mhpmevent23: RF Reg Launch Fail */
		<0x00000000 0x00000015 0xffffffff 0xffffffff 0x00800000>,
		/* mhpmevent24: RF Instruction */
		<0x00000000 0x00000016 0xffffffff 0xffffffff 0x01000000>,
		/* mhpmevent25: LSU Cross 4K Stall */
		<0x00000000 0x00000017 0xffffffff 0xffffffff 0x02000000>,
		/* mhpmevent26: LSU Other Stall */
		<0x00000000 0x00000018 0xffffffff 0xffffffff 0x04000000>,
		/* mhpmevent27: LSU SQ Discard */
		<0x00000000 0x00000019 0xffffffff 0xffffffff 0x08000000>,
		/* mhpmevent28: LSU SQ Data Discard */
		<0x00000000 0x0000001a 0xffffffff 0xffffffff 0x10000000>;
};

---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/t-head/c9xx/cache.json         | 67 +++++++++++++++++
 .../arch/riscv/t-head/c9xx/firmware.json      | 68 ++++++++++++++++++
 .../arch/riscv/t-head/c9xx/instruction.json   | 72 +++++++++++++++++++
 .../arch/riscv/t-head/c9xx/microarch.json     | 67 +++++++++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index c61b3d6ef616..dd1d998a7ad6 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,3 +15,4 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x5b7-0x0-0x0,v1,t-head/c9xx,core
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
new file mode 100644
index 000000000000..2c6e9a904a11
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
@@ -0,0 +1,67 @@
+[
+  {
+    "EventName": "L1_ICACHE_ACCESS",
+    "EventCode": "0x000001",
+    "BriefDescription": "L1 instruction cache access"
+  },
+  {
+    "EventName": "L1_ICACHE_MISS",
+    "EventCode": "0x000002",
+    "BriefDescription": "L1 instruction cache miss"
+  },
+  {
+    "EventName": "INST_TLB_MISS",
+    "EventCode": "0x000003",
+    "BriefDescription": "Instruction TLB (I-UTLB) miss"
+  },
+  {
+    "EventName": "DATA_TLB_MISS",
+    "EventCode": "0x000004",
+    "BriefDescription": "Data TLB (D-UTLB) miss"
+  },
+  {
+    "EventName": "JTLB_MISS",
+    "EventCode": "0x000005",
+    "BriefDescription": "JTLB access miss"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_ACCESS",
+    "EventCode": "0x00000c",
+    "BriefDescription": "L1 data cache read access"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_MISS",
+    "EventCode": "0x00000d",
+    "BriefDescription": "L1 data cache read miss"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_ACCESS",
+    "EventCode": "0x00000e",
+    "BriefDescription": "L1 data cache write access"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_MISS",
+    "EventCode": "0x00000f",
+    "BriefDescription": "L1 data cache write miss"
+  },
+  {
+    "EventName": "L2_CACHE_READ_ACCESS",
+    "EventCode": "0x000010",
+    "BriefDescription": "L2 cache read access"
+  },
+  {
+    "EventName": "L2_CACHE_READ_MISS",
+    "EventCode": "0x000011",
+    "BriefDescription": "L2 cache read miss"
+  },
+  {
+    "EventName": "L2_CACHE_WRITE_ACCESS",
+    "EventCode": "0x000012",
+    "BriefDescription": "L2 cache write access"
+  },
+  {
+    "EventName": "L2_CACHE_WRITE_MISS",
+    "EventCode": "0x000013",
+    "BriefDescription": "L2 cache write miss"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
new file mode 100644
index 000000000000..7f1649548177
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
@@ -0,0 +1,72 @@
+[
+  {
+    "EventName": "BR_COND_MIS_PRED",
+    "EventCode": "0x000006",
+    "BriefDescription": "Conditional branch mispredict"
+  },
+  {
+    "EventName": "INST_BR_COND_MIS",
+    "EventCode": "0x000007",
+    "BriefDescription": "Conditional branch instruction"
+  },
+  {
+    "EventName": "BR_INDIRECT_MIS_PRED",
+    "EventCode": "0x000008",
+    "BriefDescription": "Indirect branch mispredict"
+  },
+  {
+    "EventName": "INST_BR_COND_MIS",
+    "EventCode": "0x000009",
+    "BriefDescription": "Indirect branch instruction"
+  },
+  {
+    "EventName": "INST_STORE",
+    "EventCode": "0x00000b",
+    "BriefDescription": "Store instruction retired"
+  },
+  {
+    "EventName": "INST_ALU",
+    "EventCode": "0x00001d",
+    "BriefDescription": "ALU instruction retired"
+  },
+  {
+    "EventName": "INST_LOAD_SAVE",
+    "EventCode": "0x00001e",
+    "BriefDescription": "LOAD/Store instruction retired"
+  },
+  {
+    "EventName": "INST_VECTOR",
+    "EventCode": "0x00001f",
+    "BriefDescription": "Vector instruction retired"
+  },
+  {
+    "EventName": "INST_CSR_ACCESS",
+    "EventCode": "0x000020",
+    "BriefDescription": "CSR access instruction retired"
+  },
+  {
+    "EventName": "INST_SYNC",
+    "EventCode": "0x000021",
+    "BriefDescription": "Sync instruction retired"
+  },
+  {
+    "EventName": "INST_LOAD_SAVE_UNALIGNED",
+    "EventCode": "0x000022",
+    "BriefDescription": "Load/Store unaligned access instruction retired"
+  },
+  {
+    "EventName": "INST_ENV_CALL",
+    "EventCode": "0x000025",
+    "BriefDescription": "Environment call instruction retired"
+  },
+  {
+    "EventName": "INST_LONGJUMP",
+    "EventCode": "0x000026",
+    "BriefDescription": "Long jump instruction retired (jump dist over 8MB)"
+  },
+  {
+    "EventName": "INST_FP",
+    "EventCode": "0x00002a",
+    "BriefDescription": "Float point instruction retired"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
new file mode 100644
index 000000000000..073c1d085021
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
@@ -0,0 +1,67 @@
+[
+  {
+    "EventName": "LSU_SPEC_FAIL",
+    "EventCode": "0x00000a",
+    "BriefDescription": "LSU Spec Fail"
+  },
+  {
+    "EventName": "RF_LAUNCH_FAIL",
+    "EventCode": "0x000014",
+    "BriefDescription": "Register file launch fail"
+  },
+  {
+    "EventName": "RF_REG_LAUNCH",
+    "EventCode": "0x000015",
+    "BriefDescription": "Register file reg launch"
+  },
+  {
+    "EventName": "RF_INSTRUCTION",
+    "EventCode": "0x000016",
+    "BriefDescription": "Register file instruction"
+  },
+  {
+    "EventName": "LSU_STALL_CROSS_4K",
+    "EventCode": "0x000017",
+    "BriefDescription": "LSU stall with cross 4K access"
+  },
+  {
+    "EventName": "LSU_STALL_OTHER",
+    "EventCode": "0x000018",
+    "BriefDescription": "LSU stall with other events"
+  },
+  {
+    "EventName": "LSU_SQ_DISCARD",
+    "EventCode": "0x000019",
+    "BriefDescription": "LSU SQ discard"
+  },
+  {
+    "EventName": "LSU_SQ_DISCARD_DATA",
+    "EventCode": "0x00001a",
+    "BriefDescription": "LSU SQ data discard"
+  },
+  {
+    "EventName": "INT_NUMBER",
+    "EventCode": "0x000023",
+    "BriefDescription": "Interrupt number respond"
+  },
+  {
+    "EventName": "INT_OFF_CYCLE",
+    "EventCode": "0x000024",
+    "BriefDescription": "Off cycle before interrupt arbitrating"
+  },
+  {
+    "EventName": "STALLED_CYCLE_IFU",
+    "EventCode": "0x000027",
+    "BriefDescription": "Stall cycles of the instruction fetch unit"
+  },
+  {
+    "EventName": "STALLED_CYCLE_IDU",
+    "EventCode": "0x000028",
+    "BriefDescription": "Stall cycles of the instruction decoding unit and next-level pipeline unit"
+  },
+  {
+    "EventName": "STALLED_CYCLE_SYNC",
+    "EventCode": "0x000029",
+    "BriefDescription": "Stalled cycle for sync instructions (FENCE/FENCE.i/SFENCE/SYNC...)"
+  }
+]
--
2.40.1

