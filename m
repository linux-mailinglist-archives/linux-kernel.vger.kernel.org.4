Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AD71A10B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjFAOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjFAOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:53:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50832132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:53:52 -0700 (PDT)
X-UUID: 1b3f2194008c11eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gCLkoPD/yaC4RiRuvsgex3F6Yed1PUSsgSBGhFQEzyo=;
        b=UufGFYEgudvnVLV2ezMr/3chB2n4+OJRn133RY9/rYRTrMUS+8fgeaV2MksJSY/zdiS+l+TdSx3zoxFDo5m+YEoQayFBicEqU3ZtpZaAbkFq481R5fK6HzIl0TYfbx+6UNwa7xFA4HRoZ9XTC4z4NJ/CgbkD0C/IyvGA9Vscm58=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:f08bb277-d19b-431c-a897-54f6a45a52b0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:402d473d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1b3f2194008c11eeb20a276fd37b9834-20230601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 545046838; Thu, 01 Jun 2023 22:53:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 22:53:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 22:53:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCNrYALtx5FoDjJ2ELhis8EpW+95tcpkG2iwG5VwQcs+o/uJMKHAlpPjOnJCrl/onjUaZ+GbHZ/Sq0yvyaITb0ryEL6WWWYCcwGeHYRikzpTNyAZPKYNVmnlXTW9FYpjje9gywak+8XkOiTDqE72ixEwa/xcGApyBNfPnpDK9UouHTHJlKc5/odLY8mr7RLy5QbkzBriAPthha/5nOP/yvD+wD+ETvhbR7Dj/pviCes4kDriYdustzY6iWQtJWEETv8F2ys0vaLvTOhKbn7d2cq9366GvuUmFvANKgNVi2nzcVfPi4jF663JUBoP8aOHqjZkJJsljrNL4ezPc6Rayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCLkoPD/yaC4RiRuvsgex3F6Yed1PUSsgSBGhFQEzyo=;
 b=RzqNTA7LO6PxFbQUoz41Bo/OatvXS507CjVl5EbedDZxMTJmTo5GATUre9+AuY4yCcJhIdenLYoTy5v0DvMxwDRioUVa46rRYXflblEStNYKbN27cUe8gWbGiGS8WT4fXUk45W17S+KzRwlzxeRgfdFMZ8PNOSrH5ujrrdSv3KAjD5D5xqEaKH/5qneAtp5HN+w68gd2gjS/1R+rSVDlgj+emhC+kNV6JH6LXUJtm+lEQmqij9UDCoaDevDUyfTLAJ7QFDGe7+6QYjeI7aYcF1B8mLThgqoMvXPEtfXK314Scz4CQYsijCRVDhKhRoR/hfxLr/4hm3jQ7Q3R15NGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCLkoPD/yaC4RiRuvsgex3F6Yed1PUSsgSBGhFQEzyo=;
 b=KeCeQY2V/lb0DeaUiJOjc6T8O/1gNFaRxOG1LC0a2XnA0tJ+uPjjkgwYA1Uxgt3qSq3c/Oo5CGfwsgFUean4PYFOGTWfAkg2uB/Qj9CGg5+2Zsb/x0pWDRQbxfExzlRs9hTkqPkEADHrnarIj50Swtw1qkucvfTo7DL8hvG8qIw=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by SEZPR03MB7486.apcprd03.prod.outlook.com (2603:1096:101:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Thu, 1 Jun
 2023 14:53:40 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::604c:2481:85d3:9347]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::604c:2481:85d3:9347%5]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:53:40 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v3 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Topic: [PATCH v3 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Index: AQHZgogz9De55le0Gk+ANY/gfUaNAq9f0V6AgBZbRIA=
Date:   Thu, 1 Jun 2023 14:53:40 +0000
Message-ID: <f1db85a9d90dac2aea091a6b7d751a2076879506.camel@mediatek.com>
References: <20230509150737.8075-1-jason-jh.lin@mediatek.com>
         <20230509150737.8075-2-jason-jh.lin@mediatek.com>
         <4ebdee84-9c02-b8fc-9f52-2da91fd3c82c@collabora.com>
In-Reply-To: <4ebdee84-9c02-b8fc-9f52-2da91fd3c82c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|SEZPR03MB7486:EE_
x-ms-office365-filtering-correlation-id: d5b1ada9-fd01-4d9b-6d0d-08db62affcb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRH+ck+8sNJeM/Em0ExBd2ZuP1ta11sa5t9vOH6Y+H66cYtgfz5MF1CqHVCi4UKcQNzSlVpzgWLcxirUBO0jR8+TSLLoUKBAjIDp4VJODzYF8b6IUvVli+o95avg/b7F+H/8HqWGltPiKHPxBXIpG57tZb5d2jpLUPZX3qOCnhJTsaL72dhn6wWUEKaYCVYJvMyFS5IgCGbvCSmZa9Zzp0w91gTj7mJBKT7Tjo8HbqzoV6wnDhQNf9LeXYOF5bx7Lxt4adNK3zrQKf4xJJRsht1eMQirx5FPelCDzm+IN0YtpcSdF3hAPgRmz4IfXkJhq8FmknYxNTo8u9Aove6yFMCMgJRKRG1Jz9M4n++0ag4HNL037v4L60dToIhjnGcjfrThWCM4a7HMkHGy4BSBTp2rJFApBmNptk94HhUwLtYRsAV7xKFWAYK8jyymyvHej9HQL7wXqVQNYvqD6A7MjhVyO1DApDgQKrkMvPshcLx6v9Md4Tu5mPrL0uAzJ5XNcMvsVyKhNtbkndH/6NcQWk1LVxsEccy43PtTCKSW+zZCB7VB8csMIeBkRsKdgkcRa0m93yBV9cglwywP89n+LtAxnit1rUTlNvs57lMC27g3Xjiqq6EfCBQ+iaXAYXmC4KvOM4Y+kr4dXya2/3eChAhABG3vOQeasUQJ1YiD99E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(38100700002)(478600001)(2906002)(186003)(6506007)(26005)(6512007)(5660300002)(8676002)(54906003)(8936002)(2616005)(122000001)(110136005)(83380400001)(107886003)(38070700005)(86362001)(6486002)(41300700001)(316002)(66946007)(36756003)(4326008)(76116006)(85182001)(91956017)(64756008)(66476007)(71200400001)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MCtlSzM0WXJlS3NiWEkyWVE5TjdIQ1dQckpwWXhZK3JvSk1LY0xqdHdBL1Fj?=
 =?utf-8?B?Sm5oNVJpbmN6VFNFeDd2ZU8rTHJZOEoxTmVBd3RUazRlRVhsVkI2VTBLbmxn?=
 =?utf-8?B?dmp6SEltM3E2bHYva3dSWk1Wakxpcnk1cFAzK2RjUnI2c0hiOXZxdS9iRUEz?=
 =?utf-8?B?K21zemIxNXZXdWxsQ3VkMkZnMEhjSFlYTW5qU0hVRWRTdXRZVUd4WGtva2JF?=
 =?utf-8?B?bUVmb1Z4MjFkU3BkOFRIbnErQTlEaVJYK0syeEJoSnJsS3gwS2x4RmMvamJK?=
 =?utf-8?B?WkdicVA2OGVjejBheHcvZzVQQXJSWUlhSXZqL29TalNwd3V3Z1FMYmpQdXhs?=
 =?utf-8?B?T1ZiSDZqVHlsa2tZY1IwL2FtTGZUTzhQVDFKb0JhMnV4NjBML3k0U241RmRZ?=
 =?utf-8?B?UnF1MnN4K0Z4emdZc0VPaGtsNFYxRWRKRk1nMXpmN0JocUlsMXZBbDUwRnNR?=
 =?utf-8?B?Z0hsby9BdXVpME9iRXJnYjVDRVBmM0xZSkE5K3YzRGpvUHExYm1WTlJnNjV1?=
 =?utf-8?B?dkc0MGhkbUVzVExOU1hGL3R1UXVObWtWd1NiMXg3VDMraG9QNktRQmVheXI4?=
 =?utf-8?B?dFFhU2IxUEhpZmJFL2VzRzVKRWdUbWR3b2xGSDVjTHhMSHdPK3R2UXhYK2RR?=
 =?utf-8?B?ejZCTzlTU3owQlNLc2VpRWtNcFptWHVhc3ZaVzNVUHNZY2M4ZjQ2eFBRQWdV?=
 =?utf-8?B?V2EyVjBMRXkxUnp2Wksyam1lWUNSYTBxbnBFTFpjR0Njd1J2VnV5ZkFlMm1Q?=
 =?utf-8?B?ZXZUU0w5SVBiK1ZHMmxpNndDRmZIdkxNNjJSZ3l0Zm85RmxZbTBBbDNockNy?=
 =?utf-8?B?TUo2MXV6NmVvL1V2M3krMCs2WG5aVmh0Szc5RkZNRVJ4SGVESE5UQ3QwdDZ6?=
 =?utf-8?B?K1FydFc4VFJjZERJVDJNZEJjdDE0eGZrbFBxV3lBMFpPVDR0ZGUzaHpEa0ZC?=
 =?utf-8?B?TFVIOXB6RnhKQ1dzazBkc1F2TzJkakMzZ2ZUOHJXdGJ1SGsvRkxEZk9BNm5F?=
 =?utf-8?B?UmhJbjMyUnFEbzE1YXlONUh0TjZYNm5YaThrNnY0RVRzOUt6Vk8yWGpLdC8v?=
 =?utf-8?B?dGlyR0lwTjJxcTZqQUhBbGg3SUp1ZHRqOHJYWGtTQmtNUmtyQUs0YlpEdzcy?=
 =?utf-8?B?c0VNSHcxdWU5MEpiNnZXYmlwaWhWOHZGN01UL2E0Q0RLbXlPQVpzU1FVY1Er?=
 =?utf-8?B?UE8xSmxBcFpHYmNMVFlmb2xjcUgzNGJoVUQ5ZUlVZmVuZlFMTFdWekJXWnE4?=
 =?utf-8?B?NlF3blZVekhMcHVteXJtNlQwNWg4NDI5cXZXME00VTMwZUtwRVZ1dVZyUDdy?=
 =?utf-8?B?dUljN09SZjJRMzZ4UmxFbHRIY0oxa2NIQlYyV2FuZmZJczlVREZtdHljcXFU?=
 =?utf-8?B?b0RKeXFHb1BRNjZaTks4bGlzT3JQbGV5KzgzczBDb0pwUXFmVUczb0g2bjND?=
 =?utf-8?B?d3BQNWQ2RlpaTFdZQlo2OU9DM2tQbk8xYnpRVFB0dEE5ZFhsUWhhaC9mV1Rt?=
 =?utf-8?B?VjdOSWRJUENXZGRoQ1Nwd21XZG4rY0pVV0NibHFxZld1OFlVZFk5Z2pDbmN0?=
 =?utf-8?B?cmw2S0cxOG1Pc2FBSWNCYlNSWjFJWkNJR1ZKMitQYXMreXZZOEJWNUJMS3Vx?=
 =?utf-8?B?bEF4eXhmcmwyRW9tMHh5aElRcHE0YzJ5RVpxTVoyNGViVG13L0ZoVWxpaEF6?=
 =?utf-8?B?em9DMFM2dmoyVWFFc21UTk9QVGNwSGZ6bzJ5YVBBODVaN0FPWFVHWm91c3Rw?=
 =?utf-8?B?L1dqcEpYZ2hMZE5jMlpvWkp5b2NQc0FVN1FqUU1LVExpaE5OSjBKaWNDaXp5?=
 =?utf-8?B?SVlKQlZmbjhETHI4UjA2MmMwQXc0YnRIU3VneDdUWmQ4SzE1eHhsUklqMkph?=
 =?utf-8?B?dFNteFpGZUticVdLY0YvNGNqcHhJcmJGUjFVTDhnM25yS2ptenlpNVVLdGt3?=
 =?utf-8?B?YjhFQXhuU1VyVDdJa0M1ay9zRGxsWGIzOUIzZWxNdmdvVGRjQURIajVoR2dy?=
 =?utf-8?B?MllaK1Y4a3YvZCtwcHlXNm1ZMEtaT2ZsRllUL2tPY3R5MkhhOUdVVCtMTjc5?=
 =?utf-8?B?TCt6dC9MdVl6Z0Q1NTBRZHMwc2ZsWktmbkZ3bDZVZlVMcVl1Um9oa2I2Z2d5?=
 =?utf-8?B?TEk1T2FCcVA2d01Xcmo5WlpabEtGT3hIc1E5ZkQvOWw1S05JUWJvWnZXMWZ5?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C0AA23D20088408A51BCCAA63C0FDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b1ada9-fd01-4d9b-6d0d-08db62affcb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 14:53:40.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvrvgPhIqCOslJYOnPBv3CZa9za2mpfKow0nP6+2zncr0J7VZRjW3IUZrylPLiZuGGbMWc3JVaaFXvmbiF0ASCwAFUuqeTxjQqZbYDU+oG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHNvcnJ5IGZvciB0aGUgbGF0
ZSByZXBseS4NCg0KDQpPbiBUaHUsIDIwMjMtMDUtMTggYXQgMTE6MjkgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IElsIDA5LzA1LzIzIDE3
OjA3LCBKYXNvbi1KSC5MaW4gaGEgc2NyaXR0bzoNCj4gPiAxLiBNb3ZlIG91dHB1dCBkcm0gY29u
bmVjdG9yIGZyb20gZWFjaCBkZHBfcGF0aCBhcnJheSB0byBjb25uZWN0b3INCj4gPiBhcnJheS4N
Cj4gPiAyLiBBZGQgZHluYW1pYyBzZWxlY3QgYXZhaWxhYmxlIGNvbm5lY3RvciBmbG93IGluIGNy
dGMgY3JlYXRlIGFuZA0KPiA+IGVuYWJsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5j
eSBMaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF0aGFu
IEx1IDxuYXRoYW4ubHVAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpI
LkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgfCAgIDEgKw0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgICAgICB8ICAgOSArKw0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDExMQ0KPiA+ICsrKysr
KysrKysrKysrKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmggICAgIHwgICA1ICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jIHwgIDI3ICsrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5oIHwgICA4ICsrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYyAgICAgIHwgIDQ0ICsrKysrKy0tDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgIHwgICA4ICsrDQo+ID4gICA4IGZpbGVzIGNo
YW5nZWQsIDIwMiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBpbmRleCAyMjU0MDM4
NTE5ZTEuLjcyYzU3NDQyZjk2NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmgNCj4gPiBAQCAtNDQsNiArNDQsNyBAQCB2b2lkIG10a19kaXRoZXJfc2V0
X2NvbW1vbih2b2lkIF9faW9tZW0gKnJlZ3MsDQo+ID4gc3RydWN0IGNtZHFfY2xpZW50X3JlZyAq
Y21kcV9yZWcsDQo+ID4gDQo+ID4gICB2b2lkIG10a19kcGlfc3RhcnQoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gPiAgIHZvaWQgbXRrX2RwaV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4g
K2ludCBtdGtfZHBpX2VuY29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiANCj4g
PiAgIHZvaWQgbXRrX2RzaV9kZHBfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgIHZv
aWQgbXRrX2RzaV9kZHBfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gaW5kZXggOTQ4YTUzZjFmNGIzLi43NjVmYzk3NmU0
MWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gPiBAQCAtNzgy
LDYgKzc4MiwxNSBAQCB2b2lkIG10a19kcGlfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4g
ICAgICAgbXRrX2RwaV9wb3dlcl9vZmYoZHBpKTsNCj4gPiAgIH0NCj4gPiANCj4gPiAraW50IG10
a19kcGlfZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArICAg
ICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKyAgICAg
aW50IGVuY29kZXJfaW5kZXggPSBkcm1fZW5jb2Rlcl9pbmRleCgmZHBpLT5lbmNvZGVyKTsNCj4g
PiArDQo+ID4gKyAgICAgZGV2X2RiZyhkZXYsICJlbmNvZGVyIGluZGV4OiVkIiwgZW5jb2Rlcl9p
bmRleCk7DQo+ID4gKyAgICAgcmV0dXJuIGVuY29kZXJfaW5kZXg7DQo+ID4gK30NCj4gPiArDQo+
ID4gICBzdGF0aWMgaW50IG10a19kcGlfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBk
ZXZpY2UNCj4gPiAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVj
dCBtdGtfZHBpICpkcGkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBpbmRleCBkNDAxNDI4NDJmODUuLjU0
ZDQ4OTMyYjgzMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMNCj4gPiBAQCAtNjAsOCArNjAsMTIgQEAgc3RydWN0IG10a19kcm1fY3J0YyB7DQo+ID4g
ICAgICAgc3RydWN0IGRldmljZSAgICAgICAgICAgICAgICAgICAqbW1zeXNfZGV2Ow0KPiA+ICAg
ICAgIHN0cnVjdCBkZXZpY2UgICAgICAgICAgICAgICAgICAgKmRtYV9kZXY7DQo+ID4gICAgICAg
c3RydWN0IG10a19tdXRleCAgICAgICAgICAgICAgICAqbXV0ZXg7DQo+ID4gKyAgICAgdW5zaWdu
ZWQgaW50ICAgICAgICAgICAgICAgICAgICBkZHBfY29tcF9ucl9vcmk7DQo+ID4gKyAgICAgdW5z
aWduZWQgaW50ICAgICAgICAgICAgICAgICAgICBtYXhfZGRwX2NvbXBfbnI7DQo+ID4gICAgICAg
dW5zaWduZWQgaW50ICAgICAgICAgICAgICAgICAgICBkZHBfY29tcF9ucjsNCj4gPiAgICAgICBz
dHJ1Y3QgbXRrX2RkcF9jb21wICAgICAgICAgICAgICoqZGRwX2NvbXA7DQo+ID4gKyAgICAgdW5z
aWduZWQgaW50ICAgICAgICAgICAgICAgICAgICBjb25uX3JvdXRlX25yOw0KPiANCj4gYG51bV9j
b25uX3JvdXRlc2AgaXMgY2xlYXJlci4NCj4gDQpPSywgSSdsbCBtb2RpZnkgaXQuDQoNCj4gPiAr
ICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RybV9yb3V0ZSAgICAgICpjb25uX3JvdXRlczsNCj4gPiAN
Cj4gPiAgICAgICAvKiBsb2NrIGZvciBkaXNwbGF5IGhhcmR3YXJlIGFjY2VzcyAqLw0KPiA+ICAg
ICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgICAgICAgICAgaHdfbG9jazsNCj4gPiBAQCAtNjQ5
LDYgKzY1Myw4NCBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfZGlzYWJsZV92Ymxhbmsoc3Ry
dWN0DQo+ID4gZHJtX2NydGMgKmNydGMpDQo+ID4gICAgICAgbXRrX2RkcF9jb21wX2Rpc2FibGVf
dmJsYW5rKGNvbXApOw0KPiA+ICAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdW5zaWduZWQgaW50IG10
a19kcm1fY3J0Y19tYXhfbnVtX3JvdXRlX2NvbXAoc3RydWN0DQo+ID4gbXRrX2RybV9jcnRjICpt
dGtfY3J0YykNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBtYXhfbnVtID0gMDsNCj4g
PiArICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFtdGtfY3J0Yy0+
Y29ubl9yb3V0ZV9ucikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiAr
ICAgICBmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmNvbm5fcm91dGVfbnI7IGkrKykNCj4gPiAr
ICAgICAgICAgICAgIG1heF9udW0gPSBtYXgobXRrX2NydGMtPmNvbm5fcm91dGVzW2ldLnJvdXRl
X2xlbiwNCj4gPiBtYXhfbnVtKTsNCj4gDQo+IElmIHdlIHJlbmFtZSB0aGlzIHRvIGBudW1fcm91
dGVzYCBvciBgbWF4X3JvdXRlc2AgaXQgYmVjb21lcyBhIGJpdA0KPiBtb3JlDQo+IHVuZGVyc3Rh
bmRhYmxlLg0KPiANCk9LLCBJJ2xsIG1vZGlmeSBpdC4NCg0KPiA+ICsNCj4gPiArICAgICByZXR1
cm4gbWF4X251bTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfZHJtX2NydGNf
dXBkYXRlX291dHB1dChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KPiA+
ICt7DQo+ID4gKyAgICAgY29uc3Qgc3RydWN0IG10a19kcm1fcm91dGUgKmNvbm5fcm91dGVzOw0K
PiA+ICsgICAgIGludCBjcnRjX2luZGV4ID0gZHJtX2NydGNfaW5kZXgoY3J0Yyk7DQo+ID4gKyAg
ICAgaW50IGk7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICsgICAgIHN0cnVj
dCBkcm1fY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSA9IHN0YXRlLQ0KPiA+ID5jcnRjc1tjcnRjX2lu
ZGV4XS5uZXdfc3RhdGU7DQo+ID4gKyAgICAgc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMg
PSB0b19tdGtfY3J0YyhjcnRjKTsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX2RybV9wcml2YXRlICpw
cml2ID0gY3J0Yy0+ZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgY29t
cF9pZDsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgZW5jb2Rlcl9tYXNrID0gY3J0Y19zdGF0ZS0+
ZW5jb2Rlcl9tYXNrOw0KPiA+ICsgICAgIHVuc2lnbmVkIGludCByb3V0ZV9sZW4gPSAwLCByb3V0
ZV9pbmRleCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghbXRrX2NydGMtPmNvbm5fcm91dGVf
bnIpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgcHJpdiA9
IHByaXYtPmFsbF9kcm1fcHJpdmF0ZVtjcnRjX2luZGV4XTsNCj4gPiArICAgICBkZXYgPSBwcml2
LT5kZXY7DQo+ID4gKw0KPiA+ICsgICAgIGRldl9kYmcoZGV2LCAiY29ubmVjdG9yIGNoYW5nZTol
ZCwgZW5jb2RlciBtYXNrMHgleCBmb3INCj4gPiBjcnRjJWQiLA0KPiA+ICsgICAgICAgICAgICAg
Y3J0Y19zdGF0ZS0+Y29ubmVjdG9yc19jaGFuZ2VkLCBlbmNvZGVyX21hc2ssDQo+ID4gY3J0Y19p
bmRleCk7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghY3J0Y19zdGF0ZS0+Y29ubmVjdG9yc19jaGFu
Z2VkKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsgICAgIGNvbm5f
cm91dGVzID0gbXRrX2NydGMtPmNvbm5fcm91dGVzOw0KPiA+ICsNCj4gPiArICAgICBmb3IgKGkg
PSAwOyBpIDwgbXRrX2NydGMtPmNvbm5fcm91dGVfbnI7IGkrKykgew0KPiA+ICsgICAgICAgICAg
ICAgcm91dGVfbGVuID0gY29ubl9yb3V0ZXNbaV0ucm91dGVfbGVuOw0KPiA+ICsgICAgICAgICAg
ICAgaWYgKHJvdXRlX2xlbiA+IDApIHsNCj4gDQo+IHJvdXRlX2xlbiBpcyB1bnNpZ25lZCwgaXQg
Y2FuIG5ldmVyIGJlIDwgMCwgc28uLi4NCj4gDQo+ICAgICAgICAgICAgICAgICBpZiAocm91dGVf
bGVuKSB7DQo+IA0KSXQncyBiZXR0ZXIgdG8gdXNlIHVuc2lnbmVkIGludC4NCkknbGwgbW9kaWZ5
IGl0Lg0KDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBfaWQgPSBjb25uX3JvdXRlc1tp
XS5yb3V0ZV9kZHBbcm91dGVfbGVuDQo+ID4gLSAxXTsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgaWYgKHByaXYtPmNvbXBfbm9kZVtjb21wX2lkXSkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICgoMSA8PCBwcml2LQ0KPiA+ID5kZHBfY29tcFtjb21wX2lkXS5lbmNv
ZGVyX2luZGV4KSA9PSBlbmNvZGVyX21hc2spIHsNCj4gDQo+IFRoaXMgaXMgZWZmZWN0aXZlbHkg
QklUKCkuDQo+IA0KPiBpZiAoZW5jb2Rlcl9tYXNrID09IEJJVChwcml2LT5kZHBfY29tcFtjb21w
X2lkXS5lbmNvZGVyX2luZGV4KSkgew0KPiANCj4gUC5TLjogQXJlIHlvdSBzdXJlIHRoYXQgdGhp
cyBzaG91bGRuJ3QgYmUgKGVuY29kZXJfbWFzayAmDQo+IEJJVChlbmNvZGVyX2luZGV4KSk/Pw0K
PiANClllcywgZW5jb2Rlcl9pbmRleCBzaG91bGQgYmUgYml0d2lzZS4gSSdsbCBmaXhlZCBpdC4N
Cg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm91dGVfaW5kZXgg
PSBpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICB9DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gDQo+IC4u
c25pcC4uDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
aA0KPiA+IGluZGV4IDNlOTA0Njk5M2QwOS4uNjcyYjljN2FmZWU2IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaA0KPiA+IEBAIC04LDYgKzgsNyBAQA0K
PiA+IA0KPiA+ICAgI2luY2x1ZGUgPGRybS9kcm1fY3J0Yy5oPg0KPiA+ICAgI2luY2x1ZGUgIm10
a19kcm1fZGRwX2NvbXAuaCINCj4gPiArI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ID4gICAj
aW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0KPiA+IA0KPiA+ICAgI2RlZmluZSBNVEtfTFVUX1NJ
WkUgICAgICAgIDUxMg0KPiA+IEBAIC0xOCw3ICsxOSw5IEBAIHZvaWQgbXRrX2RybV9jcnRjX2Nv
bW1pdChzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOw0KPiA+ICAgaW50IG10a19kcm1fY3J0Y19jcmVh
dGUoc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IHVuc2lnbmVkIGludCAqcGF0aCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IHBhdGhfbGVuLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBpbnQgcHJpdl9k
YXRhX2luZGV4KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgaW50IHByaXZfZGF0YV9pbmRl
eCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IG10a19kcm1fcm91dGUg
KmNvbm5fcm91dGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY29u
bl9yb3V0ZXNfbnVtKTsNCj4gDQo+IG51bV9jb25uX3JvdXRlcyBsb29rcyBiZXR0ZXIuDQoNCk9L
LCBJJ2xsIG1vZGlmeSBpdC4NCj4gDQo+ID4gICBpbnQgbXRrX2RybV9jcnRjX3BsYW5lX2NoZWNr
KHN0cnVjdCBkcm1fY3J0YyAqY3J0Yywgc3RydWN0DQo+ID4gZHJtX3BsYW5lICpwbGFuZSwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0
ZSk7DQo+ID4gICB2b2lkIG10a19kcm1fY3J0Y19hc3luY191cGRhdGUoc3RydWN0IGRybV9jcnRj
ICpjcnRjLCBzdHJ1Y3QNCj4gPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gaW5kZXggZjExNGRhNGQz
NmE5Li5mZTIwY2UyNmIxOWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gaW5kZXggZmViY2Fl
ZWYxNmExLi4xYzFkNjcwY2ZlNDEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gPiBAQCAtODAsNiArODAsNyBAQCBzdHJ1Y3QgbXRr
X2RkcF9jb21wX2Z1bmNzIHsNCj4gPiAgICAgICB2b2lkICgqZGlzY29ubmVjdCkoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ID4gKm1tc3lzX2RldiwgdW5zaWduZWQgaW50IG5l
eHQpOw0KPiA+ICAgICAgIHZvaWQgKCphZGQpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG10
a19tdXRleCAqbXV0ZXgpOw0KPiA+ICAgICAgIHZvaWQgKCpyZW1vdmUpKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IG10a19tdXRleCAqbXV0ZXgpOw0KPiA+ICsgICAgIGludCAoKmVuY29kZXJf
aW5kZXgpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IA0KPiBkcm1fZW5jb2Rlcl9pbmRleCByZXR1
cm5zIGFuIHVuc2lnbmVkIGludCB0eXBlLCBzbyB0aGlzIG9uZSBjYW4gbmV2ZXINCj4gYmUgbmVn
YXRpdmU6DQo+IHBsZWFzZSBjaGFuZ2UgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGlzIGZ1bmN0aW9u
IHRvIHVuc2lnbmVkIGludCB0eXBlLg0KPiANCk9LLCBJJ2xsIG1vZGlmeSBpdC4NCg0KPiA+ICAg
fTsNCj4gPiANCj4gPiAgIHN0cnVjdCBtdGtfZGRwX2NvbXAgew0KPiA+IEBAIC04Nyw2ICs4OCw3
IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXAgew0KPiA+ICAgICAgIGludCBpcnE7DQo+ID4gICAgICAg
dW5zaWduZWQgaW50IGlkOw0KPiA+ICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVu
Y3MgKmZ1bmNzOw0KPiA+ICsgICAgIGludCBlbmNvZGVyX2luZGV4Ow0KPiANCj4gU2FtZSBoZXJl
LCB1bnNpZ25lZCBpbnQuDQo+IA0KT0ssIEknbGwgbW9kaWZ5IGl0Lg0KDQpSZWdhcmRzLA0KSmFz
b24tSkguTGluDQoNCj4gPiAgIH07DQo+ID4gDQo+ID4gICBzdGF0aWMgaW5saW5lIGludCBtdGtf
ZGRwX2NvbXBfY2xrX2VuYWJsZShzdHJ1Y3QgbXRrX2RkcF9jb21wDQo+ID4gKmNvbXApDQo+IA0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0K
