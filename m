Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11AC74633D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGCTSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGCTSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:18:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B682EB3;
        Mon,  3 Jul 2023 12:18:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82um025208;
        Mon, 3 Jul 2023 19:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b95PyIT3uuz55843oOQDdUpniLYPHbph0/FRjW1BAlQ=;
 b=b1y8d9MsR8buIjAYkoIWhe6RT1JDf/SzVEHvKAo1n6u3Z8M08sXZEyfs+WUR03L0W4Ag
 ktMdN9x0OBsNHgwECKmlKlUHSH8vP131ggz444HUouIQ5iJPge643WyPLwQLMHsON2Hv
 RJz9NTpNWQIC00lkSfDVnq44C11XWwczY1K+y+BzXBewi/zuSk/jVZ+GvZwlvCs7Q5R+
 tKyEswo//uv5TZfKLJ5XK+UUOldonxOonslHMDZG+cCG+aEeZdsadDddFKMSUfjUDIvi
 vpwm73qBMsIKdazXZ47FjrSz/0Si/xJ2OBuPK8hvHtXFxLnlDZKNJsD0IygBPGZBcJBK fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ckary-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 19:18:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363HLR0g010608;
        Mon, 3 Jul 2023 19:18:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3q0s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 19:18:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAS5SdeqQmWkktfOeBPPnlEJ7eXqJbcXjWJIEhXMlXEgWPfDWGtmQKTX5kgzhXRedHUu9wv4PPVSu6xsTF+qVlPDloOdPI/zyr0d/VWVoPJPC9MTUZpiieedAZP16qaaNcN3IWM198+EyuC8uatuPYTGDDixco+gJIs0H/MmvwkjnvcXoJPfrBlC1QXzBXjYgmMhFsKkX/qO4M2FZuhsFojYRVtuoIkaR3bNuFaE3GyuNyd57h7So0mr6p3yl2+MxfvH/wTtZ/4HBogNeksqez/iIyqcTewuWkLMil+HqUj7qCtPtRtCTW8jmUHSUO7WJDfFg0q5RL1IrySXYipbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b95PyIT3uuz55843oOQDdUpniLYPHbph0/FRjW1BAlQ=;
 b=PNkiZqP/Ed3Styn939B1GZsHSNDOGBoBxzJWfdVaAmx497Y3PnM+CF5kYTtMoFktFZefFd8MCMfJ5CgjR4efHdR+EZjdvyZi+brhrr+FbKa30OWv98hrraAfhC32DZ9HjWsPdOOoO1JfM7UAs+cUvEquocP2P9NfGYojID9zc0J3U30hmmDIEofu1mzYiOoSwCdF52p9ht0ECjI9V8S926dFlfrL1Apz4FRF3ZG2pL24ZxGQ3Qb3s7MDzSRBIWrNvzT0eyWaYRIz9Vy8HKq0+2mtmhWp+EHLMevGrHab2dFuPVMWxPnKJZg2PPLYmdpmCtXjW5/Y/8wQS77TM5hoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b95PyIT3uuz55843oOQDdUpniLYPHbph0/FRjW1BAlQ=;
 b=UXKxl81sfefliRmc4Z8+GfHUq4NNHOqvEzl4lE4F0VIaEJXr8CY2KI+KVmbsSjVnMY3hrwUtw+gjrTbydLoLX7+Ot4pm3KQ3EjYX62QY64sGtpNLONBJpivEfIEBjVwy60El5MnRssl1x90VsoKpubuzDXoZfsODWMY9wmYMGWQ=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 19:18:02 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 19:18:01 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "david@fries.net" <david@fries.net>,
        Eric Dumazet <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "zbr@ioremap.net" <zbr@ioremap.net>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 6/6] connector/cn_proc: Selftest for proc connector
Thread-Topic: [PATCH v6 6/6] connector/cn_proc: Selftest for proc connector
Thread-Index: AQHZnxnDAmuiOBkXSUa1e+jxJeLAIK+kPJGAgARLZYA=
Date:   Mon, 3 Jul 2023 19:18:01 +0000
Message-ID: <CC10AB17-6DCD-4EB6-976E-EB5B77B25F18@oracle.com>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-7-anjali.k.kulkarni@oracle.com>
 <20230701014307.fs6tb7m5pyt6huga@revolver>
