Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D7625AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiKKNGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiKKNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:06:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D60862D9;
        Fri, 11 Nov 2022 05:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668171960; x=1699707960;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Xf4FkxRe4NTdDVdwiYeJiJweFwsmaRW8vNhT1hwRUDc=;
  b=M23UjDn9JeDJZc8npDzQDhjhYxftXfMxcCjLm/vUEiy0IaWL97Q13f9s
   JrQrtgb4caTEd0ZunPgPTUI1/d2/4fPAHeizbcd/9pBfqxyED5Gjs2UAY
   X6O6fYqv+iJaQMi0OORCaHJyTiddhty2A0g9/SCF8GTvjEzgeBxPAMvwx
   79QN8u3eugw51opescPd33oKeKzpHR2BaCt1/aVKcOS/iwxR44Ah0I426
   gJNRmIKYiDxnrTn3TfxxXC81A5G/PHGFBkJOWx2sh3iOf4guWxaCAzd68
   TGugV41as7E3cLcv+6XxLYyTjYWK/Nr9h2m5bsnsyTVyxaF1SlAEyPkzl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299105037"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="299105037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 05:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="701212019"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="701212019"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2022 05:05:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 05:05:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 05:05:58 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 05:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbSHPiBsaTojo9kWY3wkH1wu/m6TaA/M8TY34iYvu22opSlOx1SEblRuN55P2/M56U7HlhYjs4mA2tsAfn+t6u+tfABfkjVUzdh6EYyk9XqmyN821umZ08ezNMlZIEd409WYs45G64Btc12UaMFq6qMYBfLwJl2sYI9YvHJVn2tLaLEh1krNKNtjJrYZeH1s1F/IMehrwtQ3JkNJB/079CdOrzB2t9eHi+D4QGOp2McoPjvEaszA4Ps08QBL2TMHjRvtpZaClY015Ign6dQv1tST0nTShnpVke7bxLhGpfDdNOzAMFUNioSm4wTh1vUqd90m7sX5UHvPQYsBjWcfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf4FkxRe4NTdDVdwiYeJiJweFwsmaRW8vNhT1hwRUDc=;
 b=nJB74NZOY6HDMeI9VWu7Z+5vcYxz0p6ZgB2u3Aw7AgtqiJb190Qk5uGRY1KNC9qOckehM9GWMzkrpJlraAaWN9HFaHszYgE1VcL07ZDvEM4vFM49kE1kdKjoPMmZOMgkeVfLaMiSxBCp43AUaEl2lSQeeSRVC4h+iC8O7OkNh6qQVMghec1fRrBAYxUJjaXEnLb2miHhBUYwPWtYIhd1Qtv80VYRnWM5X5GTEJZkXrM0W0pkkBqgcPfkHISTgNVNz151Cv48LvJYcRF4sQPYdLdCxbAzeEJS+NvDxR8T2EW3O35uSfhgYpPPMG/E3uiQKWhTX9fn2UfanFkbQRTnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 13:05:57 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 13:05:56 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Topic: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Thread-Index: AQHY9bjOyeVrXHxgy0el1PqNXBMQja45mfHQgAAOY4CAAAch0A==
