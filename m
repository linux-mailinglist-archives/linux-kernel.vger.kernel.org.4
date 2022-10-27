Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6360FAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiJ0Oqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiJ0Oqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:46:45 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E3923D4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:46:45 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RDA7qv013336;
        Thu, 27 Oct 2022 14:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=wlRgnKEueQoiL5pH+pb1AEALJQQScaBrzpgt8x+Xh3c=;
 b=gE0txrnGfORn4/GXGSOezsxQB13lKarQFHZc2G1AmqP1DF0/gJqfjteiUGOuOUtcIP/h
 nlqh6AkzdVZbtdRjNJ6LV58XriuOReUeGHi5EZlR6SGgQVzhJ8ox2b8BzyMGnTarTNQF
 ZSQmR7m0ozso5RiFOAgWI0g0OkkXijtyBtrTLBvrNt3ekxzJmLVK51+CG6fdpwkR9TmC
 yGVS0IsALCD0+//4KZW09PpQvJKsMyLxXUfGHYSuYValrfeU0tMCew2S/bUc9cOY9g7h
 lhI1WnJS3n3336Es08p/nqLc1jUqdXB7H2NYy42S+1dpp8Q+gf0zp1WgT7+6r1HNXbo5 XA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kftmjgv29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 14:45:58 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E39E52EEF1;
        Thu, 27 Oct 2022 14:45:56 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 02:45:55 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 27 Oct 2022 02:45:55 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 02:45:55 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4xC5z59gwTLU+TEpB6jPuuedESZ5NB2Txd63SoXqAJOUc31WY1p1OHZr6NtfRNZLUVefNwyTnetm+ubtKSyBOBhKTZ8YBXhiDM8tamm6Q9A3l89Oy/caPtUit3el5qUhbJAXQYeYD1zfayrmqQ5sNx9vxSV36wpk/LKQ/U8d7zNRd0saEqXANPXCnO6ZD86rfO/RsbhOi7pm05j6bg1E8FNdhgDgX4bkLo9M/YhLruVFzEkrNqGQVDcIaBenRGf0kMAFviiu5n4H3yX45Af+aHU3hxfYYw29MXLrcalZ13cj1DaB7UkaKmFrYW6WkuxmS0jw3B4hgBOpMYXrc9H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlRgnKEueQoiL5pH+pb1AEALJQQScaBrzpgt8x+Xh3c=;
 b=bntWJm2yLX22jL/HHnOK/D4tNSb7QlVg/P4V8h3OLqVBEyQyr2wpJgEhI6FlRGYFydRbP8rMEd04j+cHKYz6Ucr0rsTpYYh6WyIEadZsQRrd125B/JmQ5pO4yufGM7MWf4Qu989FicFRBqfSg1ERMTfXV1GPPIh9iiGYAT0rgIHEB07M15LtUIXJoZZxYgmBlv/zgWFLeyvU+Pclsnv/VsyqwIX7hvYyRS3uXPC2XnRfjOsSnqw80xZUYcyN8TZY9/kPOquSk/CivYZHy+OXcQHTU9fFGFP+yDfkRfEmCr8WWXb4Ivrqx0AEYi6TV7m6uj3d1w7ae2xUkaQc8HKoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1532.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 27 Oct
 2022 14:45:54 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 14:45:54 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     =?utf-8?B?TWF0ZXVzeiBKb8WEY3p5aw==?= <mat.jonczyk@o2.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: RE: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Thread-Topic: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Thread-Index: AQHYxbtM4TN11ey6QkaTM4FYDy1Oeq4imEUQ
