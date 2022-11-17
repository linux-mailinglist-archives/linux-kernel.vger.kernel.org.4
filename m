Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D721762E161
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiKQQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiKQQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:18:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7B74ABA;
        Thu, 17 Nov 2022 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668701935; x=1700237935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TF8SQ0saTFfyCKTkKPdEWfBzDhP2Bruhri6HOs3aYXU=;
  b=Rni9vDMoxrZJ6SLkpYF3W0IrbTfPkMP45p3YNigMzyNU7ti2io9WBYfn
   SKk69JBc7lTr+KcbCgPa+YzCWf4GuesOm14otgqPta5DDBVEXBHGyPo1s
   uTaqJh6649AU4QsSfFY0Mf82/gDhgBOwRozOKkiBdzu2tpM41/mEeo0z9
   EJSbqUvpVOu9d/pWocx95drUt5Gb7XPvV2d/hVrB6woaVyzhj2FnnPeSP
   /M5PcIm4uPo6stZWYFpLcZsjZhFhu1f+nZQApPMLPOS6qOXKhSZMFRLT6
   f8KoTrvp5zEau61LloQGwsb7INAOcmgynKtoszQGpIkZVDwUkgF9rj5pY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310525403"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="310525403"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 08:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703387717"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="703387717"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 08:18:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 08:18:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 08:18:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 08:18:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZzjf6DafteeyJ8UkjcOqy/4XoKM22JXaiVYybCpFzDm2jnQmmjGEjLBjLtmBC042MqVcCknjlpzobC7YjBsRYjxc20gVp4VrkiHbc9LgnGOq2LBlLJyshTHvjWlNYa36vaS0ngBF4ea2UkrtnxkuJX2VuDl2a15iF6KdLv/HjBRgxJvOmmdQIo5x8dkFC4ydUWmO3rN+XmM8RDcD/I6kcSFBnhl3qXOv+l+zGrxLe6W/DXs4IF5+h5puQ53kVsHpuRd2xCBh1CIMIttZlC9R/XF0/4zrmftEtLDO96nFlofTxK2Zo9xfwdpfGm3UpbUquZIe9m5gnyiiWobsMTZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp9C6iJraBW6M1UoPZWn7T8ErQ71HUtKKKxeU4IleAU=;
 b=OgZxbPbc45uLcIcGjpA4JJ5NBeHuoS1v/vGcfTglKxPCuQIHpSRgwImPGlhMCDKcU1KbPAx3BoUFtOte9UGq/MYi9Yz/rRUCLVdjHh6QVXN/ToERLJdbrmO2ClBRfE8fn8glGOaCMqIaO4QIz8XL6N3fmnlCFZMjoM4x4WTMwnVj9qmEF6yQqXICWn2eXr6d4eZv4CmS/xsYiOk/HnE6RJhM6y3tQZD7WoPeNZc4lF6vbdFOsZc9ZXmlfl941XwV8XHGMACehoCOeGjrP7xv6agdGSC7Ul0SlS6bm6Pn1YiVu0zl+rH9GuTz92/Rp1l86lQEGeFbJGJlp+qzy8ODTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 16:18:27 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d909:216c:b14e:826a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 16:18:27 +0000
