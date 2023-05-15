Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2E70274E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjEOId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjEOIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:33:49 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D11119BB;
        Mon, 15 May 2023 01:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYvO6edlN2hVUXpxWEtvUR3UR/Y3R+IxQw+b4mII73+EoX7Sd6K5aAlFzsNrql8nVyi9vBI+ED8Ex1rPz1qUW4fo2L9Z6FkmSyZqxttQ4ns7p0G4NgI5AxRCAb/IULt1JafHwdEHV0iQG/vxzHBRgXTkPPsxS/HOzHZM8sWlIu4gjfkYuzGm5TanaB6dZ1pxhVx8AyK03A1x9rVa3dqwuz16iodnGiqNr1qj7BQ1stV8HatrpTdO6LcJmVoWH1rzONX3WuAT9+tRs6blLcWnEzdmMNYboZ1kdBcQiUbv/Re4FwDLpgX9rH8PwjOFXrbr42s/TQJxCumCbrl+GPmOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of0Pl8V+36654KzuTHXG9LMv8lEkYkfVAgHCqJuPtoA=;
 b=b4VVjAW03qMenTmp51C3OC5MFxVE/GzUtodPF2IUXA6T+T0q4Xq+RQL4LaR3+xVYNBDNqPqBHW7/5uuv2QApbltydD4nlBcOWcfo+uiuJOvuVZ7XVx4vzLYSqOKvuNjkJH1jC/Mp2jU8dcy9bjrFB2tXKnYL7/UdpqreJE90IIce5HdiJex5iOkJu74zmMGrKPucNDCN8jReAGKWzVh/XSyB8Bywc5ZKN737U3HiasQz/fN9dQDgKA7To+Y/dlVXu2G0MFEliALWub2ou9qmlhr++y1aaHkWo6KqCg/mDfeWobByUe/QCO8D9YGYUZzUu9EP/a9TW4RpxOKTKqf4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of0Pl8V+36654KzuTHXG9LMv8lEkYkfVAgHCqJuPtoA=;
 b=Z7e2TDRBoC6mGUxRAkzBlr9wPsF1kvOFyWMKTx3LOoGNMTb/GVHTEFZCBd0avnvnkwRK9DeovXM0jzNbsTrYvJLZFdsWNNjtx2OKuSJb1eWhvIDXWlXbJQcPL/U0TNoGHxwRZXO87Sf3AWCzHguyJmu81z0HcU+iDIIIrW2gfes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB8299.eurprd08.prod.outlook.com (2603:10a6:20b:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 08:33:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:33:16 +0000
Message-ID: <e458d47e-e0da-c6a4-f91a-c44b3a66531b@wolfvision.net>
Date:   Mon, 15 May 2023 10:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        202305140640.VLcvhR5G-lkp@intel.com,
        kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
 <202305140640.VLcvhR5G-lkp@intel.com>
 <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
 <40f4e8a3-bac7-f64f-161d-f863103f3aec@kernel.org>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <40f4e8a3-bac7-f64f-161d-f863103f3aec@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: b97707cb-7441-4b15-a4e2-08db551f0795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmXkgr5qMRkV8VTReWaCPyLmstl0r/vDLn4swJ9f+gEyjYsY/mCcA5gpIAT3vmPKG0Bqp0CKjh+n6Z0EAAEsQ33/luBDVuH76Rce62u1f4XHNBtagPvKQEmXQr2tRst8Bmz9vOHBtqlyr8oFaz50Jf/mcUeg2K2acwbSKIdxt8QaiuutxGv1/isBhiwkP0oP8R2d04A50H3dB+3+N8p+vNFP3MLQn502aSRwfpwqOZxNcbTYcaIPq6aym5iAozpVFR3QVVXNal8upzPXxZs7I1lqdufA2F5uUfNU1HJ1EA3cwAsOr/ZLsB5cO8z1J9uj2xQ4Vg2JjyY4KtNdRwaGAUvYlMQP6pOF1n2NtDaBB7aH93wH98qH5tOiD8cbtOScx+y09xh/m/K2sspyDePKzkL26fUjlYtlO8JD66HAB1XHW4YALkVv0/jUcXs0ZXEBYWwEAxaF6sXClcGPez9bHuNPmfI7fqcdBXxp5Zwm4ht6HQzb/Cn4UO6J5f4FfuRBSqVzI1KOORVeXQKU2qvdXns+eHh+jX+Edn+UC3DI0rmGvGBL+j/styLq4ky+eZtGUJ/k/JbHJzylBrOma/Hn5zGPPnMXfGSFNqFYWuZjpNPk/JAiOyOl1EtOG5hbx08WuPhtYokbxPFj9tIuvGwPgkfFSBipNQ4IX1/rL41WuTOAv/EAlzrvmcyZShX4KJwM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(396003)(366004)(346002)(376002)(451199021)(66556008)(110136005)(478600001)(66476007)(4326008)(6636002)(66946007)(45080400002)(6486002)(316002)(966005)(2906002)(8936002)(8676002)(44832011)(41300700001)(5660300002)(7416002)(26005)(31696002)(86362001)(38100700002)(2616005)(83380400001)(53546011)(6512007)(186003)(6506007)(36756003)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNCb2lEa0d5Z0tiditzb1ZtRTBSWHJCU09IYjk5eDFHbm5FZUpoUFg3cmFG?=
 =?utf-8?B?YjV3dEpxYjdmSWNFZjN3RzB5K1NSL3kzZkVpeGVFcWJyRk1zVUc5RE9UY1p4?=
 =?utf-8?B?VnQ5N21rQ1ZJYjRNbE42dFRTRXBtQUwya3pmbjdKMHZWRVJhN1FLUGtpZU1L?=
 =?utf-8?B?WG9hbFNlcDIrQzhKVTBKck5RM2ZPRTMyWUJaWEFqZGJuWlBCa2loWDlnNE5y?=
 =?utf-8?B?ZytGUjZVMzZ1OFNqNFlEalNIc3JXZ3N6TnEybnZBck9LK3F4cWpYZEszbzJI?=
 =?utf-8?B?MkFyRGRlVE5yb0IyeVU0czJWMmJWM2hIdDlhTDZKK2tYN0lITVJYN3Fpc1pB?=
 =?utf-8?B?SnBoQlJ6VThUUkI1d3FKbnlSZXhadU9tOHk3YnB1Vkl3RlhJU3NtYm41T3Ny?=
 =?utf-8?B?SDlXRGFpZmcrOHVwZExUME1YSWx2QnlkS0I1eE14V2svQW1rMjhRaVVPM2JS?=
 =?utf-8?B?dTlnRnZhWG9rODQwMEk2NVkzMTcwemtQdWgwNGRMU1dIZnYrVFRVcEc3dFFR?=
 =?utf-8?B?Q2RPTjJDNXA1RlF4R3kwOG5iTzhHUXJ1V0FVSVQ2ZFlUekF4VW8wQkdPUDNI?=
 =?utf-8?B?ckh2azlwU3VGdlR0RU5neXJTWGh0ZHM3SXk3eWVVNzRVdGxCNmJ4czZtUEVm?=
 =?utf-8?B?T1BwTWdIVzJvZmRzTGk1NHQ5MHZKVE56VWh3WExFWGE2RTl5WGxNejg5blFq?=
 =?utf-8?B?bGt4Mkp3Z1RpaTJiNUlDbTdVUDE0RHVLVVk3dkl6RkZDdnB0aU41dmhiUnFK?=
 =?utf-8?B?TkgxTUJXNjEzK1VjV3hEZDEzMXhjT0p3MjlybFFBdEVzY05DNEFpVFZZaDJL?=
 =?utf-8?B?L2haY0VHVFp1UllzZkk0V01RbjhORzkvZTRNT1JDSnVMeUtlU2xxdStETTdO?=
 =?utf-8?B?Q1lOQXdEWG1hK2pSQkltdGtVdk1wMmxCSFBMM2lGd0ZtSlROekJIMVJrMk9H?=
 =?utf-8?B?VzVvRGhVaGNCT0FZTW84QVpwaWlQQU1oZGwvOERldnZSUFJPbGtHQkFhOEV6?=
 =?utf-8?B?eUM0OVZSLzlyZEg2azY2L1ppM2UvbzBDM2ltNDk4WnZSdU9iMjJKVVh1Vk9t?=
 =?utf-8?B?ZXU4aXlLa3FqbkkwNFBPK3djNEhFVHZncjcrOGFBL1RkRitXOUVKZklsR2hE?=
 =?utf-8?B?bjM5Nkczb3JudGVsS3dKQTBhTVJNd2xMTUw4R0I4c1dlK3A3L0ZGTzRXczZ0?=
 =?utf-8?B?QVBiZldFeGhjQ3ZiRktBVms5TFBQU0dDWHVwMWxSeUVuM0JuVmlmUTE5cXk0?=
 =?utf-8?B?Qlo3Y3N5NlhnenFYRTV0UFhvM0lYVno1R0ZYenNPejkvb0c3TFAva1hGMFZQ?=
 =?utf-8?B?M0JUWXdCV0FTZEV3dGUwTUJKMXRzb0VmQnI4R25UK2dBVUowTXdxSlFJS1NU?=
 =?utf-8?B?UnowejUrMy9XeDJsWlhYRVJDUWV2eFFvQi9VeGNGMllacjJJYUprYWthQ1lN?=
 =?utf-8?B?MDJvNnhoZ3d0Q3UxUlpvRGxjVkxOV1VxNjAvV0VRdkNLd2pXTkI2NmI3dmFY?=
 =?utf-8?B?bXovTDZkWmxaVWg0ZGllalV0YXd1N3pVd2M2M3ZHUlBjNFpxeS9MK3N5UzVn?=
 =?utf-8?B?VlA4SmNUbmNFYytpZ2tTVnpVNXRRVFh2WHBTcDkyK0QrT2pFVEp1ZkhVemFK?=
 =?utf-8?B?NnF4N1IzRGluT09UdGdNVjEwODZKdGpiaExvSHJ1UHp3cmdRMXV6VlpmOCsr?=
 =?utf-8?B?cnhJNDREaHJsdHl4STYxZUlJMjR6dHdxbEFsTU1qVDR1cjc2TU5aU1dDT3NH?=
 =?utf-8?B?RlpLZTVERTFjVWJJY2h4NDQvNkFFczV0enVCWkRyWmdmYnpSdnJIdmg1ZUVW?=
 =?utf-8?B?ZjhmQ0hmR0RxYkROaWtDSk1hOFROUk00RWordm94SUh0dUxXN3MrdENCY3gw?=
 =?utf-8?B?NzJ5TWlLeW5nS0VtUDI1RFRLTWxEVnRIUVdtRUV3OFo0TTg5aXFzblBXOTF4?=
 =?utf-8?B?dnpVSS9GbXU0dU5ya1lJcFRVU1NRSS96NnJGd0laZ3Z3TWdXaEpjTmdQeS9I?=
 =?utf-8?B?RE9yd3ZRTUloVnpNY01DRnVjSGdJSmU4OW1vZ3B3VlFIdkdCcm03RnB2NFhZ?=
 =?utf-8?B?Y1hhaVFuRC8wQUhuUWd1UkN5OURxejd2RTJNT0xkZHZ5bytKM0dhUGVpUk16?=
 =?utf-8?B?VUlZVjlJdmgxZEdFT0crS1B1VjFrRm92eDIrYVVxaTZqckFCUGs4TUc1RXZV?=
 =?utf-8?Q?2e3oKDt3h8h/fNesmmT2zBY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b97707cb-7441-4b15-a4e2-08db551f0795
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 08:33:16.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgI6VOwLYEQXw1lT6nDPwsYcKMaQqsvCfOy0uigbkWwlsbjNGoZcptf4CekQyh6WD+3eEo1E4Jv1gLRXaxPCh1jF+OmQG9fHTlNvTR4wqNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8299
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 08:43, Krzysztof Kozlowski wrote:
> On 15/05/2023 06:34, Javier Carrasco wrote:
>> On 14.05.23 00:38, kernel test robot wrote:
>>> Hi Javier,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on ac9a78681b921877518763ba0e89202254349d1b]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
>>> base:   ac9a78681b921877518763ba0e89202254349d1b
>>> patch link:    https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264%40wolfvision.net
>>> patch subject: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons handling
>>> config: arm-randconfig-m041-20230514 (https://download.01.org/0day-ci/archive/20230514/202305140640.VLcvhR5G-lkp@intel.com/config)
>>> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://github.com/intel-lab-lkp/linux/commit/133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>>         git fetch --no-tags linux-review Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
>>>         git checkout 133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: https://lore.kernel.org/oe-kbuild-all/202305140640.VLcvhR5G-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_parse_and_report':
>>>>> st1232.c:(.text+0x148): undefined reference to `ts_virtobj_is_button_slot'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x15e): undefined reference to `ts_virtobj_button_press'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x16c): undefined reference to `ts_virtobj_mt_on_touchscreen'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x242): undefined reference to `ts_virtobj_mapped_buttons'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x266): undefined reference to `ts_virtobj_is_button_slot'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x276): undefined reference to `ts_virtobj_button_release'
>>>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_probe':
>>>>> st1232.c:(.text+0x42c): undefined reference to `ts_virtobj_map_objects'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x43c): undefined reference to `ts_virtobj_mapped_touchscreen'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x44a): undefined reference to `ts_virtobj_get_touchscreen_abs'
>>>    arm-linux-gnueabi-ld: st1232.c:(.text+0x520): undefined reference to `ts_virtobj_mapped_buttons'
>>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x542): undefined reference to `ts_virtobj_set_button_caps'
>>>
>> Apparently there is something wrong about the references from this patch
>> to a previous one from the same series ([PATCH 1/4] Input: ts-virtobj -
>> Add touchs[c]reen virtual object handling). The "url" link shows all
>> patches of this series in the right order though.
>>
>> All these functions are declared in the linux/input/ts-virtobj.h header
>> and also inline-defined there if ts-virtobj is not selected. If it is
>> selected (either y or M), the functions are exported from
>> driver/input/touchscreen/ts-virtobj.c. According to the error report,
>> ts-virtobj was selected as a module.
>>
>> I could build the kernel with the three possible configurations
>> (ts-virtobj y/n/M) for x86_64 as well as for arm64 with no errors or
>> warnings repeatedly, so I am a bit confused now. I am probably
>> missing something, but I do not know what.
>>
>> I wonder if the new file where the functions are defined (ts-virtobj.c)
>> could not be found by some reason or if the test build does not like the
>> way I handled the function declaration/definition. Any hint or advice
>> would be more than welcome.
> 
> The report is correct. Build driver builtin and your virtual as module.

You are right, that was the configuration I was missing, which I
honestly did not even consider when I tested this feature.

The problem seems to be that I am using the IS_ENABLED macro which
returns true if selected as a module, but the define is in that case
CONFIG_TOUCHSCREEN_TS_VIRTOBJ_MODULE instead of
CONFIG_TOUCHSCREEN_TS_VIRTOBJ. As I am using the latter define in the
Makefile, it does not get compiled.

I am testing the IS_REACHABLE macro for the header instead, which I
think is the right one in this case and actually fixes the bug. I am
telling you that just in case I am talking nonsense to save everyone
from a pointless v2.
But first I will go through all possible combinations between my virtual
and a touchscreen driver before I submit a broken v2, where I will also
provide an improved documentation as you suggested.
Thanks a lot again!

> 
> Best regards,
> Krzysztof
> 
