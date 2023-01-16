Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809466B567
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjAPByc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAPByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:54:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C87297
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673834031; x=1705370031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5chWlG6Onqfdw3CICHI3M8ubD6pnwf5CR6fVBOQL5rA=;
  b=oDoAGj5OmePc/Iz+YN/2jKZpPkW7vvZ7ctRwLH4ygkOwR5xgAZLy7I9C
   RiMkucjGIAeZYrzZmyGbbNU027jmAprE2AlTh52Gtt+iDKrZmhmZ/LvPt
   ZbMOD3NwsqnY0HX5IBSljtevjrHLrpC9KZu6jM5sQj6AFzVU8U19Yv0bm
   iaaXpfBQdohgjt8lz296HOiZ8v1817JNklW04Z0oAsXhdq/XmoWZuMp+P
   toREW3s5Ky50VGCmN7fmKTDwE5CwIfKWnOgErsxh6jon34wL7B4U7QHpl
   daflPR3BPllL1j8uX8X8HhGFr+q3yY9qrNAWVnDwk5sJlkoV2ONC5GjC5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326424777"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="326424777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 17:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="722125531"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="722125531"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2023 17:53:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 15 Jan 2023 17:53:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 15 Jan 2023 17:53:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 15 Jan 2023 17:53:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd0Z+ArRiK6b03FB4f5RX6iRW/LG6m7NrtIjlhEeozfbgw+V+vmoAmI0aEPwYwYzOQ+hNr19Kc6RGg1rB48I5hRnjQyxI6cShRg5FiABwdl5Ko5FdaFFyhG1jJ/yKI+sG+NYu55OD5jd3QRykBnLJI/k/z2leXseM1PkTxar13Es35CVakFseTSZ0ePVlBkfHfrOlb1tBWM2fhvnDcY3NdVD/hsCltMQ3B56GVrxNr1VKN4HFwwi+EjQot8lZ8tCWPMCm16uBD3Z+3g4J6evkVK1oaDjDafmOZ6AXATYNx9B+BdoqhxJ6zSJmfC7qtRvblsQS4C7r5/YbRE86kXggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD+r2wtTMAfFmSvIpFo19iszCcsm3iDS39jYB1B83TI=;
 b=X8LVgj3/SrA1kfcGZoEuH4l4+wvrRMbN3UpeV9y848O4AK8Ol2BdOqrw2n9XmuVBB2gytb+vu6x1cPVOFW9r+AMEctZKrf/LqKQ7BIo9ggTs70ioD79Hl5kDcdFc1F82jnrKzi1o2O0zmycao9FvOZ4jFhY0zlLUgGS8ROdPvZKVm4sBIwwhGzvIBIJHask3zP+J8YWE2RgBEQ6GUMhuecxa/a9x0VQL39z3ODUEgGh4UeCuOLJfJl2jgz09DvZi0PENo23UtiL+DTsLvQ79RB3gBFj+Ab7TrG/ef/mPmjZylb4N6n6CmWq+jNjA1NYE7tsh26X0599fwsuCCISsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Mon, 16 Jan 2023 01:53:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f42a:63d9:2c7:356a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f42a:63d9:2c7:356a%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 01:53:45 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: RESEND: MMCONFIG related question
