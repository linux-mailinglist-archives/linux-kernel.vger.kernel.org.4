Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E15EC228
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiI0MN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiI0MNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:13:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC76AE86D;
        Tue, 27 Sep 2022 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664280827; x=1695816827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6WwxgKvgyoNai8NDuEbd8bgrReqIegLJsc4N5iLhBU=;
  b=YHaJq0mxLUMgKY/RUlLyVD15qjhwtZHds0ZMpapbc2wI/ilr/iGwvRZk
   3gnA0jylBLTim+HF3olSQwz2cZrqf0epeHovlVY35Nuiz8ewyOoRtlKVJ
   DiHljNlu+ixvS+1M/cg8ZCaFhPK4iH9p6/ekGH6vikLMRK0V5jo1jVqTM
   gt0zdxg4cP7eoXs8bwUsJIFjHbw/AdJ2key/S+WQeM8IZK9jcloHd5tF8
   EQ/xdUHlYp5LHiojA4pM1uQH6T9qCJbUiN3ts/wS0wP1EyLWZKrKGthfe
   eR6HE+U6kuEf0oYkUdy5He3prgSyfkvl1/MONx6Zsbhxz5TXxV76AGvNZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654531200"; 
   d="scan'208";a="316658271"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 20:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAjIZkLV0SaEVC3DqiDKPT/71b6CP9wd8k/IiV27K45jVFcoD8sIM/JRhpm4J17vwkPK8pMwkjjKFLhNLTG4QhR4Q2V5wucuiUfUJt0cPCHxiQ0WS4i5JKXLx5iNO2iCwwAiVivxC9qpqBemu2oozKZ/yM9VydwMSQB/6yyyUVSJQmeIbMVC4Eti/BTmnlio8psjkHL4lo8yFZfI6M+/o53PedNN/a9so86zCbCtKmvkcb/fHjO+ewEJbqGGX/wNs7DdO/jUuTZYIWDF3l85KEmPOW0HhwVJifEHYCBmzlW92X+jQiwkjDk80WHkSjJ1jcxCyMKWka/18DdwmyvaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6WwxgKvgyoNai8NDuEbd8bgrReqIegLJsc4N5iLhBU=;
 b=IlUQ9UyZb91PdiLkPlKo+eceGJQo7VCGHX9L30pBB+WPj2ypg5QztVhG6IdCW1OnH0KeYElwhtI8h+t30cCf485Sd3IthXazs/2e/fFYt19sbfiw4SKZPtg/lLAsNauqwmTE3Qhjb8TUn/pRQQPd4SngJFjpEYej0gQ+XSHVBqZTjR2QaPurB1bJMLLa034wZtTf2MuTXPuoY7xjBqURCC8QE22Gb+AxXwNGm62vpid8kIBCH1jbnmALi2P2/hdK0WHFX/VdkmFUDZHm0sezL/R/hy5aBP5v+YtbtS2TVPCrSWVusE7SnWTpTdENIlfhlH8KBwUs7ncwUCjhcYGdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6WwxgKvgyoNai8NDuEbd8bgrReqIegLJsc4N5iLhBU=;
 b=n8Nnw5ZF0PfaXEuWmRCfk43aVL0uxyAMWFcc36uC8va6v240RJmGjsB6/iaV8XfS8eF1sj39BP4a746ILPqvUyVrkIkU5HUTTKkYNXOh98PC+nWbRL+b7STvd3FuHjmEuuOJgOqvjZ7yq4MG+5LPrG1ERgtcoS0U21vTTUmpwLs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN7PR04MB4211.namprd04.prod.outlook.com (2603:10b6:406:fa::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Tue, 27 Sep 2022 12:13:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 12:13:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Topic: [PATCH] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Index: AQHYz1RWgoZZDLvZfE2Ozld1vXObAq3zLpQAgAAHdIA=
Date:   Tue, 27 Sep 2022 12:13:35 +0000
Message-ID: <DM6PR04MB657591012FACE78F92A9DD9DFC559@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220923135617.46-1-avri.altman@wdc.com>
 <CAPDyKFr2+PmmmOoOo-YzaogdaCRCW=CB2PdZcSGdoMjOj0zA_A@mail.gmail.com>
In-Reply-To: <CAPDyKFr2+PmmmOoOo-YzaogdaCRCW=CB2PdZcSGdoMjOj0zA_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN7PR04MB4211:EE_
x-ms-office365-filtering-correlation-id: 2d2a5cad-3f79-4121-604c-08daa081b3b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISzBY9mdEW7kXVg28tSt2z4SXm8WH1ZHqKXs3JcN+ZJb1/iQBjOgEFXmPP8m/UswAq7Tze1St62242MZQxOfevLsSEDOgWOZttDgCuiFTgyefDAUXZSkWrXp4oK0DWW3uK9AIHbKFOUf2QYnhcCbmHL/jXN8m/rLe3x8Mc+63t54wbcqaE+7Pl/IrCxv2Y7wb/P0N1ECMjUx71O37u0HPQmnNA+h7TEHGV5ealE5dta08L/0k8rHl+NOpWtmbq8GSUTD52qx1TFDfRmJYvW+6XlyuwOJ17KFegzI0wcZ/XUw+UnGBHo5PlcGK3pAHWvNwzA1eaITcUb9LUZYkqTEqxyhcGPbbK5zBXUdjR55EmM2qDota1iYSeTmWjQ/cJRMpiTZ/WnE+sgPNimNINd6wemM380OshI4HF5MgV55Iyw333k3zl8wGalc5jssDGswx+h72eXljqew3UjJL8TQSBR3RNDd+CZrwHfUGzc7/K5kT0HeothIu8BHu5CxXT58eqWl5R0hRJU9O5yvDoNIXhzOemNbBlzbFEQh1eAUidE72Z5mSlkvFwsEycJQfO7VuKnXN2niGfXTnV6PNZhrM1IEbkklOSIuSh7wUFx/rwn8i7O0fRgaGY93ih26lN2BnhiXGBxgnwkAncZrUKWmT8ADHPi3Eg+sns1ollE7MF0hU8VYtJNiWLNUC1g1I3PZ6k8qmLamlD5ZfM709DmvNzW2BvtP7ilmwsJgzTw7tcMHjZGLdmEZenhlY+SqYnXyQ3lPqW+R7in+pcPwb/0tSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(316002)(5660300002)(52536014)(6506007)(9686003)(26005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(478600001)(76116006)(6916009)(7696005)(8936002)(71200400001)(41300700001)(33656002)(38100700002)(83380400001)(38070700005)(55016003)(186003)(2906002)(54906003)(4326008)(122000001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFdHOFhIYmdVa2pNcGZGaDlDQTZlcmd1alEzZVFHQ0dYNk9hY0d0MXFqaHow?=
 =?utf-8?B?R2h0MHZnZG5lTDV2dmZUNkFqME56TGY2WXFYTSs3RWFCVnFBT2FhRVdVdkx4?=
 =?utf-8?B?dWVBRlRPanZVdjFpajBCQ0FNMXVJc0pGbHRUYW5WdC9WdHdvejdLZlg5Wk44?=
 =?utf-8?B?U05rVVlCS0huZUVHcnNMN3lIZlpqWHcxYmdNTTR2THB4WW13OVJna3RsWUJQ?=
 =?utf-8?B?ME1BQ080cHlzSHBTRXI5U0xyd0JWUTJlaWp4MjVMS1dJcmNhQ3Mzc0tMTVdw?=
 =?utf-8?B?ODFtamdHdi92L3RZR0phbGJMVmtBT1F5cC9vQVAvM2c1QkRYQ2JLMnlmT28w?=
 =?utf-8?B?Z2RBM2wzSUhJVHZWZXQ0cVlxRG9sWGxPMVpmZXR4akdBeFY4Q2NuSFpkT1Z6?=
 =?utf-8?B?MXFraTZubjdSN0J5YThpWXBvR0pnVWdsNkZZSXc4alNtdTlGeVZyYnhONjFl?=
 =?utf-8?B?dFB3VlQxZXBjczYyYmExdTR2VGh3Sk1zVit5NTdrQk5xU2NTcmRLaEk1WW82?=
 =?utf-8?B?aS9UNnl1N2hpeFYwajFZd2lJRllGd1JkNitTaVZhd3ZIbUdNdjR1VG9LdlNE?=
 =?utf-8?B?UkNRL0lnMVlIM3RDWEphMTBLcWxFWVZKZ3VMWFliOTNrYXRQNUlIMENaSjNJ?=
 =?utf-8?B?OXRoRTVwcy9YQmo4eGlzM0NIOEdvRUo1dnR6RUorZy9YSzBLTGlPdkVhTHF5?=
 =?utf-8?B?RFFXcUp4N2Z0UVNqREtRUk9xbHZaQWpoOXlvbThwZlcvaDhTcitVd0s3Snlt?=
 =?utf-8?B?RWRWcElWS3JHeTFjejA4QmFSU2FHMlNtNGE1bnpzc0hwblo0ZWZlS3k0L1B2?=
 =?utf-8?B?aDZ1L0ZaM21hTWRDaFVGN01vWWUyTVNGZ2lxWmcyUXRXU3IyL3ZlWlNScGg4?=
 =?utf-8?B?SVFLd2orcjNaNG5zZjRYVTRwMUw3a3BnUW1nVmZMTDZRV00yazAxdFcydUJt?=
 =?utf-8?B?dGkzRnk2S2dkeER1N0RtVFNQWlpobjZlR004NGZ4bGM5NUVjWFFJVmwxR1hN?=
 =?utf-8?B?elNpVnE5QmRjNkpuQkxxeCtieFZnM2dCMmJFdG1lK3ZIcWlsbGZsbkNrUm1a?=
 =?utf-8?B?R2ZuWUIwTTBQL0F1WG41d3puR1IzZzVZNzlua1lXQjJuYmxzY2M1cURaQ3Fs?=
 =?utf-8?B?SmJ6Sk1SZzdQQndUQ0RHNytUcUNxK0VEMk9jSlpLTzNDYllKd0cvMm1Majlu?=
 =?utf-8?B?dkJzYmVrcHY3TDRvQ0xHbldJdkprTHJZL21hUU9nSlozeTRZQnhJVzUrZ1FV?=
 =?utf-8?B?Sm5zWlZWNFlUR2Z0TWpCM21HeDVGdnFlaXM4angxaTBUM2NLekxPN3VVVlhO?=
 =?utf-8?B?a1dFNzRYUldyUjNFSHZPR3FUTTRnbzZ0b0IyeTMzY0MwTGpQaDBCU1Z5di9o?=
 =?utf-8?B?cW8rOVArMFBCbXJHQ2xQL2U2ckVQd2hvNk9JTzkxUVZSYzV4bFFGRXNXdTFC?=
 =?utf-8?B?QTY3US9JMEw3QmtWeE9nUmpXSHpvOFFhL1QydGd1ZUdpT3psVWEwM0c0a1lQ?=
 =?utf-8?B?TUxZZjJONVpDTyt6YjU1Q3BzQ3htcUhxOXVZNS9yRmFzK1g4eTRicVBUVGhx?=
 =?utf-8?B?a3pIMVNnL25GeUFuMXQvSlBNRmVMMXVybDM2ZXp3VXJjM0prR2VuWmpaUGsw?=
 =?utf-8?B?MkpYdWMvdW1SdUxIbitmcVV0REorbGZBc2FsNUZnd0d3bDNKd3NvSXpPdUdH?=
 =?utf-8?B?L1BFSGlUanRhMTQ1cHEvM000WHRYd3FYS3pBMUo5Q0xkM3U5RitUZ2NQU2Nt?=
 =?utf-8?B?UnBoQkQ1TUNpcHZrWHhHYkdHMzI5QVpwWURUL2c0eVUwa0xWem9JTWo0R0tB?=
 =?utf-8?B?NEFpMDNldGdyb2dkNG56K0oxUlJvbDZnbE9VQ3FhY0R3M3g1R3NyU0YrMDNp?=
 =?utf-8?B?c1ZKcFBhRnVTTzRDcHVCelFYTVhIWGNvMytJdytBbFZRWitjUThUNmwrM1BZ?=
 =?utf-8?B?MGNqZzFwNmxIQS9kRzBCN0xsSWQrQ2FyRnphbk9GcGJsdGRzMVFHMmFRL0h0?=
 =?utf-8?B?TkdlRTNPTGlpQUdOYUowTTJXVlNqaEZ3STJnWS9aTkpRNFlUaFpXNnNiNjlS?=
 =?utf-8?B?anpmK0c2NWQ1TjlHTUZ4MkNEcmd4dXZRK0UvdG5ublJzZk54aUhmSG5oWDdu?=
 =?utf-8?Q?bCKJljBm0PyT3chnX5X4mvJjy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a5cad-3f79-4121-604c-08daa081b3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 12:13:35.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnxjwUZVKMtQ5hBGakU3S/tXaVbyvjt6yKUK4CQD7kYXBfotwJKDWNWaNeCsMJS3YU6B0IAa/DUDD23vsU/TBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4211
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9j
b3JlL2Jsb2NrLmMNCj4gPiBpbmRleCBjZTg5NjExYTEzNmUuLmEzMWRjOTE1YzVlYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9jb3JlL2Jsb2NrLmMNCj4gPiBAQCAtMTE0MCw4ICsxMTQwLDEyIEBAIHN0YXRpYyB2b2lkIG1t
Y19ibGtfaXNzdWVfZGlzY2FyZF9ycShzdHJ1Y3QNCj4gbW1jX3F1ZXVlICptcSwgc3RydWN0IHJl
cXVlc3QgKnJlcSkNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IG1tY19ibGtfZGF0YSAqbWQg
PSBtcS0+YmxrZGF0YTsNCj4gPiAgICAgICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCA9IG1kLT5x
dWV1ZS5jYXJkOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGFyZyA9IGNhcmQtPmVyYXNlX2Fy
ZzsNCj4gPg0KPiA+IC0gICAgICAgbW1jX2Jsa19pc3N1ZV9lcmFzZV9ycShtcSwgcmVxLCBNTUNf
QkxLX0RJU0NBUkQsIGNhcmQtDQo+ID5lcmFzZV9hcmcpOw0KPiA+ICsgICAgICAgaWYgKG1tY19j
YXJkX3NkKGNhcmQpICYmIChjYXJkLT5xdWlya3MgJg0KPiBNTUNfUVVJUktfQlJPS0VOX1NEX0RJ
U0NBUkQpKQ0KPiANCj4gVGhlcmUncyBubyBuZWVkIGZvciB0aGUgbW1jX2NhcmRfc2QoKSBoZXJl
LCBhcyB0aGUgcXVpcmsgY2FuJ3QgYmUgc2V0DQo+IHVubGVzcyBpdCdzIHRoZSBTRCBjYXJkIHR5
cGUgKHNlZSBhZGRfcXVpcmtfc2QoKSkuDQpEb25lLg0KDQo+IA0KPiBNb3Jlb3ZlciwgSSB3b3Vs
ZCBwcmVmZXIgaWYgd2UgY2FuIHVzZSBhIGhlbHBlciBmdW5jdGlvbg0KPiAobW1jX2NhcmRfYnJv
a2VuX3NkX2Rpc2NhcmQoKSksIHRoYXQgY2hlY2tzIHRoZSBuZXcgcXVpcmsgYml0LiBTaW1pbGFy
DQo+IGhlbHBlcnMgYXJlIGFscmVhZHkgYXZhaWxhYmxlIGluIGRyaXZlcnMvbW1jL2NvcmUvY2Fy
ZC5oLg0KRG9uZS4NCg0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBhcmcgPSBTRF9FUkFTRV9B
Ukc7DQo+ID4gKw0KPiA+ICsgICAgICAgbW1jX2Jsa19pc3N1ZV9lcmFzZV9ycShtcSwgcmVxLCBN
TUNfQkxLX0RJU0NBUkQsIGFyZyk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBtbWNf
YmxrX2lzc3VlX3NlY2Rpc2NhcmRfcnEoc3RydWN0IG1tY19xdWV1ZSAqbXEsDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5oIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmgN
Cj4gPiBpbmRleCA5OTA0NWUxMzhiYTQuLjg4MTQzMjMwOWI0NiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL21tYy9jb3JlL2NhcmQuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5o
DQo+ID4gQEAgLTczLDYgKzczLDcgQEAgc3RydWN0IG1tY19maXh1cCB7DQo+ID4gICNkZWZpbmUg
RVhUX0NTRF9SRVZfQU5ZICgtMXUpDQo+ID4NCj4gPiAgI2RlZmluZSBDSURfTUFORklEX1NBTkRJ
U0sgICAgICAweDINCj4gPiArI2RlZmluZSBDSURfTUFORklEX1NBTkRJU0tfU0QgICAweDMNCj4g
PiAgI2RlZmluZSBDSURfTUFORklEX0FUUCAgICAgICAgICAweDkNCj4gPiAgI2RlZmluZSBDSURf
TUFORklEX1RPU0hJQkEgICAgICAweDExDQo+ID4gICNkZWZpbmUgQ0lEX01BTkZJRF9NSUNST04g
ICAgICAgMHgxMw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIGIv
ZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiA+IGluZGV4IGJlNDM5Mzk4ODA4Ni4uMjliOTQ5
NzkzNmRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiAr
KysgYi9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4gQEAgLTEwMCw2ICsxMDAsMTIgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtbWNfZml4dXAgX19tYXliZV91bnVzZWQNCj4gbW1jX2Jsa19m
aXh1cHNbXSA9IHsNCj4gPiAgICAgICAgIE1NQ19GSVhVUCgiVjEwMDE2IiwgQ0lEX01BTkZJRF9L
SU5HU1RPTiwgQ0lEX09FTUlEX0FOWSwNCj4gYWRkX3F1aXJrX21tYywNCj4gPiAgICAgICAgICAg
ICAgICAgICBNTUNfUVVJUktfVFJJTV9CUk9LRU4pLA0KPiA+DQo+ID4gKyAgICAgICAvKg0KPiA+
ICsgICAgICAgICogU29tZSBTRCBjYXJkcyByZXBvcnRzIGRpc2NhcmQgc3VwcG9ydCB3aGlsZSB0
aGV5IGRvbid0DQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIE1NQ19GSVhVUChDSURfTkFN
RV9BTlksIENJRF9NQU5GSURfU0FORElTS19TRCwgMHg1MzQ0LA0KPiBhZGRfcXVpcmtfc2QsDQo+
ID4gKyAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX0JST0tFTl9TRF9ESVNDQVJEKSwNCj4gPiAr
DQo+ID4gICAgICAgICBFTkRfRklYVVANCj4gPiAgfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L21tYy9jYXJkLmggYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiBp
bmRleCA4YTMwZGUwOGU5MTMuLmM3MjZlYTc4MTI1NSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21tYy9jYXJkLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4g
PiBAQCAtMjkzLDYgKzI5Myw3IEBAIHN0cnVjdCBtbWNfY2FyZCB7DQo+ID4gICNkZWZpbmUgTU1D
X1FVSVJLX0JST0tFTl9JUlFfUE9MTElORyAgICgxPDwxMSkgLyogUG9sbGluZw0KPiBTRElPX0ND
Q1JfSU5UeCBjb3VsZCBjcmVhdGUgYSBmYWtlIGludGVycnVwdCAqLw0KPiA+ICAjZGVmaW5lIE1N
Q19RVUlSS19UUklNX0JST0tFTiAgKDE8PDEyKSAgICAgICAgIC8qIFNraXAgdHJpbSAqLw0KPiA+
ICAjZGVmaW5lIE1NQ19RVUlSS19CUk9LRU5fSFBJICAgKDE8PDEzKSAgICAgICAgIC8qIERpc2Fi
bGUgYnJva2VuIEhQSQ0KPiBzdXBwb3J0ICovDQo+ID4gKyNkZWZpbmUgTU1DX1FVSVJLX0JST0tF
Tl9TRF9ESVNDQVJEICAgICgxPDwxNCkgLyogRGlzYWJsZSBicm9rZW4NCj4gU0QgZGlzY2FyZCBz
dXBwb3J0ICovDQo+ID4NCj4gPiAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHJlZW5h
YmxlX2NtZHE7ICAvKiBSZS1lbmFibGUgQ29tbWFuZCBRdWV1ZSAqLw0KPiA+DQo+ID4gLS0NCj4g
PiAyLjE3LjENCj4gPg0KPiANCj4gT3RoZXIgdGhhbiB0aGUgbWlub3Igbml0cGlja3MgYWJvdmUs
IHRoaXMgbG9va3MgZ29vZCB0byBtZSENCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gS2luZCByZWdh
cmRzDQo+IFVmZmUNCg==
