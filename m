Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDA62B565
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiKPIkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:40:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8965FE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668588011; x=1700124011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WFjwktM1+d56W486zKDT9Z8ACiPPBERbXSvgTlLuvqU=;
  b=VX2bJdultozitrpX7AyGWmNkdg9Z3nvkSLf+hpa/5mC6fQahR1av3Z9t
   1hOl9zKJKQdoe7zSzG4thZsDpfO/iRHTGK7PmqDddyPyh7/BNo9a/lzzw
   XIQxCkxog8rw/DenKrN6XkOVcI4orJd2RqarjYu4I2Fobivb88kTW6YZl
   ZTq1cI70zksjZCJVuH8ze+lFb3DajFI2qQHCuNlKgtibq5gx6WhGrEP3L
   2mYrSQjHGGB1/6eTejOPlPq4QRvcDLnD4eFNvZjNECpBd/7z6Sp5su9v1
   Yxnd6Rz4jcR+jhxIFSje1VE5oJe8fvgaUqYnRk6i1uHLYdmmCEe0m2a1c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398776014"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398776014"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633552758"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633552758"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 00:40:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:40:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 00:40:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 00:40:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSRwOoVdDkFSJlirbkf5Hpd39fNVPXt4hW9Gn9YB+cd7OAct4pRsw9B5nLDiqmoebOiLVGrWITWwZuRgZTP1lJd7I00sNtOW52Xlkb1zWZ2/AJpFOLUSUI9AxAxCoYGbyvi09d1qbXtgjNhkvRXyeJawyn9+7tx2l6zZoPgN1iLCsNVpe9CxOk+Vmu+2TcW3LoeGwp6Tvh2St+9jUmQJYAxPfCeFHet5x4QcetNJ6Y2XHzDEen8C/kniqX82Qp38Xvs5ngMKNRBgzP4b6BeyWanEm1Za2HAOh07Pd5EuLvjaItG8Zuq58sFxafo11D2MQwL4BWGG9S6m8AHpcxUTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peXOqtNPqcsmRJ5XhZWUydNYgI1dPc72/J79X7Pgims=;
 b=l/wxEagBA5MBmxt8hDiWfCYK50baomzwTXsaPvcvhLeBx9DhqiWEBaXOtcUsofJCGPbkW3z9PtZ1p3FwTGGJT3a5jLwyaTXJDqn/9ETWuWNoC1Kmx5kYi6m7ALSUgg9Cq9JQNRVhgLjq/RewaHCGEyVkIdd9x50TDNG7JBBSIyUYB1DU3QTwiG53iKUD7k2C49Tf4V9UjgkCLD9auzF8bSRoFkPquLu+/Ugat8dcHntJSnlmG2iyncVYJRMWPXtRcU7GZ1pF1Nh79KUWlMhrrM8ZWhZZ1QUiUowqqvcbwaPzD416ccgsZVijVq0ZLmOWWBt3UvNcStL7FMD1dL47jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 08:40:07 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::2101:1249:d2cd:7c45]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::2101:1249:d2cd:7c45%3]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 08:40:07 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>
Subject: Re: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6
Thread-Topic: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6
Thread-Index: AQHY+Yj2gEXwbfUqE0K+PqHC3finJq5BLseAgAAMFPU=
Date:   Wed, 16 Nov 2022 08:40:07 +0000
Message-ID: <CY4PR11MB1320725DD8AF856EAD3756A0C5079@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <CY4PR11MB13207C899E7C3FE22C1D3F2DC5079@CY4PR11MB1320.namprd11.prod.outlook.com>
 <ee196f9c-a3f6-05fe-83c8-c81fbd73acfa@prevas.dk>
