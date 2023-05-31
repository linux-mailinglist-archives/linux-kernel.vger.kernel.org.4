Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41098718561
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjEaOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjEaOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:55:14 -0400
X-Greylist: delayed 264 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 07:55:12 PDT
Received: from sjdc-mailout6.udc.trendmicro.com (sjdcvmout03.udc.trendmicro.com [66.180.85.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5B107;
        Wed, 31 May 2023 07:55:12 -0700 (PDT)
Received: from sjdc-mailout6.udc.trendmicro.com (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B7AC2B617DD;
        Wed, 31 May 2023 14:50:47 +0000 (UTC)
Received: from sjdc-mailout6.udc.trendmicro.com (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9F4A9B617D0;
        Wed, 31 May 2023 14:50:47 +0000 (UTC)
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn Y3Jpc190YWlAdHJlbmRta
        WNyby5jb20=
X-DDEI-TLS-USAGE: Unused
Received: from SJDC-EXCH02.eu.trendnet.org (unknown [10.45.168.5])
        by sjdc-mailout6.udc.trendmicro.com (Postfix) with ESMTP;
        Wed, 31 May 2023 14:50:47 +0000 (UTC)
Received: from SJDC-EXCH01.eu.trendnet.org (10.45.168.3) by
 SJDC-EXCH02.eu.trendnet.org (10.45.168.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 14:50:45 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 exhybridnabu.trendmicro.com (10.45.168.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:50:44 +0000
Received: from PH0PR01MB6455.prod.exchangelabs.com (2603:10b6:510:a::14) by
 PH0PR01MB7365.prod.exchangelabs.com (2603:10b6:510:10e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 14:50:38 +0000
Received: from PH0PR01MB6455.prod.exchangelabs.com
 ([fe80::9640:5dfc:5011:38e9]) by PH0PR01MB6455.prod.exchangelabs.com
 ([fe80::9640:5dfc:5011:38e9%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:50:37 +0000
From:   "Cris_Tai@trendmicro.com" <Cris_Tai@trendmicro.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Sam Ravnborg <sam@ravnborg.org>, Stafford Horne <shorne@gmail.com>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "majordomo@vger.kernel.org" <majordomo@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Question]Deprecation of force_access_*
Thread-Topic: [Question]Deprecation of force_access_*
Thread-Index: AdmSromKp5qoYEVXQyCpbH3Xs8hetgAAg8tgAAYMHIAAC6M38wAz+DYA
Date:   Wed, 31 May 2023 14:50:37 +0000
Message-ID: <PH0PR01MB645586AEE00DBBD7D6CAD89D8E489@PH0PR01MB6455.prod.exchangelabs.com>
References: <PH0PR01MB6455F105A2788475E76EFC948E4B9@PH0PR01MB6455.prod.exchangelabs.com>
        <PH0PR01MB64556CE141BE3F708CFA3F408E4B9@PH0PR01MB6455.prod.exchangelabs.com>
        <3cbc3100-5437-4df3-8696-b56397ee44b9@app.fastmail.com>
 <87353eezsh.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87353eezsh.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=True;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2023-05-30T13:04:57.6450366Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR01MB6455:EE_|PH0PR01MB7365:EE_
x-ms-office365-filtering-correlation-id: 9edee2a8-3c88-4985-332f-08db61e66573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2juOEWGmScBMLjQi+4u02RMBgiXNqlLyloJTKuZgLzGDzN3IKH/NkrVMkKhHWRlwvmhQZ42DczO/ihxOAcmcxLfGMkY4CJyeNvhplYT7V3PgrHgPjquaMi4/C99/dxwSfMCpzCXHajEZVzvmHJ/bm6nUm5QXAYUn1jHGTwCE3a/jnJKdtRMahkCVRtMIp8vTzkJelCSgRAd0fHHZkdNcAxvzWHdoWJX1uKPWsC27tFTYjZr542nM0wABr0c6LlYVrZhWDN+oOa4UhuxgLeMGDkk2bbQe5sJOn4IYZ5tPiYFuJz6OfKV04Zo0BcWhukHPYWztA/Pn3yZ8i19VLjVj+IEpjYrjG2J4JItOC0pXqHAdEiIeX/K+H1uRlJyr7l6yEj6IcN0bWk7afW8ROzqLGy1iRz8U+CXjhhTheCElLAETOcqs/jwW9lrbWs0YC/fpzoK9D1TwGncdEYmCm2uBEYOi8cKOYrVNFxFsQBNyXaDgdOaL2S20sHYxASkKYlHjECLEY10uFxuOrFl/WXvesQ6M5sDhhCLyuX3JHiATyeA/ho6cB2mVGAD5qrYTE+YFjjdNU1vM950xnG8MHj+RFna+1HrurzhjzFm0oqNWP2MmtAtDZC9hTQXukUBLTlw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(54906003)(71200400001)(478600001)(110136005)(64756008)(8936002)(2906002)(5660300002)(52536014)(8676002)(33656002)(38070700005)(86362001)(66946007)(66556008)(66476007)(76116006)(66446008)(4326008)(82960400001)(316002)(122000001)(55016003)(38100700002)(41300700001)(966005)(6506007)(26005)(9686003)(186003)(7696005)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWQvYkVnOWMyWm1ORG9UdUljZVBKam54a3VMVHI3TjdBaWhnSzdSZkN2amw5?=
 =?utf-8?B?c0pBdlY0c0JESEdDblZGRzdWc1E3Wk85WEQ0TkpjaTRtOFlObktpZ1NqbEVV?=
 =?utf-8?B?YjFyaEhIdzROSFIvRlVNWEwvZzF6OFVTNGhBZlI2dW04cTNkN2J2QmRYM3B5?=
 =?utf-8?B?RlVRNCt3czczOG9hcVpDV1BOMlJVUkxOMjdGQjhhN1Q4SnVEdHRqRnN6TVRp?=
 =?utf-8?B?a29IdFo3eVIwYjQ2dWVsUjdTUzQvdkl1R3l3aFhIaEhnOXROUmIvWGhLUWNI?=
 =?utf-8?B?OWlIS2ViVDhOUjFhUW1KQ2RlY3g0cnVwUjJEWEFrTzBKVmpXdUhrOFo4cVBY?=
 =?utf-8?B?Yy9Ca09nSHNaUE1xZk5RTVVsZjg1YldQeW5zdVFVQ2JJUDFKUFg5UVA4WUlY?=
 =?utf-8?B?SkJ3TmE5N0M5YTR2MTF6R2hGUVdMT25YM1k2eHBBMHhYZ2pUSTNVaE41SExC?=
 =?utf-8?B?RVBHR3RBYTZRS0VxWnhaWkhuTHF6L2lZV3N1bGNxVXRDU2UvZHJaYmFrTytR?=
 =?utf-8?B?bUNDWXpmU3pyVkJiMERQVW9Vckt1S1E2ei9XblFyZjBtc0kzMFh1Z3VqUjZV?=
 =?utf-8?B?WGo0Z01TSnk5TzFYclV4YXIwNDVkTzEzOHZJUmgyNGd4cGlBZlNQTWZEMnFl?=
 =?utf-8?B?aXNEL0tlcWUwUklFNkhubjFET2RaZ3BNUS9hZmMxdWhUTVZ6QzBRV3B1RVJh?=
 =?utf-8?B?RnYwblh2Y0NCalJWQ292QU50aGJTUEJ2d0FIQTZVYkY0eG0zc2pIOTc0ZFRl?=
 =?utf-8?B?aDBKbVVrSG84YlJ1SjJSczNLWllVQU9hVTJzbnZhMGZCVldBYW94LzV2U3RH?=
 =?utf-8?B?T0RndkNwaGxjdnBNL1hLVFFBSk1aZFVxVnlyektCem5jai9tdDl0UWFOb0Fu?=
 =?utf-8?B?NERDT1RocHBzVUxZejhYT2cwTUNteC9PdEk4ZUJJMjZVVEhzSFZBWjBuNnBw?=
 =?utf-8?B?SlpwYURacXQvQ1lBMW9CT21QL0NZZ09vZk5kMHpQVm8vZ2ZGU3E3VTFoQ2NS?=
 =?utf-8?B?WktBbnRtcUh0Tk5LWG9VdEJlVkwwR2gwcEtLVXphclJQa0xoNkQ4VmJUZ1lE?=
 =?utf-8?B?ZlYrQ05LeEI1d2oyaWd3V01VL2R3d0psRWE2UkpacHR4a0tTdVR6U0JuNGxz?=
 =?utf-8?B?emlTc1NUMHg0S2MvbFJqekNkVFRRd3l5ZXpNdzkvRE1RQnVsWldoQlJubTJU?=
 =?utf-8?B?QjA0R1hSVk1WUTJkZEY5ZkprMU1tcDV5ck5oTVpYcW9Lb0dyQ0VnNy9oZ1dv?=
 =?utf-8?B?RVgxcSttbFR4Qk8zQ0J4S0VzNmxQSHgvK2VUbFVibUdrYWJSbnh0K0k5Kzcy?=
 =?utf-8?B?UUpHeGVJNzRhR0lKRS9COVFieEVXa0JxWVBpNWZYRE5pYTh3N25IcWkrK3lT?=
 =?utf-8?B?c0krdkdPdHBBNzJJWTQ3K0JXR2NTRDFFTCs1R0pyb1U5ZE84TXRSSzhqZ3dj?=
 =?utf-8?B?YkJJcHdwT2ZGOU94TDBJQkR4YnVRN3VFcnVKeHJhSktIRXk1djVRK3Rlb1Fp?=
 =?utf-8?B?Y0VCaFNRbmFDZmxVeVJCUzFka0lCY09iaG1TNG1EWktzblo1TmczcTdVNFhy?=
 =?utf-8?B?d0UyQi8xbnk0SWR0WlU5VnhTZGs0dnFKUUVwRDNWN2oxQmRTVC8zYTBldDly?=
 =?utf-8?B?NkhGd0ZUTkIvWTJXZCsyTVBMNUl4UFhER2lVRDM2SmlYVm5SYUJIenhoY3Ez?=
 =?utf-8?B?NDZ6OWZGQjdWK1pBQ1pwdTcxOHhJaHhHT1FlOEtjSHUwamc1OWkyNkhTWHRi?=
 =?utf-8?B?dVFsdks3ZWZ4bDJlK09NQmdBd3pDbVRNNVJjdW5YRUdYRnFTRzF6cnhyZUVh?=
 =?utf-8?B?Y3Fab0VRNmhqeGpHR1YyZzFPZXVSclBHU2s3cElxcUI3ZlF4QmI1RVlpZUlz?=
 =?utf-8?B?cXEyV1ZyMVFBakxldmp6OGZYK2huakY5aTZoSjFQU0t2dE9IOHVOelp1V0ph?=
 =?utf-8?B?Q3BpbENEYmgxSFFOcUFiVlB3Y1RaVGlmZG9neU40WlNSK0NReVVublBsQVNo?=
 =?utf-8?B?d2VMT1o1bHR6TERKc3B5VW1yYkFFSk1oL2cvUklHYWt1aGxaNWd0cnZoSjJR?=
 =?utf-8?B?cnYvWmFzVmJpbzI1eTBkVFFUVTVZaHowMlM1b2U5d3NLTHpwZnFHeXk5dnYv?=
 =?utf-8?Q?0C4Pq7akMiyI78+npo7MHp6v0?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJnk98GnKKJRhl+CjXtaQdzPT6C14sPyV0OE6TF0FziVy4oI8vII+a7AoCiss1NNw3JmR2fNIOm4WaFTk+v9nkI9YDIOl8Cx4GBbdzRXsm8rbztSSYCUuOQ+NXFYJ7wSsdn+Aw8q57/mGaxxP7pIGN20FeQfzv9NAVf7pT75oRIibEs1z4akXGYiQKNrDBpQlzKk5DuMHJMUa6odpv5tMJhn+YuVfvKvRS7fl4+1q6xP/t9/ETeY3LKqAVwIrQy0nswsELloYuyJIyrhBiVLWXqvTcvm2R5reamCmAJM4CGXhKi5Pbqc7BbS26E2dSCVJ5NzrPS1i7Uf99JR4Zh5Hg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQTi/6YlyfatOUR5ZD67Qy4FuAziUWdFYgNGG/pUTkc=;
 b=QyvcOPpvYOvQc3/lXGqmBqXIPVT6WbuYWo66gqwYJGAO7wO1iajOCXFfyujf3VmjS8XRyyJm4tAdIkDbA/5TIPOu6jrjv2xodGXgu9Y/xFqXJChU/IhcqU0eJ3YqrCbzHPfgTuI9DEweHouc1VioDKNiPxP8MyJSdyZ6AJ2Lw01fxLsClBn18RxSx8tpYyF0tc0PtP8U1JI4iKAdHP4LOGQk7eVYE9wPy4vtfWevghgD02MGMc6yUjDzSSMl/1GKdmuanCpmDBPnmjziyInFziFV6A0xzE/TwCEzUcaqjsgeykEgi7v8lUWXX/YdEqd3m4uPzaxJGQo06CZRVPKc4A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: PH0PR01MB6455.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: 9edee2a8-3c88-4985-332f-08db61e66573
x-ms-exchange-crosstenant-originalarrivaltime: 31 May 2023 14:50:37.5332 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Ky2esbZ1AK+JPtXT44/SLs3pNqeUEsHb++BT7NOFai8TCMpnfSfDo1WmAL5PpNaMhGCIyJwMKr/zZDbkh3fauA==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR01MB7365
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27664.000
x-tm-as-result: No-10--36.003800-5.000000
x-tmase-matchedrid: cqdSFfwslhg2eFTDBkQySu5i6weAmSDKkYC3rjkUXRLe6dEbvIyrxYUO
        mGTb5yG/k5uenlGv39LBgqOTdp7g4jQmrIfRqtAk+GYt8f/VhTsxXH/dlhvLv7DGRtqVMwHzmmP
        5c2pTo3ud4pyst6Igw64BUOurIHPcm3tkJNb9bT8qIkSpQVZGCHZljA0Gozoi/mtU6zZvDhH64E
        XalNg4NfOxJCWoZZBZIfmUkIzjDWuOi361F0D4Jf7FEhWgo0y8R8s92weZBudQKAQSutQYXE7Hf
        nB/xfeqJIkym79v1BOji8Jve2EBbRMKyyUVs6nMutvHF25zoU9R3sGN+j7mNCN3bl6Adla6PieV
        RgmhMn8zWOCn0s1gaQkj9soPk8vT5wXTDmkn5c/huntKSqs2aUi8rgutezVpth6QveQfsqOhXb1
        oqJ5eJHmq6YJ837xP/kVUaKWgKIbOWGE/gzv0iJKLzY5Zrthjo8tN19oTXlc1k41TP3DSL+ygZw
        V7oJQcRgz9sOnh4ulucftoZZ+9Sv9ehdaP6yTuF+qQpCWTUjkO4jfa+nI3P5xvJrCyJGN3o3rfu
        CGo7LZeAO0T1zuuskEKbfrhqxiuCbm0451GVI2JDLgwb/1K2WmRqNBHmBvelpyqxIUg/ZT5kvmj
        69FXvKEwgORH8p/AqT43asAfakVJV3La6JhRYmpxNWG2/ceFhUfR2rvBju4D/dHyT/Xh7Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--36.003800-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27664.000
x-tm-snts-smtp: A8B06135254219A19B014259FE693D0A2E63A0D24A6BD4ED4BCF2DA64214EE6F2000:7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-ERS: 10.45.168.5-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pEQy1FWENIMDIuZXUudHJlbmRuZXQub3Jn Y3Jpc190YWlAdHJlbmRta
        WNyby5jb20=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1685544647;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; l=0;
        h=From:To:Date;
        b=hx9B5A+FguyfSkk0MMMgUOYWxA61NWooj6gXymTFHZo5RKZVXJIfD2wV6/3XjhA0J
         QvoaPX3LYb3/k4epJBnPDB+eMAHFCaq2ipngpOE6nVpljmiUSUmw+UbvlFWQPzVPxQ
         AQiVs0I+/47/JiLPG4m/2fc3nGyF6meT8NjSPNQY=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJpYyBhbmQgQXJuZCwNCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIGFuZCBncmVhdCBhbnN3
ZXJzLg0KQmVsb3cgaXMgYSBmdXJ0aGVyIHF1ZXN0aW9u77yaDQpTaW5jZSBzZXRfZnMoS0VSTkVM
X0RTKSBjYW5ub3QgYmUgdXNlZCBub3csIGRvZXMgaXQgbWVhbiB0aGF0IHRoZXJlIGlzIG5vIHVz
dWFsIGFjY2VzcyBjaGVjayBub3c/DQpJZiBrZXJuZWwgZHJpdmVyIHVzZXMgc2V0X2ZzKEtFUk5F
TF9EUykgZm9yIGtlcm5lbC1zcGFjZSBidWZmZXIgYWNjZXNzLCBjYW4gc2V0X2ZzKEtFUk5FTF9E
UykgYmUgcmVtb3ZlZCBzYWZlbHkgb24gcmVjZW50IGtlcm5lbHM/DQpBcmUgZnVuY3Rpb25zIHRo
YXQgcmVseSBvbiBzZXRfZnMoS0VSTlJMX0RTKSBuZWVkZWQgdG8gYmUgcmVwbGFjZWQ/IElmIHll
cywgY291bGQgeW91IGhlbHAgcmVjb21tZW5kIHNvbWUgcmVmZXJlbmNlcz8NCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpOb3JtYWxseSwgdGhhdCBib3VuZGFyeSBz
aG91bGQgYmUgZmlybWx5IGZpeGVkIGluIHBsYWNlLiBXaGVuIHRoZSBuZWVkIHRvIG1vdmUgaXQg
YXJpc2VzLCB0aGUgcmVhc29uIGlzIHVzdWFsbHkgdGhlIHNhbWU6IHNvbWUga2VybmVsIHN1YnN5
c3RlbSBuZWVkcyB0byBpbnZva2UgYSBmdW5jdGlvbiB0aGF0IGlzIGludGVuZGVkIHRvIGFjY2Vz
cyB1c2VyLXNwYWNlIGRhdGEsIGJ1dCBvbiBhIGtlcm5lbC1zcGFjZSBhZGRyZXNzLiBUaGluaywg
Zm9yIGV4YW1wbGUsIG9mIHRoZSBzaW1wbGUgdGFzayBvZiByZWFkaW5nIHRoZSBjb250ZW50cyBv
ZiBhIGZpbGUgaW50byBhIG1lbW9yeSBidWZmZXI7IHRoZSByZWFkKCkgc3lzdGVtIGNhbGwgd2ls
bCBkbyB0aGF0LCBidXQgaXQgYWxzbyBwZXJmb3JtcyBhbGwgb2YgdGhlIHVzdWFsIGFjY2VzcyBj
aGVja3MsIG1lYW5pbmcgdGhhdCBpdCB3aWxsIHJlZnVzZSB0byByZWFkIGludG8gYSBrZXJuZWwt
c3BhY2UgYnVmZmVyLiBJZiBhIGtlcm5lbCBzdWJzeXN0ZW0gbXVzdCBwZXJmb3JtIHN1Y2ggYSBy
ZWFkLCBpdCBmaXJzdCBjYWxscyBzZXRfZnMoKSB0byBkaXNhYmxlIHRob3NlIGNoZWNrczsgaWYg
YWxsIGdvZXMgd2VsbCwgaXQgcmVtZW1iZXJzIHRvIHJlc3RvcmUgdGhlIG9sZCBib3VuZGFyeSB3
aXRoIGFub3RoZXIgc2V0X2ZzKCkgY2FsbCB3aGVuIHRoZSB3b3JrIGlzIGRvbmUuDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSSdtIG5vdCBzdXJlIGlmIGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgaXMgY29ycmVjdCBsaW51eCBrZXJuZWwgbWFpbGluZyBs
aXN0LiBJZiBub3QsIGNvdWxkIHlvdSBoZWxwIHRlbGwgbWUgdGhlIGNvcnJlY3QgbWFpbCBsaXN0
Pw0KDQpUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcgdGhlIHF1ZXN0aW9u
cyBhbmQgcHJvdmlkZSBhZHZpY2UuDQpPbmNlIGFnYWluLCB0aGFuayB5b3Ugc28gbXVjaCBmb3Ig
eW91ciBoZWxwLg0KDQpCZXN0IFJlZ2FyZHMsDQpDcmlzDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEVyaWMgVy4gQmllZGVybWFuIDxlYmllZGVybUB4bWlzc2lvbi5jb20+
DQpTZW50OiAyMDIz5bm0NeaciDMw5pelIDIxOjA0DQpUbzogQ3JpcyBUYWkgKFJELUNOKSA8Q3Jp
c19UYWlAdHJlbmRtaWNyby5jb20+DQpDYzogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3Jn
PjsgU3RhZmZvcmQgSG9ybmUgPHNob3JuZUBnbWFpbC5jb20+OyBEaW5oIE5ndXllbiA8ZGluZ3V5
ZW5Aa2VybmVsLm9yZz47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQpTdWJqZWN0OiBS
ZTogW1F1ZXN0aW9uXURlcHJlY2F0aW9uIG9mIGZvcmNlX2FjY2Vzc18qDQoNCg0KVGhpcyBtZXNz
YWdlIHdhcyBzZW50IGZyb20gb3V0c2lkZSBvZiBUcmVuZCBNaWNyby4gUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXNlIHRoZSBz
b3VyY2Ugb2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCiJB
cm5kIEJlcmdtYW5uIiA8YXJuZEBhcm5kYi5kZT4gd3JpdGVzOg0KDQo+IE9uIFR1ZSwgTWF5IDMw
LCAyMDIzLCBhdCAwNjo0MywgQ3Jpc19UYWlAdHJlbmRtaWNyby5jb20gd3JvdGU6DQo+PiBEZWFy
IExpbnV4IEtlcm5lbCBEZXZlbG9wZXJzLA0KPj4NCj4+IEkgd291bGQgbGlrZSB0byBhc2sgYSBx
dWVzdGlvbiBhYm91dCBhIG1vZGlmaWNhdGlvbiBpbiB0aGUgTGludXgNCj4+IGtlcm5lbC4NCj4+
IDEuICAgICBUaGUgbW9kaWZpY2F0aW9uIGNvbW1pdCBpcw0KPj4gaHR0cHM6Ly9kZGVpNS0wLWN0
cC50cmVuZG1pY3JvLmNvbTo0NDMvd2lzL2NsaWNrdGltZS92MS9xdWVyeT91cmw9aHR0DQo+PiBw
cyUzYSUyZiUyZmdpdGh1Yi5jb20lMmZ0b3J2YWxkcyUyZmxpbnV4JTJmY29tbWl0JTJmOTY3NzQ3
YmJjMDg0YjkzYjUNCj4+IDRlNjZmOTA0N2QzNDIyMzIzMTRjZDI1JnVtaWQ9MUQ3RTBBMTktRkNF
OC1BMTA1LThCRDUtN0I3NkI2Njg5N0UzJmF1dA0KPj4gaD1mYzhhOTM3MmI0YmYyMGVlNDE1YTNi
ODNhMjdiODdjYTI1ZjFhOWE1LTZjZDYxYjNkOGFhNjA3YzQwYzVlYTk3MTM1DQo+PiA0OGY5N2Jj
MzZhYzY3NA0KPj4NCj4+IFRoZSBmdW5jdGlvbnMgZm9yY2VfdWFjY2Vzc18qIGFyZSByZW1vdmVk
LiBBbmQgdGhlIGNvZGUgaW4gdGhlIGNvbW1pdA0KPj4gc2hvd3MgdGhhdCBmb3JjZV91YWNjZXNz
XyogZnVuY3Rpb25zIGNhbiBiZSBkaXJlY3RseSByZW1vdmVkLg0KPg0KPiBQbGVhc2UgQ2MgdGhl
IG1haWxpbmcgbGlzdCBhYm91dCBxdWVzdGlvbnMgbGlrZSB0aGlzLg0KPg0KPj4gMi4gVGhlIHF1
ZXN0aW9uIGlzOiBDb3VsZCB5b3UgaGVscCBjb25maXJtIHRoYXQgdGhlIGZvcmNlX3VhY2Nlc3Nf
KigpDQo+PiBmdW5jdGlvbnMgYXJlIG5vIGxvbmdlciBuZWNlc3NhcnkgYW5kIGNhbGxpbmcgdGhl
bSBjYW4gYmUgKnNhZmVseSoNCj4+IHJlbW92ZWQ/IE9yIHdoYXQgc2hhbGwgd2UgY2FyZSBhYm91
dD8NCj4NCj4gSXQgd2FzIG9ubHkgdXNlZCBpbiB0aGUga2VybmVsIHRvIHN3aXRjaCBiYWNrIHRv
IFVTRVJfRFMgd2hlbiBhbg0KPiBhbmNpZW50IGRyaXZlciBjYWxsZWQgc2V0X2ZzKEtFUk5FTF9E
UykuIEFsbCBkcml2ZXJzIGFyZSBmaXhlZCB0byBubw0KPiBsb25nZXIgZG8gdGhpcywgc28gdGhl
IHNldF9mcygpIGFuZCBmb3JjZV91YWNjZXNzXyooKSBmdW5jdGlvbnMgaGF2ZQ0KPiBubyBmdW5j
dGlvbiBhbnkgbW9yZSwgYW5kIGNvcHlfZnJvbV91c2VyKCkgYWx3YXlzIHJlZmVyZW5jZXMgYWN0
dWFsDQo+IHVzZXIgYWRkcmVzc2VzLg0KDQoNClllcy4gIEEgZmV3IHJhcmUgcGllY2VzIG9mIGNv
ZGUgdXNlZCB0aGUgaWRpb20gc2V0X2ZzKEtFUk5FTF9EUyk7IC4uLiBjb2RlIHRoYXQgY2FsbHMg
Y29weV9mcm9tX3VzZXIuLi4NCnNldF9mcyhVU0VSX0RTKTsNCg0KVGhlIHVzZSBvZiBzZXRfZnMg
aW4gdGhhdCB3YXkgYWxsb3dlZCBwYXNzaW5nIGluIGEgcG9pbnRlciB0byBrZXJuZWwgbWVtb3J5
IHRvIGZ1bmN0aW9ucyB0aGF0IGV4cGVjdCBhIHBvaW50ZXIgdG8gdXNlcnNwYWNlIG1lbW9yeS4N
Cg0KSWYgeW91IGhhdmUgYW4gb2xkIG91dCBvZiB0cmVlIGRyaXZlciB0aGF0IHlvdSBhcmUgdHJ5
aW5nIHRvIGdldCB3b3JraW5nIHRoYXQgdXNlZCB0aGF0IGlkaW9tIHlvdSBuZWVkIHRvIGZpbmQg
YSBmdW5jdGlvbiB0byBjYWxsIHRoYXQgdGFrZXMgYSBwb2ludGVyIHRvIGtlcm5lbCBtZW1vcnkg
aW5zdGVhZCBvZiBhIHBvaW50ZXIgdG8gdXNlcnNwYWNlIG1lbW9yeS4NCg0KSWYgeW91IG5lZWQg
aGVscCB3aXRoIHRoYXQgcGxlYXNlIENjIGxpbnV4LWtlcm5lbCBhcyB3ZWxsIGFzIHRoZSByZWxl
dmFudCBwZW9wbGUgd2hlbiBhc2tpbmcgdGhlIHF1ZXN0aW9uLiAgSXQgbWFrZXMgZm9yIGEgbXVj
aCBiZXR0ZXIgZGlzY3Vzc2lvbi4NCg0KRXJpYw0KVFJFTkQgTUlDUk8gRU1BSUwgTk9USUNFDQoN
ClRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGlzIGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIHN1YmplY3QgdG8gY29weXJpZ2h0IG9yIG90
aGVyIGludGVsbGVjdHVhbCBwcm9wZXJ0eSBwcm90ZWN0aW9uLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHVzZSBvciBkaXNj
bG9zZSB0aGlzIGluZm9ybWF0aW9uLCBhbmQgd2UgcmVxdWVzdCB0aGF0IHlvdSBub3RpZnkgdXMg
YnkgcmVwbHkgbWFpbCBvciB0ZWxlcGhvbmUgYW5kIGRlbGV0ZSB0aGUgb3JpZ2luYWwgbWVzc2Fn
ZSBmcm9tIHlvdXIgbWFpbCBzeXN0ZW0uDQoNCkZvciBkZXRhaWxzIGFib3V0IHdoYXQgcGVyc29u
YWwgaW5mb3JtYXRpb24gd2UgY29sbGVjdCBhbmQgd2h5LCBwbGVhc2Ugc2VlIG91ciBQcml2YWN5
IE5vdGljZSBvbiBvdXIgd2Vic2l0ZSBhdDogUmVhZCBwcml2YWN5IHBvbGljeTxodHRwOi8vd3d3
LnRyZW5kbWljcm8uY29tL3ByaXZhY3k+DQo=
