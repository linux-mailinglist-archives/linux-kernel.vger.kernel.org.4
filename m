Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327560DDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiJZJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiJZJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:22:15 -0400
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FDA50CF;
        Wed, 26 Oct 2022 02:22:12 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 29Q9LlDl003702; Wed, 26 Oct 2022 18:21:47 +0900
X-Iguazu-Qid: 2wGrOQpXQrO4q2V4ok
X-Iguazu-QSIG: v=2; s=0; t=1666776106; q=2wGrOQpXQrO4q2V4ok; m=q43W6BwG7lCHqFqfTKnaROEr1r458iXGtzLKhrzXkr0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1110) id 29Q9Ljhu007651
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Oct 2022 18:21:45 +0900
X-SA-MID: 44761338
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC1g+ahVOzWM/AJfhXOpCyEJqi1ZyKMuDaExTh3IdLR3g22L6dMmqZWNbAU50RZXw6LIDEJdxgChWMg4y5z8NkUg3sC0T2zvopScLe201mmLjy07hjCPqUfNRthlijxtUrlb0sE2QxbkAlspZVMJj5v0QbXmhAm70fa06/ra4C1bKc3GKecxzgSruQXWEYhokQMxbujpyOg9qvS8Ktn58cBdfv8u/+KjLgh5lY83SEF7ARls0xE8qM5twJ6An4uu3W6vySZs+Og9LkYDQxFg1g97INDtMK+DluIzg4Z8rtfC7Wm56lxNqMsRFHYmQgTbgOQ2MbQK6V9jrMP2CI4BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRMyewLsQOWiqHATQ0oJRt2ltGNc2YRBUPYE1gIafCM=;
 b=CTDUknroh0zUJbSF2JoD1YL1KzbLFtbq7xJm1njRSZBtl44Eh+YjUg0MxtoYHrJcXhfZi7H1j5FKWK26CwJQp9j6kQZMMwr+rCWtqa41aDi7Hf5gt/Rq/I3CPTPiRtY7AU6p/Ecve+t/6gSB2QhTrOJR60IrqNzX6rscY9Rccfhe1aGdtX7KoUOceAjVfXxgwr4OB/jWzlZ2vurE/8d7nZxpSr3XseV9zW1r5Sb3y07wt+6NjNG5WLzA+fv/fTrUwKM4kw2XVz837OZ/+jHFIZJ/F1yQUFJFN4OQblQRDx0pF17DwXyhU0T+iyw9wJAhKaoiDbADOoGLhEFDdA+TYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <hverkuil-cisco@xs4all.nl>, <posciak@chromium.org>,
        <paul.kocialkowski@bootlin.com>, <mchehab+samsung@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Topic: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Index: AdjnXTbTKaza2ljVTOuz35R3VQs17wAH+O+AAGOERzA=
