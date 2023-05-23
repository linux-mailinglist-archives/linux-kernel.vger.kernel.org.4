Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48270E4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbjEWSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbjEWSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:43:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15791;
        Tue, 23 May 2023 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684867399; x=1716403399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q0OHr2ZKLKOgi6vbdEYHhqTpWPpk4OJD1wCL5bKueW0=;
  b=O+xtefREc5LkNYGnSb44/MTeIRTrjwMQYB19W69bhyp7rTDRrWemaF0o
   SYgSNvp/NHooFJMTjNZ+vligj85AFqo2K/RGxBdpToEc2LL+GtSo1mDlk
   /SEdpLjerquk+owindSwcS2RTgG/1g8T1WR72w3Tq0lIVEv1wRvhZs4/f
   ND+IkSBFvRlbQVyS4aoN5OR50zJ95iwtTcJN3t8LrrdzbNqDD66O9sgln
   JvZrPGO+dDF4QE7ElXvuIxuTn1cahTNvXO9O+QeW81f67XE2cc2zR2LYC
   k1LDqSA8liTftThZ2D1r3msGGmZI12ABosQgqKebf37F5pmdMz+XbyJrV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="353353360"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="353353360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707139940"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="707139940"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2023 11:43:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 11:43:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 11:43:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 11:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4+AkpVccsfODlpv1g++YSFi9UnaJsHb9C5qwmCxLQ01wlZjYplKq84oQPtiEmqz/IR/rp9rvLCGMZiC31zvr1IOmJ/79gbQMb7y9znvOvCIuk2AjFQwpihnShVyKa0Uu7VJdxwYhVdiqYQtUFuzDbRzeuI21Ejfz/ksK2dHGDjcFWlUxNIaFD2MslbPWaVQLU+5WpJeCS3nY2qpDmJwKyESMmPRuBEUcIysstMMwP20hmUzTc3N/godnLN3Oj/cXhw+kpxKPYJTJvI3wSBXgRKuhDmkxoz4DHtVjrjxn3zkSqvDaM4a9TOgqlgGIo/TostgwIXQQXP4wgTnAzx7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmOmutOf37haJD/LZKnO3irmHgBNCkIc+8xbVDnVoCY=;
 b=OjBosvYcSovkMFuRuCBeIELF0a3qih7yPv+SjalA4sgaFR+Z37XyRi+VtKPJoDbmrm1CFBaCl+ETn2fU6YFZ7+VvFz4PU/wkKkkztnYCG2hHG07MxV/UscM4OVbm2c+hBgVgtqXFAuUSx9Go33c6zQUPG7ZB1E954OVdFOBcJlOUXDLaxid6czAGw30lRiy2iCwX7YhXuEQWdfmBL4cQvwh2QYxPBvBQ/VMsp6lodfUNRY6uyM8zBrIkQF3fJxfopzMmJ1T/toNpDGGkBTqUDzQRYuol0BAv3QDQIfFPbOte6F5KX2o0tVAKWQfercD0hT+VQI+XxQhvT2KjSqsXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Tue, 23 May
 2023 18:43:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 18:43:16 +0000
