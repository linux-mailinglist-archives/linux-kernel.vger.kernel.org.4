Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24A74B8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjGGVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGGVju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:39:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9777A1FEA;
        Fri,  7 Jul 2023 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688765989; x=1720301989;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JVxtDJCtUWjjL1xxoj2ZHlVn1ss2sZzM4Gyi8zuuddI=;
  b=lBwDAmTc6qXFW3rgrHtY1cAJvewplEtv4B8gKdmug7xrQ0+KdSYufsCr
   B91RN068vEShUKPFD9a9m6I97OR2Ga5zlJmlM7BLxAY5C/reiXilDXETo
   q6o5xs1vDfgolM+fvSDhlCtghARr1ROE0b7NttRp7IXMdxxe3pBCjj2kb
   fMSQlYbbTcLOf/m1ujX7AjeaXF2+PAJ89C9mxuq5Q9rRBoSJdV8mWnQ5B
   C9eB024EjqEKbbHMvqVeRW6py2ZZ2VwP0qJbUUOnH5N2qtp//SRf2Oyyj
   SbFCn7Rh9mHqedhFjUAWCD9APgTEZqpBNAhuXVfXhkz/Sg+8HpWowfKbK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353836306"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353836306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="966759810"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="966759810"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2023 14:39:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:39:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:39:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9oNuyhLQVfb+5qkEsL4MLQjG1qctqqjD+3QW2bwUYXI7cUkGHo+dBrCEE4bz+KbP5mpKmo8KQg5Sky9sYZkais+cHKsCF/LXjssENxAAsUBZtj3FOijfcymhU3F2dbkUc0bsS925iJqa8ST5DGserga0syY5Wmei3y7ay/Qms9TVjMZ2Q9dkGPIvPdQGMNq8X1ygbwt71QkhzP3LxGqalpnX0kEhxlO0mW7ITCnkJLYP3XhTAK+HTSyOxZXTl5DsxfDzoyMmmT3GIihIf1s9t0SFPBrVa873ANepcUUUNeQ8j0L6C5UyZci7jsrhLuoqrLAtvr9i6vw5Wz6Jr9eMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6k1bBxQ6BLvgt6QrhGQLWmhYLD1JwGa0d7O65YIax4=;
 b=DDzNWzFBrvdCTZX2jIb2CHuF9UEcBo8guJOtybOrylcPxDUDhgNWmrWPMRcOlH1AAWEPYY8WcmQz3vTrrE6WkeF4PcfTTNQT3+wRD8cLQi92U+aXJlcphh8s5NwkHgjvPDD+du+qCI4PDf0pLAKQEE79lDWTgl4V4j4QISto5svpAqZ2YBi247+OdvoOl93epZFQuw6hvSXGGuQtFerIuaiakwlh59Ir6RZFBYl+sZmXkIeUW6Ay1TM5Zcx1ofSki8+L2XtyN8AgYIo9ryy+LqaoPdkWRqp4v6gOm46uWAFhKIpuFq6zOy3AIwfyTKpkJy9r4Nu89LKZQeTh2aPwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 21:39:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:39:45 +0000
