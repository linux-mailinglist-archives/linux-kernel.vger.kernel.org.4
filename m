Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B65FC1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJLING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJLIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:13:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DB77E86;
        Wed, 12 Oct 2022 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665562382; x=1697098382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AZsnIlyeSVJ93jzPc1yKcJrI1Z3slvZ4grzKd1ebEYo=;
  b=ZWVcxcRjVutcSdILJJ5r/W43ShbyiJuWjlhUrt+wkjRSAFkQ82r9Q/WM
   N8aj+Au2O0X7qXRAgMHfAgd0ka0chpNn7HikL8v5JnAdjJ8sY6SDOB1+C
   Zwk3Zl0ZlWLTv64O2WmJ04HcXln9eOlRhlCeNxI22BQfzTgidjSyZkcrV
   oWdWokEzwOBrMJhvTPGUZiTR6y69aJbNGbRxgYXemjcw+74pqF/GSStp9
   8R1kzp4CKbk8dUrMaSahzCuz4A2PyWZqA6GVGxY0+OOQC9a2QMJzUgjvJ
   1SRCMkFaOUEWQG/70Mc/loGz0qRBjgeY/T0OVipeTilLka/Tiwd+XW2KH
   w==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661788800"; 
   d="scan'208";a="211913695"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2022 16:13:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBdO4TU3B7fcXadHH/HFIZP3c8OLlrELCD+2JmNBirQHrCTAkyVJx8JelUi4a559fUgQxax+U52FTkkEdrJqkycNwPZQd7Di77S7QnXMprZkY3cYvCemVuQ7SJWq2CMk4CUcoUCxIXZ1CPCsG9V2qOrKe9Ndu1pND/Q1GelOiAO40YlNN5rsbA1KjeYaTaoG2N+hjeN44faIZmh48XPfHdogJZ0n50OphqKgUU7L3otmm48hV/xV198LbLmj9LnBREpXXWwUhl1lvAVtpVlrTggmcQ3Tm/BcI6d28eyx7wCVltaQ/4d3PuaonJNN9npgtalXJllzN0QkdJF54d/oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZsnIlyeSVJ93jzPc1yKcJrI1Z3slvZ4grzKd1ebEYo=;
 b=GWyNKH5gldI0ABIoIKA7LO2E+HX2GKVWdZoVMb813ho8Y8OJZ55XkGyHci+1PUUt+rynhhIsYIB5u/NXjq3GdVGNjSeT45GRSvO3q698QEBlAmmPB6gneSmR3F2xHNzWqSfy3wd4neGKAdwBAMv3TsHDfIgVik2GJ7wwiR4WtsDT45m/x3YDCRMN1dx7A+J6YS89Z0IoPnrvPKXALSQDhZ52ZvlB/zeDLTdnY/NzM63KORR4ggbMKNfOxMY+pq7/gErkOY4W8KccHz8wDlVanlmhOf8NcH/2B+MsUdCybs+XyLGn4ghJ/K/9dTAy9vWPmPIlPxqLxmqR9V3k5T15wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZsnIlyeSVJ93jzPc1yKcJrI1Z3slvZ4grzKd1ebEYo=;
 b=BJ0fqYPIyXlEAzximlDBiF9ySfn4E8vGGGEBr7RzAOBpgPZTGEYeC0mhbLYeerY6V1WW2kfwXstjg2M8Fgx6fVQfaCZjsTQ98O8zv3BU91lwPMUNimFhUaok/CqTxgxFjvkvxMKfYzG/oON7wJWJ0w+05HEOYnUaQAdLvpg02cE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB3788.namprd04.prod.outlook.com (2603:10b6:5:b1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Wed, 12 Oct 2022 08:12:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 08:12:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        =?utf-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Topic: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Index: AQHY3ReOb6qYvQkkBU21f4ndI5lc+q4IxU1wgABQioCAATX+kIAAHGCw
Date:   Wed, 12 Oct 2022 08:12:58 +0000
Message-ID: <DM6PR04MB657509954BB9AA1C22739928FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
 <DM6PR04MB65756E9549E9DCDB4BCF8FF6FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65756E9549E9DCDB4BCF8FF6FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB3788:EE_
x-ms-office365-filtering-correlation-id: 94985a68-d3c5-4453-9216-08daac2992bc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8l7aplA41rYhlT99DA/1qd6Y9YyXS5MTItV7ZrORlRx/wC6LSexvTFHx+E0RV1aES1PYqGriUTFiQXPIpIPlJqb3pjaTroWlAuKhGqbsup5rAflPU/4MZmZVgJYrCaDLPIeMNO2KymYcLjtpZCMZgxEK10LRiZHzyVndKEONZ6ciNN8a6fYXDy66fhEP9+9l8p7rNk1VFQC8wOIPu3U87B6LmAAiKqKH38v7DiCqKxlutJgPUrJCsOyhGYIJ30zRWT601WzIMREd8c3Tg/msKZLjq9iEyMmRC7rHXtydEViJDfqIXbd2wPsUUdKoUG8GbMEeoz6J3T3z//6g6oa7PqzfL2LkakooXfjwF6aylgsMjgnuo0wbaeBhmSH9VX4nwB1Jbt6ZS4LlrFkkwyRCMxIcrPi/Hj5kBWKsO+tam/rF15rg7cZ5VegpSug5DUvj1vjGQM5NYJUjZ2NKkeUlXAFEPPwZhD9k8ZWFtjLUAB6MSRVeqVHROFnc2QgI5yyjxs2KpPK8mZNESV1W4mkcX9QlUzv/i5dtmVa64eY7ti2ofwm7Hf0aUKp28wftFpDv8BW2m4GxMsNkrOdir9STDQ3W0jD7/PvTQOSfn9DV/j3/2VBTTw+dzV00d5qh1c/pHXTm9EbD4VH8kArQmrXZ8Y2EqZzqOZ8NInXRTSm6lPJE7oNQ/6NcBs0tyD+8CbkkONFzTjVzBwP75pT87kfDR6CtuYgz0uc7ztCPnTJS6TR8XJakVoeTT3vNYzjEYuKaTD/kFv6GVQ81y5zPLsOVgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(55016003)(33656002)(2906002)(26005)(186003)(83380400001)(38070700005)(54906003)(66476007)(86362001)(9686003)(6506007)(7696005)(2940100002)(66946007)(76116006)(316002)(64756008)(66446008)(41300700001)(8676002)(66556008)(4326008)(71200400001)(38100700002)(122000001)(478600001)(110136005)(5660300002)(52536014)(8936002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVIajFhRk1iTXMwUzBDZlMwSENRNG1qM0dHZEFXem1sVXZ1MmJUNmJCcUxh?=
 =?utf-8?B?NDhBbEJJNTVHWnFCMGRwWjFaa3pBVHdxb3JtdWR3UUx0VHJtVVZUZjhwWnA4?=
 =?utf-8?B?MElUYVc4QzREaVlVM2VMR0g4T1F0bVlkRnlOMEwrSGpaUGVPT1BCZ1hSSkVX?=
 =?utf-8?B?NG5YS3k4c0RMeGlYTld6akd4Vk10bG5LWUpTczJUTWtnQlJ2UEZnV3Y0SGtu?=
 =?utf-8?B?NDBHVm9zMVBhOFhHZFhURkw0S0FDVzRKMFl3ck8rTGVUYXBOb2NMeFJPRU9K?=
 =?utf-8?B?bkZtRUE1UUJlZjNtU2NVYURpRXp5WnlpdzhsQmo0eUxGc3laS0NOS0xQTVM0?=
 =?utf-8?B?cldVb09FWmJCVUU3cVMxVTcrQkZjMTlhOC9SeDg5K25JT3hkbzB0L21UekxG?=
 =?utf-8?B?bHh3UGQxSnAveVA2NVZ4Z1dkNFpLL3R5SWRsY2l6akdhUVRWckZIZDVzQkhT?=
 =?utf-8?B?SGNTYUhhcjlDWmhKTE9hQlRLMEJ0SnU0SlRoS3l2Q1pCNmtaTHkvYVpXZ2Fw?=
 =?utf-8?B?UFYzMzdZK2s4SjFPVTVmVGU5Wkt5Y1hMMy9vcU9OTmpyKzBoTUpveEppQ0Ex?=
 =?utf-8?B?WVNLSGh1QlV4YUpva0cwZ0EvR1pIaGc1aWNjeUZmdWlVaERLTk5CVmU0RUtn?=
 =?utf-8?B?bUdkNVhYSWFGQXFFYytFdFkrMVRKZTlSOUcxdzM5dVJFOXBwUVM3NmkraTFY?=
 =?utf-8?B?MFM3RU8yQmFEbWM0KysxVWFJZ0xwSGc5TWlHakNzVi9zZ3lMMEhFTE5RN0RJ?=
 =?utf-8?B?RE5Yd09kaHBndWZHSEJmc21EU2U0SU4xbTE1OVdsSm1aa1Z1MWUzWTlyNTZW?=
 =?utf-8?B?WXNZVThPVmx5WlZLanNFNFZzNHFOL1licklZKzRzQ3AvZE13bHpJRmhHUHpa?=
 =?utf-8?B?OWtjSXFIT3AvRzdLUjEycEsxVGpNNGFObDZuVGxQdFZ6NWNkek9kZmc1cURu?=
 =?utf-8?B?QW5XMWFPNDRBcWw3Z3N0RFVDWFBhMzlHR01uRG40dTV2dDFsQS9xaXlSemto?=
 =?utf-8?B?VjBHUm14RzdITHhIZ2lMdHhiaFFCVCt1RWYrM2JUeDhjM0RhWHVUTW54OWNt?=
 =?utf-8?B?LzZnQ3cvT282ME1saTRoT3VGRnZFekR0aGgwVDUybTFmdVBJOEZ3bGtVbUpX?=
 =?utf-8?B?c1p1RjJGUjZkdmxod25sUXJaQ3lUMjBoU3JlYXZMVkVsUGRNVjNIRVVaN2ta?=
 =?utf-8?B?TnV5SWFFV2NBTG5tZjhSN2FiUVdpbW5yN0h2WGxUYkErMTF2a25ZT3MwN3Nk?=
 =?utf-8?B?dXVxenova0RWcGZrelRWM0srZGI0dXZKVm82S2NPZms3WG1vTUs4eVdtMWhx?=
 =?utf-8?B?STd6NVdpZlU4TW1ZSThaZkw0TDNnK1VRVDRHaXoybFdubkJZcjBlVXJHQ2lD?=
 =?utf-8?B?dWM5cXl0OVJMMUtJRFB0MFloQ2M4a2MwSVBVSHlZVXNFSFJvWHJGZ2tUY0ZN?=
 =?utf-8?B?UGd0RXJQaWR3bXEwVTZMSjlFOG1Zc3BibmN6N0FDWWVFKzhYMVF4c1ZGbHdY?=
 =?utf-8?B?M0NUNlVuS2E0TlNDVkJvTUl3Z0VkVE5rUlhMdnhOQ2dXV1U0eGxONWYwdURW?=
 =?utf-8?B?cUtNTHdQb09Ra052ZkprWkhsUzh3SngxZzkyR2N6eXp4TFduNC9ERVFEczk4?=
 =?utf-8?B?UlJTRndOUkpTeXg5NzZGU1l6elExTVFscFkrZmptaDZFbVJBNEtEREF4ZmVF?=
 =?utf-8?B?azQwKzdja3RwUUQ3UHdjN1I3TU4zREtUeFgxTGxlQmh3VlpGaXYzYUdtZUxy?=
 =?utf-8?B?TFBON0paRWpQWjFxRlJGTnFRVGJMcmc4d1JrR3h6bzgrUnQySnRRNy9KQ2hx?=
 =?utf-8?B?azVIUXl4SVBDNVRWMG5TVE9FNjNaUjNLVFkxS1I2cmtaWVdSbWNYNkNrU1VI?=
 =?utf-8?B?T3RGQ09oZUI5YW1mZ2dUeGhncVB2ZXU5cGppRE5SZElZY084TTVuY2pPVDhn?=
 =?utf-8?B?M2tIRTJCMmRyOC8zcFVpaVFrSURaQXlYN0xjbnd5NVluWHBUL3U1TE1nL0kw?=
 =?utf-8?B?NEVFZ1gxNi9JTWRxci9LYkxBRW8vVGFzMGtZQjN2cXJvMEdkeXBsTlBtcjMr?=
 =?utf-8?B?cmlWazNWYjlDOTd0NjFicWJHZnBsdXVEV2ZJd3NZUyszUGpObDJCZDhPWmlC?=
 =?utf-8?Q?KepBfPKfqKFYcCV8gMVlAugZc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94985a68-d3c5-4453-9216-08daac2992bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 08:12:58.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sU9xVb5CMow+G/mRgjiDX8TBCnJPP3PHYdv70MnICJooKJvQQ0QzWQA1crsABDRNB99jOZWxeyDF8/wA/splIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3788
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gRGVhciBBdnJpDQo+ID4gICBVbmlzb2MgcmVwb3J0cyByZXN1bWUgZmFpbCBvbiBV
RlMobWljcm9uIEZTMTY0KSBkdXJpbmcgc3VzcGVuZC9yZXN1bWUNCj4gPiB0ZXN0Lg0KPiA+ICAg
V2UgY2hlY2sgaG9zdCBpbnNlcnRzIGF1dG8gSDggZW50ZXIvZXhpdCBldmVudCBiZXR3ZWVuIFNT
VSBzbGVlcA0KPiA+IGNvbW1hbmQgYW5kIEg4IGVudGVyIGNvbW1hbmQgaW4gcnVudGltZSBzdXNw
ZW5kIC4NCj4gPiAgIEFzZm9sbG93czogU1NVIFNsZWVwIGNvbW1hbmQgLS0+IGF1dG8gSDggZW50
ZXIgLS0+IGF1dG8gSDggZXhpdCAtLT4NCj4gPiBIOCBlbnRlciAtLT4gaWRsZSAybXMgLS0+IFZD
QyBvZmYuDQo+ID4gICBIb3dldmVyIGRldmljZSBBUUwgRlcgY2Fu4oCZdCBlbnRlciBMUE0gd2l0
aGluIDJtcyBhZnRlciBzZWNvbmQgSDgNCj4gZW50ZXINCj4gPiBjb21tYW5kLg0KPiA+ICAgRlcg
YWxyZWFkeSBlbnRlciBMUE0gYWZ0ZXIgcmVjZWl2ZSBhdXRvIEg4IGVudGVyIGNvbW1hbmQgLCBO
ZXh0IGF1dG8NCj4gPiBIOCBleGl0IGNvbW1hbmQgd2lsbCB0cmlnZ2VyIEZXIGV4aXQgZnJvbSBM
UE0sIGl0IG5lZWQgdGFrZSBvdmVyIDEwbXMsDQo+IGFuZA0KPiA+IEZXIGNhbuKAmXQgZW50ZXIN
Cj4gPiAgIExQTSBhZ2FpbiBhZnRlciBzZWNvbmQgSDggZW50ZXIgY29tbWFuZCB1bnRpbCBkZXZp
Y2UgY29tcGxldGUgZXhpdA0KPiBmcm9tDQo+ID4gTFBNLiBTbyBkaXNhYmxlIGF1dG8gaDggYmVm
b3JlIHNzdSBpcyBhIHJlYXNvbmFibGUgc29sdXRpb24gdG8gc29sdmUgaXQuDQo+ID4gICBIeW5p
eCBhbHNvIGhhcyBzaW1pbGFyIHJlcXVlc3QuDQo+IElzIHRoaXMgc29tZXRoaW5nIGNvbW1vbiB0
byBhbGwgcGxhdGZvcm1zPw0KPiBJZiBub3QsIGFuZCB5b3UgbmVlZCB5b3VyIHBsYXRmb3JtIHRv
IGRpc2FibGUgaDggYmVmb3JlIHNzdSwNCj4gWW91IGNhbiBpbXBsZW1lbnQgaXQgaW4geW91ciBv
d24gdm9wIC0gc2VlIGUuZy4NCj4gY29tbWl0IDk1NjFmNTg0NDJlNCAoc2NzaTogdWZzOiBtZWRp
YXRlazogU3VwcG9ydCB2b3BzIHByZSBzdXNwZW5kIHRvDQo+IGRpc2FibGUgYXV0by1oaWJlcm44
KQ0KTWF5YmUgdG8gZnVydGhlciBjbGFyaWZ5LCBJIGFtIG5vdCBzYXlpbmcgdGhhdCB5b3VyIHN1
Z2dlc3Rpb24gZG9lc24ndCBtYWtlIHNlbnNlLg0KSXQncyBqdXN0IHRoYXQgeW91IG5lZWQsIElN
SE8sIHRvIG1ha2UgaXQgcGFydCBvZiB1ZnNoY2Rfdm9wc19zdXNwZW5kLCB3aGljaCBJIHRoaW5r
DQpJdHMgdWZzaGNkX3N5c3RlbV9zdXNwZW5kIGZvciBldmVyeSBwbGF0Zm9ybS4NCkFuZCB5b3Ug
bmVlZCB0byBnZXQgYW4gYWNrIG9uIHRoYXQgZnJvbSB0aGUgb3RoZXIgcGxhdGZvcm0gb3duZXJz
IChtYXliZSBleGNlcHQNClN0YW5sZXkgd2hvIGlzIGRvaW5nIGl0IGFscmVhZHkpLg0KDQpCdHcs
IHlvdSBhcmUgbm90IGNoZWNraW5nIHRoZSBwbV9vcCBzbyB5b3VyIGFyZSBkaXNhYmxpbmcgYXV0
by1oOCBmb3IgcnVudGltZS1zdXNwZW5kDQpBcyB3ZWxsLg0KDQpBbmQgbWF5YmUgZWxhYm9yYXRl
IHRoZSBjb21taXQgbG9nIHdpdGggeW91ciBleHBsYW5hdGlvbiBhYm92ZSAtIG1ha2luZyBpdCBt
b3JlIGNsZWFyLg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiBUaGFua3MsDQo+IEF2cmkNCj4gDQo+
ID4NCj4gPiBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5Ad2RjLmNvbT4g5LqOMjAyMuW5tDEw5pyI
MTHml6XlkajkuowgMTU6MDflhpnpgZMNCj4g77yaDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBUZW4g
R2FvIDx0ZW4uZ2FvQHVuaXNvYy5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEVuc3VyZSBhdXRvIGg4
IHdpbGwgbm90IGhpdCBkbWUgaDgsYW5kIHRoZXJlIHdvbid0IGJlIHR3byBoOCBpbiBhDQo+ID4g
PiA+IHJvdyBhZnRlciBzc3UuDQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoZSBodyBzaG91bGQgZG8g
dGhhdC4NCj4gPiA+IENhbiB5b3UgcGxlYXNlIHNoYXJlIG9uIHdoaWNoIHBsYXRmb3JtL2hvc3Qg
Y29udHJvbGxlciBkaWQgeW91IG9ic2VydmUNCj4gPiB0aGlzPw0KPiA+ID4NCj4gPiA+IFRoYW5r
cywNCj4gPiA+IEF2cmkNCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVGVuIEdhbyA8
dGVuLmdhb0B1bmlzb2MuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvdWZzL2Nv
cmUvdWZzaGNkLmMgfCAxMCArKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMv
Y29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gPiA+ID4gaW5kZXgN
Cj4gPiA+ID4gYTIwMmQ3ZDUyNDBkLi40MmY5MzY0OGQ3OTYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91ZnMvY29y
ZS91ZnNoY2QuYw0KPiA+ID4gPiBAQCAtNDI1Niw2ICs0MjU2LDE0IEBAIHZvaWQgdWZzaGNkX2F1
dG9faGliZXJuOF91cGRhdGUoc3RydWN0DQo+ID4gPiA+IHVmc19oYmEgKmhiYSwgdTMyIGFoaXQp
ICB9DQo+ID4gPiA+IEVYUE9SVF9TWU1CT0xfR1BMKHVmc2hjZF9hdXRvX2hpYmVybjhfdXBkYXRl
KTsNCj4gPiA+ID4NCj4gPiA+ID4gK3ZvaWQgdWZzaGNkX2F1dG9faGliZXJuOF9kaXNhYmxlKHN0
cnVjdCB1ZnNfaGJhICpoYmEpIHsNCj4gPiA+ID4gKyAgICAgICBpZiAoIXVmc2hjZF9pc19hdXRv
X2hpYmVybjhfc3VwcG9ydGVkKGhiYSkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm47
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICB1ZnNoY2Rfd3JpdGVsKGhiYSwgMCwgUkVHX0FV
VE9fSElCRVJOQVRFX0lETEVfVElNRVIpOyB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gIHZvaWQgdWZz
aGNkX2F1dG9faGliZXJuOF9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhiYSkgIHsNCj4gPiA+ID4g
ICAgICAgICBpZiAoIXVmc2hjZF9pc19hdXRvX2hpYmVybjhfc3VwcG9ydGVkKGhiYSkpDQo+ID4g
PiA+IEBAIC05MDM2LDYgKzkwNDQsOCBAQCBzdGF0aWMgaW50IF9fdWZzaGNkX3dsX3N1c3BlbmQo
c3RydWN0DQo+IHVmc19oYmENCj4gPiA+ID4gKmhiYSwgZW51bSB1ZnNfcG1fb3AgcG1fb3ApDQo+
ID4gPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gZW5h
YmxlX3NjYWxpbmc7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgdWZzaGNkX2F1dG9faGliZXJu
OF9kaXNhYmxlKGhiYSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgICBpZiAocmVxX2Rldl9w
d3JfbW9kZSAhPSBoYmEtPmN1cnJfZGV2X3B3cl9tb2RlKSB7DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICBpZiAocG1fb3AgIT0gVUZTX1JVTlRJTUVfUE0pDQo+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIGVuc3VyZSB0aGF0IGJrb3BzIGlzIGRpc2FibGVkICovDQo+ID4gPiA+IC0t
DQo+ID4gPiA+IDIuMTcuMQ0KPiA+ID4NCg==
