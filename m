Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2465774ACD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGGIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGGIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:23:51 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6BF2100
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:23:46 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 366MMq8x016062;
        Fri, 7 Jul 2023 08:23:38 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3rp6bt95xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 08:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWUl5vgKjG2DWqFh4H5CRQbiV2aeiaFT5R2vHaUnz1RGNdLceO2PHLz2mj8zwMjUMKntBAkOLWqE+Y9xMXWLhf25BQZ+LHsapxRALdPi5jDiiuE9aPpXgzvjwmDgM2OgvW2Sv/5z3ocDKgEz6ZrOMUODsdjSXY+2OdnsKjVOY86BNB7PopiCgWwu43ywMbqz/AvZ1Sd3nUJXHmVfxoSrydKm0mgZX7wIeKS10t9KtUqrZM1dRysYe0BoGnM6s4Mc7zuRZxMlVJ7K+R2n56V32PMCCyM45fcYA+eOSHuHUfwu71gpuAHIPgOJahLdVHZjPXFveoB+STVxH68j3G/r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKMoTf8p1qmzaVkkjvwmNs//SOoX8IBLt3MCIw4TjSo=;
 b=RKspt9iv808o1UT/tGb/iPjZWjUMEmTg6XVBgdfO0c8kS0XlcvvvuBqhoc5YgBd3JbNbbvbhfdtOSWijAY7xN+4HTeK2/CBN+uD/Dp6GGfxfaJXpWHM9A1dMjtXdhz7u9SValJi5aoWO3/TMgY68XeSEntaoFUbrbcM6uKmil7YtAC+9mwIZj1nMv+arWR45unkU+CZrAaYqBgxlr2mspyczKUBp3AIjbA0n+Gqn/EQwCQnn2PgjAumGYBpU9SBIU+ISYqtV4swutIwlQ88b5W6C/M6xfW1b+sceW45d986ErkdsfdINcEi9EnZCQLbaNwcKqVhHOmDoyrEKFCjtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKMoTf8p1qmzaVkkjvwmNs//SOoX8IBLt3MCIw4TjSo=;
 b=CioxoyLJeC2Qz4hDz7lTZtCfqcv4oqq9fgeIsD1U7OoZci8tlezMPhP4/5VCKWM0tIXNCxOnTMqTHg1YSHs3P2lfI1g9OUPzQSPGRB7xDs6SSg08IEJyPVajhoNhDcIuqPzROTxAABKlbYuK6yP9sV6MRFKXtzuNiNLWZ+ku3GtJ20SQBTqggqcIakzuYeaDHMi6ulTiQvSf6nn7mqJiIR0ysys3oUTH0LsxhwB7S9xCQ5RUzkyeDawnJlAO6ZFYrxcwURteUKsmdWga+Otyq8FRqoGhLqjnBEEbfYfWlOWttOTZWhbQ9JkUqtlDL8/zYy5Sr2Iqz/mKUipCuF6cmw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by GV2PR03MB8656.eurprd03.prod.outlook.com (2603:10a6:150:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 08:23:33 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 08:23:33 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Thread-Topic: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Thread-Index: AQHZpEL/jQILjif4TEa2QZqecjVVUK+Vi2cAgAt2NQCADPhOAIAAD7yAgAADBQCAAANwAA==
Date:   Fri, 7 Jul 2023 08:23:33 +0000
Message-ID: <6fd98d3d-a83f-100e-93c4-b45cf335708f@epam.com>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <f1a81ac1-5b9a-6d19-1a11-b98685bd2430@suse.com>
 <d5d6caa5-6ca6-b4b8-5334-fc156eeeb21d@epam.com>
 <8b862919-296d-d0b6-d4c1-465b62cfa37f@suse.com>
In-Reply-To: <8b862919-296d-d0b6-d4c1-465b62cfa37f@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|GV2PR03MB8656:EE_
x-ms-office365-filtering-correlation-id: e9a67b84-3dc6-44e9-143b-08db7ec37443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xphmgt0BKFE7BJD/xTh/wuH6ET2KDClsXG/DgJD4ITL8aRZDiydMDY3zbuCr9xl9vBrJTHhMOMgqJ9bKtL8WlpjGL8BjfnN+5OLoRA3+eQG6dn5pKevaYraRZrfGjJ0QRfCU0APfoTPZ/LsWEbIQdQkQHS0A0c5oh4Qp8RIdx3jdUYVMcKYrL5TNdnoB7ZgEHzcbQcHV+dco3+KiPK5AINvhTAuYfzFQ/gU2hDKBr/Ggv0oZEkNM8AyUyjTfiVTrmy3C9OShEc3B5HyKoOmoqNCASJl3lNDUIpeAfZJfrBrUHMxiv18GqIJoajLy6fmw4V30Q44RPYv8IOLan+KQ7zLLqPKbTm8cny9qH5BYZLTnAMc55EwCThjLZNSWW4kYUS2U2li8gQ23ttAhLd8U7RcOFNET5fruIMLKS+c9eMGajNiUPIHNm94OZ8vA3D/JjaqWN0rZUw/yjz3pSLyQfdDLzeb9gjRZIPBh5DQdnop0ltbteVowtZa8jzDTjr2YK/lQi2dY1VB2wyC7XNl4/LcaeADFFeEJjqF21UeuXZQbUvXACxbFN1pl1QhA/FrO5zzMmNvcR36oBcv5OeDq/qXB8Z9hGf40sh/2h1VeBg/c1RN/9h7WNvBSv2AymlAZa+xpO6wJ4Caijf9HMxhHYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(6486002)(478600001)(71200400001)(91956017)(110136005)(76116006)(54906003)(6506007)(26005)(41300700001)(6512007)(53546011)(66946007)(2906002)(186003)(4326008)(316002)(66446008)(64756008)(8676002)(8936002)(5660300002)(38100700002)(122000001)(66556008)(66476007)(36756003)(86362001)(31696002)(38070700005)(2616005)(83380400001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0RvMmo4Yk1obXdSTFNsbHNEbmhYeE9GUHM3Y1MxdllVb3E5UFE1QVhnQUZE?=
 =?utf-8?B?b1pWUzhCOW9oWExVZ0hHY0IvZWhJU29MYlltNWU5WW0rUTBMeUZzY3VQZ2tl?=
 =?utf-8?B?elBJd1dBbmt5eVp4cUx1S0ttcDlmVytLTzdhaUdseHRqNXdTRlhIRlpHQVV6?=
 =?utf-8?B?U0FyNExDYWtYNWcxd29xMW00MU5PaEg1NmI4MVlZeGJPSXdZK3M4NGh3bzMz?=
 =?utf-8?B?SlZpNnl2OHp0dzN5eHhDOGM4OVVXNHJhM3JkeHcyeEJyQnIrR2tsZGJnWXgr?=
 =?utf-8?B?OGNSU1pCMWpScnVTbytVVGQ0ZlpXNjlsNkdrY1BSVSs3ZGw4VEU3ZlFkdzBj?=
 =?utf-8?B?QXgvTFNjK2pTdUsvS25CYllkTmQxVWZzZVY3VSs5blVKQjltUnh0R2xSOHhp?=
 =?utf-8?B?OVBCcENpNjc1cjVoTXVlbEtpSE85T0ppTWdCaUpOQ29Sb003U2xWaG5acnlp?=
 =?utf-8?B?aFk5emNPZDZEZnNTNnpDLzk5aTNvY1hYWFRrNXBqSFBqWU5OTnlPdllNZHpj?=
 =?utf-8?B?K3lsYWdGMU9lVkhxa1pSMEw4TlFZV29qWUhaNm9NNnY3Tzl3V1FXeXVuMUlr?=
 =?utf-8?B?TzI4OTlXUnJjUThlNWZtTEk5RmN0T2NWa3YvWlFZQzdRdDJmdkZ1d2NQbkFx?=
 =?utf-8?B?dm5tSndEVmJqRlYzRFBRbGZ4RjNIdHo0NDRTTlUvYXd1Nld6M29rMWVoUDZK?=
 =?utf-8?B?cDRRZGlKSldoTDV1ckZhMmF3NFp3bVBKZ0RTemtXY1k3NGZmdEprT1JOZkJl?=
 =?utf-8?B?OSthRjN1SFRSNVFFNlFKT2c1TUs2cys0TG5Qc3pLZ2lGM1FERHAvQkFZNTdX?=
 =?utf-8?B?NnJ0SzdnWGZjQmVjSnprZTBXTmtWSnl1NW0vbzZTUCtFUkpnNWNDM0RrbXNC?=
 =?utf-8?B?eDJweXdQMHVVbWJhcUMzMmxDZTFkdVUwakV3MFI0Y0tWaVhCVy92TUV6N09R?=
 =?utf-8?B?Rk9QVFhFSnIraWRDUi83RVIxeHQ3MzZuNE0yRDgxNy9HS0Z5ZUFDNWNTc0dI?=
 =?utf-8?B?U3FrS1RCc25tV1VjOEI4cHM2U1czOGhldVNNdW0xb1JCcFRZd3RWZXB3cUcv?=
 =?utf-8?B?SFZEdktCRVdFbXRBbU5QT0ZwbWY4ZmRsVGZoUXlWWkoyZlQ1c0dwVHdBeFVw?=
 =?utf-8?B?Rk1yVDF6YWRGZmJBSzRzNUlKdE1YNFJGRmlsS1BDdDg4elhmVlMwbjRlNWlB?=
 =?utf-8?B?dHJZNUlVV3AzQ1Y1ZnV1bG5DejE2VEhBaWQ0NWhOWWJJbXhDNUdNOEowdnJ0?=
 =?utf-8?B?cE1EWUtqcE80c3FVaEFLOCtWRFdhYjlCeThHWGZmcDh5WFl1Q2hEVFVZUU9D?=
 =?utf-8?B?YmZ5UkVyekJzY2hUQVhITzdteGN0WDRYYXFyMFVLcGZEeUxUOFQyNTlFbmNq?=
 =?utf-8?B?YUlBR1dnaUlvOXJjamhHd3BUb2VTN1Zwd0tQSElpbmVaNmZBUWlpQjhJSVpE?=
 =?utf-8?B?azFEN2J2bnhmc1NpSitkZ0loYXF6ZjFaS2FzUXlkblMyU3MybjBQcm9VTldr?=
 =?utf-8?B?aDJ3dDlkK2lFaFdMRDcwMHBJWDhCanhUYW9BWUIyUy9vb3R2THhCczIvZjhh?=
 =?utf-8?B?RXl1WUtGV1doeXQ5ckErL1VFNkVzcmsyOXFHYVA5cUpscDZ2WVNVOGJaNjJC?=
 =?utf-8?B?c0w2T1JOSDdib2RjbERCcjh1MC9vSUZnTEM3RWlZY1pOeTE2WlM1QkRLa2dB?=
 =?utf-8?B?Y2grbmVsTjB1cGFUTWYrR05yMUc3c253R3dDblVDcHBSdS82N1lRcER6aEoy?=
 =?utf-8?B?RGpnZUh0eWxOeHdIbWFHUlZqbkVFV1hPZFVnb01UeEEyOUtDWjRKRHZudFYy?=
 =?utf-8?B?QXk0U2wwWVRwNjVZZXRBSDdBd0VKQ0ZTaUp4Y2I4UWpTY1YvbUJMa2xPOTMv?=
 =?utf-8?B?aURDV2JHY2ZXNkdTbEVoa0RZRTBoSDN0TWh0ME9uYzkvT2UzVWVna2phbUhN?=
 =?utf-8?B?Skd3ZHpXVi9ZWm1IbWoyZ3F0NkFtRlRKdjQxNzB0aGlYMEtESFUzamYvWlU1?=
 =?utf-8?B?S1hnZ0VqclZQVFVlRXJkK25kdlhpWDJSdG5wTlQzMFFHNDZrVVFIOThvdkZa?=
 =?utf-8?B?cDNTTkJCTHZPK1dzYkVmNkJydWhxSy9VSFp6OFlJRy9QeUR4YXJBdW9yRzB0?=
 =?utf-8?B?Z0t5VXIyNXVUdWpmWGdzaGE0aHU1QmZjYnJzcXI2M1l5OXhaZEdOWXJQek1k?=
 =?utf-8?Q?fCiPhr0pcDID72smSXeq88I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68636962385E3D40AEE3D03739B907C7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a67b84-3dc6-44e9-143b-08db7ec37443
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 08:23:33.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+9u/+/xr4mWMc9W3iyzsHyzJ5jdw9Q/nO4z/8ycrQhxt4gjM3wgq06NMubQML1z9SOG6rsANIGrpNjx5pue9sfUKcwKunuWPaG/2uxtRjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8656
X-Proofpoint-GUID: JvT80BseL972exYhQWvq8v_IMhm4sLAE
X-Proofpoint-ORIG-GUID: JvT80BseL972exYhQWvq8v_IMhm4sLAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LjA3LjIzIDExOjExLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCg0KPiBPbiAwNy4wNy4yMyAxMDowMCwgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6
DQo+Pg0KPj4NCj4+IE9uIDA3LjA3LjIzIDEwOjA0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4N
Cj4+IEhlbGxvIEp1ZXJnZW4NCj4+DQo+Pg0KPj4+IFJlLXJlYWRpbmcgdGhlIHdob2xlIHRocmVh
ZCBhZ2FpbiAuLi4NCj4+Pg0KPj4+IE9uIDI5LjA2LjIzIDAzOjAwLCBTdGVmYW5vIFN0YWJlbGxp
bmkgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgMjEgSnVuIDIwMjMsIE9sZWtzYW5kciBUeXNoY2hlbmtv
IHdyb3RlOg0KPj4+Pj4gT24gMjEuMDYuMjMgMTY6MTIsIFBldHIgUGF2bHUgd3JvdGU6DQo+Pj4+
Pg0KPj4+Pj4NCj4+Pj4+IEhlbGxvIFBldHINCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4+IFdoZW4gYXR0
ZW1wdGluZyB0byBydW4gWGVuIG9uIGEgUUVNVS9LVk0gdmlydHVhbCBtYWNoaW5lIHdpdGggdmly
dGlvDQo+Pj4+Pj4gZGV2aWNlcyAoYWxsIHg4Nl82NCksIGRvbTAgdHJpZXMgdG8gZXN0YWJsaXNo
IGEgZ3JhbnQgZm9yIGl0c2VsZiANCj4+Pj4+PiB3aGljaA0KPj4+Pj4+IGV2ZW50dWFsbHkgcmVz
dWx0cyBpbiBhIGhhbmcgZHVyaW5nIHRoZSBib290Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGhlIGJhY2t0
cmFjZSBsb29rcyBhcyBmb2xsb3dzLCB0aGUgd2hpbGUgbG9vcCBpbiANCj4+Pj4+PiBfX3NlbmRf
Y29udHJvbF9tc2coKQ0KPj4+Pj4+IG1ha2VzIG5vIHByb2dyZXNzOg0KPj4+Pj4+DQo+Pj4+Pj4g
wqDCoMKgwqAgIzDCoCB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHggKF92cT1fdnFAZW50cnk9MHhmZmZm
ODg4MDA3NGE4NDAwLA0KPj4+Pj4+IGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0LCBj
dHg9Y3R4QGVudHJ5PTB4MA0KPj4+Pj4+IDxmaXhlZF9wZXJjcHVfZGF0YT4pIGF0IC4uL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjMyNg0KPj4+Pj4+IMKgwqDCoMKgICMxwqAgMHhmZmZm
ZmZmZjgxNzA4NmI3IGluIHZpcnRxdWV1ZV9nZXRfYnVmDQo+Pj4+Pj4gKF92cT1fdnFAZW50cnk9
MHhmZmZmODg4MDA3NGE4NDAwLCBsZW49bGVuQGVudHJ5PTB4ZmZmZmM5MDAwMDQxM2M5NCkNCj4+
Pj4+PiBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jOjIzMzMNCj4+Pj4+PiDCoMKg
wqDCoCAjMsKgIDB4ZmZmZmZmZmY4MTc1ZjZiMiBpbiBfX3NlbmRfY29udHJvbF9tc2cgKHBvcnRk
ZXY9PG9wdGltaXplZA0KPj4+Pj4+IG91dD4sIHBvcnRfaWQ9MHhmZmZmZmZmZiwgZXZlbnQ9MHgw
LCB2YWx1ZT0weDEpIGF0DQo+Pj4+Pj4gLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6
NTYyDQo+Pj4+Pj4gwqDCoMKgwqAgIzPCoCAweGZmZmZmZmZmODE3NWY2ZWUgaW4gX19zZW5kX2Nv
bnRyb2xfbXNnIChwb3J0ZGV2PTxvcHRpbWl6ZWQNCj4+Pj4+PiBvdXQ+LCBwb3J0X2lkPTxvcHRp
bWl6ZWQgb3V0PiwgZXZlbnQ9PG9wdGltaXplZCBvdXQ+LA0KPj4+Pj4+IHZhbHVlPTxvcHRpbWl6
ZWQgb3V0PikgYXQgLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6NTY5DQo+Pj4+Pj4g
wqDCoMKgwqAgIzTCoCAweGZmZmZmZmZmODE3NjE4YjEgaW4gdmlydGNvbnNfcHJvYmUNCj4+Pj4+
PiAodmRldj0weGZmZmY4ODgwMDU4NWU4MDApIGF0IC4uL2RyaXZlcnMvY2hhci92aXJ0aW9fY29u
c29sZS5jOjIwOTgNCj4+Pj4+PiDCoMKgwqDCoCAjNcKgIDB4ZmZmZmZmZmY4MTcwNzExNyBpbiB2
aXJ0aW9fZGV2X3Byb2JlDQo+Pj4+Pj4gKF9kPTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJp
dmVycy92aXJ0aW8vdmlydGlvLmM6MzA1DQo+Pj4+Pj4gwqDCoMKgwqAgIzbCoCAweGZmZmZmZmZm
ODE5OGUzNDggaW4gY2FsbF9kcml2ZXJfcHJvYmUNCj4+Pj4+PiAoZHJ2PTB4ZmZmZmZmZmY4MmJl
NDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkcnY9MHhmZmZmZmZmZjgyYmU0MGMwDQo+Pj4+Pj4gPHZp
cnRpb19jb25zb2xlPiwgZGV2PTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVycy9iYXNl
L2RkLmM6NTc5DQo+Pj4+Pj4gwqDCoMKgwqAgIzfCoCByZWFsbHlfcHJvYmUgKGRldj1kZXZAZW50
cnk9MHhmZmZmODg4MDA1ODVlODEwLA0KPj4+Pj4+IGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgy
YmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0DQo+Pj4+Pj4gLi4vZHJpdmVycy9iYXNlL2RkLmM6
NjU4DQo+Pj4+Pj4gwqDCoMKgwqAgIzjCoCAweGZmZmZmZmZmODE5OGU1OGYgaW4gX19kcml2ZXJf
cHJvYmVfZGV2aWNlDQo+Pj4+Pj4gKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2
aXJ0aW9fY29uc29sZT4sDQo+Pj4+Pj4gZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTAp
IGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjgwMA0KPj4+Pj4+IMKgwqDCoMKgICM5wqAgMHhmZmZm
ZmZmZjgxOThlNjVhIGluIGRyaXZlcl9wcm9iZV9kZXZpY2UNCj4+Pj4+PiAoZHJ2PWRydkBlbnRy
eT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwNCj4+Pj4+PiBkZXY9ZGV2QGVu
dHJ5PTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6ODMwDQo+Pj4+
Pj4gwqDCoMKgwqAgIzEwIDB4ZmZmZmZmZmY4MTk4ZTgzMiBpbiBfX2RyaXZlcl9hdHRhY2gNCj4+
Pj4+PiAoZGV2PTB4ZmZmZjg4ODAwNTg1ZTgxMCwgZGF0YT0weGZmZmZmZmZmODJiZTQwYzAgPHZp
cnRpb19jb25zb2xlPikNCj4+Pj4+PiBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzoxMjE2DQo+Pj4+
Pj4gwqDCoMKgwqAgIzExIDB4ZmZmZmZmZmY4MTk4YmZiMiBpbiBidXNfZm9yX2VhY2hfZGV2IChi
dXM9PG9wdGltaXplZCBvdXQ+LA0KPj4+Pj4+IHN0YXJ0PXN0YXJ0QGVudHJ5PTB4MCA8Zml4ZWRf
cGVyY3B1X2RhdGE+LA0KPj4+Pj4+IGRhdGE9ZGF0YUBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAg
PHZpcnRpb19jb25zb2xlPiwNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGZuPWZuQGVudHJ5PTB4
ZmZmZmZmZmY4MTk4ZTdiMCA8X19kcml2ZXJfYXR0YWNoPikgYXQNCj4+Pj4+PiAuLi9kcml2ZXJz
L2Jhc2UvYnVzLmM6MzY4DQo+Pj4+Pj4gwqDCoMKgwqAgIzEyIDB4ZmZmZmZmZmY4MTk4ZGI2NSBp
biBkcml2ZXJfYXR0YWNoDQo+Pj4+Pj4gKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMw
IDx2aXJ0aW9fY29uc29sZT4pIGF0DQo+Pj4+Pj4gLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIzMw0K
Pj4+Pj4+IMKgwqDCoMKgICMxMyAweGZmZmZmZmZmODE5OGQyMDcgaW4gYnVzX2FkZF9kcml2ZXIN
Cj4+Pj4+PiAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xl
PikgYXQNCj4+Pj4+PiAuLi9kcml2ZXJzL2Jhc2UvYnVzLmM6NjczDQo+Pj4+Pj4gwqDCoMKgwqAg
IzE0IDB4ZmZmZmZmZmY4MTk4ZjU1MCBpbiBkcml2ZXJfcmVnaXN0ZXINCj4+Pj4+PiAoZHJ2PWRy
dkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQNCj4+Pj4+PiAu
Li9kcml2ZXJzL2Jhc2UvZHJpdmVyLmM6MjQ2DQo+Pj4+Pj4gwqDCoMKgwqAgIzE1IDB4ZmZmZmZm
ZmY4MTcwNmI0NyBpbiByZWdpc3Rlcl92aXJ0aW9fZHJpdmVyDQo+Pj4+Pj4gKGRyaXZlcj1kcml2
ZXJAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0DQo+Pj4+Pj4g
Li4vZHJpdmVycy92aXJ0aW8vdmlydGlvLmM6MzU3DQo+Pj4+Pj4gwqDCoMKgwqAgIzE2IDB4ZmZm
ZmZmZmY4MzJjZDM0YiBpbiB2aXJ0aW9fY29uc29sZV9pbml0ICgpIGF0DQo+Pj4+Pj4gLi4vZHJp
dmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6MjI1OA0KPj4+Pj4+IMKgwqDCoMKgICMxNyAweGZm
ZmZmZmZmODEwMDEwNWMgaW4gZG9fb25lX2luaXRjYWxsIChmbj0weGZmZmZmZmZmODMyY2QyZTAN
Cj4+Pj4+PiA8dmlydGlvX2NvbnNvbGVfaW5pdD4pIGF0IC4uL2luaXQvbWFpbi5jOjEyNDYNCj4+
Pj4+PiDCoMKgwqDCoCAjMTggMHhmZmZmZmZmZjgzMjc3MjkzIGluIGRvX2luaXRjYWxsX2xldmVs
DQo+Pj4+Pj4gKGNvbW1hbmRfbGluZT0weGZmZmY4ODgwMDNlMmY5MDAgInJvb3QiLCBsZXZlbD0w
eDYpIGF0DQo+Pj4+Pj4gLi4vaW5pdC9tYWluLmM6MTMxOQ0KPj4+Pj4+IMKgwqDCoMKgICMxOSBk
b19pbml0Y2FsbHMgKCkgYXQgLi4vaW5pdC9tYWluLmM6MTMzNQ0KPj4+Pj4+IMKgwqDCoMKgICMy
MCBkb19iYXNpY19zZXR1cCAoKSBhdCAuLi9pbml0L21haW4uYzoxMzU0DQo+Pj4+Pj4gwqDCoMKg
wqAgIzIxIGtlcm5lbF9pbml0X2ZyZWVhYmxlICgpIGF0IC4uL2luaXQvbWFpbi5jOjE1NzENCj4+
Pj4+PiDCoMKgwqDCoCAjMjIgMHhmZmZmZmZmZjgxZjY0YmUxIGluIGtlcm5lbF9pbml0ICh1bnVz
ZWQ9PG9wdGltaXplZCBvdXQ+KQ0KPj4+Pj4+IGF0IC4uL2luaXQvbWFpbi5jOjE0NjINCj4+Pj4+
PiDCoMKgwqDCoCAjMjMgMHhmZmZmZmZmZjgxMDAxZjQ5IGluIHJldF9mcm9tX2ZvcmsgKCkgYXQN
Cj4+Pj4+PiAuLi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjMwOA0KPj4+Pj4+IMKgwqDCoMKg
ICMyNCAweDAwMDAwMDAwMDAwMDAwMDAgaW4gPz8gKCkNCj4+Pj4+Pg0KPj4+Pj4+IEZpeCB0aGUg
cHJvYmxlbSBieSBwcmV2ZW50aW5nIHhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoKSBmcm9t
DQo+Pj4+Pj4gc2V0dGluZyBkb20wIGFzIGEgYmFja2VuZCB3aGVuIHJ1bm5pbmcgaW4gZG9tMC4N
Cj4+Pj4+Pg0KPj4+Pj4+IEZpeGVzOiAwMzVlM2E0MzIxZjcgKCJ4ZW4vdmlydGlvOiBPcHRpbWl6
ZSB0aGUgc2V0dXAgb2YNCj4+Pj4+PiAieGVuLWdyYW50LWRtYSIgZGV2aWNlcyIpDQo+Pj4+Pg0K
Pj4+Pj4NCj4+Pj4+IEkgYW0gbm90IDEwMCUgc3VyZSB3aGV0aGVyIHRoZSBGaXhlcyB0YWcgcG9p
bnRzIHRvIHByZWNpc2UgY29tbWl0LiANCj4+Pj4+IElmIEkNCj4+Pj4+IGFtIG5vdCBtaXN0YWtl
biwgdGhlIHNhaWQgY29tbWl0IGp1c3QgbW92ZXMgdGhlIGNvZGUgaW4gdGhlIGNvbnRleHQNCj4+
Pj4+IHdpdGhvdXQgY2hhbmdpbmcgdGhlIGxvZ2ljIG9mIENPTkZJR19YRU5fVklSVElPX0ZPUkNF
X0dSQU5ULCB0aGlzIHdhcw0KPj4+Pj4gaW50cm9kdWNlZCBiZWZvcmUuDQo+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFBhdmx1IDxwZXRyLnBhdmx1QHN1c2UuY29tPg0K
Pj4+Pj4+IC0tLQ0KPj4+Pj4+IMKgwqDCoCBkcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgfCA0
ICsrKy0NCj4+Pj4+PiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYyANCj4+Pj4+PiBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+Pj4+
IGluZGV4IDc2ZjZmMjYyNjVhMy4uMjllZDI3YWM0NTBlIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2Ry
aXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPj4+Pj4+IEBAIC0zNjIsNyArMzYyLDkgQEAgc3RhdGljIGludCB4ZW5fZ3Jh
bnRfaW5pdF9iYWNrZW5kX2RvbWlkKHN0cnVjdA0KPj4+Pj4+IGRldmljZSAqZGV2LA0KPj4+Pj4+
IMKgwqDCoMKgwqDCoMKgIGlmIChucCkgew0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0geGVuX2R0X2dyYW50X2luaXRfYmFja2VuZF9kb21pZChkZXYsIG5wLA0KPj4+Pj4+IGJh
Y2tlbmRfZG9taWQpOw0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zfbm9kZV9wdXQo
bnApOw0KPj4+Pj4+IC3CoMKgwqAgfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklS
VElPX0ZPUkNFX0dSQU5UKSB8fA0KPj4+Pj4+IHhlbl9wdl9kb21haW4oKSkgew0KPj4+Pj4+ICvC
oMKgwqAgfSBlbHNlIGlmICgoSVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFO
VCkgfHwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fcHZfZG9tYWluKCkpICYm
DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICF4ZW5faW5pdGlhbF9kb21haW4oKSkgew0K
Pj4+Pj4NCj4+Pj4+IFRoZSBjb21taXQgbGd0bSwganVzdCBvbmUgbm90ZToNCj4+Pj4+DQo+Pj4+
Pg0KPj4+Pj4gSSB3b3VsZCBldmVuIGJhaWwgb3V0IGVhcmx5IGluIHhlbl92aXJ0aW9fcmVzdHJp
Y3RlZF9tZW1fYWNjKCkgDQo+Pj4+PiBpbnN0ZWFkLA0KPj4+Pj4gYXMgSSBhc3N1bWUgdGhlIHNh
bWUgaXNzdWUgY291bGQgaGFwcGVuIG9uIEFybSB3aXRoIERUIChhbHRob3VnaCB0aGVyZQ0KPj4+
Pj4gd2UgZG9uJ3QgZ3Vlc3MgdGhlIGJhY2tlbmQncyBkb21pZCwgd2UgcmVhZCBpdCBmcm9tIERU
IGFuZCBxdWl0ZQ0KPj4+Pj4gdW5saWtlbHkgd2UgZ2V0IERvbTAgYmVpbmcgaW4gRG9tMCB3aXRo
IGNvcnJlY3QgRFQpLg0KPj4+Pj4NCj4+Pj4+IFNvbWV0aGluZyBsaWtlOg0KPj4+Pj4NCj4+Pj4+
IEBAIC00MTYsNiArNDIxLDEwIEBAIGJvb2wgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2Mo
c3RydWN0DQo+Pj4+PiB2aXJ0aW9fZGV2aWNlICpkZXYpDQo+Pj4+PiDCoMKgwqAgew0KPj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9taWRfdCBiYWNrZW5kX2RvbWlkOw0KPj4+Pj4NCj4+Pj4+
ICvCoMKgwqDCoMKgwqAgLyogWGVuIGdyYW50IERNQSBvcHMgYXJlIG5vdCB1c2VkIHdoZW4gcnVu
bmluZyBhcyBpbml0aWFsDQo+Pj4+PiBkb21haW4gKi8NCj4+Pj4+ICvCoMKgwqDCoMKgwqAgaWYg
KHhlbl9pbml0aWFsX2RvbWFpbigpKQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGZhbHNlOw0KPj4+Pj4gKw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCF4ZW5fZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKGRldi0+ZGV2LnBhcmVudCwNCj4+Pj4+ICZi
YWNrZW5kX2RvbWlkKSkgew0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKGRldi0+ZGV2LnBhcmVudCwNCj4+Pj4+IGJhY2tl
bmRfZG9taWQpOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiB0cnVlOw0KPj4+Pj4gKEVORCkNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IElmIHNv
LCB0aGF0IGNvbW1pdCBzdWJqZWN0IHdvdWxkIG5lZWQgdG8gYmUgdXBkYXRlZCBhY2NvcmRpbmds
eS4NCj4+Pj4+DQo+Pj4+PiBMZXQncyBzZWUgd2hhdCBvdGhlciByZXZpZXdlcnMgd2lsbCBzYXku
DQo+Pj4+DQo+Pj4+IFRoaXMgZG9lc24ndCB3b3JrIGluIGFsbCBjYXNlcy4gSW1hZ2luZSB1c2lu
ZyBQQ0kgUGFzc3Rocm91Z2ggdG8gYXNzaWduDQo+Pj4+IGEgInBoeXNpY2FsIiB2aXJ0aW8gZGV2
aWNlIHRvIGEgZG9tVS4gVGhlIGRvbVUgd2lsbCBydW4gaW50byB0aGUgc2FtZQ0KPj4+PiBlcnJv
ciwgcmlnaHQ/DQo+Pj4+DQo+Pj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgbmVlZCBhIHdheSBm
b3IgdGhlIHZpcnRpbyBiYWNrZW5kIHRvIGFkdmVydGlzZQ0KPj4+PiBpdHMgYWJpbGl0eSBvZiBo
YW5kbGluZyBncmFudHMuIFJpZ2h0IG5vdyB3ZSBvbmx5IGhhdmUgYSB3YXkgdG8gZG8gd2l0aA0K
Pj4+PiB0aGF0IHdpdGggZGV2aWNlIHRyZWUgb24gQVJNLiBPbiB4ODYsIHdlIG9ubHkgaGF2ZQ0K
Pj4+PiBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCwgYW5kIGlmIHdlIHRha2UNCj4+Pj4g
Q09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgYXQgZmFjZSB2YWx1ZSwgaXQgYWxzbyBlbmFi
bGVzIGdyYW50cyBmb3INCj4+Pj4gInBoeXNpY2FsIiB2aXJ0aW8gZGV2aWNlcy4gTm90ZSB0aGF0
IGluIHRoaXMgY2FzZSB3ZSBhcmUgZml4aW5nIGENCj4+Pj4gbmVzdGVkLXZpcnR1YWxpemF0aW9u
IGJ1ZywgYnV0IHRoZXJlIGFyZSBhY3R1YWxseSBwaHlzaWNhbA0KPj4+PiB2aXJ0aW8tY29tcGF0
aWJsZSBkZXZpY2VzIG91dCB0aGVyZS4gQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgd2ls
bA0KPj4+PiBicmVhayB0aG9zZSB0b28uDQo+Pj4NCj4+PiBJbiBjYXNlIHlvdSB3YW50IHZpcnRp
byBkZXZpY2UgcGFzc3Rocm91Z2gsIHlvdSBzaG91bGRuJ3QgdXNlIGEga2VybmVsDQo+Pj4gYnVp
bHQgd2l0aCBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVC4NCj4+Pg0KPj4+IEFuZCBzdXBw
b3J0aW5nIHBhc3NpbmcgdGhyb3VnaCB2aXJ0aW8gZGV2aWNlcyBvZiB0aGUgaG9zdCB0byBwdi1k
b21VcyBpcw0KPj4+IGEgc2VjdXJpdHkgcmlzayBhbnl3YXkuDQo+Pj4NCj4+PiBXZSBfY291bGRf
IGRyb3AgdGhlIHJlcXVpcmVtZW50IG9mIHRoZSBiYWNrZW5kIG5lZWRpbmcgdG8gc2V0DQo+Pj4g
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvciBQViBndWVzdHMgYW5kIGFsbG93IGdyYW50LWxl
c3MgdmlydGlvDQo+Pj4gaGFuZGxpbmcgZm9yIGFsbCBndWVzdHMuIEZvciB0aGlzIHRvIHdvcmsg
DQo+Pj4geGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2MoKQ0KPj4+IHdvdWxkIG5lZWQgdG8g
Y2hlY2sgZm9yIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBhbmQgcmV0dXJuIHRydWUgaWYgc2V0
Lg0KPj4+IE1heWJlIHdlJ2Qgd2FudCB0byBlbmFibGUgdGhhdCBwb3NzaWJpbGl0eSB2aWEgYSBi
b290IHBhcmFtZXRlcj8NCj4+DQo+Pg0KPj4gTWF5YmUsIHllcy4gSSBkb24ndCBzZWUgYXQgdGhl
IG1vbWVudCB3aHkgdGhpcyB3b24ndCB3b3JrLg0KPj4NCj4+IEF0IHRoZSBzYW1lIHRpbWUgSSB3
b25kZXIsIGNvdWxkIHdlIGp1c3QgbW9kaWZ5IHhlbl9wdl9pbml0X3BsYXRmb3JtKCkNCj4+IHRv
IGNhbGwgdmlydGlvX25vX3Jlc3RyaWN0ZWRfbWVtX2FjYygpIGlmIGZvcmNpYmx5IGRpc2FibGVk
IGJ5IGJvb3QNCj4+IHBhcmFtZXRlciBpcnJlc3BlY3RpdmUgb2YgVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNIHByZXNlbmNlPw0KPiANCj4gVGhpcyB3b3VsZG4ndCB3b3JrIGZvciB0aGUgY2FzZSB3
aGVyZSBhIGhvc3QgdmlydGlvIGRldmljZSBpcyBwYXNzZWQgDQo+IHRocm91Z2gNCj4gdG8gdGhl
IHB2IGRvbVUgYW5kIGF0IHRoZSBzYW1lIHRpbWUgYW5vdGhlciB2aXJ0aW8gZGV2aWNlIGlzIHVz
aW5nIGRvbTAgDQo+IGFzIGENCj4gYmFja2VuZC4gSSB0aGluayB3ZSBzaG91bGQgdXNlIGdyYW50
cyBpZiBwb3NzaWJsZS4NCg0KSW5kZWVkLCBJIG1pc3NlZCB0aGF0IHBvc3NpYmxlIHNjZW5hcmlv
LiBJIGFncmVlIHdpdGggdGhlIGV4cGxhbmF0aW9ucywgDQp0aGFua3MuDQoNCg0KPiANCj4gDQo+
IEp1ZXJnZW4NCj4g
