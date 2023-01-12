Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728D666853
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjALBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjALBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:17:41 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCA2F788;
        Wed, 11 Jan 2023 17:17:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4E5+Yz4sDjzvP9G2aMdM6js1ir9U4YTA/0Np0DLYoXw32iNGh3YoV3epWZRE27Ab1jtAuA4Pe2SzDiCe9+5ncYVjKgl1T4Nd9kpi1zi/Z7ChHGbeKjUEPXG7duAqq4G8jEPIgSdRIbYsHWmdokYkxbah0A9WRDz17s3HAz5DdUm8DBpz9UR/Qv+BsPOPtlFeIsC2Gb37JxXb9b1PTHoEwufvrJD1BCZHJJBVs0+Nb1vszUu0ZOOjdJxlxC02o6jw1gvb+KE4DR233fAEsAu42WaToE4XMNYr9e5otbbIYX+Xa5inHmZk0/l9Ewt/Q24jQ0n2wAZ75Cv7gcbQOjmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+fiodlGRUlgSlM7k00TRj0yFYZRnjDvrCvlBK3dZMY=;
 b=edURG6wZmg1IoCbMTH0TLlFJXiTohPbpDXeATdxPGWwHZYspC7gWia7sCPaAXoDh+XHE2JTGy9YFmqSjEBDZClxTG5urDFeA06Uv6v0lKIZP3VwedgYOWbjzItKIK6/YtXy+R4O8Cjk7K8rSCeSFAYvpYvwrOM9VF2LeBSUCggZ116QJGRd83vn4gcAbi47qc3Cjspsz3s+GVsH+H/1kuD77cohkZ7vSj2OOTTBnPmY0Rjx0ARdfwznzzUKYj65+cpGTtbdNaJPf875F1JlqhbgtLCgMcT0csiYAEcomewaA1KltX0bygCJrUSXQJCi6/PyAw7aJsb/DHi0oMpZTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+fiodlGRUlgSlM7k00TRj0yFYZRnjDvrCvlBK3dZMY=;
 b=Ti6N9/sdPo+WwXdjvnHRiz4uTOuyHNEb3SBwHFpGKDKqUSqUNCN3wgp0R2ksN7RJmPMoje1ODkTQLRp2K2yyBvkmsr/Hh4mxGq+uiF1a2np6uh+6GNnbvdELV2IC5VBjAZqwLkMVR38mQML48gzU9+ytige2D4y/CSaR3L5S+AA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 01:17:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 01:17:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Ming Zhou <ming.zhou@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 1/2] media: add RealMedia format
Thread-Topic: [EXT] Re: [PATCH 1/2] media: add RealMedia format
Thread-Index: AQHZFE5aqPLaejQ67Uq0D5Qyo/fLm66ZaU8AgAC03sA=
Date:   Thu, 12 Jan 2023 01:17:35 +0000
Message-ID: <AM6PR04MB63415BE84921030A392604DFE7FD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1671525379.git.ming.qian@nxp.com>
         <969b6905c945a1cf0986a2188290ddf3c52c5511.1671525379.git.ming.qian@nxp.com>
 <88e1772841b84a786f4864a6540e03c2e7cd744b.camel@ndufresne.ca>