Date:   Fri, 11 Nov 2022 13:05:56 +0000
Message-ID: <PH0PR11MB5880FEAD72BAE59185256195DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
In-Reply-To: <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW3PR11MB4539:EE_
x-ms-office365-filtering-correlation-id: 8b986e24-b8ae-4974-ed81-08dac3e578df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W67vYWXXtY/FoJu6sgQI8V2ipYZPRCTK/rGp2NZPzyIBlaOJ/6fUjCuiDENTvqQDmmYxgjxjmB4FzLqQGDAXDKndOdpOfP6suyVT/dolB1C5SQDN1YHBeFYUM8Mei9OTSnk5eNLcnAu/98k/A1ucvQWROg2f4N/ohnTmVmlNgUMAwyr3ZlDvSVR0mWuTU08maqKx9wSzG2NT2AJyb2JmAIvHZpBYMrM+mTbS39SuqaG0DScwdmMtijJW1pnmr0Wkcmbp+eFPf4cXA9hch/tG6zVkVTnB/RcrSo0shYHOr7Wm8Co8xWegs6MrUd3udVJBmQtS/DcWSkBqE6huVZdLGM5Cu7VHA0+GrcpFiWqA1cwQarV0uiWFuedLUwgOqxCDycMZfW4DbnIR6DOQZMBAb4sh1S+tk04ZcMKC1c5OEOPcJBlP++7YXFK2hFbRNkFzVH6x36/9MzJzparoczS/k9XULrOK5UQmJoHMHupMG6JmAzYonkIf+TCQaLSMb4KEKGmjIT2WZ0zcZLacZ67DPH+iatCjFYQikVaCdWoZo1vqyWUl4HoquYctfV5ruNYJYUl4vXCoPNojtmzL7lJDfZrkrXbGokX0TZFPc8KChqiRKnmDEc4wAWqr6PrANPQCXq0L0hnOJJ6yUDyYiO7LJJLVLHzvc0cw7wR0BHZkbMLwKkvA/eL8y75V+MMCmX6hxV62WxE+nJuphps75ZzoyPocIVgZ1RKzGajR27uDfex11WCgpcQbzUjegOm9kphIDI+E9TdqirZ7uJncxb/bVK+ZM0YegFNJMScIHh7zyhI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(41300700001)(2906002)(86362001)(8936002)(7416002)(5660300002)(52536014)(33656002)(66574015)(71200400001)(83380400001)(9686003)(7696005)(26005)(6506007)(53546011)(186003)(478600001)(55016003)(82960400001)(38100700002)(64756008)(66446008)(66476007)(66556008)(921005)(38070700005)(8676002)(66946007)(76116006)(110136005)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ay8wU2dDWVBVUSs0VE5VZE40NGxjZG1TRVdwKy93T2p4QVlSRWJBYXZQSHRa?=
 =?utf-8?B?MWoxcGZNNkhUUlNBUkNvNnJZWlp0bzhOY0ZIbmxrbGhEakRSQTgvN082SDlu?=
 =?utf-8?B?a2tCeVNOWTZUZ0dENlE0dzAyaGNXZUdiUWdEMzZGK0R5ZGNWVnRodHNRYXZB?=
 =?utf-8?B?K09qR3B3eGtjczR5Y1BPN2ZiYmZIKzF1Y0hqdE5YWkFJTjJCbFpIZFB1aEVM?=
 =?utf-8?B?Wjhpd1dTWmc5Z2k3aG1IM0EyR2xTYlRxM3JEcjlkbGV1OVZZdkdaK2hUSHZQ?=
 =?utf-8?B?NEhvNzZMZVQ2TEYxdDdFTzFaVG04bWFqQ2k0L3B4N1A1b3hqcGNRV3Jka0dV?=
 =?utf-8?B?eHhCa0tRc3ptUnFnTG9lTVdEQ3hpaTJUSDdNcURTNVBSK1UwYXUybmQwK2E1?=
 =?utf-8?B?MDcyb1R5SzNqWnl4ZGthcVlFdG83MG5rUFZNWE01NG5sVDVVRk1oTWV1Nnhw?=
 =?utf-8?B?OFlLS0RNQnp6cnlka0ZneTZYRjUvQ2RiVlAzSlRLSWhXMlB2WXg1SEJ6WFVW?=
 =?utf-8?B?WXhQRWR1RHBWY1ZsYWxsdzVGL0VaMTliWHVlMXo3bDZkQmUrM2tXTVg4QXd0?=
 =?utf-8?B?QXlyTmcwVlpwbDZ0bEswZjFlc3JPODVpTGJwSCs0M2I4SExmbFVwREk2QkJa?=
 =?utf-8?B?UDMzR1ZBL00zcXl6SVBib0RoQTNQcURZSEVxOUJ6Z2R0UTJVUTh5bHlIU2pN?=
 =?utf-8?B?b2FPdE96RHdyRTRzRlQ5TE1ibTNINTRKMnNHdHZTT3Rib2Rxbi90cEFWL1lW?=
 =?utf-8?B?aGJSNzl3MlRQMS9kcStCN2ZiSmg2VHZzTDRBUklySm14S3BIYkV4YStGdHFj?=
 =?utf-8?B?UDRCMUJSSm5oeWMyRWlnMy9wZVc5eThZcTh6NWpMMWh4dEtTTEkwaWZ3b3hq?=
 =?utf-8?B?K2k1OWc0Qkt4ekg3L0NCSVgzMWRnSkRjcXUxdVM1Ty8reklXV01KeUtjSVln?=
 =?utf-8?B?NU1hZE10eGJ1cUovUEpUVXhlU3B4a0M2SWtQSmhEQmxoamlyOUNOK2diR21I?=
 =?utf-8?B?UkhjNkEraTdCMTBjTzc0bXhsa3EwOEFDMGQ4a2J4N25saFM3U3k1bDM4V1dp?=
 =?utf-8?B?aFc2QXcvNkd5SXk1Q3M2TzcyTzV3NjFHd1lVTkhKcExNZENXZVhveXFPUXZK?=
 =?utf-8?B?ajg5YURKOVFqblZwblhHY1ZEM2V5d05ZTWt0WURtSm1YTWlOMUVrNEJJY2NR?=
 =?utf-8?B?dzlYajk5NXRIYVlFa0lkQXo3VDVObDRQQXJZUU5UVzdxSHZPWTNCTk50RktZ?=
 =?utf-8?B?Z2V3OUU3RmordUgwaFQwMVBISEY5UWxpZmxPM0QrTWxxeDVJOXRYN1E2YmtS?=
 =?utf-8?B?cldMVkdDL0tuZDV2MGtKNWxaR3NrdmhGbXUrc1ZYVGVJc1MrU0liTTlJN1VR?=
 =?utf-8?B?WWVrRGE5Nzc1TlJLSFZiYjRnd3ZmanlQeTBqS29FMVNTWnltQlRYT0s0TGhJ?=
 =?utf-8?B?Q3pYaHU4QSs0WnpiTWxiclI0TFVBYTgyQXZZVmduaFVjYW5qTHpETFNqU2Zx?=
 =?utf-8?B?TE0rRmpLRUgzTWZqZm9DR2FtWXVtVHY1eEVnV0VETWJPbWNPRkREQVZWRWo4?=
 =?utf-8?B?R1N2VzdlQkJxdk9ZcmY1blc5c2xNV1VybjdJYXlNUUJmUmhzcUxQbW5aTU1V?=
 =?utf-8?B?cE5maE1sQWJzY3Fzbnh4OHhKWUZKS2pvMlNpS3V1R2pzNEVEV29TUmlnRTlz?=
 =?utf-8?B?RTRBT3hpemtzRVhYTzJPSVVxS2VFVW56WFduVmNGRlpLVGppdG5tR0hnWk1t?=
 =?utf-8?B?Smo3VUdadWlEU0R2dEVFbDFWMXJpcHRQbGFRRG5EUVVyMGV6L1VtNG1LZHM2?=
 =?utf-8?B?N1QwWUhoM2ZhOHBhYmpPeG5VOFRwYnRkRUZmMlc2blJpKzQ1VUw0TiszZU9L?=
 =?utf-8?B?STJJQ2k5STg1LzV2bmZLU3BxZEJ3Smd4QlVXVkZYNkJBNm9uVWdBUzh2ODE3?=
 =?utf-8?B?Mnc2L3BTTFdFaVpEaTluRS9GbmpUTHFlTHplSmFpUW1FQ2ZGUC8wVXowUVF0?=
 =?utf-8?B?WlROeVQxTDVXTEUwSVJCNmNqY2hvVUUwYlNOaEN6dG5YaUs2SzdrSUR5aStQ?=
 =?utf-8?B?dUdJYWRLNVVmSml3TTUvT0dVVVpwdkRBS0hVMUV6cWNqMGRmcUIvcGJJa2dE?=
 =?utf-8?Q?biVbXwTC2V59iO2j5KsBeoV1r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b986e24-b8ae-4974-ed81-08dac3e578df
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 13:05:56.8734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFUlgr9ipj37amU4URGc0wO/6IY+QLKAVbBQ35Mx2S3yUqrfoYO7ttk5tGvnr6Go4D0Yj2AJ89ICxvGJ3peiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
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

