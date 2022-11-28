Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EFB63AE33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiK1Q63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiK1Q6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:58:09 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0012AF7;
        Mon, 28 Nov 2022 08:58:00 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASGbpE4027841;
        Mon, 28 Nov 2022 16:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=FObPKKabfnw+zUHRRuyWjF7/0t66BQmgmBJeN0pJ+AI=;
 b=cGhf3Nvf3XswMcNhD4HcSekVzb7sq/wIHQli1cJYDNTlmKPcd1MZYcXFmn+/ULuRXDtW
 Z+dA1nKmPG3Uu5hHhr3ENfYx4BpQygzJ2AlV2mTucjGDt4HiWlLQQhyK4zIjqUuUXIjY
 jAy4JE1uaE0SqkR+o/br2DWCbsehnaw7OS8Y7kuO7x4NbVUMe8PmUUz3Fzm8FyJetwlB
 RgTtpZ9doCOUDRmOQDt6clnJNBKgaH7R2MwH9o8W1jtSA2/to9o/MmtRouxkZNQ2sHCA
 rrhOvJaHJGfln0mrTp59sfp9oybZ9hO0Jjq7nJHY2V3s4w9gH9PM4gmpI05N9a1exyH3 dQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m50nur4xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 16:57:42 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A8EA32FCE7;
        Mon, 28 Nov 2022 16:57:40 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Nov 2022 04:57:26 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 28 Nov 2022 04:57:26 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Nov 2022 16:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDSus599kLoswdxKIZdGiIat7OHwh+c++3B28ozO5w3v75QFaBrURReKyUTaUS3m+PtTTPOhJO//2nKg3Un/1NAOp3lq/pFQis82b7ZrP5oyYKAe4FqTJQULov88WHa/b2BiSXLaB9xiqZsGkd0LKfxnMvtGrQ17UnrggCY+cPe98xF8W8yAKayggI1xuY7yUx8nNobDH2vuj94TUU9KBkO1i2rYJRsIQa0mAojEgeJZszrXd5IGviUG5+cJNdSujBj/7JgVjOYrTt1YR9cQBOMn2ZKEFQYTD3tKFcSUCg1VkIIvwosLyn825XuMd0+hsyoAPQDEBgc1k8t7qoxp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FObPKKabfnw+zUHRRuyWjF7/0t66BQmgmBJeN0pJ+AI=;
 b=VYC5hI/KthIXTM0lM1L3pu5lu8+Wnnl6ebpzsUi7tP0F8HJlXg/25j74AYT9AWx/RNqTHMhzZoLCsaIoZflAi9geHydtk3Gk8uBp49qi0OUoDFkzaqcB8AKxeP2G4YLoTWqEnoWliuaQDCI7ncYdYy1OH8OSOIfWUyH5yeGPjNVl/2ZW+0qMtK/qBWPo1Tq6uqz59tTL4+LTkstV2ItpNKraJSPkezPQHMWgDWweX5IAz/2iUZKEANx4eECbZhE7MD89IAPxvgcivCnqlmX0pYSIUZ0d5P1Iub8Es1gfbaLNF175C8oKvEtjABetCKWlAlXhs3NN78maMfm4E99szg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1810.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:161::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 16:57:19 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 16:57:19 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgA36OwCAAAUngIAAAQwAgADfYdk=
Date:   Mon, 28 Nov 2022 16:57:19 +0000
Message-ID: <MW5PR84MB1842E182C47F77FE8C8E755BAB139@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <CAMj1kXHHm+L=qE5opDXhjoWZt+1eKXFeGVS=OdvyF0VNFZivCA@mail.gmail.com>
 <Y4CExnFX46mk4/1+@gondor.apana.org.au>
