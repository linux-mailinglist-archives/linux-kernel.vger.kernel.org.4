Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674B608DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJVPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:08:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D7103DA4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666451338; x=1697987338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dDLWxE2WLfeO1wu0fmTjstmh2q893zPQi44bFQZY2LE=;
  b=IGz/MpOSQoku7M8Er6D6gjTpHNYTB/aUhSZaGk93+5b2TJsG6z1fqqLh
   NP6EWTD+FN0XjiZNH8+Jx2j7o9bwHgeJOSbfBbSBTtfc/RQ7Cmxwjxhq6
   atbtJmQwEv8jsncHNZwM5due6BEoQ0GBs/33K5MA8QnD3b7EWsCiX8Nim
   0BWYc1yCesbHiruO1XiT3UO3VJopN4UgJ/99YP9EnVRzBxXqaWpbO0CTy
   6oqsRAG3UsbNQyXWcbHhJAMxSDPyaa0w52xut8EZdyUQKKV/UjtRUR3x/
   GpM4ocTx/0sZGwHVa96qHTw/sFTgd5le24MsCeMypEBWI2qtaUQGZYeQZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="393503901"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="393503901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 08:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="735909433"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="735909433"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2022 08:08:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 08:08:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 08:08:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 08:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCqsOmMYjUKbK689QqUjB1q4uRnzb72efnAaydT73qCtCfCdQz4O7z3Slawr+wFCjNOLjBJp/OUtmB73Uym/kBFc3fx12rmxJCDca0Sz/2AxTfAmB0ioVZmXyz1+HEtIfOWiWTw0e6alL0L/DdrOV++VQDAUjUfu3tz00XK3LAjKJHFLvNapxr72ENR72Iv4gwfphEgbqcqBk9z21MDwdyVwr1Bs05AiqF7QxQxsRGNfd++HCl8SUSf5Z5uk8FdQl+FtlP4M5l1sASKDnp570mgW9adxPBAMRb2lkq4NJTEQJtWqT1VNIHyi+oxRhAyI/UpiDsG185+ibpQGt1SYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8b9ivSYqPWqjlYikTWXsN3qIc8TsKVEaS97Y5L4C8w=;
 b=Y6INHqpk3aaan55q/uNNNAcptaJpX/w6RWYisSRMB6JeRFnTEN70OX/N+C1w6vxPy8EYCfor0sp6LPmWB25EpuQSVAMtT2W8rizMptZbI7ghNg6evpgcV3zQfI8brg60PBd6VkOiX07fc3y6kUk+86Xd8rk1l5QiMJBNrBZJjBiQzJ+rwbSiyZyMGn83ty6Bc7GUL6X7UBURU48cNrVy7vK1G9bNVw3KbACQaA/6GqIHmSuiib1wegIPTsm1lExLksRigiRHW1Prto/aRuEJKWKvOSBVwGPP6r95MaAhOFulVNIg+y5Lirn78zjQPrZIHadaZJrUvll7/Gzr4UuhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 15:08:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5723.033; Sat, 22 Oct 2022
 15:08:56 +0000
Date:   Sat, 22 Oct 2022 23:08:33 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <parth@linux.ibm.com>,
        <qais.yousef@arm.com>, <chris.hyser@oracle.com>,
        <valentin.schneider@arm.com>, <patrick.bellasi@matbug.net>,
        <David.Laight@aculab.com>, <pjt@google.com>, <pavel@ucw.cz>,
        <tj@kernel.org>, <qperret@google.com>,
        <tim.c.chen@linux.intel.com>, <joshdon@google.com>, <timj@gnu.org>
Subject: Re: [PATCH v5 4/7] sched/fair: Take into account latency priority at
 wakeup
