Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C75691C50
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjBJKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBJKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:08:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF44ECC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:08:14 -0800 (PST)
X-UUID: d2107576a92a11eda06fc9ecc4dadd91-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KwlW4/QbQURQXSfvNE/HTkSW5TGVqMtUZcrVFIzhLAY=;
        b=t4Amrdkj3LgikAWUw5lEtGo3fRcKrO1gRE3sysglWLmCdkQO3t+f0fkRHKHZQgARGn0Hu/iLob3ZlJlqQx6AvPP7BjbNu/oT2O4QH6AhlbOz6v0HiGKUp0bwcYyeXMkrNZGcgwHkdDaP9DJixeLH9wycdWlYakhhxPRzc6jX2fs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:873222e0-0eaf-4908-aaf6-d4709841c300,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:c715e856-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d2107576a92a11eda06fc9ecc4dadd91-20230210
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 958477940; Fri, 10 Feb 2023 18:08:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 18:08:08 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Feb 2023 18:08:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTdiu/YecsU6myi6OgUNot64syCdhip3KN5oBgx5Bibx4dr30RM3dInl2UNMzhzQwlNq8WyA85F/eASFT6NRhUV+AarTs7ybXxCLzfjlfyf0xLztOhHnCAN+j1LqYXDkSM6kMbFJ7pniwmC/MU6OxwjxNV+AV2syGKVLqyXZGsPuOjolZBjxHwSPm5beFdClRUm98cyaOrwEKsvu0TB7IPzzAbi/VY47gegyAIrkybg5NnpN/2+anRti66ZQvAFUYyHfI6ggbMzqcS39LcuEd94xuOfUzPdJO6Ln5k7jBLl2YUS/ysdXUi1Q7idhvu1s6CRRgrbXzR0FKxyie3LkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlW4/QbQURQXSfvNE/HTkSW5TGVqMtUZcrVFIzhLAY=;
 b=QdurJQ2y0IbWu7odSfYNT0+yUTtsPv8akhVqYtjgSwiQbgfWNbkKCzzLXt3RPhfAy+zmGcksU270qGuV5risUFYIFPRk2PSIp1KLNCJZyuwuArkni1ilRABQrQix8QUNBjM3K1H5yv3q5GRrLUD60V6LZRy0iUiaFSi/m3yTynG4z4HGqgH8AbTa2V5CPc7cA3SVYpGyqiHAf3+hpOxit9PfFlIKB380fxk0Jlqv6/wvh1AIeiK0eL7PqJHjTlqiET5xnvtPx4QrgY/t96kliOMfc5LilUNyxkyALB0vvZsPI2bWjnoaVMt8ekGXMuQjhC3eZsfFZTRgVphVexCQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlW4/QbQURQXSfvNE/HTkSW5TGVqMtUZcrVFIzhLAY=;
 b=m9z2abExSOx+GB75M7D0EZFJ+/KAfTeRdsgDGLcXTJdraai45FUTbi37XahKNWqq8Ynwq+6h8VSVXyRsSZzVZEimbTDxI5AhhH1GkqR76iPIpF3bhthB+1dTmKKwxS6m5QzLxx94YhXH172NveXjs85s66hdtp2wLeNkyd/Nb+4=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by SI2PR03MB5257.apcprd03.prod.outlook.com (2603:1096:4:105::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 10:08:03 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::8ea3:f438:e35e:4a13]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::8ea3:f438:e35e:4a13%4]) with mapi id 15.20.6064.034; Fri, 10 Feb 2023
 10:08:03 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Thread-Topic: [PATCH 1/3] time/sched_clock: Export sched_clock_register()
Thread-Index: AQHZO8lPd5tEKtuMsU+KmmpG4+tdYa7Fcx4AgAKEbQA=
Date:   Fri, 10 Feb 2023 10:08:03 +0000
Message-ID: <553bd6dd40263bef64be020f1442b3730f218eaf.camel@mediatek.com>
References: <20230208094813.20874-1-walter.chang@mediatek.com>
         <20230208094813.20874-2-walter.chang@mediatek.com>
         <e1a89a4e-8a0d-47e1-a8fd-75ea152ef816@linaro.org>
         <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
