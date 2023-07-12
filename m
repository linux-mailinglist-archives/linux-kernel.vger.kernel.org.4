Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3874FF18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGLGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGLGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:14:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E910CB;
        Tue, 11 Jul 2023 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689142491; x=1720678491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VHOJCPM5YdWIsDjfhoSvcCDSm7CY7Aghb+e+xVxVUsA=;
  b=i17HnFS47G1hL+zIO1a4e5vtmBZzCSmq+uW+EUvD7HZ1bXdKLwdtpH99
   loEvjM5G9FBt9AlsoUBvDUDY/a8kpEVk7GG33tOlwOToiEZuTph52oXgf
   3fwoqRHULDisTqW+GHukjo+pk+MUC2WUMWqwDkK80gsSBU2F2FjOwZ4OE
   YmEoMpADENXXdQreioYdPabwD0ioMg368KyxFM+qM+sP4KoD6pu1hDKIh
   TIUFYZB7oOSYBZt9iuU67EslusYU4Fsx5/0Hhj3qTs7EHqt3FfP2/uct+
   0BlOUX1wF3DgMM6CAW5xsptL/mOgFz0MXT8gY9j5D1GWEcjrv2h7naJU0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="349664633"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="349664633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724753590"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="724753590"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2023 23:14:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 23:14:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 23:14:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 23:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gir71SulLWAFnyVHiuJcsr2NgB3JFmFU+tQJe0p6fxZZHuw3/4N7M+oPmUoElnblX7HAg3RgSIsKr8RDzfb3sKYZriw3VQUevpfGfzwBf+OD0A8y2o5gCsl8c2Yqvjhn/JxPIOSe4GUKHHpzZuVdPg3hFf6Crkd9sksuB48+VesptJVyMEfd7EtfnbF0D8/6DjXgahyuyarBVCbBjs6Oa8T1Bu0URBOYKPmCsHlINDZ8xHS6emVE/5CrkincckWyWD0Zw3f6LqNyjZzbPpSSza9SuAirsOlPMmGkZrvTVrBedk4M7SDKz2xPEmakX1/zdenNSTPpyOvp30P8SIBZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHOJCPM5YdWIsDjfhoSvcCDSm7CY7Aghb+e+xVxVUsA=;
 b=aW3qnJK/XU5INJ4G05sXbx7VPV49I9ZZEX3qiiGSfxlb8xlcOKgxtpr1SAbz1D04MkBJTatby6BG1Ju5nv1soJesH8FCO71BJCgn3SYOlOCR143Rhd0xW5DI18HWc4UyZ0w/MKACcNobL5V23a75nUlvVbfPzi/2h3QAyajxmDMHM6+RTa/MCkNm89dlmT6q2lZlPD5s4bcJiLJd1lCjsei+llWwA/DyaY8lcAbwSeInREpBZ5ACDH4L7U2uMuE7ChzxY7zkwV0HLxciDOD2rLtQHkNgxnqB2J5/NqV2eicKiNXdtVTmVSyFZrVra9pPh2ep6H1fYL7miroxnAtXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 06:14:42 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::55e0:44be:6aed:d4c9]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::55e0:44be:6aed:d4c9%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 06:14:42 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
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
        "Christopherson,, Sean" <seanjc@google.com>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>
Subject: RE: [PATCH v3] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Topic: [PATCH v3] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Index: AQHZtAHzpi9OnFh3/Emr4NUREf+emK+0omCAgAD/dUA=
Date:   Wed, 12 Jul 2023 06:14:41 +0000
Message-ID: <DM8PR11MB575068AC229C410A9FA5F3AAE736A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230711141257.232312-1-carlos.bilbao@amd.com>
 <2023071151-sprinkler-aids-a07a@gregkh>
