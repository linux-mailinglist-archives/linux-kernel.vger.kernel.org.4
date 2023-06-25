Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD073D297
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFYQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:58:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2022.outbound.protection.outlook.com [40.92.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C368B1;
        Sun, 25 Jun 2023 09:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2D+KLYTKTDOQ9aryNLVfmFCr6FHiAS1KTH+shbPgIKo2AtLTNCYEqPS9Gr6aSoh97rR6sqsX1iXrVLYS8Dz+Zpw8A4CJ7Yq4+ugfuCvb8u9YdzZHMINbR6WnnOpBQCY1hLmkFhpVVcuWJ/Ib2uQfPW34BJWy4xNWvPGqcsMmimBfzNz+1tgEBoIu5wsN2TfMU78/RUTijhOniPqXVzo3PO843VNeg8hSoHei4daDFjoQ6UAmRYcTRPQ75LeV/LW8Kfa6AjoqEMVqUcMRGGMFImBzv7XhpKUf3kqO4OhyPSUgSwp5GHBEscE+KR0uDMxCfyqWIb5jhfKggP4vSnvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nwDQPRC+2nngHIh2pS/zTx59mCETITE4CXQdR2wofg=;
 b=kNmZRat4JIrh6aF76Fw1ASpNybWMYOCcnHF8ML/fGD9hGOD1giOoMSJGPjHWUku/PR2myRqWlFcZcKUp06xUOv8aaBYJw10hjUd0htcAZVP4ks/q6bxWb1K/shKdOhwIzNnDSwvS7skHWZqwGsd2t7fIukvVANpj0+PzT0hOop+jTr0qdJosoa96VPXZPTqKdc/cn9easnM1pouzkV1XKlifyFOvaYauaYlV7fED7XbRBE12dXukuNQrupwL//tHfuxUNAYuxDTC2m87DCgLE4OeFMn+a6Nicp2OTFcIkjVIRWUve6mywGTPWY2a4p2XrMmvEV7weEAAK1tAV/lSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nwDQPRC+2nngHIh2pS/zTx59mCETITE4CXQdR2wofg=;
 b=e6ylI3aZzaBV5DoSiShnAXVXBG4Vn3GLp0umpMCgM5iXXB5z6z+mdtDPApF3LdCt8Za+5wbfmvzVmuQS6+rBo7Ks+virvpNDk4cxUdf/HYCumYz09koFqEPapYqrJYbrdyMjy7pQPmKmMJioQ4Oqa1cPH1V25g70Kd0dqRpi38CBkokq+Ar6gozPvhGem0sCja2vp2pq6/X48CPUodtEDwAsAEVDlfr3Dp80HdWhznDjGtXz9jE2sAa508eQhW1v896Zgvdpi/p6AQcOeVklfWFK6PSItMeMYoc0D9dfeFMwhwwHiVWZKA7mG015adHIClQLRDC/hX/v/OBAUMH48w==
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:c9::8) by
 SCZP215MB1933.LAMP215.PROD.OUTLOOK.COM (2603:10d6:300:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Sun, 25 Jun 2023 16:58:12 +0000
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc]) by RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 16:58:12 +0000
Message-ID: <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date:   Sun, 25 Jun 2023 11:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
Content-Language: en-US
From:   Sardonimous <sardonimous@hotmail.com>
In-Reply-To: <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [NJTORj29h07yBKb8RnkgmWSUAY1HfTb758cSw1jEW4jhDaeV+atnRb71+0bXqNtfIDDOuYaRlY4=]
X-ClientProxiedBy: CH2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:610:20::26) To RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:10:c9::8)
X-Microsoft-Original-Message-ID: <8ed569e8-a51f-1b8b-83ff-f241f6fa0263@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: RO2P215MB1938:EE_|SCZP215MB1933:EE_
X-MS-Office365-Filtering-Correlation-Id: 111b26b9-c819-4048-0ee0-08db759d5bdb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siapfy8BqKSgnuhBtcKyXGJVgjO550bw9OWD3N0SIfXMESXz/IStl7sb4h2lj4uJt91V7U7oJJ+9aTbNlLGBLhNwflrafql/6YvUnpGE0ZomfgojLgNom3+UqzARz2lfRIgw2O7WAFgvFa8o7MGnHUojfNvRlorK4WeGt9LBCp0WNIhGZhbUJ8skSdnCoxNev9U8j0NIkJrcGBzQeZ0DOgd/cvINrsyOWvrwwBbzbfiOtD4VtS8hnxCbdFLTse4UboOy3ybEzNapMSqO0eV5aymLhIrbN/xC0PUTZmzScxRX+XTU2EX//ggIGxayFL5v1RrYKTSrroiEXj0LiwZdXMam4difHGIwO5j955YyLTbwtjkX7MyeIq7v4AoOsev63W7l2chiqot0Ow0AtRpdTdc8rYQ/ELVuT/C7ggIaPVQEuEKeOnfri3EKv01n0IayoULk0ZFgskwcnBSgN31xLGgV3pHt/K1QQSKxW9s3ctnco4oOppBTAGR978jUCdi9/OaEfiwp/p46b0Z3ZLjfSKSxMFC1eZyB6mrrwgEWO6PQse/KprcsX6vNhQ80XajT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZreUpLSHVVVVdVcUpjZjludzJGMk1UR0VXZkN0dDlhWFp5cUhuRElTY3Va?=
 =?utf-8?B?bGZkSXFuMEVsWS80TUNxUlA5OEVNcnYvUWJmd0wxTEhqMXJJMnRGRURnNUtW?=
 =?utf-8?B?MmV0akxwaGt1VlRjMlVWaWVKeUx4b1lweUdUMEhyVUZvZ2hWY2VCV0NLRU1O?=
 =?utf-8?B?WUhOUy9RMEp5ajZKY2pSc3JaWGV2ZGpSM2tCMVY1cHVNdDJVaWVmMjBuN3lD?=
 =?utf-8?B?UjFWUlAzeDNHaVlmSDhNL2x0Tkc5MFdHRit1YjVvOTE1amVsK0hONFVYWEtp?=
 =?utf-8?B?YmJJOExtWXo4T1hwdUxCdjI4NGJqc1lQK0JCRTJWcnRpM3JXbFRJUGtEQ2V2?=
 =?utf-8?B?TzdrcWZDTHgrM1ovQm9KT0hRbS9vbTRjMTF4V3RmblZVbkhEbnF2ZktjMDJl?=
 =?utf-8?B?MGRRaVF5clBSM1p2b1Qvcm5pSWJaeWNnak12Y1VMMHMzWGJoRFNwaERMdzhr?=
 =?utf-8?B?aDZxWk50azJicGllRVAwMkRuOUV6T2ZONnR6NzJMYS9PR0RkU1BTTFNRZlhD?=
 =?utf-8?B?SDhIQUV1WTdBRzdLUXlhSWpyZlZjS25tVkNBdThnWVQ0V0xwRzBodmtUN2hU?=
 =?utf-8?B?MVNPRlJCUWlQNlNYV2JUYXdaUkZENVBWT3JnVldkNVprc3Y2MkM5V04vTUxt?=
 =?utf-8?B?NTBTMW5DNzZRN0pSN0tjMWtSYWRIYldTU2ZwTjZyZ1hYd3crVE9RVzRJaXhP?=
 =?utf-8?B?R3FubCtBNklpQlZNSzJ1YllaUGViZVJuMzA0am40bzE2cnFtYzAwcTRxV1ZV?=
 =?utf-8?B?cVJFclY4UjY0U0M5RTlHVlBZN1N0UzdQcnZwYTlNL0JVOUtoY3pra1dvMitz?=
 =?utf-8?B?N2ZUWE5JYVVvNU50YXlaYVlXVVVOTUQrcytDODVuaXB2L0Z1UkZHTXhJa0xI?=
 =?utf-8?B?RGswM2FGeVJ2bFd0bWk4SkhJeU1QT2g3UE9CT2ZQQW1rdnFsUkxnNDhKdDdC?=
 =?utf-8?B?V3Y3Ui8rU0dQTFREbEQ0eWxFczU1ZllNS3FmMStjdVY4dWt4RmNEb0VXbTVC?=
 =?utf-8?B?MmRIakdvaDRwSW1NUkhQeGUyZ0JBdCswQ3QzMlZURUFvSjBlcjQzVmM2V0ZL?=
 =?utf-8?B?L1J4Ti8wWXJPZnRSbERSZklHbWNwRG9NdXEwN1NOVnJ2bjYwTDlTUzJ6a3pS?=
 =?utf-8?B?eEE5VTRWUVlEZHIxdG1zUk9jR3QrS1RoVGE1NHhzU1IySVdtUkwvNkFETVpU?=
 =?utf-8?B?NUZGZGdkMldEaDdReHNwc2drTWtEMGRkdzFncEdwWFFSUWZqTVltRHZlZGNO?=
 =?utf-8?B?djJtbTk4enQ2ZEFWSlNzVU5qMWtmQnY0eU5KVFBYRXdOL0cySjlaZGQ4Zko2?=
 =?utf-8?B?WjNtVTVxcUh5eDFraG45ZWFhNUhLKzFNY2JUS1p3Y1dzbG5UWDE1MVBZTkRm?=
 =?utf-8?B?N3FkMzh5WTV2YUowcUdDU0hxY1dibUFidXNZODU0SVNzMlVnSEVpUThOblhy?=
 =?utf-8?B?Z2VqVkQ3OWh6d1kySHZDRzVKN1lyZWgwaitTUkdoeXhKQTNWSVNFTE1zTnRw?=
 =?utf-8?B?T3J6aUFZck92M0R0OCtPdHRKRTRNdDB1RjVOc2YzWE5rMmJZRXljeWg1OURl?=
 =?utf-8?B?WGhVNGRLT2FtZzlVdE5SRnF0cEczYUNXOTFUekNFWVRiNDh5TjZINUJ4WHU0?=
 =?utf-8?B?MmlnZjJOQ2Y0eTUvY0d6L0ZIUnZ2VnVzSTdxLzJvTTVpQ0FoSWNLN3N6Q2pM?=
 =?utf-8?B?QWxhaGp0WW82cm9JZUdXNlhRN1BZMGl1OXN3Mm1mOEdOR2s3VFhJU2tQSkg2?=
 =?utf-8?Q?f2LtxgVHff6i8gkUqU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-7d2c5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 111b26b9-c819-4048-0ee0-08db759d5bdb
