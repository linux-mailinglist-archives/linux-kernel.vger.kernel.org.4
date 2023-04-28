Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08926F101D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjD1ByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjD1ByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:54:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2055.outbound.protection.outlook.com [40.92.99.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7BB3A82;
        Thu, 27 Apr 2023 18:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE+9ZNK9blFEVD3ZKRqk1uxcX4GmXVcPZPjNsDF7PIaf1a1d+9Yd/54JiqU0fUvyyWDfIXFiqovqfel1jz8Rli9iue2JYKxGbAx5TU5k4xvQwCi/2fVHxxydWEYyxU7166JuHm7Cb19QlaxhdvZOetUROYEUH4MhCk+L/aWpdbSlwaWKESHtOpqYp6VCy165tqzD9M59iTQmclal+W/v4eXtYKf16TWcatJqFuiG3cqVOsi/gyrBJxkNSS4WbZcWToR+SqmBjDCSUcLcEH7b+YGYltC7a+Zjh5f9KU5gYAW2Y1Wf0k8Px8CdL0ykw46a0LmahFzOyLRNuQQIN7BCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/DhCtu2AFYl2BEFvjDodkAlcnabRIvAr6fPMABjVyk=;
 b=S0wITDO8qhEsojDWnJ3hvE665fQ9986tmO9El3zLU4VVbXAs4qgHursWywzPPCcWj1IABgcTwZgOffp84uNMq9B5U+Tj3rRCOT2PJI3SkHinKLfDg+UiT2pokrXErxbyem0vLIB7hGfYmS5oKTQZBmQXItJv91VtvusVo99gYzR72OgHaaGDQDfO64MW9rjwCE0fGQGUlB51hWbhwsGUhun4iZUtuw5NQjzWe+MyGaYR3pWJtOsA95xLt7BwZWVVfHSCsVp9Q7uSlWkgH1bDKqEv7Yes+N/Bo1q6NQ4YmU+zC05ezAtN0NBh7buhAiPk/8ZRGQjlvSocD2h/lhd0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/DhCtu2AFYl2BEFvjDodkAlcnabRIvAr6fPMABjVyk=;
 b=ZcE4PKBkq34LpgVY6VwEWOQvyrvpXWAohFgTSNhc7b3heRyqy+6FcJotNx3M6h5Yr5GDJxsflzE5GHltyCJuzaw7tTaxMmekh8JSqNbd9DiWqnyhpl8wY36KkbieHU7hB8fOuUh/CJbqPy154k1TNu6uMQEfDm97/2iIfw3V6SgMPWJYvOXYoV5KjfBSOz1u/3uovivzjrj9rx8NXCJGf1DLjz0MSxNs7hPUubS3zJ3PiBypzkKbuDj+BoALKKCFpHD0+/kgDIUZ0CGGx5vpzXedAaz2CnyDfF20e9IbmbrDtBCdJopZX69j1jozlGDACsLGrwxGtiDN583+s+8VFw==
Received: from OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:ca::9) by
 TYCP286MB1730.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:187::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Fri, 28 Apr 2023 01:54:04 +0000
Received: from OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ea75:e5e5:1236:341d]) by OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ea75:e5e5:1236:341d%4]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 01:54:03 +0000
Message-ID: <OS0P286MB06283D2E74F02D7C541E46D79E6B9@OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 28 Apr 2023 09:53:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-core: Simplies if condition
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
References: <20230422121415.6276-1-yahu.gao@outlook.com>
 <OS3P286MB0632739A614E451725FF697D9E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