In-Reply-To: <2023071151-sprinkler-aids-a07a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SA1PR11MB6687:EE_
x-ms-office365-filtering-correlation-id: 63ab598e-00fe-4546-7c9a-08db829f47df
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSFUuCKjTRmYhFCfO0onEQP65nuzaXlN8uR83K7NJw3ZkSHPe5vL6NBZVfSGXA2+mrUULMm1xqANW6sHlv20vwCOvXT+mLR0r/yUD2chX6rNmGwrrsSVamp6tJZaPi+TTHnUAt+m9/yj40S+6YZ7C3zLupNfmlWes0ChcuPI72syOznBDBO6w+xEADuLgRg+xR8YyWYqDiZY7W3JvogyG0ijQ6Nkmg7ULWoMZCcrihd6jB9nYmdXZy2JOkKG+kIx89ylJt3lon6vEcbwoTQweuAY5lbDZMxy4uuA8dGKI/Foa2tJjfRavIX4x4abH5R+R51YdW3KpCYGTmHpZoujIRdqq5iqC6fR5alzdcpJDqIln+kBOXP0VuJETYdmynTL4b9Ix5Mc0150RAAt34ssq6rAPHeunJ+fVV+G4uSn+6NyoPWzhN02w3/3Mn1fLbpADTtHbvzkiJVbZqPdh9elTOHB75cCIiuX2imZ7vSTHOnc4bI1FJYlkMvHVcEQR5fIqhb4vTQ/8LuKHu6aGhI649Vjv5w5oqg1Fhnk2fuW5rR3YABMdaAUp//CGouqyl/v55d+HaHjHLLGKDMfVgjxAnNwpSA+BvO3Aq5pYanj4Z0iralJy86Fnbg5v9DN2sOC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(66446008)(41300700001)(64756008)(38070700005)(110136005)(9686003)(54906003)(33656002)(86362001)(38100700002)(7696005)(122000001)(82960400001)(71200400001)(4326008)(316002)(83380400001)(66946007)(66476007)(478600001)(2906002)(76116006)(8936002)(55016003)(8676002)(52536014)(5660300002)(66556008)(26005)(7406005)(7416002)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE1zclVkRVFoSDE4WTlWUWlQL0lOV0NLeC81SEE3WmppSG5aVndyTTRWVjAz?=
 =?utf-8?B?dEovd09pemR4S3NJTGZmZVRqb25IbTUyQTgxWk5XVVdla2pZRVpiWjlFaDZU?=
 =?utf-8?B?c285Q1BPaTQ0dDEweXl4TUZDTGtMRE9peEFZVjBrUXVsYnh0Ly9TVXpmR29O?=
 =?utf-8?B?TnBvZHFVbitqUDMvTW5PTTFLQitqdGhrV0VSUWZycElwd2x6Y3ZQR1VlOHh2?=
 =?utf-8?B?b2Rta0FaVXV3aWhqNmFib1JiTWlwN3poVjJBK1lCL1Q2Qnl6djNNYkx0Z2tj?=
 =?utf-8?B?NEpEcVcwS0xaWXpmSGgrQ2ErdGlVWVB5VEg0OU9YUzhibFlodnpxSzE2Unk4?=
 =?utf-8?B?U0Zob1VFOW1SZDlzSlpsNXh5bmszcUNXR1JYZWQycndkWlNHTk10djVPUm9p?=
 =?utf-8?B?NUFWUGU5dHpaZnlBWnIwUENmWnNHTWNZQ2p4dVpTY1paMHlZQlcxQVRCbWhX?=
 =?utf-8?B?aVJJNUFxeEJEMnVzaDFUYnNqd2JOdFdmdHYwWDh0YkYwK0RJM0dZNWdxcDRi?=
 =?utf-8?B?eHJKWFlxL0d5a0hnMDdHQ2dTTmlySjVOVG1IZUg3MXRtbU1HM0FKa2Q2MVRW?=
 =?utf-8?B?dXJuMndrYS9TT09RRnZrVFdoMFh3WURuRHBsaFdrQjBONFJwT0hFVFlyY0xx?=
 =?utf-8?B?bUZsUVdiOVRDRlAwaDZESTVoNlpJS3I4SHd0dWlRR2thNUYxYjc1dGppWElG?=
 =?utf-8?B?VzZzakZoSjZYL1AyMGRKOHZ6eEFMRDN2VEZtT2UwOG1qWkFQV1JSQzUwa1l0?=
 =?utf-8?B?MDVLQW1vQW5EbnQrRUJqeTdPK0h6aWdXMGU4azZiTGswNkszMk10c2N6Tkxw?=
 =?utf-8?B?aUZ6YlBHZlZBNWZ3N2FjOVlOYXF1U3ZSaUVDQUJMelNVLzdSWkJyTEIvN3dh?=
 =?utf-8?B?NEE4L2ltcm9sWFY0TXRhMEN6d0ZCUXdwRm45Zm9nTFFaUU0xZHVyQ3NzT0FF?=
 =?utf-8?B?ejgxUGMyYmRrOFgzdVkwVG9wNEdPTDdzUFFlZzhVV29RS0RiNjQvUmdqSHhQ?=
 =?utf-8?B?cFQ3MnpySnlMY3FoNGpWRkpqZGVMdUkwKzJycmF6TEl3Q1cxRVVnd1B4Njdl?=
 =?utf-8?B?ZURuMk5sRkRmOXNlY2lhSVhoMlgwT3RaeFAybXJrRHZza2FhUlNkNk4rM285?=
 =?utf-8?B?NHB0bExnc0N1TGRhRkp1Zzd0a3JuUDNQNVZMSjlWWXgvdDlESFdQY1BId0E0?=
 =?utf-8?B?RWtweWUrZnJTVjJQaGQwdFJaUDVoYUtxTFZJS2wzTGQ1UnhaRCs3b2llTmZa?=
 =?utf-8?B?OCtBM0tKQTd5ZCtlRjA2VFpsVHRZekpVeUVrdnVIZklPaWRQb0ZPVThGam91?=
 =?utf-8?B?OXV6M1RjSEZtRzh3a0V1SGFaV1R2ZnNNR0huWnpwRmN2RTRjVmQrOUlGRXdN?=
 =?utf-8?B?OG40WVh2SG5FZ1prbFg2dTVjZTg3dHhud1NVMWRuVlpvQVZjWGp1d1JaeHpV?=
 =?utf-8?B?a3IwYUI0b1lGMUdIbHNuZTdmY0VLU3A1NFpuODRUNDVDbEV6Q1M1ZGZuc0xV?=
 =?utf-8?B?ZGNrK3BCa291Nld4Ymc5Wmc2cFhkNm50dnNkdkg4YS93c1hXOGVGdXF6TGVq?=
 =?utf-8?B?RVRyYkk3R1RHbUtaL1hXWnJ5TVBMUFpWMU8zTE44Um1PT0MvdUxTMTFmZFhC?=
 =?utf-8?B?YjVJTE9IMFRTQ3ZJN053dnJ1SVY0U2loemN3aitmQXU4VzZFTlNkL0FBSVZu?=
 =?utf-8?B?MTJ3T0grQU94ZG8xS3RKRFlkd3B6NFVhWXhlZVlRc011NExzcEx4TW1hT0th?=
 =?utf-8?B?S1VUcWl3d0QyTFJ1NldRZ3M4WDNpT0JiMmM0MXVxYXd4ZXdaK2hDYms4dWRW?=
 =?utf-8?B?a2ZmWmM2NHNQUkk4N0VLQyt3UGhRRW1DQ0NSY1VMOHhkUGk0aTJFdDRwTG9W?=
 =?utf-8?B?TEhqTHJMQVNGenluUGVuazVtWEZha2g2RHA4Z2JCcDIxcTFsWmM0NWE5M1Uv?=
 =?utf-8?B?Y1huWEdITTFESWJzTzdzTmxqK0JOY01KRmlEcGpZbnBtYXV3UkRNZXlQdFc2?=
 =?utf-8?B?TGtCUXliMjd1emZhUURMV3ppUnVzNU1xei9aa0czM0lIekprZWhrTE1nYUxW?=
 =?utf-8?B?aWFPRy82REFuQkdRUmYvV1gzM3dJUmZiakR0SlhFbVBvVEh2Mm9ac0l3RTJn?=
 =?utf-8?Q?Zn3FTHyvMBm5dn1frCHE5bE9b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab598e-00fe-4546-7c9a-08db829f47df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 06:14:41.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcnlyvMPHaf1dTqif+QD/WgblYhASuzsawNrC9slNDgjgp+koXvP9VsmvElNyo9ymCi/1K+To2q7BxsRWdWTKa6kXkQUYFiK7+S3fXMqlD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIEp1bCAxMSwgMjAyMyBhdCAwOToxMjo1N0FNIC0wNTAwLCBDYXJsb3MgQmlsYmFv
