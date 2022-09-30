Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C185F1217
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiI3THh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiI3THe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:07:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661141D7BC9;
        Fri, 30 Sep 2022 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664564850; x=1696100850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BoSUJhCQzft5fI9d5SbRKdUfM6ezAoXtuzRb7WDpBoY=;
  b=EYMNWZeQXfT2Nm1EPtv1gnRaQyutd92POCxEUm6mbneYXpn1XKuWqMt8
   yk6pXOPuZPQ/+m/UDL/Hfbb0KF6EafqBYVqCP/hAsTNvSTkTrPTIWHftO
   dhW05GwX8hI2/D0KfnucxtL/uU6/jk1n1UxVGqTEP6KbW8g3VKzg2Wyo7
   98d0TcaKNt5GVDC3JGTtR1pOUdjckJ6VEenwS5s9cOOvf746CwYwJG/4D
   391KpbtFM4TCmpTIxg/UgU2veDV4dVQvh0XstKtIYDYmixGvIj5FfxWug
   xwt+mCc8ARZyOOHZSAhROmzwrNkUQ7DKBR0u/V4tMSk1RyLBbfl5NPJbM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="303180312"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303180312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="656056947"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="656056947"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 12:07:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 12:07:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 12:07:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 12:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUPWCoKjUTDB2BFNVOTooi80+oHMmcrfjxCmP57h959F7taD8FWJrY9OxYcUcF8Ulh88e70NwZuAZL7TrhWu3Z+nKz+qcAIh3ZqO9+cW5Pjg6830Da65GU3NJz7BsauC4oOtMuAjgA96KrXQaAe8yyxaKtjWpVtriJH+nlfCM/8XHg8Nm9+KBEUBvUbibwSiuqekCiIdA4T4jN4dgZ4XzNkyCWp6Z9/WuI7Bbz+kK8jiokouLPP3JFSfaPMoSEN5FF7RqeNdBl8QV30V/EvuohXKtEtn9M3aIRjDt+jVNhpds782oPlhu/HLptQim6geJVDuWxN2kif28xoB9GIwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDPCM6+8uJA/nT0yBeKW4NVdVfY+cYV4lV60cOzsPUA=;
 b=fmEELdH8JVhWyogdcEsOwOVRbx+1oAbzzXCgg0ucLBHpnfiF8ib+u5XX5CX7v+MDq/M2ZeVCh3JtPF7yXCZqz850nv5uutIWrHIzpUiMg5ngyXea3P2ZwhUXReC1Qxs9zt18A+k/OmZKu8pMmvPJPqEbgRkP1udzy3ZV8x/ObcyU1lHrju+61g2UC9m4++pk3DTWrwVQ886/8hvXy50mD4DREqffEPKDAIWoCUcsmkU+pY4ig4GLu+Vl8ZU0kLw7NFQYO9cd08m9tXqU2dvGV8OyTCBBPHRX6Y1tN5/IUx2ENLE/arv9ajQHbn7KbyYcdJ1PFonN+aOe+d5NJR3NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4712.namprd11.prod.outlook.com
 (2603:10b6:208:264::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:07:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5676.023; Fri, 30 Sep
 2022 19:07:23 +0000
Date:   Fri, 30 Sep 2022 12:07:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 02/15] cxl/core: Check physical address before mapping it
 in devm_cxl_iomap_block()
