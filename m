Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B375EE3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiI1R6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiI1R6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:58:05 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02133FAC74
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664387881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ejvLsyvRYRIo5ioxGxyXks6c8OqpjnQIINwBtHWAVFQ=;
  b=D7XjZQ+lXa0k2BEJO0iRxA/aSrY+K3W1YTgvfELmS0y1TwMiOx7V5VUC
   bYd5/54mzo3rdHGvCk9qoTNem2nwa381oryQhP2laRGQFkMsIlrp/Ishu
   z8QGcsoQHj5LLRXt+rv/2svSAhWbqZ4fuLLlCmlElzzpnqFB7wFczFqpa
   g=;
X-IronPort-RemoteIP: 104.47.74.45
X-IronPort-MID: 81566237
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: =?us-ascii?q?A9a23=3Ajmb0YKtwFERGrQLXTrv4JLHmN+fnOphVZm2k7?=
 =?us-ascii?q?MifNrXfj2XJXxPLv9mXE6OXqo9YNnHyIzUAFRkCmn587YojKkVBHWmiaCJCk?=
 =?us-ascii?q?S3VH/9Nb/EQheh5y9LbMyGwkGch65aWxEEUbM05HDoTjyGStbqqY5BEphD54?=
 =?us-ascii?q?dnoK8gppbYnmBo7x/GsmoR/MiGTfxB8D8G+imKubXw0lx0uszFnUgvWn0QJ9?=
 =?us-ascii?q?vFPnbWsYM/deUcb54crSqLVvX5/8HhU33QYqaBYLGhu5nh3oYi6wZ38fm5r3?=
 =?us-ascii?q?RBoyalupSxDxXBZcBSeWQgMeek0KB9xRHInvi1nzZ/Bgt04TQbJN6VfyvEQd?=
 =?us-ascii?q?R605SK+KWlPa2DyFrNY2htoTQaSNizTZuirIt7ZHieSBMWXBA/XUh/6jZbRk?=
 =?us-ascii?q?gbtz5JWxwz1HFmUriNsKQMk0YjZIoFHx8+rUc51vduB7DzXX6sGnHpVemyDU?=
 =?us-ascii?q?pogOIwN5caG2c7qRe2J5O99B4+u7wiZGXm3431iRAB6PcRZVVDCgeBUA0JqL?=
 =?us-ascii?q?4T65t9VFUQFSq7FI1A7rfDFKx7Qg1re8TYnfTiTvgjEhDOFoDrcJ55Bcjydz?=
 =?us-ascii?q?pdYY0S8VhofU2e7QzFsduvMueO5EwucXYMXchj88yk2+qPPrxnREKtYDtzBM?=
 =?us-ascii?q?m1o7rCa24z/vSOiu5CGixbodI0Lops3Gm4eDkeRkIuzZd5oeehVMdG9OWUOg?=
 =?us-ascii?q?0GU8Y3bKPlL0JjBCZoIKCub2Jo2Ec4ay49VmPMgNRkc/uuQZPIztMOYGooWH?=
 =?us-ascii?q?lKABh4CmkiXr9yKAvIQfsTWJ3GC5WI974WO7kYfVSNwcltEXBgI6R+9z7h3K?=
 =?us-ascii?q?a8VwtJqHIxMha6TBh3zR0EpsAYYsoN1DVdXMGK0rke0ONbOtTPSLDfGuAvt2?=
 =?us-ascii?q?8ZvU/ASBl46+gawM0KlRcKZbu8p0RXvVrL5zLHTRBVYLIqn8wzOV5UwlwAgU?=
 =?us-ascii?q?xUZlfP960MyoHz11PLosFtCJRqyXhVuf+mn7s0tmNB90to9gtwQp/Oj+ly6r?=
 =?us-ascii?q?mBfHn3YzJpYtHKWlhg5EpOgInyMtl9rFgFFZiKBv2+kHDM18QgQWufPqDYQr?=
 =?us-ascii?q?KAGw4HzBhZUfNfCf9v8z98EVLUCmlyDhwYkmB5vuxfAL6rArOpPVKtbNmt4A?=
 =?us-ascii?q?xMoXYXokp1a0G318qrlKL8jz3fvPXlaIUxURqrdYs4QGaJPyWFgcga4BYB5Q?=
 =?us-ascii?q?tCBayZbJsnphXRY8VqCJDo/gD1+oLSBgyq5r0CPRlJE6gRpQKPBfV+kLUrjg?=
 =?us-ascii?q?xjhLwiSK8/a6/VHr0P9RsuZTV+7eUKwS7Iq8fqNcsa3NmFKdZRqUP+NIWPhW?=
 =?us-ascii?q?V+EeAE8in/G5TLeSeE/byD1uPM2KVF8i4chArwZsxn61KHKboxypKQ54Vztd?=
 =?us-ascii?q?pBVZuDLOE+RP1A76x4sTC8Lj1De7bydRJkP3o6IOXK1a9c3A0qn83YEo6oiJ?=
 =?us-ascii?q?VDzvJucKKHSdIkfQftYFiHRdab0Bw6oHdpxdcnZt8QrUyNiAjdGVz1z965y6?=
 =?us-ascii?q?j/F2RGOb7CNtu34zEAP10iSDqxPh0fkJhJouHbpYUl5Re4itMst+ltovITDu?=
 =?us-ascii?q?TkEZMd0FaS7GhoMMyTrtNdjEGuCzImziDJViG83U7Nloh+SKOAjYyzitkeN3?=
 =?us-ascii?q?gXA32evoYjILzUoKBT4Aoo33JYAac4yTMdHp7/Xe72Zi35dH9/v3dqbVAT/e?=
 =?us-ascii?q?uywOPwmQl9YhNe/RQubtYwEWVedcIB9GtczYEfVF9PwbfawMeT/nTH2t0oav?=
 =?us-ascii?q?sQA1K2vkxokFuK59rZvkpZ7BRzmd8x9nzu+dr47fv2emIQvnZE/79gUBvuk6?=
 =?us-ascii?q?HV8NphkkcAuyskWC7VcUmyIvtadHI9v/zZ2NKI67lFHCOUe006cXjkHZUPn9?=
 =?us-ascii?q?vYbCFtw4PSco9BDBL7gUOlf9s7rN+oRC6IYnfoP9qJ1L7C7XCLGVrk3arx/g?=
 =?us-ascii?q?B+PmsAhHqnvHC3l0hSjKJpmnsnThfMJrslmyMFXg68R3jdztnmF9leqgSjLx?=
 =?us-ascii?q?E1368h/ju1QDdh9SbYeZLVtR4vuc6XJ5Z54BsNql2RCK4TdTNrlFbqeBIJ7X?=
 =?us-ascii?q?1kUoEcpXnllsqNjEaoiqH1y8gOD5jZR/TZrQICMKW38ZRYKaBMCnp4yXnjve?=
 =?us-ascii?q?Hb6PhtJEshWQRe4MQ8odkeF5k9YBrZgsUhlTsPpvpxCCKyOOWbofCpA+PwDs?=
 =?us-ascii?q?nNlGQP0H3llGfIaL7apyO2waZk9Ci5dNvI4WbME+8R5hG7BY1+aV5prsJ2PX?=
 =?us-ascii?q?AfDg2PHH3BIgQ2VI6jr+NMXQwkQTUFMteYSYIeRC6M11IpB/NARrrYkJESJP?=
 =?us-ascii?q?KzdqYVkpkrBIoq0y3RqYjieIAoejdJ/1/ZAhFIvtqK7s1yYRvEUUOzPDSERF?=
 =?us-ascii?q?7j45LmWHuYrpOGx0YXPkKyBAO/w3Nun49YQ0RfpI82Ni7BTBsJNn0IM+E3dA?=
 =?us-ascii?q?oipMgsHX4DibnZHNP7Of1UM9KLf63zAuf5ZaQRBgsrV/SlEHLRXS2zOqjq/T?=
 =?us-ascii?q?b4cpZIQWRpMlxI9hMJT0FoLNoSos8qh/KYCwCMqjXE+8MUkT05zW1tPIQHUE?=
 =?us-ascii?q?9vbnTXrVzmIKlf+r1Y7dAOwgYeG8OvOgqVEKeOUaxt4IwItk1nBvncgB7vZX?=
 =?us-ascii?q?/sndH9iSHOXCpARD2fNG67ZxZj4mOwzQDAW2MWwEwCPKzDwD1IH+t1NLoSF8?=
 =?us-ascii?q?kResd59BrLaZ3OzkXWVFREpy8hN0MZUcZ2/3GIeA71MckkXU/wWX4X5x9n9j?=
 =?us-ascii?q?7d5EkpxL2h69w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.93,352,1654574400"; 
   d="scan'208";a="81566237"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 13:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2RRWXinqiXUZn0c7uo7G9ucLP+kSPZy6jC/ySj5mQfa5tlD3Ta1ArW6uKhJQ3qsfaGe7mk+RnVlPiwYIX682VIKFuXWbYRAqnlPVcZUE+aV305wn3frWFc4HKh6VdFIi/DgiB3JCvGNbV5V4O0RyA47+7q9p4GzPy50ZDSBqCu5IdSXkzDCeC4rHC+FgyUachmIf6HBCp8oLiSZyfkDfsbcJ8PHg4PS3dTYlEFkkaOmPtCUnlo9sgZiVugEK6qe+OiobwHgIqX0ixcCmLM9h1nDMahk+u3Sa4PsFOea/13wVMIlfUDksw84qnHcRki48OuvtmBKnX51XmnEEZr0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejvLsyvRYRIo5ioxGxyXks6c8OqpjnQIINwBtHWAVFQ=;
 b=LFcjAOCq4KIZADRl+IwewG0hU69e4XmvGW0qP+IUiQnstlz7qBsnawLLHacW1TL7YDp83mPBR94lDagVQqW4Q5tmU+inMYllciZXR547/VbAPoEwnD3hiJoEwD+2TE9+9gBePr8IxRFH6AcL9BqsVevWlKilvbPYwZOcUcERfb5Sof1wVYhdJ1LYKM+uItMXhRB5FvV3zzejamMogQEd4MbibyUoAS9K8Y+HEi1JgPF9GweMrNJKa6Z9upm0Apc2gvpdkKfxw3gYlhDRyTfHeuwEAl5GNojOestk4Wpu3WuYAu1fIGKK+mJHSpbTAIXUFWJS0La5Nr3F9uLN7/YDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejvLsyvRYRIo5ioxGxyXks6c8OqpjnQIINwBtHWAVFQ=;
 b=RvPfVaVYqrnDDP3RvFchT2B+Y5vimjC1mVGTWZjDYP0/VZWoRP2flrOfAu3viP7kYrj4QGgdwY0RWXn7XQ9Ttu3b7jefdZdvbJSLSNQAXbDxOTC1CKMvhWqMGEr+g9iTJ1agKLdqwX+X9JUrtTJouMuyxMKBfOm0UmOrYq6agJ4=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6674.namprd03.prod.outlook.com (2603:10b6:a03:396::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 28 Sep
 2022 17:57:58 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::56c6:613e:cc95:d028]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::56c6:613e:cc95:d028%6]) with mapi id 15.20.5654.027; Wed, 28 Sep 2022
 17:57:58 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        =?utf-8?B?TWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tp?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant
 diagnostics
