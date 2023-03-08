Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DC6B0681
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCHL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCHL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:59:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA00898E0;
        Wed,  8 Mar 2023 03:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjroJ+U8R46Nm+hpTz0pxaD92awejLGCq0QgKY737uPPS42J+Nl19Lrx8gzRE55LmDzJUtYd3Sq3MP1jNBauLlz9wuEPyt5seNE1TQyJ3tJ2OKo34eiWT03o+EvITyzvr2I3SGuUdFNaP21nNDw8ROcvGaLQsc1jak80I7JXKbaVsbXQE5s07RnfqDvmCW5t9QylAFaXc9QgK2vbdpq0BKdPTS/edb5q6b9NZSvuTM5hZj9P5H6bW9Epsb6UAhSRFRayD/BmglrU3HnyJU+Qha6+EQXGJWBEnD2fMTvI0OUzVVmtVvCK5FUUNaytL0LPjfCsaLRJniJlXVdy+v+bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPHYvm6jtFE3qhzm8ftdKUYDwK4MkL+b6afEoj24EKM=;
 b=QH94dikXzZUffU2B1ZBFD0EMWxeghOsMLyPdaZAIojhSGdHRE9hqVk08a3ifGuDFUbHNaCAOJYkt/wCLX6XptlkRAPhG1KidHfXwtedUHzlnMkLP+rA+hLhkK9w0BQgafDHGJu6esrbeUad6fbKrDMux/iHW2R+nqiAdsHAyEyGlm+WIPJsAKiupB7W6gTW63o38cO4/VrmOxGNDMGB7E0ps/SBVXAWXv9oNoirCpcSnStad9aYhsl8AS2T7nTv4eJAsZ7LN5M0oFiNKzxVa1H8f2QneNNZeeM0pulbw0Sb5oinMKNQf2/KzUdTzQajraJg2P9YAW1GVXzSDnU2OvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPHYvm6jtFE3qhzm8ftdKUYDwK4MkL+b6afEoj24EKM=;
 b=qGFdRTzEhbPlu5Bnr10FEKvckV9agTSYU0yAua2oVzIuSyW8NN8686HN1lavsMNjzDTycXBKOyvGiKX0WV1C2C8vhWrex6x5J/eL3UKHGb4fYqrtqgttyhUK4tvrDR0PCHc14coOBgzY5+M6Cup9LEl6Ixcz+ALW5tvKeexZu4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 11:59:07 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 11:59:06 +0000
