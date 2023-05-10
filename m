Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761556FD8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjEJIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEJIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:09:11 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0F2122;
        Wed, 10 May 2023 01:09:10 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A4w9Fg031015;
        Wed, 10 May 2023 01:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=UHwrhcP+kSpB45UBZ1RgRE59D1G6Q9ENcD5CF0Hu4Zc=;
 b=x7zLFjd796wwP1qNB239w8i0+SRtl45JIXAzxhh2sM79KHkElJO4/hMxgGwt5PYmRcMu
 TwRUSqqcFG55uCf9qVYpLKMyAuMfwv7Qd3YOwM2oMh5bPJMflr7SoZEHyTsMrMZX+THO
 qa28ArN81GGtEALhhRQ+KKBUKzz5PXflXJhTO6aeazWJ0WGCkLqiMDGkoprv4u4Sk5fQ
 x1VfE608N5bPZdewzzzNtwxIeLm3hrvauBcTsdl1i07gSCXNVtKt/BQqM/C5m8IIWPmL
 IVp0TqBzgYab4fruzKs23wEOi9PIPclpCeKVxtpkLvlaz1reCNAKd/M9Ai/DrXlBE+xv DA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7tbkv3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 01:09:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuleXXkcnccr9wFVEEhZ6Ne85J+2ponnhKgnF+t062QsWxAhEYYiLTWdoPJAmBUCDQSWaIzUPjgs5FqM0S1hhWWDGAWevYczAgGP8KdNdT9A1eNeWC4Mr74jFn9UQyn9B1s8QlkS4gPbIKWyhSeusQ4L8CHu+pDNuuNdYlWqWim3sJTtxIzGcq//fmFxpuBNxv6QtsEgDeLSmBt9ecrmHp3Yxcu/72IFSQ4zU6T1tpAp8wt/MaFvhmsV07KMqCgfI9jliwTNAEF8DF976DuoMIMxIJarKVSlSDdvHPu3mziNR95UER4d6oh+Cgy2WkvrDwXt9LKsImHeyOMb72/Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHwrhcP+kSpB45UBZ1RgRE59D1G6Q9ENcD5CF0Hu4Zc=;
 b=hvhmNJ12Ryr1ZQEXxmay7BBXL7DGOx5gtCNv4EmxBz4h6RdNnPgeQyitGJNy4SlaI4MXlzquiGYYlr3SEddt6Ma66S8PjPXgB+p44W3GPSxFFMh64cKExoG2Mxkir/uSO8phmqT0/XCUcbwERhPCCmO3xF7m9LViqnAaeouqOn7CuWaOL2VLO7q4iPzuU5sJlYzxvVDjWggGvJDdZObcoYDD1SPHLLme0EN4peSKtT6NojAXoE3cfsyNGHQhyTRz4RlU4Q2UHH3hlMbuWgYUjeeAM5kZPUWyZsvCI6fadn3JpMrkVGJ38CbI3lasve/ZiaxMo2zbjJsiA5Z5fJ7muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHwrhcP+kSpB45UBZ1RgRE59D1G6Q9ENcD5CF0Hu4Zc=;
 b=ZwMJ6wqax4VcRUfd/vU0hHtv96lO9qM+kABAcLWuUMcf02W0Zjx1HZkCo4ipItLDBPOd4BYJH4+2LwoQ3LNg8kx3hyzX5MKKYDG7MVYn15lBlZPBHeCFJR7FkjRNBoS69Pl/JRUFGTdxSpHMBcAvoigL+kJEx5pfWU5jPp8edUXqJg9zSMt8gumevseeBhqFKO1Pn68lW9aPLigJTqsEp0pUG0ktIeyXMMuXj9rC/y3QDpC4oFp5JDgAZWyTFFk0Es0l0AkbynpPX0WOTQY+AeSFfrpUOfLv7FtriDUB905fqVqF7yf+bRI4zz4gqaUwU14TU5PIZ/CaN20y++AfHQ==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by IA1PR02MB9467.namprd02.prod.outlook.com (2603:10b6:208:3f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 08:09:05 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 08:09:05 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH 0/4] audit: refactor and fix for potential deadlock
