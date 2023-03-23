Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92F6C6119
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCWHsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCWHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:48:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5B9B777;
        Thu, 23 Mar 2023 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679557688; x=1711093688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=95aHD2Qcaog4kfPpqwpWAWs5WSBZuknlH0XEmtzj4aw=;
  b=aD2mmWMbRXcXKlmvprEE+JDkyQROZNaWDu4Lsdb+pL64wkZvpqHOYQyV
   gcB0QbH/xfqP2RMIxeomi7WQv3C62x/m8//2E7InWdEndk2H/oEYj48Ka
   GqFzUdrMUdb0GiIsHdbppX7a5OZzW1qy022BsEF83O7lkwKNVDP8DQgxJ
   xBbZ/lMG+ZDmdmYtJohY2J8d5saTmwwfnMxbttlqhR0QkzrFY+kzgJkOq
   zWJTLt4cuuMfJ8Ped92/hER4s0gUurHGwwc/QXphIq56o7n7x/gkm/TEw
   Ogbnt4Tf0utmcvq1CniLj6E/rrQklMIlJ11OSg08hCnhIHJp6uvJYg0CM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319809789"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="txt'?scan'208";a="319809789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="806161469"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="txt'?scan'208";a="806161469"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2023 00:47:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:47:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:47:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUd9mK00uzbB1vtwu/aVBkoexrCSD+M/vUK3ITrGJKjwNwsBwjnroeFnT92KjZO+4sgosi6M9TK0VurE1IzK2Yc07ZwsnHqRk8/zjzZNQd8hnjOIwFZbyWiH0dLnD0Hy2JwUTresX48lka+TXVkYYxVQyn5x2Y29AKNqaNxB7gtm0n8I8w6w/681joVmmDw6RI1btfTDN7GA70097fXC2YdR+euOaFwzoAick+nSw5uILYXGRSb1VJxmw2dSm88HxVRJGAf6Af6ZSdAiuA+HZRhCNZbpIWHKLWCpLb6pYxwuTk4Klu5Isb/4p+ALVFBYZ5+EolrTwT8yAbmS8dN0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DjENkWw70ibof3vYueVnwID58xsHalbsfay8yMqQH8=;
 b=ELnEjH03FVl1PXFsQy/8vmrxIKe9AAcBrj0VRffWVlN2q9+fedPyTUdFqN/DDC8y+Tnup37ut9QD0nol2Z6I/hAQ+LMkhImEVLudJwR3FoFnb+ul3260trJft3/YoHfy3JYUG34265JziF1yMevpDyRurTHRv46AT+r1xAilALRCewtaVGSHKXR4RBxatGREuub34Q8cx2KwqhdgmBFgrtd9Ev54Uf8bZzlUCWftrq5Rdl3srvQwQm7UFrXN+rpGxn4PrG/mqt6W7tUILVRN9SwCtq+BPJ0cZRyrWN3+jOc5KTm7AnfYWrf+K2iCRLlRIRprViwaWDwXkNJN5dszHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:47:51 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:47:51 +0000
Content-Type: multipart/mixed;
        boundary="------------5L4Q5alA09h5Gw158hgU19xl"
