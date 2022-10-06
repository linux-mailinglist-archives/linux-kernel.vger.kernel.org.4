Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094D5F650A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJFLOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJFLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:13:57 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0237A447;
        Thu,  6 Oct 2022 04:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPlhJWmLKGA33cZxhDERX+goIahfnnMF5hcvVWZl0UQSbtk5Sko0FtzJ4Q5yrUe0ulMVa2yGWHAOPNLu7inLhSt5z5rWKbB9/FqSQRQWw+ebu8EJ4SAHXaXcPRLJG121dt1l5lEE55P+DCeUkryUukvnz2QwVg3+Hb/Ue5BWMwRkWp3hXSoN5EeX6+VJgZ/F3BxjzjFcz1Wh8QMiczvNYNSlF9tl3rJCjBXuTsdDpDDvYdtKImXpOwqyevMCqksmw587pcp07Sjwjh+Kl41SNuedksqd0xLOPHV4T7IkXnaNgDDBZysn7z7zNLVnbiy6FMz0eIaPiuT+NmAt93ewFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA2pjTt5+iGpDfPTdBQRDAEOpVzSFlwzo/B8XyhGDgg=;
 b=LA/teqsAeYszC395906Uaa0NbqSPxAUSqqkVrLykC5yZov2LVVgG/fDRGZoezA/50psZ2cZW1ggjp7lpIsiMP3GyE39xkD8IUnyAtYXVskgY5laCw3vjmIvht5NDfsMKpPDYvHfVF2cVcMrKO6ID6fvfzB5YH/eFC6eCFOsLv/C6tc62VDm6SiTB8fRtrKvqS0F4rVRhgNPHgHGAo84SqHMwRcwSGvx4UlIIfO4B1tJJZN5qGpieCmxI9LKm13csbPGr9mFYj0PLG0axVoBWuQI3xJg0L32+QD4QvDOjqgIDi1jFSxqWAnMGaC9SjKd5NGHXhqs6gV0Eyz9rc43aMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2pjTt5+iGpDfPTdBQRDAEOpVzSFlwzo/B8XyhGDgg=;
 b=FvFEik8etN+mrz55tSYj5rQfbbtnX5UnnSyYbQbbuXLiSPZT2bj8ckxzL3csojXYqmZ1yadCbf46NdMn0rSQoSQiMBxIybvwoDhm+ugPcKw0qcWecvX8PyqCHrCqWu44LeQDRIrU+DyAVx2LfgAKT1VXHJ6qVgDUHYNbFWhoeaK4EiXUypGyIN30x0v7vG5s1B+tGoplHZiOM20N1densY9B5BpHdo4CAG/jAsnVIzxcGIq81cSQupt8MEhXzmbBKsiScZeWi/mmL04iLXEfF4LnT0xGpp8e8A2Sl/yYuoPA30uTOXfYqQhD/fY593M9OXxYaPkphdYX2Z4P79IxOw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 11:13:52 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 11:13:52 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Finn Thain <fthain@linux-m68k.org>
CC:     Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: mac_scsi: Replace NO_IRQ by 0
Thread-Topic: [PATCH] scsi: mac_scsi: Replace NO_IRQ by 0
Thread-Index: AQHY2UT/Y9mxrmgzokKDa+p4K7gASq4BGIwAgAAeWAA=
Date:   Thu, 6 Oct 2022 11:13:52 +0000
Message-ID: <009bf4b2-ab5d-b583-20bd-8eee397e251a@csgroup.eu>
References: <f11593e75ba2e18e3b76989255cbb2e53a0213b4.1665034244.git.christophe.leroy@csgroup.eu>
 <5fb75ac2-678a-dd6e-2e68-7485b2d2ce5f@linux-m68k.org>