In-Reply-To: <88e1772841b84a786f4864a6540e03c2e7cd744b.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: 09c482ae-6446-489e-37ef-08daf43ac991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1zGexCGv3Kk60S+SEnz9gJai4JBI2B86BrDGrVd3snt99EMoDCwXpVJpnVQtBnen+F9J/oku1Hs20tgTLaMsVPYOUo2WJF9Z3ZCo0cIsWaE6buAcO2RkA59YHHmWhi8way6KbGW3r0fb/zsFdaeL3jX/D5+xBjECPv6QmEowpRYPamOZzakIjPDyTuf508mHYQAs3Ic1GOhkbon831Mt8OcgssQfCXrgBFJczjd0AVjKDpIdMYzK9rLA1kQU+3HlqCvolhEb/X82sDB/z9NYeU558uyVe397d7tqRIpo+QExwEanbE0z2ppkj1+uvUlB3zZ0a4NlL+MaKyF6/v92iy/ELTIOjrzBEGwzANvsiNL/z6u1fEAYfULZmqo7oyHyrl34gArgkZq4+FnOuaSw12sSLm4IjF98jdYbJT351V7g3N9SCBIprv0MgMz2Z49Ua+5eabx7oJ2weuAYbAYFklYXpnuASLKMalvyWTwDgShu1YTzfBl7oBwogyCtBkX4NDm8Y8rK5/Sr3HdIWgemZe0mtLtU1ig7CbMIk/G+RIcrFBjxwzJtd8FvwZE/pKXwyl49KlUKeV+cUmJ7iQrqsZoN4XWhMrzMeZh+SldmR3GQ+row/us2H99UviI+4RuV+ceAmgzxHt9tAJtCgRTCCpxZAbbWB/OrLPwF0AJ6eL+viKITR1MpQCFb2MDDVNarp3/Vt/ZN2MBDA3gky9HpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(33656002)(316002)(5660300002)(9686003)(26005)(7696005)(44832011)(7416002)(186003)(478600001)(71200400001)(66476007)(38070700005)(66574015)(4326008)(110136005)(66446008)(64756008)(66946007)(66556008)(54906003)(8676002)(76116006)(41300700001)(8936002)(52536014)(55016003)(86362001)(38100700002)(6506007)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhSTTNvQyt0ZVgvd1lzODl1L1pPcWJDNkVjZEY1dk5BOHJvdlBKQ2gzRERi?=
 =?utf-8?B?TkZ0TTlCbDlSQ0M0Y1VPanFIYVdSM3VoQ09rUFkvaHdPcDhuYTZ4UmRENjlw?=
 =?utf-8?B?VGRiamhuVDY2d1B5b3E4aVZTYm9XTEk5ZERyTldEVDFucU45VXNwSkNkMCtD?=
 =?utf-8?B?R0Z0SnJudG82L2IrdjBHYW9tTzBTNEJUVlVkY1RTS3dlalo5VGlUcCtZUVJL?=
 =?utf-8?B?cTRqVzVwdlFsTitiTUNRRzNHWG1SR09NeVYxbi85dmRQbU50M0Y1TitBeXQ0?=
 =?utf-8?B?QTNJY2dyZkZaeXErWFNmUStOaExydEg3TllpUVRBTjlpSjJHVys5eGg1S1g0?=
 =?utf-8?B?WTd6eENxVWJrRm05RnBNME1FbDRpVGZRK2FsdEdqOS9pY3NrVGMxbDhqQ2dP?=
 =?utf-8?B?dDlGc2Jkc29TMkVBNGFzaEpMcTJ6M2dsQWZTc3RsUHlYazduQVAzZTNkdTJV?=
 =?utf-8?B?ZlhXV3pqd1FxUG84UWRkU2Uyai84U0NRSHhWcjVUWFlJVkRhYTFoKzBWSzdn?=
 =?utf-8?B?dDdCWHkvMG85UU10czNVeTJIK1MvaHB6VlUvM3hPUEFkOFVtSTZDcFhsY1BO?=
 =?utf-8?B?S0cwNkI5WFF4akovUlVzNHlwUVptR0JKelJDRDI0TnFBQzNjVHRGNWZZeHdn?=
 =?utf-8?B?TW5rOWd1aUhPUTFrdDA4cXN2bkdydEdZR2tXWUZWUG96MS9IZWNWeTFBdlM5?=
 =?utf-8?B?RGJOQjFselM2UTJKcFE3c3dSbklUNEdYYm9ob0VWbldiUUUyMDZFMjBReTYz?=
 =?utf-8?B?TlRmTy9FTmVIdWxFVFBJUFJ1dk9tQUpUeUNrMGVwcHBxM1N5NDM0UjVkM0dU?=
 =?utf-8?B?TUI2Vk9jTUdVSUtYKzZKWWc3dW5nWFlUMXh0ZEhlWlFtdHVNdzE3WUsxWWhl?=
 =?utf-8?B?NnVXZXhQYzdWYVo3ckhFZEV3M1laQXR3ZUVyRmJydG5hMlkxTFRTTUxVbW5E?=
 =?utf-8?B?Wk5NM0NPeFJaZ3VJazdSSGw4QXJtSXh4NVVzazlTT1d1SkIxdWhwNkZNeFVt?=
 =?utf-8?B?d2ROUzBUN3YzTTUzaDVyUVp5WGJKTFhJN0s3dU5NS1kvcEhDV3pZcjUxV0VO?=
 =?utf-8?B?emJ0MGJQQWExYlZvR01icFRwaDBkRnhSUk8rS3RSQllCSHRORC9PL0JqMUZV?=
 =?utf-8?B?dlBhTE5iMVJjMzVxdDJ0UHBZTzdjNDRHLzJvN01WOU93NzhvVXMvYTZ5aEZF?=
 =?utf-8?B?Zk1Ddmw2N3ZsNTY1YlFsaWJTRmYyb096YklQZXdqV21TL3dsMUxteTk5bmxx?=
 =?utf-8?B?endTbkpwLzR0ZGpTMjgyZGNjWlhlLzV2ajlyM2k0VXU4Q1p4OGIxVnVlWGpV?=
 =?utf-8?B?NnQzZkpyd3ppWktZR1ZQTFVCZzMwcTFxRkVKeUdaK3NNb3dyc2Z5Wkg5YlBu?=
 =?utf-8?B?Y1NCVXN5RThCVTVhY1k3ZEZnSEFqOTl3STVoRXREaG85L2M0aHhJWFNMeVZo?=
 =?utf-8?B?ZDZnQzYzSVNERVkyVlFyWTRpT0t3QkpHRlVyT0JJMXJ3S2E3S2k5UlRJcDlH?=
 =?utf-8?B?SnpMcGlmZ0t1enJNOGxMSUJQR1c4NEltK0dPYUtVWEZ3ZFhPT3BlWW85aVM2?=
 =?utf-8?B?M3JSUi9kWVo0OHFQemozTHVqOFlUWDNRUi91KzdNOGEvQ1BEbCs3d0VWcStQ?=
 =?utf-8?B?R1ZFVkViUzFPY2xKQ2NmMmhWTlV1UWxET0RxTDdYSEFqREdOY1dOTENBWk9v?=
 =?utf-8?B?Q3ZncmNveXIxUmNYbjVNUVBCTjkyV2lEZ0pXMEVZb3h0MnhLWnlNSkphRGhl?=
 =?utf-8?B?MzV4d2o5dFErWjZCaEhKZUNLdW44cmF2ZkMxVnVpNmlnZmVmRnJlV1JBdDBX?=
 =?utf-8?B?T3VVUDJDSEZLbGtFVzlCR1RUYjc2Z21tK08rdGExcm12d1NFZ1hJSWtUR0ht?=
 =?utf-8?B?ekgzaUVaYnY2dGl2Yy9tSE1NY3VNNnNmNW1WUGtoQURqVWlFQUF3SG1Nc0Nx?=
 =?utf-8?B?RklacDNTWE05UjNTWUNTUkhCcDhlWUNESVNwWWxvVVZlZXR0UEpPdUVYRXpC?=
 =?utf-8?B?dmVtQ1RrV2I3UTM0bDd1R3JFWFZGbS9KdW9MaDZtNkhpazFjZEtOMWlxYnZK?=
 =?utf-8?B?OU5UY1REMmtvbWEyQ2RtNFkzUENXUDdNQ1RnOUFRU0M4NG9MaW9Wck5Ybld6?=
 =?utf-8?Q?p71U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c482ae-6446-489e-37ef-08daf43ac991
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 01:17:35.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6jWiZiSiAZbVLjHP+I7Dq23Ui+tTssrIGUSLzDCNQ8iT9X/DCnz32HUR/aTG09Gavt7eHmotsi63ghEcYWDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPlNlbnQ6IDIw
MjPlubQx5pyIMTHml6UgMjI6MjgNCj5UbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47
IG1jaGVoYWJAa2VybmVsLm9yZzsgaHZlcmt1aWwtDQo+Y2lzY29AeHM0YWxsLm5sDQo+Q2M6IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj5rZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGlu
dXgtaW14IDxsaW51eC0NCj5pbXhAbnhwLmNvbT47IFguSC4gQmFvIDx4aWFob25nLmJhb0BueHAu
Y29tPjsgTWluZyBaaG91DQo+PG1pbmcuemhvdUBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDEvMl0g
bWVkaWE6IGFkZCBSZWFsTWVkaWEgZm9ybWF0DQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+
SGkgTWluZywNCj4NCj5zb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkgLi4uDQo+DQo+TGUgbWFyZGkg
MjAgZMOpY2VtYnJlIDIwMjIgw6AgMTY6MzkgKzA4MDAsIE1pbmcgUWlhbiBhIMOpY3JpdCA6DQo+
PiBSZWFsTWVkaWEgaXMgYSBwcm9wcmlldGFyeSBtdWx0aW1lZGlhIGNvbnRhaW5lciBmb3JtYXQg
Y3JlYXRlZCBieQ0KPj4gUmVhbE5ldHdvcmtzIHdpdGggdGhlIGZpbGVuYW1lIGV4dGVuc2lvbiAu
cm0uDQo+PiBSZWFsTWVkaWEgaXMgZ2VuZXJhbGx5IHVzZWQgaW4gY29uanVuY3Rpb24gd2l0aCBS
ZWFsVmlkZW8gYW5kDQo+PiBSZWFsQXVkaW8sIHdoaWxlIGFsc28gYmVpbmcgdXNlZCBmb3Igc3Ry
ZWFtaW5nIGNvbnRlbnQgb3ZlciB0aGUgSW50ZXJuZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
TWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi91c2Vyc3BhY2Ut
YXBpL21lZGlhL3Y0bC9waXhmbXQtY29tcHJlc3NlZC5yc3QgICAgIHwgMTEgKysrKysrKysrKysN
Cj4+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMgICAgICAgICAgICAgICAg
ICB8ICAxICsNCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxICsNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0DQo+PiBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRp
YS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9tZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiBpbmRleCA4Nzk0YjkyZmRl
MzYuLjMxYmEyYzAwMDkxZSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9tZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0
aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZtdC1jb21wcmVzc2VkLnJzdA0KPj4gQEAg
LTIzNyw2ICsyMzcsMTcgQEAgQ29tcHJlc3NlZCBGb3JtYXRzDQo+PiAgICAgICAgICBNZXRhZGF0
YSBhc3NvY2lhdGVkIHdpdGggdGhlIGZyYW1lIHRvIGRlY29kZSBpcyByZXF1aXJlZCB0byBiZSBw
YXNzZWQNCj4+ICAgICAgICAgIHRocm91Z2ggdGhlIGBgVjRMMl9DSURfU1RBVEVMRVNTX0ZXSFRf
UEFSQU1TYGAgY29udHJvbC4NCj4+ICAgICAgIFNlZSB0aGUgOnJlZjpgYXNzb2NpYXRlZCBDb2Rl
YyBDb250cm9sIElEIDxjb2RlYy1zdGF0ZWxlc3MtZndodD5gLg0KPj4gKyAgICAqIC4uIF9WNEwy
LVBJWC1GTVQtUlY6DQo+PiArDQo+PiArICAgICAgLSBgYFY0TDJfUElYX0ZNVF9SVmBgDQo+PiAr
ICAgICAgLSAnUmVhbE1lZGlhJw0KPj4gKyAgICAgIC0gUmVhbE1lZGlhIGlzIGEgcHJvcHJpZXRh
cnkgbXVsdGltZWRpYSBjb250YWluZXIgZm9ybWF0DQo+PiArICAgICAgICBjcmVhdGVkIGJ5IFJl
YWxOZXR3b3JrcyB3aXRoIHRoZSBmaWxlbmFtZSBleHRlbnNpb24gLnJtLg0KPj4gKyAgICAgICAg
UmVhbE1lZGlhIGlzIGdlbmVyYWxseSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggUmVhbFZpZGVv
IGFuZA0KPlJlYWxBdWRpbywNCj4+ICsgICAgICAgIHdoaWxlIGFsc28gYmVpbmcgdXNlZCBmb3Ig
c3RyZWFtaW5nIGNvbnRlbnQgb3ZlciB0aGUgSW50ZXJuZXQuDQo+PiArICAgICAgICBUeXBpY2Fs
bHkgdGhlc2Ugc3RyZWFtcyBhcmUgaW4gQ0JSIChjb25zdGFudCBiaXRyYXRlKSwNCj4+ICsgICAg
ICAgIGJ1dCBhIGNvbnRhaW5lciBmb3IgVkJSICh2YXJpYWJsZSBiaXRyYXRlKSBzdHJlYW1zDQo+
PiArICAgICAgICBuYW1lZCBSTVZCIChSZWFsTWVkaWEgdmFyaWFibGUgYml0cmF0ZSkgaGFzIGJl
ZW4gZGV2ZWxvcGVkLg0KPg0KPkknbSBhIGJpdCBjb25mdXNlZCB3aXRoIHRoZSBkZXNjcmlwdGlv
biBoZXJlLiBJdCBkZXNjcmliZXMgdGhlIFJlYWxNZWRpYSAoUk0pDQo+Y29udGFpbmVyIGZvcm1h
dCwgYnV0IHdoYXQgeW91IHdhbnRlZCBpcyBhIFJlYWxWaWRlbyBlbmNvZGluZyAoUlYpLg0KPg0K
PkEgcXVpY2sgc2VhcmNoIGludG8gRkZNcGVnICh0aGUgb25seSBPcGVuIFNvdXJjZSBzb2Z0d2Fy
ZSBkZWNvZGVyIEkgY291bGQNCj5maW5kKSwgdGhlIFJlYWxWaWRlbyBjb21lcyBpbiA0IGluY29t
cGF0aWJsZSBmbGF2b3VycywgUlYxMC9SVjIwL1JWMzAvUlY0MA0KPmFsc28ga25vd24gYXMgIFJl
YWxWaWRlbyAxIC8gRzIgLyA4IC8gOSsxMC4gSSB0aGluayB0aGUgZm9ybWF0IGhlcmUgc2hvdWxk
IGJlIGENCj5SZWFsVmlkZW8gZm9ybWF0LCBhbmQgaXQgc2hvdWxkIHNwZWNpZnkgdGhlIGZsYXZv
dXJzIHlvdSB3YW50IHRvIHN1cHBvcnQNCj4ocHJvYmFibHkgb25seSBSVjQwKS4NCj4NCj5yZWdh
cmRzLA0KPk5pY29sYXMNCg0KSGkgTmljb2xhcywNCiAgICBZZXMsIHlvdSdyZSByaWdodCwgSSBj
b25mdXNlZCB0aGUgZW5jb2RpbmcgZm9ybWF0IHdpdGggdGhlIGNvbnRhaW5lciBmb3JtYXQsDQpJ
J2xsIGNoZWNrIGFuZCBjb3JyZWN0IGl0Lg0KICAgICBUaGFua3MgdmVyeSBtdWNoDQoNCk1pbmcN
Cg0KPg0KPj4NCj4+ICAuLiByYXc6OiBsYXRleA0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4+IGIvZHJpdmVycy9tZWRpYS92NGwyLWNv
cmUvdjRsMi1pb2N0bC5jDQo+PiBpbmRleCA5YjViMDRiOGFhNjkuLmE0ZDEyZWVhN2ZjNSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYw0KPj4gKysr
IGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiBAQCAtMTQ3Myw2ICsx
NDczLDcgQEAgc3RhdGljIHZvaWQgdjRsX2ZpbGxfZm10ZGVzYyhzdHJ1Y3QgdjRsMl9mbXRkZXNj
DQo+KmZtdCkNCj4+ICAgICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfRldIVDogICAgICAg
ICBkZXNjciA9ICJGV0hUIjsgYnJlYWs7IC8qIHVzZWQgaW4NCj52aWNvZGVjICovDQo+PiAgICAg
ICAgICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX0ZXSFRfU1RBVEVMRVNTOiAgICAgICBkZXNjciA9
ICJGV0hUIFN0YXRlbGVzcyI7DQo+YnJlYWs7IC8qIHVzZWQgaW4gdmljb2RlYyAqLw0KPj4gICAg
ICAgICAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9TUEs6ICAgICAgICAgIGRlc2NyID0gIlNvcmVu
c29uIFNwYXJrIjsgYnJlYWs7DQo+PiArICAgICAgICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX1JW
OiAgICAgICAgICAgZGVzY3IgPSAiUmVhbE1lZGlhIjsgYnJlYWs7DQo+PiAgICAgICAgICAgICAg
IGNhc2UgVjRMMl9QSVhfRk1UX0NQSUExOiAgICAgICAgZGVzY3IgPSAiR1NQQ0EgQ1BpQSBZVVYi
OyBicmVhazsNCj4+ICAgICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfV05WQTogICAgICAg
ICBkZXNjciA9ICJXTlZBIjsgYnJlYWs7DQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRMMl9QSVhf
Rk1UX1NOOUMxMFg6ICAgICAgZGVzY3IgPSAiR1NQQ0EgU045QzEwWCI7IGJyZWFrOw0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gYi9pbmNsdWRlL3Vh
cGkvbGludXgvdmlkZW9kZXYyLmggaW5kZXggMjYyZWYxMGNmYTAyLi5hN2E3OTY5YWU0ZjgNCj4+
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+PiArKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4+IEBAIC03NDAsNiArNzQwLDcgQEAg
c3RydWN0IHY0bDJfcGl4X2Zvcm1hdCB7ICAjZGVmaW5lDQo+PiBWNEwyX1BJWF9GTVRfSDI2NF9T
TElDRSB2NGwyX2ZvdXJjYygnUycsICcyJywgJzYnLCAnNCcpIC8qIEgyNjQgcGFyc2VkDQo+PiBz
bGljZXMgKi8gICNkZWZpbmUgVjRMMl9QSVhfRk1UX0hFVkNfU0xJQ0UgdjRsMl9mb3VyY2MoJ1Mn
LCAnMicsICc2JywgJzUnKSAvKg0KPkhFVkMgcGFyc2VkIHNsaWNlcyAqLw0KPj4gICNkZWZpbmUg
VjRMMl9QSVhfRk1UX1NQSyAgICAgIHY0bDJfZm91cmNjKCdTJywgJ1AnLCAnSycsICcwJykgLyog
U29yZW5zb24gU3BhcmsNCj4qLw0KPj4gKyNkZWZpbmUgVjRMMl9QSVhfRk1UX1JWICAgICAgIHY0
bDJfZm91cmNjKCdSJywgJ1YnLCAnMCcsICcwJykgLyogUmVhbE1lZGlhICovDQo+Pg0KPj4gIC8q
ICBWZW5kb3Itc3BlY2lmaWMgZm9ybWF0cyAgICovDQo+PiAgI2RlZmluZSBWNEwyX1BJWF9GTVRf
Q1BJQTEgICAgdjRsMl9mb3VyY2MoJ0MnLCAnUCcsICdJJywgJ0EnKSAvKiBjcGlhMSBZVVYgKi8N
Cg0K
