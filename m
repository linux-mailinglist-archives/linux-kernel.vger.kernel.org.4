Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAA6AFC0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCHBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:17:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DB5553A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678238263; x=1709774263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BJA0BbrbM/rrc8H0AQRcERVJFEGwb+E8LIclcNmbA34=;
  b=TZqMzSNAAjXNaUGBiNHTc5qSXHWrUoP7rhSLgdtET96VdBJvjRrDzaDA
   9h+gzLCEI2rKi10hylu/NlrGG/YIzJ32+eCtfvlMJ4p5ZnKCD6KZiH/wl
   R3mPEd57b9d/b6WfViwluf2D4FIgWMCqe/3YtLpmFByNDoKAuGFw/OMNw
   27KKohNsac4FbiBaqanWKKdV4+sbfKRciL90Te+Ku0ZuZqDQL0wZhDU4t
   QPO9y6UiS3W0sc1hvL6WS3NfAuo0T2ZC8ky/Sbn2Rkof3ET2gn9vkJOyb
   1RUQUFYO4SVilVrMZHEMRBxxLbV9f96ZMWk7PPFeFZnfjoOcsyceYTOde
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319852140"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="319852140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 17:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800567089"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="800567089"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2023 17:17:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 17:17:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 17:17:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 17:17:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecgnuuaV0vlz+hTy08SPKTsU+mPDwTQkXpKFeXcbXK9YyhvpMBpUYNvjtze1smeSYJNq/7Tbu/i9CV+oPwMaLwSqL4wuTMpVjyk5tBZc44/MLtC2h1cw9roEJYqm7JR9HoAzubFzR2a7SCatL9P0Quvl8iTsvhw5ezwV74YT12B2BDfvNlwJ6iEZCplpRw7uFtfwdMKNkQqes69e94y5XcTRnOPCUu849QDAm4tT4AyuML8JdTAME84+vMr/iYaW21VJ32iSr3oxt6hN3TXjmfoYslpFNbj03GqmWY2QBKgAaICYosx1h4gQij4hizL98nCLX6WuyNJktBlhVc0w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzRQt89wZzxOYNFlGyCicL2WaRjxm7CcOG50C13Uwo4=;
 b=KEm75iQbeQtcYuM1fTZwtFS7pj2mwqW49OswZGSBhKopmc7gU1oQHGDnkZYYqsYlKHMFDYp9xRPfTFXXeu1eGg3d4/SrOW2fJiKG9hR0/18SuYErOKKNkOr9+krboysH37EHf2qnYQxVfITBc+pzNmeb0IbiqTg5zpHq/nY4i2uJ3JDsJ27+g/mK520dMyrpfMgG7Ys8JtpxpU7+SOG+VJPtGW9hcOUPWlhheLWGnGhBn3BVLYVVHxxDMkX/32PTlJmSK4LY5OsaGurWykCTwjzBaSNgunGgx+QvLFNREzGpLRQd4mbGh3UIpdWVcudrGSEd/1/6llZR1rOcPQaIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 01:17:38 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776%6]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 01:17:38 +0000
