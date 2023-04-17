Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF35B6E4E56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDQQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDQQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:32:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2070.outbound.protection.outlook.com [40.92.98.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBF83E4;
        Mon, 17 Apr 2023 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIa6Lrfbvv02KfD+Q3Reb7AbQOjmmExHPCR3sYiAyAgEilmnhsFEzC4hHqbiWKeS/KnB2EypSBwZzASnbdaIIc1Ff3e7y06gwoJRpIe4SoLKdsJTzkgkLXmy/ziel/UQKdGlTBuddktKKOdCWV49R5IdV9zYtcvoE77h18qBTTGgEeT9cIUaL0yUk/SQ42yNmiZnifOHcvTUnsXZWgetzyk3eWYLDaqsaefZ2SHtFmMApMLE0vmQbvpR05NnpVuhbhnMNZ6lyTU+48cVuHpyoBS9BmM8Tx7Py5UFRRcjYlRRQ0+3EngbkU3J7c39ROHTIdP6Ah23DLKQhhlZj/motQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSknW21e6RDjimw7XeT66MeRjckB84uffdBmXXr73mI=;
 b=gCfN5g31LbUIribND456zt1MGfNrpuNeznTWHwstVkGDFzoosXdJbC451bM4Yw7pnDvH7UMskL9mpoceBvEa5bkr81KtcHryo/jXwDtZ15piJxqVGod1/ePSg+CYb3hePh3TrV6YJlAJfe1I5TlxOQL5A0kDIT4ldo5zydhXuvgR6ZBXQyI0Hhv5Z7/oeZAAWbgq2+Sz7DfR3P7THX7ISX852nf8HiKJqOSNtbN0SDQI28mgzdFOVz1hyvZFHlW/gZOu9EqapfatO111IsVBdocOHrgfp5VASkdJ+Evq2AU44MNUHk4FW0U9BzsH6aBwI6b0+Fr3Q4N+rSWOi/Gxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSknW21e6RDjimw7XeT66MeRjckB84uffdBmXXr73mI=;
 b=QUpJSIDWmdbwBTPuY1vTSIw2/NfRnVs8rZDT9vOEnP2lcb0eRMOGTG80q3VfpbWpvk51khsjT0rJh+mgu0GVm9UNr2ShQCCp22CnmREjIhJSU0d/mdEXjxUspEa98zAH3x7rHHbzj8W/VB1l+KqD/YMk/Jfdss6zsVt1r+QJbLBvPaYiLNR8J+b/MLxqCXxbJzDbgLxupJp5U86P2yP2PNVoRhUBQ9EKEUB1O/TETINAc224P3w031lXEuizDJ+ikRrMI2RdEFywC8DfanZ2s9NfudFM+wc0DN2kAo9QpbD3U5oYZsT9kahmqW6/6pXz0YZU0Ecfk2czZ8PUBW900A==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB3411.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 16:32:08 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 16:32:07 +0000
Message-ID: <TY3P286MB2611897A0903548C7A4199FA989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 18 Apr 2023 00:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB26111D00F42888C71EF0877698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230417152020.419bfb9c@donnerap.cambridge.arm.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v1 4/4] regulator: axp20x: Set DCDC frequency only when
 property exists
