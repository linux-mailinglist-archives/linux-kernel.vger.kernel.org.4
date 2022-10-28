Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6501610AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJ1GtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ1Gsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:48:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F345773B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666939513; x=1698475513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tmLKN7HCptzQHQvscT0FeeUUtfHbSOLw5oXbG/nqt0A=;
  b=fCoIV7V4WmQSaTRKZEbfJ+zZYfdjR+jiAclK3PCAZTU/i4Q7LLmsDvQA
   ok9I58ZAwCDd5QWiS/7wpGUyMkfMyTKSNfmoQa2x5aUbXjhc2W6BV/nn9
   zHAB2p0xC7FUcAbM0sw3UmtXSfliwr33ebH8oJw5fRYlNR+D1PZAgmQB6
   cLbS1hL8DHxp7n+X2V/Qemv7iI6meT0tOoGXUbFMS/hOunFl1G77/KRGm
   2GBeSAERPHnyzXG62Q6iOA7uT/dJrg6/BNoqH0jxD2iZ2rZuy7xwxY7aW
   JcTFlGjVD9GPy+3SeW3uttCvwuG2QehJRDsAMk1wOrLKGnbnhaiorwD/c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308414926"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="308414926"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="757984458"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="757984458"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2022 23:44:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 23:44:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 23:44:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 23:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS2TzJI7YOqJ/3GfAbHPbI9oZyEPgQ6ZdeTbNGMUWGlNjP44dOPdBDyFcghn6F6p9NjxkSkIUxZ3kVxTepdIhBq9NCQqqKUj8GV9u/I+PdUa6IfmuhjkkRUbMKmAPo/+u62I4qaWEdTOB4F8uBLKVlk4hlclBw2ty1EhkvGHlykXxIptFw12Lm8sRS/WXakYG4gkBAzSFK6qgGLzdOrtvLDg3AlNtu7L/zpiw1xIuffbAfaHomMM/WA9B8ZXsbC7yeRjq1A7fWy44NShvAO1QNsMLvpx8aiDQmpAmLKEUHQTaj5kV2dN8e1AFt39ppzgKdsVpWXWdTjNVe6EHpA4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMg9aFpdfUVtUbjeb+WKh7ZCShh5FAU/qllK0QaBBYY=;
 b=IP8XbCdD9EMZIPTh+VWM0jTA6izFYN35Lu8JK15XGkbutMPW+805N+fWAViuG84SqUaR1D12KniEx7wem/3R9mJu/54F3O+O33fAty40ISRf82pCqO4yjfq9MCjn5CtbVhqfLvqspU1v1RG/MyA6zpqlWEg2pATpEEyb4H8rw82ZGHwSAarPj2bS+lLckeOkr8IGzWevB44OQQ8e4DHojrFei6A3Vci9EnHUDPaDTeHyYs673zsUwNOBVjTtHITspKYs/Kvh52Pgr9eB6bCnFN2hyJMGiLnGdegH1MBqBl2QLWWKhjs696/HLr9cu/IDrMWPB/JdPoN7pPyk5eYv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 06:44:31 +0000
Received: from CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::4ec5:eced:e4:7706]) by CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::4ec5:eced:e4:7706%6]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 06:44:31 +0000
Message-ID: <c1c548f8-71a8-0d4d-d591-58a0cd5dac20@intel.com>
Date:   Fri, 28 Oct 2022 09:43:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/i915/hwmon: Fix a build error used with clang
 compiler
