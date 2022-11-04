Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E4618E35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDCUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiKDCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:20:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE32628
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667528436; x=1699064436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GcRt0AWyVXREFVPd01sAcDNi2gPzuux3vpsnBRgrSkQ=;
  b=QKBsyK8FSBITR1rlGfQX+eSOv7IwQydw/NPW6tLBF4m+6qVblu085Dtk
   RzWv2DaeZLpZBQWgn43RYNkHdCECnFFy6qTt8TL5Mv7q3ELZhrIiMzOX1
   eellzsg/0woTrvi+PoDCzz5o7v7J6sGIWvylLtBf2gzopYA5J5NCpUTWM
   ZPBjqCPqehbg7AbQZis2p3bOd9sYXjlSs9yl6oG/IaZEMU+ds3JFSzIEN
   0p7819Ldbo8fGUQSs1aFDVyQos+VQr4pr/xWOkNS3DGSuTkB6+U5ltrnJ
   zRIXsaoQXiJww274b2ak/8Qlp1noT9XP1Vs+sxjgQkgTBSb0PlCM/Jk9c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336558288"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="336558288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809900725"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="809900725"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2022 19:20:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:20:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:20:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS0+lBX89P4PtZdf5h2fenCun4SMgqjhE8awLO0nVj+lbemNfFSLA62UTzuh0ym0ssTjdYcIPPYrs6xZJV93YR+kNLRRp37oqwjmjpe6x0On6U/jickeiCufryeOj9zYoO9jmu0xggMLwIWzft4Wz9vcZxJSAOuI2Krp7MkGsMmfyegam8h7CnKfse60/qV1dWo6hUIurAoyWOUZlb6/ZQO3WBaF1bldvjA3sS+FIy0lQ5sEEt4NCKhFpkfpAWbbRL2kJ5kwOkrWnMiK5kWurdg4eZHveSPrq0gdq4+P7wFfgbfTHreqL4q7q6uVtDVSKPW7NmZGK3ua97sO4Pjy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcRt0AWyVXREFVPd01sAcDNi2gPzuux3vpsnBRgrSkQ=;
 b=Ds65VKh0K3rngirlpmju/wqQiJ1iPinadjFRvZWqg+i5KZGDqc+Gb69/wFR0uyHxqyIJGcrlpiVomdlnOmpxI1UovG+EO8JIKQDiWp6W/wXM+QsOk7clok+QgsEvRzWyINVR6/0Eh8tLCmBU0wHdalA7XOSgRwKdburENitnHS1wpzG36/JGHUISNsKhlWLmchm1Lcio54Wo9K65wFK2jNJ2L7rmIgQppKlIZRBhMs4fJ5gzDzKRoqC5ADLRoRsRf4uRBCCty5wt03529uMnUF/CLpQvMg9IR2ZRbhF5xU4BNrDIzM7uUErjKPWND1RJnFzOz9lQD3Ge7HCvv1eDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 02:20:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:20:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/7] iommu/vt-d: Use real field for indication of first
 level
Thread-Topic: [PATCH 7/7] iommu/vt-d: Use real field for indication of first
 level
