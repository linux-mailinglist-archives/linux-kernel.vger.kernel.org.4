Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81A57260B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbjFGNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbjFGNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:09:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95852A6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686143388; x=1717679388;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JYW5kGzcUHekHWb33WzHVELrIkWfFOv50dLpcfod23A=;
  b=dM+xy/9PpjKv0NWRuAwGM9N5fr9P4Btz3DLuYlav33yMA98Qx+LlvSmH
   A2jPlMK50mWA7ghQ/02l7JOJldGmQLS61v6Ig679WaCHGiYmYgqQQviBB
   T8BJQNm1ocbNHpRZj0thwSWdK2OqytsWOUeUHigp6P5ksYp1TjrtKoTXl
   bHygB7h2GcNqBA00k6Pb8wic/Ox0Jcwn6wtZ4ozxofIpVXhNtU0GQtbJF
   Qq7R5BUD0Q8bshMGH4dpCcFWX0TMn9sW3ZJJDj5tI3qqnjDHzWrD9iYdq
   2biI8WB+4rJVHHzUo1yYgiyjwKmGzeY07OQ64bzvtpBesJXt6l4yBe5bT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385299590"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="385299590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 06:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883783038"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="883783038"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 06:09:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 06:09:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 06:09:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 06:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmsUgyZDkoc1q2fxgoFxL4PbxOFtNyzoVnruy/AwiBm7db2DCUipVXceACJbxmdEg13omIThCGTKNKLXSsmn/RNExyOPABS6x2RvEjEVYdeh3dV2VaLYi6m06EuGgC105hFW+UORGPsu8UyEc+Yb5ZC/Jr7sPAlGVrYrxs8rJB3TFlLSNWRsQHcrNwuBVcilDPzyxE6VFkiookCC0LOBGJd4PhfRLuV78VBlxPYEbtJ93wlzDFID1Pua7VwPQPgSM4KUHPelpJcdYKsahazZoCSCEEvuGhxw5UBM8qfkSrTkuQYjgF1hy5aRG6/Danxb168nJ6QwArzlnPOoZ4B/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYW5kGzcUHekHWb33WzHVELrIkWfFOv50dLpcfod23A=;
 b=ky+qQlp6CsQCP1Gy9qbSSu6v/Oc/pi3DBqeSmFuk2HkoIWDxDXJ0VEOEbYSCLB/YU2VonbjqOb9iimdvKdHxsmI0cjZjF56MDUluqgMo/XCrpLZaJ5nvNm0dGJQpcoo7pBo4q1mm+8RGtP0HM95RICzHaF0S3jQ4PdwGIkSFY12uBfvYw8PY36O5U4R6VU0IVsZ+l4dsJcnqK2202eveG6P0H/CQx3EB3ecBonH1aw9xmN+GGYo8Kw+NQwpjhoTBFGpfgauazNMylpQfpf+534sN9BLHzKuCFLrjyUFtwIk6DlvYobd1AUoZHJQpqY/w9YnzCZt9T9kaLENcFYMQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:09:44 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 13:09:44 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Topic: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Index: AQHZmHGkJHNK5LCThUOCQcp+9xZgea9+JvKAgAAJdwCAAR6ZsA==
Date:   Wed, 7 Jun 2023 13:09:44 +0000
Message-ID: <SN7PR11MB7590BF4A53EA329C3B5FF031E153A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606124939.93561-1-yu.ma@intel.com>
 <20230606192013.viiifjcgb6enyilx@revolver>
 <20230606195406.smed5heroqbpghcx@revolver>