In-Reply-To: <20230417152020.419bfb9c@donnerap.cambridge.arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0BwRwgh2L4JHzTnbeEYCjhZ9"
X-TMN:  [+WvamU/HFdAoBH1H9mqoodlFRL5Rt3ZWknTExmsFtvrgO3o2CspXvA==]
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <c677cea1-2767-58b3-d842-96ffa27c9b01@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3411:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b2d430-997a-4bea-510d-08db3f614932
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGuqHjNuGyW9r7+735tJx0KQoki4QLIQD28STUwbRtWDahSy6XRqjMZQn2vxeuyFEM/f3oZTqP3/0yT2riBosxJnYxrGR41yrPGenSwTY85VzIgx3V3wiRYHEJW5Noa0w0ovTyykjP/oqMN2SQTWEwVyfxjBh8OYcKvbBwJE5DxKSm2i65I1yNeIrXldleBWbNk8vi/OMBvTLtVIlH/5thJa1al58Y6OoHu0mvgc0383chEX0i6GxSMkKC3++p3xRlQ1JtHf7znRKzQhiHjCYs6egCQOIMLmRS5WLQeCE5E4vmr20flmkCr00Y6yZVjrn6wNu3DeKCiK/SiZhAUibpU/PM23R+bvTY8UQ3XEUAuMML3cthebNFaQkQxFk+V7jQKX+X4A326Yyv6lRp7eXZ9v3qmKXg0SXIbY6/NHd2W8xAM014k+4/QLkev7M0xrDtisgwymdyXQlSO8tRi9c9S9u1qmc5GE6Wv6B9wu+4TTHr/nqlO9WOKhoRq6U+t3lcIdeFqqF7cXzDpm3X34Oy8PlTLFut2AAARjxL0uMea7IQQrEssutC3fC+V6Bj1LE1zgvq2rq2xkrOxXLninRvUf3bevfiBtl+oFXTdMO2lwRSquIARWzl19eEJF6EvhIVWTKLDDWl8rZVclP2AGNA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNHbVlCTklVMm5PYTRQWlRxbTF0VmpYYjE1RUMvMWw5ckFrZmRvUFl6TU9y?=
 =?utf-8?B?VzhSYWo0ZG1ndzlnaEdJZXBEdkhRWTVVREt5a0lsQnFDOXp1WUZWeEUrVmlj?=
 =?utf-8?B?REovN1hiNUVrbk1hT0t4UjRseU8yMnhGbTFqcmFmRms0T2I3Rk9xRnlSa0FK?=
 =?utf-8?B?MGpoV3J5S0VzMG9MQVl5WGZURG02eEFFUlZDM3Y4cUNmcGtqNXY1MTRQWjEy?=
 =?utf-8?B?UjlOak55T29jKzdDbWs2WG1mSDdvYUxzY1lpekMwNk9DaFFtWEtENnhxRFpv?=
 =?utf-8?B?cHRqcXBvc3VUaTErWS91VU5CeEZIbElNanQwSkFlUWZaWGVpYWVMc2g3bUlE?=
 =?utf-8?B?RTlBZjlZMW81SWZNNXJ3U1dVcWJYMHBScHhVTmVRd2IzQUhmMXpPRCtnME8r?=
 =?utf-8?B?WXZSQ3ZHMTZpWUtBZ0dXTmxrWm5MT1BMSG5wOUNYeU1KclZPT2d0am1BM3Fz?=
 =?utf-8?B?MUppMDFLU0FWYkRTWktwU0Mrd0FXQjRJRFJiS1BmeGs0Z21abWZWNTI3VGhm?=
 =?utf-8?B?SzI0dVo0VHNqWDNmaDdtck1WSnYxNkRYZ0Y2RkxsWFBPV3VoUGxWS0xjSTR3?=
 =?utf-8?B?aTFOVmNVWlBaakRuM0Y3d1dlSDAwcXBKZXBGNWhQaEdtMTBQTmVTQWtNcnY1?=
 =?utf-8?B?TkNxd2FFcnp1aTNBQVMwd3NncTJyOU8rQ2FCTjFmdkVOOUEyazgwV1RwTit5?=
 =?utf-8?B?Ujh6K2JRUjd4SXBuY1JNQXdLeTc0RUo4ZGJkZ2lJUzBvbkNQN1NHcUQyb252?=
 =?utf-8?B?NFRPTG9DVFMwLzdIY0FXZmY1WGh6WllxVDRJR0l2OHByNTV6allXcDFxN1gz?=
 =?utf-8?B?ZE5ZNnY2c1V2cVo0dDZjeXBsazF2VWU1L29mcFdKYnRMczlWMW1OT2VTeS9j?=
 =?utf-8?B?YXRvcFpyeS84bVZnaWowWGFwVEJvK2pXWksxVVdnbzZJVzJzSVBCaWRNU2g4?=
 =?utf-8?B?ckRMZ3A2MXZJV0hOZFAzVnpMcThmRUNkZkIycVJCdVZWN2pYZ0w0KzU0OVgw?=
 =?utf-8?B?bENmVG11UmNBbGdyelpTS0VoejlTSllDZThWR1pTWGZVeXlKUGZ2K3BFSmxX?=
 =?utf-8?B?dStpVUhnc3E3UWNOYzJVdVVlN2VtbDVic2oxZTVkK3lOZzlEd1dzcnFBa0JB?=
 =?utf-8?B?SzV4M1BYRlNJY3cyRDg0ZENkaHAxTGxjWW1NLzZqbzZpNUFZcFVXMGJtOVJT?=
 =?utf-8?B?OXFFOVZ0bTRuNU9JTUptRCs1K3ZKWUZNZXUrenFValFQTWh6NW9mSm9rY0Mx?=
 =?utf-8?B?MDRhVHN0ckZ4Zm1jTnZuZExOeDNRRHVEZmNkL3lLRFhIWUFOdXQvbGptWFo2?=
 =?utf-8?B?akM3WHJiZS9FME05NkY1dHd2cEU0UmJEUFpBcFNwdVlZYUVEaVNCVG41d0dW?=
 =?utf-8?B?am5PQXU3Y1BONTJiY3hnN3Nrd1FObVN3aEJudi9TZ1JaTWEvM2FiS2xDQ05L?=
 =?utf-8?B?eHpsbXZnNHpIRko4czI3MXlORGdyb2hUSCtWUkZpY21BVDlIWWFPNjNxQVZR?=
 =?utf-8?B?T2ZReVdSaUtvODMwZTNPZUV6YUxaLzhlUlJ1ZnJFRXpvbHFkMDdLZkROYVdO?=
 =?utf-8?B?eVA5M3VIQUtsU0lDUllMTDMxY09vSER4YUZpcEZTeFVNSjVLY1BIUWNtMlBQ?=
 =?utf-8?B?biszQ1BpNURGZEU3YXB1YlhOV2h2eEdSZFc2V2hsOGJUVFBQakZucnhpcVZR?=
 =?utf-8?Q?CH/bSSRWZJfFFRbowe3u?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b2d430-997a-4bea-510d-08db3f614932
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 16:32:07.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3411
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------0BwRwgh2L4JHzTnbeEYCjhZ9
Content-Type: multipart/mixed; boundary="------------Cr9IN54IpRpNrZ0Ln7xcCxMB";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Botka <martin.botka@somainline.org>
Message-ID: <c677cea1-2767-58b3-d842-96ffa27c9b01@outlook.com>
Subject: Re: [PATCH v1 4/4] regulator: axp20x: Set DCDC frequency only when
 property exists