Thread-Topic: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant
 diagnostics
Thread-Index: AQHYrQdIEd7TSMPUDUiF8IZ7oS1/Iq31VGgAgAAZN4A=
Date:   Wed, 28 Sep 2022 17:57:57 +0000
Message-ID: <a60333b9-6b42-4730-6509-cf1a0cd5cf84@citrix.com>
References: <20220810221909.12768-1-andrew.cooper3@citrix.com>
 <YzR1/nWoQtdRQ3Uv@zn.tnic>
In-Reply-To: <YzR1/nWoQtdRQ3Uv@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6674:EE_
x-ms-office365-filtering-correlation-id: fcb44b63-34c5-4024-d238-08daa17afa11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0Q6xvU/AsZToWXsr8EOIlKTZeGQ6vnKnjROpk8APAt6vIqelWkr6rP9J9+byU4axOgCUg0Laink5lh3XzqdKGrc8St43xmjSrUSsdtOY6PSSVrEjKACTYReGzD9UXhHNHFir1MUcDvLzAsQieYmIIQSlXqpLS91s+FPGkcnzsArZJ+O2z59suL7vI8QKhEHA+PvYulmsPRQcHjdGmzJsjvl2HTP8LorAwdYV4+OI3uU5jfh/ZZqm5HEvaIa2fCloknyPMCLHnb3Th6/AWSTbLSYFA8DX0hsgMYX8de0cNRnZi5KzkAEaDRG1T4wkGrJ3008U4LBy0O4twQY7r1IFvobWQH/dknnChyYRInp8Bm7kBH3Z30oa6NzROLPVZvuDzLsq/jT2Qg/TD6E44TcAJ+0+oED02oD+Zo+FhkYfy4cGYeoXznlS9nLZ8GrGZuMEbAHjqeTrj71SIbYNiTYLbIUMJqRC93cbMuo1Z9x7OsnrbVlnZhYloAxvQNohqdTej6SWKnhnh09/4f/Tf9jAoss8zoGKDebYpt2SqGTldxFJmoRjjz6qELbLyjmHR31Z5sNaMD6oXb5Qd8xwNEslq6QmxF6LTO2bGR+wazXzW1Kh267CbHPbjBoOmIjHwy5N7PaEH6J4YBM4qT4IsjFMNJj3JnWFKHVH6uLlh5DlhBZlUMFI6La0lzFkHlC2VTJltJw3Nt3xdVGl/1gQLJPVl/mmUYyevFzNwUv58O3pX7VUPi4X2OTu1CLzAPJZaAhu+bjiDLkiJ2lB9vXMiYydUUv6/N5dUdV40FGjHmPGoFjERVHW+jlSo1L5IyCm/kg2zgIxcJlhrqBjRD4I/RUaTtHiZwmZrRjwQPXDX05U6Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(76116006)(6512007)(2906002)(86362001)(64756008)(66574015)(41300700001)(26005)(966005)(91956017)(4326008)(122000001)(36756003)(8936002)(38070700005)(6506007)(54906003)(38100700002)(6486002)(66476007)(82960400001)(6916009)(316002)(31696002)(5660300002)(66946007)(66446008)(478600001)(53546011)(66556008)(2616005)(71200400001)(186003)(66899015)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VndwQ1Q4eklOc2VjcW9qdUh6TVd4Wmw4U21zeFd2K2hkQjBkTDExRk1qaHhL?=
 =?utf-8?B?bzZQOU1jdHJHalN0YVdySnNSV2dkck1FQnh0ZFBVOXZGN1pWcVUzM04rT3Ju?=
 =?utf-8?B?Z2x2eUtmS2dUMGUvY2VRb3Q2cUlESmhpSEpIUGM1SndTL0pSeFpNWlNvd2FU?=
 =?utf-8?B?VzdIaXpSQlN3VGF5NDNmY2pLRTJFQW9FT29YTzJKM09ZRG9iVGpqL0F0Unhu?=
 =?utf-8?B?VnYwOGQ1Z092ODZHQ2RhL3Y4V0pEQnZya004ZUtKY05GQmYwRVlwc21VQXl3?=
 =?utf-8?B?SEhOV2l3d2ZleU03NCtnVy9OTHRJc3FXS2RHOVBhNUhiYmJYYWtrSHY3b09Z?=
 =?utf-8?B?ZWNKZ21lVEpHWDNod29Zc1Y1T2dnQlloNDJMUFRwRXoySjVGcmNSL0J5TWIr?=
 =?utf-8?B?TVFVRUlTeVc2eThJYllGdjA3bE4vajFieFhaUkZpYUFTd1dlMi82T3FyYm5w?=
 =?utf-8?B?S09VM21VaG1TdlU1WlBDRFQzSjBwdDF5Vmo2T1d4clBydlZzYXhvTW96NUhk?=
 =?utf-8?B?T2NpZ2JJU0VSbXZKbjhJL3llVVhEUXBVOFJncU9lOTJZcFFNTHJTb2ZuemQv?=
 =?utf-8?B?UTJOWHE5QkFYNk9PTnpvVDN1RTFobEJCQ2xsa1hTR2FBVjVvK0tFckNBb3Bz?=
 =?utf-8?B?dXVVclVzYmcvVU5NTUhPazdyQ3hmRWVpdnBUM1Q5V2RIdlYyYllCeGwzNW0w?=
 =?utf-8?B?eEFTbGxvVWZPMEFLVGdQMnlLRzJNVS9oTHp2WThlb0tXeHNZd21oczM5eDJW?=
 =?utf-8?B?MlMrMitXWXRtOEQveC9VQ2oxZWFXdkJ3ZWhjTXI5Q1VyYThiQ3NLclN5WFNu?=
 =?utf-8?B?UUVYUktnbkZqNkN1Z25UUWxPb2NsQkVCSmxRcE1LcEFDTTF6S0NsblMybm1m?=
 =?utf-8?B?ZXQzT2EwOEdpa2xwamtWL3ZGd3dpVzhLd2JISVFaR2EwdVE2aGFqQTkwR1FE?=
 =?utf-8?B?aHRZbFMvcllmeHZadXFwMDJiamFFOGMyTG1ISzczY3l0ajhDd1htSjhYUjhO?=
 =?utf-8?B?cHZRdWdvMlVjai9LUU0wSkpaUWlIS25Sb00vNWJ0M3ZFQ1pGUmUxUERNWXE0?=
 =?utf-8?B?UW5PTjFSdE1PZVdKeTdweHduV1FmbUttaVk4UndlSjVMQ2VwQUNUK09wZC84?=
 =?utf-8?B?cEtKYnBoMWFrTms4L3pyZ2twc2RNeit6c21oRWxNTnk1KzhRMEtGNFlSd1N2?=
 =?utf-8?B?cVU0Y2o3VGF6d0RPc3hwVE9POFRDUFlYY2o3ZnpsVkVMZkQzKzR1V05YbHAx?=
 =?utf-8?B?a3FxU2hCcklKaTBWK0FVMWp0TnlZVmZhcFIzaUhiVUh3N3l6Si9zMDVhS0dV?=
 =?utf-8?B?ZDhTMVFMMFNjY3dTTTcrbXd3ZXNOUWNpQTJ4N29KZU1KaUlRajFZL3ZMdHND?=
 =?utf-8?B?eFcxYnRFZk9sazF4K1l5QjZkcE5NUVp2bmcyQWVIYThRVVFxNExzZEtjUXRM?=
 =?utf-8?B?N3Uwa3NvMm9zend0MXl5T05FSnI4UEt6UDJqMFpkTmJyLzV6eVpvKzVrRERn?=
 =?utf-8?B?T2gybk0vRWdHZ0FtMkRLOVdQSDFlSWZMZFA0blNoNWJQOFoxdmhBM1oxcDNv?=
 =?utf-8?B?Uy8yMVNGQlI4ZnBTbi94V3lRcyszZ1ZiVG44cGpYS0V0clZTaDdEVytCVW9Y?=
 =?utf-8?B?TkdMNURmRlhIRmJFTDRsNHI5U3lBWXVKd1ZUNVp3aXdLeWltOGpXbEdCK2dD?=
 =?utf-8?B?TWV2SFp6S0ZjU20xVEg1R0UzQ3h6emVRMjhzSlV0WWFHdnZNbnFoWm5OSStG?=
 =?utf-8?B?Vnhsbnk2VDZVSjVMTEJ0WThieUFCYTJWYXZIcUJZYkcxMllWOGF0YmNmdzhm?=
 =?utf-8?B?czA1YU9uV3h2c2Z3WG13NlprSzBWRHdIZ2tCcW5uT1BxTDRzYnJUMGhkSXd5?=
 =?utf-8?B?SUx4N0VaSllLYTR2YWJYTGlLbHBxTndvYWsrVHljanNrOGNWZExCdktZQ1BB?=
 =?utf-8?B?QzhkVmtVOXpjTDcwU0hoVmhtbDNXNEVpUlNMVkdMdlJieDlRVTFLd0NpSlND?=
 =?utf-8?B?Q1J1dm4wL3o1YVBzRFVkUTNsTGtFODN5MXk0c3NzQWQraWJONU9WSFlIb0hi?=
 =?utf-8?B?U2JRdXoyUkNydWFpNWl2SlV3NDREL1l5SnpRNmZ2cDNHb1VtSVNHQ0p6TTFl?=
 =?utf-8?Q?Zge9EbT6qXELg07qj9jSpDbZy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <760A317299B19946B6F3AB9F9D21D45A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb44b63-34c5-4024-d238-08daa17afa11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:57:57.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pahYWfKgLIvTSj5UVOOfZUjOyUrco2MGZc5daR/6zYlt5kXX+aKAR7bYW3SKGH77FZhuwwe3W9GR+A6d9LiqGeE/vfhvlxluWWlGGx7o9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6674
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMDkvMjAyMiAxNzoyNywgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBXZWQsIEF1
ZyAxMCwgMjAyMiBhdCAxMToxOTowOVBNICswMTAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0KPj4g
IlhTQVZFIGNvbnNpc3RlbmN5IHByb2JsZW0iIGhhcyBiZWVuIHJlcG9ydGVkIHVuZGVyIFhlbiwg
YnV0IHRoYXQncyB0aGUgZXh0ZW50DQo+PiBvZiBteSBkaXZpbmF0aW9uIHNraWxscy4NCj4+DQo+
PiBNb2RpZnkgWFNUQVRFX1dBUk5fT04oKSB0byBmb3JjZSB0aGUgY2FsbGVyIHRvIHByb3ZpZGUg
cmVsZXZhbnQgZGlhZ25vc3RpYw0KPj4gaW5mb3JtYXRpb24sIGFuZCBtb2RpZnkgZWFjaCBjYWxs
ZXIgc3VpdGFibHkuDQo+Pg0KPj4gRm9yIGNoZWNrX3hzdGF0ZV9hZ2FpbnN0X3N0cnVjdCgpLCB0
aGlzIHJlbW92ZXMgYSBkb3VibGUgV0FSTigpIHdoZXJlIG9uZSB3aWxsDQo+PiBkbyBwZXJmZWN0
bHkgZmluZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQ29vcGVyIDxhbmRyZXcuY29v
cGVyM0BjaXRyaXguY29tPg0KPj4gLS0tDQo+PiBDQzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+DQo+PiBDQzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+PiBD
QzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+PiBDQzogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4+IENDOiB4ODZAa2VybmVsLm9yZw0KPj4gQ0M6
IE1hcmVrIE1hcmN6eWtvd3NraS1Hw7NyZWNraSA8bWFybWFyZWtAaW52aXNpYmxldGhpbmdzbGFi
LmNvbT4NCj4+DQo+PiBSRkM6IENDIHN0YWJsZT8gIFRoaXMgaGFzIGJlZW4gd29ua3kgZGVidWdn
aW5nIGZvciA3IHllYXJzLg0KPj4NCj4+IEFwcGFyZW50bHkgInNpemUgODMyICE9IGtlcm5lbF9z
aXplIDAiIHNvIGxldCB0aGUgZGVidWdnaW5nIGNvbnRpbnVlLi4uDQo+IEkndmUgZ290IGEgc2lt
aWxhciBidWcgcmVwb3J0IGZyb20gcGVvcGxlIHJ1bm5pbmcgTGludXggZ3Vlc3Qgb24gc29tZQ0K
PiBvdGhlciBwcm9wLiBIVi4gQW5kIEkgd2FudGVkIHRvIGdpdmUgdGhlbSBhIGRlYnVnZ2luZyBw
YXRjaCB3aGljaCBkdW1wcw0KPiAqYWxsKiB0aGUgcmVsZXZhbnQgZGF0YSBhbG9uZyB0aGUgcGF0
aCBvZiBwYXJhbm9pZF94c3RhdGVfc2l6ZV92YWxpZCgpLA0KPiB0aGUgbG9vcCBpbiB0aGVyZSBh
bmQgeHN0YXRlX2NhbGN1bGF0ZV9zaXplKCkuDQo+DQo+IExvb2tpbmcgaG93IHlvdSBtaWdodCBu
ZWVkIHNvbWV0aGluZyBsaWtlIHRoYXQgdG9vLCBob3cgYWJvdXQgeW91IGV4dGVuZA0KPiB5b3Vy
IHBhdGNoIHRvIGRvIHRoYXQgYW5kIGhhdmUgaXQgYmVpbmcgdG9nZ2xlZCBvbiBieSBhIHhzdGF0
ZT1kZWJ1Zw0KPiBjbWRsaW5lPw0KPg0KPiBJdCBmZWVscyBsaWtlIHRoaXMgd291bGQgYmUgYSB1
c2VmdWwgdGhpbmcgdG8gaGF2ZSB3aXRoIHRoZSBnYXppbGxpb24gb2YNCj4gWFNUQVRFIGZlYXR1
cmVzIGFuZCBkeW5hbWljIGJ1ZmZlciBhbGxvY2F0aW9uLi4uDQoNClNvIHdlJ3ZlIGFjdHVhbGx5
IGZvdW5kIGFuZCBmaXhlZCB0aGUgaXNzdWUsIGJ1dCBYU0FWRSBhbmQgdGhlcmVmb3JlDQphdXRv
bWF0aWNhbGx5IGduYXJseS4NCg0KaHR0cHM6Ly94ZW5iaXRzLnhlbi5vcmcvZ2l0d2ViLz9wPXhl
bi5naXQ7YT1jb21taXRkaWZmO2g9YzNiZDBiODNlYTViN2MwZGE2NTQyNjg3NDM2MDQyZWVlYTFl
NzkwOQ0KDQpUaGVyZSBpcyBubyByZWFsIGhhcmR3YXJlIHdpdGggWFNBVkVDIGJ1dCBub3QgWFNB
VkVTOyB0aGUgc3BlYyBkb2VzIHRyeQ0KdG8gZGlzdGluZ3Vpc2ggdGhlIHR3bywgYW5kIGl0J3Mg
dXNlZnVsIGZvciB2aXJ0IHRvIG9mZmVyIFhTQVZFQyB3aXRob3V0DQpYU0FWRVMuDQoNCkNQVUlE
LjB4ZFsxXS5lYnggaXMgc3BlYydkIGFzIHRoZSB0b3RhbCBzaXplIGZvciBYU0FWRVMgb2YgYWxs
IGN1cnJlbnQNClhDUjB8WFNTIHN0YXRlcy7CoCBUaGlzIGlzIGtub3duIGRvZGd5IGFscmVhZHkg
Zm9yIG5hdGl2ZSwgYXMgaXQgbGVha3MNCnRoZSBjdXJyZW50IE1TUl9YU1Mgc2V0dGluZyBpbnRv
IHVzZXJzcGFjZS4NCg0KSSBoYWQgd3JpdHRlbiB0aGUgbG9naWMgb3JpZ2luYWxseSB0byBoaWRl
IHRoaXMgZHluYW1pYyBmaWVsZCBpZiBYU0FWRVMNCndhc24ndCBlbnVtZXJhdGVkLCBidXQgTGlu
dXggbm93IHVzZXMgaXQgaWYgWFNBVkVDIGlzIGVudW1lcmF0ZWQsIHRvDQpjcm9zcy1jaGVjayB3
aGF0IGl0IGNhbiBzZWUgZWxzZXdoZXJlIGluIHRoZSBDUFVJRCBzdGF0ZS4NCg0KSSdtIHByZXR0
eSBzdXJlIHRoaW5ncyB3aWxsIGJyZWFrIGFnYWluIHdoZW4gdGhlIGhvc3QgTVNSX1hTUyBiZWNv
bWVzDQpub24temVybywgYnV0IEkgaGF2ZSBubyBmcmVlIHRpbWUgdG8gc3BlbmQgb24gYW55IG9m
IHRoaXMgaW4gdGhlIGZpcnN0DQpwbGFjZS4NCg0KVWx0aW1hdGVseSwgdGhlIGlzc3VlIGhlcmUg
aXMgdGhhdCB0aGVyZSBpcyBhIHByaXZpbGVnZWQgc3RhdGUgbGVhaywgYW5kDQpMaW51eCBpcyBu
b3cgcmVseWluZyBvbiBpdCBmb3IgYSBzYW5pdHkgY2hlY2suDQoNCn5BbmRyZXcNCg==
