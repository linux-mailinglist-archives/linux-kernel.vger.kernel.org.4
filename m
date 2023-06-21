Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6573820B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjFUJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFUJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193810A;
        Wed, 21 Jun 2023 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687339874; x=1718875874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y3SQs3ktxPxgvDfUN3I5Wg/e5hbM6Mrb8fyJXqx34WE=;
  b=mV1330Ib80fDr94efO0B6mhZL+U35S7hG3qlEjs8BYBN2uvdxSiEZOg7
   O6JqXeFzzvMTSwidqLBlA5s9skmWsEnfPdibmIc5FkYIBl939EsA6N6r4
   yHPlmlEyXxIjlJC+vyy4QEv8tYJczxc3Vol5o8PwmasA7LkUoUtSI80ZB
   itdFFDjo8QKpKuKOLWQjmhHwDlIGQsjdo1aCtFr4iRY5+7BzDBvMFfTBZ
   umybS6giMUoUjAl5Q8oO539xT8QpHjDJZ9FLOlyQExcajsnNiATZ60m3m
   cfxI+o5G+R0kNmxld920nwkYCTpbloxX5c4bge7Tyh/llV+786vmCnfwY
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="219675170"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 02:31:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 02:31:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 02:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GESry1Bi//QAQYPZBi+Z8RBYINsUg1Smhm35s/GeAtsmMEuk6yMnrF+1bGnfsWKj3oPmEhISWjCQsfGp19CSgNRYfC32OYtTIM4RrDxXo8r2na9TxyhoGWCThTc00cUEoTCAupx78NbFJdqqHqKWI0EGmkZB85T6P4Dcu00tittp0ddyQ7LAZDsb9kkJTPhcVSihDKjc3N9gtYXa5+9OKBd2a3G4GIP3omAcLGS6kRVy+BAvy5Ee+kDzJPpeUszO0PGRF1YoZ/SuUqmYBH3xHjIxFERut0I3nWnlHIfp3rxDrrGOmGSrCKe5tA/ZmTGf4xlSulXeKwVmn7I0zlHbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3SQs3ktxPxgvDfUN3I5Wg/e5hbM6Mrb8fyJXqx34WE=;
 b=DPdmKQuv7cPyaceFQYmeduSUkxaydA2S3UwyqTOpQGGjBUqtt/gvkVzDIXbc0+XBjNRqprT6YENwhp0/RXRTqxvOxl2n/3F/0g3FrS+od2z+66hSkSdDnvWaRcGY9V3qJc8sSPZiOf3ZAqKMEvA70DuYZhdmViEOVOjloxFDPCBEN50+QhNAxN4xGrU0egKJ/Ad2AbupU6hA72ZlivVLRKEpZocRxJI6/0EBecYF0PMYIRv3bQpKaCKvzyvoWqZZASmBrvdwyZyimEnV6LG1Il/SEjHc+IGp1edCq1DlLsy+JhSnHUNVWyLeXFkQP86sAiL7qep//jWhmy4wlxUK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3SQs3ktxPxgvDfUN3I5Wg/e5hbM6Mrb8fyJXqx34WE=;
 b=DG2wwfyq27b7OeaLeqnA6rijp3vVJ6K5eaMVhK/rIBNHAEJmhgu/G8cMFOeEspmXD4dCGvAsVU3DvNu5C7uqYIJ/D6HZiv/mmIpgxq/lFI98TPf2OMjJ95zDPyykMWSlKOAbxNzGfGUqVVP/96XMrdgSdwGwdK0dmgONVbNciMA=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 09:31:07 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 09:31:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mwalle@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <michael@walle.cc>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: lan966x: kontron-d10: device tree updates
