Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A2699FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjBPWtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPWtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:49:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C334F4F;
        Thu, 16 Feb 2023 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676587770; x=1708123770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=koG0rQCPulpBsx4nFFXp99WNRrbHNlY0e2RCw8qG3rI=;
  b=il8UZqyK3WWnIZ104OIIKGFLakloNBomRKh9y7fKQ28sHnEarQrr+v9M
   Na7GP8axxCkKCinBkpXxpdYqCK0cNoMsNJBDIP543YMLTSU4Y8Kq18qCl
   6F3La69hIt4YMlspvtKRBkgIW3dxChwvtY9TDEGRJinOKJ/o22UGs8j0K
   cJAkB+CcY89erQGVqFU7H6HGcNVCGXA/9cTmV8wkFkxyiAeUOs0ZPkSkE
   0z997bXw46OPDKvkNMKuJ4lg+DIEzbLPzIaHsjVNi1LEfye0pbEtZcDpL
   mnbo5N468l3A6NsETfA4R2U5TgdkDGMPV2bzID2Owsn+5gD50P8Qbg1GB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359301045"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="359301045"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647886720"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="647886720"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 14:49:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:49:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:49:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:49:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmFxV3YdPElohCWdqw69uomwVdy5l9osC1N9otc66hvxU7/f3JPeFC/qRroNQIT1hSseDPXsYxgNIkyhEapfSrF/pBJkupQIodhZin1ce1hspZEHXC4bRTo3R8fn5t3HW562tt0+rtlNGu6/s15Gu4dQAgp4da8M1c607Ib/ytVvp+ckheKuxCbwGxeYz+NizVRLkJXrLdxE/2NRIyyO1RCr1u+Nu1pEhSboJkk+vnZoFaQmqfWoAy1/byuCnKAAsF/b2irQDSr260oPBUU4qfWM2rGsVy3gXW3UOJb03OyeU+mhT58Mty/cb/uljRfkdEuokXwtFJKUAXlIxI4DCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opzbg55XLyI+P6rAsYlHI1iEkCPu9MWyu686XsCnEGI=;
 b=G4PxMbEDm8w/uA+8cOYopLihc/5ipmCXkdRDSuDsuqz1wZqTKAmTzxqPc72dlfccLMAP+nDj21XKrjG8neMHUXBNCz483bICfEDpyCrcQ1zCbV2CeYpA2pPPkwIWJs9Y1fOLOCnkkLzEVojEu7C6uBJLu9vgBmAnuzMnPMH03D+AzHcwW7kfLOLIgTxFR5mPzFWU1xyudFsgVAf2BFOaLRKadV7SKRZLmqNSQUw4q3oXPjo3PWpHVv9KVHx7Q1NThtElvF2GYr4RUb/z/AQuK/f2lqrKcazj2rqurjHAtRCLQ91hrQjutBNSpOD1D+lkVC1S2m9MnPEZmhBlU7iuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 22:49:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 22:49:22 +0000
