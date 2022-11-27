Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F986399D6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 10:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiK0Jsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 04:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiK0Jse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 04:48:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A3A1B2;
        Sun, 27 Nov 2022 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669542510; x=1701078510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e8djLnXVtrXppI9FJTDx/sQtmYiZKFtKJuUSw0ObFXA=;
  b=fl+EA1g9Q+lHRGoG3tCgFsy1O4BfqW867orJIyXEww7c8dO6R7gwLs1M
   Rhv9ySHWciC0w5OdJPqyiEj/Gya9Bp+xtQFeKxKdTeOpJUnQ4suU2w9n2
   amNcRIRjM/1xWN4+N3wkO89XrtS9jMwy5bvXYLsejoYFTM2gNA8LfYld2
   Sl/imGvimw9nfUgUWvrl+q3OV9RQao7rFwQac/gCRLMrp/ves/mSTE+m0
   JqDQuxpCEiyf01FR1nw8TIxPODTABByR0LVtw2KhxxvlZ8mrTsLJlbllh
   PqnnXJ39+rPmbOebxqw6o3yno89+JZGipubQTnJCYZ+cjqa2nkUKGM9zj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="302232995"
X-IronPort-AV: E=Sophos;i="5.96,198,1665471600"; 
   d="scan'208";a="302232995"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 01:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="643079773"
