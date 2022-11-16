Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE062C8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiKPTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKPTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:24:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF502E9C3;
        Wed, 16 Nov 2022 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668626697; x=1700162697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U993N2R/zByTPU9va3A5PGXBPk6BNrBUHkBEdfaXr34=;
  b=K/CRVgZbs1rivxoLd92ntl3aEcBEP8xHuedDMXwmSSBR0DjKxo3HQBiO
   Vr8OCZbw9vpfn93fta1Q90EGi+wHm34DsWZJQF46WTIB7RnW1CVXkivwx
   E5tIwKoLZkdcPdtVQpAmtZgOmWH2jqGj/yXRdJFXmIt+9W1S+rLlyLtdt
   DawdtxnLFzUI71ymXxiMB6U8flcSkhPU+Yed1Q3wq8Cjog7HM6qDxmuOu
   JSQWxGpyVV+pDBlUWtcxOaxZOm7vo5/EOq6Uk7OHaHj7Zo9p0iIjnY6Tb
   3w6/8BVgBMya6xEL8eT5MCPJDbqx8p07595qlj4Rp7jRB83zAXbk2OSXr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292345723"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292345723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 11:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617290946"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617290946"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 11:24:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:24:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 11:24:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 11:24:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmqA7TOdvt/L09/bheE+5ziHUfX1/sZIaslb7ydcuQel985jkPGI/SvNY50kZ5izzqM9PTt1SQFScup9bche7kVpQAvvfcFidesXyv8TSYlsaHHpT7SCeIJ/IseAgyi0VlV6hZfb6j8YXTwLbuEM6eTJhCOrii1sZAajCspKwoaTkAFgulOHINI1XGMUvtijLp8neEV7ucRSRtVRxg+e6pJyfhMWTNuPVwPck2xUS/uw8J9ncl+Jn/fEo5ost/0UrM7nmPgVRgVQMRk2hgrkqlrxQAPv2Fv/qrTX8OXFZY0IzheShuJ231HjBoMHUE2y0Ho0Gn6hAtIdQRtfpVxM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCWnIJeSa+HseAqrgGQ6HhYnL3U2o254hB9THOzik2g=;
 b=oC80lgbnr/ja113WqKs0RU5q281nJLp6dHPXgXBzdmq5BDS8UUlz2WkLVJGVVU2ucGoQllf44Q9Rtw7OjpYxnp1O6Fl4tZZAC6bj201tw5jszimhtz24nLbk2WA8Yo0PvKLq5OpNnlZE82QUikrqYUYhiMBpem6QTug3Too3QUFW922sGMcDhjR5csipwbJyTuFG7ibhkf8Kq1OxlwYbnWPfm65ohZjlVpHSdyP3juR4zt7H0P317OHu5+uxVUzEQuKG8G9hwr79NJIJi94+5xqm/315FCdE7HSgUEbqLYiMb3mT5wRRGEyMOdOIcRihvHHe6V1E/dJMOd7Ct3edgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7195.namprd11.prod.outlook.com
 (2603:10b6:930:93::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 19:24:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 19:24:52 +0000
Date:   Wed, 16 Nov 2022 11:24:48 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 5/9] cxl/pci: Only register RCDs with device 0,
 function 0 as CXL memory device