Thread-Topic: RESEND: MMCONFIG related question
Thread-Index: AdknN8UPqcs0NvwITtueOaHW/mwOlQAHq2yAAH2Gn6A=
Date:   Mon, 16 Jan 2023 01:53:45 +0000
Message-ID: <SJ0PR11MB674419202D61518CB81282DD92C19@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <SJ0PR11MB67449911D6906A753244AC8A92C29@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230113135343.GA1834989@bhelgaas>
In-Reply-To: <20230113135343.GA1834989@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: 8e1ad3e4-9f79-4974-c107-08daf76480c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlN4a8vNOtArPni3t7wa/IyqP70jrGE9Y2gjZLm/N1MfRUWscPDulUdEI8sxSeA+rRy2Mr5JdjjSeLyzxuHKW80I7y/G3HBDGiaQO1j45hClkJe0fFHXbSf93GaVhON4rB2HBfrYYSxvPP+QHf22RrQPld9vvtkXI+DkfdZW0H5XfXoa9iFGOvpaSLOubIy/ksEr9XaXpeo9hUkCLsQK39+N3P67HDzBpXYgVhItNg4LfaWTmdnZPvtI3GEEeArs3h2dOuCDZ2LVdap8iHAvQ8veHzMNpzBwIQpRfnwNUCl5U+ZkNOCQ6GQKGztL4L7EB5KK0WAJvrD9SrlWn3TZGhtvS56tMNcgNRafhnU/Rxb+ZJDrCm93LuXctZ2z87Gvgt9TMgQ8VbTQblNWv0gEs00vFiEPNMbwEQPxo9jjzmI8khhN/rygWsKYY1bDzB9eTgaiFA5eMGBdxD+Od908tZ8lx4/OlV+mofSoGLUk06Gyhjqo54lRV1OQR0+h81opyv+smGx7yTF5EsmBRtP9GcFvgs37vo+mmQTv6Pu0ZdO0asofet6BsetSgxNb+jFkq13NTbrP+brg6KPpXi5kiu9nLRQFCGVSQlh/qP1FaZgjLKplbm5AIutxAQwZS4DES0QTObc/6vN7k7gMmiY4TsIh+ltlgwmWoFK3qplis7RAMd25C8EFxho0+QdbOg1WFO5wUTZfWfHqGKUllFbwEgW/IUxbQEcdAFkEy09Rt0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(4326008)(6916009)(64756008)(66946007)(8676002)(66556008)(76116006)(66446008)(8936002)(52536014)(5660300002)(41300700001)(33656002)(107886003)(66476007)(478600001)(83380400001)(186003)(9686003)(316002)(26005)(6506007)(82960400001)(86362001)(7696005)(55016003)(38070700005)(71200400001)(54906003)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+kz9F6qj6Y27bzUozsH+5x6qeDS+Ou5IpnPudg3rm0NKjxuJ6CSIYOEYEgF?=
 =?us-ascii?Q?gkrEHNw6KdCr8F/vd6rT1R8wSOIhQELhVwVIUzfI7pz7vtzQlRjzcctzXi/H?=
 =?us-ascii?Q?0vwHRtyrhrb1RUVJr4cm4gEzlKtgtokkVsC3X3eokQFS6kgS1GFQ6YwZWD0t?=
 =?us-ascii?Q?hsR3HheTHB+IyxTYHKZrcFT8GXRavxT1q52epaU9yUJYTcfpNYcEczeaMr/j?=
 =?us-ascii?Q?ggFgk3JHhmev8n6y6LoTrgCYRr85a3Oa3eZ4bJI3UlI3nyFtMCjhuxNVYpj5?=
 =?us-ascii?Q?cvBBRT9ZH4deZwG7IYpFa6UttLwI3pjs/jn/Aach9+W4wZOpyaBC6FQ9AdNr?=
 =?us-ascii?Q?oGNWPlCc5DYbLCtYcekOlkrL/lKdin7NdNEv8r6VpyGj3ErwvuscRQ2SXwoh?=
 =?us-ascii?Q?L380GiL85Gg1Pb7hqY6BFOz1k5iR7s0pxXSDtgif7pt/yF36Mi8Xph9Y4ep6?=
 =?us-ascii?Q?FH/gO/r3e1ktcP9CkjCd30i9wvt7zSMAF3P2S07iIvnWuZjTC+svw+adLlRl?=
 =?us-ascii?Q?O9bOjgA+yb8CfWqEk4WZHycXr7zbR/M4E3bNNJHhOTLj7XQhZryJj6nNG8QE?=
 =?us-ascii?Q?ykGv7uMxa0/moShDWFzhernAuDn4Wgls4qHLgYhq4cJT2N9j1j7N2lZnYn9H?=
 =?us-ascii?Q?fci4ftzvTzPu5uygIFjwVA9cxH/Yl94C8qMd4WQTDQmfHPviwOg3KlInofzg?=
 =?us-ascii?Q?psff4j8IHY8cXYLQyS7DkkG8W+zCwO95iUTvqUcVSLZFxcTOf5k4apU0XoTf?=
 =?us-ascii?Q?BkwcoqssSHvpaT4GzcZ78gS0gHB0rbUA6H0Sdh2dbaV16xeyZBVKluF9CArs?=
 =?us-ascii?Q?nAfiTf1qnpGd+UTmjM/mrrLsVO603wkeOWVJi/UiOvQa5M0mIeMoESfWSN/w?=
 =?us-ascii?Q?1Z997B8bspFTD6RDPVl79aH4g363Y/s4uLX2pSPwHumbfGQr5AAKTQGTQz7E?=
 =?us-ascii?Q?wlI1psHz+7QrRcy6WT+FybkyRTKB5wHB7TK/85INUpEE+sFIi3G8ha0rb+mu?=
 =?us-ascii?Q?SPVgFnOMjUHm6k8XUSdhq0IFaUGBDCvd3wBwyiPMut9JEjkcC71f2Urcve31?=
 =?us-ascii?Q?Exd98SsybMnVH3paJF+pVVg68tOb+C/8znVDZgK5BZpM5a6AapcKSoLUsiG3?=
 =?us-ascii?Q?zXBm2zoRveYl5ML9dF+xV353Dqtb55sGkvUvtVq2B0x39V+JOinmW1rH204U?=
 =?us-ascii?Q?TFeDx/oCPKCF7TgEUHzxc9mQ0ca/RVvn1XSKSaDZoRnCK7/6MQPV8z5M29kV?=
 =?us-ascii?Q?d44fxjngd0jAWBhtM+xIYC0MuGddhi8baFtlpBzCxMmi/JVJk/k63YmbRrSi?=
 =?us-ascii?Q?kbzcmVkHqiJuS9o9CUK1tJQ1TQZdhQtjAhl394o6mzgJWU735YIm4/LGTYAV?=
 =?us-ascii?Q?3QqUTLoN+pnazQlncdfxjZ08PZgis5FwPs+/+mj96YQA7D/VcU1rU5e5ReWC?=
 =?us-ascii?Q?1wgEEqaIX5NfiRb5+LMCB62CoBICbfi5cYLuJD0Vw8v0aaaFsJU0kf7PZs3W?=
 =?us-ascii?Q?dSkiXm0rYrwUH76bl1z4VH7cgb0v5N1OSPJCYtv+x9fHjZvyyOTp2NOf9nvM?=
 =?us-ascii?Q?ges8gvZSH3RMQxZeKXWlnRxC0ZPhEb1gHNha+GvP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ad3e4-9f79-4974-c107-08daf76480c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 01:53:45.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUrOMJSjz8Z/Tq6Nb8JXgg6/0xBDmc9Qwvs/MpTm5esu3slIxjGaguwuvdpUOUFydfHW/mI04I6fTVe2uvHyXXgjcbapJ2ifruRT5vx1rSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Bjorn Helgaas <helgaas@kernel.org>
