Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24036D4E84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjDCQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjDCQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:58:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE932EC;
        Mon,  3 Apr 2023 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680541107; x=1712077107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jOg8+FXFFLnz0c02JLjYmfCZhFC3/Hy+xlGyWcDJm9M=;
  b=UTgZTSuWdcOG2tPpL5iQTN4o+Letrkvx3SFe0UkotC9y5lMmafn9/ICq
   pAqAjFtGKPzwS7+o9oS182rivGhxs+YbCq7bD5DXRRDa6kQ+GKGbIaqMg
   horyKLYQSUSw8ZhIQWO/ei7Q3ApCfo+YRJq5CXs6ksta+Kv/kw2wuifAJ
   fFj21tX6WuXUKz/XQ9kItIFEu8AfM+dUGje0LVGZgBsNaRQXIhDezhXJJ
   1k8ZdZKDPCUmacmo95s2XWapVZpbryNNVf4xUOv/vQaSLIV2YfGG74ck3
   MeU0v5P+Hn104AcN6rSwNmUt0xYlPoSqrLyn7Qb4bHiU0EcrYK7HdUieJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330527896"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="330527896"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="797135552"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="797135552"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2023 09:58:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 09:58:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 09:58:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 09:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axW5eg2vlwCLY8AD3/cIk5snN1u3upbw1X9BaeSJN5W+Pv2jRtoR98QkUrMIzJHSRu7RMYugHCq3KT+e6r9DXgGDJIS93vryU7HE5u4Rlk5sXM0GQKb4iiTsPpLK1KL0RliTb4BznjyEzCr8tWqH+H2wTkTF2ezpXVznIqbF/bnHJ2S8Dhg26p0LpP1joLHjCNXmjgL0MeHQjmlYPQ0zigAGl8p1LQhU2GU0eT0mtocUS8RNDuBW9NwVB6BvUyZIrITNWf3pYGu6xVJaA7AtYkq5cgstMmuwtPfeh2MPoM8YU0gDoxZKbF1HqJCkZjRhZEQ362prVLzVGvI1C+u1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOg8+FXFFLnz0c02JLjYmfCZhFC3/Hy+xlGyWcDJm9M=;
 b=GpwgwyNwIcgwz350zgoLUZDgsgM6FsdXpfIOrxTm8U7+toa8/lV/MnEVgcOGpSm4gbIR9uB9ZVaomNivxZwZyeCFstl4W3HXR+VimF7r/lLb9im+X10geYpld79XmRrTXnuMvqHj8GXqEmLQieYEx21tbR1ni9NPL/xs5Bd/nfnKCSVnu3dLhbqQIkazGspAg8HnD5CrHJJOgTnwKevECSvbIu20DZUW6rIAZqHqKEzDm0lJuLSgjkgLGGmEZHzii0t78CsppoFRR42O9Z0FGsW3Dsv8oaeTainR41vn3XLz5lbsbEN73PzNpuVsiESkYR/s6GkChkVYvFdsr8N4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 16:58:22 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8%7]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 16:58:22 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "jstultz@google.com" <jstultz@google.com>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] platform/x86/intel/pmc: core: Always capture
 counters on suspend
Thread-Topic: [PATCH v5 3/4] platform/x86/intel/pmc: core: Always capture
 counters on suspend
Thread-Index: AQHZY0BC/kn9a0tyrUSkCv4nmzeVG68Z1H2A
Date:   Mon, 3 Apr 2023 16:58:21 +0000
Message-ID: <41b516903b7522ea618585dd854b4c5c6037da27.camel@intel.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
         <20230330194439.14361-4-mario.limonciello@amd.com>
