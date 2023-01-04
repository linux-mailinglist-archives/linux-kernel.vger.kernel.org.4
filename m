Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C865CAF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbjADAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjADAfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:35:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852801571C;
        Tue,  3 Jan 2023 16:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsmn2us+WHiuOj6HyGwt7OEiZGXaAxWc6ZvV673CWa9hS/hFvuRWjxnWrFhskqACO5nTijQ9thZkvamHZeIm30D8eNiOTNYbwIVethKbhfocIMBgbffdF23eCzYoXtfnzp2UxSRDD1JlF71r+5vnuKWm21z4q0RrFfBppg2LYG/DarwlPkNXQGa8ujNAQhUcr736wWsDV23tBPAYdaZ/XjSNMFTfezvNcCNQfyX/59deynCn7HklhCVUMLaAp4L4rOBDhIlq1rYLT/+r/0Lc3qbqzd7iGkEcCozIFEmFSYP+dZgJet1vLQgAfEYidyNN9zMbDsHgtzj+EDsmJc3ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQP/NHYZmct81cDi+Vhhu5EP7nwImVwKCwoiqWKKlsY=;
 b=n5chLpUYyOmg6KTMnZrsoUBq8QrZypPmLGVs+di4gVfcKihe16EbKqiTEmH4H08vCDVQA8ellgyLeLQTpgKr/hO9mRp8de6jbZVlmtesAWiVObm6j3+3gOdwsv41h4j9jWmWiesSnivlcQ9KzYJeP8/XvDslqQutikKa6mNTgprdp/WEnNoaySra5PMzZfOcRqMMq8HhZKvbSEyt0apx/DgWiJTlBpS2wKIhyoAAzWrZoLshOcdkR6/MWwVHLolx6TMddi6EwwyAPI8whr0DU4uiqRICqGntaK21Ibep0+h64IAbwVfRW7Wz8avUpcPXtpGYBis0J3QhJWM9b4PaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQP/NHYZmct81cDi+Vhhu5EP7nwImVwKCwoiqWKKlsY=;
 b=R1SokFj8lGDLYoFImbGrUfi8yuBeEFAqbnVLVbamyc8Gc49TUCqcSjn6hLEUWengYw5Xdc2YCZHT2yUcvoR4NPGW2+RNEX1vsggkSbXAjWFl7EHMgM+4umxf95xI0rzWgw2vPG0PkqwGGXo9VeFpBAAh6UW7W3VK3HBmWCOeRrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:35:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:35:16 +0000
