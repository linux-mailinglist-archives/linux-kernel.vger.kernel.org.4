Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6462474A9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGGESJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjGGERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:17:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD528123
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688703410; x=1720239410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/1dKwvBp+ZR2RSYjnMGY41PhbzyIR6g7ZVmLkfTnfXo=;
  b=X6GZCSOlmV19RLVnrTRNKQ9tCWBZDLzmeWm5TkPXWA1JYuhg0Y24h8vA
   fBMvzDqC+plHOE38wV0ZP485BsFNVGuvsuhKjTQMWp9+R1hSPeEQE65Y0
   bGz35T3ewxT+rgTIjuUwhxndYIvfSm3C/7u67jLK7qpmMhyim9HWgDdVu
   mlP8KmZnWuAxEf3Kq1I3ZHvNUjBUKVJWcGpshLpUTK7eTMRCgQra+iuMw
   xioAFyQqpJHPBVUnYxNzmipNl0Xyi7aVFHLAoBEN/0ZHn4ZFF6XfImMHQ
   oYy6YyC4254PlV12F73v3ZWVg21f13qsJecrXkodiUjame4Wp0/+Q6+pI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="366380976"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="366380976"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 21:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713842925"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="713842925"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 21:16:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 21:16:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 21:16:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 21:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzTsQkee9d1aVR3fQSYV6dMZ514cmFNebMM/8q24t5iIB/3h7sJ0yK7f9REixUpTSxCOFrGVzECIyjvC8f9NE0wnXxQBxLyrNplFF/mQu9oqw4vCdIxBVufrwHDHBNFQLImrK69jyuNHL853xmcsD0aE9bS1zAsTXuJL+86kSqWt9UPmwosa2celovap81SAJBypa0TycVcwLXRBIXbBDwPreNsqyjh70WVxSDzlRmoHF72enuPTgSbOWEjhakL36B9YEPgZX6as9QOaXubT9+KrIzVmgNGnhcB6p2QQke/XTTxBTDb7OhchtZ4EawtXuzJyiLOc5lGTiin67G54Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1dKwvBp+ZR2RSYjnMGY41PhbzyIR6g7ZVmLkfTnfXo=;
 b=O2BFsPcUiTwrPzf2rzwFJ+9jyJYjVv5OhEmh6OlELwF5hBynrf8FMuERxyQXHC7DFsGF028buqnZaEtuuoXEEKA2lTGRFnc32kOARG4KkZsqxQYqyKIkxsRolIhsC6W9Innn59MK+rtaKHhusE4q8RowyR0xFvENOzHHMZUoxWEjwwMqOARZrzlbQiklY1uYqy5UZ55hDRtZoKni8Y21WM7SH2qIoPkkJwR0HFSUftbj8ji5X9zrFM4LdXKLmZie9aUe+EEQiyWcjNlR4Gxp/l+msVd0Z+kERkWP0eontheOgaoV6Z8qsySMmGuyCResz1K+9/RPU1DGIRPmGCxufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 04:16:47 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 04:16:47 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
Subject: RE: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Topic: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+sxk7ngAC/myCAAC0zwA==
Date:   Fri, 7 Jul 2023 04:16:47 +0000
Message-ID: <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
 <87v8exgmot.fsf@email.froward.int.ebiederm.org>
 <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB6122:EE_
