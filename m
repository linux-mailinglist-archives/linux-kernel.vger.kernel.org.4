Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4F6B24BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCIM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCIM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:58:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDDF05CE;
        Thu,  9 Mar 2023 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678366667; x=1709902667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CRajW4CQwJYXh/1yDxAuQSgXw3sqXcc/YnAczQdHkE0=;
  b=R5PeSJsfPB/LjQ2lrDwxgJQxP8xARPGRw2oys0/NUUzCNIkyIRDTFuI/
   b4WJY/torq1g1cTKKCKtwbHTNCC5JTHWGU5uu8aBjn+BmUL+ym1w4FMDi
   7RVyCC9weSB/qv4EX+s0L16hFcjZiETuLL2TZ66f4W0E1nc8Z49/4cqIA
   nOwJVhkxdWEZ+Vj52WZ17FxeoHxTLvk26Tbbt8d/z/9D3cnrPi2tr+glt
   2Tv3tC3+RJcylYbRFWigLw6Y2BZLOFMK/9mvikQC0klHsUd75ulp5Ai/1
   j82IY2lEPMqcETBr9Rr3BiLDT11oY4qzFsqo3TaTQFV+iRzk7fBFyndGV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333908065"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="333908065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 04:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851496070"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="851496070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2023 04:57:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 04:57:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 04:57:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 04:57:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na+Q+/J2efTZcIrFwvti6Ej5TmhGyW8a2P2JFZo2podzpeXKItbXHgIVVkPWXyxLjxbW74phIZfre49jDgA4owk06LVyZt+KdBpP+yeUDNQ5RlY2iu5kpdLaLqvCz8S7GzAPonRLTM1qwUGlra0rMs3Epicz/VGl0MGM+E12vuqe9VA42QnDjceLQZm3sxyt1Avvd1yYABdjrvFh/zzTXiSQHKYjY2V330/wlGplJFR8GiqX8nBbH9W1RCo06SCwsu5jQpyB3lzZHV3/bIDPtR+OxUdCxbOlH6hIsAbGb8MBjj+/VCxYZGSltuE1yrlE7gmj9pdtkBkRwgQpQdSt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1m51OZgqVR7MsDj0o4lAMC9ZriPiKQEoT35t84zNVk=;
 b=i8ywCrwA27O9kP8hMUd0vLrBZT2gP4QPPGg7Hs5EU+U+M5JxNxamTRFfxXDxbYr3RVeLDXoW56r4JW8SjVFdeGz/50NvgJiqP5Wmy9sbjTpAx11jSrMKB4tHk1JiWcNoR2FrhdrXvkdF1nmnaP2Ep9wec74xvBx5coH24UGghV3Sw+1TQtJ5WiBQsXm93ZXVhmyAIGlZTBMjOi5KzJ84Gk4WSP9YK35R1P4BQ4vHEDemaTRIthO6mz8Hv00/uF+ENesUJQEvIN9UcF1VolodURcDCUIS6AFQpbu56qwYy/gEHPjrDJgTO5xHX5IingDjU9O67gTHvQjaPGWByl6OCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 12:57:23 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::bf91:c1f1:da12:9cf]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::bf91:c1f1:da12:9cf%3]) with mapi id 15.20.6178.018; Thu, 9 Mar 2023
 12:57:23 +0000