Date:   Wed, 26 Oct 2022 09:16:42 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62019A8DD1215F41F0FE663C92309@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6201561D2644EE783BA8B196922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <b645f983-447b-7b4b-6dd6-d5f10da08e96@xs4all.nl>
In-Reply-To: <b645f983-447b-7b4b-6dd6-d5f10da08e96@xs4all.nl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYWPR01MB9756:EE_
x-ms-office365-filtering-correlation-id: c0664cff-e23b-4705-42e4-08dab732cbdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nV0+lG2kEG6llO2ONzof0bZ82dK47PegKw9gofWVWRO+gpkJH8+5ITCpqs8K5SRDcoVnZDFo+sbTMBsemjLofiNHlA8K5oBZkSeu19bhYwfdzuS0GIbOpoZDk6HzwpNo7N1FYoabywB6USaYCHgaW38LMeb0k/nFtjFgt9nlHDYdHlGYKOmDJYoAJ//T8cADAMsNOGYdqKyuRDOJ5+8KdvtTF+NGnMAdeNESBx9G4vW4pYwgXabyLOhZt/TT/3x1jcSjEyGxTSgNhPVRH6preHLuo4i9QaNE4QBkdngrrR9YpXw6XS9y6jmaRhHCEtP813EMpP0C/AHo860wiH5UeSXwyywzeRz3rjXKpI3xf5Q/ZUKBuoW20BUhInDkcyvH80jkcjM95Qx+oAxPmTxcSrX9SzYw/CavX08qmBunF5sDzemyr/alvdEzVziWAoWs2HmuK7JbHE77yw7jNvvH/77TrzdjeAwM92LpLst7/r2Ixq59mMkNo7FfxxhS0P5TGAOSRiwNdsTiFK+pbUwmMlg/TlBeVuE3Wuo7zyvDLIfEvNlYZqiVr/PcU6pwHtYUDSxgovFbKnXswXLCsG8OjDoSngLK/0FmOCQa+TlxPrgtp1GmCzgxAGMtYq9e1NHd/CIXhZr6zq+rBIgtRbQXtb811MFQ3FZ14qzMSvCseiGWnXtz3Mbie6kdsCoij4bq1WTns6nEn29cwY3CdUZa7TvYNkIpaYQDyBrxnyGM1zJRr4PH6iQFiFaTKddXXLcroAVawqmFt2H0C1tNv4vs0JI8xmAtMNehcAXA7yQH1hA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(2906002)(110136005)(52536014)(8676002)(66556008)(33656002)(53546011)(41300700001)(83380400001)(64756008)(86362001)(66946007)(66446008)(76116006)(66476007)(5660300002)(8936002)(316002)(38070700005)(186003)(71200400001)(9686003)(122000001)(55016003)(966005)(478600001)(6506007)(7696005)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWF2M3prVlhSN3ZTY0NNU2ZnVjhmUUdjZ2RLNEp1OWcxZmdZQjdFcTdlbEN2?=
 =?utf-8?B?TXJkWnZpb3ZXaGt0bGpvZUgwYXNKM0hjUlgzeEtHd28wZmdvWkxQdEFuTWNa?=
 =?utf-8?B?cTQra05qM21xS0dxT3V4QzVtd0NXbENuQkVQdXVaSVdQNFBjeEt3SDMxcEx3?=
 =?utf-8?B?TnNuTklDcTdiYmdQK2F0NEc4SEg4OVVCQUdaQ0EzQVlHTlUvMm5SeFM0V0JU?=
 =?utf-8?B?Y2pVWjJseDhVTnhVdHJydmFTZUdEeUt3c2o2VGRybUc3UnN1ckNxOTFkKzVS?=
 =?utf-8?B?aTU0N09uOUp3L2V6VTNmblRPSG8rdm8zcGVmZXJ3OXEyQWhDby9USTJXb09J?=
 =?utf-8?B?aXRnajgvNkYzUTlUdkNHdHJqVk9uWHB4REM3MHozVU0vaytBSzJ2TFlReWVy?=
 =?utf-8?B?TGVSeDllOExrUjlBSzg0aHhKRjk1Rm5PQjRRbmtGaDlNY0c4Y1M2TkRJTlZU?=
 =?utf-8?B?ZkVNU0ZWVEE5Tkljd1Uzb3NTV29uVkZvVURjTnpETzRoYkpScytFSzE5RHBx?=
 =?utf-8?B?WE1BV3RNQlJQcTJsQWk3NTFtZk1RZDQyT0VFaXFTYnlsSkM4MTJaTXUyZDlS?=
 =?utf-8?B?d2MxTDFwVmhxc21OVFJSQktRdlJZN2xpTEtBTWo2L1JHVHFJS0puUDYyTVRL?=
 =?utf-8?B?R0RXZTJ5UU9MRFd0cnQwcDcwVVErREtSN0F5MnFyMEhSMGk4VzFyOHBxQmRN?=
 =?utf-8?B?bEpjWnlkMmZraEtlcGdVZUh2Z2RXWS9SZkZVUCt6Mys5UnpSSmQ5R2RjVlIv?=
 =?utf-8?B?azRLZ3JxdllrY1VZcHNrN1JVZW95cXlYd3JVeFlvVkpOcEhmVEJZM2tZSWpl?=
 =?utf-8?B?eTlzZGMxU003MDA1ZzRIcm52b3FsMWtDUDZ0aWg5MGZnNFpvcngzV2w3QkpZ?=
 =?utf-8?B?RUJGSWJ3NnNrWmJWNUdZWjNrTk5hK054d3crU3lmazFiL00rUk5JVEEzSlpS?=
 =?utf-8?B?QVBhV0tkcVNoZG9teVJtQXBFbEpGNmNqdE5RREFOODkvY2xlWGtJZW1FcTls?=
 =?utf-8?B?YzF6cjFtRzhXRlQ4SUlrRk9jcUYvYklyYkxXd3ludGI1MHVrRmlqSDRUSGpy?=
 =?utf-8?B?VzZQbzlSUW5vcHB2M0JLQWZCL25hdGk3TDUxeU1hbkcrUHE3YlZiYU9XZG9U?=
 =?utf-8?B?TDkyK1VrQ0JzRE5OUlRQT0xENUFRVERBZEN1R1Y4WWdZY281c2t5eU55MzBD?=
 =?utf-8?B?YnZha0dvUnVoTlhGNncwb3ZsWlJtbW1vRnBRZDd1RUtxcnpwTEcvN1lUc0tX?=
 =?utf-8?B?S1AxMUdwZkJnSWVwSHVrK2plVjZ3RGhPa2pwMTFOM0g0ZDZ5U25nUFpNbFFU?=
 =?utf-8?B?RjJidW42alpZU3d2TC9OQXhIUXV0Qk15M1VIUmFKeHB4V05VbU5BbjRoVC9J?=
 =?utf-8?B?TXc0c09YbVEzRFZ0S2VtSGpmSGVUTnBEYWl3dTlGbFdOai93RUkyVGJ1Mm5W?=
 =?utf-8?B?dHluT0ExRUtPT05rL2lJNXJ4UEJjZmgvcG9UN2poR0RrRG93T3JnVmxNcGg3?=
 =?utf-8?B?TEVaNERobG1uaEFLaVowUExLZGIxcU16azBoVDFOZXQzRjRHWlZTN3NiaGN5?=
 =?utf-8?B?VTQzVVBWSkdDK0xicmdtZmVpYzZjQ0Z1bDEzakREVlBJci9xMlBMSU96cFp2?=
 =?utf-8?B?Rk1UTzJCY05lTE1JY2ZwY0lKcmhUUExrM2V6bCtOWkY2VjFQZklyb1VvWm9l?=
 =?utf-8?B?d01pSkpGa2M5bHZ4SlFzY2QrSCtxaHJ4dHQ1akFiejRsOGlrTjduVklGWXFy?=
 =?utf-8?B?aS84TWJmZTRCM0FHS2dscWZrUHJCNFFBSTBTNTM0SHZtcHMrMXBjTk4rb3Rx?=
 =?utf-8?B?TFQxK0tCRUZkRFUxL1BpWGc2cWoxanh1anNoUm5IOTUvd1BNRGhrNGk2U0xu?=
 =?utf-8?B?NUd1b25oNFR4bHM5OTI0aFRVc3BFRHhZRVh1OEpQNTRsS3BVdVNidkhvNnp4?=
 =?utf-8?B?bUVPNDZWZTlleFZjRmxXeFgrckRJYW5ZQmJWYWNnLzVuU2I5aUtldUs0emNO?=
 =?utf-8?B?YzM5SVMvcmNJVXcvSnhoakpHaFhCRjBUeG44MFpISk1YOXRQNU9RU2ErdU96?=
 =?utf-8?B?NE9pUXQrUyt2a2NIZlpiUERxZjJ4OXhYSFFYWnN6cUpPUUlOcjhZNVRiWUVk?=
 =?utf-8?B?VHFMSmFnSTFiamd0NllZREgzRUMvVkM5VFlkMm81TTF1aTBXUWRuc0VRMHE5?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0664cff-e23b-4705-42e4-08dab732cbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 09:16:42.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A6Twk7O3VYZV0CEUUIgUuC5Lj0V1uQl0BrpPcBx18YHeyy0ZRGqAimexpdABxH5r3Eyx9tdQiWopfqIb8Cv+q4BlIOezrJ8bs+kC1pnmPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9756
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZl
cmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVy
IDI0LCAyMDIyIDQ6NDkgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDil4vv
vLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5pc2hpa2F3YUB0
b3NoaWJhLmNvLmpwPjsgcG9zY2lha0BjaHJvbWl1bS5vcmc7DQo+IHBhdWwua29jaWFsa293c2tp
QGJvb3RsaW4uY29tOyBtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZzsNCj4gbGludXgtbWVkaWFA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBRdWVzdGlvbiBmb3IgYW4gYWNjZXB0ZWQgcGF0Y2g6IHVzZSBvZiBETUEtQlVGIGJhc2Vk
IHZpZGVvYnVmMg0KPiBjYXB0dXJlIGJ1ZmZlciB3aXRoIG5vLUhXLWNhY2hlLWNvaGVyZW50IEhX
DQo+IA0KPiBIaSBZdWppLA0KPiANCj4gT24gMTAvMjQvMjIgMDY6MDIsIHl1amkyLmlzaGlrYXdh
QHRvc2hpYmEuY28uanAgd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBJJ20gcG9ydGluZyBhIFY0
TDIgY2FwdHVyZSBkcml2ZXIgZnJvbSA0LjE5LnkgdG8gNS4xMC55IFsxXS4NCj4gPg0KPiA+IFdo
ZW4gSSB0ZXN0IHRoZSBwb3J0ZWQgZHJpdmVyLCBJIHNvbWV0aW1lcyBmaW5kIGEgY29ycnVwdGlv
biBvbiBhIGNhcHR1cmVkDQo+IGltYWdlLg0KPiA+DQo+ID4gQmVjYXVzZSB0aGUgY29ycnVwdGlv
biBpcyBleGFjdGx5IGFsaWduZWQgd2l0aCBjYWNoZWxpbmUsIEkgc3RhcnRlZA0KPiBpbnZlc3Rp
Z2F0aW9uIGZyb20gbWFwL3VubWFwIG9mIERNQS1CVUYuDQo+ID4NCj4gPg0KPiA+DQo+ID4gVGhl
IGNhcHR1cmUgZHJpdmVyIHVzZXMgRE1BLUJVRiBmb3IgdmlkZW9idWYyLg0KPiA+DQo+ID4gVGhl
IGNhcHR1cmUgaGFyZHdhcmUgZG9lcyBub3QgaGF2ZSBIVy1tYW50YWluZWQgY2FjaGUgY29oZXJl
bmN5IHdpdGgNCj4gQ1BVLCB0aGF0IGlzLCBleHBsaWNpdCBtYXAvdW5tYXAgaXMgZXNzZW50aWFs
IG9uIFFCVUYvRFFCVUYuDQo+ID4NCj4gPiBBZnRlciBzb21lIGhvdXJzIG9mIHN0cnVnZ2xlLCBJ
IGZvdW5kIGEgcGF0Y2ggcmVtb3ZpbmcgY2FjaGUgc3luY2hyb25pemF0aW9ucw0KPiBvbiBRQlVG
L0RRQlVGLg0KPiA+DQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYS9wYXRjaC8yMDE5MDEyNDA5NTE1Ni4NCj4gPiAyMTg5OC0xLXBh
dWwua29jaWFsa293c2tpQGJvb3RsaW4uY29tLw0KPiA+IDxodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWEvcGF0Y2gvMjAxOTAxMjQwOTUxNTYNCj4gPiAuMjE4
OTgtMS1wYXVsLmtvY2lhbGtvd3NraUBib290bGluLmNvbS8+DQo+ID4NCj4gPg0KPiA+DQo+ID4g
V2hlbiBJIHJlbW92ZWQgdGhpcyBwYXRjaCBmcm9tIG15IDUuMTAueSB3b3JraW5nLXRyZWUsIHRo
ZSBkcml2ZXINCj4gPiB5aWVsZGVkIGltYWdlcyB3aXRob3V0IGFueSBkZWZlY3RzLnYNCj4gPg0K
PiA+DQo+ID4NCj4gPiAqKioqKioqKioqKioqKioNCj4gPg0KPiA+IFNvcnJ5IGZvciBhIG1lbnRp
b24gdG8gYSBwYXRjaCByZWxlYXNlZCA0IHllYXJzIGFnby4NCj4gPg0KPiA+IFRoZSBwYXRjaCBy
ZW1vdmVzIG1hcC91bm1hcCBvbiBRQlVGL0RRQlVGIHRvIGltcHJvdmUgdGhlDQo+IHBlcmZvcm1h
bmNlIG9mIFY0TDIgZGVjb2RlciBkZXZpY2UsIGJ5IHJldXNpbmcgcHJldmlvdXNseSBkZWNvZGVk
IGZyYW1lcy4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZXJlIHNlZW1zIG5vIGNhcmVzIG5vciBjb21w
ZW5zYXRpb25zIGZvciBtb2RpZnlpbmcgbGlmZWN5Y2xlIG9mDQo+IERNQS1CVUYsIGVzcGVjaWFs
bHkgb24gdmlkZW8gY2FwdHVyZSBkZXZpY2VzLg0KPiANCj4gSSdtIG5vdCBlbnRpcmVseSBzdXJl
IHdoYXQgeW91IG1lYW4gZXhhY3RseS4NCj4gDQpNeSBjb25jZXJuIGlzIGNvbnNpc3RlbmN5IGJl
dHdlZW4gaW9jdGxzIGFuZCB0aGUgc3RhdGUgdHJhbnNpdGlvbiBvZiBjYXB0dXJlIGJ1ZmZlcnMu
DQpHZW5lcmFsbHksIHN0cmVhbWluZyBJL08gKERNQS1CVUYgaW1wb3J0aW5nKSBidWZmZXJzIGFy
ZSBoYW5kbGVkIGZvbGxvd2luZyBieSB1c2VybGFuZC4NCg0KSW9jdGwoVklESU9DX1FCVUYpIC0+
IC8qIERNQSB0cmFuc2ZlciBmcm9tIEhXKi8gLT4gaW9jdGwoVklESU9DX0RRQlVGKSAtPiAvKiBh
Y2Nlc3MgZnJvbSBDUFUgKi8gLT4gaW9jdGwoVklESU9DX1FCVUYpIC0+IC4uLg0KDQpUaGVyZWZv
cmUsIGV4cGVjdGVkIHNlbWFudGljcyBpcyB0aGF0IGEgYnVmZmVyIGlzIG93bmVkIGJ5IEhXIGFm
dGVyIFFCVUYsIGFuZCBvd25lZCBieSBDUFUgYWZ0ZXIgRFFCVUYuDQpJbiBwcmFjdGljZSwgaW9j
dGwoUUJVRikga2lja3MgdmIyX2RjX21hcF9kbWFfYnVmKCkgYW5kIGlvY3RsKERRQlVGKSBraWNr
cyB2YjJfZGNfdW5tYXBfZG1hX2J1ZigpIGJlZm9yZSBhcHBseWluZyB0aGUgcGF0Y2guDQpUaGlz
IGltcGxlbWVudGF0aW9uIGtlZXBzIGNvbnNpc3RlbmN5IGluIHRlcm1zIG9mIGNhY2hlIGNvaGVy
ZW5jeSBhcyBjYWNoZS1jbGVhbiBpcyBkb25lIGluIHZiMl9kY19tYXBfZG1hX2J1ZigpLg0KDQpC
eSBhcHBseWluZyB0aGUgcGF0Y2gsIGlvY3RsKERRQlVGKSBkb2VzIG5vdCBraWNrIHVubWFwX2Rt
YSgpIGFueW1vcmUuIFRoZSBzaW1pbGFyIGZvciBpb2N0bChRQlVGKS4NClRoZXJlZm9yZSwgaW4g
cHJhY3RpY2UsIGEgYnVmZmVyIGlzIG5vdCBvd25lZCBieSBDUFUganVzdCBhZnRlciBpb2N0bChE
UUJVRikuDQpUbyBrZWVwIGNvbXBhdGliaWxpdHkgb2YgYnVmZmVyIG9wZXJhdGlvbnMsIHRoZXJl
IHNob3VsZCBiZSBkZWxheWVkIG1hcF9kbWEoKS91bm1hcF9kbWEoKSBjYWxsIGp1c3QgYmVmb3Jl
IERNQS10cmFuc2Zlci9DUFUtYWNjZXNzLg0KSG93ZXZlciwgbm8gb25lIHJlZmVycmVkIHRvIHN1
Y2ggZnVuY3Rpb24gaW4gdGhlIHY0bDIgZnJhbWV3b3JrIGluIHRoZSBleGFtaW5hdGlvbiBvZiB0
aGUgcGF0Y2guDQpBbHNvLCB0aGVyZSBpcyBubyBhZHZpY2UgZm9yIGluZGl2aWR1YWwgdmlkZW8g
ZGV2aWNlIGRyaXZlcnM7IHN1Y2ggdGhhdCBhZGRpbmcgbWFwX2RtYSgpL3VubWFwX2RtYSgpIGV4
cGxpY2l0bHkuDQoNCj4gPg0KPiA+DQo+ID4NCj4gPiBXb3VsZCB5b3UgdGVsbCBtZSBzb21lIGlk
ZWEgb24gdGhpcyBwYXRjaDoNCj4gPg0KPiA+ICogRG8gd2VsbC1pbXBsZW1lbnRlZCBjYXB0dXJl
IGRyaXZlcnMgd29yayB3ZWxsIGV2ZW4gaWYgdGhpcyBwYXRjaCBpcyBhcHBsaWVkPw0KPiANCj4g
WWVzLCBkbWFidWYgaXMgdXNlZCBleHRlbnNpdmVseSBhbmQgSSBoYXZlIG5vdCBoYWQgYW55IHJl
cG9ydHMgb2YgaXNzdWVzLg0KDQpNYW55IGFyY2hpdGVjdHVyZXMgY2FuIGF2b2lkIHRoaXMgcHJv
YmxlbS4NCkEgcHJvYmxlbSBzdGF0aXN0aWNhbGx5IG9jY3Vycywgb25seSBpZiBhIHZpZGVvIGNh
cHR1cmUgSFcgZG9lcyBub3QgaGF2ZSBIVy1tYWludGFpbmVkIGNhY2hlIGNvaGVyZW5jeSB3aXRo
IENQVS4NCkRvZXMgdGhpcyBwYXRjaCBjb25zaWRlciBzdWNoIGNhc2U/DQoNCj4gPg0KPiA+ICog
SG93IHNob3VsZCBhIHZpZGVvIGNhcHR1cmUgZHJpdmVyIGNhbGwgVjRMMi92aWRlb2J1ZjIgQVBJ
cywgZXNwZWNpYWxseQ0KPiB3aGVuIHRoZSBoYXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0IGNhY2hl
IGNvaGVyZW5jeT8NCj4gDQo+IEl0IHNob3VsZCBhbGwgYmUgaGFuZGxlZCBjb3JyZWN0bHkgYnkg
dGhlIGNvcmUgZnJhbWV3b3Jrcy4NCj4gDQo+IEkgdGhpbmsgeW91IG5lZWQgdG8gZGVidWcgbW9y
ZSBpbnNpZGUgdmlkZW9idWYyLWNvcmUuYy4gU29tZSBwcmludGsncyB0aGF0IHNob3cNCj4gdGhl
IGRtYWJ1ZiBmZCB3aGVuIHRoZSBidWZmZXIgaXMgbWFwcGVkIGFuZCB3aGVuIGl0IGlzIHVubWFw
cGVkICsgdGhlIGxlbmd0aA0KPiBpdCBpcyBtYXBwaW5nIHNob3VsZCBob3BlZnVsbHkgaGVscCBh
IGJpdC4NCg0KSSBhZGRlZCBwcmludGsgYW5kIGR1bXBfc3RhY2soKSB0byBzZXZlcmFsIGZ1bmN0
aW9ucy4NClRoZSBwYXRjaGVkIGZ1bmN0aW9uIF9fcHJlcGFyZV9kbWFidWYoKSBpcyBjYWxsZWQg
ZXZlcnkgaW9jdGwoUUJVRikuDQpGdW5jdGlvbiB2YjJfZGNfbWFwX2RtYWJ1ZigpIGlzIGNhbGxl
ZCBvbmx5IGZvciB0aGUgMXN0IGNhbGwgb2YgaW9jdGwoUUJVRikgZm9yIGEgYnVmZmVyIGluc3Rh
bmNlLg0KQWZ0ZXIgdGhhdCwgdmIyX2RjX21hcF9kbWFidWYoKSB3YXMgbmV2ZXIgY2FsbGVkLCBh
cyB0aGUgcGF0Y2ggaW50ZW5kZWQuDQoNClJlZ2FyZHMsDQoJWXVqaQ0KDQo+IA0KPiBSZWdhcmRz
LA0KPiANCj4gCUhhbnMNCj4gDQo+ID4NCj4gPg0KPiA+DQo+ID4gKioqKioqKioqKioqKioqDQo+
ID4NCj4gPiBbMV0gRllJOiB0aGUgY2FwdHVyZSBkcml2ZXIgaXMgbm90IG9uIG1haW5saW5lIHll
dDsgdGhlIGNhbmRpZGF0ZSBpcywNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIyMDgxMDEzMjgyMi4zMjUzNC0xLXl1amkyLmlzaGlrYXdhQHRvc2gNCj4gPiBpYmEuY28u
anAvDQo+ID4gPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDgxMDEzMjgyMi4zMjUz
NC0xLXl1amkyLmlzaGlrYXdhQHRvcw0KPiA+IGhpYmEuY28uanAvPg0KPiA+DQo+ID4NCj4gPg0K
PiA+DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgWXVqaSBJc2hpa2F3YQ0KPiA+DQo=

