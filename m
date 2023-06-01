Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7557199B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjFAK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjFAK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:27:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E71730;
        Thu,  1 Jun 2023 03:26:11 -0700 (PDT)
X-UUID: b7f1c314006611eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+qJmIYdGdKAd2WezoieU0zOmJigEHQzMH9yyVzXgb9Y=;
        b=CzkJ7UZdRAZ0eCETmorEcK8k8pFocA6VhyrWhTY/F03ter8tqORJrh5rjtsSlflZ+nlRwmnnGLn94e7wZCvwY2sgy7OrnOKZtShiYZnNgw80nwK+8+Q9ywEqh/bR4JUOMLV561P3MsuRZNm2FY+og4fwfoz5IipN3HuHxYu8gM0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ca7dda61-1da0-4bef-b4bd-14b9ad580960,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:2b4c423d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b7f1c314006611eeb20a276fd37b9834-20230601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 721685396; Thu, 01 Jun 2023 18:26:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 18:26:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 18:26:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuRHSe7GzXgHT23Q+DgvO8p3aIkrIAlRJHbQefFi2PsclFWv87bHnqdyn/8GQhUIs+gkv38Szo3RjQlJIe/M7tW84eX2r0+8j5R/xtL2TnF8pcAqgp3lr0LPLdd/EVTkhklg6ona/NRUfMrrOPzPrPA3woQmndvFsVPnEtZTyFqFgY5KgAls1wqwVRg6ykx1oaoxEvRycnUAoDnyaYX6fbWiNU6rgCrAgYt2Hq0yNX7elYFr6Bh6KJ1zyhE7UlpAUDchejjXDIgkG0Koo+PH3ktJ+h4WIltl9ozi1rCINjf9Rf9eKHdzjYfNpoPSBSxdED/mhMaz4+OYEDysph78nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qJmIYdGdKAd2WezoieU0zOmJigEHQzMH9yyVzXgb9Y=;
 b=BpgUS4jBRh1iYGmvw00ta3xve7wZNnHH1alm7cgUUuWg1rffLJJEWu5b9x40Q0DOP/PPnUAqD5n8rvOraPd1gPAVzdC9QVor4Lo7Fx/v8I7C892rSbScR9cemgBiRBXRLoJiti2VKtkz9QbB4k1LoxRtT1GC80bLH1b4QdhQwCz7AJk6t4bRjeql2ZjeC759yoB6nN8iQbOCRw3SzlUoR4J08+H6BJdkKTJZ2uuYp+Pqi7tiPGiKXlVi+yHALyi3WzAk51evpaEtvp0/30MIvv5pRbZtYY8JOfYihLmngy8FiK7Hp/cw931CLoOxzR7awreZt7V3pOD0GVA6gdXx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qJmIYdGdKAd2WezoieU0zOmJigEHQzMH9yyVzXgb9Y=;
 b=Jm0G0+iRAjwvWZmdN0U1h6mfgVcyao6T1mNMdZTSqHcM7Yu6DxrP8Ijd6INjCp9RzvBNhGBqjfQSygKIhw/dsRxMZk4PN7EHXbCXPfqOUqOAW9ZCs337ap+bLf5JSrxvA1OZR6xbGLxB8fi0mefxg7/Z9+Ee+0UEwX9IJVW1csE=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by SG2PR03MB6825.apcprd03.prod.outlook.com (2603:1096:4:1d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Thu, 1 Jun
 2023 10:25:59 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::f0ea:f00a:e800:a382%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 10:25:59 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "chu.stanley@gmail.com" <chu.stanley@gmail.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Thread-Topic: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Thread-Index: AQHZkp8O+KfkX8LDKkiWd0UHlYtLm69zfuaAgAAhg4CAALa8gIABaoUA
Date:   Thu, 1 Jun 2023 10:25:59 +0000
Message-ID: <fd0fceb04efa34e6d86f09c5554746cfcc5c993f.camel@mediatek.com>
References: <20230530023227.16653-1-powen.kao@mediatek.com>
         <20230530023227.16653-2-powen.kao@mediatek.com>
         <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
         <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
         <ec9c378c-fedd-5a90-bb12-085395e0d22e@acm.org>
In-Reply-To: <ec9c378c-fedd-5a90-bb12-085395e0d22e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|SG2PR03MB6825:EE_
x-ms-office365-filtering-correlation-id: 0c2d35ec-270d-49f4-b180-08db628a97f0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JpoHJJt4ooGyhp/kSwQRZkl1iPelNgirnOHRORAzaiqRPhAquiaPmR4TGwshHZh+eIEL14J9XYMlf8A+SNvjGn/vXT6Kx1xAkeROO+nnqiP79oOPO0377FYxykbPa9YoqwLa4VRpJy8b2Mq8bPEcab0wHY/vOZN2Yv89mEeweNbbaj87BaSHBMJquke5hP2Vde5PaabwRAwhk8QfX9cRl7w/C2mYSzFzxnRfebYoNZc+kFQ06y4cWNiu+BspJf0AidllaOyTH1NQemnxj4P+8kPcLRz2I+X7/EkHUgmBzpTPkbRfYCV4Y1Ug5yy5L0LzBl8e+Z5K2xJVZUpiZ6xzbFb4ArR9Wium2/GWkBH+brKapEt90z5AKd79KNULB7SkHbQX7TPJF6ROQmPtNAGDmsvQSOixmJEB8puyOL1Z549bUC6UIIhTQZ4Cs3ujBrhkjtvF2a5noTs2yTkr3GuOE1n78AElC9SjVE6fM1A1X0m+ecNKyNG6bmpck4tba79Z9cw/x3eit4xrr1M02cVOXHLrMPwqVIkMXeEL5VFlJ8giNCVkdFdlg6y4YR4OJxCZL/t94u8ASpgHNgRb/fusPCIV6sE4DKWMKCOuI2GIWSzYP1BEq3hN5AAD3z5sTDoe9uhuI8hH+U+x/OSkH3sZpCqqdJn0JnB+Ox2gY5YPrAQjG5PNIRNHiogNx+sWkEX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(6512007)(6506007)(186003)(53546011)(110136005)(2906002)(54906003)(2616005)(478600001)(26005)(66899021)(83380400001)(38100700002)(41300700001)(8676002)(122000001)(6486002)(8936002)(66476007)(64756008)(316002)(66946007)(76116006)(66446008)(5660300002)(4326008)(71200400001)(86362001)(85182001)(66556008)(36756003)(7416002)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czdtOUZ1SS9RL1dLS09hWXF1VER4Uk5BdXRWVFVocnBXSFdjcHVaalFjY2Fn?=
 =?utf-8?B?QjZNeHpUNE15aTU3TUdXckNGckhxcTJzakJQVGYzdWhBRDlZd1RFc2ZYeGhX?=
 =?utf-8?B?eE1WOUNudXNoVHZtMTZ5dy9URklTZUhIUStKL0E0SEtEQkpuemx3SGEvYTYv?=
 =?utf-8?B?L0JKWHo4ZmZ5U3o4dUxoYTUwMjJmZWNEZDg5OG4wOGtsT2JpOHN2N1E3eVhz?=
 =?utf-8?B?Sng4UGUvSnU2WEVuWi9yTGVZc3JTKzBWVmJyeEZCdVNoUWhmNU85c3hudXMx?=
 =?utf-8?B?NDQyZldpeDdQc0dpUGxNR2JZanQvb1FQOEgrZVB5b2R3Y0tmejJLVkwzTnd5?=
 =?utf-8?B?UmgxV2wzNFJSVjlVZFU1NFoxUjNxY1N6YUFJWk9LRnE0T0JRcDZkVml1b0tM?=
 =?utf-8?B?UE9FSlR2SzJBeDBZeWlLMC9XRTBTY2pLaUVGRXVDeHY0aXRwOEFCeTdJWXpp?=
 =?utf-8?B?QXJlZGZ6NS90cVR2bVB3TU15RDVNNld3anpxVWk0cDI2ZzZZanQzOE1mL01t?=
 =?utf-8?B?SlNTTWJuV1R5MklBRFFSVm4ydmd5MG9ZeVFscWVzTEJ3bDZpd2ZlMG9scmNE?=
 =?utf-8?B?b3h3UnlJNVhOYlAySGdJT0ZsQSt5elRGU2NaQTJ6MGNQUHhJOUE0MXdnVG52?=
 =?utf-8?B?c1M2Rm1KdGZlQXM5K24zWEd5RUgyZWxjZlpLdklWT1JaU1VGL3dpNS9EaFJK?=
 =?utf-8?B?akhiS2NDSm1IVzFBcldFTkhKNGtmVm8yK21TL3gySjNYWW03TFR5YVU4N3k4?=
 =?utf-8?B?bW1qTnNFSHk2NWNJOTFnVk9CdFhCcXlPZ1dHS1A3Zit5Z05raWlzeUloNmEr?=
 =?utf-8?B?TWpkajQyOVJZbTdISmV6enZ1MWpFQ252aXlFT1d1Z2ZRWTF5WVc1amVycjdQ?=
 =?utf-8?B?UkJtRStmODZ1UFlnTzBUN2xPL3hFNmJrQ09KZm0vWkVKeTZXRUozbVF4Zkpr?=
 =?utf-8?B?ZlJ6eG1DYUdkOTdxTXB5NXZyWWRXUGwvdkphRHgyeE1vODRFY1U5dGxRSXdG?=
 =?utf-8?B?U2szQ2JXM2NkUTNxanhWa3pFTTAzTm9ncXcrMjFQQ25NeEVQcUdQRTR2dDFW?=
 =?utf-8?B?WXdNOFMzK0NQb281QlVrVkNkWm1nRG9zQ3dmTHhqVGJoMk96OEpHQ0ZQdyti?=
 =?utf-8?B?ZTQza1JaY2pIakp5dnBoeEFRMmFkVVlmOXJGcUlLMVpaNFhRYWFZZWQ4eVQ0?=
 =?utf-8?B?V2V5TTFFVVErWTgvVkZCWFp3YmJHVE1SRXBwTk1nTXhNeEJCclN6MUJCaVJi?=
 =?utf-8?B?ckFKMGNCamVqYjFvZFBaVUlkWlYvc28vQmQ2MHdlZE9nZVVnakl3dkxWL0lh?=
 =?utf-8?B?ZzZRWTMxSS9qcGpQSGhYNnlab2oyR2NBUm9iVW81d25aTUN0WXgxT2U4NjBa?=
 =?utf-8?B?M0lyeU13eEFvZzhKczI2ZzlHb0ZLdWZTc0VuRTJZVU5ySVdMdm5nbGJsVkw4?=
 =?utf-8?B?TDIrbzlNR3Rmb0ZwcHRCblVXbTk5NkZXa09nMEFSUFBBMjQxQkRldXZMcmg0?=
 =?utf-8?B?NmRBUUFiV05RN2NnSkN4Q3ZkaGt6ZDNsT2hyeEgwUGVSRnVTTDV3VnBqZ2xa?=
 =?utf-8?B?RG5LMUUrZS9sWmw4VDNNaGhQclZOYytRdWRRenVOcDljTnhiSVlQcE5GcGkv?=
 =?utf-8?B?RVdreHpXcm1KRU1BbGxEM21MRG01M3Y4cGxTRmdCL3c5a2dRcHhZUVhDRWd2?=
 =?utf-8?B?cUFPU0h3cWpBbGE5M2ZjaGN0YWRINXc0T2tIbVBBY2pHVWlGbnZucjJKR0Nh?=
 =?utf-8?B?cTdNVVpJSklpWWI1RGxQUFEzUW9DZTdLNkpOU3NNTGtEeDdHOVBjQ3Z4TUpX?=
 =?utf-8?B?aTZWVWxpYS9uM09VNldOOXVYR0R5WlkrYldJakZCRHhwMGxrWVRXSnZVcmdi?=
 =?utf-8?B?SXo0YkM3K0htMzhqa2hodUU5VjZjdmhTNG4xRlk0REVOanFTV1MyNjZFSU5v?=
 =?utf-8?B?K0pYeFlneGhGdU85YXliQ1pmYmRIV1lSbFJWNWFaeWViUmVLVjMrNUt1bGNt?=
 =?utf-8?B?UHd1VGp0Nm1aQUhvelJ5ODdZL20zVnRHVVFEMFUzdlNLM2RaQ3c5SXUzeThy?=
 =?utf-8?B?Zk5vNDJWaEx2M2tPWVJ0K0FuL2d6Wi91SENIU3VmdHkwc29OQTR0clRCZi9P?=
 =?utf-8?B?R3dYRW84TzJOUGVkOEQ1U0cwc2luVkhzbnZwcG5JbFBURFpJc2pwT1RZL2Fq?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EE3CC862B4EF24286F8EA4A9D1E1809@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2d35ec-270d-49f4-b180-08db628a97f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 10:25:59.7033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njNldTPiwIe8xlS1GwY62hnoNv7WO2BwtQ8ygFakTQCtwmyxth5xmra4zhbH71EARV/R098DRylt1ja6REreDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6825
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDA1OjQ4IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gNS8zMC8yMyAxODo1NCwgU3RhbmxleSBDaHUgd3JvdGU6DQo+
ID4gSW4gYWRkaXRpb24sIHNvbWUgYmVuY2htYXJrIGRhdGEgc2hvd3MgdGhhdCB0aGUgcGVyZm9y
bWFuY2UgY2FuIGJlDQo+ID4gaW1wcm92ZWQgYnkgdXNpbmcgZmV3ZXIgQ1FzIHRvIGFnZ3JlZ2F0
ZSB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIG9mDQo+ID4gY29tcGxldGlvbiByZXF1ZXN0cy4NCj4g
DQo+IFdoYXQgaGFzIGJlZW4gbWVhc3VyZWQ/IElPUFMgb25seSBvciBib3RoIElPUFMgYW5kIGxh
dGVuY3k/DQo+IA0KPiBIb3cgYmlnIGlzIHRoZSBkaWZmZXJlbmNlPyBBIGZldyBwZXJjZW50IG9y
IG1vcmU/DQo+IEZvciB3aGljaCBudW1iZXIgb2YgU1FzIGFuZCB3aGljaCBudW1iZXIgb2YgQ1Fz
IGhhcyBwZXJmb3JtYW5jZSBkYXRhIA0KPiBiZWVuIG1lYXN1cmVkPw0KPiANCkNvbXBhcmluZyA4
LTggdG8gOC0xIG1hcHBpbmcsIGl0IHNob3dzIGZldyBwZXJjZW50cyBpbXByb3ZlbWVudC4NCg0K
PiANCj4gV291bGQgdGhlIGZvbGxvd2luZyB3b3JrIGluc3RlYWQgb2YgaW50cm9kdWNpbmcgYSBu
ZXcgdm9wPw0KPiAtIEludHJvZHVjZSBhIG5ldyBjYXBhYmlsaXR5IGZsYWcsIGUuZy4gVUZTSENE
X0NBUF9TSU5HTEVfQ1EuDQo+IC0gU2V0IHRoYXQgZmxhZyBmcm9tIGluc2lkZSB1ZnNfbXRrX2lu
aXQoKS4NCj4gLSBNb2RpZnkgdGhlIFVGUyBjb3JlIGRyaXZlciBzdWNoIHRoYXQgdGhlIG51bWJl
ciBvZiBjb21wbGV0aW9uDQo+IHF1ZXVlcw0KPiAgICBkZXBlbmRzIG9uIHRoZSBVRlNIQ0RfQ0FQ
X1NJTkdMRV9DUSBmbGFnLg0KPiANCkFjY29yZGluZyB0byBzcGVjLCBkcml2ZXIgaXMgZnJlZSB0
byBhc3NpZ24gYW55IFNRIHRvIENRIG1hcHBpbmcuIEkgYW0NCm5vdCBzdXJlIGlmIGl0J3MgaWRl
YWwgdG8gY29uc3RyYWluIG1hcHBpbmcgdG8gc3BlY2lmaWMga2luZC4NCg0KPiA+IFRoZXJlZm9y
ZSwgd2Ugd291bGQgbGlrZSB0byBpbnRyb2R1Y2UgYSB2b3AgdG8gYWxsb3cgdGhlIGhvc3QgdG8N
Cj4gPiBjb25maWd1cmUgaXQgYWNjb3JkaW5nbHkuDQo+IA0KPiBXZSBkbyBub3QgYWNjZXB0IG5l
dyB2b3BzIHVwc3RyZWFtIHdpdGhvdXQgYSB1c2VyLiBXaGVyZSBpcyB0aGUgDQo+IGltcGxlbWVu
dGF0aW9uIG9mIHRoZSBuZXcgLmNvbmZpZ19jcWlkKCkgY2FsbGJhY2s/DQo+IA0KDQpZZXMsIHBs
ZWFzZSByZWZlciB0bw0KIltQQVRDSCB2MiAzLzNdIHNjc2k6IHVmczogdWZzLW1lZGlhdGVrOiBB
ZGQgTUNRIHN1cHBvcnQgZm9yIE1USw0KcGxhdGZvcm0iDQoNCitzdGF0aWMgaW50IHVmc19tdGtf
Y29uZmlnX2NxaWQoc3RydWN0IHVmc19oYmEgKmhiYSkNCit7DQorICAgICAgIHN0cnVjdCB1ZnNf
aHdfcXVldWUgKmh3cTsNCisgICAgICAgaW50IGk7DQorDQorICAgICAgIGZvciAoaSA9IDA7IGkg
PCBoYmEtPm5yX2h3X3F1ZXVlczsgaSsrKSB7DQorICAgICAgICAgICAgICAgaHdxID0gJmhiYS0+
dWhxW2ldOw0KKyAgICAgICAgICAgICAgIGh3cS0+Y3FpZCA9IDM7DQorICAgICAgIH0NCisNCisg
ICAgICAgcmV0dXJuIDA7DQorfQ0KDQoNClBvLVdlbg0K