Content-Language: en-US
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <anshuman.gupta@intel.com>, <intel-gfx@lists.freedesktop.org>,
        <llvm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com>
 <87mt9kppb6.wl-ashutosh.dixit@intel.com> <Y1ercgaqQwfqt42U@ashyti-mobl2.lan>
 <87ilk7pwrw.wl-ashutosh.dixit@intel.com> <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
 <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com>
 <877d0lxl6s.wl-ashutosh.dixit@intel.com>
 <CAKwvOdmVJn8HvfF9WTnOAc+HsdJ4c1Tdck8E7Caky7AoCq4ZTA@mail.gmail.com>
 <875yg5xgkp.wl-ashutosh.dixit@intel.com>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <875yg5xgkp.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0360.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::36) To CH0PR11MB5409.namprd11.prod.outlook.com
 (2603:10b6:610:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5409:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2831b1-445c-4625-c5a9-08dab8afde08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3STTHiRmctZCvQYPbk+V59pFc5tA1gNqRuzxkmV8SU5RSweR2VZbJTkYN+3gxKm8juvaJG6Ed5qw41LH8Y/VCessrbHK0mBf/ef7cTJ7OPT/3mrhuIcKtAS+mhVzgKJ0cQGe1xe4XjKjvejRqb+lz+5i0FzPKRP6eLalZvJeBniWq4DS+zrrnVJsHpGjcatm1ytrorCTsHKBMILIplruCH8DC8ipvOoN0aXwXoVl6JyhIELdQR/CTzMQHWXWujsgjNmOpk/1b5Jp6bnKKRuSjmF8uivUiWAro4doTPZCSQs8bFCAssQ3UXxf2BwZ9lSZk73it3x/3M/3I4EdGJmoT7U22drTrywm6QSXJmCkHasjVTPugqA7+D7qDo+Y1s2dMbD5znL50rTQjuIVsXXDaDnpmPl8HzUP019EqlG3PAluTkV8AH9to+qfl+y4sk0pPbixfQVULUD8IOYrnaAyxmB66NmafgYcq773zTEuUYVMJUR+WoOR9WPeTOrnccMURDQkdH6u8twRkRq/WVulRjFqKh+O+ZC2gOxq/GmSj20V9KVtHJH3IvpUF/0+5mXjaPvnxt5AmrofAcikHd60RMvwIgVXnM4JbxpKh634kIzAocKm7PHGb3hbIWtWDdHoP3uYXzJW+WcS7cZdMqTu2130ucgiE+ZXF9gjGaYu6gOyKaVRRLiRS/kpaxNP86UJAt5gyKjGy/hfG3ojtZdptNtl+k4yfKQgeTbhMDGbSl9QwiqZzru0alxJexeyWE92sg8I3E1HW5RzkUNGi2Vt9DQ2nNdSInoUcPOjGFzNy9dczjSdU1ehsg5fLPfM5YxxwFczS/h5QqZQaGoMV6sYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5409.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(82960400001)(110136005)(316002)(54906003)(8936002)(41300700001)(8676002)(5660300002)(4326008)(66946007)(30864003)(66556008)(66476007)(6486002)(478600001)(966005)(186003)(86362001)(26005)(6512007)(2616005)(31696002)(6666004)(53546011)(6506007)(83380400001)(38100700002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZDNHNxUGdseUZwSFdZam11WCtOSS81TGw3UWQ3a0dGK0FoRnp3Rloweks5?=
 =?utf-8?B?bkVYVVZkcFdsWmwrQlV6VzF0TTlaK1R0UEozQ1lvUXZaWWdDMjYvVEFmcXRs?=
 =?utf-8?B?VjJBdnJtTEpBbHpHRzZjVmVOTmRmcERJbGx4WHY3Sm9kMlRIdGVKcjY3aUQ0?=
 =?utf-8?B?dUI2SC9JdmQvNUNxTGJOQnVIMGFmUGhSaFNISnBTNGM5V2lyNlZPN3V3Yml3?=
 =?utf-8?B?K2k0KzV4RlFEbHJxRlg2MkE3NWFNNFRvVVlNRzlBdlMwOUdtR1ltamhKNi9z?=
 =?utf-8?B?NkZUcFB6aUlHWUxacVhzTytSMFRldjNWc0hURWlFeWZFSjZheitGdFpaeEIz?=
 =?utf-8?B?OVFVNjJMckpsa1h0anplcmlkb0grQ2FGRTNNMlRJUlVjb2JDVGt0NldCeWFQ?=
 =?utf-8?B?UFZleDhZL3VSemdQNFgwQ2VVY0RISmhvWkVsUG10SFFHTnBMK3JHWUVaQjhU?=
 =?utf-8?B?SVdMVW1IZW5tNER4aEZVL1V3dE1JV1FJZzRDUUJ3ZVZ1SFNVZDBvL1hzWlU3?=
 =?utf-8?B?TkJVLzNYV0liWHo5Mm1wNDVpaUV4d3FTYkxUL2V1QjZpaVlid3NLeGhvYU1M?=
 =?utf-8?B?dzNLWE9KT2lsU1lIL01GOVhDeG9qcjg4R21XVUoxNzVXMEdVSDVzQ3dnYzg2?=
 =?utf-8?B?YVN4cENnVDBSb2Y3SENCUDhVdFBkMHk2U25OcktBRXhWd29RVjNDd2twcmll?=
 =?utf-8?B?MWZMU2dnTFpIUVpHdjJxbmwwVmN6Q1FhbnJLT2IyaWpqVTQwOERrK0FvY2xl?=
 =?utf-8?B?ZzY1UTVFSlB1VGJDRU0vbDlqOXo5Q3pjMXIrWHhzUkYwd3dUcFpYVnBHTzg5?=
 =?utf-8?B?QzJ4KzBnZ1BNV1lRaVNpcFkyRk5hZjZtWUlBaFhldE9QcEJyU3p0K1lUNXpE?=
 =?utf-8?B?Qnhsa1JBOWlicEtuTzBCem4yTUJzVUc4c0hDbHJPdnBWT25kZzY2b3lwc0xm?=
 =?utf-8?B?eU80ZE13ZTVRV0E1Qlhvd1BLQ09jUDc0MHNYc0lMUDRZZjNDaUNRNVpnZVZL?=
 =?utf-8?B?eGtGWjVOMTVUQTdGNlJvTUpOdStHMTZWS2x4Z0xoZHUvblUwbFlkNEdnZEhP?=
 =?utf-8?B?SFJ1VmJMaGMyOUlPYzVwdTN3bjQvb3c2dTdMUXZzMlgxOTB6OWdWOTIvT2du?=
 =?utf-8?B?SzkyZ1lmaCs3MzRFZXVaUXhaYTdYZ2l3UWY4TEhqangwb2ZtMGFFVUhpUkJV?=
 =?utf-8?B?V2xtblFaQTBOdThLUXhPc2tkemtEU081VnZ3S0ErdGhJTyswbUx2bC85ZzdN?=
 =?utf-8?B?cFVab2xZYWdlUjNUdWFUR3dCZWpJa0t6QVFBM1EzcFE4Nmtya2FoSWxEbm83?=
 =?utf-8?B?Tm0vMkQ1Y3FiYldSbm14emkxWTlnN3FEaHN2aVphMkErVDQ5NFhnb2hyQzZL?=
 =?utf-8?B?UzZqaFNRTHp0Q2RMK0VlV3EvOTdjbkRRd1REa1E0eVJhV3lQMmtHaGZYQ0Uv?=
 =?utf-8?B?MVpoRFVGNmlKdTNGV2k5K0VYZmZVdjNGNzdSZnBUN3VIbXU4QWd4OXdnRE1y?=
 =?utf-8?B?N24yOExVOW5RRnZ0Z0ViUVRKLzdnaHJiMHV6clltWDRsQm5zZ0FmR3p0WjRO?=
 =?utf-8?B?eWtBUEZGTm52YkZKTkprcXY5L0gyOGRqZXh6ak0rOHBPTXg5MThIZms5WG5x?=
 =?utf-8?B?UWJQWFM5WSttOEJJOURxQXROaFljN2lGdTJNYk4ycStVVlo5ZWQ1N01MOWM5?=
 =?utf-8?B?NHZEOGNITjhhMjNPd0RYOEtuQ1RjVk5nMzVldGhTQ2dRb2VjMVdiUGpPZ1pq?=
 =?utf-8?B?M0FCbm9oNE5wUmdITXlIK3B0c0VKeVpjcVNYRmRwRVQrSHhUK21XWlYwWTJH?=
 =?utf-8?B?ZG54M3hVVDJYQWpmU3RrNHRYUmdOL3RGRGQ3ZmM1b3VkSUhmYm03OUZ5bUNP?=
 =?utf-8?B?Z25SSEkvbmw5SjZZWVZOOHNSU29xbnlHMFo2RFBHZERvMGVidFYzR2pqWGpK?=
 =?utf-8?B?SjQrMWhkZStma3ZjVWNab3hTOWppWHMvVlU5TUVaNHR0SXZ1MEEyaVZKOUUr?=
 =?utf-8?B?VWVkZnRFWDB5MHk3b3hGc0Qvc21NQ2VVS053djdDdnJPNHRJWDY0TTRVNkZL?=
 =?utf-8?B?Rmx0dXhyc3VoNThOVkFZRnljY2JFUmRKZG9Ldk5HQ3d4NERXbmVobGw0bTdC?=
 =?utf-8?B?YnV0MzBxQWRzalYzVjhKaDYybkJpZFpBdXk2clVMSm1BRDErSUx4d0NVWm9R?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2831b1-445c-4625-c5a9-08dab8afde08
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5409.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 06:44:31.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sob57srwQLdI2DjoX0tNIGFb3oM9tbU4oA0W7PxGrCnKxLC3jFRhf5nvJc2XYgYavDez/gOQxJypsigyCb2rsAeA5YWGsm3BbZSz5XESW3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, because some content was accidentally omitted from the previous 
reply.
Please ignore the previous email.

Hi all,

I should have written the original commit message more accurately, but 
it seems that it was written inaccurately.

If the FIELD_PREP macro is expanded, the following macros are used.

#define FIELD_PREP(_mask, _val)						\
	({								\
		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
	})


#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
	({								\
		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
				 _pfx "mask is not constant");		\
		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
				 _pfx "value too large for the field"); \
		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
				 __bf_cast_unsigned(_reg, ~0ull),	\
				 _pfx "type of reg too small for mask"); \
		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
					      (1ULL << __bf_shf(_mask))); \
	})