Message-ID: <997614df-10d4-af53-9571-edec36b0e2f3@intel.com>
Date:   Thu, 23 Mar 2023 15:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>
CC:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        <linux-kernel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <regressions@lists.linux.dev>
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com>
 <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1bacbb-5145-4640-b4f6-08db2b72e75c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZXhajIL5er6HrKtg2GPvw/0GzH/nC1/xuh2jNXUKkiDGF8u4iz/wnKpoU+Ej4u/kEWbmYDXvCtnbePDkf1USzJ2nQekiDEdwxX+JR/SyMII+nnERaIQ7henj7q1tVVx0Hq4nK9DwDtJYrlUHjSq2TRQK7EnBuh0hvcgvNoAVj3QRUy4hP/M9ZcB+CFp2BNK7YV5ZUjCxvCYaYmv7NhDN9mcNr7NKM6DRxqt3AMAZPqp+nBwgiXIvlULAYNhub3RYKKwN8lTUhMp9bsMz28dG2F9VaA3S3Rrwn6j6rh2pwgltl9DoZ+P8+phfgkk8vAmS0bCxhUHHqZcwsXonkj0SEj3ZLjTgARLUX7PDnl6fYU3Mxdlus/63ykCtUIzhjQ5ooqAix3IpidufOLy/18LuTXB9zdLrCrvdKU+OqokRcbj3cwZbh/V8YNu5AotrIiRblayv8q4SiQ/Fj7hcSu1UarfIerdkf/gK5KomO5p6dKBmKGU62jlT29xY9LoNT0eZpJDQpSctsWUluSX8/nmOiUOvxYsx9K6Sbc7YBVP9lnYFNwg511QUeyD+enHYFThPGv4ZjJRTD9YYhLUbZuG0BuKtB382tqj8HKNYXiggK9+WP40xvpr9tNe1Y3nwQKfBphgAnF/o9hDxqEMVvxy16QWtrPO8iy8jeARFh5UHl2HYopHjW342EGlPdefR7jOWWMEjVLb+gpIRTzoLtXHst90Koe9vzhckfO21XkDXE3LdQ55R5thgHsknrW0Q13MmJ8Qr2oWsS+znTOr70hnxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(31686004)(6512007)(2616005)(83380400001)(21480400003)(33964004)(26005)(53546011)(478600001)(6666004)(186003)(5660300002)(6506007)(6486002)(966005)(7416002)(316002)(235185007)(38100700002)(31696002)(30864003)(86362001)(82960400001)(8936002)(66476007)(54906003)(41300700001)(66946007)(8676002)(2906002)(66556008)(4326008)(6916009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNwZFdLMW1XdU8rUkorZEJOUitrektoOHZ4RzM5VWdSN3czQmRCbTh6Ri8v?=
 =?utf-8?B?bWxDOWF4Q2VkRkdLc2dqeVBwQWlhWW1PK0V3eUJ2aHZwYzZ0WG5NMzV6cWZo?=
 =?utf-8?B?eHNEcVNLMHpuVDhxUmJwSkw4b3hHNks5aldsVnliK0hwSGxuTE1Wd3p1aTVZ?=
 =?utf-8?B?RWJvRUFhK2toWm5uMkIzcXRHNzJwQ0o5cVphQkoyUTFQMWZCdU5NOHVLa0I1?=
 =?utf-8?B?YnkwVVZxQTdGVkV0NmJsZmtUN2doNi9idkJFbXdBNVo2SlA5SlAxeEhsR29C?=
 =?utf-8?B?NHE5SHlzYzVJMnhpcjI4VVdEZytPVVBNUVVnUTdaYUZ3UnEzd3ZidDZqS0Ft?=
 =?utf-8?B?aWM2c1lkS1pwL0t3Tkh3cmxiWENLbUp2a1JQTFJUUlBxVUJ0K3ZpR2hxVExU?=
 =?utf-8?B?YUZ1ZnhBTm8yc2ZsNTJuajhmQy93dUVFZ3J2d2N5dUVmWE53UjJyQzF4S1JU?=
 =?utf-8?B?dytBVER5dWxRa1ZhaXhhNlVCZFZHRFFRV1dBaEozNEg0azV5THhWRUJYb25m?=
 =?utf-8?B?M3piZkYxcW9MZkdqaGJhTnA1MkpPUERQTGVxTlFzYno3T0pySlcrcTBWcDZD?=
 =?utf-8?B?dk0rYVZvMUVkYndjQndSemRFdk56Y2VqcHNRZnlaQng5MDJIRGJ2VEtkaWpv?=
 =?utf-8?B?ZkMwVno2dUwxelBCeFV6MDUvTTl2VlJ2SDVCTXJjNFNIcm9ySUxFMEZ6TEk5?=
 =?utf-8?B?dTVCbUlqb0xCeHhHRWt6YzN5Q05CbU5IYnpiZUN3UkxzWEpKVWVGNzFRZzZJ?=
 =?utf-8?B?WXh3NVA1cEpYaVlvSmV4UHJ5NUF5ZngvZU1ZR1Fzc3BkeFc3NzdNWUlNcEhJ?=
 =?utf-8?B?ZWpzY3B4c3JRek12T3JMWW9FUldIckczak1vellOSThMeWx2b0pKSnd1bitL?=
 =?utf-8?B?WnF1VldiWWhoWFlCYTNnNnZHY1JBWFhVcHJ0dlptUWdoZExXK3NyMXRzVmkx?=
 =?utf-8?B?T3ExRm5QUld2cVNrTGlyTDJYS05Nak5jclIrUmFnZFVmK2hSNEQ4NGQ0TXB1?=
 =?utf-8?B?bUhFcG80WitLMEg1bGxZc1lwcHVJR3VyMkRmM2pvUlArbmc1UjdrNTJQTy9Y?=
 =?utf-8?B?czBVQ3JRSFY4Ym5yQ21hanJldlkvY1crK3RiVnptTHkvdEZKYXIvSkJrNEx2?=
 =?utf-8?B?aS8zWUFOZEdvTEJiajBiVndSM2Q3a0FtUlcyT1NTMys1WVVxbDVxeThUUEdv?=
 =?utf-8?B?cm5DTW8wTS81aUJKenNYdVZuKzZBbGRvS1dia1JkNjJDNTh5SlhGOGtiOGVL?=
 =?utf-8?B?ZUZWMEZKUXpRTDJZLzN3R1VKcUM2TXU3WDhXUlZydk5OU1FXZWpJbnRJaUsw?=
 =?utf-8?B?UjZMSEIxN0NxV2lZYVhGWm9lVUxrRk5RUC9OR1ZmZmZFRkJMRjdGbnhnTEFU?=
 =?utf-8?B?RkhGblZ1Qy9mbGp5YmIwTFFrL2E1Ly9RQUVacTczeHh1RkMvalZZWm1MM1pB?=
 =?utf-8?B?T0psVDBjQ29jSmxXMVgza1c2MjVtRlNvSCtHNC80LzVwTFl3Z29DYmJZOHJp?=
 =?utf-8?B?Mk5tTC9YbG1CaHpKOU5hcUJmWCtaSEFXSlRFaGlicEhHY1hWOFFmZml6WFh0?=
 =?utf-8?B?MTRaSXd5SlBGLzYzUkhlaUtxV1U2cTFURFRKRkhJMUNqYmtGNld3K0hxRWVI?=
 =?utf-8?B?UStrajVvSXEydU9HZC9wOTF3cHY3TnZjUHpaUXdvcEhSMjJiZ1FIUWw5cDR4?=
 =?utf-8?B?d05CVzcrY2pwVm91WVQ1YXRNRVZMazIxYldkRGdYV1dzbjdsVVZxSlljdGI5?=
 =?utf-8?B?djIvZTJjSVI5TVZ1cEVtS2ExY1pZNVJBZnh2SlplRGl0Y2xOL25ybkluQ1JU?=
 =?utf-8?B?dGNjUVE0YkRxNzFValN5NklwWGpUZThqTmFSRk9LZmhlcTdJOVZmYks0OGJX?=
 =?utf-8?B?QVRZSGdtbzR5RkswK0xxRzZ6aktvMHNpbHZGSEFUVVFTMG9sZE9WeHJadFJW?=
 =?utf-8?B?aXRIVG1aSFZQd1E3OEZpWDM3NWZPQ0xoWnF5eUlucDNoTUlWWVZscDRuNWsz?=
 =?utf-8?B?Y0M3K013QkdxSjBWQjNheUdBc1Z5NFlLQkdudkc2YnFqS24rK1p0b3pvUUF3?=
 =?utf-8?B?cW5rMzZkR3YweWZuSGJhWExKanphQ3Qrc0xpRXdOR2ZVUWs5SVVLVVliSk1M?=
 =?utf-8?B?a1RCZGJEVjJSSzVtM2tLOHY0K2NZU3ZDRTFIT3Y4TlN1MTB4RTBSUDhNREk4?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1bacbb-5145-4640-b4f6-08db2b72e75c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 07:47:51.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE0MfWEaw+YtIgzcPWtEOXWXKNDxi8Dh9Xqo2B9X6D/k1wby+2hHRWYXqAArGWUrstcPUhjriYeowe0grLDd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------5L4Q5alA09h5Gw158hgU19xl
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 3/15/23 22:26, Steve French wrote:
> Can you verify what this perf looks like with "closetime=0" and "closetime=1"
> 
> Are there differences in /proc/fs/cifs/Stats when you run the same
> steps with "closetimeo=1" vs. the more recent default (5 seconds)?
The dump of /proc/fs/cifs/Stats are attached. You can tell which
closetimeo is used from the file name. Thanks.


Regards
Yin, Fengwei

> 
> On Wed, Mar 15, 2023 at 2:46 AM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 8/26/2022 10:41 AM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to commit:
>>>
>>>
>>> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred close timeout to be configurable")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: filebench
>>> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz (Cascade Lake) with 128G memory
>>> with following parameters:
>>>
>>>      disk: 1HDD
>>>      fs: ext4
>>>      fs2: cifs
>>>      test: filemicro_delete.f
>>>      cpufreq_governor: performance
>>>      ucode: 0x5003302
>> Please note, we still could see this regresion on v6.3-rc2. And the regression is related with
>> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit changed the default timeout
>> value from 1s to 5s. If change the timeout back to 1s as following:
>>
>> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
>> index 6d13f8207e96..6b930fb0c4bd 100644
>> --- a/fs/cifs/fs_context.c
>> +++ b/fs/cifs/fs_context.c
>> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>>
>>          ctx->acregmax = CIFS_DEF_ACTIMEO;
>>          ctx->acdirmax = CIFS_DEF_ACTIMEO;
>> -       ctx->closetimeo = SMB3_DEF_DCLOSETIMEO;
>> +       ctx->closetimeo = CIFS_DEF_ACTIMEO;
>>
>>          /* Most clients set timeout to 0, allows server to use its default */
>>          ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
>>
>> The regression is gone:
>> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be08f
>> ---------------- --------------------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>>             |             |             |             |             |
>>             :25           0%            :3           33%           1:3     last_state.booting
>>             :25           0%            :3           33%           1:3     last_state.is_incomplete_run
>>           %stddev     %change         %stddev     %change         %stddev
>>               \          |                \          |                \
>>      515.95           -50.0%     257.98            -0.0%     515.92        filebench.sum_operations/s
>>        5.04 ±  7%    +833.7%      47.09 ±  2%      -2.9%       4.90 ±  2%  filebench.sum_time_ms/op
>>       10438          -100.0%       0.33 ±141%    -100.0%       0.50 ±100%  filebench.time.major_page_faults
>>      167575            -4.1%     160660            -4.4%     160140        filebench.time.maximum_resident_set_size
>>        7138 ± 11%    +141.4%      17235 ±  3%    +147.6%      17677        filebench.time.minor_page_faults
>>       28.68 ±  9%    +199.9%      86.00 ±  7%      -2.4%      28.00        filebench.time.percent_of_cpu_this_job_got
>>     2453485 ± 54%     -63.0%     907380           -66.2%     830273 ±  6%  cpuidle..usage
>>        0.61 ± 38%      +0.8        1.41 ±  3%      +0.2        0.80 ±  4%  mpstat.cpu.all.sys%
>>      142984 ± 13%     -45.6%      77725           -47.5%      75106        vmstat.system.in
>>       34.23 ±  7%     +27.9%      43.79           +27.8%      43.74        boot-time.boot
>>       17.09 ± 11%     +66.0%      28.38           +65.5%      28.28        boot-time.dhcp
>>        2661 ±  7%     +37.5%       3659           +37.2%       3651        boot-time.idle
>>      104737 ±185%     -87.8%      12762 ± 10%     -89.8%      10631 ±  4%  turbostat.C1
>>
>>
>> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the timeout to 1s. Thanks.
>>
>> Regards
>> Yin, Fengwei
>>
>>
>>>
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>>>    gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
>>>
>>> commit:
>>>    dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get from open_cached_dir")
>>>    5efdd9122e ("smb3: allow deferred close timeout to be configurable")
>>>
>>> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
>>> ---------------- ---------------------------
>>>           %stddev     %change         %stddev
>>>               \          |                \
>>>      515.95           -50.0%     257.98        filebench.sum_operations/s
>>>        4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>>>       29.00 ±  8%    +212.1%      90.50 ±  3%  filebench.time.percent_of_cpu_this_job_got
>>>       24629            +2.7%      25297        filebench.time.voluntary_context_switches
>>>   7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>>>        2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>>>     1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>>>        2.00           -50.0%       1.00        vmstat.procs.b
>>>       21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>>>        3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>>>        0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>>>        0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>>>       34.55 ± 14%     -34.8%      22.51 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.avg
>>>      119.64 ±  3%     -20.0%      95.69 ± 17%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>>        5249           +15.8%       6076        meminfo.Active
>>>        3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>>>        1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>>>       69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>>>       72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>>>       23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>>>       74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>>>       81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>>>       23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>>>       17983            +2.3%      18400        proc-vmstat.nr_mapped
>>>        7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>>>       26888            +1.6%      27306        proc-vmstat.nr_slab_reclaimable
>>>       47220            +3.4%      48803        proc-vmstat.nr_slab_unreclaimable
>>>      966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_zone_active_anon
>>>       81133            +6.0%      85973        proc-vmstat.nr_zone_inactive_anon
>>>       18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_zone_inactive_file
>>>      361460            +2.5%     370454        proc-vmstat.numa_hit
>>>      946.67           +18.6%       1122        proc-vmstat.pgactivate
>>>      361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>>>      187906            +4.7%     196761        proc-vmstat.pgfault
>>>        8189            +2.5%       8395        proc-vmstat.pgreuse
>>>   1.097e+09           +15.5%  1.267e+09 ±  7%  perf-stat.i.branch-instructions
>>>    39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>>>     5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>>>       29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>>>   7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>>>        1877 ± 15%     +75.1%       3287 ± 12%  perf-stat.i.cycles-between-cache-misses
>>>     1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>>>        2898 ±  3%     +34.4%       3895 ±  7%  perf-stat.i.instructions-per-iTLB-miss
>>>        1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>>>        0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>>>       48.47 ± 11%      +8.4       56.83 ±  7%  perf-stat.i.node-store-miss-rate%
>>>      283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>>>        3.57 ±  7%      -1.1        2.44 ±  6%  perf-stat.overall.branch-miss-rate%
>>>        1508 ±  3%     +39.8%       2108 ±  9%  perf-stat.overall.cycles-between-cache-misses
>>>        3022 ±  3%     +23.6%       3736 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>>>   9.585e+08           +18.8%  1.138e+09 ±  6%  perf-stat.ps.branch-instructions
>>>    34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>>>     4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>>>       25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>>>       77139            +2.5%      79105        perf-stat.ps.cpu-clock
>>>   6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>>>    1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>>>     1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>>>   4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>>>        1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>>>      247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>>>       77139            +2.5%      79105        perf-stat.ps.task-clock
>>>   3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.calltrace.cycles-pp.getdents64
>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>>>        6.25 ±107%      -6.2        0.00        perf-profile.calltrace.cycles-pp.open64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>        6.26 ±115%      -5.4        0.88 ±223%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>>>        3.38 ±103%      -3.4        0.00        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>>>        8.51 ± 91%      -6.9        1.59 ±223%  perf-profile.children.cycles-pp.getdents64
>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>>>        8.34 ± 83%      -6.7        1.67 ±141%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>>>        6.25 ±107%      -6.2        0.00        perf-profile.children.cycles-pp.open64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.__x64_sys_getdents64
>>>        7.63 ± 84%      -6.0        1.59 ±223%  perf-profile.children.cycles-pp.iterate_dir
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>>>        6.26 ±115%      -4.6        1.67 ±141%  perf-profile.children.cycles-pp.get_signal
>>>        4.57 ± 73%      -3.8        0.76 ±223%  perf-profile.children.cycles-pp.perf_mmap__read_head
>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_vmas
>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.unmap_page_range
>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pmd_range
>>>        3.38 ±103%      -3.4        0.00        perf-profile.children.cycles-pp.zap_pte_range
>>>        8.54 ± 43%      +8.6       17.19 ± 38%  perf-profile.children.cycles-pp.asm_exc_page_fault
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>>          sudo bin/lkp run generated-yaml-file
>>>
>>>          # if come across any failure that blocks the test,
>>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
>>>
>>> #regzbot introduced: 5efdd9122e
>>>
>>>
> 
> 
> 

--------------5L4Q5alA09h5Gw158hgU19xl
Content-Type: text/plain; charset="UTF-8"; name="cifs_stats_timeo1s.txt"
Content-Disposition: attachment; filename="cifs_stats_timeo1s.txt"
Content-Transfer-Encoding: base64

UmVzb3VyY2VzIGluIHVzZQpDSUZTIFNlc3Npb246IDEKU2hhcmUgKHVuaXF1ZSBtb3VudCB0YXJn
ZXRzKTogMgpTTUIgUmVxdWVzdC9SZXNwb25zZSBCdWZmZXI6IDEgUG9vbCBzaXplOiA1ClNNQiBT
bWFsbCBSZXEvUmVzcCBCdWZmZXI6IDEgUG9vbCBzaXplOiAzMApUb3RhbCBMYXJnZSAxNzcgU21h
bGwgNTkwODMgQWxsb2NhdGlvbnMKT3BlcmF0aW9ucyAoTUlEcyk6IDAKCjAgc2Vzc2lvbiAwIHNo
YXJlIHJlY29ubmVjdHMKVG90YWwgdmZzIG9wZXJhdGlvbnM6IDIxNjY0IG1heGltdW0gYXQgb25l
IHRpbWU6IDI3OAoKTWF4IHJlcXVlc3RzIGluIGZsaWdodDogMjk0ClRvdGFsIHRpbWUgc3BlbnQg
cHJvY2Vzc2luZyBieSBjb21tYW5kLiBUaW1lIHVuaXRzIGFyZSBqaWZmaWVzICgxMDAwIHBlciBz
ZWNvbmQpCiAgU01CMyBDTUQJTnVtYmVyCVRvdGFsIFRpbWUJRmFzdGVzdAlTbG93ZXN0CiAgLS0t
LS0tLS0JLS0tLS0tCS0tLS0tLS0tLS0JLS0tLS0tLQktLS0tLS0tCiAgMAkJMQkyNQkJMjUJMjUK
ICAxCQkyCTEJCTAJMQogIDIJCTAJMAkJMAkwCiAgMwkJMgkxCQkwCTEKICA0CQkwCTAJCTAJMAog
IDUJCTExNTM4CTI5ODMxCQkwCTM4CiAgNgkJMTE1MzgJNTk1MzAJCTAJMzgKICA3CQkwCTAJCTAJ
MAogIDgJCTAJMAkJMAkwCiAgOQkJNTAwMAkyODEwOAkJMAkzNwogIDEwCQkwCTAJCTAJMAogIDEx
CQkyCTAJCTAJMAogIDEyCQkwCTAJCTAJMAogIDEzCQkwCTAJCTAJMAogIDE0CQkxODcJODUJCTAJ
MgogIDE1CQkwCTAJCTAJMAogIDE2CQkxMjk3CTkyMQkJMAkzNwogIDE3CQk2MgkyNgkJMAkxMgog
IDE4CQkwCTAJCTAJMAoKMSkgXFxsb2NhbGhvc3RcZnMKU01CczogMjk2MjQKQnl0ZXMgcmVhZDog
MCAgQnl0ZXMgd3JpdHRlbjogODE5MjAwMDAKT3BlbiBmaWxlczogMCB0b3RhbCAobG9jYWwpLCAw
IG9wZW4gb24gc2VydmVyClRyZWVDb25uZWN0czogMSB0b3RhbCAwIGZhaWxlZApUcmVlRGlzY29u
bmVjdHM6IDAgdG90YWwgMCBmYWlsZWQKQ3JlYXRlczogMTE1MzggdG90YWwgMCBmYWlsZWQKQ2xv
c2VzOiAxMTUzOCB0b3RhbCAwIGZhaWxlZApGbHVzaGVzOiAwIHRvdGFsIDAgZmFpbGVkClJlYWRz
OiAwIHRvdGFsIDAgZmFpbGVkCldyaXRlczogNTAwMCB0b3RhbCAwIGZhaWxlZApMb2NrczogMCB0
b3RhbCAwIGZhaWxlZApJT0NUTHM6IDEgdG90YWwgMSBmYWlsZWQKUXVlcnlEaXJlY3Rvcmllczog
MTg3IHRvdGFsIDAgZmFpbGVkCkNoYW5nZU5vdGlmaWVzOiAwIHRvdGFsIDAgZmFpbGVkClF1ZXJ5
SW5mb3M6IDEyOTcgdG90YWwgMCBmYWlsZWQKU2V0SW5mb3M6IDYyIHRvdGFsIDAgZmFpbGVkCk9w
bG9ja0JyZWFrczogMCBzZW50IDAgZmFpbGVkCg==

--------------5L4Q5alA09h5Gw158hgU19xl
Content-Type: text/plain; charset="UTF-8"; name="cifs_stats_timeo5s.txt"
Content-Disposition: attachment; filename="cifs_stats_timeo5s.txt"
Content-Transfer-Encoding: base64

UmVzb3VyY2VzIGluIHVzZQpDSUZTIFNlc3Npb246IDEKU2hhcmUgKHVuaXF1ZSBtb3VudCB0YXJn
ZXRzKTogMgpTTUIgUmVxdWVzdC9SZXNwb25zZSBCdWZmZXI6IDEgUG9vbCBzaXplOiA1ClNNQiBT
bWFsbCBSZXEvUmVzcCBCdWZmZXI6IDEgUG9vbCBzaXplOiAzMApUb3RhbCBMYXJnZSAxNzcgU21h
bGwgNTcyMzUgQWxsb2NhdGlvbnMKT3BlcmF0aW9ucyAoTUlEcyk6IDAKCjAgc2Vzc2lvbiAwIHNo
YXJlIHJlY29ubmVjdHMKVG90YWwgdmZzIG9wZXJhdGlvbnM6IDIxMzU2IG1heGltdW0gYXQgb25l
IHRpbWU6IDExNDMKCk1heCByZXF1ZXN0cyBpbiBmbGlnaHQ6IDExNDMKVG90YWwgdGltZSBzcGVu
dCBwcm9jZXNzaW5nIGJ5IGNvbW1hbmQuIFRpbWUgdW5pdHMgYXJlIGppZmZpZXMgKDEwMDAgcGVy
IHNlY29uZCkKICBTTUIzIENNRAlOdW1iZXIJVG90YWwgVGltZQlGYXN0ZXN0CVNsb3dlc3QKICAt
LS0tLS0tLQktLS0tLS0JLS0tLS0tLS0tLQktLS0tLS0tCS0tLS0tLS0KICAwCQkxCTI1CQkyNQky
NQogIDEJCTIJMQkJMAkxCiAgMgkJMAkwCQkwCTAKICAzCQkyCTAJCTAJMAogIDQJCTAJMAkJMAkw
CiAgNQkJMTEyMzAJMjcxODAJCTAJNTAKICA2CQkxMTIzMAkxMDY5MjEJCTAJNjYKICA3CQkwCTAJ
CTAJMAogIDgJCTAJMAkJMAkwCiAgOQkJNTAwMAkyNTEwNgkJMAk0MQogIDEwCQkwCTAJCTAJMAog
IDExCQkyCTAJCTAJMAogIDEyCQkwCTAJCTAJMAogIDEzCQkwCTAJCTAJMAogIDE0CQkxODcJNjcJ
CTAJMgogIDE1CQkwCTAJCTAJMAogIDE2CQk5ODkJNjE3CQkwCTEwCiAgMTcJCTYyCTkJCTAJMQog
IDE4CQkwCTAJCTAJMAoKMSkgXFxsb2NhbGhvc3RcZnMKU01CczogMjg3MDAKQnl0ZXMgcmVhZDog
MCAgQnl0ZXMgd3JpdHRlbjogODE5MjAwMDAKT3BlbiBmaWxlczogMCB0b3RhbCAobG9jYWwpLCAw
IG9wZW4gb24gc2VydmVyClRyZWVDb25uZWN0czogMSB0b3RhbCAwIGZhaWxlZApUcmVlRGlzY29u
bmVjdHM6IDAgdG90YWwgMCBmYWlsZWQKQ3JlYXRlczogMTEyMzAgdG90YWwgMCBmYWlsZWQKQ2xv
c2VzOiAxMTIzMCB0b3RhbCAwIGZhaWxlZApGbHVzaGVzOiAwIHRvdGFsIDAgZmFpbGVkClJlYWRz
OiAwIHRvdGFsIDAgZmFpbGVkCldyaXRlczogNTAwMCB0b3RhbCAwIGZhaWxlZApMb2NrczogMCB0
b3RhbCAwIGZhaWxlZApJT0NUTHM6IDEgdG90YWwgMSBmYWlsZWQKUXVlcnlEaXJlY3Rvcmllczog
MTg3IHRvdGFsIDAgZmFpbGVkCkNoYW5nZU5vdGlmaWVzOiAwIHRvdGFsIDAgZmFpbGVkClF1ZXJ5
SW5mb3M6IDk4OSB0b3RhbCAwIGZhaWxlZApTZXRJbmZvczogNjIgdG90YWwgMCBmYWlsZWQKT3Bs
b2NrQnJlYWtzOiAwIHNlbnQgMCBmYWlsZWQK

--------------5L4Q5alA09h5Gw158hgU19xl--