x-ms-office365-filtering-correlation-id: c7387f70-cbff-4fb4-be33-08db7ea0fb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUWXGh3y7BAFRf/4t+cDJqVUyGiKX8iifsIZ5kCtq6jdI3qTghTsvUIqv1PzsLzZwYqCXnioFRGaThrBsoiFx9snnpv0hh3kmv5v+NRKKYmMh1j8qdxvtiLn1MuH9xqZAQkvvBL9IcMY75lllJtr9Yua/vT/IUu+NYcyuZMSZv9pBO3SRwLvfNP1MddrjwYRyn2A9vip2VP0KGzKpHye+jmGAsfLqNI9GS8BdN+5sQhQEmqYUwzV4Gd/aal9AbiU4iM8WEfX+wthm3YpPZRUeZDXcysJYo/n9exvtbLkGTUT6rZjUAke4QLiqOBy07whq/QNamO1g3/kDOorYbwY5CE6zNwLnszajT8ZFq3mB0nnVl010VDBhDtOc0oHZbiHGyWXGff/QQKvsyNs4FtleXqDHmrxIotkV9ZVv3fkcaOhCMN8vDkRmAMADFiWHR2lIRYVlKz5RClmmLIzyEHUS+jMLVlTTdijSoAWMrwm1HtukqRwqjsJYaSENNgLIj6mHLz3nNhtIIb1mfbxPnmkLo6C5tvh7ePmof/WD5/INvfjO5hMtDrBQniEOiSaAurqABLdZbhbAVJuwEtqR26d6xTlz0SLuurpcOGJidupiUUM32Cc7ifHo3JoYTFahNUq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(82960400001)(478600001)(71200400001)(7696005)(54906003)(110136005)(76116006)(186003)(2940100002)(26005)(33656002)(9686003)(66946007)(2906002)(8936002)(8676002)(41300700001)(66446008)(64756008)(66556008)(52536014)(316002)(5660300002)(66476007)(122000001)(4326008)(38100700002)(38070700005)(558084003)(6506007)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uYdZM6J/HpCUpICRGxqY3HGyHfh7gpvYiDMHJRwcFwceV/VNWwAwdrQFfhvH?=
 =?us-ascii?Q?TqezAk708ECP8+7Oh1zjOU/toA+C4Gx2AYFLAM4c3/1dMDndPSUzMcIEdOur?=
 =?us-ascii?Q?gtM42zIaFphQ5o5qwx4FgTkiASl2nDQmuqnTq1UjYLp4Siu3V3y5TnFS9ixd?=
 =?us-ascii?Q?OYSYApLE+GrX7Em3PyxCZUzRBjk2rS6yJstJ7i6N8LRtMjqv2VmSoiYEnYBG?=
 =?us-ascii?Q?aR3uDVxCehZVVDLO0VxE127l9ogOtcbrRcYHmd/DJ0BgQqHcseE1VBc3mZ3b?=
 =?us-ascii?Q?dvOkAszUS4nyjEGTNmurf3ftiSZB+DjVPmd3qeC/sOVxbJ5/xitwCZR9bNNH?=
 =?us-ascii?Q?X/d1emtUhtV/0IWW7FZu67g2wkbnhi8r9BwLOp4/DFcHtoM6Dgrc2dQXwhFN?=
 =?us-ascii?Q?xJa+jtZwC6/hLVV1eXXBicQ6EhKS9t0i9btDtvk4EPuE84+NZ/KLvaHNlKUY?=
 =?us-ascii?Q?efiMtgLbh/woipmPU59Y0D3ughblX9WcEwGHtwkvIO9mS9uUFCsmGYuySTiE?=
 =?us-ascii?Q?MmMfUh4GXv3/IlslYvJKhJH0Lk0sFCDnXdyRwvd4t8DB+TWkam13fDO6QFQs?=
 =?us-ascii?Q?BySu/IfSjy71eZRLlbLr0jfkywJHoA5DK7bSDy1hf/J1B3RZfBwfQy4g+4hh?=
 =?us-ascii?Q?cQP/TSE8acnKwBOdWY2doZ2vquTV26KvyKmsLAMASodVLlYkzRoqO5WfgcF+?=
 =?us-ascii?Q?Gn4AGl/truupBDywpv7RF+i6nOjbAQ9xr9ZdArbf4aopNYiT8NmrXo68RoRa?=
 =?us-ascii?Q?IKN0xTGVxadhS5KBqAlCLucUy44GRWg+BMYGcetORWOJkq5lIh13v2YFAmD+?=
 =?us-ascii?Q?jEJumiKhhdAIkm3Ok8cxKsjeMG+MQisUpxstof9MorLAM8eJMimoiYXK2nvv?=
 =?us-ascii?Q?YHQY4gSJZBQdGEx5+QI249aS9qgOEXPdfqINENFG/FHYi/cHI6V8v63QbsiZ?=
 =?us-ascii?Q?HvXSBhLCay11ZehWaYArmA2S9r2rMQhX71MlOuSDZKNCOHHbGhVS5G7PZDbf?=
 =?us-ascii?Q?hHf3pgrAAk+uMby97Kk2H6Vea6+1qCWnU7lMTkrUCNIUHSBOUHVlyjrlZWo/?=
 =?us-ascii?Q?YmrhS/GFZmc09vcHg3EU4S+E0hr8aM4CAT7E/XkZnitiBCPppMXI5FmUZKId?=
 =?us-ascii?Q?zLI40Mc0Ifk1IIezRFK+M8T6bmTbIXfOluYcpaHmcuw2xF4Ng27eXT0c/r9R?=
 =?us-ascii?Q?xVKRdRVvR4yaXb7BDR1vnbjp1vSBFLOj3nR4qHyXtPG5ZqCg8pSCFROgYe51?=
 =?us-ascii?Q?cCJjVlownKO/Iy8Mb76cDzwTD6KBuLuBS5kswmiJS+f6PZek9WE2hqFRcF0e?=
 =?us-ascii?Q?8bc6fCDnH3dyHJgG+yZW8xe9RjI5mYO8KjfXBUnbAuCUT6tOKW8EnJ9vDnRe?=
 =?us-ascii?Q?kskPxWIFSwstcnMbdE30dT8nw/dVGrna2TTaO03GAe+7F7f629FV7M96qWTk?=
 =?us-ascii?Q?b0hduy43WIA0oH3cO7lwXWABfT9QrEMdnt8inB5UvbybhnARUlGNBhZx+hqS?=
 =?us-ascii?Q?RmnndZB2W897GNipJlSWREKqE/n27LsG6F4bu/6lLOAkwBQHWNazYN4yAXNo?=
 =?us-ascii?Q?uUWqoYgydXv8VGL1QJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7387f70-cbff-4fb4-be33-08db7ea0fb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 04:16:47.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLVxnCbLFskj47sF0k4krRgzSMTldHBEZ92Y2uTOmgtfkleHCAe/tCQToliaz8I0F+yHL7gpLX3PqJoo3rtspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
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

> Thus 3 as a selector is the same as 0, and it doesn't matter to change it=
 or not. But
> when IRET sees an invalid segment register in ES, FS, GS, and DS, it sets=
 it to 0,
> making 0 a preferred null selector value.

To clarify, an invalid segment register value includes NULL selector values=
.