In-Reply-To: <20230606195406.smed5heroqbpghcx@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|CY8PR11MB6937:EE_
x-ms-office365-filtering-correlation-id: 35fad3fa-8552-4833-5cd4-08db6758764b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WuBs2bVJAWSFc78FdYO9Jx2tzOs7mqDAxjw6oVc7a5cctIX1ciFePtUaBRcAwZZ9RpLEAisp/iWqo90Galz72KNX2U5fl5YozICex+KqCJ3UJ6+jBj2RSraKU31twnuly0sRe//Ii1uNP3JXPwoO5g7tptpwWhVbyoE5wUiGc1CbiNRtg4LRtWSDZ5iHvqB3RTuPwL+rdlD8U6xBesnCfsBftEvCGldtJXicat0pKdijX5rbYyMd7BX+cGtY/xGcx08RDnuQjfIgI/fPQolMmRIjwOWwvXDVFrD170jVJWnWcbCrafYsrto3VOMQnZ5LtEPZDLFyd+hmmxTCzqQ7zEnilQwcBgbCpHeAq1N3pYi1l0tdGuCXrIRthj4B/erhRaWz7SiDtPjuN5Jvnc6sjZxy+IVPnLEAudNPLMmDN/fIgwud4j5WUT8tVjj/kMnxJEAnwJvXtdGdlu6mE/tglNx7m8AGL3gCKdrLFCd+16Bi32MbtHqD3BXOfaMn7d0rs2ufiUlWOVL6KF/4hF93zZwuwIrBfzbpG7y0igdxqcocXGe/gGDRNvYtnL+hueCt82R4iXr8ReMPP2ob9UkS9hNbSSCwcWxOx+qTQV8JOdJb0NGYIOpn4gw6yDygxolz2t5FWnEi4moW46awkOQQoqrpRCmsShDU6xa+UAgxf80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(110136005)(71200400001)(478600001)(52536014)(8936002)(66556008)(8676002)(2906002)(5660300002)(33656002)(38070700005)(86362001)(64756008)(122000001)(66446008)(76116006)(66476007)(66946007)(921005)(316002)(82960400001)(55016003)(38100700002)(6506007)(41300700001)(9686003)(83380400001)(966005)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEQ3KzRod2JKUE5OSVJIYXBhdzlkWUh6VjNZSHUxYkIwUUxTS1BKaHNUL1Zx?=
 =?utf-8?B?UkFsblVQVVRPZWVwNnZCWU9ickYrWmtURkFlYnZEMy8yQWpndTVCVS95cFI3?=
 =?utf-8?B?RTA5d2RzZU9hUFpVZTF3blNUeDQ5M1pHZ2FtWmcweXJjdGM0dVlDeGNmREZE?=
 =?utf-8?B?YUNRTmhuOEVCeklvT1hFQUtxU2xlVHNlQWxrbHZqSEN3a2Q3aVBpOWFhNGQ1?=
 =?utf-8?B?MVVxcmdoNzFBeHo1bkhPZVU1WEUwTENvdWVvVTVoREFPWlBpSnVSTStkOW1n?=
 =?utf-8?B?cmNWR1htb3ZxUUdmemdYQjNXcG1ud0ZPa3ZmVmNOc3ZsdlRRNUNsNWhNS3B4?=
 =?utf-8?B?aktESlBqSkJMRnJPSHl3bU5uYzNYRFRFanNvQUszUU5EVlB1RDUwcDhaeGRP?=
 =?utf-8?B?c2IrRWVDVzRWOWJpYXNxWFRIYm93KzNkMlZHM1QzN2tRTElPbHFnQjhlaGxL?=
 =?utf-8?B?Q3A1U0pIWGcwaC9mYStBUTY0endvaXp3ZEYxRlFLaXBGM2toZnVZQnNlZzFF?=
 =?utf-8?B?T04xMDVDWnlGSW1pNEdONFl1OXZKRlpTZEllZk5OWGllWVdOZlU4amxXQnB3?=
 =?utf-8?B?U2lFVEYzTE15cXd5WHY5Vlh5MEw3QmY2RzBHb0ZZcEtWNFVhOUdzQllNWXBo?=
 =?utf-8?B?aXZoZVJ6ZHV6NVYwdXN3aHJFWWU3ZWFjMmlsemNGN2k2Wk9HQ1g2d0hEVEhi?=
 =?utf-8?B?UmRXbTBvSHo2RW9WWkhVUk1RbFY1dEVDazFiSXcwOFp1eU9CRUR1cTEzU3pT?=
 =?utf-8?B?aDBYV095TVBuWStsc3IrVmJvRWdnaEFKaWVUL2lTQmdpUlI3MnQ5N09zMjlC?=
 =?utf-8?B?ZktqWkhLU0UrcFlFWEROVktzSVh4UGtzeUJIbFZTNUZ6VXc1aVRrbGh5WVVq?=
 =?utf-8?B?NGd5K3B2YnZjVHMwVUJBK25KLzhhblJqU0JiVnFTM09FTnFBcXZ4QnNBWitW?=
 =?utf-8?B?OVpzWXFqQURubGJjVVRrWjVscGIxQ1ZmeDNJbFR6RDFRQTk1SGxjMnhHWDAw?=
 =?utf-8?B?MUR5VWw3NW5pRWxJcWRPQUFyZTBYUkNCRm5UaXNld0R3cFpHYWRFRFQ5WVlw?=
 =?utf-8?B?SzczbHBsTFJ5ejZpQ3pHNjdLeWdkVWQra3NKSGZpSENWSkdDWEFDN2pkQmlX?=
 =?utf-8?B?aFAxZmUrS291L1FldjJPQ3hUdGZxVE9tbDAzVnhzeVVoLzJ1OWllanI5RnJS?=
 =?utf-8?B?MlJtRzFmeHNwejBkR1ZxRUlGVTNvakdHcFpzUml5Z0ZncjBJRlpnSnF3Sjlt?=
 =?utf-8?B?cEkwTnM0VldvTFZvT3QweVF5R0hJMklEeGhJWlIwV3ROOVZMdE9aa2hhcFlS?=
 =?utf-8?B?c2VhVlRjQ2J6MmxOK1pXRGtaVHhQN0c0U3pXZjBQaUthL3VtRDQ2UmdIWEpT?=
 =?utf-8?B?bGl5MS9DMm9IWlRZMFFQN2JZMkxORzVZWktWMnhnZnBZRVV3STU4K1RBdDVh?=
 =?utf-8?B?ZDdXMjVNRnZMWlJETlJFT1RDZHdUeEFiWXZXdlZkNThUSDNEbGlQS1pBajRK?=
 =?utf-8?B?UzR4MjlmZE8vK3dIZmtwTE8zSkUyS1psM1gwUGd4azlWNUNGMlRSVmIyYWVX?=
 =?utf-8?B?NENReStMbkhXYWQ4R1Vua2pRbFE1emwvY25oYkVSRnVXQ2ZoYXVUV1VCeVJi?=
 =?utf-8?B?N0lMMGYza0tHV1NKMTJXb3VvK0JUbDhIamk5bGJ3VkhtZXVoUG9aTnoxV1VX?=
 =?utf-8?B?ZDZpRHZSM0RxQnlyTjhSdm4xU1dpZDJKOXl6Ni9TTFg2YWQvL1FZblNQV0g5?=
 =?utf-8?B?OFBTRm5oZTFpWEJBdjEvQ1BBZ1B1cFlWaVFmeDVnVjJPdlBrTS9ZcStYR0d4?=
 =?utf-8?B?QlhEWXpQK0x5bGJwOS8rRkY5L0xhYzJyaE16WGRTTWdZNmkrZjJpTjlzTU9N?=
 =?utf-8?B?aURtVDRELzJjdzM1YXc2QUZQbndIK0NUa0hNUk1OdGRTZ1ZlOERjNjllUVJQ?=
 =?utf-8?B?b0JwQ2dwRHdtWlVhZjFYSXRDRmx4eVE4anNpbDZxdzFsUWFpRmNVK2cwakN0?=
 =?utf-8?B?UkpURFNlYUwzY1Ywd2ZQNVJTaWV2Rm1GN3Fwd0xjdTExYjVISTU0eCtPVVBy?=
 =?utf-8?B?WG5CYnE3UzNnR0hhaUt6S25Dbk9pdFIvUXhkQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fad3fa-8552-4833-5cd4-08db6758764b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 13:09:44.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQzk7cUZpDdnG2/dOFSLfSsPgtJ7MjcF4G3usiXLl7D7WHaHivZJYFSDL6bCcZm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAqIExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5jb20+IFsyMzA2MDYgMTU6