Thread-Topic: [PATCH 0/4] audit: refactor and fix for potential deadlock
Thread-Index: AQHZgYLqBTlbVO45nUiARiTa6bZEZ69QadWAgAC/3ACAAgCcAA==
Date:   Wed, 10 May 2023 08:09:05 +0000
Message-ID: <0BA588DC-1E53-4BCE-B124-77C5C730C267@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com>
 <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
In-Reply-To: <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|IA1PR02MB9467:EE_
x-ms-office365-filtering-correlation-id: 61c3ccba-7e5c-4352-9807-08db512dd2cd
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E2mTmXFnhHw3GQhIQ/0FJkWfwN6xwmxSzlCNYOONN2jsg9noHpnTHMG9fUeZMA3GbeHeaZDccR1kz1P4RTOOmbWt7moPzRls7xolyMCQrjfUId0QLXNcMCp6f1gccFmRyuy4nM6y/GaDuK5jZrEJG04zUNDFLeztf24w41eHlnp7oUtDi2JuSDABa4Dht/dV8CDWsA44ce0IZjD1yt+pvqNS1NeHpaF6zuXO/8S09Sou7SWt2Z0+m0vTxBssOlvhXDF6OyOkX9xACCbgnMKmqg34VETzrgSR7WD+5HvGG9jrDb9a3jHlQLwDgE2l3x2R3Hn16h7yzxAwxnyXmHDvu6b41eROZWc6gtdSSWplMblbS213l/a1jVaVWPJ8uUOgiV3BN4L1BxRxheNWemyqLkkuXkc1+FbRYUNAdiV5Sjmgq4l6z4FdIDWQjrU1R3/lX30anWXNINfWZo+OD0oAhypg6HGGDLtFjWFARt8Q8pwv0jq+Vclq/M/9RfND5eiwe2gpoCbcIyUWzRLL/AauozyxnJu51kHDt8LqUCW8gSxCANtIsj6MAe7AJpROY+pLLGCBMTmu1rkkDiUjGMU+2Ae6YvkQh4NBCuwZB5l2BS9KcmpZoX0fJqkX0IcIMcVhVzFoKo/xbY/Rty+JjIBQhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(6486002)(8676002)(71200400001)(66556008)(6916009)(66946007)(91956017)(36756003)(76116006)(8936002)(66446008)(64756008)(66476007)(54906003)(2906002)(44832011)(4326008)(41300700001)(86362001)(38070700005)(122000001)(316002)(33656002)(38100700002)(5660300002)(478600001)(186003)(53546011)(6506007)(26005)(6512007)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFHcWQzTVFCOHhYNll5Wm51SGJtNmRUbWt2T3pSSnBpOXQxVUpDRWZtc1Fj?=
 =?utf-8?B?RlJRNnhRY2k1V3k0NHpnVWpCM1ZGMlVsWHBuSzdibUVMaVRYeFlMSy9EY0tL?=
 =?utf-8?B?azhZUjJXMGFIZXpvTkpCVVVPYkNyQVd4bUhjRWRDMjFhcTBEZDZ4WjZYZFdu?=
 =?utf-8?B?bGdtaExQeFpHYS81c3ZINkRma3JtTHNzbEpOMEhqY0l0WHJiVmZoc2FPWGgy?=
 =?utf-8?B?ZVRpbUIrVEFkeUJBTzdRVTB2c2VUSlpkU00rWFNON2JmbitsTDYvQ1BhdXYx?=
 =?utf-8?B?R2E4YUF5MkZrLzBFdWlpcENhU1NGK1lJMjU5R0lKcVV2WlNUZ2JtNWtIQnJD?=
 =?utf-8?B?VnRHUHd1TUNKWmdTd21FNFIvMWZ2OTVtOGo0blR1OWJkeHc5MERjOXZvTmRN?=
 =?utf-8?B?VmluMjd2NU9TcHlVSDE0YUZaUmlhMTBXSCtpVFZZNmlKOWtqa0ZXSVNOOW1J?=
 =?utf-8?B?VUFRMDg3ZjZKNW1qSkZ6V3dhRUppS245dmI0R2p1S0h2OVdzUUZrTHJidkk4?=
 =?utf-8?B?UjFTUTVBdS9DS241VGZFZE9UUUI2eTRLcCtXM083WDJpRjc1enJDZ052VG83?=
 =?utf-8?B?Sk8zZWt2VnhCbDN0dDJiYWdQb2NUMUNCcEs4cjgxOTduamlkTWFFUGs2QWNL?=
 =?utf-8?B?cVNJb0pjZVBrMkd0eEd4RndFVmd1UlFlWWNNOGpST3RYTCtXSEdmeEFiUDRq?=
 =?utf-8?B?dk9hSjlCMUdWYnR3RjV0K0pxYXl0cXZiZmtIUjk2RFJaNkpKN0lvWTY1Z2Rz?=
 =?utf-8?B?aXNReXBVSU9YcGVIRENHeEt1ZVcrRGwrOW9MYzl3YldEOTBodG9tUGVIMmc5?=
 =?utf-8?B?Ly9WNG42Q2E3L3l2dmM4WVEvcXA5RVh3VmFyTEVFNlJMdnJtdWVTdTl6aDZr?=
 =?utf-8?B?TG5VbnVpck11dENqY3A5SGNqZklKdWYxa3B5YWpFNEJjak1NdXVhYSs4c0RP?=
 =?utf-8?B?UkQyV0cvRnYyRDFIcWZpbXJKOGpmbU5iUTlBNE9NOVg3d3BxVGxNZjlzR0pu?=
 =?utf-8?B?UERQdDJJMnpvYmwvcktjckcwcDVvL3l1ZTJBVm1UdHIrQURsVUJWa3h6Vmpm?=
 =?utf-8?B?eWJNc1RUQlluWXFyT3B5MXRsWDkxclc1enZPVTFYVFYrRkNYWW8xbTd1cURv?=
 =?utf-8?B?NFUwUGt1aC9vajNPVlJQdTdWQlQzYURkTlBML0dWUTBwbEdtbkkzUDFGdUZD?=
 =?utf-8?B?YWxtRURreEJlU0h2NEszNk9EOTE1R05sUVFpbmpwYk51NGVRYVR2MXdnYnNE?=
 =?utf-8?B?RXZiUG1wMDlxMGIxUnRndWtYZmNZSzRDZTBsZkU0QzB0dHpaUGNlUkNERjV2?=
 =?utf-8?B?UjlxS01mZXRsVjdoRThqYXJpZnYvZys2emZVcmlHei9rUlAzeFk5amxXQUY5?=
 =?utf-8?B?TjdlU2VHdGlYTDRyMlFmMFJXalF2L2pTTGdZNUVqWUphWTlQaTYwdS82ZE43?=
 =?utf-8?B?aU9JRkhZQjNtUWNXL01mUWRXZWc3OEp3M1lwRDBpbmVXYW9lSFNOUW5KYVZP?=
 =?utf-8?B?K2lxRzkvd21ac2xOZ0hXQ1hFS3daQ00xSzRXdkw3OTFKNnRYdWV3MTZpSlZH?=
 =?utf-8?B?US9ocVAza3oxcmgxaGp3MFZaZFBacWJDWGdSbkE0aGFDU1BXV2dTMTlkYUt6?=
 =?utf-8?B?VEZTZk5nanNEZVRaY2tLT2dycTlUaFlob2VSTEl5TWlJZ2JPV3ZKb3FpaHlR?=
 =?utf-8?B?bTZwTTFhV0tsbEdiZ0ZBczJRWVQ1elJIbGRhY2UwK0YxTmVHS2swL3Y0eFox?=
 =?utf-8?B?YU1QRkZjbWZaQ1RXaE55dHlYK29HYklIWXFJVVo0NnV1MWxIS2ZqUFRSV2lF?=
 =?utf-8?B?L2xmZldSclRIOUhxd2VDT3hTanZ4dEtodFY5WjlhOExsUnJsYmpOcWphQXFr?=
 =?utf-8?B?RzB5SWhJL3FWSnM4dHRVaTYyQzBUMGJiTVlJK0pneTVKY21Zb0lMaUo3dGhn?=
 =?utf-8?B?UERVcEcwN3BtbDRDZUIyVll2eTVDNnhVUTZBU3pVWER3TWJjdi9WdDBmczMx?=
 =?utf-8?B?TXFQSWhOU2VOcStRUVZHaVpPRUE3bzg0bUF2aWVQMWRNU0c3M01VaDVEc2E0?=
 =?utf-8?B?eG1kK2xOWU1aWU5SN0FldERQVEVMVFYwWHdEZ1o4YTVDaUtBRW5FeFE3aGc4?=
 =?utf-8?B?N3QxZmZxWDRRWk9POFN3ZTg0WWQvdXgvSFJyTys0YjV5NEc2R1BuTGdQN2N4?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A7B682BA5701341A569E4195E1592F6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c3ccba-7e5c-4352-9807-08db512dd2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 08:09:05.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sphxfo73jmYLfreTg1DyIyFF9Bjjs1Xl1OMthYT7gvASkRCVuhxydnXN1pG+qjzFeNWAcXnu1eFnlNJgdsdAVwC+cRjihzqa3VIX/xDUeMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9467