In-Reply-To: <5fb75ac2-678a-dd6e-2e68-7485b2d2ce5f@linux-m68k.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1439:EE_
x-ms-office365-filtering-correlation-id: 97c0e79a-b435-4333-1423-08daa78bda25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g55z4ekSpH1RM3LcZJsp3F1KVkJmCo1/vRb7JEG1x1E6sIkvqRoogGjL3tudynxclxTin74s7n06fauXKI2uov6LLXMdozFGuiJ1Jh+KGlNR+xA8xMPjekWDUSz+Wf1dlXpm3DHHN5Fs0qKv9sqvNf923ggN06CEgtzJGt4UqgUdercokBqPYgqaBC48zk4cyXXOChVwpGuq3jseMCZXQgIkWCQXbR4lPR3HGTScnjZRMQiWzEf4McnxIKhJvEfUUB02/Ho3rHtxNM7Xg8EcQUunjKEWv/eLayU6wE4nln52z7bygPtMN5zlmQ8CfS6TvkmFdt4V2LPnwDMI3kgidsN7+efek3reUyE83cObo29FPVjXSRKhmygtSPSf6WhPxanB9O8Fa2ZnimyPe+9GgCSKgKpf6PrhTbVAa9L+SdWB9a/XWDldTVPcr2sYEbcuXb6wcgw+xPayY02jsMdhb14y8m7lLSCxBtft2ttKkRaq6u2GhB3h5RBcQQXfxZBOCTXOp4jcHFUCo9VuaQeEr4W/UnUNLVQOCgJD7QroOnuSZ2MBr3jaDcpG4OA+i/1xkqBdJREkkBUR7pL19Vv1R4h+ILnBfHQVV8lnuiGwlcNcF3X7XtmHDXx2S31gMSKIjN12rvy+BYnbdtrDbhIeqWuoQpuadrblImXkc/Bslr0kQlf3+ZoUTOJok/7h46ELbwQtBok6Y1GvOXw+AcWUwQ2b+jGHjX/4wQ6vPzSSW1ekt/HOBRX+CQNhAGl+N4cIqLGSyOMcOmMh42wrqSj4/de1Z1cKXnmXKbem2+MNug5s21wbVARrcz9C6lHqu1AnNXAQDzD5AAPGLRxtGEuFMiSy44lrQ7oq5gW6d4Aov3g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(8676002)(83380400001)(6916009)(316002)(38070700005)(86362001)(4326008)(31696002)(38100700002)(122000001)(76116006)(6486002)(2906002)(71200400001)(91956017)(8936002)(41300700001)(44832011)(66946007)(66556008)(64756008)(5660300002)(66446008)(6512007)(66476007)(186003)(54906003)(66574015)(2616005)(478600001)(966005)(26005)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjR5L1V2TFJITjdkaUcraHBTVHhPb04rMEJRekdyenc3dHlyZGxMUDdBbEFQ?=
 =?utf-8?B?SFJreVZIbUt3T0Z6OThQaEFNY3k1ci9EZTJmTW5LRnhoSUZkRTBQalFEc09I?=
 =?utf-8?B?bllHZWR5NjErKytlMitqd0x5Y1JrYkJORW9lQXpLV0F3RUNncTIyL3lUNWND?=
 =?utf-8?B?Nm90VlhLRW9BQ2NWSm5KdnVpWmVveUQ3WjlFVVdvK0NNWVByRUJONUlGRlRa?=
 =?utf-8?B?YVYweWZCV21tZjI5ZjlnNXZ3bXFhMzh2VzFyc3RjRjVzZGNRcGh6clExNXdQ?=
 =?utf-8?B?OWpyVjI2Z0RpUWU3WDNTK212SGxFdUZGaWY5YXZQczF1cTZacXhkemZaQzht?=
 =?utf-8?B?aWY2cWJNQXRLRWF0WWFaMTdvRjJvQjZvb3BxaWUwUUUxV2xWdHVTMGduTnBi?=
 =?utf-8?B?bjIxWVJFSS9aSENzQnVScUVwNWl0YlFHZ1ZJdktZN3YzdU1DSUNYSU5OOHBH?=
 =?utf-8?B?WmxScmNqTWN1Q1ZBRkl4QmJobVJ3ckZ3STNld3VQUVFsUFdvbUlWYjA1Snlx?=
 =?utf-8?B?dEJKRHRHQmpBbU5jMEVlc0JrSzlhTXBsUnE0dStFU1UxNVllUjNEczhiQTIz?=
 =?utf-8?B?Y1R3cTdsenZWcEZpdGllOGxrbGQrZmVqbkthamptNmU5UVBiNWlwa3djeVFs?=
 =?utf-8?B?Y211WDhyQmRqNVdkZTJ2NzhHcEE4UU40dXZNSzNkVUNKcVpKNzZjNmMxeDNP?=
 =?utf-8?B?NG8zSERqOEN1QVF5clJPbngyM0t3VWRtWHZ1blMvenY5NFVsQ1hHNkZzQ2JV?=
 =?utf-8?B?ZmMrc3NVYzdHZThBS3pLMDNwK1dScWVnT0g1bjVzMG9lV1FWSUdMeWpYWVJL?=
 =?utf-8?B?djUyQlJnbHRlR3pNUFFaSUNZLzBwcnJGS0RyTmg0SFF1cDBQa3laS2FCOHZ0?=
 =?utf-8?B?eHh6SkdSbjdyQVFzeElYckdWY3hoSkMxM3lRVVNJWUVJT2llcXFEejJRaUFE?=
 =?utf-8?B?Qmw1WTE1c0ZSeDA5Z1JGeHF1T01oNXA0ck1zOW1DSDJnejlmdmdOMTVWckNO?=
 =?utf-8?B?Q2VxbzBJWmhJeENOL1g3WFJWSmQ2dktuZ0Zmb2ZHRGFtaGMvMWhmRGZkRnpF?=
 =?utf-8?B?N2R2RVFaZ01za3NQNndlM24zMkR4dGZkUTM5UVB1UmR3Yzk2dWtTaEdLa2cx?=
 =?utf-8?B?N0h0bHRrZkhUY1dMSmNSRmJ5eFlSQzFRSHZxNUJLdU90WTNwYVVvdTVnZWFI?=
 =?utf-8?B?dnFtS3Q5WEo3M2liNkRQQWtvcGV4aDVJSXN4c2hqNHIzcDU1dmhYVE5HQW9R?=
 =?utf-8?B?TGc3RERXdkc1VmI2NVpvNkRERmdEN0pKQXNlQnV4amZwRngvUi9PS0tvcmlT?=
 =?utf-8?B?Qk9MVWh3ME1HRzBnemdqQ2RwdFdCemNxNXM4TW9yamtGZjJHd05pRXFqU2F1?=
 =?utf-8?B?djZ2eDJPakNpTUZ2b3VtQ2hMTHcyQVcvSGllaWllY2JBZlhFUGwwbHFFcy85?=
 =?utf-8?B?SFNxNGpLNFZxUENFT05nMk1Zd204TFhhV2hlMWVQSi9ZYVRVRyszTTBoVkR2?=
 =?utf-8?B?UXQ0TzlNMzNUb3NuTUNndURjUy8wNFBnTko0MXlYcEVTUm0xTGZua0dQUHds?=
 =?utf-8?B?MXhRSTY3TVBSdHdteUg0OTFXMnpOQ0Vtai9kQmVGZkpvSVI5RTB2OGZraytp?=
 =?utf-8?B?NnhRaDErTWJoQlJncDdPUUJVbGxVclZpNXlzWkgxZzRac2toWnVTOU9yc3dt?=
 =?utf-8?B?SVAyMzZnY3JNTnpqRThDMzh1UUdQTG9sUCs1QldoeGtjeUVwUk1tNkxQT3RR?=
 =?utf-8?B?NkdsWFFZTDJzaDBESnBDbERKdzQwdjFxdFhpbmszQWdhRDJFMGlRVzE2YXVQ?=
 =?utf-8?B?MGRrVU1tbi9FRTdvcnVzcGxkdm5yTlJkQzdKWVVCL1plYm9qNG53QjhDUWtZ?=
 =?utf-8?B?RnZxQkpYZlVUZ3h6RkY5YkdTR3BieUZ5WFBVb2tRNGNORVFJNkliRlhHM1lL?=
 =?utf-8?B?N2pZVUZaVlRWVy95Y1dmWW1ZWkpVcm12UHRRdjh4V204TWZaUjduR0s4Z1dM?=
 =?utf-8?B?c09mYUFZTi9waHFtZllxZkFudzlqNlowS0VLMGxadlhuMkQvTHZoTmZlaEZM?=
 =?utf-8?B?SXhiejFTOVRxYklmOTZXSnJhRTlDeW1zNlkwVHRUY1lJZ3hjZGpSZG9ielpL?=
 =?utf-8?B?MFk5NGpoRkxRMVNaeE1ReEVmUkZHeFprWGFpREcwd3puamwyenc1TnY0T011?=
 =?utf-8?Q?MBWEd75oNXZogCknGxmdILE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0438347B5017D458A1FAF2D41E66BE7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c0e79a-b435-4333-1423-08daa78bda25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 11:13:52.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYpH24md60g1Hq5wCB9KEebRqfltmdGXlM2nbM5atRQADGo8LiG9tyV9QWvM9REvZQb5JRrnzBWtEs8mlW4DXUnovKPsX2QPajkvWxT4RTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1439
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTE6MjUsIEZpbm4gVGhhaW4gYSDDqWNyaXTCoDoNCj4gT24g
VGh1LCA2IE9jdCAyMDIyLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiANCj4+IE5PX0lSUSBp
cyB1c2VkIHRvIGNoZWNrIHRoZSByZXR1cm4gb2YgaXJxX29mX3BhcnNlX2FuZF9tYXAoKS4NCj4+
DQo+PiBPbiBzb21lIGFyY2hpdGVjdHVyZSBOT19JUlEgaXMgMCwgb24gb3RoZXIgYXJjaGl0ZWN0
dXJlcyBpdCBpcyAtMS4NCj4+DQo+IA0KPiBZZXMuIFRoZSBjb3JlIE5DUjUzODAgZHJpdmVyIGlz
IHVzZWQgb24gQVJNIGV0Yy4gd2hlcmUgTk9fSVJRIGlzIC0xIGFzDQo+IHdlbGwgYXMgb24gcG93
ZXJwYyB3aGVyZSBpdCBpcyAwLg0KPiANCj4+IGlycV9vZl9wYXJzZV9hbmRfbWFwKCkgcmV0dXJu
cyAwIG9uIGVycm9yLCBpbmRlcGVuZGVudCBvZiBOT19JUlEuDQo+Pg0KPj4gU28gdXNlIDAgaW5z
dGVhZCBvZiB1c2luZyBOT19JUlEuDQo+Pg0KPiANCj4gU29ycnksIEkgbXVzdCBiZSBtaXNzaW5n
IHNvbWV0aGluZy4NCg0KTXkgbWlzdGFrZS4NCg0KSSBzdGFydGVkIGJ5IHJlbW92aW5nIE5PX0lS
USBkZWZpbml0aW9uIGluIHBvd2VycGMgYW5kIHRoZW4gZml4ZWQgYWxsIA0KYnVpbGQgZmFpbHVy
ZXMgYnkgcmVwbGFjaW5nIE5PX0lSUSBieSAwLiBUaGVuIEkgc3BsaXR0ZWQgdGhlIHBhdGNoIGlu
dG8gDQpvbmUgcGVyIHN1YnN5c3RlbSwgYWxsIHdpdGggdGhlIHNhbWUgZXhwbGFpbmF0aW9uLg0K
DQpNb3N0IHBsYWNlcyBpdCB3YXMganVzdCBhIHZlcmlmaWNhdGlvbiBvZiB0aGUgdmFsdWUgcmV0
dXJuZWQgYnkgDQppcnFfb2ZfcGFyc2VfYW5kX21hcCgpIHdoZXJlIGl0IGlzIG9idmlvdXNseSB3
cm9uZyB0byB1c2UgTk9fSVJRLCANCmVzcGVjaWFsbHkgb24gQVJNIHdoZXJlIE5PX0lSUSBkb2Vz
bid0IG1hdGNoIHdoYXQgaXJxX29mX3BhcnNlX2FuZF9tYXAoKSANCnJldHVybnMgaW4gY2FzZSBv
biBlcnJvci4NCg0KQnV0IGhlcmUgaW4gdGhlIG1hY19zY3NpIGRyaXZlciBpdCBzZWVtcyBhIGJp
dCBkaWZmZXJlbnQgYW5kIEkgaGF2ZSBhIA0KbG9vayBtb3JlIGNsb3NlbHkuDQoNCg0KPiANCj4g
WW91IHNlZW0gdG8gYmUgc2F5aW5nIHRoYXQgdGhpcyBkcml2ZXIgY291bGQgYmUgcmUtdXNlZCBp
biB0aGUgY29udGV4dCBvZg0KPiBvcGVuZmlybXdhcmUvZGV2aWNlIHRyZWVzIGlmIGl0IGF2b2lk
ZWQgdXNpbmcgdGhlIE5PX0lSUS4gRG8gSSBoYXZlIHRoYXQNCj4gcmlnaHQ/DQo+IA0KPiBPciBh
cmUgeW91IGNoYW5naW5nIE5PX0lSUSBzZW1hbnRpY3MgdHJlZS13aWRlIGZvciBzb21lIHJlYXNv
biBleHBsYWluZWQNCj4gc29tZXdoZXJlIGVsc2U/DQoNCk5vLCBJIG9ubHkgc2F5IHRoYXQgTk9f
SVJRIGRvZXNuJ3QgbWF0Y2ggdGhlIHZhbHVlIHJldHVybmVkIGJ5IA0KaXJxX29mX3BhcnNlX2Fu
ZF9tYXAoKS4gVWx0aW1hdGVseSBJIHdhbnQgdG8gcmVtb3ZlIHRoZSAjZGVmaW5lIE5PX0lSUSAN
CmZyb20gYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2lycS5oDQoNClRoYXQncyB0byBiZSBsaW5r
ZWQgdG8gZm9sbG93aW5nIG1lc3NhZ2UgZnJvbSBMaW51cyA6IA0KaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMDUvMTEvMjEvMjIxDQoNCj4gDQo+IElmIGl0IGlzIHRoZSBmb3JtZXIsIHNob3VsZG4n
dCB5b3UgcmV2ZXJzZSB0aGUgY29tbWVudCBpbg0KPiBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
aXJxLmgsIHdoaWNoIHNheXMgdGhlIG1hY3JvIGlzIHRvIGJlIHVzZWQgaW4gdGhlDQo+IHdheSB0
aGlzIGRyaXZlciAoYW5kIG90aGVycykgdXNlIGl0Pw0KPiANCj4gSWYgaXQgaXMgdGhlIGxhdHRl
ciwgc2hvdWxkbid0IHlvdSBhZGRyZXNzIHRoZSB1c2Ugb2YgTk9fSVJRIGluIHRoZSBjb3JlDQo+
IE5DUjUzODAgZHJpdmVyIHJhdGhlciB0aGFuIGp1c3QgdGhpcyB3cmFwcGVyPw0KDQpZZXMgSSBn
dWVzcyBzby4NCg0KPiANCj4gTW9yZW92ZXIsIHdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0
byBmaXggdGhlIGNhbGxlcnMgb2YNCj4gaXJxX29mX3BhcnNlX2FuZF9tYXAoKSwgc2luY2UgdGhl
eSBhcHBlYXIgdG8gYmUgYWJ1c2luZyB0aGUgTk9fSVJRIG1hY3JvPw0KDQpJbmRlZWQuIFRoYXQn
cyB3aGF0IGlzIGJlaW5nIGRvbmUgbW9zdCBwbGFjZXMuDQoNCj4gDQo+IEZvciBleGFtcGxlLCBk
cml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jIGFjdHVhbGx5IGRvZXMgI2RlZmluZSBOT19JUlEg
MA0KPiBhbmQgdGhlbiBleHBlY3RzIGlycV9vZl9wYXJzZV9hbmRfbWFwKCkgd2lsbCBzb21laG93
IHVzZSB0aGUgc2FtZSB2YWx1ZSB0bw0KPiBtZWFuIHRoZSBzYW1lIHRoaW5nLi4uDQoNCkl0IGRp
ZG4ndCBwb3AgdXAgZHVyaW5nIHRoZSBtdWx0aS1idWlsZCBJIGRpZCBmb3IgcG93ZXJwYywgc28g
SSBndWVzcyANCnRoYXQgZHJpdmVyIGlzIG5vdCB1c2VkIGZvciBwb3dlcnBjID8gSW4gdGhlIGF0
YSBzdWJzeXN0ZW0gSSBmaXhlZCANCnBhdGFfbXBjNTJ4eC4NCg0KVGhhbmtzDQpDaHJpc3RvcGhl
