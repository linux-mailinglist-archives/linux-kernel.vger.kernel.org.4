Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDE66DDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjAQMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjAQMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:35:23 -0500
Received: from mo-csw.securemx.jp (mo-csw1116.securemx.jp [210.130.202.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A312B61B;
        Tue, 17 Jan 2023 04:35:20 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 30HCYmaq020551; Tue, 17 Jan 2023 21:34:48 +0900
X-Iguazu-Qid: 2wGr0AvYwZqclLSdM3
X-Iguazu-QSIG: v=2; s=0; t=1673958887; q=2wGr0AvYwZqclLSdM3; m=EjQsS2iilBZHE/TbHxSlUWEqJk/pZjoIoTsc2fyOsxg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 30HCYkNE034754
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Jan 2023 21:34:46 +0900
X-SA-MID: 53238212
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAHatiF+Xe2Wm93smOD4a9N11q0hLdhYERc7/1hf/CkSaCAZQ3dDHhGDV2gtUnuQlvmIHLjuWBNBnQ0ronFjYOqWx++ss0clWrtdDKudDXsEjIOAWlpRRe2ziu+V36SV01WCqO8Nk4ZbJ0Pcl7fT88BJIACJyWHUHeOosF3rdGjbSi8C8Oo0MnAFUrJMdt+8pe2eNFLz9WSf3s2/hG+FsLaHKzU/V5hmu9iilVuPjrmZeS23OS5T+HePmM01JiXzKZZ3HnXuDRZcPiL2JmXD8jATFwTEOR/pSOhDmZ/lWrUgb+bowcrwY0mn8BQQ+yz7jTHgYabItSwsrr4ZT5uBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbknxRtMxfgwQ/eHRX2njc1o1Blnk7WBX6eSnBaOzhU=;
 b=bEQWL3h1z3EtSo881EsjsbjDiEBJlEbtWhc4udStArl03Z6KZi5H00/Y1pw7gDHAkZ15eohNLJ2gm6HWpe0gFKoILOtlJq474xcir+pMUsqWh3vQDz/GYD+f3UiLxTv2s7D17/MpVQJMpoaGH/2VZR3oUAZyUNjR7ksMN/i4sgDlhxZQOD5RHa2KdA9phmh6nwOpA8q78yVuYNVEidg8UpajSkifypvoebcnJgfy5vyiJ67iBHnJ8lLTTkjiT/c5yC8Eh9j7uvFsOhpP2GMeSM7g1Pz3nPgzwDRwQ582xUa/iecNgPcynHdXs+i495tK9a7/TzM4gRr/sveeO7vD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzk@kernel.org>, <hverkuil@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJJTAFXt/zFsv/k+G9pe5B8zila6YCwmAgAEiAQCAAAsWAIAAzWwAgABsKYCACCDswA==
Date:   Tue, 17 Jan 2023 12:29:39 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62012C375164A60ED102929592C69@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
 <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <14ffd7a0-caf3-d5ee-18bb-df4e53f276c7@kernel.org>
 <TYAPR01MB62014698C65E5ADFBD07C65F92FD9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <f92ff708-add2-44c3-8e51-33a1279cecbf@kernel.org>
In-Reply-To: <f92ff708-add2-44c3-8e51-33a1279cecbf@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OSYPR01MB5429:EE_
x-ms-office365-filtering-correlation-id: fa743fe0-86c7-4ff6-e6cf-08daf88680f8
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZaru6kr7i0ck81obsrRvU437Mk1AtSR9uFi8wlheAYLAMGWaqVjiZCwyqh4gqe9uZjXz4LYNWA/pxg9WO5bE/3kXl3F3a2v7//4mCmD9NDqVj2kbMcHTLAjY5c5R5NaRwYQlC3tGP488B2YjAsUmB7PNEROiFxsbY7b1gM1Y7CzgXOz+iO5pB0kT1ieng9qSXknyNyOwLFMEQKhm5PMvz4bnodKEs63aIfmcHlN3q+lR2P+tNPjQ8j7vofIigtZQWSPlipHYVV02gQeexaMbj3HJAflDBToomE4WL8muPRvHx1blsZWL0jA2RMQaNWzTr1RDLseoJgPwEPm1SKJDxlVjgh8mi+Aomrmt04hAuS3i5nLwXhrLJ4uZ2h+yIUF0JoZsyv2jZP4mm44k+KJLq6jRvcRJ0dyrf8NLGaLD0pKDy4dsX/ovnVR6BDpNzGFkBBta1hqJ6IUY74QO3Y2wdjRkKiu2yZP1OkKnWGn8JrmEIRRzoTVgGqzOf8RI7DbwRUz7kvUsyj3+c7gfXWrOXP8C5zgEWR/jFWa+a/tHNk1f27/jJE6bE9uNqQqHAongXiwjKdbYhItpHa63IrIK6N/odWCGq2+dNVr/0sT7f6I6W2E9PYiMGjA9jS2m63Cjdx1U8QG5Bappbc336r9QLf/XCb1Nsm6V1L9Ja5At1uZI0UuhzEq1g6k0wCb2gLilV1Te7fNLnBYfqsQbZkITw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(38100700002)(83380400001)(122000001)(33656002)(38070700005)(86362001)(4326008)(2906002)(66476007)(5660300002)(55016003)(8936002)(66946007)(8676002)(64756008)(66556008)(66446008)(52536014)(76116006)(478600001)(41300700001)(9686003)(186003)(6506007)(26005)(53546011)(54906003)(71200400001)(316002)(110136005)(7696005)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andDeXcybGVBaDQyd2xZWXNHR2FPbExRUkVoL2FPQ08xclJhZGVreDFtWnNl?=
 =?utf-8?B?ZWlVQjlZYXlUcnJiR1hibEZLTktvSHFQbjQrLy9pd1BqME92ZDZScEFmSkJ3?=
 =?utf-8?B?V0w4STBpK1g4VFFLTE1pMURpaFlvQ3BjeFN1aFBaNlZCVVpmRHBjUFVMNTl0?=
 =?utf-8?B?by9DQnJtblRHSW9EMTVOem9Ram9yMFgwcFcrMWZ6VEZ1SmtJOFBuQW8zK2Mv?=
 =?utf-8?B?M01HakRIckQ0WVozN0Z0VkpKUFEyaU5uSHhEUTVGQjJCUm1tdmRMRVY1Ny9h?=
 =?utf-8?B?L0E0bzkwalhNRXl6MUxRbVJIbjRQQlNDay9UeHlvNERoL1ZML1ltai94dkpE?=
 =?utf-8?B?bER3RDRLWm9WYXo5K2VDK1Uxb1JUL1BuazU0WHR4MjNEVFNlTityZkdzalhL?=
 =?utf-8?B?eWlRWmpKTFZKeWxhTDU1bWRhRXorZ0NGYmVoRjd1SGFNVWZXNW14cnUrSE13?=
 =?utf-8?B?TXE3TUhIMzRCK291K1VQU2k4OEhmT01mUDdXb1F3WWd4K2dHVW5HeVlab0Zi?=
 =?utf-8?B?c0M5MWRtMXVyWldObGQ3eUtpWDlKRTVKUlh5bDZ5ZWlUVzZaYnJOekhaTGRl?=
 =?utf-8?B?VmRSeUxzdjQ0QWppelhnOWxjbHJEU0pmMTVGOXhVZW50bWgvdE1GTEwySWtp?=
 =?utf-8?B?bzUvaWxLeVdaRXpLazRjZlhjK2NGSnEvelRNYVV3bUIzci9nSjNGb1hDL0tF?=
 =?utf-8?B?ZHRQWE5hQXpYZWNuVDlHSXR4dzFrTEJQMWdSYTVYeEVmQmI2cW5FMUlpNU0z?=
 =?utf-8?B?N1VWaGhpc2lHZmY1RDhYdmNxcVBTdzQ5Wk5vdC83UnZTQ01vRHNycEJyeERJ?=
 =?utf-8?B?eEdoZTIvLy9ZMGhuMGc0WkNPbWFxdWdWQmFqU0ZydDRYK3NtUjRRZGNlcVBo?=
 =?utf-8?B?Q3hmZWYzdmxJanE2U0h4eUhRUUd4aTZHNFJEMGM5QURoTlZ3a01NY1E3UmRu?=
 =?utf-8?B?ZVU3M0Y4Wkx5eWJtd0g4UktxNDBVM2JCTlp0UEFTR3htTjFqOVVmQ1ErK203?=
 =?utf-8?B?L1JvZnVuWUF3emtOSm9FQzJESXBvZjBPMGVHV214Y214d24zS3ROaEZJWWZs?=
 =?utf-8?B?Umg0UGM5UnpOT3EzTFkyUjVoOEs2UzBzUWhHMXd2VjVMS3Y0Nzg3c0phZmdh?=
 =?utf-8?B?RGxsTmNIVmUzbFczU280Wm5QajU5RGpGeWh4bUFESDNZMExQbzVWSVR5Y1h0?=
 =?utf-8?B?UGczSHBnM0JFTm5iSElhZU9ObGFnSzNIVisxS2pSbHd4VjdycG1SY3E2MTRh?=
 =?utf-8?B?WXI2SWtidm1FbUtqN0x3Y3dYZlhwQ2oyWVV2bjZpUVlBMWZkcFJVQ3dHWXJz?=
 =?utf-8?B?endoMWlJTlliRnlEVGs2clhJbHc0MDU2TUcvK25JVy9vdkNjbGVCdkZVbnBz?=
 =?utf-8?B?RFhVby93ZnA3Uk5XZjYvYnBKdDRDVUtpSWhFSExuNGtiMFc3a09HcW4vbEZN?=
 =?utf-8?B?c1gzY2lpMGJVdkFsVlJhdVRldy9SRUlOUUxwaFZGRjdqOGxKanJjbngyVXow?=
 =?utf-8?B?VkJCWGNFNW93NEFHT2VXSld1cHNQRG5ROWJ0Nm1JR0ZEVTJFOTlxSG9vV3M4?=
 =?utf-8?B?dDl1QXJ0RjRQYXVqdXJTN1Z6YW15VG1lc1pJNzl2eU9PYXQvQWdHaXJYUnd4?=
 =?utf-8?B?U0FwZm1MZmlFaHRjaEV3dzc1dC9HWXhUSlpMaEhGV09oYVZLeW1pTlk1aXJr?=
 =?utf-8?B?NERUQ09CRVVnb2lCS1NOUHNqYU4walp0R09PR0o2VSszY1VLNWoyM0pTb0ZH?=
 =?utf-8?B?aDlFUXdJVzVsSFZOV2kwR3FzaUsyRStNR2ltU3pMN1ZyVEo1T255dmtCS2RD?=
 =?utf-8?B?eHdrMm1Vc2NQWEFRM2RrWHQ0a0xmRzd0ckFtS0lzblVvTFBETjROMVFOSkFK?=
 =?utf-8?B?YlFKaHhCSmNEekMyTFkzNlloL0pMb0xPWDROb2V3S1ZJN3lMeHV1b3BCZ2Zj?=
 =?utf-8?B?aTVBUm9VaW1OWlpkb2xRY3VYTkZSSkY5SC9pRkxvMklIM1BOQi8wdVZ3MTFo?=
 =?utf-8?B?SXY3Tzc2VDZ2U2JzaDQ4TGsvYXlydGhZdEh6eXZiOU1FSGJ6NDN2UmpTWGRG?=
 =?utf-8?B?dE5yOTVyL0Y5RTJKc3dnVXpucmE1VWd6dGROeXZYa1Mwb0ZwUm1tamRYYkNF?=
 =?utf-8?B?bGNNWFp5VlU1YjZjNUpnbHV4NndmMml4NGFJUWR2aW80dVMzZGhjTCsyTDY3?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa743fe0-86c7-4ff6-e6cf-08daf88680f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 12:29:39.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUneH/UhTl9h/27QHiUxoKB7/19JcALcOMoAt4zP0yOf+YiX63ngb27zHDMtetpqTiCGlElWd8na0PbFlrXmfpJ9zX5MwCNS3Y0nnp2vB5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5429
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXks
IEphbnVhcnkgMTIsIDIwMjMgNToxMSBQTQ0KPiBUbzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg
5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykNCj4gPHl1amkyLmlz
aGlrYXdhQHRvc2hpYmEuY28uanA+OyBodmVya3VpbEB4czRhbGwubmw7DQo+IGxhdXJlbnQucGlu
Y2hhcnRAaWRlYXNvbmJvYXJkLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOyBpd2FtYXRzdQ0KPiBu
b2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJv
MS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMS82XSBkdC1iaW5kaW5nczogbWVkaWE6IHBsYXRmb3JtOiB2aXNjb250
aTogQWRkIFRvc2hpYmENCj4gVmlzY29udGkgVmlkZW8gSW5wdXQgSW50ZXJmYWNlIGJpbmRpbmdz
DQo+IA0KPiBPbiAxMi8wMS8yMDIzIDAzOjA1LCB5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpw
IHdyb3RlOg0KPiA+Pj4+IENvbXBhdGlibGUgbXVzdCBiZSBzcGVjaWZpYy4gWW91IGNhbGxlZCB5
b3VyIFNvQyB2aXNjb250aTUsIGRpZG4ndCB5b3U/DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBUaGUg
VmlkZW8gSW5wdXQgSW50ZXJmYWNlIGhhcmR3YXJlIGlzIGxpa2VseSB0byBiZSB1c2VkIGF0IGZ1
dHVyZQ0KPiA+Pj4gU29DcyBvZiBWaXNjb250aSBBcmNoaXRlY3R1cmUuDQo+ID4+PiBEb2VzIGNv
bXBhdGlibGUgaGF2ZSB0byBiZSBzcGVjaWZpYyB0byBTb0MncyBtb2RlbCBuYW1lIHJhdGhlciB0
aGFuDQo+ID4+PiBhcmNoaXRlY3R1cmUgbmFtZT8NCj4gPj4NCj4gPj4gQ29tcGF0aWJsZXMgc2hv
dWxkIGFsd2F5cyBiZSBzcGVjaWZpYyB0byBTb0MgbW9kZWwgbmFtZS4gQWRkaW5nIG1vcmUNCj4g
Pj4gZ2VuZXJpYyBmYW1pbHkgZmFsbGJhY2sgaXMgYWxzbyBnb29kIGlkZWEgd2hlbiBpdCBpcyBh
cHBsaWNhYmxlLg0KPiA+Pg0KPiA+DQo+ID4gSSdsbCB1cGRhdGUgdGhlIGNvbXBhdGlibGUgdG8g
InRvc2hpYmEsdmlzY29udGk1LXZpaWYiLg0KPiA+IEknbGwgY29uc2lkZXIgYWRkaW5nIGdlbmVy
aWMgdmVyc2lvbiAidG9zaGliYSx2aXNjb250aS12aWlmIiB3aGVuIGEgc3VjY2Vzc29yDQo+IFNv
QyBnZXRzIGF2YWlsYWJsZS4NCj4gDQo+IEFyZSB5b3Ugc3VyZT8gWW91IHdpbGwgaGF2ZSB0byB3
YWl0IGF0IGxlYXN0IG9uZSBjeWNsZSBiZXR3ZWVuIERUUyBhbmQgZHJpdmVyDQo+IGNoYW5nZSwg
ZHVlIHRvIEFCSSBicmVhayBvZiBEVEIgdXNlcnMuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGFkdmlj
ZS4gSSd2ZSBjb21lIHRvIHVuZGVyc3RhbmQgdGhlIHJpc2suDQpJIHdvdWxkIHN0aWxsIHVzZSBv
bmx5ICJ0b3NoaWJhLHZpc2NvbnRpNS12aWlmIiwNCmJlY2F1c2UgdGhlcmUncyBlbm91Z2ggdGlt
ZSBmb3IgaW50ZXJuYWwgZXZhbHVhdGlvbiBiZWZvcmUgcHJvZHVjdCByZWxlYXNlLg0KSSBjYW4g
d29yayBvbiBEVFMgYW5kIGRyaXZlciBjaGFuZ2Ugd2l0aCB0aGF0IHRpbWUuDQoNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMsDQpZdWppDQo=