In-Reply-To: <ee196f9c-a3f6-05fe-83c8-c81fbd73acfa@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: c6465c8f-5b8c-4c16-8ae2-08dac7ae2a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4SpPW5SaF3lEc77QAiKrXLytDv4GtQlZvQfwuTcIX1OdslKI4uG0v/xoAMTwUateaMERtQpRV/tI7+S6JFYGQqo/t4wKD3D7DSmaVB369C4tE8FlR+6SAT0FflfIKxt4kg00pidIBg+EhvRkbVmKKZK5JHk9jx6t4v/fcWfENV/BaS6YNGLVWAKC4PKihht9tHiE0Dt1b1h8+G1OKQ4+7DlKVj5EwDd6C0Y0icneFmkuThCxDOnhTFA2MbkQqFt3Z9Qvl1zmvoMk4WvZ9cTQdJrQ336CvUiMlvXOA3X5VfgRhp2AbQ5wTmFTf6dVg5KQxouuLlF7Id/kjDh+b8G0glw0mDMZgkjctn+NeL9JR0OaNK27P5PYPjuPFUKluGzSL6+y6QPiCuXeLo1JGssELLSTMcmAlflHcHiybeSuiTFMD5fkEmZ20CkM9b4AV7clun77HZTd/1olTVtOwRQTX8RfxWHnssqpCgajF2m3QtzXfXwyNqNjIQqvR9BOKl2AfAsmst/2pWyclB6Rj+DpYonXsjDfXWBFMhVizGvyJpxIo1TSu5jOYuTOWPSqIfw2M9CHExy/hZgFnN7xIXjdyHdTi7bsxNeOTRFB6R/JwtsOkAGmT+b/UieW0MczkhBJYSK7n77j8klUT+cTutTmQ5oRjN4jrDqaVWq0xSLJ/p3aYw9A4m34rU5Mw7ubiMvWkf5uGzOlQSeBSnoXKgnpTclov4mt5xA3r+O2qWPsfQfUMIFE6XsYF3uHScs/pWbX0zXHzx/3wn1e4ObVzHrJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(122000001)(38100700002)(41300700001)(33656002)(38070700005)(82960400001)(86362001)(110136005)(71200400001)(107886003)(9686003)(478600001)(52536014)(8676002)(91956017)(316002)(66946007)(66446008)(64756008)(8936002)(66476007)(4326008)(66556008)(186003)(53546011)(7696005)(55016003)(6506007)(76116006)(2906002)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HV+W1HH8fNY12fXB/t9t7MnMa3XkhKY963vkFclKTuapIMtyPk29BGu1m2o3?=
 =?us-ascii?Q?JtMIfjmILmEOuSHhk1WP1fqS09hKkP1YlASpIqoJ/Vhn81GlnhhBN6NGKGpM?=
 =?us-ascii?Q?lFSRv2BshvdV2chivXCr7ywPnuVcy6Di233ysaB2IGcpECka1La0VaRwLx1W?=
 =?us-ascii?Q?RDKNwHp7bwGKjT8Mu04Y10u0TOzmgb1EdylmsfEd5lhWYM1I1T4fELBSa30+?=
 =?us-ascii?Q?EiIUyYr2ruWL4p2RHgKLJaUc8F4V8a6qB0l/7GuoUxXkuhMZ1+DGjasgNX4B?=
 =?us-ascii?Q?HUtK7zuDxtCufiukakVHXmr9MjvVvFMTLoUC7IMxQj38o0LS3ZTR9cNWx4Sc?=
 =?us-ascii?Q?1J4QUzXNj2t7EEj2bh/RAWHrBQf9A90Zau4+FB/A/Db6BMT+wz6gACBxEIyl?=
 =?us-ascii?Q?t2uqHjmaWOIBcg/b2WVZSn8+R6eL56PgggueYxSqKxWqkNh2nwXq2GImEcJs?=
 =?us-ascii?Q?Mu51xdmKOwWsXz2Bc31RrX7HKrrxe47PPFkKMLNQdQ9sT9rMwNYMAaRPPfMx?=
 =?us-ascii?Q?sjDhQ2P9Tn2atHHk/U8XR8BOvsHTWZKyAyN2NW3ltWipzj8Sh4WTVMW+yfBf?=
 =?us-ascii?Q?vnnYvoc6bPzZL8DR9t+QCrTqsNAH8D6+ZE0o8cV0l2E2Ma/Bd1aZTpVqxY3d?=
 =?us-ascii?Q?6xmTGfy/j8nHm1dcm/qwzy13XPmffodH+t2T4cqlom2xa3b/C0LmGWeP75I+?=
 =?us-ascii?Q?DLyXJi5FLj6Yub0JFqFF9CX/Jn6Gjl1To4F9i6wGmY9TFP9y2hElyDObJOYR?=
 =?us-ascii?Q?4279YVPLz1yNstDK5R3cRW7m0BfE6dbiVY4MrRrZQ2HIYOPIqvT+tCpNR7T7?=
 =?us-ascii?Q?RoTNr/24o2LyD/DDjnOEG/qv8ruwcf6OGp1ZtABgxm9tD+91LeEX7VeHVfpQ?=
 =?us-ascii?Q?4vSXwOLZdzpfXb7tBe3vN+BNN5M1mCIU19szHZOPgxY/4ujE+SeUJBP1qlwz?=
 =?us-ascii?Q?HM35h1bPKDu3h1zDhdzLBOyYudvToxY0TKzLjVBb5TOJB98IR3gIPyv3BXVV?=
 =?us-ascii?Q?HG3KQIrR7Rjk8U74dqof/kQmTAvWgowXzdBeNX6ue/zk/ih7Sr3mZNSOF2f5?=
 =?us-ascii?Q?+nhY/o+nvBMovF4Z9JbWNIhR6wVxcdVZIT5GAvctanoWkeW3mAKSToTkFhEd?=
 =?us-ascii?Q?C2m+0oIUaEzUf9jR+x8I/yoL2yk/uklZeX4aFjiP9baGjo4gvMBHnFqzWCJJ?=
 =?us-ascii?Q?nhz+7Lt6Rw/Z7cCgPlENpRLWUJsFdVtej36kcPGFPkJxZeHCDf41vcTwF+jR?=
 =?us-ascii?Q?l7WG1WEEc3zfWshKKb0GrpX0ehy53l7gnpmO1V/xvGBHZILOabr13jDEHGP5?=
 =?us-ascii?Q?ehP3zDgQvU1MEcK1q/As3lU/MJ2WYFU0IntHxjYnDCdr2C6/y/+Q+Z70ljT/?=
 =?us-ascii?Q?uRV1BWEPK3EPjGrX38Om+OjILiyHYyKe1TjCBGx95IIjeSiMk+YpvFerpiuI?=
 =?us-ascii?Q?xTp42IWCZGvk8pKPnSfsqHSP4JJl+eS3Mdlj6CXrmcftNVHpmGJ6Fg/beFCa?=
 =?us-ascii?Q?rvWrG9pSk64/Zp5+RapOf2JbIKXbENdDTHOu3Rw5EuNTMKUTifj+hesXTDC0?=
 =?us-ascii?Q?UVi1JQ5dCiINQDeOCrLUVGQHEkzE+TaCVieXwacK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6465c8f-5b8c-4c16-8ae2-08dac7ae2a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 08:40:07.3118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04bXUUGyn4072b/D2ajy6ZBFEgd1a/sZiZY1HALDu1Z2eHO5gHJ0TtPpcVWVg8nc+6he2iu7db57LrEl4Qrugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>So perhaps use -k when using that script to enable one of the rare
