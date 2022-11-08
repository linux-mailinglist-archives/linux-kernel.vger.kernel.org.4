Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AE620AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiKHICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiKHICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:02:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B12BC6;
        Tue,  8 Nov 2022 00:02:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNThIRVbD0+UAyxCtwp9nAP593q6G6szFECdlOENeolWi+FJVGjpC6qYwEII9LixFv3OzbXrO0uns8KhjgOP/myJtFVRmsxad2rvEqOw4soZDq56oOrK/y/cTdJOrgW84OxbSHwUiTZVG3GVa2p4MrzJetAEHX09RGVoE+MD+c/5NlWkJr0Wkp+LAFdKY3Lc1oRo69F+iLkKeAIF7W58P7by0uV9GRagcqxorz0GNOgaBZ1q0bdei0buZhaphACOWrEu0G85OAC+k9xQGgMNW6l2N7MI1qWILeVt+hQ1k5qLVHsQJkbs+4L3uD5gMLrgdsX1IZymAYEW+zTMi8gIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6e4dEHEnmcfy+63lg8kFCFfFn394/3Rou0IzfORSLg=;
 b=jpynoryCcUhQzWysnBXchx2BpTRqI56qkpFQX/SOY5r9Xkj4aJP6qEgR/Ssu/6pDFVFLOJ+2n/PCBqew7fErtfSY9DGzTIgMt+H00lqhpsWjNA/EqIRc07M0YYqPGAj37kD1aeaKJrxG6tFs2IFbYYXb8a3M4rcIaqyWoLmPmB8rD4uhSIDo+rGYk+cQLGjF21A+FsnabYtwPisinzi5Gj6k6XE62krR4VeMc/rTDB+grct6UlgwBweECxAcOb0AlJMq1I973JJq1g97/pH4pRgF6XSG8gbVMGhDI1Wy583dq6lqt9m/fnjxkK49o2FDniyJpbstUUZFun5e8LlkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6e4dEHEnmcfy+63lg8kFCFfFn394/3Rou0IzfORSLg=;
 b=0L4KfzvhA9XoeZt/GDLJzD3Mga44UZzxoTg59JRLHw6YhE7+Doj1lev32t0bpQNFyWcj6kxfoHgpt5I/F2F87BSaZq48QQdy5C3BaFSGrRCnhAatutduL3M0L5i27MP7P3twfaiquLs+30vXOTNatUfpo/rueAIEf5ET9/kDKclzGdJo1OkcOJj2fRaKh0OXW/NHqYrIh9pdNZCz/C+YQ5zgVmM5YP7ZXoAz9VvhbQh5inXAfXE30OivNt3bH7BhyZJYc0DXdZcuzIyhJ3C8O+LtKDQCiDU+0JuLCmh/c6yzG38JmsGIGVdcKhB3puP5oFol7MBqWC0OyxjZ6U0feA==
Received: from PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23e::20)
 by AS2PR10MB6662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 08:02:16 +0000
Received: from PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9a2:43d3:12c:f695]) by PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a9a2:43d3:12c:f695%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 08:02:16 +0000
From:   "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
To:     "rogerq@kernel.org" <rogerq@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Thread-Topic: Coverity: gpmc_is_valid_waitpin(): Control flow issues
Thread-Index: AQHY8IRB9ZtHrJ3BMEisffpY/LZZHq4zK+IAgAAAvQCAAYMsgA==
Date:   Tue, 8 Nov 2022 08:02:16 +0000
Message-ID: <b18cddde778ada5030f6a80308854cf9c0dc4d23.camel@siemens.com>
References: <202211041233.4D45359E7@keescook>
         <7cdf3d14-3f1b-7cd4-e8b9-e94b5359bf82@kernel.org>
         <e4e4c4f0-782b-9f89-d7a2-859c7759ca66@kernel.org>
