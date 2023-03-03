Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306E6A916F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCCHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCCHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:06:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEFD1ACCC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:06:38 -0800 (PST)
X-UUID: edcbac82b99111ed945fc101203acc17-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=nhr24+aMPRLL8oqvv8aIzvKu4lGWfd5mkiAOQAomdtU=;
        b=e7faiz1fzYGo7ERC+N0cg00r9/pDjuUCoOlkVIUD1VXm2AUkur0TY0tHO6y24EIoybkqX0eOLBxLB/Kj3z48qrZvLZ0FFCtCWh/d7ipXLkemxrPOKO4ZDQcOpOG/HcIhNjUF4Jv4SaUWeAfMOtN7aeNzmpsJ56MZuU6URSZ54M8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:98e8c67f-0992-432e-9d91-64b9caf06368,IP:0,U
        RL:0,TC:0,Content:34,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:34
X-CID-META: VersionHash:25b5999,CLOUDID:f41b3827-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3|11,EDM:-3,IP:ni
        l,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: edcbac82b99111ed945fc101203acc17-20230303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 380729970; Fri, 03 Mar 2023 15:06:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 15:06:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 15:06:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIu8S+gn3hUX4ujcg6hY7KhquiuighWY1soq0UNVSetoa+4okFcrAWBl/+//mmALY3wDWOZZvzIA/xwoqKIj1bD8+0/hfrSkf0djwwZkjQOCvFxjZ0Zt6r3hJHJRBtDIaPKCn+Ae6by2E6wSPH86VIS/g/AN42IdTbZVI0c0xgOYP7Vd0lhVASUnEQwSnUAJBBox8ejsgd8xeK4NeHyni3TQ+eAZGXPB3pn1yH1bU8mAnEOhLPd8ycGo4mVxrkzTc+BXQlvfzsYfeTCE4nMhNCdzhB67HWsdaogiu86zsmtHZ8p6c1cESFCJe/tb/UGxF78QX8EYlt67WEEmwdxCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhr24+aMPRLL8oqvv8aIzvKu4lGWfd5mkiAOQAomdtU=;
 b=VP0DJISiXm4ZOXJe9YIsWM+QiFKAkYVPIQ+oB8DhW4bedq1GKNTDn9LdtCBxbwvF8tD7n6icypyacsxonvpPacsUYFmG5k8iUh8f/o9fuMRuCq2iI1atazQEpz+lK34xhUmxDD0Sad/r6CUtEH8POw0BbX0oz8o5jSjwTyVSQZuKzzwPp9sZwWIVccxrDEFvC0/Y72em02m2ayn9hpjAyRRAB5idScDeSkyuAedUu2m8l/4ikK7AzkSYT98HURjU8fDUIybHHFXFqYRAWpQIld8PgfkGQnnHUPfVe8YGxZ77M6VsSZx8Q2i4qoGfXMZm8wYwTuwMyLaOA88Wow7gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhr24+aMPRLL8oqvv8aIzvKu4lGWfd5mkiAOQAomdtU=;
 b=tfT/oidH/FdF8GrMqRtz5ayW/w+4b/0KJGwxul4x0qZy0ohF4czV5TEIjQ4IRs4Eha1MIm3VcHKLHwlij4XmGOw24pPhcoO+tbQRL4zVTErSKrFzw8sCKQl2VQNdHKhL1CUDnKq7I4wmU5xuoFvmEPSFbldn5CacjMqGbZiPlCU=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by SI2PR03MB5564.apcprd03.prod.outlook.com (2603:1096:4:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 07:06:26 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4a62:3b6d:5a5a:7c44]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4a62:3b6d:5a5a:7c44%2]) with mapi id 15.20.6156.020; Fri, 3 Mar 2023
 07:06:26 +0000