In-Reply-To: <20230701014307.fs6tb7m5pyt6huga@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SA1PR10MB6615:EE_
x-ms-office365-filtering-correlation-id: af34c5dc-2ec9-454d-22c0-08db7bfa3807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9uJ9qesyfG2X8GLozb+KrSvBzgHxOjWZFeVv63G4VJDz+89uU2X5YgWVDunCjl/YvZwgK9Yvpu8rs5MdPtivN2vRsGCUGh1EGEP5xVutypRYwweRkRQ1ZVL6pHE/lgjsz55f9kj863SUWM8HC778rN8SxtWtHmlUBMenVD6R8gk+oIJODx8SqJ75A4neRZJLjXzEKYv+Pxxe9KG28Xy6dRzrgZkac126yKvMUYOGAvvVDpD/LoSmoGNUSwkGVrcgaTQq2+tObE8KvenqSZ0UFYBKcZCE3vJjngXHh5Y3z3Tu2ZRAatsJZHUgJuH5oqeQDvOamA8m5IjBHDmn0rUKfUvjGpjAPfq/1MA+beo2TtKEqfJ4BpqRQA792rxCPz5wpcaO5ow6cGTwg8DucH8GQ2l4cLp6Kjgm/WR+WG6cLxK367ut8qqw2GFiTgIQfS9PMXqEwX185S2G3zZVbWSFF/JznTUGu8Lx/n1UI3aMKjiVaqQ+6MjXIBj7XHXJVW5Uw9JgV2kV6ZlxhRvMDRUVG8piWqK8MK0MzP1J4IdKvTbH4BrQLnMYBRBtQL/Ly2T2T0OxC2a9mexEyUP0Yb/SsUrliHCNLVPrwyxOXXlyQRcOdY/FxWnGaUGg/00YerMv/m1124oFalTFneSPh8KKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(33656002)(7416002)(4326008)(66476007)(64756008)(66946007)(76116006)(66556008)(316002)(2906002)(478600001)(66446008)(36756003)(8676002)(8936002)(6636002)(6862004)(5660300002)(41300700001)(6512007)(54906003)(86362001)(37006003)(38070700005)(6486002)(38100700002)(53546011)(6506007)(186003)(122000001)(83380400001)(2616005)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c59XRDFAKTOUj4p+D3uJo/kPggCHFDu0KB+blI5vhkoZgaGOyOgRF6A/Km5f?=
 =?us-ascii?Q?qR0QxVZZ/qkekR29mkiebYiTxrUX5LkW9kfv3PaFKcSAaZalC5XgefCpI79i?=
 =?us-ascii?Q?snsPafZnhw47RjrvexMMIDTIi3hWF2KiLJyEjYVNVJyCBiHXtnYiIV2jx1EW?=
 =?us-ascii?Q?cVM5V4FKQ1ZywB+kEXn8MVMyEtuTCE3bzqBkvwP6hTg7ZnN4zTqdHD32w2rJ?=
 =?us-ascii?Q?DwGKxmKtB031PW+RnS1WjPu0GJP6qaHx6utjlox+keJv8uD8ecHos0z/9Z2j?=
 =?us-ascii?Q?AY3RNsVkykAT+rDNfE3OYvLQcOE3dvu584ROguJucDzdUMlqF4NItAsJztFI?=
 =?us-ascii?Q?ryOoYiHJeC3GsBNxIhAzSjjjXlHixvGDQadfTBTdGWa5YMSC/tLL2/RB9+iD?=
 =?us-ascii?Q?ZlgoxH2fWqPNQvkhaBlT+NejlObTF18rFlacfsuaWIMhRYfQUTMJ8zLdWjgq?=
 =?us-ascii?Q?rCblTB2AGx/gpG1p0bEHllSgkuUn6sJdYfX5IxaKdIa04s1QpCpOugiakyPg?=
 =?us-ascii?Q?c3yPPwRPZUfIsgzVw7Enn1L+s40/MLUC+K8V2H+v5ElUgtFCatfG5MleNfOM?=
 =?us-ascii?Q?nw/I7kguJKZv2W/z4/1BYmhyrwTevKL1tfmLbg19RQVzzTxp6KXpx6O/OVr2?=
 =?us-ascii?Q?00rCYialG7ZrMdnEsDf5Cj4FRgcvlo48Z5B0gWqvLM5UGo6mCsZBu1ce8SNg?=
 =?us-ascii?Q?Dk9UHJbQ/RRG0mONjW2CeqNNI8sivPorOTetjI5Sg1WtLFVZKEAiPGst7P4N?=
 =?us-ascii?Q?4i07jcpXdAj6gQWgL0AjnXjD10Ldnj1fPydkZ+2hkDvBWZxawCJKLTEuia46?=
 =?us-ascii?Q?DlslGKDPVOPSZqgEAaiUKSuFJIxNiZf8iFFTIDYCb8lbEkxj8j+T4gFCvG28?=
 =?us-ascii?Q?cyAR5fBuk5424CbxaxX9pgyyLwGvQNWhGFX/ewwZG+ZkKc/JTodRp7M9zim5?=
 =?us-ascii?Q?1RK8v6K0p/hFv4got0B9SJgnBdosVnACSQt8oMQebPm/iE22j4Wm5bfKmTQl?=
 =?us-ascii?Q?F3uyqP0UVkk6CbP74EO0fOevoeTOAEmPNVhjBrMk3puhRo3SXUEzuntQqp+p?=
 =?us-ascii?Q?q6vaz4waZs8MiO5tE0LjtJYWnbFYfBPqSd+/jLv5lU42O5/ro7HxklgXY4Rl?=
 =?us-ascii?Q?GscoAaEJ4ENfF49w27H4ci14WI462eLLpSB4t4c3z2Sf5iFSVyDdN3ZM2EqT?=
 =?us-ascii?Q?GCV4ufO+TEiTEZx/ndfn1XvyGKsd9znF2tjaMU5HF+UPxLg0LTdzyzKOMz0V?=
 =?us-ascii?Q?BNSPa9XCd/5M0iP0mx6Gcgo6VOoEAe+zZsLdHNeQaaYNqQHFozlWEK5jdWQ3?=
 =?us-ascii?Q?fL87brSu9JRYoZq/xYuruccjPgLMJU31AK7TYgqIkn0CmX+oxGdqRrho7q5W?=
 =?us-ascii?Q?sJ0czgat3wS5IxtYe3kCY5eWyZhkkoZtfARDdE3MGF7NPreWj4n9N3dxD+9S?=
 =?us-ascii?Q?qMruApt0rqyxwTRfYCZcSBEDviM4D7n7EqOyd1l00vKH520TqOfSqhg1af3G?=
 =?us-ascii?Q?G87wLi6AXNPzL71AoIX3PKEMVU9MVqK9x7KymST3xsGKXf1/upR+b2CsuJrY?=
 =?us-ascii?Q?Fix/IUVmIV4m9OUsgmjUlKOkhvceok2f/Tq5wBGrdILJvFU9ea91TpLqQtIV?=
 =?us-ascii?Q?T9OhNCey8HZUl5a4ugpUL49Rqm5QUiiVX/PpnJ9ED26mRK4+kPmWPjxClCjl?=
 =?us-ascii?Q?76y5sh8O9vCLIkLfL7wqQH3jOv8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <051F233625143B4C99B975D25D81F9FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iHObKh6qwJXyoZi207KWwp8It07p9DAdOrOwttBUlby6/RhAAZgJ78iEV6uy?=
 =?us-ascii?Q?pX6WA5g5afOaLcwaWGJA16BUEHAM1bo6SBNWT2zbWgv5qNGunHqy7thwAldC?=
 =?us-ascii?Q?t02rhvRgFYu7Yi+OhoCQJMCnv8HBAhkgqDTlfGDBsInBTbmJLl5fdmlCXC6o?=
 =?us-ascii?Q?HDLTtZSu1cLg6xBVxkXShMigCIj3VginWazAIfdfyoGEwg2PxfVk9oVqk7Mk?=
 =?us-ascii?Q?SnW3AxA7YmOn34V6EafmdCteL8AEV74cp6YSLObGH9QTioA2r7R9kzqWpFzq?=
 =?us-ascii?Q?VUEz9QiM6WtrGrpfcIZrSCN+2cGjhqHhX9wVoNAF4nXByYbIHiyfHDQGG3QX?=
 =?us-ascii?Q?AFLnjKwIxzEdhbaX+MNm6PudsAQ48bSbwUveGgu4BusdMYLlRtkZ70A2UaeC?=
 =?us-ascii?Q?qtexSwW/fbXbH+q//VyfTCK+AHFpHqGZTHvoa1W4atJs0n7J+/snDCMkEsYW?=
 =?us-ascii?Q?83PD1+nXcdciHlHtvqjc4OqdFNL4BxV6ePCGTzLw6tkH8XsRHSW97VkOn71l?=
 =?us-ascii?Q?qoRUFso5GLyAm/8cEDyImvjGqnjbaFUWt6XQSXhvkPzmr4D6pNi6/qz+9oge?=
 =?us-ascii?Q?cBG6lsqk9DEbQ87q0G0yi/clZlynold4pUXKIyXLZC/5ymgW/y4sWK/kA+ox?=
 =?us-ascii?Q?ObAZX8gGmKh7hWtM7ssh6GaQfmK1oh9ATrWJxE7ViRB6nkHgonlrZ0E13/yA?=
 =?us-ascii?Q?fj+YFgVr4NpUdGO6vMjklQ4x3zlRQfypmO9W2DdNvuS4oax87tGdr0fZBzkN?=
 =?us-ascii?Q?5EAqx/1O7/S1D3y6di7R8DEPPCWSJw7Zvvs1hDwZollxIVfemSUh618BL8h+?=
 =?us-ascii?Q?EnH2qm4iZ6MxdLCZhCpRpGQ0TZCkrep1HWnP4acWut/X+nw0x8BZtG6OqGkz?=
 =?us-ascii?Q?N7Jb0r1YV81gpwSb8sF0VpPIsef6y47ZC1SaIDtkQplHLy68uGR0h+aIhRLz?=
 =?us-ascii?Q?KWXnbu/nMIAYUhFBpnGqR0wqiU2ACRUgU10Af2yzz4afOFU93Spds2mNvqXh?=
 =?us-ascii?Q?ELTc1hyfkop78EWbn89MaainDlPXy+2KP3Ljgh8OH1h0eK5OeEbyqAACHpLB?=
 =?us-ascii?Q?xBdCCmRZbR7Foc+rVXC5RFvDkvONBJJxHkR5DC7w/9LNSRDEZIjKKIMJHgzM?=
 =?us-ascii?Q?Hm9NEfhfDUKvzvQasQ254CVhQnzxqmYmLFyaxUETCZAVG/efPBb8+f0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af34c5dc-2ec9-454d-22c0-08db7bfa3807
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 19:18:01.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTUQh2YdOEGGrZYbwrVPg0bpJxm2aaqNIwCEiboHUhSPQgcisfUgGtOlld2TkUZAvn3VOfDu+fGPf2ELbqb92hNo3ogTFa3sUNKXIgGv6Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_14,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030175
X-Proofpoint-GUID: ahHpoSKQrEFTfIr5lrvVeH5RFz-7-BEF
X-Proofpoint-ORIG-GUID: ahHpoSKQrEFTfIr5lrvVeH5RFz-7-BEF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 30, 2023, at 6:43 PM, Liam Howlett <liam.howlett@oracle.com> wrote=
:
>=20
> * Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
>> Run as ./proc_filter -f to run new filter code. Run without "-f" to run
>> usual proc connector code without the new filtering code.
>>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> tools/testing/selftests/Makefile | 1 +
>> tools/testing/selftests/connector/Makefile | 6 +
>> .../testing/selftests/connector/proc_filter.c | 308 ++++++++++++++++++
>> 3 files changed, 315 insertions(+)
>> create mode 100644 tools/testing/selftests/connector/Makefile
>> create mode 100644 tools/testing/selftests/connector/proc_filter.c
>>=20
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/=
Makefile
>> index 90a62cf75008..7c9673951f9a 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -7,6 +7,7 @@ TARGETS +=3D breakpoints
>> TARGETS +=3D capabilities
>> TARGETS +=3D cgroup
>> TARGETS +=3D clone3
>> +TARGETS +=3D connector
>> TARGETS +=3D core
>> TARGETS +=3D cpufreq
>> TARGETS +=3D cpu-hotplug
>> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/=
selftests/connector/Makefile
>> new file mode 100644
>> index 000000000000..21c9f3a973a0
>> --- /dev/null
>> +++ b/tools/testing/selftests/connector/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +CFLAGS +=3D -Wall
>> +
>> +TEST_GEN_PROGS =3D proc_filter
>> +
>> +include ../lib.mk
>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/tes=
ting/selftests/connector/proc_filter.c
>> new file mode 100644
>> index 000000000000..99a382ea2544
>> --- /dev/null
>> +++ b/tools/testing/selftests/connector/proc_filter.c
>> @@ -0,0 +1,308 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <sys/types.h>
>> +#include <sys/epoll.h>
>> +#include <sys/socket.h>
>> +#include <linux/netlink.h>
>> +#include <linux/connector.h>
>> +#include <linux/cn_proc.h>
>> +
>> +#include <stddef.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <strings.h>
>> +#include <errno.h>
>> +#include <signal.h>
>> +#include <string.h>
>> +
>> +#include "../kselftest.h"
>> +
>> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg=
) + \
>> +			 sizeof(struct proc_input))
>> +#define NL_MESSAGE_SIZE_NF (sizeof(struct nlmsghdr) + sizeof(struct cn_=
msg) + \
>> +			 sizeof(int))
>> +
>> +#define MAX_EVENTS 1
>> +
>> +volatile static int interrupted;
>> +static int nl_sock, ret_errno, tcount;
>> +static struct epoll_event evn;
>> +
>> +static int filter;
>> +
>> +#ifdef ENABLE_PRINTS
>> +#define Printf printf
>> +#else
>> +#define Printf ksft_print_msg
>> +#endif
>> +
>> +int send_message(void *pinp)
>> +{
>> +	char buff[NL_MESSAGE_SIZE];
>> +	struct nlmsghdr *hdr;
>> +	struct cn_msg *msg;
>> +
>> +	hdr =3D (struct nlmsghdr *)buff;
>> +	if (filter)
>> +		hdr->nlmsg_len =3D NL_MESSAGE_SIZE;
>> +	else
>> +		hdr->nlmsg_len =3D NL_MESSAGE_SIZE_NF;
>> +	hdr->nlmsg_type =3D NLMSG_DONE;
>> +	hdr->nlmsg_flags =3D 0;
>> +	hdr->nlmsg_seq =3D 0;
>> +	hdr->nlmsg_pid =3D getpid();
>> +
>> +	msg =3D (struct cn_msg *)NLMSG_DATA(hdr);
>> +	msg->id.idx =3D CN_IDX_PROC;
>> +	msg->id.val =3D CN_VAL_PROC;
>> +	msg->seq =3D 0;
>> +	msg->ack =3D 0;
>> +	msg->flags =3D 0;
>> +
>> +	if (filter) {
>> +		msg->len =3D sizeof(struct proc_input);
>> +		((struct proc_input *)msg->data)->mcast_op =3D ((struct proc_input *)=
pinp)->mcast_op;
>> +		((struct proc_input *)msg->data)->event_type =3D ((struct proc_input =
*)pinp)->event_type;
>=20
> These lines exceed 80 characters.

Will fix it.

>=20
>> +	} else {
>> +		msg->len =3D sizeof(int);
>> +		*(int *)msg->data =3D *(enum proc_cn_mcast_op *)pinp;
>> +	}
>> +
>> +	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) =3D=3D -1) {
>> +		ret_errno =3D errno;
>> +		perror("send failed");
>> +		return -3;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int register_proc_netlink(int *efd, void *input)
>> +{
>> +	struct sockaddr_nl sa_nl;
>> +	int err =3D 0, epoll_fd;
>> +
>> +	nl_sock =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
>> +
>> +	if (nl_sock =3D=3D -1) {
>> +		ret_errno =3D errno;
>> +		perror("socket failed");
>> +		return -1;
>> +	}
>> +
>> +	bzero(&sa_nl, sizeof(sa_nl));
>> +	sa_nl.nl_family =3D AF_NETLINK;
>> +	sa_nl.nl_groups =3D CN_IDX_PROC;
>> +	sa_nl.nl_pid =3D getpid();
>> +
>> +	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) =3D=3D -1)=
 {
>> +		ret_errno =3D errno;
>> +		perror("bind failed");
>> +		return -2;
>> +	}
>> +
>> +	epoll_fd =3D epoll_create1(EPOLL_CLOEXEC);
>> +	if (epoll_fd < 0) {
>> +		ret_errno =3D errno;
>> +		perror("epoll_create1 failed");
>> +		return -2;
>> +	}
>> +
>> +	err =3D send_message(input);
>> +
>> +	if (err < 0)
>> +		return err;
>> +
>> +	evn.events =3D EPOLLIN;
>> +	evn.data.fd =3D nl_sock;
>> +	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, nl_sock, &evn) < 0) {
>> +		ret_errno =3D errno;
>> +		perror("epoll_ctl failed");
>> +		return -3;
>> +	}
>> +	*efd =3D epoll_fd;
>> +	return 0;
>> +}
>> +
>> +static void sigint(int sig)
>> +{
>> +	interrupted =3D 1;
>> +}
>> +
>> +int handle_packet(char *buff, int fd, struct proc_event *event)
>> +{
>> +	struct nlmsghdr *hdr;
>> +
>> +	hdr =3D (struct nlmsghdr *)buff;
>> +
>> +	if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
>> +		perror("NLMSG_ERROR error\n");
>> +		return -3;
>> +	} else if (hdr->nlmsg_type =3D=3D NLMSG_DONE) {
>> +		event =3D (struct proc_event *)
>> +			((struct cn_msg *)NLMSG_DATA(hdr))->data;
>> +		tcount++;
>> +		switch (event->what) {
>> +		case PROC_EVENT_EXIT:
>> +			Printf("Exit process %d (tgid %d) with code %d, signal %d\n",
>> +			 event->event_data.exit.process_pid,
>> +			 event->event_data.exit.process_tgid,
>> +			 event->event_data.exit.exit_code,
>> +			 event->event_data.exit.exit_signal);
>> +			break;
>> +		case PROC_EVENT_FORK:
>> +			Printf("Fork process %d (tgid %d), parent %d (tgid %d)\n",
>> +			 event->event_data.fork.child_pid,
>> +			 event->event_data.fork.child_tgid,
>> +			 event->event_data.fork.parent_pid,
>> +			 event->event_data.fork.parent_tgid);
>> +			break;
>> +		case PROC_EVENT_EXEC:
>> +			Printf("Exec process %d (tgid %d)\n",
>> +			 event->event_data.exec.process_pid,
>> +			 event->event_data.exec.process_tgid);
>> +			break;
>> +		case PROC_EVENT_UID:
>> +			Printf("UID process %d (tgid %d) uid %d euid %d\n",
>> +			 event->event_data.id.process_pid,
>> +			 event->event_data.id.process_tgid,
>> +			 event->event_data.id.r.ruid,
>> +			 event->event_data.id.e.euid);
>> +			break;
>> +		case PROC_EVENT_GID:
>> +			Printf("GID process %d (tgid %d) gid %d egid %d\n",
>> +			 event->event_data.id.process_pid,
>> +			 event->event_data.id.process_tgid,
>> +			 event->event_data.id.r.rgid,
>> +			 event->event_data.id.e.egid);
>> +			break;
>> +		case PROC_EVENT_SID:
>> +			Printf("SID process %d (tgid %d)\n",
>> +			 event->event_data.sid.process_pid,
>> +			 event->event_data.sid.process_tgid);
>> +			break;
>> +		case PROC_EVENT_PTRACE:
>> +			Printf("Ptrace process %d (tgid %d), Tracer %d (tgid %d)\n",
>> +			 event->event_data.ptrace.process_pid,
>> +			 event->event_data.ptrace.process_tgid,
>> +			 event->event_data.ptrace.tracer_pid,
>> +			 event->event_data.ptrace.tracer_tgid);
>> +			break;
>> +		case PROC_EVENT_COMM:
>> +			Printf("Comm process %d (tgid %d) comm %s\n",
>> +			 event->event_data.comm.process_pid,
>> +			 event->event_data.comm.process_tgid,
>> +			 event->event_data.comm.comm);
>> +			break;
>> +		case PROC_EVENT_COREDUMP:
>> +			Printf("Coredump process %d (tgid %d) parent %d, (tgid %d)\n",
>> +			 event->event_data.coredump.process_pid,
>> +			 event->event_data.coredump.process_tgid,
>> +			 event->event_data.coredump.parent_pid,
>> +			 event->event_data.coredump.parent_tgid);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +int handle_events(int epoll_fd, struct proc_event *pev)
>> +{
>> +	char buff[CONNECTOR_MAX_MSG_SIZE];
>> +	struct epoll_event ev[MAX_EVENTS];
>> +	int i, event_count =3D 0, err =3D 0;
>> +
>> +	event_count =3D epoll_wait(epoll_fd, ev, MAX_EVENTS, -1);
>> +	if (event_count < 0) {
>> +		ret_errno =3D errno;
>> +		if (ret_errno !=3D EINTR)
>> +			perror("epoll_wait failed");
>> +		return -3;
>> +	}
>> +	for (i =3D 0; i < event_count; i++) {
>> +		if (!(ev[i].events & EPOLLIN))
>> +			continue;
>> +		if (recv(ev[i].data.fd, buff, sizeof(buff), 0) =3D=3D -1) {
>> +			ret_errno =3D errno;
>> +			perror("recv failed");
>> +			return -3;
>> +		}
>> +		err =3D handle_packet(buff, ev[i].data.fd, pev);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int epoll_fd, err;
>> +	struct proc_event proc_ev;
>> +	struct proc_input input;
>> +
>> +	signal(SIGINT, sigint);
>> +
>> +	if (argc > 2) {
>> +		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>> +		exit(1);
>> +	}
>> +
>> +	if (argc =3D=3D 2) {
>> +		if (strcmp(argv[1], "-f") =3D=3D 0) {
>> +			filter =3D 1;
>> +		} else {
>> +			printf("Valid option : -f (for filter feature)\n");
>> +			exit(1);
>> +		}
>> +	}
>> +
>> +	if (filter) {
>> +		input.event_type =3D PROC_EVENT_NONZERO_EXIT;
>> +		input.mcast_op =3D PROC_CN_MCAST_LISTEN;
>> +		err =3D register_proc_netlink(&epoll_fd, (void*)&input);
>> +	} else {
>> +		enum proc_cn_mcast_op op =3D PROC_CN_MCAST_LISTEN;
>> +		err =3D register_proc_netlink(&epoll_fd, (void*)&op);
>> +	}
>> +
>> +	if (err < 0) {
>=20
> -2 is ENOENT, -3 is ESRCH (no such process), so I think you won't have
> collisions with the send_message() returns. Ah, but this is test code
> so it's probably fine.

Yes, these are just internal error codes to this program..

>=20
>> +		if (err =3D=3D -2)
>> +			close(nl_sock);
>> +		if (err =3D=3D -3) {
>> +			close(nl_sock);
>> +			close(epoll_fd);
>> +		}
>> +		exit(1);
>> +	}
>> +
>> +	while (!interrupted) {
>> +		err =3D handle_events(epoll_fd, &proc_ev);
>> +		if (err < 0) {
>> +			if (ret_errno =3D=3D EINTR)
>> +				continue;
>> +			if (err =3D=3D -2)
>> +				close(nl_sock);
>> +			if (err =3D=3D -3) {
>> +				close(nl_sock);
>> +				close(epoll_fd);
>> +			}
>> +			exit(1);
>> +		}
>> +	}
>> +
>> +	if (filter) {
>> +		input.mcast_op =3D PROC_CN_MCAST_IGNORE;
>> +		send_message((void*)&input);
>> +	} else {
>> +		enum proc_cn_mcast_op op =3D PROC_CN_MCAST_IGNORE;
>> +		send_message((void*)&op);
>> +	}
>> +
>> +	close(epoll_fd);
>> +	close(nl_sock);
>> +
>> +	printf("Done total count: %d\n", tcount);
>> +	exit(0);
>> +}
>> --=20
>> 2.41.0