Thread-Index: AQHY70mhQejafyVHv02dMfcTRu2EHq4uCWFg
Date:   Fri, 4 Nov 2022 02:20:33 +0000
Message-ID: <BN9PR11MB5276B0297ECFEDF9323B09E28C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-8-baolu.lu@linux.intel.com>
In-Reply-To: <20221103055329.633052-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: 4346a9dd-71e1-44e2-2f4d-08dabe0b2755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJb+LcjTBT46VuqoHF3+JCLlpsoZLBSIzmmAbg0jziGz0l340j6vJliEhFquroE2bX19N6nlYTgo+NyC152g0oBu/YMFR5gV1OE78TNkdcwQQ9v1XrDSmXRXIV5vE1vdO7sk7IJ4cqYqq0RcyZnp2rdmDWzIzacjVhAkPlqggeTAn9Ij0l8vRX0QD2UBf2PXp4gsbqTlzBftd2f59CVPRMbiKKObp/F8SkbAZ0Ngsc66xLC4+sykE4xSVth3rodx/csqW+mQHRJZ1uSF1EILpc6RPnzVuwgmFF6VI0quDIyR2P/XtIS9lTwngJR9A4icl4liAO9/49kKW98viOwEqgp4cllaDTu9XlwIsURam0RrxuRa/nv9DwHQIB05EKs/tvfJzBCSHUhPec0FR0gfcWmdwdYBVaLDdls/EqricIRFxjp5rHECMdPU0mFvDPjw8+S7edzZhcdebigJEncl0Oo3aEYJLStpHGMGoT/C9a8q8J7CIaSf13vs20a3sd5neBQ2rTHNlr8dvEfXA3m277kXmxsAiUzEMrQO+hy1mOmnErbEcIJWDC25kh8MHHMdpkOw1WnnNWLcf5TEo9TDbn+wz7pM5gBTQoCpi+5OGEKpyNt2kDEVG/nndkjpzVIa8eT+8b0ojzY+V6/P2lNa/wjd6ZlGLxp5eDkqWP1qMsIoq2R5lrcfj4LOIjyu8rKV+tghTeD0fAduuPcVgbsjoFJKMyR8EPI3PMInqFXZu983AUXVDQAgLvOEJkqXrY/dPa8A7r+4UGWHA0rfW4y6qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(33656002)(38070700005)(86362001)(82960400001)(38100700002)(66476007)(122000001)(558084003)(41300700001)(2906002)(5660300002)(76116006)(6506007)(52536014)(66946007)(66556008)(4326008)(8676002)(7696005)(64756008)(110136005)(55016003)(316002)(9686003)(26005)(54906003)(66446008)(478600001)(186003)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iWbR/GJigBXXEEt6PW+HzJ+A39QIqrPIhNxicMafxMJg/N2TYo9d/pLRFCN1?=
 =?us-ascii?Q?55hB/AhoQrVue1iMVIKTFRiwUVg2SnOvDVz3ZFdvr7mZCW1ZnQYPBLeQN4B/?=
 =?us-ascii?Q?0GYoWriRYRqEk0ccZ+9LmYVc8QiGcemfEQGSp7VLvgSLNZIdmQscmv2Iw/5h?=
 =?us-ascii?Q?EKY5he9Nqtx0ejZMZZkBt3waCvl+ykqhy+mjDkQ1whOzModjgaCkq6VN5A5r?=
 =?us-ascii?Q?+/3gbu09gm1BAM/VA0mlRooqkmQl5ygtTrU1Sz66+NPQL/Ss5mdQRzONbEpv?=
 =?us-ascii?Q?vscP0og3LB+uVYdU8V+l/8/BU86+H9msfXLVd7j9SWbm8z6zHyOsr0XpAnJy?=
 =?us-ascii?Q?WepSAUmHI4Gusf5DB+35P3+LOWGqTp8IuAd/4z6CVoPNKEI7Hldb8ulWRVok?=
 =?us-ascii?Q?e02MU+FIh3BY4oBnGrQY/aHGqv80SDG71qOLkC5f8EfkRkaBdUPhw8FQ5CZu?=
 =?us-ascii?Q?r+6su0BEu9Ig85MwJnjPS0JR1h/D9JmKbCgPjPWrbAbQtzCbhO8Vv/VyTDFX?=
 =?us-ascii?Q?mfE9Jbu535PwevAUtwOiSFSIYKIJvrwd5FMESvb3yFu4GypxDL7fl+sQ+G31?=
 =?us-ascii?Q?giuTiVMmncEAbgXE8kp/L4KRcPFVA+gL1MKTtgCup2uexQty6QfHzhac6EV9?=
 =?us-ascii?Q?5IxaSr1PGnnJYWXfh5jfvqzHhq96Pdi5pKeA4EGrEqRUBEEoKvoH+l0XtOYm?=
 =?us-ascii?Q?rPRvthI4IEBONiCG6pbwHNVWAHzW02AnMqiH2uRTUafsFsLXcXF029AYm8LV?=
 =?us-ascii?Q?V2tiXOGMsKRud535pdqnc2VGLE4ft+Ur8Sjb/y4bZjPtQ+gd9xjnGA7L+NQV?=
 =?us-ascii?Q?weuXV5eQwwVrFDcmQ0jKbmV5kJIRtPTpTHVVB48J6TGstey2ISu7VDu2RRK9?=
 =?us-ascii?Q?fQ0RdlmeemU8vefNxmYmotnl+1BvWuyOwpgZVoDuyIQ+F7TArRapyIgFqUFs?=
 =?us-ascii?Q?i0WtoFBPyQKG81DlZnR1BDE5bJgrkpw/tLZIkC/6rSDHBHu83a/XRszgOegW?=
 =?us-ascii?Q?TejmNc+hr/EKZAgdS3D8BFm8DD/L8/99puwU8v2kC1D2qVLLBlxSEl+R3Rzv?=
 =?us-ascii?Q?9OEQhfUH0ZXY7OQF26GnD77TZ79++O811WxIISrsTu0eA9mIoA83Ck4lPnvq?=
 =?us-ascii?Q?wFAr6S2b70xO7/JMPe23YeWf1oCh4gFwCNrnh5YS2MTBn8ri/+a/VNhirHeS?=
 =?us-ascii?Q?jBlmSCVD0s23pHLBnopHn/1gG5SeAd5JkOW/AdsTK6VwAIsd+DqnBoosXxdN?=
 =?us-ascii?Q?55nbBylBo1CAfY0HsM2z6n/rIMIZKx/ANxHvETbh6ppPZaXGRSqQCA4FHvR5?=
 =?us-ascii?Q?s6zXrbJANW6vccEhTBcpUPaKQCaZx05xsfpbarGASMC0Prr3LJmLay8hSV+O?=
 =?us-ascii?Q?zp9yr0iX8NSMGFAQsFLkWbeLPI2IzgVgY0NptnQo87fd2kD08qP8lhZTPnmR?=
 =?us-ascii?Q?heT+x3gYW4hcGKhG2GtzaSBJz7jRRl3E425Mxl8lb8oEFpmH37mljeUI2l9u?=
 =?us-ascii?Q?3q6l4zThTBaLuifezxqep3u4FHKi5PCS4t3s/9I91Zf/DXrzC7uJ6IvNQRVA?=
 =?us-ascii?Q?GTQzXyj+MVKPYBizAI1ZTDmNUI96aXy+yE65vJgr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4346a9dd-71e1-44e2-2f4d-08dabe0b2755
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:20:34.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJ3/H6t5HGuKQGFmOiRqH2j0H9jXrSiclixlFhiVDpdFXGiUpD8ex2vBM0ZMnGx0LvtHsPrMN5sndJvsSXOnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 3, 2022 1:53 PM
>=20
> The dmar_domain uses bit field members to indicate the behaviors. Add
> a bit field for using first level and remove the flags member to avoid
> duplication.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
