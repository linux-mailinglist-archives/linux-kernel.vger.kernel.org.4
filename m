Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790670F54F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEXLcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:32:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5CC12E;
        Wed, 24 May 2023 04:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLbrb0JRV7VwUlSpdl0DZT7Zq9xA0lDs8R1vMK/i/vm2Yt68jdgawpI44JwhDIauJu6QqWaoAE08UznLAaQuWDXpAtY7+tvYY9DDEr5mXcsb686PCsoKXwEcpBNXnvPiMZdgr93cSC14seAy0FK9ynN62PMtLbku+iNxgOP5Y8ZXTwmXRMgWnkGw6U24rhpNXRcMpw/wzCU88WYQNLURqYUuCtT/AMdx2KFkIyMVxFoxgreKJCFINdB0y5N7pVMxOmYye92g0lKAOJU8nU+O2taLjrnlFytRL3jeq9MhTlTIYpLI46P3PbzecqQnjUE5z4lm6pqnH2oNBNghWiHtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qSc3/fY0W/zzZkOCK6y4Zen5squZ9tmaDQBou4NBzI=;
 b=aRr0U+tdJBbYYaeAvGcKWXT+A4nqfl58cgQPQjmWyrnYt/pnKf/ToZQ+T+GMN+e8wHeddJB/DbR48paMGkOY+uvXSDbr5iA7+b5YVdwl77FgJURdU+sCyOJn9ws+tXBZI3vHo/Xe1JBBwEOAzm5pHi33F14lbbfjiQ1cz/cqG9hCfO5CK6nFnPAX9U3uPrzk9+bsFNuJKk4RwPRt+vHBVYWjtF7tYENHOOEiXsmDJSXDBy8iUR5n9IRtedoqwMNs13AHfYM58h4dqsI9i5CkzG+KxCgcqPMmM7IovENptAkmYs/xTkhEW8t9gIx5iITlTW/TStzA4C4BxSg0TeT3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qSc3/fY0W/zzZkOCK6y4Zen5squZ9tmaDQBou4NBzI=;
 b=VoKUjK5IFNtP4nl6jujGybWH8d0QE8FYz0D8TobDePkFWM9BFjagCJbyCI1FpUfVFBia6KNV4Do1YwB9WMpgeY6sZEniNZQVvhFgQkiRvnyrMcgjJCA7LoJqzXWoxDvrt8GEajo6mUrIPT7HxDr7fqQa0RUUPxQHnOF/BAnleA4=
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com (2603:10a6:102:1bc::10)
 by PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 11:32:24 +0000
