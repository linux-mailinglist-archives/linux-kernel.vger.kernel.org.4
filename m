Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB796FB833
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEHUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEHUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:16:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E4E44;
        Mon,  8 May 2023 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683576968; x=1715112968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ctCmlpD7x7JJyvf9349qJVVapEHgckh+soNzGwPgizc=;
  b=KhITDvyP5fN+3kninXkZavPq9f2nRr5IpTN6dVq9vgO+K689svXo7KXc
   IPL7BMlNDgKz7+4kgF1BYhEupEx+uPp+lOFfcbgUQ53BSbANQX0luG8Bz
   Cy0q+w827Q5dvsdRJ0d/oozSklOY0SP3MAztRpYjq+/8Ben60pl8w/L2G
   xJUyyreq4w1sa2yI/9dlikNgnFh55yfwGhlde0JptY1O/aPFKbT5Vd6Qn
   PHSMPwYASrkeGnDQaAoSoT563SVrXJnFABlpryRGjlaUB6z+qY3tDQbT4
   Kvu4PsNrbNj/smyat3VRGMV7cZ2OY6p4nm+T4TIk8NQ3XBja22jJ8eQZ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330108167"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330108167"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701553546"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="701553546"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 13:16:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 13:16:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 13:16:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 13:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZDMIg4QsPcrovyDwHUY86S9VvHnDEJ22d2WQ5idZDvBmaBtyxkgDCCti+FEY1pg7m65jtihgT+RMvrUFZMSPtLzfRwggVWRJYOVhQG3ri+21xonLo+iyZZhK/X4Y5B5iu0d7Tn+Ev8IatkEFjiAgG5pzTPihGya8CrdYWaHyzNKzFBKnHHOl893ssjQvV/BCryk1/qoXGknOypKlyr8FhoVIEsxYbKhelLGqTwVL9hoUFyfEjKKKEZkIOvimqBQW8ADHq7GRl28wwNJ1o7tfhDJdm7Yo8X+5KClHfQg3DWFbddl9uL+IX+LJqrcxl+seMpH7BfKI3NUvwf10tm16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7BCM/4DJsw1UMRd3ZrOY1ui2LF7prWcl/6AN6S4GtA=;
 b=QSM4QoF7cZmg8fnbGV2tZnSP33IVI5onvA7s+SSD3dNAUV59FAsb55UwyTG8STDYUF78LkhmG1wpEsuy88+TxMCtmm+mGio7srIl/h8Qw5A7ExqHPhidNwANwYKblJhH6GPiib+0CvKqYmAOMM5rImlfbeuX2hb3YMkNN+LQePx7zC/Xm4hewZFkDSNiTcuzD76eDiuY6PrKlU8dptmdv5JlPtdf3tZo+dCkfiDpYO/Rqb4kbYIbPMVgskIJjw9UeUh4Ljv2zEFkDvS/5LbQWzDSGELzT0N125gwlsPW8ZHewe28vuPZiJ7Hct8EOhN0KRTxX2vFlj5Kq2mG2Iji3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 20:16:02 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 20:16:01 +0000
