Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE34F610CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJ1JFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1JFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:05:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F75BC01;
        Fri, 28 Oct 2022 02:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaOS9Fm2OBAQQzKBbUFRhVDUCp9rj78BUMmHWu/2x1VM+ep9Y3ALkT4QIf9wImgNdTb5m23XKOIk9FweTHOWAqiAppecfZMMzh9SVsZn2opdyBU35xE0euxB/QTXV/QeNBLAT078gYSsk8sS4CI8HAt3CmvC5ntEinLucesWTArEUdLQe5cH6JFub1Z58qonLVajJbzkLsVrXzbq6aMn/cspy7H0jm76dW65TsCJSd2puy/5OfC0SQY8yYJ9GyWzdl787qhPLSMFzFHUo8frdHb0rM0cSAl3Xu4DnTKb3mUj5gMLyrIr2T0aLmFgEGgvRVmF63/2K+snil23Z5njtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZT7mKtkWe5MzH/5bBg4mh+ev8csJhBhB1RstteS9yM=;
 b=TQW46IRTx4VC3v68AuBmmGSCCa4FnC8aSKl67Y40QbiK+NyaEchnywPaI5KB98yessd3xbaV1cRJ5CrBe1dyVOdzQ9QTja4hsNGzVlGhBSxHEvLkgnDsqXIzljwb2pEB/4XPe0/Q7ZK07Y5KR79jMsOO6gGChFVT9ban0awrjig+hZ0txYDvYiFHDsEk1/5Dj2sMwMrG+WkQ0yPpBnlBfhAFix7FJjuIBrapAjfg3rAxtvD4wgVpRiqUCvxwhbmm0YRrYta905oQqnwP8EBRqSPfW6EmevjHCGTUlY+4Tn0EOHY6r+9TG4Dq/Aw9IbQnHJeQk09RF599lHgG4F0iLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZT7mKtkWe5MzH/5bBg4mh+ev8csJhBhB1RstteS9yM=;
 b=2EVvdS6qrX2OAsRlUaD5BxcRbC6Czysra88YHYk7OdRWTgK0hq4ln8gSYWCednEwNmC1zCmMNQWvRmMi6/XoX6ht1j1bmp5RTXr9uSy6oW+Ps527HKRvHINRX64J6iBSU4C8AxDq2C6ttmFZsUw0qbmmmtiFl8IDVP/D8rn9t8zAizBU3D+FBUtcUoH5VIUq9QF4FR/NshkKIL/aSQpUnnpyO45m4KJ08nNWDTA75bGDiL91WWB1u6K6NaTELUWYr9dAqeveLp/6Y9RbjrVx4OHKdNXv5O7vx8CR0YcQhKrT8GYOeOhHMFDZlJERTyNs/5EJVC1QzNf7hEA3JMJGdw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB5394.apcprd06.prod.outlook.com (2603:1096:400:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 09:04:53 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 09:04:52 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Lei Yu <yulei.sh@bytedance.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Topic: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Index: AQHY543fG2IRDKPpjUCvaIBADhhwbq4jYB2AgAASRYCAABWy4A==
Date:   Fri, 28 Oct 2022 09:04:52 +0000
Message-ID: <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
In-Reply-To: <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|TYZPR06MB5394:EE_
x-ms-office365-filtering-correlation-id: 0efb4610-430d-48c1-b6e1-08dab8c379dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUBNC8aa8hUWTlJydzJLzCCImLuTrEe0txrZLX5fv7aLZsYy2GkCMW1jHyfDR9WyrO9d3SLMaae4c+uaTwB+4CXNOmJVOVd+xxW2TcKBqCmlA6tqnxW6hHk4PXELkfGwdBkZ8pYL4P3EtYM7bLFHF133CBvGchZ6aeLdG5oxgxkATZU/vYYcyOjLjgsgTmNv8fX7hD2/YDs3xzdljjJAJkyDWG7qKItBNm7GqkcoE+q9PDHHo+hXkXhVZzpbGF0mm9NUlyjdhR5lK58mjCDx8ssA8k4zpt2sJQ66G4W+DjGgiqTenvPdrOrPzofCt9TyioSavop1C5mGlASvyVwS3vsehKcib/PY9w/NbBaaUoFs6NzDGqMpxBliHOoDqZQ3/Y0tgqGLvhspfPSzbaXUEZdpe18kYoSE6FiLwfGi4rtO+Hb/+2ING/RsBh53xthwCZB3xj8kdsUnVfu2D/ygbiW0uqmCeaCMncPpB7LS4ElTlWZUIafFZI3ef7SPXuOhF01uO7/Gk71xyxDtbi4F1tdZF0S57YRO/Fmxd5E5PS6M0EjvX1fH5qixDdCPUhieA8H1MaJcf7VnHtspHuo6DaeQ1V+niS8xMIQp0oQ8Rq2zv7z9syJSIz0bChWY5uK57IyAr1vtt6jrMnlCegwZ0NU6tGQh5BKrVlL4iLdVeXVlhvaJLXtQUJjmADxA+iIgOK9tk7Hf6fp8YYI4QGEMM28wykscdqPWNeB1i4A5ncT2IIxppjBCof7SB1uhZYY4kxSRLl62ceLsHt9OEcuoZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39850400004)(346002)(396003)(451199015)(38100700002)(33656002)(107886003)(71200400001)(8676002)(478600001)(76116006)(4326008)(52536014)(9686003)(54906003)(83380400001)(316002)(38070700005)(2906002)(26005)(41300700001)(86362001)(6916009)(8936002)(122000001)(55016003)(7416002)(7696005)(186003)(5660300002)(6506007)(66446008)(66556008)(66946007)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1J5dVlocWFCa3J2b0tLTkJBT0liOTkzNDY5NXpTV1BzbU9SWmJXUjJuRmdB?=
 =?utf-8?B?TzFERUVYWjZVZVV2VGxKWmFLMWp3MklVcjRNcEZUREJUSUZ6VWQydnE1YzZI?=
 =?utf-8?B?RmprMlRlQ0ZKcGhUVm1hdjUzYU9MUVRaUVhlSmJ1TVI4QWprUHIyL0hNUGl2?=
 =?utf-8?B?aTdZT25WZ3Q3VWd2TXZpYzJXK0N2MUZxVmxMNUgxemRLMzFVRVBSVVpTbHlL?=
 =?utf-8?B?ZDQ1ek9nR1VpcWZSWkNwWnZnT2k5L1lFeVJZeDhlUjc1NTZHOWM3b0FhdnNo?=
 =?utf-8?B?SW5EajRYYXlBZHNDdk5VUUx1cDlzQ1NEbTNSZkhjdWpMT0lTM2htY3pGQkFv?=
 =?utf-8?B?NjFKUWxIZDRvNWwyTzUyektwR0hhUm9SMTVQUlRBb1hOazV2OGNIb2UvMHRj?=
 =?utf-8?B?NUlQMjFZVmNPZ2FLd0lON3Q4TlZ2RnA1aFcyUDJySEdPbDEyTFlMelRkRTM0?=
 =?utf-8?B?elhrRTdZWDJZbFNmLzUrK1AzZFgwTWhESTBEdW1Rd05ZdnJNODNrcEhKaFpp?=
 =?utf-8?B?Y3NWTkpvSmxaZ0dEZTh4eU4rbVpydDh6MVFTV2NOSFI5WnpINlVFWStGTmlE?=
 =?utf-8?B?U3hNSGEvRUNFVk9RRUpmcUFpQ0VUcWErbjVRQ29TU3VhVldTUlV3M1RmOW5W?=
 =?utf-8?B?cmorVDRnRWN5S0k4K0s1K3Y2VDl0ZVhyMzFRaWRvSVhyNHZ4aWN2Nmp4TGVi?=
 =?utf-8?B?a29YZnJPUjZLQk5WVTVOQTRzL0dkMlhhd2ZPeXVFY1lvcEEzL3ZYTWhJWmRM?=
 =?utf-8?B?aHR1cXVxYkFKNEt1K1N4UllIaWZwV2VhdVVxZHQ5ZmdwOEJHT0JBN203TlZN?=
 =?utf-8?B?THRnRkNiZEhTaE1oT0JmOGh3OTIwZitMQjlRbExDQjhQeFIwLysvMkxBZUtE?=
 =?utf-8?B?TjArMjBWMHJIbDVpTWkrK0MxV3Y2eUR0QkZKTXE5Z05hQU9wNmU5c0ZpTDA3?=
 =?utf-8?B?U1ZYYXNDUXBWYkpOQ3lSZXJKdC9qdTBOQjluZTVqUHJQb045MFl4SlR0Ny9O?=
 =?utf-8?B?aHRoemV6cEQ3ZlE4bVVKa29pVHpqUGtWVm5ad0gzRnp1dVRLWHBuUTRuT2FQ?=
 =?utf-8?B?R1JMSEpsL0NDcEZiQnZoSFdsWndCanFjZ0s0ejJmbFRzT3djY0syakJIbFRO?=
 =?utf-8?B?MlNxVTRmVENsQjhCSmZqUktBY0hOc1JBS1hubzJ3Y1FNRW9EMnRnNEJhZDVH?=
 =?utf-8?B?MjdBcFl1em1FcjhQbmtySXFaa3dmU0dneHBBR1ZwN2xjYlk4ekE3a3MyR001?=
 =?utf-8?B?emc3VWpSK3lRRXZQOWN1YmhNL2pNcWxHZnoxUm1mTGl0S0lLLzZ1WGNHcGwz?=
 =?utf-8?B?VCsvMVBBS0x6NWF5YnFGd1RFN2VQbXpuU3pvZ2dMbjJZNHRKUERraHRaRG9i?=
 =?utf-8?B?NDM3UUxaZmJvenRmb0hDZ0d0K0hFYStaVyttYkgxWWUybFZjNFFUYXh3SXJ4?=
 =?utf-8?B?SmE0M1hqWE9OaWRxUHM0dEk0SVg2K1Q0NlpNRUpoaWhQV2xKUlI0S3hxSWs5?=
 =?utf-8?B?UnlGQytLZ2NTZkttcXNlZ2pUWk5VMXpvZFVaUkNmSzJ1bXVJd2lYaXp3S1JQ?=
 =?utf-8?B?MmhkeHZVZndISXRxeXVrR3crQjF4OFpycnZCbFlaclp0THFvcmhYWjBTUWtV?=
 =?utf-8?B?bnFsTzE3cFdmMjR1eVFpcjVSWk5MdGovMFBJS3pUSUt2aDlUVEswQW1mYTFa?=
 =?utf-8?B?TUEwVXdkMnNPRXVJZFhCdFNCQndJOTJpSzRSMkFRRTZJU3ZTeEZMc0VMd0Ja?=
 =?utf-8?B?S25jQjJOVTFZMU83eVlieEtMQWI5VXRod3d4MnQ2S0c1VlA3VlJZcDVpeXdR?=
 =?utf-8?B?SXlEcDNLd1ovcE9FRWxXMUNkRWlYUm1QQmtaN3B5MnM2UlNaZlRGUUVKRUVz?=
 =?utf-8?B?YmhGQk14bEY1TE1HR2ZyWXlHdy9qc2N6UzFHUFEzbEN1OUdQYTc0YVFaWHRz?=
 =?utf-8?B?ZVYySU16Z1NOT2RUNmJxZ3I4QTFiYmFUdkpMZkVxSXB2S0lpSi9wcUV2Y1hZ?=
 =?utf-8?B?dm8xaUhDWHZFU0FKNDVZc2hnNVZZSnhEenA5cWQ2c2l6Z3hwbU1CZWJKcVpi?=
 =?utf-8?B?a3lIY2UxdlJUa0tQaC9TK0FpUE9vVCt0Q2dhSmtSV3RuNjZNSG1id3M3ZmUr?=
 =?utf-8?Q?RFdhl+/ZcGHlJVrH7efDLRhxi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb4610-430d-48c1-b6e1-08dab8c379dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 09:04:52.8428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2JkdhBU1DQXwTYuoQmqDfiKUqMsBLs84oQRRiBsnOZDAoQSNJf5rqOCXbuJVJrU/WTV05bC3Y3nl6REWsGE/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCj4gPiBJIHRyaWVkIHRvIHJlcHJvZHVjZSBp
