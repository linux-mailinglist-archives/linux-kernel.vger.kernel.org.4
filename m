Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28BA7022F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjEOEe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEOEey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:34:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5CA4;
        Sun, 14 May 2023 21:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfriBd9PjpEZC7AhNeapEZDjSYfx4/7F5ZMgoLYqqV5nfk5F4sTF4/GneU8B7quPUbFoCXYRS8AhL6O9OpmqB0NX7s0dUaGmA2iWJO5N4BT5IYvrf3/U4hexo0/HNWYjJHXzPQCEWjJkPfALmp5C7n26e4Sy1w+0JugeoEQqZjkj0sBmJ8DudkjbgsF3G4f1NdUI2zINQD6uh/iT1wpK0/uiEXRM1GhbcD3krXEza+05B3TJ+TcRfaANse5KS+L5zJ3RMbNIrilIeiJ1isLm7mG3vENT2W5AIMwXfBnFcNXpO0Ps28STRPrUANxH5wYaR5v1xFh4+b2634F8X90I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbNclFI+ybWcGM8BwKD0GUK+Vv9bRlccyTA8OnyXVwc=;
 b=VS2fueKTb3b8uGawRkbi5UYlspfs4Rlp/xat2kg2lf/2/bSJjIxce/76M2TEnWbQv7Kg4CtpsxUaZvFpdR3b4epH9yV/gmuD9rNjNw1X8LsDrE2HEXOjLE8WDFRhT/mFmHMHlsZPO7lwdxKTzrOn6ESEONeSjYQyBYXViNdbMHZ0D1Q7V9NvxrMfBm1sSwkYao4KqUoRA71fBEjyqQ62zVLSxUWGMWHdFrJS39WuXZw/NWUbP8sbuhKi1KDY1fB2x+r3pdcTMgNKbPb9uPZmQqiKcZGr0LUHeVxRhduhpT4u1nt/ShSZV8/u4QHB0jK4w7YbEOkVOK1x1keRg/yPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbNclFI+ybWcGM8BwKD0GUK+Vv9bRlccyTA8OnyXVwc=;
 b=po3bjrf1W/ZJtoGXp2FPF9egSpe4nC1nddBXcdZ5kd3J19qHpSsoIe2oD7dLHuOOWU6C6bGii8H320yuLZ0C6j0XlaMOusskJcDEEIfPC/LtNBEzjmfjiAQlcRQSVeWtczEwX9i+eAJccORjLDdiD0EIrnMAFBbBLz6YfSDtuhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9549.eurprd08.prod.outlook.com (2603:10a6:20b:61e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 04:34:47 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 04:34:47 +0000
Message-ID: <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
Date:   Mon, 15 May 2023 06:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Reply-To: 202305140640.VLcvhR5G-lkp@intel.com
To:     kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
 <202305140640.VLcvhR5G-lkp@intel.com>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
In-Reply-To: <202305140640.VLcvhR5G-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR0901CA0091.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fb6d32-0220-4ed4-c7f6-08db54fdb6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCrrvVEXBrgZEvkAYCVPYoLj5yaDb2Yo3KcFSVyd2z76fqitPQhm0mTZriFk/UAWc8F1mOKTKD31n7w5dSVVqRErvHfBkcWyculAc5BSMTDo3qHvjKTTuJ5Q5OysHUnCWgpVb9pFLr4p/AQNqnhYLs9IVR3atnEfd8CNcM50xKhGLiZ5tTnM3O0F6MxCrWYE+OboHfGRJZHoHQsGPmBQ3uDQbwBAgM/lIhPuN7mrCXkVsCQu65KVN+oYaxfJwwNvhwSNez5n4VENq3S4QKD8h9w5v++xFOB3jl7wuhJyvzoQE/6A551iWXem3x/Fbcl1uINmudgg5PbFJfH8HC4tK1T5zGuvdbiOChyYQ0rSfw74NAAPXRfcyg7NyZLEvTkZxngEmwRfL/FO+c2Q6353Mk/sS5nJ3WRJNIaiHvYlFONFEssKtAQVr6aaXmqyczhiwK7u0JL/VuYk4Vk/nOwmztYGfRBK91j2gLxtMgT5f8BkB2e9Mn+5tuahufAaX16Fc3X7uUXDJ7t5nXukCOp5dPy11Q6efc+paCzn7lS0lBksbDPCuZ+xjY3pXukOTBwH79pZVGH1XBuB634JDhSiIbbptMda0JQTij6q7CL/cFeVeNokZrd9UIVq1US9FP53Iv20NJ57yGBzAjUcGyb3g87pd3sWHpgMvLg2w4W2iF/7Ra0ZIqVF7oiS+XOFNztG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39830400003)(451199021)(36756003)(110136005)(66899021)(478600001)(45080400002)(38100700002)(41300700001)(44832011)(7416002)(8676002)(8936002)(5660300002)(2906002)(316002)(4326008)(6636002)(66476007)(66946007)(66556008)(6506007)(26005)(6512007)(31696002)(53546011)(86362001)(186003)(31686004)(83380400001)(2616005)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0g0YllzcW12YlBoRStUWkpKcmxPUlNSUTVwU0EvbFhSRGdNZm1pL2FVN0xI?=
 =?utf-8?B?R250SUphOHZUYjhJcXZZMXVQL1RFbUp0SFVCQTNOaVVrbjA4UGNHeUJqVklh?=
 =?utf-8?B?YlhKM0ZNSy9aYTkvQUduSzlqSWtzMHJvOTJsZHVhTE9hdjdDdFh5RjZXNWxB?=
 =?utf-8?B?cER6RFBldTlKTkV2NDdQVmFqTURuUkdnUVV2dzRpb1M3S05SYWI5OFhBdkho?=
 =?utf-8?B?bGx3cWQ0QlRaL3B2Uko3QVAwQmx0VWJaMmlVZ0hQbU5lRmZIWUJ4bkZ1dEl4?=
 =?utf-8?B?b2NCd3JxbVJKbFN4RkFvTXFuUTFxL3JURE9xV29XS3V1OWsyWXlraHF1YWVI?=
 =?utf-8?B?YU03cjBhNHhwVmRDbUg2V1RLR3I0Y3FwR0Z3ckRNeTNwMzNJeTcvTTZvYldz?=
 =?utf-8?B?OUx2dTVRMFh4NmV5RDJoZjYzSVAwbXhVRlhYcSs0VVVJN21aMDlIZEVCUTdQ?=
 =?utf-8?B?VWU3dnVieFh3Z1JNSkphRkJKZlRkYys0ZlNKMXB2bG1vdVV1RE5yaElMK25Z?=
 =?utf-8?B?OG5oSlREYktydXBybnN2aE9SeFNlM25iWXc0V1RtRmlEei9tMG1Oc21VTGhi?=
 =?utf-8?B?T3QybVNsTFllRWN4UnAwaDVYRkkyVWZ6WjFkMnVLenVocm1MNEpkb29PWUI1?=
 =?utf-8?B?YlNNWHdibDRjc3NqYXNZRkRPMnAydHhjYlhoVmgwdXVSMW0veS9MUVJYeXVl?=
 =?utf-8?B?SDM3T1BqYTdzaXVFOW9lRi9SSXZ2RC8zNy9ybzBueHh3RkJzZnduNWRmQUM5?=
 =?utf-8?B?OS8vMGRSYkU3N0Npemw1MFRPa2xxdzQvUytVMVRqLzdMc3MrWFNEUXNDeExo?=
 =?utf-8?B?cVkwNHk1Y1NQcWZhb1VoWFgxTjgvejdSd3Q3WWdMUVVGNFdwdS9jSThkMGl1?=
 =?utf-8?B?RE83SHRzNXNzU0ZpV3l4QVQzMC9lc09oUGpHdkpSaWd5a0pYME9NY3o1enJm?=
 =?utf-8?B?VkZBbzROVDNyV3dxZTJlVkp3RVA1Uzg3cUN0djUvcFBBazZhNEhuVGZWVVpZ?=
 =?utf-8?B?K0w5c2c5WmxRZmdJOFpaZkdXaFZWU1RnaDF5M0duSmdRNWhHRG43U0xFR2J5?=
 =?utf-8?B?SWI5SlQzbllNNjZOYmZvZVNmOURPR2hHc2x6OTFHUzY0NFg2Tm51WG9PaDdh?=
 =?utf-8?B?Mm1uVFgzK3NtdENHMTNSZFBZNlhGTHg1cm95V3A3aHJ4Z0J0NFgwWldLcC9U?=
 =?utf-8?B?ZG1RY3hNWXJGMVkwSWhPWXZWZitrNVZ0UVMyRHAwUFkxS1ZIY2xzUFJIZWQ2?=
 =?utf-8?B?OEFhT2w1dU9Ia1d1NFZpV1pVaDBqMUhFY3psTm11UExzQnozVkJQV1JWMHp5?=
 =?utf-8?B?SlUyNk55ZlAyNHFaWGVsNVorbzNkSGJERDFlZTQyR1FQRjJqWnNuaTBTdEpy?=
 =?utf-8?B?NlExVkU1dEZwZGdRcytvc3RhdERoOE9YWkdPMStDSk5aTGh1R2tSMmprVGky?=
 =?utf-8?B?amlpbTR1Yk96aUNWUjFhNVUreWwvZWtFTlhYS0tHUVdGbk11UHRzLzN4aTM2?=
 =?utf-8?B?ZThsM3p2MENhYnBZTlUzZ0NRWjQrNFhHcytVZWtXZDdacDZzK1lqYTJRRjVa?=
 =?utf-8?B?d3YxZW1mMHA2VHc0aTArdVo2bkNianlQbkZTMEROMTRzUGphTXcrRVpacmhk?=
 =?utf-8?B?TkhZUVBRcG9nRDVyekNDTzVLRk5wTUROSkViYnpSNVM4NDQ5ckdRdmZOOFlH?=
 =?utf-8?B?K1cvcmlYVlVUNGlhaEhxcVNYVnNJanRxc2xsL3VjcGpuNzdmMU9NTUphbmwr?=
 =?utf-8?B?ZHRtVXRwbG9Fa0tVdUVlQzJsRVJUZkRTWjI3WlFaNUNoc1BWZklacis3bnhK?=
 =?utf-8?B?RndwMnZZUVp2MlJBVnpiWUpxRGxuK3B3K0VUMUZPZUJNVDZKL202WjAxb3lY?=
 =?utf-8?B?QVFkRmNxNWlabC9sVTJPbnV2U25BL0M0aDZNWEhXNFhHaGVybUpZZXpVTUJQ?=
 =?utf-8?B?YzNLYWM0aXMzUzBPVytjT2N3cWZlWlR0TG1QOElyNys4VGFhUnRYa0RPb0kr?=
 =?utf-8?B?M2VtQXRHazRjSzNBdThvNHM3bmJJTURqQ0JGNUM0dHJkdTNNSSttTU5MRHRZ?=
 =?utf-8?B?WDVlaGk3TEJhSXZaWEcyOTVUNlVRYzRkUTFlRkVlZm5XUE81S2l1MDk3Vmh4?=
 =?utf-8?B?aHpKOHNEMDRQSVFPQi9jZkZFZmpac1BFNjhySnR6OVEySS8yRHFhcXhncGZq?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fb6d32-0220-4ed4-c7f6-08db54fdb6bf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 04:34:47.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yV/1p00nwEDxrOwfbGzKt9B8/r2tBX+S+Zh6q4VbMN3LZLD9YyxUF6DxAIsaBeSc/nMAApu7eovClbUEe8YmqYFj9JLDfjSMHPgwF3RdPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9549
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.23 00:38, kernel test robot wrote:
> Hi Javier,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on ac9a78681b921877518763ba0e89202254349d1b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
> base:   ac9a78681b921877518763ba0e89202254349d1b
> patch link:    https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264%40wolfvision.net
> patch subject: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons handling
> config: arm-randconfig-m041-20230514 (https://download.01.org/0day-ci/archive/20230514/202305140640.VLcvhR5G-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
>         git checkout 133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305140640.VLcvhR5G-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_parse_and_report':
>>> st1232.c:(.text+0x148): undefined reference to `ts_virtobj_is_button_slot'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x15e): undefined reference to `ts_virtobj_button_press'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x16c): undefined reference to `ts_virtobj_mt_on_touchscreen'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x242): undefined reference to `ts_virtobj_mapped_buttons'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x266): undefined reference to `ts_virtobj_is_button_slot'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x276): undefined reference to `ts_virtobj_button_release'
>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_probe':
>>> st1232.c:(.text+0x42c): undefined reference to `ts_virtobj_map_objects'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x43c): undefined reference to `ts_virtobj_mapped_touchscreen'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x44a): undefined reference to `ts_virtobj_get_touchscreen_abs'
>    arm-linux-gnueabi-ld: st1232.c:(.text+0x520): undefined reference to `ts_virtobj_mapped_buttons'
>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x542): undefined reference to `ts_virtobj_set_button_caps'
> 
Apparently there is something wrong about the references from this patch
to a previous one from the same series ([PATCH 1/4] Input: ts-virtobj -
Add touchs[c]reen virtual object handling). The "url" link shows all
patches of this series in the right order though.

All these functions are declared in the linux/input/ts-virtobj.h header
and also inline-defined there if ts-virtobj is not selected. If it is
selected (either y or M), the functions are exported from
driver/input/touchscreen/ts-virtobj.c. According to the error report,
ts-virtobj was selected as a module.

I could build the kernel with the three possible configurations
(ts-virtobj y/n/M) for x86_64 as well as for arm64 with no errors or
warnings repeatedly, so I am a bit confused now. I am probably
missing something, but I do not know what.

I wonder if the new file where the functions are defined (ts-virtobj.c)
could not be found by some reason or if the test build does not like the
way I handled the function declaration/definition. Any hint or advice
would be more than welcome.
