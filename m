Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FC61771A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKCHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:04:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4BAE6B;
        Thu,  3 Nov 2022 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667459098; x=1698995098;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bsB/JPexMFCej2Jr0IK6VHWS3MOO0j9a/3BGtvmo9Gs=;
  b=PldWuF0R86cVBvUkCwZZF15LyWxPuXomFzmDp5aqhgLChN/WVw2ydLl6
   48VenSCDO9jAHppMPxcewoNO+AqFYcTvhBv7zQpwB28Gq31RtZVLUPpri
   VWdVZCOkkR8QtleE0VhPdVUiT4C32ikP+XnBLYUqYY6UokEgFYIGbDvZt
   38HNxnytPtuG/UeLUyURR1JjkFvnPtYQZfYgdGuZ7EJ2F5LmibXWn/Ogd
   T8PuOs9OC+vtCWTqCaFa4mniJB7TDYQXTUHK2wqV5hzfA3ua+9mPsaVWq
   H1DyD/dX4Fx8LUHYomKLHKU0cVv+vdp6SFNqJSfWWNOi0cDTnJClbweGF
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="215722583"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 15:04:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw78fGhp6deq0e/EC360xbkrSCG6Al7l26Fs1CD5b3KwHy/uBMD0zK6ZyqGegQqjI7ogJuhoda+HxzeG5GdbBwhN/uwnifj+JVxXa4abzz1eARdk5MziYvK1eoPpRlXm6ZHrwVpS6a36BsFuWHvgDz87Qz7H/05831XtSUPbtNPgduuRXNYlq12oGCpS8fK4qp9axrYzfgE8kTsbjBh4nlkLLS51z5fg7EPl+WjsnpUwzGDMc2L6/bB4iGhFmRpXynsrX6+CEd6wBOQqgSG4+hFuApNRCdm5KbyYHU9DwQsD1GvQSK1KKGwLUtcqE32U3Z5BZGh4R9oTE8hEjIsQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsB/JPexMFCej2Jr0IK6VHWS3MOO0j9a/3BGtvmo9Gs=;
 b=nh2zFeh3prVM/0I/WA9ghlJn1RHjSFCDRmAEykRARz19iLK54beaqEDhn9SDUfm4eqZHVZR7aZSwcEzShjSJm3bRzEWr+bJf7OFVKmhk/r49olaeHkjU+cUSQ6M36Znf5+lVD0VDrlXqAHl4Df08LHfW5euhOHv7GQnMqbHIa05X28N8hUQ6SZMKj9k/HSB1AH/sj6urLIuJWPrgcG9R64pjPnUVZ9BjgNyPMeYWiYYi6lh4yXPbGsh2frpcSu+8VYDHBwPXflv8R04F7CQWIn+ZcaoyneEAqxKnXgfCf3pEpk5EDjc1OQEZz5aL9x4m6xpuq5814Foj/zSYWjRh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsB/JPexMFCej2Jr0IK6VHWS3MOO0j9a/3BGtvmo9Gs=;
 b=vXgKeiRQQWFNomMz0RNyAh5Gm46lOPeALS+DzvXsk0RZUbrmCKviarTxOA+CqfTQ11utxJ+ZHypEmkjiGG3LcFMuSnXi9sTQHjkn68Gr5tmOiqHIemVfhGa11r3eL3nbzGQGOoTnwWWg2VCsUpJcDPZRsJXE7W317tCxd7gOQ6g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR04MB3757.namprd04.prod.outlook.com (2603:10b6:300:f8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Thu, 3 Nov 2022 07:04:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 07:04:39 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "draviv@codeaurora.org" <draviv@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Remove check_upiu_size() from ufshcd.h
Thread-Topic: [PATCH] scsi: ufs: Remove check_upiu_size() from ufshcd.h
Thread-Index: AQHY70iyVGVmoWL6BkyAgU5GWxrDoq4sxf/Q
Date:   Thu, 3 Nov 2022 07:04:39 +0000
Message-ID: <DM6PR04MB6575B13D4DE238F0B6721FA7FC389@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
 <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
In-Reply-To: <20221103055349epcms2p338f2550c2dd78d00231a83b24719a3d4@epcms2p3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MWHPR04MB3757:EE_
x-ms-office365-filtering-correlation-id: 7924c0cf-a90f-4f59-fdc0-08dabd69ad01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqjir/L+qlVmIIqV/tv+E/QWJ/lm9RpybPRPfRkPpQkIxcxsfCMj1jGA39QW0Rrx4q45VSK2n6nOTXKljSH8sXxtp1i13fsKTgHuluwDHAEFSuwc/ZT7yZ4NLPUVHIVcBO9I73t0yoYcxcG3xDC73s2Q5L2wx38DFXHkGQLH07NORQ+RlkfocKgHthjebKo4OVAlf/FG6XLgSb0YTn6SwLiZyCQKuih0MMw+NLJW4+jedstZJAk7HVArJjX5ULUJ77lajjxBw9EeQi79/Rk3V0NTduPBDavX2odtxKTxhXb8sJ/LSSTejgrLjXs+JjYwQJbBlpvbWJLzCckLMMEFMXIA1yVpwjK1JhFXwceC4IcvWdWLRzgMZZ4Nawlqt6BWgbJSBNAJ8brjZuu0PH4NqSzisSBB7Vr/i/V+oUCWgscP1bGKI2+o5Ph86T9p5KwNwTrJXatkXnpE6QKLzxvq3ntcfvdB23Jk+P8nYVj58/JZdP6+v7zIB30SecgcO81FNXKwebHI3R7ZGrnXlk3CJCKdmIGp/J1bnuUbFUB+fgJp55hdh2yrNLMDokLAn7qvBgxROox3qq1tVzZfpf5KLm5uJIQhnThj98BbevOR4PYR7V2kymdqBDe/UeL17pnYrAK8+gKPK3Lo8Plgy8IEREt0ZdAmb6ks3hAhk1hPNwvgsYbAcqLGsKLEmFxTqABXbVHQ6aTOzAbA9QMH42zZv40HGACldIawl9OClbhBNUjakaMD2S/uSzUteUWrhuWVj4QPSYgLjPxjJyFY8TedCfqaonnmvD+r6LjVcQOZo9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(64756008)(66446008)(66476007)(66946007)(66556008)(71200400001)(8676002)(2906002)(76116006)(83380400001)(55016003)(316002)(38070700005)(86362001)(110136005)(6506007)(122000001)(7696005)(921005)(33656002)(82960400001)(38100700002)(4744005)(5660300002)(41300700001)(7416002)(8936002)(26005)(478600001)(9686003)(52536014)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFpURis1VEdTVXBzdGd6c3MrbzNkcGNvUHBZRnhpcWFCNldHcDBoU3Flb0d0?=
 =?utf-8?B?aUdHRzJ3cjVFd2gxSHIzV0ZiaGZBYUtRZ0NVYnpuc2ZUNHlzRHdPMkxvcXoz?=
 =?utf-8?B?d1FmaDBjb0hJWFdzdmpEZlkzcmYrcFRUclF2M2pYb0syTE9ZZ0dYRDRVazh4?=
 =?utf-8?B?Z0V5Zmd6UlAwOEFqTTNrWVJCRHZ1Ti9yY0Z0LzRrMXhxYmYyZldXU0pOWDNX?=
 =?utf-8?B?NW1uVHkzeFZhOFF2RzNSQkpjYkI3NUJaTTNMTDRjcXhzY3ZjN0hWSzN6SHVt?=
 =?utf-8?B?YjhBd0ZEUGpLSUdSR2JvaTFuMUV5Lzc4MEtDYVRvL0VkSU9Kd0l1T1RpTUZm?=
 =?utf-8?B?bmwrTmRac0ZYMmlITHVTMHJPMUF1bHd6NjE3dzE1ejcrdnlsTHc1cndPZXpK?=
 =?utf-8?B?UzZCMllMa0dDMDJYR3dEUThMV1grZnlKa1dGOWlUZlNlQ1owT3NXYmJJR3JD?=
 =?utf-8?B?b2ZDYU5tL0ZzaE9lV1hqZVdyZERuRE9Nc2JrMnF6eGJEMXZ3V1JPZUY2OWFZ?=
 =?utf-8?B?R1lGdXViMDc5Yjk2TXU1SktFMEFiaHQ4Z3d5WDFUWU5PQlozSDNLVnRPcFUv?=
 =?utf-8?B?c2lZaUFCMkptVEtLbEw1WWJrWVZnVllJaWkwbXVSTXcvZnJKWVRzVTVLUEdt?=
 =?utf-8?B?TDdyRzVIajZsbHhPOWs5eWRDTVpPZmRWa2ZVcVJDeHJJU2d5ZmI3ckJBWTdY?=
 =?utf-8?B?ZFNVSWRYMGkvN1BCc3dMak9veEdCTFdvU0dELzBKa0hvT2F2K29IQStFclk3?=
 =?utf-8?B?VUFwakpVYWZhQ2NGdGJEcm5Kd3VHaUJvNVA4U1RtdXByck15T29lRXRuek1l?=
 =?utf-8?B?MVcvZ2VzMHpPdE1yZUNMNk5MZjZMNEFjRWhmYWhWdjhXbWhGQVJ0RFNJdTA0?=
 =?utf-8?B?WUVCU0dTcDJBdmY3NVR3aU1jN3dNcmFGSEsvTHI0VE9VZWtYZjNhRmNPVDlW?=
 =?utf-8?B?UkY0TE1hWWMxb242cTliaEtmUlhoN3NhNlQwZ1gzQ011UHBKLzVQN1piQTNK?=
 =?utf-8?B?RGp6OUY0eDdRWFR2VGEyS2JtT0hyZVJlK2ZYblo4TWprYUJ1SmR3V0lrMTU1?=
 =?utf-8?B?eFNVRllHY3NDK2lySjl5U0tPd3JFRGFyOHg3QTNpVXkxaFJHR2I3YVhUZlpY?=
 =?utf-8?B?aTRydFJQTnRBRk9EeHZMbzBhQllEOHlzQVNKVVhRaW16YzMrY3A2OXZhcFE1?=
 =?utf-8?B?YjBUTEE5L1hTVzNXY3UwZVhKWUZ2R2xjTVhhNTJWSWV6VEc3OGhLYURqLzQv?=
 =?utf-8?B?bE9ZVjZhbFIrcUdYQnYveVV5TUFleUh1TERHUy81ZEV3QStEVGZZeGdaZ1lz?=
 =?utf-8?B?cXBqUDQzR3RLL25GcVZGNExRNWh4RDZBWWd6Q3NTcVVuMXlRSnpLMnkvN2c4?=
 =?utf-8?B?QmxGcENKKzU5Y1YvU05GNEV6OEozMy93ZkovUXNBYnJBTU1BNzhMbE4zSlRI?=
 =?utf-8?B?MjZnZWJKVGdsK0JpTW16NUYySTV2SXp6bHJFWU1UNVIxOFJvM2lOUjlnV3RX?=
 =?utf-8?B?TFBNOVhIZGlReFM1Z1VtRXpjaS9CN1g2dERrTFoxYUJ1UExTQjkwdFFxaDFi?=
 =?utf-8?B?N1lVSzRzRkcrcUIwZ2NqZzhUWFJGUlR0Z3pBM3ZoM0JGY0FiVVJOaGpoUEFp?=
 =?utf-8?B?OE9STTFhems2TXRFaG1YYk1nMXdCbjZhVkFzZG9lb2gyVEJWUFp3ZzBKSDFO?=
 =?utf-8?B?U2ZTNEtmdDBDalk1UEp3T3M0UERNKzR1bjlVRzZPclk4V1o1QWdvdzVCU3dM?=
 =?utf-8?B?Nk9nR1VsKzcvOFQ4aFpRdVhSUjFBb2E2dGMwMjFaZ2hmL1NsK3dDQkRQM3JP?=
 =?utf-8?B?cnJHeUFsWFEzQmtQbzQ2SGEweXRZUUJ4cmxac3pYZHlBUjVGNnlzNjJrNlhm?=
 =?utf-8?B?Ky8rYmxFUHFpT1BOKzBBLzV1MDVNMHpmd1NoOTAvVUx5eHVGWWlGdVBIbjQ3?=
 =?utf-8?B?NFp3NFVrQ05lY3ZaWXZ3V1Q0a0QxOTNOQ0pZM29PRGd6SDVhYUtGOTJ0ZnNB?=
 =?utf-8?B?VzFZUjJGVDg1UkpmL1FoQTMvUFhKSkVXelRlcXBLVUhCelFRcllqcHRLcGxh?=
 =?utf-8?B?bEF1ZndZL2NsVE8xNE56cWp6bWFleTdUNEdyem9GdjhpVDVvOVpTd3lRUXBi?=
 =?utf-8?Q?wwtvDB3+trltJk589DfhcRasV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7924c0cf-a90f-4f59-fdc0-08dabd69ad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:04:39.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+0LNpXCMduvFTHNUFKcAOA0Ji42vz4tBNSGmqMhhLeT0s5GZgUyuBBhel+zEFZSfpczKHmJYkdQjpjPti0y8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3757
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDb21taXQgNjgwNzhkNWNjMWE1ICgiW1NDU0ldIHVmczogU2V0IGZEZXZpY2VJbml0IGZsYWcg
dG8gaW5pdGlhdGUgZGV2aWNlDQo+IGluaXRpYWxpemF0aW9uIikgYWRkZWQgY2hlY2tfdXBpdV9z
aXplKCksIGJ1dCBubyBjYWxsZXIuDQpOb3IgdGhlcmUgZXZlciB3YXMuDQoNCj4gDQo+IENjOiBE
b2xldiBSYXZpdiA8ZHJhdml2QGNvZGVhdXJvcmEub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZW9z
ZW9uZyBQYXJrIDxrZW9zdW5nLnBhcmtAc2Ftc3VuZy5jb20+DQpSZXZpZXdlZC1ieTogQXZyaSBB
bHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQoNCj4gLS0tDQo+ICBpbmNsdWRlL3Vmcy91ZnNo
Y2QuaCB8IDYgLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vmcy91ZnNoY2QuaCBiL2luY2x1ZGUvdWZzL3Vmc2hjZC5o
IGluZGV4DQo+IDk2NTM4ZWIzYTZjMC4uNWNmODFkZmY2MGFhIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL3Vmcy91ZnNoY2QuaA0KPiArKysgYi9pbmNsdWRlL3Vmcy91ZnNoY2QuaA0KPiBAQCAtMTA3
MiwxMiArMTA3Miw2IEBAIHZvaWQgdWZzaGNkX3VwZGF0ZV9ldnRfaGlzdChzdHJ1Y3QgdWZzX2hi
YSAqaGJhLA0KPiB1MzIgaWQsIHUzMiB2YWwpOyAgdm9pZCB1ZnNoY2RfaGJhX3N0b3Aoc3RydWN0
IHVmc19oYmEgKmhiYSk7ICB2b2lkDQo+IHVmc2hjZF9zY2hlZHVsZV9laF93b3JrKHN0cnVjdCB1
ZnNfaGJhICpoYmEpOw0KPiANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja191cGl1X3NpemUo
dm9pZCkgLXsNCj4gLSAgICAgICBCVUlMRF9CVUdfT04oQUxJR05FRF9VUElVX1NJWkUgPA0KPiAt
ICAgICAgICAgICAgICAgR0VORVJBTF9VUElVX1JFUVVFU1RfU0laRSArIFFVRVJZX0RFU0NfTUFY
X1NJWkUpOw0KPiAtfQ0KPiAtDQo+ICAvKioNCj4gICAqIHVmc2hjZF9zZXRfdmFyaWFudCAtIHNl
dCB2YXJpYW50IHNwZWNpZmljIGRhdGEgdG8gdGhlIGhiYQ0KPiAgICogQGhiYTogcGVyIGFkYXB0
ZXIgaW5zdGFuY2UNCj4gLS0NCj4gMi4xNy4xDQoNCg==
