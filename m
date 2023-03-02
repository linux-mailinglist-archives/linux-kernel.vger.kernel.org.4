Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853D6A7A22
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCBDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:42:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB714608E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:42:25 -0800 (PST)
X-UUID: 3a5d0898b8ac11ed945fc101203acc17-20230302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tm2MrasgD/oq4DeZCl78AMhL+YmlT7U7DBXuSk1eRS8=;
        b=IdZZEO2VOEBGDbXotvQ+FL3F0aljEk/dB4qG3SFImCkKhBDpcRrzlau2WFU4UYUZnEtzJ0r4u4KfXgUqoMmptfa15G1KYKB3Y3GWBdhn2Loostrtg24CyGKW8vxHsr+bj8rpQilXo/sMJbsfexBPi/rkn5PpQ+neihbHB3hgkxw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:9995ca95-8bf4-48ea-a4fd-a61318d3b0ef,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:3566f1b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 3a5d0898b8ac11ed945fc101203acc17-20230302
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <cheng-jui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1384550140; Thu, 02 Mar 2023 11:42:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 2 Mar 2023 11:42:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 2 Mar 2023 11:42:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpUCbuW+Hw8UaN2n1XG6DoGSLRw1YRtJyON9UN94XZKAS4y7EnS3FVy6gHXyCriK9p7T+BLtxLRSE6R5hg6nOn5ML+liXH3r95KyN981E3ARx2tmqNnheamYc4VyBoDhuUI0VOV+RDMzA/93zPwTWw1guniapOBaDkZQSpqRlZIwveYa5AQb+BHMkxOClB0Sv0YIu9/PT898pWrMMdl8uAU9UTBfkEgAuWyTUBNYHyTlb/PWwArnTgORGtId6chJXp1ZhDsWXrDTVG7g0psIfqZ1yXrqElSBrqvlgSYu2AA8iiVgmOpgwSnbVMKbWBzrl92n4DXpLMaFuYimP+CnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm2MrasgD/oq4DeZCl78AMhL+YmlT7U7DBXuSk1eRS8=;
 b=mvRTc30L0v1nGd1X+QaN5WMEfdF3MCU+0qoWA1TW2X4ruKvv21DeeP4WorFvmdCnKptASiLG8Tvbdpuq5+1Z+3gg5iPvV6qjyLOaBLfr+SAoh8k1EDfV3OKWUVa6LHU64ivo1jU4kdxqrGROOR868oQTKoSu5W6w7VaMQMcxnAmg80gDtW3erZmj9vwzGfKmjKk6rA4OPvLJ0+WcMu4he49oMcJ6JR6+izTaZ6m8RnAa2VQBHRU0zdXVyXPI5ONwaGbA/r7m5xTSgnVZEpA/lu7j6XWBxxOOM431nlnAkJ0tyzO1vNmyUxE3pOvusk5EG/dN6EHNNP5/eQ56SBuAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm2MrasgD/oq4DeZCl78AMhL+YmlT7U7DBXuSk1eRS8=;
 b=rGXIIVUkbwwT7jR+bc8HhiGVJZxwRAnWuy7uKqjRDOllSgA4ph3t8ErM6DDNrNuWMtV6lF07xh+SBP4WoXaoMYa5IHeTXh4WLF15VuljxzTIN9K3F3Kbk/RpY1i6vSNnTw9AbT9Qg/I4DrhmMvv/fD1JsNy6sMr3Bdu/L6/CYXk=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 SI2PR03MB5548.apcprd03.prod.outlook.com (2603:1096:4:123::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Thu, 2 Mar 2023 03:42:12 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::1eeb:dc8d:3117:ad0f]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::1eeb:dc8d:3117:ad0f%5]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 03:42:12 +0000
From:   =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= 
        <Cheng-Jui.Wang@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "surenb@google.com" <surenb@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= 
        <bobule.chang@mediatek.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Thread-Topic: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Thread-Index: AQHZTCPsSbY+bDZDiUyH+yg4juwAr67l3OIAgAAEMoCAAPiVgA==
Date:   Thu, 2 Mar 2023 03:42:12 +0000
Message-ID: <8fc10d148f3e0e04c89de03057726cc01c31b7f5.camel@mediatek.com>
References: <20220822164404.57952727@gandalf.local.home>
         <833cecca4460ae3c371455cef75b40a1f3922758.camel@mediatek.com>
         <Y/9KjY48FoHIHJ44@kroah.com>