Message-ID: <63753900717c6_12cdff29439@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-6-rrichter@amd.com>
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c30a01-4b52-46f8-d419-08dac8083bd6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLUSCzBv31LVvaUFoxZX4xf/skC+UZ1PLCymBN6e9ttTcERH1bRB19B/gZnfE0BHt2P2f0jIz+kqGpegtrHpQFCLzjv7EUmEzG/JrdASZdvs0YgjIhmOFXZGgtaGQIJhaAzkWRl/nfCPo/8dM3U5lH8Y5oqWszl4hL3tdF5e3XI/aiodJD1/PQdA03YE1ehFBF4bEgPWRPWqrlz/X3Z4UyUVKca454l5ExQiqtU2G815tEzjdWnOvXUa726zUWoBwjQhpbKeTnt0rX1T/KUKtCnKAkfOFJo4i4sCC+f4cyKZBznOWBGa1iZ2uDGPt+tl2FLuTPTt52Ua3iC/V62XtyjH5UXhw63JpIf01aSTyvCVGNvhi2kkgXge89L01F+riWxm/8E8gQUjMJV/Y0qWqshR2hmk0xlMuNt4NuPXT5R4HKiufP4+g8KWD4MZym2Ln5olQb8mVPoJkkn65tEBvQ1IDeHUA+z6LysCHYQCnnmyJciOIE4RAy2bvFMEiAvbUNZC8lHcw3ZGzkXFxq+EBYS4CV0iN7FdaIOrbUOfTTfIFomQGPJloZ2yarjV1AokPET6hFQ91QEjLsF+r/+OMBYO4sblYMyf4lCi66r6B9oXyHS+gdRq9ZiptpPNIlD9PvIl18Ds3VVM0MKVL3vu0cAL8HsA10rIHEcig3n1UggacXdYrlaMqSlRmMnK8CBZ1PamILELbcf3xpsqM9i+bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(26005)(478600001)(6486002)(83380400001)(6666004)(6512007)(9686003)(2906002)(6506007)(5660300002)(54906003)(110136005)(66476007)(66946007)(316002)(41300700001)(8676002)(66556008)(8936002)(4326008)(86362001)(82960400001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjBhuIjhZ77hOCEenVx7nfCgXkJVITR0yxRRTKM5qyEHPpab0mch3iV+VshA?=
 =?us-ascii?Q?uNkuns+e34g9Mb2w2ShlTESq+HrqBKLZO3tgLSxdNyX8LCz5zdDM259/8kZr?=
 =?us-ascii?Q?5531x66qg1J1SM1+KMZsGfe1CwxpynC9znGiFv3NTEWI+IGLYsxmMMn/WIqo?=
 =?us-ascii?Q?SH6M6od554bVdxRrEAPNsjg/nJ/Kavp4wR7R1n1TSTIjbFDjbeDSc2MwcPYf?=
 =?us-ascii?Q?BXVR8g17kMEbQKObQlZ1mbso46KhZdLK7qiRKoNjjhX8SpzibnGY3ykiyvnD?=
 =?us-ascii?Q?bbBDT9UVu0IIVskSPUKf474b3ZFMFKSOy7vjPwir6yt1qY50wSyXUElEifAe?=
 =?us-ascii?Q?U3mOudCbqI6j5+fqxIKpHuj/M/k64VODzTQqPiHNOTZiiDoJafSAQMDJgTBd?=
 =?us-ascii?Q?o1yqMZ5qvws8q5pnwRd+4/n3+iDmfvsWBxxtn9ES8GSO7/+Z+O7I9iLz5kh4?=
 =?us-ascii?Q?G0PneMeUlK7ySet6d21if2o+EVJZ1m/nP+BQRNfMug1wsHEbUQYYoS34tUY/?=
 =?us-ascii?Q?WuyMGwAU5fCWNrluQC3vKkFkCAPGKoal1bboDYFjVX5iEqXDZsbCH+cD30eY?=
 =?us-ascii?Q?Kxj13xk9gv2OnzIS4gKfoIIJeZA6WJ3H2xa0B0j8W6wT+hHzlyOsDKKn7rF3?=
 =?us-ascii?Q?GatP3Y2vG2MsXJS8WO2TavwDBqhfQREe72a029gdtK+l0x4eYdYOcP0DMS/w?=
 =?us-ascii?Q?GsgxA60UhZIqB7Ybp6U4domuHYYvLihYzIvnSY+9hqGAx2FJ3aI5MZNsow1X?=
 =?us-ascii?Q?jWRbTpKuURPhaQ/NP14RFf+9koznUXwp+WwoZXgnjxE+9GlIKugmbmcr1xzm?=
 =?us-ascii?Q?oIrwopA+vzExlHWQ7xiO/8SjTwGNYri+4zOWjteHJ/JSjt83JGvkfoEhsUF/?=
 =?us-ascii?Q?DB/4XzUC9smbPQnXrIbVsvjtUGSINj+13v/SuRIq95vnwyEdimh4ZAzbXmhA?=
 =?us-ascii?Q?O8IxmfKeOmgUm5xKeLLpWO/Hf3APCk/l1dzlYHZIYCCD0GIFWsdHz8GsyDQR?=
 =?us-ascii?Q?Kamv1htZHQ22Mh7NBJOnnM5d5R3nmfDpm4dI+0VP8pneawuY45P61nGcMRCH?=
 =?us-ascii?Q?C/IZBCQv8hDOn71YztsD043wHiTXNDJnbKxSqxrmvLUbkmYSxeVTZTFyL6q/?=
 =?us-ascii?Q?3oe7qY31ovsjAg1+VMA+JGQt224wAI6yUvtYo2UI7m1CpxX0VY5qKyOwFclB?=
 =?us-ascii?Q?90B17TuwuAajh5Gy+j8XmfJg9JG9oKIEdm8MjE85NOoeCb+Hrf86jboXCNXz?=
 =?us-ascii?Q?zgQWZIaWi7yqAPTPJVjVRKwfsHmvERsAB9M71LoZvIP0OaPtWFkuH6LE5hfP?=
 =?us-ascii?Q?h/N61SFTVtmSgZCzJX5KGadSfFVn5WtTvY3ZhaMR/JVcfiiWHTZKD9GNHoTa?=
 =?us-ascii?Q?meYiJIW1IcrvRNcBdlue9IsFEl3RTvEZ9h8zIBADFVcfvVrfTFizazOlD+6i?=
 =?us-ascii?Q?EmqWQeOi1/sxcNdvdw4T8sQfvQffDhpxns6VCFoKbwKHqV0B1pingYQ5kfLb?=
 =?us-ascii?Q?cH91M3gLK6PiMebU9P5En+WATobSD3SiUOGTD+qLJrJ9gkzOjra4ESBKUyXi?=
 =?us-ascii?Q?XnFX04R2sisV9sQOKIoL11n5gPhO7aAphYDZwXxrvMgPqssC3hCNd3pqbWx2?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c30a01-4b52-46f8-d419-08dac8083bd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:24:52.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl9TlIWhUHLjTvSB0nNgGCc9VrZ4XqCf2hanHhM/bfFEvvDPMQmACwEkydMLRDsW7JqT83qTsIyQQrjdtnnQUYf9ruDeJ0ozjCMF8qgjODw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The Device 0, Function 0 DVSEC controls the CXL functionality of the
> entire device. Add a check to prevent registration of any other PCI
> device on the bus as a CXL memory device.

Can you reference the specification wording that indicates that the OS
needs to actively avoid these situations, or otherwise point to the real
world scenario where this filtering is needed?

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/pci.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..cc4f206f24b3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,11 +428,26 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +static int check_restricted_device(struct pci_dev *pdev, u16 pcie_dvsec)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +		return 0;		/* no RCD */
> +
> +	if (pdev->devfn == PCI_DEVFN(0, 0) && pcie_dvsec)
> +		return 0;		/* ok */
> +
> +	dev_warn(&pdev->dev, "Skipping RCD: devfn=0x%02x dvsec=%u\n",

s/0x%02x/%#02x/

> +		pdev->devfn, pcie_dvsec);

This looks like a dev_dbg() to me. Otherwise a warning will always fire
on a benign condition.

> +
> +	return -ENODEV;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> +	u16 pcie_dvsec;
>  	int rc;
>  
>  	/*
> @@ -442,6 +457,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
>  		     offsetof(struct cxl_regs, device_regs.memdev));
>  
> +	pcie_dvsec = pci_find_dvsec_capability(
> +		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +
> +	rc = check_restricted_device(pdev, pcie_dvsec);
> +	if (rc)
> +		return rc;
> +
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;
> @@ -451,8 +473,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return PTR_ERR(cxlds);
>  
>  	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +	cxlds->cxl_dvsec = pcie_dvsec;
>  	if (!cxlds->cxl_dvsec)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
> -- 
> 2.30.2
> 


