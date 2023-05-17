Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFC706345
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjEQIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEQIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:48:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1C1FFC;
        Wed, 17 May 2023 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684313287; x=1715849287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ksGvY8CSGyG+wWhAiQl6PPnLJNHCXtj0zuKlFPq78yw=;
  b=mQCWg8McqV1T6dOkaenJCq5nrEpjtIeuvve7qI9dx75Xnf8TA5Q4Tnuz
   W0DplUAdNESkdn8u9breSmUbzTal8C2/aZpRCK41yD6gSAspyWirZU7Cf
   Gj5iMra5cJGeO3bRPhUNwYOAsQ8zrxFjr3K8MVucMMx+1Lnziw4W6PwQ9
   mWzgNAw6604FlpghJkqfl8QP4UJV2APAoXbaUft9Pd1PNZdOTugg0Zlzr
   Zxb+lrfyEnU6Xi8V/HUpGs3tqx4HdXsj2BOtkYhqhxP93SSweU/HBQsI0
   sTAim26RJ8w73+sl0uKOvvBbSTVofUV8cdGSPIuYC+u1V/eAXK43eO/Ig
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="scan'208";a="215845908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 01:48:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 01:48:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 01:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxBjaJVpJLGOcVLKb0mAzYceI4xg16JVPDpJ9n6Gfme2J5ubeteH090xqCCVY8iI9eoq4P3IEcPOLXv/oDh2KW79f6oAtticJPzyPG0d00ZsXM1X5BpCEZVfGBRuzAEdmdFJfyYPAALKq4h4asolgPbx+8JzeH6KzPLvSpLTx/HTwYYC7n+uYw/vTSuy0akb4F6Jm3pMfOs6Y+aQ9vy0ATqSbNhrmjty/kOSWYzXbo5AdZRCzKRjywDzPJ3XGwX0x4QB7t7t66cLwC6rp0RM9GKchp78xaFfCAxJPHGXO8jfetP8rX7jMYKxBy+oyUGmPoFuMO2D1AuNysgtE8cjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksGvY8CSGyG+wWhAiQl6PPnLJNHCXtj0zuKlFPq78yw=;
 b=JeihitNA6lP8on/3X++C3F/hDokfSMTEPzEAQc2DnG7nu0Q69kV67/KIdBmNzyB7uFugT8wzO3G6iBi6miBNB4mVVx+7XsXhNXH+mKR11w8nAyrEjFde4Gh95HY3rU6QGlAFWJ3NJ6Gx3fulkSqlQlpHG+hWQgJDnCKEnwHyPMWb06xhY6WvXUK4uM0hDHrEzc3WrS3HgrgcqnKxdWen5CN6q62/bMa1q0dtLY+5cLv8r30nz7OZQY9ucf5yRvkEN70+p+bSAKycmHl/vNLYjPw3sg3AVXUkCsEQ07fEr6qxbK3Knny2R55DAeFplGiPNQ39HYV3rGi3ckoJvJzwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksGvY8CSGyG+wWhAiQl6PPnLJNHCXtj0zuKlFPq78yw=;
 b=l5pKDjpTv0zG+CiwmapMKTdgSwlBLnH3FvVwFGXNb5kkcOexqyaxnSJryb9dy0A6BK/HSoKJynJ1Dds+62QE36n5Q1M42XDckf4SsBPCICARODB9KtSEqrTlafzWzlZzUt2nTehKUN/JhrbefR/Km3Mpy688WqcPCy5P9biwuR8=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 08:48:04 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 08:48:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZiJxLlS7j96kN5EubResGVVnG+Q==
Date:   Wed, 17 May 2023 08:48:04 +0000
Message-ID: <131f3527-8ad8-bdd2-036d-6c8c61f69142@microchip.com>
References: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
 <20230516051836.2511149-3-claudiu.beznea@microchip.com>
 <20230516-modulator-reason-1d3a754c6dd7@wendy>
 <a42f5efd-0847-6a7d-5d2f-ad5772466664@microchip.com>