MjBdOg0KPiA+ICogWXUgTWEgPHl1Lm1hQGludGVsLmNvbT4gWzIzMDYwNiAwODoyM106DQo+ID4g
PiBVbml4QmVuY2gvRXhlY2wgcmVwcmVzZW50cyBhIGNsYXNzIG9mIHdvcmtsb2FkIHdoZXJlIGJh
c2ggc2NyaXB0cw0KPiA+ID4gYXJlIHNwYXduZWQgZnJlcXVlbnRseSB0byBkbyBzb21lIHNob3J0
IGpvYnMuIFdoZW4gcnVubmluZyBtdWx0aXBsZQ0KPiA+ID4gcGFyYWxsZWwgdGFza3MsIGhvdCBv
c3FfbG9jayBpcyBvYnNlcnZlZCBmcm9tIGRvX21tYXAgYW5kIGV4aXRfbW1hcC4NCj4gPiA+IEJv
dGggb2YgdGhlbSBjb21lIGZyb20gbG9hZF9lbGZfYmluYXJ5IHRocm91Z2ggdGhlIGNhbGwgY2hh
aW4NCj4gPiA+ICJleGVjbC0+ZG9fZXhlY3ZlYXRfY29tbW9uLT5icHJtX2V4ZWN2ZS0+bG9hZF9l
bGZfYmluYXJ5Ii4gSW4NCj4gPiA+IGRvX21tYXAsaXQgd2lsbCBjYWxsIG1tYXBfcmVnaW9uIHRv
IGNyZWF0ZSB2bWEgbm9kZSwgaW5pdGlhbGl6ZSBpdA0KPiA+ID4gYW5kIGluc2VydCBpdCB0byB2
bWEgbWFpbnRhaW4gc3RydWN0dXJlIGluIG1tX3N0cnVjdCBhbmQgaV9tbWFwIHRyZWUNCj4gPiA+
IG9mIHRoZSBtYXBwaW5nIGZpbGUsIHRoZW4gaW5jcmVhc2UgbWFwX2NvdW50IHRvIHJlY29yZCB0
aGUgbnVtYmVyIG9mDQo+ID4gPiB2bWEgbm9kZXMgdXNlZC4gVGhlIGhvdCBvc3FfbG9jayBpcyB0
byBwcm90ZWN0IG9wZXJhdGlvbnMgb24gZmlsZeKAmXMNCj4gPiA+IGlfbW1hcCB0cmVlLiBGb3Ig
dGhlIG1tX3N0cnVjdCBtZW1iZXIgY2hhbmdlIGxpa2Ugdm1hIGluc2VydGlvbiBhbmQNCj4gPiA+
IG1hcF9jb3VudCB1cGRhdGUsIHRoZXkgZG8gbm90IGFmZmVjdCBpX21tYXAgdHJlZS4gTW92ZSB0
aG9zZQ0KPiA+ID4gb3BlcmF0aW9ucyBvdXQgb2YgdGhlIGxvY2sncyBjcml0aWNhbCBzZWN0aW9u
LCB0byByZWR1Y2UgaG9sZCB0aW1lIG9uIHRoZQ0KPiBsb2NrLg0KPiA+ID4NCj4gPiA+IFdpdGgg
dGhpcyBjaGFuZ2UsIG9uIEludGVsIFNhcHBoaXJlIFJhcGlkcyAxMTJDLzIyNFQgcGxhdGZvcm0s
IGJhc2VkDQo+ID4gPiBvbiB2Ni4wLXJjNiwgdGhlIDE2MCBwYXJhbGxlbCBzY29yZSBpbXByb3Zl
cyBieSAxMiUuIFRoZSBwYXRjaCBoYXMNCj4gPiA+IG5vIG9idmlvdXMgcGVyZm9ybWFuY2UgZ2Fp
biBvbiB2Ni40LXJjNCBkdWUgdG8gcmVncmVzc2lvbiBvZiB0aGlzDQo+ID4gPiBiZW5jaG1hcmsg
ZnJvbSB0aGlzIGNvbW1pdA0KPiBmMWE3OTQxMjQzYzEwMmE0NGU4ODQ3ZTNiOTRmZjRmZjNlYzU2
ZjI1DQo+ID4gPiAobW06IGNvbnZlcnQgbW0ncyByc3Mgc3RhdHMgaW50byBwZXJjcHVfY291bnRl
cikuDQo+ID4NCj4gPiBJIGRpZG4ndCB0aGluayBpdCB3YXMgc2FmZSB0byBpbnNlcnQgYSBWTUEg
aW50byB0aGUgVk1BIHRyZWUgd2l0aG91dA0KPiA+IGhvbGRpbmcgdGhpcyB3cml0ZSBsb2NrPyAg
V2Ugbm93IGhhdmUgYSB3aW5kb3cgb2YgdGltZSB3aGVyZSBhIGZpbGUNCj4gPiBtYXBwaW5nIGRv
ZXNuJ3QgZXhpc3QgZm9yIGEgdm1hIHRoYXQncyBpbiB0aGUgdHJlZT8gIElzIHRoaXMgYWx3YXlz
DQo+ID4gc2FmZT8gIERvZXMgdGhlIGxvY2tpbmcgb3JkZXIgaW4gbW0vcm1hcC5jIG5lZWQgdG8g
Y2hhbmdlPw0KPiANCj4gU28gSSdtIHByZXR0eSBzdXJlIGl0J3Mgbm90IHNhZmUgYmVjYXVzZSB3
ZSd2ZSBiZWVuIGVuc3VyaW5nIHRoYXQgdGhpcyBsb2NrDQo+IHdhcyB0YWtlbiBkdXJpbmcgdm1h
IHRyZWUgaW5zZXJ0cyBzaW5jZSAyMDAyIFsxXS4gIFRha2UgYSBsb29rIGF0DQo+IHZtYV9saW5r
KCkgaW4gdGhhdCBjb21taXQuICBJIHN0aWxsIGRvbid0IGhhdmUgYW4gYW5zd2VyIGFzIHRvIHdo
eSBpdCdzIG5vdCBzYWZlDQo+IHRob3VnaC4NCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20v
bXBlL2xpbnV4LQ0KPiBmdWxsaGlzdG9yeS9jb21taXQvYmJiY2U4ZjQxZDNkYTBhYzk2OGJhYjdh
OTY3ZTEyZTJiZTFhN2ViMA0KPiANCg0KVGhhbmtzIExpYW0gZm9yIHlvdXIgcXVpY2sgcmV2aWV3
IGFuZCBkaWdnaW5nIGluIHJlbGF0ZWQgY29kZS4gSSBqdXN0IGNoZWNrZWQgdm1hX2xpbmsoKSBp
biAyMDAyLCB0aGUgZmlsZSBsb2NrIGlzIHRoZXJlIHRvIHByb3RlY3QgX192bWFfbGluaygpLCBh
bmQgaW4gX192bWFfbGluaygpLCB0aGVyZSBhcmUgMyBmdW5jdGlvbnMsIHRoZSBmaXJzdCAyIGFy
ZSBvcGVyYXRpb25zIHRvIGluc2VydCB2bWEgdG8gbW1fc3RydWN0LCBhbmQgdGhlIGxhc3QgZnVu
YyBfX3ZtYV9saW5rX2ZpbGUoKSBpcyB0byBpbnNlcnQgdm1hIHRvIHRoZSBmaWxlIG1hcHBpbmcg
dHJlZS4gU28gdGhpcyBmaWxlIGxvY2sgYXJvdW5kIF9fdm1hX2xpbmsoKSBtYWtlcyBzZW5zZSBz
aW5jZSBpdCBoYXMgb3BlcmF0aW9ucyBvZiBmaWxlIG1hcHBpbmcgdHJlZSBpbnNpZGUuIEl0IHN0
aWxsIGNhbm5vdCBleHBsYWluIHdoeSB0aGUgb3BlcmF0aW9ucyB0byBtbV9zdHJ1Y3QgY2Fubm90
IGJlIG1vdmVkIG91dC4NCg0KPiA+DQo+ID4gPlJlbGF0ZWQgZGlzY3Vzc2lvbiBhbmQgY29uY2x1
c2lvbg0KPiA+ID4gY2FuIGJlIHJlZmVycmVkIGF0IHRoZSBtYWlsIHRocmVhZCBpbml0aWF0ZWQg
YnkgMGRheSBhcyBiZWxvdzoNCj4gPiA+IExpbms6DQo+ID4gPmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW1tL2E0YWEyZTEzLTcxODctNjAwYi1jNjI4LQ0KPiA3ZThmYjEwOGRlZjANCj4g
PiA+QGludGVsLmNvbS8NCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIGEgY29uY2x1c2lvbiBvbiB0aGF0
IHRocmVhZCB0YWxraW5nIGFib3V0IGNoYW5naW5nIHRoZQ0KPiA+IGxvY2tpbmcgb3JkZXI/DQpJ
IG1heSBub3QgaW50cm8gdGhpcyBsaW5rIGNsZWFyLCBpdCBpcyBhYm91dCB3aHkgbm8gb2J2aW91
cyBpbXByb3ZlbWVudCBvYnNlcnZlZCBvbiBsYXRlc3Qga2VybmVsIGZvciB0aGUgdGltZSBiZWlu
ZyA6KQ0KDQo+ID4NCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogVGltIENoZW4gPHRpbS5jLmNo
ZW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXUgTWEgPHl1Lm1hQGlu
dGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIG1tL21tYXAuYyB8IDQgKy0tLQ0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvbW0vbW1hcC5jIGIvbW0vbW1hcC5jDQo+ID4gPiBpbmRleCAxMzY3OGVk
YWEyMmMuLjBlNjk0YTA0MzNiYyAxMDA2NDQNCj4gPiA+IC0tLSBhL21tL21tYXAuYw0KPiA+ID4g
KysrIGIvbW0vbW1hcC5jDQo+ID4gPiBAQCAtMjcxMSwxMiArMjcxMSwxMCBAQCB1bnNpZ25lZCBs
b25nIG1tYXBfcmVnaW9uKHN0cnVjdCBmaWxlICpmaWxlLA0KPiB1bnNpZ25lZCBsb25nIGFkZHIs
DQo+ID4gPiAgCWlmICh2bWFfaXRlcl9wcmVhbGxvYygmdm1pKSkNCj4gPiA+ICAJCWdvdG8gY2xv
c2VfYW5kX2ZyZWVfdm1hOw0KPiA+ID4NCj4gPiA+IC0JaWYgKHZtYS0+dm1fZmlsZSkNCj4gPiA+
IC0JCWlfbW1hcF9sb2NrX3dyaXRlKHZtYS0+dm1fZmlsZS0+Zl9tYXBwaW5nKTsNCj4gPiA+IC0N
Cj4gPiA+ICAJdm1hX2l0ZXJfc3RvcmUoJnZtaSwgdm1hKTsNCj4gPiA+ICAJbW0tPm1hcF9jb3Vu
dCsrOw0KPiA+ID4gIAlpZiAodm1hLT52bV9maWxlKSB7DQo+ID4gPiArCQlpX21tYXBfbG9ja193
cml0ZSh2bWEtPnZtX2ZpbGUtPmZfbWFwcGluZyk7DQo+ID4gPiAgCQlpZiAodm1hLT52bV9mbGFn
cyAmIFZNX1NIQVJFRCkNCj4gPiA+ICAJCQltYXBwaW5nX2FsbG93X3dyaXRhYmxlKHZtYS0+dm1f
ZmlsZS0+Zl9tYXBwaW5nKTsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4zOS4zDQo+ID4gPg0K
PiA+ID4NCg==
