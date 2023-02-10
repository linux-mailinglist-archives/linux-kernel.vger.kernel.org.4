Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936D2691A67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBJIyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBJIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:54:43 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2029.outbound.protection.outlook.com [40.92.102.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FF22797;
        Fri, 10 Feb 2023 00:54:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhufXtVY8htxc0GL5sCo5Doegk6yTaxaJqCPQzjsCIkh53RQbo5mhehWZsmTPv+xNylv/qoYF3f8U0QoYSnhej6Gt7Ikh1FYHR/mYcVOVcp8WWnUc5aYB0SxYmzOcMMyQDFhCyudhuzSNFN5GHdzOevBUwmxT8MJqR53z4yz7f9RsjSRnD8zd5FdHLdT9T5TE0fv/EvK7+kzE9F/SkT9QMAUux5hE0W4SPXwgR+dZPFTpivl/EL1ldbGQ1sqHIZUef2Jc2qiCxdmuKZkJD+HKzlhusG7tenfOgOQXOTyEoupNWwDN4MXWJqqy9kzezABYMzYniMjsKVRMZXXwlL3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfrktCrCSZ5J6zGw9x797XXne/5TgZK0v5NMQT+Zmdw=;
 b=UnbGlxycyNpiQ27gXjinCEUWH0B8tQUtOZuwAuoc6vqm4Jw4ghk96wo12D//oxTPytCXvvX771IoYriDn6vYXK06hWIFO3zDOcET0ILk8KU21UFrmTgU7AEqCu4rog3A4vmB98tsROlVmUIdzOKOoB2rb5PnJ3LXfQlafKVNPYhegtNlg64NK0QGbWrcmn+APTh9MttuYxYVN6k9JnETq0Xv0optL17xZliMguh5xIH3lQxa+ep6wxT/4pi+B3puO9kiTu0bhaEkpfE+tnEpJH7WtFfUZa1YqMe1bMVXG9D2kDEgfWV+ReUlW6ciMJk25qTVPtnibqMYaixh3sISCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfrktCrCSZ5J6zGw9x797XXne/5TgZK0v5NMQT+Zmdw=;
 b=Y7mJyu9s9jCt7bPJxKpSjblTar9b1D7C86ixRkqsqdlS55LncBbIxDBpbxfc/7IhjIRAz7wlXCBzoGjA3bvQcCj5EEfBwjC0lKmenVhT/av+xoatCmGsXUGL950aikVMWEjQKmZtHF8Cuyguu91io9xuBoQ4yXcbq+JwDG2rpo1KqAdtxNPagOPbFl1SL30rCJFyVXORZajoVP6U2brzq3vyccfQmxAzYVxPAIcOvloiV4Yjt7RlluwEUBfNOa+Bn/asbxVpcZjURgYwYvqb+YKKdWGsg6cpYpe1rwyMmDsxtrSX7D1xGh90PgiKEjR9G+j8szjf7ExACgNfSdfC+g==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB8852.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.6; Fri, 10 Feb 2023 08:54:35 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 08:54:35 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Topic: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Index: AQHZPQwM5DSulXBskEykQ8jgSAssVq7H2aOAgAACjACAAARDgA==
Date:   Fri, 10 Feb 2023 08:54:35 +0000
Message-ID: <B472CABB-5D94-4E15-AE6D-EF8B8BF4CBF3@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
 <AC5AB6F5-4D65-4362-A8B8-A694D1371188@live.com>
 <CAO-hwJK=-9n885crMM8sHFGdNCZfjhqwuQXb2OtgMQiqaoZ66g@mail.gmail.com>
In-Reply-To: <CAO-hwJK=-9n885crMM8sHFGdNCZfjhqwuQXb2OtgMQiqaoZ66g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [giry/W0Jnc39uZqEVZSOQbe6OAr6flIz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB8852:EE_
x-ms-office365-filtering-correlation-id: 98d391b2-1f3f-49c7-b138-08db0b446f1d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2pB7OOnBrH6/4R3sfw7CoxL8BzAIlmRGDvIbi+J+GokOMk0E5w6MnDbIBs33jyq8FbeZ7ylrNJckF46FyQbaxrpj0QNut/de4i7mBREsH0SXatcPn6Rkb6v9XFp08Sa9T93yL61blDJnotX0ISaslurRPrjJ85YyARNawgs4To/KIf9gBhhTFS9tnAVGMqSlyaZide5SiqivhK9rIcrMx8GuS0gQOqAxxextttwNWiYHwmTS/2kzBYeD3L4bK9CfjgArC7VW+PTukDTvDd24Eoa6QI9dT7B4v+cpKKvz44gJ9lnvzA9cCrkpNX+HBD0YusqqiXX4X3ELoUcMAbAm0KCrzNkzQ3bdaoHtf5S5g7KK4xyrA1WiFLVJVjCRZ56tqgzrSHZp4gyH4rMuW3pxpYBUMGtXIp+PDR4NzDvSS7LxJPt7cNJFRz/n4QGACBKYEDByMbFKCoJ+yQH6lkhtz2yqaCmYxNZoOwT6DUjDbrOZeQTL9B6teIJOTGUhIOKwfNO3hztc33cnUlOlKaFKd2zLKIL9n1B8eVjpdCXmtgcqXKVRaUmfz2GYZHAxnALa2Mu1bQ99ozqf9qHk3yqYmqwFDP/ncFHGrWQrgTlQsE/v2cQYZ/abNwYhgxpcCSJunK1wv2YFqrzI1Rc++u0hw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmR5QWNwMHVYMXdDNFNFdjg2R1FkRFBvaFRLN1JmWFhNZTl6dTYyR3VqdndI?=
 =?utf-8?B?QmF5dTVEOXFQQlFvYjBhcU5Mb3A4SzFLYXZ5VWFMQmFHTEpIeEhjek1VaU9h?=
 =?utf-8?B?YXU2K0xjTlJkZFhhKzF4cC9WbDdmUkptc3RjT3VuVDlqYTRIMm1JYnh4NURq?=
 =?utf-8?B?UWJFcnpFSGFlRDdkMVJlS0RtbUtPSDNBS21xM2VLR2g5clhEMXZHWnMzNzM4?=
 =?utf-8?B?TmMwdXY5ZWgyR1grNy9FYzRHZUo3SldlWWh6bXRESWdLcUMrK01FbkdVMEpX?=
 =?utf-8?B?bTBLcXNBaktZcit0TmVWNFFxWjBIVGlsbTkxNjJvTEtRcW40WDQzSkg0c0lm?=
 =?utf-8?B?eCs2dUJpVVVRclFyWTFDNTRWekp0TVpNWlpveU94ck8wMzY5OUl2dW1IUU0w?=
 =?utf-8?B?TGlIQ3RrRWhJK2lFOUlnK0hUckhydTlpMGkrSUdtU3Y1Ny9rZTY0dFhSZ1Ri?=
 =?utf-8?B?aTYzczBTLzBZUlA2S1NIeXh3T1lPUmwyeHZ0a2haTml0ZHlUeWxuK1lYcDRL?=
 =?utf-8?B?ejVJRUJYTkxGbGZzdEhLSC9XYzQ4UTR6OVlITlVVOUwxdHdZV0hQd1JDZHlo?=
 =?utf-8?B?ZWg4aHplMjRubHBHSnY1Rlh4ak1PWkpIb1NTOGx1THAxSGpxMXRvZ0ZKZjli?=
 =?utf-8?B?dHFpME1aSWxCNkJXWnpCbGJwVHZFUFdITXEwYjZIZFRpRFdxSlMyRStRRGdr?=
 =?utf-8?B?bWxaMG92ajdob2tRS2RDL0lKcHJZRkQzeklPTk45VEJBQTlqSXhOYng5eENh?=
 =?utf-8?B?MXpqb2MyVnJuWDlOQWZhTEY5OTcxY01zMXRpY2tVNmE2WXM5ODdYaURIcjJK?=
 =?utf-8?B?TGRBMkdmZktWRGpGNmhjZVBLZ2F6L3RXajFJVmhYdHU4VlFEYVJpS1FUODE1?=
 =?utf-8?B?K1VHQWpPdWVlRjBsRzhTZldvc0YxZDA4WDFuaTV6ajdYampWT3ZxaDIzQXM5?=
 =?utf-8?B?MkNXYUpjMDFmRGpyQ041ZDVzY05ZcE05SWEvQ2k4Tzh5YjVaWVFvbUFqR1Z2?=
 =?utf-8?B?a3hXKzJ1TnkvVmMvMStiakZuU0JwMlFSTlNCdDI5YTJCUlViNEhqTXJOdEZo?=
 =?utf-8?B?SmtVcGJrOFVtNEF0OVF5WnhIeXFFWEhnL3dHZWVMYTljZWxsNnNmQlRCNHVX?=
 =?utf-8?B?TlVsMEl0Sm5jeDdpRUQ4d2hUSkNkeFNyL3FxVWlNdFF4QXFMTUZtWkxZaytt?=
 =?utf-8?B?Vnhab0VxTGFRWGt3N3U1ZkU0Rlc5dm1RMTZOMTcyQlRpRUo0bENKaTJCRTNV?=
 =?utf-8?B?bkVFUi9FVU9XUWlSTXVUM0RtOUpJc3VUeHY0UHFkZlBqVDFVbTZWQ1hhay92?=
 =?utf-8?B?NFlqMU9lUko4M3dkZTRkWVorQmdHOFppN21iTEkreUErTmdFRVZGbGJwcENa?=
 =?utf-8?B?SWprdFFuQkhWSEZucE8wazQrS2RvUG9yNUs2STUveW11K2RBZGpWcjkxNW1r?=
 =?utf-8?B?d1FkOEtDdVo2d2F1NzMzcXEvVjI5eFBkaXFodW44Mi9vNnFyZ1lLY1J4WUEv?=
 =?utf-8?B?UTh4ak0zNENvbXlwaEJ4aTA5cHQ0aGRkSlRMdkNvQkNvbmpiLzh0TVhQcnpB?=
 =?utf-8?B?dDhWSkdkSFRRRFgzR3NtK1VrQTRSNFlJTmFwNUlieDllK1ZqMUpmenhMcDc1?=
 =?utf-8?B?ZHN3TG5BSVdEays3SmFtaldOd1ZQOXk5MGlaU2RoY0kzNXhkWEI3UU1KdHNw?=
 =?utf-8?B?WDN6S3d2ODRDc2xRNWN5bGE2RlRERE1LOFhLWlBidFlaK3E0MjdJZlF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE5E8C31BE25B04895B6FC5821A48B44@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d391b2-1f3f-49c7-b138-08db0b446f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:54:35.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8852
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTAtRmViLTIwMjMsIGF0IDI6MDkgUE0sIEJlbmphbWluIFRpc3NvaXJlcyA8YmVu
amFtaW4udGlzc29pcmVzQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBGZWIgMTAs
IDIwMjMgYXQgOTozMCBBTSBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3cm90
ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiAxMC1GZWItMjAyMywgYXQgMTA6MjYgQU0sIFRob21h
cyBXZWnDn3NjaHVoIDx0aG9tYXNAdC04Y2guZGU+IHdyb3RlOg0KPj4+IA0KPj4+IEhpLA0KPj4+
IA0KPj4+IHNvbWUgY29tbWVudHMgaW5saW5lLg0KPj4+IA0KPj4+IE9uIEZyaSwgRmViIDEwLCAy
MDIzIGF0IDAzOjQzOjI0QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+PiBGcm9tOiBS
b25hbGQgVHNjaGFsw6RyIDxyb25hbGRAaW5ub3ZhdGlvbi5jaD4NCj4+Pj4gDQo+Pj4+IFRoZSBp
QnJpZGdlIGRldmljZSBwcm92aWRlcyBhY2Nlc3MgdG8gc2V2ZXJhbCBkZXZpY2VzLCBpbmNsdWRp
bmc6DQo+Pj4+IC0gdGhlIFRvdWNoIEJhcg0KPj4+PiAtIHRoZSBpU2lnaHQgd2ViY2FtDQo+Pj4+
IC0gdGhlIGxpZ2h0IHNlbnNvcg0KPj4+PiAtIHRoZSBmaW5nZXJwcmludCBzZW5zb3INCj4+Pj4g
DQo+Pj4+IFRoaXMgZHJpdmVyIHByb3ZpZGVzIHRoZSBjb3JlIHN1cHBvcnQgZm9yIG1hbmFnaW5n
IHRoZSBpQnJpZGdlIGRldmljZQ0KPj4+PiBhbmQgdGhlIGFjY2VzcyB0byB0aGUgdW5kZXJseWlu
ZyBkZXZpY2VzLiBJbiBwYXJ0aWN1bGFyLCB0aGUNCj4+Pj4gZnVuY3Rpb25hbGl0eSBmb3IgdGhl
IHRvdWNoIGJhciBhbmQgbGlnaHQgc2Vuc29yIGlzIGV4cG9zZWQgdmlhIFVTQiBISUQNCj4+Pj4g
aW50ZXJmYWNlcywgYW5kIG9uIGRldmljZXMgd2l0aCB0aGUgVDEgY2hpcCBvbmUgb2YgdGhlIEhJ
RCBkZXZpY2VzIGlzDQo+Pj4+IHVzZWQgZm9yIGJvdGggZnVuY3Rpb25zLiBTbyB0aGlzIGRyaXZl
ciBjcmVhdGVzIHZpcnR1YWwgSElEIGRldmljZXMsIG9uZQ0KPj4+PiBwZXIgdG9wLWxldmVsIHJl
cG9ydCBjb2xsZWN0aW9uIG9uIGVhY2ggSElEIGRldmljZSAoZm9yIGEgdG90YWwgb2YgMw0KPj4+
PiB2aXJ0dWFsIEhJRCBkZXZpY2VzKS4gVGhlIHN1Yi1kcml2ZXJzIHRoZW4gYmluZCB0byB0aGVz
ZSB2aXJ0dWFsIEhJRA0KPj4+PiBkZXZpY2VzLg0KPj4+PiANCj4+Pj4gVGhpcyB3YXkgdGhlIFRv
dWNoIEJhciBhbmQgQUxTIGRyaXZlcnMgY2FuIGJlIGtlcHQgaW4gdGhlaXIgb3duIG1vZHVsZXMs
DQo+Pj4+IHdoaWxlIGF0IHRoZSBzYW1lIHRpbWUgbWFraW5nIHRoZW0gbG9vayB2ZXJ5IG11Y2gg
bGlrZSBhcyBpZiB0aGV5IHdlcmUNCj4+Pj4gY29ubmVjdGVkIHRvIHRoZSByZWFsIEhJRCBkZXZp
Y2VzLiBBbmQgdGhvc2UgZHJpdmVycyB0aGVuIHdvcmsgKG1vc3RseSkNCj4+Pj4gd2l0aG91dCBm
dXJ0aGVyIGNoYW5nZXMgb24gTWFjQm9va3Mgd2l0aCB0aGUgVDIgY2hpcCB0aGF0IGRvbid0IG5l
ZWQNCj4+Pj4gdGhpcyBkcml2ZXIuDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBSb25hbGQg
VHNjaGFsw6RyIDxyb25hbGRAaW5ub3ZhdGlvbi5jaD4NCj4+Pj4gW0tlcmVtIEthcmFiYXk6IGNv
bnZlcnQgdG8gYSBwbGF0Zm9ybSBkcml2ZXJdDQo+Pj4+IFtLZXJlbSBLYXJhYmF5OiBmaXggYXBw
bGVpYl9mb3J3YXJkX2ludF9vcF0NCj4+Pj4gW0tlcmVtIEthcmFiYXk6IHJlbHkgb24gSElEIGNv
cmUncyBwYXJzaW5nIGluIGFwcGxlaWJfYWRkX2RldmljZV0NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
S2VyZW0gS2FyYWJheSA8a2VrcmJ5QGdtYWlsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQWRp
dHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IGRyaXZlcnMv
aGlkL0tjb25maWcgICAgICAgICB8ICAxNSArDQo+Pj4+IGRyaXZlcnMvaGlkL01ha2VmaWxlICAg
ICAgICB8ICAgMSArDQo+Pj4+IGRyaXZlcnMvaGlkL2FwcGxlLWlicmlkZ2UuYyB8IDYxMCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gZHJpdmVycy9oaWQvYXBwbGUt
aWJyaWRnZS5oIHwgIDE1ICsNCj4+Pj4gZHJpdmVycy9oaWQvaGlkLWlkcy5oICAgICAgIHwgICAx
ICsNCj4+Pj4gZHJpdmVycy9oaWQvaGlkLXF1aXJrcy5jICAgIHwgICAzICsNCj4+Pj4gNiBmaWxl
cyBjaGFuZ2VkLCA2NDUgaW5zZXJ0aW9ucygrKQ0KPj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jDQo+Pj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2hpZC9hcHBsZS1pYnJpZGdlLmgNCj4+Pj4gDQo+Pj4gDQo+Pj4+IA0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4+ICtzdGF0aWMgaW50IGFwcGxlaWJfbGxfcmF3X3JlcXVlc3Qoc3RydWN0IGhpZF9kZXZp
Y2UgKmhkZXYsDQo+Pj4+ICsgICB1bnNpZ25lZCBjaGFyIHJlcG9ydG51bSwgX191OCAqYnVmLA0K
Pj4+PiArICAgc2l6ZV90IGxlbiwgdW5zaWduZWQgY2hhciBydHlwZSwgaW50IHJlcXR5cGUpDQo+
Pj4+ICt7DQo+Pj4+ICsgc3RydWN0IGFwcGxlaWJfaGlkX2Rldl9pbmZvICpoZGV2X2luZm8gPSBo
ZGV2LT5kcml2ZXJfZGF0YTsNCj4+Pj4gKw0KPj4+PiArIHJldHVybiBoaWRfaHdfcmF3X3JlcXVl
c3QoaGRldl9pbmZvLT5oZGV2LCByZXBvcnRudW0sIGJ1ZiwgbGVuLCBydHlwZSwNCj4+Pj4gKyAg
IHJlcXR5cGUpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IGFwcGxlaWJfbGxf
b3V0cHV0X3JlcG9ydChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwgX191OCAqYnVmLA0KPj4+PiAr
ICAgICBzaXplX3QgbGVuKQ0KPj4+PiArew0KPj4+PiArIHN0cnVjdCBhcHBsZWliX2hpZF9kZXZf
aW5mbyAqaGRldl9pbmZvID0gaGRldi0+ZHJpdmVyX2RhdGE7DQo+Pj4+ICsNCj4+Pj4gKyByZXR1
cm4gaGlkX2h3X291dHB1dF9yZXBvcnQoaGRldl9pbmZvLT5oZGV2LCBidWYsIGxlbik7DQo+Pj4+
ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBzdHJ1Y3QgaGlkX2xsX2RyaXZlciBhcHBsZWliX2xs
X2RyaXZlciA9IHsNCj4+Pj4gKyAuc3RhcnQgPSBhcHBsZWliX2xsX3N0YXJ0LA0KPj4+PiArIC5z
dG9wID0gYXBwbGVpYl9sbF9zdG9wLA0KPj4+PiArIC5vcGVuID0gYXBwbGVpYl9sbF9vcGVuLA0K
Pj4+PiArIC5jbG9zZSA9IGFwcGxlaWJfbGxfY2xvc2UsDQo+Pj4+ICsgLnBvd2VyID0gYXBwbGVp
Yl9sbF9wb3dlciwNCj4+Pj4gKyAucGFyc2UgPSBhcHBsZWliX2xsX3BhcnNlLA0KPj4+PiArIC5y
ZXF1ZXN0ID0gYXBwbGVpYl9sbF9yZXF1ZXN0LA0KPj4+PiArIC53YWl0ID0gYXBwbGVpYl9sbF93
YWl0LA0KPj4+PiArIC5yYXdfcmVxdWVzdCA9IGFwcGxlaWJfbGxfcmF3X3JlcXVlc3QsDQo+Pj4+
ICsgLm91dHB1dF9yZXBvcnQgPSBhcHBsZWliX2xsX291dHB1dF9yZXBvcnQsDQo+Pj4+ICt9Ow0K
Pj4+IA0KPj4+IGNvbnN0DQo+PiANCj4+IEFyZSB5b3Ugc3VyZSBhYm91dCBjb25zdCBoZXJlPw0K
Pj4gDQo+Pj4gDQo+Pj4+ICsNCj4+Pj4gKyBpZiAodWRldi0+YWN0Y29uZmlnLT5kZXNjLmJDb25m
aWd1cmF0aW9uVmFsdWUgIT0gQVBQTEVJQl9CQVNJQ19DT05GSUcpIHsNCj4+Pj4gKyByYyA9IHVz
Yl9kcml2ZXJfc2V0X2NvbmZpZ3VyYXRpb24odWRldiwgQVBQTEVJQl9CQVNJQ19DT05GSUcpOw0K
Pj4+PiArIHJldHVybiByYyA/IHJjIDogLUVOT0RFVjsNCj4+Pj4gKyB9DQo+Pj4+ICsNCj4+Pj4g
KyByYyA9IGhpZF9wYXJzZShoZGV2KTsNCj4+Pj4gKyBpZiAocmMpIHsNCj4+Pj4gKyBoaWRfZXJy
KGhkZXYsICJpYjogaGlkIHBhcnNlIGZhaWxlZCAoJWQpXG4iLCByYyk7DQo+Pj4+ICsgZ290byBl
cnJvcjsNCj4+Pj4gKyB9DQo+Pj4+ICsNCj4+Pj4gKyByYyA9IGhpZF9od19zdGFydChoZGV2LCBI
SURfQ09OTkVDVF9EUklWRVIpOw0KPj4+PiArIGlmIChyYykgew0KPj4+PiArIGhpZF9lcnIoaGRl
diwgImliOiBodyBzdGFydCBmYWlsZWQgKCVkKVxuIiwgcmMpOw0KPj4+PiArIGdvdG8gZXJyb3I7
DQo+Pj4+ICsgfQ0KPj4+PiArDQo+Pj4+ICsgaGRldl9pbmZvID0gYXBwbGVpYl9hZGRfZGV2aWNl
KGhkZXYpOw0KPj4+PiArIGlmIChJU19FUlIoaGRldl9pbmZvKSkgew0KPj4+PiArIHJjID0gUFRS
X0VSUihoZGV2X2luZm8pOw0KPj4+PiArIGdvdG8gc3RvcF9odzsNCj4+Pj4gKyB9DQo+Pj4+ICsN
Cj4+Pj4gKyBoaWRfc2V0X2RydmRhdGEoaGRldiwgaGRldl9pbmZvKTsNCj4+Pj4gKw0KPj4+PiAr
IHJjID0gaGlkX2h3X29wZW4oaGRldik7DQo+Pj4+ICsgaWYgKHJjKSB7DQo+Pj4+ICsgaGlkX2Vy
cihoZGV2LCAiaWI6IGZhaWxlZCB0byBvcGVuIGhpZDogJWRcbiIsIHJjKTsNCj4+Pj4gKyBnb3Rv
IHJlbW92ZV9kZXY7DQo+Pj4+ICsgfQ0KPj4+PiArDQo+Pj4+ICsgcmV0dXJuIDA7DQo+Pj4+ICsN
Cj4+Pj4gK3JlbW92ZV9kZXY6DQo+Pj4+ICsgYXBwbGVpYl9yZW1vdmVfZGV2aWNlKGhkZXYpOw0K
Pj4+PiArc3RvcF9odzoNCj4+Pj4gKyBoaWRfaHdfc3RvcChoZGV2KTsNCj4+Pj4gK2Vycm9yOg0K
Pj4+PiArIHJldHVybiByYzsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgYXBw
bGVpYl9oaWRfcmVtb3ZlKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2KQ0KPj4+PiArew0KPj4+PiAr
IGhpZF9od19jbG9zZShoZGV2KTsNCj4+Pj4gKyBhcHBsZWliX3JlbW92ZV9kZXZpY2UoaGRldik7
DQo+Pj4+ICsgaGlkX2h3X3N0b3AoaGRldik7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgaGlkX2RldmljZV9pZCBhcHBsZWliX2hpZF9pZHNbXSA9IHsNCj4+Pj4g
KyB7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfQVBQTEUsIFVTQl9ERVZJQ0VfSURfQVBQ
TEVfSUJSSURHRSkgfSwNCj4+Pj4gKyB7IH0sDQo+Pj4+ICt9Ow0KPj4+PiArDQo+Pj4+ICtzdGF0
aWMgc3RydWN0IGhpZF9kcml2ZXIgYXBwbGVpYl9oaWRfZHJpdmVyID0gew0KPj4+PiArIC5uYW1l
ID0gImFwcGxlLWlicmlkZ2UtaGlkIiwNCj4+Pj4gKyAuaWRfdGFibGUgPSBhcHBsZWliX2hpZF9p
ZHMsDQo+Pj4+ICsgLnByb2JlID0gYXBwbGVpYl9oaWRfcHJvYmUsDQo+Pj4+ICsgLnJlbW92ZSA9
IGFwcGxlaWJfaGlkX3JlbW92ZSwNCj4+Pj4gKyAucmF3X2V2ZW50ID0gYXBwbGVpYl9oaWRfcmF3
X2V2ZW50LA0KPj4+PiArIC5yZXBvcnRfZml4dXAgPSBhcHBsZWliX3JlcG9ydF9maXh1cCwNCj4+
Pj4gKyNpZmRlZiBDT05GSUdfUE0NCj4+Pj4gKyAuc3VzcGVuZCA9IGFwcGxlaWJfaGlkX3N1c3Bl
bmQsDQo+Pj4+ICsgLnJlc3VtZSA9IGFwcGxlaWJfaGlkX3Jlc3VtZSwNCj4+Pj4gKyAucmVzZXRf
cmVzdW1lID0gYXBwbGVpYl9oaWRfcmVzZXRfcmVzdW1lLA0KPj4+PiArI2VuZGlmDQo+Pj4+ICt9
Ow0KPj4+IA0KPj4+IGNvbnN0DQo+PiANCj4+IEFyZSB5b3Ugc3VyZSB5b3Ugd2FudCB0byBkbyBj
b25zdCBoZXJlLCBjYXVzZSBvdGhlciBoaWQtZHJpdmVycyBhcmUgTk9UIHVzaW5nIGNvbnN0Lg0K
PiANCj4gSXQgaXMgc2NoZWR1bGVkIGZvciA2LjM6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2hpZC9oaWQuZ2l0L2xvZy8/aD1mb3ItNi4zL2hpZC1j
b3JlDQo+IA0KPiBTbyB5ZXMsIHBsZWFzZSBtYWtlIHRoZW0gY29uc3QuDQoNCk1ha2VzIHNlbnNl
IGZvciBgaGlkX2xsX2RyaXZlcmAgYXMgcGVyIHRoZSB0cmVlIHlvdSBzZW5kIG1lLCBidXQgSSBk
b27igJl0IHNlZSBzdWNoIGEgdGhpbmcgZm9yDQpgc3RhdGljIHN0cnVjdCBoaWRfZHJpdmVyYC4g
SXMgdGhhdCBzY2hlZHVsZWQgYXMgd2VsbD8NCg0KPiANCj4gQ2hlZXJzLA0KPiBCZW5qYW1pbg0K
PiANCj4+IA0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgc3RydWN0IGFwcGxlaWJfZGV2aWNlICphcHBs
ZWliX2FsbG9jX2RldmljZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+PiArew0K
Pj4+PiArIHN0cnVjdCBhcHBsZWliX2RldmljZSAqaWJfZGV2Ow0KPj4+PiArIGFjcGlfc3RhdHVz
IHN0czsNCg0KDQo=
