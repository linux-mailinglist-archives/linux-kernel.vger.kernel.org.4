Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E26BDF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCQD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQD3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:29:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7F5FA7B;
        Thu, 16 Mar 2023 20:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679023746; x=1710559746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ryFifEexpZgJHZ3t/2VdLrLampU+fkoG4wL1OaVlWQ4=;
  b=kvCVQj/cwnPKPE5zBAUq1ih89RaiPQPKtVVxWtFUCvpy15F1YLi2jvWp
   cMJJ4LIncRJCHP+gnVoZdjGjwDxU3n7kOvmbgWr8pgV8z9uIjqblp7rFR
   OvWDJO1et5j4XYH+ZN14Q3zDa9GKk4qWo4CEFmaIoeBzyijRcyaYkKBHf
   JTdZtazemv1/ThO1Eeeudb8Y4m05NM58Lr8S968v1nXwzXPExFcxPoVsq
   WR+ki4yTn+eOGyPAsSyBDNB8M3VBdi3kaohogRZ4Ljcldg3MKUfXdCfZ7
   Aq/+TgEhgI8TvnZyD0MyHsb2Xyy/IHNVKd7m2Gy8bx/cIbeBGsjBWKgS4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424442740"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="424442740"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 20:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009483426"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="1009483426"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 20:29:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 20:29:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 20:29:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 20:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjrmKve5dxCo6kYNb2WROPBodPrGMf9cLiHbhAUmqxzHYX4T/Q6TNAgyx5bSlepr6VBlVhn5QE9x8xRvTAtbhLRVvLWHqdObLS1G3htHYSkyY+7dMnmsxEhUVo9aA0vyxbdbWMNPA0vZmfh8VRagjzgg1w4DK7dVYLIN4Y2yabHmRGuAP/w2VKU+dHOAMwRCctab8Qq5zzi7mPWnRWwxmpJLupiyhz5+Ov23zbzXf/3+oU4xvHnWnWtb2hW+63eJRXepoam59qhQmyLjSb1dthOiukIaE3bTJichpxAv6P4+wIz8POUHHq/AWhrW9N2aESqp7BZn/x37TilElEZfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryFifEexpZgJHZ3t/2VdLrLampU+fkoG4wL1OaVlWQ4=;
 b=DNbriR3OhiJMFPUoM4KNeZtrvFnotEnsYGrlUWA1kBkgE7I1TixAVJNb7YRODpp6FOMuX3isgl02krfEeRTOdnme/9y2gNdRUzqLwR2wFZ/ZtFSHforAvLAdcsG36mwY0fgFiS71qiA9BcK6hgCbuC4Qh3Bh4EchLrQLlEspPHfIV/h40jLPk5sTkyKq6I2jgiFoUo+Bh7de4IZyjj70OxVYsuGcLQn97uJ5Z5N49oA+GvCYpCMk6kO59yXStpwp3anTN6U9rzy581GkadC3Ddpv638ZleUFTVNwy7AuUuqKFpM1ynf1g7EzBrB2a+ozvX4cvEp8XpGmVqXtvWxO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Fri, 17 Mar
 2023 03:29:03 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:29:02 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
Thread-Topic: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZVYJ6y9lPL1nBiUy5prGqw8pyma765zaAgADmYLCAABeigIAALuYAgAFQWLCAAAbrgIAAArGAgAAWDwCAANCk8A==
Date:   Fri, 17 Mar 2023 03:29:02 +0000
Message-ID: <IA1PR11MB61715366801048471236AB4289BD9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
 <IA1PR11MB6171C7FEE026F421A3CD6A9689BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YTh18nWTWjLBCRiB2AAH76oD7XrMMMPWZ+9thFSmcPaVg@mail.gmail.com>
