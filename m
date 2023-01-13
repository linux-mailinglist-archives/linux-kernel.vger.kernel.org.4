Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7B6693DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjAMKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjAMKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:16:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071B60FA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673604985; x=1705140985;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=z9lTqTerJMVCdMao+DPoft0xgfGx1HnGCgb0x/EfUS8=;
  b=XJaq8prUKvGCb+HQoelfQ5PKejmPsmSLlU1qTAfhmRj49GHYh3wcBrnw
   5xPFTMtjPnD8jFOXJ5Zkd0DlqT2nRKBYv7AcnrPh3x13d+bfkHi3ySRbw
   yPFkt6wIYAaqSiBYTfCd0WeyQkipBle8ZG66G92hr6Gc1vAnDaD3ah5lt
   +aFnEgsVj24MDf3Q5mxIfPvRkHxBuWt7+5Z+J1qZjiAW9hL2e+6WZGd/M
   1HWVGwrhlDYdC0L+2GifdG6z9WQnv+y0jIiWfDBv+TT/VBl4dJpJ7vooN
   HjLGYLLluLR0sWOmLwvKc+bOnxHE/IsOcEPBM43hj7hdhT5aYOkHrWkQd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304342238"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="304342238"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 02:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="832028023"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="832028023"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2023 02:16:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 02:16:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 02:16:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 02:16:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQEkd+HYQE4U58YeQ3I5M7fOfQNaMFDsdNrPJoqBfHPrDVVQ70ktzSQr1FK9rHibh9CKJF5AjGZgWDd8ReUOIucJ6Q3pe7Np2LoJo3BRzVBspsVjR7/aNmel+q8h7gIaGWcIGqDB0oOrr4Mt94dY7iJkXSxemTbBaHfKxGr9rU16GmaUu5YTmTEFqLBEJqemN2eBrNts2nnSeOAn+zW0ogmdff5nUUNdI/7t/x7xkr7YbQiIHxT+KTJrCsV8yfhzWXjOl6w+ycU8nW1xRs3vSgLnAF/AYkK5dqaNuhGg81XcjDvsQI8V/qrJ56GjGdAH8ihZ19eYrvAPMfqQCpPRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUpLNKJIMBgKQzCMdeOwL669if1LaAJeLwtMJoPjpqw=;
 b=GzhZ04pxJg6FOjKpcSoTrZdCglh+2Jsu8oelaLN3SB7GCfV+0mXPpuC0Rrhsdp7v098VAJprLagOCPu7rPOwr5q4d7Ih2nXThM0t2U49WSAkivxFSqUWjHkO8xiy2xUM+9Ebi/7JtAO87FEXql5bzEYS6KTvgZB0GGgiRHU0KHGToKL6BbhIe1YkgZB2PykIDVrmMnWtAqa/TA7FJAkSsg105iaWWJMOOhh22l6CrqGGK/n4aAjCrTSkjGJVhmmR8PnK8nMVDvpRvD0ET1N3ENtTi7yPGPh+9h7qxrVQcaou8fGTlHTvAM914uodqCN4slQFREhCU4hgNzoPj16wjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 10:15:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f42a:63d9:2c7:356a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f42a:63d9:2c7:356a%5]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 10:15:45 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RESEND: MMCONFIG related question
