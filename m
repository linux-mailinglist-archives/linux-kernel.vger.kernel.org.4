Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC6686591
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBALuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBALuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:50:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998261863
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=judxhkLu6pcz5krPirxPtKH8qzLKUBfcTDwu3r9BppGk9czZbipGvmnI+9C+eEmr8wDVVKarFXCkotRkMbMKOYO5OP5V6XUvEaYt98PCdV7jlOfjzoWwv8iMyz7pIUXgQoPSV3alu36MOd3bZGj3DzV3HmB9iFbW+a0hJ2IqNvXnkCYgfQCJFnJqew4z2cAEcf8Ih49Yx85jcYyOMGFOrrOBXu4ufkHs2bcHu5YfOMEfAk0o8ztZ7osk934mUKlvzUeGw1mSDMD+0bJR+yqnIVackiBt5rBdfo5sCI2WyvBOK/k7yjCk4rQQaOlEC+nobhvEVvqo/DCn6s2/hCxhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRBLlarkG8lwvm5xNjEHG7EgOrXIw6sOO/Ntf6jA1aY=;
 b=AKI7AyPpzt9/su8+kXwFS9jDQ+is/NfHKW1MnUS9PchvEAjlKWPe+mmmddZYjJLplmBWR0AdZq5DL/21mRCTqqKixwgrdfScAhwppv5WujDGHPn8xlaFDtKJp56nB8V4uSgMpmIfr7vlMbVVTmmCRD+xMTnYXwO2UXEGvCTKVdcS0Y9+rrQQeHbzdzz2fW64N0D3kxoTq3SqmsT6+oaD6Q8H0mBsePxQ9c7pfsNRS7Te1SV2V5vzKn08mI73vT5Toz0jsOMimZVOOx9XsPEky6/r2C6VByu+AYQ0lzsWgkcJlOvNMXHYTzykhocsGA6RdTmlAb6RpwbEKA2QV8WXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRBLlarkG8lwvm5xNjEHG7EgOrXIw6sOO/Ntf6jA1aY=;
 b=I1tmaO9zx+lJ2rnGVW+sOjP8I4sWQQdh7dzMeUaUzhFdLCGmfgOyDfO9dMIC2Df3XMPpKne5tiybaBMl1DuUkqSiYIaZtCDHAU4OfEoeDomtKO4axXSfvisYxhzhav9kNttJDDjnWPERKgaSAnSpMVZnjMvFKXjpBbwVwyGuu6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AS8PR04MB8452.eurprd04.prod.outlook.com (2603:10a6:20b:348::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 11:50:15 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0%3]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 11:50:15 +0000
Message-ID: <d6297aae-7f9e-1b4e-d2f3-da5664804ab0@nxp.com>
Date:   Wed, 1 Feb 2023 13:50:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] bus: fsl-mc: don't assume child devices are all fsl-mc
 devices