X-Proofpoint-ORIG-GUID: AzjHipQdjHz5lGPXJuKmF9Wm6I_GeIsR
X-Proofpoint-GUID: AzjHipQdjHz5lGPXJuKmF9Wm6I_GeIsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDksIDIwMjMsIGF0IDEwOjM0LCBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRz
dWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gTWF5IDgsIDIwMjMs
IGF0IDIzOjA3LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3cm90ZToNCj4+IA0K
Pj4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCAzOjU44oCvQU0gRWlpY2hpIFRzdWthdGENCj4+IDxl
aWljaGkudHN1a2F0YUBudXRhbml4LmNvbT4gd3JvdGU6DQo+Pj4gQ29tbWl0IDdmZmI4ZTMxN2Jh
ZSAoImF1ZGl0OiB3ZSBkb24ndCBuZWVkIHRvDQo+Pj4gX19zZXRfY3VycmVudF9zdGF0ZShUQVNL
X1JVTk5JTkcpIikgYWNjaWRlbnRhbGx5IG1vdmVkIHF1ZXVlIGZ1bGwgY2hlY2sNCj4+PiBiZWZv
cmUgYWRkX3dhaXRfcXVldWVfZXhjbHVzaXZlKCkgd2hpY2ggaW50cm9kdWNlZCB0aGUgZm9sbG93
aW5nIHJhY2U6DQo+Pj4gDQo+Pj4gICBDUFUxICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BV
Mg0KPj4+ID09PT09PT09ICAgICAgICAgICAgICAgICAgICAgICA9PT09PT09PQ0KPj4+IChpbiBh
dWRpdF9sb2dfc3RhcnQoKSkgICAgICAgICAoaW4ga2F1ZGl0ZF90aHJlYWQoKSkNCj4+PiANCj4+
PiBxdWV1ZSBpcyBmdWxsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdha2Vf
dXAoJmF1ZGl0X2JhY2tsb2dfd2FpdCkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgd2FpdF9ldmVudF9mcmVlemFibGUoKQ0KPj4+IGFkZF93YWl0X3F1ZXVlX2V4Y2x1c2l2ZSgp
DQo+Pj4gLi4uDQo+Pj4gc2NoZWR1bGVfdGltZW91dCgpDQo+Pj4gDQo+Pj4gT25jZSB0aGlzIGhh
cHBlbnMsIGJvdGggYXVkaXRfbG9nX3N0YXJ0KCkgYW5kIGthdWRpdGRfdGhyZWFkKCkgY2FuIGNh
dXNlDQo+Pj4gZGVhZGxvY2sgZm9yIHVwIHRvIGJhY2tsb2dfd2FpdF90aW1lIHdhaXRpbmcgZm9y
IGVhY2ggb3RoZXIuIFRvIHByZXZlbnQNCj4+PiB0aGUgcmFjZSwgdGhpcyBwYXRjaCBhZGRzIHF1
ZXVlIGZ1bGwgY2hlY2sgYWZ0ZXINCj4+PiBwcmVwYXJlX3RvX3dhaXRfZXhjbHVzaXZlKCkuDQo+
PiANCj4+IEhhdmUgeW91IHNlZW4gdGhpcyBvY2N1ciBpbiBwcmFjdGljZT8gIA0KPiANCj4gWWVz
LCB3ZSBoaXQgdGhpcyBpc3N1ZSBtdWx0aXBsZSB0aW1lcywgdGhvdWdoIGl04oCZcyBwcmV0dHkg
cmFyZSBhcyB5b3UgYXJlIG1lbnRpb25pbmcuDQo+IEluIG91ciBjYXNlLCBzc2hkIGdvdCBzdHVj
ayBpbiBhdWRpdF9sb2dfdXNlcl9tZXNzYWdlKCksIHdoaWNoIGNhdXNlZCBTU0ggY29ubmVjdGlv
bg0KPiB0aW1lb3V0Lg0KPiANCg0KSSBmb3VuZCBhbm90aGVyIGNhc2UuDQoNCmthdWRpdGRfdGhy
ZWFkIGlzc3VlcyB3YWtlX3VwKCZhdWRpdF9iYWNrbG9nX3dhaXQpIG9uY2UgYWZ0ZXIgd2FrZSB1
cC4NCkFzIHdhaXRlciBzaWRlIGlzIHVzaW5nIGFkZF93YWl0X3F1ZXVlX2V4Y2x1c2l2ZSgpIGl0
IG9ubHkgd2FrZXMgdXAgb25lIHByb2Nlc3MgYXQgb25jZS4NCg0KSWYga2F1ZGl0ZCB3YWtlcyB1
cCBhIHByb2Nlc3Mgd2hpY2ggaXMgc2xlZXBpbmcgaW4gYXVkaXRfbG9nX3N0YXJ0KCksIHRoZW4g
dGhlIHByb2Nlc3Mgd2lsbA0KcXVldWUgc2tiIGFuZCBpc3N1ZSB3YWtlX3VwX2ludGVycnVwdGli
bGUoJmthdWRpdGRfd2FpdCkuIE5vIHByb2JsZW0uDQpCdXQgaWYga2F1ZGl0ZCB3YWtlcyB1cCBh
IHByb2Nlc3Mgd2hpY2ggaXMgc2xlZXBpbmcgaW4gYXVkaXRfcmVjZWl2ZSgpLCB0aGVuIHRoZSBw
cm9jZXNzDQp3b27igJl0IHRyeSB0byB3YWtlIHVwIGthdWRpdGQuIEluIHRoaXMgY2FzZSBvdGhl
ciBwcm9jZXNzZXMgc2xlZXBpbmcgaW4gYXVkaXRfbG9nX3N0YXJ0KCkNCmtlZXAgc2xlZXBpbmcg
ZXZlbiBpZiBrYXVkaXRkIGhhdmUgZmx1c2hlZCB0aGUgcXVldWUuDQoNCkF0IHRoaXMgcG9pbnQg
SeKAmW0gcGxhbm5pbmcgdG8gdXNlIG5vbi1leGNsdXNpdmUgd2FpdCBpbiBhdWRpdF9yZWNlaXZl
KCkgaW4gdjIuDQpMZXQgbWUga25vdyBpZiB3ZSBzaG91bGQgdXNlIHdha2VfdXBfYWxsKCkgaW4g
a2F1ZGl0ZCBvciB5b3UgaGF2ZSBiZXR0ZXIgc29sdXRpb24uDQoNCkVpaWNoaQ==
