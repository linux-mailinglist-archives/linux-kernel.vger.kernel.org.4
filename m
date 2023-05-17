Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A47705EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEQEj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjEQEjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:39:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E030F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:38:56 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GMHQ0K003721
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:38:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=y6rrPuLBNa6u0WpKV8uUdDG7Wuqa9S/HrfP0BZ38Ilc=;
 b=K6XscVvIkwC3Gxci82xgz8VyS4BSZnzoPMAXCF2blhzl84hiB4MV1pf8eP7s0yOzcYq5
 JFTvNL0atOTKaDvMtdAJn+ehlcQEnlw87AVcljfbmlfRb7reoppGJAJSLcLTP6E6CNEk
 ukLES0LlJK6K/E88SYw4s6MRydlqYz2yaW8g1GOP/gLNKpReVmYzDvTT6PKll+FCYkul
 LyPGgXYJ+JMZTNKzCFaLecyjfvPkY/g20DTjZ1YUYTb7MO/5W1g5+ZOD9gGqcbKbmzWf
 hN/9ZQkDEqbySAx8MAUR5pFZKh/POjms/A7fLa5m0gR2sjHU7HUGyuJp64TUqha7iCms JA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qkwa4ahqf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amCqfuY75tBfyc8qIkEJ5geDVCOQH70qqyfq407h6cpa+rHTVX6Apwq6+f4LKhGYL4PadaE6+XdvMeGBiCUvhViFPigcPZ9dlA1il9fD+RYGqMCaoyhfzxug1Fiz7R99vqASiKlbErjwVF41DwhcZVBgNitHNK4j9oleVtaELxBxk5gT/pAhpp1UcqkFNm5MCpI1oPJkxDXqD0VZNOrC4Ljtq6JYrWSJ8ill7V8bJ6DrJYZtZlLjB8TdF+JqbeZX4+qsKg/qO4efxkeFuMYA1pKJUWGAre65R4tQJML49eFlhNuI1l9tbAJufsd5aFbu5dK+EJysQlXnNF9ArxN2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6rrPuLBNa6u0WpKV8uUdDG7Wuqa9S/HrfP0BZ38Ilc=;
 b=YtoN7vvwbiOzIkPBBTSlDYvYDSd9Lh6VxjMS5UVH/DFlxqCMawnaLLw4tfxWzaF5YDhC9BneCDp0gVOALiMNks85s661p0F0hZK1hJ4088jLbFMPiRFahGXFFM77j4nTT48bzCjlLcRgbBZ+ggtFQPWKQrTEsqPS34NguXvhx5qPhXq/+xsQsHY/LEh9nVwJ3yBltuvWwlhIYCr07FoTTN4cLzk9VpuWZ6IPbf+7rGZNf+RmJ7KM5fuNeIKrlpQInYYCGREVsuhbsohgGoXEeiP7/dBtoWBbej8Dh02nriWXOguCg8dYkE11LGLx4BAwwndrSV1fFEuzkecs6OE6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5637.namprd15.prod.outlook.com (2603:10b6:510:28f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 04:38:53 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 04:38:53 +0000
From:   Song Liu <songliubraving@meta.com>
To:     "Li, Xin3" <xin3.li@intel.com>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Topic: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Index: AQHZiFJQA17dibxJREeMwvRcxvYa+a9dq7iAgAA2jQA=
Date:   Wed, 17 May 2023 04:38:52 +0000
Message-ID: <5DB7DD91-7213-4A30-B89E-FB28AD96F8C5@fb.com>
References: <20230516235817.2323062-1-song@kernel.org>
 <SA1PR11MB6734A17FF1E12FC3AC256C91A87E9@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734A17FF1E12FC3AC256C91A87E9@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5637:EE_
x-ms-office365-filtering-correlation-id: 0d72f8ea-140b-4c01-eac9-08db56909dff
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASclpwvwEbStP4w6FBrhGV6vu/kQoJMP+2a05WHO1ooE93kmhaKP3GWYkCAo/110rVnaI6b/JIi/0gNRzAF9qVQUtZrZ8lQjaYrpYRkS5DnOhQxqzSIuXbhXgqna5VJccSgekYfWOGOClsLq8BypaA0L4+/5x/LwHtbUT2XDCKKFpSpsvL/DW/eGBewFgMAPOzjY9ZqzP8hEKmwQ+GV0p4YY3M3Kd7dhsE+ZFp+Mk+6Kd8/iWqWb5iRSp0oc8y9DBOFnIi20D0xJa/s4gN5zp3h/xFfnZg5thTfg2x4OwuO0Ltw7Y+lwl8iY+rsN19VAfkzHn0GtFwx0F4pU63ORG0KW0lOF7ED88r7tmJ8Mzq2UGjqeRNr5V1kUycB/OrRvs41FUjgM+VRNYC9s6Emh7U5Ht0FoCSo43lF6cmhCva31maBE7kAzCZIoTOC+ZSYMt7KLMxVTWVsenekoZ5Z5cMJx+yzjc2MhKiP6y4EcCzqZe4XrmsCufAdKgHucWKBqfr5F0o2Nn49BderamtNVrwTfM4EMQxRjBDTdtZlBVwfaTVEbnSw1BZThgu58Pj5OeFaqPj5WMU1FFnVjX1RZHgp5sjAJKUTOnGpzi6VhfDFEYIvW+ee1u+kGUXVGWFlG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(66556008)(66476007)(54906003)(91956017)(66446008)(4326008)(6916009)(64756008)(478600001)(66946007)(76116006)(71200400001)(6486002)(8676002)(316002)(8936002)(41300700001)(2906002)(4744005)(5660300002)(33656002)(122000001)(86362001)(53546011)(38100700002)(186003)(6512007)(6506007)(38070700005)(9686003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1LY5PH4xuhLGWAjuwLbCM0KdsF60HrNptzZt9RcUYklgW7kzTVtrDNtoJ4Yb?=
 =?us-ascii?Q?IzSZN7JadJ2XRvbkKlCGrRbHr74AImJsMAJJMG5wS7gjhOwuSTw49/3t8W4+?=
 =?us-ascii?Q?Ip8VpSoxEVx+1Pfcl/UF5kW+hxIkt+xq2aeszF+9AciTbf5T6B8wSM7gUDKJ?=
 =?us-ascii?Q?sUC3bjgviTrTC7mVbIm1ec+ZpIWKa30lrzq5ZbWS7bcjVhIGPItsF4Qg65/z?=
 =?us-ascii?Q?dsfpv6qvHLrkboiBQtyrqTo/0PPEdaKwR+1usu1gq0FSX4sMB/6F9YXYSfiS?=
 =?us-ascii?Q?peFjk1jl6Z/3CmHVzIUOTY5jUvLw19HtxL/kF6yj27kikes1Ng7I03NEtebb?=
 =?us-ascii?Q?nYsqJ0PDh2I/K690IMKx3N5bsXf6FviwxwX5ioSyIw7L8nS/FOQ7yCN6zuch?=
 =?us-ascii?Q?xVay5SQEXFa+LGMM2IGBttob3oKitrkOQDvXBnuz23FfyFDpGKhuHfn72LHL?=
 =?us-ascii?Q?fdyKSoYDp0rxkck7wJ5x5LjlKj2fXAXBZbvVjkWDsyUs041trEBRf4vuSMk3?=
 =?us-ascii?Q?NOabjJES2aymwzxVOESDkoDH1gfaLILJP1UE9177hBLsWijnbKPdWyK9uDoa?=
 =?us-ascii?Q?W/Ml6nXGzet9uraTWK02lBKX5cTHtqsTr6MAJK410nsQita4IZJPpTc2A4hG?=
 =?us-ascii?Q?2b/KYX4yxiFM0db5Q/haVYYZEaMdkH1Qyn1CvOLYrkJLiKguYteIU9H2pCCh?=
 =?us-ascii?Q?ks2/gbNz/jPp0ASKQJZN8wbTetd63kQAACbWHUgAAZZQKwtalrmKWUQI9l9B?=
 =?us-ascii?Q?NpYRjtN9S8Txr5PTnuHj8+ki5KrTqlYbMOoL2fVJdwWrKB4RX5H2vlsQppiv?=
 =?us-ascii?Q?U5bqoZIPtj0VengYdeBY6KlEWYWF18jBPKOEWhlhAKsyM0v1sFTd7mA09UTt?=
 =?us-ascii?Q?lMiDoMeixagDGEk0dpYp9qJGtn1Fu6DnrqYT37ysXlH/Ti85i5ENBgoNVR1B?=
 =?us-ascii?Q?6OT1aASfaW7/J3QKOz0uXX41bqXzzWLZNn6iF0yEhW6SNnH5dZruMSpVF9ha?=
 =?us-ascii?Q?ptKAKlzPvqwABR4Ib/Fn7U9qVUNTv8GxRFhpU+UKZ1trht+nE9MCW3hsQxJU?=
 =?us-ascii?Q?JVEd2drrtLfiNhdqcx1WMCRi4/n5SaLqv1IsfxmyjQbqHHmJVmancBtK8bqm?=
 =?us-ascii?Q?uLacs03smyoQG3Rw1/3t8QjTDBGVPl/k3wenHKsjC9XQDjQVG9nHZkGIV8+X?=
 =?us-ascii?Q?BP5aEjR/vm+pMo5eN5KsiEAJPpyHaRlzYkull1DGf2WLtv4SFchPWvb9jYJg?=
 =?us-ascii?Q?dm/LFE63PoNbnBKDmtmO7IgK1HPlGz6UBmIcmz2RAYVgQLGo77+JdSdMfBaO?=
 =?us-ascii?Q?X1t8swa2i3+QAL/BmnD6wyffGLlk+tHT+4xpzaMBVR77t1kseETcce4sg4UC?=
 =?us-ascii?Q?ZFQr9qU0I9bp6+rBTwPNc286YeRc1fgPdlBrfqZsnllxxBYu5BMWTimeJMMw?=
 =?us-ascii?Q?tlccfSEs4UWnKMG8sz3t6LXLiAth7X/rVI+O33n9LO6CcsUaKtLKuTgu/un3?=
 =?us-ascii?Q?UJCIIWwU97p+SmFa9Sz2qfgl6KnmWXckhzWCph7yIUM+j+R514csDOB+ZmpV?=
 =?us-ascii?Q?Uf20id1hxQf/HTWSir/PbqfTqWYqFJ3KPPBgQUeP66NYqFm6ie260/+LfzYX?=
 =?us-ascii?Q?7Iz/0dutF1FkCy52+1LXe1g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D407AAC6C2B0084BB581BB194E5D1364@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d72f8ea-140b-4c01-eac9-08db56909dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 04:38:52.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OznY+vQfWWwrFVGS6IWK+/9LiaF8IzQ2ibVEkDBl+NyUtfMiiad/UzdDmkn1Ln7QQSs5hIrHd4q+XxxwyZdqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5637
X-Proofpoint-ORIG-GUID: IoZysUmhyRQoZSI4doumkHS-PJ1lih3f
X-Proofpoint-GUID: IoZysUmhyRQoZSI4doumkHS-PJ1lih3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 16, 2023, at 6:23 PM, Li, Xin3 <xin3.li@intel.com> wrote:
> 
>> NMI watchdog permanently consumes one hardware counters per CPU on the
>> system. For systems that use many hardware counters, this causes more
>> aggressive time multiplexing of perf events.
>> 
>> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
>> used. Try use "ref-cycles" for the watchdog, so that one more hardware
>> counter is available to the user. If the CPU doesn't support "ref-cycles",
>> fall back to "cycles".
>> 
>> The downside of this change is that users of "ref-cycles" need to disable
>> nmi_watchdog.
> 
> From the discussion in v1, the users don't have to disable the NMI watchdog
> *permanently*, right?

The users need to disable NMI watchdog when using ref-cycles. For example:

    # disable nmi_watchdog
    sysctl kernel.nmi_watchdog=0

    # use ref-cycles
    perf stat/record -e ref-cycles ...

    # reenable nmi_watchdog
    sysctl kernel.nmi_watchdog=1

Thanks,
Song
