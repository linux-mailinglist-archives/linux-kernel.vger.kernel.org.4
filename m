Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A61702F71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjEOOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEOOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:19:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2073.outbound.protection.outlook.com [40.92.99.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31431BFD;
        Mon, 15 May 2023 07:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7zk/DWJdw0cIIWflhVT0yb9f0Bw8ULZYrUgezYa2WXTtVwfhBrluCrvfh0sjGW+uuR6fCuDyRmqUBeNjg5W+WcJxp7k8DNMeW7AQtZysy1lTTdxlU96mk/LG8JBHvE2adW1UElhMOGfbFlxwBKf5TDQpr/NRu+jxRifnlp1traUIuFBIibk6U5vng1FNFuZoigj1ip9h74C5NIy6bZL/E1CpJjekVpizx6AJZFxTvOEuYx8FEfqnobtB9iE1ps5XMrmkgePVX0NOsNdKGl2AZk+xpNWrGK+wywIzR3YoADYCIkY4fcIdwA7vqEOoDLYmLh8k/aalSwr7k60BfdfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjnAOZJr/eQjz1lc7UNr+LoRu45XnwkRAXAHhjF5c7g=;
 b=UCnIsyl1atdeW0ap5XfG5g8xpaCFDwJoAovgPcDBHq3quMV5IxjT2cFgPtTgigXkofSfN6uc3PC9+Vr4SAdF04HhGibqruhDbjcobp5K0CT9bTJag27+q9egzbSChVMybOhuACgUXiKCjiHHj4oceTci4rtu/H+pnyQnODbwhFYsTi2Vtltb13/GkPvM8FWF9f/gdbEbVM1wvjc04z/J9eOTp9Ge0OKBjgYNnkzpjCyx6Df4VK9SOVy7n1P3c/wOfnbkwh7Cv4GSjLJodkJxulk7Pc6sZ6ywJ4S0EBAe7Ww9FT/NJvRGjAca5YiO+TXjEfKQi1dh2O8TvjY+FOXLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjnAOZJr/eQjz1lc7UNr+LoRu45XnwkRAXAHhjF5c7g=;
 b=ZYU+vDQ8z2jtyvEN1Yeh9wWguLJNTDe3q/8tgysRNanKDlHZAkbo42q40fxYXCPfu13ao3CqywFqYjSqjbpDiC74RBWBTEI5RTDeIxFuIBIyfd6bgLBoB21o3phaIzwHywZZSW8u1LKLVxF+tnVFYp72NPIcvCJ2VHeYrGeDIvo7/4f9y2vnEqmEu84PI0rqrh4/FDS/qXCS9f5s9LG9Eo+cNeZEWrXOp6qNNtze9HBldrT4a3BT0xFZKW0ukovTdV1gyht72tuiwylmW8fBXYFrbK3t8mPDJvWaAMqSeAwmcregDsI3/oIzJG9Fb9rSPwLQpA/e/P+JLYB7LMeUzw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2201.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:172::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:19:46 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:19:46 +0000
Message-ID: <TY3P286MB2611F5969DC0F3F11FB8689B98789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 15 May 2023 22:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     wiagn233@outlook.com, Andre Przywara <andre.przywara@arm.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
In-Reply-To: <20230515105229.GI8963@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------s8Nz3WDKfb20Dl0A4Jn2OARY"
X-TMN:  [N7yjVjowWCoFQjtcs9n7wAKjXpdYgwun]
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <56e13335-b5ee-e3cd-3755-4f8f6ea20918@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8d6fa0-8cfe-4285-6672-08db554f6f7c
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT/OA0+UPAYL1ow5eioUeC8gm8LChimQtryxbIfQdQqBltHHCKirl70LTrgecZWJVdu5zmfFhQdd/+WsYcVTzVLSp75Ee07iq1AthXNacLLw/dJXtJgiObttELM9MhVAjVqFyLyirA2L7KAa1wQgyfOSHjO4aF4oOf8hAritmIkM/tQQ5IqTLfhLZQeNj4vUr7DZ3vbwVUCZwnO7TTVRum6dUxr1aBZIzj0mB2ssP3OK22b0fgkmY4o7VbSXyp2aSpxUVZpQKQskwh3LcZGXhBv0xJH5LxhNE3hlQrEVyn0DdgjgkITzIdaxB/ly1UAknd26su2R24G2V6dhy//VlrQhq+vYF1U5Rx70bAYBBfWOvVYqTxRvHUttLuz5didBiVXlOxcucj7AWF/KHZIig53A5g+AqB++fOCBRBD4RtFf4iBkvv6nihGxFpJfEWMEoJGkcsKLF5pyxaskq8NoSSFUpzxSc4LkVBgs3/2m/IvgxFOnCbxvidZh7t4Wpw2Fkfy23bOI4aZBARvYIoudc70gcofhvnSlww7jKY5glQpwf2OwnZ6okUviGQVFR+7iCI0iuVUQ7pIfVG9HvVDp08HHFwwWBRR7xlcuVGYBkiOAP/RczTPRbKotLDhTVhK2RE1EjZUtDcEC4rbtNBsr4BUu8KgrfYEgQ8NpDZ3fizvCwclt2ze5w3gb2UDglF/9qx/5XQwBrr4t859KyDjguG3BErXi+/Unefwvf6cZ6Z5ZblNg/UOUQWDZPGz3EgYkSoNZqiUsCzuehWMO4gzujcwMnwjn5QBj5w1G2iJw3U/aIhxy5B5mZvdl
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U11rsfj4sCycLwSBP9eWrjZGWg+Y2X4NCBBrxsmsr76N1Jh5DTf/H063z2OMOg+v0K2OSSR3SP5h0p9VAlP/Ee/IhmN/wVJ1KvUxMFVdwO08J1UOHuMA/FPiM9cZ7vhHA0hIlvvh7k7Spt6C+etFP1YYJFvjx5Siy36lUC3+BTfpMD84EPTG/kqD3QMkOK9IzEZFsKnv+fS51icN3dvQWlGPcPA+LuaGXFW3fMw3ixg2JYRNdynaUe8i93Fi+EH0LLTXw053GibGeBYUkL+BtdB8FujRyNZ1HVE7vY4OGQYrtHUyg/+q4GbPBNYYRBjst2vOMA2Y0KRvpCyyHxhycLa3Jjx76ecQm105VFKrJlLxKUQcjAFA7H7Y31JH/fGhSJEWIuJhXH0SfYZWiQCHiOZ3+p9MSFe3kL3fPuP+jPPvZPyIboZOl/GYk1oN0vGBGzrxMEPc6wLk1tY/fxWHX3D9k+8NfDiivHEiVIGQ9m7c3t6/N1mIRk6xty1LBRxtilJ3RQdWUarmTv6uJnJONZ9HaJY/HX0S7hzhrZmm1AxD7imqP1fmr8Ln04rvfdpvpLnfQbX9S8fuJrm4qkit2cICEZTPClO4S1H17sVU3wBTJ2B5SaYd/FzNX6TuFgv44vNqzcE43ByVolC0oeoS4/Uw9x1XDBvdCt/fzAjzWU+ijx52qIkeRzm8OfXDrQwi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2tDa3NyNmRWSTczYk83MVZ6aFBiZzdTMUNUc1pCZ05sUUtqNjBsbEVwcTJo?=
 =?utf-8?B?aWtySnU5aldQM21xVUlFWXhTOEZuaE1rT0JzRi9RSXZ1SFVXVGRaRE9wc3lD?=
 =?utf-8?B?WEpNckpVa3ZPNHJYRERzMTF1TEowOWtHclhSdW5rQ3p6d1ZuZDdRZ1FmS2F2?=
 =?utf-8?B?dHdUTXgvVHp4cmEveGM5NmNEdmVCRkRFL3haSGFwU2tYUGlxZEx0c1JrSnI2?=
 =?utf-8?B?QUpnQ0p1UUxJSlhpZ0lnM2Vlem5ITy9OeG1aSThYVUx5ZEJMUTVmcXpGTDdQ?=
 =?utf-8?B?OWVqalY5V0pETWhpRFZVNzFFaDFoTy9xK0w4QmUvM0RPeDhINDNnNGt2c21x?=
 =?utf-8?B?c1ZyaWMzcW9NNGh2cWNFQjh5a2V5Rmh1NEpSNjNWbHA0ZG5TMTlObVFrUlIz?=
 =?utf-8?B?aTVIV21xeHFDQk4wNHpHc3l6SXR2QkpkcG9FRnFHNFhkZFYyYWQ2bW5TalYv?=
 =?utf-8?B?R2pyZUoxa2pZY1p3Y3VjTWJ6d3BVWEFYNXRTMmVVK1JnMUpMYW9raXRSZ3hy?=
 =?utf-8?B?Y0FCbFI4VGFYMjFGN3FaUWJCbWN0TXNPSi95K1VOS25yUEQ1MmdlaVNJUFpw?=
 =?utf-8?B?dDJIVmNWdW9qbFd5aVJDaVNhYTVmOUlpWUhyZWphQnlhZzh6YUZSdkdDR1lH?=
 =?utf-8?B?eXEzVU56WWFXSEtYNG5EOGcvcTlKZDJpRmIwM0tiNUY4WVBYWmk5S3VhMzBy?=
 =?utf-8?B?QVptK0hveEZvd3AvOS83blkxak1ZaWp6T0pIVWJwZm9FNzk2c29lMTczdkZx?=
 =?utf-8?B?SEVqS2hHS2N4V25ham9LSWpFdU1jbkpBTE1mc1FzZU9BZmVOUXBFMjVqWDZI?=
 =?utf-8?B?R1RmK2VjS2hkRzZrSEVvdjRqQXd6aThjYWdwT3MxSzhTMmYvZWVYaWFrcnQr?=
 =?utf-8?B?L2lhODRQaTAvZlFjV1NVU2hQMWF3bVZHLyt1a21XNjR0QU1UV2NQZ2QyalRQ?=
 =?utf-8?B?SFEyTTROR2l5enBpUldFS01mbVRBWnRSZHJoVzQ3cGo2b3I3VHk4SHZaSWVX?=
 =?utf-8?B?b1dEbS9ZZXdnZEY1c3B6Y0gxSFcwbTBlbk5vcWdZVlpYUWNkeDkwL2FidU92?=
 =?utf-8?B?M0cydkVmdjVXZlZyV3F4aER6UGVUTnRTZi9aVk9hdEltdWRmT0pjNU5GNDFi?=
 =?utf-8?B?YXl2emZBRmY0czRyWWtUKytreGFETXBLV0RXR09YSmxuOUVEY1hRZVBWLytC?=
 =?utf-8?B?ekg3UnRFSHpUblpNcW01NytrbWhHbEpxQ1dHcEVMVzh0aFArNSt2c2pTQjBr?=
 =?utf-8?B?ZG4vREtaczNON0hZdU8xZjV0UDRYZ3FKWHFWWVhFZTRqZllRUlpzZmRwOGs1?=
 =?utf-8?B?b1crZ3dQbGtGd0Y0ckFRcExOdk1qV1NPd1dCMVZYS3FHMWcxamdLYkVqbUd3?=
 =?utf-8?B?dWZzWXZSZkovM2twb1ZZV2dBQ3htU2JtV2JPOXFobmRjYit4WjZ6TVA0RlpS?=
 =?utf-8?B?UzVtYWJSVm1vaHQyWjVzc3dFRTAvVFhiUXl1czA3WFJNWnA5cFdILzgrWHpl?=
 =?utf-8?B?bkNYZTVYTmJodVFqMGJXai9JTWZSNjBnV1BOQXFIM0lNaUR2TjFsb1hxazBj?=
 =?utf-8?B?ekNES2dvREVvemo0V1RGY2hJa0tiRzdNc2E0bWlPVzhYUUcxTWpHS3VsT3pM?=
 =?utf-8?B?em9nK0FUN3duNmhnTEtKWE5DeFNYMnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8d6fa0-8cfe-4285-6672-08db554f6f7c
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:19:46.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2201
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------s8Nz3WDKfb20Dl0A4Jn2OARY
Content-Type: multipart/mixed; boundary="------------Hkb21enb3MR81X2Bk7XDSYp8";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: wiagn233@outlook.com, Andre Przywara <andre.przywara@arm.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
 lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
 Martin Botka <martin.botka@somainline.org>
Message-ID: <56e13335-b5ee-e3cd-3755-4f8f6ea20918@outlook.com>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
In-Reply-To: <20230515105229.GI8963@google.com>

--------------Hkb21enb3MR81X2Bk7XDSYp8
Content-Type: multipart/mixed; boundary="------------P20xPOLqbKbwIvnMG0hBUUSE"

--------------P20xPOLqbKbwIvnMG0hBUUSE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTGVlLA0KDQpXaHkgdGhlcmUncyBubyBuZXdzIGFib3V0IHBhdGNoIDMgZm9yIG15IHNl
cmllcyBhbmQgYXhwMzEzYSBzZXJpZXM/DQoNCkl0IGNhbid0IHdvcmsgd2l0aG91dCBwYXRj
aCAzLiBBbmQgY291bGQgd2Ugc2VlIHRoZSBmaXggZm9yIHBhdGNoMS8yIGluDQoNCm5leHQg
UkM/DQoNCkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+IE9uIFRodSwgMDQgTWF5IDIw
MjMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+DQo+PiBPbiAwMy8wNS8yMDIzIDEz
OjA3LCBBbmRyZSBQcnp5d2FyYSB3cm90ZToNCj4+PiBPbiBXZWQsIDI2IEFwciAyMDIzIDE1
OjI3OjQwICswMTAwDQo+Pj4gTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4NCj4+PiBIaSBMZWUsDQo+Pj4NCj4+PiBJIHNlZSB0aGlzIHBhdGNoIGluIExpbnVzJyB0
cmVlLCBidXQgc29tZXRoaW5nIG11c3QgaGF2ZSBnb25lIHdyb25nIGhlcmUsDQo+Pj4gY2Fu
IHlvdSBwbGVhc2UgY2hlY2s/IFNlZSBiZWxvdyAuLi4NCj4+Pg0KPj4+PiBPbiBGcmksIDIx
IEFwciAyMDIzLCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4+Pg0KPj4+Pj4gVGhlIEFYUDE1MDYw
IGlzIGEgUE1JQyBjaGlwIHByb2R1Y2VkIGJ5IFgtUG93ZXJzLCBhbmQgY291bGQgYmUgY29u
bmVjdGVkDQo+Pj4+PiB2aWEgYW4gSTJDIGJ1cy4NCj4+Pj4+DQo+Pj4+PiBEZXNjcmliZSB0
aGUgcmVnbWFwIGFuZCB0aGUgTUZEIGJpdHMsIGFsb25nIHdpdGggdGhlIHJlZ2lzdGVycyBl
eHBvc2VkDQo+Pj4+PiB2aWEgSTJDLiBFdmVudHVhbGx5IGFkdmVydGlzZSB0aGUgZGV2aWNl
IHVzaW5nIGEgbmV3IGNvbXBhdGlibGUgc3RyaW5nDQo+Pj4+PiBhbmQgYWRkIHN1cHBvcnQg
Zm9yIHBvd2VyIG9mZiB0aGUgc3lzdGVtLg0KPj4+Pj4NCj4+Pj4+IFRoZSBkcml2ZXIgd291
bGQgZGlzYWJsZSBQRUsgZnVuY3Rpb24gaWYgSVJRIGlzIG5vdCBjb25maWd1cmVkIGluIGRl
dmljZQ0KPj4+Pj4gdHJlZSwgc2luY2Ugc29tZSBib2FyZHMgKEZvciBleGFtcGxlLCBTdGFy
Zml2ZSBWaXNpb25maXZlIDIpIGRpZG4ndA0KPj4+Pj4gY29ubmVjdCBJUlEgbGluZSBvZiBQ
TUlDIHRvIFNPQy4NCj4+Pj4+DQo+Pj4+PiBHUElPIGZ1bmN0aW9uIGlzbid0IGVuYWJsZWQg
aW4gdGhpcyBjb21taXQsIHNpbmNlIGl0cyBjb25maWd1cmF0aW9uDQo+Pj4+PiBvcGVyYXRp
b24gaXMgZGlmZmVyZW50IGZyb20gYW55IGV4aXN0aW5nIEFYUCBQTUlDcyBhbmQgbmVlZHMN
Cj4+Pj4+IGxvZ2ljIG1vZGlmaWNhdGlvbiBvbiBleGlzdGluZyBkcml2ZXIuIEdQSU8gc3Vw
cG9ydCBtaWdodCBjb21lIGluIGxhdGVyDQo+Pj4+PiBwYXRjaGVzLg0KPj4+Pj4NCj4+Pj4+
IC0tLQ0KPj4+PiBZb3UgbXVzdCBub3QgdXNlIHRoZXNlIGFib3ZlIHRoZSB0YWdzIG9yIEdp
dCB3aWxsIGRyb3AgdGhlbS4NCj4+Pj4NCj4+Pj4+IENoYW5nZXMgc2luY2UgdjI6DQo+Pj4+
PiAgIC0gUmViYXNlIHRvIEFYUDMxM2Egc2VyaWVzIHYxMCBbMV0gKyBuZXdlc3QgKDIwMjMw
NDIwKSAtbmV4dCBicmFuY2gNCj4+PiBTbyB0aGlzIHBhdGNoIHdhcyBiYXNlZCBvbiB0aGUg
QVhQMzEzYSBzZXJpZXMsIGJ1dCBJIGRvbid0IHNlZSB0aGF0IGluDQo+Pj4gTGludXMnIHRy
ZWUgKG9yIGluIGFueSBvZiB5b3VyIHRyZWVzLCBpZiBJIGhhdmUgY2hlY2tlZCBjb3JyZWN0
bHkpLg0KPj4+IFRoZXJlIG11c3QgaGF2ZSBiZWVuIGEgY29uZmxpY3QsIGFzIHRoaXMgW1BB
VENIIHYzIDIvM10gZGlmZiBhY3R1YWxseSBsaXN0cw0KPj4+IHRoZSBheHAzMTNhIGVudHJ5
IGluIHRoZSBjb250ZXh0IGxpbmVzLg0KPj4+DQo+Pj4+PiAgIC0gQWRkIGF4cF9yZWd1bGF0
b3Jfb25seV9jZWxscyByYXRoZXIgdGhhbiBkaXJlY3RseSB1c2luZyBheHA4MDZfY2VsbHMN
Cj4+Pj4+ICAgICBmb3IgY2FzZXMgdGhhdCBJUlEgbGluZSBpc24ndCBjb25uZWN0ZWQuDQo+
Pj4+Pg0KPj4+Pj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+Pj4+ICAgLSBOb3RoaW5nDQo+Pj4+
Pg0KPj4+Pj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXN1bnhpLzIwMjMw
NDAxMDAxODUwLjQ5ODgtMS1hbmRyZS5wcnp5d2FyYUBhcm0uY29tLw0KPj4+Pj4NCj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFNoZW5neXUgUXUgPHdpYWduMjMzQG91dGxvb2suY29tPg0KPj4+
Pj4gLS0tDQo+Pj4+IFB1dCBjaGFuZ2UtbG9ncyBoZXJlIGluc3RlYWQuDQo+Pj4+DQo+Pj4+
PiAgIGRyaXZlcnMvbWZkL2F4cDIweC1pMmMuYyAgIHwgICAyICsNCj4+Pj4+ICAgZHJpdmVy
cy9tZmQvYXhwMjB4LmMgICAgICAgfCAxMDcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4+Pj4gICBpbmNsdWRlL2xpbnV4L21mZC9heHAyMHguaCB8ICA4NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4gICAzIGZpbGVzIGNoYW5nZWQs
IDE5NCBpbnNlcnRpb25zKCspDQo+Pj4+IEkgbWFudWFsbHkgYWRkZWQgdGhlIG1pc3Npbmcg
dGFncyBmb3IgdGhpcyBhbmQgdGhlIERUIHBhdGNoIGFuZCBhcHBsaWVkLg0KPj4+IFNvIHRo
aXMgcGF0Y2ggZG9lc24ndCBsaXN0IGFueSB0YWdzIGFzaWRlIGZyb20gU2hlbmd5dSdzDQo+
Pj4gU2lnbmVkLW9mZi1ieS4gVGhlIHBhdGNoIGluIExpbnVzJyB0cmVlIGxpc3QgYSBSZXZp
ZXdlZC1ieTogZnJvbQ0KPj4+IEtyenlzenRvZiwgd2hpY2ggSSBkb24ndCBzZWUgYW55d2hl
cmUgaW4gdGhlIHRocmVhZCwgaGUganVzdCByZXZpZXdlZCB0aGUNCj4+PiBiaW5kaW5nIHBh
dGNoLCBBRkFJQ1QuDQo+PiBZZXAsIEkgbmV2ZXIgcmV2aWV3ZWQgdGhpcy4NCj4+DQo+Pj4g
SSBzZWUgeW91ciB0ZW50YXRpdmUgUi1iOiBvbiB2MiwgYnV0IHdpdGggdGhlDQo+Pj4gcmVx
dWVzdCB0byByZWJhc2UgYW5kIHJlc2VuZCwgd2hpY2ggaGUgZGlkIHdpdGggdjMuIFRoZSBh
cHBsaWVkIHBhdGNoDQo+Pj4gbG9va3MgbGlrZSB2MywgYnV0IG5vdCBvbiB0aGUgYmFzZSBj
b21taXQgdGhpcyB3YXMgc2VuZCBhZ2FpbnN0Lg0KPj4+DQo+Pj4gU28gSSBhbSBzbGlnaHRs
eSBjb25mdXNlZCwgYW5kIGFtIGFsc28gd29uZGVyaW5nIHdoYXQgaGFwcGVuZWQgdG8gdGhl
DQo+Pj4gQVhQMzEzYSBwYXRjaGVzPyBJIHNlZSB0aGUgYmluZGluZyBwYXRjaCBtZXJnZWQs
IGJ1dCBub3QgdGhlIE1GRCBwYXJ0LA0KPj4+IGV2ZW4gdGhvdWdoIHlvdSByZXBsaWVkIHNh
eWluZyBzby4NCj4+IEJlY2F1c2UgdGhlIHBhdGNoICMxIHdhcyBicm9rZW4sIHNlZToNCj4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWTNQMjg2TUIyNjExNzdDRjdBQTI5NTlC
RDk1MTdEQTk5ODYwOUBUWTNQMjg2TUIyNjExLkpQTlAyODYuUFJPRC5PVVRMT09LLkNPTS8N
Cj4+DQo+PiBUaGUgU29CIGFuZCBSZXZpZXdlZC1ieSB3ZXJlIGFmdGVyIC0tLSBhbmQgYXBw
YXJlbnRseSBiNCB1bmRlcnN0b29kIGl0DQo+PiBhcyBjb3ZlciBsZXR0ZXIgYW5kIGFwcGxp
ZWQgZXZlcnl3aGVyZS4NCj4+DQo+PiBMZWUsDQo+PiBEbyB5b3UgaGF2ZSB0aGUgbGF0ZXN0
IGI0PyBJZiB5ZXMsIHRoaXMgc2hvdWxkIGJlIHJlcG9ydGVkIGFzIGI0IGJ1ZywNCj4+IGFz
c3VtaW5nIHlvdSB1c2VkIGl0Lg0KPiBJIGFtIHVzaW5nIGI0LCBhbHRob3VnaCB0aGUgdmVy
c2lvbiBJJ20gdXNpbmcgaXMgcXVpdGUgb2xkICgwLjkuMCkuDQo+DQo+IEFsc28sIHRoaXMg
d2FzIHF1aXRlIHNvbWUgdGltZSBhZ28gLSBJIGhhdmUgc2xlcHQgc2luY2UgYXBwbHlpbmcg
dGhpcw0KPiBhbmQgZG8gbm90IGRpc3RpbmN0bHkgcmVtZW1iZXIgZG9pbmcgc28uICBUaHVz
LCB0aGUgYXBwbGljYXRpb24gb2YgeW91cg0KPiBSLWIgbWF5IHdlbGwgaGF2ZSBiZWVuIGEg
bWlzdGFrZSBvbiBteSBwYXJ0LiAgSSdsbCBrZWVwIGFuIGV5ZSBmb3Igc3VjaA0KPiB0aGlu
Z3MgaW4gdGhlIGZ1dHVyZSBhbmQgaWYgSSBzZWUgKGFuZCByZW1lbWJlcikgYW4gaXNzdWUs
IEknbGwgcmVwb3J0DQo+IGl0Lg0KPg0K
--------------P20xPOLqbKbwIvnMG0hBUUSE
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------P20xPOLqbKbwIvnMG0hBUUSE--

--------------Hkb21enb3MR81X2Bk7XDSYp8--

--------------s8Nz3WDKfb20Dl0A4Jn2OARY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRiP3YACgkQX75KBAfJ
sRkQeg//be0ydO6p8yNq+zXKb0lZOqNKZLaw+meLf9fH2i4qAr6SrCodcAgjTeJX
O7kkQbeP6MaEXB6QW2XpfmeMXLK4Pfulu56YQ9JVhgp5j3SLw5i8tREgTKpO8P1w
pj+Zl0iPzb96fougCVivVB1lfXPUYBcfiLluwWi4ts0xRXKCkpb67BBNtd+ePUuH
8JZRKNTBgaHroNTSJgQyXKniz/smnWBLV5gK42SVAgKahwxwqJyEcHQt24Cy4VhR
Dz0gz8E8kO/HjwdYuaSZS/i5BTTPyHgkRoFOCpAcLMxxQhxzW3aANd3DVpYw67Ku
oaxaVOaLzFuXe0/bRtmKsqlqpHY1TyjaeZibqwIsAqVh5wVHlCmG8GlmeX9jtT3O
iCBP7CuSKMKyxyECNWCuS7pWUg0fK9Pbq0+8u0Y/KI/p7dvomsrzpN1nzcON1X/y
HWK7zwT+HA8tXFTbtDCuASxbbAw1XvEgKYPIXdhBWkUJZXV6IoYI7Gu16R4oN8wT
yc6iYO51cQaKsHSjdwyBhUP2N2EJE8XR7UWnN/9Gp1YnGTZIGJZk3b5UnJEm2FGb
RVxFDTCJfZktBqpKYAFDTpuh+hZAR2ioBG32MYBvQdW8qtL7mHrv+Mv+vpYTJ8eQ
TgR68tkYrkAi+JpefqhbrIKBDuqh8LUCB/LI73hNVI8E2Py87HQ=
=EYWq
-----END PGP SIGNATURE-----

--------------s8Nz3WDKfb20Dl0A4Jn2OARY--
