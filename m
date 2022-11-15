Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0B62A116
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKOSIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiKOSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:08:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C861EEE8;
        Tue, 15 Nov 2022 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668535690; x=1700071690;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bc3a6K3hwgNszRhttBxYt8CTu3vqtJaXPLg+kaOzYmE=;
  b=A4NUK8w8Ot3GvDKyQbx8IA4BPUNTfBUFY8JuyhZ3nGIPPqBqu23EiS8M
   ba29HFXfM0Pk5unBSNQA+fDQV3vVx3Mgf6ICgE12dqbos6USAidHwvT1E
   eyDL06ZXkrMLc99L7TuExahIW5vW0aPgSbdr7q2imgb2slQicMCFnIvaw
   uZSSO89xPGhdY5O3Jhu77N9NmWFFA79QT9QF73Gv2yKYyh7GB64z589Xn
   ofaK37bFpz/2X5xWvaABGsFaAiHp9ihAQ/qlCpHIYE/MwiSo4MA+j+hld
   6IzTomokJuRTogb4qHVnuwzgZmdhT6SMhqq3Nk7oU/aAGucBThBrKIqCp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="376594335"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="376594335"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 10:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707832112"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="707832112"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2022 10:06:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:06:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 10:06:35 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 10:06:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY/FzrHu+sBqxlGsxFtkRPZcM/SwfGzJF3Xfqx0q/KiSKELky0f0yc4HhcBdGiHsxh3jRCFOf2pxvZZLYdYDeF52btXQYYCL7bzInuY82VlJXLekmWDdAU2gRhKObGPxywjXx+ohjKDtg0L+oTn92Z2XHH5W6J7EkEgCv5Lgt0OcpnOPKcDzsJMUvJyiu+WuAecReOMYtaThESC/6hUFLZ+3WZINX6056Md2QgJkAa7RkU+ZASp4aga0xI+5CNbdz9vO4CZ4b5C2XlQLIEv9My6Bbdxr7I74hNdiFyZfkbmCQn/AKlRALW94+gEQj8HTFiSulhAfgJj+2Y5FVhQwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNN0ZrlHRrF5FbsMuub0qLeQcC9Nt0Ziix3826uwTLg=;
 b=mca0yfKBInB2XT9r5wfRy00LUhsP0vCDmG+J6szb2KNYl4avtBVYyJAQQxthGLGVbpOgKPGFMRiAIDEv1XldyZhWUQ77xGQKaFlGhH9ApXW1gb0xEv5TNtVqVapzn1uO7h2Z+CWy4UQ8XbdlIdGqdK01vh4v9+8rxGiJ9jq7VosX4JiqzSYnBwVqVEx1veFbAe1Q51XgrjhHysU8Z9D0co61O0UCd5SOrZJt4FmbZzy9JbYUXZiiM0WkVU3cxrNV2Ozd9L73i8mLgj5FQ1RgC2xYJ0nDlsh1woXrJjHN5XRGhrDrLLukFy7fv0zpVIoZH3xvuR0NyAPuJl6fwjPd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7568.namprd11.prod.outlook.com
 (2603:10b6:806:34e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:06:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:06:32 +0000
Date:   Tue, 15 Nov 2022 10:06:28 -0800
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
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 3/9] cxl/mem: Adjust cxl_mem_find_port() to find an
 RCH's port