>config options that contains a lower-case letter.
Thanks, it works.

best regards,

________________________________________
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Sent: Wednesday, November 16, 2022 3:56 PM
To: Zhou, Jie2X; linux-kernel@vger.kernel.org
Cc: Li, Philip
Subject: Re: scripts/config bug: can not enable CONFIG_FONT_MINI_4x6

On 16/11/2022 08.29, Zhou, Jie2X wrote:
> hi,
>
> This is a kernel bug.
> ./scripts/config convert "CONFIG_FONT_MINI_4x6" to "CONFIG_FONT_MINI_4X6=
=3Dy" in config.
> x->X, Lower case letters become upper case letters after process.
> After "make olddefconfig", CONFIG_FONT_MINI_4x6 is not set.
>
> Add CONFIG_FONT_MINI_4x6=3Dy to .config.
> After "make olddefconfig", CONFIG_FONT_MINI_4x6 is set.
>

From the script you're invoking:

        if [ "$MUNGE_CASE" =3D "yes" ] ; then
                ARG=3D"`echo $ARG | tr a-z A-Z`"
        fi
...
MUNGE_CASE=3Dyes
while [ "$1" !=3D "" ] ; do
...
        --keep-case|-k)
                MUNGE_CASE=3Dno
                continue
                ;;

So perhaps use -k when using that script to enable one of the rare
config options that contains a lower-case letter.

Rasmus

