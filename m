Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6655EB6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiI0B0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0B0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:26:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266EA287C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664241990; x=1695777990;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S6h/HRNY5auhlVBY9Rfs6sbsWFzIx0iz9a7bi/nO9yg=;
  b=Rod2vPbiPJ7DQxFOMe/qJUVcE5CQkseBuApz/mB5ya2USAovSVn8yi/P
   329+fGhGq6t+IeZ+i3B7sHJw9uWmTlNYNvja7inh/QpAlcPLJpFWWtrn0
   JjlL/JlOcOczpaf6hAmkrODXWGQ1eVcJHZjB3yfxAlTSphAg90UFqa9JZ
   KDOL/J9KIzX39tNH2D7eVlJNiIlv4iTZ1h7qKGA/IZNrUl9UxX07IzCXq
   BXxvmt5vBsptMuoDW380TrwyeB4muZ+jsiLio6BwzNeHlE6+sYDccCLF6
   wQpWth8VHjF5fEoi4xdgx+kAIo0Tm6pdzlpynzkXoRFfNK9xs8ROO7ghW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327540914"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="327540914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 18:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796580411"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="796580411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2022 18:26:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 18:26:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 18:26:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 18:26:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvK0o/jQkue1JdMdycn2foXNiwD9X4WWzwwawlwHBDmIPq6LfyazLy6AdbF8c7cVU8Nl8juktrCU7eRMu5XGKrEdSlOe4y+qvMXRN+TL2gnMfbClRX46r/82dVfWN7KXCbKqemuy8FQ7gWubSxpI6rvyLBuu8A8oey903cqxNYPXcB+SrJoPJAvvhO8LjsR9++mfNoy9mX7U6Gl5uyd3upjPQcw4pdzPd9A1MdMALf0A1oOc7hBd1axObEgnqNO+aDq5gk8KrFhEP1Cw+h/r5FU8IzpvXeUKqWQEVPPjNtBH39OECPuIkB7s7mFx1y+gFPWj01OmKsgxDiJVox5hwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlJynwXhNEARojw8a4azOH6f85vaBKMZo3T7j4qAaWM=;
 b=lbQ/h+Tpt8lNcjg/6hmCTyDaZ2Uwrsgidp7BYrip7vEtWwSBa5KIq1Ts9sMdeJdD0HlxgOWbRdWuMJGGYNx5d1zp2ujO7pg2KLETEFcjAC2Lcs3CBo+m2bvLhbtofdKwJaX/1s8ePcD3Tl9mS1rEpJUYdT0rmHXSFCJWlBmS6+zt0Mr+hWiuAHKd2NuSi9d5pF6zfKXtoDLMzAnlTz2m4lpwELvWluIgXX8dfldskxlPe0IwUlWnGzl2dgvkq0yuvJS97zw/nh7k/UO7LjSgwaCYskxaSBUgsByRE3Lip/vG5kWbjAoo1a0uaL/oyOEDY71v97dSunWnb+qcUcypOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Tue, 27 Sep
 2022 01:26:26 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::9db3:6204:5b3a:4ac5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::9db3:6204:5b3a:4ac5%6]) with mapi id 15.20.5654.022; Tue, 27 Sep 2022
 01:26:26 +0000
Message-ID: <af34adb9-7772-f96a-ca36-73e898a3419e@intel.com>
Date:   Tue, 27 Sep 2022 09:26:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: [mkp-scsi:for-next 59/141] checkpatch: WARNING: debugfs_remove(NULL)
 is safe and this check is probably not required