Thread-Topic: [PATCH 0/3] ARM: dts: lan966x: kontron-d10: device tree updates
Thread-Index: AQHZpCMb+rdStbi6j0S8AsOsI+rBvA==
Date:   Wed, 21 Jun 2023 09:31:07 +0000
Message-ID: <334a6195-95ef-549c-22b6-e3a705077298@microchip.com>
References: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
In-Reply-To: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM8PR11MB5702:EE_
x-ms-office365-filtering-correlation-id: bfea38b0-6c94-4836-87d5-08db723a3dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPcw719OigmQbwy0XBv8JQz1b6SLOIAvEMOQ9r6+xy4zV+tyLHSC9lsj5y7TrxsRi8cy50R0XEVpM7EwCGPyhF8PpObMV0Yr2aYGE523oi/5hCzrhnkad1O5QjRt2AIUjefh0Qle5d9d+d7J4FnNysCoD9icv+zcOive82gHu8112fAPKBg2Oe/4H1b3w4ez0pMROwYXYCirS6iUs5glLIWvlasjOk4/moKoNIVhub40huras9wXDaEVclfBeFWX2ANxsYrD0a7AfaB1eGv87dPoH/boJwtv3b3AAH0mI19Ar1Z+8ajfvt7IN/Qvy9kxCHlTpeP7zLe2JxThMcxYEqcF7IRA4M3V05EQSLaJYlFUfTC3otbtk8xKzbH6zmq50J6FntvwqJj0ElULd1Yzw5pjjbwaV9Coh9d49SOaOZSJwNpDNmx0NM9zH0QDEMB9jb6pFZ8fAGM2apj/QZZ/qGnQAsL+ABhDkqWcaHUa/gB3arZH/zn8iHV++SUG9WK95pJS866JdaDxfbx2iDJC7GuQM2+BssyTfDGVkQO6wBt04V/5FpunW6+xX2vesqwSIsL8ABRlIGVS+dQMxxuFcuLojOLn3xw5jxoEk58wYDqI7uAkscrIPyeaWs3U32NolusKpwAIDLK1knXEUnauVX7yBBthksT69fV/BlBFb2TyZt/dpw594sPRSoWue+qm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(31686004)(76116006)(478600001)(66446008)(64756008)(66556008)(66476007)(91956017)(66946007)(36756003)(38070700005)(71200400001)(4326008)(110136005)(54906003)(316002)(86362001)(31696002)(6512007)(6506007)(26005)(186003)(2616005)(6486002)(122000001)(38100700002)(53546011)(8936002)(8676002)(41300700001)(5660300002)(4744005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW5aMFZCaDhPZmV4Vkg0Tit2Z0Q4Qm1WNlJJS2xSSFUzQnRIMEg5dnB6M2FX?=
 =?utf-8?B?Rit0aXkzbnFwTVM4dHFMRWtVb3c0UUdMdStMT0hNQzluRlYxQytsSEFqbmNE?=
 =?utf-8?B?TUhoT0lEU05ubzlnRlpoaStHY1hPYlhPV0d1K2JVamwrYmxLMm11d0ZGQUYw?=
 =?utf-8?B?U1pHam91L0dTRzN6Z09JNFBJVTIzbTdObGMyalQ3RlFqdkVsNE5TVWZQM2RO?=
 =?utf-8?B?LzdTK1FxZHpZbmxSdTJmc21DS2J4RGpzMWdpbEMrMjhqUEhlYzF6ODRnR3lC?=
 =?utf-8?B?TWo0TUxMM1JlTUk0OVpTODdvcm0vcmVCaHM3L1FDaVJselhJNEZ0YWhPUkJX?=
 =?utf-8?B?Tk5xNVA5anUrNkRNTnUyVjNSVUYzWjdhczQ2aTh3ZmNSQW4wcDVIdVRWUENZ?=
 =?utf-8?B?NVdWMXlReEIvRzdjSEMzeWp1M2JaUk5ZbHlZTHFMYlRQMDJkZjlhN05rdHRG?=
 =?utf-8?B?MVdVUlBjcnNRTy9wdS82Y1RsZVQ2NmVaWVY2dE5iYTNmZzI5ZUlTZ3FKbHdR?=
 =?utf-8?B?MFFuOVlxN0NsRXlwaFMyUzRNQm1sd1RkNjNiQWNodHdHZVIxRmMwY0s3YkFN?=
 =?utf-8?B?elZjOGt4SHF3TUxBbFUvTDBPdnlURDgyd3dDQ3o4YXdrRWtzODByKzAwN1dU?=
 =?utf-8?B?K3phc000YnRySDhiUDFVZ2F3MnJEdUxVUTFSQ2lFYTFWa3U5MWRpblFGVUxC?=
 =?utf-8?B?QlhVeFd5SGFvWHBrN0gvK0FZWEQ4THh0SFlDK3VBRDJqaUk4ajBaNUk4N0Iy?=
 =?utf-8?B?V1RkOEM3Tml4ZEZrbFpWMjlhU1IrSUs5ZDVxL2JhcTRNS1BXUVhCOWQzMVJv?=
 =?utf-8?B?KzNFcm5NcFZ6T0VOSmF6clRYSXZDRHRlc3Q5ZDkwVytKS0RmQ3N2eFhvU0xN?=
 =?utf-8?B?MWVxUUR0WmVhMlFkWUZJeG9HcUx5R0pnYkhSLzRXbi84Nmtwbis4Z0RtNkMr?=
 =?utf-8?B?VktobE00cUtYY3RHVEhyOGxWcEdtcjJWTjZBTGIxNUZ0TmtSdFFzdk5CZmRj?=
 =?utf-8?B?ZGJhQy93R0FRNGcxK21YZFdXT2pKTk81VENYcUpkZDd4VTNXd29VVENBTDYz?=
 =?utf-8?B?RGNzSFJoZGdnM3JzL1RsT0RLVnFkRkR6Z3h4QkI1OTk5dTFleVNreTZ3NTdW?=
 =?utf-8?B?SVkraHB0WFArdzNBUnp4Z2tQVnpjQXZDT25QQ0dCRjAxMmhmRys4SjVNQUNE?=
 =?utf-8?B?RCtiNkEzNVN3UFZ1Rk16aUw5UGtKUlVRelc3V3dOL2dZY3JsVUhQL2tUaXRY?=
 =?utf-8?B?TFB5REFQdVVpV29Rc0J2V2tIMlhwYzE0TmRrc0xlRjRGR0x3bjZJWGFlZUsx?=
 =?utf-8?B?azltdzJBSUZ3UHR6MXpLSjdienBacnNMOXBSb0p6V2NBWWNrOUNyMm5DcWZ4?=
 =?utf-8?B?bUpxUEY1MVBDYjMwQklCeUpmbXRJSjI4REZIZVFvSmtNclBRcHN1YWhQdFFE?=
 =?utf-8?B?Vmo2emNiV202cjdqdW04NUp0RGVnaWFmZ1NFcTlJVzZGWXRRVUVESFhMUWFX?=
 =?utf-8?B?eVRUZ0JjR3g0RGtXWndPemtIL0pwaHB5SCt4NmhHWXVZdUQzRnpGNEk2dEFL?=
 =?utf-8?B?YUYwdmlQdDlMS0pRMFNDN2Fhb2FFRXVSZ3NkZmI2cERvRkN5dFUxYzFmWWIz?=
 =?utf-8?B?ditnelNNMVNGckExMWtpUG9ybms1ek5ZVzY1QWJRMWJ6Q1lHZXl4R2F6ZzBZ?=
 =?utf-8?B?YmJjbUZwVzdtQ0d1RTBKT1B0VVNKY3p0MUlSRkFnSndmdCtWeHBJcDNHeENj?=
 =?utf-8?B?eDNzaVM3YmFFZ2VsdlYyREZDOUhuVGRxQ1J0UXZmeEpyQXhTUWk3UlhCWFdr?=
 =?utf-8?B?YlF3WUYvZDRwQm9GZDF6UEJvZExLd2lmM2UzMkhqenJjNWgxRVUzSTRQV2Fh?=
 =?utf-8?B?VEEwTUhkMytzdjZ6MExPQXZxNXNwK2ZvTFowWUlScFVhUmZPdW1DczBoMFA3?=
 =?utf-8?B?ZDB3WnB2NjFDdXlRQjJMNW9hV1lFbzc5Y25mcjhmSUxGYm5sSFdjenBtNDNo?=
 =?utf-8?B?OHJjN2d1VEo3Nm1Mb1ZuTENTS0RCVUNZVTNmbnJFNWtpRDFUUCtpalQwOUw4?=
 =?utf-8?B?eXozSExpeFpDRUVVUlN6ejNqeE9ZYmtBV3VXU3FLUms5b3BVYXFVRUVtSGRy?=
 =?utf-8?B?czJ1NUJObW4vTDBKK1NyeXhta1hoVlczbDdUWDYvbHN6NUlVcEdRbkYrK1Q5?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED91FFDDEFB95E40AAED8016B7E4B1A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea38b0-6c94-4836-87d5-08db723a3dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:31:07.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQiviErF9IAk5Or8iffbNlPWMQV07Gppptn2iW6Pnbm/8r7gHiwUdgaBnGgNYjWYB/PyjlNb20HsVgoUU44ow1JhcE5C80pnrOC5aLWAGJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5702
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDYuMjAyMyAxNjoxOCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGaXhlcyBib2FyZCByZXNldCBhbmQgU1BJIENT
IyBvZiB0aGUgS29udHJvbiBEMTAgYm9hcmQuIFNpbmNlIHRoZQ0KPiBNYXhMaW5lYXIgUEhZIG5v
dyBjb3JyZWN0bHkgaGFuZGxlcyBpbnRlcnJ1cHRzLCB3ZSBjYW4gYWRkIHRoZSBjb3JyZWN0DQo+
IGhhcmR3YXJlIGRlc2NycHRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxl
IDxtd2FsbGVAa2VybmVsLm9yZz4NCj4gLS0tDQo+IE1pY2hhZWwgV2FsbGUgKDMpOg0KPiAgICAg
ICBBUk06IGR0czogbGFuOTY2eDoga29udHJvbi1kMTA6IGZpeCBib2FyZCByZXNldA0KPiAgICAg
ICBBUk06IGR0czogbGFuOTY2eDoga29udHJvbi1kMTA6IGZpeCBTUEkgQ1MNCj4gICAgICAgQVJN
OiBkdHM6IGxhbjk2Nng6IGtvbnRyb24tZDEwOiBhZGQgUEhZIGludGVycnVwdHMNCg0KQXBwbGll
ZCB0byBhdDkxLWR0LCB0aGFua3MhDQo=