In-Reply-To: <ad3a5c30-5062-55ae-7908-c0a127bec5ee@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|SI2PR03MB5257:EE_
x-ms-office365-filtering-correlation-id: 745affe9-7a27-41c6-0306-08db0b4eb28d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1TsFdASjrJHl1a8UaEO27t130sCYCKnftyH1tBhMy/mmCMjsRNH5FJmgBshJ0BAo45l5ypXNVbrYD4tB3INg1ZSYRZDWZas5MBo0VrBjFUj6bAlioP5s69bze6eMBvKVvwDjneIqWrtxBE2YLGjfeZAZM2J0hxyAWk86416/17U7IbfU0Jg5sx7/tYk2UyBEEs/dJCM/O82r/zG86W1nN7ZEaLyukuGs4l2dBA+V0eSYBZtQN6U8vGeSth1YaFULTLvTQTBAEz0G4YkCV2fC2/pPifiI8wJsYniRCZcdjP27fZFxGEjNwtuIuyVsdOJd7CvJcoNcfPSltfaloI3hJbJFQCCUSK1MCe+9PQupUquJuUf/+MkUgZLhSgoQuyCOL4l/g/TWhtYVcTrxJVM3AxYRpHvZDke9QY42/cJ6G4pZ4Wc00N0G+RMjRiP5fVBIDzXQLZABihardozwO79LTbjlTTCewMLmLnd3pREGWP8mFqVpaS6s4tuakPv4Lz82U494E5e57A8OnxY/SVyqrXdJNaytnMZ2Bdysds2VlM63L6a20fN+3pZXAJnGgjZd9iXTaBDaCTt9cuJ5m+NUWYR3fWXhMyHDWtB7VwZXS5U7eubVEJ9pqNxCQtxpeXLA5zPZjEqUmOVRCSOWAPzZC7703Xqj2t+Zh00jxYfGjdwPyy9U5qWbM/JJKPzTyUtvi8EMwo9G+1KnhGVooCgiwmqxTRJ00nRi6FT1ZKzIjEd4NEBz4yjeFIBizOMIa0D9eRM7VPpt+mDnHzL7ihKv+0l0n3/WFZYisBhPtIHJZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(66946007)(2616005)(186003)(5660300002)(66446008)(54906003)(66556008)(316002)(110136005)(8676002)(4326008)(91956017)(122000001)(76116006)(64756008)(66476007)(41300700001)(38070700005)(38100700002)(85182001)(36756003)(86362001)(8936002)(6506007)(53546011)(26005)(6512007)(107886003)(71200400001)(7416002)(2906002)(966005)(6486002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkd2NFJFSWgvaEgvY0R0K1FCcktCR0Y5L08zQldaMmVPa1VNeXFzeDFqOWpU?=
 =?utf-8?B?aXVsYjhVN0lEWVBiNllRSXVrN2JUYnBaQW1hSzVMMTliL2ZQblFIQ3JjSkhm?=
 =?utf-8?B?NE9va0tMSjJjbWluU2dhL1ZnaTcvNFQ1YUhlWURGdGNoeU1QSEp5UlNuUDVa?=
 =?utf-8?B?djNHbHJjUVFneVlPakdkUTZTNVR6TGUzcncrd1JBQStMQVlkd2lKM3d1OFpn?=
 =?utf-8?B?UURQa1RYdGk2V3RVdlB4MW5uL1RpK0ZYdms0Z240MzRybkpQeWJ6aTBmRjNj?=
 =?utf-8?B?VnpIODVGL0U1UGpjRW1NZDUvc28zQ25yQ0phbWh0MFQ2YlFqQVh3eUpqc042?=
 =?utf-8?B?Y0xKVG9pa2dxUUNHRlVsU1kzYklhcEZtT1dxd2pZblFXZDRNL2VFZXIzYjVJ?=
 =?utf-8?B?cHJxSGQyTVhuWTd0VG4zL0Q3cWNxcTVVUUpTbzQwbzBpOHdVM2dpemdoWEh4?=
 =?utf-8?B?MmpFcFY4S3lLOXJBd0FxQUt0M1pKNXE4RnJ5Y1FibE9VUCtKQmpacUJPT01s?=
 =?utf-8?B?YURpNEs1LzUxa3FyQ3k1SVA5cEtXMnpBUk56SklsTXQ0QlJUbkozdTlZdjEr?=
 =?utf-8?B?WkJjaUxvSXZva3Qvd2lLWFRBZXY3dWo1OGRTdHZNcWRheDMvcnZZaitBNFRI?=
 =?utf-8?B?WXd2TkVIZTJnUkpJalJScTZzUnQzNnVDbjN1SFNldkZmYkN5VG5acmJtNjho?=
 =?utf-8?B?SFdNZm9RN1N0alcvcFNXdEgxSFhOcEtpV2ZEU3VhaGVxVWtSQXpwclRlWENn?=
 =?utf-8?B?cGxDQUlFUXhXZk9JTExBODR5Q0ZqWFlqVENXbnBIU0VwbUZYK0ZTMFVzVEFJ?=
 =?utf-8?B?QlY2SHVscWRwWGE5VWtraUtjYWpqbWx0bEVjam11YVhiOFAybVpvOEZkV0Ny?=
 =?utf-8?B?dWliQjE4UnhKS2ZURG9iYlh1SEdZSUpmVUhrWlBabFlMTXlpQWk4Rk8vNXhE?=
 =?utf-8?B?R3RjNnVleno1MVBoNzJXRE1WbjlOZnZ2cy9CUFdadGtmbXFPU3lVeGNEMytB?=
 =?utf-8?B?TnpIMmJ6VUxmOFVSdXVzb1FhaGNySHA1QjB2WTJONXBPMFpXenVpUlB5M01U?=
 =?utf-8?B?bHh2c2JaVXVBZXdGWmYrblB3N1BwUlF3TGVIUnAzQXpyMVFrVmNpVGFJcnpv?=
 =?utf-8?B?eFVUcTY3VS9QRzE5SWh0d2xjc2lhVnltdUxvMWlHTDREYzRjM2RhSmZLTHBE?=
 =?utf-8?B?azBkbmRLdTdwd1VsR1hlOEpkR2xxV2hHd0RxRGxnMStuWDVzN0Z0emFCb1kz?=
 =?utf-8?B?azNzK0dmK3NkemJhdVlxV1FEdmtmSExzdGRSMksrdjZEN1VaNzM1NUExaldC?=
 =?utf-8?B?Q1p4YUM2WlRDYlJjZXNFMWh3L0NNSU91OGJlNXFqRFN0cWRoRUdqRHJFc2xT?=
 =?utf-8?B?T0VnWS9FcWRBbWpKV215TTZpenpDZkg2SmE1MU9KUUZvWXlOWm9zVno3cDhr?=
 =?utf-8?B?SGVYbnBhZ080Nmw3T0J0Um9xWjJqTWpISjZ2V2hiMW4wZ09rNVRTZ0djVmZl?=
 =?utf-8?B?azU4aHJvR0xQdEV6QkZFeDdGN0FwZWd1OUdYYW1PRVNWVUFSTkFiUjZFQmRn?=
 =?utf-8?B?Qjh2TUVSMVAwWGVWcnFXZS93a2psb3dBUFdCUnlUWVZFSkNKdm9Mc2NxK1F3?=
 =?utf-8?B?bGFBQmZYV1NYTEtrK1Fhc1pkdWZUZE9oMTFXQVpQUHVDakM5UTBOWTVrRjNW?=
 =?utf-8?B?U3FhbFVYRG4ydGxtaG5hbUozeEcycXNyZTQ2NDVMZUpZZkRIN2ZNcWMyVWdp?=
 =?utf-8?B?VlVSYlN0VUt0eFFaUGhlM1Z4Q3NRWE90ejU2a2RibkJlcmhXaUlKZjlYUC9a?=
 =?utf-8?B?RnhnT25tYTMrbGNZcExlZGxkRFVYQlFsM1RYYUQycHprS0xEdkp6Z3lTVVF6?=
 =?utf-8?B?VEdFZVpGSndzekhZWm84alpGWS9ueHFGbVk5alU1c21NQ3FLSVRTdVI4Um1G?=
 =?utf-8?B?TmhJQmVOaUR0Q3FIRUNiY0FnNFA0YllVeVRoVExaN3pXZjNVT1RDaVBDZGl6?=
 =?utf-8?B?WURmUzM3ZWt3MVg5clc2Ky9CdDdzcW5SODlLcDdEUDJxV2IzcFo4U25WZ1dq?=
 =?utf-8?B?SDB5V1htWk5PMlNha29VTkRrR3RwSDZkQ1JRcG9kbUNuL2FFSWxLdExrTzVv?=
 =?utf-8?B?VlVmQlYwc0lkN2NEL0xqTXJaZTZETjZhQjdvTWcrclJ1YXBKOUpQdS9yNlJZ?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39B828A51DA9E94CB24E535FCBF5CF4F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745affe9-7a27-41c6-0306-08db0b4eb28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:08:03.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk6zkfFq+6gN6Wo54/4ThYdtx+KN4SnR08YSdXBoaS2Dzs39ZNvrS9GiTbQ76vRMZEOmUIGiaYF6pqsq9MufGdiiutra3fQlkWXQ0VMkmfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTA4IGF0IDIwOjQxICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDgvMDIvMjAyMyAxNToyNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToN
Cj4gPiBPbiAwOC8wMi8yMDIzIDEwOjQ4LCB3YWx0ZXIuY2hhbmdAbWVkaWF0ZWsuY29tIHdyb3Rl
Og0KPiA+ID4gRnJvbTogQ2h1bi1IdW5nIFd1IDxjaHVuLWh1bmcud3VAbWVkaWF0ZWsuY29tPg0K
PiA+ID4gDQo+ID4gPiBjbG9ja3NvdXJjZSBkcml2ZXIgbWF5IHVzZSBzY2hlZF9jbG9ja19yZWdp
c3RlcigpDQo+ID4gPiB0byByZXNpZ3RlciBpdHNlbGYgYXMgYSBzY2hlZF9jbG9jayBzb3VyY2Uu
DQo+ID4gPiBFeHBvcnQgaXQgdG8gc3VwcG9ydCBidWlsZGluZyBzdWNoIGRyaXZlcg0KPiA+ID4g
YXMgbW9kdWxlLCBsaWtlIHRpbWVyLW1lZGlhdGVrLmMNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQ2h1bi1IdW5nIFd1IDxjaHVuLWh1bmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0t
DQo+ID4gPiAgIGtlcm5lbC90aW1lL3NjaGVkX2Nsb2NrLmMgfCA0ICsrLS0NCj4gPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3NjaGVkX2Nsb2NrLmMNCj4gPiA+IGIva2VybmVs
L3RpbWUvc2NoZWRfY2xvY2suYw0KPiA+ID4gaW5kZXggODQ2NGM1YWNjOTEzLi44ZTQ5ZTg3ZDEy
MjEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvdGltZS9zY2hlZF9jbG9jay5jDQo+ID4gPiAr
KysgYi9rZXJuZWwvdGltZS9zY2hlZF9jbG9jay5jDQo+ID4gPiBAQCAtMTUwLDggKzE1MCw3IEBA
IHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydA0KPiA+ID4gc2NoZWRfY2xvY2tfcG9sbChzdHJ1
Y3QgaHJ0aW1lciAqaHJ0KQ0KPiA+ID4gICAJcmV0dXJuIEhSVElNRVJfUkVTVEFSVDsNCj4gPiA+
ICAgfQ0KPiA+ID4gICANCj4gPiA+IC12b2lkIF9faW5pdA0KPiA+ID4gLXNjaGVkX2Nsb2NrX3Jl
Z2lzdGVyKHU2NCAoKnJlYWQpKHZvaWQpLCBpbnQgYml0cywgdW5zaWduZWQgbG9uZw0KPiA+ID4g
cmF0ZSkNCj4gPiA+ICt2b2lkIHNjaGVkX2Nsb2NrX3JlZ2lzdGVyKHU2NCAoKnJlYWQpKHZvaWQp
LCBpbnQgYml0cywgdW5zaWduZWQNCj4gPiA+IGxvbmcgcmF0ZSkNCj4gPiANCj4gPiBJcyB0aGVy
ZSBhIG5vbi1pbml0IGNhbGxlcj8NCj4gPiANCj4gPiA+ICAgew0KPiA+ID4gICAJdTY0IHJlcywg
d3JhcCwgbmV3X21hc2ssIG5ld19lcG9jaCwgY3ljLCBuczsNCj4gPiA+ICAgCXUzMiBuZXdfbXVs
dCwgbmV3X3NoaWZ0Ow0KPiA+ID4gQEAgLTIyMyw2ICsyMjIsNyBAQCBzY2hlZF9jbG9ja19yZWdp
c3Rlcih1NjQgKCpyZWFkKSh2b2lkKSwgaW50DQo+ID4gPiBiaXRzLCB1bnNpZ25lZCBsb25nIHJh
dGUpDQo+ID4gPiAgIA0KPiA+ID4gICAJcHJfZGVidWcoIlJlZ2lzdGVyZWQgJXBTIGFzIHNjaGVk
X2Nsb2NrIHNvdXJjZVxuIiwNCj4gPiA+IHJlYWQpOw0KPiA+ID4gICB9DQo+ID4gPiArRVhQT1JU
X1NZTUJPTF9HUEwoc2NoZWRfY2xvY2tfcmVnaXN0ZXIpOw0KPiA+IA0KPiA+IFdoZXJlIGlzIHRo
ZSBtb2R1bGUgdXNpbmcgaXQ/DQo+ID4gDQo+ID4gWW91IG5lZWQgdG8gYnJpbmcgdXNlcnMgb2Yg
dGhlc2UgdHdvIGNoYW5nZXMsIG5vdCBqdXN0IHByZXBhcmUNCj4gPiBzb21ldGhpbmcNCj4gPiBm
b3IgeW91ciBvdXQgb2YgdHJlZSBwYXRjaGVzLg0KPiA+IA0KPiANCj4gSSdkIHByb3Bvc2UgdG8g
YWRkIGF0IGxlYXN0IG9uZSBkcml2ZXIgdGhhdCB3aWxsIG5lZWQgdGhlc2UgY2hhbmdlcywNCj4g
dG8gbWFrZSBpdCANCj4gY2xlYXIgd2h5IHlvdSBuZWVkIHRoYXQuDQo+IA0KPiBSZWdhcmRzLA0K
PiBNYXR0aGlhcw0KDQpJIGhhdmUgdXBsb2FkZWQgYW5vdGhlciBwYXRjaCB0byBtYWtlIHRpbWVy
LW1lZGlhdGVrLmMgZHJpdmVyIGJlY29tZQ0KbG9hZGFibGUgbW9kdWxlLg0KDQoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMTAxMDAwNTguMTk4NjEtMS13YWx0ZXIuY2hhbmdA
bWVkaWF0ZWsuY29tL1QvI3UNCg0KVGhpcyBkcml2ZXIgcmVnaXN0ZXJzIGFuIGFsd2F5cy1vbiB0
aW1lciBhcyB0aWNrX2Jyb2FkY2FzdF9kZXZpY2UgDQpvbiBNZWRpYVRlayBTb0NzLiBJZiB0aGUg
c3lzdGVtIGRvZXMgbm90IGxvYWQgdGhpcyBtb2R1bGUsIHN5c3RlbSANCndvdWxkIGFsc28gYm9v
dCBub3JtYWxseSBzaW5jZSBBcm0gR2VuZXJpYyBUaW1lciB3aWxsIHRha2Ugb3ZlciANCnRoaXMg
cGFydC4NCg0KVGhhbmtzLA0KV2FsdGVyIENoYW5nDQo=