In-Reply-To: <e4e4c4f0-782b-9f89-d7a2-859c7759ca66@kernel.org>
Reply-To: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5520:EE_|AS2PR10MB6662:EE_
x-ms-office365-filtering-correlation-id: 92e49db2-e90c-4b82-f893-08dac15f8d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g84LmPU7xpanX0Wqmc6e0jnLrV1nkB/qGMK/Zyr+Kqm276Xrfa5kSiq6JwuRyREdgNOST3bjDDX1HAUEUQE174FjDn/GNdVgRuXLgSCEyQzT7MS3Dr5yQNFSqvJwys0hK0w4WvurjAiofyxAMYKPGiBEpylugcaWVrad9RejnrOh9ma3lioDaenljBli6A3cCNJXpgIhnv/oSVBopx9YdcAmf2i4h3Tm4qCJj18cTEPXDonvKLNF+huEJk7qS7rYah3KwHQuxSUB0Jhk4RVbk6O1+9fyTQaaDXaiYEjtzN6gqNs1D1p0pFmNFTViJx8FPTLdtOQfWkRkYoPYW7jD+u4W700cZcfIYD7IorxsaKJdfZJjEXF8cLST9U5xoOhqOgKXlNztMsjOXHgOVEqq/OgwVoE8GWNg79rOfxVayMxD0NvzinlC6mss/3Yl6BRsrOZV8QIXESpEMrJBWYEXI6CHdw9F4c/84FxNKAb8iV2equ9qOSU9w0d98/dGitfOSoR3eu1vVx/hzTYHYjjCYbwIWhtT3UJ8aDiv7SdSsiqIcpu+UbCZvP9KV4b5M7k6dMHOgmRR8c8lIp62nJ052FincWrzBXzxZuGwWOoE+Blqog+KBluLDM/2B1zMozC2iFvXsmxFb2Z+j9sDtiPrD8ltl5kY0XvtPa2MZVJOL3suDZJxn4c1NzJzV5QlT4/uyxcgOcFpKotHGr/wScuTCkk0+CehxiLR/hgIs6y1bRvA4BWRhb7a3eAK1E36vWJ6I7DjiHGaizohX8lZEix35DJMgiOulI2/bG39oHWPyOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(86362001)(38070700005)(41300700001)(6512007)(478600001)(38100700002)(3450700001)(82960400001)(2906002)(122000001)(36756003)(2616005)(8936002)(186003)(8676002)(5660300002)(54906003)(64756008)(66556008)(45080400002)(966005)(66476007)(66446008)(4326008)(6486002)(71200400001)(110136005)(316002)(91956017)(83380400001)(76116006)(66946007)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VHdjdMR3BleHcxY3B5T1VMbTBYMUtRVzRTNUZ6cDZISEJCbno5bllLRDB0?=
 =?utf-8?B?YTFHcHRRRU5oMHN6bnhmK3ZvZGV2bFQ4RThoTUNaZ1I4Ky9RRnZhblo4VzYv?=
 =?utf-8?B?QUxGSXZKRkR1NldXYkxrRWNma0JNN2F0b05FZG03aTYrM1N5bXZXekV1cXVC?=
 =?utf-8?B?dHAzSHAwWENDUExlakpvL1NyejBkQjVXVkMwWUtIaWc0UHJoamphT2drUXkr?=
 =?utf-8?B?NmJ4NVU1L05DTDFuSlNpTmkraVQ0SWNmemJuYm5udFYzd0ZXVElNa3NkbkQw?=
 =?utf-8?B?b0gwaVY1aUIwdXdjb1Excmp0dnZQTzd6YldBR1JGREFZbk93dzVYREpBa0Nl?=
 =?utf-8?B?ZlBCU3BEZHduZ1pKQ04rWlNmOGIxWkM1MlJIalY1eDc1a1hlQXRydENBS1VD?=
 =?utf-8?B?MiswNTB0SG9BU0kzS2RsVkZYTGc0U1lxUllDVzFrVlgvL1krR3FsWjBsaTdY?=
 =?utf-8?B?TWsvNjRoNFJXWFk4a1QzYklsTmx4cnhzOEVuY2w4SDFjc0VvcDhPakFNN1VI?=
 =?utf-8?B?Z3U2amJjQTFMNE5IZzlLL0Y1MndBVXFQeWtIOHVBWlYzT0VHWjd3RGNQK3hT?=
 =?utf-8?B?cGJxY2piQVVWNDdnOWVWaXVNMFdMczNiaERINXhvU2VXWkplYkFpRXA1T2pm?=
 =?utf-8?B?RjI5SUQ5MENKY2NlMjdDOWY4Yy8rY1JRWk96OXVhY1p5WGJuWDR5TFE3QlZ1?=
 =?utf-8?B?L00vT2U2WWlkUDliaEdqQjB5K2dQSTM3RWV0REFQa2xMZDBZbnA3ZjNwZ0JK?=
 =?utf-8?B?eGdZTGJzU2p3QmV5Z3JGUGxzY3RFdlROajcvTGFRbkJYV0lYNzFYa0V2emx2?=
 =?utf-8?B?cmIzMWloRlBnMXIwYml0Q01VTkJoWFkra2hReXBaQlFUWGFsMjBwV1hjc2hV?=
 =?utf-8?B?SDUvME5lNjFuckZJT2tGQVprNTV2eTFJM3JOUW45bFhwMDdlY1NHWkpDVTZX?=
 =?utf-8?B?VS9jN05INFdlVTkxaGtyU0NLWDVtVGwzZWVoM2hEMW1rWlU5c1EreGJGbE1a?=
 =?utf-8?B?MW40MVBFd1VLWkdrUENJNzdHS2FlL0NtZi9ueWpiNWpvZ1hDOXNUSVRvdm9L?=
 =?utf-8?B?VWRZajM1NHk4MHVtNWpzdlpyeDRBSXRvOFBDN1FTUEVGKytrd0JGT3hpN1hu?=
 =?utf-8?B?QU1iTlU4VTNIeWxScE1HS25mWTMvbjZvbk9zWE1GTmRBSWRkb2N5Rjl0YTR0?=
 =?utf-8?B?dXArRXFqYnZXNCs5d0VvNlZFZmIyZzZtSTlIUUZScXZoT0FrZjBzdFU1UVNE?=
 =?utf-8?B?eDdMVE0vbEoxbWJXd3ZQQTkvc2c1Ky93R3J3cW1kN1E4Y1E4VVBGc00vVjFh?=
 =?utf-8?B?WTFCMnhPczk3TlRTTGZOajBNa3FaZk9HMGpVYmplNTlZOVpIRGhDTGlJRlBQ?=
 =?utf-8?B?bDlSSlRjNS9sZzJ5NnR4c0hsZUVvREZ0Z29NWGZnclptbmswWmxYak1WZW9F?=
 =?utf-8?B?YXB6eExJTUhmWnh3WHYvQmFLalBmbmdFV1l0dE56YlkwMnV3ZE5HaTJJSkpP?=
 =?utf-8?B?ajBvdWlYVVJiWSs0bE56TUNlWWY1NjBYZDhmN2VWKzIvcC9xV1VpNDNJZmk0?=
 =?utf-8?B?L2pKYVRjeU4rUHBsOG1wTFdVY1JJbXF6allxZ0JadVFzRHZQUXNBKzNLZWVS?=
 =?utf-8?B?OWNGcjhaZE9aODM1ZkFoVmhaUnRXZmFCSFF3aWpmTEtodGVmZDdnMHBBNDh0?=
 =?utf-8?B?UTNlQTVzZ040eSsxcU1CeXE2aFhnZFN5ekhUcm9EdXAvdmJYVFpOcGpUYnpP?=
 =?utf-8?B?R0VGdmlISGhFTjR4UTBLYzdGeE9PT2FtREs2eDNhY3R4WFV4VnFURXpNNkl1?=
 =?utf-8?B?cTIxK0hOa1ZWYitVbDRVRFlvamJzNks5RUR3V2FscEp3RGJ5a2Fsc09nYkN4?=
 =?utf-8?B?eVZMSXVJM2JxQk1weEZRZER2U3BoSVVsUU1IdEFEZHI3dFlXSkZPYTR1MW1o?=
 =?utf-8?B?NnZGa1pXNVNYKzg5MkliWG5UenV5M054Mm1TaFNVd3VMOGZYazBqV2ExSEFi?=
 =?utf-8?B?T0R1OUI4UkxGVmZGYUlhajVxQWhDdFN1Q215ckVzRU41UlpxLzBkOEtjWUM1?=
 =?utf-8?B?andrZDhQeWlaZHdCVm92d3dIa2xSdU5Vb3V3Rm9sTnpMRFdJbHVrbHRCbkFJ?=
 =?utf-8?B?T1pRNC9acmNRUkR3WkNKSkljNWhOUXoxSTlZUkdjRVdCUjN4WVVUTVF0bWp6?=
 =?utf-8?B?UlV2UlhLUVFvSWwxc21HR1d1dWIzNmc2bktkOWloZ2NqaExaRnJCVEpiTXJh?=
 =?utf-8?Q?HqX8sN6nqFMMxMKnaWoS9LAEwdae1VuTNqInjW/8x0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <564EA4EEEE40BB4699BF00FD77CC2E74@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5520.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e49db2-e90c-4b82-f893-08dac15f8d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 08:02:16.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWd0l3YDhfew3oWdgHhUe66LPfrGTVHB7QQNodMWJkEiAROPxDwtnlVN3kD1rNVefOdgPCfKjy3WAri4/fCUjsOPHTI0N3lkeIDrwrAI1MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6662
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDEwOjU2ICswMjAwLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiANCj4gT24gMDcvMTEvMjAyMiAxMDo1MywgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPiBIaSBC
ZW5lZGlrdCwNCj4gPiANCj4gPiBPbiAwNC8xMS8yMDIyIDIxOjMzLCBjb3Zlcml0eS1ib3Qgd3Jv
dGU6DQo+ID4gPiBIZWxsbyENCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBhbiBleHBlcmltZW50YWwg
c2VtaS1hdXRvbWF0ZWQgcmVwb3J0IGFib3V0IGlzc3VlcyBkZXRlY3RlZCBieQ0KPiA+ID4gQ292
ZXJpdHkgZnJvbSBhIHNjYW4gb2YgbmV4dC0yMDIyMTEwNCBhcyBwYXJ0IG9mIHRoZSBsaW51eC1u
ZXh0IHNjYW4gcHJvamVjdDoNCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnNjYW4uY292ZXJpdHkuY29tJTJGcHJv
amVjdHMlMkZsaW51eC1uZXh0LXdlZWtseS1zY2FuJmFtcDtkYXRhPTA1JTdDMDElN0NiZW5lZGlr
dC5uaWVkZXJtYXlyJTQwc2llbWVucy5jb20lN0MxYTI1Y2M4NzA0NTI0ZjI0MjI0MTA4ZGFjMDlk
ZmFiNyU3QzM4YWUzYmNkOTU3OTRmZDRhZGRhYjQyZTE0OTVkNTVhJTdDMSU3QzAlN0M2MzgwMzQw
ODE5OTQwODc0NjElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlM
Q0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3
QyU3QyZhbXA7c2RhdGE9VzFLbEJLZzlud0VEZkZBYnFXNkp3N3YxZDQ2SFFMajhSWDh3bFo5Ukh5
YyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4gDQo+ID4gPiBZb3UncmUgZ2V0dGluZyB0aGlzIGVt
YWlsIGJlY2F1c2UgeW91IHdlcmUgYXNzb2NpYXRlZCB3aXRoIHRoZSBpZGVudGlmaWVkDQo+ID4g
PiBsaW5lcyBvZiBjb2RlIChub3RlZCBiZWxvdykgdGhhdCB3ZXJlIHRvdWNoZWQgYnkgY29tbWl0
czoNCj4gPiA+IA0KPiA+ID4gICBXZWQgTm92IDIgMTA6MDI6MzkgMjAyMiAtMDQwMA0KPiA+ID4g
ICAgIDg5YWVkM2NkNWNiOSAoIm1lbW9yeTogb21hcC1ncG1jOiB3YWl0IHBpbiBhZGRpdGlvbnMi
KQ0KPiA+ID4gDQo+ID4gPiBDb3Zlcml0eSByZXBvcnRlZCB0aGUgZm9sbG93aW5nOg0KPiA+ID4g
DQo+ID4gPiAqKiogQ0lEIDE1MjcxMzk6ICBDb250cm9sIGZsb3cgaXNzdWVzICAoTk9fRUZGRUNU
KQ0KPiA+ID4gZHJpdmVycy9tZW1vcnkvb21hcC1ncG1jLmM6MTA0OCBpbiBncG1jX2lzX3ZhbGlk
X3dhaXRwaW4oKQ0KPiA+ID4gMTA0MiAgICAgCXNwaW5fdW5sb2NrKCZncG1jX21lbV9sb2NrKTsN
Cj4gPiA+IDEwNDMgICAgIH0NCj4gPiA+IDEwNDQgICAgIEVYUE9SVF9TWU1CT0woZ3BtY19jc19m
cmVlKTsNCj4gPiA+IDEwNDUNCj4gPiA+IDEwNDYgICAgIHN0YXRpYyBib29sIGdwbWNfaXNfdmFs
aWRfd2FpdHBpbih1MzIgd2FpdHBpbikNCj4gPiANCj4gPiBXZSB3aWxsIG5lZWQgdG8gY2hhbmdl
IHRoaXMgd2FpdHBpbiBhcmd1bWVudCB0byBpbnQuDQo+ID4gSW4gYWRkaXRpb24gd2Ugd2lsbCBh
bHNvIG5lZWQgdG8gY2hhbmdlDQo+ID4gc3RydWN0IGdwbWNfd2FpdHBpbi0+cGluIGFuZCBzdHJ1
Y3QgZ3BtY19zZXR0aW5nLT53YWl0X3Bpbg0KPiA+IHRvIGludCBhcyBpbiB0aGUgY29kZSB3ZSBh
cmUgcmVseWluZyBvbiBHUE1DX1dBSVRQSU5fSU5WQUxJRCBsb2dpYyB3aGljaCBpcyAtMS4NCj4g
DQo+IEFub3RoZXIgYWx0ZXJuYXRpdmUgd2l0aCBsZXNzIGNodXJuIGlzIHRvIGxlYXZlIHRoZW0g
YXMgdTMyDQo+IGJ1dCBtYWtlIEdQTUNfV0FJVFBJTl9JTlZBTElEIHNldCB0byBhIGxhcmdlIHBv
c2l0aXZlIG51bWJlci4NCk9rLCBJIHdpbGwgZml4IHRoYXQuIA0KRG8gSSBuZWVkIHRvIHNlbmQg
YSBuZXcgZml4LXBhdGNoIG9uIHRvcCB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXM/IA0KT3Igc2hv
dWxkIEkganVzdCBzZW5kIG9ubHkgdGhlIGJ1Z2ZpeC1wYXRjaCBmb3IgdGhlIGNvdmVyaXR5LWJv
dD8gDQoNCg0KPiANCj4gPiA+IDEwNDcgICAgIHsNCj4gPiA+IHZ2diAgICAgQ0lEIDE1MjcxMzk6
ICBDb250cm9sIGZsb3cgaXNzdWVzICAoTk9fRUZGRUNUKQ0KPiA+ID4gdnZ2ICAgICBUaGlzIGdy
ZWF0ZXItdGhhbi1vci1lcXVhbC10by16ZXJvIGNvbXBhcmlzb24gb2YgYW4gdW5zaWduZWQgdmFs
dWUgaXMgYWx3YXlzIHRydWUuICJ3YWl0cGluID49IDBVIi4NCj4gPiA+IDEwNDggICAgIAlyZXR1
cm4gd2FpdHBpbiA+PSAwICYmIHdhaXRwaW4gPCBncG1jX25yX3dhaXRwaW5zOw0KPiA+ID4gMTA0
OSAgICAgfQ0KPiA+ID4gMTA1MA0KPiA+ID4gMTA1MSAgICAgc3RhdGljIGludCBncG1jX2FsbG9j
X3dhaXRwaW4oc3RydWN0IGdwbWNfZGV2aWNlICpncG1jLA0KPiA+ID4gMTA1MiAgICAgCQkJICAg
ICAgc3RydWN0IGdwbWNfc2V0dGluZ3MgKnApDQo+ID4gPiAxMDUzICAgICB7DQo+ID4gPiANCj4g
PiA+IElmIHRoaXMgaXMgYSBmYWxzZSBwb3NpdGl2ZSwgcGxlYXNlIGxldCB1cyBrbm93IHNvIHdl
IGNhbiBtYXJrIGl0IGFzDQo+ID4gPiBzdWNoLCBvciB0ZWFjaCB0aGUgQ292ZXJpdHkgcnVsZXMg
dG8gYmUgc21hcnRlci4gSWYgbm90LCBwbGVhc2UgbWFrZQ0KPiA+ID4gc3VyZSBmaXhlcyBnZXQg
aW50byBsaW51eC1uZXh0LiA6KSBGb3IgcGF0Y2hlcyBmaXhpbmcgdGhpcywgcGxlYXNlDQo+ID4g
PiBpbmNsdWRlIHRoZXNlIGxpbmVzIChidXQgZG91YmxlLWNoZWNrIHRoZSAiRml4ZXMiIGZpcnN0
KToNCj4gPiA+IA0KPiA+ID4gUmVwb3J0ZWQtYnk6IGNvdmVyaXR5LWJvdCA8a2Vlc2Nvb2srY292
ZXJpdHktYm90QGNocm9taXVtLm9yZz4NCj4gPiA+IEFkZHJlc3Nlcy1Db3Zlcml0eS1JRDogMTUy
NzEzOSAoIkNvbnRyb2wgZmxvdyBpc3N1ZXMiKQ0KPiA+ID4gRml4ZXM6IDg5YWVkM2NkNWNiOSAo
Im1lbW9yeTogb21hcC1ncG1jOiB3YWl0IHBpbiBhZGRpdGlvbnMiKQ0KPiA+ID4gDQo+ID4gPiBU
aGFua3MgZm9yIHlvdXIgYXR0ZW50aW9uIQ0KPiA+ID4gDQo+IA0KPiBjaGVlcnMsDQo+IC1yb2dl
cg0KY2hlZXJzLA0KYmVuZWRpa3QNCg0K