Received: from PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2]) by PAXPR04MB8304.eurprd04.prod.outlook.com
 ([fe80::513b:76ce:48c9:f9f2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 11:32:24 +0000
From:   Zhipeng Wang <zhipeng.wang_1@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2] cpufreq: dt-platdev: Add MODULE_LICENSE
Thread-Topic: [EXT] Re: [PATCH 1/2] cpufreq: dt-platdev: Add MODULE_LICENSE
Thread-Index: AQHZjhJoUJyJR7FLt0uquZN8xtUGNK9pPXCAgAAI/cA=
Date:   Wed, 24 May 2023 11:32:24 +0000
Message-ID: <PAXPR04MB8304E7A86D98E5785B6EC52AEB419@PAXPR04MB8304.eurprd04.prod.outlook.com>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
 <20230524104501.uhgs6geb5dtk3wnt@vireshk-i7>
In-Reply-To: <20230524104501.uhgs6geb5dtk3wnt@vireshk-i7>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8304:EE_|PAXPR04MB8909:EE_
x-ms-office365-filtering-correlation-id: 4d5668e5-0fe7-46f9-a7a3-08db5c4a8ba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCW0wmpURZZOYpp5hGuf8LKi40nhfl6vwePXsksSifORmcbX3peW9Tk5sRm0RWzNxTZUq4gP3L0boCh531AQaKBinqrAQJgAfBVzK/ayYVK0PS406IBal6d4awTJl/fqw6z6P3Rr8j/EB5s3FIv/YCLyNTO3qSQ2GJjQNO+aeQ7qOUr24nwV0MicgXR30HxSdir7qC3kdWmX1ZAX7IdfzoZUeW9r7bRZ1xfCgjFuZALESQySibn5jRBKgFSceGivoLTUUOL22Nk7VCvl9b2baYMHhH2Ie1VLc4GpiPqADMCte6O9ib4v8MTAWVRPDaIxVwL8SoCwC0oB4EYOti+1sqHH2mU9bEVP2vN6nT0Iyi6UAMzoQpYPEGL1ClXGYes75qezWLH/cI6eQNSD4vhSxd6L7yuYVbboW/ZwpSishYZ3I9Jk0q8BbfAplZ31012CrD46dxBBH+LAwYNVpJQg2F+pKL2s0T5N99fdyd6PRlSxBQxBPEOEeapLJWLvmHV7q+R10dOqRjexzrY8nBsqNawJ0j/wOO9Bf9sqOhZMDvcNTfFavwaUrzdOEsw3dPlouigy1eEoFMITRh8eGarZ0xrRe45f/Stlriyv6f4w5ZPwvWZ9tmrZOOBMv/PO0f+E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8304.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(86362001)(8676002)(52536014)(8936002)(2906002)(66556008)(66446008)(66476007)(64756008)(76116006)(66946007)(38070700005)(4326008)(6916009)(316002)(478600001)(41300700001)(5660300002)(54906003)(38100700002)(7696005)(71200400001)(122000001)(55016003)(53546011)(186003)(6506007)(9686003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S0JHa3U3MzRwU3hQN0h2Y1pERzA1a2I2bkFmeGx4Nm1zR09kT3BKM29KdHFR?=
 =?gb2312?B?dTRJb2VxQzJOeVVMMjhmR0dnOHprTGViUWYyam1jSUZPMkptdWxDNUkrYUM4?=
 =?gb2312?B?bWJsUGxhdWJjN3EwYitaWUszN3Y4NjRuN2EycE9ranJOcURTU0Yxall4NTd5?=
 =?gb2312?B?K2ZKMEZNalR1K1grTVRGMXBzYndGMW1KNldPYlR1RmJUa1FYNm90RVJPMGwz?=
 =?gb2312?B?T21tU0R2blc2bDVyV0hDVml2WjRHOHgvS3d2amp2bTlsenNybTZXejhlUDJl?=
 =?gb2312?B?NXgzWW9lemRZWjBEN3NUZldFeFhVdDcwVExOYnJ3SnM2ZG0rL3A4THhpRk15?=
 =?gb2312?B?QlVkN0tEcnJla2VTK2tGRUZXUTMyN29MamVaRlM3UUhoSWtCTjU2UEVVK3pi?=
 =?gb2312?B?K01qVmtxZlpKZkovbmhtUmRRYVZOUnpObDFQUUNxcm5BSzFxUUlXNUpiRjlr?=
 =?gb2312?B?SGRpSm50cmJHQUYvcnVXUWhNRW1ITFU3NVJ4dU1CdFRwL0VLSjVRZ1J2VXln?=
 =?gb2312?B?S2tydm9qQ1FjZDJ4bWJIZzZZdTFLSGl5L2FzNnFnMytqVG1yZkNBUTBHeE53?=
 =?gb2312?B?cjFDTVAvd2N2eTE0d0pIM0pUK1BoZjZZRTZWZ0drQ0VpUVhzM0FzV1Y2S25n?=
 =?gb2312?B?eGRNd0tZa1VQR2RiRjZ5d0hPVDFqMDhYQi9BUzIzMmY3cjhNVExLNFowdnhq?=
 =?gb2312?B?RzYvWDFLbk44NnJoSzI3OXMveThVdDJZcm9nRm5rbWRmWXU2R1h4d05WbkZJ?=
 =?gb2312?B?ZGQwdEI3UGEyckZuVmNiTFhpTXNtdFMyVVhpRitTcmRQMmZTN3Y5cUkvQTRp?=
 =?gb2312?B?NmhQZVFFTWZLU25RSDZwMGpQWEEreGdUSVFPUlRtTTFzbmJPZ3BWS1piSVI4?=
 =?gb2312?B?cUFSaG40ODRoN3FNNW1iU012b1llMjM0dXBLcTdKOE1VMms3WTB6UzBKWnBt?=
 =?gb2312?B?dlZyMkRaazdQUE02bURndy94ZDZVdHRWQnlsNUZsb0JHN05ZWVlvWmdtZ1JW?=
 =?gb2312?B?OXYvVTYrK2phOGt3N3FIRXlsSGdyNHNDOEVCakhVOHJROHZXTWUzR01JakxP?=
 =?gb2312?B?MVhiNks5Uk5SOTJyRk1IM1QyU2R2aXErM0M1Zy9HSWdTQ3VMSjd4RGdmYVpS?=
 =?gb2312?B?MSthenJWaTVNb1RwNnhjbGlJdWZYTWxIcEEyRkl4WmkzMVZQRERsMitGekRr?=
 =?gb2312?B?Um1qdmpzWnh5QTVoT290dlZzZDgrSUtiUHpMTXI4SlBEN3ZiazNPUXZ4Qnoz?=
 =?gb2312?B?RXRIaVVXVVNKTU9lY2ZJZ2t3MFQrVzdFMTl1Um5yUFc2SGNENUdtdUdRbzZJ?=
 =?gb2312?B?L2Rjak1yeFZLd0U1WDd5M0ErRy9GRGFVT1BGSE1BTm5JOWRoQzJTeTMvSWZv?=
 =?gb2312?B?NkwyTEpYM1k0MTJKbFdkemZ6TlJaVHh3dkppMGtaazJaU0JkangvVXYvNlJV?=
 =?gb2312?B?YXdTQlhjbXp6d1NucmpKajNTYkNSMkNtRjdBVjJ4aDZUY3FHQVQ4MnhqWHAr?=
 =?gb2312?B?YllOQk1CaVlMQktuek1pSGwrL204b2YzRTZUV0JGcnFtcXI5NmJvWmhKQ1JS?=
 =?gb2312?B?b0VhZFJzMytmeWI1ZzZsRk1XdWp5L2JJL0tsOTBIa0IxU1JaRmZ0amk1WDEz?=
 =?gb2312?B?ZGNOclpxRHRoR3FHMnltSTByRDdsRlJLZ093N3BNSC81b1FjZXFZOVRRemdD?=
 =?gb2312?B?S1FVS0ljb2crTFFxTTBOb1RXTmZYNEtiYTZXNU1WTnFnUGZTNjZUNVpZRWFH?=
 =?gb2312?B?WDdNZVFTUFV2UW5pK0ZsS0FyY00wZ0tuUjF4YXI2UEc1YTFXRTJvN2YxdUtm?=
 =?gb2312?B?K2QyUzBjekxNS1BXb2V6eHNWMVZpYWVIV0FoSGhubEpYZkczUk1acm94SVNH?=
 =?gb2312?B?MUlUc2RvWUhLNG11dHJHeDc4TTNxVTZKUDFWRlRqZWVPOVJtYXhzZkhkU1dt?=
 =?gb2312?B?bk1UYlF3aGw4b0pSeEhLNUIwejRYdmtqTFR0dzg3QU1ua1kzTXVIQjBURXVZ?=
 =?gb2312?B?ZCtnY1FCSkNQWWJ6TktuQWtaVVVvSlprTHVId0NBNEY2SW9oc0JjSW1jS291?=
 =?gb2312?B?dENRUmorejRzRGdxTmhqaEtDYmpFajhqSWs2b2pLSGVQdUEvR24xZEdqTmMy?=
 =?gb2312?Q?jwyg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8304.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5668e5-0fe7-46f9-a7a3-08db5c4a8ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 11:32:24.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTTbNzX+Rji26cDiS/PKwLGmStiqTstzXar0LLLCNDNHeIO+QEHjFFsImYkYeuXyU6ZLIwBBz/wa0/+hJKxEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBhbSB3b3JraW5nIG9uIGVuYWJsaW5nIHN1cHBvcnQgZm9yIEdvb2dsZSdzIEdlbmVyaWMgS2Vy
bmVsIEltYWdlIChHS0kpIHByb2plY3Qgb24gb3VyIGJvYXJkcyAobWVrXzhxeHAgYW5kIDhxbSku
IA0KVGhlIGNwdWZyZXEtZHQgZHJpdmVyIGFscmVhZHkgc3VwcG9ydHMgbW9kdWxhcml0eSwgYW5k
IHRoZSBjcHVmcmVxLWR0LXBsYXRkZXYgaXMgYWxzbyByZXF1aXJlZC4gRnJvbSBteSB1bmRlcnN0
YW5kaW5nLCBjcHVmcmVxLWR0LXBsYXRkZXYgaXMgbm90IG5lY2Vzc2FyaWx5IHJlcXVpcmVkIHRv
IGJlIGJ1aWx0IGluLCBhcyBpdCBkb2VzIG5vdCBhZmZlY3QgdGhlIGJhc2ljIGJvb3QgcHJvY2Vz
cy4gVGhlcmVmb3JlLCBJIHdvdWxkIGxpa2UgdG8gbWFrZSBpdCBzdXBwb3J0IGJ1aWxkaW5nIGFz
IGEgbW9kdWxlLg0KDQpCUnMsDQpaaGlwZW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gU2Vu
dDogMjAyM8TqNdTCMjTI1SAxODo0NQ0KPiBUbzogWmhpcGVuZyBXYW5nIDx6aGlwZW5nLndhbmdf
MUBueHAuY29tPg0KPiBDYzogcmFmYWVsQGtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gY3B1ZnJlcTogZHQtcGxhdGRldjogQWRkIE1PRFVMRV9MSUNFTlNFDQo+IA0K
PiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdo
ZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3Vi
dCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1
dHRvbg0KPiANCj4gDQo+IE9uIDI0LTA1LTIzLCAxNTozNCwgWmhpcGVuZyBXYW5nIHdyb3RlOg0K
PiA+IEFkZCBNT0RVTEVfTElDRU5TRSB0byBzdXBwb3J0IGJ1aWxkaW5nIGFzIG1vZHVsZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXBlbmcgV2FuZyA8emhpcGVuZy53YW5nXzFAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEtZHQtcGxhdGRldi5jIHwg
MSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LXBsYXRkZXYuYw0KPiA+IGIvZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXEtZHQtcGxhdGRldi5jDQo+ID4gaW5kZXggMzM4Y2Y2Y2M2NTk2Li41
NDUyOWFhMTZkNTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEtZHQt
cGxhdGRldi5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEtZHQtcGxhdGRldi5j
DQo+ID4gQEAgLTIxNCwzICsyMTQsNCBAQCBzdGF0aWMgaW50IF9faW5pdCBjcHVmcmVxX2R0X3Bs
YXRkZXZfaW5pdCh2b2lkKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KHN0cnVjdA0KPiA+IGNwdWZyZXFfZHRfcGxhdGZvcm1fZGF0YSkpKTsgIH0NCj4gPiBjb3JlX2lu
aXRjYWxsKGNwdWZyZXFfZHRfcGxhdGRldl9pbml0KTsNCj4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQ
TCIpOw0KPiANCj4gQW55IHNwZWNpZmljIHJlYXNvbiB3aHkgeW91IG5lZWQgdGhpcyBhcyBhIG1v
ZHVsZSA/IEp1c3QgY3VyaW91cy4NCj4gDQo+IC0tDQo+IHZpcmVzaA0K