Message-ID: <a5bb0516-9a21-5d46-d557-f02893ac8bf4@amd.com>
Date:   Wed, 8 Mar 2023 12:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] iio: adc: Use devm_krealloc_array
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230306152723.3090195-1-james.clark@arm.com>
 <20230306152723.3090195-4-james.clark@arm.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230306152723.3090195-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d08e9a-2a26-446f-94d7-08db1fcc84d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHphTyGSM0vxbfKHAxYsmuOxyw9+JdenO+ZZA48qrVOAx/MD8iPLR9eODVr+GafLE5fXc8Tj8kLSRM/aVdPnAZChAbyADutVlJAzaDsStVfWHrvl+VTpERX2iFvt0fEfctMidq7ShDi7oJn6Yacwf1ocefciRjipkQ/YJ3QTReuCSQqImkFzba1mrTgvqq+HW9wRF/CWdh+M1sSI2HsfbN3aSS7kKhEFw1A3milppzKCV3ht5ocEW8vHO9sRrO+nTN0S0AbQG3shk7K6qu3aMT8QgyH+Bmcb466YKAq/G4rCeYmmM0Rq6vUENGUoJ19F/1Ess6OW1UtUFZSdclLX+2Zc1fT67zYsAdnZuWKKzgwKC8gUSXqBtqkvS9fYKV6zEwuJ6CNemJhKzMOgQP1iKo+kBpQ2mlPZydPAvRSB0qrdv6JEIVvAQKbOzIMWmU/6dBTDJAZ/ueXt12SJ6F4OphXz3I5avtmna3Vwu/0+WSdKBo77D2wK48vaELvZxz2VkNpLY+uYIuqDIQCQuBAG89RWZ4MtSn1uHJIksDfR8ODXXqwjw7egn5zN9GK0Fx30eeZMjlOcJfA7RSTuBIzPV3S7bOoGfI3jIIOEEXP1MMaEciQmvvPqQvLPiw6vpBAVR74xOuAr5k9+sLrybGjutXx2ykwpw8ntqyJw9QOg8Fcm2amTvIKn0M7ObR3EK7wBpci0bRpOUego7Upw6IcXiArJkcpayRXsqTC8jfhYMHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199018)(38100700002)(478600001)(316002)(31696002)(83380400001)(5660300002)(54906003)(7416002)(2906002)(36756003)(41300700001)(8676002)(6512007)(53546011)(6506007)(8936002)(4326008)(26005)(186003)(66476007)(6666004)(44832011)(31686004)(66556008)(66946007)(6486002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Y4bXdIR1JEVEU5NEZSdGpkUkh1TmJnT0JsbWh0OUdhOHVoeWJnSVdQS1hK?=
 =?utf-8?B?RVBEQjZzK2k5M1NYSktxLzNNY3V5WUpNVUd3NW1aZ0ZKcGplNVRlekIxbE94?=
 =?utf-8?B?c253ZnRYYzFtM2lEQjA0R1ZFZjMzRkxVKytTNURCZkJDSkw4SkpyRUNrR2dO?=
 =?utf-8?B?SVJQaWUzZWN2U3h3ZVNac0NmdTNwckZyWkQ5RVFxYkJrYVZ5UE51L0pVQ2xj?=
 =?utf-8?B?RFFidW1xaW9hbFNicG14b05HcnZlRm5kL3BGZ1ZKdExRZ1o4em5sc093NjI1?=
 =?utf-8?B?alBOYnBWbXpVbEZwL2VlbXlGRnNlcDRmUGhRZVZKNURqSkl0YUNlVlBtUWxS?=
 =?utf-8?B?cjNQRnQ0REQ1SU01R0pzcXhDVjYvbDVnTEh0Skh3TjdFSnBESk9raU9iejky?=
 =?utf-8?B?Zk5YVlVLTEZLcDNNai8ybVA5UjRTQ1l0WnlFd3d6SFg0VXJ1eHFkOCt2OG5H?=
 =?utf-8?B?MDhVY3QxRDB3aHRlZVpLMFIzb0VIdk10RjRiY0k2RmFidll6THVSM1YyQnFE?=
 =?utf-8?B?RTIzOTdPTnJMT1VJTmJQVmJXNyt6N1ZxRkM4RmtZMGZ5TmlqQ29KS084S0lG?=
 =?utf-8?B?eTcxS1dFQlJ1OHhycU1uVDhnOTNGZ0JGdW9JVmd0dEdSSklHWHdvQW5OSGxW?=
 =?utf-8?B?Y3FwWGJMcFhvR2VQT2o0Zk95N3lxbXltOG53NjV4THBhU3JYTTFEbkozbHFB?=
 =?utf-8?B?aCszWE5QWHdZenN6MWNMblRSMHowcXBlZ3F2VDNjTTFGRXNLSDVhWGd3SjVF?=
 =?utf-8?B?b3VrajZPditTY2g2QTFHcG5QYnRnOEYyMUgzQ0FDVGRFK0s2VFM0ZVRHRFVL?=
 =?utf-8?B?Slc4ZkVVMjdmVkE1R25HMkdBU1pVTjVrMzhnMDQ5SnpGYmE4ZjdUdkFGVkxr?=
 =?utf-8?B?Ui9HUHJkZDRKSVdIUGZRZ1VLVjNWVDVUS0JqKy9qUVR5RUNJQWVTZjdBcDhr?=
 =?utf-8?B?YXNwd3J6WkFodmU0OFc2anZlYW1iWVQrNCtQemMyWWgyVVlRV1h6ZlJUeFU1?=
 =?utf-8?B?MEpNaDlOSEkyZFVZb09mQjZ1ZlNyYmNJU0cxVC85NzhHTFdKa01WcE4rS2Fi?=
 =?utf-8?B?NDhmWUJmWmtJbmIxOW8vUlR4TEJ2YisrT0hmdGlxSjgxZ0t4RDRIYVhkT1Jm?=
 =?utf-8?B?cXBxRkViTVlsemtpN1ZzODBldml2dnFtUlNSRGhRZ2JwN1J3b3NXZmdjUzlN?=
 =?utf-8?B?ekx4Ym9NZUdyK3VncHFaZ1hPYjMwMENqZGxDRXZFNEpwYWZmbHNCeFlMTmhj?=
 =?utf-8?B?cERBcCtXbDl0YVFtOHUyYXlIZnFJTkFBVFFwa1ZXRW9aVzhUSWRpTlFxU2tK?=
 =?utf-8?B?MUppL0NSOE43bDF2eWxlVHVsYVFadkV5dW4zOFpidDNpOHYwS2lqQjJoYWU1?=
 =?utf-8?B?R3JMT2tnNTV2aUhzY2FtRjhBb3VWV1VRZXg1cGs1bHJrSnNuek1BZTdIRkNQ?=
 =?utf-8?B?NnZhMEtkQWQ0Z2dPeldJWDFDY1oyNUV1aEh3cFVoRllhUW5JT3pka1FYV2Fp?=
 =?utf-8?B?aHl6QVN3cTRZTjZQWUJLZXduTHRsM0gzbHYxNXZaRHpQWDFJeEtIUit0MVk3?=
 =?utf-8?B?Y2tra3VxM0dobVhSQVErVEVNMGFJelJWNTNMYVdJM3Z2c2ZGbGp4bThLUDl3?=
 =?utf-8?B?cis2MmNCVkk4V3FEOThGdUk2OEpzV0Vicy9XcURMZXdzWTZSbmdZUW8xaktM?=
 =?utf-8?B?aC9tRktoRkVuRGdOWW0wQUE4cjNpV3M2d1FraHloZ1NxMjNtOStHa0svL0M0?=
 =?utf-8?B?di9aMlBUQmF5SWlkK2EvYW5ldFdJcEdDNWlwNy9hZDdLTEd2T1FJSFJ6VkR2?=
 =?utf-8?B?VCtERXhIbVRSUW93dFF2NUJWV21lVDNJcEJxRjhZL2E3OXBUZ1VJVWhTdVZa?=
 =?utf-8?B?Tll1UUxwZXZYaHZqRlJmbWZaQXNxdU5EL1l5dXNWUkdlMlVSTXJsZlc1ajBP?=
 =?utf-8?B?dWJlVWpLVEJhYWxCWkFpZkZMVjkrSTg0dkd2bFIrZVpnYkJBeGs0TzF6Vks3?=
 =?utf-8?B?cnJuTjkvdUxJbmx5dG4rVE9peHBqSHNsVm80UklBY1JMZE9EeFVFSUtqbnc0?=
 =?utf-8?B?RUpXbEJiNFVQdkEyK3hLWVBiaVJXZmVnaXJMcjRqMzkxK0lZU0Vma1VCSVJw?=
 =?utf-8?Q?AkfjUVPb42TK9zM4/Qu02yNCp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d08e9a-2a26-446f-94d7-08db1fcc84d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 11:59:06.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2lz9kkwDIlmUua0SocllbgHfq4WmS/M1IAYI/h4UEfloKwEKhO7gntcq/Sw1k5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/23 16:27, James Clark wrote:
> 
> Now that it exists, use it instead of doing the multiplication and
> checking for overflow manually.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/iio/adc/xilinx-ams.c       |  9 +++------
>   drivers/iio/adc/xilinx-xadc-core.c | 17 +++++++----------
>   2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 34cf336b3490..f0b71a1220e0 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1263,7 +1263,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>          struct device *dev = indio_dev->dev.parent;
>          struct fwnode_handle *child = NULL;
>          struct fwnode_handle *fwnode = dev_fwnode(dev);
> -       size_t ams_size, dev_size;
> +       size_t ams_size;
>          int ret, ch_cnt = 0, i, rising_off, falling_off;
>          unsigned int num_channels = 0;
> 
> @@ -1320,11 +1320,8 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>                  }
>          }
> 
> -       dev_size = array_size(sizeof(*dev_channels), num_channels);
> -       if (dev_size == SIZE_MAX)
> -               return -ENOMEM;
> -
> -       dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
> +       dev_channels = devm_krealloc_array(dev, ams_channels, num_channels,
> +                                          sizeof(*dev_channels), GFP_KERNEL);
>          if (!dev_channels)
>                  return -ENOMEM;
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 292f2892d223..287df3bb951e 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -613,20 +613,17 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
>          const unsigned long *mask)
>   {
>          struct xadc *xadc = iio_priv(indio_dev);
> -       size_t new_size, n;
> +       size_t n;
>          void *data;
> 
>          n = bitmap_weight(mask, indio_dev->masklength);
> 
> -       if (check_mul_overflow(n, sizeof(*xadc->data), &new_size))
> -               return -ENOMEM;
> -
> -       data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> -                            new_size, GFP_KERNEL);
> +       data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
> +                                  n, sizeof(*xadc->data), GFP_KERNEL);
>          if (!data)
>                  return -ENOMEM;
> 
> -       memset(data, 0, new_size);
> +       memset(data, 0, n*sizeof(*xadc->data));

this is not correct coding style.

M
