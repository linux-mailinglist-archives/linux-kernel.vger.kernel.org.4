Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5356F0602
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbjD0MmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0MmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:42:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213862103;
        Thu, 27 Apr 2023 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682599333; x=1714135333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D1Yyo3puY7Fnewg3RdBZfIAijYj9UYAEBcvR+c9fET4=;
  b=iz+J6JgFgHWKs9Zmz3xEmXdfFq437GBnic7Rk2dMOPZGkzH3kBtrlRqj
   2vYC7NmMLzYjeeCr1Zmh0Aex99AeHt6kdEVSlEZIkALoTUu0xRhslzTtt
   WuC3IYfUojLJlY8Bdqt4/7DgS9Ssec+idTGE0kevyykrbyvzG8AJj+M3w
   a/aLedeAXOQR/qCuRythzVEDB2OatGnLu6sQD+o3LVZxxMat2NBYvSBkE
   IVu7cB8jpyF3U2tsKVcdFcOc6TwYIXRub3GExRqtyeyMpT1u4eT6JCzaq
   NNXWwKkZat3klrm+ZIlFllE+h9yRbnanrXGi/KAgQHdKiMbomFjUOhi+v
   A==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="scan'208";a="210958586"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 05:42:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 05:42:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 27 Apr 2023 05:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAEgEM0wm0HH2i4cKWJ6YOSbjRQCDQkZ59fw6x4LEfGDvLaTAcx3GAeiVnOFyr+9JVNoY9v/oFsi7LTn+LSZORr6enfbgAYZpjCgoXCEIkaoZiNyDn/cm490jetPwY1kjHY6NtbqHpwglkI66dkNFzP1B4n4CNPjil3BHMMkG7wxfILs+4RCa8HWK//aGbRChdePbDV/WvM/emvCaig4ZKXkmi8gtZp0l/FsZlUU46U8yeNFCb4xLheyzDfSpWcFKR2sqAs8gFhUwN0LMBx26q5OwD5Mnw12zqjnNqVXlWvoZrpWdakHukGHayHaEOD+2WZowWbGTUE4m8R9nZYyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Yyo3puY7Fnewg3RdBZfIAijYj9UYAEBcvR+c9fET4=;
 b=I2kl8cgV5mzZKK/pFq1PwBrzGxRNX2MPutAmiA/ZLad57I2oslIwCmETSBhGSEj2/y7PsYme9PlN4rX23UeuQGE9oQX3Sd5pTnpdvm0CQ7/AoxwRtssm/ai+rnQQTGSwiCM/OYh+LPxU3GY8SgCSk+8PCM3Cndt4I1jVY0z2mnm/aBbr4VapQ0gvN+MCITqcLgNdORha4iCLMmIuRTP3sFWV+TwuMs/C+zn062x9buyDldGAa3j3Z4tK/GZqJL6dE0bOpxH/yhW6V6iqM8MvhexbrUzu6wyNw0ZDx5h0RioCHWoR2jWL9GFeGyh+z25aVgtvN6h1XcNfLZtKRoknRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Yyo3puY7Fnewg3RdBZfIAijYj9UYAEBcvR+c9fET4=;
 b=Mo11dpK/BoKb19uGcbNC2uSHGI+YLCqCMxiN/d6PrafKIf2HSdG/Zrjs29yzOsCsLudEAdegcbjoTN9l94xbniUVxzQLPYTltahur/l25zmC9DgwWCrOXO1L2ggF7JzrTzAPi2VlAXPeZ3lJspc6XlQSYp/RZ1iSlCEjsakLXJ0=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Thu, 27 Apr 2023 12:42:08 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 12:42:08 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <michael@walle.cc>