Message-ID: <63373e684c3fd_795a629480@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
 <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
 <YxsvPwzxoYBMnN2y@rric.localdomain>
 <6324ba91a05cb_2a6ded29457@dwillia2-xfh.jf.intel.com.notmuch>
 <YzQhz93rqX+1NAQH@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YzQhz93rqX+1NAQH@rric.localdomain>
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c8ffd1-dc7b-4176-ce9f-08daa317015e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eawv8BQWSsHWj5CgCU2Y/HO90l7buVfrh3fkiVefFBEm0LcpFXB271zqHxtJekyGArMFsFWPK4aYqCOhXUj6ooMjwbGkqz43XU007r4VIOx6xnlsLGaVYNcqc5mPIXyo50vWLW99Ag4UKdDlGU4Kv2WCHqGAPu5qpYFWyuJwWHYWRi/kmzeFCB9fvqx/UK1q3mVjlIhmecutDjW7Sj3HHPjXEKOjeFXtReg0tOfoYEjvIZMwhTZ39YxVGpZwT0Dy++aTY1CAOIbCyPfzd1flRJfXQtqgM6ln7NXAX77A6vYRx3/gL5IP3QaChv6X7/p2YZvs8mZSMd9OLg+8UxeJpG3zBr495+cnvZSZdrdb1gQhOb9a8Cn2qu/lj4Tt8Wn01bfd90Hso9+8gWyJC92QvFnWUblmCjSE1YOgC0lfRIVTLNmUHEfeuUUZW/7hCAE0EOtCdzcIqq6978vTHxdMdhYOgo/91eZD/A2IDUr9rmBcDH/IxiS9XRt5T/rIL/3lg3JTDgthCdZLmA9exaHASeyCHGP0TmkjHwlI3+Q/8MlpcxTFheK/n0K1RIkHwRcIfjCzP4v5Vvcrc1oRlY9ORvRpBWaDVl0vtEHbo6Y9CM2o4nhnnX6IQaG0GBaUFIHAQc1njLYjszcjufKyR1UMJcbaV7gXCCePsuP3/i9ZIPxNClYi2kEoHV/nBYRJk8uCFy6JTjbUBB9qe3h+2HTbkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(6486002)(478600001)(5660300002)(82960400001)(8676002)(9686003)(26005)(6512007)(2906002)(8936002)(86362001)(6506007)(4326008)(54906003)(110136005)(316002)(41300700001)(38100700002)(53546011)(66556008)(66476007)(66946007)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79SnO1cpkq31FCWsKzi6wyIb/nYGS98flIiYMrjv2Ih6bmvNBWUfvc+6GR/t?=
 =?us-ascii?Q?xDW+d8xNmwrkMMgnzTXlHG1j3E+epVGDlyC8WgIaQgLtkQFMKZcF5q1Vlpjd?=
 =?us-ascii?Q?DDYTnz8YoYEkFDvmfDx4fVz48kawbNe9DWDR3MCJZZfVanUY2HOpWQ96BRTb?=
 =?us-ascii?Q?BeaPcWrJWBHbDtBxXGSgbOpQ3q2AP2e5t+Gb+Po2JA1T4sjLKraTipB69UYz?=
 =?us-ascii?Q?K35vvWr2jjwUnrGLWvDDngd5jtKsVt66wPLCqsfBkZsWtJnxN2hryTRMTFpJ?=
 =?us-ascii?Q?Wcv8X/f2Xd6zUtb1jYpj1dIYjBM1mdebDCQ88CR+wEnLe/VLiGfCDM96ZB2J?=
 =?us-ascii?Q?7/JHlv2zZOcV6d1/la5rA+QvfNBc+6xRsYrSf+E/LI08dNcRDRpeN7uBzzD8?=
 =?us-ascii?Q?S3kC5lSGnNxvK92VcN4YwJZuaRJds3tFdHh+tJnpuvpz74XAMvE95bnf1740?=
 =?us-ascii?Q?eY6VGbdbKOmBwmWfVxrf68CkjCiR5CG760Sf2kM0lt8lt2th2mmF/6UJfAeq?=
 =?us-ascii?Q?Okzpcu3+y/EwZd8KbTmSTMy5LzcK7vFYQBIcbXWmSsc0cGqqfu+mXY/9wUvR?=
 =?us-ascii?Q?63a0X3OZes/LXcc6f83+s2HeSdMmjeqWI8Tbd1Cm+r/zVAkNDdKsOJMbJEXk?=
 =?us-ascii?Q?JMPHvDtLRgGP0BkAFHDvkwVk6TgR54scJNMtrTtTZVP6qrFJoUDV7RgKwHvj?=
 =?us-ascii?Q?BnfD8K1e9vl1aZkYTo0EckHd33RMo9vSu6YwakcBLj6+w/fezZbBxj0YJd9e?=
 =?us-ascii?Q?5M/YjtaPWulxe2m/snKlUr9ZskXPqmU4SA8quW9+eA251RF8ojRIE4l/uSCF?=
 =?us-ascii?Q?UfoE3BG0os2B2TN4obAH7QQkYYCKnlN979ls+Mjkm1Y9+LtFlToN1Cax6OD1?=
 =?us-ascii?Q?esVvnVF1LHIhdD/wTdgZe/q8b7UUkaHyd/4issmmXv1Up8iqtSaX/edIX0Sw?=
 =?us-ascii?Q?X96/IULxKX/eVPggtszNTaWxD93sy3efJd1R7SNA6Od3cRWGFw9OuqboLLO2?=
 =?us-ascii?Q?WfUJ4nGO1kSWNGyt+rzWnOq1M775Qo0ObimHTVozr5oPGRiPO7qklJ75wdn2?=
 =?us-ascii?Q?Zd0Cb+LjG9FRnmWgKldYSHlpTb/ef70p11Advq1BxVQ8DPXnATRI1mngDRM7?=
 =?us-ascii?Q?9dUH+srB5q9hiq5KODBVB9fYWM6YH+aS2Qup/2IY/vKbqdcCvWKn959Mga4v?=
 =?us-ascii?Q?CicFyT1d/qx1lWq7ghoL3WqVO+Xc2i04P0zCVwR4uae7u80a3ajAKWIqnZdy?=
 =?us-ascii?Q?kBimuMQaLTreHc7addD2w/t1MKVdZkODqZ5ziuXlJlFLRKY97lR1ydNnClnP?=
 =?us-ascii?Q?vT5tOrl1vOWkQsiOg2SZeU1N15as4skZ3D5NE/gahrQ2c39xGwODztYMoLPy?=
 =?us-ascii?Q?kCsF3DbU1ZfCX0S+B7TDe48j/06KcJbzsnmN2Tussj7iatxxjVhRBjy7nFD2?=
 =?us-ascii?Q?nYjWsBTSEdy+JU9pGmjCRRQ6CDlIpUFOlQSlP1dY8tOcDzspizuKARxIfHLC?=
 =?us-ascii?Q?wlgOR49a25B3wdOcxh4iLnzYXxvZ94OoGQMV4ltF6FcGUOlPE2Hytakx11t2?=
 =?us-ascii?Q?fEkUhyqR1fnLuWCLQyHFwRIW2ikXmaLAYivPxSzYIyAVPW1dx3JiOd9Qfxau?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c8ffd1-dc7b-4176-ce9f-08daa317015e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:07:23.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5/xhz7BnuBtoWWnbvTayjh/kJSu55ZmjXnqmDWoMSfEG4aflRtsCipypc+5CA0ABSe2oUC51l972/wGj+KYyOVbLGQEApwVUtiGwe65YJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 16.09.22 11:04:01, Dan Williams wrote:
