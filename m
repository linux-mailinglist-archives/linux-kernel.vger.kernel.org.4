Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020A8617AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKCKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:36:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2AD103;
        Thu,  3 Nov 2022 03:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0vNsDJeK6q908TgyepedYMVdJKHnVddhke0GvfqTx/hY4F0wBk3oEwoPy0pnCvDTCMaHntnxzdMEVfpeLD/KAu+k+wanhnJOqm3RG5fUw6JufM0S/A25necJH7MxbnFAtfw7pVe2+pXtcD+Gx99fR/9Cd+AZ/Q7vWz37GFz6KUYKz1ot6Sg30zCL15SnpX06RrCttlpeGYE1MbKGl4CyVOXzViB914Jy3sq6KDE85F87pafqFB0Lph12pV2JD+1n2sd4kB8OyeOF8bkP6+O6E8VxE4jAezyj/Euy7zupm1Q5CtaCpw+g0FpItXHt22isk9c5JjeC1VEbKH+sqNtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBhokYf6DFiIFGISReTfA3zALBCAuQJLjZRCmbPdsQE=;
 b=Y7RrwGPn5fCsk5TJ7YfU1nBy5cd3QxhdSvebmejrBhW6WyZDrnEKQyoNKNvpM4z6MVjEZRMwuogmqky5U2/YxIstRwLbhH6wtIt2RpTef08kWnpvsuxCyAFjf/pQhDMKwsg3EoVVxmKXsIX8WH7CsGVFitFHeUlqOQ9pcCd+E1jKrkPwPvSjVVpGqbFjey0X08VNI415Dlf8DPkahPDQ1VNpg0hc+STKCgquxrThuHI9tyB5hK0xp7A/qqk+PNcPEuAiHL2P9dtzDb4OE3qZT6VR6h+HnxlwQkbOIcmWizZh+4VpX4lmOqZSlEEw5FPfOz7uhos8Ym8XmsIBMSrRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBhokYf6DFiIFGISReTfA3zALBCAuQJLjZRCmbPdsQE=;
 b=PghWQtRzIUp2x0hl70QrKeKKB7yxS0Rk6Ao3Oa8s95k0/60pmzpoJRhG/6230XU9v5BgwkniqEMa96W8+sqNRGqxZzblH//bO9lXHeG6Ekeu1xtqLrkjokIKvYlXDbtCaVjAbDYOonfIEwLhEoaorlDPWah2dmD3sBkErgwuloLmiVObXcNhCplmymDUTxE5Zdgb+VAgvr9cCJcFnw2IjEhs+cXKg1kw6TPacXmt7ekGZAuigA3NdxHcn6uOKLqxlMhC/6OAwrZmyT/wXupEdLnyMCRWh9NtwTEryYyU+9oLNcmwHr7pF83fJGJVh19cYAs9Jqjpv3dBISU1SFpYNA==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SI2PR06MB5171.apcprd06.prod.outlook.com (2603:1096:4:1ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.16; Thu, 3 Nov 2022 10:36:34 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 10:36:34 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [PATCH 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHY7RSrQ+K+O9R23EOsQ/fWozuSOq4sJ8SAgAFkd4A=
Date:   Thu, 3 Nov 2022 10:36:33 +0000
Message-ID: <2508B515-E153-42C2-B013-2A64A110BCF2@aspeedtech.com>
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-2-billy_tsai@aspeedtech.com>
 <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