In-Reply-To: <Y/9KjY48FoHIHJ44@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|SI2PR03MB5548:EE_
x-ms-office365-filtering-correlation-id: 54b246f5-6a54-4c6c-49a8-08db1ad01bd0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fV53AGquU55ePYh3waGa1ucL/+HPHX/F+d2FKrrybBPkvI6UfVlP8EjnVD+prBY7IN1q0Ye6gxtC0/bRrye5vGmHDKI+Tg+IjVCCosqwrbx8JIFgIGz8HrSbqOPT7ciL/2Lk9ce9STPVl8VdsVtW/+uHAfSeb6qkDhtF1VFgfxn2k9gC1IjtVRlzIVMro1WPRMTkeo7rPIIdY38/ZBNtfYTUm/Ql9MB/Ig8kgjokH/3pvOCj2kszo90mGhUK8bm/E0mGobvY7Agzj0TFNlHCuq1GoMZinOoULZewXjRRa7Cm8L1YeQN2zpsi4dytA3scTc34Xd6MSBwtpb6qOwSoaQrj6fHuz8Mo0gaxQCA0OHnzJalWxnffyjQsAMT1vipMIuqWMok+jCVuGzACyoQ//2r0ekOzJV3CGVHO7ulFYZBTrf0BT9mGus7SXarnpwRIW7Ve1qcyOdNBfnhSU5pDUtuEr2RLvjcjgvs34fRacGpLMR98uGm3ViBrjRY0zekzxD9KQSMlt5g7NLz+Fd0mGSCmEQn2paro8LfTbfMlFq67jekoDojkZ1KOVkMdcGBaB4/iGRhgLfYoDR7FUSPcPnUHDP9E+vkZNI/+sJb86GWyAijAdpxnrJceQ5Wt0Wbnqv+8D9Coh/MQwPbRaly8oqRe4aQeiVtrSMzi8g++cIXZcVemWI8k52LwemO0xDLfCVbrqV8Zef6Otdf78TefCmcm8r1/XgQfgBS1T7EwV9HSwDxC+d892sHuIsfgeAF5HzJe2/u0ZYZfuvLN7ksIPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(5660300002)(41300700001)(8936002)(38100700002)(4326008)(8676002)(6916009)(83380400001)(64756008)(66446008)(91956017)(2906002)(66946007)(76116006)(186003)(66556008)(38070700005)(54906003)(2616005)(66476007)(122000001)(316002)(6486002)(86362001)(966005)(478600001)(85182001)(36756003)(71200400001)(6506007)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHc3VTJnd2xpU09DbGVjMlQ3MHBWTTFTUW5uR0tYZkNyWDRqSnRPczdDNFkw?=
 =?utf-8?B?N1J6Y25oNEtNRGxHdVlGbWJpSkFqY3c3b3ZDUVIvZWs1ZElGU1JrbjFmTXhH?=
 =?utf-8?B?U1FpWmlEQW04LzJwVzVucUFmYTQrQ1czaFBibzMyTzhGYWZwS0FhdU5kMVBa?=
 =?utf-8?B?dm5KMGtUZDRHK1JpbElWL3BrZTJ4WEQ0V2lZRXlPbkQrUS9VVnRnNFJKZEhT?=
 =?utf-8?B?WFF5QzY1eVIwY1lOSGJjclg5cm1MMG9ZVmgxWGVlVkNwNC9xMVdEbDlMZDdD?=
 =?utf-8?B?ODBsYUN1UEZWbjlzRWJJK0hSbU04MGtCL1Y3QUZvOWV5akFZakU0UndsRmN0?=
 =?utf-8?B?TVVnRTJ3aEh1dTg2MkZ2SzA3cEozUXpFdVduOHlONWF3c0tMeGRHSnBYTnhL?=
 =?utf-8?B?RGpNUVNBMVpBbExrVTYrWldBMEdPL1VIZXhMZ3I0Mjdnc2xGem9nRlk4aFJ4?=
 =?utf-8?B?bnFySHhTbWlrTENDSGVlZ3VFdXNpem00bG5CK3ltMVVZVG9oNStPNS9ta0xH?=
 =?utf-8?B?dDBhSU8wR1BJbTJrNGxCK0NIcitGdWlsWXdVSEQ5SkVVT2xjVGdZcU5ILzRv?=
 =?utf-8?B?NWxkWVVnQU0zSkYzMGN6N0ZXY3gzU0pNWkN1VVlVanBvbER2aC9EeUQ0UWdF?=
 =?utf-8?B?YUp0K2lONjdJSG5OWGR4NjJzdzFhRXhiQTNZV2R6MHBQODVZREMwMW9BMjZz?=
 =?utf-8?B?R25nQ1BEN1dkWnJlM2xjV1N2UzJSd2syN0RBbm1LMGRMVW1uVTBscENscTlP?=
 =?utf-8?B?NW1mRHRTZUdxS0lwdktQTzBBeElVY1N4Rk90bGthVkpJdFl2cS9UVUd4U0Vr?=
 =?utf-8?B?U28reDZ5UnNxWTB6emFGclpPKzBvWVQybmV1dGw2cUtwbUNQVmxmOGtHd0Ja?=
 =?utf-8?B?WGEyaW9iK0psNm1IRjRkOEwrV1hIOTZ0Y0lIZzd1UmJxY3lhTEs4NUZBQkp0?=
 =?utf-8?B?Y3REWXRwRks4Yi85R1k3QW1EQkVSUEg3cjVJcVY3aEUrQTVPS0czSHFQY2oz?=
 =?utf-8?B?ck1OemZ0NS9NZ1I0VWpFazJzeGUwRldIeXI1MEk1M2svQ3JqOVJwSjFnT2hr?=
 =?utf-8?B?USthQ3V3S2pUbXQ1N2dtMGQ3bDlJVnBtUEd2S3gyT1Y1ODRObnVzU0V5Vkxr?=
 =?utf-8?B?d2E5bS9wbGMwdk1UUmRyR09Td254cS92TDVDcmNjZlJSbXkyZDdxak5UN1Ar?=
 =?utf-8?B?bTd2ZzQ2c3daQmt4MTh5SzVMQ0ZzNjdIcm5xSE1pYkdiSi9SM2VkNHVBTHR1?=
 =?utf-8?B?cWRKdkZma2VMbTNpOFRucXI2NS9TcU54eGh3RUQ1Z2Fpb05ycXJtQkh0c3Vm?=
 =?utf-8?B?elU2QTltMmJKSlNQY2txcllvM3ZVN08yTG81Q2FWZ3VxNzBqalNtRGdSQ0xW?=
 =?utf-8?B?bWUvK0YyaU01SlFYZnpZWXpyZzBTaG03SzhzUEwzRDZ5ZHdBZWhZOER0ZWNp?=
 =?utf-8?B?akpzRFBqc08rNnpHN0Fnb2lIcFhGUUVVUFBHUDUzODc1TFFUSG01MUFXT04z?=
 =?utf-8?B?QmU1NW8weWpTSk1NY0Q0V1dKTGJQYkwxSlJvYXpoblBSMzYzNisyMWZScnJz?=
 =?utf-8?B?WXVHa3FneHVEWitPdm1zYk1rcHFlRVNXWnVHS2FCNzAvVHgrc2ZsWFNIYzUw?=
 =?utf-8?B?N0RWNzF6LzlqN0pTR21OZ25WNjZ1a0Vmd0s3VFordWdrdU8raUQwWjU5NDd6?=
 =?utf-8?B?b0YyTkZTdTVvMHl0aWR3V3pDYmR5ZWRXRlFYVUthc1EyRWh1a0dJVmVrdWVO?=
 =?utf-8?B?azhkRXY4SU52NTVzd2hMZDZTQ0pTMTBOVzcrNk1SeGdHaE5EQW9NTE8yU2NS?=
 =?utf-8?B?c3M0Y0kwQ1pjelZYWHZHMU5rZzUzUmNuTFlwLzN3UXg2bkM0Y2NoQnFtcGla?=
 =?utf-8?B?alhSSW8ycHE0NWh6ZUwydjl4ZHIwSUpPVmFObjBCMjdwUVZjWSs4ZXBpVlln?=
 =?utf-8?B?YWE5c1RaT0tuRVpGZm40SXRLdGdxV3JhQ1g3Vmc3WG8yajhuM1lNSGVibUhj?=
 =?utf-8?B?a3FIMit4bVdVYy9JMFdXRTI2NXhoUVNpeE9WTzdGNnJwdUNnWm9kbTNLblA3?=
 =?utf-8?B?NXRycnFVaFdGeWdCTHhPdEdzdlZHUGt6MzkvanRjNDVlUm5DMU9JSUVRT3dH?=
 =?utf-8?B?ZEN1bERRVEJ5b09ZRlFra3I1UGdUWnhscVRsb2RVSGZkdUR6NGdOckVVVXF4?=
 =?utf-8?Q?JN8iWo5sbicFYmOFZNVZ5Fc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADEAC5329BEF3C41B41B5E6207ECD2B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b246f5-6a54-4c6c-49a8-08db1ad01bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 03:42:12.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz9qLvrgyd2jnNFph0nKFGgpocFOgQ8efbhu4QvoOvU6cTerLOQakumu7I/YfwpwDc59epO4cEGyga290rorWPNcTN40DvEHh9/nwTARlQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5548
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTAxIGF0IDEzOjUyICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gV2VkLCBNYXIgMDEsIDIwMjMgYXQgMTI6Mzc6MjlQTSArMDAwMCwg
Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvykgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIyLTA4LTIy
IGF0IDE2OjQ0IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4gPiA+IE15IHRlc3RzIGFy
ZSBmYWlsaW5nIGJlY2F1c2Ugb2YgdGhpcyBzcGxhdDoNCj4gPiA+IA0KPiA+ID4gWyAgIDE2LjA3
MzY1OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4gPiBbICAgMTYu
MDc0NDA3XSBidXM6ICdwbGF0Zm9ybSc6IGFkZCBkcml2ZXIgYWNwaS1nZWQNCj4gPiA+IFsgICAx
Ni4wNzQ0MjRdIERFQlVHX0xPQ0tTX1dBUk5fT04obG9ja2RlcF9oYXJkaXJxc19lbmFibGVkKCkp
DQo+ID4gPiBbICAgMTYuMDc0NDI0XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAwIGF0DQo+ID4gPiBr
ZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6NTUwNiBjaGVja19mbGFncysweDExNC8weDFkMA0KPiA+
ID4gWyAgIDE2LjA3NDQyNF0gIGxvY2tfaXNfaGVsZF90eXBlKzB4NmYvMHgxMzANCj4gPiA+IFsg
ICAxNi4xODYyODRdICByY3VfcmVhZF9sb2NrX3NjaGVkX2hlbGQrMHg0YS8weDkwDQo+ID4gPiBb
ICAgMTYuMTg2Mjg0XSAgdHJhY2VfcmN1X2R5bnRpY2srMHgzYS8weGUwDQo+ID4gPiBbICAgMTYu
MTg2Mjg0XSAgY3Rfa2VybmVsX2VudGVyLmNvbnN0cHJvcC4wKzB4NjYvMHhhMA0KPiA+ID4gWyAg
IDE2LjE4NjI4NF0gIGN0X2lkbGVfZXhpdCsweGQvMHgzMA0KPiA+ID4gWyAgIDE2LjE4NjI4NF0g
IGNwdWlkbGVfZW50ZXJfc3RhdGUrMHgyOGEvMHgzMTANCj4gPiA+IFsgICAxNi4xODYyODRdICBj
cHVpZGxlX2VudGVyKzB4MmUvMHg1MA0KPiA+ID4gWyAgIDE2LjE4NjI4NF0gIGRvX2lkbGUrMHgx
ZWMvMHgyODANCj4gPiANCj4gPiBPdXIgdGVzdCBpbiB2Ni4xIHN0YWJsZSBpcyBmYWlsaW5nIGR1
ZSB0byB0aGlzIHNwbGF0IHRvby4gVGhlIHY2LjENCj4gPiBzdGFibGUga2VybmVsIHN0aWxsIGhh
cyB0aGlzIHNwbGF0Lg0KPiA+IA0KPiA+IFRoaXMgc3BsYXQgY2FuIGJlIGZpeGVkIGJ5IFBldGVy
J3MgcGF0Y2ggDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwNjA4MTQ0NTE2
LjgwODQ1MTE5MUBpbmZyYWRlYWQub3JnLw0KPiA+ICwgYnV0IHRoZSBmaXggaXMgcGFydCBvZiBh
IGJpZyBwYXRjaHNldCANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MDgx
NDI3MjMuMTAzNTIzMDg5QGluZnJhZGVhZC5vcmcvDQo+ID4gaW50cm9kdWNlZCBpbiA2LjIuDQo+
ID4gDQo+ID4gQ291bGQgdGhlIGZpeGVzIGJlIGJhY2twb3J0ZWQgdG8gdjYuMSBzdGFibGU/DQo+
IA0KPiBXaGF0ICJmaXhlcyIgZXhhY3RseSBhcmUgeW91IHJlZmVycmluZyB0bz8gIA0KYTAxMzUz
Y2YxODk2ICgiY3B1aWRsZTogRml4IGN0X2lkbGVfKigpIHVzYWdlIikgYW5kIG90aGVyIHBhdGNo
ZXMgaXQNCm5lZWRzLg0KDQo+IENhbiB5b3UgcHJvdmlkZSBhIHNlcmllcyBvZg0KPiBnaXQgY29t
bWl0IGlkcyB0aGF0IGNsZWFubHkgYXBwbHkgb3IgYmV0dGVyIHlldCwgYW5kIHNlcmllcyBvZg0K
PiBwYXRjaGVzDQo+IHRoYXQgeW91IGhhdmUgYmFja3BvcnRlZCBhbmQgdGVzdGVkIHRvIGVuc3Vy
ZSB0aGF0IHRoZXkgd29yaw0KPiBwcm9wZXJseT8NClN1cmVuIGhhcyBiYWNrcG9ydGVkIHBhcnQg
b2YgdGhlIHBhdGNoc2V0IHRvIGZpeCB0aGlzIHBhcnRpY3VsYXIgaXNzdWUNCmluIGFuZHJvaWQx
NC02LjE6IA0KaHR0cHM6Ly9hbmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2UuY29tL2Mva2VybmVs
L2NvbW1vbi8rLzI0NDkyMDMgdG8gDQpodHRwczovL2FuZHJvaWQtcmV2aWV3Lmdvb2dsZXNvdXJj
ZS5jb20vYy9rZXJuZWwvY29tbW9uLysvMjQ0OTIxMi4gSQ0KaGF2ZSB0ZXN0ZWQgdGhlc2UgcGF0
Y2hlcyBhbmQgY29uZmlybWVkIHRoZXNlIGNhbiBmaXggdGhpcyBzcGxhdC4NCg0KRm9sbG93aW5n
IGFyZSB0aGUgY29tbWl0IGlkcyBvZiB0aGUgYWJvdmUgc2VyaWVzIG9mIHBhdGNoZXMgaW4gTGlu
dXMnDQp0cmVlOg0KNWUyNmFhOTMzOTExOTVhNjQ4NzFkYjVkOTZkNzE2M2YwMDYyY2E0Zg0KOGU5
YWI5ZThkYTFlYWU2MWZkZmYzNTY5MGQ5OThlYWY4Y2Q1MjdkYw0KNWZjYTBkOWY1ZDc2NjY0Nzg2
Y2E2YzA5MDc2MzQxZGVmMTY1YTY3Nw0KZTAzOGY3YjgwMjhhMWQxYmM4YWM4MjM1MWM3MWVhNTM4
ZjE5YTg3OQ0KYjNmNDY2NThjZTQwYTM0NjdjZGE4MmY5MjBkZDlkNTMyNWFiMGVhZg0KNGQxYmU5
ZTc0NTM4MmI0MTQ5MmIwY2I5MDAwODI5ODYzZGI3MTMzYQ0KNGNlNDBlOWRiZTgzMTUzZjYwZDdl
NGNjZDI0YTFlYjRmODI2NGY2YQ0KYzNkNDI0MThkY2E1M2Q2YzQ5OGE0OGM0MDhmN2E0NTI4OTU5
MzY1MA0KMGM1ZmZjM2Q3YjE1OTc4YzZiMTg0OTM4Y2Q2YjhhZjA2ZTQzNjQyNA0KYTAxMzUzY2Yx
ODk2ZWE1YjhhN2JiYzVlMmIyZDM4ZmVlZDhiN2FhYQ0KDQp0aGFua3MsDQoNCmNoZW5nLWp1aQ0K
