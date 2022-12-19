Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E941651599
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLSWfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:35:18 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9344F12D1C;
        Mon, 19 Dec 2022 14:35:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSHemaZfPWcUztUwLB5y4dXovVCX4ZFIiB6lpbRiDVzxtQvCk38wGfVGpTSF6y3OQ2bnDK0iSYNmbGdzQ2IfL5GqisAw1PQ7kW+iKDqMhwfulRRohbwNAn6eDeWWCfhgmg0YDGmSQrf37zmdrKbJdDU5W7SQY1ji3khhxdBz1q/tGjAgzIPCZ66DZi50TfzXeXC5vE01i08+sH9vadkR5VGUi+wLZOv6HwgyY5uqt8RWGhBMoA6zM8UkBCm7CC/XU0Op9zQVGNTAKCeipoLCFA3HaiH41EWbibY78XxdZY24NVJa1HOPlskSPsUrrwP/x60/0QXPE3sBp5EFWEO8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShCUBqUh/FFMGQbCL+UDs5J4mCWGnMPg7IK88uqAWOk=;
 b=UUeFh8JVM8wF3XV18iIILph2uoyduHjUALMcyKlmVn11pM0dDAwm2HSthnzJ4WCjPyq77gLLpAVXzbPDe33UxNOcPzPHHWSEZf6ZYuAENoDYReLaRHn9d1vZnTne2Ra3wv7qTc6yFCRafEiYK/RMk77xIDhxU3+vMqLAKIB6ooNbefM7f9MjJlbanQ8QsyTJEUrsOIRnvGDuZRQm7TfVnWD4zggBTzW6iEdGR11kXnBW6WHdrr4rvMbkOvOnYYbY23tFAaEF5Rrw77gok+0oe3rznX59zu19g5dxXHBy0U94gCZwv7fqCXINPskWmsSqc/X6pp1WqU90UOyCwa1TYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShCUBqUh/FFMGQbCL+UDs5J4mCWGnMPg7IK88uqAWOk=;
 b=DiGUJQOK9w+NOuqgkc9ULsyx7NsRvsL0j7UDh1deLwdiabAf/lN0UvSINMWKOwvUKLL8/safo6pQ1bB4ZuhvBY14KTuX6IqVba5xpaot62Hugr17G8PGuKwgoovS6n6ax2d6vhvncLI8ymGZ3+PInHcqX6B6sfdz5wOCT5lvyp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 22:35:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 22:35:15 +0000
