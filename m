Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2541C62B3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKPH32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiKPH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:29:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88448B488
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668583765; x=1700119765;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sOFzuyFIhUKmbhjz5B7q9UIRs9N4AAVzVcIStrLmiC4=;
  b=fgoCV8dIgFZkKJ+H11RiMu6Hx4HZGpXRD1LWfVhHDXD1SzjAfWflATcM
   OXlqdUVafVHl9w863PZFSwpKPPEo9N2fbZxkIsakv2u75dQw5BtX0vvJM
   o6lhGlxtj10wkcoF4f6q0y1QLJ5Lyu1als+rbDCU77XqyGyKhu2/PxIQx
   PsODeS/NP407Lyk6FSbX5tBgBLtURWv4UydpErj3nWeNqkS9kFF7MIofW
   4CCYu0CFClo3oKfhoYyxFHPTHv3qBlrtBFSGxwVuL4aDMvwk4cot4B+y9
   pLWf4QcmX6CXS0xAEZ8xJGyabB3v45l+aQgWr5ewBu2W/usQPHNnwzmNe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="310102479"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310102479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 23:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633533856"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633533856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2022 23:29:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 23:29:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 23:29:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 23:29:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb2cjP08zLT+LO5vF4WQceQ5VBiRQBrfI7+O4SvE+r79ijr+2jQlG8ABXRYZXqtYWwLDj8MbGjq+18XtSQAoNbr9Pzpw2RQyRA2NmKPQRIJ9SrE/9N9Yf0uN6VSueTSLi+t0365Wa6dg+Z3+NilGvcFTSy8zc/oZSt5vMpbNtPIjl5liVOpvReSyEBSewTXsme+JSo1otj9tDGJCqhRxqixs6AfC+8ve3jooroKKmuQaCz/lRXutv7PPUoAYKzjGbGptpmJANxvGbIdo94BmAs9rAZuBWGUN3spnuf94+BaWoh9VRoRIb2QmZjZjxUEePhnidWgt66dxqXqOpnxP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOFzuyFIhUKmbhjz5B7q9UIRs9N4AAVzVcIStrLmiC4=;
 b=VSN08qVvmtmxyRwrd/+Fe9uX/wxoS3o5D6jnaBRQ0Y4Jv3IvnDREFBwscOmTnBEHKbiYJluo53uUaVcX35BoSAHNA5r//zIRpw0QBlzqV4gD93HwBW4YOkci/pHFsMWZv++gdf0g9YxSAFczKfd4HSLBRMTjsRoWWvDyeiD1KYhQ7flQKOmNqy7WTF7SXE1n1Fo7dxhedJza1spB5uzw/06Y2KaFKrK02NUskGWtIBc3/wCQC0epA9pKjBxN7w0mrqeHqSgwGmXhsumVAPj2/Bc+/ZFDRdFaE77Mq6F6ZpoIvc5PgqnDvsHVAE4+4/6uNmjKO29jXdnrCG4g+7TkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 07:29:22 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::2101:1249:d2cd:7c45]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::2101:1249:d2cd:7c45%3]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 07:29:21 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>
