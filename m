Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5FB648255
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLIMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:23:51 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75117075;
        Fri,  9 Dec 2022 04:23:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcyhGBXPEaoydnHaOo+YpDWiYO+nkRGUerVvKKED6xhDevHUxphwFCGkzB+7P7qHUAFR/nkopThjiw3FPujQhZQw5mp3yCbd2OylUqVMuC3pFuSB+UPOTk5F9M1cW8h2dHbff8ucnp7Ch3m8GWLs+8iHUl09eJH7iNNBI3UFmBs3FFVKdgEl13la25wMK4M+xUkaydwLIaseZ/6oNC/SPdyKafHGyriOOO8H/ALng4SghAf1WF5sdufyJVKDZXRy5zLshv2czF8MYCmrNacYnix88nFKESasxNzRsgqWtvnH+EVr6xqindhmfD+95+Vox39OrW4/IZM+uLX48MZGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLXgzl7WybghGwMOvWudOEtANkN5AdXC2ranCY3TH0I=;
 b=AJv1/Xwu91oBt6CkSvJj4QMnMH/+SQEkFP5zH+C3qUdoFq4S3Wlb0GyhushBu83rwFdVIu6Pi+h0NTdlV+OIyvBGDty+xI09Xn8HSfgCA7cEx6TO8MWhdteeshu/K3zL7aPuAiU6Fj6GVGjX/U+eQ7MtjlLXi79G73jx79Oj2ZV8jsG1pA1BD1KAUXedSOjH9ue6oy3llXNfsBmGhza4a4fnAsrunFA+DeZA1+saF37tMpKP48K4EMIkB7ThFq//tccMTDEXOP7/JfwyYHpjW4GWTC830CeWG/crcLnn81gJXuyhEwMjhCUdM6qccwUIPofhkLZfaY19TkVhMOZisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLXgzl7WybghGwMOvWudOEtANkN5AdXC2ranCY3TH0I=;
 b=ukMQBOckBdE3x4Oxv/MSyS+Rl0ln44FdV4HRhSVFu7M00B75Sjmnl1aO0CYrSe3dHUr/hDNqN1ZvqHk4eVWMIeKuuy+CADsaatxCJsvnA6BxOIm0RI4DVTA+txh9Qp0UVwsq0R7II1VEMqGwTQI44nx8LbQaiB4ouZV2LMjsZbJiXqz579CSeM1Dg7pUkVWtZDNJmbeBllQSpy55kel2hnBsndRyeLl7HfzUR9YASMaGY+y0NsqdElp/1ITXSQ3h+B1YZO3cN54c/ada66Bl2XgRlA9YdRWLAAcdAc+Ef4Ix+iBbBes5fM8VgMqtBrIlkezNIL7IKkkZ/vJdw3UDdg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB6866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 12:23:47 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9%2]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 12:23:47 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "manfred@colorfullife.com" <manfred@colorfullife.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Invalid locking pattern in Documentation/kernel-hacking/locking.rst?
Thread-Topic: Invalid locking pattern in
 Documentation/kernel-hacking/locking.rst?