dCBvbiBteSBzaWRlLCBhbmQgaXQgY2Fubm90IGJlIHJlcHJvZHVjZSBpdC4NCj4gPiBIZXJlIGFy
ZSBteSB0ZXN0IHNlcXVlbmNlczoNCj4gPiAxLiBlbXVsYXRlIG9uZSBvZiB0aGUgdmh1YiBwb3J0
IHRvIHVzYiBldGhlcm5ldCB0aHJvdWdoIExpbnV4IGdhZGdldA0KPiA+IChuY20pDQo+IA0KPiBX
ZSBhcmUgdXNpbmcgcm5kaXMgaW5zdGVhZCBvZiBuY20uDQo+IA0KPiA+IDIuIGNvbm5lY3QgQk1D
IHZodWIgdG8gSG9zdA0KPiA+IDMuIEJNQyAmIEhvc3QgY2FuIHBpbmcgZWFjaCBvdGhlciAoYm90
aCB1c2IgZXRoIGRldiBkZWZhdWx0IG10dSBpcw0KPiA+IDE1MDApIDQuIFNldCBCTUMgbXR1IHRv
IDEwMDAgKEhvc3QgT1MgY2Fubm90IHNldCB1c2IgZXRoIGRldiBtdHUgdG8NCj4gPiAyMDAwLCBp
dCdzIG1heG10dSBpcyAxNTAwKQ0KPiANCj4gTm90IHN1cmUgaWYgaXQncyByZWxhdGVkLCBidXQg
aW4gbXkgY2FzZSAoVVNCIHJuZGlzLCBEZWJpYW4gMTAgT1MpIGl0IHNob3VsZCBiZQ0KPiBhYmxl
IHRvIHNldCBNVFUgdG8gMjAwMC4NCg0KVXNpbmcgcm5kaXMgaXMgYWJsZSB0byBzZXQgTVRVIHRv
IDIwMDAsIGFuZCB0aGUgaXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQuDQpVc2luZyBuY20gJiBlY20g
aGFzIG5vIHRoaXMgaXNzdWUgYmVjYXVzZSBidWZmZXIgbGVuZ3RoIGlzIG1vcmUgYmlnZ2VyIHRo
YW4gdGhlIHJlY2VpdmVkIGRhdGEgbGVuZ3RoLiAoRllJKQ0KVGhhbmtzLg0KDQpSZXZpZXdlZC1i
eTogTmVhbCBMaXUgPG5lYWxfbGl1QGFzcGVlZHRlY2guY29tPg0KDQo+IA0KPiA+IDUuIHBpbmcg
Qk1DIHdpdGggYHMgLTE1MDBgIGFyZ3VtZW50IGZyb20gSG9zdCBPUyA2LiBCTUMga2VybmVsIG5v
IG9vcHMNCj4gPg0KPiA+IEkgZHVtcGVkIHRoZSBgcmVxYCByZWxhdGVkIG1lbWJlcnMgaW4gYXN0
X3ZodWJfZXBuX2hhbmRsZV9hY2soKSB0byBzZWUgaWYNCj4gd2hldGhlciB0aGUgcmVjZWl2ZWQg
ZGF0YSBsZW5ndGggZXhjZWVkcyB0aGUgYnVmZmVyIGxlbmd0aC4NCj4gPiBJbiBteSBjYXNlIGBy
ZXEubGVuZ3RoYCBpcyAxNjM4NCBieXRlcywgc28gaXQgbmV2ZXIgZXhjZWVkcyBpdCBpbiB0aGlz
IGNhc2UuDQo+ID4gSSdtIHdvbmRlcmluZyB3aGF0J3MgdGhlIHZhbHVlIG9mIGByZXEubGVuZ3Ro
YCBpbiB5b3VyIHRlc3Qgc2NlbmFyaW8/IEFuZA0KPiBob3cgY2FuIEkgcmVwcm9kdWNlIGl0Pw0K
PiANCj4gVGhlIGxhc3QgMyBjYWxscyBvZiBhc3Rfdmh1Yl9lcG5faGFuZGxlX2FjaygpOg0KPiAN
Cj4gYXN0X3ZodWJfZXBuX2hhbmRsZV9hY2vvvJpyZXEtPmxhc3RfZGVzYz0tMQ0KPiByZXEuYWN0
dWFsPTEwMjQscmVxLmxlbmd0aD0xNTc4LGVwLT5lcC5tYXhwYWNrZXQ9NTEyDQo+IGFzdF92aHVi
X2Vwbl9oYW5kbGVfYWNr77yacmVxLT5sYXN0X2Rlc2M9LTENCj4gcmVxLmFjdHVhbD0xNTM2LHJl
cS5sZW5ndGg9MTU3OCxlcC0+ZXAubWF4cGFja2V0PTUxMg0KPiBhc3Rfdmh1Yl9lcG5faGFuZGxl
X2Fja++8mnJlcS0+bGFzdF9kZXNjPTENCj4gcmVxLmFjdHVhbD0xNjM0LHJlcS5sZW5ndGg9MTU3
OCxlcC0+ZXAubWF4cGFja2V0PTUxMg0KPiANCj4gV2UgY2FuIHNlZSB0aGUgbGFzdCBwYWNrZXQg
MTYzNCBleGNlZWRzIHRoZSByZXEubGVnbnRoIDE1NzgsIGFuZCB0aGF0J3Mgd2hlbg0KPiB0aGUg
YnVmZmVyIG92ZXJmbG93IG9jY3Vycy4NCg==