References: <20230407141813.89-1-wiagn233@outlook.com>
 <TY3P286MB26111D00F42888C71EF0877698969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230417152020.419bfb9c@donnerap.cambridge.arm.com>
In-Reply-To: <20230417152020.419bfb9c@donnerap.cambridge.arm.com>

--------------Cr9IN54IpRpNrZ0Ln7xcCxMB
Content-Type: multipart/mixed; boundary="------------i0y7zynqOFO5MxEBikmKY0zZ"

--------------i0y7zynqOFO5MxEBikmKY0zZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmUsDQoNCj4gT24gRnJpLCAgNyBBcHIgMjAyMyAyMjoxODoxMyArMDgwMA0KPiBT
aGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT4gd3JvdGU6DQo+DQo+PiBDdXJyZW50
IGF4cDIweCByZWd1bGF0b3IgZHJpdmVyIHdvdWxkIGFsd2F5cyBzZXQgRENEQyBmcmVxdWVu
Y3kgZXZlbiBpZg0KPj4gdGhlcmUgaXMgbm8geC1wb3dlcnMsZGNkYy1mcmVxIGluIGRldmlj
ZSB0cmVlIGRhdGEuIENhdXNpbmcgbWVhbmluZ2xlc3MNCj4+IHdhcm5pbmcgaW5mbyBvdXRw
dXQgb24gdmFyaWFudHMgdGhhdCBkbyBub3Qgc3VwcG9ydCBEQ0RDIGZyZXF1ZW5jeQ0KPj4g
bW9kaWZpY2F0aW9uLiBTbyBvbmx5IHRyeSB0byBzZXQgRENEQyBmcmVxdWVuY3kgd2hlbiB0
aGVyZSBpcyBmcmVxdWVuY3kNCj4+IHByb3BlcnR5Lg0KPiBUaGlzIHBhdGNoIHNob3VsZCBu
b3QgYmUgbmVlZGVkLiBZb3Ugc2hvdWxkIGRpc2FsbG93IHRoZQ0KPiB4LXBvd2VycyxkY2Rj
LWZyZXEgcHJvcGVydHkgaW4gdGhlIGJpbmRpbmcgKHNlZSBbMV0pLCB0aGVuIGhhbmRsZSB0
aGF0DQo+IGxpa2UgdGhlIEFYUDMxM2EgZHJpdmVyIGRvZXM6IGJ5IGV4cGxpY2l0bHkgY2hl
Y2tpbmcgdGhhdCB0aGUgcHJvcGVydHkNCj4gZG9lcyBub3QgZXhpc3QsIHRoZW4gcmV0dXJu
aW5nLCBzZWUgWzJdLg0KPg0KPiBJbiBnZW5lcmFsIHlvdSBtaWdodCB3YW50IHRvIHJlYmFz
ZSB5b3VyIHNlcmllcyBvbiB0b3Agb2YgdGhlIEFYUDMxM2EgdjEwDQo+IHNlcmllcywgYXMg
dGhpcyBtb3N0IGxpa2VseSBnb2VzIGluIGJlZm9yZS4NCg0KVGhhbmtzIGZvciBwb2ludGlu
ZyBvdXQgdGhpcyA6KSBXb3VsZCBmaXggYW5kIHJlYmFzZSBpbiBuZXh0IHZlcnNpb24uDQoN
CkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+IENoZWVycywNCj4gQW5kcmUNCj4NCj4g
WzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXN1bnhpLzIwMjMwNDAxMDAx
ODUwLjQ5ODgtMi1hbmRyZS5wcnp5d2FyYUBhcm0uY29tLw0KPiBbMl0NCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtc3VueGkvMjAyMzA0MDEwMDE4NTAuNDk4OC00LWFuZHJl
LnByenl3YXJhQGFybS5jb20vDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3l1IFF1IDx3
aWFnbjIzM0BvdXRsb29rLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3JlZ3VsYXRvci9h
eHAyMHgtcmVndWxhdG9yLmMgfCA4ICsrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcmVndWxhdG9yL2F4cDIweC1yZWd1bGF0b3IuYyBiL2RyaXZlcnMvcmVndWxhdG9y
L2F4cDIweC1yZWd1bGF0b3IuYw0KPj4gaW5kZXggZWNlNGFmOTNkZjdiLi4xMmExMjkyM2Jj
N2IgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9heHAyMHgtcmVndWxhdG9y
LmMNCj4+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL2F4cDIweC1yZWd1bGF0b3IuYw0KPj4g
QEAgLTEyNDcsMTAgKzEyNDcsMTAgQEAgc3RhdGljIGludCBheHAyMHhfcmVndWxhdG9yX3Bh
cnNlX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgIAlpZiAoIXJlZ3Vs
YXRvcnMpIHsNCj4+ICAgCQlkZXZfd2FybigmcGRldi0+ZGV2LCAicmVndWxhdG9ycyBub2Rl
IG5vdCBmb3VuZFxuIik7DQo+PiAgIAl9IGVsc2Ugew0KPj4gLQkJb2ZfcHJvcGVydHlfcmVh
ZF91MzIocmVndWxhdG9ycywgIngtcG93ZXJzLGRjZGMtZnJlcSIsICZkY2RjZnJlcSk7DQo+
PiAtCQlyZXQgPSBheHAyMHhfc2V0X2RjZGNfZnJlcShwZGV2LCBkY2RjZnJlcSk7DQo+PiAt
CQlpZiAocmV0IDwgMCkgew0KPj4gLQkJCWRldl9lcnIoJnBkZXYtPmRldiwgIkVycm9yIHNl
dHRpbmcgZGNkYyBmcmVxdWVuY3k6ICVkXG4iLCByZXQpOw0KPj4gKwkJaWYgKG9mX3Byb3Bl
cnR5X3JlYWRfdTMyKHJlZ3VsYXRvcnMsICJ4LXBvd2VycyxkY2RjLWZyZXEiLCAmZGNkY2Zy
ZXEpICE9IC1FSU5WQUwpIHsNCj4+ICsJCQlyZXQgPSBheHAyMHhfc2V0X2RjZGNfZnJlcShw
ZGV2LCBkY2RjZnJlcSk7DQo+PiArCQkJaWYgKHJldCA8IDApDQo+PiArCQkJCWRldl9lcnIo
JnBkZXYtPmRldiwgIkVycm9yIHNldHRpbmcgZGNkYyBmcmVxdWVuY3k6ICVkXG4iLCByZXQp
Ow0KPj4gICAJCX0NCj4+ICAgCQlvZl9ub2RlX3B1dChyZWd1bGF0b3JzKTsNCj4+ICAgCX0N
Cg==
--------------i0y7zynqOFO5MxEBikmKY0zZ
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------i0y7zynqOFO5MxEBikmKY0zZ--

