Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831916EF58C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbjDZNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjDZNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:32:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419702701;
        Wed, 26 Apr 2023 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682515950; x=1714051950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eFbOqc6Ao0GwyziNql2BnsUO+Bmk49lX84x3dKrsOgo=;
  b=KNCVtMhvhkphtLZDpEbbv+iq9bIG69KZWQe7tSTaC3/LiomQ7bphvQEE
   amvM0mC53Y06bvcH2OM+WJHV01KL0s78lbhidduqen4X8Vk7+v+XcsNFN
   YqsFUBVVKWtoKpXj2l6UzI0G2d5h7xqzZstxY3d7cucmktEzzsilN6Pz7
   5GTUpk4YW33eLQxAhGp6nS1qTEYi4urZJ2YMsbjoxyp7Rm9nQ9JkgK5bM
   ch8WFxZ9b7hpx4IQ5AgytR67nI46jXvxR5i9SygMFyx6mjQoSdXn07DPc
   9KVUuRrikL1B7AJFDvcpzUP3yk7h0Alf7Lauxa0i3V9piHk/dVmgaP3mf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="326707778"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="326707778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 06:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="644252975"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="644252975"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2023 06:32:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 06:32:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 06:32:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 06:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIehRUDNE9r6V+nvUsGsa9TFbF8ZNqB1flkNrmTHcsSseXAyER4euQWPMR3E3G4jxeeyQzyQAkz1lkL6i09WpteoOKuru6NHK1SIvEA97ckOCbYoRh+sET3PV2NcGPRMFEX5aQfNI5woMGXLF01SXT2aB9/2oRXruwYgU25aC6XcuPYxFOQBnRCTDF8rtu5iYQnk4XfQNXY4mvHa9U5gthimQ9N82VTexx4fFo6YX1E+u4Wy4bXpvi4EVXQl9i6x87uRHNRPwCLm7GT3m3EQNAz73BXwO6vh+q19lTHJ2OTIF2Y11O61m9nExQHL408uRtqhP8n+bLajyCmAR4X67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFbOqc6Ao0GwyziNql2BnsUO+Bmk49lX84x3dKrsOgo=;
 b=KqWbDnfvMen3aFDbB7JkNoJf84Vy/y6rmY2z9BjF9PgN6eg0HFaAYchyDDd0+OfRrXHO69Efx8zIZQ35EeoEmSVwjANSHZpKW9hTLrk3lB6ydZ9pVZXK4ZFX1yP9RCf6LHCL5mBa4VqOupzCB/EYenRwONj0xBWqBlHJpv8SCO//FPDVrsHVGtmsAnO5vNmM3XFCvKJsw5sV+jTLbBICqKXm2AGDNE0VJ6HflNnBk/pbYkfTaNP5Av+XmXOfB+3uT42oiAl4muqorkP7uGvD2D8mUWwdS7tYpLc7/ECfGymVBhn42xsogT8xEokGM/GzjhEZYW0+BhcxVgKyuJPnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.34; Wed, 26 Apr 2023 13:32:21 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::65f0:6a4e:8aac:3e3e%2]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:32:20 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: RE: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Topic: [PATCH] docs: security: Confidential computing intro and threat
 model
