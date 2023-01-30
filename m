Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4F680E12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjA3MxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjA3MxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:53:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C993C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675083184; x=1706619184;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jY7n2JBQiZwVuiqsKIqX5AC0l9O9Ct3ye8unNcnSGDQ=;
  b=fHTCMAu3YMZQwlOsTuxFnVbpYAmrZkZAT0xPUYV/6KpPHgyqAsyuviet
   4BZp3hwNE6EwqqmYMeMmKLzP1iaNJ8kJaxvPgnnAf8W84B1qL4mjxEmnS
   +vBX/1WDgd2M5beXugbIwNv6WWggqtHyaaKrl76evcaZWnkz/qzJoi/2h
   mhnB3gZOUyKPN1x2rtoxCxRGKO2l88m7hAljEAQXrisOcUXe09LmTiJlt
   mfc29GE8x/+EmlQjYrg81LBYu0o+nS9KkX48bGRD9Iy984t2Np5Pk3/y9
   TZx++7yeIk1vWGzd494TI+fEqdyPL58U56fu0ST+N7MzHpdk6ZE17dbvW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="392095786"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="392095786"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="732687734"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732687734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 04:53:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 04:53:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 04:53:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 04:53:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoL/aN10yA+v4BD9vw7YyCCRlX9/TA2YgxXwRL57zNPuUOjpfEX+Yrmg288exLHTAlw+B2H9nvcUPFhklWJWw+hjdjyhzbvCyxMe1wIe/lB5kvLcSuhYXakdExHdTdAdXzDexPkBTFojwZgffbBqEH6fhnJIgYEotbn8og1tcO7Y9uKzrEjGb6VCjqOeL6r4nI8SKFltcgZtLmBQHXLJlgCF4UWKfmW9gF1CiN2frrpB4j3urxOeRtVyWjPbmx30CvRbX19dMNVbY1/+VK0qLux+4hPxrhd7JAo4Ht8UayWfLLRVxiF+z4ncU4W6PrN9rxHaHNdj55p4NlGcBOYMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY7n2JBQiZwVuiqsKIqX5AC0l9O9Ct3ye8unNcnSGDQ=;
 b=ZtlEa/i4XMdoBGaYqYSBW07pSFT8E8wKSQs5Y5tH3P3R5byXB3th+Y+hS/7clO0HhvbRtMsIwy8k2OBLImoNuB6c23pJD/Xvq8Cvb1aiUfkx+CWM1GFKY1IhOqwkZ4Tci4WFZ6RAePTadOmLxT1AiyeEoYXE/IVJ6p+b9l+KU+srJKN1zxhETkuUVPrhNBxLdMxlLaOQODmJa+EaXgU7pNUfIUqYn1LpgukExP70P5ISn+SMpPZJlWzZJtH0cIF3wbybFpdeCWLa5T/Bs3xVlEv2EF9Qm0Nz9xr5AVH1KhZvKqjK/jCQ8E1H2+2hwjM17VeiQjMWdE0zm7d00VtaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:53:01 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59%7]) with mapi id 15.20.6043.021; Mon, 30 Jan 2023
 12:53:00 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     "giometti@enneenne.com" <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