Among them, a build error is generated by the lower part of the 
__BF_FIELD_CHECK() macro.

		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
				 __bf_cast_unsigned(_reg, ~0ull),	\
				 _pfx "type of reg too small for mask"); \


Here, if you apply an argument to this macro, it will look like the 
following.

__bf_cast_unsigned(field_msk, field_msk) > __bf_cast_unsigned(0ULL, ~0ull)

The result is always false because an unsigned int value of type 
field_msk is not always greater than the maximum value of unsigned long 
long .
So, a build error occurs due to the following part of the clang compiler 
option.

[-Werror,-Wtautological-constant-out-of-range-compare]

You can simply override this warning in Clang by adding the build option 
below, but this seems like a bad attempt

i915/Makefile
CFLAGS_i915_hwmon.o += -Wno-tautological-constant-out-of-range-compare

The easiest way to solve this is to use a constant value, not a 
variable, as an argument to FIELD_PREP.

And since the REG_FIELD_PREP() macro suggested by Jani requires a const 
expression as the first argument, it cannot be changed with this macro 
alone in the existing code, it must be changed to input a constant value 
as shown below.

diff --git a/drivers/gpu/drm/i915/i915_hwmon.c 
b/drivers/gpu/drm/i915/i915_hwmon.c
index 08c921421a5f..abb3a194c548 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat, 
i915_reg_t rgadr,

  static void
  hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
