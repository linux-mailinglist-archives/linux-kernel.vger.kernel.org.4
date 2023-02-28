Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788736A538E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjB1HKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjB1HKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:10:23 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924D20046;
        Mon, 27 Feb 2023 23:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCc6GV0y7xOpmXt8YmohoBLqgMmV7GHds7jF+s97z0+b4cNp4f8G63MdYmB97ZfPlg89MlN9uEnTZ8t12sl7h5moEYAabI2ER961xZ8Wd3zWmZZNg3wGOeVwrAQOvJxw8fp00YTfsG/P6qRcmXOWHX7HvdPJIPeK+mWQK918X3tz4PrJk9Q+Ux0pInuCJWfVl9Q1lICVQtgEapKyQmPXxU3ZckiauvBNmWnp+OLtdMnI12wIhpy3IGgcUb3jEXB3hMOuaMfXcQre5TxRT7FoXeRHD2KqBpbIKFUC605siGHFHCH2TTCH5vXrDEmEpQ+AU5qJlBAjQF/1fvqB8FauJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNvSnAE0SBi85++FsKMYlw2QUahw5L/ziUuC9mUwnC4=;
 b=M7B7KXcGApI7c75C1kjTL60Lni/Nf819FxsdcBnDNGB9FPUm/vAHkTFTxOTcQbL5DyObp4vNRM8CQmYvvyElFNa5wM71NmDVIcV2NBEn74T79nEozxhYEa5q8Y1f9sMVdwI3SHaAZLnx29tHnIqpnhxjBBaUu8TP3ZFQF1ew+m55ErmDpN4Vl2xKzASXOXjbDnqi3SV0LROadCAsWSZ4EWIv6oQZbrcadbHMhnIdUC/ZJOz+ywzHakH2qCNnk+k37+g8/OYEliKoztAyJWwQKNrEsd6GkRRjLegmlX0e22Ge8P0ajkrupltY3gAlmGQb7vY5wdUQ8xFOMYGxSz5XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNvSnAE0SBi85++FsKMYlw2QUahw5L/ziUuC9mUwnC4=;
 b=ixdn6mZVm2NHGCLUXpZCzFu+Gv6bPBLMCLapHu+4R+lPkJ6r9pmaIZQpDfRFRCoZfUFIOqYMNAFYMvb9MImQK6pvrru+fxZQ6+VMk2mH3g47Ell6inDLNNd+zYcBI7puS3gjbFvHw6wSxOlT9La4fnyRWcOOE4fuu2sDjUEaRmNrJGDbWII8P7Ei0Z8nZmtUpk0OU5WbImsBK7FtaKa+/fkXI6R0K5rHV4pEne7M9N5udHUl/dbjfiE48MrQMUMoSVgiZZ4+/1n3NlJfpa4cHzU4cGmQLw/4E7UxaQfCA25pgxJSKLo9uoykEeWlciHuv1ktjM+vvEhyLFyCXegmWw==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB9PR10MB6738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 07:08:42 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 07:08:42 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Thread-Topic: [PATCH 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Thread-Index: AQHZSz5lmugBEA2yEU+bDpHjHzsn2q7j7bkAgAACw8A=
Date:   Tue, 28 Feb 2023 07:08:42 +0000
Message-ID: <DB9PR10MB58815DECFF54F6D69E738ED8E0AC9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230228062957.3150-1-daniel.starke@siemens.com>
 <7ad445d4-34b5-0973-1f4e-7413feabb206@kernel.org>
In-Reply-To: <7ad445d4-34b5-0973-1f4e-7413feabb206@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-28T07:08:40Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7e078111-023a-4358-8e0d-f9cff166ede7;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DB9PR10MB6738:EE_
x-ms-office365-filtering-correlation-id: 06aa85c9-ae83-411c-3905-08db195a9fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XJL60aDWd1XkAxQ3xB6EySF0brZHc7srBB5Cg6q/CPouFk323Pe/xjt9kyvxEZsLO9QOTKP2i+iKLrxPfiz06FBXPjMFDmc4fxHoPpbSyc/XSbNvoSWbJeVoPzPtw/ldt9vwVzScWcdDCem5im6vFp2YN7AaIyiMioJwG+1AAzoVDOwLXVSItOUuJY1UnF5r8v/ax9BE78mnunGTF2dTRxmwqdftVF1qRNZVCYE/59o7MWdpC+oGG7CteXuE4MTNqlYi6ogGQtzytrgisC6DEu4D2M1FnVR/UyU9EQtzDMcLVzwbB0TfimluDNd/iz2I9BF8OcnY9AfC5Lh9LOhYwxfdikjgXXX5lXAV9EMKVl1nvye0zxGlHNMbC+vNJy7ADtV04sgmjHbeC52e5Io0GtmCpWkjFuRGWwUhdHW1JUqf2Lig2gbxWLAAAfGKj8pK67oFj5pu0IhduD1au7WkUuuL5+Q+T5kCGeziLjl1P51H7zhBZY80E3+Af0eCuzO03W4vnSQC3fTSQAFImjlztsMHPGaOKBESZrUavIY+eYJ+A1Bhh2t0PSqoW0j15xshbmzBI7qDeotGegF3toPTDYoNf5fmiG4iUr1+zz1jh5O1Cyc4zD6Q184/1jeqWa15b3ikatdkV1MGm5ikGLtRJvaABAkV/t7cYgU8pSj6DJ39D2jC2NByFWO5FHUbIIBIIVL6iNiX/NeUGqWOtbwLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(8676002)(478600001)(7696005)(110136005)(71200400001)(316002)(26005)(6506007)(9686003)(186003)(66946007)(66446008)(66476007)(64756008)(4326008)(66556008)(76116006)(52536014)(41300700001)(5660300002)(8936002)(33656002)(55016003)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXhjQ2ZtY1hCZldOTHJVcTBZdTA5Y2ZkODFUSTFKZWdsVWFnZWczVFdWaHNq?=
 =?utf-8?B?WnJGV1gxMGdDa0ZMUGpBNHJpUmpwejFhdTRKZVdJaEpreFpraEVlMjlKUUp3?=
 =?utf-8?B?akJDbWNZTzlSVU1zUlRoeGxodXpMYjl1WFBORlBvWDdrTERXRjJBYnNLQkRZ?=
 =?utf-8?B?cGdGMEVTeURPa1ZLcXFYOGNEMmJCc0laL0tRL0N1MVpLZWZhMzcweEpaM2ky?=
 =?utf-8?B?TWFlSzlrZGFHQlI5L3hWclcrWUNHbEh4aW11bEcrR2hqeHpJclV6cjY1ak5F?=
 =?utf-8?B?QjFoUndNUmRMNEtDa2JjZlpCaWdtSHp6VTBpeWRBeVVsQWZzY2VFbFluMDMw?=
 =?utf-8?B?aS9Zdlh1ZHNDUm1qYWdUK2IvUU4wR2VoWE0vaDV1RlpSdVJiZ1UycU1pVmRE?=
 =?utf-8?B?RSs5S05EYmJVNVZqZ0J5RDRjQksxbzZVVURCaXFmTklDYXJ6MkRIZXdId2Qx?=
 =?utf-8?B?S2djT0NvNjJldnRna3h6ZjBjOUl2YUMxQ2ZGTk41N0NubHBjQm1OVXI5bUNN?=
 =?utf-8?B?RndvK0hib2RZUzVrNkRWdU1IWGNXVHZ4K0ZRNjVBSUJQMWVRZ2tzUlJlNzV4?=
 =?utf-8?B?VG9Od0pZd0JjU3g0Y1pDT2djbDRuc080SmVoR0hZcGVLUTAwZW13M3A3TlZI?=
 =?utf-8?B?a0c4bUR6SGVzTjBvSXYrRlE5WktFSXhXTHpBeHhyWXFpQTUyUG04bHlqWWJj?=
 =?utf-8?B?QnVuSVhQeStTc2Q2SWM0NitqQlY5Q3ZRWlk3ekdweUh3MmpjSFc2Ri9qRnRj?=
 =?utf-8?B?MlQyRS80R2R4dzlhMVRYekV2dGkxUlRwOERkM1VhUlR5OG8xaVQrejRuOHhh?=
 =?utf-8?B?YllqUU1KQWRFekVHR3FQeTd5d0t0Y2ZtdFJIcThwZSt3VFl1d1ZtTUNBQWVK?=
 =?utf-8?B?eFZkRWExUFZiK0xNQ3JnTE1DaVhjdjRqc1pXek1Qc04rR1NBb2xQL242UWhk?=
 =?utf-8?B?NnU3Yy9FY3hDbDVBN1pFelozK1ZpMHJySlN1akNhdVhFNXJBNkxIL3ZWZDNR?=
 =?utf-8?B?Q3RQbzhqb0Y4WGIxU2Q3MnhrVXR6elZNZEpyNUp1aUZxajJKMGJRQXV2RFhm?=
 =?utf-8?B?S2swbmFmMXlRNnVrNFFzYWFNcGdXYkNRZllnMnFROGd2cWNhcDI4S3ZGbTdv?=
 =?utf-8?B?cTM2ZkdRYnI2azFzaXFFZjRLYW8yUmZYUmhyZkxISlpnaUFWZ2JveDhVeGF5?=
 =?utf-8?B?SjBOaXl0WGVvd0Z2OTladmh2bWFVenRON3hFMXdEcURqdTVSQkN4VUd6RlU4?=
 =?utf-8?B?YXNhcER4clBFYmEycXMxb3VKd08wM2NqL0h6c2VLbzhpbC9RZFlTV1ZvNGtY?=
 =?utf-8?B?eFYwdHNkdEd1bGUxMHRRSCtCM2JUVU4wUXZaZW9RaThiR3lncWdGYS9Tb21V?=
 =?utf-8?B?OUx4dkROZS9YS3ZZVFd2b0ZUMnNpK1RNSEVvbDRsOGJVQ0JwWVRMR1JFVjFO?=
 =?utf-8?B?U0k2elpxSXBMR3dSSkY1UzlPUm9Xd0Y4MVNxV2EvYTBiT1l0K0oyc0hKYmRX?=
 =?utf-8?B?TEhwaEp6WFRxNHpveVc5LzZ0ZDlOVmtxdWlkTGxDWklTN1BOT1I5eEFyLzBW?=
 =?utf-8?B?a04vWThqK3N2WXAzNnRSMWdaRXF3b0RocVJrY3huQWtlNkovZDBpRFhwQ2JS?=
 =?utf-8?B?YzByOWEwWFJZOGNrU3ZtWkpXMjZpRDFkdEUyM1dhamQ5ejdUcWdPNk8xTkw3?=
 =?utf-8?B?SlVrRG9wbWpnSFBxTjcyaG9COThlakFXWjZ2Skl6blp3UFVCbisrOVlENDBR?=
 =?utf-8?B?QTFGYlBBUXF2Vis5QmxTQ1FJZmhQTlQ5VkpCQlc3T3hnSWJ0dTZndEcwTU1Z?=
 =?utf-8?B?NHp0VVFtSnkra1A2S1RFM2luNkx0WUhRUjdpSmlBQzBvem9yZ01vSDNRaEVM?=
 =?utf-8?B?Zk5tZDRXbjZxSFdnelNPUzBQYXg4dDB2SXZydUtjVnRnRXlOMGJxZWg3TmI2?=
 =?utf-8?B?dDVkVHRvOEpLMkRRVE0zVzNlc2NIUGthL1Ntak9MZzFMbUVBZXgvR3R5ODky?=
 =?utf-8?B?dzM2S2JqWVFkRldzV2ZnRHlOcWNVdXJFWHFpMHVCWW5lS3ZkdC96c2FSYWRL?=
 =?utf-8?B?dGJMaGtrVnNzdGt5ZXdTbTIwZ2IrT25sTWRLdjdTaENzV0Q3SDc0Zm9UVGoy?=
 =?utf-8?B?VTlzK2pGTlhzSWN5elZpVU1TRmRNcXVTbTRhS2RoUEx3SDlTaHF4SG1mbUFv?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aa85c9-ae83-411c-3905-08db195a9fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 07:08:42.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/wepe9qMGZqKHOvutMzeaoarFdWZAM3oJfjIMn4WS3ta8ixNo7dd4wcAoOz9XY1XV1nOYabb9SqE701eBWzxM4vJ4IBOv+htPfYNEaEJ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgdm9pZCBnc21fZGxjaV9jb3B5X2NvbmZpZ192YWx1ZXMoc3RydWN0IGdzbV9k
bGNpICpkbGNpLCBzdHJ1Y3QgZ3NtX2RsY2lfY29uZmlnICpkYykNCj4gPiArew0KPiA+ICsJbWVt
c2V0KGRjLCAwLCBzaXplb2YoKmRjKSk7DQo+ID4gKwlkYy0+Y2hhbm5lbCA9ICh1MzIpZGxjaS0+
YWRkcjsNCj4gPiArCWRjLT5hZGFwdGlvbiA9ICh1MzIpZGxjaS0+YWRhcHRpb247DQo+ID4gKwlk
Yy0+bXR1ID0gKHUzMilkbGNpLT5tdHU7DQo+ID4gKwlkYy0+cHJpb3JpdHkgPSAodTMyKWRsY2kt
PnByaW87DQo+ID4gKwlpZiAoZGxjaS0+ZnR5cGUgPT0gVUlIKQ0KPiA+ICsJCWRjLT5pID0gMTsN
Cj4gPiArCWVsc2UNCj4gPiArCQlkYy0+aSA9IDI7DQo+ID4gKwlkYy0+ayA9ICh1MzIpZGxjaS0+
azsNCj4gDQo+IFdoeSBhbGwgdGhvc2UgY2FzdHM/DQoNClRoZXNlIGZpZWxkcyBpbiAnZGxjaScg
ZGlmZmVyIGVpdGhlciBpbiBzaXplIGFuZC9vciBzaWduZWRuZXNzIGZyb20gdGhlDQp2YWx1ZXMg
b2YgdGhlIGlvY3RsIHN0cnVjdHVyZSBmb3IgaGlzdG9yaWMgcmVhc29ucy4gVGhhdCBpcyB3aHkg
SSBwZXJmb3JtDQpleHBsaWNpdCBjYXN0cyBoZXJlLg0KDQo+ID4gKwlpZiAoKGludClkYy0+YWRh
cHRpb24gIT0gZGxjaS0+YWRhcHRpb24pDQo+ID4gKwkJbmVlZF9yZXN0YXJ0ID0gdHJ1ZTsNCj4g
PiArCWlmICgodW5zaWduZWQgaW50KWRjLT5tdHUgIT0gZGxjaS0+bXR1KQ0KPiA+ICsJCW5lZWRf
cmVzdGFydCA9IHRydWU7DQo+ID4gKwlpZiAoKHU4KWRjLT5pICE9IGRsY2ktPmZ0eXBlKQ0KPiA+
ICsJCW5lZWRfcmVzdGFydCA9IHRydWU7DQo+ID4gKwkvKiBSZXF1aXJlcyBjYXJlICovDQo+ID4g
KwlpZiAoKHU4KWRjLT5wcmlvcml0eSAhPSAodTMyKWRsY2ktPnByaW8pDQo+ID4gKwkJbmVlZF9y
ZXN0YXJ0ID0gdHJ1ZTsNCj4gDQo+IEFuZCBoZXJlLg0KDQpJIHdpbGwgcmVtb3ZlIHRoZXNlLg0K
DQo+ID4gKwlpZiAoZGxjaS0+bXR1KQ0KPiANCj4gZGMtPm10dT8NCg0KUmlnaHQsIG15IG1pc3Rh
a2UuIFdpbGwgYmUgY29ycmVjdGVkIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBwYXRjaC4N
Cg0KDQpCZXN0IHJlZ2FyZHMsDQpEYW5pZWwgU3RhcmtlDQo=