Message-ID: <8600edf0-28fa-b700-932b-3de5ce3fe965@intel.com>
Date:   Thu, 17 Nov 2022 17:18:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221117122904.6759427e@canb.auug.org.au>
Content-Language: en-US
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20221117122904.6759427e@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DM6PR11MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 03610353-d353-4096-06e0-08dac8b75aec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BC2GzXLKA9ww7SZGWNiMHNVL8I2TytReNlsaphggIh2rQcmqR1yM8MPF4d/oShd7QMbDOuZFdpURF6j/wczvVkSjRGWMokqECJc43WBaKAldZlwSPudosY+L2UGIkLIgcCiqpTAOO1E3g1iK0cHs9HFw67vP4fmYwYurlKDiEvME9SnMoirFD5xrvWAF1ePE5ZwWWGfJO5xxsR2loQtcV7cwCf9TkacfP8NqlF2FdX9Nk9WhziVhQ1eZeWjIZlMtUC4q0cE0ZeJlMrK0UUoNNzknZgToCNgbwqW4YNZ/upjW/H4DJjlMCVsHdrqfjMmzV/CpgiJRrKcqsNoYkSb702hEsmH4Eplutri86vkZ0N5QLpeo6qvUGhMPdhyOIBpLn0h6IQnQJ//Y3wIXAgX7gaIfGLGZqQ77u1tUWvuzGrA3OLdY/vuadJBSGzdiB+2Qo96xSKz5Axcu2yAEq/PU5/+rep/cFVklsSVzhUP6MqntkOH1JwxgKMPTMRGfd4oE5JNlerX9k47DK+gFstHjC0ASsjDRDXk4Ymkt3hmyJr4xCwW+iBn06TN/2x9jXV3yEYdoWtBY3JTXirscmQss44prPz4Y93Ge9RgEcbgm/5KJ5YvMvAGUl5wL4RKPg44Sj9hQFUeCNl8MzWmcVBt2lWcNnD8SckX0t02wauwrGYN3k+YmpXCR+gCRi66YnqYJEOTn2DluFqnybwZ5cKqqJ7mmzFqXOax2XIJpBD8i4I0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(83380400001)(86362001)(31696002)(4326008)(41300700001)(66946007)(66556008)(2616005)(66476007)(8676002)(36756003)(186003)(8936002)(6666004)(478600001)(36916002)(26005)(6486002)(316002)(6506007)(54906003)(53546011)(5660300002)(82960400001)(6512007)(38100700002)(110136005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Yxc1pkOENPOWJDVlhpUXJpeUxJa0l3OHl1SVFGQmlHYlZWY1FtTmNScHN6?=
 =?utf-8?B?QlpkRWRCU09abEM0SERCOVdLYWtyZ1FXSFJNTXNJTEl2SXhFSmxJSjgvRW5z?=
 =?utf-8?B?QWRLSXNCb3UzY3lNbGVMS3pHN1dadEFPZnhFcy9hSzczTzZhMTRTOXhRdWxm?=
 =?utf-8?B?a3JDR3NhSWhhZ2k2UHBONFRwZllNNW8rcFp1M2YvZjlCbDlKYjhsNk40dDZs?=
 =?utf-8?B?a3FSRCttcDlUazUvYUlXcGllQlZZTkduWG9RS2JQOXBMbmdhYXBrZEpSZW1p?=
 =?utf-8?B?K2ZZU1pkb0xEYUNwbWtDU2hpT0dKMVp5aUo3RzIrMWRrdGM4Q2o0K1VITklL?=
 =?utf-8?B?SCs1UG9teG9YWGpPNnZyNmRYaG81N1o4UE4rWll1RWhvVXN1bTV2alNBTG9P?=
 =?utf-8?B?S3dHaWcrY2MyR1B5NzZyU2l6QjZsVjV4b1hnQit6OGY2YXVXaytROTU1SXhW?=
 =?utf-8?B?aE1BVWpuYU1xdWZBb0U3VHUzSmlrQlQzOWUzK1dzK0dkRGl3YUJ6Mk11elJ0?=
 =?utf-8?B?WG9GM3dCMDJOUjNGejF4T2dscHo3dzJRZG9uZndZYVhtdDEvNTVyeHcrcjRk?=
 =?utf-8?B?RjNHWk1YNU1XdHZtaDJ5S2ozSE9EVlFrbUtLc25pdkVXU01NeDdQMHpZQXl4?=
 =?utf-8?B?cTRvcWc0dUF0MWRqdWhLMVNNRnNsbU9nZ2NjYnBzTCt5cGx6UUxBUldmcjNC?=
 =?utf-8?B?M3IvalhTSUN6TExqNHc0ZW9WdjNscUltcjRiK1FLZlR3cjRWNjdjZk5GdW5z?=
 =?utf-8?B?cHIzNlpoek9ZWnVuZFFkN2hVeCtLdEFZYU1POVZqeFBSUW0ralpzVytETnpv?=
 =?utf-8?B?azJGaXJtT0NtNWs0bHFoc2Q4dTZVQnJyNkdMVGZDM2tBZW4yR0Nld0NhdFBM?=
 =?utf-8?B?TVBSemtMVmlIaUx1SXovZXBBdDFHeENadFZKQXNVa1VOSEJ2akVyVnN5a0hV?=
 =?utf-8?B?MnJMOFBsaytycG9DZWFhb0wrbGxzN3VlZCtZQm5aaVdMcElUYnZBVXBOTnBx?=
 =?utf-8?B?UUp2MnlEQlpXZUdZN1Y5d3N2UXZvUVF6ZVdxNTFqWVYzam55QkVxZHVZRkhD?=
 =?utf-8?B?bjQxaEdOSTNqaXJxVnEvK2xHM0RqNERLQUJTbEljcUJVdldpcEtqZUlkQWZG?=
 =?utf-8?B?VkUvQkRnOXMrZzRZYmM2OHFHRzlVSHhVRFhhWGlYRS9WRExRSlBod08zWXBU?=
 =?utf-8?B?M2ZWZ2ExODc4UFpZREJIVUpMaS9sOEtqNmQycEV1NDFHenJRYUFoakZqQm4r?=
 =?utf-8?B?QU9zbFVGRXpwQTgzRVphNnJCMHMreE9meDkzVytYT3EraEVGSTNtdUJjVWJT?=
 =?utf-8?B?d0lzOWhpazdiK0FjdGtkR25SVjdCQ3BaV0VIVHNJSEthV1ZTNTMvUExvb2kr?=
 =?utf-8?B?STJVTVpqS1BoTURDeUJEOXhhVTgvV1RnV2FGZHBETlVTMDlNWFN2Tlg3emVi?=
 =?utf-8?B?QWI4bGkvREZPaWw4OUpUbzRENi9EeDl0MFRIby9pRzY1MHFrdnNYL0tqRTVW?=
 =?utf-8?B?Z3JZYTJwcEl4NFRTa1hZRWM5MWhubVAwZ0lsVzJPLytxeEFQRU9NeGtQcFVK?=
 =?utf-8?B?eVp1dDNGdXN6b3gvckdaSTMzYitka2Z1VUN3emcrcHh0cHZFd3VIS29WdVVP?=
 =?utf-8?B?UllvVTlvaVQzL29WM2lSV2I0cU40bFhaYkowZTRwZEhrYm1NazRISTFhWGp1?=
 =?utf-8?B?MW1zN0M4ZVh4ZWhtRFI4MUg1aWZJSmw5RUVXb3ZpUWd6UVZaaHI4WFEvaUVQ?=
 =?utf-8?B?MU9xYjNDYjhpMnVPYmtBSG1LQWpUUi80RXlxOGl4RnlreGlpV3l3WHlwVjlH?=
 =?utf-8?B?SWtFSUJxNndwTHVNMXhMdWNENjhZczF4ZVZ4T0NQaUhwNnEybndHY0lpcXVu?=
 =?utf-8?B?REN5WlNZcGw5cTFud2dodzFOR0xKS2QzVXUyUithN3N5VHhtK0VTTUIyMEov?=
 =?utf-8?B?Z1FOQkFnc2RTRVBsZXVQTlgvbVpyZEhYbWhBaWFWZmJ1cnRyb1UrRGtVRVJt?=
 =?utf-8?B?YUZvbGcwdUJiTTliVk9oOWlyZUNyK3VsRzU0ZnU4R3l1dG1MWFhETlFMeU8x?=
 =?utf-8?B?djBacjRnbTNsZG1XclI1MlprN21GazA4MFEvbjZnU0QrYVdjZ1U3YS9qQTBk?=
 =?utf-8?B?LzlEblFTWlpTczhQRm9QZlhUcGdpaXZ5Nmd5b0c1ZG1CVWJYajZqRkV3SjYv?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03610353-d353-4096-06e0-08dac8b75aec
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 16:18:27.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY1HsGFzP34umxzeszBCoZ8ot1Y+Iu0gIdqFZgzsTEjfnd2be8D5BxMbRO87/QLgnxLhKcNXPTW3ELZfFawT1EFfmCwhdUHCnzMiA7pd3vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/17/2022 2:29 AM, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the thermal tree got a conflict in:
>
>    drivers/thermal/thermal_sysfs.c
>
> between commit:
>
>    05eeee2b51b4 ("thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex")
>
> from the pm tree and commits:
>
>    dca20ad5acb7 ("thermal/core: Add a generic thermal_zone_get_trip() function")
>    aed8b46d141c ("thermal/core: Add a generic thermal_zone_set_trip() function")
>
> from the thermal tree.
>
> This was just too painful to fix up, so please fix it yourselves or
> supply me with a resolution.
>
> I have dropped the thermal tree for today.
>
 From my perspective, the current material in the thermal tree is work 
in progress and the thermal tree is merged via the pm tree anyway.

So I think that it would be better to merge it into linux-next through 
the linux-next branch of the pm tree as a general rule.

In my view the material from Guenter is important bug fixes and it takes 
precedence over any cleanups and new code.

In any case, sorry for the trouble.