--------------Cr9IN54IpRpNrZ0Ln7xcCxMB--

--------------0BwRwgh2L4JHzTnbeEYCjhZ9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmQ9dGoACgkQX75KBAfJ
sRkt8xAAhW07ckjor5QJ8LlygYLzGEqPOh/hF1bFcY8EBc116K+XaHidPtQB3z10
2MMg++B7wbSCFx681SdzsrB4gPrQCwmuWAdogdOQdJ5OTJ63flnebTipIWPyUXmB
CLgpbjht4J5u0IlM+6eW8Cbl0BfVljRoLGORtxpCpHPbSXk8i3opZ5IX2Ere/e0V
u5CUrnN+pyhy3cQVJHisilL61cYhOtq0PHrif/57yqmFM5Q9aVFzPTtUXAO0kv4s
gehBW+Eo9/8kKM/8tm9fsUtbMIz0vBiDuqpwP8FBqmakzConOI1+qJGRLpsYJNzf
nDpQVSu/Av4gkOTaGFIOzro0vskKf83xqnwJCYQu60Z/yuOfsxpgs8mbRzZnonA4
Dp/jxlYQKsu1ipE6NEJ+jFcxCZ42wBEJSsCQgmsHZ55r3q61sczLPYIlpJWVv/vg
vjiu7YjIAnbdp99J+OoJU0P9lBM2smtfr3GXxZxpvEAKBQX8bbIisijYJQMppvJv
AlqLYtAuWOnQvdZXxWorS3ewGcwC92QA3CHG//U8mnKVGHvZIHiwLRppN4d27aKe
4tpPX/J4ZMnScG+gRvJ70ijGp2mW5zCzgYw44fQoyF+Uvw31QSd+ZFfKF2y7rBnv
dDEEGF3vZGTDBlXF5NQE9JN6VuVv5S3Sw6a89iFRK5kNqie1mrY=
=s+T7
-----END PGP SIGNATURE-----

--------------0BwRwgh2L4JHzTnbeEYCjhZ9--