References: <6330e3af.23eSa2zDsViptpST%lkp@intel.com>
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <6330e3af.23eSa2zDsViptpST%lkp@intel.com>
X-Forwarded-Message-Id: <6330e3af.23eSa2zDsViptpST%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:300:59::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 102eda85-cc55-48d4-510f-08daa0274bf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJ4exbWT0uL/k3lt58mU/3T79e1pLKFYRFaCNo1aLXP6NuQArZMJh08gb9RxYpaqUR/RLaY+CRp3R65pcEWjpBzF88AjykJoe0NuKFRjYlI/TuUtU0+lnz/aIY/wo+2CnJtN0yd6xIESEqEYGDlCF3qM1SAqHHxlLJUi09Y1MEUvNmkoTpaI7dkw+UG5PkxL5+bThEMn3Viuw/Ul5r0UTiluP6GOzsgZTAfe/WJfMWs6YacyxnTzdnlTfsO2EUByr5eh8aANlMFNWYOswEbyoIHhGqRjDLjcmd5DF9ZQPTU8F4qryAE6b7MXHm2Z6/KDgCAhhHESQyCiV5pG8cwNdGj8dve1LlKRIqJF2b6sRyh+O51yFWK2RRggLOoznbGOybwh00Lk9cRmRtKdNiPCVJtYlgEL4jpoiiL1W6TFigFhfo3HLp6eXxt9iNtzzZNlkWZ6YWTtmstr7qN99tkcRC4pJEsbD1mMJInBJMgKo/bWDLt61/ToddBoISAcDWzeWU98e4l2KD8lN8iqpXLArkMcNjnZ9ObsAuDHJen3k/1ruMc7qf2MmnlOi2Wka1ohomDpyXDjx5ugZ+44+bzpAH92oNayS3n+E88kCRrxZ8/dEJtCEe8epMDF7tWr6RnO3Da7U0dRxkn4lNr9TYE3saLMsKDZmpGjwMBlgJyG7g1HzzHxLjfgSiR8cs65cU/HxRLS5wC6dqFFQNdDu6N4Ku8479EUmKbVx/+fkQmudbyeBWU9Z8gf7Ti0wOQnCyyCYcvPIrwbFjhR+Ibeq3s80GRPJwXCo+ufPW32FRPIsc1TZQ2GZYJdJ/w7gUGlmzsapS2VngTYN/wZafds6J21JzegsrbXsZZXVgavaZaK9Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(186003)(83380400001)(31686004)(41300700001)(26005)(4326008)(38100700002)(5660300002)(6512007)(6666004)(66556008)(8936002)(82960400001)(66476007)(66946007)(36756003)(86362001)(6916009)(31696002)(2616005)(2906002)(6486002)(478600001)(6506007)(54906003)(966005)(316002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFI4TC9JRHQvTEhpZW9jb3VEQ1FiSG4wOGtMWVVIVElVc3J0cTcvVmZwWDYx?=
 =?utf-8?B?d0IvaWwwMEsvS29TRElHNkpyMmJyNnhOZkV5OThSaWhVbWs2WUM2Tjlhdkdz?=
 =?utf-8?B?ampzd3BGZzZ0YjBKYzdmQ01CelZ0MjdGWnZ2d1UzVTRhZWRDVjNvQ3E5VEhX?=
 =?utf-8?B?emUxS1kxOEY0WXppZXBQUGM4dUx0ZDdnSk1jMmVpRUozUE0wN0RRM3hqd0ox?=
 =?utf-8?B?U0ZsSzZ0NG51c3drU01nOUI2SFpVTjZ5KzVoRy9BckpJWTZtd0tEYzEvRGMx?=
 =?utf-8?B?S1VDbERuVXNHVWprWG9uWGNPZUdpa3p0anVhbnBWbGNxNHVDaEllUll1T1hY?=
 =?utf-8?B?TktpdWYxNVFSOXFsL3VYQkdDWjRjZW1Gem5UUDZXY2x5Q2I2dnZvcFBCNUxH?=
 =?utf-8?B?ZVhDL0lzRG8zbExDNUxqa2Y4Zk9SdlgwYTlObi9vdHdtcmlsTTVIWVN5UGp3?=
 =?utf-8?B?dDEvUGFHSmZBRVFZOWpTYnJoSGJxaUdmNysya2dDRUtOazBMZ2ZqYUJKL1BQ?=
 =?utf-8?B?aXl0dzFDVldNbjlidTB6VlltS1B5YjVtNGNzWU5WdmIxd296Yjk0QWxRRUNU?=
 =?utf-8?B?Uk4xTGNmYTdOTGtwNTZGQ0pGMWkwUlFTS3MweXUwVzZwcWcxYkJEclJRYlJK?=
 =?utf-8?B?ZzFWWS9qTE4zd25VcWwrOGErdVhma3h3dFYvcmNrZVBPRGlqZ01xYS9BcXlE?=
 =?utf-8?B?NVJGS05nVVRHZkdzTG0yRzNOM3N3Y1ZCRXN2SC9zN2NZbndsTFVVL2pzR2h4?=
 =?utf-8?B?UHZiSElyQ0lJWi9sa0VlVHFmcnlZKzRsZmcreUwxUjJ0cVVKUlVBYndvd0t0?=
 =?utf-8?B?WlJzellHVGdvSEhJeGVURFdEMDFTR3VaNGpHRDM4MEIzM2tibVNXMXFSYVNN?=
 =?utf-8?B?eHBwRis4VUFhRndUbXkwbGRtanNRRU5RS2U4dXJ1RHJybnl3d3F6ZjV2UWVJ?=
 =?utf-8?B?YUF0b1o1TW05K25KOEdzRUI2SW8rb0tjaS8rZ0NIR2Y1V25KaVdHbGMwd0hj?=
 =?utf-8?B?THd1WGJ4VlBLTUZlY0UxZk1HVzFVb256QVpITXBPY3NrVGs3V0NxMFZWcWUv?=
 =?utf-8?B?Q2VXQjM1WUlLQkUxaCtNU1FpbXA2Vk9URUFwOTNYeHJxcW11bUlhSG5NaG5B?=
 =?utf-8?B?Z3JtcXlYZGZaem9qbktONURBTE8yQm9zdlBvQy9CeEFwR1FrMWR2ODFRTUxq?=
 =?utf-8?B?b1hVMXhnM3hOdGVuQUE2WldreWEvUzZoVTBnTUhPVzJGeEdjVzhCZ1owT29C?=
 =?utf-8?B?WHJ5S0ljc255R09peWhJV2tXSkJYZVo3ZWM5aVlrLzZmZzZRbGRhWkhZYllO?=
 =?utf-8?B?eko4eGxwcjVSY05lQzcyWmllRStEQ2YvM2MzUjNBdHVDbzZFQm5oYkQ3VUZk?=
 =?utf-8?B?Zld2L3VRc0YvNlRVODJqaEhYT2I1VHU5NnFzcFRqMndCOEZyQlNVajd2eDRX?=
 =?utf-8?B?eUFNOVhialpFNXhSbkMvLzdFTjRodXQyVEtVQkpHdk8zVGpuUXFCL0tSdEtR?=
 =?utf-8?B?KzNJTnhRa3NDVHFkWVJlU0l0dE9vMFhBOEZZUlIvcGVpL2NTTGdGTlN3bmh1?=
 =?utf-8?B?WGYvVjZHc1Z1WHJjdnZCREY4K1lGWklqaDFwbnFpOUVxNUZMMUJwMHd2WlBn?=
 =?utf-8?B?WVhsalR3bFJLVFA3bEl2SjZ6ZjVjYnJ5U2lSWGxWTWYrZUVUTWFyb1lJT3BM?=
 =?utf-8?B?U3psa0pYS1BIRFFlbE1mZWJJWVYwVzVPL1NJS1VHSG1aV2hwSDgyaGFVZ0c1?=
 =?utf-8?B?K2wwTlRZQjlRUnkrMEVRcW9CYjQwMzBIWWVESGpJWjdMd29tdHNjNWRWQXQw?=
 =?utf-8?B?dWhWN24yRXVpZ0pLenJ4SGN6bHZFdXlNS1pkb01wYzA0WEtuT1JlN3huaUh1?=
 =?utf-8?B?MG9zN2lrc3hHcjREbjVZMzVyNjYzTkVYY1FSSjFOdDBiOERiVnBsbDJiTTd2?=
 =?utf-8?B?SHZlQnhBVndDQlkzSytET0pHUW1kaXdnU2N4V241SWZaNGo1dXllQjM5Uk5F?=
 =?utf-8?B?SUw3YW9iMnV0cWVYQmxSai82dGNKSng5Q2xKZTdyK3A4U3BJeTdyLzNuR1pq?=
 =?utf-8?B?aGpMazVEN240aTdtdWZyTHI4bDgrNDA3SE9HTHJBb0FlSjJrVVQxcGIwYmNB?=
 =?utf-8?Q?66ORF5pwLfVOVDxD0CMssyTRh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 102eda85-cc55-48d4-510f-08daa0274bf1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 01:26:26.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaD4QKXX9QI3cUVs+G7tJpvs+P/YJFe1aF2EWhQa0sghulw3i3NFZ0I8oNwCgKtFbZqLuJhqPgxtGxMaDznf4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   57569c37f0add1b6489e1a1563c71519daf732cf
commit: 389f179b868e43121c6cfccfbf5e495842a766fd [59/141] scsi: qla2xxx: Add debugfs create/delete helpers
reproduce:
         scripts/checkpatch.pl 0001-scsi-qla2xxx-Add-debugfs-create-delete-helpers.patch

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <yujie.liu@intel.com>

# many are suggestions rather than must-fix

WARNING: macros should not use a trailing semicolon
#71: drivers/scsi/qla2xxx/qla_dfs.c:521:
+#define QLA_DFS_SETUP_RD(_name, _ctx_struct)				\
+static int								\
+qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
+{									\
+	_ctx_struct *__ctx = inode->i_private;				\
+									\
+	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
+}									\
+									\
+static const struct file_operations qla_dfs_##_name##_ops = {		\
+	.open           = qla_dfs_##_name##_open,			\
+	.read           = seq_read,					\
+	.llseek         = seq_lseek,					\
+	.release        = single_release,				\
+};

WARNING: macros should not use a trailing semicolon
#87: drivers/scsi/qla2xxx/qla_dfs.c:537:
+#define QLA_DFS_SETUP_RW(_name, _ctx_struct)				\
+static int								\
+qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
+{									\
+	_ctx_struct *__ctx = inode->i_private;				\
+									\
+	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
+}									\
+									\
+static const struct file_operations qla_dfs_##_name##_ops = {		\
+	.open           = qla_dfs_##_name##_open,			\
+	.read           = seq_read,					\
+	.llseek         = seq_lseek,					\
+	.release        = single_release,				\
+	.write		= qla_dfs_##_name##_write,			\
+};

WARNING: debugfs_remove(NULL) is safe and this check is probably not required
#115: drivers/scsi/qla2xxx/qla_dfs.c:565:
+		if (qla_dfs_##_name) {					\
+			debugfs_remove(qla_dfs_##_name);		\

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