Message-ID: <583d3642-a79e-fee0-5c90-84eac82c3812@amd.com>
Date:   Tue, 3 Jan 2023 18:35:13 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 13/13] Documentation: amd-pstate: introduce new global
 sysfs attributes
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-14-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-14-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afb9b73-8859-4d98-1498-08daedeb8cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muTOzSv34djM/DpbZ5ifa4ue2rXbDg8ptFBsReAQa+f9cZM7bhw4dHGBJCLPt38LA2gVRO2n8Ev0Ly7fmfMMJMzwQkohJyUNN0T4skBuy33QiN4mJvz5X/GqzgKakOCkECyAUWhy9/yMMvcA6Njwg698EeMK1+YjGJ+bhX7PHs5TludT+tEONiLg106o4uoYqQuP3xfE3NpXep4l+aqNwGkNOCUgOvyLe2DUuqQHs6nrBK04p9xvyB89OB8WwlhX/BJE+t6TGcb4LqbBLPuOY62CMawi0bmRbBNi3iTuAtXJVSXeZvsLEDXunfuQ6juvkU0Ef3jJJ20X5u6xqUw+PKeBzWOyfy0IKwI3tI/E9cuhSWadT6hX+H4Xgk3/diw6q8B2JOPir+mFSOBBwQgh0o4K37Kis0fKLH1Uk4buSr4nNwJNXv/5hvguWRrzCe6R3Wz5Sf38wIrNj2OaohffGeoQCrkfRNTxc91QKOVvsJYvD7r50p/XCuhlsJU7Kndrst26Kiik0endNrPbgg0dGx6Uy3aCl6ryGrp8TokCbySm3qjzdMc00tmm8YKFxCgL/AIqVJvXgt5TXxzi4hsjC7akvv+eLbbKx4cXvQkiPf6xMBrudjuTw7HVc02NQ3NGfMyWDhrJ/9QZZb/OYdRAvizykg6bd4aT9jpR1HCdOWPQgoW6ipNEZoZOjvtLJVtsa1QRYLy1IdilVY+u0G1a3NFM4oGuBdwNmKEcwVR203o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(83380400001)(2616005)(31696002)(86362001)(38100700002)(36756003)(2906002)(41300700001)(4326008)(5660300002)(66476007)(66556008)(8676002)(66946007)(8936002)(316002)(186003)(53546011)(26005)(478600001)(6486002)(6512007)(31686004)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGo2K2oxNDloZm5JUFM3OTNQeHhSK2VzQUZOcHZici9wRUxqMEswcE5jcVFs?=
 =?utf-8?B?Y3lLYmRBbkdicU9kL1BKWVU2UktWOEJtTlMyUVpHdklDUkVJNG5FM2paOVRt?=
 =?utf-8?B?OElQVWtJTWtBdmdMRDBoUkRnaUpaWEN2NTY0bkpHUFg1Z1M3M1ZRdndGVERn?=
 =?utf-8?B?YWRZMkRRelMxaEl6UXRZMW9CUU1GMjdCdmdCaEcrMktZaXBGTzFpMHRrdGFu?=
 =?utf-8?B?RHRLQVJDYzR1RmRpOUlza1kvdUI1UENqN1ZmYVdhWWdwVUN5K0hwVVdTYTVH?=
 =?utf-8?B?VnhURFJYcXJVVWZwN0l0dEUvNlVmVUZKY3h5bzc3OGN5Vjh3SjVQT0lrN2FO?=
 =?utf-8?B?TUFjbHlKN3BYUXY3Zk96YTJ6S3ZsY2xjeXJDM29uOVlsaTMyK3lwWDhsRmhm?=
 =?utf-8?B?SHhiR3pRYXgreVptZWtRMEZuNnFpbjBXTWxvMzBWTkZsZTZVVmN2enpzR0hV?=
 =?utf-8?B?Zm5QVHZNVk5URWoxdnFES3kyRkh2U1F4VVhYa0s2UHNRZ0NOUjQ4eVV5U2tG?=
 =?utf-8?B?eENsdjY5QmlRYkt0ZXN2Sktsb1VycFBaMFc0Z21NeGdHK1B3NkovZWJwQytO?=
 =?utf-8?B?K3UyNjlTckY0QnZ0a2NkY0RveFNKWWRoWi83TlcxbWx2cFIvOC9mYmlFcTBN?=
 =?utf-8?B?cnBzdlpTK2w0Vkl0R0s2R3BneitOZGVCOVkvaC94eEVEM1dMWFBpUkZLeTNL?=
 =?utf-8?B?ZnNIWTl1WHFDMjV6TStvV1lMTVNYRUJrMVZHSXg2T0dmT3JKR0dqbXV6RDdV?=
 =?utf-8?B?ai84ckx1UUdwa0VNOUthc0NyRTBYZUlaSTlJUlhaK2lZQStSRVlHOVpYVXZx?=
 =?utf-8?B?c2QrU3lkRTAyU01IbWNhSDJYS3hEM0svU3B5dGhVRU1RekJEaXRDS1BxU3ho?=
 =?utf-8?B?UXVJalorRkdXcGloaGlxZ3kzcXpySHQ2U2FxWmFDU29jYWJudGw2dDVSNktE?=
 =?utf-8?B?TVdLVS9BdlloWTJ3K2Qra0ZFZXJWbGlXSGIxdSt5SG9tTGVBLzRQd1hxVmhR?=
 =?utf-8?B?SkoycUUrYTN1dWdFa1pXekpZVklWNlpLZ0JpUlYzdE9vVUVNK09JeSs5UXRZ?=
 =?utf-8?B?WWlGczRVTkRsTEV0TzBvSzd3Q1RhRi8yVldPcjg3TDRja1krdCtLZ2x2NWpY?=
 =?utf-8?B?YTVDQmxva1pySUp2cWhIKzBjbzVyVTVBNjFPUXo4c0Q0Z25MSTlZOWVmdFdj?=
 =?utf-8?B?T3BZdUZlV2Z5bzkwcWNHeVdHT0FFQldKemc5UmtXLzFxSXpEU0hYS2N0eGtV?=
 =?utf-8?B?akZIc090VkpLLzJmSG5JTWc2RjllY0RsYnpORG8yRGtsN0FiUTB0TUxYeDZ2?=
 =?utf-8?B?b2swSXh0WGxldXdIS2VHT2FBNTNIR0d2VDlERFlTL09WcGphOFdlZ1lrUUVT?=
 =?utf-8?B?d1QwbnlpUEtQR05Td3paTGRLRm1IL3BxV2VDdW10dEFyZmh5MXBzSkhsUkVE?=
 =?utf-8?B?b0VnUHpyM0FWZkFjQ2VTcXh6NnIvU0NDWnBxaXh4MjFsRHBpb3dMamZjd2lm?=
 =?utf-8?B?dTJKMGZndTAyUXZHWXd2andxNnlvemJsWGh0bzRIZWRhNmcxbHB0MkdpazFU?=
 =?utf-8?B?eGthOEI4U2FTcEl0cFc5RmdZcUpBa1FBTUJuYytSby9kYUxoSXNoWXdZdEc4?=
 =?utf-8?B?UnRDd2NuNUFsWmtqdWNGS3BlQkpoVnJUME9xSzZpZTZ1QjlsWCtSWGhScFpM?=
 =?utf-8?B?SkJvdkFXd0xkMDVXblc1MUlxWmRLZlREaWQ4ZFU2TU5aemFITTc3T29IRUZT?=
 =?utf-8?B?eWdnYlM0UnMzSkJvUW5ueGNzM0hNRDI4cDVTbkQ0WU1qNlc2cDA1MlZmY3U3?=
 =?utf-8?B?N2JBV0N1RDRGbW8vdnlxTE5NVlJkenp0c3Q3WFdPbEhKWnZiS1hpRERhbkxr?=
 =?utf-8?B?SG5JR3J3aWxQSEVMNnRpK1pDbTV6WVBpczl1em9GZHFHdVRQZmVHNXRVWDJG?=
 =?utf-8?B?dDdRbmhiTGFsNjJjTlczTitUdU9obUhGb1VVNXFTYkVuZEM2cXIvQy82UGw1?=
 =?utf-8?B?ZVcreFl2VkZlOVk0YUhzTHRkbUJiSmdvVGtjbWxLbi8wdmZzRS9zRngralJY?=
 =?utf-8?B?MS9mbFF6VlFGak94R1pwTUJveFIrMXdjV2g1eGYzTWY1bFU2RVl1L1h3d0Q2?=
 =?utf-8?Q?ZMFtHA2eDLTnRrSm5a4bAey/1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afb9b73-8859-4d98-1498-08daedeb8cb8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:35:16.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOES3A905DUsvsiM76BOG4Euom12iOC2awIf4lpoyF/r+p68rkhnzxOlOsDy7WVNfhtjOFfV31W7+kYtdIN49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/2022 10:34, Perry Yuan wrote:
> The amd-pstate driver supports switching working modes at runtime.
> Users can view and change modes by interacting with the "status" sysfs
> attribute.
> 
> 1) check driver mode:
> $ cat /sys/devices/system/cpu/amd-pstate/status
> 
> 2) switch mode:
> `# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> or
> `# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 62744dae3c5f..5f6379475b32 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -339,6 +339,35 @@ processor must provide at least nominal performance requested and go higher if c
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
> +	Operation mode of the driver: "active", "passive" or "disable".
> +
> +	"active"
> +		The driver is functional and in the ``active mode``
> +
> +	"passive"
> +		The driver is functional and in the ``passive mode``
> +
> +	"disable"
> +		The driver is unregistered and not functional now.
> +
> +        This attribute can be written to in order to change the driver's
> +        operation mode or to unregister it.  The string written to it must be
> +        one of the possible values of it and, if successful, writing one of
> +        these values to the sysfs file will cause the driver to cause the driver

"will cause the driver to cause the driver to"?

Presumably you mean just "will cause the driver to"

With that fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> +        to switch over to the operation mode represented by that string - or to be
> +        unregistered in the "disable" case.
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   

