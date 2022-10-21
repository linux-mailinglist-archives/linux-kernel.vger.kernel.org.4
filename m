Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90DE6081FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJUXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:07:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD5297F07;
        Fri, 21 Oct 2022 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666393626; x=1697929626;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IYuantDatYn4NDyXxt9H1Evhxl8Fyx0sHyTkUD+qaks=;
  b=k4gqE6aEAJDVnNbq/i7x3KkQhntcldvkzfmnXbsKyBjdKAVK9a85qV3f
   4Zlq95Odq+zv/5aeyjAItkTOJFFTtTNjPWR3EQddHRGgoZLoEdOB7MP5w
   y4+8VRX3DzAfJ12IuRfQ5PPCMDv5cd+N7gYyQxgSo5wAn3ldqoiWjSHjw
   jguiG3sfK60iHY4h/7V2wpKWGmyJ9Fqb3Qim7Wo1XcMylJDWDq/gqJJgo
   E8X2eFHbKeMvaqCefXFwRl81dxF7YUPxJ5mCi6E09pkwkbnuaA+Tr5+W5
   ErgM1v6T0OWTNXhSF/+q0QwdJB9y8HLBjsrX1bzr/SFaqMmN/2W8/k57f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287521247"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="287521247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773231827"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773231827"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 16:07:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:07:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 16:07:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 16:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYcx5FySya6ncHt5w958hnCxl1VKOi3dIc77qa+zoaZg8GLWfTJA9Nco38LtVhty2Bux+6z6IC7u04ZFID+md5WKdB69n1Qe0B0gxdD6vgKLyOOG6fJGNRgHNlhHtNOknW1Lm1dFk/s0tIvwvF5aNJH7d4+4iwuB53bDD78R0yKqt+tGQfMMDZ2sZz7SuS2Nl04i+ORLdWbNckjI8o1qEoIzAJJw/31H1dm6kEERdokSk9dWdPpvtlmsVao03QdOqYLt5gRL6o4t4snSecIHHAukxs6bwBKhE4dLUsx7pXiSu0ppIEBqXHx4wr7nJTBKNTLoGmnsHsFJ07OYBm2TiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxpGmS336nzB6xDnDj29f9oO0dINUvkvtW9AiNBlG3E=;
 b=dqZH69VQ+q3yX1gAM/2qV6ZC/LkEMl3dwyMOjvAoyw+Yk8io6/4IJ2cRMFhNSWs0Jx/B0t3rZmDOZZyicpZX7dIyp/fWUdFbE/3G4NynMLQkWGHlUxrcwZVb1Hxz/mEGdwQTt5LXL9j8EXtF8LVS6tkg+HlE+Jgv/yzGxSLbAITukdOmDMflMawgXYiBcI0+uxa+bTWvIzc5k+HM4vxBwUdysVyLdwBUuuVzBepRRED5SlbALkN+GeeJ3uG3jEfjCrYMc3nV5Joz8byKrWDSv6TFpweR+rWceZbH4VUDskKSb7Be1W+d5D9nrC8CWkWnLDefQwAQ7DHGCuu/J/HtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5583.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 23:07:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 23:07:02 +0000