Thread-Topic: RESEND: MMCONFIG related question
Thread-Index: AdknN8UPqcs0NvwITtueOaHW/mwOlQ==
Date:   Fri, 13 Jan 2023 10:15:45 +0000
Message-ID: <SJ0PR11MB67449911D6906A753244AC8A92C29@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: c073f07c-dccc-4171-8645-08daf54f2258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aX1A3EnweKvn5q4n4nIlA65nI32i6xDhYbiB4S+Fua6BS9lNrZwBLy372930Eknnw4YkzA8UnqNRVLhH/Zsm0HCeamPJeAH9am5i1KCefPdS9EnzSs+Rv4d2Kiq1U74JfmzXb6zqJE8EX4LECYjb41UKa6HkFFy7y1mqt0INlPnOOwc2R8mWa7RTutB08N8sg6WbugaFuELsAmRXqfw/9+D/KRA8Y2fN90W9IATjNiWn3Grb1jZsQplNv2E4TuQkjktLhrGI2jmj1WHfclij337dlGOOBmDHgV9I7Ep4XenO5KwD8SshbQiikierIY5WU2oyOKlNTBmJ4Og6ZX1FhpCOtH+q/1wvb/2irFATcYV0zKVHaw6rE80xZs+o4toSKSWb0OYx7T5wzOPRnAxjt4r9qEa+e+wXmB4G0Ip2Cnyv+Ykaay92oKMxMLCCaT9wJHSyzjO6uzNeDPrMe6xT4/pt86nOjscpA9V0RNRX1b/+J74x19hEBdJ1pORMNWvLlGkEF7HYIJY7RPrR5o6ogYtVHkyDaem/N+e9Btsu3/Q/Iyu3HMWUc1eHpWumcq1J0BDmdMmq4ky+pHCQ8rS699UC6BtzCoaFAUAOsqq/B176EyxH1YdoTceaHuBpz0BRb5XIrCjfxUvvWUO8d7Uz8sCP427QMMQKyFlmTKtZrlu+pM3WRLWxKUF3627mT8sYvSeaR8hqlyvzlPSwlYjocygD4PHpTs5IWk11IFS4RtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(55016003)(71200400001)(2906002)(6506007)(107886003)(9686003)(7696005)(478600001)(26005)(186003)(76116006)(54906003)(4326008)(6916009)(316002)(66946007)(66476007)(52536014)(64756008)(8676002)(66446008)(66556008)(41300700001)(33656002)(5660300002)(83380400001)(38100700002)(8936002)(122000001)(82960400001)(86362001)(38070700005)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bl8uSzGQv0eRNAzlKPToEWfKWHl2KXxFEgYz3nspy8hGeUTGE4forTaQCH4f?=
 =?us-ascii?Q?gADQo+mD7Nhe3paEcMs3XLp7GuTSSxmTCmHBa77iyg8oGtJKo75yJ259fAdF?=
 =?us-ascii?Q?eS4UaHyu5WJ34M14t3sB2ogZPdOHwbI8DfU33Sk/N58tKlfXceckt/ks3sha?=
 =?us-ascii?Q?KBhyLje5zqWiAYgGKzk45K4zOydr4VkgWUg75oWQsejxf7B0NclAAQJzbAb9?=
 =?us-ascii?Q?NBUHYixJhJsU9SZq10x58Y/+7UcwPU73+3GQAtX7B25nrKBl12N+USjW3ind?=
 =?us-ascii?Q?rNF+T2z+vbKKd+06x9nqXI3pj7VIkYj7AqFjNooppqYtfCqySWkPDhbeS4li?=
 =?us-ascii?Q?D/XR7su4RsSud6eLZMigk1YLPOF8tJQ7sowsMFxmiZ6Gr10WmebUaCnqt2pn?=
 =?us-ascii?Q?o+vaumvXnwa1jmX8hyfETmbN2iEXE7AhwhEJALjgs0peU5BsuBJ8J9z/j0vy?=
 =?us-ascii?Q?Dopn2Xihzpf/2JYS/5x+CFY32TKwq2MsuSg2NxO7Hy/XeMFSDdZevvSHm1KS?=
 =?us-ascii?Q?RYnUhzlN1X0L0IusdJJjArkgA/qk0mKW7PMqluONhNT3hLT+dUkYdihGLaxV?=
 =?us-ascii?Q?FSvcOX/0EfYbgQq6+RMu323WBH1XsuHuGhbwzfacknsRMUTtDlZL/etacUpX?=
 =?us-ascii?Q?UQwd8yFFNlVdx29vVRVsuWh0+F3zifk5JgbZzwSsqB+LTRukIR4mUFyaKc9T?=
 =?us-ascii?Q?E2nC4slcSlloZfaOWmfX5CsHszqTNhaR0361JtZd+pliQUfedwnomE3JPIuR?=
 =?us-ascii?Q?nm8oknUXkTtiqBUf0lcfLQXRuF5BDDzLCWxUoUn1hg+08kNTaWB5QqKO1YrV?=
 =?us-ascii?Q?u1cAif7rNGpir6Y4efA7c/5Z48ld1oUCyFxl7sfgP3uvv1YaqFxs+8uYU/Mg?=
 =?us-ascii?Q?0P4TH1ELgZc3Go6sNqKr1oolC9UjMw5yFZ8tDDovzcY/B+wFIucRACDYo8cw?=
 =?us-ascii?Q?Ekibn15JJVNFoUUn64+3cjrvY3cYHS2Z8VaQEH3fI1wjNICD7bG/k6YxCSre?=
 =?us-ascii?Q?omcIZky+GosWKvTejeb/CGSmpbdKb43lYErjsqNYIhcp8XkQC0rbkMIc3aIQ?=
 =?us-ascii?Q?AzdLVnEi8nyrWVhHl6l5/fGuNNXlYsxnqdVTy6F1WEkeLlVNrrTU4UM6unEc?=
 =?us-ascii?Q?nG21Rt4Cn48PlmFkw4mwuIiyUhWIAYqq+BPLTs5sfUkGa58gLsTb9wzFlm5l?=
 =?us-ascii?Q?T794jV5Rt6IORsG15Gio4QvEbpDnU8pkJIisZ9/lpM2jc0lgifY0NlWBYeYU?=
 =?us-ascii?Q?OUI+gN+7Rtv3uz3Xc08bYEZiWlznigoP7wVHiZu81PrKsDlF+OcQ+7T8K+UD?=
 =?us-ascii?Q?vSzUncm2/8GCxhQuy/p+vb/JYPqNah3+CZm5wMPW1YJt3F6rlw9gD0X7/LoS?=
 =?us-ascii?Q?htHGQz9KFARemU4vTidsevz1rXFty86/xTo0/PnIZiz3ck39jsehTn4x8cm/?=
 =?us-ascii?Q?OZY0WNfBgBIdTl8MKoHJwjEZ114zXEzh+IcHueJZ2o9AuSEZgGzYKbENqFkF?=
 =?us-ascii?Q?KafnPkFnzmqcn/6qTTtvAmjoUMYSWFIMWU7FxpsCFESwChYj2T6hWcjd7o5f?=
 =?us-ascii?Q?luj6p6I0tsCPK3gWmReEyWQ3ZHdDHg7ZfMrK/VYb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c073f07c-dccc-4171-8645-08daf54f2258
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 10:15:45.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/+rNQnZNhl9qfAx59a6wHuivw7iKtWLeYuQxUCz2lzY5v8qUFYWA0bqZQqLF6IgpmKQfYSMgkU+NexCOvomhSOQC5qKy7qSxD6nWLfEkcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend due to format issue)