From:   Yahu Gao <yahu.gao@outlook.com>
In-Reply-To: <OS3P286MB0632739A614E451725FF697D9E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [e/IRxFVxlL5/S3MRPT58EjVmvI4FyFO5]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:ca::9)
X-Microsoft-Original-Message-ID: <f314efd8-a5ca-cc3c-9d3f-ff75798ce4ec@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0628:EE_|TYCP286MB1730:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e23ed0-a34b-416e-5d03-08db478b718c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1bu7KU3Jb+AhjraQQf7lU3Bezhzs8+RV+TZBNZ440Mu6keKMKAm9ZLbg3qXDjlYUlQcdWFg0XwYB1turwpdOCDb6shUdhvJv8cN8oMYw6kzFXtSMCDtGnuiNWgEtTHBeU7Txxk6StEZVXxz3J6Rvr+wje6rgklIBTNcRZNrQE4lior7t3X3r6dJuYJ2U6HEuxHUdG7Et78QIqcCHx4ErWD0dLDeHK9wssaJt3N73TIBdURSEx5pQpmZkT95BpDG5vd6buLmoUCWpBjZVcfy6PMb1HymhnkkXw2l9RTnN285uEK+CPraBW4zAD5XS8vgHzg3kJLoQauNSg/+ovvEHOQleO0UgbLuzj53DJZF+cBV7ZK8dIYuvDARg1p4dqg5Xe/KY+qEVhyT1R7eyl0egqGDBcm4GdubJBDvXzmugw+XCo5kph+YxZDNOsgdiFMS+KRZrDnRn9vcerBF0okrTRYo5Dwow2fuOAgkwpjMHyB1w60P+4qMUB67TOYlZp6QmODLdpZX2N4jKBJ7+RgBlDuY5uJ6eiqkngsGJ/yfWWbtPVr2R2wxexESM/CEaM8Y/lPLzWhVabiI0FslXboav6lsDMja/qVHLLwngZTeT725EoWeBedXPA+5l536cF7h
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdWV3dMYUNIaU50UVVlVVhGN2x5MlF6dmZNWEptcDNsQmlQeEJvWm42bFhu?=
 =?utf-8?B?bkxNSzhjd0RVaFB0Vy9vK1d4Tnk1aVo5TCtFSUcwbG50ZDJKQXBjUTNuU2pr?=
 =?utf-8?B?QlZMeWFKdEppSUt1a1lSbElOendjaWZySkRjVjNWbTlpN0tFOHJrUU45dUhi?=
 =?utf-8?B?d2k0bnU5RkpnVmZRTlo2RVBXTG5RZ3d6K2pFc2c3SExETHRqYkp5T2lpS0p1?=
 =?utf-8?B?QTVlNVhmb09ad2owM1JkZVU4U0duQkYvaVNsL2g2YXRUcXV0bXMwaEtGTFZx?=
 =?utf-8?B?QmRjaWpaUDdxVWFaYTFkN0xUazh0SEFBTHJlMFZ2UnZzVnphV1RCcGtsOWNr?=
 =?utf-8?B?ajZEVFhyaUpna2RaZDA5dUEzSUIzTWYyRzFUK21aWllBNFJ3SkdoczZJNWlw?=
 =?utf-8?B?VXI0S3lEeU1RWWRkdjVzYXdaKzBFU2xXK2IyTU9lMEFhcERRWm9iOXg2VVhk?=
 =?utf-8?B?TTZweWpQajVrYXhQU21sU2Iyb0pZYkF2SVJqdFF0MWJwQUdva1dnVjdNYXZo?=
 =?utf-8?B?Rk1WbDA1RTQ4SDhPWUt0Y0ZLVnE2QVN1TStCVVhUTU9jZyt2TDF2ODNTbG5L?=
 =?utf-8?B?T0FSQjRhT3JodHBKSlVxUklKNFRPRHA4RmtIUUN4cUlaTkQ5N2dlZ1drSDFS?=
 =?utf-8?B?V1BERlFlaWJZL3h3SzhTY1VuMy9QdFdBRGozK0VpUUhWRVVuOHFTaG5yWjF5?=
 =?utf-8?B?MDhaRzFMTVN4Y1Z1U0RrYXozY1Z5K0V1LzBNMEphY0RZSnRVZytWVUthQXF1?=
 =?utf-8?B?azFZaTZsNDlocml2OVZpcms5Z0s4TFJXcC82Zy8ybml4VlVRVHFIajA4bC9E?=
 =?utf-8?B?OGNqTkU3T2JJZFFYN0dTQkJSK2hWTFFVZVU3eTBsc1dxSDdhYkJUZTc4M096?=
 =?utf-8?B?VFdyeHR3bXdINFZxWk1idEQ1Z3oybXl6VStLOWRYblg2aC9Rc0x3MGxHNysx?=
 =?utf-8?B?a2dpYXJNK3RWVnpTTUo3RDFJbkNMVG5maXZ3Z2hpNG5XWjVmYnM2SXYwRUJj?=
 =?utf-8?B?VjNkK3dmQzBCRExhQk9BdzNoZFlpOTg3a2EzNHZqVzZpc0d6QlhCY0Z3Z0ox?=
 =?utf-8?B?QWd2NGMyeTVOanRZL3M5d1lwTFVzcE0wT1ZhaS94aEw3LzdUY3ZXdUdIVTIz?=
 =?utf-8?B?Q3Q3MUtON3MzSnMrOFdVQkFiNzRuRFZJVW5DYXVFcUp2V2tWbDVvSDczU2FZ?=
 =?utf-8?B?TTRaUWZmTSt0S3gzYjh4YTJNV0ZMUm9WVytURHZ2Uzl5RHAzT25mVjkwOG1s?=
 =?utf-8?B?OEFzMGlkL3J5Q0FlcmRtcGNJTlFYUWwrc20rNUFvNkhzbTBIREYzT2RqdjZw?=
 =?utf-8?B?OERWN2djbFlnV2wvcVhOaEFjZWp1cWdxQXNiTjRYbFhOVncxTXRJYi84V25s?=
 =?utf-8?B?aCtkUXhoMWJTLzhaREgxLzhKNnhWSURjOEZiQzFUY0tCaTVoSGcwTElTOUNY?=
 =?utf-8?B?UFkvMk0zRlpScDFPQ044VGdmdU5PZnVzY3k5R28xNy95ZjZIUTNMRjZxTHZH?=
 =?utf-8?B?K2ZKRE5xbjJ4WWVIQUZzZVl4bHNIS0tXb3BmYjF2enExb2paZi9pbGY2U1Jk?=
 =?utf-8?B?SFN4T2pORjM0ZjA1TERZNXFSQWtwUkQ1Y0w3OGJKMndYZ2JFYjlkSndqWUFs?=
 =?utf-8?B?c2pQS1JKYWg0L1d2cGY4aWtmb2pnT0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e23ed0-a34b-416e-5d03-08db478b718c
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0628.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 01:54:03.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1730
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

在 2023/4/22 20:14, Yahu Gao 写道:
> From: Yahu Gao <gaoyh12@lenovo.com>
>
> Replace conditions of avoid issuing [P]IDENTIFY to PMP.
>
> Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 14c17c3bda4e..53f65d751189 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>   		return -ENODEV;
>   
>   	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
> -	if (ata_class_enabled(new_class) &&
> -	    new_class != ATA_DEV_ATA &&
> -	    new_class != ATA_DEV_ATAPI &&
> -	    new_class != ATA_DEV_ZAC &&
> -	    new_class != ATA_DEV_SEMB) {
> +	if (new_class == ATA_DEV_PMP) {
>   		ata_dev_info(dev, "class mismatch %u != %u\n",
>   			     dev->class, new_class);
>   		rc = -ENODEV;