In-Reply-To: <ee6c5a96-81c4-5729-f623-4b23bc3b8e0a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SI2PR06MB5171:EE_
x-ms-office365-filtering-correlation-id: bc91ae84-d47a-4973-238d-08dabd874757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/wQ+05HWL0R4yK30dC2eocDlJ8LBB3kHPN7R2+8/widP1FGFoU3Ss4BDzAOhPJSHZCrEu4RsntNs1Xvxw2QotincSHlwhrWZjmqleJ036qaR9BkmmFKEMQIhXvXdkBf45QAm+grEVo3vaF/YpwoTiBai9umYXhAIGHjUjA6f9m4AQ8pSmgGO65g8a/7v61z5aopIFEGFekSvBSWBaIrrJdC1LZ2p31Hx4ymqZfeL01p61Tobmlp61BbCudgTQLFs8FNXJFWY1GyO/u/KPMWCPSNnVZ50bJfZEkWIKo2/oIJdL+KTWxmqx2PDfUfK7giQJvLCHPXzm9eJc4iuLAHUUM9QF2U8NcFJNvpb/cjg0lEMQCgTEVJXxUPzpptLlyDfnX/ifJEiHZ0Fwcv1nQmf33+qE+mKLaKeYVpGgWdUwSMtavrIoJ+zRdkupXegUVNNmu5uMibfeAyfb6L2AqrkbVi471I1bkisjAfTfcnq0VyygD6BchpOwu2vr6kmYmunE3iID4Ob6Q+u08/gy0tF0eQuG9TUPiAw4/aEWPwDd3LAVCMYTUQnI0GU5NZQIxte8EmSUvj5Wd1tPbXgD9Sv5u9Gd/fjmWyudU3b9UVk1hj6z5PHRWV1JgcMcEEwXU4qthIXSZ2ET/9DOtpX0+96ZYiFRzkm+80ODUl2f/bOIz0pDEI8dYS8FESWFI0mD2a6c+kOEvNefzrF+sAVejNRNrqBz3GxSElmpjkv4UqRJqOsLJF5TvjvOCXKDGGQyjwbigDuSjnbzqbQLnzX55HFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39850400004)(346002)(136003)(451199015)(8676002)(86362001)(36756003)(33656002)(110136005)(66476007)(186003)(5660300002)(41300700001)(2906002)(66946007)(66446008)(66556008)(38070700005)(122000001)(7416002)(316002)(6506007)(76116006)(91956017)(64756008)(38100700002)(921005)(8936002)(26005)(478600001)(53546011)(6486002)(6512007)(71200400001)(966005)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y094Q2J5UEVZeHRZU0xTZS9KcUNWTGNTVi9pdjBTNFo5cjFpa0w0VjRleEZW?=
 =?utf-8?B?eEdxVHRtU2IrVGM3WjVsWkJlOHVVTmZNUTR2emlodk53YmY0UmhDNWpqL0Zi?=
 =?utf-8?B?Snp5S1NQK3hhS2FIM1hUeUdmY01GdVFZSjREZVJjMDZwQmxIRjBMenRMMThC?=
 =?utf-8?B?T0szMFdNVUF2TmJ5MkdPYVhtcFAyVXdNSWNta0tldjZHa1owWHRESCtFUEhl?=
 =?utf-8?B?cHp4UHpHRnUwTCt4VmJmWjZ1TWYxTVlFc3Vvdk9ONlVxNjRkNEJVWEt5N1kx?=
 =?utf-8?B?RkV1SzZhVTlKbVQ1WnNVRjdaT1UyRU84clk1L0Flc0NIc2RiWXhoMjhQck90?=
 =?utf-8?B?a0xKbkNpSGR3SFVGZFplNGJCR1ArUWd1NUY5YjJzNjM2alNIOWh4WERreEJq?=
 =?utf-8?B?eHFkMkJuNkhnbGhKSWYwRVl1MnlZbW5BcFgxQ3o0QVVUWGt0Wk9WNFBUMmVz?=
 =?utf-8?B?UGlQZFlIMVdCamFIMUJqeXZRNndhYnhjcmR1ZUhwenJGWkRXZGxOQmhjNnVm?=
 =?utf-8?B?aGIvZjJtZmxlOUoyK3d1MCtTRTNPdS9jYXR6K2JBR2pIemR3czh2QytxQjV6?=
 =?utf-8?B?U3JybDlyQk9DL0JKeWpxNzF0ZE1mYXRyaWhCZ2lTTVVnYktwL0tUd3dJTk12?=
 =?utf-8?B?eEx0dVVVTEt0S0ZMaE0xWFNHM2ZhWFd3d0hRVklUSkFac1Z3MWxpVVN1UFd1?=
 =?utf-8?B?WGtHSGFOSWUyYXFxWFJ5L1I2UXdvV2hjcW9tVHBhODZyeER6UURudkhVL2or?=
 =?utf-8?B?aFV5bEZ6ZEtId1VJcE42VUw0dmRvUkU2cFRWbTRkNWs3MldYSVI2ZHI5N2pI?=
 =?utf-8?B?MHNQdlNteTFjQ0poWngvNmV2WUtwemM3eGNtdUlZa1RtU0FpOEk0VmN0bEZ5?=
 =?utf-8?B?SHMzczhFMlU5Z256ZjdCODNxcklZN2JGZEVZRitXRXVOSEFReGs0UlF1dUxC?=
 =?utf-8?B?Nk5Sc1ZjVTdqWU94ZnFBT244NkR5eDFyQjU1RzNmYXJUN0duQlFVVnNod0FX?=
 =?utf-8?B?aFlIL05YMzladko1K2dkeXZBWE9JT1lzL1pjalRoWSthaFRCajhlZlM1VzFX?=
 =?utf-8?B?b20vK09QdTFOdHFYTUdnZjNDZ2N0MW5KTjYybEtZT0NXRCtLaUUxUUpqaWtN?=
 =?utf-8?B?L1FQcS9UYkFFSmJRRFBUbGsxd0J5M2JPWmhuWjk3RnczcUFzVXpQKzMzSkxD?=
 =?utf-8?B?ZWkxTkJmeThRdWpPdjBFdGJhYkR6RHNXSmpxd0ZFUHBSTnhtd0RzWFFMNTJt?=
 =?utf-8?B?ZWVsNUlkQWI2bjVodjVtMEdOQTI0cy9GYWxNdWVJZ3FBTDRONDlTLzh6MFpD?=
 =?utf-8?B?UlUwWTV0NkpqRXprTVJyN082SkxHTEVFNE8vOElWckdaby9EYlovUWE0MTlr?=
 =?utf-8?B?ZEkreENZR1VyU3RwY3VLUW84a0NGeXlqU3hLb3R6R21UenB5VmtrcnowMi92?=
 =?utf-8?B?bERtY1VPZ2hhbXA1Ti9icVFhNXBacHIvV1FqODIrSjBhRmdXSFoyMHNpemJL?=
 =?utf-8?B?ZzNrSHUxQittZCtmT3JWbmhqTTNvd3lwY21UaHVFUjl3aUc4SjQrRWxKa05R?=
 =?utf-8?B?amJMSUFReExSb2F2TmJCNEpZM05KNFhubTNUcG9EVXRtZTdTTmljelBCM1ZM?=
 =?utf-8?B?UE53WnBFeWlHQjFLa0p3M0d2Z3pVS3QzQTFzMEpIMUg0S0kxQUxTTXVQTkFO?=
 =?utf-8?B?MTk5TnBhN05jempuUEpGOUk3NjBTMk5zTUdEUnJISGZxR3Q3NG5qRUNwUG1S?=
 =?utf-8?B?YjZ2THJFc2VrajR4KzFWSUc0T3pjNldQS3Q5anhFVkxJV0ozNGRUSHhZS1lt?=
 =?utf-8?B?aXM4UDdGZm1MeURrOHVtMUFGSy9lK2ZqR2ptTmZ4eFBiUmJubWFsOXhhOThm?=
 =?utf-8?B?NHJlcTJEeWtCWUVqdnMzVkRwdEJ5bXN2ZTA1UFhyK2JyVDlJMUlKWEIxWmVC?=
 =?utf-8?B?V2x1QXBkVWNxYlJxVUt1YXdTMnIyNnU5U3lVcExubHg1NmxvSnN5ZzRWSHNZ?=
 =?utf-8?B?eFJqeFFDTTJGU3BPTk9mbXlnR2hoNEFmOHVqdW5maUg1SDZwdi9DTFhqREQv?=
 =?utf-8?B?aTRwVnpzbWl4T1JtWGNscFZsaUs3NkhLVjh4UWJVNVFZQ2RpeXV3cTg4UURr?=
 =?utf-8?B?MGY4ZGZxVWxWYnBSVkVOZlBhSWs2dXpqQ1hMaGUzZFQwcU04Tll3NUc3amw4?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFB69F3AA72E344B06A0DC3F2278569@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc91ae84-d47a-4973-238d-08dabd874757
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 10:36:34.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDO29h5dfWJ8osOEWHrkICIhfqDaCycc2ZqmzmT2uuD7w1GkqC8Av0rlbdYr7IjAtJK0OVYRlrXQaC+0xrWtHknqa7aGx5MnQ7hJtM62zJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIyLzExLzMsIDU6MjAgQU0sICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6a0BrZXJu
ZWwub3JnPiB3cm90ZToNCg0KICAgIE9uIDMxLzEwLzIwMjIgMDY6MzgsIEJpbGx5IFRzYWkgd3Jv
dGU6DQogICAgPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCiAgICA+ID4gKyAgIl5wd20oQFswLTlh
LWZdKyk/JCI6DQogICAgPiA+ICsgICAgJHJlZjogLi4vcHdtL2FzcGVlZCxhc3QyNjAwLXB3bS55
YW1sDQoNCiAgICA+IEZ1bGwgcGF0aCwgc286IC9zY2hlbWFzL3B3bS9hc3BlZWQsYXN0MjYwMC1w
d20ueWFtbA0KDQogICAgPiBXaHkgdW5pdCBhZGRyZXNzZXMgYXJlIG9wdGlvbmFsPw0KDQogICAg
PiA+ICsNCiAgICA+ID4gKyAgIl50YWNoKEBbMC05YS1mXSspPyQiOg0KICAgID4gPiArICAgICRy
ZWY6IC4uL2h3bW9uL2FzcGVlZCxhc3QyNjAwLXRhY2gueWFtbA0KDQogICAgPiBEaXR0bw0KDQog
ICAgPiBXaHkgdW5pdCBhZGRyZXNzZXMgYXJlIG9wdGlvbmFsPw0KDQpUaGUgcHdtX3RhY2ggaXMg
bm90IHRoZSBidXMuIEkgd2lsbCB1c2UNCnB3bToNCiAgICB0eXBlOiBvYmplY3QNCiAgICAkcmVm
OiAiL3NjaGVtYXMvcHdtL2FzcGVlZCxhc3QyNjAwLXB3bS55YW1sIg0KDQp0YWNoOg0KICAgIHR5
cGU6IG9iamVjdA0KICAgICRyZWY6ICIvc2NoZW1hcy9od21vbi9hc3BlZWQsYXN0MjYwMC10YWNo
LnlhbWwiDQp0byByZXBsYWNlIGl0Lg0KDQogICAgPiA+ICsNCiAgICA+ID4gK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiBmYWxzZQ0KICAgID4gPiArDQogICAgPiA+ICtleGFtcGxlczoNCiAgICA+ID4g
KyAgLSB8DQogICAgPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAt
Y2xvY2suaD4NCiAgICA+ID4gKyAgICBwd21fdGFjaDogcHdtX3RhY2hAMWU2MTAwMDAgew0KDQog
ICAgPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljLg0KICAgID4gaHR0cHM6Ly9kZXZpY2V0
cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmlj
ZXRyZWUtYmFzaWNzLmh0bWwjZ2VuZXJpYy1uYW1lcy1yZWNvbW1lbmRhdGlvbg0KDQpUaGlzIGlz
IHRoZSBtZmQgd2l0aCBwd20gYW5kIHRhY2gsIHNvIHRoZXkgYXJlIGNvbWJpbmVkIGFzIHRoZSBu
b2RlIG5hbWUuDQoNCiAgICA+IE5vIHVuZGVyc2NvcmVzIGluIG5vZGUgbmFtZXMuDQoNCmh0dHBz
Oi8vZGV2aWNldHJlZS1zcGVjaWZpY2F0aW9uLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9jaGFw
dGVyMi1kZXZpY2V0cmVlLWJhc2ljcy5odG1sI3RhYmxlLTENCkkgc2VlIHRoYXQgdGhlIHVuZGVy
c2NvcmUgaXMgdGhlIHZhbGlkIGNoYXJhY3RlcnMgZm9yIG5vZGUgbmFtZXMuDQpEaWQgSSBtaXNz
IGFueSBpbmZvcm1hdGlvbj8NCg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkN
Cg0K