Thread-Index: AQHZC8kWpSEVmt/EpU6oN/KdN6T7cw==
Date:   Fri, 9 Dec 2022 12:23:47 +0000
Message-ID: <442ecdf402f8e726f2be4ab19c7299d272e27c0b.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB6866:EE_
x-ms-office365-filtering-correlation-id: da29c54f-255a-4ff3-5eeb-08dad9e0388a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8oSs9ogSYiQjRuw3a6LQ+BrEqVXCysJYZGkiB4b/is9qlezynX9F2ENfHjGsvTuIuHLNhGAktEvGcl2mQ/o6UGv6Ub8hzO58bBXCMZ96YKOyNyT68XPTrZ7A4WvyjK+3BDqn2qH13qpnryskq1ZZTADQPdGwO3/rYPMD1ovtaDAhG7nNTuteYG1ZDN5ot2bDDbMARh90LE/sO8X0Ymfeck9UB9WHRqbcp+8//gowS2w+N3onO3RvoAhsf16+SuHN32X3eyC//yeYokMVDprHt0taUw2bjlcY11W4Dkp1txJWRKRpSyV+9Gioeg7W3qxVapk7LW9i1dm8vFhm0Xne7xW0kxeVpu6xxSh2RJJo3zzCM3vjP0yDbtkOs+/MytpHtJ6MeDljm2wk8h2OKNFqsRZdeGTl/Gup0YBskzPOMKch5mTPTdhlMzwzNfa+JTZ1JLfox3WRlDVtJgmTQnKHetQdV298IuQG3LHmpP05OCD/5VJSLhNZDRgp5pWa9Pbebz1qhVvYSRbC7vN5DXq3mEd2YkboiLyrA/soNW7tEzMEfss4/WqYXURrJwK3/1NKzcZCIPgFtaWpXT0INxlmIzLSXOF82YWA9ksYXlUDR87KCQtVKh0WRzeueJjXBOQbEckmMwzv+AneW/IlQN5ns0/CcaLbWe8WqsjRf20Iwe0tdHF7TqcXBzOx1gViH2rFL+9l+0LwdiY8XJqXrJStWlDyNU7H0wlfU2BjZi3ESBpZPKhmQ06YCTbBHiMu9JAsI6B62x/UmVL4bmdqi1CUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(66946007)(478600001)(66446008)(64756008)(91956017)(66556008)(122000001)(66476007)(8676002)(4326008)(38100700002)(6486002)(82960400001)(2906002)(6512007)(110136005)(186003)(71200400001)(26005)(76116006)(83380400001)(86362001)(6506007)(38070700005)(36756003)(41300700001)(8936002)(5660300002)(15974865002)(4744005)(2616005)(316002)(55236004)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnhDREJDcEhCdklsOVhoUGRJS2p5cFB3ampXbmkvTnFKcnBTMkxmTkZtME9v?=
 =?utf-8?B?QnlvN01tdE1qMUhBbEpTZTY1MTdSaVNFQW1DcFBhSExkdjFUcmoxZFEvbWJC?=
 =?utf-8?B?MkI1M0U5djVrNVpHaDdGWjNJbFZEOEJvcnNZMzZIeUVPcURTckJpMkxZcitu?=
 =?utf-8?B?NDhZc0dpOVhxUDhzWVBacDZlcWVod2dTcDhFcUdZYTJrQTMxcFNEemU3emlP?=
 =?utf-8?B?K0N6Z2srWVl1N1ZVaWxCWmJHNzJLdmtiRWE2b1RLYUFab1gwWGlib3dSazU3?=
 =?utf-8?B?VVorMVlUUmNNaElRazJkNU9xUUZVemJPbFBUZ2Vmb20yRzl5eEJxSUwycStW?=
 =?utf-8?B?Uk1jbzBpR2FyL2g5YTg4enBJSWFZTzY4NWFtWGE5UG05SmEwclM1cHNoNTlO?=
 =?utf-8?B?d0hlOTNzTG5JUXQ0eSt0S2JDYXA3WmxXY09rZGVKTUMxU0NPYTJMR09iOHVU?=
 =?utf-8?B?UGMrSThsWm1kT1BaRmN2TTBNN2diNWVyKzViK01zQko2TUJjOXN2RUpROUdY?=
 =?utf-8?B?UTF3T01WV2tEUzhHb2cxQWhMbWVRWnUxK2RCODFaZ1JmWlFoODhMQWxra1hI?=
 =?utf-8?B?ZHhoeHNhOVVVY3h2UStHb25vclFPL1VjdDN0NDVUNXg5NDl4Vlpjdk5WUWVx?=
 =?utf-8?B?TklHb3JIZkxHbTJabGNhalhtZFBqVysyRG1lYXRSaDJmK01FU3N1YzlWc292?=
 =?utf-8?B?K1gvNithWmp4b0F5U0tDc2N5aEoyaTdVRlVWanlxd0dWOVh4V3o2Q3ozQi9G?=
 =?utf-8?B?czQyTURQMEdWb3Exbks3OE1lajJwNjRCbnBreEhEV2p6aG5uRjEwZ0pyQ3p4?=
 =?utf-8?B?dm84UUFYVmdPa3VWOTRzQjZNZFdqakM2NHdYK2J3NjFFdEQ3Q3FjR2tZR0s1?=
 =?utf-8?B?SlVEcFlORDhpY3J3WjZSeU52MDlIY015ZGE2a0hpdHRrN1IwbzJGWG9vdUFk?=
 =?utf-8?B?MXEyUnVndjFlV2dRTUg3b01abjN0blNBa3FwZlhKamF2bkFXaVdjeE1GREps?=
 =?utf-8?B?RUxyTThWWnBUclQ3Q0E1VWcvMjM0cVNHWi9hTFAwVllIT1FOVnJDc3d4SVFm?=
 =?utf-8?B?ekhJUlUybFljQmFoZWJVK0h3TmNyMUs5QVJRRm55ZDFVeWp0aEFqeFBXY2ky?=
 =?utf-8?B?YjNlT0Rkclh5MzJDVlN2WWl3NytVeUtzeC9zR3l6NldzNlhBMnljTUlFa1RS?=
 =?utf-8?B?WG80QkwzSlIwUDMvaEhUb1FqTm9nK0xOb2FydEdWU3djRFI0VHV0cW1IdGtl?=
 =?utf-8?B?YUV0TnhRR1UyODA5bGFaeWdLUEZxL05SaTNJS3pnWi9tcHdaTmNFZHQxOGpW?=
 =?utf-8?B?bXhwN0lGaFlWZzZKeDkwZVI0U3YwS3RDVjJGVEI3emR6SG1LZVprTERoN25X?=
 =?utf-8?B?VGxnUGJFc1dlOFZMK0FDWUVLdktUUDlob0Njbm9EdGx6Qm9JcDJnU1BTUkNm?=
 =?utf-8?B?azMwbkQrMHljaThrVzZoWm5kQXBGZm0yWHhpWks2cjZySEVLR1d1bmpOZ081?=
 =?utf-8?B?ME9NTy9RMGEyWGF0eW9CR2FQOFl3ZjkrSHplRnY1VFpTdWJ0V2pvL2xlUFlW?=
 =?utf-8?B?Q1JibU9RbHhUVFJ0dUpXZ3IzYmJQeEhuK0prcUpUNy9JdXhCR1dMdHpMRXp0?=
 =?utf-8?B?aURHbS8vcUpUQm1Fdnk1eEorRk5RMmZ0dmNuVEtVeFIvaFR6WnFKY1JEMjQx?=
 =?utf-8?B?Q1pHUWV2UDJyQmJaNTd5U3pWaEkrRVBUWEVUM1ovWlErbmJjbzJqVFkwek9m?=
 =?utf-8?B?QjlIN3NuVzJob05lb3pTbnhPNzZXNDhkblEzZ1RPSkRGRFNiWWN5UGhtR0gx?=
 =?utf-8?B?QTkybmVJVmxZMDNaMzVKY0MvbVR5eUEzcGFWS1NWOUxKem5rOXpiaDJPNk1V?=
 =?utf-8?B?NEU5SHhnYW5KeTBFZXpUV0JUR0x5dC85TjliNkxCUEFYOERxOVpOandkTGlk?=
 =?utf-8?B?T2xIWTJVNElVdk5Jc1NQWDdJSUVqUklEMmZza1psbWUvSXh6eEp0eUJKTTFO?=
 =?utf-8?B?bitJemFFNnZxTVJIM1IwOGVSZG5CWnhZdEZxZEZpWVI0ZE5PVTR4ZnM4MFVa?=
 =?utf-8?B?dUUvZnJaOGhKbkNQd1RZV09TMWhsWVVtM1FySURQdVJaV1FDZHhjRGRFUFdR?=
 =?utf-8?B?TThHdk1hUWZwMWhhaHd0V1lQVzNBZHhUQXB6U2lEMTlIbEovRXVwSDVnbGsw?=
 =?utf-8?Q?Js5jbT1EljmeeuobPiX2RtE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10882FA944CB05439B5980E2F8BB621F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da29c54f-255a-4ff3-5eeb-08dad9e0388a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 12:23:47.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wvc7a/8Vao+tWxp6KYqzByL8mSqqnbTCN3NMA3hyzvVfb5mngvDZXl5OLGdOpPhULxP1IMj4zWMseNPhgaDgGUCTNc3DH0j+k8+asNnbg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6866
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBkb2N1bWVudGF0aW9uIG1haW50YWluZXJzLA0KDQp0aGUgbGF0ZXN0IHZlcnNpb24gb2Yg
bG9ja2luZy5yc3QgY29udGFpbnMgdGhlIGZvbGxvd2luZyAoc2luY2UgMjAwNSk6DQoNCiJNYW5m
cmVkIFNwcmF1bCBwb2ludHMgb3V0IHRoYXQgeW91IGNhbiBzdGlsbCBkbyB0aGlzLCBldmVuIGlm
IHRoZSBkYXRhDQppcyB2ZXJ5IG9jY2FzaW9uYWxseSBhY2Nlc3NlZCBpbiB1c2VyIGNvbnRleHQg
b3Igc29mdGlycXMvdGFza2xldHMuIFRoZQ0KaXJxIGhhbmRsZXIgZG9lc24ndCB1c2UgYSBsb2Nr
LCBhbmQgYWxsIG90aGVyIGFjY2Vzc2VzIGFyZSBkb25lIGFzIHNvOjoNCg0KICAgICAgICBzcGlu
X2xvY2soJmxvY2spOw0KICAgICAgICBkaXNhYmxlX2lycShpcnEpOw0KIg0KDQpJc24ndCBpdCAi
c2xlZXBpbmcgaW4gYXRvbWljIiBhY3R1YWxseSBiZWNhdXNlIG9mIHRoZSBzbGVlcGluZw0KZGlz
YWJsZV9pcnEoKT8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5z
aWVtZW5zLmNvbQ0K
