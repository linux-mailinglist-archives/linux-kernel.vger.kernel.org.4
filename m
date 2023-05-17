Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACC7706FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjEQRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjEQRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:51:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81273268A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:05 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HGW4BJ003474
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=x/qRXEI+GzRpNVgi9hUf/STAVjSQrzE6cAL8J5Ad5h0=;
 b=PmKvS+7O/6/m5DKhHO3ElfJ3T4HnPSVAICzzbr7Jr4Dbfz8TSgW8G+edMjcuCHCPF5mt
 +vvLEyayC3PiqKM9eDEW/xZom2lDf390Oirur7y/pYvEQC7O/MA6QGRdWou8d9au5xPq
 xHSnkc3yTSzLeOF1qAhRbhjA+mt7fQ24x+IWMB1tjCuNhyqSTekC1s5Yu0DSpXDxyDbl
 PCuLlLm6LBwd1rdQb47il7O+iwXtyhz0XWatY9mUeP1Xw8X55muDnGKCdNWhVsRLMxUe
 VxpmaEWcvLpD0WW6FXU9Vj6zOmLUvlumid1sqhKEU76PBttBSmMa9qk7qiwTM70qNBBB rA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qmrccchyg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2ih/dD617IJWt6MfL/MPTZAnhWlVsxaLyA6LkvH0A+qnllOUPBi8Apbgh4TNa0/XLFj6FyAa2LvCzfYEBlhjeN0diq9tvf+J3n5dyM4OJybu7BB0VofsWYpeyyrXnmj5qWG5RcwB6+42Q87m4ZvI+yCpy5HwqhQdJHIcrwrY1ZNVx1ROhBaopyadBF00RONJb1tqZsRawNoGTqKJrw/3m7YaB3FNcwK5noIqiizVVhIx0Bf6U50/pv0NbIDoKBC3JYrXyfl6QTUdaeKvU1ezM/MExX+jauLf3x9+hVZvtzi+a2U3lOV02S0UAhOpStaRYNzm+/Wwbx8YdoZ8pn7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/qRXEI+GzRpNVgi9hUf/STAVjSQrzE6cAL8J5Ad5h0=;
 b=khEL6jSjZl40qDt8z88SIa9GLk5UX7dOsJE9P/kbNb7MSkqiZndkYlNofK23fGutxOMPV7B/7x/VcXgJHgWbialKF3QHNCXzUsvpwEV2hyqghhZQm+xFTkqiWvh+pdwxxiP4VlAa+578XZwgUbh+QmHOzJKHwZjcjH2WLPuIciQg2jd5bazuphC2Z9oUDeunVVpjMNxbfAqo3pvpu0iFElupRG0uIqTkc+bdXTXIlXzgy1HC/3Y0zotp+zJY5HEn1gzZKZJTAVpr7w81XgnEcUvft4GNnHz32x1hTA4NQXmyem04BoDdC3hkJqyKdsUG3oUnvnK3dVNUEghXrQG9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB6162.namprd15.prod.outlook.com (2603:10b6:510:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 17:51:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:51:01 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Topic: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Index: AQHZiFJQA17dibxJREeMwvRcxvYa+a9eEn+AgACtGAA=
Date:   Wed, 17 May 2023 17:51:01 +0000
Message-ID: <1DEE93B2-BA74-4266-A3C1-22A9DDEB63A8@fb.com>
References: <20230516235817.2323062-1-song@kernel.org>
 <20230517073119.GA2665450@hirez.programming.kicks-ass.net>
In-Reply-To: <20230517073119.GA2665450@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH7PR15MB6162:EE_
x-ms-office365-filtering-correlation-id: 73a2a6d9-f50b-43aa-784f-08db56ff470b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmT8+p/7TOY7t4m8EZTOdMkG8dtuEZd00gq4Oas/AJatd3dxiGcfRfFVtBg1L5AICbafPWgN+3NkcuTDX6GaNwK/hk00cSkidn8eZCLgP9l0VcZkxaUdUDLi3grM1oVwxizuZqisZwPY0VlXDETiveSdWJuAiAXSp8TNr3AlB9elycXwHyQIzjHCaqq/LzjgGq71CWq/M9AsxHGTkRu+/szEyzdHamvaKP2zt+mWv8YKUuqDBfKuIDQFDDDF/gsbB25OhTQNXKQ1oanqe3/I1cBXi64VeOoOZx1Le4HuQMOko3bZBWOqN66TZgO/oNEaDhO0+aVZxefiPdYyNu4iYiY8JL92q4aMMqt/ihXp4WaevcJrV58Ma6t/C3z9SO0zABJ2QWeDzePfwNppcRDyyTNkXBNvyfjI4u7t7HWstiYmr9aL+3w0N5HIV5JBxdlHTkyhJeaD0keYuAzkwM7KpYXxLLKhj8ximlvBLyoDXrfbHWe5yiEis56E+qpej0KmcAihNRlTT3287yh4oS+ilEGLw4iFX/Qd9Me0VarJgk/ChYx4BdTDK2yI+kYjbZ7km+eSTLeYGT7DoSTpLRN+atHh2OaQNjDePrjUSyXqhsGrgZl7JP9bjTW0vhPT2qo9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(4326008)(6916009)(66476007)(64756008)(76116006)(66556008)(66446008)(66946007)(478600001)(316002)(91956017)(54906003)(6486002)(33656002)(86362001)(36756003)(38070700005)(6512007)(53546011)(6506007)(9686003)(186003)(41300700001)(4744005)(8676002)(8936002)(5660300002)(71200400001)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YN71BiywDUj/oKHw0XdriBlK40BQN1Cb9wALJrU/aPcrQyCSewQZiBp7nWgo?=
 =?us-ascii?Q?G2cn1TeXvO0lpdTN7pD3xogBmq9oaapByJxHcpSljZIyiMwa4hWwXDhgc5eh?=
 =?us-ascii?Q?bk26QduXTckEkzHO9UfxaqbDuPabRVMrH4oLPY6uOu8GPlsuXWQwwQGJzwvy?=
 =?us-ascii?Q?w9wEvgkRODCUw0e6wvXCQsbG9+zv5Nvgcx4SSNaF6pdKX6v6G8mEfvx34lKu?=
 =?us-ascii?Q?hj98W9pa5LuVwnFeovCvVUV+rnkTpxOHZa6bQJojwZg3bL+l4lcATuh0Vi9w?=
 =?us-ascii?Q?D573rVsux7FDrSk1wBUnL0gAgxtdi840Eh/U9Eul/C64JC4IadCtAsUGYzrr?=
 =?us-ascii?Q?X4mi7QKaMLb5Fr3H/2WLh/Gi/Ppcgp1/3Vgn5vrjdUa/edXC3rNn7p0jShrD?=
 =?us-ascii?Q?yaJngrKfNgwhvp/wTile//tGTyoSeUk9efd0L5whkxYVaK4c5x4VLsMqgXpc?=
 =?us-ascii?Q?NRAIqfIYQAga7arRml+OjBvgKyVzOUs6IBJNGfDIG57Yso/FgPsu+QWYo1pj?=
 =?us-ascii?Q?6rrsKfx96+B5mB01IObd7cEk1Lxe/37yoZSXKmNYIWsMBPne4RG/LkHmwF0a?=
 =?us-ascii?Q?g/HqDQQOp85Tg61R5w4RC5XtCo+8mjvf3t7S7lc39QMhekWgOugIpwl04yFo?=
 =?us-ascii?Q?64owWVuT3ncwxhaqCEEbwcUP+yQA+ZT3zoefrl8gmYcanDdq93QeXNjrZust?=
 =?us-ascii?Q?w2IufkvkVHCNd5anWBh9kDYmNcxjsDhkWZ/j7G0SMpDP56D2hZifcrLOlCwz?=
 =?us-ascii?Q?GI3UVwLmKcDoTV8owUCefDGJLkvr03zK2beAztz4v6FExSAXCYGSqK7kpA8y?=
 =?us-ascii?Q?zeagpNeBptnz12PqVvRjuQP+DvhtQNbqWm0/5QOIzYtJvNI3rtwjBRxPspBl?=
 =?us-ascii?Q?MD46+8bmCGfz9h6MT3PGHeZT9Wgo/XF5FaL/pZS+besq7rIYt1csgaoL4tmr?=
 =?us-ascii?Q?ySLg56EI/+dsNwyxMSPA9TOP8LUJFDUejxWqresc93JbBBGxeHJpIrBoXdy9?=
 =?us-ascii?Q?BR0FHT6qGrvQzJ1j/fh7CwmJ0CSpggAdXOvxQtI3OnyQ8dAsAtqRDkBDaqCn?=
 =?us-ascii?Q?+YhviAQv4IDo34xFAaYdd14JMoeWDVlNiuaMPFcH9UUV1o7Me7ysYx8yK8gu?=
 =?us-ascii?Q?9JxZU3uQ+kXa5ShW5jdSLHhoZGHMNsdB/+agEN5MGV0NioK8N/R+vahn+y7T?=
 =?us-ascii?Q?B5cwdDpPCz3FmLimutfbWLG6l5zUkbG2fUzkEPVZNq44WEFC4a6Jp775FT0+?=
 =?us-ascii?Q?ctCoxtKZT3xzTBSTzKYYfFN+piJjY+JpzWTWVLMBFJ3we0/H7IOtq9hiL8fm?=
 =?us-ascii?Q?ildUMxMyU0x5fLZfav987dPQOtSId43+IMHs+aNSBXBsxWfbQfHCM0cDwT8V?=
 =?us-ascii?Q?wnnVniyxgDYyEibthqaaHeUKtkQXL05ITSbsecoCL64vgLI+pVpPHzNMrmLT?=
 =?us-ascii?Q?Jh3qA0BRwbUWnxq8q7tKKtwgdLd2Ww54LoL+s4ZTnDiJyswpwY4BKvtNuqpi?=
 =?us-ascii?Q?r8wEHtk9LNFwkC/aRJ+QDO5Wph7jejfqT1XR2ospPHhfcPzTY1Rja+zmiQHD?=
 =?us-ascii?Q?283lLoaqO8XHanZ4QkqOo9QG5h2atnhkJksht31JjV3MYZHuIuLOw3nUO7c+?=
 =?us-ascii?Q?CKshGHflOBbQY6OvLOFIz5Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A08F874D5F7C74DAB82FD049F58C7E1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a2a6d9-f50b-43aa-784f-08db56ff470b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 17:51:01.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ7nCC0mdDEN913MSe4n12eJvlnj5GAz/Wh0uARTtsNA9KSUmtnGEA99lM2Ss4OWQs80utVnElC9bhjwb0ifsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6162
X-Proofpoint-GUID: N9jdcN2RXLvk7i5s4HF13j5xEZxe6WkK
X-Proofpoint-ORIG-GUID: N9jdcN2RXLvk7i5s4HF13j5xEZxe6WkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
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



> On May 17, 2023, at 12:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, May 16, 2023 at 04:58:17PM -0700, Song Liu wrote:
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
> I still utterly hate how you hardcode ref-cycles

OK.. let me try with kernel cmdline args. Sending v3. 

Thanks,
Song