Subject: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6
Thread-Topic: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6
Thread-Index: AQHY+Yj2gEXwbfUqE0K+PqHC3finJg==
Date:   Wed, 16 Nov 2022 07:29:21 +0000
Message-ID: <CY4PR11MB13207C899E7C3FE22C1D3F2DC5079@CY4PR11MB1320.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: a2eec997-3d1e-41d7-695e-08dac7a44773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nV+F2GP/LsRUEqvoHj8vQ0ifoUNhWwhcVHWdKjN6Y5vjDkF4qCLZnkXlUWOi2Iyrx6HhassRmfO/qKjBKpe5YRkErJh357iJnDHWBNn2mqZII+VfKXszAaEp5M6OKWnNQEeldNWuy89T50vfu1bZV0cu8ypqoDpbQHkAfA7vWopDEDyeoyLWt757j34sM/Apr+5FwQcnk+6MgdBbfcRcaECV/Zn+IHMrlh+KkZK9/HlkKkpU0AAthVe8v0nJdGHa7b6OfgaOPSo+oJJ//POai+yr7SpMVkZFFP4abspIsgU5v+BtmGOzq7eliOzYSPX+WiJKsNqPlmEZ/UgZX0Jg+P9DNnxuOrpdxQkup2p+vxolbgJzv/b2gbuoB3GQCbNcy15BPW/ItMHR25jBxleW/qQAvW6Uxz+Z2nDIQLEj3qukDRHmjs2y38rkBmce4wWokvIhQ1By+fo3uHmoDJvJuiAznVYgCWJx/whAYT87sgmXb4YYGK1tjjfDFQazQk+rlNCg7Mqgb4iZ6SgVyAWZ80CS25aUnVJo/qckOwUqnqWkkXRyMny7JGRQKmuvHhqcg0tWFKO3k7yBvSt77l9ymEjXuPq4Ck3gAWUtCfut0KG5FXQVdVAmDSC8yi4lSl7hkJvu2b/L0A5iZYnMhmSOn1iofJ3RZTpbGg5sdOtwTG11L9+SY48xHRfzBwip90qPv4zvAMDReU38QoONHc2Na/JIiRyOQRGglxDG8FboPFO2W/U9J8bPNcahYf68aKVlyHTQ8bgmracFfTv15pvVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(26005)(9686003)(2906002)(478600001)(5660300002)(7696005)(6506007)(186003)(71200400001)(55016003)(86362001)(83380400001)(107886003)(33656002)(52536014)(8936002)(316002)(38070700005)(6916009)(38100700002)(4326008)(122000001)(41300700001)(66476007)(66446008)(66556008)(91956017)(76116006)(82960400001)(64756008)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VBiof76BXIRF2O6es4L5hAmaiGoRoBeU0WWTbm6C0VxVLwA6v9fNKibYQN?=
 =?iso-8859-1?Q?erH9xI5XSeCmwaPIYJjVvkUhGm7xPXz66fZOE8HbC4wsdyDSsiLpbw0ilX?=
 =?iso-8859-1?Q?pdamSyCTdTHvXOpah24GCqT0FN+vg9hnfmoMnZT/JvHSKzprbsOMA3q/8i?=
 =?iso-8859-1?Q?Hh0hRXuAxAt/LjHSIL/YmJ9YjwLuN0y32GEOGI0sITkLO2g8RRVE1kbL9V?=
 =?iso-8859-1?Q?xG7oipGRk3v/GUe5o65VRxafbHd581F+DE2as2AAav5ip1ISI3Or21XEOQ?=
 =?iso-8859-1?Q?QlqyvLNTOXtTr+376dhIpbzE38bVbMVdRVTCo2fohnaGZCC3392VvmhgO/?=
 =?iso-8859-1?Q?O15doa93ZzT3JN4yHwJIsNICd0FE/hArQFy5h82cBS4slPPGFN1s3+NdFb?=
 =?iso-8859-1?Q?38w2Lorl1YYSR6xiO4FGn1pQnVO7pgzl5KvlFbK6oUeutrQFFjz8oGVAgc?=
 =?iso-8859-1?Q?Ko1PAKAeMxjY5I/XVCl+aqhTxWz79lQUEoyRZwIQs7Xj5nJlkz6Aw0hS86?=
 =?iso-8859-1?Q?9I6WLF612T+VtJx5xqBgwHfFCKGmgsAwf/XZiPGOp5URo357LqGVFZ2f9I?=
 =?iso-8859-1?Q?/+7GmDYCcOTRfbakmWROsiYBStq9rvKWa2LF4PoC5i2WHrKqpv92A5w8c0?=
 =?iso-8859-1?Q?33kRsNJ6dhutlk+DybcbMp7IVgn1n57aD1JGGapCS94ZKyuYlfXmDQn6Ao?=
 =?iso-8859-1?Q?/erOpZ2yHMH49nfMmXcEJvTB0yYemV3hKFkS7VX+yuSDTN05zsOB55iIqe?=
 =?iso-8859-1?Q?e526W/PLbCquz3ZjUCOEtuU1slVDxSpjzHR5WNB0yZ5cW9L7wHJFY937/I?=
 =?iso-8859-1?Q?5B8jj6/Qpe/+nB3vhxxoAVCTlZ16MCstOnvZQSFpmQuavH1wBnq8D1PGBQ?=
 =?iso-8859-1?Q?TTDhKyJ69bIVv8WH6LpJftByk+x5g217eDkMWaph46O+yJp/vwgd3wlLr+?=
 =?iso-8859-1?Q?eJgEB/0TLmxqxM+9FYDxMaepS04gKfeaCrj34naoQAnPe+auDcVG1DLEK0?=
 =?iso-8859-1?Q?uhrcCMyRYfJkYgCwAc1vHWP3F12XrSCrzUaRPyQvOw6NIF9Q9vsdaUGfO/?=
 =?iso-8859-1?Q?J0nqa20uFieQdNHNn8RxKHJ4UQ1kuUctxMwDQPUjj4kxui/DBFQj9+r/C8?=
 =?iso-8859-1?Q?3kzB/mpYfN/o4Dys35rzpQ9R8egpuLG2+HbDA28aIJij6GURjwyyV+dkzX?=
 =?iso-8859-1?Q?FP21Uxo6g6UV2AQy3NmncFl23uq1EhT335lI5fJALcpny9vJLS8PTyQbO9?=
 =?iso-8859-1?Q?n52zPyxUYeYl+vim9GuVIID1G4B8TeeiRwDDnKX766kspbuM0dqq9MhRC6?=
 =?iso-8859-1?Q?Q+zYvijr3N5O2b7xU703cU1TRR0ilgq7KcnlwKhnzjWdQZCg3GIkt9Jtma?=
 =?iso-8859-1?Q?+Wg4F75A4x/yxASlsTyvEG6h9XawdLIbzvhuK6QmQxE0ec+9yFrZYQPSIn?=
 =?iso-8859-1?Q?Psys/lVIA1rZo6Jxrnhremm5CUkOD6Nfc7dpMR7YvQm0nxTKujAb/zf01l?=
 =?iso-8859-1?Q?RpNiF4brduc6SD/M+bpDSUEamfkqjVYtV2z4mW2ZjQFb+iGtKjj6AghAl6?=
 =?iso-8859-1?Q?KPOZdORe80b1n779Zx/eWZpy+6lAFoOSHq/8u9DC4pC+Du3hyHn3gFJBIu?=
 =?iso-8859-1?Q?RYF65A0ZDOR2PlPAkRDZQ3aXYxnWDDs05B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eec997-3d1e-41d7-695e-08dac7a44773
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 07:29:21.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yriMb441A5xd0lPLaORiDqkEve3IEIULERYi9iR6Lh93EuG96YV5ji8ErNExhJxMVLXhygtDua1t9dd26HwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,=0A=
=0A=
This is a kernel bug.=0A=
./scripts/config convert "CONFIG_FONT_MINI_4x6" to "CONFIG_FONT_MINI_4X6=3D=
y" in config.=0A=
x->X, Lower case letters become upper case letters after process.=0A=
After "make olddefconfig", CONFIG_FONT_MINI_4x6 is not set.=0A=
=0A=
Add CONFIG_FONT_MINI_4x6=3Dy to .config.=0A=
After "make olddefconfig", CONFIG_FONT_MINI_4x6 is set.=0A=
=0A=
enable CONFIG_FONT_MINI_4x6 by ./scripts/config:=0A=
[root@fedoraguest1 linux_stable]# grep FONT_MINI_4 .config=0A=
[root@fedoraguest1 linux_stable]# ./scripts/config --file .config --enable =
CONFIG_FONT_MINI_4x6=0A=
[root@fedoraguest1 linux_stable]# grep FONT_MINI_4 .config=0A=
CONFIG_FONT_MINI_4X6=3Dy=0A=
[root@fedoraguest1 linux_stable]# make olddefconfig=0A=
#=0A=
# configuration written to .config=0A=
#=0A=
[root@fedoraguest1 linux_stable]# grep FONT_MINI_4 .config=0A=
# CONFIG_FONT_MINI_4x6 is not set=0A=
=0A=
enable CONFIG_FONT_MINI_4x6 by writting .config:=0A=
[root@fedoraguest1 linux_stable]# echo CONFIG_FONT_MINI_4x6=3Dy >> .config=
=0A=
[root@fedoraguest1 linux_stable]# make olddefconfig=0A=
.config:6708:warning: override: reassigning to symbol FONT_MINI_4x6=0A=
#=0A=
# configuration written to .config=0A=
#=0A=
[root@fedoraguest1 linux_stable]# grep FONT_MINI_4 .config=0A=
CONFIG_FONT_MINI_4x6=3Dy=0A=
=0A=
best regards,=