-                         const u32 field_msk, int nshift,
+                         int nshift,
                           unsigned int scale_factor, long lval)
  {
         u32 nval;
@@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata *ddat, 
i915_reg_t rgadr,
         /* Computation in 64-bits to avoid overflow. Round to nearest. */
         nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);

-       bits_to_clear = field_msk;
-       bits_to_set = REG_FIELD_PREP(field_msk, nval);
+       bits_to_clear = PKG_PWR_LIM_1;
+       bits_to_set = REG_FIELD_PREP(PKG_PWR_LIM_1, nval);

         hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
                                             bits_to_clear, bits_to_set);
@@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32 attr, 
int chan, long val)
         case hwmon_power_max:
                 hwm_field_scale_and_write(ddat,
                                           hwmon->rg.pkg_rapl_limit,
-                                         PKG_PWR_LIM_1,
                                           hwmon->scl_shift_power,
                                           SF_POWER, val);
                 return 0;



In addition, if there is no build problem regardless of the size of the 
type as the first argument in FIELD_PREP, it is possible through the 
following modification.
(Since this modification modifies include/linux/bitfield.h , I will send 
it as a separate patch.
   )

However, it seems that we need to have Jani's confirm whether it is okay 
to use FIELD_PREP() instead of REG_FIELD_PREP() which is forced to u32 
return type in i915.

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c9be1657f03d..6e96799b6f38 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -9,7 +9,7 @@

  #include <linux/build_bug.h>
  #include <asm/byteorder.h>