IHdyb3RlOg0KPiA+IEtlcm5lbCBkZXZlbG9wZXJzIHdvcmtpbmcgb24gY29uZmlkZW50aWFsIGNv
bXB1dGluZyBmb3IgdmlydHVhbGl6ZWQNCj4gPiBlbnZpcm9ubWVudHMgaW4geDg2IG9wZXJhdGUg
dW5kZXIgYSBzZXQgb2YgYXNzdW1wdGlvbnMgcmVnYXJkaW5nIHRoZSBMaW51eA0KPiA+IGtlcm5l
bCB0aHJlYXQgbW9kZWwgdGhhdCBkaWZmZXJzIGZyb20gdGhlIHRyYWRpdGlvbmFsIHZpZXcuIEhp
c3RvcmljYWxseSwNCj4gPiB0aGUgTGludXggdGhyZWF0IG1vZGVsIGFja25vd2xlZGdlcyBhdHRh
Y2tlcnMgcmVzaWRpbmcgaW4gdXNlcnNwYWNlLCBhcw0KPiA+IHdlbGwgYXMgYSBsaW1pdGVkIHNl
dCBvZiBleHRlcm5hbCBhdHRhY2tlcnMgdGhhdCBhcmUgYWJsZSB0byBpbnRlcmFjdCB3aXRoDQo+
ID4gdGhlIGtlcm5lbCB0aHJvdWdoIG5ldHdvcmtpbmcgb3IgbGltaXRlZCBIVy1zcGVjaWZpYyBl
eHBvc2VkIGludGVyZmFjZXMNCj4gPiAoZS5nLiBVU0IsIHRodW5kZXJib2x0KS4gVGhlIGdvYWwg
b2YgdGhpcyBkb2N1bWVudCBpcyB0byBleHBsYWluIGFkZGl0aW9uYWwNCj4gPiBhdHRhY2sgdmVj
dG9ycyB0aGF0IGFyaXNlIGluIHRoZSB2aXJ0dWFsaXplZCBjb25maWRlbnRpYWwgY29tcHV0aW5n
IHNwYWNlDQo+ID4gYW5kIGRpc2N1c3MgdGhlIHByb3Bvc2VkIHByb3RlY3Rpb24gbWVjaGFuaXNt
cyBmb3IgdGhlIExpbnV4IGtlcm5lbC4NCj4gDQo+IFdoZW4geW91IGhhdmUgYSAiYW5kIiBpbiBh
IGNoYW5nZWxvZyB0ZXh0LCB0aGF0J3MgYSBodWdlIGhpbnQgdGhhdCBpdA0KPiBuZWVkcyB0byBi
ZSBzcGxpdCB1cCBpbnRvIG11bHRpcGxlIHBhdGNoZXMuDQo+IA0KPiBBbmQgdGhhdCdzIHRoZSBj
YXNlIGhlcmUsIHlvdSB3YW50IHRvIGRvIHR3byB0aGluZ3MsIGRlc2NyaWJlIHlvdXIgY3JhenkN
Cj4gbW9kZWwgb2YgZGlmZmVyZW50IGF0dGFjayB2ZWN0b3JzIEFORCBwcm9wb3NlIG5ldyB3YXlz
IHRvIHByb3RlY3QgZnJvbQ0KPiB0aGVtLg0KDQpBY3R1YWxseSBpZiB5b3UgcmVhZCB0aGUgZnVs
bCBkb2Mgd2UgYXJlIG5vdCBwcm9wb3NpbmcgKnlldCogYW55ICpjb25jcmV0ZSogbmV3DQptZWNo
YW5pc21zIG9mIHByb3RlY3RpbmcgYWdhaW5zdCB0aGVzZSBhdHRhY2sgdmVjdG9ycyB0aGF0IHdv
dWxkIHJlcXVpcmUNCmtlcm5lbCBwYXRjaGVzLiBUaGVzZSBhcmUgaW5kZWVkIGdvaW5nIHRvIGNv
bWUgbGF0ZXIgd2l0aCB0aGUgY29kZSBjaGFuZ2VzDQphcyB5b3UgaGlnaGxpZ2h0IGJlbG93LiBX
aGF0IHdlICpkbyogZGlzY3VzcyBiZWxvdyBpcyBoaWdoLWxldmVsIG1pdGlnYXRpb24NCnN0cmF0
ZWdpZXMgdGhhdCB3b250IG1ha2Ugc2Vuc2UgdG8gaW5jbHVkZSBpbiB0aGUgYWN0dWFsIHBhdGNo
ZXMsIGJlY2F1c2UNCnNvbWUgb2YgdGhlc2UgbWl0aWdhdGlvbnMgd29udCBuZWVkICphbnkqIG5l
dyBwYXRjaGVzIHRvIGxpbnV4LiBGb3IgZXhhbXBsZSwNCnRoZSBmaXJzdCBhdHRhY2sgd2UgaGF2
ZSBpcyAiIEd1ZXN0IG1hbGljaW91cyBjb25maWd1cmF0aW9uIiwgd2hlcmUgdGhlDQptaXNiZWhh
dmluZyBob3N0IG1vZGlmaWVzIG9uZSBvZiB0aGUgZ3Vlc3QncyBjb25maWd1cmF0aW9uIChrZXJu
ZWwgYmluYXJ5LCANCmNvbW1hbmQgbGluZSwgZXRjKS4gVGhlIGdlbmVyYWwgbWl0aWdhdGlvbiBm
b3IgdGhpcyBhdHRhY2sgdmVjdG9yIGlzIGEgd2F5IA0KdG8gYXV0aGVudGljYXRlL2F0dGVzdCB0
aGlzIGNvbmZpZ3VyYXRpb24gYW5kIGl0IGlzIG1vc3RseSB0cmFuc3BhcmVudCBmb3IgdGhlDQpr
ZXJuZWwuIFNvLCB3ZSBlaXRoZXIgbmVlZCB0byBkcm9wIHRoaXMgYXR0YWNrIGRlc2NyaXB0aW9u
IGZ1bGx5IGZvcm0gdGhlIGRvYw0KKGFuZCB0aGlzIHdvdWxkIHJlc3VsdCBpbiBxdWVzdGlvbnMg
ZnJvbSBwZW9wbGUgbm90IGZhbWlsaWFyIHdpdGggQ29Dbzogd2h5DQpkbyB5b3UgdHJ5IHRvIGhh
cmRlbiB0aGUga2VybmVsIGFwaXMgd2hlbiB5b3UgZG9u4oCZdCBkZXNjcmliZSBob3cga2VybmVs
DQpiaW5hcnkgaW50ZWdyaXR5IGlzIHByb3RlY3RlZCksIG9yIHdlIGxlYXZlIGl0IGluIGZvciBh
biBvdmVyYWxsIHBpY3R1cmUgdG8gcHJvdmlkZQ0KY29udGV4dCBhbmQganVzdGlmeSB0aGUgb3Zl
cmFsbCByZWFzb25pbmcuIA0KDQpUaGF0IHNhaWQgd2UgY2FuIHJld3JpdGUgdGhlIHNlbnRlbmNl
IHRoYXQgeW91IGNvbW1lbnRlZCB1cG9uIG5vdCB0byBjcmVhdGUNCmNvbmZ1c2lvbiAoSSBkbyBh
Z3JlZSBpdCBjYW4gYmUgbWlzaW50ZXJwcmV0ZWQgdGhlIHdheSB5b3UgcG9pbnRlZCBvdXQpOg0K
DQoiVGhlIGdvYWwgb2YgdGhpcyBkb2N1bWVudCBpcyB0byBleHBsYWluIGFkZGl0aW9uYWwNCmF0
dGFjayB2ZWN0b3JzIHRoYXQgYXJpc2UgaW4gdGhlIHZpcnR1YWxpemVkIGNvbmZpZGVudGlhbCBj
b21wdXRpbmcgc3BhY2UsDQphcyB3ZWxsIGFzIGhpZ2hsaWdodCB0aGUgb3ZlcmFsbCBtaXRpZ2F0
aW9uIHN0cmF0ZWdpZXMgdGhhdCBjYW4gdXNlZA0KdG8gYWRkcmVzcyB0aGVtLg0KVGhlIGNvbmNy
ZXRlIG1lY2hhbmlzbXMsIGlmIGRldGVybWluZWQgbmVlZGVkIGZvciBMaW51eCwNCndpbGwgYmUg
ZGVzY3JpYmVkIGluIHRoZSBmdXR1cmUgZXh0ZW5zaW9ucyBvZiB0aGlzIGRvY3VtZW50LCB0b2dl
dGhlciB3aXRoIHRoZQ0KY29kZSB0aGF0IGltcGxlbWVudHMgdGhlbSIuDQoNCkRvZXMgdGhpcyBh
ZGRyZXNzIHlvdXIgY29uY2Vybj8gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hDQo=
