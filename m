Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841072DC67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjFMI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbjFMI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:26:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25612C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:26:31 -0700 (PDT)
X-UUID: fd0589ca09c311eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6JpZQbU46HUfwtLI1BuldOCoAyVzezCs45AMzCa76Lo=;
        b=RPlbFPMb+Dz9LnXKqwGM3krJ4g5XeG5dOqEqOfBdPda1UkyakOjvFObAlbpFQ/Bnl81V7oXPTmLfKgJd3aWIwTqDMN+Au1S/JOBpVdO4nz5nypH+jL2yUzW19zamzxPG8SE79Ij7CcowleiROSRahcSkYTgPIhBN096aYKfPHcE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:c7bd0d5c-b5d0-4f76-9777-ab133a22f372,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:691d763e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fd0589ca09c311eeb20a276fd37b9834-20230613
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1544002645; Tue, 13 Jun 2023 16:26:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 16:26:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 16:26:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7pT9avLEgdD+vTm4baZ8cFkMNGHgtFxcUedEbDQTjkhTSFPyDDcDlscpyfqc/5FgxDQ5qp2SNR15yEfRAyneCtPaGUTWcDuW4raeqF5j2pQPK8zLRWkbkXq1TllNpTdWhQ10/9x6WMRcMsIAfE2dYCH/2f+ssXN5trrpT+a9L5EBk8oEZshMG98rZ7C4w7pxmW5R+SLa9j63QH+3HbvnWnU5nzjb4KHSlMkOjyyOmEPjVV9p4mKb8kfMfuUzgUjT8kUazu3E7ZwD6UitTvfsdZ5ca4XVHUmOatgq2TcCF4+3U4XJNbV8jPZwWrDyR7r80hgU72bjWMS5H293nvt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JpZQbU46HUfwtLI1BuldOCoAyVzezCs45AMzCa76Lo=;
 b=SZWoOOwWmUZYw/bMDNt9OmF3cVhXN/PXqc2uoT0sqHoS3mn5OJtC6fJNe9IUl5mQD5hYlhAxb1lJJiEW8kZIu2gA1YZEhhzbiUF6kCA875vSpgY/ygG7UsrX+3571G5Z3eSwUFlCEcFdhrpRdSHIibSqRX0PhQznwHDqYTwpmJoZXY8AbIPmeD/oxE+dz9mQ7Z2plkSzck7uz2SDMHf9rSf1uJFsDIzxS8L6R9uKZKxTvkEUZM/IYixhWnBgKLGrUsxoxXfhd7hNs9pzagiCjUjB+9+zQ77sfiPfzaAmf2zG0c2EucG7ueMO10KH7vFpX8S8Mx512GjpeES8rcr5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JpZQbU46HUfwtLI1BuldOCoAyVzezCs45AMzCa76Lo=;
 b=wPf7grydsjF6vqJRypoDe3PmOQiiPdmcRD6E5YhmCAx4hej4gDcVxM5HUVTIw1/zyj03Fh5OAKi2ssn23zCw2D6f6jL7hCfKlcR20qJmc2JRKNMcQjBcbCrJVDbVkvHogIxmHMO2TP5K5RZkgEJxMtNzT4iiFque/3EUNi86ezY=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5717.apcprd03.prod.outlook.com (2603:1096:301:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 08:26:21 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 08:26:21 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 4/5] drm/mediatek: Add casting before assign
Thread-Topic: [PATCH 4/5] drm/mediatek: Add casting before assign
Thread-Index: AQHZaRzW7WJf0awPwkuKkqYxGwq11K+HR8eAgAGHdQA=
Date:   Tue, 13 Jun 2023 08:26:21 +0000
Message-ID: <41b13866830ef087bbc9d4618df7aee1c1db2967.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-5-jason-jh.lin@mediatek.com>
         <de84475a9d9cc7b4381b79e0be023fc9886b9103.camel@mediatek.com>