Hi Helgaas,

Recently Lixiao reported sriov disappered for cards which supported sriov. =
We found it's related to commit "07eab0901ed efi/x86: Remove EfiMemoryMappe=
dIO from E820 map" which removed EfiMemoryMappedIO regions from E820 map wh=
ich lead to pci_mmcfg_reject_broken() check failed, raw_pci_ext_ops isn't s=
et to pci_mmcfg finally, below is the related log. I know maybe bios should=
 add MMCONFIG region into ACPI motherboard resources, just want to ask if w=
e would support the case when MMCONFIG is missed in ACPI motherboard resour=
ces as I see it's treated as "Firmware Info" not "Firmware bug". Thanks

Also has another question, if MMCONFIG happened to be in EfiMemoryMappedIO,=
 even if it's removed from E820 map so that there is no CRS clip for that r=
egion, could it be used for BAR space? Will there be conflict for BAR and M=
MCONFIG access?

[    0.000000] efi: EFI v2.60 by EDK II BIOS ID:SE5C620.86B.01.00.0763.0224=
20181017
[    0.000000] efi: SMBIOS=3D0x6ae78000 ACPI=3D0x6bbab000 ACPI 2.0=3D0x6bba=
b014 MEMATTR=3D0x67e99018 MOKvar=3D0x67b2d000
[    0.000000] efi: Not removing mem06: MMIO range=3D[0xfe000000-0xfe010fff=
] (68KB) from e820 map
[    0.000000] efi: Remove mem09: MMIO range=3D[0x80000000-0x8fffffff] (256=
MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
[    3.351098] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[    3.351742] PCI: not using MMCONFIG
[    4.867853] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[    4.904325] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff=
] not reserved in ACPI motherboard resources
[    4.905061] PCI: not using MMCONFIG

Regards
Zhenzhong