X-MS-Exchange-CrossTenant-AuthSource: RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 16:58:11.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCZP215MB1933
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,

On 6/24/23 23:41, Larry Finger wrote:
>
> Sardonimous,
>
> The critical line is:
>> Jun 20 18:20:11 askasleikir kernel: b43_pio_tx+0x373/0x390
>
> I certainly have not used PIO for a long time. I expect that your 
> MacBook Pro should do DMA on the b43. Apple makes wierd hardware, but 
> not likely that wierd.

I have been unable to get DMA to work in the past.  So I have been 
configuring it with PIO=1 (/etc/modprobe,d/b43.conf):

     options b43 pio=1 qos=0

>
> Does dmesg offer any clues as to what is happening?
>
If I try with, say:

     options b43 pio=0 qos=0 verbose=3

Then

     rmmod b43
     rmmod ssb
     modprobe b43

I see the following:

     insmod /lib/modules/6.1.12-arch1-1/kernel/drivers/ssb/ssb.ko.zst
     insmod 
/lib/modules/6.1.12-arch1-1/kernel/drivers/net/wireless/broadcom/b43/b43.ko.zst 
pio=0 qos=0 verbose=3

...

[Jun25 11:51] ssb: Found chip with id 0x4322, rev 0x01 and package 0x0A
[  +0.096950] b43-pci-bridge 0000:02:00.0: Sonics Silicon Backplane 
found on PCI device 0000:02:00.0
[  +0.411653] b43-phy1: Broadcom 4322 WLAN found (core revision 16)
[  +0.038206] b43-phy1: Found PHY: Analog 8, Type 4 (N), Revision 4
[  +0.000032] b43-phy1: Found Radio: Manuf 0x17F, ID 0x2056, Revision 3, 
Version 0
[  +0.015660] Broadcom 43xx driver loaded [ Features: PNLS ]
[  +0.520933] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
[  +0.726559] b43-phy1: Loading firmware version 784.2 (2012-08-15 21:35:19)
[  +0.276596] b43-phy1 debug: Chip initialized
[  +0.000562] b43-phy1 debug: 64-bit DMA initialized
[  +0.000013] b43-phy1 debug: QoS disabled
[  +0.023145] b43-phy1 debug: Wireless interface started
[  +0.056159] b43-phy1 debug: Adding Interface type 2
[  +0.086691] b43-phy1 debug: Removing Interface type 2
[  +0.000105] b43-phy1 debug: Wireless interface stopped
[  +0.099849] b43-phy1 ERROR: DMA RX reset timed out
[  +0.065067] b43 ssb0:0: Timeout waiting for bitmask 01800000 on 
register 0F90 to clear
[  +0.204905] b43-phy1: Loading firmware version 784.2 (2012-08-15 21:35:19)
[  +0.296681] b43-phy1 debug: Chip initialized
[  +0.000555] b43-phy1 debug: 64-bit DMA initialized
[  +0.000010] b43-phy1 debug: QoS disabled
[  +0.027099] b43-phy1 debug: Wireless interface started
[  +0.062503] b43-phy1 debug: Adding Interface type 2

The wlan0 device never seems to work, no IP address is obtained, etc.

> If there is nothing shown in the log, you definitely need to do a 
> proper bisection from the mainline git tree to isolate the change that 
> led to this failure.

Still working on initial kernel build.

> ADDED WITH EDIT: I looked at the code and b43 will not be built for 
> any hardware without DMA, thus it appears that adding "b43.pio=1" is 
> the only way to get PIO mode. Please check the output of dmesg for PIO 
> messages.
>
> Larry

Thanks & regards,

Sardonimous

