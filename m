Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F05BFC98
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIUKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIUKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:52:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C977CABA;
        Wed, 21 Sep 2022 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663757518; x=1695293518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CnZsCYsGKwdofiKAwrNQ3eR7rXdpi5McyCcdteyd4Ko=;
  b=qKCNXuAFX8Z06HDNNsfoM8MQKZZMKlUL41/Jfxki8ABYR5Y1IJ/Xve5Q
   MMSgacl2u3LtnNyPsbl/q8aEVaV5E1VH5ZaDAmPRRION4urqTHn0rpDTf
   JSQGOly//xpxHT+IAjqsQqmLrRL2Ntb/VL9uHUP+cCBu48s2PuFwPauml
   D5kO1g2RN5VJxZ8SI6LrW8O8AXI7W67c9vSZ9hsCHkVIISXdltkPXOrXk
   zutK/lGx6yCgnoCF0Axe7ENI4uDL+aLRjn8tM1PJztJaYvjzzSeQ1aDXc
   uYBZ7mDvB/0eLZKYp9Mja84jfWP7bQQdlEb0ed25mhqRw8IIlTvEnTwbn
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="211900747"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 18:51:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtGSVDYTy5Zf1Gf/EFeRoJacHgDNogXT3F+nbuTPNI+2bGzk91flMguCXCPkEjqom4AI6gdkrnZD42sMAMxLfJz8IL/LEUR3R0HG1WYCKreq6Hh6TFDmEIkkppBLeFQtqnDe+747dh0MeRVmnFYkeVUY/kxs0DubznFGkTdpWsOwrQccW9dKDFT+53U81a7DwrKdYX03NIHTapdQKzNJL4ETge3aa4eUBMcNI68I6o9n+qITy4VEnHWA5j7lgY9lIO7BFH47VM4LP21oa6u3OHrhnPUNX0w3g21sAcZfsnd+TB/NtuevJ4u/AXb4NvmYkj8FdWE2LV/P3uZx+Gkw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnZsCYsGKwdofiKAwrNQ3eR7rXdpi5McyCcdteyd4Ko=;
 b=IlFhM8vn8wT0FUaYkVJ30Bt6SD2sC8JBKCH8R5aqoUkSpjQv7z0ogIIabajaF2OGTAXBt2IiYT7WCR34gsl+T/vzMAKn/SFcBPkuokKeGSYvLSx4/uV3IY+TOUQlEzTEeY/RkOVJoJ+1k1B2tm1thykCunQ1DufDQ/fvv+nYftd07HrKzy0QNH5Ytz2JZW2JX0EYdeIMO5KEs8mM7O1p3phcUBovT9kQ7DVitlJdMUpuuHe1B3cq7dnoQXIaZw/lHmYp3Xgtlhgp3kLvfq8IL+W4wdK+CeG5C2G/gosv4kkpLnXwPTIgORvCWBs3+TC8M7OPs2Udn+PZMAwkS/GHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnZsCYsGKwdofiKAwrNQ3eR7rXdpi5McyCcdteyd4Ko=;
 b=lR2oJJMnizmgmm8FHIBF7bk4gvo/jKDU6P1ZzO436wp14xse/Co6PS1nQ2iIHUnpJaqlRmiMzZJ3pg4q/UIzW9scDLcQ3GWuU51Vghi3zDrIk+dqGn4+x63+LRscaUurzWxTA38JGZKk6oHDnVA4syGNSH+8DIx6W7FP0kf6IQg=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by MN2PR04MB5615.namprd04.prod.outlook.com (2603:10b6:208:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 10:51:56 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 10:51:56 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Remove redundant function definitions from
 ufshcd.h
Thread-Topic: [PATCH] scsi: ufs: Remove redundant function definitions from
 ufshcd.h
Thread-Index: AQHYzADNY/mNfMDQMUahPT576FaNbq3okkIAgAEmAhA=
Date:   Wed, 21 Sep 2022 10:51:56 +0000
Message-ID: <BY5PR04MB63275E8FDF8CCB60142C2448ED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
 <db36f36f-d321-b848-dfd2-9bb693e68dfb@acm.org>
In-Reply-To: <db36f36f-d321-b848-dfd2-9bb693e68dfb@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|MN2PR04MB5615:EE_
x-ms-office365-filtering-correlation-id: 709c7c3e-b83a-4994-a0b1-08da9bbf4d21
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlhIq2udf6Sct3JGQwFKpXmSfsPMaTyFKO5x1wKCkRShNIjPogfpPKgSTdnNTs+hN/+MEJuHNHdQkq1Lfkko9DJURwaIoZ0gNgSgyu5Ee06Yf/quKz9Ge3vm6xPFZ5fIfVtCU7s2xPHHfRbsqPZnzMbR5hZAEWH99omxe9BgMQjAkGTbaEnsGWkcWM6QWpfmxNqrC5tcR5LCq6SpD0JlfqY/2hsWHEpcO4q5ar3Fp1e9MFhpI+TwVT/sSPq/AbeoEQOz0Mhi005MhYbSsLV2SxxNVKWQbPkNed4aKRW8SutaWk7huUwf6OMIsNIw0zSzfg2ibqpSpGRmf7IU/ktLrIQfijTS6vPZXfCXjYqQACiUabVwQn4PKkwxtw+Dc2hKAXdvQHSHtfUli1lY++oMMOgrVg1kcG3zUIOaCPy4ZTNOc54Kbef6X5nw89QWWpG0bZ2ymX/PqawXuSVAEFcNlREmHeRI3pprlFYYu2KNCrZ3yKtYQ1fF4dqaz9INswTHJlsf7HqbAMjXUcGT165IusE2lKDql6wozRSJ0VwOLkxFR8UzMR4BktgkwgUXn5ckljTZN694K6x/36gR/n1ryH0lMVAno2pKxvRH4c9wKJid8q2RtdAyBG3XQzl4331ZblsZp0BbcRbOQ9K5zd33CTzlsJQl51sCIvPU+8o2dzbHTUylqQC41nH6tcMpWPUvNhIVssAcRTL3CS5NmYwDlrT0aIiNwcA6K1SquB71jd0ycOfZI9Hgn+NRs99VVDKz9Jz9BJ6k+8KfwCwW16KKcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(33656002)(26005)(38070700005)(53546011)(110136005)(9686003)(6506007)(7696005)(86362001)(316002)(54906003)(71200400001)(478600001)(122000001)(83380400001)(55016003)(186003)(38100700002)(82960400001)(5660300002)(8936002)(2906002)(4744005)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(52536014)(41300700001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFDSjZmOWJSa3RKQXV0bDY5bjg2R1UzMjdpRzVwc1h6WlEyaUdTWWE0MXFD?=
 =?utf-8?B?QlJpUmo1T0JLeGIyN20yR0lWdzRsOVkwVGZUZHU5dHk5RW1kMks0N04zeG1Z?=
 =?utf-8?B?a3ZuOUptVmhrZHRBb3RNUGl0OFlIVHNPMzhpQ1JIWDgwN2RoOWk1LzJ4ZVFv?=
 =?utf-8?B?QzJ0WHU2dmYxUHJ0QVFmM0crZW9icTlkby9Xbmk2bmkxdDdVM213dm94RzEr?=
 =?utf-8?B?Y2ttNzVYMm0vamJ3bENiUU8vbDBUYThkRGZUbGhMZUd1bTFLTHU1c3h5ejIv?=
 =?utf-8?B?YXhhdFRpWVBaRklNLzZHdmI1Q2FTTGE0US85OGlUYXByVk1BZGRBaDdidS80?=
 =?utf-8?B?M3VUL0tHWXV0QXRyUmlDOVd2eDBLNlg2akZQM2NPN1d0b2ZqUDNCQnlONEdr?=
 =?utf-8?B?eXVLSjBWR28yd2d2ckswek5WeTdDYnZ5R0xZZzFKRzF3djVVL1RYNDVLdlo4?=
 =?utf-8?B?ZnFBK3VSM3JGSDFVSU5qYW1VaE94NTlWeUlWdVdMSUkxNWY2R2hEZWs1eHdS?=
 =?utf-8?B?bXZ5Z2JaYVVOa0NwRTNmZml3YnRjN25qSjZPR3Y4OTBnTHNNdTc3WEg3Yzli?=
 =?utf-8?B?a1gzMEpTU01WRnM4Q3VpN2tKUFB2aHhQOTN4R0k5RWFTNTBOdElHcjBxWGVw?=
 =?utf-8?B?ekJvUVU2NWZPV3ZNNUFzT1NFK3dmYWhEUVYzL3M1a2xweW13c2xvRnRNYzN6?=
 =?utf-8?B?UXlFTVZTdWJKelhiRlFKdFFRNUJyeFRlVVdSTGdzN2NESGxxZWhYTjVqMWF3?=
 =?utf-8?B?dEFZeXNkSWVmRUFlcTl6VzZleDFtbllVdmE4L0NwQkVPclFEeERzc3dWTDc0?=
 =?utf-8?B?TG5oRzVNa2MzdGp4TU5pNmM5VllFMU90MGNCRGQyMjh2YUdVRmxPZHdBNFF5?=
 =?utf-8?B?YlppMXNzZkNZZzF6b0E3K2h1NGcrK2cvZ3pCODdpd1dvSDdFb2VNVkFMVEV0?=
 =?utf-8?B?MFZoVDYyZ1Z2dGxTOTIxQy9ONFc0Q0ZNU2xHTUovUktINjd4V2cxRVFQY0Ni?=
 =?utf-8?B?eHBoMXNiSnYweHBkYVhvQzVpMWF1MkpOTHJsU0dqRWxnUjdDYXA5RmlYeU9D?=
 =?utf-8?B?WmJ6VHFXVVcxdHZad1Y3dVhqNTRudmdiVmFVY0M1TG43eUx6Wk4wb2NmdE9S?=
 =?utf-8?B?SGlGaGYvN3dTK0RRZG9NWjgxUWdSQ3AvTjNoZTRxckFidWp2eG4rMit5WnVF?=
 =?utf-8?B?U0d5M3JFdnRQVWxaS25mbEw4ZlgyU3l2ZW9Wb3hVRklaTlRwbGdoVmxOUWZy?=
 =?utf-8?B?aXpBTkN6cHQyYTZmOE9BbjY0dVROTjJESHkzSVVzdHZaUXpJTXZLZkZTZEhi?=
 =?utf-8?B?RUtmbUQyNGM3UjRwSENobEZSTHNBVWFLazhaeU9TcUJLMk5hcmJ3RE8zcVJx?=
 =?utf-8?B?TFV6bHNQSFFsaEVKS3h3M3lpU1BhOXNyMlVOQkxodDBzVDVXQkZldndBYVpV?=
 =?utf-8?B?SVRNZU9ZaDdESFBKR2R3QnExcFhsZkZkb2QyeHZKdmNGSE1xSEtsbURScnc3?=
 =?utf-8?B?QjQ0WnlaV090RlAvaTNpNlFYRFFjUmE1U3Mrb1c2ZGwybmRHZGpTMU5RdzI2?=
 =?utf-8?B?dzJXVFFMUW10VTgvQS9hNWR4V2tZZUg3TU1LUTRHMTF5MituSEZNM201eWpX?=
 =?utf-8?B?OXFpVXF1TzRYQkM4Z29lM2FPdlVyd0dYb0JMRG9ON05YTHQ0UkNZQ2VOMjk5?=
 =?utf-8?B?OHBuZGdONm54cG12V2J6WTVRMk5nVndyeXhOaXN5cTlRMGdjaWlaQ2hTemhD?=
 =?utf-8?B?TnpabUZ4bllmdnpQNW5NSlVGNEFvWGJsZWdicTZ5eUkrU2h1Q0QvWExoNW9I?=
 =?utf-8?B?aDE4eHFjQ05UTGpaQkRjemU5OThhdkhwelFGUkVpSjVsT1VFQ2NQTTBocWFj?=
 =?utf-8?B?b2drNzVNaDF2NDhNbllWOTllSmhPSUVIMFlmWFFFT3drSFVBeVpuQUkxblZy?=
 =?utf-8?B?bG5zd2hyckhLdU9xbGMxTjVJaW4rUFZWRlNsWElzcktkaVE5c2V0cXloVWx1?=
 =?utf-8?B?UXBuMTRGVVFURFJkeUZJejZoaUtnNXYzZjBtaUdxdUhxaWl6S3RwOEpxYjh2?=
 =?utf-8?B?NkMxYkxzcXp0YytXTGI3ZHhqZ2U3RU5oWHdVMnFCTTIyZ1JzN0J3Zkhpb0pJ?=
 =?utf-8?Q?4vstHM2eaLA3bsbEoQvG2iovR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c7c3e-b83a-4994-a0b1-08da9bbf4d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 10:51:56.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoJhrWtn1k3r3qHIx6RpvVuIY6Ag8aU8ccY37bFspimoCAuuM8HpPj+ZbsfRbqgsCFbjm1fgYh45NGTnGyMi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5615
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9uZQ0KDQpSZWdhcmRzDQpBcnRodXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDIwLCAyMDIyIDg6MTkgUE0NCj4gVG86IEFydGh1ciBTaW1jaGFldiA8
QXJ0aHVyLlNpbWNoYWV2QHdkYy5jb20+Ow0KPiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0K
PiBDYzogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+OyBBdmkgU2hjaGlzbG93c2tp
DQo+IDxBdmkuU2hjaGlzbG93c2tpQHdkYy5jb20+OyBiZWFuaHVvQG1pY3Jvbi5jb207IGxpbnV4
LQ0KPiBzY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBzY3NpOiB1ZnM6IFJlbW92ZSByZWR1bmRhbnQgZnVuY3Rp
b24gZGVmaW5pdGlvbnMgZnJvbQ0KPiB1ZnNoY2QuaA0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERvIG5vdCBjbGlj
aw0KPiBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzZW5kZXIgYW5kIGtub3cgdGhhdA0KPiB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+
IE9uIDkvMTkvMjIgMDE6MjEsIEFydGh1ciBTaW1jaGFldiB3cm90ZToNCj4gPiBUaGlzIHBhdGNo
IHJlbW92ZXMgUXVlcnktUmVxdWVzdCBBUEkgZnVuY3Rpb25zIGRlY2xhcmF0aW9uIGZyb20NCj4g
PiBmcm9tIGluY2x1ZGUvdWZzL3Vmc2hjZC5oLiBUaG9zZSBkZWNsYXJhdGlvbnMgYmVsb25ncyBz
b2xlbHkgdG8NCj4gPiB1ZnMgY29yZSBwcml2ZXQgaGVhZGVyLg0KPiAgICAgICAgICAgICBeXl5e
Xl4NCj4gICAgICAgICAgICAgcHJpdmF0ZT8NCg==
