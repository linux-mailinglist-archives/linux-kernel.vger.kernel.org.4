Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38C6668BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjALCLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjALCLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:11:19 -0500
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FAD26F;
        Wed, 11 Jan 2023 18:11:17 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 30C2AqON001864; Thu, 12 Jan 2023 11:10:53 +0900
X-Iguazu-Qid: 34tMVHkSTwiRPcm1xv
X-Iguazu-QSIG: v=2; s=0; t=1673489452; q=34tMVHkSTwiRPcm1xv; m=crQ97L5mMD2T96F9yN9ueSTbshhU5tWp+mcaC+WWh0s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1513) id 30C2ApZx009449
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Jan 2023 11:10:51 +0900
X-SA-MID: 52904112
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M726Wwm0gz2ZPujWcikZkH+l0nX324pWI8OWoCxOEbggETS3253EEZSlZ1kvXTJx7cmZ6pLmqjybjnqQjYl684Yv2T4IwUcOx7crBrEu1etC6yh7U2rIPDupOhPydzHrwrr3jnNPbXLyHrBm1LlNnaDZJHbYvvGpYsDNyZGIh3aQ81hcrKtsntH90mfqCY4DuXCF2EFMEdvnZZNN0kNifH+XRYQAoNCNyzu7PsYM4FT0Yl0WBlgK93uT2leCU+jEmNBCxGfHM5e+r9XBt6SJsGME5AIiyYzZotOtHY0FwBmEowzaCxX/Y0hzg06YBbEEhKQo1lCGQi2pSAN9mBccYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzivsKM9ymsLDd/QrGfjVuyNwKQ1dT+7TxrjpJGwVu0=;
 b=RzMLEXmoaDQDlj1dLowB91EgVn6diBNDCU40c3CCiBwIqQS/Mu6WP2ob8GFjuR3/cksLtFpv1iDv/NU2Z7Qe/F7zvSx4uDnl2C6V6EbFloU14aI8vyQBjQ9o1eETVoiwgJVKIXPdoUeplIJtT4B8pAk2oaKgc7nj+J2gu0jrkz112TsfvX5trRX5zgEIRqIZbdwynNZb2XUjrqHwsnJr1huH0qQB43stlXjUNmpI1x4r9DB4vcC29jyZ6fCRmqXVJ0aa9ourbBVN3xIUK/BNsEgHTiyDWF6x7DPG6c/bb5XoONAJ4ZKXk/p7jGdrikcAi5aWmeEWkBcy3qzkT7OSrg==
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
Thread-Index: AQHZJJTAFXt/zFsv/k+G9pe5B8zila6YCwmAgAEiAQCAAAsWAIAAzWwA
Date:   Thu, 12 Jan 2023 02:05:38 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62014698C65E5ADFBD07C65F92FD9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
 <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <14ffd7a0-caf3-d5ee-18bb-df4e53f276c7@kernel.org>