In-Reply-To: <a42f5efd-0847-6a7d-5d2f-ad5772466664@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CO6PR11MB5635:EE_
x-ms-office365-filtering-correlation-id: 6ffd77e0-4ac6-427e-466d-08db56b36dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBQdL2JZKy85/4gGrTTJZGKKRbMlyx3Jb7F/uRVtLDsaEREtpnkSyV2tL1ZllA52k2yu4LwLapHhEjZp540yMzkQzfI5nEKXZdXemfK0N97MfWxr+qUmXt7TFHnlGAjkw6YWJE/Uq1/o3kjS7Lqv0/Z7t056xLb1nxxPC0vNbN7eVkn+g3oukTaq5meS6ZgrTt2zc3kR97jJXNz3szO6dQVPZds/DIql/pi2jkXS64Vk+nxRoa5w27NSu/PukF1dxnVSB5A2yd+ICdMloJfUy9GJUp1V7tVhmPzH4I/AbdA3tiLTtZgcgtOUfV0UKS/hEOYKsPDIfQs6oTM5DlJnVmzpmXAeq2ayS55x+935iAlZrCxRrNZiHHVBFg5FMSPm2ZwDO2ROAmKglOY8WaF2ukGdeoAMrwvCg11GHOSWkexe2i36/rba24X75bQsUr3R5lGqpeBLfHdcj8s/dtgsyktBJlaCQly0rDUKysoqbZfAGOCvPytMrwNfU1WS45nzCqFzXD1S6XndU7GsHgevNMEDe7K4wagH7vnochrULZpwopA6yyCXsZ572TquayEjhT9H4HmvkD1UE1Ag30M/wgBEU1YbIkAnxiYKyTKJE8zB6h5V5O8sGBMGxoJGyXeCEmspzIwzsQ3gy3DpdDtQkvggi8EkxiVmDnzf4WL6A7JxbBknoKeAGmi1MGBGSXyU4IHDcdRjze7yKS4iqLbGPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(31686004)(966005)(316002)(4326008)(6636002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(37006003)(91956017)(54906003)(36756003)(38070700005)(31696002)(86362001)(83380400001)(26005)(6506007)(6512007)(2616005)(186003)(53546011)(41300700001)(5660300002)(8936002)(6862004)(8676002)(6486002)(2906002)(71200400001)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXIweHFkdW9ud0Y4RG5rOUFza2JtYkZPY0FUZVI5V3FIS1U0MDZhK0pvMzRs?=
 =?utf-8?B?L1ZMZUZ0R052UDIxRjg3V0hVeUNDVHlZRFlYWC83ZzNVM0k3RWFVSFdTRE1Y?=
 =?utf-8?B?c1d3cVdPamNuaWd6a2tVem9DdTBUL2xZbmE3MFRld0NBbDRKV2h5aVA1MmZk?=
 =?utf-8?B?ekpTUkZPNjAxcTFmQVdvejM4bGVQVWNoMGsxVEJEcS9USTFQNjZxaWxIcHdo?=
 =?utf-8?B?VXRpdUd0bFFCTUFrUkdHOVhiU0Jlc09GN3Iya1ZjM1R5MVZpOW5pYkh3SFd5?=
 =?utf-8?B?aitpbzhZWlloM0lRQkRPb2ZnKzFkdGdJajVTaDNjMTh6RWhtRDhLUENaOFB1?=
 =?utf-8?B?bzh3RWhJWHpDWUVORmdwN1dqL2V2enpXUmtSVTZ4c0QrZlUrQTJvVjhWWmpN?=
 =?utf-8?B?TFgzWnZyMmRSdmw2ZlpPVk9DSVd2RllFb1BsVWtXNmw2ci90NWZ0bnJuMkRK?=
 =?utf-8?B?SmQ3WU9rMzVCY3hobmxmMHUxNDRVZUNnSHhLOHNOMDZFY1ZyZmM4Y2Z1Rjlk?=
 =?utf-8?B?MW1Rd3lLNjFHZERqUWhUUjIzWHFiNURzTUJFYWkxSC82dks1cmxUTFhXeHYy?=
 =?utf-8?B?Y3FoOUl5VUVzSzFPVWZHa0xaWUlBSHErOXRIZytGRUxDeXJIT3J4YVhPeW1h?=
 =?utf-8?B?dloxaEZIcmxPZFBWUitvbVRnMzR0UC9XaVNlVjZJOGdBaVdMNmhwTkQzT3ZN?=
 =?utf-8?B?UlQ1Y052V3cwUXllL0VjbWQ3dktreVhuTXZ5WEFvYmZzcDhVTS9xTEVUZEFN?=
 =?utf-8?B?bGs1RVdZZjQ0dXJROHphQy9XT0pkVDFKVWR6WWlQV1dWK3FTMUJRcXgydEhF?=
 =?utf-8?B?YzM0d2pUYzBNRmQwRGJMZHpsMVNndjIvbVpSQkIvcEZjK2VXK3pUeEwrZFox?=
 =?utf-8?B?K1VXbTkxY3dUODA0YllkSVhYQXM1YkdDM1VXK2t1NlcyVE9GV0VjeFRibWl1?=
 =?utf-8?B?NW5jcGVGaWMwU2RIaEVEVkdDNDVaVElNeS9Ubm1GTHZtbE9rS2owODJGd1pC?=
 =?utf-8?B?ZEk3aVY4dmdDOEtWWmREM2IvTnQzT1VxUXJNUEVnTDFsalJoTHhXOCtaMEJn?=
 =?utf-8?B?SmxiVXJmRmZ1UGJhNmVrVGovdUswTGZqeUlwdndaZ0VhOTZEZGM4TUUyemVM?=
 =?utf-8?B?UXNzV2lHa0tXS3orLzVXRGU1WDlYQWNBZm83TnBGUFZScDVKR2VDeStDWWhT?=
 =?utf-8?B?aEs3YnpFbzMvakpUZmducTNUT1YyOWs2MmhycEpWM3FyZGpRRnlzQUQwT0tX?=
 =?utf-8?B?NFhGOWd4SDRXdGROVHZmazhOZFUxOGhmNnZQREtmSW14cHd2Nkd5T2d0Kys3?=
 =?utf-8?B?TVhtQmk5bkY2cHVuTnlzTGhnV0FHSTNYT01RZFpCcVJBb2V2VHVXalJnZVBj?=
 =?utf-8?B?SElFK2pVTndRNThIRmR0RVdCeUF2OVQ5Z2I5alE0R1hKaFBtU3k5VWxMeWN5?=
 =?utf-8?B?Z05YNXlKanFvaUF5eFkzeVdUSXRrUlFjZTdJUThFZUsvWS85MFZ6MHpGV0wr?=
 =?utf-8?B?TUptdTByMWprcENJOGJibC9tWW16enJ1WlRtU3NXMit3bXF4OW5MKzBTTDJB?=
 =?utf-8?B?ZUExTXNwRmVqdStUK21UVlgvbTE4NU12RjJDcnFoMk1KcCtWNkFUTXhLYWJy?=
 =?utf-8?B?Q2NhODlCdmRmWHpoam96b28wODZ5MmloQ1JBSjNYeTY1RndoeGxFZlZjbGpL?=
 =?utf-8?B?djRYdFc1bmN3SFk2YzNFVURVUWNKZWxSZ1pLOFB2dHJLQmVBWjFteW5ZVWdV?=
 =?utf-8?B?cWk2c2VzV0FYajJIV0RCWndzYVhoNFk3dVU5NnhLRTJLWGxDUmZhY0dTN2FR?=
 =?utf-8?B?N1JvQUlJZ3BzM2hsVkZYamRZSjhtdHpiODkzVGNQRXdTYnFEelNFM29mMTRB?=
 =?utf-8?B?MFEzc2U3Mkl5VVpDWjdncXZjVUUrSTdoWStDM3dNemhPR0VFUmR3TWRIRTdL?=
 =?utf-8?B?K0c4aXgrYkhmZWZkWEZpUzBIMTVrMGVjeW1qVzMwZkt4RER3Nm5pV1NmdGgw?=
 =?utf-8?B?UFg3TzdZcTFRMnBnVGgzOUluQ2FCWEZDay94OEZxLytRTFhSYTUrenpYZkVu?=
 =?utf-8?B?bWRaRG03ZzRuWnpaTUQzaVpLa0IyNHViMG1hb01maUorRzc5amswWFBrMThD?=
 =?utf-8?Q?rXbJjcUQ90H0d2Vac4e0pOJFs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5EDE7D75E2BB344A7F9E2B599E75D05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd77e0-4ac6-427e-466d-08db56b36dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 08:48:04.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2BSbKIv8A04OYw7Pqp3kuOxgnSYAlqPIicI5U95eWPdxQA8qBGuros139VyW/GkAfhA4Fx50WGQDkOFBWCZ4KyXQ2Fw0kmJxNDgdnO3E9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDUuMjAyMyAxNTo1OCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IEhp
LCBDb25vciwNCj4gDQo+IE9uIDE2LjA1LjIwMjMgMTU6MDAsIENvbm9yIERvb2xleSB3cm90ZToN
Cj4+IEhleSBDbGF1ZGl1LA0KPj4NCj4+IE9uIFR1ZSwgTWF5IDE2LCAyMDIzIGF0IDA4OjE4OjMz
QU0gKzAzMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+IENvbnZlcnQgQXRtZWwgUE1DIGRv
Y3VtZW50YXRpb24gdG8geWFtbC4gQWxvbmcgd2l0aCBpdCBjbG9jayBuYW1lcw0KPj4+IHdlcmUg
YWRhcHRlZCBhY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQgYXZhaWxhYmxlIGRldmljZSB0cmVlcyBh
cw0KPj4+IGRpZmZlcmVudCBjb250cm9sbGVyIHZlcnNpb25zIGFjY2VwdCBkaWZmZXJlbnQgY2xv
Y2sgKHNvbWUgb2YgdGhlbQ0KPj4+IGhhdmUgMyBjbG9ja3MgYXMgaW5wdXQsIHNvbWUgaGFzIDIg
Y2xvY2tzIGFzIGlucHV0cyBhbmQgc29tZSB3aXRoIDINCj4+PiBpbnB1dCBjbG9ja3MgdXNlcyBk
aWZmZXJlbnQgY2xvY2sgbmFtZXMpLg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55
YW1sDQo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmU1
ZjUxNGJjNGJmNw0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbA0KPj4+IEBA
IC0wLDAgKzEsMTUzIEBADQo+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4+ICslWUFNTCAxLjINCj4+PiArLS0tDQo+Pj4gKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1w
bWMueWFtbCMNCj4+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1h
cy9jb3JlLnlhbWwjDQo+Pj4gKw0KPj4+ICt0aXRsZTogQXRtZWwgUG93ZXIgTWFuYWdlbWVudCBD
b250cm9sbGVyIChQTUMpDQo+Pj4gKw0KPj4+ICttYWludGFpbmVyczoNCj4+PiArICAtIENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+ICsNCj4+PiArZGVz
Y3JpcHRpb246DQo+Pj4gKyAgVGhlIHBvd2VyIG1hbmFnZW1lbnQgY29udHJvbGxlciBvcHRpbWl6
ZXMgcG93ZXIgY29uc3VtcHRpb24gYnkgY29udHJvbGxpbmcgYWxsDQo+Pj4gKyAgc3lzdGVtIGFu
ZCB1c2VyIHBlcmlwaGVyYWwgY2xvY2tzLiBUaGUgUE1DIGVuYWJsZXMvZGlzYWJsZXMgdGhlIGNs
b2NrIGlucHV0cw0KPj4+ICsgIHRvIG1hbnkgb2YgdGhlIHBlcmlwaGVyYWxzIGFuZCB0byB0aGUg
cHJvY2Vzc29yLg0KPj4+ICsNCj4+PiArcHJvcGVydGllczoNCj4+PiArICBjb21wYXRpYmxlOg0K
Pj4+ICsgICAgb25lT2Y6DQo+Pj4gKyAgICAgIC0gaXRlbXM6DQo+Pj4gKyAgICAgICAgICAtIGNv
bnN0OiBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVs
LGF0OTFzYW05MjYwLXBtYw0KPj4+ICsgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+Pj4gKyAg
ICAgIC0gaXRlbXM6DQo+Pj4gKyAgICAgICAgICAtIGVudW06DQo+Pj4gKyAgICAgICAgICAgICAg
LSBhdG1lbCxhdDkxc2FtOWcxNS1wbWMNCj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFz
YW05ZzI1LXBtYw0KPj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMzUtcG1jDQo+
Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOXgyNS1wbWMNCj4+PiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05eDM1LXBtYw0KPj4+ICsgICAgICAgICAgLSBjb25zdDogYXRt
ZWwsYXQ5MXNhbTl4NS1wbWMNCj4+IFlldCBhbm90aGVyIGNvbWJpbmF0aW9ucyBxdWVzdGlvbiBm
b3IgeW91Li4uDQo+PiBXaXRoIHRoaXMgYmluZGluZyB0aGUgZm9sbG93aW5nIGlzIG5vdCBwb3Nz
aWJsZToNCj4+DQo+PiAiYXRtZWwsYXQ5MXNhbTl4NS1wbWMiLCAic3lzY29uIg0KPj4NCj4+IElz
IHRoYXQgaW50ZW5kZWQ/DQo+IA0KPiBObywgSSd2ZSBqdXN0IG1pc3NlZCBpdC4gU2FtZSBmb3Ig
dGhlIGFib3ZlLiBJJ2xsIGhhdmUgYSBuZXcgcm91bmQgYW5kIGZpeCBpdC4NCg0KVGhvdWdoLi4u
IHNob3VsZG4ndCB0aGlzIGhhdmUgYmVlbiBkZXRlY3RlZCBieSBtYWtlIGR0YnNfY2hlY2s/DQoN
Cj4gDQo+IFRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vayBhdCB0aGlzLA0KPiBDbGF1ZGl1DQo+IA0K
Pj4gSSBub3RpY2UgImF0bWVsLGF0OTFzYW05MjYwLXBtYyIgaXMgYWJsZSB0byBhcHBlYXIgYXM6
DQo+Pg0KPj4gImF0bWVsLGF0OTFzYW05MjYwLXBtYyIsICJzeXNjb24iDQo+Pg0KPj4gU28gdGhl
IGluY29uc2lzdGVuY3kgc3RhbmRzIG91dC4NCj4+DQo+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBz
eXNjb24NCj4+PiArICAgICAgLSBpdGVtczoNCj4+PiArICAgICAgICAgIC0gZW51bToNCj4+PiAr
ICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFybTkyMDAtcG1jDQo+Pj4gKyAgICAgICAgICAgICAg
LSBhdG1lbCxhdDkxc2FtOTI2MC1wbWMNCj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFz
YW05ZzQ1LXBtYw0KPj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTluMTItcG1jDQo+
Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOXJsLXBtYw0KPj4+ICsgICAgICAgICAg
ICAgIC0gYXRtZWwsc2FtYTVkMi1wbWMNCj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1
ZDMtcG1jDQo+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQ0LXBtYw0KPj4+ICsgICAg
ICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtcG1jDQo+Pj4gKyAgICAgICAgICAgICAgLSBt
aWNyb2NoaXAsc2FtYTdnNS1wbWMNCj4+PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4g
T3RoZXJ3aXNlLCB0aGlzIGxvb2tzIGdyYW5kIHRvIG1lLg0KPj4NCj4+IENoZWVycywNCj4+IENv
bm9yLg0KPiANCg0K
