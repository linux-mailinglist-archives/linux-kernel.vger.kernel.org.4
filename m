Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE36335CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiKVHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:21:09 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D331342;
        Mon, 21 Nov 2022 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669101666; x=1700637666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c+WzJjuv1by/zltiE6fT9uIUQfMMimgv1sbL9S8q8e8=;
  b=PMGIK296xwD1HH3jkfzz/OJlO2XofA5vtpARrGN3pSIEuCzSKeNo5UM0
   D+IPRDm0e2Xt3j6ZN/iNVRIEU9Z6v1wMLXWf8/MZDkQMjf099S5s/fC0q
   aKE6vbw4IABejGKrZCubQRil7wwWBfRHe2k+4FmX8V4O+AwklcqqZCQTQ
   m0EFp4Ni44e4cQZFgBtEZNGOw4jIaojEKU071ZDZyPsGqzzIXHg7borYN
   G/SdF/RXeMq/jCZSPjukyYcH8Sr7frgbX91GTkFcE4n97R8/dBhb2vgns
   YoKAlcBCM6Cw7i/SJ4YPB/bx5byjs4Dn75uL0IQqNqZKKuJg3xPaOitsN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="222026289"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 15:21:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpo57j8QqBmiZeSPrEPgrHTKK9xGcM2rL9HOmPZY2d6oied5gJPXu2JWI0E59m8c8sfyV/vtVMPqNPug7zUac3nPzKhvIh73boWONUP85OKvkxz7/OP85hPbeHwFPY2u2MBV6U6kwjMlo5gDpZr9g8cP5MGwPValY5dTM1smn+CE1SP7afSzYIVx4ccqdi8uzLtA6h3SEKoJyQbEqAHiOMeISHCouiW8FdvxoR/7x4hGGGqUyq5/ag3TBAkG0TcpuXiuPhnYX4t41vdvAuH+Y/KVeWEG/fjiVTDW3gBRcP2/gABndrWTooLQoKayw4DTL2+eqWlkOcI98A/IW0gbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+WzJjuv1by/zltiE6fT9uIUQfMMimgv1sbL9S8q8e8=;
 b=l74tT0cgr49jKqlujQb6qVa3te3oQP2Y61yo4eCEYQGd/UT09mMZAB+cgwRddKqTzQkQzRUCeqr6OlTMLAKxFM/FhhTIB8Ko9c0lV2iZTd/9UAKgLbc6vxBWGFwhar+K9kVhjVPH2z1MjfMsTu+v1/TwOp9b4+nbcRlhBaLN6r6crDc9cMb0m14688IJpo1r9jeTd98fOoc9afDCANzjphnOJEs4y9/ld14iDm3KwRcQUkLM4GnMOySu3SHfI1GUBU8HNMSv9VnF5vqcSUzNoFrnh5JXlzh+6l3rchLLtJbNrW9o1SXNW26NwmidAW1Mw4hRA/aNEmtCtM8bJ+mn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+WzJjuv1by/zltiE6fT9uIUQfMMimgv1sbL9S8q8e8=;
 b=b3X8o+elpeudNIej7atLlZNCYEVwpwccHSfxW1iKjhx6PENIPeVbZRM8t8joAqsMtrfPZwkyEFKKPjvR/Bb0W/xtQAYKa+bZynvajyf9nOX9kEOzfDObhkcmMTmndxfL1mE2GkhflEoLce0ZkYzVq0QlXU4q+XheYwcNhuLQooA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7842.namprd04.prod.outlook.com (2603:10b6:5:354::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 07:21:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 07:21:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
Subject: RE: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Thread-Topic: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Thread-Index: AQHY/YLhh81gWci4b06XxQAqWrcjAK5JwAUAgAAHyICAAAT/AIAAvYKA
Date:   Tue, 22 Nov 2022 07:21:03 +0000
Message-ID: <DM6PR04MB6575EDCCDD993EEEA14A99A2FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
 <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
 <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
 <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
 <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
 <1c9b3db6-3443-5580-08f2-42520d6a3318@intel.com>
 <4bba6b72-c361-f212-a8c3-9e33aab80c99@acm.org>
In-Reply-To: <4bba6b72-c361-f212-a8c3-9e33aab80c99@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7842:EE_
x-ms-office365-filtering-correlation-id: 21712292-c1e2-42b8-69d8-08dacc5a1d89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPWweXSXimttRgPan9RqP7uw2Lu7TywAl3+8KNwSxBzdgMv10Uby1SMOaOXArcIT40Ago0KkKRJr6kO6NKZG1idOQTEJmBDtX6JIJLlwi2l6aBgpLBPjzVR5Ls1GxQEcjJNfJX6N4RZdTZZw8+fILVrmVmlLOmfDfNJAHEsq0RFqgza3VwEReRNibPkCIDM2b37t/2Mw4s3cfXCWs0CYVYyYRvsK8CH2u30dqgNhx0C1BdBwtosba/bZzrGFuxw0JVR4hVzZE6ZbeGuVzyCyvxpdKb3SordF77Z93lahx3l/B6sXwro9JggOvINFejWxMV9XG+/NaXXd2UvhAa/FVH3iLL9yoYWx2R4+miiJWRbZycM49/rouYNxYemKqbu0sUdj4PRUqb0VYEpuNSCjAfiIF1FwIODjMrhhU+8UWgBVJYeWhLh4lgFrxqKSs2syD2R5Gx8IN9QPmT57d7MVM1MnS8BUodJV4nzQfyP3vjFnMkrZkE9oiXdqZoSJKYE5P/N6xixBA+icJYDbX3QKJI9T9Ag2NwEEpM3yEGxOatkDpd7ioFvz2RGGKaXKaXBuEayORe8yGJI4Ro7E04oFOKmxIsqLbFpmpTBWeONwpH6j/WKcNWjjcifw7/C7sf2GvrLiWipfsekSrW/Zf2XzGFMFvYF8EALxjCWC5rEJsQx7cKIDxJ1WzNlaFgM/bTOS7Z/xpJbVu398xHya5X52IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(9686003)(186003)(53546011)(122000001)(82960400001)(38100700002)(76116006)(4744005)(55016003)(64756008)(7696005)(7416002)(2906002)(26005)(5660300002)(71200400001)(52536014)(66556008)(6506007)(478600001)(8676002)(66946007)(316002)(66476007)(66446008)(4326008)(41300700001)(8936002)(110136005)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDFJaEF4aEwwL1RCVVhiL1BFQ2hQMDlVcys4THNOT2k3OEdYeDhadWNqZUQv?=
 =?utf-8?B?QWdTemNEUU1YbXJMQS96N1BPV0dzY1JReHR3dUJRN2toVGJvejBsZTZMQzRP?=
 =?utf-8?B?cE41MU94RGZRODhibWo5Z1Uybm9RR1MyUmFQemQ5T1FtMmlaWXZ4cE45eUVD?=
 =?utf-8?B?ZGFPczFkNnpIMVBRcDhkVlVFR1JKcVVnUC9jRmlEb3pkTHhXRklVZUpxcEtl?=
 =?utf-8?B?OWw3MTFlOTlNVVE3YnA3d3llSlkwUkVTcmsvYnpQNThLMmZFdFp4WVZUczRj?=
 =?utf-8?B?MlBvSTA4OHVTNTc0WHhIcW4xZS95VHJwNmVjcFh1TVBiWXBEdjh6bjNCRGRY?=
 =?utf-8?B?VHdCVXdTRXFGcFoyb1VpS25DM1JEQkkwaXZjSEJlSmtVMlB4cFUyN1k0U3hy?=
 =?utf-8?B?Zjd0ZmhVTE1VQUFmK1R3SVd1TzJDNXY3UUVIc1BTRm5BcjFZdFErcVNaUW5P?=
 =?utf-8?B?aUk2L21aSW5wWHo4WURWd2lIbTlNaWhUZXU3NTB0UFFCL0h3ekQrV0V6RFVT?=
 =?utf-8?B?QWt2TDJUYVVpVU5nVFBvUEhxcWk1ZzNWU0lINzZWOXI2L0hkVnBaNHZhV3hy?=
 =?utf-8?B?SHFXQlVuejhVZEIzZERnYWRlK3l5a0F2V2ZBU0w1K2t3dXIxeUFnc2pNN3VQ?=
 =?utf-8?B?ME5WaVFCV20xSnVNaVkwc0N1U0NCTDA5ZHdHUHltYXNMek13aDI0aDRJRVBo?=
 =?utf-8?B?eUtJcWNUaklBNnBrbU5VMjZBVGVUYU12aDBWa0hOVWxmd1lXbFFwN2hLTDY1?=
 =?utf-8?B?S3hNVkl5S296WVdLWTgyVG42NEMvN1ppUHYvT3lvbDE5bDBEYXM3Rk9rQldC?=
 =?utf-8?B?UzFCeUUyNzczOHJ4TXhkRWNuYkZmSGJYTUdqOGU4ZFphS2gySXRweFpEdllu?=
 =?utf-8?B?VFJYTUsycHJ4b2MvblJkN2ROMkFQbmdURlg5SGJwME96UmZsUm1BZW00N20w?=
 =?utf-8?B?V1lJajdMcGFBM3Y5eGxrVlRjZVNWWGhCUUN1L1JIdXhUZjVpbmwrMGpTdkNt?=
 =?utf-8?B?dDBiNnQxRnpkamxTRjVtclRrZ3BtZmZlSkVIa0Q4S0RkVjlVK3JmWlRPWnRI?=
 =?utf-8?B?WncyanNrUTgvbE9IN0IrazBWcjkyMC9tM1BWdnJIVERuWWpkRVVPN3BvdVYw?=
 =?utf-8?B?di9pR2Z0eW9NV1ExYVNNZStrdTdVSWpzSTZrWWVwdXpJdWZIMlNyWWZ6M2Rx?=
 =?utf-8?B?cklraVlndUpTcE1UTStwb1UwNnNHUXAxMm1qaU5UemZGZ0NlVzNjODBRN3JF?=
 =?utf-8?B?cTlrMzZzWFp6YSs3b1dpR1BONmQ4TkhsZUVZU2RudjhGZDFpVUs5bXBUNGVZ?=
 =?utf-8?B?V25PTlJCOEFRQVpkRjJSUFF3RmdkaUgwQ1BOdnVQYjVPbWJuNEVjZjhkZHd3?=
 =?utf-8?B?aE9aQjNrUEVheEVnMFdXem1PaE9QYkFNMDJtc3h6TjNIY3ZlL2Z0ZXFLSlpT?=
 =?utf-8?B?U3MzNjhkT0tGNFBXVm9ZM0tMaC9GejVMbkdnd3d0UThFOThuYzFYdUEyN1BM?=
 =?utf-8?B?WDFpQ01sQWhEMEJXUUR5V2h4REQzRnk0VWZzZUZBK2tXOWg0eGJaSlJEcGU2?=
 =?utf-8?B?ZDJmeVdlMmN2dmtZOEExOGNFTm82d25COGRESHpQa2pTaFp6SWpoUkFMNFJK?=
 =?utf-8?B?M3ZUTWhFL1BIRnZ2bVlRM2RKcWZ2d3ZKc3J3QS9Gd0FuU2Nzc1pQNE5XWWxp?=
 =?utf-8?B?WFJFY1c3eWNsTHd6U3pva3d4MFg1TExJVlp3a3hrQWI5MXBZTWxjRmJ1TGlE?=
 =?utf-8?B?QWtoOWJQYlBsSlFQMmg3SDk1TGtibVFLZWNoUlJxVGgvWWpUd3VDa1F1L3Ny?=
 =?utf-8?B?UFFQZzdRb1JFbmwyaE5aVWhmaTFtZHZ5czE5WmpCZ25YS1Z5bnY5UDhCeENl?=
 =?utf-8?B?QUVKNmVQdnlzRlNIYm9ucWdnS2lidW9ieExLVVZFTnRzNlJEK2xheXdXckFO?=
 =?utf-8?B?Y0NPM1BLR1B5UHF1L01TUmtCQ01NWGxGNXZHMHVVTk5hcWxOR01LUyt5cHNL?=
 =?utf-8?B?T0h1OWg2N240NG8xa1BmOEc4NmhURlJ1ZnhHUDdTVWZIUFJQSjBaMUtnbWYz?=
 =?utf-8?B?R3VuaHBaeFRMd3dyc0l0VjRmUlg4UUpNUlZGbCtlLzd0aHZlUXVSZFpvRERE?=
 =?utf-8?Q?BjgwjNrpVz0AD35Cz+GWe8UE3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WFl2bExWeFAyUFV2Z3F5cTlhT2JFcm9hS2paV0xKdnV4TTd6TEU3WWEzNXZv?=
 =?utf-8?B?RG16c2VIWHJNdWJvcjRQLy9MczBHYmZUYzQ0ajdmaGtKTW5vWmxpT2pMaVdp?=
 =?utf-8?B?clU2bzgreU9LNG02ZEdidEVUL3hLcHFwaVRCbXNSNktTenVIYmJxTExFQWJh?=
 =?utf-8?B?VjJsRWd4cjloZnNZdVlLWU1JeXA3R3VOYVBjVjZBUDdSeldCVmxwTm1sSS9r?=
 =?utf-8?B?NzNhU3lnUmdCeVJXOUloZ2R2TjRpS3I4UDBTRSt6MytNVk9xNHMwVW1uWDA2?=
 =?utf-8?B?VnA0a3N0MUJ3YzRIZzh0UVZuYldWQWV6RW5OckYvRHRraHA2M3dSQmpwZkI2?=
 =?utf-8?B?Vm1FWU44eGlQeVpGcktveXpNbGdvN3FsTXVJY0pzZVRNOUwvVzlnSHRpaUY1?=
 =?utf-8?B?bDJrNVowTC90NWMyZE85NTU1TFI4QlJrZGRGSVB0SHU4bU9uTXlDZ0xXTTdl?=
 =?utf-8?B?ZnUxUlJOWGoyeDhqL1RRbS9XNk9qSmNQOSthK1dkWHd5QUQxV09iR3NEeUVn?=
 =?utf-8?B?QkpqcTNPZGNnOTBhR0NleEYwMXpuWTlVbkhSSDBRYm5sRlgwTDVXejhvdUUv?=
 =?utf-8?B?VXEyYUhGWS95YThGbDJMb1htcGhGdmt1R3JFWWxkeE8wQjBFUUZiMllIZ2hU?=
 =?utf-8?B?KzhiRHk1L3dpcXRJcnpBdmxNbGgvTUtEZUR0dzZmUTU4R0FTbnlFSnBhVmpU?=
 =?utf-8?B?dUxOTys0bkk3bElkRTdqNTlGMU5JSkxkV1JyTVZRWTAwSXBYOGVtZ2dzaFl3?=
 =?utf-8?B?RkIrdjhwdHVzNkpyTW0wWHQ4WTR5dGdvbUorUWxQczBNSkMremtJTC9KU0pB?=
 =?utf-8?B?Szk2cXlaWlpONmRWMG1LamVTWjZkRjVHUlNpSjdveVlHYXZXQnhMejB0bXZB?=
 =?utf-8?B?R1c3aW1pVnQwbGY3Tm9zc3ZGd0xJTVJnMW5QYUpCWkY0TWdqbXFyWlVzNk4y?=
 =?utf-8?B?T1lkMU13SzJHZzRVY0dNeEp2Q3IwSDc0Uno4cEhxdE1DVkNFYm1xa2cyM0NG?=
 =?utf-8?B?WEU1VGVZQmVta2phQk4zbmtSdmFmR0hrZVZIN29LZndNK01FRzBBSEFPakZu?=
 =?utf-8?B?aGxrVGRLd0VZUjJRb0ZWT1hDcVYxU2VNaG5XRTVzNFZETHcxL2NxcEdneTh3?=
 =?utf-8?B?M2czRFlQdGhKbTd3aGI3dTRjUm5TM0ZEeVpHV2ZUTmJzNkZmeWt4RlVUV1pB?=
 =?utf-8?B?RUQ3UEtiZERVcUQ5b1hJYjhXRlpVU1ZXY1BFcVB6d2hpOERWOS8reEdQcGY5?=
 =?utf-8?B?Q3owbU9qaThyM2J3aCt1bGs0UldYRzlmVVpMaUp0VGllbHBMZTE1YmVnbWls?=
 =?utf-8?B?c0JEK2kvSnJ6dDNsRXNrN2gzY01jNmtHQjNLWTkrdndXRkhLa2FlYmVxVVhR?=
 =?utf-8?Q?HY5rUYOnmo6psnVJjh1QKoBJCAY4pS5k=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21712292-c1e2-42b8-69d8-08dacc5a1d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 07:21:04.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pKL1AAswNqaDO3rPHkbZQDs8GeQnjMahTrbkIcS9XnHbuTo5PuUXO8SsgODrlTBUH422Gl75REm97m89sVg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7842
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMTEvMjEvMjIgMTE6NDIsIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+ID4gYmxrX3F1
ZXVlX21heF9od19zZWN0b3JzKCkgZG9lcyBub3QgYWxsb3cgaXQuDQo+IA0KPiBSaWdodCwgSSBt
b2RpZmllZCBibGtfcXVldWVfbWF4X3NlZ21lbnRfc2l6ZSgpIGluIG15IHBhdGNoIHNlcmllcyBi
dXQgbm90DQo+IGJsa19xdWV1ZV9tYXhfaHdfc2VjdG9ycygpLiBBZGRpbmcgYSBjaGFuZ2UgZm9y
DQo+IGJsa19xdWV1ZV9tYXhfaHdfc2VjdG9ycygpIHRvIHRoYXQgcGF0Y2ggc2VyaWVzIHNob3Vs
ZCBiZSBlYXN5IHNpbmNlIHRoYXQNCj4gcGF0Y2ggc2VyaWVzIGFscmVhZHkgYWRkcyBzdXBwb3J0
IGZvciBtYXhfc2VjdG9ycyBiZWluZyBzbWFsbGVyIHRoYW4gdGhlDQo+IHBhZ2Ugc2l6ZS4NCk9u
Y2UgeW91IGRvLCBwbGVhc2UgcHVibGlzaCBpdCB0byB0aGUgc2NzaSBtYWlsaW5nIGxpc3QgYXMg
d2VsbC4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0K