Message-ID: <bc79f3dd-425f-8f91-bccb-69bf263ed8b2@amd.com>
Date:   Mon, 19 Dec 2022 16:35:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 13/13] Documentation: amd-pstate: introduce new global
 sysfs attributes
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-14-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-14-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:610:56::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 830f872d-0beb-4770-459c-08dae2114c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/2uIVjNESel5UFcApADPiH8yT+ERaLfWOQh9N9s3RjPwRHzRXDzN0/xN/y8X6GQ7pS3I2aItG9tPNRq4PPGuu19DHrx4kFQZjuggCHvF320N4KxgKs8lCeDapI/XvtGkJdxtv8LYuLJV+kQ15yBTmqWxbjiUF/BQp1TY8vx2XKd1ftGowsBiW/oE3wZFanTXf5pe9PxHzMqCNowUOm35AlmOinTm/UIsxNSesaM2bWuZqyD0RV17cwBrJCeVA54mzyIp2NjvE+LXbNeJEUICJWPY1FBl/Op30j2HhfOE1na9jS1nhIP6ehfuPBrJ3Ev8FtIqQnr4ZiC2b0xslY2hbRP/kth5d3GUnWJvPQmPJacxwOT47vHcpQdFiWPae549+bk8hMDcdhfpgK3HUcLjXoeC4nnf+pkq6uCLOCZqGOFUvhVbJQpSA6ZqTN3BV0CsjUUPXk7LpxM+jQhayeAOOedtUmypw+Bk4D4iKAuc51n13aNzK6tNiS7jfFQj4Wd4/xhUItJHlGSA/WRw/vtLXSrfCuq6FqnTGWlTqVrcXxAlBKG3XhGoLsx0BOy5ME8XqN3wGp8j9uvFUFMlcDuyl4E/M/upS0036svbK/l7tphc9Uqwo5irFgqENYmP1raXWlUPG09m/WHoL7dfS/uQgpnSH0h9AbuJ/J4p+bdEVr9hJQEgAKloIBxgq/62cHIqBd4IRCjp4wyEAL/Xqo/4hGi7+fWuSrQpdF3epj2J+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(31696002)(86362001)(186003)(31686004)(53546011)(66946007)(4326008)(66476007)(8676002)(66556008)(2616005)(41300700001)(8936002)(478600001)(6486002)(6512007)(26005)(316002)(6506007)(2906002)(6666004)(38100700002)(83380400001)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmovVDJUeXJjZ0FxS2ZLOFZwZ1dZY0NJSGxaTFhkMHluaTJnSXVuSks0V3By?=
 =?utf-8?B?Y2x1VUZUNUZuanN1ZTl6d3JMaHBZZ3hscmRlYVM1MDIwd0hpN0pJK0Q3UmRh?=
 =?utf-8?B?Z3pxT3FjWkNZODVKTjROc3lyaG5vbWxNdVBFMFdEOTA5VytPNnpaREZsQk1z?=
 =?utf-8?B?WTltaWx3QUg3N1hyYnpYM2VMNEJDanJsby9IdmorVVVReDNXZ2FENjhVQjAr?=
 =?utf-8?B?d0V2WU0rV25tWnFGRVB3Qk9UdDhWb1JtZE0wekZMTlY1aHQvc1U4UDdzaEFp?=
 =?utf-8?B?ckN5MnZ5ZDY4WndLa0RNN1VseHkvL2VRZ2gwbVBqNHpPc1d6ZU1pY3RVUkdp?=
 =?utf-8?B?bVIrUDlFMXdMRWwzOExiTHo3R1ZHMWtHUjN3dTN3dGhabXBDNGlyVGlrZTdx?=
 =?utf-8?B?NzNOa3hTN3drSDhzWWlhanAvVGtsbXRGWnRjd0JSSk5aS3R5ZjBobnVjVHVa?=
 =?utf-8?B?bGJiZTBRc0pCdGtPdEhKMjlEdmFBMUtHamFkNG1vQnU1NTEva3Q3RjlKRDNO?=
 =?utf-8?B?djVTREwrRUp2c0xwSVllQ3QrallvWWMrK1g1QTczcnVxUUl0Vm81Tkd4c2lv?=
 =?utf-8?B?M0ZzUGxYSDEvQ0svTERFRFIxU0k0eVovdHU5WGRpMGh4LzNlWnkzTitwRUcr?=
 =?utf-8?B?QTZEQnRQUzBvUEwvMFVZZC9MZ1pPbW1UTDVqSFM3TjNxTThLNUwrZTh2TFpU?=
 =?utf-8?B?K1I4ODlqY2xLTHZpWEM4eGtxd0FBcVZXdW5DUk9EeFFWSVExMUNocEpMOEpt?=
 =?utf-8?B?bWM1a2FvcDBQcjdRMTFBRzdYZ2NacWNHTWFVV1ZUcTdSZHk4MWhPU1ZrbWFq?=
 =?utf-8?B?U2NPRmJtUFRDTXRUMzNOaE9hcmNlNlpBS0p2NEtDQmRpN1l4cUI4WG1Kc3ZQ?=
 =?utf-8?B?QXNPQktpTStCL0lOU2VGcmFTcDAxVVFQeERMLzlDbFdrUUx1ZzZuay9YTHdO?=
 =?utf-8?B?SjRjcTJ1cS8raTQzZ0J0U2JWUW0zWGFyWU5COEdKWURJeFRIWCtnWVBXRTJB?=
 =?utf-8?B?SlJ5SzdzV2owU0lZOUxxRTVkSWtHMmRGcjg5amx5dXFueXF6UldaM0E4RmpC?=
 =?utf-8?B?YitPUUcybWRwL2UrMWU0UlRBUVFmR28vUSsyWkp6cmhoaUVKZnpqQXpkdXJt?=
 =?utf-8?B?NmlqT1YyQkdNYkxEVDJyQXRWYlVLUVNMbC9hSTExZTlzS3cyL1E0MTBZaUwy?=
 =?utf-8?B?Mzg1WlhyOFhiZ002aTRPbUwxNmJnNVpoaDJGN21RSTZSZDQ2NG1LbmlGc1U1?=
 =?utf-8?B?K3VaYTV2VlVrV2hDLzgrMmdlU3NGUmtCRVp4ZUhQaXJnUWJYb2tzUFUyQkFD?=
 =?utf-8?B?b3lCQUc5TS9XVUVXWDBTK21JbDZPWng1Ukw4VWNmRXFSSjEzYzRUU05DUHpM?=
 =?utf-8?B?VS9oS1BWQ01IcUdHZ0hDc0Jjdlgxdk5aRHBoeVAwSXdoVXFCSXJIeWdGcWVw?=
 =?utf-8?B?OStnc1NZRmtBeVFrY3QrNGpyY1BFMmZqdjV0aEU1S1YwSlc5K2Y0eVYvYTh3?=
 =?utf-8?B?aUw1RzNIeFlCbUR5WEZGWXNoalBaczAxUEVXT2Q1aWV6R3ErenEyVFhxMVRD?=
 =?utf-8?B?Q0NOOTcxaHV6bmpJakNORmRndjN2NEg2UlNnMzYxbGlRQmorOSt5cUdlbnB0?=
 =?utf-8?B?dys4bDc5QmZUd1lDOFd6ZFVWNHdmOTVRb0xnczBzT1R5d0t6MmMwZm91NkZL?=
 =?utf-8?B?bmdhbWpudkpiaitOSlpIUHZ1K3BhaDBGUk5qS090RTMyNUNnNE4zMUd5c2ZT?=
 =?utf-8?B?TzRsdGRxSVF2MHRMNWRVUUhvMmZQdisxenpJUnFqNnJ0MFpGS202NHF6QUdq?=
 =?utf-8?B?RmlSYUZiMTgxUHNuS0lZdGkvNTlyejRrK0VvSm5rK2s1aTk5cko3Uy9FVHFr?=
 =?utf-8?B?U3lNMFd4YWlaWlY4eVhnQzdmYVRvKzJRYy82Z2JMOEZMdVpTc3JhRFRzRXll?=
 =?utf-8?B?UEcrTmpnSm9kY2hwb0d6bmRhMHhXVklhb3Flbkc2eTZKUVJycTZLM21LN1Q1?=
 =?utf-8?B?NXdrdjdnZ1dFY2lCSkVGdTVrdnZZazd2elhWYUNLbzNKdW5wMzI3T3l1d2g2?=
 =?utf-8?B?bm9nWXd6MVBDU0pDcStJU3d0OFJJbmUzaStWSDRMRFJPdFliak1tczFzREFm?=
 =?utf-8?Q?EHwk+Xl1pm759ogRw1skhekt2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830f872d-0beb-4770-459c-08dae2114c31
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 22:35:14.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fmnH7lEZ4o90n1TWebgPozoyf/W8ztwi4K39QyPSLRUUHGMic7fW3dOCz6JtZSBbV3jAuZbfwzrF9TAclwXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2022 00:40, Perry Yuan wrote:
> The new amd-pstate driver support to switch the driver working mode and