In-Reply-To: <CAEXW_YTh18nWTWjLBCRiB2AAH76oD7XrMMMPWZ+9thFSmcPaVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 91fadcc2-7fa0-45e9-a26f-08db2697c149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqsDnHR6Vi/AN4LlH/YCl9ZMPdHLAC2nK5Fg0u7/vyBfcCsXWSEW2gueHxJ0BCGr1YlhbwlOfhspOV2FQojWXCFaPIC0FvAlcRK1M4iWJjXLFs20jjeX9nJSWviOv2pB3vNoYJh4P4ITMohcDP2ba1FBNcrYSTNntoWUqvYXH5tAqR+cs6hCn99xUpv11+KWcPphWjoNDm6quHShHgND2bRYes0U6OoQhlELEFnWa2psrUjKGEwvpmvierdLVskPjUS8TnejkfuxxXlEBABqblIzqnLD8rwRSUXdxicYQAmI/fVm8qp53S29GpyAma8c0O+XiS9a1fBqxr5xio/+JBeA6NO+HF/0Yru+4HvL+a3QBVR/mcMhDI1exFxSPjXKTv8gMsMOTIuRHgLp3675ri3rjNZVJdcda6jHcd1J886f5evtsuLykYaNEtHgINsT00ZzNFXpAARqnVqnoJyylFA80C4uFTWAhB4G6ZSy+LOZgWDMAqZXYdVqtQQzJSm3VaUpcPIHUnELZQ9h0cnFXm81oekRe3bY+sskAvd8sqQNpauEC9LYP8wdB4hge6O9Psq3a8gXvV8DZI1QxScoG1V7xDlkMAdcB84RrzClCh8SH/KWgbpazEUuUfcVOjwE2EiOd8b2eLh41lT4Mcy2CkhGYFok/lNSUG1uog2HDlUn0Va4WpWPESKyU7mmiCwEU9UDnlFt7IdN4fYX3Am2ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199018)(26005)(9686003)(6506007)(186003)(71200400001)(7696005)(66899018)(4326008)(76116006)(64756008)(54906003)(316002)(66476007)(6916009)(478600001)(66446008)(8676002)(66946007)(66556008)(5660300002)(52536014)(8936002)(7416002)(82960400001)(4744005)(41300700001)(38100700002)(2906002)(122000001)(33656002)(86362001)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzNCc2NINkhDZ0hxMGVJOWNWZFIzL0RJcW41OVVwUHdxS3VyenhwMEpqb2tF?=
 =?utf-8?B?Z04xeE44a1BqcURsTk5YYUVBcUs0S0xpK3UvTnM2d0JQR1JUTFp6QlYweGNh?=
 =?utf-8?B?d25jcGo4WGthZlhKZFAwL2JIMU1wOTVXZWVXdE42WVlmeXNvakpncmhVZU1p?=
 =?utf-8?B?d2ZvNGRmNUVEZVpEUFFSMnlvMWdxWWViVTZjMytoLzI3S2JOUHJvYTJEbVMz?=
 =?utf-8?B?OVkyS2xDYzllVERPOXVNTGdRQ0hoeGxUK2NoTjRXaFdyWHoxK01zNFZndkZj?=
 =?utf-8?B?Z1pSelM2R0JqL1JPUlhMVUhWOGgzbE0vb1I4eVIvRUxjM2dHNURQQmZIbFRK?=
 =?utf-8?B?TlBrMTUxYktIYWYrRmw3SmFLMHpvRG4wTzFCa2IxdUgyTzdrb1h5ZTBBYXRQ?=
 =?utf-8?B?bFl1QUVsVkRlbmlWWkF3WkluaTlaSlF6TjJqNWV3M01ZNlNBQXR4WEx3NGZV?=
 =?utf-8?B?MmdnbDhiMTRKU1kzeFZwcWpYdFlQVmRDaFR3cENqOGJmS3FtOE1nTDc2ZkdM?=
 =?utf-8?B?WTNIY0RsUlZSd3QvQ0FGOUNvTUt5Zi81TjcxeVdnUm1WZnlTZEdBZzVBdmpS?=
 =?utf-8?B?VjJFVXFBZXVzS3dBZExCM3ZpTG1YenZabVNjZk5xQkpic0h5L0dhdVQ5bFBq?=
 =?utf-8?B?Y3BEYXE5Wnhnb1l5VU93VU5Cb3M3Sis3MHk4NGpEMytoRmFyQ1JxSmRUb3Vm?=
 =?utf-8?B?eEJuWGVDcU04QXdCSVp2Y1YwV0Zqb2VtYS9NWDNFVkdSak1PeDRhUytjL2Ja?=
 =?utf-8?B?L25xUExBb21lM2hZOVpsVndkSndtYmFOT2tXUzVZN3RnUjBTc0NSc0o0UWh4?=
 =?utf-8?B?UTV2U25QTWhVWVRlaVhQcjJGTE1IcHZyOXM4SHVRUFRHcUo0MDJmWnRza2VC?=
 =?utf-8?B?VVMzOUs3OGY2Qk1QME41VXk1bnVmZkRzNkUxbGg0YXVybDZsK2I1a05rZitZ?=
 =?utf-8?B?NnJWV3lIYkRpYkJNaFBkWVVQUjZ5VFhobEhObHh5Vmg0QnE0TkVLRzRWQkhT?=
 =?utf-8?B?U3dQN2paR0lRL3RkSGRQRlhNQUJMc3NiL2N5bS9RUXhxNzlMNSsyVXF5cTgz?=
 =?utf-8?B?WFArc3hhRzZyL0hNVlVPUHBJdEhDR1BKSDFMa2cyQnQzVG13azVUZVJrSzh0?=
 =?utf-8?B?bVVuZEVrNUp5OWI1L3ZZeGVDY0ZJR09GenJTUHJ1QkxBZ1BwTG82aEpQbi80?=
 =?utf-8?B?S3VjNHU1VXA3YU5qd244T3gyRS9Qb3JaWEdJZFJuY3dMaU1ocFdkZXpWMTR0?=
 =?utf-8?B?QjUrcmQwTWlaU0lNeFJ5Z1hvaHNFZzM5a2JsS01UcmkwODFNVzZZUnZBcWJh?=
 =?utf-8?B?cXNkblRwR05vNzFuUVA1bVQvMWUrR0tTOFBMWGN5VUIrNmlKZDROUmFaTDBC?=
 =?utf-8?B?eTlWaWxla09BN1B5dUVoRUp4R1o4WkhlZnJqUjRMMkNwNVZFWFRkNjBGVUN3?=
 =?utf-8?B?WDAvVjdGMlhsMTBrdEhxRzBLbWtDN3BCNVJjanpDc2htNlMvNmxxUEZOUHV2?=
 =?utf-8?B?QXk3SGxCOWFuU0VDUEFZYStjRVg0QWVMYkQ2Z1g0RDI1c1g3L1M1dmsybDE4?=
 =?utf-8?B?MTlmRDAzQXYxWGpRNy95UjBNSzNwMU44WW5OdEEwcW5YQW5WZk9uMC8rMWZG?=
 =?utf-8?B?b0RuU1RnelM0RU9pMzIvWjBiSTRQQWZBQ3paS1VoWGgwTFVKV3dyWmZtd25w?=
 =?utf-8?B?QVpSM0JiWi8zWFpyaEFGQkYyanhUMnZQSU1qNkdxT3l5alF1SnkydWFFSzRG?=
 =?utf-8?B?Q1NkVGFUeTVtQmxkMVBHd2JVNmo4UEFMM1Y4VGhkU2g1RGdZcEVTNHZQTUFo?=
 =?utf-8?B?R1dodDE4V3ZUbzdvVU9Rd21QZEhjL0N6cDlEc3Q5bDQzU0pqWVJ2SnB1ZmYv?=
 =?utf-8?B?MlZVMk8yZlFjYzIvaXZud3NlTkFFbVY1Tzg5Wm1Gb0psbjdjWlQzNlNQUGRF?=
 =?utf-8?B?M0tHV1YwS2JVb0FZYmNSOXd2T3QvWDhLbENOQm9zZk4weWhDSzJ4Q0UwdmJh?=
 =?utf-8?B?NXprb0ZsQU55dmRHZWxwOGUxYVlkLzlsVU05RitjdkRoczhGUlNkN1BpSkd2?=
 =?utf-8?B?Qkd4L0VsdDhocmN5WEFmakNVU1pJaGlrK1duUFpoTFF0TCtxT1Vqc3B4eGhX?=
 =?utf-8?Q?xIrsiNypuFU0EQbJJ8buZbinK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fadcc2-7fa0-45e9-a26f-08db2697c149
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 03:29:02.7334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FAVbgN5J1tpSM9P6mItKKnb7GNvlIZ8b3JlHug683ZcS8GkX3JF43+LzHymK4cWe6kZFndoZaM4GREq0OFGJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gWy4uLl0N
Cj4gPiBJJ20gT0sgd2l0aCBjcmVhdGluZyBhIG5ldyBrZXJuZWwgbW9kdWxlIGZvciB0aGVzZSBr
ZnJlZSBzdHVmZnMsIGJ1dA0KPiA+IGRvIHdlIHJlYWxseSBuZWVkIHRvIGRvIHRoYXQ/DQo+IA0K
PiBJZiBpdCB3ZXJlIG1lIGRvaW5nIHRoaXMsIEkgd291bGQgdHJ5IHRvIHNwbGl0IGl0IGp1c3Qg
YmVjYXVzZSBpbiB0aGUgbG9uZyB0ZXJtIEkNCj4gbWF5IGhhdmUgdG8gbWFpbnRhaW4gb3IgZGVh
bCB3aXRoIGl0Lg0KPiANCj4gSSB3YXMgYWxzbyB0aGlua2luZyBhIG5ldyBzY2FsZSBkaXJlY3Rv
cnkgX21heV8gbWFrZSBzZW5zZSBmb3IgcGVyZm9ybWFuY2UNCj4gdGVzdHMuDQo+IA0KPiBrZXJu
ZWwvcmN1L3NjYWxldGVzdHMva2ZyZWUuYw0KPiBrZXJuZWwvcmN1L3NjYWxldGVzdHMvY29yZS5j
DQo+IGtlcm5lbC9yY3Uvc2NhbGV0ZXN0cy9yZWYuYw0KDQpUaGlzIGxvb2tzIGxpa2UgcmVhbGx5
IGEgZ29vZCBjb25zdHJ1Y3RpdmUgc3VnZ2VzdGlvbi4NCkJ1dCB0b2RheSwgcGxlYXNlIGdpdmUg
bWUgYSBicmVhay4gOy0pLg0KDQpUaGFua3MhDQotUWl1eHUNCg0KPiBPciBzb21ldGhpbmcgbGlr
ZSB0aGF0Lg0KPiANCj4gYW5kIHRoZW4gbWF5YmUgcHV0dCBjb21tb24gY29kZSBpbnRvOiBrZXJu
ZWwvcmN1L3NjYWxldGVzdHMvY29tbW9uLmMNCg0K
