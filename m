Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A96CD063
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC2C4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2C4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:56:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26D62D75
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 19:55:58 -0700 (PDT)
X-UUID: 38e0de7ccddd11eda9a90f0bb45854f4-20230329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=C2883PnuNPpCTsPs9t8wQt7THVcXcbjvh2GOL3JE5K4=;
        b=IIk8uSjWDmLA+URQjCuYQOdY5+xBSSx6QK+9FazotJeMcdYRjJHEqkSEPCQsaiYtdTOfyNKQR0eNDDneemaperJuxsmJkJzD6I064Uv0bxenoS5M5AEUiIEw17yxIU+KyX9GDHECqLnAve3y/aD9Ldove1PJkvRuBw2TywxGHt8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f8f468ce-6dc1-4c07-843e-5f8ba3681711,IP:0,U
        RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-20
X-CID-META: VersionHash:120426c,CLOUDID:f602adb4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 38e0de7ccddd11eda9a90f0bb45854f4-20230329
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <qun-wei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1609519517; Wed, 29 Mar 2023 10:55:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 29 Mar 2023 10:55:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 29 Mar 2023 10:55:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVKOErt37BQNM9lBGfzAcW99kTZ2+AN8pKnasSnEW8/VD79PUJg+vXtHj5e0vWSSgrTqMVpGi+X2OixzCCtm3Udq5Hkr9AFF1ho94atPdkTy6YAL+yqq/PZiAQidcJ0IpA+Sa9R5ovOvEOj9cRQ/0fVH7qn7UttvDQD/1IU8vXb2phIxaVksMDvM5MG/TFdZ2Pa/j0RfQmhrAw5j7kQEKSApkmrhicNWF6ojZSUtfvfXksiNn5ojI2ecjevrdBM0umS6WLjfMBp86+axPDEAj23GPHHayyoPHFywqXL6YUSpdAwI2jlhDl8UcOo/LiFA9Kv91TEkFwJKp/UWr/8uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2883PnuNPpCTsPs9t8wQt7THVcXcbjvh2GOL3JE5K4=;
 b=ErO3QqMaciq/oiEaKcLchYFkiNwIvG0tJNcG57RjuQLO5cKta8ZH2BFtVwNBZ9+1TN0eY6UoWeD0+EQCmp71rsZ59K/cmo5tDaWEIQtbnFCiF8SoGpAbY2bBbxC9XoBkyflu5WvqszCEHPCDnq6P1Pt+6T+j+cBslrUwu+aJIe0hiOav20avaQ4JwLLuEju/M6j4DKa1VGHvVCJxShVHx0q7uNWoHQ0wFLpAoDa7eIDwnFZ6SChB9BUnGGECBApH8S7qAb1ESF/XQ+BpYMOUut5d4APBbVy6qqu7rzd07Gmz5xoqGcvI9/IoGnt+WsfeSCY9FyLK+jyKMkuauOdGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2883PnuNPpCTsPs9t8wQt7THVcXcbjvh2GOL3JE5K4=;
 b=JoYL0ICGazfTNis5eg9bsm3BRSHszTFQJZmLOGfi4jRhlyUegzgHhyMyRmnR/U1MWhXgyFBw+XJ2MzdyemtpTZ3dTP4Y5ZONzzc6Ui4FVyv3q19nAroRgI188QLIvL94tIwjEIY8/UrZnz+oFCCFaT/8F1/EAh7Tj0jR3fNbgTE=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by PSAPR03MB5526.apcprd03.prod.outlook.com (2603:1096:301:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 02:55:50 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::4e8a:b69:30c5:9cf5]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::4e8a:b69:30c5:9cf5%4]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 02:55:50 +0000
From:   =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [BUG] Usersapce MTE error with allocation tag 0 when low on memory
Thread-Topic: [BUG] Usersapce MTE error with allocation tag 0 when low on
 memory