Message-ID: <ac5de854-d274-92ab-a0fa-9a0e738a68fa@intel.com>
Date:   Mon, 8 May 2023 13:15:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Content-Language: en-US
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "gmazyland@gmail.com" <gmazyland@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com>
 <MW5PR84MB184225DA6EA0FA7A9191C057AB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <MW5PR84MB184225DA6EA0FA7A9191C057AB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4baf35-66c9-43f3-53bd-08db50010b17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmyaWzxbE9BjlmjFqMq65/tl6UKgcgUvBbyGEEvbjnON1MSjfAtlDUjsaQFVkudrVRXqP00wpX3h/HjcZQSrksIsxgkjrJC4Ycxjw/5LqT2WA0jUi+7HFo/6y4nXHFQ6xbKZSzWAs60mjpRKsNdYvyQR1WErbEIYiySAGEWd3rDmd+qCS+cmSvBS1HSYOUbpHOZFdsm17gsb9SnrJTVpDeiwihuzox1fv2sBNYnLX/G+Fp/ybizDBoWMahIxEQntTpIqMuA4n+L222WFaULc+NCrWzksiU96d3BKIzJUVqxWBs1ipcxYJA+ZuLNbwvHhg1lPhYVn3kt/P6rZbc5iOvpJZC8FxEI/8tFkgmHm5fA7/UidOFkA9nh7X4PwwBh1SaOWJ75RtHjyokXo4fIyU595CNxXKWOzt3tPq2REXIgamOgrpc2DlQdS+DAJJXd6tVSK3le5C27QtovUwNES8UT0Jeh01Ot3XzN+nqQHEQepfn91xh/5PPAhwtJUwB04GSHlVj5xDS0Nk7ddRVu8WeEPRA5U/2mD83e2ZJSRF24rr+AEC/N9Mf6BAPwvATcAKAXvv+Ac4MtAyAp/IrfDReBIzssKUx7+Hzw0pgCpaK3QnE1au35p3q2mBMFEdv5wUbPyk1lXDcyOf+0VuoScrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(31696002)(86362001)(66556008)(36756003)(296002)(110136005)(54906003)(4326008)(316002)(478600001)(66476007)(66946007)(6486002)(8676002)(5660300002)(41300700001)(8936002)(7416002)(2906002)(186003)(38100700002)(82960400001)(26005)(6512007)(6506007)(53546011)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1Y1RHo5YXVoUGRZMmE0bmhXdmE4TmtHaEd1Q3F5MDRIUVgxaXB4UmdieWV3?=
 =?utf-8?B?TmtBR3dPOExsRzgxVGVibzJLWGN3TkRya0lyOXJjSG1DV1ZsZ0MzbjhMYTFX?=
 =?utf-8?B?S21Zb05mRHMwZEo5QzV3dVY4ekN3cHNQN1lkQjJUaHB5UEc1YXJZSDhUQmd3?=
 =?utf-8?B?UXQ1dTlVM2dheFV0M2g5TTVPdG9EQkQ2MWswWG9NZnJpYU40WXBaS1RmNFNH?=
 =?utf-8?B?OURLc2RUSXZSZ2wvNUF6Y2xqL3VRc3BCcGhJRng5K0VRSGVlUmZFN0VuSUNM?=
 =?utf-8?B?akYwSzA3bm9HalJ3VUVGbTlkK1VyR1VCdHNYakhZV051MXBSUTdjVE9TOXlp?=
 =?utf-8?B?NkxXWWdhWWtEcmpOaVl1bWQrcGlod2daV1U3SWNSbTNmVGk3dStDcHFlaTlJ?=
 =?utf-8?B?NElUc2xjTmNPcCtacEhJUlhCMnVkd2NvUDBYU2lsQlNlNFB4Q0Q3L0p0bE5l?=
 =?utf-8?B?RTh0VXluTG1wN2NaTW5uQVVyRTJTdzJqZ2ZrS3BsSklLZnNEcHNrdnNtTjZC?=
 =?utf-8?B?b3hFRi93U2ZFUjN3c2VxeWJOZGlQN25WSWpjQUVTUWdCaCtHeFJ1MGdrOFBG?=
 =?utf-8?B?Q1FNN3JRRnVic0toWWZ6cDB0NC9JcXZsTmRlUjRHOGtGVDBDNy90dXFKR3pO?=
 =?utf-8?B?eUFTcko2a2NXZS9lUWlaNHFVSkw0eVI1WUhmcmVtTjBpK0lYQlU3aUdOcVVy?=
 =?utf-8?B?THJGWmdjV3dJRkxqa3Uzam9zc204ZDQ1OW84QWVPejN3RzRMOUJyNEdJWDlq?=
 =?utf-8?B?eCtmTTlnb2NTbkRta2sraUt2RDBmMVBENXBTOEEvMlgvNDNqVmc0VDBMOGZh?=
 =?utf-8?B?bFdNWFFSQlZRdG41eDJYZ0xKUUtBdDMyZWV0Q2hBZkJtNXhPMFJ0VmNpZXlE?=
 =?utf-8?B?dEV6dDVMWEdJQXJESEs1MzlCUUJ5S09OWVMvTEhCdGVRbWxINS9PcVRNMEZU?=
 =?utf-8?B?Qjdka3RjUkt4TjJldlg3MU1CaWtwKzZtOU15dzdhVEt6SVR5VHFtZHlBV0p3?=
 =?utf-8?B?WXM5TU14eGc1cnhsbFQwZXptWVhIR3F4UXg4ZThVemxnZjZNWTJpVUNsQ21G?=
 =?utf-8?B?TWEzVzVVNytGdW9kcHYxeUZqNDUxendmMVJteCtXRlJ3dU9QTWVUZDNyRitR?=
 =?utf-8?B?VkcrTzVjVzJBZTYwcWE4eVkrR1VSMEN0M2l6Rlk2M0l2bitESEhxZGFFdGdF?=
 =?utf-8?B?NkJPZUJnRm14OEEybDRZZkxINmhnc0F2QUpWMlRXb20yTkRveE9Cd21CQ0Nj?=
 =?utf-8?B?T1plOGJwVW81ZU05MElBeUdXQlN1SWdzUUxZWUFwOFVaWmcxZGhKajd3c2My?=
 =?utf-8?B?SEhEaTZ0THhPM0g1YlViMmJlYXUrQWJkZVZBeXoxZm9IL0RKMElYeDRmbkd6?=
 =?utf-8?B?bUwwRFhhaVNJVyt0OCtCa05FUEtiM0FpTXJsNElEcDFaWmZQUE1zZXJPWWdW?=
 =?utf-8?B?MkRpc3Q3Ujg4Y1h3TFN0MkpodWI1UDRaUTZ4cXNQUnRYSkxIcFF3dElKRGhU?=
 =?utf-8?B?bjNOMFQrM3VhWkZsZ0Z4RE5iV29Qcy9Bd0tMODhWQ29TRFFacnJ1cWYrSlV5?=
 =?utf-8?B?NnptLzMvZU1YTzE4N3NXZ21WRDlpdlBENDF2blRhSG1mS0VETG1TTXpUTk0y?=
 =?utf-8?B?bm9DaW5BNEZ3UUhkWG1XTUdKTXhvZ0p2aGdoQ1ExVytOZFBRMW5xWC9iUmR1?=
 =?utf-8?B?b29mNzNQcXZMcWtEUkFQeDRxSzd5Z1ZnWGpxbmxmR3Q5dHZ0b2xYQ1daL3lM?=
 =?utf-8?B?SVplR1ZSbFhadkFjY0NXQVJKYWZKMlBOenFJNUJCb0JORkxhN2pnWmlJVDJ2?=
 =?utf-8?B?S1NmNVl2YlFlRGVMQXlXWVlSS1d2OEQvaEZ0b01iVkluQWJwQW5Rbm1DZEpq?=
 =?utf-8?B?YkpMQU5OUVBielF5NktkSXlGang3bUYybStLWjZzS1hXQnRVejJxM2x4VkVM?=
 =?utf-8?B?ZER2SVFKSnZ0cVRXVHFRK0ViNitONCswNTlpZlk1VVFTWjhEUHZxdjBkbWRG?=
 =?utf-8?B?Q2tta3Q0NGJpakJvVFRlcWlydytLdS8xUlR4T2JrK3FMbUFYbGlhblNScThh?=
 =?utf-8?B?L0dSNmxjRGNtTjdIOWk0NlV1cG1iVkEwWWRoVzFKQ1hibHJwQ25US21PZTVj?=
 =?utf-8?B?RElCK3NCN2ZoY2tKSkdHV1JaL25XNzhwVjh0Z0huSWpCYzY3R3M3VnlWVU1i?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4baf35-66c9-43f3-53bd-08db50010b17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 20:16:01.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/zXW3EWrEDFirrgcxz0qceLaiwo3XK/4bmtEDE5IT50E+Vif86oUyNP/Z5jGk/cJMPelqTZYoOvmh2FNJ99xO8thdXsAxPiUqy7UnZDtb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 12:18 PM, Elliott, Robert (Servers) wrote:
> 
>> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> ...
>> +void __init destroy_keylocker_data(void)
>> +{
>> +     memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
>> +}
> 
> That's a special value for garbage collected keyring keys assigned
> a keytype of ".dead". memzero() or memzero_explicit() might be better
> for this use case.
memzero() looks to be the same as memset() in x86:

$ git grep memzero arch/x86/ | grep define
arch/x86/boot/compressed/misc.c:#define memzero(s, n)   memset((s), 0, (n))

Instead, memzero_explicit() looks to be about the right call here:

/**
  * memzero_explicit - Fill a region of memory (e.g. sensitive
  *		      keying data) with 0s.
  ...
  * Note: usually using memset() is just fine (!), but in cases
  * where clearing out _local_ data at the end of a scope is
  * necessary, memzero_explicit() should be used instead in
  * order to prevent the compiler from optimising away zeroing.
  ...

Then,

void __init destroy_keylocker_data(void)
{
	memzero_explicit(&kl_setup.key, sizeof(kl_setup.key));
}

Thanks,
Chang