In-Reply-To: <Y4CExnFX46mk4/1+@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1810:EE_
x-ms-office365-filtering-correlation-id: d96abbb4-9d86-4be3-ed7d-08dad1619c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYCoF06RWs5Y+HU0ovuZVzEudWZ64ejivXGiyRZw3as95rLwJUIK+4PbE68JwQGpKUasizCZ0RGrG55cTDCCg87GXIfQBDuFKQcr6OlMNPtH4KPhf586Zfw6+dQLtAOWcUB/jtYlCG1h3eX0BUYthLpCGVqjB6fz2HBUBQuPg7nhO3yYOprsrqOHByenor87ImneZZR7l7dzgWlbZRWDA2fDrs2uQgI4Am91TTUnjF0arWzAMGAeoRJ3iaUM3Xqx94reXs+xFJqOYdGYs2RgzVn9QH9QnDapEyaN3uYiy1a35ZwvlGwVLNo4BKPRAzQg31h9gIK6URm0zRjVRz9P0IdaO7+cE2TS9/uoiupDGJpcEhIgJ0rUqkBpOMWhGBtIpYO3FB+H1DfikKKtDyqpcgj4tmBMSz1BAeeGUSIjDSvJNbvz8e5RmdjZBaZBqObBKrlHlzhoXKnThx1JfrWhYc6ZOhHhm0x8bvAJPaEPLRI2tPv1BECqfo6bvShvuXtWdY7YW3gFPRaLlHIivyd7Layf+qoDAtfH+7GddY4QWjeheYGO3tHFI8n7X++K3BXwSzUpq7QiL1V8YJjb47Q/5N/cE9sD4v6VWsAcGY0uALoBChUI2t9a9f4i0lWAFKi48OAEWMpaKViMVhYX1W7CWbGQYyegU4Xov2CXSlh7gnnb03f9+fA5QbJ3MsiGwuY8KSQfOmRhNdYIwUOkAUrh2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(2906002)(83380400001)(41300700001)(5660300002)(8936002)(7416002)(52536014)(186003)(33656002)(86362001)(55016003)(122000001)(38100700002)(38070700005)(82960400001)(478600001)(54906003)(316002)(26005)(110136005)(9686003)(7696005)(6506007)(71200400001)(8676002)(66946007)(64756008)(76116006)(66446008)(4326008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LrwP+9P/4ZyeogOf5Eha8cYZ15QU+w25rw/lI6DK787Z2QtLxSD83+R3ruAF?=
 =?us-ascii?Q?eXdJ5Z+FCf7EhKZtXqyvaBKC66tB75P+w7PVmvTR4tETuI48jRi8Moy68f4j?=
 =?us-ascii?Q?STqNSbw6wnlIgTGVLthRq2mpIRnh9nNJRhYzOJ3RsiiFGTRcxnZBaQ4aIByb?=
 =?us-ascii?Q?SuZSLMsHzsyitFEK7z7gT0/rN/hyR3BKFWpR4qkxlH8sEEFGLwvbUbqrjt/2?=
 =?us-ascii?Q?JUieicdj5zopuFW/D9h8Y6iGfYkbG7voZU2prHhfrdwAFu7P3IgX3/1Ot0d/?=
 =?us-ascii?Q?tbJW4qVg21H/jO7clWiDpbrt3JIXLfCjrGELLq7BfUTe4prLjKq4fXbJca6p?=
 =?us-ascii?Q?NGaEeze3DZYWZIpGIyk9/dfHgWQIAa3us9BLsbhThPu1HvOYoPVetnXE0AU4?=
 =?us-ascii?Q?A7p2H+DJ/7F7dslQi9N/yyhurZlYXutq+/C/EEftrXAu9ltVMikHg6wm7zU/?=
 =?us-ascii?Q?lSy7F2fMMlxys24cW1qopAVQsAKgKnNxa9gzuLziq3D/DrK5S/0Uwg+/jgQ4?=
 =?us-ascii?Q?p42gxWqeTTZI8ZUjU0gqYlrR0Lo50ZvVKW9gGLyAmsOsMF5wdjIGsVLZS6TL?=
 =?us-ascii?Q?a4LlZ/ZKENujzZqc5cWkJ9COrNMbuiPmC0JBc2bE/y0hT5ZpC1xWPbEZ+wk0?=
 =?us-ascii?Q?IstuQ3OmyaV/MGQxPMgoy4J0eZjf4rRXbf91i3QjUv5VechztB/zGVbkg3z9?=
 =?us-ascii?Q?A8So0+Bx30q3ttj6iKLEhxSb3NbfmDh6/nSGS6MrEfh71Jb7fqUC8cSb7aNU?=
 =?us-ascii?Q?Jsc3LfdT/frZJ7LYRoBfT6IISHZyhkfQ9ERoiroYS0cGzqLP/Vit3LsRZwQ6?=
 =?us-ascii?Q?4BpxYzohjeWedo8/U3hRH4NyRoZlhSHTIxUG3uQkO5o9TN5cNdqd158z5BCC?=
 =?us-ascii?Q?vi9I+CcDntduPfkm/QdeMtDziSXmuaKf3YpYlTpAxXUUaLzycu+LLq9TWyY4?=
 =?us-ascii?Q?x+OW2TbsPn66kKdgOGWW70UvbRu9o64MCXHGUW7NybJ3LMg15zKcj6aY3cmx?=
 =?us-ascii?Q?Bngg/tL43qZg7rR9o/jrgUIcrLHWc28VStEfvUZcvszGnBldc7yBuCO00o8G?=
 =?us-ascii?Q?KxugP4r1UmeK86CJS3XEF/H2NtKwM7R1jB68MhyyqLasr+6L24N43NLsoajw?=
 =?us-ascii?Q?YvUx+Na9Is3mSGkpHn/6J07cu0GDzyra+ucDs4UzvnRpvj/dEJHVZtPkmUtc?=
 =?us-ascii?Q?BpgkhxC2biEmY8yrpq8SxZphpXtb13FDJMlWYTj3S5fyijf9PeondKZG++W1?=
 =?us-ascii?Q?T8Q8g2tT4U/1exZpMJbQ+6aVQAFX5FeLrWtdBX/YgRX2BD/OCfXCMDBdUTHV?=
 =?us-ascii?Q?eC5hKJi+MOwaqV7WOgFahv8MrRZv6UH82VIjQRNo/IwQ8QvpSV/h0LraPDQo?=
 =?us-ascii?Q?vZ+EpyctSbvasXO82UGL/7/rRSRnuciENi+JJNwD0q2Tvc/DmokB7kK9JOfF?=
 =?us-ascii?Q?zYJQPrUkpWD9RJLqT0M59DBM2MHdga7da4orW6UTEbBogoJ0wQfIR62KoIgJ?=
 =?us-ascii?Q?Fc8CsfBASG76zlsQEAhXyFyx2itth9/YNuoJOBWxDYOdJM8fpPOdBTu8ACka?=
 =?us-ascii?Q?5Ainskbp+RqwjZn6sEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d96abbb4-9d86-4be3-ed7d-08dad1619c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 16:57:19.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kapwlUOMdFvgV37uxn07wGrDnhWo/S4bjDt8MGfaeBPaMwt4nN+KuTgi288HJIuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1810
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: eSFy8vhXeCa6zYoqejnMm7vEz4uodLIq
X-Proofpoint-GUID: eSFy8vhXeCa6zYoqejnMm7vEz4uodLIq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_15,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Nov 25, 2022 at 09:59:17AM +0100, Ard Biesheuvel wrote:
> On arm64, this is implemented in an assembler macro 'cond_yield' so we
> don't need to preserve/restore the SIMD state state at all if the
> yield is not going to result in a call to schedule(). For example, the
> SHA3 code keeps 400 bytes of state in registers, which we don't want
> to save and reload unless needed. (5f6cb2e617681 'crypto:
> arm64/sha512-ce - simplify NEON yield')

That sounds like the optimal approach. There is a cost to unnecessary
kernel_fpu_begin()/end() calls - increasing their usage in the x86
sha512 driver added 929 us during one boot. The cond_yield check is
just a few memory reads and conditional branches.

I see that is built on the asm-offsets.c technique mentioned by
Dave Hansen in the x86 aria driver thread.

> Note that it is only used in shash implementations, given that they
> are the only ones that may receive unbounded inputs.

Although typical usage probably doesn't stress this, the length of the
additional associated data presented to aead implementations is
unconstrained as well. At least in x86, they can end up processing
multiple megabytes in one chunk like the hash functions (if the
associated data is a big buffer described by a sg list created
with sg_init_one()).