-
+#include <linux/overflow.h>
  /*
   * Bitfield access macros
   *
@@ -69,7 +69,7 @@
                                  ~((_mask) >> __bf_shf(_mask)) & (_val) 
: 0, \
                                  _pfx "value too large for the field"); \
                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
-                                __bf_cast_unsigned(_reg, ~0ull),       \
+                                __bf_cast_unsigned(_reg, 
type_max(__unsigned_scalar_typeof(_reg))),    \
                                  _pfx "type of reg too small for mask"); \
                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
                                               (1ULL << __bf_shf(_mask))); \
@@ -84,7 +84,7 @@
   */
  #define FIELD_MAX(_mask)                                               \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");     \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), 
type_min(__unsigned_scalar_typeof(_mask)), "FIELD_MAX: ");   \
                 (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
         })

@@ -97,7 +97,7 @@
   */
  #define FIELD_FIT(_mask, _val)                                         \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), 
type_min(__unsigned_scalar_typeof(_val)), "FIELD_FIT: ");    \
                 !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
         })

@@ -111,7 +111,7 @@
   */
  #define FIELD_PREP(_mask, _val) 
          \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), _val, "FIELD_PREP: ");       \
                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         })

@@ -125,7 +125,7 @@
   */
  #define FIELD_GET(_mask, _reg)                                         \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
+               __BF_FIELD_CHECK(_mask, _reg, 
type_min(__unsigned_scalar_typeof(_reg)), "FIELD_GET: "); \
                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         })


Br,

G.G.

