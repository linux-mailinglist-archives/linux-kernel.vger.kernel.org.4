Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1267EED6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjA0Tyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjA0TyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:54:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BEF916C9;
        Fri, 27 Jan 2023 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674849095; x=1706385095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IgIx7BkasJjmMWbmHc/8YDdj7nsE0Jgp6ExW2ONbUiQ=;
  b=en17gfjONDzd2SmGYLaX5gnoowZmFvSFwIrq0rLRh4QhzCZ/2Btq1qvb
   EStezYThfaJVI/frTbhWPDaW3FXY4qycZjHIGMycOTV5Vw9qF/s1fjxcf
   CugBLCgLdMLDw9HrXMojVkcElOH2GVeZ2MtyBWAPchcxPtrgBDY5GJp2c
   CfzKLkGEPSeB4WszQznRIZnqRDzrxGLelUz8JvZ6mL/Ql94CUWvSwuYuS
   rshCSTn2TyTr3LfedNpPkC3+7BnLJb+toUi8bON5HMxcd6RHzJMYRWXB2
   fuOsGr5niZNv8WQuIz68995hIfGXFQnElRtj/H9hfdJFtDjVTFdt83Weo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391728671"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391728671"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="640811373"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="640811373"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2023 11:49:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:49:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 11:49:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 11:49:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJgnDwZ8vBk6K+Pn8iLl/aUdGuQ5oiErrl9io6kUs1VoiRVUpu6mKrXoPbX42Q19UCKQThnZn/fkhgwMldz315Vp9ktJdWOqRuB9bu0/DTK6axxk+oGyqhGzlTpZ3kZ9Df+ZvSkGoEV5YgqQm3mDTvZZQ4xeZ8vlcwrDtYoygzEbAm+wak5oYvdnyf/vZi3TthgI2KElFVyWdzKW17Np6BXFFzlbj+BFqP4wZwQ68rkm4aQsyOyf+nzz8qURRG02te0+Zw4qKxRXGE5P7tuL8jj1BKKtprMRtD572O73FuuVw7bHddSS/vh/5d6CWRKj/e/3UwRQnvPqPuprydtDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnfqGCuxd2zzbD3t6pCnqQlv2S76UFZXMM70iHD8CUw=;
 b=jTEnheXHkjOFMYqU+Mg323wHC/Il8lF8ewfW99+bxCb0TyvlmeVxlsHPZiRG6iKtYhfNsaM1fcqrSnqqsFCl68HTA7OEr/Eig5kGIE2yKw39zrCw6/klKxM03qUAa6K1IiJvdESrcyZssnK3W1MS7n1PMZ4dmK7NkE08iqC/CYEu8t5f+BNoFDI85mGwn5cZshm6ylPUZ2y+k16HD1p5H+5bzmuQD2QP/g8KNx1qk87d3DUtmcRqAvvz+lPgPx38sgNPcxPcqBgmBhw1gH8IeuhYxPQCHw1X/QrcasuudY3Z377wwwXfOfmOl25kNE6LbVr2SflO0ZvtT61JwPa6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 19:49:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 19:49:01 +0000