Words like "new" don't age well.

> use can switch the driver mode within the sysfs attributes in the below
> path and check current mode

Perhaps "The amd-pstate driver supports switching working modes at runtime.
Users can view and change modes by interacting with the "status" sysfs 
attribute.

> 
> $ cd /sys/devices/system/cpu/amd-pstate
> 

No need to change directories; you're demonstrating below using full paths.

> check driver mode:
> $ cat /sys/devices/system/cpu/amd-pstate/status
> 
> switch mode:
> $ sudo bash -c "echo passive  > /sys/devices/system/cpu/amd-pstate/status"
> or
> $ sudo bash -c "echo active  > /sys/devices/system/cpu/amd-pstate/status"

Another way you could suggest this:

# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status
or
# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status

I don't feel strongly which way to suggest though.

> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 28 +++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 62744dae3c5f..f3a8f8a66783 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -339,6 +339,34 @@ processor must provide at least nominal performance requested and go higher if c
>   operating conditions allow.
>   
>   
> +User Space Interface in ``sysfs``
> +=================================
> +
> +Global Attributes
> +-----------------
> +
> +``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
> +control its functionality at the system level.  They are located in the
> +``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
> +
> +``status``
> +	Operation mode of the driver: "active", "passive" or "off".
> +
> +	"active"
> +		The driver is functional and in the ``active mode``
> +
> +	"passive"
> +		The driver is functional and in the ``passive mode``
> +
> +	"off"
> +		The driver is unregistered and not functional now.
> +
> +	This attribute can be written to in order to change the driver's
> +	operation mode or to unregister it.  The string written to it must be
> +	one of the possible values of it and, if successful, the write will

I think this is implied that you wrote a possible value and if it 
returns success something happens.  That's how all sysfs files work and 
it's needlessly wordy.

> +	cause the driver to switch over to the operation mode represented by
> +	that string - or to be unregistered in the "off" case.
Considering the implication of my above comment I think you can reword 
this as:

"Writing one of these values to the sysfs file will cause the driver to..."

> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   