Content-Language: en-CA
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ioana.ciornei@nxp.com
References: <20230127131636.20889-1-laurentiu.tudor@nxp.com>
 <Y9kB8F3Nls8d1Koi@kroah.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <Y9kB8F3Nls8d1Koi@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0009.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|AS8PR04MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3a571f-08c8-45a3-1091-08db044a7b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJlSJZd2coFkqHKN2EWCmjXf4BfLEVvQGxsao3JaR1KnvP9ZZafO9J4TYEb0HG8Tb//B1ELX7OghWknr2tD/38bfaeWuuJbd7a4aQ09KiuDs6bV4DLDMgC+J5UnHfD9zc1VtLxCS540S9zXgnkzMadzsy5GemLZrD6mns7z28wj+ik6Q5jXOpS5J66hyhHehzMDgeFhNW3C3nd/6UlKgrR4byZd13W3/fplP7KcODKSl1dc//kXLJocscwuErIS7ZK9uodxZBOuhkyrKYlvcax1Lw9kYbbwcslQY7Ohzp3aZMmm0K7fPXgal2NfrBH6rffaN4kkuKER1IVGMZjzcGwl3Ya3oxEnaNQY01GT4PJ/19GTC1Z/gVrjJ4Nh3Hi+5Kutmr2dJr8B6gZsDRIMQH9yoBlvPB6pnU/ydlm1thfaxUwmcrA+uLYgCoSCePgnnztaCVwvYsp9T0K3MZaySNChnkQLXse6RoefQxietNeycbXip/Ct5zzBWuVdDVgN+gm/+m3gDQlZP7JM0Y8a6g/zC6BXju5guTkOog7koickhythfX+Aum5lcQ/1D/tZC1FwfDRwRHVJTPSkJgvu22UuT00egZkd9LBRUGRQRwXEpSWWXLuTOtMeGRtFiMb/oFxektkrOAJpeUIL4UChwEVmITzL3bUYahHsLTb9n2BsT0o/FoNUr5sJF/oQZE1LHR1Xt1Yts/ziuj/ymIM4nmqDHIKj5PKWuOLjqZtHgl79UGnw1y48FR0bamIUVFProAdnW9Yb3FIG7Wd5379R6ElrrcGvti0oQwubaBoR1iqoAMT7xANMPT1mdqhYMVSdggt4Ybgc0mVqTMhFdjgG15Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199018)(66946007)(4326008)(66476007)(6916009)(66556008)(8676002)(8936002)(41300700001)(6506007)(53546011)(36756003)(2616005)(316002)(5660300002)(38100700002)(31686004)(38350700002)(31696002)(44832011)(26005)(6486002)(86362001)(186003)(6512007)(52116002)(2906002)(966005)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGE1SDJpYWlXQzJOUHlNQTYzalBCUnFLdFN3V3duKytEQ0tpSkF2cGYyK2Fw?=
 =?utf-8?B?Q0hhZll1Z042SVVjbFQ3NDY5RlhPbmRBTjE2M0lGckRydFpLZ3BaVEQxRjNX?=
 =?utf-8?B?L1FrYTBwMVN4ZGFrYU5Ma09sem1pV3B5aEc2WEhwV2pwTFFYTERLclNmeU9L?=
 =?utf-8?B?aEQ2OE5ta3FvVk9GZ3o2MjFOR0x3SmJMM1NNSWV0dk5ETHZNMUNWelZQb2hC?=
 =?utf-8?B?T0pNZ1R2NTc4VHdIMDg5MkdDQ2IwTlFvRE9XRkdZcWx1MitUMGQvMDFqelFJ?=
 =?utf-8?B?NnlhOWgrNjNqQkZ6djdjNCtSbUtYQkRHWGxtMVJ6VHFoaUdsU3phclNidVpI?=
 =?utf-8?B?eTZDTUhLMUt4NWVxdjY5TkcwaFBtbHltY3FXbXNXZzVIcWRyVjFMOGtvcWhQ?=
 =?utf-8?B?T3ZqUHVRam5JRlU2Ri82WG5xZ0NnNWc2QmpLZGo3eTJIQzA0K05ML2tGZzNN?=
 =?utf-8?B?UlVRQWwvMDJVcXNzTW1YL3ZzdktaTXBlbmVhVmNjUUx3UjNZS0JkdlEraTBw?=
 =?utf-8?B?UG9SVXNtZk5zbGlGVGI5RWsxNVhjVE92MEY4R1RUWmdGRVpuUXMvOUZFM2xB?=
 =?utf-8?B?T1RPWVFRZGhxODVVSW5FTzhualNHT3BNZXVWRVFmUFRBdE92RlpmNWZWSThp?=
 =?utf-8?B?OGE4cXNyZ21hNGtlcGI2Z3BIUWxkY3lVTU1DS3RWM2prK0g4RGNwWXpUdnZ5?=
 =?utf-8?B?Zzh1Sy9RTGRvOUVBWWRaTUtwSSthVTV5YnN6TzRZTVp2L2RqRlR1KzlnTU1X?=
 =?utf-8?B?SGp0VUhiSEFpbU12bnBQaUZ6Mi9TTWxDSjBwQVIzQWRIRnQ1eWRWM2tZU1lS?=
 =?utf-8?B?RXVkRnlUL0Z5OU9BaVB5V2pNRjZCbHYzeEpDb0xtcEdrQVZJL0h5cFcvTFdS?=
 =?utf-8?B?aW1PYXRtRDF5cFVxenAvaHVqc2RNVHhLd2NaL0R5dFVlbnZ0ZGFrWE9KZGRz?=
 =?utf-8?B?MEFzYytzYWpHLy9ndXpIbkxJNGpVekhiTS9tcTFDNHFzVWNUNk9MQVYxYnR2?=
 =?utf-8?B?ZTZ2RVR5WWdTQUVlZThQRmpMTlNwSmFiaW5TbkJQNGNpYVRjQ3BEZGFEZEJk?=
 =?utf-8?B?RTAwUldMQm5nSjlWblRyKzF1RmtlVC9YMTEzcFpwanFrYncwekdZcVhWakZm?=
 =?utf-8?B?bTBORDZTZEF2RjhDcDRacnZHRE1NbEp1cVdHVlJTK0F1QjU4VzdsOE44VS9p?=
 =?utf-8?B?N3ZiMjJUZXBsSnM1R1VsNXV6OVI2ZUVoOU9GdytoS1FSL2lsV0pXOVNIY3cz?=
 =?utf-8?B?eFE3ZDl2N0dxVUtxbUZuV3JpalIxdUZzdlRIUkZvTGx1V0RhRlMySFpDT1hF?=
 =?utf-8?B?YWFyc2NaMmM3My9KUzcraW5jS0VPWGo2U0RkTCt4eVIwOVl0Nk9mdEdIMDVK?=
 =?utf-8?B?b1Rxb0NIN201NU11UFVQa2VqZlNtb1J5QW1DT1BPR1AzZm91MTE4aWtkMHpR?=
 =?utf-8?B?dlVNRDJUNGhzQllGbEJXZ29LRERvcGV6VnlMekkrS1RlaGo3N1FRaDRaYTJK?=
 =?utf-8?B?TlgyTkszQ1dNMGlZQk9ONW1HVnRsek5GOXQxRkRUbkdYQjJqQ3hQTE50L3lI?=
 =?utf-8?B?czFJZzBkbFVCZWVYWXNGUW52NjkwTENGeEdwZTdmWXJVdFllbWFDMUV0V3RH?=
 =?utf-8?B?b29oYkVjUld0aGsrNUFKbEJQb2dpMmQvRXFRVzJkNk9Udk5kZmFQdmVvRDM2?=
 =?utf-8?B?ckh0cWJYOTJOUTI3Ny91NzZoUGIyWTR5MkRvbEQ0ZndMYTdoM0JnQWJpWTcz?=
 =?utf-8?B?eWtYc3M1ZW5qNldLdGZzUlUvOFViVmQvZTFNSXBpWEdvUVVPYnpKRE8yQWgv?=
 =?utf-8?B?UDVieTJ1RW44UWpVcmc0eXJkdnhWR0ZnT3BRLzk3TjJjZnJJdTJEZGRlQlV3?=
 =?utf-8?B?OWtQQmFoVlg1YjVyVVczdXBNQXBZelFicVlaS1MzUU5TelhjWFBKVGxMRVdl?=
 =?utf-8?B?LzVOTnFub3BhRGJEK0p1OWp0ZHJ5bEJXa3hYWTMrdXhJQkhLMEdJSC9MMlJM?=
 =?utf-8?B?d0VTSzN3UStnaEF3ZVQwYTlSbytmZ202Z0RxcnFKZlY1RDhqaVR3VGFyRmZU?=
 =?utf-8?B?UHVCbmUrU1RzWkcyV251YWZNWEt1RkQzamMyVDd1NFZiU1RnVXpKSDhwd2Uv?=
 =?utf-8?B?OGUvcTlNUWRISkNhNkdXLzM1aEZ2R0ZOSm5weG5vVjBrQzF0RFZFRVowcnZZ?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3a571f-08c8-45a3-1091-08db044a7b53
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 11:50:14.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfmyTgOTRAI6+jNNT/c4TZwViy8QViLSl1zvLIjw2UrL+iJdup1CP/sKLyPLzfl3OSKpQ0N6tDKsa0gUqOflbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8452
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/31/2023 1:56 PM, Greg KH wrote:
> On Fri, Jan 27, 2023 at 03:16:36PM +0200, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Changes in VFIO caused a pseudo-device to be created as child of
>> fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
>> device to VFIO. Fix this by checking the device type when enumerating
>> fsl-mc child devices.
> 
> What changes?  What commit id does this fix?  Does it need to be
> backported?

There were a lot of changes in the VFIO area but I'd point at this 
commit [1].

I'll resend the patch with a "Fixes:" tag pointing at this commit if 
that's ok with you.

> And what type of "pseudo device" is being created? 
> Why would it be passed to this driver if it's the wrong type?

It's not passed to the driver per-se. The problem shows up when the 
implementation of the driver does a device_for_each_child() [2] and the 
callback blindly assumes that all enumerated children devices are fsl-mc 
devices. The patch just adds a check for this case.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c28a76124b25882411f005924be73795b6ef078
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/fsl-mc/dprc-driver.c?#n96

---
Thanks & Best Regards, Laurentiu