Date:   Thu, 27 Oct 2022 14:45:54 +0000
Message-ID: <MW5PR84MB18424DF86AE0D9B60994A38BAB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-2-mat.jonczyk@o2.pl>
In-Reply-To: <20220911084711.13694-2-mat.jonczyk@o2.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1532:EE_
x-ms-office365-filtering-correlation-id: 8ac47ca2-e29b-435e-b5ff-08dab829f347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muYzFBsbesWHkQWFdEf1NhlLCLoyzNzShRNO46R7ftQrUc7OzswJhEySpCEVomziOvd+PwAQ/uyq9t2NzOOfXejw94OLQKKyW6+Kk7GRPT60mdFzlJdidFJTPt2KOgUyNEzLKElJqHG/Un1DXnZP+O5eJNPcQV/nODlMEaBCC2wWav1Hlzt/riGI1rx6dTQqalmA+i9R4x+JtzI+GFSDFRQEl9djzP0eAJ8VCmtmuHFdQ/xt7laIros0u3omVwkEnoayysNdD/K6lkuaE2JGrgoRiwLKtt5ruLRss1TwvI5LyFRsERTTbUZDEYyE7sc9MIPCJimBMxWLyRB43Jh4b6QNtZY2611tRWSOC7+rzXu1mmmenxPdkDRXo2zUrsWwoex1uFuv7HwNpgLSVgDxrgQGae5NmX6XAUhc+IjoZYdBBXwIEqJfqumh/0IzAwon0KYOpz/c6P2LdQ8OSlfJUloI5uR17BRMLtgKHAAmmQZK2GLragBL6Qj3xOBi/pIHbYZsRr80Ye8tNR+xOp66D35z4INa9XVrdemC4dr62FZ5iHw9iO6DpBh2O4J1W3Z7LVRvRax/Fn+aGEMDV8f+65DMitoLz3eb0jYPKLL9Bl2FiU7RLU28h+rltbNOzGVMB3RG/MngCl/iXvHcTZrgt1VXv6AJFPK012ZZXrA8iNniD5ujeX2L3yNIt5yuwdyqBcv00kep/Ijx1/moJzqgZq4gfU+j9wVnlkFTCSB1FHWgTQOAdMUt7CJIn3aDJuml0bo/AfTydBvZtb4mHMK3XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(82960400001)(7416002)(86362001)(186003)(83380400001)(110136005)(38070700005)(4744005)(122000001)(5660300002)(54906003)(26005)(38100700002)(2906002)(64756008)(52536014)(41300700001)(55016003)(8936002)(8676002)(4326008)(76116006)(7696005)(66946007)(66446008)(478600001)(66476007)(66556008)(71200400001)(9686003)(6506007)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG9lYnBFOXBhSGxFaFlrc3MwNmt5dVFoV2d6NEJFcWh0dk5DWXFudS93ZEdp?=
 =?utf-8?B?UVJzZUN0MEZVWXUwWlB6OFVlMC9WTHdDdGdOU1B0OS82bUhJd1VlK3BybGps?=
 =?utf-8?B?NFJmaG54YnZweEdhYWVxZXBUbDBySmF3ZFFHMFhlUTdGM2VpbUZhaU1YcTBm?=
 =?utf-8?B?WXREbUxJaUtHeUY3ZW9NWEZ2RnZXYXBEeVZjVEx0d0lUanBoVkJIUy9keDZ3?=
 =?utf-8?B?TU10WEVMRjQydmpMN3VFMUlwRkJKWXJOVCtKSGVUNk9GcTA1RzFqSTluZmVZ?=
 =?utf-8?B?MUZJNTFKd0U3U0pCeTRTenVsd2JiaUhiR2xGc2R0TUQzNUJKa05oNzduTk12?=
 =?utf-8?B?RlY5aXczT1JJREYrenFmRlJzWWx1MlJFaFlBZXByZzVPN0ZmYzlTTk1sT1Ft?=
 =?utf-8?B?enJRYWFqS1NpNkxwRWV3cy9OcGFZMXNZMnNKOHJJa1NTNzRQYXM0TTBVdHpl?=
 =?utf-8?B?V3lYVjk5aUp6WnQ2RXhPcTBZZXFqQnlreENrZCtIczFKaUdDMjE3Ui9KV1Za?=
 =?utf-8?B?Mk53cnY0UE5GaWtNRXJLWnluV2RLVlo0MVdHSjk3bjJWc3JpNkdNVVpZUlZL?=
 =?utf-8?B?QzJZcEVSYjFsN0RVc042QVRTSkxqazZLcTE2eWQxQmQrQkpTaG5TckxjV0pu?=
 =?utf-8?B?bWRheXRxR3JCQWR5enFQOG10NXNQUC9MN0RBUlZmZVpEcUtBSnNueU9yOWR5?=
 =?utf-8?B?aFJ6czk2ZnY3OTZvZUxMaHB6bTY5RU1pWTNsR0lqTHEwZGVnbk53R1FreUZm?=
 =?utf-8?B?UnpCUk9RcE16MlZldGx4MUlnVVlWRXVHQ29LUlVVMVVOajBZNS9GOU5CdXY1?=
 =?utf-8?B?ZjNJVk9lTC9SNGlsU1AwdEdkK3NGODNiYnNWTklhalZTeHQySTFHQS95anRq?=
 =?utf-8?B?UnkyWUF6QWFjR3JUZkVNYzdnRkxUQWMrZjFucWFBZnFrNzZKSU5EczU1NkRv?=
 =?utf-8?B?TjRsZUJIbURBRTJmS3VHa0VLMmtadHJON0o1MnRIL2RNcUhWdG1zNnMvV2Q3?=
 =?utf-8?B?eTNGSERSUDVhV2NPTVE2dGw2ZTR2Y0EzZHA0ZjZLbDAxN1pZcFlLeS9BQVR5?=
 =?utf-8?B?NHhrSVVDT0luNmdLU1BYQUVsR2pySHJhaC85WGNlcENVOVlWT1Y2bTAxL2JQ?=
 =?utf-8?B?dmhiZ3U0OHJSWW9lUnVuZWR3blFTdHZFSFVObm5TRzhnVXRGM2dZc0lWTDRy?=
 =?utf-8?B?eE9YUkpWaGZmTk5kTHcyaVdHVDI2WEpsZjBTeTZvYXhid0VmcU5JSjlYK1V0?=
 =?utf-8?B?WnRsR3AwZ29tZUphWmk3ZllCdXI2VnpSTjJIeS9wdkExUndQZWFwa2NlY0x0?=
 =?utf-8?B?am4wQ3Z2TFBVcnVnWnlzUUNGdjJWL0dtV3FTK2FpelJPaEVHUjNwejlxN1Z6?=
 =?utf-8?B?UnNzc3hMRUR5QXlWSTM3c3AyZ29SY0dXL2NJRDkwbU5vVUNDWEJmbjQ2V05P?=
 =?utf-8?B?MVBGMTRwc3V3Zks2aDdWNXhiODhqRWlGYnR0empuQm9RRFdWQVJzUVpGeVV1?=
 =?utf-8?B?NHhGNmdDSStZcEpCa0QwY0VyQ1YzN0hFR1VvT2t2TmN6ZGRmYTFSaDFNczZQ?=
 =?utf-8?B?Z2RKMkJVSXIwZVlEWHZNWTlXaTNvVnVzSHFXMUVGcnkwLzJaa2FuUU52bWdj?=
 =?utf-8?B?Wjd1MmNvQnVnT0ovZTdxOGp1MTVCTnJVSXhXMjJGRzMxdG01M2VYYk1xaG5N?=
 =?utf-8?B?SVBVTDdrR2YxZzc2R014eW9LeUZSeE9CVnFUc0wxSXJrei9ySXl4RkZJVG1D?=
 =?utf-8?B?TGVOVnZQMDdKNFpYL1lRMW40OHd2SXkrVW5qUDhuNWlqVmt2eXNmSXlTK3Vo?=
 =?utf-8?B?TytSWFF2cVJ0NVplRXIxajJOQnlWUkZOMjFpS1hkN2YxZkFRRGJpcENoUldC?=
 =?utf-8?B?RmszWXFGNVpPY2Z4NkF0L0FtTGlTTDh2NUVNU3RkUkQ0eEs5VUZHazRyL044?=
 =?utf-8?B?eUFZS29nY1cwb3JtdHdzQ2kwa2NlNFVMV1AralFZNjBxK2p4czh6Z0NxVGw2?=
 =?utf-8?B?OUZ1ZSs4VEl1T2hDK3BKZ0ZoUGE2ZTJkS2pGN1JodVJuK2h4dzkyOXV6eDhB?=
 =?utf-8?B?ZWQ1RVRoVmVBZGlZSk5LeC9LWDJpNEZRbDUwVFlnekpQdmxPcVdiZkpnNEVB?=
 =?utf-8?Q?7030=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac47ca2-e29b-435e-b5ff-08dab829f347
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 14:45:54.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5U1oKrqaMatH0VzNtBzjeZ8r4nu55i+ekSFD5/7NXtu6E2ctCeAhN5c/OMHRsr6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1532
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: UShz6DuDLds-cdIncrKbdZdYd_2xFoVk
X-Proofpoint-GUID: UShz6DuDLds-cdIncrKbdZdYd_2xFoVk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=353 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270080
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBcyBtYW55IGN1cnJlbnQgcGxhdGZvcm1zIChtb3N0IG1vZGVybiBJbnRlbCBDUFVzIGFuZCBR
RU1VKSBoYXZlIHgyQVBJQw0KPiBwcmVzZW50LCBlbmFibGUgQ09ORklHX1g4Nl9YMkFQSUMgYnkg
ZGVmYXVsdCBhcyBpdCBnaXZlcyBwZXJmb3JtYW5jZQ0KPiBhbmQgZnVuY3Rpb25hbGl0eSBiZW5l
Zml0cy4gQWRkaXRpb25hbGx5LCBpZiB0aGUgQklPUyBoYXMgYWxyZWFkeQ0KPiBzd2l0Y2hlZCBB
UElDIHRvIHgyQVBJQyBtb2RlLCBidXQgQ09ORklHX1g4Nl9YMkFQSUMgaXMgZGlzYWJsZWQsIHRo
ZQ0KPiBrZXJuZWwgd2lsbCBwYW5pYyBpbiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9hcGljLmMgLg0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnDQo+
IEBAIC00NDAsMTUgKzQ0MCwyNyBAQCBjb25maWcgWDg2X0ZFQVRVUkVfTkFNRVMNCj4gIAkgIElm
IGluIGRvdWJ0LCBzYXkgWS4NCj4gDQo+ICBjb25maWcgWDg2X1gyQVBJQw0KPiAtCWJvb2wgIlN1
cHBvcnQgeDJhcGljIg0KPiArCWJvb2wgIngyQVBJQyBpbnRlcnJ1cHQgY29udHJvbGxlciBhcmNo
aXRlY3R1cmUgc3VwcG9ydCINCj4gIAlkZXBlbmRzIG9uIFg4Nl9MT0NBTF9BUElDICYmIFg4Nl82
NCAmJiAoSVJRX1JFTUFQIHx8DQo+IEhZUEVSVklTT1JfR1VFU1QpDQo+ICsJZGVmYXVsdCB5DQoN
CkNvdWxkIHRoaXMgb3B0aW9uIGJlIGFkZGVkIHRvDQoJYXJjaC94ODYvY29uZmlncy94ODZfNjRf
ZGVmY29uZmlnDQoNCnNvIGRlZmNvbmZpZyBidWlsZHMgZG9uJ3QgY3Jhc2ggb24gY3VycmVudCBw
bGF0Zm9ybXM/DQoNCg==