CC:     <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>
Subject: Re: [PATCH v10 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
Thread-Topic: [PATCH v10 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
Thread-Index: AQHZdF1lwSMif+NWV0SQ+2SNQpgE+K87p8cAgAN7HgA=
Date:   Thu, 27 Apr 2023 12:42:07 +0000
Message-ID: <50d10f649ac1314f07d53db89fe76c39e2764486.camel@microchip.com>
References: <20230421142643.1784-1-vaibhaavram.tl@microchip.com>
         <20230421142643.1784-2-vaibhaavram.tl@microchip.com>
         <2265a7467850190ec99ac9ab0aaa7905@walle.cc>
In-Reply-To: <2265a7467850190ec99ac9ab0aaa7905@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|SJ0PR11MB5815:EE_
x-ms-office365-filtering-correlation-id: 81fef849-f24a-45e8-ca37-08db471cd022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LS/ccuso0fv8Nbi8O6hKNaSzkx+FKETKF89C/iIHvBtLo3aa7j8t0i/HYF65EwZzZdVj1Y4JrVQmdiva8rylzvrM/DcYEJNOJVc8C/p+vIX3QRPpt6t72uNcjQFe6bp4Xmg7NCOk4mbkZtTW2dRoU4SCwkdXtnr3fl7HgmN2Y0Ngw0/h2MPD0+ZmFWSxJPaB/0VO4VrRbzyRTLGchAal2FHbmqDZznFA3PD7MBeNupacvWnu/1h0VE3YRvq557i8/HxmlI9mQ96j/vm5tfPyQmDcSnH8uhZjz5jW4TCq2d94kIRZ0EYjm8MmDwdMSVaNaKtazA2RMT6OICfSUMo6nCUPf+zCabMKisgNz1iJwTBLYb6mqNqhVUPm1ggOfMr2A5YpHwQDtdCgDjVnN/b+9rjw5aUn0L0GiLtCMOPtfEZG3IAqpqd2T+AZSke3QzxDFpS4zMs4tQHOZvPujAwX2sYtSrwIdq+G7J5TUgJQUeCJI2sHuUPVH+/QMOO1dDJPDFdIO7e5f8dRd517KV3xko/JtjflzLzsHv0Gz+zpnZmI7fsmCt902B2gfS3ZmfFO4KBQgPznmq5Rtl7FXMa94KOAk0iceL6wuMzXDJjge5S0lLX4WOJTDC3ef/C+PZ8j6ox5bMxXAN8OEU+aAMf+dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(54906003)(36756003)(186003)(6486002)(26005)(316002)(6512007)(71200400001)(66446008)(64756008)(66476007)(66556008)(6506007)(66946007)(83380400001)(6916009)(4326008)(76116006)(91956017)(2906002)(122000001)(41300700001)(38100700002)(8676002)(38070700005)(5660300002)(2616005)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajU4bm9OVVhVR2tvditmbDdybDl2SnJJeHRyQW9lSW9QaDFVT1Jta3c0WXZQ?=
 =?utf-8?B?SmZ6dFhPUDY3bTJEQWduS0lLZlVoenUvVlozWkIvU29vY1d0Mk1KeHlSVzBy?=
 =?utf-8?B?V3h2MEl4UFA3ZzFJVS9xeDZFVndRMnNYZGdIRlVyNmJtaFJNZlJkWE1ldEJU?=
 =?utf-8?B?dW1DLzg0VDJGMW5VcmtUeXBaVWNHbElwdVdKNzdmV3VlL3pyQjFkTmZaVnho?=
 =?utf-8?B?RnN0YzVYZUhJQmttelM1V0p4dkVnMmVJMEFwL3UzM2tQY21xNWxuS0NZWTM1?=
 =?utf-8?B?ZkJlbzNRR1pUVHFzRkZsSk9SSUROaExzM2diTmNwbmtxdUp3bGNoZXZVbTdt?=
 =?utf-8?B?dVRBQmpIbDdXRGZZVk9KL2F4TUd2V0RlSnJ0QklaVUtXOGJFR0ZhSHJjUzBU?=
 =?utf-8?B?U252WEVJTEhQVUk0R0NVRm8wTHlDdkppdFlEeUJScCtVNU43NjlaaEVZbjVw?=
 =?utf-8?B?R1IrMXBxQjNoQy96VzZVNWRHWEU3QWFZRmpXYVp0SXlMS3J3WlZZUWJ0bXZj?=
 =?utf-8?B?M1hRRmxGWmNjM2pSUStYbDcydUJmY0Z3Yy9jekhrcnFSMmlHdXRQQTZwZGtE?=
 =?utf-8?B?YTZjWVFRSlJmeGlUVk5pSUNZM2R2a0t0VHZWSlVjUG1sVFFEeTFvMmVydkdO?=
 =?utf-8?B?aHZNMXZ4cE54VmdMdzhCMUVLWDcxVFJ2am1RNUc2cXBIZmgySnVNNzJEV2Rt?=
 =?utf-8?B?NENqeDJCZlhoMnNMUHpYZFpPeHJ6ODhHYUVSNUtyS0swNkpQUUVwdHFoOGdo?=
 =?utf-8?B?Z1psUVZhYlVWUHFlakdyMGRvZS8rS1FkVkNLRXFiWEEwYkNrKzBFSldSaE53?=
 =?utf-8?B?di9OaVZDeTVja25ZU0N3NUpScVNidDkwQXdyd0ZOSWo4amtONGt4VWY1R0Rw?=
 =?utf-8?B?WUZld0ZlMHExZU0xZ2Jlc0ZZUzZlbHRObHV2aXlqTkZNYWJvS3h1U2FNZFZx?=
 =?utf-8?B?VDgyejg2WHpzdEF6cTFGdlI1NWtONExCQ1c2NHVMZ01NZWlYUVpZSWJ6K2NB?=
 =?utf-8?B?YVpVZlFCNlRKYWZkeHk3dTNuMEliT1Z4dWswR04wbGRMUTlUeERvdXVDYzhL?=
 =?utf-8?B?a05DZ0Z4STBhVzh3c05HUWRDQzBoQmdzM0EycFZSZ1I2UFJ3YkJOcWJOS2pS?=
 =?utf-8?B?YlFWTDBYb3drU1B5Y3NxdXdrNEhpV09iTVZjd1hydUpOc3pXU0YrUWFXbURv?=
 =?utf-8?B?M3grZkd6VCtOSGxYZnJDbHNhSGdGRWk5OXVBQlVSK0s0R0hocG9ubHIyYjd1?=
 =?utf-8?B?eldvUnhuM0lVQ0tCYUdFNFFCZTBhSmV6aE56MVVqcWlBZzhVajVxelE2M1BC?=
 =?utf-8?B?WnhwNHZVYmEwZ2Y1YUxaY1hUWUI5TlNVaXlBQ3Jua0pMQzk3RFd2M0pCN254?=
 =?utf-8?B?dzFWeng0SWF1VGdVYzlaOHJ4Rk5HZ0JNTzg0Uk11Skl4OTV2NEhKOUx4Umlv?=
 =?utf-8?B?a1VzR29PNiswVUhjUm9uS1k2S1RpWkdqODBRU3ZjS1FIaWxPZ1FnOGRWdDcy?=
 =?utf-8?B?RjNUbmdJQjF4VEFrMkJJckU0QWppaEYwKzB5VzM3NWg2ZmdjZmR3UDlJaXhi?=
 =?utf-8?B?TThHemR6bWlyM25hR2p1U0Y0djE2ZkNJRk1UdTMrUWZtem05eDJQZ1BEOEVh?=
 =?utf-8?B?ODNpNUpGdnNJNXVhWUtVRmJNWWRnd1hBTVRmWTQwbHVYU0hRUHRwTFhXZThC?=
 =?utf-8?B?TGJ0REJaQTU0d0tIMkNoTU5CL0ZBMzBXc2R4bjJQTlFWMytDRWNWSHFCRFVk?=
 =?utf-8?B?S2RzRUJURzl4d3k2elhQeFRMY211V3dyUjM5N050Q1A3WVBlcDRaUGJ4NWVK?=
 =?utf-8?B?UzQ4REVndjFKNjZPc01jeUF4aW5zR0MzNFAxVWwvVTJxVVhkeG1ES251cEhH?=
 =?utf-8?B?ZlJJSTVHd3BtY0pMNkF0VjBrVU9xa3FxLzdMRWY5bUZSazNZbElIYnFwNnZE?=
 =?utf-8?B?RWhKZnZteER2djV4ZUxlWWVrVTJIMko2ek53YnlycU5SbStTUnRORlRzYzFU?=
 =?utf-8?B?U0FxN2x0K1RtY3FpeTRFSnJMVkxzK1ZBZlBYNHZ0eFd5U2FkckxQeXBaYkxJ?=
 =?utf-8?B?T0phQ0Uyd1B1Umx3N0ZzYTRKVkladTlqR2RRSXpvNHo5eS9FbDdXbHZwNVpH?=
 =?utf-8?B?bEJCQVJacjVwSStZRUhNZWJqTE82ZzArYlU2VDI2TUhDbG1hUmI5bXhzakY0?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5152D9E10CB5A34C83E78E57F8D9962E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fef849-f24a-45e8-ca37-08db471cd022
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 12:42:07.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhS8x4VmWAcviDZ9Wt3vuBaE4+JBHv5/jSeK6VfEydrfDr0vqIoBiicxNSPdsXes41IcPYnMQQqSCZL2Khp11+Kryni4AwYfx7hiXGP21v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDA5OjMzICswMjAwLCBNaWNoYWVsIFdhbGxlIHdyb3RlOgo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gSGksCj4gCj4gPiArc3Rh
dGljIGludCBwY2kxeHh4eF9vdHBfcmVhZCh2b2lkICpwcml2X3QsIHVuc2lnbmVkIGludCBvZmYs
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dm9pZCAqYnVmX3QsIHNpemVfdCBjb3VudCkKPiA+ICt7Cj4gPiArwqDCoMKgwqAgc3RydWN0IHBj
aTF4eHh4X290cF9lZXByb21fZGV2aWNlICpwcml2ID0gcHJpdl90Owo+ID4gK8KgwqDCoMKgIHZv
aWQgX19pb21lbSAqcmIgPSBwcml2LT5yZWdfYmFzZTsKPiA+ICvCoMKgwqDCoCBjaGFyICpidWYg
PSBidWZfdDsKPiA+ICvCoMKgwqDCoCB1MzIgcmVndmFsOwo+ID4gK8KgwqDCoMKgIHUzMiBieXRl
Owo+ID4gK8KgwqDCoMKgIGludCByZXQ7Cj4gPiArwqDCoMKgwqAgdTggZGF0YTsKPiA+ICsKPiA+
ICvCoMKgwqDCoCBpZiAob2ZmID49IHByaXYtPm52bWVtX2NvbmZpZ19vdHAuc2l6ZSkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FRkFVTFQ7Cj4gPiArCj4gPiArwqDCoMKg
wqAgaWYgKChvZmYgKyBjb3VudCkgPiBwcml2LT5udm1lbV9jb25maWdfb3RwLnNpemUpCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50ID0gcHJpdi0+bnZtZW1fY29uZmlnX290cC5z
aXplIC0gb2ZmOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHJldCA9IHNldF9zeXNfbG9jayhwcml2KTsK
PiA+ICvCoMKgwqDCoCBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgIGZvciAoYnl0ZSA9IDA7IGJ5dGUgPCBjb3VudDsg
Ynl0ZSsrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG90cF9kZXZpY2Vfc2V0X2Fk
ZHJlc3MocHJpdiwgKHUxNikob2ZmICsgYnl0ZSkpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkYXRhID0gcmVhZGwocmIgKwo+ID4gTU1BUF9PVFBfT0ZGU0VUKE9UUF9GVU5DX0NNRF9P
RkZTRVQpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsKGRhdGEgfCBPVFBf
RlVOQ19SRF9CSVQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmIgKyBNTUFQX09UUF9PRkZTRVQoT1RQX0ZVTkNfQ01EX09GRlNFVCkpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkYXRhID0gcmVhZGwocmIgKwo+ID4gTU1BUF9PVFBfT0ZGU0VUKE9U
UF9DTURfR09fT0ZGU0VUKSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRlbChk
YXRhIHwgT1RQX0NNRF9HT19CSVQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmIgKyBNTUFQX09UUF9PRkZTRVQoT1RQX0NNRF9HT19PRkZTRVQpKTsKPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQocmVh
ZGwsIHJlZ3ZhbCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShyZWd2YWwgJgo+ID4gT1RQX1NUQVRV
U19CVVNZX0JJVCksCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNUQVRVU19SRUFEX0RFTEFZX1VTLAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBTVEFUVVNfUkVBRF9USU1FT1VUX1VTLCB0cnVlLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByYiArCj4gPiBNTUFQX09UUF9PRkZTRVQoT1RQX1NUQVRVU19PRkZTRVQp
KTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YSA9IHJlYWRsKHJiICsK
PiA+IE1NQVBfT1RQX09GRlNFVChPVFBfUEFTU19GQUlMX09GRlNFVCkpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCB8fCBkYXRhICYgT1RQX0ZBSUxfQklUKQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU87Cj4g
Cj4gRG9uJ3QgeW91IG5lZWQgdG8gcmVsZWFzZSB0aGUgbG9jaz8KWWVzLCByZWxlYXNlX3N5c19s
b2NrIHNob3VsZCBiZSBkb25lLiBXaWxsIGZpeCBpbiBuZXh0IHZlcnNpb24gb2YgcGF0Y2gKPiAK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmW2J5dGVdID0gcmVhZGwocmIg
Kwo+ID4gTU1BUF9PVFBfT0ZGU0VUKE9UUF9SRF9EQVRBX09GRlNFVCkpOwo+ID4gK8KgwqDCoMKg
IH0KPiA+ICvCoMKgwqDCoCByZWxlYXNlX3N5c19sb2NrKHByaXYpOwo+ID4gKwo+ID4gK8KgwqDC
oMKgIHJldHVybiBieXRlOwo+ID4gK30KPiAKCg==