On 10/27/22 9:32 PM, Dixit, Ashutosh wrote:
> On Thu, 27 Oct 2022 10:16:47 -0700, Nick Desaulniers wrote:
>>
> 
> Hi Nick,
> 
>> Thanks, I can repro now.
>>
>> I haven't detangled the macro soup, but I noticed:
>>
>> 1. FIELD_PREP is defined in include/linux/bitfield.h which has the
>> following comment:
>>   18  * Mask must be a compilation time constant.
> 
> I had comments about this here:
> 
> https://lore.kernel.org/intel-gfx/87ilk7pwrw.wl-ashutosh.dixit@intel.com/
> 
> The relevant part being:
> 
> ---- {quote} ----
>>>> ./include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
>>>>                  BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> 
> So clang seems to break here at this line in __BF_FIELD_CHECK (note ~0ull
> also occurs here):
> 
> 		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
> 				 __bf_cast_unsigned(_reg, ~0ull),	\
> 				 _pfx "type of reg too small for mask"); \
> 
> So it goes through previous checks including the "mask is not constant"
> check. As Nick Desaulniers mentions "__builtin_constant_p is evaluated
> after most optimizations have run" so by that time both compilers (gcc and
> clang) have figured out that even though _mask is coming in as function
> argument it is really the constant below:
> 
> #define   PKG_PWR_LIM_1		REG_GENMASK(14, 0)
> 
> But it is not clear why clang chokes on this "type of reg too small for
> mask" check (and gcc doesn't) since everything is u32.
> ---- {end quote} ----
> 
>>
>> 2. hwm_field_scale_and_write only has one callsite.
>>
>> The following patch works:
> 
> If we need to fix it at our end yes we can come up with one of these
> patches. But we were hoping someone from clang/llvm can comment about the
> "type of reg too small for mask" stuff. If this is something which needs to
> be fixed in clang/llvm we probably don't want to hide the issue.
> 
>>
>> ```
>> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
>> b/drivers/gpu/drm/i915/i915_hwmon.c
>> index 9e9781493025..6ac29d90b92a 100644
>> --- a/drivers/gpu/drm/i915/i915_hwmon.c
>> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
>> @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
>> i915_reg_t rgadr,
>>
>>   static void
>>   hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
>> -                         u32 field_msk, int nshift,
>> +                         int nshift,
>>                            unsigned int scale_factor, long lval)
>>   {
>>          u32 nval;
>> @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata
>> *ddat, i915_reg_t rgadr,
>>          /* Computation in 64-bits to avoid overflow. Round to nearest. */
>>          nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);
>>
>> -       bits_to_clear = field_msk;
>> -       bits_to_set = FIELD_PREP(field_msk, nval);
>> +       bits_to_clear = PKG_PWR_LIM_1;
>> +       bits_to_set = FIELD_PREP(PKG_PWR_LIM_1, nval);
>>
>>          hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
>>                                              bits_to_clear, bits_to_set);
>> @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32
>> attr, int chan, long val)
>>          case hwmon_power_max:
>>                  hwm_field_scale_and_write(ddat,
>>                                            hwmon->rg.pkg_rapl_limit,
>> -                                         PKG_PWR_LIM_1,
>>                                            hwmon->scl_shift_power,
>>                                            SF_POWER, val);
>>                  return 0;
>> ```
>> Though I'm not sure if you're planning to add further callsites of
>> hwm_field_scale_and_write with different field_masks?
> 
> I have reasons for keeping it this way, it's there in the link above if you
> are interested.
> 
>>
>> Alternatively, (without the above diff),
>>
>> ```
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index c9be1657f03d..6f40f12bcf89 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -8,6 +8,7 @@
>>   #define _LINUX_BITFIELD_H
>>
>>   #include <linux/build_bug.h>
>> +#include <linux/const.h>
>>   #include <asm/byteorder.h>
>>
>>   /*
>> @@ -62,7 +63,7 @@
>>
>>   #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
>>          ({                                                              \
>> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>> +               BUILD_BUG_ON_MSG(!__is_constexpr(_mask),                \
>>                                   _pfx "mask is not constant");          \
>>                  BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
>>                  BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>> ```
>> will produce:
>> error: call to __compiletime_assert_407 declared with 'error'
>> attribute: FIELD_PREP: mask is not constant
>>
>> I haven't tested if that change is also feasible (on top of fixing
>> this specific instance), but I think it might help avoid more of these
>> subtleties wrt. __builtin_constant_p that depende heavily on compiler,
>> compiler version, optimization level.
> 
> Not disagreeing, can do something here if needed.
> 
> Thanks.
> --
> Ashutosh
