Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482026A7799
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCAXQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCAXQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:16:37 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3E1688A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:16:35 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 321MxBXE028936
        for <linux-kernel@vger.kernel.org>; Wed, 1 Mar 2023 15:16:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=TWY3RXoXDxBGFKNyWzLujxC1deFbdbO0p4tnl+79DC0=;
 b=YHNPLLJAdI0SYktik+rjoh3lvmtZ9KpY3EyCuGuyqs7rEnn9DTtcs6uPCtbmivJyooaT
 UpbFZVh+q7/wPOoEV9iLbrMj+QQvmR14LzR5hQo9Khw3iGQmKu1q+UJzXHFAENtKHgzG
 xeEsbUb0ViuRXRbTkUbwFPQJ61YreoG660J90ZXTu/VzVLQCRY3Jzu7g01cw0JnWFOgT
 qS2dDXU7KxS5klp84aWtgkHoora+UQYmWNcrIoyQo5AGMJMjOXsnotbk3yFZeI7XhMpL
 6dC+dFrB4FFYRsJTzs+WG0F0qmK+WM5QsXNdr3qp1ZH592dxkTqav+ryiRrhUyHHuBN6 1A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p1y0h6kqf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrP8UGsPdMLFY/t3LsnR6EdxGZSEaYjQ1SO84DwHE0V/NCOD3XO8xQGY160muqCmB44zl8RMzNWWkYppk/ycOKZFMiwjGLa2L7hi/jfQ0YDoySU7KzYeOC0z0oZufTVsBh5E3NtIMejVW/x0P0dRuuChHDFy4eyADNR0yttasKzFIx4c233DguWHQ3uOVnBxUHDNWQkFdKYzkXGKcy3DzAvl7bR7gqJD6Ou3+5G47E8ppByNNiqGqpJRr5x3+jegkDniKh3lRz7cLOQw7eSQlcdWbYhzjU+jVGg80D57pPfvuR72+E35uHGKNjdCdPH7SUx/Oa+RkxuDaKJfs0sGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWY3RXoXDxBGFKNyWzLujxC1deFbdbO0p4tnl+79DC0=;
 b=MoTgP/oct21xq6j5FNVPbMdOZe7GcBdnB13ltS2Ewc44SXL5aogqLBNMjs0mHSF9PVoq6pMIMbU+lWqtsCSpO/EmC54CyO2GPHuPevKJtrCAXyldrQGbsPvZWRmZuKZ8nriu1AzLOrscdRPxcXMfuZjBpFvniFjkGl3Q6GcsVf9IwsNSOWSMdVtE9E0dLP+WJKkYolZ/YvX/Upc+Nc6PQZOl6uLV8ic4LJj+AoSmSjh9UjnDEND3sznT1k/bm4V4Tc18OGhymyZBS9Goe0leqTWCKTRggnKslrutRPyXBY9N8KRklJ71tp5rXq4AFKPmwXDLPsh4ADcJ+mYnFnf8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4493.namprd15.prod.outlook.com (2603:10b6:510:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 23:16:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 23:16:32 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: fix perf_event_context->time
Thread-Topic: [PATCH] perf: fix perf_event_context->time
Thread-Index: AQHZS6nzbIJnibMzeEap6dRInzeNaK7mg0cAgAANEIA=
Date:   Wed, 1 Mar 2023 23:16:32 +0000
Message-ID: <BBB1A458-25CA-4C0F-AF04-18534D092142@fb.com>
References: <20230228192145.2120675-1-song@kernel.org>
 <CAM9d7chLaXDU4mMkD1U6YuOGZXcu7PFWGOuEkFKSkbrCLS+zWg@mail.gmail.com>
In-Reply-To: <CAM9d7chLaXDU4mMkD1U6YuOGZXcu7PFWGOuEkFKSkbrCLS+zWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4493:EE_
x-ms-office365-filtering-correlation-id: c68dd7c7-582c-436f-9744-08db1aaafe9b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CyZ34rVYqeF24DatnvwOwkDOzNmCm4/i8UjSpTCGeHxaC9tAOzhA5UFQIXDSAyky7WwUCL2XK5ROreVsY1Yu1OTbavVmtHsDx8zm5Rfzv0tjaVNvyugLFklWysQhohoPPsaYfMc/L9A/LFxAcneu//6YeIOmmG0chIMrZf3VHORPIWCVx6XY89OPvJXBU7m1MfhA2D1j5qEiVxtFGflSZAUpwdI1h9e5XL8ORAkNM6swhXG3tobFhwxHmDzDFWz9gYFjbp47HR5yaATyltqm/mNfxEyEyO1I4tuve+KE65oR22M9i94USmDAAVezAZ1jBYQ45ohiRzG+j58JgCVkkyZ5hZWWKj4uc9+lQAGZ8iZqVTYznCxY4lwrlv+6T+Liofh4ljZ605GqhhBK2jgo6uxmbYmdDlIAq2I4PsLAV+pDYHzEmRh33M/naQeUD6pNQ4gKwA7WpuysP4bWQ86bEdFmhZ0I0NTIWwucZAPZ5dmoVLBGoyf+CXGbi//Z+37c4PjqWrhpP8Q0SxuV/ePb7RrgY3R6TWJMRKguuLTUsaUaXeGxDAGWxxvCJheSxmDnmR46AZ16e9fxVt7mFPnQgxL5rGnnHAMct+Bre22Rcs06Ryyoo70CSHf/1BQr4ILCtz9/4XuqUyxGKWn5wWbYe2gU86Z5zBG5YQaKvgSPRcjyKeO//N7hajb76K9VXnUkzURP6XsEGejZMVwAKKH6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(91956017)(76116006)(66556008)(66946007)(2906002)(316002)(33656002)(8676002)(8936002)(36756003)(64756008)(66446008)(66476007)(4326008)(6916009)(41300700001)(83380400001)(6486002)(71200400001)(9686003)(186003)(6506007)(6512007)(53546011)(38070700005)(54906003)(478600001)(86362001)(38100700002)(122000001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qbyyorIf4y6/RYh4lvx59LVueDh4DPREKB/UPO9EIkImQM6mXbiB3NWcQKhn?=
 =?us-ascii?Q?oCrvzbXlVK1rd4fLffcnyVGtlLVbr/6ZJUoKR4CnUXzWvGwBjrp/OT7N9eas?=
 =?us-ascii?Q?qowQioNElqAhwv0G+0MPsCVYhWWmRGVmFugO725qiDe8KFRNFYrFcRpCnMYx?=
 =?us-ascii?Q?lqk97Y72Mv/9pm6nwT7OxxTCz4OWiN5rP6G7ujAQ7KZYOqnfDc3QNf7a+RsH?=
 =?us-ascii?Q?GXVpOhA7GloydgnZ/MF6FYsiREdPdYhkgJOW/Rd8g+lsOppFn/iYVdc2zDu5?=
 =?us-ascii?Q?AKycmw1vDd+96Xln6Bn6gGdJz0dNswyz+iY6QTZ+ru6b8GGOC3Pg/BEfKxo9?=
 =?us-ascii?Q?eoYjmLTId9eaSTq7DNAHWt6+KJ8/BHLiZb5mzn+Xkx3QQgyRo8JSWsb6N6RO?=
 =?us-ascii?Q?usJWo8/yJBm4FpFh3nxM5x+lmd3Wy7B9RvO81eNnzf3cNetLMoLuE8u0/+oU?=
 =?us-ascii?Q?VWGKfvj7v4tzWlsehtzCjUxI49gV4oH7JkH246kVEUvf/xKwIJLdudY2Nkp0?=
 =?us-ascii?Q?kN+uXWju042sNJ+MFVpUJEJ/cl9N1hNdGIeypzDp6R7mePpEVB0RVmDmMXkJ?=
 =?us-ascii?Q?7LToUN5rGrvBno9FMCaGh33Lk9+9TdnB9wMKQuCeF9ryCvDfXYMF4wsIXDTM?=
 =?us-ascii?Q?1LhQMA+jN8vk6Syf4SAQWwUjQHWfp3K+jGb5TWRzVp0G6X+T/zNtwfu9Ob9y?=
 =?us-ascii?Q?k6vDR13HLel2/zRYXwEQ4GGo28/Q7zrh5OohvHYKfwYvZFXzk8OixgrWNhjU?=
 =?us-ascii?Q?6pRAP9YfQo07jGTOV/FbhKIdWM0dWA6qr9zp7kbTr8B6eOS2YYDN80FZxT6f?=
 =?us-ascii?Q?MhwMP+vc6vohyRX64M4T1x8b201RQfcSmfm7F3jwrA7cY6eNYA10f/AOKCrh?=
 =?us-ascii?Q?w0/8uJXoTobosDdl4JXLOZdQ5P8t8phJwdgGh1mCmPgyEjFd+e++l15LmHDw?=
 =?us-ascii?Q?IPEy1iLxZj3jgAHpNdPe+XRtgvv1/lDhLzMiXGaL3Mwy9/kHFJwIt+3/Rtik?=
 =?us-ascii?Q?noC9w2xiYmEonLJznlNSM9lTGYxWR+j1klZ4VS9+tvlm06vLyEI/J6NlCnbm?=
 =?us-ascii?Q?BUGwa3V0LfBC7//LGjPyDk8R3nFVI4uRyFwinKoEpVGf5VP6IZiFZERjvW2P?=
 =?us-ascii?Q?a1dHH87aWE60iLKdmJxfAwpJu4e1h+CH3uYlTuh1u0X/4K9PfvW9pG7lwAcE?=
 =?us-ascii?Q?N7bS7ZVZE6YJI5Bc+R5fHIFuyyDS4uf9F8F6VqxUYO3V5lv6516rT/g/bjgi?=
 =?us-ascii?Q?LkXNsxq/GfBzS3waJ/Qa4ImaKhB7L6lsCbvBB3MU8zsRV+hv6ARick1etmBA?=
 =?us-ascii?Q?NBLpxJFsKL7qdOovERsKMZVnIe0dTWv0vvQ9bra1UXWWBKSbCA1mm12ZUK7N?=
 =?us-ascii?Q?HR0n6S+uHhAcf91niplWRdOql8W6J/KK6HWmCnsjEqMnbyCtCRiPHv0h203y?=
 =?us-ascii?Q?V0knb+rON44NjlX84ffEmHYvHsEF/wUHmX4/2Y+SGpelrBXbeuGdaRHOO+qC?=
 =?us-ascii?Q?4utVa67bY9TbeR5dJ9VuINXDtIL6aFyPhRcjDHG3p/iKse4Raxn0wLNIpNev?=
 =?us-ascii?Q?nyhNeQ52NYjGahDdItfiJv9LfgAwqAE4VFpLv2Fcr+mbuHQAfmmNvLj2V6ne?=
 =?us-ascii?Q?gA5Qg4/Pf+uSJVZSjfiYgkZLqSKJ1CSrtPBdCJS916nT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC7C5A6620984045B454EF502A68281E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68dd7c7-582c-436f-9744-08db1aaafe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 23:16:32.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpjrcsiWfAEUwEhxNraZ5xxh8p+iGAcysvIrHcGCc6cGlQpt207FqMvCYFj7z6r5dlw5H7SqjlX/hbCE7VIRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4493
X-Proofpoint-ORIG-GUID: dcedKbnLr0Lp81Pk0sv1BfWZcawcZvsp
X-Proofpoint-GUID: dcedKbnLr0Lp81Pk0sv1BfWZcawcZvsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2023, at 2:29 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> Hi Song,
> 
> On Tue, Feb 28, 2023 at 11:22 AM Song Liu <song@kernel.org> wrote:
>> 
>> Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
>> accurate time_enabled and time_running for an event. The difference between
>> ctx->timestamp and ctx->time is the among of time when the context is not
>> enabled. For cpuctx.ctx, time and timestamp should stay the same, however,
> 
> I'm not sure if it's correct.  The timestamp can go when the context is disabled
> for example, in ctx_resched() even if the NMI watchdog is enabled, right?

I think we do not disable EVENT_TIME for per cpu ctx? 

> 
>> it is not the case at the moment. To show this with drgn [1]:
>> 
>>    drgn 0.0.22 (using Python 3.8.6, elfutils 0.185, with libkdumpfile)
>>    For help, type help(drgn).
>>    ...
>>>>> ctx = per_cpu_ptr(prog['pmu'].pmu_cpu_context, 0).ctx
>>>>> ctx.timestamp * 1.0 / ctx.time
>>    (double)1.0385869134111765
>>>>> 
>> 
>> ctx->timestamp is about 4% larger than ctx.time. This issue causes time
>> read by perf_event_read_local() goes back in some cases.
> 
> I don't think the difference between the ctx.time and the timestamp
> itself is a problem.  I think the problem is it CAN update the timestamp
> (and the timeoffset) while the context is enabled.  Then depending on
> the timing, event times can return smaller values than before.

For per cpu ctx, I think timeoffset should stay the same (may not be zero 
though). 

Thanks,
Song