Subject: Recall: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: AQHZNKnI49eu8Y/hqECZgV2CTMJQbg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Mon, 30 Jan 2023 12:53:00 +0000
Message-ID: <BYAPR11MB324012AC8F2EF3C8F9F7C917E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|BL3PR11MB6363:EE_
x-ms-office365-filtering-correlation-id: 7f3a877a-4b47-4463-19cc-08db02c0eb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSQqG2vc8YQuiWKhrftRjpDkVsXo8UV1qSSwh+2RctocnNsgf2XtB0zSq1iiycU8QV/x3M0AAy+bhJUSJItY0KfueUifvPmqyjj9fnamJu1Oyxhs43fOUkBuk3qWcGSVfUw6hlJmzdz8sqyPe01cd0mHWB5TEBBdyG8AVjnqj7gT3/rcYC8uIAjojyUNxrE+XyhShh6Dh7ZiN42mCYbkvEbaJiMtnLPCOyw0GC+EHWI+ku2xJWogiqW/qed9+Zni+wBr0g1KysfrfZTRZ1HGbeVbPRmggWUTlc7wlY0hj5CaJPbnyHXWZXBOtgAZbyjySKRqEgeFbJN37jULFV6VFc8p5/N4zb+Bkx5FlBjJaHHqQKh7UgiBqqEOREKMWBAZ8b0DdVDyU5GRjZRvB/0cByP4qJ4H8i9v/4YNcuXab1EFrm6bAT6mMTirzokAI7kBagJmTaN/rcEavAXr0UiC6rg8IbhrFpzLfBtDFlZn6pse9m73C6dmqZehasxB6weCzQOYeQMgjZQFh+thQv4wWgmLC8pl+JUySZpnzc52fPgnvivUjQwvx6Y4UZOtedO1sxgVIkLaWXq448JzbCjcHDcnC7pjebumF6aLEoJlrwfDHA0FHZq2KDtyvnCKuiL5mtNnysP3m/ZGw4GyIKSpSO9nqNSugc+s10s58QwLv1jvVdwjMMxWGZpq3i+SVNuw8oAOhKt+TiDBceHS9mwxVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199018)(66446008)(66556008)(66476007)(64756008)(66946007)(38100700002)(82960400001)(8676002)(6916009)(4326008)(76116006)(122000001)(83380400001)(38070700005)(41300700001)(52536014)(8936002)(86362001)(316002)(4270600006)(5660300002)(54906003)(26005)(9686003)(186003)(107886003)(71200400001)(478600001)(2906002)(7696005)(558084003)(6506007)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INAjvNNDS+ZDbUiDPl6k5PtAZItbtCcGStD4Sz+E4gNILnfwYM4eYk/y0nSR?=
 =?us-ascii?Q?TfFum2KKDUOwZMGmISa89eWSOxRfClktMBQkCM6Dsdzq2W6Fnv+RaOZNMUjd?=
 =?us-ascii?Q?97koo0eCpjOBPHHNy1+Llctd77x9kxgaxh4oGxO1d6T2p7Ex2LJhFTdr85wg?=
 =?us-ascii?Q?bwsLg2REQxQYjb+V5/8x3Xr2u0kYiKCdhFwYd1V6yyEZXkuiwZT5DtOPaZeN?=
 =?us-ascii?Q?K6BTFGWgt1ZDNoT5MBaYFvHBK9JZgewhjApcOnTMX40DvaonSO/deX3WfVUh?=
 =?us-ascii?Q?tXsNnhHPAmtOSAfLgMEh59vFMR2Shqm2LFggSZ99REzVK3yaPbcDuh1Oqw4o?=
 =?us-ascii?Q?aKGe/e7zwFYqdu5zkbEtYeF/f0OGxI8P0+7lQ61MaNpB1HR9C2KKq6iG95Zg?=
 =?us-ascii?Q?AghN7KKvg4kxO9PwYOaljMqyD58i4LzQ5gdfAXjMAs8g18uLcNlS5GHznH+M?=
 =?us-ascii?Q?lAOexAHmpVqLN/09iuL2LjB3BQlHHlcYtFnsM/BrX7A6h2tPaGct5pfk3RKN?=
 =?us-ascii?Q?2Nr/Fv5LmqSI5E/mqBcRkg3ciu+CcdnL/f73RRmHQZIEWjh7bEYzdsTQmJU1?=
 =?us-ascii?Q?Y9mUQZQpc1M4mBcwJnXvry8aac4mz+vC491xjuMc1Xet2mj6CbRpj6X4q2EH?=
 =?us-ascii?Q?e4hu/UpG1/Gsu7fkmVpnqCl+qmxy7aMXm+s/O61WjOq+rfltnEnCCWSMkPwk?=
 =?us-ascii?Q?Q5cZv2t628AIYhIJ9ipGZ3dRKMpUQIX/FdAZ05xp99hUYIajMMq0xwDDRvVN?=
 =?us-ascii?Q?Vu3G7Y+9hs1+rbIJX5sT3gzz7fl4UCimTmOD5lnotQrgkdH1kuqfKiQf32PM?=
 =?us-ascii?Q?K0UT/d+ZyeFPdWfaXuCDabeOitgaEtn+cPuYHnexLo3q1FnbFsm526E1JODu?=
 =?us-ascii?Q?8FJiQLkxRoaptll2/iFyE+BDqXjhB0sU9COpNX+9228SYIahXH/fwgQK+cy7?=
 =?us-ascii?Q?FjS9Ay+TK1B41Z16IU5a/UW+gJxxaafg4ridWByFgI9Ls/7FB+L4au8Q0ihz?=
 =?us-ascii?Q?XhrXtL4Y2NMDd1U/cKmR8XzkjfDfdZV0RXkghB+B00POhUbDxAqLNVyOhSZW?=
 =?us-ascii?Q?YNZVFnrk3OFxcEykleH4WdSG1C3GE/MH72P1ehdvIimUQ8a9ZA2RjTQ0PbQd?=
 =?us-ascii?Q?RuFcGkkQHW9WNhebdpQ8iTIAe63f+imO4eTpLmKU0DZHgz4VjIDKmQGuMeyJ?=
 =?us-ascii?Q?PkbdZ9woeBGRsZPq2BWLs1EW4TlnT0+Hb4o4oH0TR2yUyOHEvnhCsXWn3FVL?=
 =?us-ascii?Q?OHT6X8J8bMHbBYtDFTnJPrLpfsBRL2I6n4Vgq40Bl5gNPVzEjwC2N+PfJH57?=
 =?us-ascii?Q?ufOZXNWR+rO46WkiNMCiJMbi8bwhO0GnI70INja7ci7PY95mX0GYz4MyVXvL?=
 =?us-ascii?Q?gfo6DOT/0s+16Yfl/dHsZWcOsiezBcoTL1iCVN7gFFqxXAoq5K7mitL0AG54?=
 =?us-ascii?Q?dm7AcRYApA7zitbsKKo3/+GROJVzI364NgD8ST5SGaJj1kl6P0eTIRPrahRW?=
 =?us-ascii?Q?UnAUINaqmt/TReoUnsR3i8dTzU1bcIKAzEMTrGtFOmxlV4SzHELJch74v0rU?=
 =?us-ascii?Q?7gDy9L9byu5ZgsF8KftHI9pugzxZ3kvN6voCpFE7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a877a-4b47-4463-19cc-08db02c0eb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 12:53:00.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsFuFlT9jUEhJtPjihGHNP1eJTNkjmHqe3rkKtFCL1Hz1NlbxZLwJ0cEsk9K2zYbDPGsEz8ca5bZVMitKntdrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

N, Pandith would like to recall the message, "PPS functionality for Intel T=
imed I/O".=