> > Robert Richter wrote:
> > > On 07.09.22 22:48:57, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > > > The physical base address of a CXL range can be invalid and is then
> > > > > set to CXL_RESOURCE_NONE. Early check this case before mapping a
> > > > > memory block in devm_cxl_iomap_block().
> > > > > 
> > > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > > ---
> > > > >  drivers/cxl/core/regs.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > > index 39a129c57d40..f216c017a474 100644
> > > > > --- a/drivers/cxl/core/regs.c
> > > > > +++ b/drivers/cxl/core/regs.c
> > > > > @@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > > > >  	void __iomem *ret_val;
> > > > >  	struct resource *res;
> > > > >  
> > > > > +	if (addr == CXL_RESOURCE_NONE)
> > > > > +		return NULL;
> > > > > +
> > > > >  	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> > > > >  	if (!res) {
> > > > >  		resource_size_t end = addr + length - 1;
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > > > 
> > > > devm_request_mem_region() succeeds for you when this happens? More
> > > > details about the failure scenario please.
> > > 
> > > No, CXL_RESOURCE_NONE (all FFs) is used as address. A broken range is
> > > calculated that even overflows. I only vaguely remember the exact
> > > error message.
> > > 
> > > This may happen e.g. if the Component Register Block is missing in the
> > > DVSEC. cxl_find_regblock() may fail then and returns
> > > CXL_RESOURCE_NONE. There are a couple of code paths there
> > > component_reg_phys is set to CXL_RESOURCE_NONE without exiting
> > > immediately.
> > > 
> > > I saw it during code development, when I pre-inititalized a port with
> > > component_reg_phys set to CXL_RESOURCE_NONE. Since that case can
> > > generally happen, I think it must be checked.
> > 
> > I think Jonathan had it right when we posited that the code should
> > probably have failed before getting to this point. For example, the
> > scenarios where the driver looks for a component register block via the
> > register locator DVSEC are not valid for RCDs in the first instance.
> 
> I am ok having the code reviewed to prevent such situations. But the
> handling of component_reg_phys is by far not trivial as there are many
> locations it is initialized and others where it is used. Call chain is
> across multiple functions using various data sources for
> component_reg_phys, so it is hard to proof this may never happen.
> E.g. in add_port_attach_ep() I found this:
> 
> 	component_reg_phys = find_component_registers(uport_dev);
> 	port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>         	component_reg_phys, parent_dport);
> 
> find_component_registers() and subsequent functions (e.g.
> cxl_regmap_to_base()) may return CXL_RESOURCE_NONE. But it is written
> to port without any further check in cxl_port_alloc():
> 
> 	port->component_reg_phys = component_reg_phys;
> 
> It is then later directly used in devm_cxl_setup_hdm() to map io
> ranges with devm_cxl_iomap_block().
> 
> Just an example, I did not go through other code paths.
> 
> IMO, the check is cheap and prevents weird follow up errors and log
> messages. But I would be also ok, to just drop the patch. There are no
> dependencies to this change. What do you think?

Good points above...

Yeah, the expectation is that only "broken hardware" fails to provide
component registers, but the driver is currently deficient in that it
assumes everything is CXL 2.0.

Now you have me thinking it should go a bit further and do a WARN_ONCE()
when CXL_RESOURCE_NONE is passed, as those locations need better error
handling than just handling it like an ioremap() failure.