In-Reply-To: <20230330194439.14361-4-mario.limonciello@amd.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|DM4PR11MB6095:EE_
x-ms-office365-filtering-correlation-id: 6cb0dbb6-8dd0-433f-f9d0-08db3464a1de
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKHMIYskwYqR5PGOKV/76ykj074ct4UDOuEUlgNyzhDDBPaOhp3HE7SHuBZZv5WhvgyvqXFfqsJDNEiAahRFHxC/aKkNcy+DmnRLgiAdMvPDjMlaCkk6XLPpH/R653uXHFi07f9hYcU7wsbZ1ZvS2CHdNkP3X796c3GLUeTdDkEfg5mX6lYU3jkF8lLJWHBawZEwhKZIh9xxU/Ov8MClhl7hxVmZeqbDbDwbw/Tjbf2hlXEv6zOE/9R3YzNS3+eGBqsRfV+DNGuzDcMCfMpNZUOOGlpjA/+ZfF4qYcOPoqqQx28QW1vCPK2MDlqwaEzX5BjGDtBGPtPa7nwof+WofNrAz3PqoxU2B2+60d1YxLslHabr0yza20LJWC1rSmj4NJKnf8nwMwB0kZazf6HFROZt5fCLR6oy98Fmuhy42QdIAfWOWPK8QNsAf7TQc//wR1pIHyjYEsEUJgtmO2eVzELvQLu2mAWSiFNLWRYLuywzx/uEwGuQEPrHgpZKkAiNriJCDvSUR7THQ3E+x8dkknOm9kag7XroWmjcscGtBgPZYEnqCykA9vuhKHTHd2pPWgNhzGJU1mXylrPZewoee6aHQmqqdcmAOxx6V1Q005rndAbInbKsDy0hTn0mEBps
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(64756008)(82960400001)(83380400001)(4326008)(8676002)(86362001)(66946007)(66446008)(66556008)(66476007)(76116006)(316002)(2906002)(91956017)(41300700001)(122000001)(3450700001)(54906003)(478600001)(110136005)(38100700002)(71200400001)(15650500001)(36756003)(8936002)(2616005)(6486002)(38070700005)(5660300002)(6512007)(7416002)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNzTE5hVUFXb2U2M0Q3dC8zcHlPSVFDWDZSTUVzSnY0OUs3VUVTSGlwSlVU?=
 =?utf-8?B?Z2ZGMVdjdktwL01aNUxkSVJHNEgxTnByOHNORS92dzNaSkxHTzZhc2FQeldT?=
 =?utf-8?B?cUlTN1RVN2dURGlHVHJ4dkdwbTVBNmtWd1U5bnBlTThkOGY1bFJMT0xXLzk5?=
 =?utf-8?B?bm1QR1ZXeVE5RTMyaGtJYk9aVkFnU0VjNXJHS1BGalBQNGtUY0wrdXF0UkFi?=
 =?utf-8?B?VTNxcHU5Q0VPRW5pS1dmUVlydDBxWi82dXA5QzhNc1lKbGhtRzlTeXJoTDVk?=
 =?utf-8?B?dGRCQWYzdEJwL3V5dWVxbjZsUURYcnkyWlpKTTR5NmxHOGZGbERHZlVUTFV4?=
 =?utf-8?B?UmtCMzFZMGZ4TWtNbFJxVW8zaExZQ3BQdHhqVnRRa0RXWGhrZ2dpSnF2UXR3?=
 =?utf-8?B?dTFpbTMrMU00VCtub0xreGppN1dXUHFoRzhnZDc1YUN6YnNlNDFFL2NaWFpF?=
 =?utf-8?B?VTdHZzQyNnlCVXk5c3kxd2k2aVorYXVDZlNCYlIxOVdTOUtrVWMrNFFWL1BR?=
 =?utf-8?B?UEQxbWljNzNtQzZxZGtwWmRMR1dJZHdQQlYxYko2SGpwN2xkWFk4QnZLaHk3?=
 =?utf-8?B?QVQrMFBXeDNqd2FwbXhlUzhuMWtGWUNLUkcrczRMdHZLcnVTbmI0S2hHczA5?=
 =?utf-8?B?alBubVY4cUxBWTllam9GMFNNalphc0x1RHBhbEVJbHpLcFZUcjNuakFOdXF3?=
 =?utf-8?B?Y1ptK0pzNWRlamEveUVueDRhUzJTTkhMVXhlRUhoT0hLR1F6WHU4eDQ4RkpK?=
 =?utf-8?B?MlZqRm9jWEFLUVlNOFFKY1F3VGJKZkFzQkRFeGhGNUpUVmNCVjh0OWJuRTNM?=
 =?utf-8?B?VVN5SjJjTFR1TU5JdUh4T1ozK2tsN2xzQjlUSGV4aDdhMFVsZUZNTXVEcDJk?=
 =?utf-8?B?cnF4WTlhU0JyM1UxZG9GNHBvUGJwc2xIRkFhNzNVWENNaDFadmxXYmF3TTl3?=
 =?utf-8?B?WGRwUmJEYVhHa2oxK25kZ0lydDRUUDNqcnEvTXduOHVZL0UyaGdUNEFNalVO?=
 =?utf-8?B?QlJlWUh1TC9uWGJreTc2amp0RWdrTE9FSC9FZkMyRXlJZkdFeGtrTjlWbHFL?=
 =?utf-8?B?a08xS0pYajUxdHFTVHhNWStmd2tjN2xSSTJCbEJnQkphVU9FZmhySlcrU2Fj?=
 =?utf-8?B?anZwUG9sRnVLZ0dSMGNMeEhTMmxHdlNESnBGWWJCUS9lZEo5MzljSVRPQkhE?=
 =?utf-8?B?cWhpdUI2TEE2Zmxld25jVnhFYUp6K2hpYkUxUG9BenNLTlc1Kzg1UG5Ra2NX?=
 =?utf-8?B?OS9rT1J5L01mbW43ekFpVXdHV0NHL0x2Y3Zuck1lOGc3djBVNXBPRUkza2wz?=
 =?utf-8?B?anlqaWdKRnRyTy8wT3lUQmFjZ2tqYUl6aXBKUHA1dmxMNFVZSGM4QXVId0JI?=
 =?utf-8?B?YjN3N2h0VW9Fd0JlczQrR1VnNHE1SXdQd0wycVkzYng3UVdkaVkydE5xRytl?=
 =?utf-8?B?RlMrRmp4eDZMbHNzOEIrRmdoNklyWjVtT1lBS3lsYVNVaTJHNWM0RUpGRWlG?=
 =?utf-8?B?K2xlQUhIRW1HOEw2a1dvaGg1MnBScTM1K2I1c0Q1NFljWHNEZUhHSEM4d2FN?=
 =?utf-8?B?b3FVc1Znd09GTFViT0NkYjFHUEVsUGlsK0JZT2hYQmpaOUFYUmlDbDBaQlo2?=
 =?utf-8?B?dzhxK1MvY1Z5cDZJY1cvdTh3SnhzVXY1eW5CRE9hT2lLYXdkNUhNVW9HR21J?=
 =?utf-8?B?Q0g3NDU0YzRySlJqRnFRTEgvRGdVNUdWSllFR0x5dnFnenhLK2MwQi9uR2Rq?=
 =?utf-8?B?bUNZc2JZTWp4Tk9NdE9rZHlhaU92RHhySjJ6bXhrSWVYamIzYStCclVlVUJD?=
 =?utf-8?B?d3BCelJueWVxbFI0UHVDVmo5V0hZc1VTcjUrMEx2VU4xUFNTWktwZ3dCNGxR?=
 =?utf-8?B?ZlR4NjF1b2hQeExPOVYwSVZjTVhkbUdRNnYwYmEzT1dUU2FjOG1JSlNHRTNZ?=
 =?utf-8?B?TzdZNjZzWlhvV1ZGa2E2ZFRFdEMydlNsV2daQ1pJSTNxUlE0N0Y0cFFKRWxk?=
 =?utf-8?B?SzV0VlZsWjJzMGVnWVk0dXQ4YzlMSFFvZ3JaTU1sMFJsbXd0bmlkMUtjQXBz?=
 =?utf-8?B?THIxeHdXSDhFTDdEM0p4L1BtN3UwYlgwZXdqZFY3UG02Qm9BNS9PUDFsWHgz?=
 =?utf-8?B?UU1uVHlFWkRrcFlZYk1QV2t1UkhhTGxpZmp6VEhPYkY1bHowU2taMVk5UjZU?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <453450F7EEACC044B284AAE3F6EE0550@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb0dbb6-8dd0-433f-f9d0-08db3464a1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 16:58:22.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf4Bh3PgYuZb/1ZnSFc+j7j59fhl98N1JnlEItZLoOjiQe2EffsWu1D3IA3p0ydBw935sqPFzAN4eML7qZkuFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTMwIGF0IDE0OjQ0IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToKPiBDdXJyZW50bHkgY291bnRlcnMgYXJlIG9ubHkgY2FwdHVyZWQgZHVyaW5nIHN1c3BlbmQg