Message-ID: <Y1QHcZSmKAX2SWgu@chenyu5-mobl1>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220925143908.10846-5-vincent.guittot@linaro.org>
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW3PR11MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cec82c-f599-413f-1f59-08dab43f569a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIzXwYbtpOg7bC2TefzGVselzIGu7nHg3m2oonBod6B56Kj37VUhhrYxtkqWTdc7+JMR6IHyPD/xgaW4nrfePUcPAcJ6BMXai2O9hy6MOe8x/xL3KiWGyYnVFjBrL4WX/uOnYcGgTzsVsh/hIGh/RCNc1U2X0WogAHr3twGJruLVpY+SSBDPx7OpodH8CVjxw7qONm2PPfTO+v+715XI+lqTkOWLVWS5UfRLZwYEfOHDex8Q9D3fpNSz0GDOqInbgN/rbqieah4cVWsr+j9NiYMURi9J9BqV3+MDGqqMI3KuTaDDwrFOF043hUHs1w82QLcAQ7SDr3djM5m7jVfj9HsX53K4uzWyKp0qnLDlul7wGPXP2d62L6AuRXn7PB5wSJ8+oVR5aZlQmXR9oJy3xPyOHuRwjW3WkYrQ9He5/YsKAj+q7ebARtB7jtPS/ko+0ovv6fY7OeIm1atelBG2aWYAkMAQa9jdK8joCo6Bi/svqZgFaCxhna8zjx2t46w0PJV+mF0RacFnpxFoNW4EAL8fLUkxllop83JWX5JGxPTcBCWMbyqdR5JwSnjpvQj6PTmyOHfGPMhEAw++XilRnafLyLSeJutt1vbQrE3NqVjd4qFPKGkCM8p/MxVMtf8GXBMSu/6PKSMC0zDfOZMRAVLRKEMCYC75t+ZwlAZXGnMhzOBMLOX55hIJnvOwim7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(53546011)(6506007)(66946007)(8676002)(4326008)(66556008)(66476007)(186003)(2906002)(26005)(6512007)(41300700001)(9686003)(7416002)(5660300002)(8936002)(478600001)(38100700002)(6486002)(86362001)(316002)(6916009)(33716001)(6666004)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Y5q9CYF9jSbF8+avFvYMjUbmSBUK66ilAqrFwIQpWCiUbF5s7rg4N8IzdN/?=
 =?us-ascii?Q?ntr1thv5+aTXURp6z5qQystN4SKp9Mrc/66B5gf4KrXJ1G5g1HMHlilJl8KT?=
 =?us-ascii?Q?iBkkU4hK144lBm6b5ptf+dzqvEThizkL6ZU55lFh59CIBji4rikWBGKmt/vg?=
 =?us-ascii?Q?LO1FM97tzUoI9r7i9CHR2v1C5/oDs0U4EPTRnCwO/H6rk/fpjD46lm+UGSl5?=
 =?us-ascii?Q?hjrblO9u3RcKjrmKFca1M0thIAtZSYFUlhTPGq+62uoqyRAAgt3numvLjJCM?=
 =?us-ascii?Q?787b8x4iR2WknPrldEQbT0sWcTtwPia7cuPf7bgW6btV6ZeDmlQPVqMcAzq7?=
 =?us-ascii?Q?4TcBwir24I3qeoTtJRpOlxXdI1CA1GpKhlGGgkGGEyfJWKbBTw5X+7m6Ayxv?=
 =?us-ascii?Q?NYw837jxT+iQYZinhLn75dowNsfAqkpgv4MXPzVEmQ86XH0TFxPTnIcjtifF?=
 =?us-ascii?Q?9KBhGPgYy+q2CsQCjudB+FtF8sul+1XhG1urTBeEkkRx1fwB9OzMcoHeBq9P?=
 =?us-ascii?Q?05bq73VhD+VhOzRwshneZ5b7seAQqb+qnKpKD6pzUmHu0F1UFQ8M2y90z0V6?=
 =?us-ascii?Q?HWKjl6CMapdt0qhp7szYbN4xWte2ntmwBDaziB9hLIAXyuJD47YxuZkEcRHT?=
 =?us-ascii?Q?rYSE1zhwXvCL7Vb2vCI6U+nZR9EJiqXG+7cd/+1WeBk8LB/cJzIuY3kavslh?=
 =?us-ascii?Q?3r92lxnRlEuCS5A3+wgIt81XaSaFRit7OKxEtUi3RBQqbJrHWemhdSvSq8MH?=
 =?us-ascii?Q?x4PC6VFnChWY/Yk+wGbG/6bsfLGNCbEaTbqIKb8+e9hWeT5JY0A0jZbmuiuQ?=
 =?us-ascii?Q?uhzPwXY6HkQEDeMY4w9g3PrLhR6uajUhjDPTlwJnQcXoAS5hvPn8aAiQTULy?=
 =?us-ascii?Q?ibkHRAskXRH+9ICapPxKUdTNHLosMcBBTcq1yUZw9zpTrBwd3IBV4by3JeDg?=
 =?us-ascii?Q?GPR3/Y+97BVBa4SfqEzmUclRzxBswV5g7mgcC2eTfe8LcW5xevHKO0lNi6cR?=
 =?us-ascii?Q?pWmxaDQrRP8qy7DkZ536RVaSjjyFmth49+jiCTKFWcNPPPA91Ydm8qmNVAJl?=
 =?us-ascii?Q?LzDxCYuoJ4swJM6Yot9ZFAQMqx8t++qEi7Vm+rWUrDFZ9p2xgzXnsDPvvXpK?=
 =?us-ascii?Q?JCDjMrWFty35U8ujjVsK3JsMmIu3hYjNfmYwnS9fkETsougozt5076UsNgmV?=
 =?us-ascii?Q?qAdNd6izy9RPB6WD8rv9gutWIe8x5shYOOwMAkEgzvtYJkX8P8FLj16kGfN8?=
 =?us-ascii?Q?8I6eHRykXpvuJgeIhK8QywdgQy7+O0KCaKEfZEls2wf5ZYv1gJe9/iuBWAn2?=
 =?us-ascii?Q?4vKp0+kfhmYGYXIF15rCpL2Gr9XX7c95/fHd67yH+mf5fZR4hlljBxzI2vcS?=
 =?us-ascii?Q?qYUk/W4Eli0Pb47NOIRNtRvda1EuJWnKNzaoYmnmG59UZ6Kt2CM6C/vMCDhK?=
 =?us-ascii?Q?B2mwAE93l28p+AhiOlga6D7Pqs5zHttS2GltnGPTabICmzd8HHEJ8xrEV7kl?=
 =?us-ascii?Q?oOeqNHMpheV5jadeA9ITPUCLmWL+nFKEuzPi5ReHR86994JWXlMn75/59t3O?=
 =?us-ascii?Q?Na8TlUPFmzzK3Oq/ss83pqraFCtlqJ6ZHtBiqvJr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cec82c-f599-413f-1f59-08dab43f569a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 15:08:55.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDOglhghSJl5YVhIlH27Xm81x4wU6K7TIS/n8vu8zM+9ahzF4RRiUCb1k6u6CwdiF/vK09XK5fuXl5WRVJ6msw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
On 2022-09-25 at 16:39:05 +0200, Vincent Guittot wrote:
[...]
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> +{
> +	long latency_offset = se->latency_offset;
> +
> +	/*
> +	 * A negative latency offset means that the sched_entity has latency
> +	 * requirement that needs to be evaluated versus other entity.
> +	 * Otherwise, use the latency weight to evaluate how much scheduling
> +	 * delay is acceptable by se.
> +	 */
> +	if ((se->latency_offset < 0) || (curr->latency_offset < 0))
Maybe use latency_offset < 0 directly?
BTW, is it the policy that requires the user to provide a negative
latency nice so as to tell the kernel to compare between two tasks?
Maybe I missed the scenario, I'm thinking of the reason why we used
" || " rather than " && " above. To be more specific, why not comparing
se and curr only when they both have high requirement on latency(negative)?

The benefit of using "||" I'm thinking of is that, if se->latency_offset < 0
and curr->latency_offset > 0, the latency_offset would be even smaller than
se->latency_offset, which will make the preemption easier. And vice verse.

thanks,
Chenyu
> +		latency_offset -= curr->latency_offset;
> +
> +	return latency_offset;
> +}