Date:   Tue, 23 May 2023 11:43:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] cxl/pci: Introduce cxl_request_irq()
Message-ID: <646d0941a2a48_afb77294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230523170927.20685-1-dave@stgolabs.net>
 <20230523170927.20685-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230523170927.20685-4-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0135e-58a8-4467-cfb0-08db5bbd91f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ap1VrLkRkiyOZKvxYgnKTxgRdi1TXZrKWtJ/b5eR4zG5Zj4GobViSLDyrDnSTl/Z13BSvtnsshIf0z4k1h1uC9vNsmunSC5zPVzYZbPPMyXjQryQCHHye7G+N6h5+kM8OGvWuCv+M7J/IthA8k1DLHRCyw0Md5aGLifoHJq9gujsuX/UsKCcnCca3jwu/R5YCHD+WDiupdPbuk7fKDokIa2ly+6cwxbGLB4VcNtkKWId04fvHJwQlnQ2ZOeEhz0pwb1UEGAEUBt2tPdiodFGfZEm9zI4DWIY2QtBd5W+B6esCpGcZhzR7Obalx5pTMlAfvEDCHkT2t/2iiQA0BVb6ZsvWXH+vETSB4SgIfMTkOf+29qY1upQ68CzoOXgZHccvz4HkrSumAjVnlLeUdL+sz99SpEa3TWjCiikkM0i9UT/NUXt239K7cdvcfNEpSKFTinjxkhSQHgV4mQ/hvz7Ih/3DSs5cahg+dfvjoRi/nfczuWYcxYMaxOd3rtQMKKFuZi2Z4qMgmC4s3KoBIMwtZdzJc0Xv8Qkh0c4Pxbgy8p78vKfLwmgHZam9gnMLPQh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(2906002)(8676002)(316002)(478600001)(8936002)(41300700001)(4326008)(6486002)(6666004)(5660300002)(66946007)(66556008)(66476007)(6512007)(26005)(9686003)(6506007)(82960400001)(186003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aS4xBno2VzoYio3dP+n4P0M3JkTtJ+nDHX8tjpujrG8Y8NVuy7xTlZDtNNxK?=
 =?us-ascii?Q?gGLHMctS/YWrDTw+70gV3zHJpXnHMuDBKoe7jsiBpBRMZwkQcSfPDnUihX//?=
 =?us-ascii?Q?Zng9uMScNG2bqfDxj/4uEZ3P7JI+Ocqi8GamamLo9DKfPeRE5I81/eSOLsF5?=
 =?us-ascii?Q?MOSK7FkCzHrLt11VLTPWMdnQSmJfE/JF8+5QGpulc/8pYMu/AtCjfL/hWcOi?=
 =?us-ascii?Q?3o+sAhnwRzn+cRe5KkyiPBN8Ot/drkSi/oVruoJGhN74krD8vPZz0RIpqvQJ?=
 =?us-ascii?Q?yRVNrxsFncZf0U5MTLImpLhv3LWY7SSF6CbAqRicmL+xyP5laO+0X4TpmdgB?=
 =?us-ascii?Q?ZCVCWYllIT96Y4vORPxn1wUipOotXPgW99o735Ap+3LNrA1jNd/t3vVDjBVW?=
 =?us-ascii?Q?oNYsNV81uj9NH8NAXmQDBic6KzSrzR6rHWnFLOy0Xb6Nt3OrYyfkRtNmOxCP?=
 =?us-ascii?Q?Pe7bMNpaVShbpwnaMvui5SBrlgoCl/Y3JRPVY6ZZmZ9z4RYT8qKYB74TEXWd?=
 =?us-ascii?Q?wohJQcZ01F0DQbNXV3xLrWMcLuG9jfqQDWecMRZYUhKwgfMkTsfCQXc9jTSS?=
 =?us-ascii?Q?vBwDr5ruwiJaezr9xwVzp+O6A1djY76F7FdSRnOBk9w9oXu6ak38fLfJpn3o?=
 =?us-ascii?Q?K8bksXKV5Pqnq1JBvA7p9JXztSTGAzKl5jK59ci5zerQa5J+mFiy58topWex?=
 =?us-ascii?Q?cDjvTjW4oL4c5Qmx13Jq7sGpcJMZOug2CV6f1ec83iuBic6QcE+HK+BncyEh?=
 =?us-ascii?Q?InYUOP+y5CcgrWioyAsbPGnAruCIv5JYR3AKAPW1gu7o93jo3FiDUne85/m0?=
 =?us-ascii?Q?vYZ5m2JBwqGSsn3gYJRc4we07FntI4Ckz4LZSJpj/KMRP6fHFOgR185cYyG2?=
 =?us-ascii?Q?OdLpdAv0D2yswcrgi3zbDfsc7fLiSUzSzCQljbLNxDc7pJPeupSr/OB6jL6c?=
 =?us-ascii?Q?IMk+f10K02L/dSPdoGwixTps55N5L9jU/HvsqHqlYGnQQspmWyoEopHSiL6z?=
 =?us-ascii?Q?0emIJ2UGCFQntT9zjb845kcPvS/7snHnnHFVDaX2NMtNf6MB+xbcnCnpoDuV?=
 =?us-ascii?Q?nuGqP5URWeR4zcIJ+3c6caF1pxJUKI8gd28E6F29Y2rFEQQDQiiKh5Zi9twP?=
 =?us-ascii?Q?AiDGnXVjkcoKlYUKkN26nfwIZG0pObILmMKXQiwgBmQaklYWA1Xgrx2j3Wf7?=
 =?us-ascii?Q?ReCrzn90WnpFHytZBUhp5BJhsP+hG0GFbcJ60h+Sop6q/pu2DPA98RngP2Qg?=
 =?us-ascii?Q?d5zvf582lcZSxToAb89a/ABtEV4u2+Utj8uPtWN7tYYU3NxPsRRe/PdfgO7V?=
 =?us-ascii?Q?oTLLyAAMuGV1bSEGmlbhCShAJhcuR3axt/xEoXQAaxqycvs4OqgCLg+ewvpY?=
 =?us-ascii?Q?Hhwk4HzBsDHS7aRV6TqfxAvkqintaZh4lOLvH30JtuwWVYQdEyBBqeibPSOD?=
 =?us-ascii?Q?7QKRIgfHJajYUPrYXBbQp+Ps5gXOHE4tT20n0moPnq5fxBSAcb0Nio1R0v55?=
 =?us-ascii?Q?P1KKONXcBx9bP/TMR3D3w0KdeVtOx/P39KUFvLiNCIuuUN5JO/DY8zj12IZv?=
 =?us-ascii?Q?18sAebuCoxEMs2PdIo+KvTaEzXdYU9fUa51GV+ZRKPHGCsnHOevMioXOdPVs?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0135e-58a8-4467-cfb0-08db5bbd91f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:43:16.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXWfZ2wG3ra0LLUUzUAGkZEeTEkQhNStLVSon2QGJLldhexgDSQwbYdaw9Ht2q2ibrJdRZlq8R6d6WmtuuzzMFCB/Gqu00blUBr8ex6DY60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> Factor out common functionality/semantics for cxl shared interrupts
> into a new helper on top of devm_request_irq().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f2039fe0805d..18b8f3ce680c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -84,6 +84,27 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>  			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>  
> +struct cxl_dev_id {
> +	struct cxl_dev_state *cxlds;
> +};
> +
> +static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
> +			   irq_handler_t handler, irq_handler_t thread_fn)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct cxl_dev_id *dev_id;
> +
> +	/* dev_id must be globally unique and must contain the cxlds */
> +	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> +	if (!dev_id)
> +		return -ENOMEM;
> +	dev_id->cxlds = cxlds;
> +
> +	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
> +					 IRQF_SHARED | IRQF_ONESHOT,
> +					 NULL, dev_id);

I was going to say drop the IRQF_ONESHOT in the case where @thread_fn is
NULL, but I could not convince myself that was safe. I assume that
pci_request_irq() gets away with that because most drivers are not
mixing combinations of @handler and @thread_fn being set to NULL.

So, with that, this looks good to me.