In-Reply-To: <de84475a9d9cc7b4381b79e0be023fc9886b9103.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5717:EE_
x-ms-office365-filtering-correlation-id: e35baf9e-f0c6-4013-53ca-08db6be7de5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaCIM8ab0AKOpf10rFQbDHzgIUkW9jA4rVlopB9ob1xnOVQvaimHF580Cqm6yAfvNRie7yXGG9TQGuNqOSC+3B7FIp135OobAVXFkBy3/0qTnCu6pOg+xC5IzCFsXzVOQWYdIaYst/xLx7l8lGGMBfaP+YLwsSZLHx4y1fqTnBISeuJyLBrrQbth59tJExWigEBKdGW1fm3j6AD1yUG2ykyOb9FvZ1MKl9COdV1p6HTcw4S9f4JKgi7vY2NVo8abZtfz8qrDwaNuTOqyozeXSsyOAWoMFS9yewib85hRJ4a4ZlZEBKyHV137j3hUWJlLYdjMZBfKc7lty7GJoBVX8PATJ6Y9QsaTm0HbT7K/re/KBqx9GLzsrnLeRI3rKs15KnHz50m7AvwhvGw4fYUOM3yT4Rll3GxkRRBTXwrz0zr/XFRt8hrE+8k1OAaIKakc3yfE6Rm3fksZyvPOUboRor0WGAMvRHwl7+5gePrIk2ETN7XkB0PIOu2te4aEm+PnNjzQofgg98m7WiIVowuhDbL24BEgCORZEJ7iMZ/kYsM7pCM+uCneQE8lruGK0+dVY8ABpCwxwA6ufoqJxEoxJipom6Q4NuChATsEtUrGwpfWeKcmwQZMV3qInq5P40Uu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(8676002)(41300700001)(2906002)(76116006)(5660300002)(64756008)(4326008)(8936002)(66946007)(66476007)(66446008)(66556008)(91956017)(110136005)(316002)(54906003)(478600001)(71200400001)(6486002)(186003)(83380400001)(6512007)(107886003)(36756003)(85182001)(6506007)(2616005)(122000001)(26005)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVrSVFsMkFYQWJEWXJJVncvbVBmb0FOTDhZZWQ0QWJCRXhDcmIrZXp3NE1i?=
 =?utf-8?B?MXh1M0ZxTkhmemJpMHU2TXpNRFR1OVIrTTMyRGtObUFnUThjWGMzbDZSbHlK?=
 =?utf-8?B?MlhzenlxZVNnVzA0SlVsRmhMK0VNd0NyQWxudDdubTFSallYWTJSeUFjWkJk?=
 =?utf-8?B?NG9IZmlwMlp4Q1VSQUo4NTB2dGkxYXExdG11TTFkUS8wR3h4eStFTGVjb2tW?=
 =?utf-8?B?YXFMeGNlU2VzUzU1N29rQk11U21xS2U1Qkh3S2cvWUlkaTFHQW4wYmh4Wi9u?=
 =?utf-8?B?WHJPMW1PVGNGT3R4alJHMERFMzZwdExLbm1lT05DZjE1VUpBWG5MVGRIbXho?=
 =?utf-8?B?NTczSHBMZFJETnJScTUyWmlBbFBxZFBlU1dvZW9TeVJaTjN6MUIxNmFMTWMw?=
 =?utf-8?B?S29yd3N5TlNWYTB6dFFRaG1sUE5iMkJRUWZKN2dEZkFtclpKQ3duc1dUWThJ?=
 =?utf-8?B?NmRtR0poSSttMThIS2pvMDhqSGxEVkpoeDY0NTFqY2NlRlhjN2U4TmRZQmhM?=
 =?utf-8?B?MmRrdHJCd0dtRVByT09QeW5hN1RaNGtRYjRId2pTVFRXMit0SEl6alFlOXJH?=
 =?utf-8?B?NHFqZ3pNcmVEZkUzdHpqQno0ZkZnT2cwdkxLbm9xdGsvWEFib1dnWnBxazQ0?=
 =?utf-8?B?ZGx4amlYTnZmVWZyZ0hRak5ZS2NqTExQSlpQSTRkdm40N1lZNk8yQzJ3elJ3?=
 =?utf-8?B?eDBmTE03TWtrSmd2S0RmNzRKSXpYVktRaTZ4OUkyREtrdTB2NVU0VjI2emJv?=
 =?utf-8?B?bWtJaWVrcHRMNnVRajNLUzlndWZ1TVFWZ0hJcnFDMzhFU2JRV01DRVFkSmFp?=
 =?utf-8?B?aFIwdEN6dkNKWGF6RXlBMVdHZXdhNXZBci95eFB3YklMRUUvcUI1S2x2cFpQ?=
 =?utf-8?B?blFpdlFMZGgvUXFkdCtNZ0toUC9SYmRQcDFDbnNMOVVIa2dqaVJaekhmUzFv?=
 =?utf-8?B?allaeld2VnRtRmpRd3JsamozVGNSQmxObGZ1bC9GM0tZQzIvMkNieWk3M2pl?=
 =?utf-8?B?TWdxUjcrOE5STlIwd0M1NTZBaDVMTERMOUsxNFlEMUJ6bXhmc2J1cW94cFNJ?=
 =?utf-8?B?NTRvM2VHbVhuZ1FScGVaVGhZcnRZekVqeDNuZ3FnR1pyWk12bUkzOWNGcUh1?=
 =?utf-8?B?NzBoM0hQT3hvTURDc0U0dWhyUzNOSWthbEdOdlJ0WmZQZVNZVVFCaDVHL0Vs?=
 =?utf-8?B?SmlIS3hqR3lPU20yVTFIelJvQ3JNOW5OdmlNK3NDVmpiVCtIeGdlZzBQVWZ0?=
 =?utf-8?B?cWVrcitzU0ViN0VHYktBalRwcTlneTZyMGlxY3dzV1ZVSUpMUXV1Vld6MUhI?=
 =?utf-8?B?Umw1QXlhMGtSS3pXcG1SaFErRFU0N0hLSXR3cGVQNE0yNmQ1bVlkbE5GZGF2?=
 =?utf-8?B?SWk4MEltVVBJa0hIWWpvbXAwWWoyV3RYdEVmZWxRR0syZlZMVDNLUlUvWGZL?=
 =?utf-8?B?bnlScnI1d0JxMjZOdis4V3JUcGE3Rmx0cEEyaVozQUY3VHMwSXZBQlFOSjZa?=
 =?utf-8?B?UW9hTUt5ZWZIcXljT2lNMzg0U3hyckxFNUdWL3dlOHFVY3BtakFzazJjSTdN?=
 =?utf-8?B?MTAzYkYxYWxZWDNSSW05aUEwdjQzZWRHa3dQL2plRENrM0ZibUxqSlhDZFgy?=
 =?utf-8?B?NVJJRk1Kd1ppaW4wYUlhUXdRQ002L3JYVm80eENVN3pvc0RCRnJhNVhrVGNm?=
 =?utf-8?B?MTQweWdKbmJSNWZGcVN4bmpDckJZYWQ2a0o5Q0pIODE3bXV2S080WlVDKzZw?=
 =?utf-8?B?empMQW5kandVTzhxQzFKOER1bjNXWG4vUnJjdGhoc2M3L0dLdStpK2ZwQjNS?=
 =?utf-8?B?M0EvUStGYitTalZuR2JqS2pJWU1FM1JpR2Y5N2c3UEMrNWNDQkZGUnlXL1Zq?=
 =?utf-8?B?ekhMdTFMZ0g1a2w0dVlSTVNFOUhqUktremYzNENVWEZFc0t1T2FyVjgvdlBJ?=
 =?utf-8?B?NmNnSURtOXRRTGkxeEpmZlBHZWpScHV1eVg3QTNtcHpzbWlldVF5MXRpUlVl?=
 =?utf-8?B?MGI5Y3Y4TlFPOFNNZjQ1dTZRcS9zejRnUnU2aDBWTzkreGhJaDVhMStIMTdu?=
 =?utf-8?B?QjYvQnRyckIwcUFjSjNHMnN2K1J0bmJFWnZjN0R1bWVaQjRwYUtKUzRZajZQ?=
 =?utf-8?B?NmhXWnc4M1ZGWjVzb2ZwQUx6dlo5eVZDaGJub1lNdVd2RFdNUGdaM3MrMzFn?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C3F096E5D305146B106501387496733@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35baf9e-f0c6-4013-53ca-08db6be7de5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 08:26:21.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eg3wxp8g+iVCDgjnGAVo26aCD0ynZPTKSFHo4LQ0TWuuQOUOAQ0UOC0PGbqjHr4MhG7OCAqEp2AnJ6oD4WFIGdwYSFzIZhc4XyM9dQfdwOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBh
dCAwOTowNSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNC0wNyBhdCAxNDo0NiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBjYXN0aW5nIGJlZm9yZSBhc3NpZ24gdG8gYXZvaWQgdGhlIHVuaW50ZW50aW9u
YWwgaW50ZWdlcg0KPiA+IG92ZXJmbG93DQo+ID4gb3IgdW5pbnRlbmRlZCBzaWduIGV4dGVuc2lv
bi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20+DQo+ID4gRml4ZXM6IDFhNjRhN2FmZjhkYSAoImRybS9tZWRpYXRlazogRml4
IGN1cnNvciBwbGFuZSBubyB1cGRhdGUiKQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9nZW0uYyAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fcGxhbmUuYyB8IDIwICsrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiA+IGluZGV4IDli
OGY3MmVkMTJlNC4uNTM3ZTgzYjk1MDAxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZ2VtLmMNCj4gPiBAQCAtMTIxLDcgKzEyMSw3IEBAIGludCBtdGtfZHJtX2dl
bV9kdW1iX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUNCj4gPiAqZmlsZV9wcml2LCBzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LA0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gIAlhcmdzLT5waXRjaCA9
IERJVl9ST1VORF9VUChhcmdzLT53aWR0aCAqIGFyZ3MtPmJwcCwgOCk7DQo+ID4gLQlhcmdzLT5z
aXplID0gYXJncy0+cGl0Y2ggKiBhcmdzLT5oZWlnaHQ7DQo+ID4gKwlhcmdzLT5zaXplID0gKHVu
c2lnbmVkIGxvbmcpYXJncy0+cGl0Y2ggKiBhcmdzLT5oZWlnaHQ7DQo+IA0KPiBUaGUgcHJvdG90
eXBlIGlzDQo+IA0KPiBzdHJ1Y3QgZHJtX21vZGVfY3JlYXRlX2R1bXAgew0KPiAJX191MzIgaGVp
Z2h0Ow0KPiAJX191MzIgcGl0Y2g7DQo+IAlfX3U2NCBzaXplOw0KPiB9Ow0KPiANCj4gRG8geW91
IHdhbnQgdG8gY2FzZSB0byAiX191NjQiPw0KPiANClllcywgaXQgc2hvdWxkIGJlICh1bnNpZ25l
ZCBsb25nIGxvbmcpLCBidXQgSSdsbCBjaGFuZ2UgaXQgdG86DQphcmdzLT5zaXplID0gKF9fdTY0
KWFyZ3MtPnBpdGNoICogYXJncy0+aGVpZ2h0Ow0KDQo+ID4gIA0KPiA+ICAJbXRrX2dlbSA9IG10
a19kcm1fZ2VtX2NyZWF0ZShkZXYsIGFyZ3MtPnNpemUsIGZhbHNlKTsNCj4gPiAgCWlmIChJU19F
UlIobXRrX2dlbSkpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3Bs
YW5lLmMNCj4gPiBpbmRleCAzMWY5NDIwYWZmNmYuLmExMzM3ZjM4NmJiZiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+IEBAIC0xNDAsNyAr
MTQwLDcgQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0DQo+
ID4gZHJtX3BsYW5lX3N0YXRlICpuZXdfc3RhdGUsDQo+ID4gIAlzdHJ1Y3QgZHJtX2ZyYW1lYnVm
ZmVyICpmYiA9IG5ld19zdGF0ZS0+ZmI7DQo+ID4gIAlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKmdl
bTsNCj4gPiAgCXN0cnVjdCBtdGtfZHJtX2dlbV9vYmogKm10a19nZW07DQo+ID4gLQl1bnNpZ25l
ZCBpbnQgcGl0Y2gsIGZvcm1hdDsNCj4gPiArCXVuc2lnbmVkIGludCBwaXRjaCwgZm9ybWF0LCBj
cHA7DQo+ID4gIAl1NjQgbW9kaWZpZXI7DQo+ID4gIAlkbWFfYWRkcl90IGFkZHI7DQo+ID4gIAlk
bWFfYWRkcl90IGhkcl9hZGRyID0gMDsNCj4gPiBAQCAtMTUxLDExICsxNTEsMTIgQEAgc3RhdGlj
IHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3RhdGUoc3RydWN0DQo+ID4gZHJtX3BsYW5lX3N0
YXRlICpuZXdfc3RhdGUsDQo+ID4gIAlhZGRyID0gbXRrX2dlbS0+ZG1hX2FkZHI7DQo+ID4gIAlw
aXRjaCA9IGZiLT5waXRjaGVzWzBdOw0KPiA+ICAJZm9ybWF0ID0gZmItPmZvcm1hdC0+Zm9ybWF0
Ow0KPiA+ICsJY3BwID0gKHVuc2lnbmVkIGludClmYi0+Zm9ybWF0LT5jcHBbMF07DQo+ID4gIAlt
b2RpZmllciA9IGZiLT5tb2RpZmllcjsNCj4gPiAgDQo+ID4gIAlpZiAobW9kaWZpZXIgPT0gRFJN
X0ZPUk1BVF9NT0RfTElORUFSKSB7DQo+ID4gLQkJYWRkciArPSAobmV3X3N0YXRlLT5zcmMueDEg
Pj4gMTYpICogZmItPmZvcm1hdC0+Y3BwWzBdOw0KPiA+IC0JCWFkZHIgKz0gKG5ld19zdGF0ZS0+
c3JjLnkxID4+IDE2KSAqIHBpdGNoOw0KPiA+ICsJCWFkZHIgKz0gKGRtYV9hZGRyX3QpKG5ld19z
dGF0ZS0+c3JjLngxID4+IDE2KSAqIGNwcDsNCj4gPiArCQlhZGRyICs9IChkbWFfYWRkcl90KShu
ZXdfc3RhdGUtPnNyYy55MSA+PiAxNikgKiBwaXRjaDsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJ
aW50IHdpZHRoX2luX2Jsb2NrcyA9IEFMSUdOKGZiLT53aWR0aCwNCj4gPiBBRkJDX0RBVEFfQkxP
Q0tfV0lEVEgpDQo+ID4gIAkJCQkgICAgICAvIEFGQkNfREFUQV9CTE9DS19XSURUSDsNCj4gPiBA
QCAtMTY3LDE3ICsxNjgsMTggQEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX3VwZGF0ZV9uZXdfc3Rh
dGUoc3RydWN0DQo+ID4gZHJtX3BsYW5lX3N0YXRlICpuZXdfc3RhdGUsDQo+ID4gIA0KPiA+ICAJ
CWhkcl9waXRjaCA9IHdpZHRoX2luX2Jsb2NrcyAqIEFGQkNfSEVBREVSX0JMT0NLX1NJWkU7DQo+
ID4gIAkJcGl0Y2ggPSB3aWR0aF9pbl9ibG9ja3MgKiBBRkJDX0RBVEFfQkxPQ0tfV0lEVEggKg0K
PiA+IC0JCQlBRkJDX0RBVEFfQkxPQ0tfSEVJR0hUICogZmItPmZvcm1hdC0+Y3BwWzBdOw0KPiA+
ICsJCQlBRkJDX0RBVEFfQkxPQ0tfSEVJR0hUICogY3BwOw0KPiA+ICANCj4gPiAgCQloZHJfc2l6
ZSA9IEFMSUdOKGhkcl9waXRjaCAqIGhlaWdodF9pbl9ibG9ja3MsDQo+ID4gQUZCQ19IRUFERVJf
QUxJR05NRU5UKTsNCj4gPiAgDQo+ID4gLQkJaGRyX2FkZHIgPSBhZGRyICsgaGRyX3BpdGNoICog
eV9vZmZzZXRfaW5fYmxvY2tzICsNCj4gPiAtCQkJICAgQUZCQ19IRUFERVJfQkxPQ0tfU0laRSAq
IHhfb2Zmc2V0X2luX2Jsb2NrczsNCj4gPiArCQloZHJfYWRkciA9IGFkZHIgKw0KPiA+ICsJCQkg
ICAoZG1hX2FkZHJfdCloZHJfcGl0Y2ggKiB5X29mZnNldF9pbl9ibG9ja3MgKw0KPiA+ICsJCQkg
ICAoZG1hX2FkZHJfdClBRkJDX0hFQURFUl9CTE9DS19TSVpFICoNCj4gPiB4X29mZnNldF9pbl9i
bG9ja3M7DQo+ID4gIAkJLyogVGhlIGRhdGEgcGxhbmUgaXMgb2Zmc2V0IGJ5IDEgYWRkaXRpb25h
bCBibG9jay4gKi8NCj4gPiAgCQlhZGRyID0gYWRkciArIGhkcl9zaXplICsNCj4gPiAtCQkgICAg
ICAgcGl0Y2ggKiB5X29mZnNldF9pbl9ibG9ja3MgKw0KPiA+IC0JCSAgICAgICBBRkJDX0RBVEFf
QkxPQ0tfV0lEVEggKiBBRkJDX0RBVEFfQkxPQ0tfSEVJR0hUICoNCj4gPiAtCQkgICAgICAgZmIt
PmZvcm1hdC0+Y3BwWzBdICogKHhfb2Zmc2V0X2luX2Jsb2NrcyArIDEpOw0KPiA+ICsJCSAgICAg
ICAoZG1hX2FkZHJfdClwaXRjaCAqIHlfb2Zmc2V0X2luX2Jsb2NrcyArDQo+ID4gKwkJICAgICAg
IChkbWFfYWRkcl90KUFGQkNfREFUQV9CTE9DS19XSURUSCAqDQo+ID4gQUZCQ19EQVRBX0JMT0NL
X0hFSUdIVCAqDQo+ID4gKwkJICAgICAgIChkbWFfYWRkcl90KWNwcCAqICh4X29mZnNldF9pbl9i
bG9ja3MgKyAxKTsNCj4gPiAgCX0NCj4gDQo+IEkgd291bGQgbGlrZSB5b3UgdG8gYWRkIGEgdmFy
aWFibGUgJ3UzMiBvZmZzZXQnIGZvciB0aGlzIGNhbGN1bGF0aW5nLA0KPiBhbmQgSSB0aGluayB1
MzIgaXMgZW5vdWdoIGZvciB0aGlzIGNhbGN1bGF0aW5nIGFuZCBpdCdzIG5vdCBuZWNlc3NhcnkN
Cj4gdG8gZG8gYW55IGNhc3RpbmcuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KDQpJIHRoaW5rIHhf
b2Zmc2V0X2luX2Jsb2NrcyBhbmQgeV9vZmZzZXRfaW5fYmxvY2tzIG1heSBiZSBuZWdhdGl2ZSwN
CnNvIEknbGwgdXNlICdpbnQgb2Zmc2V0JyBmb3IgdGhpcyBjYWxjdWxhdGluZy4NCg0KUmVnYXJk
cywNCkphc29uLUpILkxpbg0KDQo+IA0KPiA+ICANCj4gPiAgCW10a19wbGFuZV9zdGF0ZS0+cGVu
ZGluZy5lbmFibGUgPSB0cnVlOw0K
