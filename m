Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B15BC2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiISGgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiISGgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:36:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557B6E084;
        Sun, 18 Sep 2022 23:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrtdEZ90JXauUcnApcZiC6D0iAqeNuaFXUsdDAgh3hwbz4X4K5PNEPkROmPn+Y7t+0URU7p1ijLCRlVWPvg3o90+gQBp7i4khjCUPOKrEUTA/U1qvUB5EUOtuondXPXPw/GTMlhWOHZ7vmd7VHWXCLQedCgTqMPbPM0l/I0x/O7/cFgAtio+KxsV2LVnzq/f0POsSWBCTHN34t5PmubdAfO8WFVFWufVE+zliKGu7WI1PWbb0b8C9Sslyi84XU5hXkpBysz2JqLK3YsQ3KSvIux9ggi9fXeeI7iANx6MJOjoMJ4RqSoFbn9jYP0KU0B8C8iL6yujSoPFVMB9l50bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65aHRVdQseM96IwKorDiAHEzzJx+EM/FFe54kqlP/q8=;
 b=oTOF1V9fzqvVYzcucMW6xi3lGMfbZGimRInKw6ljSN8+P5ECTqi3nEAgXaw0Q4/1tdTf2pbRyLz9YezzP56Yj0ZELj9P0A7fGE74CV+Mi27XtVI5Q15MVJD0HOCmL0sZKpdGQzghBUk12G+2laEpxbbKExPvBmm8eJ+3ar4xo2PnjyAZRuGEpn/FoqA5G/z36qtXT+wGS/i6JehonPEUbI9/QA06BonaGZwf4guTBcs7kJPawYzBW770Wn9pMfX/eMohOiJQNxR0Vl4yQhY+ZK2gFdntH198LoMnH+8H2lTLE+oVNcWpHaAZsqIT2Sxhl2oOZ7Kt3BJI6kqiJuAX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65aHRVdQseM96IwKorDiAHEzzJx+EM/FFe54kqlP/q8=;
 b=lqORCauUuYDKEjGjt8vxiXnlKsGDSCpZuUWF/TAY567W0LlirJUBJzSgeGTGDO7ksm5HuuQRFap+qv/JVx+oD6lwrMyw4dsiEru5a5knqtbN1htKH2/vgse8G5LHyZXOMcElbGZn+YQzM0PGOKIx3sSDWlzBosnko23kuyp9J3X9bX8yJBaEvfn56q6+l0giDiFd9WcIVgtgIgAQ8ubr92Iz2bVNseF4XfpK8SCzvTQtIpjVdG0/vhZsLhFoAUfyBub8FOxH6iz6kwn+P36JgXVsmWkCshBHx0Q53c0PhC3RJxvo9jC8F6Hq2VFqgCDsz0b/rKZLhIRA5Lz7U1O+FQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB6141.apcprd06.prod.outlook.com (2603:1096:400:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Mon, 19 Sep
 2022 06:36:37 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::ecfc:64d3:aa40:f00b]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::ecfc:64d3:aa40:f00b%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 06:36:36 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     kernel test robot <lkp@intel.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] crypto: aspeed: fix build module error
Thread-Topic: [PATCH v2] crypto: aspeed: fix build module error
Thread-Index: AQHYwNLZ1RAhZZLKJEu2oAdtSs6t4K3QrOGAgAD9dgCAEEXygIAAb3aAgAQCYvA=
Date:   Mon, 19 Sep 2022 06:36:36 +0000
Message-ID: <HK0PR06MB3202E093BABA938058D5D6FC804D9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
 <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YyRS/71B4veWJgyl@gondor.apana.org.au>
 <4dc8b1a8-d7ef-844d-b48e-76fb8b91d96a@linux.microsoft.com>