Message-ID: <6373d524a1a1b_12cdff294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-4-rrichter@amd.com>
 <6372d30ef4152_12cdff29452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3OQUAriOj2NxLfO@rric.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3OQUAriOj2NxLfO@rric.localdomain>
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4d6366-d583-410c-73b0-08dac7341ff1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHP3uFy8feQ/rZdy9Wn1zGlW3azfiu9Mm2Zgx7r41BaIHJnzamqXvxIEg2yID13xq7bWPPHBTIUNrGpn3FhHnKOqDRrre3v1xjvNgBFFnaZK29/hbxqYkugrhoDJGwZ2awMOYbrpMV8zJmiiSAdZwG8Ilxh6AwR4DYxKy0UmUzbABwGzfQ3Gzpym5aKDweenM2JmWrmsi4Cqa1yWiMzSz5XtEmqWsSvdDG4fcgrAJ/pTNQC0NxFsK4Mi6nXJES0B6fDNzzzJW778xObhdtFitBNX0QB9uXFaBmUE2/Eune9zJlyHQW3u6TGHgpyuV3+DArkJTVSlbdpq7dBngORK+LBa/OoLtuDcfgts4MHW3lmyFkSuq2woR5kYMrS2Y98ZAskPe9PDQE9krXI8Jy/j4FAokDZVkvv4i7Amntr/VDmH78BrUQJlAmzgVzwcoGStaxZR0b7ZRQAjP1CiVFOY7juSbQZvr+8OepbqDBqbWDq5XPZVA75Z2dDz+DmsHxOhVG84Q2Ob1MrOXgQVByF+K3cBFvr1NOcxvH2ISSGM+/nAdWpGEQPZvKua5k4ULzKQ5KGPBBRo/8lRc9DKoRvDdY1hOh77tPsIV1VPgr2XTQSbKFpeEc0uKzgtrEJedXWha8L4m3qX6Cl4G9HBm/hjMBPBKEMCL47XCSo6dyopKTSaerZE3zEenyEUl+YdD6rL/qLLW6l3O0LtjR1W6PgBQDsM0loEZSunZcQHL84GzeImw6QWySUTbWNKpOQHm3zHa9/X7VAfrUfY2ohuqRgKGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(2906002)(8676002)(66946007)(86362001)(110136005)(316002)(54906003)(82960400001)(478600001)(4326008)(6486002)(5660300002)(38100700002)(8936002)(53546011)(41300700001)(186003)(6512007)(26005)(9686003)(6506007)(6666004)(66556008)(66476007)(107886003)(37363002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1V2dnd1TmxoR3NjTURLVDdDSStoSEg2aVowR3gzUDNLMFEvL2pLb0tjZlha?=
 =?utf-8?B?NkNFbGFmcXVsUVZkeG96VitKcUk4YWZpdmttRE1FdElXeDQ2Q2VVeXoxSG4w?=
 =?utf-8?B?aGRjL0JhRzBQNFZyS053YmcwaG1PMkhKYnkxY2RzcUVyRm1abG1lQWlUWUgz?=
 =?utf-8?B?SGdpWHFMZzg1c1crZXJFYmF2OWpINWllTHAzYmMrL25PQXpqM2RqYzJBdG11?=
 =?utf-8?B?cG4xUEx1R2I2QlorNktwM0dNK2liZWpOL0g3K1VOdk5tMFRKNlNQV3Q4cW52?=
 =?utf-8?B?dDlJTThBbk9kbndMeC9GR0dxRWRKOUhzQ0ZBN1dKU20zcTRFSUlhUE1zU0xr?=
 =?utf-8?B?M3lJbHZkNFhQVzhRSis0NDYzTUZUd0JiSHlpK3k4WEhSdVNnd205bCtsL3d5?=
 =?utf-8?B?TFRvbmF1SXpCcWhlcmF3NHM2MVdSbjBnOWlhTnRpMEF0SFdhQStsNmdsd3E3?=
 =?utf-8?B?SEdpSzkzTjFxc24vSkgyV2VtSUJmWUxkQXE5OGRiMVFKb0hRWmwzcEdwemEy?=
 =?utf-8?B?WVVra2hMRHZUc25aWmdjTEp1UlF5azZTWHJaRCtxMHhQRzZNbVhKQTRFbzZa?=
 =?utf-8?B?MXRpMjRKakNreWtqcjFRK0ltSjVzZitySlVjRjFEb3hoNERHVnlsYjlrK1ho?=
 =?utf-8?B?d2J6cmY5TXU1RWhuMVVwcC9vN2ppLzFveWZZc2ZMaXkxQXl1R09IRkZ4cGtK?=
 =?utf-8?B?YjJKVjZpSWRRdmUxL29BMUhjcy9kOVJqSEl5RFlrdWh5eGhBUjJuWkFDdUhR?=
 =?utf-8?B?c1JXMjdsR2N4dFJyUEdHTjlpdEo3Tjd1SW5wTGorNFhxV2Q0QnVjdHFBRXpu?=
 =?utf-8?B?VG5abmMzZ2VjUklYWlJ6MFdicVIvL0svSDJrTFRQTUNrSUdpVmpkNGdQK1Rr?=
 =?utf-8?B?VDJpcW5pQWVweXhLMVN5V1E2QUFyRkRNd3pDR0M0UFhTNGxYZDFRc1BmYisr?=
 =?utf-8?B?VTdDTzBROWdhMnozMyt2dnh4Q1VKdjVaZytMUXVnWCtlOXFMUHBFUEYyTUIz?=
 =?utf-8?B?NGFrZmZBYXREL1RBV1h1d3JsdE1RWUtQWjIvc2VTTzJuNGR3QzhaNit0YW1M?=
 =?utf-8?B?OVJ2SUNjNlBRUE1KWmViRFFmVWdTdDRIVW91NG1rWEVvOTdveDcxaVdqaWdv?=
 =?utf-8?B?K1NraVJxZnRtak85emkrQUlaTElNWmhoMkhRbEYvNE1UTGFCQVptVlBXc3Rw?=
 =?utf-8?B?c1FPMlNOQ3FMREFoNDhQc2hOZHM5Z0loT1J3OUZuclkrZWwweXdhVUNSMDVR?=
 =?utf-8?B?RlM1UlhpaWxuY3drR3ZzT3hOcC9ud290Z0RLdWRYUWd3UEpZTWUxMEpKUWNT?=
 =?utf-8?B?enlIU2lScnJQZmhrVjM4T0RxUzRmM3BrWS9lMDFaeUpLSUZ6b2dpakZqSGN5?=
 =?utf-8?B?d3RXQW9jOUZDSWRaOGdZUi9jTUpKQit5QVBGb0lQWWlLZzhNSEpiWFc0aEZa?=
 =?utf-8?B?dm50clU2RWp5SitKYllUUDZoY1NDM3JaZjZvYWdIeGhFNDZVUWNvQVJRTS9I?=
 =?utf-8?B?Yy8zYWJZUHVxdHlrL3FoRDdpeWkzQTdjR1JXNHJLUWtEQnZ1dnlDcDF0a1VD?=
 =?utf-8?B?WjlCcDY2NEg2elg4QWx2NkNFT0R6cVIxa3AvYUJzYTFiYU5SSmEzaWwvRVZG?=
 =?utf-8?B?U2x0eUV1dVJKTklwQ2dlKzNOeCtBVEdTelN4MUIzcTZ3UHcvN0swR2llSXJK?=
 =?utf-8?B?Z1ZNcXdPeXZWS0MzY3lrVHhBOGwrRlVUN1FkU3hpWHoyM0t5eGsrNkJreVov?=
 =?utf-8?B?MElSdnhNRFZ4czAxeWhGVG5Sck1XTmxhL0YrSHQvYW13L2tmcFcwNzRqeC92?=
 =?utf-8?B?Ris1RnRwWno1Q3pSODREUUs3Vnk5dWZaUVFBS2tKNEZSVWlNRkhicmlNMEUr?=
 =?utf-8?B?ZXU5QU5ONFBDSWR6dGNycUpXOWhtZml3WFZQQnMyOXRHZ2gxdG1lVUh5ZFY3?=
 =?utf-8?B?cjVLZzlIZG1QdzBaU21DMkh4TkljNmd0WG1FQVF1YndaazBDbGNuS1lOMlF6?=
 =?utf-8?B?Vm5JcStLSkc1Wjh6eVVzNzBWeVVjQktoanF2TTJSdDZkeHgyOXZPQ2M1YjBV?=
 =?utf-8?B?SmM0Vkw3TlhScWlWaGY5czhWUUZWbTZBdHV5ZHF6aDhMSEpWSks2aVVtajdM?=
 =?utf-8?B?d1ExSFVyTWJ1ZGQ4MGRaU0xXWW42UHlRNW50dk9KMFVMNFJKQ1huN0YyREFN?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4d6366-d583-410c-73b0-08dac7341ff1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:06:31.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zs8fRjrFEDpYMCaDVSda/dx/bL6/6mq8SE+qthz6hNMebWnToq7DcZ1FOL8gZixxyqlDXiEKCqPJ08ScCUPe2wP/ouCBij658bdAojMMiSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 14.11.22 15:45:19, Dan Williams wrote:
> > Robert Richter wrote:
> > > The PCIe software view of an RCH and RCD is different to VH mode. An
> > > RCD is paired with an RCH and shows up as RCiEP with a parent already
> > > pointing to a PCI bridge (struct pci_host_bridge). In contrast, in VH
> > > mode an PCI Express Endpoint is a PCI type 0 device with a PCI type 1
> > > device as parent (struct pci_dev, most of the time a downstream switch
> > > port, but could also be a root port). The following hierarchy applies
> > > in VH mode:
> > > 
> > >  CXL memory device, cxl_memdev                               endpoint
> > >  └──PCIe Endpoint (type 0), pci_dev                           |
> > >     └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> > >        └──Upstream Port (type 1), pci_dev (Nth switch)        |
> > >           :                                                   :
> > >           └──Downstream Port (type 1), pci_dev (1st switch)  port1
> > >              └──Upstream Port (type 1), pci_dev (1st switch)  |
> > >                 └──Root Port (type 1), pci_dev                |
> > >                    └──PCI host bridge, pci_host_bridge       port0
> > >                       :                                       |
> > >                       :..ACPI0017, acpi_dev                  root
> > > 
> > >  (There can be zero or any other number of switches in between.)
> > > 
> > > An iterator through the grandparents takes us to the root port which
> > > is registered as dport to the bridge. The next port an endpoint is
> > > connected to can be determined by using the grandparent of the memory
> > > device as a dport_dev in cxl_mem_find_port().
> > > 
> > > The same does not work in RCD mode where only an RCiEP is connected to
> > > the host bridge:
> > > 
> > >  CXL memory device, cxl_memdev                               endpoint
> > >  └──PCIe Endpoint (type 0), pci_dev                           |
> > >     └──PCI host bridge, pci_host_bridge                      port0
> > >        :                                                      |
> > >        :..ACPI0017, acpi_dev                                 root
> > > 
> > > Here, an endpoint is directly connected to the host bridge without a
> > > type 1 PCI device (root or downstream port) in between. To link the
> > > endpoint to the correct port, the endpoint's PCI device (parent of the
> > > memory device) must be taken as dport_dev arg in cxl_mem_find_port().
> > > 
> > > Change cxl_mem_find_port() to find an RCH's port.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index 0431ed860d8e..d10c3580719b 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -1354,6 +1354,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> > >  	return rc;
> > >  }
> > >  
> > > +static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
> > > +{
> > > +	struct device *parent = cxlmd->dev.parent;
> > > +	if (!dev_is_pci(parent))
> > > +		return false;
> > > +	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
> > > +}
> > > +
> > >  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > >  {
> > >  	struct device *dev = &cxlmd->dev;
> > > @@ -1433,9 +1441,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
> > >  
> > > +/*
> > > + * CXL memory device and port hierarchy:
> > > + *
> > > + * VH mode:
> > > + *
> > > + * CXL memory device, cxl_memdev                               endpoint
> > > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > > + *    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> > > + *       └──Upstream Port (type 1), pci_dev (Nth switch)        |
> > > + *          :                                                   :
> > > + *          └──Downstream Port (type 1), pci_dev (1st switch)  port1
> > > + *             └──Upstream Port (type 1), pci_dev (1st switch)  |
> > > + *                └──Root Port (type 1), pci_dev                |
> > > + *                   └──PCI host bridge, pci_host_bridge       port0
> > > + *                      :                                       |
> > > + *                      :..ACPI0017, acpi_dev                  root
> > > + *
> > > + * (There can be zero or any other number of switches in between.)
> > > + *
> > > + * RCD mode:
> > > + *
> > > + * CXL memory device, cxl_memdev                               endpoint
> > > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > > + *    └──PCI host bridge, pci_host_bridge                      port0
> > > + *       :                                                      |
> > > + *       :..ACPI0017, acpi_dev                                 root
> > > + */
> > >  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
> > >  				   struct cxl_dport **dport)
> > >  {
> > > +	if (is_cxl_restricted(cxlmd))
> > > +		return find_cxl_port(cxlmd->dev.parent, dport);
> > > +
> > >  	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> > 
> > I do not see why this change is needed. For example:
> > 
> > # readlink -f /sys/bus/cxl/devices/mem0
> > /sys/devices/pci0000:38/0000:38:00.0/mem0
> > # cxl list -BT
> > [
> >   {
> >     "bus":"root0",
> >     "provider":"ACPI.CXL",
> >     "nr_dports":1,
> >     "dports":[
> >       {
> >         "dport":"pci0000:38",
> >         "id":49
> >       }
> >     ]
> >   }
> > ]
> > 
> > ...so, in this case, the grandparent of "mem0" is "pci0000:38", and
> > "pci0000:38" is a dport. Unmodified cxl_mem_find_port() will do the
> > right thing and find that this CXL RCIEP is directly connected to
> > "root0".
> 
> find_cxl_port() uses the dport_dev, not the uport_dev. A lookup of
> pci0000:38 gives the cxl root (ACPI.CXL).

...but that is what I would expect. I.e. that RCDs appear directly
connected to the cxl root with no intervening cxl_port instance, and RCH
host-bridges only serve the role of dport devices. This also matches the
diagram from 9.11.8 CXL Devices Attached to an RCH where a
downstream-port RCRB in the host bridge is directly connected to the
RCIEP endpoint.
