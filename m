Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F55E97A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZBUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIZBUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:20:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B41D0F5;
        Sun, 25 Sep 2022 18:20:07 -0700 (PDT)
X-UUID: 11df65d2231642338fa17638532d8e17-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eTCF7Tc1urgpGVT4U/0CIwUbkM/Op8LiAZj8ph3pkCE=;
        b=ZWoes6Mb8vzICh5M/SSvaz0Z66oSqFvZTxevQXWhyHxpm3SeJ09vuOjbYEk0h1MO/+nonTOgC6LUXyLf0rWGlYcFMGJRxdXTmU5ZcX2Jxd4G5McrKx2+Mh2lbQaNpt9hoRTUtYavqH6wMBSP3iGAgtIMPzY9TPdPZTbE2TzOfME=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4d7a253f-3e6a-4d9f-8207-0eba02e68702,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:108c02a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 11df65d2231642338fa17638532d8e17-20220926
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1139422337; Mon, 26 Sep 2022 09:20:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 09:20:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Sep 2022 09:20:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF6s9Bs/1QfDUJ/x8bSSI/eff+QxWr84prFrEeQdDkhIpeGP4D9HXI89TaCm8Xr88Ebff83LDDwaMt5Ns8pNXJ2iElwHdaJddj+IfU04jIg+f7pgjtgPs7cmcgEUCoaLxdapb0SUNkA7b3TWvSF/esTwwPLOJK8UN0F/L0okrqaNnINkgrUOJUSyAjI4TINNQJqmHJRj5ghPucqMmHpusdq0RHeUtjfX2VSJi2Eb8v6rX6qL95H0Hn/z9QBDfURzvn5TnxX+PQnKpA4lh/6UrBILl+uNOk7QS2Nq6qiDAf9uRFF5vxl3ShTjPfiMuwO7cA1O4DcDJAS5mq2DVbT7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTCF7Tc1urgpGVT4U/0CIwUbkM/Op8LiAZj8ph3pkCE=;
 b=bVNeZtiUH/8LJI+chJ3n8qSZaN8oQ72PcKagi5GSaWzqceUnFWso2NrdxsoIaua4JYcNybaI80ZKccMazRJbby1keunRwFEKF74fxA6gemW01UyBkxGVyvx8vzCh3XGVlBDI8gWSOFBdMChmeFpOw77XhpCDiXCysk/DlgnEyVshnVEAmNSTQHZAGJienEGoZTEPvLxg7Y0tz+0L5va3fOFg7eNbfIRJBnYfA8cz8d9tpQPj3ws4tQM8EVy/Q132bfQcQHq5rLEmsOTgnQF6Prfv/WUARonkLpoYZYwVVRKmLQMTi7kpSXBwYyuTZo1wLpW9rOTtNDC780+UtgKOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTCF7Tc1urgpGVT4U/0CIwUbkM/Op8LiAZj8ph3pkCE=;
 b=X1mEFDVUhsEBHnxWfV2x93Rfi+IH+HtSjVDFB3gyYqYFmP8YUPiEXwdhvv4qenvk+PeHzqayXpAPKwY8PgCMBMm/ue7QR4KHqWg1BTtqNL1Jgv8ObElk1EHijujmmgSoiGjNVTgVWvIyH2jAeILq143CtPuL2FDBlhB4cqZB+10=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Mon, 26 Sep
 2022 01:19:57 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::2750:5f7b:1d14:d1a8]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::2750:5f7b:1d14:d1a8%5]) with mapi id 15.20.5676.013; Mon, 26 Sep 2022
 01:19:57 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Thread-Topic: [PATCH v4 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Thread-Index: AQHYz+vboK/WYXWDzUaGZ4HNo8ogna3vx8EAgAEkkwA=
Date:   Mon, 26 Sep 2022 01:19:57 +0000
Message-ID: <23fd466265eec1effd83de6e8ad4ff64eadf5cae.camel@mediatek.com>
References: <20220924080058.20566-1-jason-jh.lin@mediatek.com>
         <20220924080058.20566-2-jason-jh.lin@mediatek.com>
         <6bbe9527-ae48-30e0-fb45-519223a744d7@linaro.org>
In-Reply-To: <6bbe9527-ae48-30e0-fb45-519223a744d7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|SEYPR03MB7120:EE_
x-ms-office365-filtering-correlation-id: 9282a164-3124-4156-a19e-08da9f5d397e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdoW5MNfaUi8FeJWg7zyOZfHOBB7y2bWnR1DOot+ZWfVEHuMRd7d+tE5WMG5+/5WEVIHg7W6S8aA77rNWob4BUIp6wWXSokgo8WQ0ZNSawfNGVqyFaqndO2dOxDKiuJURPpaCLHPAoA+EOdVRsm2h0GP05QjX7n0jF1DkoVPunTFosu6Hdl0pzq2x2TzCS874Bmw+ppMH9vLdrbutKqxN5a3V1ODf5MFiS2K6VNI73Fp7tAQgho6IDQiMPeYxFc3Za+ZwVRUNJyhtnBAKR7H74pGF255BmSrOCkc9Q+zKNwG81nmUuBhpTEE70V8xlYL2to20q4e/WFBBRC1fxdrbTDnU3J6PynpzZeT+OJYhDatHnVKyEpan6yU1mxxmfiuUsUHcusH0sKj1+MjK2DVxsAPLjXQXUeyq5inm1weqJjtaQaJVDyYZXTzO5rO6jkm4gKeEnq/RUiqH683RhaL6LqpOtHajBMeyXL2yuHVf8N5SmoOZJ+M+CwVJj4Ftl8jxq7dzyWPWySDPR3MDJYxX7/xgRAEwOZ6irQcugbpJnZPx9kIM2YvmkRCnx8h+WT1wuhapeYaFbRrr1+MZIUNQMbMgSDoQxHrokEtGALx9a26oFjv9f46ZtnQiOs7IcBGo2w52IAkp30BLDhGQqne6pgyWYIGQ8f8ipsFz4kYFhzvMY+y9hpzeLLUFY46xd7Dc2wsqOHJPHIxHESWMG9cS5Q7w26x5TdJmK12YBgDS+dkWwRuZKZ9kGNW3Y0rXJyMrze2TfWrwZnrNksGI5YXNKJKl7+Bt1Ddk93T5FenOrVQ2ftbkCdXH7dYj4V6VQge
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(376002)(39850400004)(451199015)(71200400001)(186003)(8676002)(2616005)(83380400001)(316002)(38100700002)(8936002)(107886003)(26005)(53546011)(6512007)(6506007)(86362001)(7416002)(91956017)(5660300002)(2906002)(38070700005)(478600001)(66556008)(76116006)(110136005)(66946007)(66446008)(64756008)(66476007)(85182001)(54906003)(122000001)(4326008)(36756003)(41300700001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z291ck5BZzVYZVdzZVB1QlRiSnRUbFFnZmZxRzFOZDlqYjgvUStFMGNjaTda?=
 =?utf-8?B?STNwaVFXWEttWXFKeHM4Z3R4bkJNekpLa2IrZlZFVW14SlIyL0FhR3RlRE9t?=
 =?utf-8?B?c0pXYUY1T2tuS1pTT2lFVVF6ak5rTzBmRHlRdTdOZFlwUXRiM1dUOFRBSjJn?=
 =?utf-8?B?a29VMEF5QllzQzZXTW12Ry9kQzR5eTIzbjYwOVhnMzIzaDhSR2VqUHNaUjk1?=
 =?utf-8?B?ZFlOR1dFWExOSzNMdXpIbVJMQXc1ZHNWRjFrUWU5bzJsQ3RxVWRFalRYdC9P?=
 =?utf-8?B?VUQ3K0NWaFlHWG1VVUV1a3Zhd0dsdHJkcnFKbUduQjE5d0Y1NklDYzdMSHdu?=
 =?utf-8?B?ckhaMEh1eEpQVzV5NzJtK2Q3T2FhTGcvRXNhRE56Ry9tS1VQU0lNcThhbURr?=
 =?utf-8?B?K21nczZKSXFUSTYyOGorWGxTeFZWNVRpTlVLdDlXTHRtM1NIYXZpZVliYk11?=
 =?utf-8?B?VWxMSUp5R1Y5QlJKSjFVcEhBbHpSZ0RxRmMyM1RVcU5IdGpTcldPSzMvSEFV?=
 =?utf-8?B?TnpnTTBhRzl0dFJ4anpzNklOQUd6VGxmbFgwS3JPNDk4TnJMc3lpZ1dDbklP?=
 =?utf-8?B?ZHFvRXBNemhrYlNsczdnazA3a2dUZkNRTWpmalgzRUI2bmhoUjJZMTZUU2R3?=
 =?utf-8?B?T0VvRDU0MUo1NEdHRFJ0M0J6WDlpSGRtMVIxeTR2b05kMmdBWFNNcEltdWF4?=
 =?utf-8?B?TlhLN05FY2piVWRQaC9MOXMvRTBMWWRHeUZDVkFLS3Nib1ZIQncwd2l6ZDRu?=
 =?utf-8?B?U0R0bTR3b1BoZkV5MWNMZ2RlbmRESXl6Nm9xVGJITm9ZVUxZOXl5SGN1cjhp?=
 =?utf-8?B?eWE0QkJHM08rSXJ0WXc3VXVZaGJOWi92NHR5TW54MUVTMUs4QzBURXY5YTBT?=
 =?utf-8?B?d0NwQ1B3TFQ1dWE5bUc0MkRNN1pTQXVweW9BZTdBVjhjanpUbXJDUHk3ZFZi?=
 =?utf-8?B?YTZLRlk1V2hvdTFUTGYwMzNnSnVtT2p3dGhmMm5EY005VzF0cEtybXJ5U2Vm?=
 =?utf-8?B?V3JiS1dyWU9sVVBUZU83eUZGLzFnZTlmZTFJUTgzQVM5c3lNai85ejJKM21G?=
 =?utf-8?B?enZJNW13Vm5GYklBaW1yYUMvNlZKTGdFVVdLVDhNUHlQTmVZcmdjWjFoSlkz?=
 =?utf-8?B?L0NjejczYjRjUHp5YVBkQ3JqYURRWUtzL3l2ejdyZUc2eEFGTDZUWDVidG5V?=
 =?utf-8?B?c0V1SUpkdEtBKzFrMU54NE04YkRqMWNkcGozdDRhVktNRkl2OWpUMENPSFI0?=
 =?utf-8?B?dlJQWWpWNjNUUmVYaVhmTENQenZ1bXBOdnhQU1NROEJXQWdRRkNBTWZKV2lr?=
 =?utf-8?B?aCtlSEFDRTFMY0R3NHdPUXpJQUJzYnd6eWZTdUVWemtrNlhDamN2RDI0RTJH?=
 =?utf-8?B?c2g1SjVhelN0anNrYUdQeFJkMTRIcjk0YzFXVDVYSU9RWkVncFBQck5TbEE2?=
 =?utf-8?B?NnRtSDh0V1A2SkhlZGpLaDZSZ3VzS21ZRkVZVXJxaFdhMEt1OEZHclowbjFR?=
 =?utf-8?B?YlpIZ2pHOEFyK1dlMGVqWlhKeHFDdnVaaTQ3YVZFSGI4WHUxWmpkbHkybFBw?=
 =?utf-8?B?OXg0dlphTzN0ZFlzZWkzRzBvWE5FSE4xZWd0OWN4cDlKVkEzMTRkR0VmdGNz?=
 =?utf-8?B?S2VDUlNGcFpVeHBsaUlCUW5Odk15UHBoR1dSRHpRekt6M1hRa3RnMXRKL1Vi?=
 =?utf-8?B?TDN3ZXVTeXNBMUtFVEhnWXQzOU5vR2VyTnJkZTFobXZNdlA3RkhPbDcxSENt?=
 =?utf-8?B?aElPOFNYWFZKMVE5YTNNNTlXb08yU1BOSmRQTXZPRU1RQy9MNlhabGlyb0hN?=
 =?utf-8?B?TzF2VUR1UXhQT3JLZS9VYitOcWZiNElidmdRVFpOTTZsdlhNekFmR0tLYTZQ?=
 =?utf-8?B?L01qaXJlbGNON3VFakU5YjA1T0RQYUlCUjhmMHJSdFBiYkx3TGdTaU05b2xJ?=
 =?utf-8?B?VjdTaGZhbnZZM2EwRm5FbTI3OENSVm9ad054YU5FNGc5UmhVakRIUDJaQkta?=
 =?utf-8?B?SURlQjliR1VxUldOL0FQeEVhRHBFUC9PZUZWOGhCTDAyOTB2NGFnSlJZWTZI?=
 =?utf-8?B?TjZmNEFCbnlvMGNtQUF3QTJZK2RCTDk4WCs0YlFYTUQ5N0ZBUTZFRVNWYUJs?=
 =?utf-8?B?YlpQVlU3TEdtUEVtQVQ0RkY1encvVTNLV2JwRnNibk52K01NSmY0VUY2eGFx?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E9549D71211064FBD90D60188EFFBAC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9282a164-3124-4156-a19e-08da9f5d397e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 01:19:57.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiBKtz0xpoMfdEo54ZScQ3X8bR2T/xcWBRVS9cMiX9jBpEOkhcNy/9pgTfNfD0IcjiQtX9CLnmKVIfncKj3o98j5goYy8wmlrGloP4iRbl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBTdW4sIDIwMjIt
MDktMjUgYXQgMDk6NTIgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDI0
LzA5LzIwMjIgMTA6MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiBGb3IgcHJldmlvdXMgTWVk
aWFUZWsgU29Dcywgc3VjaCBhcyBNVDgxNzMsIHRoZXJlIGFyZSAyIGRpc3BsYXkgSFcNCj4gPiBw
aXBlbGluZXMgYmluZGluZyB0byAxIG1tc3lzIHdpdGggdGhlIHNhbWUgcG93ZXIgZG9tYWluLCB0
aGUgc2FtZQ0KPiA+IGNsb2NrIGRyaXZlciBhbmQgdGhlIHNhbWUgbWVkaWF0ZWstZHJtIGRyaXZl
ci4NCj4gPiANCj4gPiBGb3IgTVQ4MTk1LCBWRE9TWVMwIGFuZCBWRE9TWVMxIGFyZSAyIGRpc3Bs
YXkgSFcgcGlwZWxpbmVzIGJpbmRpbmcNCj4gPiB0bw0KPiA+IDIgZGlmZmVyZW50IHBvd2VyIGRv
bWFpbnMsIGRpZmZlcmVudCBjbG9jayBkcml2ZXJzIGFuZCBkaWZmZXJlbnQNCj4gPiBtZWRpYXRl
ay1kcm0gZHJpdmVycy4NCj4gPiANCj4gPiBNb3Jlb3ZlciwgSGFyZHdhcmUgcGlwZWxpbmUgb2Yg
VkRPU1lTMCBoYXMgdGhlc2UgY29tcG9uZW50czogQ09MT1IsDQo+ID4gQ0NPUlIsIEFBTCwgR0FN
TUEsIERJVEhFUi4gVGhleSBhcmUgcmVsYXRlZCB0byB0aGUgUFEgKFBpY3R1cmUNCj4gPiBRdWFs
aXR5KQ0KPiA+IGFuZCB0aGV5IG1ha2VzIFZET1NZUzAgc3VwcG9ydHMgUFEgZnVuY3Rpb24gd2hp
bGUgdGhleSBhcmUgbm90DQo+ID4gaW5jbHVkaW5nIGluIFZET1NZUzEuDQo+ID4gDQo+ID4gSGFy
ZHdhcmUgcGlwZWxpbmUgb2YgVkRPU1lTMSBoYXMgdGhlIGNvbXBvbmVudCBFVEhEUiAoSERSIHJl
bGF0ZWQNCj4gPiBjb21wb25lbnQpLiBJdCBtYWtlcyBWRE9TWVMxIHN1cHBvcnRzIHRoZSBIRFIg
ZnVuY3Rpb24gd2hpbGUgaXQncw0KPiA+IG5vdA0KPiA+IGluY2x1ZGluZyBpbiBWRE9TWVMwLg0K
PiA+IA0KPiA+IFRvIHN1bW1hcml6ZTA6DQo+ID4gT25seSBWRE9TWVMwIGNhbiBzdXBwb3J0IFBR
IGFkanVzdG1lbnQuDQo+ID4gT25seSBWRE9TWVMxIGNhbiBzdXBwb3J0IEhEUiBhZGp1c3RtZW50
Lg0KPiA+IA0KPiA+IFRoZXJlZm9yZSwgd2UgbmVlZCB0byBzZXBhcmF0ZSB0aGVzZSB0d28gZGlm
ZmVyZW50IG1tc3lzIGhhcmR3YXJlcw0KPiA+IHRvDQo+ID4gMiBkaWZmZXJlbnQgY29tcGF0aWJs
ZXMgZm9yIE1UODE5NS4NCj4gPiANCj4gPiBGaXhlczogODFjNWE0MWQxMGI5ICgiZHQtYmluZGlu
Z3M6IGFybTogbWVkaWF0ZWs6IG1tc3lzOiBhZGQgbXQ4MTk1DQo+ID4gU29DIGJpbmRpbmciKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCby1DaGVuIENoZW4gPHJleC1iYy5jaGVuQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVr
L21lZGlhdGVrLG1tc3lzLnlhbWwgICAgIHwgNQ0KPiA+ICsrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtDQo+ID4gbA0KPiA+IGluZGV4
IDZhZDAyM2VlYzE5My4uNGY5MGVhMDNjNTk2IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55
YW0NCj4gPiBsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiBAQCAtMzEsMTMg
KzMxLDE2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
ODMtbW1zeXMNCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4Ni1tbXN5cw0KPiA+
ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLW1tc3lzDQo+ID4gLSAgICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxOTUtbW1zeXMNCj4gDQo+IFdlIGtlZXAgbWFraW5nIGNpcmNsZXMu
Li4NCg0KSSBkaWRuJ3QgZmluZCB0aGUgc2FtcGxlIG9mICJkZXByZWNhdGVkIiBpbiB0aGUgZXhh
bXBsZS1zY2hlbWEueWFtbCwNCnNvIEkga2VlcCBtaXN1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4u
DQpJJ20gc29ycnkgYWJvdXQgdGhhdC4uLg0KDQo+IA0KPiBJIGFza2VkICJhbmQgd2h5IG1lZGlh
dGVrLG10ODE5NS1tbXN5cyBpcyBrZXB0IGFzIG5vbi1kZXByZWNhdGVkPyINCj4gDQpZZXMsIGl0
IHNob3VsZCBiZSBkZXByZWNhdGVkLiBJIHNob3VsZG4ndCByZW1vdmUgaXQuLi4NCg0KPiBhbmQg
eW91ciByZXNwb25zZSBpcyB0byByZW1vdmUgaXQuLi4gRWgsIG9rYXksIHRoYXQncyBmaW5lIGJ1
dCBub3cNCj4geW91cg0KPiBjaGFuZ2UgY2F1c2VzIG5vdyB3YXJuaW5ncyBpbiBleGlzdGluZyBE
VFMuIEVpdGhlciB5b3Uga2VlcCBvbGQgZW50cnkNCj4gYXMNCj4gZGVwcmVjYXRlZCAoanVzdCBn
aXQgZ3JlcCBmb3IgZGVwcmVjYXRlZCwgeW91IHdpbGwgZmluZCBleGFtcGxlcyBob3cNCj4gdG8N
Cj4gZG8gaXQpIG9yIGZpeCB0aGUgRFRTLg0KPiANClRoYW5rcyBmb3IgdGhlIGFkdmljZS4NCg0K
Tm93IEkgZm91bmQgYW4gZXhhbXBsZSBpbiBvdGhlciB5YW1sLCBzbyBJIGp1c3QgYWRkZWQgdGhl
ICJkZXByZWNhdGVkIg0KdGFnIGxpa2UgdGhpcywgcmlnaHQ/DQoNCiAtIGl0ZW1zOg0KICAgICAg
ICAgIC0gZW51bToNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDI3MDEtbW1zeXMNCiAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDI3MTItbW1zeXMNCiAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDY3NjUtbW1zeXMNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDY3NzktbW1zeXMNCiAg
ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDY3OTctbW1zeXMNCiAgICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxNjctbW1zeXMNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxNzMtbW1zeXMN
CiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtbW1zeXMNCiAgICAgICAgICAgICAgLSBt
ZWRpYXRlayxtdDgxODYtbW1zeXMNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItbW1z
eXMNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbW1zeXMNCiAgICAgICAgICAgICAg
ICAgIGRlcHJlY2F0ZWQ6IHRydWUNCiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgzNjUtbW1z
eXMNCiAgICAgICAgICAtIGNvbnN0OiBzeXNjb24NCg0KUmVnYXJkLA0KSmFzb24tSkguTGluDQoN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