In-Reply-To: <4dc8b1a8-d7ef-844d-b48e-76fb8b91d96a@linux.microsoft.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|TYZPR06MB6141:EE_
x-ms-office365-filtering-correlation-id: 5e3a96f7-cb9a-417c-46c5-08da9a094d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVA7svIm70Pbzjp82eS9B7knmjdpRiLOBfwuSKKt8MfZHXOrPXXc5hSyUQVdVM1DoUNL+5P4CGc4wUNbmgHAdzLSug+Sy4NMJzTmEd6UfxYpB7UbgVqVjan22hD84fj5TgQc3mGjdlQHLrzVh/oWu3ATzEhkHGOaHAXOGZ/mx2Fi20/geekqnVEDxhhWnE/yCseGK6x5AVNHYdABbkK4jZkdkjK/RmsLF/+LNcxl++BAEbDKk5cMVNlF0ypwkZ7Q6Ad6Aqznnvw9q941r2W7iPbCod8TXHyiKnpzHV+pu3Gnly7ybsRF9St53LTuLbj3gH+1RAJVzof39XVQhvqrxzgCpaEnEpHM/qsJIuyXvSeskZSKo2WjivpUKQae3LWoPrApUXl4PrvdzFAOFlNToSKKMaRyxFqimFhqgy+MCIntjbjI8SmBdnd/vnJWtrOlWYhKpNVRHlJrV6DNwL9muFS0SjTM0+EUNu+oqfuYHZZm/lRCxi/a71LLkUunu8XNWyUjvsrU4OBS5wO4BdJiHWUVEUfzicWlkELZLqdYYuIfeq5DP8ZDFlXxrkuuvCuUI08jioR3b7TB/4NQCtTjjEzcnZ+LdXu2+yNUAXbjOoG3y+WMdpLcg1VEvqwCh8BkX+0tJAkHT9e+qDDqKuWPaRDu94+wjp4eI3/dBFruZnqWZps6RvWVRz2cbBtPGq5uTHBD0uRElK9JbDjtlwOIbv/qcqr0ayTxSyCDGg4EMLZr7p4K2KT+eGOVG2rk8pWbiNQTzZ/g5c7ne4BTpxDFg6BQPiuu/vcfWe8e8YkdEU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(39840400004)(376002)(451199015)(2906002)(64756008)(66446008)(66476007)(4326008)(38100700002)(76116006)(66946007)(83380400001)(8936002)(186003)(66556008)(41300700001)(122000001)(110136005)(54906003)(478600001)(71200400001)(966005)(8676002)(33656002)(26005)(9686003)(86362001)(316002)(38070700005)(55016003)(7696005)(5660300002)(6506007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cElwUWprTzlBWG5jZVZCZ2NZRDlHVllscWtMMUVCd0dwRGhsL1Rsbjh3WWxD?=
 =?utf-8?B?ZVBQRmRMSmN6c0RaTWEwRVIyelJtQ21Udjl2bEx6Y240M0ZWV0VxbjBqVy9N?=
 =?utf-8?B?cmFJaklCZWRrNllacW1RRVQxSjI2RGRqekJXM3JhR202cVBmK0pDdjFnRFhG?=
 =?utf-8?B?NmRGS1BmWTl0c3FRSk9nYVprRVF2Sk0zT0FOSDRJZGVDamJtQUFDcE5zOCto?=
 =?utf-8?B?a25QNFQvNXYxU2JnSllDazJsQWZRcWFhSm9vaWhMY2lhbzBaUk5oaVJneUhR?=
 =?utf-8?B?WjZ5UXFqOGFnR2NpNmZqdVpLV2xjSkd5OStQU3VWU2VWK0p3OVRaZTdOZVBn?=
 =?utf-8?B?VUk5dEVCbzdqNDJlODlPcDE0a3huR1gzU295a2pOVnQwS0hyV1dIcVVMdEN5?=
 =?utf-8?B?QVNaU084QjhESVJMRXJsajh4S0RlcVBMOW1nMFNGNHF6ajJNWHRyM0lhMnE1?=
 =?utf-8?B?WkZzaXFqVk1VdGtzYUVjaHZST3E5ZzFyZk81SFhSRGU2eEw2TE1rZUN0VkNu?=
 =?utf-8?B?bkpsaXVTYTdWVnhkd3I5cDY0aTNxNXBXKzIvMTVQK2xBbEtCL2UxRFlnZlY2?=
 =?utf-8?B?NVhrOERWQVZvSkZSV2N2VXVTM0g2UkhJNHB6QlIyM1pxcGpNZ3JRZUtsclNy?=
 =?utf-8?B?cUVFb0JaK1RneEhiNFd2Z0NUMjFBNGVTZVN3eUlEci85SGN3QkNuMEFSK2x3?=
 =?utf-8?B?T3RrOTlvNjM5TlJLYXNqOHc4QUI5VkdYM2hidDF5Nm9RR2xXRkNhVnNFYVVE?=
 =?utf-8?B?cFJ2aWlLbG9WbnRLV2RwOCtEM0pkb1pEczZ3STRnNEorTzdsVGVrM1VweXJj?=
 =?utf-8?B?bEtsZzZkZnhDQmdTWHVPOUxFdzhURU52T1U5bmtpcFZ6Zkl3VTZrcFFmRWw3?=
 =?utf-8?B?VDg3MHpZWnRtd055NUdmZXVoV21UZGFSV1VRa1BTcTA1VDE1KzBaL2d0dVky?=
 =?utf-8?B?U1FPYjZqbDkwN3k1WUZkL0tjaS9DcTFSTDJDRzFiRVV1alVud2RwQll1VlZ5?=
 =?utf-8?B?dHFDeCt4bDBEdnZuNWdlQ3BGK0NZZStKNVY1SXhPcTErTmhqbndESGZYdFk2?=
 =?utf-8?B?RXRBRnZ0OTVXSDFPTmorNkJWZG9ybGltREVjT2JudjU0MFl1YTJRaTZDanox?=
 =?utf-8?B?ZGtqc3diRmlzb1NJWU1nWSsreWttS3hGdit1cXpmNWJmSVNsaHRCZEFDVkk3?=
 =?utf-8?B?Q3FvMWw1VnBRV3M1TnorSEc3Tk8yZ2hmL1lQYXlxUVc5djlubW9GMmFKU1lt?=
 =?utf-8?B?S0l2MzdHcnVxMzFRSzZSQko2ZGx0a2UyNXpRNFdqMmJLc3VUN1NGdk1uaTF1?=
 =?utf-8?B?MGhDbUY4VUpYL0tCOW9sd2NRMi81M1ZjMVMzL1NrOUR2VEZUYWNWb29ZbmRn?=
 =?utf-8?B?bzhoYkNMTGlvOVI5RC9qRjg2enljSCtNamtCVTdPOGk1SjVLQ25lOG9FQVNP?=
 =?utf-8?B?ei9VdXlrbG9LK3BhcUwvR3hYQVpkWlVaajAwa0hPZ21nbTg4UFRrVU1TVU5a?=
 =?utf-8?B?V3BBTU9wUVY0YXd6OExmOXQ0U1NaVU5lSmJLT05yZzZKUkpKaCtSNGdhNHVu?=
 =?utf-8?B?ZUxTdXdkS2tzbE90ZHhQZ0R3Zy9DYllIL2VwWnNYamppbmd3MURVYjh4UWVt?=
 =?utf-8?B?cDZ3V1VNK1gxYXlhcTd3Y3VaM29yUjh6b3ByK2s2Mjk2ZVFXSWYrUUpiaUF2?=
 =?utf-8?B?Q0x0WDZBUXFZOTBXMFAzSWRDL3ppcUZheWhKYi84alhMalVNVGNKRUREV3NS?=
 =?utf-8?B?TWNLNkwvVEpjZ3dwR2E0QURxS0tQV0p2WlN2U2VNOE5yb2I4US9QTjAyQ1Fn?=
 =?utf-8?B?ekowZEpXSXZHRDkyVzJvdng5ZS9uVVNsd0NCL3VzcTBYQlRZczVkcEVEUjBs?=
 =?utf-8?B?TlpsbnlHOUdhSjc1SkQwWS9WaVMvWjcwTWUwcFcxT2VMd3U0UFM1TXF3NS96?=
 =?utf-8?B?VUI4YW9HUnpNVDY3TWZYZG5SeVZtcDRmUmc4YlJudmlhVG1nblFHVHhhV3Nj?=
 =?utf-8?B?MjZwWVprS3ZyNmk0WCtzVUkwNGdwYjQvQW5ia2o1T2xXSVFxOHlHbitLZ3I5?=
 =?utf-8?B?bWcxWmM0Sjd2dU9VbXNtL1pmeHZYZ2NuRHo2eEV4Ylhlbm9GT2VRaU1NRko3?=
 =?utf-8?Q?+OMSdIU9trwF8O50YL77wFrm4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3a96f7-cb9a-417c-46c5-08da9a094d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 06:36:36.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kWqiKsOX9z8yNxzrbxNoByASjab2XpThvK1nEQGN629HmEebRBfpDFF3zhtBGNpD9Hu5nEYmtnjifUtQaNDYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6141
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gRG9lcyB0aGlzIHN0aWxsIGJ1aWxkIGlmIGJvdGggSEFTSCBhbmQgQ1JZUFRPIGFyZSBv
ZmY/DQo+ID4+Pg0KPiA+Pj4gSSB0aGluayB0aGlzIGl0J3MgYmVzdCBpZiB5b3UgZG86DQo+ID4+
Pg0KPiA+Pj4gaGFjZS1oYXNoLSQoQ09ORklHX0NSWVBUT19ERVZfQVNQRUVEX0hBQ0VfSEFTSCkg
Oj0NCj4gPj4+IGFzcGVlZC1oYWNlLWhhc2gubw0KPiA+Pj4gaGFjZS1jcnlwdG8tJChDT05GSUdf
Q1JZUFRPX0RFVl9BU1BFRURfSEFDRV9DUllQVE8pIDo9DQo+ID4+PiBhc3BlZWQtaGFjZS1jcnlw
dG8ubw0KPiA+Pj4NCj4gPj4+IG9iai0kKENPTkZJR19DUllQVE9fREVWX0FTUEVFRCkgKz0gYXNw
ZWVkX2NyeXB0by5vDQo+ID4+PiBhc3BlZWRfY3J5cHRvLW9ianMgOj0gYXNwZWVkLWhhY2Uubwlc
DQo+ID4+PiAJCSAgICAgICQoaGFjZS1oYXNoLXkpCVwNCj4gPj4+IAkJICAgICAgJChoYWNlLWNy
eXB0by15KQ0KPiA+Pj4NCj4gPj4gYXNwZWVkLWhhY2UubyBlZmZlY3RzIG9ubHkgaWYgZWl0aGVy
IGhhY2UtaGFzaC15IG9yIGhhY2UtY3J5cHRvLXkuDQo+ID4+IElmIHdlIHB1dCBhc3BlZWQtaGFj
ZS5vIGluIGFzcGVlZF9jcnlwdG8tb2JqcywgYnV0IGhhY2UtaGFzaC15IGFuZA0KPiBoYWNlLWNy
eXB0by15IGFyZSBlbXB0eSwgYXBzZWVkLWhhY2UubyBpcyBqdXN0IGFuIHVzZWxlc3MgZHJpdmVy
IHdoaWNoIG1pZ2h0DQo+IHN0aWxsIG9jY3VweSBzeXN0ZW0gcmVzb3VyY2VzLg0KPiA+IEFwcGFy
ZW50bHkgaXQgZG9lc24ndCBidWlsZCBhZnRlciBhbGwsIGF0IGxlYXN0IG5vdCBvbiBtNjhrLg0K
PiA+DQo+ID4gU28gcGxlYXNlIGVpdGhlciBhZG9wdCBteSBzdWdnZXN0aW9uIGFib3ZlLCBvciBj
b21lIHVwIHdpdGggYW5vdGhlcg0KPiA+IHdheSBvZiBwcmV2ZW50aW5nIHRoZSBidWlsZCBmYWls
dXJlIG9uIG02OGsgd2l0aCBib3RoIEhBU0ggYW5kIENSWVBUTw0KPiA+IGRpc2FibGVkLg0KPiAN
Cj4gQ3VyaW91cyB3aHkgY29tcGlsZWQgb24gbTY4az8gSXQncyBlbWJlZGRlZCBjb250cm9sbGVy
IGluIEFSTSBiYXNlZA0KPiBBc3BlZWQgU29Dcy4gQW5kIHRoZXJlJ3MgImRlcGVuZHMgb24gQVJD
SF9BU1BFRUQiIGluIEtjb25maWcsIG5lZWQgc29tZQ0KPiBhZGRpdGlvbmFsIGRlcGVuZGVuY2ll
cz8NCg0KVGhlIHJlYXNvbiBpcyBiZWNhdXNlIHRoZSBjb21waWxlIHRlc3QgaXMgZW5hYmxlZC4N
CkNoZWNrIHRoaXM6DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2NvbW1pdC8/aWQ9MzFiMzk3NTVlMzI1NjhiNDNjODA4
MTRjNWUxM2Q3YjFhYjc5NmQ3Mw0KDQo=