Date:   Thu, 16 Feb 2023 14:49:19 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/mem: Add kdoc param for event log driver state
Message-ID: <63eeb2efb5976_32d612943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230216192426.1184606-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230216192426.1184606-1-alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:a03:60::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: aa138792-8297-4d65-5619-08db10700b7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jkRkDfxiVwdvxB1Avv/vPcAkThQptejNubkKKRb0NLlDD3AszR/8xfM4ucwYVFflk0EjLplqkNrbIvGT+VF1BQj7FqMnz/o8KI7myYGg70gsvfS8LIEXyi90yU1TNVQr3ui8fPaj26wUk8iq7B93h8orZjzKKaGgWIznboU8Jzw7u1ZbLIdDK0k3RdOLuJf+3PQZDO18z8PeUhCI6VRo8qx5gmikXSuEMJzrhf3OduZ79lE1fHG82walwtVC39if+diIlrnNzXhGaGR4fh19PmTKc2dST2DDgPKnkVhM1f/YYRDNL3UhvYGPAc/m0qmijqx9GM1KeYjI8Vytwl3gH1lftsM+JyCdT6XI69Vr+NCuDnJoSiKcs75gPFgqBXl1pRQeMzsnYgJofgsNIspZdNkm0lfn+gQE9CvxJ/28cVarmTxShlvNjKFTudm8dsXRtw4D2jU1hH85VsEDTBlMTH2VJUAU3I+mRT3LdLwkR2L+5jZsQPEbVydzfyvcvIWAZ2lIo54KtTn3WwhgIYJb/LtKL3zOBaX8E+a2b5K4GmX/Wmn6GumMoZL748SGoN+ihkwSq9uJ6Qm7KBIyCDdz9jUgswZmKB+hfNGfkAl11lwijAp2zzOCrAtG12T9Ormd+DWGZZn+BHY2Z9iq+KmkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(110136005)(8936002)(6506007)(86362001)(6666004)(26005)(478600001)(6486002)(186003)(82960400001)(38100700002)(6512007)(5660300002)(558084003)(9686003)(2906002)(316002)(66476007)(66556008)(66946007)(41300700001)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4PQGC6gjGElI0uf4FMZ/BgUefqfjztngcaYrAe6Hgfm/e68u9b3i+7pb8Uk?=
 =?us-ascii?Q?a6yg+5zWNdfHgiZxCFM9xifYWPfG+QxdvyuMHfFttxnBLlOmNeH3fy1ZqZtT?=
 =?us-ascii?Q?ftzRkYVtKjWjhZlBDJn3T5Xnuyzh3p4rrHV6c4ZlFTCz+QKdMDg/Nxp4hnIE?=
 =?us-ascii?Q?HQeB8q+YauUkqk5deZrAO0PMpuhLfsmNPsOPTVGUsoWfFJWDREw4KjBmyEKb?=
 =?us-ascii?Q?Rp+IenMPnjBZ96IUfwhoOOnaSaoeS2fr66sbX6fBzKkAjCmJ6Yv6kWlowe0+?=
 =?us-ascii?Q?H9usCagbTAtu39ohHNE0VQN81nzAcLrpb0WtV92ikckBxDJhsR/DKpe+UUk3?=
 =?us-ascii?Q?1mzoqpbYcvogDbsfd+FOpq3dY9SSMR33/lB4ZxgShoxaYK5WncoZW6aRE4VU?=
 =?us-ascii?Q?87Asy5k+vJ4Zbji2/sckEHYp1lkLjjGZg6lC/vOq51+ZnRFsdlGlvaMdE/Of?=
 =?us-ascii?Q?h8iOJHVkjEKHjDRYAi0mhRpTUBP3/4m2VcL9CB2K3PoTJO1nUZEKYl5jH4s/?=
 =?us-ascii?Q?izL2Ahx1/+9xIVyBIBQ9v5oekUZlCpVMBfUfWO16kE/QfNQG3c5jZ2GDEfkB?=
 =?us-ascii?Q?YbgqiXtXBpcONmjPWEN/Om4UwmN2nMa4mmqv8/9iRvq2uCmcog5RTnkMSmdd?=
 =?us-ascii?Q?0iuELbyhrcEJTqTrIlQlKHmo0vfN2VLqomkXcVqrtHj4xR5RFlCHzu+Gi52z?=
 =?us-ascii?Q?Gt/M7qjHpbMWF2xGt19ZM2cz+Sjr37b+C8u1yRrldUpIPaC41pYDeOOZut44?=
 =?us-ascii?Q?6NoNG1vU2Zp99v1INTqMk9oup9paLDThMs3+0+BkKZsTpZmIOD/y1iwAhb61?=
 =?us-ascii?Q?7x5T/x7uXKMYIAodh00JwMB4VHDAI6LcjftAPzCK/QjYx4zmRZ46cCRqWk2N?=
 =?us-ascii?Q?G5lErq32LyldMACB/TJ9Lw/5P8TSR/Wj4liltWj/tnPYv1iX30q8OsDmYAES?=
 =?us-ascii?Q?99zZy2EAsnqTjv1DFBY5mC4Hf4LeAUtSPwf8zCwoWJ84xzjcWXKYRLk0wjEN?=
 =?us-ascii?Q?0hEtkAVaxuFDQvfcIAC9umTaLdzVVOjm4xOlSY5mglnZ5Utp+ZdmhPrjmjLh?=
 =?us-ascii?Q?QKy071HZFL/5qHJc9tjxexvKFNjjiQqSeF+xwHUdLKYs8h9uuh8XRGtzk5J2?=
 =?us-ascii?Q?l/IZEdlzPdFn1XN5p33jBslayLOhwkLbwC67ESRxMEguscl/RKr4QNUzb17Q?=
 =?us-ascii?Q?bfzOK4/Z25onbksmn0PRtMMVrTv1q86G5jGCN3gnd3AiMWxeiS9hXVXhWy5w?=
 =?us-ascii?Q?xYpAeYF+1BwNfhjkpIy7BRymcKDMAtK95oUWSStVYI3jyeJIV1WSpoOV/3ov?=
 =?us-ascii?Q?rcDvcTfWp7628cqeJCQ3hB8fgmkUfWkQEH7FFmGVqw+bMv1m/u+LUTkH3F12?=
 =?us-ascii?Q?fwxhpGVZTjb8vz0ZB+GdtJ0NPYVveDvbk3ioJjXk4ONntq9984Je+8dTi9Db?=
 =?us-ascii?Q?q0Ul6aK/q70SCUFS967QKzMYBf//zqw3uZDaQFpR7KJKeBqLFuAY6ejmnmcZ?=
 =?us-ascii?Q?f1SLwZiO9ZyjjvJolJ7HzQWLec+CULKHde1c3GZOJSvPGsFzLyFkYWpwzeAW?=
 =?us-ascii?Q?kpVUEOMmVZ30ZnTHBYxrCBDislMjMgz2aIvPKzt1klrpg7yoybGz7YknGsH0?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa138792-8297-4d65-5619-08db10700b7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:49:21.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6Puxy1Zmm1wN/MPzeOn7FnAbjh83TDc/bzG9ykBJGCtl5H7FtzVwXgeI5tCrbO0q34byN7y22PmdTJ3wLr5ZAGnOOqNxxCWzNj7PFt2qfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> This makes the kernel-doc for cxl_dev_state complete.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Needs to accompany 'for-6.3/cxl-events' into 6.3

Thanks Alison, applied.