From:   =?gb2312?B?Q2h1bmh1aSBMaSAowO60urvUKQ==?= <chunhui.li@mediatek.com>
To:     "jstultz@google.com" <jstultz@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "midaschieh@google.com" <midaschieh@google.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wvw@google.com" <wvw@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Thread-Topic: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Thread-Index: AQHZTZ6rZqGgBh6EYU2qRSOlsAtQ0A==
Date:   Fri, 3 Mar 2023 07:06:25 +0000
Message-ID: <79c6432b157a6ed365e2afa0593f67e8cbf5d7b3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|SI2PR03MB5564:EE_
x-ms-office365-filtering-correlation-id: 5e414909-6691-4b9f-16ed-08db1bb5cde3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+6KjGGb0k7a4EB1IUu8NPBEU81mo4mHHNUPOQ4kTscTadfU5KY/N5PfE3QLZUenlyp0CG36JacgYQ1UbQU8Sl4olsMc1KI6ChJwZ6Pu7Poiroaqcbs3oZDZNeSEva7ioJzBes1Tu1bQJUPKS1Myx+95qd3RmK4sRNuoP8MZiaWqdnY9F9sStwlFReZGigXncqgxtuJAPCrUqkN0cmhdWDKUGbkxULrYq7Jbl8OsvHFgKsVjCrxKPwnaxhVX2KVxbHqBA1AdDzFNFCsqcqxnBtRBdMyidB92KFQS4j43O0ZTJvWtOkAdpbbLaCNvVHLvq9HN/Z/5zQPUrd4VFTPts5p/YDkFB9LfkrV40IGKrPkSbcFTETR3O8rPs1Yk9iXlYFW1oZ9A3CLo7/Ck22VjG3JByH25aeG8SGAtUsureA3UScpNz2of6bUEz1qr80Kf4op/BChC4hvEGpFT1kPYN4KsX5mbzORxmTIAsgPRLxYbAxWqhBwmfrDDihNSFV51U3lWiGPAkUHOyi4mtRTZKSqJiDzGwSe9GlJ+GPVdEEyiCuCtM+TGB0/q8Ce2+ETAs5mdSHAQGJjo1cFIa+WIiG6RH6p22uGkG++NhIongFPehavF/XBBLprzGHA7v9GkV4Q5p3TcRukP8BL7HdSfz2trTkIvw7PNpOuluTU8M5X/InlyrKUvG4L00usan8gfPHOFSwtcko/xKed5CFheJSWTKtDaUWp2FkamsqMeoeKq+a0Xh2mZeZ//2ocBSCSk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(6486002)(478600001)(71200400001)(66476007)(76116006)(66946007)(66556008)(6506007)(6512007)(91956017)(2616005)(19618925003)(8676002)(6916009)(4326008)(66446008)(64756008)(41300700001)(8936002)(5660300002)(186003)(7416002)(26005)(4270600006)(2906002)(122000001)(38100700002)(38070700005)(86362001)(54906003)(316002)(36756003)(85182001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OW5lZ3ZISjNRYVRVOUxSVnpSR0pMU2xGR01rNkN2WVg2cHE2M096eTIvUC9U?=
 =?gb2312?B?WlBTTUJpa0piV3dXWlRJNGhVYzRhbzF0Skh0QVlvTlN0U3pjd3lZYVkvUjBp?=
 =?gb2312?B?ekdlQ1BBSFBxN3FucFM4UUgvY2xwdjZ3SE9UVXAwSFErOWVoZXNzMHEzbzM3?=
 =?gb2312?B?cHVJSDBKOFo2bUMzOS9LNHJuVEFvV2o5SDlTMlJFbkVacVRSY1BwNzZMckd1?=
 =?gb2312?B?VXlFWW1NTHMxS2FhcCtGdjBpTHVSR2NuR2s3ckRmQnBGUE13Nk4ydi9LSCsr?=
 =?gb2312?B?cWhjMVNLbVdtYkl1eDZnYmFUVHp1Q3czTld1Y3VPRmgrbnNMcGZwb1pDWkRD?=
 =?gb2312?B?V0I3SVgwaUoyME1tZTVZSjN0dWdmdXpBd3o4VnlpbHU5WWt4ZjJ5WjZtUHJC?=
 =?gb2312?B?aldCOGtYR0tTY1dHOUNOZlFKSUkwOFUrQk9LMk1uVkdkeEZDbmZMdElTRnFk?=
 =?gb2312?B?RG5EOGp1azZpVjdXNmV1RXpHc09mTXRDMzFkQXpBQXp2eTBTV0xDb2h3eWcw?=
 =?gb2312?B?QURDUFdnMHlzRjlUS2M0eUVMTG45VXBlUUNQS3FQZE4xQWRENDZGTFV3T2hZ?=
 =?gb2312?B?WkV2MVJCV0lRUDhvdWFKUHROZEovT05xbGdJV0ZhamRyQzkxc2VEWmxTakhl?=
 =?gb2312?B?a3k3WHZWRmUvdkFsTHdGUmtlSzBYWStJaitNbE1FQ3V1UHA2UTBGcmFKbnQr?=
 =?gb2312?B?LzN0TWx1ZWl4Q1dQU09hWXpIZVJGVDJkWTI0OUV6ZkI3WFAvYitpWk1rTnlr?=
 =?gb2312?B?QUVpWkFTNXFzTGJYYk5wZGJmRWxmRkZZV3J1SjJ6NEhZa1FyM3JHT0IxamMv?=
 =?gb2312?B?Mmh5Zm85cUhtcENKWnZiaFA2VTBpekw1enZuU3dQRmtDTHlJR1EzU2V5V2la?=
 =?gb2312?B?SUpUajRPMXJpaEFzR1hCaSt0YWtzVXVvTk42M2RNL2hHeVhLVWJ2akVmMW5l?=
 =?gb2312?B?SXMrZkJYejVoYzB4MU1FaHdwakk2aEthOWVxRVVkd0FOTmh3UkptRWZpUDB3?=
 =?gb2312?B?TkRmbUlGMElGaTNBZHc5ZkFnV1NXUkVSaVFkYkdCWkpvbzg0OEtMSk9URThI?=
 =?gb2312?B?bDlNRXYyeml1YlJXWmhxeFFHaGs5SlBWa2QvenlRZ0ExcUIrS0pNY3BUNWY4?=
 =?gb2312?B?ZkgrSkdCbmR1bW1sQWpRckFqYVFWcjhOSUVvUzFWNlFhRXJ6WXRJd09KR29n?=
 =?gb2312?B?M1V6b2hoM25mYWtIWlRXN1ljYkhIWGxzOTk2empScWVYN1Q5cnlGNDZPOGZq?=
 =?gb2312?B?bFFva29SajdMUll3NWFBRmFya1VlWTBHWnZJYW5XZ3ZmTkx6NkdUY1BVN2FM?=
 =?gb2312?B?RGhDZ3YzbXRGeThpaFF4NGNvVzZTa0YrS1lTeDJ3eGhvbm9aWDg5VHJVdGU0?=
 =?gb2312?B?dTRmU1RocGRyWkx4UEpUZFptVTVSc3hyaURtbmY4UE5SU0VZczJSNmNtOWlj?=
 =?gb2312?B?OC9EbEp3bEhCZm1tWTgzNG9FSXVOZmZLYUtyZTFIUzZlYVZQbm1VcnRIbUJv?=
 =?gb2312?B?bGNKOWtLT2xtelJFTk9iNVR6ODBMbmx3MFNmdEVDam81S2RvVW1xZ09KWE5l?=
 =?gb2312?B?NTh5TWd4N3NjQ2RNSlloT29tU0FHY1VLMXl1dTljTVlvcFNwSGx3ZHFLZ25k?=
 =?gb2312?B?bVlYMm9veVNVbGc5ZG0xcmVHN242WThOUkNsZG41bmZGM1JCalhEZ1BZaEM1?=
 =?gb2312?B?SjVlM0R2RjRxVlkxWUhObGVNOUUzVVRLZ2hLNVBZc2srM2VvcENKTUVPd0Fm?=
 =?gb2312?B?a2FvaVdNUmY1bXRJRGx5Y3dsQ2lPS25hL2NxeXVhNHRZZDlJd0czeFRLQ3FO?=
 =?gb2312?B?YmFKcVNhYkY0MUZHQkV0d1FpbGU4d3d0dFFIbU41YWtTR0dzUnpPTU1WSHgy?=
 =?gb2312?B?aUUyNzkzSEYzN3pSUEdBWGNmQzVOTis0dTJHODZ0bGd0cmM1cFg2WTg1WmV0?=
 =?gb2312?B?U1hMMHJ2Q3F5VFMzcDRWUE1QVTByTmxZUlA1YXNOTWlxWTM0aWc0MTU4Ry9o?=
 =?gb2312?B?WE9iaXYrdE5Pc3lmTGZXN1pXZTJLVEd4ZEJIOXZoZ0Q5NTJ2TEVRU0k4WWNK?=
 =?gb2312?B?OWxPOUM0SDBhK200T3NXVThCZkpxRGg2QzVJOFFPNnJTcE1RcVZIRWR1Qkt1?=
 =?gb2312?B?Y25DeTExMUtmVVpsaEZZU0d4Q2NZWjB4Uy9saUxVcVlWQ0Z2aFpVNVl1WlRa?=
 =?gb2312?B?NkE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e414909-6691-4b9f-16ed-08db1bb5cde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 07:06:26.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8HGdJjZdTcbs2+5qPWu4wBMI2YQcUCQNmFi81gDdrEciooWZIQnBWszJeO5uRHC7pTbzhO+aj4iXsp3G8UmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5564
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBDaHVuaHVpIExpIDxjaHVuaHVpLmxpQG1lZGlhdGVrLmNvbT4NCg0K