Thread-Index: AQHZYen3s5qS35hNike4zSKmU9bvyQ==
Date:   Wed, 29 Mar 2023 02:55:49 +0000
Message-ID: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|PSAPR03MB5526:EE_
x-ms-office365-filtering-correlation-id: 8fa764cd-2032-4d50-c7c1-08db30011a74
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RMoye2HNdHoo3TbC4UDLCrr5zAtANZ+gDTc1bYgzgoLquvY1fNbwjOUCbDQRSjf1qloHKJ0mE9qFnQZy0sDlFSlOjbMYk1Nc/jCuQ8tbvWAwJc068I2wCf+kN2n2UsqB7BOEotlxdgsj+T2/jfeBvDe9sXJm57lIw3Wxv1UZwgdGA9kFakblrZUFmSVGeXharPbWoLIGQ+QDe3PYxoaeG6+Lpl6wRqaZKeIJ7Zu1W9zpIGO4NiT19KJS4PzFINpfjpzoSUV3Ij6JcBb5GSQYY9XzdNeFJdB90eZAoxenYHBTLe2IVP/IUE0KDJGNbEOAxuPQJBeiBIQMozUAuxqUA4XQvasJbzdn8B/1nGliQHa02kLgPivfUwbvBsPeIBIAeVWDGu86IindHlj9dPXevpCjp03qEMM1VyVP6EPsiHqXzQpC8qseIK5GacQ+rl4euByKWO4UQhTYyWkSrDQqT73qYbgKz7KDjn2L3OHv2A688v/r9qLCYbaBlTgcga+F5sZOgDTukE6vFXUtslToRh2JeiC0QrBCOv5yPWlLz4tigNFcJ6KsCC4PiAG8ehZW67Er1xMlLAQVL22D6DsJucOAE92lnBSog0rYSR7fKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(5660300002)(41300700001)(66446008)(66476007)(66556008)(64756008)(4326008)(66946007)(8676002)(91956017)(76116006)(8936002)(6486002)(54906003)(110136005)(316002)(2906002)(38100700002)(85182001)(36756003)(966005)(478600001)(71200400001)(83380400001)(186003)(86362001)(38070700005)(2616005)(26005)(6506007)(6512007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1V1dmR4ZFJSakFnSEhNbUcwNVJVWmljMjVoOTNFOFpRZXlHY05leWJzdFp4?=
 =?utf-8?B?WjYvUjRsOTNGNW01ME5mKzhnbVRSdTRlVmdVejV3VW9RdCtBZlo1dDUxQ0Ux?=
 =?utf-8?B?VDBZRTI0eGJyTlRXNGZHSmJLWWFuWGRZdnZiTVBUbzhzWjRwTEdkbWNBd29l?=
 =?utf-8?B?V0FBVFVTcDN0ck1FUkszckJ2N05HemR6dnczQlNzTUhiSmpQWk4xMHFSSEx3?=
 =?utf-8?B?T00xYzZFMnplQkFsVERHVlQ4Tklnb1JpbzVUM1JNUlFkdzBjWld3aFBvbEZ2?=
 =?utf-8?B?NUFNM0hBRGpTaTh4SVhUT3FzT1R6a09Ca1cyMmtCbmloVHl6RGNWQUJDRGUr?=
 =?utf-8?B?NCtsclFmV3J6RHRWZ0ZmSlFtU08yTHgvc2RMeTNCUHdTT1I0SUVYUG52VWFJ?=
 =?utf-8?B?VUk0YytCdVRQc3RZK09nbE5kMVRCV01PYzRCSXZPYjdtK0dLQUY3VkxtSWxB?=
 =?utf-8?B?UVNCRmpTSFFUeVdKclNPOGpnQlZBS3h3UGdXY3ZlaGlyM25Dd0h2ZnNzVU5k?=
 =?utf-8?B?RlVqYlZETXE0eXVQaWdpS1BHNnJiOEF2Q2hFM3N2cDRLcWRwRnNxamlLL1FQ?=
 =?utf-8?B?ZFVYUWFiYlo5MEJ4RXdwSTR3OU5iNFJ2UkVJeC9MRjZkVmdmTlVjQStibWJL?=
 =?utf-8?B?azE5aEx4b29vTzNyMFFXTmQ1VnRRbk1hSFBZOEhZWXZiNFhEdWdDNGIvTUpM?=
 =?utf-8?B?UVBPYk10RjUxYmZVTFg3WmVvdmVXaXI4Z013SmlpaC9ldTR3Yy9tYy9NL0Vv?=
 =?utf-8?B?cEhZeEREQkdBUWp1cWVCcFNxb0E4ZGdGQzdZK3lwc3ZpcVIwcFFDaWxZUUNi?=
 =?utf-8?B?bkgrdUJLMjNzZC9EMlFFZFk4VEl3Zi96VXM2VkZZSERDOHRsTVBLZVlRWHdJ?=
 =?utf-8?B?akRMOTZmK2JZekR4T2s2WnJoYW5tMkwxLytvVlF2Q0l4NkUxM2ZWMUYxa3dN?=
 =?utf-8?B?YnFZUzlnancwb3RDN1JTK2duNU4xZTBkV0JMTzRoQ0FINyszV0EvTUZ1aFVr?=
 =?utf-8?B?TERuZ2dOY1NVTDYyNkFVSFkvemIyUy9aVDJYU0NWbloxcWlIbmZSUGc5RUN0?=
 =?utf-8?B?eGZ3WHZiWnRreXcrUkx0cnVUOU1xR2RiMTIza2UyOFFja3hCNUlPZHYrMFhv?=
 =?utf-8?B?SVBJWDI2Wk5xNGxJcHNHcG42SCtVSnhiQXdpODR3TDA2RFFVUHd2TEVxbXQ5?=
 =?utf-8?B?TVdrWnVPWDZSQzlickRqOXRzR3VTVmNCbWlmNnFJNHlGUHFqL2JXQ0hJLzNU?=
 =?utf-8?B?TlVDTEhUYjVia1dBOGZoMHBIWjMwQWIxTy9TTkZES29ZRkZxdS96ZGs0S0Fh?=
 =?utf-8?B?SXE2UDJCbDlPWXdUUzQ0WDFMczhZUzJGZmo2ZFpyZVJHekJmbGRpaW1xak9L?=
 =?utf-8?B?QmYzL1dIVk1jZzcveXlDUlBWMTI1S094TlQvckpJRXIzTGdFZnBVRm1iTkNt?=
 =?utf-8?B?UFBaWjFDVDVXb1Q0T1hDakZMZDlraGpNRTFFNE5wcGVEMGUzUWQ1YWJGZ2ll?=
 =?utf-8?B?dWxyRHZwVWVLSlFsQU8yQmVYSlZIRkE4cUxwWVJuVkxQOXV4TWZGMUNseXV6?=
 =?utf-8?B?Sk05Ukk0cWhKWGkwRkVLZjlML1hBdlQvdDAwOWVvQTk3VTJZcUd6L0EzWEVN?=
 =?utf-8?B?YXI0dWVGeG50d0FFY0ZlTXNhWmVrYWpwOGZvRnptSGhRMjk3eVVlSjk4L0xz?=
 =?utf-8?B?K3ZxVld2bDdwcmI4NWViaWxuV3JtTi81RzltckxMcnZHa2hmaFlpQUhqV2dF?=
 =?utf-8?B?dXJsK1J6Z1lveXpVMTdZeFQ1aWE5bHZKcXhEeWdJNGpXNlR4c1ZEMVZJTWpT?=
 =?utf-8?B?MDlYVXpDS0JFSzlKSklSajlLdWsyZExjMGRuaWxwaithUStKblhRUlVYcjRy?=
 =?utf-8?B?ZlZZUWFqRmlZUlJzNXFJTk51VWl0bEJDTEcwdEJzSFh3bGZuTjdMb0Y4MEt3?=
 =?utf-8?B?Tyt6eDIyWUgrWkRSWjl3WFNxRFZYY1FJN1VFaXN0Q1JTSWRwU003UGJ3QkRW?=
 =?utf-8?B?Q25QS0kxOHJLSDFLUzIzdHFZN3RQMENMNi92QjhBZ1RicVlrelFNQTVMTHRi?=
 =?utf-8?B?bTlGTXBzLytPeU9GV2tIdnEzTDRKOHN3aEkzd3VLOU9PWWlrWlFRYlk5VVZ2?=
 =?utf-8?B?a3RRem5DWDVZYUE0c0xuaElUc1pIblo5bHdZWFp5cjc5L1hLS29UT2hROTUz?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1871495C4C0AC842800F4BA76501EDE5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa764cd-2032-4d50-c7c1-08db30011a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 02:55:49.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnJPk6L4ikuldB/a261Y6+PoSQu9pMCrX/9PforaLernbFYp6vhKLCw00K3+TC5bZ8Pmrv4Ixd0dMU2c6ZZsYYhLUdwBNRGIf+6pCpYn81E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5526
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlIG1lZXQgdGhlIG1hc3MgTVRFIGVycm9ycyBoYXBwZW5lZCBpbiBBbmRyb2lkIFQg
d2l0aCBrZXJuZWwtNi4xLg0KDQpXaGVuIHRoZSBzeXN0ZW0gaXMgdW5kZXIgbWVtb3J5IHByZXNz
dXJlLCB0aGUgTVRFIG9mdGVuIHRyaWdnZXJzIHNvbWUNCmVycm9yIHJlcG9ydGluZyBpbiB1c2Vy
c3BhY2UuDQoNCkxpa2UgdGhlIHRvbWJzdG9uZSBiZWxvdywgdGhlcmUgYXJlIG1hbnkgcmVwb3J0
cyB3aXRoIHRoZSBhY2xsb2NhdGlvbg0KdGFncyBvZiAwOg0KDQpCdWlsZCBmaW5nZXJwcmludDoN
CidhbHBzL3ZleHRfazY4OTd2MV82NC9rNjg5N3YxXzY0OjEzL1RQMUEuMjIwNjI0LjAxNC9tcDJv
ZnAyMzp1c2VyZGVidWcvDQpkZXYta2V5cycNClJldmlzaW9uOiAnMCcNCkFCSTogJ2FybTY0Jw0K
VGltZXN0YW1wOiAyMDIzLTAzLTE0IDA2OjM5OjQwLjM0NDI1MTc0NCswODAwDQpQcm9jZXNzIHVw
dGltZTogMHMNCkNtZGxpbmU6IC92ZW5kb3IvYmluL2h3L2NhbWVyYWhhbHNlcnZlcg0KcGlkOiA5
ODgsIHRpZDogMTM5NSwgbmFtZTogYmluZGVyOjk4OF8zICA+Pj4NCi92ZW5kb3IvYmluL2h3L2Nh
bWVyYWhhbHNlcnZlciA8PDwNCnVpZDogMTA0Nw0KdGFnZ2VkX2FkZHJfY3RybDogMDAwMDAwMDAw
MDA3ZmZmMyAoUFJfVEFHR0VEX0FERFJfRU5BQkxFLA0KUFJfTVRFX1RDRl9TWU5DLCBtYXNrIDB4
ZmZmZSkNCnNpZ25hbCAxMSAoU0lHU0VHViksIGNvZGUgOSAoU0VHVl9NVEVTRVJSKSwgZmF1bHQg
YWRkcg0KMHgwZDAwMDA3NWYxZDhkN2YwDQogICAgeDAgIDAwMDAwMDc1MDE4ZDNmYjAgIHgxICAw
MDAwMDAwMGMwMzA2MjAxICB4MiAgMDAwMDAwNzUwMThkM2FlOCAgeA0KMyAgMDAwMDAwMDAwMDAw
NzIwYw0KICAgIHg0ICAwMDAwMDAwMDAwMDAwMDAwICB4NSAgMDAwMDAwMDAwMDAwMDAwMCAgeDYg
IDAwMDAwNjQyMDAwMDA0ZmUgIHgNCjcgIDAwMDAwNTQ2MDAwMDA2MzANCiAgICB4OCAgMDAwMDAw
MDBmZmZmZmZmMiAgeDkgIGIzNGExMDk0ZTdlMzNjM2YgIHgxMA0KMDAwMDAwNzUwMThkM2E4MCAg
eDExIDAwMDAwMDc1MDE4ZDNhNTANCiAgICB4MTIgZmZmZmZmODBmZmZmZmZkMCAgeDEzIDAwMDAw
NjFlMDAwMDA3MmMgIHgxNA0KMDAwMDAwMDAwMDAwMDAwNCAgeDE1IDAwMDAwMDAwMDAwMDAwMDAN
CiAgICB4MTYgMDAwMDAwNzdmMmRmY2Q3OCAgeDE3IDAwMDAwMDc3ZGEzYThmZjAgIHgxOA0KMDAw
MDAwNzUwMTFiYzAwMCAgeDE5IDBkMDAwMDc1ZjFkOGQ4OTgNCiAgICB4MjAgMGQwMDAwNzVmMWQ4
ZDdmMCAgeDIxIDBkMDAwMDc1ZjFkOGQ5MTAgIHgyMg0KMDAwMDAwMDAwMDAwMDAwMCAgeDIzIDAw
MDAwMDAwZmZmZmZmZjcNCiAgICB4MjQgMDAwMDAwNzUwMThkNDAwMCAgeDI1IDAwMDAwMDAwMDAw
MDAwMDAgIHgyNg0KMDAwMDAwNzUwMThkM2ZmOCAgeDI3IDAwMDAwMDAwMDAwZmMwMDANCiAgICB4
MjggMDAwMDAwMDAwMDBmZTAwMCAgeDI5IDAwMDAwMDc1MDE4ZDNiMjANCiAgICBsciAgMDAwMDAw
NzdmMmQ5ZjE2NCAgc3AgIDAwMDAwMDc1MDE4ZDNhZDAgIHBjICAwMDAwMDA3N2YyZDlmMTM0ICBw
DQpzdCAwMDAwMDAwMDgwMDAxMDAwDQoNCmJhY2t0cmFjZToNCiAgICAgICMwMCBwYyAwMDAwMDAw
MDAwMDVkMTM0ICAvc3lzdGVtL2xpYjY0L2xpYmJpbmRlci5zbw0KKGFuZHJvaWQ6OklQQ1RocmVh
ZFN0YXRlOjp0YWxrV2l0aERyaXZlcihib29sKSsyNDQpIChCdWlsZElkOg0KOGI1NjEyMjU5ZTRh
NDI1MjFjNDMwNDU2ZWM1OTM5YzcpDQogICAgICAjMDEgcGMgMDAwMDAwMDAwMDA1ZDQ0OCAgL3N5
c3RlbS9saWI2NC9saWJiaW5kZXIuc28NCihhbmRyb2lkOjpJUENUaHJlYWRTdGF0ZTo6Z2V0QW5k
RXhlY3V0ZUNvbW1hbmQoKSsyNCkgKEJ1aWxkSWQ6DQo4YjU2MTIyNTllNGE0MjUyMWM0MzA0NTZl
YzU5MzljNykNCiAgICAgICMwMiBwYyAwMDAwMDAwMDAwMDVkZDY0ICAvc3lzdGVtL2xpYjY0L2xp
YmJpbmRlci5zbw0KKGFuZHJvaWQ6OklQQ1RocmVhZFN0YXRlOjpqb2luVGhyZWFkUG9vbChib29s
KSs2OCkgKEJ1aWxkSWQ6DQo4YjU2MTIyNTllNGE0MjUyMWM0MzA0NTZlYzU5MzljNykNCiAgICAg
ICMwMyBwYyAwMDAwMDAwMDAwMDhkYmE4ICAvc3lzdGVtL2xpYjY0L2xpYmJpbmRlci5zbw0KKGFu
ZHJvaWQ6OlBvb2xUaHJlYWQ6OnRocmVhZExvb3AoKSsyNCkgKEJ1aWxkSWQ6DQo4YjU2MTIyNTll
NGE0MjUyMWM0MzA0NTZlYzU5MzljNykNCiAgICAgICMwNCBwYyAwMDAwMDAwMDAwMDEzNDQwICAv
c3lzdGVtL2xpYjY0L2xpYnV0aWxzLnNvDQooYW5kcm9pZDo6VGhyZWFkOjpfdGhyZWFkTG9vcCh2
b2lkKikrNDE2KSAoQnVpbGRJZDoNCjEwYWFjNWQ0YTY3MWU0MTEwYmMwMGM5YjY5ZDgzZDhhKQ0K
ICAgICAgIzA1IHBjDQowMDAwMDAwMDAwMGMxNGNjICAvYXBleC9jb20uYW5kcm9pZC5ydW50aW1l
L2xpYjY0L2Jpb25pYy9saWJjLnNvDQooX19wdGhyZWFkX3N0YXJ0KHZvaWQqKSsyMDQpIChCdWls
ZElkOg0KNzE4ZWNjMDQ3NTNiNTE5YjBmNjI4OWE3YTJmY2YxMTcpDQogICAgICAjMDYgcGMNCjAw
MDAwMDAwMDAwNTQ5MzAgIC9hcGV4L2NvbS5hbmRyb2lkLnJ1bnRpbWUvbGliNjQvYmlvbmljL2xp
YmMuc28NCihfX3N0YXJ0X3RocmVhZCs2NCkgKEJ1aWxkSWQ6IDcxOGVjYzA0NzUzYjUxOWIwZjYy
ODlhN2EyZmNmMTE3KQ0KDQpNZW1vcnkgdGFncyBhcm91bmQgdGhlIGZhdWx0IGFkZHJlc3MgKDB4
ZDAwMDA3NWYxZDhkN2YwKSwgb25lIHRhZyBwZXINCjE2IGJ5dGVzOg0KICAgICAgMHg3NWYxZDhj
ZjAwOiAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwDQogICAg
ICAweDc1ZjFkOGQwMDA6IDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAg
IDAgIDANCiAgICAgIDB4NzVmMWQ4ZDEwMDogMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAg
MCAgMCAgMCAgMCAgMCAgMA0KICAgICAgMHg3NWYxZDhkMjAwOiAwICAwICAwICAwICAwICAwICAw
ICAwICAwICAwICAwICAwICAwICAwICAwICAwDQogICAgICAweDc1ZjFkOGQzMDA6IDAgIDAgIDAg
IDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDANCiAgICAgIDB4NzVmMWQ4ZDQw
MDogMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMA0KICAgICAg
MHg3NWYxZDhkNTAwOiAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAw
ICAwDQogICAgICAweDc1ZjFkOGQ2MDA6IDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAg
IDAgIDAgIDAgIDAgIDANCiAgICA9PjB4NzVmMWQ4ZDcwMDogMCAgMCAgMCAgMCAgMCAgMCAgMCAg
MCAgMCAgMCAgMCAgMCAgMCAgMCAgMCBbMF0NCiAgICAgIDB4NzVmMWQ4ZDgwMDogMCAgMCAgMCAg
MCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMA0KICAgICAgMHg3NWYxZDhkOTAw
OiAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwICAwDQogICAgICAw
eDc1ZjFkOGRhMDA6IDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAg
IDANCiAgICAgIDB4NzVmMWQ4ZGIwMDogMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAg
MCAgMCAgMCAgMCAgMA0KICAgICAgMHg3NWYxZDhkYzAwOiAwICAwICAwICAwICAwICAwICAwICAw
ICAwICAwICAwICAwICAwICAwICAwICAwDQogICAgICAweDc1ZjFkOGRkMDA6IDAgIDAgIDAgIDAg
IDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDAgIDANCiAgICAgIDB4NzVmMWQ4ZGUwMDog
MCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMCAgMA0KDQpBbHNvIGhh
cHBlbnMgaW4gY29yZWR1bXAuDQoNClRoaXMgcHJvYmxlbSBvbmx5IG9jY3VycyB3aGVuIFpSQU0g
aXMgZW5hYmxlZCwgc28gd2UgdGhpbmsgdGhlcmUgYXJlDQpzb21lIGlzc3VlcyByZWdhcmRpbmcg
c3dhcCBpbi9vdXQuDQoNCkhhdmluZyBjb21wYXJlZCB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiBL
ZXJuZWwtNS4xNSBhbmQgS2VybmVsLTYuMSwNCldlIGZvdW5kIHRoZSBvcmRlciBvZiBzd2FwX2Zy
ZWUoKSBhbmQgc2V0X3B0ZV9hdCgpIGlzIGNoYW5nZWQgaW4NCmRvX3N3YXBfcGFnZSgpLg0KDQpX
aGVuIGZhdWx0IGluLCBkb19zd2FwX3BhZ2UoKSB3aWxsIGNhbGwgc3dhcF9mcmVlKCkgZmlyc3Q6
DQpkb19zd2FwX3BhZ2UoKSAtPiBzd2FwX2ZyZWUoKSAtPiBfX3N3YXBfZW50cnlfZnJlZSgpIC0+
DQpmcmVlX3N3YXBfc2xvdCgpIC0+IHN3YXBjYWNoZV9mcmVlX2VudHJpZXMoKSAtPiBzd2FwX2Vu
dHJ5X2ZyZWUoKSAtPg0Kc3dhcF9yYW5nZV9mcmVlKCkgLT4gYXJjaF9zd2FwX2ludmFsaWRhdGVf
cGFnZSgpIC0+DQptdGVfaW52YWxpZGF0ZV90YWdzX2FyZWEoKSAtPiAgbXRlX2ludmFsaWRhdGVf
dGFncygpIC0+IHhhX2VyYXNlKCkNCg0KYW5kIHRoZW4gY2FsbCBzZXRfcHRlX2F0KCk6DQpkb19z
d2FwX3BhZ2UoKSAtPiBzZXRfcHRlX2F0KCkgLT4gX19zZXRfcHRlX2F0KCkgLT4gbXRlX3N5bmNf
dGFncygpIC0+DQptdGVfc3luY19wYWdlX3RhZ3MoKSAtPiBtdGVfcmVzdG9yZV90YWdzKCkgLT4g
eGFfbG9hZCgpDQoNClRoaXMgbWVhbnMgdGhhdCB0aGUgc3dhcCBzbG90IGlzIGludmFsaWRhdGVk
IGJlZm9yZSBwdGUgbWFwcGluZywgYW5kDQp0aGlzIHdpbGwgY2F1c2UgdGhlIG10ZSB0YWcgaW4g
WEFycmF5IHRvIGJlIHJlbGVhc2VkIGJlZm9yZSB0YWcNCnJlc3RvcmUuDQoNCkFmdGVyIEkgbW92
ZWQgc3dhcF9mcmVlKCkgdG8gdGhlIG5leHQgbGluZSBvZiBzZXRfcHRlX2F0KCksIHRoZSBwcm9i
bGVtDQppcyBkaXNhcHBlYXJlZC4NCg0KV2Ugc3VzcGVjdCB0aGF0IHRoZSBmb2xsb3dpbmcgcGF0
Y2hlcywgd2hpY2ggaGF2ZSBjaGFuZ2VkIHRoZSBvcmRlciwgZG8NCm5vdCBjb25zaWRlciB0aGUg
bXRlIHRhZyByZXN0b3JpbmcgaW4gcGFnZSBmYXVsdCBmbG93Og0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjIwMTMxMTYyOTQwLjIxMDg0Ni01LWRhdmlkQHJlZGhhdC5jb20vDQoNCkFu
eSBzdWdnZXN0aW9uIGlzIGFwcHJlY2lhdGVkLg0KDQpUaGFuayB5b3UuDQo=