Date:   Fri, 21 Oct 2022 16:07:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Yu Zhe <yuzhe@nfschina.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liqiong@nfschina.com>, <kernel-janitors@vger.kernel.org>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: RE: [PATCH] cxl/pmem: Use size_add() against integer overflow
Message-ID: <635326141b6d9_4da3294cd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220927070247.23148-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927070247.23148-1-yuzhe@nfschina.com>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 373d3596-1fd6-465b-ec06-08dab3b8f6e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hNsztwk7++/nLp1DF/64fw0GLJpml8ebny8PCnOskFbANH8KTKPKdhFd79Zp2XY1RH1qWQL3u8BN+37lj2DZ4BAPMarzhV/pIOd2RDi/NcgU9PNCmAcWkKeDSYsw/NIV+TVJPPtoSNrlwtS8OtR4kGSxYkhbhWcirxe9NolEm5ouN5nh7jkC3q2sQdhpBb4GJkKRwEJnmrOBN2zNkThnq7lLmu8xteoLVHDfwtqDs5tlEAMXF7IP666OtLYGXgoU9llg6PC5UwqQvJtWIz+1mHAoBTLQ1II3Wpl1BoosajEoe77/+jF9f9cJaFeaHExmEeyd+zR1Ms3S5ixCYZdIEEdfCVgmD5Ni7EpXVUDVYz9w6QNTrHiu8fnw4LV2mbVPie53V5kew4uGK06w4/ArCEy222FV7I5FoDLEPbf2dzxP11Jslybdtb7NWFIOwhVgLO4d9tYCLS+yksD3OXzATp3zWaf3SOhe0SzOCY0/uS4/g79rVahWtLKWgKX2Yt5gdb20WawU9gt+CIw5Jx5Rn5waVHRldhdX3amM8j+2Ir7EEowtq509ixD+Htcoh8sRTU7WWuZdqIHjT0SBbrR9m9sTAETBQfycyO4hY8/lShLtdqWxD0XtukZMrf+FOiU2D6ig5kiNKTba4USv6PB3WqxB+MTZvn/yTFuhXExI0PpPIMPh32/OkJv2Qs/sEz6QWztfc6WNdM9hOOcTXp3Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(86362001)(82960400001)(38100700002)(4744005)(2906002)(83380400001)(5660300002)(9686003)(186003)(6512007)(26005)(6506007)(66556008)(66946007)(6486002)(8936002)(478600001)(316002)(8676002)(41300700001)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eU2DEDMzXxa1p92Vz9Hrqv2GNbuSPd+tCRNFJ14Ok2HoFhzbAiXCXOktRyYn?=
 =?us-ascii?Q?QghbeF/Hy9QlawbA18l0szP7Zq5WuuZaCXNmvl4G+POVh46+a/Q0Xo4/ngVN?=
 =?us-ascii?Q?L/AIodypLEDyPzKLqv8SzwvILT4j88JBD3m8/ItR835jf+mZiaSSIWmEcWe0?=
 =?us-ascii?Q?QfiSjWIRtK9vI5hYSZXDppJrkPOK+LHOJCJ0Z7s1jxwKAGLVHNoLHhcOPGux?=
 =?us-ascii?Q?YSyluWUlmWomSx9PpoF9ckvjtfSI9FrmyC3czStAGVpkBWwCFo2mNvLXmVMT?=
 =?us-ascii?Q?nMI22LzVg89rYMCGngPDq8Bqeau+SaQEnz108C6iGlJ5Lf9o8ZgVp65rP+X4?=
 =?us-ascii?Q?wkwmOgAnY0I3mIvKHos+DKY1X1Bu7noPBOcBmwS78MyIfMB2Ve5COHHthYKd?=
 =?us-ascii?Q?nK+hrjP/45eCBA1zJjQaskAJCeRLTN008pop14O/UJP+B/jvSJFmHdG1Ia0b?=
 =?us-ascii?Q?d9T6nCwYlHyNefFvPcBw1B/c1RUihuCh2+2Ttumj45tGPhktkjg4pRsWyvC3?=
 =?us-ascii?Q?KGNVy4qC6mLuKjCauS0kvPGU+ZkjFP6lMQvpDi+YcUP8ewAXmQg0Qeyte2t4?=
 =?us-ascii?Q?zrL2Rrcr8QlxkN+fkZiNaO0OQvFMuJzVRGANJYiYr0w2wRto2LCFkT+6S6e8?=
 =?us-ascii?Q?YV7uCF8J8Lny8C8HNPmsoYF/GMCdETa1KWsdOvNH7f1zbfjYtcj4aVyQ2NpA?=
 =?us-ascii?Q?usbXj16eDjjAE1RA/BVTp0c7pmWRoWVsxi8f3p2qRZDQ7bXoz0BVHxmLqevg?=
 =?us-ascii?Q?6fpNnljo2LhUtf/xlacK94ASbkh7nEHx6Uppzlc4xsd/eIrfySpFvvy1FfdP?=
 =?us-ascii?Q?BgUgyJD2bTSi57rIZjlVzxvk6RHyOPXMNt6Cv3IHHoy+M7Ow5iS02nTLuq6x?=
 =?us-ascii?Q?83zMYwQXr/Wade0EsC02Mjtmo0uDypjXfG050hlvFkn0XcIne33JwHTuCDBf?=
 =?us-ascii?Q?qpOLx83FOPABQYaosMG03/63Hdq8kZDSV0nIDDOpYHz0Zyu8cnB1zakfQ1dA?=
 =?us-ascii?Q?rgEuTC36yZnMLy5m92GLhuBQn6T7TPnoir+TFBNEQLA/S6AMzzX4gXTNJQ+c?=
 =?us-ascii?Q?LYMTa2i8p/k7ZU2Gij4C5bycisDaONSfErQE8NJ9L0LTRzAHqLJPuAe4IZDM?=
 =?us-ascii?Q?7Vp9JXC0EvcHOdSP6BEWR/rcaOhDP6BoVM+UQLT9gv4fH/mPZoNZENFkLkXo?=
 =?us-ascii?Q?imElCy4iMp5es14rAso/ggR7TA+bmrruvJbD+LEKVBw+Su5xTmBuabVYgq0r?=
 =?us-ascii?Q?xMnQDLAudjfOb912Xfn83dWzbEHSw50IdVAvf8VQHQ4DS94iExELTIlu6A13?=
 =?us-ascii?Q?fx62WT8Y6GFGAiSiapaVNcitn3MIAmLj20aRp2Bk174CUFKjV/MolDF0kt5S?=
 =?us-ascii?Q?27tiey/fS81Z2vzbJUHvQydgf9dnxuQEq9tl+DWw5ucQ485a1EMA7fDcBBh7?=
 =?us-ascii?Q?Tc/d5lgNLpkUhDNbQVjeewkKhXfVyMpwMc/7avSlViVwibVDyY0ReI4/sRRF?=
 =?us-ascii?Q?ZsFe8m/nFzEkcmZX+u5FfoQ8sH+TS/I+h9n5nPQzo9eGjSeaIVfZasuroN23?=
 =?us-ascii?Q?LknvBDHRwR76LcVCOZfQw2Pi0kRr/XnU7tATtninxwtOCfB78VYqsMwyc8Ns?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 373d3596-1fd6-465b-ec06-08dab3b8f6e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:07:02.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS1NNMqCfmaJDWGocvAkk9uCHhjjdnjGuYuNGKotdNMQ8X3VJ97aqFcpaOHK7fmtDjVvRbH4ZJw55LmfG+lkrKIeI/J9OR5m3AIj5OPPss8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhe wrote:
> "struct_size() + n" may cause a integer overflow,
> use size_add() to handle it.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/cxl/pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 7dc0a2fa1a6b..8c08aa009a56 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -148,7 +148,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>  		return -EINVAL;
>  
>  	/* 4-byte status follows the input data in the payload */
> -	if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
> +	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)
>  		return -EINVAL;

Looks good, applied for v6.1-rc fixes.