Date:   Thu, 9 Mar 2023 12:57:07 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <qat-linux@intel.com>
Subject: Re: [PATCH 1/6] crypto: qat - drop redundant adf_enable_aer()
Message-ID: <ZAnXoysp8IPjoYmR@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230307161947.857491-1-helgaas@kernel.org>
 <20230307161947.857491-2-helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230307161947.857491-2-helgaas@kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LNXP265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::27) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA2PR11MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5348ff-cd9b-4441-0efc-08db209dd345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFF0O5QiAHDXeQvg7/7lvU/sBxHc4XqWiQ2G8+qJINVOKXqs9FrLxMYlZrUBu/49B/kb/NZYEnjCyDCv8uezAYILHw6GJflNJ8tuhmpwoUxJTT3SCbBAUevRhM5hOEHG1UYcExErHnddJypxoba8M4xA3By9ITa+SZ/OjT2MB8+nfgB4dLV9QRiP1KyTule1cKZJ2GPvijU1B/C3Vhs6rDyZs9k4j3k1pJ6i0iYdJsc3BNGOZpDwwTGStsVdNgH2MZqXeSxEke7v7+mDm/y2pj9zfh287WHkHDxtu/W7eLUqfukpYd4FhlEt0Gcyp5eaK3/Geg5TQz0SfPYer89Yswi05aVjwBkoUiJZitW3DG0T0b30Q2r6sYYIj2jRL4CAOFeakMFGwOCqHmRLHJq6HYuFbIxFU/Eycybcqfo+gJi/iPlLg1+Sc3dEqRkw+9klC7zALGDe8uwwE+slptHxFGoaDC3pM0JOu/tD2pMcSWYREOqK1if4I/t5CKCVJ1BZONs1icsswMoYCkCz1pdcXlMwYglczAyq+qcHrNCpMzX5SSewbGdlZpjNG3m4RgOossg5SAlkE+jZ2avPkDSjjQPnBXpMlo0oHH6IeRU0iLQ0P7a2wa5Nv79ET6gLimYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(44832011)(478600001)(5660300002)(186003)(83380400001)(6666004)(107886003)(6506007)(6512007)(26005)(86362001)(966005)(6486002)(2906002)(36916002)(316002)(41300700001)(8676002)(6916009)(82960400001)(66946007)(66476007)(66556008)(4326008)(38100700002)(54906003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NpmRyIG81BQQOwbzJD0NrN9DIR6iueWxCrpCtPFR3RQnF9p2o9cKnrHyemT3?=
 =?us-ascii?Q?fwyft7/3kU34dSX3/HV6y+Lhv5iZ1kpggbEFhS4Z/jnePHRbZ1a6xP2pPeG2?=
 =?us-ascii?Q?ifZLMcbZZVI+NKfAeQRifSnD8x+jq/gPtbz2U2rFh+IE74297LP1NAB9ybb3?=
 =?us-ascii?Q?5fxl39WDzHyeRs3/4Ws3jt+WeBiQu2HyIvFL5jUoohgWkuNJhLIn8SMZrarj?=
 =?us-ascii?Q?axkwVLlu3EWS+C7CiB9cVt5WaHj6bC5Bw0f3jUMPdSwomgXE8HgPioQZoEiE?=
 =?us-ascii?Q?hlguI2K2DH4vPgBgVQhGgGn93Kmg7f114sfPz+N/tApLd4+xUhf1sZPWhF5f?=
 =?us-ascii?Q?fYhmNUwRBtRWKSv5Wbh1NaUmVilaoRfaXdMQJqTeATUtTJYvRC5CKUrLqe0B?=
 =?us-ascii?Q?WUyJgJ6vBBYAinxHhI6EdHff06rc4VS8A7P9fCGFmqBoUI4d1Bp7ckm3swYC?=
 =?us-ascii?Q?E+56zd93+kTA9Hlm7Uj3o4qiV8aNytFJXB7lDrm/okfVOInciljdKKjlzmLM?=
 =?us-ascii?Q?zOHEyIKTxXjO/Y1VSJpvCTkfDN4QkeCkZn7qVGgIPcXryUNJUhymKx2PRbjv?=
 =?us-ascii?Q?boH5zNwnpJbxHGKmVuArFpe66poi4rpmHR+axQ2wuF4dF8c/uqYX6QFkchpe?=
 =?us-ascii?Q?6p4ZE/YsXpBmD58yoqJgSXSA4fheYZ7Fag0qCbVfRrMnRUTloCzo9DSRCSB+?=
 =?us-ascii?Q?5QxIKgNyYPPt4JH+TfTnaLQMNC15Nffx7Ebkj2mybPcDoQRHCiMNVOKMFi4G?=
 =?us-ascii?Q?zRApCrUV/fhcWN6A26zH/5Kgc1+efsFMQz6pOKb7Wj3ZifdbrxL9myj0NfJv?=
 =?us-ascii?Q?yyNIQlJK3rpGMMlpP5Bffkzpg8AQHsI1sWpxQeuFwbKVm4jAhrd2HLZ9KlP0?=
 =?us-ascii?Q?yjrE811Y720p9pNfbxxBokfDMakmGYU0ARfapuaYN5MV5XJ8Nm7l+pHeT3GL?=
 =?us-ascii?Q?jL2/ExnhIQSrvlTvT0AuXuDL90K2+F6ZLGmrKdCFnZTv5vQZUUsAzbGgkZcN?=
 =?us-ascii?Q?UCY/L/JRiE6tJ9VksAlErfmqw+95IictWIglGf029wzDYOVuhewl5vLFGM/c?=
 =?us-ascii?Q?DBnQrWnNuqqvVOx/sBrBvv0e/Ai2Yzsy8pEcwss9NGjRVsmuDTZ8vk6ahLOd?=
 =?us-ascii?Q?DDTfQv/hMs0L5Z7fhxE3Qdmklte0i8g/L0dNEXLguGXT57i4iCyR9VkYsYfd?=
 =?us-ascii?Q?QmS5KWJkuZZYC+AWCAQddUW5GV4IQ3ESqIqhxZvEFPen35a0qTHZGCWfB4IM?=
 =?us-ascii?Q?2Vh8pDeAci1BFSiuyeYac1v3goEOeJzfQHWkiHS7a+OnIMTmVODlG/daNGOH?=
 =?us-ascii?Q?iqNrCEqCv/1aVLJbtKsl4tjU6vHxl4bRYDGArqSOZGuff4n1S67tRZwWucI8?=
 =?us-ascii?Q?a/CY7rXb3YSoHTDSio+cjdKQUzi54JHrAc4HDHBu/YfYoBWo2cLI6EwvvTYR?=
 =?us-ascii?Q?V5iBXRMYKxqbxlbKSP7qBuP8tQchJQK8qwdCuTNGQCk4rJtiPRRfLlu+wBh7?=
 =?us-ascii?Q?kdKJ0mACtmbVjpsCAiLJSeo+SisR9z3Uh7yehJIvqj/5u2WBqoUvaQnQioi3?=
 =?us-ascii?Q?QUQbKlFKOb1K1ADnqT064MCXdXZya/zQ3r52R3UEvpLpzOW2hlNsh2WDWpEg?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5348ff-cd9b-4441-0efc-08db209dd345
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 12:57:23.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3G96o565Uewij8GY3HppcMHFsg7v9SIynYC1yf6Lm+uQM1LEf2XlXuSuc5mfUF6VWnh92yLXROdeVmd1WUad+d1WCgPydub1mWT7GKvdtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:19:42AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: qat-linux@intel.com
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Reviewed and tried on c62x and 4xxx.
Just a note. This patch will not apply cleanly after [1] is applied.

[1] https://patchwork.kernel.org/project/linux-crypto/patch/20230227205545.5796-2-shashank.gupta@intel.com/

Regards,

-- 
Giovanni