Message-ID: <542f9495-0216-a26e-3b53-5ccf419c8862@intel.com>
Date:   Tue, 7 Mar 2023 17:17:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3] firmware_loader: Add debug message with checksum for
 FW file
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230302184651.2028184-1-amadeuszx.slawinski@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230302184651.2028184-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|CH0PR11MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d22b89-0973-4f2d-10b4-08db1f72e77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg8GEGto7xeGRT90oGEaUiM5ShvWOtHJLCOST6GgGrVpDS1RvlC1S8W3ZMsN0ndu9mYnSERQJs8qfm+lxxFi++2cdPNl0T4erVF6F9qYzEXCPTYhDY/HwjsgNJq3VkWXewO+wis/zY0B6Y/vbjkgQ5VReQwSHUYtfJIWhz2vH7HcrzS1qZzmJcglA6os7iEYik2iQTH/WUaCKK/2Yd204wS3SM5QUDGRmIFKXihsz5jNbhYHSkZESDcs5J6thsANtXanTuKFaX9uquZOe9kJhVfBVtQocejJ5PvR0rCJJ6qjSbAn25LR/DwtXN/vbkiryCmOzItT0+5qN71Wq+c648GvBSBE7+2CB62+vI1zt2ShHvBQFtgKV9VpEZqtKbuOITPbyW0OsknqwQgHUFUxKRSZeX5ihrShZNHOWQkIVpeYdYWQBLilVi2RiWMDD2+EjzWD08rslkePPIQxpdB+fRCH5vbjnDAWfRM1/XZDV6pz1klvtWETv3eFkPUBa9Qqw4+7eiHPMFH0eQh0CtyMflq2WNg8AhVvbgK9hwp6pcXEuwznr3PBWCWxH0TMRGVvEDvbNDmHzTRZt3me1A0ED/wd2PGeIOs6xjVwq6MuCj8N/fXqA8w9B95s3A3ussAq2KNqjr/NQEJc8WttuKIKSGIElifNnFhmcERImahPwQVWuK3ExCab5NSkgUnaRoa3muaNeHkPfb4yAqFKJXQ76atEUsIrK6XuH+9YyTkKrGKnkP7SKHey9a0vw1TkYEE81PNUCrjfHrInaxQvEQj4Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(316002)(53546011)(66476007)(8676002)(66556008)(66946007)(4326008)(83380400001)(31696002)(186003)(38100700002)(86362001)(66574015)(26005)(82960400001)(36756003)(2616005)(478600001)(6486002)(110136005)(54906003)(6666004)(6512007)(6506007)(5660300002)(31686004)(2906002)(41300700001)(8936002)(226483002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2k3QU9wejdPMVFmcXFIVXBGUXBsZTRlM240aVZXUmNxbWMwVFlTWFhKTzNn?=
 =?utf-8?B?UG1XQTJwcmVLQWR1dXJmeVVOaUpWRmU3VEFGNWhxU0QrbHVFYk54REVuWWNO?=
 =?utf-8?B?N3E5ZmtKOTBIdnlmdm5ZZkJERDk4Y3A4c1FUUm82R3ZpNkl5S3NlZHc1bitX?=
 =?utf-8?B?NGc5MUdxZW4xVXFSUWpzc2xENWorcmxKWVVBb1dYMi9HbnRIRW41bDZWNFRw?=
 =?utf-8?B?MWlpLzVHWHNtb3lIK28wVTN1a21jNmRJNTdwNE1HblliTVhLb0R5eWw4WTI5?=
 =?utf-8?B?dS9BWjUvUk9UTWxmN3FlSzBPa2VmYW5VYWlxL3pHRnRSVC9Bb3VGRkhLZUc4?=
 =?utf-8?B?S0Y2cDdmQzJzZXBWRmlyUVpzVDFNOVJzcGNuZXhyVnNwcnhGdlU3TXIwOFVv?=
 =?utf-8?B?RmNHcERpY1BDVmRTSGJGUnFuMjdEZzlVRmVaQkJkeUlWd0hVZzBYVnMzNmZG?=
 =?utf-8?B?eXU0VDBqa2xLbjEwMDVqVXhPY3JvbXVJSVY5VGgrbGNhK3JzM1ZvOERob2Fz?=
 =?utf-8?B?dE1IQ1Ura1NZZzlibW1hcGFzbkNDRGJOYXhPSXlhYlByQkdSQmdrNHJPcU5j?=
 =?utf-8?B?SEI2QU9IWkIwRG1pcHBBMjdUN21ua3JIblYwUmJmRi9wQ1N5WGZ2dFBEbnZH?=
 =?utf-8?B?WkFLa0p1ck1nVVUwWjJhWCtWc0RNdEV0a20zVFR2MWk3OGN4NzNkYzBRNFJt?=
 =?utf-8?B?Z2swVVQrMWNXbHRhTHEzVGxnOUJUNC9ucHFHU2xjNUordkJZN3BtVUt5RHZz?=
 =?utf-8?B?aW12VkczK1RYMTVaUGp5NXRGbTg2bEJJcmltMzNkeVdSQmdjZFBNQWpHRS9t?=
 =?utf-8?B?cHAwcStlVUxURW82elBFdUN4UzdWMFJBNVhoVGIyQUtiUjAwcWhYMDk3N3h2?=
 =?utf-8?B?Z1g4dldkblZRaFU5bjFOa2pnWENTTW5tanVvdHgwTkpJODdudVNTVkZrdEh3?=
 =?utf-8?B?cTdYK1czTW5xS1dHbmhnUmVIUndwZ0grOWpjUURWWnVYeXhXWjNGZkJJNC96?=
 =?utf-8?B?d2lXb0JPWGU5R20wdHhMVkg3TTd2SjF3YXVOTmxUSXg3ektZKzZxblllazl0?=
 =?utf-8?B?ekg2SXIvM1M4U2RvR2x4Sk9CaElrbHQ2MUJCS09VbW9qeGx4QlhNV083dURY?=
 =?utf-8?B?Z3hsR01IN1R5N2lkdHpIcUxkc3d6bmpiRWhQb1RxcVRnZ1hnbXJFbVViZ04y?=
 =?utf-8?B?bGxnMUROZ2Z2TktXdGZlcXBkRHlHUjFvTlBWYlB2WjJJVThNWDFXNDFtRXpZ?=
 =?utf-8?B?VUVHNkNFYVdjemIzZXhucVhobTlCdWhFenJaWFdjZGhTbUprUC9nbUtTdnNK?=
 =?utf-8?B?T1JoWm0rVmkzWTJVWE4zM2NHcDJYMVBWelRrNE1rdnhvTHk4T0QwdkdscXI0?=
 =?utf-8?B?WlFRZi8yREVoMVJtVE02VXBCT0cwRkI1Yy94SEFrNzFidmVGUjk5RjdHYm14?=
 =?utf-8?B?NHB0MjRGbGcwY0NjRU9ON3dqc3VDSHRDRWRWOW5sUkQvNU8zMnROYnFPVkJW?=
 =?utf-8?B?RVNiRlA5amJnS0tQU1ZRNUlST1lVNDlDc05HU0dHeUQ0VWt5djV2Q0ZsQ2dO?=
 =?utf-8?B?VXpoYWFrdmtuOC9KclJVTDNXWWVNWmpzMzlHZWtXakJCVjdiOGFFZExxSnFK?=
 =?utf-8?B?VmhJcVpWR2dCZ2JKNWlBRlE3cnBiU0tyOFlUbjJXc1JJSHBGdTV6b2kxUnBH?=
 =?utf-8?B?T2ZpM3FtSWdmR2RWcDQ4ZGh3Q011dmdjQ2ZaZmRBRCtrb2lqTDBLcE10Sm95?=
 =?utf-8?B?ZGZaNDJYVmVkSGpwbVBHS3BNdnRBRWdxTUxIWFhXM0dWd0JXekIrYlZzSUMw?=
 =?utf-8?B?Mi9mWGdiTnUzV1pwMldWSzFueHdIV3J3cmF4aU9OQmZ0TWJwZzJSSytDZzY2?=
 =?utf-8?B?VllRa0JCQkVZTXp4Vi8rS2QwYmtnRGtVRzVMRmxqaUtRQk1Yd001QzhxU1dx?=
 =?utf-8?B?NmxrWWlBdUVWWk0ySDFaSzNjMWNaNkNWOENHN3M3QjVrVWNvTmtLcUxsa3F6?=
 =?utf-8?B?UlIzQUtFSWNISjNsZS9hRFZSeW5oTG5sYVVSeE1odDE2ZmdJMjlNWFFLU1px?=
 =?utf-8?B?aGlGdXhta1JNekpySnV5TllVc2Q3Mko2WHdFRXFkTHBTQXRtQ1RTZGVrWkp1?=
 =?utf-8?B?b2dmUzJFZXg1bmptNTErRlY3OFZmT28yQzl3dGlhc0ExM3dhamNBM3FoaXBK?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d22b89-0973-4f2d-10b4-08db1f72e77e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 01:17:37.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrJJ/645jo6pZhgejD/JXsDOVnE4kelsCeJJdaOEGAmYhHS0P8yGRh0M1hlUWNrwntBmP//5nIrAvUQwoz4qUFLmzh4H/4T/XyzpJyUfyjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/23 10:46, Amadeusz Sławiński wrote:
> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
> to clearly identify the firmware files that are loaded by the system.
>
> Example output:
> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>
> Changes in v3:
>  * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
> enabled (kernel test robot)
>
> Changes in v2:
>  * allocate buffers (Greg)
>  * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
> dependencies without introducing circular dependency (Greg)
>  * add new line between includes and function name (Cezary)
>
> ---
>  drivers/base/firmware_loader/Kconfig | 12 +++++++
>  drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5166b323a0f8..a2f8f75e0718 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -3,6 +3,7 @@ menu "Firmware loader"
>  
>  config FW_LOADER
>  	tristate "Firmware loading facility" if EXPERT
> +	select FW_LOADER_DEBUG if DYNAMIC_DEBUG
>  	default y
>  	help
>  	  This enables the firmware loading facility in the kernel. The kernel
> @@ -24,6 +25,17 @@ config FW_LOADER
>  	  You also want to be sure to enable this built-in if you are going to
>  	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
>  
> +config FW_LOADER_DEBUG
> +	bool "Additional debug logs"

This is the prompt that shows up when I do "make menuconfig". How about
something more descriptive?

"Log filenames and checksums for loaded firmware"

> +	depends on DYNAMIC_DEBUG
> +	depends on FW_LOADER
> +	depends on CRYPTO
> +	depends on CRYPTO_SHA256
> +	default FW_LOADER
> +	help
> +	  Select this if additional information about loaded firmware file in
> +	  form of sha256sum should be dumped.

How about:

"Select this option to log firmware filenames and SHA256 checksums to the
kernel log for each firmware file that is loaded."

Thanks,
- Russ

> +
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 017c4cdb219e..b2c292ca95e8 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,50 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>  	mutex_unlock(&fw_lock);
>  }
>  
> +#if defined(CONFIG_FW_LOADER_DEBUG)
> +#include <crypto/hash.h>
> +#include <crypto/sha2.h>
> +
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
> +{
> +	struct shash_desc *shash;
> +	struct crypto_shash *alg;
> +	u8 *sha256buf;
> +	char *outbuf;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);
> +	if (!alg)
> +		return;
> +
> +	sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
> +	outbuf = kmalloc(SHA256_BLOCK_SIZE + 1, GFP_KERNEL);
> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
> +	if (!sha256buf || !outbuf || !shash)
> +		goto out_free;
> +
> +	shash->tfm = alg;
> +
> +	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> +		goto out_shash;
> +
> +	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
> +		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
> +	outbuf[SHA256_BLOCK_SIZE] = 0;
> +	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
> +
> +out_shash:
> +	crypto_free_shash(alg);
> +out_free:
> +	kfree(shash);
> +	kfree(outbuf);
> +	kfree(sha256buf);
> +}
> +#else
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name,
> +				 struct device *device)
> +{}
> +#endif
> +
>  /* called from request_firmware() and request_firmware_work_func() */
>  static int
>  _request_firmware(const struct firmware **firmware_p, const char *name,
> @@ -861,11 +905,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	revert_creds(old_cred);
>  	put_cred(kern_cred);
>  
> - out:
> +out:
>  	if (ret < 0) {
>  		fw_abort_batch_reqs(fw);
>  		release_firmware(fw);
>  		fw = NULL;
> +	} else {
> +		fw_log_firmware_info(fw, name, device);
>  	}
>  
>  	*firmware_p = fw;

