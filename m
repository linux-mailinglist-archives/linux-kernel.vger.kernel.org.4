Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30356D8C17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjDFAna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDFAn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:43:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65AA9;
        Wed,  5 Apr 2023 17:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680741806; x=1712277806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WlSsjkhCiNRF+uBvHKcu9YYD7X+sr+rTUE/rvyDHmII=;
  b=T+HICI3Sf3XuTwyjhwtWi/0IWAbTMnbKWfuF6uPGRYScNXk5tqqPppXa
   fKOxvzzzAvs+7aScIss+W9pTiFddPMPQj5JPcGNNStGaDJ3S3CD50LOnY
   9uvhPJaF7MiZKivoW5a9UM9Ub+Q7EApVpIZbptgEmBhFkhlNPKD29N+Jg
   fvxrn90CQiEt2uTE72M2pJI/0smLnD879mXZDWWWOWg3xGY6RU9DQAKyP
   hzcSxGfsq/2kPBTNnfLA8u0V4kKjSFBbcadI7Qy9AXweCkNA/qU/xDrch
   x+k0I65iDWyKPifPIbvKQ0Edoyy8iIk1OstynyckasanoCpAqeDtASYmS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322253650"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="322253650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 17:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830567405"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="830567405"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2023 17:43:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:43:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 17:43:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 17:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9a2mdWCSBnEL1g9o+vbujS3y9MnR2CxcNnfLSB64LoItrrp8s2l1yIqLYEMqK8C/8fJ+rYJOLbVwHgtU+8zkj9LdYdp0UG/i9YMLmDEb6k9AAH1d5ML3/aNo4vGe53In8KBpWYI/6HpdPrp5sFfugv/fXb7S69CAP2vORDVyi5uX5tflbtEPgFukEJRttMqPOyNQihl7hK4O0DO2nQKEiuvw1miDR3fNP7lWTzRQZaqUVlok65ayQVOg35TEVo5v6jIp/MqZxcldaznr6lntgj4HqChITcv4IvIRmBT47sP1vdS7Ab1n8kaTjvht1149czdu4KHvIruLJnSnGj/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRgj21Ya3lR14BuHRl/bVoKm6ZKQXQUvthSV4u9/x0U=;
 b=XgK0QqPopHUDjrdgzTpOmQIODIS3FF4ZD6SYvOalzsLAd1W20o7Rnd8ybQ4ncDI7/pjBZhn9UHIU3Fo2nhKE0z0wGA8eFuyizPzUCZECUSwTENQKjQyjS35HAyq+LJp02Hx7flIEvaOukIBlX0JUU5vxUgTn8AUWSMh7KDb8j1pTpY2TZcdDXJnQQ12PZVFnkalDy1xtDApZ/grFB6UMH1fow6omE0hZPZZEwLSnLP15SAJTa0AnO98Ecn8bBgtQTIqj7ZfF89Zen56vMn2JXaxa7B3tIdnYqLoYKKXu426ITzqjhiXnz5YvlrQojEIy8GyNZ4xA48sJcnWEQzsThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:43:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 00:43:16 +0000
Date:   Wed, 5 Apr 2023 17:43:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: RE: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with
 flexible arrays