In-Reply-To: <14ffd7a0-caf3-d5ee-18bb-df4e53f276c7@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OS3PR01MB6037:EE_
x-ms-office365-filtering-correlation-id: c9ce01ae-639e-4520-bb6a-08daf4417fdf
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5V3xxTWPIEg8ixLDH0oZYH1ktMQQpM6A4QoUbhmmPQ5Y6rAZkADH7/oemAJOwC5zsF6z77mRsUbZRN6xJo71hQxnkMRMNHXprJiNXWwn60LYTUGXAg/sKyrV1Gtl/nZcmMKmb+uisK+JfAfYMaQOtzIJwy4WByOnVOX5STO2L54HKTWpilkpl4eIPfq4sffZCjSAFX0fFn0Zr1GaP40XcnQOCdUJgXq0QY27N9e7ZkaVMhJxtaJn5p54gPQ9YRJA3QYQF50mq6OY4ilB+rujvpAn3xwcSnp2uI5wpWYKoJlC4tXYPzXOQSNs5dqxFZbt1LGXnAPvo8nION8BWsDxLgl8fnOi84SFrTrMAqDNm52vajJGrgkaLBeFQJrAxhS/IX8jEYdCrTxcERW2NnduIyMR+YCY7f36VBgCKYf1DFV79gLpPrRyY5XZ2heF2B2P9Bqe2dl01eKfPV8nzIAsa94fqBU7dxYcwDQMQQ1U/84MIFssAfol0zd59a3n5DCLrpKk0eI19nXlts2Q2/H2P1GiGfdqohqgA83mvRDquY++iIcJPVipro+8M6/l3LzCgrFXFATVoDYy5qmM3qpCrNFQ//gbceQ6tGzYIXJK3MIeSIYj4PSoKj5PrcHn+wo4M7DkqQJ0GIKDi57IJo5kQSXLluaF07VGP+U0utmj0WNCWTiwYhl0PYSbturjNDgENJiWGq3gf+a4Tu9POXcRIj0oZZWed+ac84c2sB8w4Wo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(66556008)(41300700001)(66476007)(122000001)(66946007)(52536014)(8676002)(66446008)(76116006)(4326008)(64756008)(5660300002)(6636002)(54906003)(38070700005)(316002)(8936002)(110136005)(2906002)(86362001)(38100700002)(71200400001)(966005)(7696005)(478600001)(9686003)(186003)(26005)(55236004)(55016003)(53546011)(6506007)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NPeWNCd3FCeTZ5OGZMbkpDTEZCMWlFNzhLTDFHV2JYZHA1NFVHdVpnTDdt?=
 =?utf-8?B?QVB6RmRJcVpPdTNFa01PaVZpOWhMeG1aTnNpZTA3b1lCYm9PQ3dqdi9sVlBW?=
 =?utf-8?B?bGlsekU1VmVlUXc3MHJPTk1RTXJVTCs3d1FjVzhRSFRsTlpjSTc0cnJpVy9l?=
 =?utf-8?B?UmI5VVVwai84aDNEaGw5dmt5dVVBSVhObUtWakxTNU5lNlEvL0ROeXpwb0Zi?=
 =?utf-8?B?dmV6bU5FVmUzQlp1TFB0TG9qNnVWQVBOWlpJbURWY3hTUVE5dGgrRDc1Q0ha?=
 =?utf-8?B?WDNEMWE0NXBFUEhiVmlCUEx1dVVOSmlBZ0lidmk5ZVk0RDVQd21tSml4R3pl?=
 =?utf-8?B?RFQ5dUVEOTVXMnhPd0FIeU5CWEFVNEFRYTQ5WlJQL1JtbVhzQ1Fna0VXU1FS?=
 =?utf-8?B?WEU3SDFNWGwvaCtkdlNhL0lCRVRINVhoeXcxc1ZQSG5rLzF5YWhwZkZFL0kr?=
 =?utf-8?B?bm1hR3J3b0RsVjdjMldaTjVXOExIM1BSaFBBR25hUXgrb3FLZ3I0UkRxN1px?=
 =?utf-8?B?YUtQaW5WYlNwYjJjZ2ZDRXVVbFJjUnVsVFJTcnhEaDR4TEJCZFlFYjR2Y3p4?=
 =?utf-8?B?T1hORUg1NzR4eFhFK24wdXR3VUtpcTl2SUxIZkZtUzJQQkFyc1ZCNVZYWmNV?=
 =?utf-8?B?ZjhqdGNZNTZIa01sa0dWa29wb05MWEdSVHVWL1FyQUR1c3FkV2RMSENkU2d2?=
 =?utf-8?B?a2sxdEgrL1ZRalp4RitQZ1RucmxFQS9BRWRUTDVQQzZLVlJpT1ZBN3htREdN?=
 =?utf-8?B?clk3UW93LzQ0dXlZVXNFMnBJdmgrUUYvWSt0bkk4U1JaVE9QN0Nla21HeUJn?=
 =?utf-8?B?dXJDUXBEb0trMXM3UGdIZlFOSFVwQnhTSW5LejV6dFZCcjF4cWFYY1lqams0?=
 =?utf-8?B?R01VNGZCZWNZbWE5K0t6THh1NmNvOUM2NEM3VE5ZdlRybDVVeHFXVjdXZUJC?=
 =?utf-8?B?VCtmVFRSbUNISjlFU0ZqOGpsbTcxdldidzNDU2x3YWwrMjJvUTlWR3hMN29y?=
 =?utf-8?B?amV1MFcxUXp6TW9kUDVTb0o3SmdJSm5iSEQzTDNxMW5OZWFHS1RzK0JsMEZI?=
 =?utf-8?B?Y0tJby9heHM4VE5teGtmUTlCMnJ3MFYwUjQ5ZnFDaGRMcWlub3NsR1c5Rkli?=
 =?utf-8?B?c2hPOGNHejBwOGZYaVByNWxISVJCL2NEZk9TbmFpRVZVYTk5bkNwQ1pXbE1z?=
 =?utf-8?B?NlFmUXlwNWZkSVNsNG1xOTJMb1AzUlM4Uy80RTgwbmNseEc5UEJpb0s5TVhv?=
 =?utf-8?B?YVRWRXpXQldNMG1NYWxFU0RNbUpKTjJEckcxMm5uUFJ6UThRS3RtRktudTRR?=
 =?utf-8?B?SWFiZnB2K1ZDZVEvUXBoSXg4cm45MVd4UnlWaWxjVVRzQTI3cjlHem4vV0ty?=
 =?utf-8?B?RVBES2haYWVDQ3FpMmlJck9saUQ3Z3pPaEMvKzlEUlJsZDZKSXhUMVovNktm?=
 =?utf-8?B?cEpyOEZIMHE1ai8vVnQ2VGtSZjlrbEUvM3h1QlZVaWFQeGlwQjZWSnQrSm9t?=
 =?utf-8?B?NGVSeStrQXNJc3hSL2l4T2pBZUk3cDhJYVV3dG5GOHRTa3lRWldNYk02T2dY?=
 =?utf-8?B?QkI4VHh4d0VuS1FTbjhSWGZ4aHN0WkVOUy9ZbStYbGY5ZW9GaHI1Mit0R1ho?=
 =?utf-8?B?Wlk4QnFMMlB3cld3aUh4R3cwUlFzdHRyMXhsblJ6VjJWd3Z2QWg4bHN5c2lU?=
 =?utf-8?B?OXRLNUF3U3ZwTVlDblNVdENQbkpnZHEzemcweGduNDJseFVVNndPMEhnMUtk?=
 =?utf-8?B?cVZVbEQ1SFExRVBlRGxVRVFLTDJodzNLbmtzS3BDUExIQ1NNMDBKTkVtYms3?=
 =?utf-8?B?V1VSbUZhMzB5VUJrZzdqbU5WMXpIVXdzTTdyaGYwbjBsTXlGQUNZSyttY1RK?=
 =?utf-8?B?NStEbXV4cUZhUHpsNkgyRUx0UXZCeVp0K0ltTVRxVVYwR1RGVE85V0F2KzMx?=
 =?utf-8?B?UnJTbW1xd3F5UHBNbWhjQ3YrS0lDL1E2N1AveFFzRFJvTFhkMzVVWUxkUmNw?=
 =?utf-8?B?QkxkeW5SMkdXZmlzck1yNndXQlhLWHFobHdSbW5BQlpSVitTdklSMGlhc2xZ?=
 =?utf-8?B?RE40VkJNMkJ3cHpkZjkza3Y0QkpuSThyeTNzU0pvWXFNMks0TjhZSytLWWJ2?=
 =?utf-8?B?bmdpUEtNU1FaQTZNeHhPczgzUmxiQk5iem12c2s2Y05sZ3F2OFZNS2tTcit5?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ce01ae-639e-4520-bb6a-08daf4417fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:05:38.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VYc42+34ioGBoBBYzcwfbMNFzlV0bfmcsMl4GGX2rtSegb1jM4BCF3fwMcYJL/SW4BuxUWMvnn+3AxPFbMO67L/1/tOUQzSah7kh3lW4k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6037
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTEsIDIw
MjMgMTA6MjkgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDil4vvvLLvvKTv
vKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5pc2hpa2F3YUB0b3NoaWJh
LmNvLmpwPjsgaHZlcmt1aWxAeHM0YWxsLm5sOw0KPiBsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25i
b2FyZC5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsgaXdhbWF0c3UNCj4gbm9idWhpcm8o5bKp5p2+
IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9z
aGliYS5jby5qcD4NCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDEvNl0gZHQtYmluZGluZ3M6IG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJh
DQo+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVyZmFjZSBiaW5kaW5ncw0KPiANCj4gT24gMTEv
MDEvMjAyMyAxNDoyMSwgeXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcCB3cm90ZToNCj4gPiBI
ZWxsbyBLcnp5c3p0b2YsDQo+ID4NCj4gPiBTb3JyeSwgSSBtaXNzZWQgeW91ciBjb21tZW50cyBm
b2xsb3dpbmcgdGhlIHRvcGljIG9mIHJlY2lwaWVudHMgbGlzdC4NCj4gPg0KPiA+IEJlbG93IGFy
ZSB0aGUgcmVzdCBvZiB0aGUgcmVzcG9uc2VzDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3Jn
Pg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTEsIDIwMjMgNDozMSBBTQ0KPiA+PiBU
bzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8
o+KXi++8pe+8oemWiykNCj4gPj4gPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBIYW5z
IFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD47DQo+ID4+IExhdXJlbnQgUGluY2hhcnQgPGxh
dXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT47IE1hdXJvIENhcnZhbGhvDQo+ID4+IENo
ZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDilqHvvLPvvLfvvKPil68NCj4g77yh77yj77y0KQ0KPiA+PiA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+DQo+ID4+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NCAxLzZdIGR0LWJpbmRpbmdzOiBtZWRpYTogcGxhdGZvcm06IHZp
c2NvbnRpOg0KPiA+PiBBZGQgVG9zaGliYSBWaXNjb250aSBWaWRlbyBJbnB1dCBJbnRlcmZhY2Ug
YmluZGluZ3MNCj4gPj4NCj4gPj4gT24gMTAvMDEvMjAyMyAwMjo0MSwgWXVqaSBJc2hpa2F3YSB3
cm90ZToNCj4gPj4+IEFkZHMgdGhlIERldmljZSBUcmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB0
aGF0IGFsbG93cyB0byBkZXNjcmliZQ0KPiA+Pj4gdGhlIFZpZGVvIElucHV0IEludGVyZmFjZSBm
b3VuZCBpbiBUb3NoaWJhIFZpc2NvbnRpIFNvQ3MuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogWXVqaSBJc2hpa2F3YSA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD4NCj4gPj4+IFJl
dmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEu
Y28uanA+DQo+ID4+DQo+ID4+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwg
dG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkNCj4gPj4gcGVvcGxlIGFuZCBsaXN0cyB0byBDQy4g
IEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuDQo+ID4+IG9sZGVy
IGtlcm5lbCwgZ2l2ZXMgeW91IG91dGRhdGVkIGVudHJpZXMuICBUaGVyZWZvcmUgcGxlYXNlIGJl
IHN1cmUNCj4gPj4geW91IGJhc2UgeW91ciBwYXRjaGVzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwu
DQo+ID4+DQo+ID4+IFlvdSBtaXNzZWQgZmV3IG9mIHRoZW0sIHNvIGNsZWFybHkgdGhpcyB3YXMg
bm90IHNlbnQgY29ycmVjdGx5Lg0KPiA+Pg0KPiA+Pg0KPiA+PiBTdWJqZWN0OiBkcm9wIHNlY29u
ZC9sYXN0LCByZWR1bmRhbnQgImJpbmRpbmdzIi4gVGhlICJkdC1iaW5kaW5ncyINCj4gPj4gcHJl
Zml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNlIGFyZSBiaW5kaW5ncy4NCj4gDQo+IEZv
bGxvdyBhbGwgY29tbWVudHMuDQo+IA0KDQpJJ2xsIHJlbW92ZSB0aGUgdHJhaWxpbmcgd29yZCAi
YmluZGluZ3MiLg0KDQo+ID4+DQo+ID4+PiAtLS0NCj4gPj4+IENoYW5nZWxvZyB2MjoNCj4gPj4+
IC0gbm8gY2hhbmdlDQo+ID4+Pg0KPiA+Pj4gQ2hhbmdlbG9nIHYzOg0KPiA+Pj4gLSBubyBjaGFu
Z2UNCj4gPj4+DQo+ID4+PiBDaGFuZ2Vsb2cgdjQ6DQo+ID4+PiAtIGZpeCBzdHlsZSBwcm9ibGVt
cyBhdCB0aGUgdjMgcGF0Y2gNCj4gPj4+IC0gcmVtb3ZlICJpbmRleCIgbWVtYmVyDQo+ID4+PiAt
IHVwZGF0ZSBleGFtcGxlDQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4vYmluZGluZ3MvbWVkaWEvdG9z
aGliYSx2aXNjb250aS12aWlmLnlhbWwgfCA5OA0KPiA+Pj4gKysrKysrKysrKysrKysrKysrKw0K
PiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQo+ID4+PiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEv
dG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS90b3NoaWJhLHZpc2Nv
bnRpLXZpaWYueWFtbA0KPiA+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVkaWEvdG9zaGliYSx2aXNjb250aS12aWlmLnlhbWwNCj4gPj4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4+PiBpbmRleCAwMDAwMDAwMDAwMC4uNzE0NDI3MjRkMWENCj4gPj4+IC0tLSAvZGV2
L251bGwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRp
YS90b3NoaWJhLHZpc2NvbnRpLXZpaWYuDQo+ID4+PiArKysgeWENCj4gPj4+ICsrKyBtbA0KPiA+
Pj4gQEAgLTAsMCArMSw5OCBAQA0KPiA+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPj4+ICstLS0NCj4gPj4+
ICskaWQ6DQo+ID4+PiAraHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWVkaWEvdG9zaGli
YSx2aXNjb250aS12aWlmLnlhbWwjDQo+ID4+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4+PiArDQo+ID4+PiArdGl0bGU6IFRvc2hp
YmEgVmlzY29udGk1IFNvQyBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgRGV2aWNlIFRyZWUNCj4gPj4+
ICtCaW5kaW5ncw0KPiA+Pg0KPiA+PiBEcm9wICJEZXZpY2UgVHJlZSBCaW5kaW5ncyINCj4gPg0K
PiA+IEknbGwgZHJvcCBpdC4NCj4gPg0KPiA+Pg0KPiA+Pj4gKw0KPiA+Pj4gK21haW50YWluZXJz
Og0KPiA+Pj4gKyAgLSBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hp
YmEuY28uanA+DQo+ID4+PiArDQo+ID4+PiArZGVzY3JpcHRpb246DQo+ID4+PiArICBUb3NoaWJh
IFZpc2NvbnRpNSBTb0MgVmlkZW8gSW5wdXQgSW50ZXJmYWNlIChWSUlGKQ0KPiA+Pj4gKyAgcmVj
ZWl2ZXMgTUlQSSBDU0kyIHZpZGVvIHN0cmVhbSwNCj4gPj4+ICsgIHByb2Nlc3NlcyB0aGUgc3Ry
ZWFtIHdpdGggZW1iZWRkZWQgaW1hZ2Ugc2lnbmFsIHByb2Nlc3NvciAoTDFJU1AsDQo+ID4+PiAr
TDJJU1ApLA0KPiA+Pj4gKyAgdGhlbiBzdG9yZXMgcGljdHVyZXMgdG8gbWFpbiBtZW1vcnkuDQo+
ID4+DQo+ID4+IEZpeCB3cmFwcGluZy4NCj4gPg0KPiA+IEknbGwgZml4IHRoaXMuDQo+ID4gSSBk
aWRuJ3QgcmVhbGl6ZSBhIG5ldyBsaW5lIGhhcyBiZWVuIGFkZGVkIHRocm91Z2ggZm9ybWF0dGlu
ZyBhIHBhdGNoLg0KPiA+DQo+ID4+PiArDQo+ID4+PiArcHJvcGVydGllczoNCj4gPj4+ICsgIGNv
bXBhdGlibGU6DQo+ID4+PiArICAgIGNvbnN0OiB0b3NoaWJhLHZpc2NvbnRpLXZpaWYNCj4gPj4N
Cj4gPj4gQ29tcGF0aWJsZSBtdXN0IGJlIHNwZWNpZmljLiBZb3UgY2FsbGVkIHlvdXIgU29DIHZp
c2NvbnRpNSwgZGlkbid0IHlvdT8NCj4gPj4NCj4gPg0KPiA+IFRoZSBWaWRlbyBJbnB1dCBJbnRl
cmZhY2UgaGFyZHdhcmUgaXMgbGlrZWx5IHRvIGJlIHVzZWQgYXQgZnV0dXJlIFNvQ3MNCj4gPiBv
ZiBWaXNjb250aSBBcmNoaXRlY3R1cmUuDQo+ID4gRG9lcyBjb21wYXRpYmxlIGhhdmUgdG8gYmUg
c3BlY2lmaWMgdG8gU29DJ3MgbW9kZWwgbmFtZSByYXRoZXIgdGhhbg0KPiA+IGFyY2hpdGVjdHVy
ZSBuYW1lPw0KPiANCj4gQ29tcGF0aWJsZXMgc2hvdWxkIGFsd2F5cyBiZSBzcGVjaWZpYyB0byBT
b0MgbW9kZWwgbmFtZS4gQWRkaW5nIG1vcmUgZ2VuZXJpYw0KPiBmYW1pbHkgZmFsbGJhY2sgaXMg
YWxzbyBnb29kIGlkZWEgd2hlbiBpdCBpcyBhcHBsaWNhYmxlLg0KPiANCg0KSSdsbCB1cGRhdGUg
dGhlIGNvbXBhdGlibGUgdG8gInRvc2hpYmEsdmlzY29udGk1LXZpaWYiLg0KSSdsbCBjb25zaWRl
ciBhZGRpbmcgZ2VuZXJpYyB2ZXJzaW9uICJ0b3NoaWJhLHZpc2NvbnRpLXZpaWYiIHdoZW4gYSBz
dWNjZXNzb3IgU29DIGdldHMgYXZhaWxhYmxlLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNClJlZ2FyZHMsDQpZdWppDQo=

