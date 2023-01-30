Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D63680843
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjA3JMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjA3JMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:12:15 -0500
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE39F;
        Mon, 30 Jan 2023 01:12:13 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 30U9BXCt022473; Mon, 30 Jan 2023 18:11:33 +0900
X-Iguazu-Qid: 2wGrJGZWBha4kuhCh3
X-Iguazu-QSIG: v=2; s=0; t=1675069892; q=2wGrJGZWBha4kuhCh3; m=Wc4fttOwCOoD3SZF3slSx6FUjipIF61jET9Cax4Ip4Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1110) id 30U9BUwP010267
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Jan 2023 18:11:31 +0900
X-SA-MID: 49980417
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm4VP2FIMzpILiprdt1zE3j0JHqa85iq3UB2vdbiq4cAJGd5jOEhjtRhfx9u57NXaCB8Cn+uUdiF6cCVOtQ8ia4+N7GpO2RS/IDPdlt2+WQqDVBLiEncWDyEKzFjcwepdQTqE5ru3Hycrn/jPhR9dsPV9CXRzqSWUpGdNh9Wq6S52adAQtHmFbhT6kRwKCE1X7Nv4MD5rhjzRbQldLd3ndMx7sTedFdMJ4swdbZIUYlnO7Bl9G2cgFxuEoAqcTAMXfqk6tRFWZL5qIXZd8ox7nk0SnXZ7+1I5SsuGJtFcNvG4mmmIYB/y78SQzv0mrfpo1CE6KUv1UApmsN0Oa83LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmNb9XbbB+kGHz5pg74dy1arwaVj/67VfxuUbN9DILg=;
 b=e0sKin5PVqxkLNW438o4yFoAYc9Dsea3eRRFCNU19xVwoj/sSluPXzXKFEbkKDiG1dncSyv7KRxfbaZIdKe2EsZrEE3rDu/b3RYCZL030KA1EB4FyeFRctfPRs9f6/h6hJTywRfqjTU9+0ELwClIrje4RLrL4XU+Kvs/8ianWRc9QlCB0vB3T+v5znBmtBpkJTKiMTxkepiLQjwS+f29i+DiNvUf39Xh2p2cTxXyD0FX33xYSU4mRJhmr1GSX3Xoh9ZtZ8OrEQHb3BAF3u97371nVPimv9+WwWsLF84q0EEQi71QGhBwWLlNF5nGs5SaJM1HrLIwSuYI/AzpNVJEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <hverkuil@xs4all.nl>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rafael.j.wysocki@intel.com>,
        <broonie@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJWPq25Efj94upEGIV2ZkL1BZ0q6ixVMAgAAEm4CAAARDAIAAEbOAgAgD9ACAC9mb0A==
Date:   Mon, 30 Jan 2023 09:06:25 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201BCC60149D17F59AD870E92D39@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
 <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
 <Y8bFjhHkbNAKQK3t@pendragon.ideasonboard.com>
 <c2740d66-b51f-efc2-6583-a69bde950c68@linaro.org>
 <Y82NtJCtr+CZgS9k@pendragon.ideasonboard.com>
