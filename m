Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1F5BFBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIUJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiIUJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:54:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C333A20;
        Wed, 21 Sep 2022 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663754006; x=1695290006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=57nYgdWhgFWdOVftUbTREVri2lr8iL2nX5oPR3egs0c=;
  b=boEuIXO8Zy7vxSRuqXBcziL4fSti3Ri+CpSTgKgCyHKRZg5Bl3N7mRQd
   QSqrQ4Wq+D8s6cf3jzcGS9QvDNawpMiHz3UkWtRQd1JyHfkJhzPfDKkKJ
   bv9Zn83lN3ycA8ZQlGnaZCMoxngI0KAlBXaRH6FaeMAGtMmcqWe163p2x
   UTO2tyS90J/VSQWhmUd4dII3VPPOeQ2bYXScoQt5IqtWzl3lFSB97CHNC
   +u0qtfjGc+lW/F849H0n1OVac2WECrB41IIQ5L26YpINQIaa0m6qKbTfl
   z8LSwpo+1ZuCF+bWTBTRqA3EMeZ3FYfixeVOjRlNlTbOfgMI7EAPLEyXE
   g==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654531200"; 
   d="scan'208";a="316184119"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 17:53:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdNtWlZ1aW2y4ylVfNZ0SyhWDpmSL7mk7nwPPXXslt/59GPSyK77F9ihK777oTaJJVh2AZtnNhnfPGthu+bj8XIEWaRGbhLxCcvdk2KnB65hMTmCKOjS8Hg9dKLjFw1C5EvNHJyFxsAzSFmSV/Wa3ILbsw17w036l9zVmQ+moafgtBFdxdqektrNXyHZN8xHxsRQtHWqS9boWa0w44pjOsiUwyPuma9VAYsKnCPk5Pu0Kf89pOlr6UU7xsk7cModBwAcg9b1wgTsfKXOEw/R64jylK2WO/yNqgpDptVHPYSo1HB7J0CCVcKqzJMpb2jB+xz4KskAstYOBAXMgA0jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57nYgdWhgFWdOVftUbTREVri2lr8iL2nX5oPR3egs0c=;
 b=jqhdyFvlm0To6TlxwVcSMVkbn3qdr52oun2Rdexz86csOCC456Pg+PWlBJq/QIBl0W2M1EUgdc2EC/lppLDxh45yatmP6vhadat463qf6eUILuDnSdMPQxPGPguL3E26erW5tKx9QQ0mfCG7X91Cnn3yO55Zwh4hBRJ5q+dwQrm+p3TcM67Se6U7BSSYrX6ur3ZtCh3XqH5dA3It+pdx9vD8jJorcaHjwdrzPPD3rIj6KmsiosKAY3ekwsU8jGyFDKvULVjsGX28+JewwEOuuh4PFGEzWuvmLpb2wUQLQnhBg0ed2/y5i0PGroPf9shxBXrIBLDWSS4dZTAMpcSF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57nYgdWhgFWdOVftUbTREVri2lr8iL2nX5oPR3egs0c=;
 b=Q6zpPEDTFTBLSMr2AzqYI8cMKNtKI7+TgTiW3sW+CLDk/VVGow0/ggRQ1gRwhOXtKTfIxfKdpotqQiOxTemalOxQsxAjPER2Nrrgh9l1KEn4AliICNqoCt9Lh4PIDK0LCjyt+R9C9X8PGBokSB5hysWsiNfuWh9xZxbno2NmG/o=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by DM5PR04MB0492.namprd04.prod.outlook.com (2603:10b6:3:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 09:53:18 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 09:53:17 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "James@vger.kernel.org" <James@vger.kernel.org>,
        "E.J.Bottomley@vger.kernel.org" <E.J.Bottomley@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "Martin@vger.kernel.org" <Martin@vger.kernel.org>,
        "K.Petersen@vger.kernel.org" <K.Petersen@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bean@vger.kernel.org" <Bean@vger.kernel.org>,
        "Huo@vger.kernel.org" <Huo@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq3ooC4AgAGVWkA=
Date:   Wed, 21 Sep 2022 09:53:17 +0000
Message-ID: <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
In-Reply-To: <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|DM5PR04MB0492:EE_
x-ms-office365-filtering-correlation-id: 4adc6353-c3d4-44c4-16d3-08da9bb71c17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2TtybttCWB1uwmzorkGsTftc8DvT7CzmGNOFDvfiGn+J7j+iTTlZCB4aU3aYxBS0I4yrI1TiyBkD24hMev9Xub/ipibGK1gsOMYVzeZrD69RHs4Y1OE+3qugcsyCmNRCaDlGNkJzYMVJbFdiZRQWHn+8Iz/ycTF03ZRj6SQe9Ex2A1Ums9Xe/ysQxGqdme7Rkemdhg05Eva5W12yHLhoz6zwntRxN01WP0obU6842gXt1Z1qZ6ehQOhXMI/OQUiSgdctmqmyP2Q7PXoCTYF+3LsuQvcfhhqKh85XusKAlv10iZ+eUINhfoscLOs4hJOPStO3BVk9w2JYnu9VTwM2EXJb+odrFPBUEMraMDWq16ldOsq2QlqZAyX+sSFM5l3cthPdQ6ymuL1kYRF4njz4zVaq1PPjZ9bPSRTRia7b1E1leodIoaFYRnIVGpKOAVWwIh1VjlrEU1z7jwpNxv2EFVEh7eGbo2fZdrQ/+bY2pYGoLwJP+MjAqtKbe4HEyqiP1gHM02xioHfbwdiuScDSNPzFcsIoyh/BbVpBFzH7unkrIbDTUz7UdMtXTWKBvMw+WgcfEE1+De1YyN6DHmELE7fmTHwhL7D28shIIsIKGKjOFv8hcvYJwTmcIVDjkLDyy6v2ilIoJ7x27kgqQqW3A8vTvOW4a4DOfOv++7eHMMPcYjyLkuqe6yK4v3hfJW2GHCsizEt9pA63L+m6I7pdWC7EhoDqipKYAZ3KTo5d7NG+nOxUtEs38upp/7Afv2TDf4ODYdiHI5xR7NJTYrtKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(55016003)(7416002)(5660300002)(52536014)(38070700005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(86362001)(33656002)(110136005)(54906003)(8676002)(4326008)(316002)(41300700001)(2906002)(38100700002)(71200400001)(82960400001)(478600001)(122000001)(9686003)(83380400001)(53546011)(26005)(6506007)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDg4VDREdElpT3lmN2pHQjBUVFVQU2FqYllEV1YwczhVZ3ppRlZYMlJQU2VM?=
 =?utf-8?B?VmgzQXJxYkFaRTdMMlA0YnRLbjJvTFlubEpFU3JPWWxOSHZMMmxURnN3TDRk?=
 =?utf-8?B?MGwxeFUyb3BkOTZYWTZ0b29idVZpdHVXMDVuTys2bE9kck5EMVZBcFNYaWxq?=
 =?utf-8?B?OERCbCtHWVpVNzNEVHVkakJkVU1Dc1BIWGd3NlBjOTBDYzRrOXMzSTdiREtY?=
 =?utf-8?B?NEtBcGxwVkdRRW4zZnJQTktJR2dDN1FpVURwWVdYL0ZOUnhzaU9TazVCaURs?=
 =?utf-8?B?eUQ0SDAwODkrUXNyK2p6VUNiUXU4UDFHTFRzaWEvYnUrYWlGZVlVNmJZc1VH?=
 =?utf-8?B?TVZ3dFgxVUFaU00wcXgzRUp1NFJBVjFNaVVkRjhPaEZ1RDJtSitaL2VBTUZJ?=
 =?utf-8?B?NU1HR3lmUDJlelR5NjdiM2tCUU9NQytlOEladllEVUFjV2hMeTVMNENxWS9M?=
 =?utf-8?B?VHRJa0RVcjJUL0MvRFkrQ0ZBWWc2RVg4aHFyWGRTbm9uUlM5bTgvME4zNS9p?=
 =?utf-8?B?b3VseDcyWEV3TkhVd29tSXlPdHJZMG5nTXFlemlwcTZYVmxoUitrLzVUMzNk?=
 =?utf-8?B?YVlhS1V4aVgxU0MrU3B2TDBHM3FMZHF6azB0QnpCSXFwMVlvSlMvUFB5SHA5?=
 =?utf-8?B?TFdMU2duS3NCNzIyeHpXaTdKZTNlcEFSSGp6N01yVFJlYVB3VlI2eVRHVUJ6?=
 =?utf-8?B?MW1KTEdneENYZHZiaWNzYkF4b0JXV09JcVhvYjJTU2ZBVGp2TkpaTTJncU1E?=
 =?utf-8?B?TVhhbG4zaHJEZWd2TGhBTmJZNzJSS1RKVFpaWVNhSjhDOUJMRjZ1MTloS2du?=
 =?utf-8?B?S01PKzJEcGNZYXE3b0UrZ0k4L0NZT2ZZTnN2cWdLZC9vTG1iTktiR2pvMC9v?=
 =?utf-8?B?QTF1NUpDYURXRlNEQ2xiMXdzVXZaN0p4T3RDK1VZSjhWa2prL1Z2VEZvS3o5?=
 =?utf-8?B?ak5hKzJuek82TXh0NzI2NG9vR1NIVTdSSkdkeFRnOHhXTHFBdEVpd2dMdXM4?=
 =?utf-8?B?NmRKUkRmTU55Q1dXSDNkV2hKcWtEeW5QU2QwTFRBdUNkdXZqQmI5MDBmR3Zp?=
 =?utf-8?B?b1RTdjZ0b1ByY3NJbFFPVlVlV29BLzU1T1Z0LzczRjRha0srNm1YVDcvZXBu?=
 =?utf-8?B?U2UrVTBPU0hYdklydkxxZWNVRXFHRHRZK0Q2Y1VXeW5lclByTGdkblUwUFEy?=
 =?utf-8?B?QWVLdnl6SzliZlA5ODVJcDBxcE9QcW9jN0VRL2tpNC9XTVU3UnR2bFlNM3JP?=
 =?utf-8?B?RUxmNForZEw0MkFjNjdRNkw5YUhnRE9yaXZKSGJLZlI4WDNrRldQY1Zob09n?=
 =?utf-8?B?M1dnTVFteXhwaXVmMkYwZ0JCZ2Iwa2tnWWJwakxWdUw5SkJsbE94MGhJYVRP?=
 =?utf-8?B?VGU5S2RVREtVL0RUaUVCbFZDNVlZcXNxNk5ITTRUVmlhaWxXRGFUY2Nia1ht?=
 =?utf-8?B?WnMrZmJDN2d2a3NOZlRZcFpjTjNzaGk0Wis4S3FLc0RZSUV6VTNNVWRBNFRl?=
 =?utf-8?B?SGJmYVk3LzhIYS9acXJ3angwZXAvR2czTFpEaU9RaDE2UHIvU3lKSFlWY0pu?=
 =?utf-8?B?V0J2UVBIRnE2N0dDYlRpZ0NaeDdNcTdJdDFqVDEyenhUV1ovZGJaNHpkZDV5?=
 =?utf-8?B?L1QvTHpBblpWSGZtVkxwV1hUUVI1NllEVFlPQTRNWnpnUU1aKzJGVDhPeXJp?=
 =?utf-8?B?VWRVVzcza0txby9Xclo0YjgzcFhWbFFFZDEyZkFQWmduWllQSE5Oa1FOaUpv?=
 =?utf-8?B?bWZOZnl6aG05YnNTMUluRVFuajdmNmtZb1dPaGFVRjYxQzU3SVUvdlhEWGlG?=
 =?utf-8?B?QUNEV0FERHNSemp5L09VaFoxWTQ3ZnVnT3RuUnJsU3l2djJ6dnJQT1ZaVjhM?=
 =?utf-8?B?a1ViWDcvSGdKQ1lIUjNqVkdzcnhxUW83cmNOeWhETEh0b3lQcU9DL1p5VlVT?=
 =?utf-8?B?ekl5NmRjRTFJSDR6Q24rQkNCZ1RWbzlFQ0xUZCtPMXYxR0tZMzlYQ1FzcjJU?=
 =?utf-8?B?THBkdkp4Y1dvK3dUOHpSdXUyL3dkSkZ4d2hIWForaGh5bUx4TWdGQ2UxcXEx?=
 =?utf-8?B?ZEpkMklYK01DQU52Wk1XWmRkQnUzb1RCOGNwT2dyd0pSaG9jYi9MbHhnQTJs?=
 =?utf-8?Q?BkX8F5siHrhF9dTmpsjBcvncK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adc6353-c3d4-44c4-16d3-08da9bb71c17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 09:53:17.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HXs6fRQ6sSbsmLXBp3ZUiiDwrtsZEfIjYmIB+LbiShMG541ZUvH7NcHaBOfPSnLLicrwWdfpJK9aS9LQz/4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0492
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEJlYW4NCg0KPiBVRlMgZGVzY3JpcHRvciBzaXplIGlzIG5vIGxvbmdlciBoYXJk
Y29kZWQgKGRlZmluZWQgaW4gdGhlIGRyaXZlciksIHRoZQ0KPiBzaXplIG9mIHRoZSBkZXNjcmlw
dG9yIGlzIHJlcG9ydGVkIGJ5IFVGUyBpdHNlbGYsIGNoZWNrIHRoZSBsYXRlc3QNCj4ga2VybmVs
Lg0KPg0KSW52b2tlcyB1ZnNoY2RfbWFwX2Rlc2NfaWRfdG9fbGVuZ3RoIGZyb20gYnNnIGNvZGUs
IHN0aWxsIHByb2JsZW1hdGljDQphbHNvIGluIHRoZSBsYXRlc3Qga2VybmVsLiBUaGUgZnVuY3Rp
b24gbGltaXRlZCB0aGUgdWZzIGJzZyBmdW5jdGlvbmFsaXR5Lg0KRm9yIGV4YW1wbGUgRkJPIGRl
c2NyaXB0b3IgcHVibGlzaGVkIGluIEplZGVjIFVGUyA0LjAgc3BlYyBhbmQgYWxyZWFkeSBleGlz
dCBpbiBzb21lIFVGUyBkZXZpY2VzLg0KT3Igb3RoZXJzIHJlc2VydmVkIGRlc2NyaXB0b3JzIChS
RlVfMC8xKSB3aGljaCBjYW4gYmUgdXNlZCBhcyB2ZW5kb3IncyBkZXNjcmlwdG9yLiBUaGUgZnVu
Y3Rpb24gcmV0dXJucyBsZW4gPTANCldlIHNob3VsZCBiZSBhYmxlIHRvIHJlYWQgYW55IFVGUyBk
ZXNjcmlwdG9yIG9mIGFueSBzaXplICh1cCB0byBRVUVSWV9ERVNDX01BWF9TSVpFKSBvciBpZG4u
DQpBY2NvcmRpbmcgdG8gdGhlIHNwZWMsIHRoZSBkZXZpY2Ugd2lsbCByZXR1cm4gdGhlIGFjdHVh
bCBzaXplLg0KDQpUaGUgdWZzIGJzZyBkcml2ZXIgc2hvdWxkIG5vdCBpbXBvc2UgYW55IHN1Y2gg
bGltaXRhdGlvbi4gSXQncyBvbmUgb2YgaXRzIGRlc2lnbiBndWlkZWxpbmVzLg0KRS5nLiBhcyBk
b25lIGZvciB0aGUgYXR0cmlidXRlcywgZmxhZ3MgdGhlIGtlcm5lbCBkb2Vzbid0IGNoZWNrIGl0
IHNpemUoZm9yIGF0dHJpYnV0ZXMgaXMgdGhlIG1heCAtIDQgYnl0ZXMpLA0Kbm9yIGFjY2VzcyAo
cmVhZC93cml0ZSkuDQpBbmQganVzdCByZXR1cm5zIGFuIGFwcHJvcHJpYXRlIGVycm9yIGNvZGUg
c2hvdWxkIGFuIGVycm9yIG9jY3VyLg0KDQo+IFRoaXMgVUZTIGRyaXZlciBpcyBpbiB0aGUgd3Jv
bmcgbG9jYXRpb24sIEkgYXNzdW1lIHlvdSBhcmUgdXNpbmcgYW4NCj4gb2xkZXIga2VybmVsIHZl
cnNpb24/DQpEb25lDQoNClJlZ2FyZHMNCkFydGh1cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEJlYW4gSHVvIDxodW9iZWFuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDIwLCAyMDIyIDEyOjM4IFBNDQo+IFRvOiBBcnRodXIgU2ltY2hhZXYg
PEFydGh1ci5TaW1jaGFldkB3ZGMuY29tPjsgSmFtZXNAdmdlci5rZXJuZWwub3JnOw0KPiBFLkou
Qm90dG9tbGV5QHZnZXIua2VybmVsLm9yZzsgamVqYkBsaW51eC52bmV0LmlibS5jb207DQo+IE1h
cnRpbkB2Z2VyLmtlcm5lbC5vcmc7IEsuUGV0ZXJzZW5Admdlci5rZXJuZWwub3JnOw0KPiBtYXJ0
aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0KPiBDYzogbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEJlYW5Admdlci5rZXJuZWwub3JnOyBI
dW9Admdlci5rZXJuZWwub3JnOyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gc2NzaTogdWZzLWJzZzogUmVtb3ZlIHVmc19ic2dfZ2V0X3F1ZXJ5X2Rlc2Nfc2l6ZQ0K
PiBmdW5jdGlvbg0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERvIG5vdCBjbGljaw0KPiBvbiBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhh
dA0KPiB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpIEFydGh1ciwNCj4gDQo+IA0K
PiBPbiBNb24sIDIwMjItMDYtMjAgYXQgMTU6MjYgKzAzMDAsIEFydGh1ciBTaW1jaGFldiB3cm90
ZToNCj4gPiBUaGUgYnNnIGRyaXZlciBhbGxvd3MgdXNlciBzcGFjZSB0byBzZW5kIGRldmljZSBt
YW5hZ2VtZW50IGNvbW1hbmRzLg0KPiA+IEFzIHN1Y2gsIGl0IGlzIG9mdGVuIHVzZWQgYnkgZmll
bGQgYXBwbGljYXRpb24gZW5naW5lZXJzIHRvIGRlYnVnDQo+ID4gdmFyaW91cyBwcm9ibGVtcywN
Cj4gPiBhbmQgYXMgYSB0ZXN0IGJlZCBmb3IgbmV3IGZlYXR1cmVzIGFzIHdlbGwuDQo+ID4NCj4g
PiBMZXQncyBub3QgYm91bmQgb3Vyc2VsZiB0byBoYXJkIGNvZGVkIGRlc2NyaXB0b3Igc2l6ZXMs
IGFzIHRoZSBuZXcNCj4gDQo+IFVGUyBkZXNjcmlwdG9yIHNpemUgaXMgbm8gbG9uZ2VyIGhhcmRj
b2RlZCAoZGVmaW5lZCBpbiB0aGUgZHJpdmVyKSwgdGhlDQo+IHNpemUgb2YgdGhlIGRlc2NyaXB0
b3IgaXMgcmVwb3J0ZWQgYnkgVUZTIGl0c2VsZiwgY2hlY2sgdGhlIGxhdGVzdA0KPiBrZXJuZWwu
DQo+IA0KPiANCj4gPiBEZXNjcmlwdG9ycyB0aGF0IHN1cHBvcnRzIG5ldyBmZWF0dXJlcyBhcmUg
bm90IGRlZmluZWQgeWV0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXJ0aHVyIFNpbWNoYWV2
IDxBcnRodXIuU2ltY2hhZXZAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zY3NpL3Vm
cy91ZnNfYnNnLmMgfCAyOCArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzX2JzZy5jIGIvZHJpdmVycy9zY3NpL3Vmcy91
ZnNfYnNnLmMNCj4gDQo+IFRoaXMgVUZTIGRyaXZlciBpcyBpbiB0aGUgd3JvbmcgbG9jYXRpb24s
IEkgYXNzdW1lIHlvdSBhcmUgdXNpbmcgYW4NCj4gb2xkZXIga2VybmVsIHZlcnNpb24/DQo+IA0K
PiBLaW5kIHJlZ2FyZHMsDQo+IEJlYW4NCg0K