Message-ID: <ca0f3541-5d84-8996-9fc6-b473387d8f35@intel.com>
Date:   Fri, 7 Jul 2023 14:39:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564609148.527584.17320328540832247657.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564609148.527584.17320328540832247657.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c14e39-3cfd-4829-a0e0-08db7f32ae30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiMLepaN/Y10WTAlOvnJO0t6/E1Kks3jw3t/f6yNOkn2eH00QDlBUeiLRP6UwiyHAZcVePyF6kMoXsmKPq8oU2lKjVjg4z7iJX4UcUUFPQ2EuM3nUFoaQKZSls0UMd6I9ilGbfT4Yhhfx4EVgBWfqtkwcY2Yifbn/ifiqIv2PT48IsP0jMczo85BHk4AsCG4c85BT7w0YHG0P+LQz8adHnDzlxqBFGQV61z/6yRB+hhZbcluSjn7I/x/juAWw1C/X/Y0OT4YLm439T07EsXGiJ7U+NfSCYSswyOrJpGTIDRw/bzMLYyuJrXSzBjKVKxQKJjZId7lK8xZVxk1mgkn4XbPDJWyvM9SZmUKxfZ5kLSt1xnluUm+kEyDAgZCW86gZgf5TugGr2umlpYC20bBN1m7j+OWuBaG9VSsCUYUKujH5lNElX7i6IO3we7NKEkvOuuCzq0cjBI4JCChnomigznf4ZC45W68piU5EjqeHmS5O/vCQx2Gy6U/Yi5RKWAp4JEdGQYbeK2K5Bj9VcSha7FmSTqd6tjPPQkrh605LOAkcjkrIdeYmR76e4RZ9gIdQQWo+oqSV4P4cDK1lAr5UHp+Hkvzqf87CcQnISkmakCw1DhAEvBSZcB5LLlJqP50Rxc4GsukggfDvfFeA/qe8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(4326008)(6506007)(66556008)(66946007)(82960400001)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(186003)(44832011)(53546011)(26005)(6512007)(6486002)(7406005)(31686004)(5660300002)(2906002)(7416002)(31696002)(86362001)(36756003)(8936002)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZYTGd1VXdhQTZoR2pES1lqblNVQ0ZTYWhCYmtvRzJkM1kzaC9TWE1TQ0tq?=
 =?utf-8?B?dTA1QlcvOWkzbEJ1b3FnbDBGR1RNMS94SnhRWmh5OXpCclB4VjZUT2toUGpD?=
 =?utf-8?B?T0R5NENUdGFCSXc5K2drOXFhaW5nNlU0ajV6L1F5SUlxYWo5Z2NTUmpWNUZ2?=
 =?utf-8?B?U00ySmI3YVZ4QlRTOUlpZjJJNU9FYlY1NXgzTjk5MFpSTVliRTJoQnowc2VQ?=
 =?utf-8?B?eFlGeWVRY3Z3Y3VPenMrVGVKN0I1ejlxaEJhZ1U4Y3YrcEFmWXJCekhMNUlr?=
 =?utf-8?B?S3RDdnhQU0RxQmRvckZSSllFbkkzdlVHUm84K0p1YjR4NkpqMGRBQ0lkLzg2?=
 =?utf-8?B?NW5STWpUblZXc1FHQ2NTdCtIOFV5cU4xbXVjbnJyVVlzaEI1RXRlWlBJUFNU?=
 =?utf-8?B?MlhWSFVaMHhLdVEyVTliWHR6UW1aT3dmd3V5eVNTaGtwNGZ3Sms0TEVxdU93?=
 =?utf-8?B?VHBBTE9pR0s2T0pLeHNqN3RLNmRKMXpENUVOcGU4V21CMDJkZFhaY09XNnFk?=
 =?utf-8?B?U0hVRHg3VldYUEJ3eE12MUd2VG5YbzZkSDI4cTlldHNMcmVxWVNrQTVOME5Z?=
 =?utf-8?B?ZEtNZHU4TGFOSUt3ekdyZ3JlVGZNNzhPQkxKNXlWS01va2c0ME04R2poM1BH?=
 =?utf-8?B?dVhXcDZIa3JMUmJ0SENKRmZsMFI1dkk4VURWbHZUMVA5RUIyYWc1MnZ1S2xo?=
 =?utf-8?B?dlZ4VlNPaGUxdkRxbklEZEMxZlZCTTAxbS9lWHhzRGZ6aGdEYWhNS1l4NmR4?=
 =?utf-8?B?VkQwQkN4alB5MnFpSmFNZ0NHUzBzb3h2NUM5NVFnMTNDMWszTXBVVDl2VS9O?=
 =?utf-8?B?dStTNUNLa0FvWlZkelJEN3ZqaWw2MnBCczJDSFJtTzZxdkJNUWJtUm9CeGVQ?=
 =?utf-8?B?WjZvTmIwVml3U2VzUzJ1Y3I3NWtJWFhmck1SNjVrK250RUF6eXNSV25QWjls?=
 =?utf-8?B?NzExY3IyMXhndW1mZmhpK1k3dlJrVEZKYkpQWUZhMzRDUGJpSnV0RG1qYmJo?=
 =?utf-8?B?VFNNMURqeFNYZVJaWExmOFdjdmhKWXgwck1QNXUrY2xBaWNjbVRKV0RvclJu?=
 =?utf-8?B?NzdHR1ZqQTgwb0VvWCtlQjlRYlhQcEloMFRrSGFSZVQrTlplc1hnOThuL214?=
 =?utf-8?B?QmtaRkVNNWRTZk5JSUY5dWoxNjc4d08xUmc0YXFmN2lJWG5xVVMrVzNpS3Uy?=
 =?utf-8?B?bFVHQk1meC9pR0JuNHlkM2NGcmQzK01LOVZkeEZjUkdSQ010QWd2d2JremV3?=
 =?utf-8?B?N0ljYlVkMnYvNDJYeERCMGg3czZTM2srL2ZJYks3V0RnNXpXVDBwUnJwY25Q?=
 =?utf-8?B?YkwzR214TGRnVnpBMVNVSU83ZjBDSGU2d1RCdkFxdkhqMnh1dWMxZmg4RkZB?=
 =?utf-8?B?dklGZFI1STIzQ0pDSGgrcDh1Ukl2NHlhQU1sdDN0ZjduN1VMcGpRVll0dWV4?=
 =?utf-8?B?eG0yU1h4Z3M4bjVTTTFpcDlkQ1V1cHVuQzFiZi9MMWNIYWI0aUFWZVZReWxx?=
 =?utf-8?B?NlNiVVIrMk9nRlRhUEtPeXJXQS8vQUNqSmRyUkxneXIwaG5nQWlLeFVEQnpO?=
 =?utf-8?B?aTFERy9nSzhrUC83Vk5Jalp0Ulhvb0xiREduUG9mbG9oWmZMWVhyS1JZaTJr?=
 =?utf-8?B?aytEY3BTd2JmSnFRUmpHR1FJS1NTZ1BvbWo5WERBSG5nV2pUbGttbm9DMC9N?=
 =?utf-8?B?WlA5QjNyM1o3L0xVN2VYakRrektRdldJS1Z5UEF3cnlLVlE5b2dMbnlMeFZo?=
 =?utf-8?B?dk5rdDlJMjdXUmw1SmsyRjFMcldZelZhbkZwcGpMS2NmRk9ObzAxYlJMSUJV?=
 =?utf-8?B?ZnpKWU0rczFiOXJ3L0NoNlVWcUx1RFNUNWtTMnhhV292a1p1TGhmUnhnZWhH?=
 =?utf-8?B?VHh1QndwVFBsRVQrOFpLVDQrWDNtdUJsNncveG1BeG1zMktReUtsQk8wNmFS?=
 =?utf-8?B?eE5SdHcxOXJXSGI1MHF2eW5jb1psM1JaeHJHQXhXYW5Gdkt5eGJJRVZDUmZh?=
 =?utf-8?B?dDVzZDZRenpMS2RGMkFONElWallNUFovWUhvY0p4US9XQjhGTnUyaXNCcDZB?=
 =?utf-8?B?YXVsN0FoRzlOZ2lnRFp3Yndkc1IyeG9DRXRXeVovTEZxMFViU3Q2bEU1dHB6?=
 =?utf-8?B?UGQ0RTA1ckZjNDBMTk5yaW42U1owQkVlSGdTZStZdWZIWVlZMGdiejhiUUJ2?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c14e39-3cfd-4829-a0e0-08db7f32ae30
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:39:45.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LrmPNF/nw8TZtkW29wqGlKmyXMMen6LShWOvPWqZ4bmJGGici/HDW+OorTMtPbsgrUl2MP87HrdcWT1qnykoJpHWoBh+XTv3iRdP8NT3RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:01 PM, Babu Moger wrote:
> resctrl uses RFTYPE flags for creating resctrl directory structure.
> 
> Definitions and directory structures are not documented. Add
> comments to improve the readability and help future additions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |   45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2051179a3b91..c20cd6acb7a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -240,6 +240,51 @@ struct rdtgroup {
>  
>  /*
>   * Define the file type flags for base and info directories.
> + *
> + * RESCTRL filesystem has two main components
> + *   a. info
> + *   b. base
> + *
> + * /sys/fs/resctrl/
> + *     |
> + *     --> info (directory and provides details on control
> + *     |         and monitoring resources)
> + *     |
> + *     --> base (Lists the files and information to interact with control
> + *               or monitor groups. Provides details on default control
> + *               group when filesystem is created. There is no directory
> + *               with name base)
> + *

In the above I think it may help to split the comment into two parts:
(a) which directory/directories are referred to, and (b) which files can be
found in the directory/directories.

For example,

--> info (Top level directory named "info". Contains files that provide
          details on control and monitoring resources.)

--> base (Root directory associated with default resource group as well as
          directories created by user for MON and CTRL groups. Contains
          files to interact with MON and CTRL groups.)

Please feel free to improve.

> + *     info structure
> + *    -------------------------------------------------------------
> + *    --> RFTYPE_INFO
> + *        --> <info> directory
> + *            --> RFTYPE_TOP_INFO
> + *                Files: last_cmd_status
> + *
> + *        --> RFTYPE_MON_INFO
> + *            --> <L3_MON> directory
> + *                 Files: max_threshold_occupancy, mbm_local_bytes_config,
> + *                        mbm_total_bytes_config, mon_features, num_rmids
> + *
> + *        --> RFTYPE_CTRL_INFO
> + *            --> RFTYPE_RES_CACHE
> + *                --> <L2/L3> directory

Maybe a nitpick but I wonder if it should be "L2,L3" to not create impression
that it is either/or?

> + *                     Files: bit_usage, cbm_mask, min_cbm_bits,
> + *                            num_closids, shareable_bits
> + *
> + *            --> RFTYPE_RES_MB
> + *                --> <MB/SMBA> directory

Same here ... perhaps "MB,SMBA"

> + *                     Files: bandwidth_gran, delay_linear, min_bandwidth,
> + *                            num_closids

Missing thread_throttle_mode

> + *
> + *     base structure
> + *     -----------------------------------------------------------
> + *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *         Files: cpus, cpus_list, tasks
> + *
> + *     --> RFTYPE_CTRL_BASE (Files only for CTRL group)
> + *         Files: mode, schemata, size
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> 
> 

I think this is a helpful addition. Thanks for doing this.

Reinette