In-Reply-To: <Y82NtJCtr+CZgS9k@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TY3PR01MB11082:EE_
x-ms-office365-filtering-correlation-id: 1a066594-543c-45e0-0666-08db02a143b3
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeF5LTWf3iVIkgHY0Ezv2oSg41OTmegqDOHK1ItEtf55Z6WBVZmobRbBtShyqKUMLVjh2mad4TG9djj/JLW/3W5aWKKlMH5G+tbsuOSPOh92yrznX6zMIJcpuzbw+SxxBeBrbLRFR91CpKQ2swXPNoIrQ1xldEktAfmAVR9Z6gqbCLZI4tHI1JQfpit/tdBGz9fso4Bu4SI57YeBO5H4ZlMdnZHg9XHEH4YcHPyZ0O5ABn6CC149PV2WsEBBa2gkxGuwKKozpDnXVOa9+Vm1mYYztW7th7Vwdqef7iNkHoPrJolX64aQtJb7Dl6QnjfbG8iXIBFK0cBAY5kXP+EZAvjN5O6xNBNUPU9fFV8gx81koKkznvCb4JJKnf0xabrVt/55s/DKsRH+I5s1s14miIq6pFeslPFtMME29v/0KvTaHZ0om2PUk8TQOvdgZKZwwQd7Ri62DPum3ULznxROmhZZRUARBjm3QrTJhVFGZn9CPNBwYC2l+J+GfiapoJG/XgLUHiP8e2CG05WltGfimbvO8St4GQpiiqsNAKTDI6M0cVwe5EPvaXnOGL/KUhhQLMwYWo/+fUeJJXuy2Bn9r2YW2+mgfwqjsW2fd/IaP8bENKP/VeZEpd0IWi+GcwezEbXCTaf9l7uXk9mbCRYfoo8Zn/74Ru+9OWII12gLdXbZ8R674M8OpmJcaEo6AvfHtUJPHpf0gtic8odYzihR6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(71200400001)(7696005)(41300700001)(83380400001)(9686003)(6506007)(53546011)(478600001)(26005)(186003)(54906003)(110136005)(316002)(66556008)(76116006)(38100700002)(122000001)(64756008)(8676002)(66476007)(66446008)(4326008)(66946007)(55016003)(5660300002)(2906002)(33656002)(38070700005)(86362001)(7416002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFQ5cVJKSEpRMWJPVDArVldGRFlMN1FxcHl6NXVvaGJOWEVzUVZaZW5zbC85?=
 =?utf-8?B?NzJRU2FVUnUxK2lnaEdkUEJYcXdwczJZS0h0Rkpmc3dqbnNiR0FzQ1JsUTFk?=
 =?utf-8?B?U0g2Y3BGMFN6OVpLYlR3eXJLR1pIbHR6UW9zRnNlaWtKR1hMaDdrY2hybGVE?=
 =?utf-8?B?YVkvZTJjZUErUWpVMURDZ3BTL29uYnVsWHcrdG1VcnpMeGVqS3dpMWdFSVRY?=
 =?utf-8?B?ODlIRHVmNEFTc0lUNk9xMUkxSklud0RVb09xVzNZNEZ5eENCSWJyMWt5T0l5?=
 =?utf-8?B?aENuVGhGdkxnTHFpMXVrZG95VzBJS3pjVHVQVk5sV1VHaEhGcnVDcE5vYW5E?=
 =?utf-8?B?RFc2cXRmdStyMjJkWUtndDh5ZEpydElvaDFadHBUZmtPMVQzdC8ydk42QkhV?=
 =?utf-8?B?QzlRKzN0MGdEbmR3TDU2QkJjdDdCUld6bTdyZ0VQRkpaR0ZXRVlRVVpJeGpw?=
 =?utf-8?B?Y0NEaGdkMzA4OGR6NWpVSUJGYTBYWEdaQWt1NjVodzhhaVI0WTQxek9EM0R3?=
 =?utf-8?B?cDVIdnBHSm1XREZoeHpQRzIva0FHT0FYWHdPNWRQcm9NaXJBbXlzN2xWMDRW?=
 =?utf-8?B?MDRNeElqUFJkUUNGcG5Xc1gxeVY5WFh0YzlXT0xocmxhVGlKcFRmMDZIUEty?=
 =?utf-8?B?NFRoZ3RYam9lamlyVW90VndqMlJpZDJsWitzdnFDcjFvdkZySDl2MTM5TVN2?=
 =?utf-8?B?WnU0YW5qc2J0d3RQV1BBdGZQQmo4Ti9JVVJiY2JLUVcwL0VYcDlobHpuVUo5?=
 =?utf-8?B?eE84VXc0RDdIcHRSZTBRaW1XMjRBMWZYdlk2NmtKZzBnR1B1aVNYQy9EWFhk?=
 =?utf-8?B?UXRZMnBqTW1IMlQrc3JWYXRZV1pLK2JHODNuL3g4MHQwNlZlMmZxWis3SkNn?=
 =?utf-8?B?L0FKUTdqT2FsQy9VcHBSeEMwTFZ2dDVjeFNleE5RcEpsdHFoeDc3MlZtR20w?=
 =?utf-8?B?QlpCcEhjZ3Y4Z3M2WjhPMkV3a2h2ZklkMmoxRlhkREI3RVp4N1AvUjJqYjdo?=
 =?utf-8?B?RXVYaDFDaEtnZTk4R1pzMEsyNERQbWZlQnh5RkFBS0JYa2pKM1BPdWkrcEFV?=
 =?utf-8?B?VjFYN3JEWitLUVlKRTRibjc4anEyY2pONGprUVFreHVNbFpkZGVpODhoN0Rl?=
 =?utf-8?B?c2dCdzRvV1FNS3pMa1BoL0MwZndxVDhyNEpHaVJJdHpXZHZRRTB0UzNIdkRE?=
 =?utf-8?B?MUwwbklUOXU1ZGhVU08zYVVyRFBCcUQzelorK0FmUnh5cGk4MnA5LzBQUEp6?=
 =?utf-8?B?dmF6Y3I2RTV6SFB6NjNjV2hDNFZCNXFybG9WM3R3SXJlS0EyaGFpMDd6WHFC?=
 =?utf-8?B?YzYyQWgvekVySlFUMEhISGx0Mks4bFNTaW51QUZEeVFCYVBhYVk3dHNKWnox?=
 =?utf-8?B?dkNXMENaVWVpS0dmZER6OTFFeFA2M0dXcEo4ZHFkeld1NlI3OHlRcXhka294?=
 =?utf-8?B?SVVaUnAwQlA4Q2VwbUJWcE40MTdFSEo3VTc3a1FYOVZrTEFsQmFCa2ZMVUwv?=
 =?utf-8?B?a28yME1OMkR3VmNOK2p2MC9BT2ZadnhIWlVnb2NHZVhjc1IyL3RkM2l5ODRS?=
 =?utf-8?B?dlVkZEJ1L1lDSThtank3MGczNjJRWUtQbDB5SjdiczFtYStmeURPU3BRY3lJ?=
 =?utf-8?B?cjR3WVRxeWZjZXJGTDc5N3diYjlGcEdkU1ZCNFg2VzBNSk1SbnNFeFlqdWhn?=
 =?utf-8?B?TmQvY3ZSbDVrTXZSSkZGbGthL0JjbnVnVktDem5Yd1JXQzNHMHJzeVFrd2lJ?=
 =?utf-8?B?VkdZSXFXeDFIVDVHd1IySHRoYmV6TVJ0VnFwQTM4QnhrRUY3bkhXL1BJdUhx?=
 =?utf-8?B?TTU2TXlnbFo1NGpOemRnS25OcGlocFFEMUZTTVJhQ28zYU5hTnFMb0xqWXd0?=
 =?utf-8?B?M1VneG5XUlU2d00yTEIvNnE3VEdFaVpRMXExcjZVSkNGTzRKZUY1ZDBoenNZ?=
 =?utf-8?B?UkRTRHhYL2dIT0FtcGZsTjFuWnNiK2VNaDBnZGF4UWVXT2EyYWhOeTl0WGpC?=
 =?utf-8?B?Z3cxaEJzNnJBZGF0L2F3dmRlRHhBa3V1U0U3Z2VoblNkK2xxUUFDd0FLOE1i?=
 =?utf-8?B?UEExRUNZcUMrWkhWTnU0RTVTWHFXVXhLek5WUG9DeG5nY1pDbkZBanBOdnlD?=
 =?utf-8?B?azB2blQ3T2lwQWc1UEdGaWQ1U0JrTmN3S2t5WEdWRVVuUjUrdUlFN0dYSkFT?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a066594-543c-45e0-0666-08db02a143b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 09:06:25.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmfFDJ+Xa3PVOQs6EynxICSy+pWEFj6ojOsYCW1qvyhZSUrX1mA7TTFowkOeyMHRADkU6sJbar5G6vpQoDx2uyCeUz5DeKn1hWvguRdIdR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11082
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBQaW5jaGFy
dCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBTZW50OiBNb25kYXksIEph
bnVhcnkgMjMsIDIwMjMgNDoyNiBBTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBDYzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg
5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykNCj4gPHl1amkyLmlz
aGlrYXdhQHRvc2hpYmEuY28uanA+OyBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD47
IE1hdXJvDQo+IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgaXdhbWF0c3Ug
bm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLMNCj4g77y377yj4pev77yh77yj77y0KSA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStk
dEBsaW5hcm8ub3JnPjsgUmFmYWVsIEogLiBXeXNvY2tpDQo+IDxyYWZhZWwuai53eXNvY2tpQGlu
dGVsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGxpbnV4LW1lZGlh
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvNl0gZHQtYmluZGluZ3M6IG1lZGlhOiBwbGF0
Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJhDQo+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVy
ZmFjZSBiaW5kaW5ncw0KPiANCj4gSGkgS3J6eXN6dG9mLA0KPiANCj4gT24gVHVlLCBKYW4gMTcs
IDIwMjMgYXQgMDY6MDE6MjdQTSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4g
PiBPbiAxNy8wMS8yMDIzIDE2OjU4LCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPiA+ID4gT24g
VHVlLCBKYW4gMTcsIDIwMjMgYXQgMDQ6NDI6NTFQTSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gPiA+PiBPbiAxNy8wMS8yMDIzIDE2OjI2LCBMYXVyZW50IFBpbmNoYXJ0IHdy
b3RlOg0KPiA+ID4+Pg0KPiA+ID4+Pj4gKw0KPiA+ID4+Pj4gKyAgICAgICAgICBjbG9jay1sYW5l
czoNCj4gPiA+Pj4+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjogVklJRiBzdXBwb3J0cyAxIGNs
b2NrIGxpbmUNCj4gPiA+Pj4NCj4gPiA+Pj4gcy9saW5lL2xhbmUvDQoNClNvcnJ5IGZvciBhIGxh
dGUgcmVwbHkuDQpJJ2xsIGZpeCB0aGUgZGVzY3JpcHRpb24uDQoNCj4gPiA+Pj4NCj4gPiA+Pj4+
ICsgICAgICAgICAgICBjb25zdDogMA0KPiA+ID4+Pg0KPiA+ID4+PiBJIHdvdWxkIGFsc28gYWRk
DQo+ID4gPj4+DQo+ID4gPj4+ICAgICAgICAgICBjbG9jay1ub25jb250aW51b3VzOiB0cnVlDQo+
ID4gPj4+ICAgICAgICAgICBsaW5rLWZyZXF1ZW5jaWVzOiB0cnVlDQo+ID4gPj4+DQo+ID4gPj4+
IHRvIGluZGljYXRlIHRoYXQgdGhlIGFib3ZlIHR3byBwcm9wZXJ0aWVzIGFyZSB1c2VkIGJ5IHRo
aXMgZGV2aWNlLg0KPiA+ID4+DQo+ID4gPj4gTm8sIHRoZXNlIGFyZSBjb21pbmcgZnJvbSBvdGhl
ciBzY2hlbWEgYW5kIHRoZXJlIGlzIG5ldmVyIG5lZWQgdG8NCj4gPiA+PiBtZW50aW9uIHNvbWUg
cHJvcGVydHkgdG8gaW5kaWNhdGUgaXQgaXMgbW9yZSB1c2VkIHRoYW4gb3RoZXIgY2FzZS4NCj4g
PiA+PiBOb25lIG9mIHRoZSBiaW5kaW5ncyBhcmUgY3JlYXRlZCBzdWNoIHdheSwgc28gdGhpcyBz
aG91bGQgbm90IGJlDQo+IGV4Y2VwdGlvbi4NCj4gPiA+DQo+ID4gPiBUaGVyZSBhcmUgc29tZSBi
aW5kaW5ncyB0aGF0IGRvIHNvLCBidXQgdGhhdCBtYXkgbm90IGJlIGEgZ29vZA0KPiA+ID4gZW5v
dWdoIHJlYXNvbiwgYXMgdGhlcmUncyBhIGNoYW5jZSBJIHdyb3RlIHRob3NlIG15c2VsZiA6LSkN
Cj4gPiA+DQo+ID4gPiBJIHdvdWxkIGhhdmUgc3dvcm4gdGhhdCBhdCBzb21lIHBvaW50IGluIHRo
ZSBwYXN0IHRoZSBzY2hlbWENCj4gPiA+IHdvdWxkbid0IGhhdmUgdmFsaWRhdGVkIHRoZSBleGFt
cGxlIHdpdGggdGhpcyBvbWl0dGVkLiBJJ20gbm90IHN1cmUNCj4gPiA+IGlmIHNvbWV0aGluZyBj
aGFuZ2VkIG9yIGlmIEkgZ290IHRoaXMgd3JvbmcuDQo+ID4NCj4gPiBZb3UgcHJvYmFibHkgdGhp
bmsgYWJvdXQgY2FzZSB3aGVuIHVzaW5nIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOmZhbHNlLA0KPiA+
IHdoZXJlIG9uZSBoYXMgdG8gZXhwbGljaXRseSBsaXN0IGFsbCB2YWxpZCBwcm9wZXJ0aWVzLiBC
dXQgbm90IGZvcg0KPiA+IHVuZXZhbHVhdGVkUHJvcGVydGllczpmYWxzZS4NCj4gDQo+IFBvc3Np
Ymx5LCB5ZXMuDQo+IA0KPiA+ID4gdmlkZW8taW50ZXJmYWNlcy55YW1sIGRlZmluZXMgbG90cyBv
ZiBwcm9wZXJ0aWVzIGFwcGxpY2FibGUgdG8NCj4gPiA+IGVuZHBvaW50cy4gRm9yIGEgZ2l2ZW4g
ZGV2aWNlLCB0aG9zZSBwcm9wZXJ0aWVzIHNob3VsZCBiZSByZXF1aXJlZA0KPiA+DQo+ID4gcmVx
dWlyZWQ6DQo+ID4gIC0gZm9vDQo+ID4NCj4gPiA+IChlYXN5LCB0aGF0J3MgZGVmaW5lZCBpbiB0
aGUgYmluZGluZ3MpLCBvcHRpb25hbCwNCj4gPg0KPiA+IGJ5IGRlZmF1bHQgKHdpdGggdW5ldmFs
dWF0ZWRQcm9wZXJ0aWVzOmZhbHNlKSBvciBleHBsaWNpdGx5IG1lbnRpb24NCj4gPiAiZm9vOiB0
cnVlICh3aXRoIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOmZhbHNlKQ0KPiA+DQo+ID4gPiAgb3IgZm9y
YmlkZGVuLiBIb3cgZG8NCj4gPg0KPiA+IGZvbzogZmFsc2UgKHdpdGggdW5ldmFsdWF0ZWRQcm9w
ZXJ0aWVzOmZhbHNlKSBvciBieSBkZWZhdWx0ICh3aXRoDQo+ID4gYWRkaXRpb25hbFByb3BlcnRp
ZXM6ZmFsc2UpDQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBkZWZhdWx0IHRvIHRoZSBsYXR0ZXIu
IHZpZGVvLWludGVyZmFjZXMueWFtbCBjb250YWlucyBsb3RzIG9mDQo+IHByb3BlcnRpZXMgZW5k
cG9pbnQgcHJvcGVydGllcywgbW9zdCBiaW5kaW5ncyB3aWxsIHVzZSBsZXNzIHRoYW4gaGFsZiBv
ZiB0aGVtLCBzbw0KPiBoYXZpbmcgdG8gZXhwbGljaXRseSBsaXN0IGFsbCB0aGUgb25lcyB0aGF0
IGFyZSBub3QgdXNlZCB3aXRoICJmb286IGZhbHNlIiB3b3VsZCBiZQ0KPiBxdWl0ZSBpbmNvbnZl
bmllbnQuIEZ1cnRoZXJtb3JlLCBJIGV4cGVjdCBtb3JlIHByb3BlcnRpZXMgdG8gYmUgYWRkZWQg
dG8NCj4gdmlkZW8taW50ZXJmYWNlcy55YW1sIG92ZXIgdGltZSwgYW5kIHRob3NlIHNob3VsZG4n
dCBiZSBhY2NlcHRlZCBieSBkZWZhdWx0IGluDQo+IGV4aXN0aW5nIGJpbmRpbmdzLg0KPiANCg0K
SSBjYXVnaHQgdXAgd2l0aCB0aGlzIGRpc2N1c3Npb24gYWZ0ZXIgc29tZSBleGVyY2lzZSBvbiBK
U09OIHNjaGVtYSB2YWxpZGF0b3IuDQpJJ2xsIHJlbW92ZSAidW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZSIgYXQgdGhlICJlbmRwb2ludCIgYW5kIGFkZCAiYWRpdGlvbmFsUHJvcGVydGllczog
ZmFsc2UiIGluc3RlYWQuDQpGdXJ0aGVybW9yZSwgSSdsbCBleHBsaWNpdGx5IGRlY2xhcmUgcmVx
dWlyZWQgcHJvcGVydGllcyAocmVxdWlyZWQ6IFsiZm9vIl0pIGFuZCBvcHRpb25hbCBwcm9wZXJ0
aWVzIChwcm9wZXJ0aWVzOiB7Zm9vOiB0cnVlfSkgZm9yIFZpc2NvbnRpLg0KSXMgdGhpcyBjb3Jy
ZWN0IHVuZGVyc3RhbmRpbmc/DQpBcmUgdGhlc2UgY2hhbmdlcyBhbHNvIGFwcGxpZWQgdG8gInBv
cnQiLCB3aGljaCBpcyB0aGUgcGFyZW50IG5vZGUgb2YgdGhlICJlbmRwb2ludCIgPw0KDQo+ID4g
PiB3ZSBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlIGxhdHRlciB0d28gY2FzZXMgPw0KPiANCj4g
LS0NCj4gUmVnYXJkcywNCj4gDQo+IExhdXJlbnQgUGluY2hhcnQNCg0KUmVnYXJkcywNCll1amkg
SXNoaWthd2ENCg==