Thread-Index: AQHZYLcIL5h5EiW/WUeIdC3dxCgzQa88TIUAgAFu+xA=
Date:   Wed, 26 Apr 2023 13:32:20 +0000
Message-ID: <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
In-Reply-To: <ZEfrjtgGgm1lpadq@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CO1PR11MB4868:EE_
x-ms-office365-filtering-correlation-id: 863c86be-9f89-4b9d-bb62-08db465aa926
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFZvOq7Y9NO9NflkT7GIRKm6tOTNvZk3VcYGDgwJJcYckltHtb8zfzQ+ADXLpBqFyLEgIQ2lPH/evhf0zaA/mtjY1v/nYHDavE4WxqwDuc3NkoR+36xwWKQ+g7BLXMk14MoY1gk+L4mlKpO5i4PeLvulkzWLesLV8ChqhipBe1vktKIlTkd7UDEbFuj1jSqDDUshRjkuRIoNV+9J26QKC7lzIM5krTBFKSe8BxsjTKT5tumyYwMGrR5PBPcgJTa4bI2G0lpFmKbSZRuG09zGRqNLya7hkIEN+fnhMYSz2d7muiMPXXo8XxyEQgkVG6VGXP+eOZ2Rj/TmtNKijAoP/GA4Q8B5vDLMnaM9a0Im8OivYz05ylKKnGkLelaLP5WVt7/g1eyn8a7AtAQqV3ipCZyX2DVAfWvoxUV0uuHk9Wqhl+x1fSmQ2vqnFf1/xX/kDi+EiI/CQY5EHOC2T4KGTVHG5oGb14fDPUiIuY4SDcmm4Jt3yAkKIR5REWYJ13DG1jCPLWtTW4i9qNs4QaU7vOCWViwWi0Hd/CJy9dEYlzp2i7EsCpuBw8atq7ChAV1w1ECBkl3uOkppswFXDhAmU68Pa22oaaCxH9pCoGgROJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(66899021)(55016003)(186003)(54906003)(86362001)(478600001)(7696005)(110136005)(71200400001)(966005)(15650500001)(38100700002)(33656002)(316002)(52536014)(2906002)(7416002)(5660300002)(8936002)(8676002)(64756008)(4326008)(76116006)(66556008)(66446008)(66946007)(66476007)(122000001)(41300700001)(82960400001)(26005)(7406005)(38070700005)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2VkN1VuZVZsNWw2a0YrRTRqelJTQ0NDRFNQcFhNOXI4QWVjSXRJWmJ0YXMz?=
 =?utf-8?B?ajdBRXdWSER2Qm1yNzlUb2RibGkrWlFFSy9GNEFSNTcyZjRRLzZ2eWlBaWV3?=
 =?utf-8?B?My9nZFpGeTBRTXp3ckN2d0NDQjJlSE9Pdy9EVkZmVytCOTV3Zi9OcGxuK0Fk?=
 =?utf-8?B?NmtULzE3ekVQVkVuNmp2VW1La3FUcUhVc1JZTk5MUE40TEZrTU4weFRFTzda?=
 =?utf-8?B?MCt4S2JSZXVTdDYwajFoRmREVXpqS29ZOXJJMXd4M0xKdHZNdE43TzVGbjVp?=
 =?utf-8?B?S2UwYVFOYlY0ZXNpRXZDKzJ4aldVbFBRQ1RlSGVKSEpnbWEyY1JwaGFvMXlh?=
 =?utf-8?B?c21HS2xsQnQwRHZtY1FtSjR6bW0zZ0IzenRBcHJ6a2VKOTlwTzN5REUyQ1Ry?=
 =?utf-8?B?aFpudzQyRmdZd0cyVVJ2eGd2MzBudmNTNHNGRXNVZ2d6VUJKdDRydFN0Nk1p?=
 =?utf-8?B?YjRXYmgybEgzS2IwNG1RUWdFTmVLLzE1R21Xb0hPdVB0ODFPZW0zQVVNbURw?=
 =?utf-8?B?MWt1ZEN4K083M01qNVpKc0xSWXNWVHY0UlcwSklQVENQYzlnVTU3VXc0L2JM?=
 =?utf-8?B?eHFIMUt0UnVtcUNJZDY0NGJ6eFJJN2locmQ5WnZXbUJFbHFRRnBBVEpCbHl1?=
 =?utf-8?B?aWZqLzFkTmRJMEE3WmlybmRFT0I3TjhBbjRhZlI0eEVCOGMzTFI0cDl6S0lu?=
 =?utf-8?B?RkNlcmZnSHd1YTExMEkzdGdUK1NKQmdaYUpKS2JZSTh3WU9UekVBUzZHMkdK?=
 =?utf-8?B?c0VsYVFKbXR4Y0ZhWmZNbDh2SHpEWUUrT2d1QUJnSU1YNUFVRE9VVDRUdjJh?=
 =?utf-8?B?cjBBekt4ZVZ5RFlwSWxrM1hrTUYydUhvczgySTdkeE5tdEdnOHQzMVR4Y21G?=
 =?utf-8?B?WlBORHh2dXB2L2EvUXRhcTAwTUk2TXlKZ1FmeVVVT3lHQndnSzdDUUZoZHhj?=
 =?utf-8?B?UDlXb1phUU5neStRUkRDYkxlWnB6K05qUHVxV3ZaUCszaDZPMFIwTno3SFFu?=
 =?utf-8?B?OFFabmM2OFU4M3Vnei9oaTlLL3JJTUZjRzhDRGwyRDB2OU5TMzJVR1JPd1lQ?=
 =?utf-8?B?VTlUb3gzR1EvVGtZbURoQmt6NkpUZ0dJaVNrRlVYTWNYeGp6aTdGNHpRY1l0?=
 =?utf-8?B?VXg1Y3dxREZEcUczSkN3M0lLQm93aVNLTVpqWDlYUzB0azNXbXB1NWFOUEs5?=
 =?utf-8?B?UG9IVFkzQ0NmbEhWL0YzNG1pdFN1aWVpdXQ5MjIzdmkrWUpKSE9RQXZSQjQ5?=
 =?utf-8?B?Q2NZb28wTDJDMkUxaWs4N0lPYkFwaUV0RHQwRGNoOXViR2JzOTJRdzNyQXho?=
 =?utf-8?B?SldxNFBGeDJzUzVTdVJrelBnczNXZktKQ1FPZXAveUNIQ0hEck5qdUNxRzNz?=
 =?utf-8?B?MDIwVWx4U1ZEY0tkaWRjd3VEZjBoaDFmbjlzS2N6MkRFVTVQbHF5TjFsSy9Y?=
 =?utf-8?B?T0dnU1BPL1VLS2lzL2FrbHRrMmxYL3RMc29XTWN2U2ZNTmYwY1FoL1dvV1Ez?=
 =?utf-8?B?OTA1VGs0QWEwbUZ2SjFmZjlUWTg5UXBOa1ZOSm40eUFZazRPcGdQUHFrUzBq?=
 =?utf-8?B?TEhJeitGY2tQQndkbHU2cjNRczR2NncwUnBYOWZXRjZERFdPa054c0c4K2tL?=
 =?utf-8?B?VDQyY0M5Wk15SUxhNGUwbGRQbTlLYTMxaHJQZEtvcHdrUkdLZG12ODV6NG12?=
 =?utf-8?B?SURpdHA1cnJ6VjVQSU5Tc1BvSnFzSEQvZHdiUlJGdWdGR1pMRE8wR0FjSWE3?=
 =?utf-8?B?eXZOTEE2MXBvUHkrM1NkOTVTUm0wL3ZqczF3bEZJc0RuaXZvLzRJMUo2KzQr?=
 =?utf-8?B?UUo1cWJObjJBQ3AvczhjMHY2ZGFERXNaOGc5WExnblNremtvZEEzOWVjeXQr?=
 =?utf-8?B?WjNBSGhZc3p5MXhPM3l6c1pFQUtUUDJmUGl1Q3NUV3A0WU01cWxWUVBrbmR0?=
 =?utf-8?B?VXROODltdkZmcXBCODRjZDcxUFF4dWNOeUtudGNKc1Bxb1pYZzY1L0s0cjdT?=
 =?utf-8?B?WG90ZU1jZnFvZWxtb3JVSTBjZ1FVKzlKVlVsUW1tUzBmL3FrZTJoS0d6UGt6?=
 =?utf-8?B?M21YTWN5QWxraVZmVWdjY0daM3lHV0VjeFZ4a2xDSURyOFltTk1uS0FQMXgx?=
 =?utf-8?Q?ijwZP9AIpJkYxwr1Pl0kLGUim?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863c86be-9f89-4b9d-bb62-08db465aa926
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:32:20.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +H2JvYpG5IJGoNQ5Si4hQZzjBRjxXJdAgF6SLJTTXNJ6/EfwA40WsDoirrM2W5x3Kc282UQbiHa1cd1tWVlO1maF0I0f9b1IARTaOYuHylk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEhpIFNlYW4sIA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3ISBQbGVhc2Ugc2VlIG15IGNv
bW1lbnRzIGlubGluZS4gDQoNCj4gT24gTW9uLCBNYXIgMjcsIDIwMjMsIENhcmxvcyBCaWxiYW8g
d3JvdGU6DQo+ID4gK0tlcm5lbCBkZXZlbG9wZXJzIHdvcmtpbmcgb24gY29uZmlkZW50aWFsIGNv
bXB1dGluZyBmb3IgdGhlIGNsb3VkIG9wZXJhdGUNCj4gPiArdW5kZXIgYSBzZXQgb2YgYXNzdW1w
dGlvbnMgcmVnYXJkaW5nIHRoZSBMaW51eCBrZXJuZWwgdGhyZWF0IG1vZGVsIHRoYXQNCj4gPiAr
ZGlmZmVyIGZyb20gdGhlIHRyYWRpdGlvbmFsIHZpZXcuIEluIG9yZGVyIHRvIGVmZmVjdGl2ZWx5
IGVuZ2FnZSB3aXRoIHRoZQ0KPiA+ICtsaW51eC1jb2NvIG1haWxpbmcgbGlzdCBhbmQgY29udHJp
YnV0ZSB0byBpdHMgaW5pdGlhdGl2ZXMsIG9uZSBtdXN0IGhhdmUgYQ0KPiA+ICt0aG9yb3VnaCBm
YW1pbGlhcml0eSB3aXRoIHRoZXNlIGNvbmNlcHRzLiBUaGlzIGRvY3VtZW50IHByb3ZpZGVzIGEg
Y29uY2lzZSwNCj4gPiArYXJjaGl0ZWN0dXJlLWFnbm9zdGljIGludHJvZHVjdGlvbiB0byBoZWxw
IGRldmVsb3BlcnMgZ2FpbiBhIGZvdW5kYXRpb25hbA0KPiANCj4gSGVoLCB2ZW5kb3IgYWdub3N0
aWMgbWF5YmUsIGJ1dCBjZXJ0YWlubHkgbm90IGFyY2hpdGVjdHVyZSBhZ25vc3RpYy4NCg0KSSBn
dWVzcyBpdCBkZXBlbmRzIHdoZXJlIHlvdSBkcmF3IGEgZGlzdGluY3Rpb24gYmV0d2VlbiB2ZW5k
b3IgYW5kIGFyY2hpdGVjdHVyZS4gDQpXaGF0IHdhcyBtZWFudCBoZXJlIGlzIHRoYXQgd2UgdHJ5
IHRvIHdyaXRlIGRvd24gdGhlIG92ZXJhbGwgdGhyZWF0IG1vZGVsDQphbmQgaGlnaC1sZXZlbCBk
ZXNpZ24gdGhhdCBleGlzdGluZyB0ZWNobm9sb2dpZXMgdXNlIHRvZGF5LiANCkJ1dCBJIGRvbuKA
mXQgbWluZCBjaGFuZ2UgdG8gdmVuZG9yIGFnbm9zdGljLCBpZiBpdCBzZWVtcyBtb3JlIGNvcnJl
Y3QuIA0KDQo+IA0KPiA+ICt1bmRlcnN0YW5kaW5nIG9mIHRoZSBzdWJqZWN0Lg0KPiA+ICsNCj4g
PiArT3ZlcnZpZXcgYW5kIHRlcm1pbm9sb2d5DQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ICsNCj4gPiArQ29uZmlkZW50aWFsIENsb3VkIENvbXB1dGluZyAoQ29DbykgcmVmZXJz
IHRvIGEgc2V0IG9mIEhXIGFuZCBTVw0KPiANCj4gQXMgcGVyIERvY3VtZW50YXRpb24vc2VjdXJp
dHkvc2VjcmV0cy9jb2NvLnJzdCBhbmQgZXZlcnkgZGlzY3Vzc2lvbiBJJ3ZlDQo+IG9ic2VydmVk
LA0KPiBDb0NvIGlzIENvbmZpZGVudGlhbCBDb21wdXRpbmcuICAiQ2xvdWQiIGlzIG5vdCBwYXJ0
IG9mIHRoZSBkZWZpbml0aW9uLiAgVGhhdCdzDQo+IHRydWUgZXZlbiBpZiB0aGlzIGRpc2N1c3Np
b24gaXMgcmVzdHJpY3RlZCB0byBDb0NvIFZNcywgZS5nLiBzZWUgcEtWTS4NCg0KWWVzLCBJIHBl
cnNvbmFsbHkgbm90IHN1cmUgd2UgaGF2ZSBhIHNpbmdsZSBnb29kIHRlcm0gdG8gZGVzY3JpYmUg
dGhpcyBwYXJ0aWN1bGFyDQphbmdsZSBvZiBjb25maWRlbnRpYWwgY29tcHV0aW5nLiBHZW5lcmFs
bHkgQ29uZmlkZW50aWFsIENvbXB1dGluZyBjYW4gbWVhbg0KYW55IENvQ28gdGVjaG5vbG9neSwg
aW5jbHVkaW5nIHRoaW5ncyB0aGF0IGRvIG5vdCByZWxhdGUgdG8gdmlydHVhbGl6YXRpb24gKGxp
a2UgU0dYKS4NClRoaXMgZG9jdW1lbnQgZG9lc27igJl0IGF0dGVtcHQgdG8gY292ZXIgYWxsIENv
Q28sIGJ1dCBvbmx5IGEgc3Vic2V0IG9mIHRoZW0gdGhhdA0KcmVsYXRlcyB0byB2aXJ0dWFsaXph
dGlvbi4gQWNhZGVtaWEgcmVzZWFyY2hlcyBoYXZlIGJlZW4gdXNpbmcgdGVybSAiQ29uZmlkZW50
aWFsIENsb3VkDQpDb21wdXRpbmciIChxdWljayBzZWFyY2ggb24gZ29vZ2xlIHNjaG9sYXIgZ2l2
ZXMgcmVsZXZhbnQgcGFwZXJzKSwgc28gdGhpcyB3YXMNCmEgcmVhc29uIHRvIGFkYXB0IHRoaXMg
dGVybS4gSWYgeW91IGhhdmUgYSBiZXR0ZXIgcHJvcG9zYWwsIHBsZWFzZSB0ZWxsLiAgICANCg0K
PiANCj4gPiArdmlydHVhbGl6YXRpb24gdGVjaG5vbG9naWVzIHRoYXQgYWxsb3cgQ2xvdWQgU2Vy
dmljZSBQcm92aWRlcnMgKENTUHMpIHRvDQo+IA0KPiBBZ2FpbiwgQ29DbyBpc24ndCBqdXN0IGZv
ciBjbG91ZCB1c2UgY2FzZXMuDQoNClNlZSBhYm92ZS4gDQoNCj4gDQo+ID4gK3Byb3ZpZGUgc3Ry
b25nZXIgc2VjdXJpdHkgZ3VhcmFudGVlcyB0byB0aGVpciBjbGllbnRzICh1c3VhbGx5IHJlZmVy
cmVkIHRvDQo+ID4gK2FzIHRlbmFudHMpIGJ5IGV4Y2x1ZGluZyBhbGwgdGhlIENTUCdzIGluZnJh
c3RydWN0dXJlIGFuZCBTVyBvdXQgb2YgdGhlDQo+ID4gK3RlbmFudCdzIFRydXN0ZWQgQ29tcHV0
aW5nIEJhc2UgKFRDQikuDQo+IA0KPiBUaGlzIGlzIGluYWNjdXJhdGUsIHRoZSBwcm92aWRlciBt
YXkgc3RpbGwgaGF2ZSBzb2Z0d2FyZSBhbmQvb3IgaGFyZHdhcmUgaW4gdGhlDQo+IFRDQi4NCg0K
V2VsbCwgdGhpcyBpcyB0aGUgZW5kIGdvYWwgd2hlcmUgd2Ugd2FudCB0byBiZSwgdGhlIHByYWN0
aWNhbCBkZXBsb3ltZW50IGNhbg0KZGlmZmVyIG9mIGNvdXJzZS4gV2UgY2FuIHJlcGhyYXNlIHRo
YXQgaXQgImFsbG93cyB0byBleGNsdWRlIGFsbCB0aGUgQ1NQJ3MNCmluZnJhc3RydWN0dXJlIGFu
ZCBTVyBvdXQgb2YgdGVuYW50J3MgVENCLiIgDQoNCj4gDQo+IEFuZCBmb3IgdGhlIGNsb3VkIHVz
ZSBjYXNlLCBJIHZlcnksIHZlcnkgc3Ryb25nbHkgb2JqZWN0IHRvIGltcGx5aW5nIHRoYXQgdGhl
IGdvYWwNCj4gb2YgQ29DbyBpcyB0byBleGNsdWRlIHRoZSBDU1AgZnJvbSB0aGUgVENCLiAgR2V0
dGluZyBvdXQgb2YgdGhlIFRDQiBpcyB0aGUgZ29hbCBmb3INCj4gX3NvbWVfIENTUHMsIGJ1dCBp
dCBpcyBub3QgYSBmdW5kYW1lbnRhbCB0ZW5hbnQgb2YgQ29Dby4gIFRoaXMgdmlld3BvaW50IGlz
DQo+IGhlYXZpbHkNCj4gdGFpbnRlZCBieSBJbnRlbCdzIGFuZCBBTUQncyBjdXJyZW50IG9mZmVy
aW5ncywgd2hpY2ggZWZmZWN0aXZlbHkgZGlzYWxsb3cgdGhpcmQNCj4gcGFydHkgY29kZSBmb3Ig
cmVhc29ucyB0aGF0IGhhdmUgbm90aGluZyB0byBkbyB3aXRoIHNlY3VyaXR5Lg0KPiANCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1krYVA4ckhyNkgzTElmJTJGY0Bnb29nbGUuY29tDQoN
CkkgYW0gbm90IGZ1bGx5IHN1cmUgd2hhdCB5b3UgaW1wbHkgd2l0aCB0aGlzLiBNaW5pbWFsIFRD
QiBpcyBhbHdheXMgYSBnb29kIGdvYWwNCmZyb20gc2VjdXJpdHkgcG9pbnQgb2YgdmlldyAobGVz
cyBody9zdyBlcXVhbHMgbGVzcyBidWdzKS4gRnJvbSBhIHRlbmFudCBwb2ludA0Kb2YgdmlldyBv
ZiBjb3Vyc2UgaXQgaXMgcXVlc3Rpb24gb2YgcmlzayBldmFsdWF0aW9uOiBkbyB0aGV5IHRoaW5r
IHRoYXQgQ1NQIHN0YWNrDQpoYXMgYSBoaWdoZXIgY2hhbmNlIHRvIGhhdmUgYSBidWcgdGhhdCBj
YW4gYmUgZXhwbG9pdGVkIG9yIFNXIHByb3ZpZGVkIGJ5DQpIVyB2ZW5kb3JzPyBZb3Ugc2VlbSB0
byBpbXBseSB0aGF0IHNvbWUgdGVuYW50cyBtaWdodCBjb25zaWRlciBDU1Agc3RhY2sgdG8NCmJl
IG1vcmUgcm9idXN0PyBJZiBzbywgd2h5IHdvdWxkIHRoZXkgdXNlIENvQ28/IEluIHRoaXMgY2Fz
ZSB0aGV5IGFyZSBiZXR0ZXIgb2ZmDQp3aXRoIGp1c3Qgbm9ybWFsIGxlZ2FjeSBWTXMsIG5vPyAN
Cg0KDQo+IA0KPiA+ICtXaGlsZSB0aGUgY29uY3JldGUgaW1wbGVtZW50YXRpb24gZGV0YWlscyBk
aWZmZXIgYmV0d2VlbiB0ZWNobm9sb2dpZXMsIGFsbA0KPiA+ICtvZiB0aGVzZSBtZWNoYW5pc21z
IHByb3ZpZGUgaW5jcmVhc2VkIGNvbmZpZGVudGlhbGl0eSBhbmQgaW50ZWdyaXR5IG9mIENvQ28N
Cj4gPiArZ3Vlc3QgbWVtb3J5IGFuZCBleGVjdXRpb24gc3RhdGUgKHZDUFUgcmVnaXN0ZXJzKSwg
bW9yZSB0aWdodGx5IGNvbnRyb2xsZWQNCj4gPiArZ3Vlc3QgaW50ZXJydXB0IGluamVjdGlvbiwN
Cj4gDQo+IFRoaXMgaXMgaGlnaGx5IGRlcGVuZGVudCBvbiBob3cgImludGVycnVwdCIgaXMgZGVm
aW5lZCwgYW5kIGhvdyAiY29udHJvbGxlZCIgaXMNCj4gZGVmaW5lZC4NCg0KQXMgeW91IGtub3cg
dGhlcmUgYXJlIHNvbWUgbGltaXRhdGlvbnMgb24gd2hhdCB0eXBlIG9mIGludGVycnVwdCB2ZWN0
b3JzIGNhbiBiZQ0KaW5qZWN0ZWQgaW50byBhIFREIGd1ZXN0LiBWZWN0b3JzIDAtMzAgYXJlIG5v
dCBpbmplY3RhYmxlLiBUaGlzIGlzIHdoYXQgaXMgbWVhbnQgYnkgDQoibW9yZSB0aWdodGx5IGNv
bnRyb2xsZWQiLiANCiANCj4gDQo+ID4gYXMgd2VsbCBhcyBzb21lIGFkZGl0aW9uYWwgbWVjaGFu
aXNtcyB0byBjb250cm9sIGd1ZXN0LWhvc3QgcGFnZSBtYXBwaW5nLg0KPiANCj4gVGhpcyBpcyBm
bGF0IG91dCB3cm9uZyBmb3IgU05QIGZvciBhbnkgcmVhc29uYWJsZSBkZWZpbml0aW9uIG9mICJw
YWdlIG1hcHBpbmciLg0KPiBTTlAgaGFzIF96ZXJvXyAiY29udHJvbCIgb3ZlciBwYWdlIHRhYmxl
cywgd2hpY2ggaXMgbW9zdCBwZW9wbGUgdGhpbmsgb2Ygd2hlbg0KPiB0aGV5DQo+IHNlZSAicGFn
ZSBtYXBwaW5nIi4NCg0KTGVhdmluZyBmb3IgQU1EIGd1eXMgdG8gY29tbWVudC4gDQoNCj4gDQo+
ID4gTW9yZSBkZXRhaWxzIG9uIHRoZSB4ODYtc3BlY2lmaWMgc29sdXRpb25zIGNhbiBiZQ0KPiA+
ICtmb3VuZCBpbg0KPiA+ICs6ZG9jOmBJbnRlbCBUcnVzdCBEb21haW4gRXh0ZW5zaW9ucyAoVERY
KSA8L3g4Ni90ZHg+YCBhbmQNCj4gPiArOmRvYzpgQU1EIE1lbW9yeSBFbmNyeXB0aW9uIDwveDg2
L2FtZC1tZW1vcnktZW5jcnlwdGlvbj5gLg0KPiANCj4gU28gYnkgdGhlIGFib3ZlIGRlZmluaXRp
b24sIHZhbmlsbGEgU0VWIGFuZCBTRVYtRVMgY2FuJ3QgYmUgY29uc2lkZXJlZCBDb0NvLiAgU0VW
DQo+IGRvZXNuJ3QgcHJvdmlkZSBhbnl0aGluZyBiZXNpZGVzIGluY3JlYXNlZCBjb25maWRlbnRp
YWxpdHkgb2YgZ3Vlc3QgbWVtb3J5LCBhbmQNCj4gU0VWLUVTIGRvZXNuJ3QgcHJvdmlkZSBpbnRl
Z3JpdHkgb3IgdmFsaWRhdGlvbiBvZiBwaHlzaWNhbCBwYWdlIGFzc2lnbm1lbnQuDQo+DQoNClNh
bWUNCiANCj4gPiArVGhlIGJhc2ljIENvQ28gbGF5b3V0IGluY2x1ZGVzIHRoZSBob3N0LCBndWVz
dCwgdGhlIGludGVyZmFjZXMgdGhhdA0KPiA+ICtjb21tdW5pY2F0ZSBndWVzdCBhbmQgaG9zdCwg
YSBwbGF0Zm9ybSBjYXBhYmxlIG9mIHN1cHBvcnRpbmcgQ29DbywNCj4gDQo+IENvQ28gVk1zLi4u
DQoNCldpbGwgZml4LiANCg0KPiANCj4gPiBhbmQgYW4gaW50ZXJtZWRpYXJ5IGJldHdlZW4gdGhl
IGd1ZXN0IHZpcnR1YWwgbWFjaGluZSAoVk0pIGFuZCB0aGUNCj4gPiB1bmRlcmx5aW5nIHBsYXRm
b3JtIHRoYXQgYWN0cyBhcyBzZWN1cml0eSBtYW5hZ2VyOjoNCj4gDQo+IEhhdmluZyBhbiBpbnRl
cm1lZGlhcnkgaXMgdmVyeSBtdWNoIGFuIGltcGxlbWVudGF0aW9uIGRldGFpbC4NCg0KVHJ1ZSwg
YnV0IGl0IGlzIGtpbmQgb2YgYmlnIGNvbXBvbmVudCwgc28gY29tcGxldGVseSBvbWl0dGluZyBp
dCBkb2VzbuKAmXQgc291bmQgDQpyaWdodCB0byBtZSBlaXRoZXIuIA0KDQo+IA0KPiA+ICtDb25m
aWRlbnRpYWwgQ29tcHV0aW5nIHRocmVhdCBtb2RlbCBhbmQgc2VjdXJpdHkgb2JqZWN0aXZlcw0K
PiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiA+ICsNCj4gPiArQ29uZmlkZW50aWFsIENsb3VkIENvbXB1dGluZyBhZGRzIGEg
bmV3IHR5cGUgb2YgYXR0YWNrZXIgdG8gdGhlIGFib3ZlIGxpc3Q6DQo+ID4gK2FuIHVudHJ1c3Rl
ZCBhbmQgcG90ZW50aWFsbHkgbWFsaWNpb3VzIGhvc3QuDQo+IA0KPiBJIG9iamVjdCB0byBzcGxh
dHRlcmluZyAibWFsaWNpb3VzIGhvc3QiIGV2ZXJ5d2hlcmUuICBNYW55IHBlb3BsZSBhcmUgZ29p
bmcgdG8NCj4gcmVhZCB0aGlzIGFuZCBpbnRlcnByZXQgImhvc3QiIGFzICJ0aGUgQ1NQIiwgYW5k
IHRoZW4gbWFrZSBhc3N1bXB0aW9ucyBsaWtlDQo+ICJDb0NvIGFzc3VtZXMgdGhlIENTUCBpcyBt
YWxpY2lvdXMhIi4gIEFJVUksIHRoZSB2YXN0IG1ham9yaXR5IG9mIHVzZSBjYXNlcyBhcmVuJ3QN
Cj4gY29uY2VybmVkIHNvIG11Y2ggYWJvdXQgInRoZSBDU1AiIGJlaW5nIG1hbGljaW91cywgYnV0
IHJhdGhlciB0aGV5J3JlDQo+IGNvbmNlcm5lZA0KPiBhYm91dCBuZXcgYXR0YWNrIHZlY3RvcnMg
dGhhdCBjb21lIHdpdGggcnVubmluZyBjb2RlL1ZNcyBvbiBhIHN0YWNrIHRoYXQgaXMNCj4gbWFu
YWdlZCBieSBhIHRoaXJkIHBhcnR5LCBvbiBoYXJkd2FyZSB0aGF0IGRvZXNuJ3QgcmVzaWRlIGlu
IGEgc2VjdXJlZCBmYWNpbGl0eSwNCj4gZXRjLg0KDQpJIHNlZSB5b3VyIHBvaW50LiBJIHByb3Bv
c2UgdG8gYWRkIHBhcmFncmFwaCBpbiB0aGUgYmVnaW5uaW5nIHRoYXQgZXhwbGFpbnMgdGhhdA0K
Q1NQcyBkbyBub3QgaW50ZW5kIHRvIGJlIG1hbGljaW91cyAoYXQgbGVhc3Qgd2UgaG9wZSB0aGV5
IGRvbnQpLCBidXQgc2luY2UgdGhleQ0KaGF2ZSBhIGJpZyBjb2RlYmFzZSB0byBtYW5hZ2UsIGJ1
Z3MgaW4gdGhhdCBjb2RlYmFzZSBhcmUgbm9ybWFsIGFuZCBDb0NvDQpoZWxwcyB0byBwcm90ZWN0
IHRlbmFudHMgYWdhaW5zdCB0aGlzIHNpdHVhdGlvbnMuIEFsc28gY2hhbmdlICJtYWxpY2lvdXMg
aG9zdCIgdG8NCiJ1bmludGVudGlvbmFsbHkgbWlzYmVoYXZpbmcgaG9zdCIgb3Igc210aCBsaWtl
IHRoaXMuICANCg0KPiANCj4gPiArV2hpbGUgdGhlIHRyYWRpdGlvbmFsIGh5cGVydmlzb3IgaGFz
IHVubGltaXRlZCBhY2Nlc3MgdG8gZ3Vlc3QgZGF0YSBhbmQNCj4gPiArY2FuIGxldmVyYWdlIHRo
aXMgYWNjZXNzIHRvIGF0dGFjayB0aGUgZ3Vlc3QsIHRoZSBDb0NvIHN5c3RlbXMgbWl0aWdhdGUN
Cj4gPiArc3VjaCBhdHRhY2tzIGJ5IGFkZGluZyBzZWN1cml0eSBmZWF0dXJlcyBsaWtlIGd1ZXN0
IGRhdGEgY29uZmlkZW50aWFsaXR5DQo+ID4gK2FuZCBpbnRlZ3JpdHkgcHJvdGVjdGlvbi4gVGhp
cyB0aHJlYXQgbW9kZWwgYXNzdW1lcyB0aGF0IHRob3NlIGZlYXR1cmVzDQo+ID4gK2FyZSBhdmFp
bGFibGUgYW5kIGludGFjdC4NCj4gDQo+IEFnYWluLCBpZiB5b3UncmUgY2xhaW1pbmcgaW50ZWdy
aXR5IGlzIGEga2V5IHRlbmFudCwgdGhlbiBTRVYgYW5kIFNFVi1FUyBjYW4ndCBiZQ0KPiBjb25z
aWRlcmVkIENvQ28uDQo+IA0KPiA+ICtUaGUgKipMaW51eCBrZXJuZWwgQ29DbyBzZWN1cml0eSBv
YmplY3RpdmVzKiogY2FuIGJlIHN1bW1hcml6ZWQgYXMgZm9sbG93czoNCj4gPiArDQo+ID4gKzEu
IFByZXNlcnZlIHRoZSBjb25maWRlbnRpYWxpdHkgYW5kIGludGVncml0eSBvZiBDb0NvIGd1ZXN0
IHByaXZhdGUgbWVtb3J5Lg0KPiANCj4gU28sIHJlZ2lzdGVycyBhcmUgZmFpciBnYW1lPw0KDQpO
bywgeW91IGFyZSByaWdodCwgbmVlZHMgdG8gYmUgYXVnbWVudGVkIGhlcmUuIFdoYXQgd2UgbWVh
bnQgaGVyZSBpcyB0aGF0DQp0aGUgZW5kIGdvYWwgb2YgdGhlIGF0dGFja2VyIGlzIHRoZSB0ZW5h
bnQgc2VjcmV0cyBhbmQgdGhleSBjYW4gYWxzbyBiZSBpbiByZWdpc3RlcnMuIA0KDQo+IA0KPiA+
ICsyLiBQcmV2ZW50IHByaXZpbGVnZWQgZXNjYWxhdGlvbiBmcm9tIGEgaG9zdCBpbnRvIGEgQ29D
byBndWVzdCBMaW51eCBrZXJuZWwuDQo+ID4gKw0KPiA+ICtUaGUgYWJvdmUgc2VjdXJpdHkgb2Jq
ZWN0aXZlcyByZXN1bHQgaW4gdHdvIHByaW1hcnkgKipMaW51eCBrZXJuZWwgQ29Dbw0KPiA+ICth
c3NldHMqKjoNCj4gPiArDQo+ID4gKzEuIEd1ZXN0IGtlcm5lbCBleGVjdXRpb24gY29udGV4dC4N
Cj4gPiArMi4gR3Vlc3Qga2VybmVsIHByaXZhdGUgbWVtb3J5Lg0KPiANCj4gLi4uDQo+IA0KPiA+
IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4gaW5kZXggN2Y4NmQw
MmNiNDI3Li40YTE2NzI3YmY3ZjkgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiAr
KysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC01MzA3LDYgKzUzMDcsMTIgQEAgUzoJT3JwaGFuDQo+
ID4gIFc6CWh0dHA6Ly9hY2Nlc3NydW5uZXIuc291cmNlZm9yZ2UubmV0Lw0KPiA+ICBGOglkcml2
ZXJzL3VzYi9hdG0vY3hhY3J1LmMNCj4gPg0KPiA+ICtDT05GSURFTlRJQUwgQ09NUFVUSU5HIFRI
UkVBVCBNT0RFTA0KPiANCj4gVGhpcyBpcyBub3QgZ2VuZXJpYyBDb0NvIGRvY3VtZW50YXRpb24s
IGl0J3Mgc3BlY2lmaWMgdG8gQ29DbyBWTXMuICBFLmcuIFNHWCBpcw0KPiBtb3N0IGRlZmluaXRl
bHkgY29uc2lkZXJlZCBhIENvQ28gZmVhdHVyZSwgYW5kIGl0IGhhcyBubyBkZXBlbmRlbmNpZXMN
Cj4gd2hhdHNvZXZlcg0KPiBvbiB2aXJ0dWFsaXphdGlvbi4NCg0KWWVzLCBzbyBob3cgd2UgY2Fs
bCBpdD8gQ29DbyBWTSBpcyBhIHRlcm0gZm9yIGEgcnVubmluZyBlbnRpdHkuIA0KVGhhdCdzIHdo
eSB0aGUgYWNhZGVtaWMgdGVybSBDb25maWRlbnRpYWwgQ2xvdWQgQ29tcHV0aW5nIHdhcyB1c2Vk
IGluIHRoZQ0KYmVnaW5uaW5nLCBidXQgeW91IGRpZG7igJl0IGxpa2UgaXQgZWl0aGVyLiANCg0K
PiANCj4gPiArTToJRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0K
PiA+ICtNOglDYXJsb3MgQmlsYmFvIDxjYXJsb3MuYmlsYmFvQGFtZC5jb20+DQo+IA0KPiBJIHdv
dWxkIGxvdmUgdG8gc2VlIGFuIE06IG9yIFI6IGVudHJ5IGZvciBzb21lb25lIHRoYXQgaXMgYWN0
dWFsbHkgX3VzaW5nXyBDb0NvLg0KDQpXb3VsZCBiZSBtb3JlIHRoYW4gd2VsY29tZWQhDQoNCj4g
DQo+IElNTywgdGhpcyBkb2N1bWVudCBpcyB3YXkgdG9vIEludGVsL0FNRCBjZW50cmljLg0KDQpB
bnlvbmUgaXMgZnJlZSB0byBjb21tZW50L3BhcnRpY2lwYXRlIG9uIHdyaXRpbmcgdGhpcyBhbmQg
aGVscCB1cyB0byBhZGp1c3QgdG8NCmV2ZW4gZnVydGhlciB0byB0aGUgcmVzdCBvZiB2ZW5kb3Jz
LCBiZWNhdXNlIGZvciB1cyBpdCBpcyBoYXJkIHRvIGtub3cgZGV0YWlscyBhbmQNCmFwcGxpY2Fi
aWxpdHkgZm9yIG90aGVyIGh3IHZlbmRvcnMuIA0KQWRkaW5nIFJpdm9zIGd1eXMgbm93IGV4cGxp
Y2l0bHkgdG8gQ0MgbGlzdC4gDQoNCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=