>Sent: Friday, January 13, 2023 9:54 PM
>To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Cc: bhelgaas@google.com; linux-kernel@vger.kernel.org; Yang, Lixiao
><lixiao.yang@intel.com>; Peng, Chao P <chao.p.peng@intel.com>
>Subject: Re: RESEND: MMCONFIG related question
>
>On Fri, Jan 13, 2023 at 10:15:45AM +0000, Duan, Zhenzhong wrote:
>> Recently Lixiao reported sriov disappered for cards which supported
>> sriov. We found it's related to commit "07eab0901ed efi/x86: Remove
>> EfiMemoryMappedIO from E820 map" which removed
>EfiMemoryMappedIO
>> regions from E820 map which lead to pci_mmcfg_reject_broken() check
>> failed, raw_pci_ext_ops isn't set to pci_mmcfg finally, below is the
>> related log. I know maybe bios should add MMCONFIG region into ACPI
>> motherboard resources, just want to ask if we would support the case
>> when MMCONFIG is missed in ACPI motherboard resources as I see it's
>> treated as "Firmware Info" not "Firmware bug". Thanks
>
>The patches here:
>https://lore.kernel.org/linux-pci/20230110180243.1590045-1-
>helgaas@kernel.org/
>should resolve this problem.
Will try.

>
>> Also has another question, if MMCONFIG happened to be in
>> EfiMemoryMappedIO, even if it's removed from E820 map so that there is
>> no CRS clip for that region, could it be used for BAR space?
>
>MMCONFIG cannot be used for BAR space.  MMCONFIG should be reported
>via PNP0C02 _CRS.  BAR space, i.e., a PCI host bridge aperture, should be
>reported via PNP0A03 _CRS.
>
>> Will there be conflict for BAR and MMCONFIG access?
>
>I don't think so, but I don't completely understand the scenario you're as=
king
>about.
I mean the case when MMCONFIG space reported by ACPI table overlap with PCI=
 host bridge aperture reported by PNP0A03 _CRS. Just realized this case sho=
uld be firmware bug, sorry for confusing.

>
>The E820 clipping of PCI host bridge windows is only intended to work arou=
nd
>an issue where PNP0A03 _CRS reports space that is not part of the host bri=
dge
>windows.  E.g., there were a few platforms that seemed to report host brid=
ge
>register space via _CRS.
Understood, thanks Bjorn.