Message-ID: <642e15a1ce95b_21a8294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher>
 <14903668.tv2OnDr8pf@kreacher>
 <642e00331b335_29cc294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <642e10dfc46d8_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
 <F03AC35F-764F-45AC-A18E-F9BBBF172D4A@outflux.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <F03AC35F-764F-45AC-A18E-F9BBBF172D4A@outflux.net>
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e5697e-ab35-4b77-4c6a-08db3637e8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+PUB45+AnA9+xVmJAbgEgYXgOor+KZtm5IKdngsrRVFepra2RVJ7rPl0rqc1Qup/tpePUwakXKzLWhiX7iP66irLUAACmX/3As0oip3/AxSJeSuIbRzKmgwVt98TZtjwcQJ9si7s4iap/fsnMjlcUJJfQ4J5MpM2+Hjtnzvr+7UFqj546GG2Mi5NhakqPGN5MZdgJ6Kp/2egFP9j8UrwzGPnH0VYKx4gL9h3g0J24xwXh4PHAIU98ucmhZNT8JQ69tIodKt6cgR9PnxiffhUungePUQ+dmUmxWK/+hQTHgpBS4JMr7FxaPzA+0rKyl0z9BlZ4ehb3JbbzdnGkVbw3gK2Uag3uPXoATU5IHq39fiI5yb1Js1s2uAtP0dbeQNZ8SdHBmi44JXvlPGOBciY9825DVJwLtkXSNuBHYRwdLBU8GC8z3th1WByqEMRvnFnmmCx+NpDcVJdCdtTbsrJ5CibeB3hLZ6hqRiezBCCwCIn4aI+yzcmyz4rCPMT9cYT5nPA2x1bpL5utml0eNjYaCumuh9ZVvkHhQhRN7K6RM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(6486002)(107886003)(966005)(6666004)(66476007)(66946007)(4326008)(9686003)(6512007)(6506007)(8676002)(66556008)(86362001)(2906002)(186003)(478600001)(316002)(82960400001)(110136005)(26005)(41300700001)(54906003)(8936002)(38100700002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PqqAKhKtbn9BVZugLNy8AjJDl42hm8kqrBV+QcrXUr0FnNNh6x2rkJWj8Ban?=
 =?us-ascii?Q?MldhMnXej23sbcGiswEnisNCo3QTSDo+g7wEiQSN3e+F4abjA180BM39pe29?=
 =?us-ascii?Q?KfO+guDevDscoUIRMgqtrDEjLZ4ZNFAhKkz6ww5uS5y9FCtcjGOGhZ664bvd?=
 =?us-ascii?Q?fENaF/yFW9qgZO9EP0eGpMhHWAW8kPbfzuk5NZlO9lc7cbQF88xoEG2aCEFu?=
 =?us-ascii?Q?FVGsRYs6oJW/c1MuMyQg5ZDx3ZE//thl4ozMlq2B0I6SlZqJsUW/cY3KXmjN?=
 =?us-ascii?Q?rru2IGa6B1kgzaF865r0RGTBktX0gy3owO35K4QDkNTV215AglW3TKhKXwju?=
 =?us-ascii?Q?lmJQ0iqpvWWyU04g/OlW/Qirdk6IlPEXX+htUaSnkdQamsJa0dt5lRM1Ah2A?=
 =?us-ascii?Q?kp8uEQr7wk4aC6aDmHDof+BOr/GR8VOcRbi2JIK++tGKYusrcwAkmBsvf4NH?=
 =?us-ascii?Q?SsbtqfRjgdQ7cM5sApkRky4l4YXhcVsAMlBy/vdbRyk9Bbj1z7Aq5wlebtTH?=
 =?us-ascii?Q?BVc/NR9uAytAOQRM+pu5MTXJtXvp120DzUWjyIOdsGTKR5sHYXfybD4JmsHD?=
 =?us-ascii?Q?bxS/erLHh6kj/b0cFuq2kYw4dEubAGts52Jt9ZdenHCSkeG7qOz9Wo5LLGXk?=
 =?us-ascii?Q?IAcX+73pcLBAjXoyMEsVQUwCcxmhubpXUbyoEfbOTCvMm9/H+/oYZzIWlXcX?=
 =?us-ascii?Q?WywdrO9f8AUHPob6qtoMCgFH7JwvVsqOd8Ipj1YdZB94DzaCB4rmeBJlbL+J?=
 =?us-ascii?Q?1m+TLB7DN0d8mT5SDHTJX12B5NCnUy55taLabxT913dZT3QmLC4fTZYmO8vN?=
 =?us-ascii?Q?l+yJZUq+gSe3LfRaoKkAid5QkLdZ7YDiQcHv3bJk66w6oatb0Fx8HUgAc094?=
 =?us-ascii?Q?vjGmonbEgcXcNK0EH3A0sa5fyaH1VRaVdqoq5C4sb9/hTTl+eyDpwMg3jtvG?=
 =?us-ascii?Q?jiHxccLibfFWa296PTK8iSqOSyJIihu59pmBHd3nezBsrW0j7SvN62/3+CDR?=
 =?us-ascii?Q?kzrrx+TrbFeTgBVnghLv8sbblo+MXr5GE2ti/e6MmFKgHyY3IGpNfnIQ6Jqg?=
 =?us-ascii?Q?zM3uP13G3C46wGe+LNEsmwPuHxRdqHPL1ZivkndEQw9UGQFCahGsI3EDv2qq?=
 =?us-ascii?Q?iEzioUecdS32Uip3mKK06Appn0DsAEH16vaeGp/vNekqPVDYFKC9qJcSJYzm?=
 =?us-ascii?Q?0b8XQ71sisc88penXoWqbTaPnTRpg5bvy3I+R7zSKuniKuqUm31xhgyvJHb2?=
 =?us-ascii?Q?ZaMfZpo6RDjuWVI8EYXB8pgOpi+SnUHAVzQDvsyCn4pehqStHk1kNYg/ylJN?=
 =?us-ascii?Q?QeZ0hb0bkRc9WDSWIPT6GSV4kjOIaiCEGeKuT3Y+LjyFNnPpzCQOVtxPB/cF?=
 =?us-ascii?Q?xLLFiIgAeVCmybxX/O/oRuxyfZcZAoiH9Lg2pOUxKHquq/ibVtlqqzz+JqJi?=
 =?us-ascii?Q?DerZc32S1AqgI4lux3K+epDksP9CoZnAmmIa1GMa6cGTOWXLkxdG6udGJJD8?=
 =?us-ascii?Q?5chc+2YF7grhgZR4Rz0cNSbKTSKWFwS1DcRiSB7Pr6bLBoVwzYdwWo8y0xe/?=
 =?us-ascii?Q?3SeKcODH6iJIjNMpW02S08K86Dtxk1vhfReCd2kDPsB9qOiIPZT50VxvJPX1?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e5697e-ab35-4b77-4c6a-08db3637e8c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 00:43:16.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBTp0yCppnq4hBGn3PxE2IoqNL6qLBNSrZPHnvXnKLTFOFvN9VjpQFNPssxzJpCcFGE34zIPbfYeUzXlWFMFGAsqAjldK0SUj9bFgb93ERA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:
> 
> 
> On April 5, 2023 5:22:55 PM PDT, Dan Williams <dan.j.williams@intel.com> wrote:
> >Dan Williams wrote:
> >> Rafael J. Wysocki wrote:
> >> > From: Kees Cook <kees@outflux.net>
> >> > 
> >> > ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264
> >> > 
> >> > Similar to "Replace one-element array with flexible-array", replace the
> >> > 1-element array with a proper flexible array member as defined by C99.
> >> > 
> >> > This allows the code to operate without tripping compile-time and run-
> >> > time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
> >> > and/or -fstrict-flex-arrays=3).
> >> > 
> >> > The sizeof() uses with struct acpi_nfit_flush_address and struct
> >> > acpi_nfit_smbios have been adjusted to drop the open-coded subtraction
> >> > of the trailing single element. The result is no binary differences in
> >> > .text nor .data sections.
> >> > 
> >> > Link: https://github.com/acpica/acpica/commit/44f1af06
> >> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> >> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> 
> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> >Unit tests say NAK, though.
> >
> >This causes a regression, but I think I see where. Will send a fixed
> >patch in a bit.
> 
> Ah, which tests? I must have missed something!

You're doubly forgiven for not running them because 1/ they typically
require setting up a VM, and 2/ they've been broken since v6.3-rc1 due
to where the test modules moved.