X-IronPort-AV: E=Sophos;i="5.96,198,1665471600"; 
   d="scan'208";a="643079773"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2022 01:48:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 01:48:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 01:48:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 01:48:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6beqPcci9TeN+G3HB1zJBx6lsuzrYrcUO/zv/hNVa/irQMV8hmXbNPmaOG6JPWk79vXDp4oM2tX7K+4tqz+pTEzShvT86BgPRvaSvyI8sjRAFLEhxv1SL/E05WKzMltRGFIEFMEn8APKPq9sGMhU7O8zZQR9s8YYplBhQnlok/2ZMod7IVl4+gINNaVQbEyWfBbcKkTkbL9hlNehbAChBZu9GVENdocFMmSEOJXW0KdAo4XSai4YSqLr9Nix9rBtpJUzf9E5yZycC9VybBawfrIxTcP2OoNhLHQXvf6/JJrFI7tKAzewRZhYuSZj3RlBinMB8G64Jq/uDnQycuYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8djLnXVtrXppI9FJTDx/sQtmYiZKFtKJuUSw0ObFXA=;
 b=AJBbWk3I341EOAKsjcybDkjnNIDwrfk6AU3PBREVoL2AG6oK/02O8xuAKpN4KXZFlbX/f05udrCMmYaA/C26MYCUFsaDAj5bV85dS8icZyA3/TkvvWuFKtUpBV5sOfuIdVjb0cZ8HfHRlqBQZSKHBFP0XIugjhfzuZaH1eL7uzmbs1CTEE06WxS1UzLkeIfhQe275WyoovTl01ywyG7rLx9z2aaoGSCOSZHY+0GTOKRe6XBWbci+IAm1jl5W/bWsHdjJ4EDdQPwzF2NCLFofigsGYFIJ6L50dzdA5QMvQstO3iySJZZ/jibv04uy0gha5Fy9tQHOVcq9gPnhlTLqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5532.namprd11.prod.outlook.com (2603:10b6:408:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 09:48:14 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Sun, 27 Nov 2022
 09:48:14 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Thread-Topic: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAOVqO+x1XL1ptUSqdc8Q343Nzq5Qq6MAgAABXYCAAJv0gIABPxww
Date:   Sun, 27 Nov 2022 09:48:14 +0000
Message-ID: <PH0PR11MB58808A0169E7318EF248443ADA109@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB58804E24C3C14371F4397D68DA119@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CE3515A9-2226-4001-BEDA-9DD6CB2ACF09@joelfernandes.org>
In-Reply-To: <CE3515A9-2226-4001-BEDA-9DD6CB2ACF09@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5532:EE_
x-ms-office365-filtering-correlation-id: 2a47f910-d408-4322-1899-08dad05c811b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yrnEZ4xH9ub65v+pKbhKPT3tME2dzgG4N3hZ7HZC+fgqfzQXxs0vYqyroG2UPbh/mRLtNYYPdmdPd1AtSAVT0G9QeX2NUBjHwxoG9bbuv2fJE0uOPkSJMrnY03+QT+FW+E2vIwdUgcEs4Ov5+WjwZgxpVQavS3cVOohM+ODA6xza/5q0cyBsZfUrxPPJsRSPbbB6clANwOcrv1DeQksBlEKpSIFG0iYpF5CrtebuuvZcYHW6Z4L8MochiOuDMW8NvPPKkaz9xOBVjTJ8qBbwxa/EgiCPXMH7/NhuDpa1ad1R6OIdMAxOeVTroAsiXZpJ62jDplMdZBC5xgPB+5HYuLqRcr+ZButjccTuFNYZSGjvKm+SsZ8GLw0AV1jQ9AnV8hiAcb4+Xa1rJvkUy+pokXUeilCwG9f0LUVpFHeQtXHn3uGdBEnji5Vq40l9ox5DlgEukUF18KDF3RtVarUWRArsJbaoypoDUxX4fSC/1RzXYuAcf0TUr63aHOV703IbzGzl97+FM5Mz5xdWPIQMnWe5Z56RXfkBs/YvXASvIRcHUxQ5MTEbnGSVA+PEmvpyWP6zSXhEHf7zB6t2Bm0Vku5XvOgzMB24o66NuljBJz47RiTe5tn4oI9tFD5rzNQV+UQtPeQzMoZNrBMIlW2lTSCpYco57LHfapzjXF/cQZtOpBPdI5fMT7p3DBo4KUbMKWPIAiio14H6kf1yX1Vgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(316002)(478600001)(76116006)(66946007)(2906002)(33656002)(54906003)(6916009)(71200400001)(83380400001)(122000001)(82960400001)(38100700002)(55016003)(53546011)(26005)(6506007)(7696005)(86362001)(9686003)(38070700005)(186003)(8936002)(41300700001)(52536014)(5660300002)(4326008)(64756008)(66476007)(66556008)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXFkUElhT2V1Vzd2YjBjd251OTlHN293UEtxRWw4Y202cklyaTJuVlRDaGR5?=
 =?utf-8?B?dTQxR3cyVUF5SW5LS3BpSTVDOHJnR1BTbGhZTVVuNFRtblY4S0NiN0Y3Nldr?=
 =?utf-8?B?NmIybFJqSXlFSlZNejZMS2M5SGdkSk8rQjlGN29GdndVYlRYcHhCRktxM2tT?=
 =?utf-8?B?MVI4WGRlSWxHUC8rcThEMVQvbXY1cUo1UksvTXUxYnFuc3U4YjBVSFQ5bjMw?=
 =?utf-8?B?Vlg1djBkYkVvNnBhbndBUDhEVEdvOU9tYkE4RTRtenJlMENoa09BT3NyQnpo?=
 =?utf-8?B?Mmp4ZUNianMwQW91eWlUZ1dSVlJwZlZ2M3dZcWRQL21zVjNKdys4aEMvSGcz?=
 =?utf-8?B?Zi95YXFzS0thNGRMNGhsVUxoK0ZxL0d2OVQ4U2hsem1LeTRiK1Jqanh2VTVL?=
 =?utf-8?B?ZEdnSUtqck9hMFgxSm0xRy9jK2pnUGJiSXcwMW9LVjVsQTh2YStyclgySjk2?=
 =?utf-8?B?SXJ0c29UUnlpVE1qd3ZadUkwcE1pVzdVS3NZMjU0UlpTZHcvS2xjR2Jqd0Z4?=
 =?utf-8?B?U0xFTi8rS3c5cGNRZlFIY0toYkJuWVpicTU2ODVtMHpIRzVxd2dqb0lRbHBa?=
 =?utf-8?B?TVFJekJOSWRIQ2JxSHRuODVHTnR1VkxUQWYwa3JHY1FnaXJQalFUczl5bDFx?=
 =?utf-8?B?VHFPTm84NjdLNVlFWkllcFUwSTEwZTgrdkxSY29FWnZEdnBIUkdtbDNFZDRx?=
 =?utf-8?B?NzhhaTZROGdCRnd1eTBkZkU1OXRtcTB2c3YycjdvYWs0ZzQ5QkJzRkxOaTkz?=
 =?utf-8?B?SXFBSmV5T0g0Q0dZbzV4ZDNNdUVBMExPb0JDZGdWRW8zRmZZTUIvbGFqRWRD?=
 =?utf-8?B?U0FpZzFtWXFaL08zVTlJbnBZTlJxTFV0NkVFQnpBd0ZjeENZa3FwbWFud1l3?=
 =?utf-8?B?RzBzamwzejNMS2ZMTEw4cklVdUpZc1plckJzQktRbk1udlFvZGRQS3hsMUdO?=
 =?utf-8?B?U2RSQU5SWVRaaXpZbnk3UjVibDVBNWdHV2xia1VNb25sNXdFbEVmcGZGM04z?=
 =?utf-8?B?UDFKRDg2OFJ3cTA1QUxpNTQzRm1XUGhrS1NKalJwUGt3TkVQOGQvUWhSUmFr?=
 =?utf-8?B?aHJXUkR6d0RzM1JUZDFZRnU0aUVXMzlNM2p5bDFrbGVyZUFXazFUaWhEK1R5?=
 =?utf-8?B?ZExMRVZpbGNEVWMxWHkvbXJOamI4bVBrZzRER2xpd08zUk44Q2lmbStWTi9r?=
 =?utf-8?B?eUx4MDZ2Q1VhOUdXYnRzVGdEV1luckh1NEpEKy9VZEh4RUIvTVJ2dEJWWEho?=
 =?utf-8?B?U0w3WXRkRHVObVYzaU1vc2pUMEl4QnN5eDBycVJJZVlRc1FudVZIVk05WEt2?=
 =?utf-8?B?dDhEa0wwdzNwVHBZQ1lTcDc4Z3Q1c3l5OFF2b0dIdThHcFdDRW92WmlzRkxR?=
 =?utf-8?B?UjZBemhQaFlNbHpMVDZ3RFJPOUVEVGN0YVlOd3ovK2RvMHRqODJWaFgyc0Fa?=
 =?utf-8?B?SWcyQVRMU0RvOTRESHlicWlncXY1S2YwVWpSMWxSWmdCWW90OTZYWHAwak9F?=
 =?utf-8?B?Vys0eDJ6THVhbHRSNVJ0RTR0WmNEbjhoWDBJRHFodEVuRnp3aVYvdFBibXV0?=
 =?utf-8?B?NHZOVlRvZE9LdkFOdWtJd0dtejJMNnVCV3dnZG1WS0hEdHZrdFlicVNCT2Z6?=
 =?utf-8?B?cEVzbW93Vml3ZmhZbllWakhHS05IeVYyREoxcFNOeW9VaXdpNGVNZUx3WE1t?=
 =?utf-8?B?bTZ6ZDNkNEpTNDlrVy9Xa2tjRk5pNXh4RzRMV2owaTBJYWp0cUQzUzJBVWVx?=
 =?utf-8?B?MFIrYjZGYmFuU25XWHlySTBrbkFDcmhBV2diQS9JZzFYVW5Vb2t4dW83UStX?=
 =?utf-8?B?aHdXNFl5TnEydGlmam1qZG0ydXJNZVNUTzVoTEpPeUpsV2x3T1RpdWVOVUF5?=
 =?utf-8?B?Q3BYaWZBby9XZnlVSUx1cVg5OXFtTkU2WnV4QUI2Z0VRTWY5RitvaDZ1NC81?=
 =?utf-8?B?Q3l0TFNOcmdFbzlmUFM3c3cvdkZ5ZmdWUlNWSms5ZDJDdW1nTVNuOGVmRVV1?=
 =?utf-8?B?SHBBNUJ1SzF2bmtqMlg5ekx6T1YrZndZNUhXaTBCWWk4bUp1VU1uQ1FBNGJX?=
 =?utf-8?B?dU5QZFFodFdtblZqcXRra2RjeXlWSnhud1JEWlhHdGJvYU1TY2doS0VENlJO?=
 =?utf-8?Q?BJeYNg1JAROgrHgZr25DMPtif?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a47f910-d408-4322-1899-08dad05c811b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2022 09:48:14.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umuI5QJn5aT94oBeesfP6I/bO/jvAwmUc+tC7RcfBnwGQQfCoPBhuh4xeiqhPsC/YOpUQRLPqjF/zMbs8nuSZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE5vdiAyNiwgMjAyMiwgYXQgMTI6NTIgQU0sIFpoYW5nLCBRaWFuZzEgPHFpYW5nMS56
aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiANCj4+IEhpIFpxaWFuZywNCj4+
IA0KPj4gT24gMTEvMjUvMjAyMiA5OjI0IFBNLCBacWlhbmcgd3JvdGU6DQo+PiBDdXJyZW50bHks
IGZvciB0aGUgY2FzZSBvZiBudW1fb25saW5lX2NwdXMoKSA8PSAxLCByZXR1cm4gZGlyZWN0bHks
IA0KPj4gaW5kaWNhdGVzIHRoZSBlbmQgb2YgY3VycmVudCBncmFjZSBwZXJpb2QgYW5kIHRoZW4g
cmVsZWFzZSBvbGQgZGF0YS4NCj4+IGl0J3Mgbm90IGFjY3VyYXRlLCBmb3IgU01QIHN5c3RlbSwg
d2hlbiBudW1fb25saW5lX2NwdXMoKSBpcyBlcXVhbCANCj4+IG9uZSwgbWF5YmUgYW5vdGhlciBj
cHUgdGhhdCBpbiBvZmZsaW5lIHByb2Nlc3MoYWZ0ZXIgaW52b2tlDQo+PiBfX2NwdV9kaXNhYmxl
KCkpIGlzIHN0aWxsIGluIHRoZSBydWRlIFJDVS1UYXNrcyBjcml0aWNhbCBzZWN0aW9uIA0KPj4g
aG9sZGluZyB0aGUgb2xkIGRhdGEsIHRoaXMgbGVhZCB0byBtZW1vcnkgY29ycnVwdGlvbi4NCj4+
IA0KPj4gDQo+PiANCj4+IFdhcyB0aGlzIHJhY2Ugc2VlbiBpbiB5b3VyIHRlc3Rpbmc/IEZvciB0
aGUgb3V0Z29pbmcgQ1BVLCBvbmNlIHRoYXQgDQo+PiBDUFUgbWFya3MgaXRzZWxmIG9mZmxpbmUg
KGFuZCBkZWNyZW1lbnRzIF9fbnVtX29ubGluZV9jcHVzKSwgZG8gd2UgDQo+PiBoYXZlIHRyYWNp
bmcgYWN0aXZlIG9uIHRoYXQgQ1BVLCBhbmQgc3luY2hyb25pemVfcmN1X3Rhc2tzX3J1ZGUoKSBu
b3QgDQo+PiB3YWl0aW5nIGZvciBpdCBjb3VsZCBwb3RlbnRpYWxseSBsZWFkIHRvIG1lbW9yeSBj
b3JydXB0aW9uPw0KPiANCj4gSGkgTmVlcmFqDQo+IA0KPiBJbmRlZWQsIEkgZGlkbid0IHNlZSBy
YWNlIGluIHRoZSBhY3R1YWwgcHJvZHVjdGlvbiBlbnZpcm9ubWVudCwgTWF5YmUgDQo+IG15IGNv
bW1pdCBpbmZvcm1hdGlvbiBkZXNjcmlwdGlvbiBpcyBub3QgYWNjdXJhdGUgZW5vdWdoLCBsaWtl
IHRoZSANCj4gc2NlbmUgSSBkZXNjcmliZWQgd2l0aCBqb2VsLg0KPiANCj4gSWYgaW4gY3B1aHBf
aW52b2tlX2NhbGxiYWNrLCBzb21lIGNhbGxiYWNrIGlzIGluIHJ1ZGUgcmN1LXRhc2tzIHJlYWQg
DQo+IGN0cmljYWwgc2VjdGlvbiwgYW5kIHN0aWxsIGhvbGRpbmcgb2xkIGRhdGEsIGJ1dCBpbiB0
aGlzIHRpbWUsIA0KPiBzeW5jaHJvbml6ZV9yY3VfdGFza3NfcnVkZSgpIG5vdCB3YWl0aW5nLCBh
bmQgcmVsZWFzZSBvbGQgZGF0YS4NCj4gDQo+IFN1cHBvc2UgdGhlIHN5c3RlbSBoYXMgdHdvIGNw
dXMNCj4gDQo+ICAgIENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGNwdV9zdG9wcGVyX3RocmVhZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YWtlX2Nw
dV9kb3duDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fY3B1X2Rpc2FibGUNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGVjIF9fbnVtX29ubGluZV9jcHVzIA0KPiByY3VfdGFz
a3NfcnVkZV93YWl0X2dwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVo
cF9pbnZva2VfY2FsbGJhY2sgIA0KPiAgICBudW1fb25saW5lX2NwdXMoKSA9PSAxDQo+ICAgICAg
ICByZXR1cm47DQo+IA0KPiB3aGVuIF9fbnVtX29ubGluZV9jcHVzID09IDEsIHRoZSBDUFUxIG5v
dCBjb21wbGV0ZWx5IG9mZmxpbmUuDQo+DQo+QWdyZWVkIHdpdGggeW91cnMgYW5kIE5lZXJhaiBh
c3Nlc3NtZW50Lg0KPg0KPj4gDQo+PiBBcyBwZXIgbXkgdW5kZXJzdGFuZGluZywgZ2l2ZW4gdGhh
dCBvdXRnb2luZy9pbmNvbWluZyBDUFUgDQo+PiBkZWNyZW1lbnRzL2luY3JlbWVudHMgdGhlIF9f
bnVtX29ubGluZV9jcHVzIHZhbHVlLCBhbmQgDQo+PiBudW1fb25saW5lX2NwdXMoKSBpcyBhIHBs
YWluIHJlYWQsIHByb2JsZW0gY291bGQgaGFwcGVuIHdoZW4gdGhlIA0KPj4gaW5jb21pbmcgQ1BV
IHVwZGF0ZXMgdGhlIF9fbnVtX29ubGluZV9jcHVzICB2YWx1ZSwgaG93ZXZlciwgDQo+PiByY3Vf
dGFza3NfcnVkZV93YWl0X2dwKCkncw0KPj4gbnVtX29ubGluZV9jcHVzKCkgY2FsbCBkaWRuJ3Qg
b2JzZXJ2ZSB0aGUgaW5jcmVtZW50LiBTbywNCj4+IGNwdXNfcmVhZF9sb2NrL3VubG9jaygpIHNl
ZW1zIHRvIGJlIHJlcXVpcmVkIHRvIGhhbmRsZSB0aGlzIGNhc2UuDQo+IA0KPiBZZXMsIHRoZSBz
YW1lIHByb2JsZW0gd2lsbCBiZSBlbmNvdW50ZXJlZCB3aGVuIGdvaW5nIG9ubGluZSwgZHVlIHRv
IA0KPiBhY2Nlc3MgIF9fbnVtX29ubGluZV9jcHVzICB0aGF0IGlzIG5vdCBwcm90ZWN0ZWQgYnkg
DQo+IGNwdXNfcmVhZF9sb2NrL3VubG9jaygpIGluIHJjdV90YXNrc19ydWRlX3dhaXRfZ3AoKS4N
Cj4gDQo+IERvIEkgbmVlZCB0byBjaGFuZ2UgdGhlIGNvbW1pdCBpbmZvcm1hdGlvbiB0byBzZW5k
IHYyPw0KPg0KPkkgdGhpbmsgc28uIElmIHlvdSBjb3VsZCBhZGQgdGhlIENQVSBzZXF1ZW5jZSBk
aWFncmFtIHlvdSBtZW50aW9uZWQsIHRoYXQgd291bGQgYmUgZ3JlYXQuDQo+DQo+QWxzbyBJIHN1
Z2dlc3QgYWRkIG1vcmUgZGV0YWlscyBvZiB3aGljaCBzcGVjaWZpYyBwYXJ0cyBvZiB0aGUgaG90
cGx1ZyBwcm9jZXNzICh0aGUgb25lcyBpbiBzdG9wIG1hY2hpbmUgb25seSkgYXJlIHN1c2NlcHRp
YmxlIHRvIHRoZSBpc3N1ZS4gVGhhdCBpcywgb25seSB0aG9zZSBob3RwbHVnIGNhbGxiYWNrcyB0
aGF0IGFyZSBpbiAgc3RvcCBtYWNoaW5lIHdoaWNoIG1heSBoYXZlIHRyYW1wb2xpbmVzIHByZW1h
dHVyZWx5IGZyZWVkIGZyb20gYW5vdGhlciBjcHUsIHJpZ2h0Pw0KDQpZZXMsIHlvdXIgZGVzY3Jp
YmUgaXMgY29ycmVjdCwgSSB3aWxsIHJlc2VuZCwgSSB3aWxsIHJlc2VuZC4NCg0KVGhhbmtzDQpa
cWlhbmcNCg0KPg0KPlRoYW5rcyENCj4NCj4gIC0gSm9lbA0KPg0KPg0KPg0KPiANCj4gVGhhbmtz
DQo+IFpxaWFuZw0KPiANCj4+IA0KPj4gDQo+PiBUaGFua3MNCj4+IE5lZXJhag0KPj4gDQo+PiBU
aGVyZWZvcmUsIHRoaXMgY29tbWl0IGFkZCBjcHVzX3JlYWRfbG9jay91bmxvY2soKSBiZWZvcmUg
ZXhlY3V0aW5nIA0KPj4gbnVtX29ubGluZV9jcHVzKCkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGtlcm5lbC9yY3Uv
dGFza3MuaCB8IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvcmN1L3Rhc2tzLmggYi9rZXJuZWwvcmN1L3Rhc2tzLmggaW5kZXggDQo+PiA0YTk5MTMxMWJl
OWIuLjA4ZTcyYzY0NjJkOCAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yY3UvdGFza3MuaA0KPj4g
KysrIGIva2VybmVsL3JjdS90YXNrcy5oDQo+PiBAQCAtMTAzMywxNCArMTAzMywzMCBAQCBzdGF0
aWMgdm9pZCByY3VfdGFza3NfYmVfcnVkZShzdHJ1Y3QgDQo+PiB3b3JrX3N0cnVjdCAqd29yaykg
IHsgIH0NCj4+IA0KPj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3Qgd29ya19zdHJ1Y3Qs
IHJ1ZGVfd29yayk7DQo+PiArDQo+PiAgLy8gV2FpdCBmb3Igb25lIHJ1ZGUgUkNVLXRhc2tzIGdy
YWNlIHBlcmlvZC4NCj4+ICBzdGF0aWMgdm9pZCByY3VfdGFza3NfcnVkZV93YWl0X2dwKHN0cnVj
dCByY3VfdGFza3MgKnJ0cCkgIHsNCj4+ICsgICAgaW50IGNwdTsNCj4+ICsgICAgc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrOw0KPj4gKw0KPj4gKyAgICBjcHVzX3JlYWRfbG9jaygpOw0KPj4gICAg
ICBpZiAobnVtX29ubGluZV9jcHVzKCkgPD0gMSkNCj4+IC0gICAgICAgIHJldHVybjsgICAgLy8g
RmFzdHBhdGggZm9yIG9ubHkgb25lIENQVS4NCj4+ICsgICAgICAgIGdvdG8gZW5kOy8vIEZhc3Rw
YXRoIGZvciBvbmx5IG9uZSBDUFUuDQo+PiANCj4+ICAgICAgcnRwLT5uX2lwaXMgKz0gY3B1bWFz
a193ZWlnaHQoY3B1X29ubGluZV9tYXNrKSA+IC0gICAgc2NoZWR1bGVfb25fZWFjaF9jcHUocmN1
X3Rhc2tzX2JlX3J1ZGUpOw0KPj4gKyAgICBmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KPj4g
KyAgICAgICAgd29yayA9IHBlcl9jcHVfcHRyKCZydWRlX3dvcmssIGNwdSk7DQo+PiArICAgICAg
ICBJTklUX1dPUksod29yaywgcmN1X3Rhc2tzX2JlX3J1ZGUpOw0KPj4gKyAgICAgICAgc2NoZWR1
bGVfd29ya19vbihjcHUsIHdvcmspOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGZvcl9lYWNo
X29ubGluZV9jcHUoY3B1KQ0KPj4gKyAgICAgICAgZmx1c2hfd29yayhwZXJfY3B1X3B0cigmcnVk
ZV93b3JrLCBjcHUpKTsNCj4+ICsNCj4+ICtlbmQ6DQo+PiArICAgIGNwdXNfcmVhZF91bmxvY2so
KTsNCj4+ICB9DQo+PiANCj4+ICB2b2lkIGNhbGxfcmN1X3Rhc2tzX3J1ZGUoc3RydWN0IHJjdV9o
ZWFkICpyaHAsIHJjdV9jYWxsYmFja190IGZ1bmMpOw0K