T24gMjAyMi8xMS8xMSAxOTo1NCwgWmhhbmcsIFFpYW5nMSB3cm90ZToNCj4+IFdoZW4gYSBzdHJ1
Y3R1cmUgY29udGFpbmluZyBhbiBSQ1UgY2FsbGJhY2sgcmhwIGlzIChpbmNvcnJlY3RseSkgDQo+
PiBmcmVlZCBhbmQgcmVhbGxvY2F0ZWQgYWZ0ZXIgcmhwIGlzIHBhc3NlZCB0byBjYWxsX3JjdSgp
LCBpdCBpcyBub3QgDQo+PiB1bnVzdWFsIGZvcg0KPj4gcmhwLT5mdW5jIHRvIGJlIHNldCB0byBO
VUxMLiBUaGlzIGRlZmVhdHMgdGhlIGRlYnVnZ2luZyBwcmludHMgdXNlZCANCj4+IHJocC0+YnkN
Cj4+IF9fY2FsbF9yY3VfY29tbW9uKCkgaW4ga2VybmVscyBidWlsdCB3aXRoIA0KPj4gQ09ORklH
X0RFQlVHX09CSkVDVFNfUkNVX0hFQUQ9eSwgd2hpY2ggZXhwZWN0IHRvIGlkZW50aWZ5IHRoZSAN
Cj4+IG9mZmVuZGluZyBjb2RlIHVzaW5nIHRoZSBpZGVudGl0eSBvZiB0aGlzIGZ1bmN0aW9uLg0K
Pj4NCj4+IEFuZCBpbiBrZXJuZWxzIGJ1aWxkIHdpdGhvdXQgQ09ORklHX0RFQlVHX09CSkVDVFNf
UkNVX0hFQUQ9eSwgdGhpbmdzIA0KPj4gYXJlIGV2ZW4gd29yc2UsIGFzIGNhbiBiZSBzZWVuIGZy
b20gdGhpcyBzcGxhdDoNCj4+DQo+PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAgDQo+PiAuLi4gLi4uDQo+PiBQQyBp
cyBhdCAweDANCj4+IExSIGlzIGF0IHJjdV9kb19iYXRjaCsweDFjMC8weDNiOA0KPj4gLi4uIC4u
Lg0KPj4gKHJjdV9kb19iYXRjaCkgZnJvbSAocmN1X2NvcmUrMHgxZDQvMHgyODQpDQo+PiAocmN1
X2NvcmUpIGZyb20gKF9fZG9fc29mdGlycSsweDI0Yy8weDM0NCkNCj4+IChfX2RvX3NvZnRpcnEp
IGZyb20gKF9faXJxX2V4aXRfcmN1KzB4NjQvMHgxMDgpDQo+PiAoX19pcnFfZXhpdF9yY3UpIGZy
b20gKGlycV9leGl0KzB4OC8weDEwKQ0KPj4gKGlycV9leGl0KSBmcm9tIChfX2hhbmRsZV9kb21h
aW5faXJxKzB4NzQvMHg5YykNCj4+IChfX2hhbmRsZV9kb21haW5faXJxKSBmcm9tIChnaWNfaGFu
ZGxlX2lycSsweDhjLzB4OTgpDQo+PiAoZ2ljX2hhbmRsZV9pcnEpIGZyb20gKF9faXJxX3N2Yysw
eDVjLzB4OTQpDQo+PiAoX19pcnFfc3ZjKSBmcm9tIChhcmNoX2NwdV9pZGxlKzB4MjAvMHgzYykN
Cj4+IChhcmNoX2NwdV9pZGxlKSBmcm9tIChkZWZhdWx0X2lkbGVfY2FsbCsweDRjLzB4NzgpDQo+
PiAoZGVmYXVsdF9pZGxlX2NhbGwpIGZyb20gKGRvX2lkbGUrMHhmOC8weDE1MCkNCj4+IChkb19p
ZGxlKSBmcm9tIChjcHVfc3RhcnR1cF9lbnRyeSsweDE4LzB4MjApDQo+PiAoY3B1X3N0YXJ0dXBf
ZW50cnkpIGZyb20gKDB4YzAxNTMwKQ0KPj4NCj4+IFRoaXMgY29tbWl0IHRoZXJlZm9yZSBhZGRz
IGNhbGxzIHRvIG1lbV9kdW1wX29iaihyaHApIHRvIG91dHB1dCBzb21lIA0KPj4gaW5mb3JtYXRp
b24sIGZvciBleGFtcGxlOg0KPj4NCj4+ICBzbGFiIGttYWxsb2MtMjU2IHN0YXJ0IGZmZmY0MTBj
NDUwMTk5MDAgcG9pbnRlciBvZmZzZXQgMCBzaXplIDI1Ng0KPj4NCj4+IFRoaXMgcHJvdmlkZXMg
dGhlIHJvdWdoIHNpemUgb2YgdGhlIG1lbW9yeSBibG9jayBhbmQgdGhlIG9mZnNldCBvZiANCj4+
IHRoZSByY3VfaGVhZCBzdHJ1Y3R1cmUsIHdoaWNoIGFzIGxlYXN0IHByb3ZpZGVzIGF0IGxlYXN0
IGEgZmV3IGNsdWVzIA0KPj4gdG8gaGVscCBsb2NhdGUgdGhlIHByb2JsZW0uIElmIHRoZSBwcm9i
bGVtIGlzIHJlcHJvZHVjaWJsZSwgDQo+PiBhZGRpdGlvbmFsIHNsYWIgZGVidWdnaW5nIGNhbiBi
ZSBlbmFibGVkLCBmb3IgZXhhbXBsZSwgDQo+PiBDT05GSUdfREVCVUdfU0xBQj15LCB3aGljaCBj
YW4gcHJvdmlkZSBzaWduaWZpY2FudGx5IG1vcmUgaW5mb3JtYXRpb24uDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbiBMZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPj4gLS0tDQo+
PiBrZXJuZWwvcmN1L3JjdS5oICAgICAgfCA3ICsrKysrKysNCj4+IGtlcm5lbC9yY3Uvc3JjdXRp
bnkuYyB8IDEgKw0KPj4ga2VybmVsL3JjdS9zcmN1dHJlZS5jIHwgMSArDQo+PiBrZXJuZWwvcmN1
L3Rhc2tzLmggICAgfCAxICsNCj4+IGtlcm5lbC9yY3UvdGlueS5jICAgICB8IDEgKw0KPj4ga2Vy
bmVsL3JjdS90cmVlLmMgICAgIHwgMSArDQo+PiA2IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKykNCj4+DQo+PiB2MSAtLT4gdjI6DQo+PiAxLiBSZW1vdmUgY29uZGl0aW9uICIodW5zaWdu
ZWQgbG9uZylyaHAtPmZ1bmMgJiAweDMiLCBpdCBoYXZlIHByb2JsZW1zIG9uIHg4Ni4NCj4+IDIu
IFBhdWwgRS4gTWNLZW5uZXkgaGVscGVkIG1lIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UsIHRo
YW5rcy4NCj4+DQo+IA0KPiBIaSwgWmhlbiBMZWkNCj4gDQo+IE1heWJlIHRoZSBmb2xsb3dpbmcg
c2NlbmFyaW9zIHNob3VsZCBiZSBjb25zaWRlcmVkOg0KPiANCj4gICAgICAgICAgICAgICAgIENQ
VSAwDQo+IHRhc2tzIGNvbnRleHQNCj4gICAgc3Bpbl9sb2NrKCZ2bWFwX2FyZWFfbG9jaykNCj4g
ICAgICAgICAgIEludGVycnVwdCANCj4gCSBSQ1Ugc29mdGlycQ0KPiAJICAgICAgcmN1X2RvX2Jh
dGNoDQo+IAkJbWVtX2R1bXBfb2JqDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2bWFsbG9jX2R1bXBfb2JqDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNwaW5fbG9jaygmdm1hcF9hcmVhX2xvY2spICAgPC0tICBkZWFkbG9jayAgICAgDQoNCj5S
aWdodCwgdGhhbmtzLiBJIGp1c3Qgc2F3IHRoZSByb2JvdCdzIHJlcG9ydC4gU28gdGhpcyBwYXRj
aCBzaG91bGQgYmUgZHJvcHBlZC4NCj5JJ2xsIHRyeSB0byBhZGQgYW4gaGVscGVyIGluIG1tLCB3
aGVyZSBJIGNhbiBjaGVjayB3aGV0aGVyIHRoZSBsb2NrIGhhcyBiZWVuIGhlbGQsIGFuZCBkdW1w
IHRoZSBjb250ZW50IG9mIG1lbW9yeSBvYmplY3QuDQoNClRoaXMgaXMgYSB3b3JrYXJvdW5kLCBv
ciBtYXliZSB0cnkgYSBtb2RpZmljYXRpb24gbGlrZSB0aGUgZm9sbG93aW5nLCANCm9mIGNvdXJz
ZSwgbmVlZCB0byBhc2sgUGF1bCdzIG9waW5pb24uDQoNCmRpZmYgLS1naXQgYS9tbS91dGlsLmMg
Yi9tbS91dGlsLmMNCmluZGV4IDEyOTg0ZTc2NzY3ZS4uODZkYTA3MzlmZTVkIDEwMDY0NA0KLS0t
IGEvbW0vdXRpbC5jDQorKysgYi9tbS91dGlsLmMNCkBAIC0xMTE5LDE0ICsxMTE5LDE4IEBAIHZv
aWQgbWVtX2R1bXBfb2JqKHZvaWQgKm9iamVjdCkNCiB7DQogICAgICAgIGNvbnN0IGNoYXIgKnR5
cGU7DQoNCisgICAgICAgaWYgKGlzX3ZtYWxsb2NfYWRkcihvYmplY3QpKSB7DQorICAgICAgICAg
ICAgICAgaWYgKGluX3Rhc2soKSAmJiB2bWFsbG9jX2R1bXBfb2JqKG9iamVjdCkpDQorICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm47DQorICAgICAgICAgICAgICAgdHlwZSA9ICJ2bWFsbG9j
IG1lbW9yeSI7DQorICAgICAgICAgICAgICAgZ290byBlbmQ7DQorICAgICAgIH0NCisNCiAgICAg
ICAgaWYgKGttZW1fdmFsaWRfb2JqKG9iamVjdCkpIHsNCiAgICAgICAgICAgICAgICBrbWVtX2R1
bXBfb2JqKG9iamVjdCk7DQogICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICB9DQoNCi0g
ICAgICAgaWYgKHZtYWxsb2NfZHVtcF9vYmoob2JqZWN0KSkNCi0gICAgICAgICAgICAgICByZXR1
cm47DQotDQogICAgICAgIGlmICh2aXJ0X2FkZHJfdmFsaWQob2JqZWN0KSkNCiAgICAgICAgICAg
ICAgICB0eXBlID0gIm5vbi1zbGFiL3ZtYWxsb2MgbWVtb3J5IjsNCiAgICAgICAgZWxzZSBpZiAo
b2JqZWN0ID09IE5VTEwpDQpAQCAtMTEzNSw3ICsxMTM5LDcgQEAgdm9pZCBtZW1fZHVtcF9vYmoo
dm9pZCAqb2JqZWN0KQ0KICAgICAgICAgICAgICAgIHR5cGUgPSAiemVyby1zaXplIHBvaW50ZXIi
Ow0KICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgdHlwZSA9ICJub24tcGFnZWQgbWVtb3J5
IjsNCi0NCitlbmQ6DQogICAgICAgIHByX2NvbnQoIiAlc1xuIiwgdHlwZSk7DQogfQ0KIEVYUE9S
VF9TWU1CT0xfR1BMKG1lbV9kdW1wX29iaik7DQoNClRoYW5rcw0KWnFpYW5nDQoNCg0KPiANCj4g
VGhhbmtzDQo+IFpxaWFuZw0KPiANCj4gDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS9yY3Uu
aCBiL2tlcm5lbC9yY3UvcmN1LmggaW5kZXggDQo+PiA2NTcwNGNiYzlkZjdiM2QuLjMyYWI0NWZh
YmY4ZWViZiAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9yY3UvcmN1LmgNCj4+ICsrKyBiL2tlcm5l
bC9yY3UvcmN1LmgNCj4+IEBAIC0xMCw2ICsxMCw3IEBADQo+PiAjaWZuZGVmIF9fTElOVVhfUkNV
X0gNCj4+ICNkZWZpbmUgX19MSU5VWF9SQ1VfSA0KPj4NCj4+ICsjaW5jbHVkZSA8bGludXgvbW0u
aD4NCj4+ICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvcmN1Lmg+DQo+Pg0KPj4gLyoNCj4+IEBAIC0y
MTEsNiArMjEyLDEyIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkZWJ1Z19yY3VfaGVhZF91bnF1ZXVl
KHN0cnVjdCANCj4+IHJjdV9oZWFkICpoZWFkKSB9DQo+PiAjZW5kaWYJLyogI2Vsc2UgIUNPTkZJ
R19ERUJVR19PQkpFQ1RTX1JDVV9IRUFEICovDQo+Pg0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBk
ZWJ1Z19yY3VfaGVhZF9jYWxsYmFjayhzdHJ1Y3QgcmN1X2hlYWQgKnJocCkgew0KPj4gKwlpZiAo
dW5saWtlbHkoIXJocC0+ZnVuYykpDQo+PiArCQltZW1fZHVtcF9vYmoocmhwKTsNCj4+ICt9DQo+
PiArDQo+PiBleHRlcm4gaW50IHJjdV9jcHVfc3RhbGxfc3VwcHJlc3NfYXRfYm9vdDsNCj4+DQo+
PiBzdGF0aWMgaW5saW5lIGJvb2wgcmN1X3N0YWxsX2lzX3N1cHByZXNzZWRfYXRfYm9vdCh2b2lk
KQ0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3Uvc3JjdXRpbnkuYyBiL2tlcm5lbC9yY3Uvc3Jj
dXRpbnkuYyBpbmRleCANCj4+IDMzYWRhZmRhZDI2MTM4OS4uNWU3ZjMzNmJhYTA2YWUwIDEwMDY0
NA0KPj4gLS0tIGEva2VybmVsL3JjdS9zcmN1dGlueS5jDQo+PiArKysgYi9rZXJuZWwvcmN1L3Ny
Y3V0aW55LmMNCj4+IEBAIC0xMzgsNiArMTM4LDcgQEAgdm9pZCBzcmN1X2RyaXZlX2dwKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd3ApDQo+PiAJd2hpbGUgKGxoKSB7DQo+PiAJCXJocCA9IGxoOw0KPj4g
CQlsaCA9IGxoLT5uZXh0Ow0KPj4gKwkJZGVidWdfcmN1X2hlYWRfY2FsbGJhY2socmhwKTsNCj4+
IAkJbG9jYWxfYmhfZGlzYWJsZSgpOw0KPj4gCQlyaHAtPmZ1bmMocmhwKTsNCj4+IAkJbG9jYWxf
YmhfZW5hYmxlKCk7DQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS9zcmN1dHJlZS5jIGIva2Vy
bmVsL3JjdS9zcmN1dHJlZS5jIGluZGV4IA0KPj4gY2E0YjVkY2VjNjc1YmFjLi4yOTQ5NzJlNjZi
MzE4NjMgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvcmN1L3NyY3V0cmVlLmMNCj4+ICsrKyBiL2tl
cm5lbC9yY3Uvc3JjdXRyZWUuYw0KPj4gQEAgLTE2MzEsNiArMTYzMSw3IEBAIHN0YXRpYyB2b2lk
IHNyY3VfaW52b2tlX2NhbGxiYWNrcyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+PiAJcmhw
ID0gcmN1X2NibGlzdF9kZXF1ZXVlKCZyZWFkeV9jYnMpOw0KPj4gCWZvciAoOyByaHAgIT0gTlVM
TDsgcmhwID0gcmN1X2NibGlzdF9kZXF1ZXVlKCZyZWFkeV9jYnMpKSB7DQo+PiAJCWRlYnVnX3Jj
dV9oZWFkX3VucXVldWUocmhwKTsNCj4+ICsJCWRlYnVnX3JjdV9oZWFkX2NhbGxiYWNrKHJocCk7
DQo+PiAJCWxvY2FsX2JoX2Rpc2FibGUoKTsNCj4+IAkJcmhwLT5mdW5jKHJocCk7DQo+PiAJCWxv
Y2FsX2JoX2VuYWJsZSgpOw0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdGFza3MuaCBiL2tl
cm5lbC9yY3UvdGFza3MuaCBpbmRleCANCj4+IGIwYjg4NWUwNzFmYThkYy4uYjdmOGM2N2M1ODZj
ZGM0IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3JjdS90YXNrcy5oDQo+PiArKysgYi9rZXJuZWwv
cmN1L3Rhc2tzLmgNCj4+IEBAIC00NzgsNiArNDc4LDcgQEAgc3RhdGljIHZvaWQgcmN1X3Rhc2tz
X2ludm9rZV9jYnMoc3RydWN0IHJjdV90YXNrcyAqcnRwLCBzdHJ1Y3QgcmN1X3Rhc2tzX3BlcmNw
dQ0KPj4gCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlX3JjdV9ub2RlKHJ0cGNwLCBmbGFncyk7
DQo+PiAJbGVuID0gcmNsLmxlbjsNCj4+IAlmb3IgKHJocCA9IHJjdV9jYmxpc3RfZGVxdWV1ZSgm
cmNsKTsgcmhwOyByaHAgPSANCj4+IHJjdV9jYmxpc3RfZGVxdWV1ZSgmcmNsKSkgew0KPj4gKwkJ
ZGVidWdfcmN1X2hlYWRfY2FsbGJhY2socmhwKTsNCj4+IAkJbG9jYWxfYmhfZGlzYWJsZSgpOw0K
Pj4gCQlyaHAtPmZ1bmMocmhwKTsNCj4+IAkJbG9jYWxfYmhfZW5hYmxlKCk7DQo+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL3JjdS90aW55LmMgYi9rZXJuZWwvcmN1L3RpbnkuYyBpbmRleCANCj4+IGJi
OGY3ZDI3MGYwMTc0Ny4uNTZlOWE1ZDkxZDk3ZWM1IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3Jj
dS90aW55LmMNCj4+ICsrKyBiL2tlcm5lbC9yY3UvdGlueS5jDQo+PiBAQCAtOTcsNiArOTcsNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wgcmN1X3JlY2xhaW1fdGlueShzdHJ1Y3QgcmN1X2hlYWQgDQo+
PiAqaGVhZCkNCj4+DQo+PiAJdHJhY2VfcmN1X2ludm9rZV9jYWxsYmFjaygiIiwgaGVhZCk7DQo+
PiAJZiA9IGhlYWQtPmZ1bmM7DQo+PiArCWRlYnVnX3JjdV9oZWFkX2NhbGxiYWNrKGhlYWQpOw0K
Pj4gCVdSSVRFX09OQ0UoaGVhZC0+ZnVuYywgKHJjdV9jYWxsYmFja190KTBMKTsNCj4+IAlmKGhl
YWQpOw0KPj4gCXJjdV9sb2NrX3JlbGVhc2UoJnJjdV9jYWxsYmFja19tYXApOw0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMgaW5kZXggDQo+PiAx
NWFhZmYzMjAzYmYyZDAuLmVkOTNkZGI4MjAzZDQyYyAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9y
Y3UvdHJlZS5jDQo+PiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPj4gQEAgLTIwODgsNiArMjA4
OCw3IEBAIHN0YXRpYyB2b2lkIHJjdV9kb19iYXRjaChzdHJ1Y3QgcmN1X2RhdGEgKnJkcCkNCj4+
IAkJdHJhY2VfcmN1X2ludm9rZV9jYWxsYmFjayhyY3Vfc3RhdGUubmFtZSwgcmhwKTsNCj4+DQo+
PiAJCWYgPSByaHAtPmZ1bmM7DQo+PiArCQlkZWJ1Z19yY3VfaGVhZF9jYWxsYmFjayhyaHApOw0K
Pj4gCQlXUklURV9PTkNFKHJocC0+ZnVuYywgKHJjdV9jYWxsYmFja190KTBMKTsNCj4+IAkJZihy
aHApOw0KPj4NCj4+IC0tDQo+PiAyLjI1LjENCj4gDQo+IC4NCj4gDQoNCi0tDQpSZWdhcmRzLA0K
ICBaaGVuIExlaQ0K