d2hlbiB0aGUKPiB3YXJuX29uX3MwaXhfZmFpbHVyZXMgbW9kdWxlIHBhcmFtZXRlciBpcyBzZXQu
Cj4gCj4gSW4gb3JkZXIgdG8gcmVsYXkgdGhpcyBjb3VudGVyIGluZm9ybWF0aW9uIHRvIHRoZSBr
ZXJuZWwgcmVwb3J0aW5nCj4gaW5mcmFzdHJ1Y3R1cmUgYWRqdXN0IGl0IHNvIHRoYXQgdGhlIGNv
dW50ZXJzIGFyZSBhbHdheXMgY2FwdHVyZWQuCj4gCj4gd2Fybl9vbl9zMGl4X2ZhaWx1cmVzIHdp
bGwgYmUgdXRpbGl6ZWQgc29sZWx5IGZvciBtZXNzYWdpbmcgYnkKPiB0aGUgZHJpdmVyIGluc3Rl
YWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2ll
bGxvQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRGF2aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51
eC5pbnRlbC5jb20+Cgo+IC0tLQo+IHY0LT52NToKPiDCoCogU3F1YXNoIHBhdGNoZXMgdG9nZXRo
ZXIKPiDCoCogQWRkIGV4dHJhIHBtX3N1c3BlbmRfdmlhX2Zpcm13YXJlKCkgY2hlY2sgZm9yIHJl
c3VtZSByb3V0aW5lIHRvbwo+IC0tLQo+IMKgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1j
L2NvcmUuYyB8IDEzICsrKysrLS0tLS0tLS0KPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVs
L3BtYy9jb3JlLmggfMKgIDIgLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
aW50ZWwvcG1jL2NvcmUuYwo+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUu
Ywo+IGluZGV4IDNhMTVkMzJkNzY0NC4uZTJmMTcxZmFjMDk0IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMKPiArKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gQEAgLTExNjgsMTIgKzExNjgsNiBAQCBzdGF0aWMgX19t
YXliZV91bnVzZWQgaW50IHBtY19jb3JlX3N1c3BlbmQoc3RydWN0Cj4gZGV2aWNlICpkZXYpCj4g
wqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHBtY2Rldi0+Y2hlY2tfY291bnRlcnMg
PSBmYWxzZTsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgLyogTm8gd2FybmluZ3Mgb24gUzBpeCBmYWls
dXJlcyAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmICghd2Fybl9vbl9zMGl4X2ZhaWx1cmVzKQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiAtCj4gwqDCoMKgwqDCoMKg
wqDCoC8qIENoZWNrIGlmIHRoZSBzeXNwZW5kIHdpbGwgYWN0dWFsbHkgdXNlIFMwaXggKi8KPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKHBtX3N1c3BlbmRfdmlhX2Zpcm13YXJlKCkpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiBAQCAtMTE4Niw3ICsxMTgwLDYgQEAg
c3RhdGljIF9fbWF5YmVfdW51c2VkIGludCBwbWNfY29yZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UK
PiAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocG1jX2NvcmVfZGV2X3N0YXRlX2dldChwbWNk
ZXYsICZwbWNkZXYtPnMwaXhfY291bnRlcikpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVJTzsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHBtY2Rldi0+Y2hlY2tfY291
bnRlcnMgPSB0cnVlOwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IEBA
IC0xMjIyLDEyICsxMjE1LDE2IEBAIHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgcG1jX2NvcmVf
cmVzdW1lKHN0cnVjdAo+IGRldmljZSAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1
Y3QgcG1jX2JpdF9tYXAgKiptYXBzID0gcG1jZGV2LT5tYXAtPmxwbV9zdHM7Cj4gwqDCoMKgwqDC
oMKgwqDCoGludCBvZmZzZXQgPSBwbWNkZXYtPm1hcC0+bHBtX3N0YXR1c19vZmZzZXQ7Cj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqBpZiAoIXBtY2Rldi0+Y2hlY2tfY291bnRlcnMpCj4gK8KgwqDCoMKg
wqDCoMKgLyogQ2hlY2sgaWYgdGhlIHN5c3BlbmQgdXNlZCBTMGl4ICovCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHBtX3N1c3BlbmRfdmlhX2Zpcm13YXJlKCkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBtY19jb3Jl
X2lzX3MwaXhfZmFpbGVkKHBtY2RldikpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gMDsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmICghd2Fybl9vbl9zMGl4X2ZhaWx1
cmVzKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArCj4gwqDC
oMKgwqDCoMKgwqDCoGlmIChwbWNfY29yZV9pc19wYzEwX2ZhaWxlZChwbWNkZXYpKSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBTMGl4IGZhaWxlZCBiZWNhdXNlIG9mIFBD
MTAgZW50cnkgZmFpbHVyZSAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2
X2luZm8oZGV2LCAiQ1BVIGRpZCBub3QgZW50ZXIgUEMxMCEhISAoUEMxMCBjbnQ9MHglbGx4KVxu
IiwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuaAo+
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuaAo+IGluZGV4IDgxMDIwNGQ3
NThhYi4uNTFkNzNlZmNlYWYzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2lu
dGVsL3BtYy9jb3JlLmgKPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29y
ZS5oCj4gQEAgLTMxOSw3ICszMTksNiBAQCBzdHJ1Y3QgcG1jX3JlZ19tYXAgewo+IMKgICogQHBt
Y194cmFtX3JlYWRfYml0OsKgZmxhZyB0byBpbmRpY2F0ZSB3aGV0aGVyIFBNQyBYUkFNIHNoYWRv
dyByZWdpc3RlcnMKPiDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdXNlZCB0byByZWFkIE1QSFkgUEcgYW5kIFBMTCBzdGF0dXMgYXJlIGF2YWlsYWJsZQo+IMKg
ICogQG11dGV4X2xvY2s6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtdXRleCB0byBj
b21wbGV0ZSBvbmUgdHJhbnNjYXRpb24KPiAtICogQGNoZWNrX2NvdW50ZXJzOsKgwqDCoMKgT24g
cmVzdW1lLCBjaGVjayBpZiBjb3VudGVycyBhcmUgZ2V0dGluZyBpbmNyZW1lbnRlZAo+IMKgICog
QHBjMTBfY291bnRlcjrCoMKgwqDCoMKgwqBQQzEwIHJlc2lkZW5jeSBjb3VudGVyCj4gwqAgKiBA
czBpeF9jb3VudGVyOsKgwqDCoMKgwqDCoFMwaXggcmVzaWRlbmN5IChzdGVwIGFkanVzdGVkKQo+
IMKgICogQG51bV9scG1fbW9kZXM6wqDCoMKgwqDCoENvdW50IG9mIGVuYWJsZWQgbW9kZXMKPiBA
QCAtMzM4LDcgKzMzNyw2IEBAIHN0cnVjdCBwbWNfZGV2IHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50
IHBtY194cmFtX3JlYWRfYml0Owo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbXV0ZXggbG9jazsg
LyogZ2VuZXJpYyBtdXRleCBsb2NrIGZvciBQTUMgQ29yZSAqLwo+IMKgCj4gLcKgwqDCoMKgwqDC
oMKgYm9vbCBjaGVja19jb3VudGVyczsgLyogQ2hlY2sgZm9yIGNvdW50ZXIgaW5jcmVtZW50cyBv
biByZXN1bWUgKi8KPiDCoMKgwqDCoMKgwqDCoMKgdTY0IHBjMTBfY291bnRlcjsKPiDCoMKgwqDC
oMKgwqDCoMKgdTY0IHMwaXhfY291bnRlcjsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IG51bV9scG1f
bW9kZXM7Cgo=
