Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E926371DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKXFt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:49:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C12627EA;
        Wed, 23 Nov 2022 21:49:48 -0800 (PST)
X-UUID: 1f0a3ac1a3cd48ce9cb8bfa369247019-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t0rQvutHq8xGa6MrHKTE4Gfkppk+abexSIXGN0/Rsqk=;
        b=IbxHLE9V8RfuoaJ22Dtl9z7H458E56OUs6Hd5wnddaPf7AKNjc43gWz4XiL9c64n4N0IF+ln2fwWN9ukDLtPYcjACSEYIGLXM3ebvffNzsOf6nUaKIF8rtNWUl4tzCeqQABBIXh/T56fLumMKDUJFaylECOUC+CBzRgJqRH1UA8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:92813cf4-a901-48f3-8869-aa187985e18b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:92813cf4-a901-48f3-8869-aa187985e18b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:ce451adc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221123190839YUIEHW6Y,BulkQuantity:4,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 1f0a3ac1a3cd48ce9cb8bfa369247019-20221124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 790789556; Thu, 24 Nov 2022 13:49:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 13:49:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 24 Nov 2022 13:49:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6YOs0IZz0m72+OV+7uK90hKmCnmtPKhJ1dR8irHeiRbvXZJpqPbQdtfrj0wFWOk9F4oOfPhYAre81cFvLSDLjrT8PCiDZEuCI0SCPZs5VSgIn80WbHKdxWFBbryya5f5aFb/GiXd9oUnBt9UQOTi9hk9FDPuC9nkJJQDRmgO5vtUhbMZ34XGlfMvTkrIIKhCB8EfkispkkD6FimQxn2R31feBgv9YrVdSOEBw0MThlIxvBx3BRgHdGLkVkxDTL4uojT8KWpn8nyqgj9O3NHHqif+9+sTTE4+VO/5V6bOLrJYZovm6hq1+OV3kUw4SRzXT9Y7sb4vmH/3o9Sdlyfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0rQvutHq8xGa6MrHKTE4Gfkppk+abexSIXGN0/Rsqk=;
 b=J9cnJTTGjiyeG1YHCVl6xgCj7KQxIpwipmGvaHlEO/rZOAYNOV5+vT9xU+in3L/7fw/zkliHyOiU0J/ZG8pP1L9KJgx5kazNUuye98fHdODQguBtjmCLOddCXdwE/ywazL4/MafpocBAw5XhCTnOTh7k/SQcYtM9Ls94tO1WO4USE8y5suLnSuzsXE5OpWLPui2KX7OZtfqGOkIX7k1PJboUEfXRGch3XVk4ub4NNDGxps5dZLnqsAEfXahpePRMTaDN0IUg044fdK6/JgviqVyJpNVVyG0n899kAhA62bPyAsIqNLX/sX0fgUhIrOw11OupNf2stNfr5idL/b2baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0rQvutHq8xGa6MrHKTE4Gfkppk+abexSIXGN0/Rsqk=;
 b=heo3h+caGUtEShWL7Ty2Dh+n+PtG1/5bXgu3kiaF6TSezwiyURE8m+3fc3o5rC6/5fpvt0PiYMvcAqUD6M/gM9cnI3UU9eo7ZAkqXZiizQZN2Hqrn2HY7+bJ2AAK8wMpKaByzV6Wvu9kPTKK/XI9fL6jJHnSrcb9s/RXbFeOVxI=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TYZPR03MB6848.apcprd03.prod.outlook.com (2603:1096:400:25a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 05:49:37 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 05:49:37 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Thread-Topic: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Thread-Index: AQHY+z0cVRMPp1EvGkKE/tItjF/i765MYdAAgAE4xoA=
Date:   Thu, 24 Nov 2022 05:49:36 +0000
Message-ID: <1b20f8a9ada72ff619b5010f85a790023e4801ba.camel@mediatek.com>
References: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
         <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
In-Reply-To: <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TYZPR03MB6848:EE_
x-ms-office365-filtering-correlation-id: 88fc885b-f93d-4ff8-2c45-08dacddfabce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLM9aeEl/igiDe/sfgCb56FhHSWUpk/6inMJbk7iwxD4YLw1rlzQ2zI+2B3HhtZ5cKYz0HoP1Wz4AjVwCJwriN0kzfdr/iTIt3nkeGrsLzQI5IEVa96Z1gsylBjfcfwvsFjA1dU0eoRi8kr1n5OhCxQzMOshguwZsXMyeWMEOWjsGWxZV4rtsuvBL14IrAdDQbkPiipUjLWvtN8QpsvcOQQPM3NyUEjH8V/m9LXESFrrfqYqju9xRmuYQmAdU5HowD6u0J+lj7iA6PZSdXwyzSUnF57tSlcOWxcFLBkqMX/2cmUM51Oq9rfVGqrDMNnZMBgnESizYmQzU604Q0JTOolMEjspX/BxxI/Xs6rJKntILar/6B96Ag/R99Bs3g9dWvkkW/rnVYjPxc5AcrEVDRW2BowUfri1/4Z4rKrxIjOk8XosOL/4tyilKtw8zPzormGBVmnzVvNDq40wpvzbv0zq4auoLNnFe4ntZszNijwoLbN2fK9aPVcOvmRszmZJtLtZcviHoUNpUZJuC5Th9x8qLNOkkahpackaGM9+uag+KzuWdxmejwBocZLvfcImfrflPF1gVB35LQrUgEOT+/mXdIWXK+II0znBJ6LsV8t2yyFqAGShqzntnASJdYiqMCAJloCaDO+BWuBDFzRhkVjVzT945H//M6J7NlyNrUCUG+6/nk86+fQuJ/yQ7Mrk9/w1WNlxb6e2vN+ye/riDpWwAph/pfD9mKw0nnCgLQTI6MTl88anBxqhc0+vGSiCZivSfDd6DvlLWgB42XZVuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(38070700005)(36756003)(85182001)(86362001)(71200400001)(6486002)(110136005)(54906003)(6506007)(26005)(6512007)(478600001)(5660300002)(66946007)(8936002)(41300700001)(4326008)(4001150100001)(76116006)(66556008)(66476007)(66446008)(64756008)(91956017)(8676002)(2906002)(316002)(38100700002)(122000001)(186003)(2616005)(83380400001)(66899015)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FFUlFiWlR6ck9xNGovS0g3cElra0tZQjF2SzRFK01GZjZ1TFFlczRGUXZ4?=
 =?utf-8?B?bXBIVXh0M1dMdHdaTUNMYVlXV3ZaNDdaWk5NeFFaVkVkSVA3TlZ1OGp3UWlQ?=
 =?utf-8?B?cTZ2VTZJbk42cEMrZ25PRndwMXk2ZzF5dkxUVFRhZkNWekdlMHBTeXhNQ2d0?=
 =?utf-8?B?V3Z0Zys0T0ZLVE82Ly85dFdxb3QvVVVucUd2K1dGNjNDNm5yenhRVjFKOTlj?=
 =?utf-8?B?T2pvTzRqSzduQ0o1WDl3cWhOMXJFUlRMYUpKVkZWSXR5V3hSQVQvVVRCNWpP?=
 =?utf-8?B?YjdEek5sbFpPMnYrSkVLUytkTkE0dCsrNENXYnYrbkVaK3E2M3VZRm9jQko5?=
 =?utf-8?B?NEZ3K00xK21LRWlqd05RVmdRZ2ZKWmhBcURUaWwwY2VrMGF6VEgyY2d4b3RQ?=
 =?utf-8?B?WXNCRlRuSXY4MFE1ckRoWnBQa1ZHUlFzWHEyNEI2WWtSOG5NSm8vaUxCMzZy?=
 =?utf-8?B?ZTUzaG9ZM0JVSFU5azNKTFZaS2piZVJyWW9OcVh5eFQ4TzM5V2ppdHFCUUxE?=
 =?utf-8?B?eWR6TjZjRnVFbHY5RFc3YUZTdmJhbHBiVHRnTUdWNjl1RDNxRmJwMnVZZlJ2?=
 =?utf-8?B?VU1pK1hReCs2R0hsdU9MbHFKYS8xQ2d4VzlMeHNYNHJtSlFyN3p1YUE1MTRw?=
 =?utf-8?B?MTFoSmNnVDVqWUVHbm5SYnNPSzRpdU5JUVNzcUQzZVkwVS9PTzRrektOc0FQ?=
 =?utf-8?B?amMwZWJ5RjVlWmdwUzFBTGtHMUNJMFdjRTl2cWlnVjVQTkkrQ0orSG1tZkx4?=
 =?utf-8?B?OExaODBENjBOTFZNbHlBdmVOY21tNEZkT1FLY3dvM2pIcXBVNCticUgwTExM?=
 =?utf-8?B?Qy91bFM3RWYyck16WDJnSnljck04SVRXSENQOE5zVDN4VEwwdTM5QzV4azYx?=
 =?utf-8?B?Q3E2bXRXcTVTWnc3TkUwNVNKTjhUeFhjUHlwbjBJVkpEREtMUE0xeTVOTnZY?=
 =?utf-8?B?d1Vsd3ZJT29seHE0QTJIUHFTSjc3SUpvbW5TTk1pU1liK0JHVWVzdG5raTBL?=
 =?utf-8?B?RUQxVEs5RDJ0L0FDcFhWQ1pNTnB6ZmppRkd5amMzNk1GTjlnL0tKMUZpRmta?=
 =?utf-8?B?bHArUHlXT0N5eHpVYjd4dDZsbFlRY3lqUWk5YS9GSDlUKzhHMmU1ang2L0tp?=
 =?utf-8?B?Wlcxa0c3bVJjdFBQN3k0M3VFSitpZkNtQXJML2szVmphRkIvbnNDTm5UTmhm?=
 =?utf-8?B?RTJZc01hUTJhYjRQQjFuNFAzN3cyNDRlL1ZhSHZFcHRYY0Y5NFZKdUZmOU5o?=
 =?utf-8?B?ODh1SVFhVG5pRmhlQWNsUDkvZnpMa2RpekdRSmdZKzhWVlNTamR1bmNwQ1Z2?=
 =?utf-8?B?eGFwUmtZY1JaZlNUZ1Q3SzdhR3RTVjNISmZxOWN3amVrOVQraEdhbFFpZGN6?=
 =?utf-8?B?UUhVY1BoK0RnSmpLaXh6d0V2Wm43dW9ML3lGVzhlMzdHZlJBVk9yWEN1QWxu?=
 =?utf-8?B?NUJaMG5Oa3o2dGxqd2R0WFBKV3RGUEJ6VjQ1L0orSFBHcGJZa05CcWp4N3l4?=
 =?utf-8?B?N1dtVTZnaVRBMkx5V25sRFMyb0s3MnE3ZWlIdmJveFVlZ0RDOHRxdHQzTUMy?=
 =?utf-8?B?aXpQRU5vVWFRVlphYjQ2bVRrVDRCZndsRk5BWFlCbUZvQUxUSGJLZkhPTjA1?=
 =?utf-8?B?OFFpaCtiRmVUTzVscjMxejlhTjlCNndHU2xjR201anZXRmg4OGRhWU1EdUZI?=
 =?utf-8?B?bjJreHErSys3dWlZR0FVcFlQMW95TTluVzY3K2NVMEhVa2V2TVhFZ0IzYXZU?=
 =?utf-8?B?d2tTWFVGOEZGcGNmRGU0dEhKODFabTErWFpiNjZhL3N1SVFvSFhQeHRRN1F5?=
 =?utf-8?B?L3FtSXd0M01iUVNjVGM5VVo5NzBJMUwrRE0wdzQzNVc3aDV6ZytUYWhFTCtt?=
 =?utf-8?B?dmFEYjdUYzN0Z2ZvZFhjSTBHRTNZaHZ3b0VVeDdUanl0QmFtbDdoQStPNS9o?=
 =?utf-8?B?TFN3Z1VmSDNVRDRLVTdIekZnUU9BT0lvb28xWm8zOVRGeWRDK214bU5mUk95?=
 =?utf-8?B?T2R0OGpKd2dhY3k5MXRTZjFXekV3UWZNR0ZmQ24vNk10eVVPaDJpQUl6MFA0?=
 =?utf-8?B?dldMUkJJbkYvTUNCMmdsbVR0ZW42U09QbndOVTl5TUpFZGx0SktxSW9tRHM5?=
 =?utf-8?B?eWNlVFJLcnFqc0FSRUNVbzU2S0lJQ2NmSEJhS0pmSlJ1Sm1aZnRhZnErRDBu?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9665D0ACAC79F54F9ACEB10C50F2DE57@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fc885b-f93d-4ff8-2c45-08dacddfabce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 05:49:36.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhpeHpYvhPOtXWegU1KdGthc5vLg2dOtSZbQIZ9o9DfqgfVlQhOcmLBO87xPv1CLtIyzWKOlNOFbQC6s/Vxl7abxrnnqq03uV1iMSyALqH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6848
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTIzIGF0IDEzOjEwICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAxOC4xMS4yMDIyIDEzLjAxLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gVGhlcmUgaXMg
ZXJyb3IgbG9nIHdoZW4gYWRkIGEgdXNiMyByb290IGh1YiB3aXRob3V0IHBvcnRzOg0KPiA+ICJo
dWIgNC0wOjEuMDogY29uZmlnIGZhaWxlZCwgaHViIGRvZXNuJ3QgaGF2ZSBhbnkgcG9ydHMhIChl
cnIgLTE5KSINCj4gPiANCj4gPiBzbyBvbWl0IHRoZSBzaGFyZWQgaGNkIGlmIGVpdGhlciBvZiB0
aGUgcm9vdCBodWJzIGhhcyBubyBwb3J0cywgYnV0DQo+ID4gdXN1YWxseSB0aGVyZSBpcyBubyB1
c2IzIHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAtLS0tLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktDQo+ID4gbXRrLmMNCj4gPiBpbmRleCAwMTcwNWU1NTljNDIuLmNm
ZjNjNGFlYTAzNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiBAQCAtNDg1LDYgKzQ4
NSw3IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICAgCWNvbnN0IHN0cnVjdCBoY19kcml2ZXIgKmRyaXZlcjsNCj4gPiAg
IAlzdHJ1Y3QgeGhjaV9oY2QgKnhoY2k7DQo+ID4gICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+
ID4gKwlzdHJ1Y3QgdXNiX2hjZCAqdXNiM19oY2Q7DQo+ID4gICAJc3RydWN0IHVzYl9oY2QgKmhj
ZDsNCj4gPiAgIAlpbnQgcmV0ID0gLUVOT0RFVjsNCj4gPiAgIAlpbnQgd2FrZXVwX2lycTsNCj4g
PiBAQCAtNTkzLDYgKzU5NCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0DQo+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgDQo+ID4gICAJeGhjaSA9IGhjZF90b194
aGNpKGhjZCk7DQo+ID4gICAJeGhjaS0+bWFpbl9oY2QgPSBoY2Q7DQo+ID4gKwl4aGNpLT5hbGxv
d19zaW5nbGVfcm9vdGh1YiA9IDE7DQo+ID4gICANCj4gPiAgIAkvKg0KPiA+ICAgCSAqIGltb2Rf
aW50ZXJ2YWwgaXMgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIHZhbHVlIGluDQo+ID4gbmFub3Nl
Y29uZHMuDQo+ID4gQEAgLTYwMiwyNCArNjA0LDI5IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJv
YmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCXhoY2ktPmltb2Rf
aW50ZXJ2YWwgPSA1MDAwOw0KPiA+ICAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJp
bW9kLWludGVydmFsLW5zIiwgJnhoY2ktDQo+ID4gPmltb2RfaW50ZXJ2YWwpOw0KPiA+ICAgDQo+
ID4gLQl4aGNpLT5zaGFyZWRfaGNkID0gdXNiX2NyZWF0ZV9zaGFyZWRfaGNkKGRyaXZlciwgZGV2
LA0KPiA+IC0JCQlkZXZfbmFtZShkZXYpLCBoY2QpOw0KPiA+IC0JaWYgKCF4aGNpLT5zaGFyZWRf
aGNkKSB7DQo+ID4gLQkJcmV0ID0gLUVOT01FTTsNCj4gPiAtCQlnb3RvIGRpc2FibGVfZGV2aWNl
X3dha2V1cDsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gICAJcmV0ID0gdXNiX2FkZF9oY2QoaGNkLCBp
cnEsIElSUUZfU0hBUkVEKTsNCj4gPiAgIAlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gcHV0X3VzYjNf
aGNkOw0KPiA+ICsJCWdvdG8gZGlzYWJsZV9kZXZpY2Vfd2FrZXVwOw0KPiA+ICAgDQo+ID4gLQlp
ZiAoSENDX01BWF9QU0EoeGhjaS0+aGNjX3BhcmFtcykgPj0gNCAmJg0KPiA+ICsJaWYgKCF4aGNp
X2hhc19vbmVfcm9vdGh1Yih4aGNpKSkgew0KPiA+ICsJCXhoY2ktPnNoYXJlZF9oY2QgPSB1c2Jf
Y3JlYXRlX3NoYXJlZF9oY2QoZHJpdmVyLCBkZXYsDQo+ID4gKwkJCQkJCQkgZGV2X25hbWUoZGV2
KSwNCj4gPiBoY2QpOw0KPiA+ICsJCWlmICgheGhjaS0+c2hhcmVkX2hjZCkgew0KPiA+ICsJCQly
ZXQgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIGRlYWxsb2NfdXNiMl9oY2Q7DQo+ID4gKwkJfQ0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXVzYjNfaGNkID0geGhjaV9nZXRfdXNiM19oY2QoeGhjaSk7
DQo+ID4gKwlpZiAodXNiM19oY2QgJiYgSENDX01BWF9QU0EoeGhjaS0+aGNjX3BhcmFtcykgPj0g
NCAmJg0KPiA+ICAgCSAgICAhKHhoY2ktPnF1aXJrcyAmIFhIQ0lfQlJPS0VOX1NUUkVBTVMpKQ0K
PiA+IC0JCXhoY2ktPnNoYXJlZF9oY2QtPmNhbl9kb19zdHJlYW1zID0gMTsNCj4gPiArCQl1c2Iz
X2hjZC0+Y2FuX2RvX3N0cmVhbXMgPSAxOw0KPiA+ICAgDQo+ID4gLQlyZXQgPSB1c2JfYWRkX2hj
ZCh4aGNpLT5zaGFyZWRfaGNkLCBpcnEsIElSUUZfU0hBUkVEKTsNCj4gPiAtCWlmIChyZXQpDQo+
ID4gLQkJZ290byBkZWFsbG9jX3VzYjJfaGNkOw0KPiA+ICsJaWYgKHhoY2ktPnNoYXJlZF9oY2Qp
IHsNCj4gPiArCQlyZXQgPSB1c2JfYWRkX2hjZCh4aGNpLT5zaGFyZWRfaGNkLCBpcnEsIElSUUZf
U0hBUkVEKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlnb3RvIHB1dF91c2IzX2hjZDsNCj4g
PiArCX0NCj4gPiAgIA0KPiA+ICAgCWlmICh3YWtldXBfaXJxID4gMCkgew0KPiA+ICAgCQlyZXQg
PSBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2lycV9yZXZlcnNlKGRldiwNCj4gPiB3YWtldXBf
aXJxKTsNCj4gDQo+IAkNCj4gZGV2X3BtX3NldF9kZWRpY2F0ZWRfd2FrZV9pcnFfcmV2ZXJzZSgp
IGNhbiBiZSBjYWxsZWQgd2l0aCBqdXN0IG9uZQ0KPiBoY2QsIGlmIGl0IGZhaWxzDQo+IGl0IHdp
bGwgZ290byBkZWFsbG9jX3VzYjNfaGNkOg0KPiANCj4gZGVhbGxvY191c2IzX2hjZDoNCj4gCXVz
Yl9yZW1vdmVfaGNkKHhoY2ktPnNoYXJlZF9oY2QpOyAgIC8vIHhoY2ktPnNoYXJlZF9oY2QgbWF5
IGJlDQo+IG51bGwNCj4gCXhoY2ktPnNoYXJlZF9oY2QgPSBOVUxMOyAvLyBjYXVzZXMgdXNiX3B1
dF9oY2QoKSBpc3N1ZXMgaWYNCj4gc2hhcmVkX2hjZCBleGlzdHMNCj4gDQo+IHB1dF91c2IzX2hj
ZDoNCj4gICAgICAgICAgdXNiX3B1dF9oY2QoeGhjaS0+c2hhcmVkX2hjZCk7IC8vIHNoYXJlZF9o
Y2QgbWF5IGJlIHNldCBOVUxMDQo+IGFib3ZlDQoNCkknbGwgY2hlY2sgaXQgYWdhaW4sIHRoYW5r
cw0KDQo+IA0KPiAtTWF0aGlhcw0KPiAgIA0K