Date:   Fri, 27 Jan 2023 11:48:59 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <63d42aaaef012_3a36e52942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230119094934.86067-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119094934.86067-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b2c8f0-f3e0-4703-b377-08db009f8992
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87tVCN7sDCan6XedfvaHgZDn4sdvEjRMpi/meIHVtm14ja+LCP9tPKeq1P59E4cRsaDKfF+jmeVYgjPfpjlOtoOHVZVM7IQ7+F1v4l1kubCeuuGjCm+NEfTCPFuEHp7uuwGtbEMRO/mqRNYvD7hw3C3WGBZG3M0ogTJjfNL+zcpt08ps256dwLJd/xqdukAry+t1XbU14aY/nx+4Fha6ULT5Ab+kOA4GBtbRL36nXLjIRTdC7rLqhljEkxNbJuyIhKZSk8Sxqg71ih+8QRI6Gjh29t+q+80pK9xHRb3ttn53OfJrezFPD+1Q3v+d8DC2Voji4RcphkjM7o5WhLDC1C+feDKSKhLnvvM4LcKfVUcXC5KKzxYDwA/QshHgj8LYJLXtEBCr/KiEymLC9qzJ/qbdZH8ztZCACZQgNZTIyk2LSuzAUNQr5iDUHt4LlMdNzz05sw22kXZPJXhSrBmPxAgw4KICIAmSGM0CsZV5IrZ2I3RwMaQoxTVAzbQoGvxX5hwdze40u+timR/68qizMozH2adxOCyDYSow4fQwqlTypztIMtMivJ2MvRLbRgDrQ6LQwVpDBDI2cIh3jVk8pVKYvKrfTWoCBT/CIWffP+/xrmhx76Le7NhWHS6UA49KlcMHms6b2B10LhDisfd8tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(6486002)(186003)(9686003)(26005)(478600001)(6512007)(83380400001)(316002)(54906003)(41300700001)(8676002)(38100700002)(6636002)(82960400001)(6506007)(110136005)(8936002)(4326008)(86362001)(5660300002)(66946007)(66556008)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+vHVixCmMHwQHCyHmyNTYudYRi5471M7clsIqdpf3eh0+NWc5Gpab7kEHsj?=
 =?us-ascii?Q?l21WW21yLY9NgGszQnDyyF22nd6Qz40xTmvFtwnm8lqqo5PH+yMqsNIgrY/p?=
 =?us-ascii?Q?zDEiVxJ8cAmkYgYTDvYCTvXUlDiYkmWA7dWOL/da5lZkWb9JcZf120pevvc0?=
 =?us-ascii?Q?z74xkNiuzcIJM4HkGAhTq3O/Ud5NCKji0SGpHNetM14zChFSORAJOJxFVkLn?=
 =?us-ascii?Q?ggEy8knv9no/Rjtzk1kR2VQWs73NwiaKnCxL2weJ0a7VlG9OjnD0fZ+LKj9w?=
 =?us-ascii?Q?gRXCOKtK7+UV/hLGth3eKqmEzlyby9zTOQEmz22pkqTrl4CUIZ64znIuRVZA?=
 =?us-ascii?Q?CyAHCeFBaaQMgViJuRYsVwZDxo+NcKKSQ9fRFOHXzLcICXQNPnPUstW6Bp9J?=
 =?us-ascii?Q?uR6KoYS/pGTrMFw19oD65TMr3DWzvaqCEgdH2ltBrcXSJM0g84+JD1bPcm7b?=
 =?us-ascii?Q?crGMUWBuYF8VvlTekI/C5gH1ZeFdZZDX0qVPKu/nijvBz+pOzOHuj2OGyLtt?=
 =?us-ascii?Q?Lj+GTWw9l0oNdwxsYgLy3bkUKY+iOo2fsTQ2tn6GMtYvvkl6QGEhw3VxXKH0?=
 =?us-ascii?Q?0MOW9dUp5y8q+Vo/7/YBpYD75fdNR2lGj4lAj0mEwjZJXiWQUFUAiKqxM1UM?=
 =?us-ascii?Q?VzHLyJ/iZqLw5fpGtDe2yGYQikNMrHdBweKfzz9MTiVY5nGrv96rmRFrAvN+?=
 =?us-ascii?Q?4gcBobcxrw1HbF7mrw4AfSITaJkR60VFiAqyOuTinKUxDorblpYYYTVTZLB0?=
 =?us-ascii?Q?ZVvmBIZYNnZtqmc1cJt0mBX/uLO2UYClori4Zn2pPVhM/kBD0dfBYoR/SZBw?=
 =?us-ascii?Q?Nz7MckX8mPZ0tUnhggO9WKMfnHdUzJDyvjzzOtbHPNlki5vthwsZxGBqnojy?=
 =?us-ascii?Q?EcobmtifwTLUQxUSNjsZBzKrEnnnfiS17k3dLmzggt3t5zxw7eTisbKSSKGq?=
 =?us-ascii?Q?1hQV+2Jfx15zb9lQPLaPQ1jNZghk89lnURmxCfjpDJyEdFafsXv39HWa1k14?=
 =?us-ascii?Q?CUXlQq3ndSGZypQFBcAz7MaXTPpB4wIbFUosZqzGISXxfKwqVz7hCH+8SyKE?=
 =?us-ascii?Q?1TL9wJzUZnxsyLMIt6rkbeynJ+DEOfnev4I6RwvmMP0YSBHc4GK/FVseBrIa?=
 =?us-ascii?Q?886815oWUs8ewV21ROzfvRv64sVTipAlQMjw06kLNPcS2A0B+CpJLILsOlEe?=
 =?us-ascii?Q?lSVlrCel12anZaMEdDIop2WS9Adt8/1zPIqeUXqkhq6k7TBYL0MYeyglB/Uq?=
 =?us-ascii?Q?zbzWOl0ZhsvqXHGRpbM+v47hBapyIjKKlvbNaRq6aO31ektFgUI4FwBAoAhr?=
 =?us-ascii?Q?GrA5rn2DUni3JcDmXbf8ls2ACy39IfdJmxTaxm3mxOfzaRtUHs4jvWg7c9XJ?=
 =?us-ascii?Q?hKll0wnIVoQyWvvHwY1wgXSK6gn89AF5sDixXta5BFaDM6PHg76iDlqEcqpW?=
 =?us-ascii?Q?5gFAy5PFWYSNpGwp6Wfs5l7VGHiX9Q9ZIQtz/F3eqWkQ+89ka58+T4FX8xG6?=
 =?us-ascii?Q?oDkW3glBuVxdP4Q1l+BUfUMgyD5uyEODBQj2xABk7hnNzL1QG0PiecNxwzXm?=
 =?us-ascii?Q?lNqZHC5I1cdSA5OfmD4QGjcTqAm+uQwdAhPWXfR7DUaIPDdgi3CzG3fwV5iC?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b2c8f0-f3e0-4703-b377-08db009f8992
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 19:49:01.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cvN643lfzMPSOpYTYkMqH4FwYRy+wD3tnNx/hs5GQFoYHTe98fVIVoW3ICT8K2UWpFVXYe6bCrS4U30yanwfnneSgkxvoaUYkkih3196TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
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
> Commit 2aeaf663b85e introduced strict checking for variable length
> payload size validation. The payload length of received data must
> match the size of the requested data by the caller except for the case
> where the min_out value is set.
> 
> The Get Log command does not have a header with a length field set.
> The Log size is determined by the Get Supported Logs command (CXL 3.0,
> 8.2.9.5.1). However, the actual size can be smaller and the number of
> valid bytes in the payload output must be determined reading the
> Payload Length field (CXL 3.0, Table 8-36, Note 2).
> 
> Two issues arise: The command can successfully complete with a payload
> length of zero. And, the valid payload length must then also be
> consumed by the caller.
> 
> Change cxl_xfer_log() to pass the number of payload bytes back to the
> caller to determine the number of log entries. Implement the payload
> handling as a special case where mbox_cmd->size_out is consulted when
> cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> that -EIO is only returned in case of an unexpected output size.
> 
> Logs can be bigger than the maximum payload length and multiple Get
> Log commands can be issued. If the received payload size is smaller
> than the maximum payload size we can assume all valid bytes have been
> fetched. Stop sending further Get Log commands then.
> 
> On that occasion, change debug messages to also report the opcodes of
> supported commands.
> 
> The variable payload commands GET_LSA and SET_LSA are not affected by
> this strict check: SET_LSA cannot be broken because SET_LSA does not
> return an output payload, and GET_LSA never expects short reads.
> 
> Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v4:
>  * Fixed a build issue.
> v3:
>  * Added comment to the WARN_ONCE(). (Jonathan)
>  * Passing a size pointer to report the payload size back. (Jonathan)
>  * Moved logging of supported opcodes out of this patch for a separate
>    change. (Jonathan)
> 
>  drivers/cxl/core/mbox.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Looks good Robert. Do you think this is v6.2-rc material or can it wait
for v6.3? It sounds like you have a real device that needs, so I am
inclined to add it to cxl/fixes for this cycle.
