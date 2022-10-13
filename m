Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476B45FDBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJMODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJMODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:03:30 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8B696FD;
        Thu, 13 Oct 2022 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1665669212; i=@lenovo.com;
        bh=6UXSds2EGORX3oJAy25YJn+ywW/dLT9Pru30SIV1K3g=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=1ce3+CmxPpaK7Fldr7XbZQeYGIQ9pKVRE6vF66LGtL4dljuvU7MKjPHUdg5hzinBw
         /1Ewe0K0/FAeTFMkMyDkq+HRsfWAfCXUFb9C1dCsGpfFES+RFy59+b2AvR/E3KyAdD
         tU+8XIizskkwqkQdcHNV7WHn7n+47hocSmOFhaSr3H8rOWezdNfgtW3cNJbJCRZ2+n
         Hnp/Up95JM3d1rpyfKbu3ihOc8/IHkHXoDtxnGafvAyOjOA43QDkCMAAY06WwNfPih
         prC/SEz9049AmnU+t9ckBoKEk5VdFgBCxfX8vR+Mjx8YeAsecFokjaceH4c1MbSMe1
         F3Y2Z6z0HZrkw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRWlGSWpSXmKPExsWSoZ+nqRst4ZF
  s0HhI22LOhb8sFv+6l7FZTPmznMli8/w/jBaXd81hs7g++zyTA5tH66W/bB6zGnrZPO5c28Pm
  8XmTXABLFGtmXlJ+RQJrxps1T1kL5shVzFwV08B4V7SLkYuDUWAps8S5C8/YIZxFrBINU/6zQ
  ThtTBJ/ms6zdDFycggJzGSSOPLbCsI+wCSx4bApSJGEwHFGie5D65hAHCGBTkaJH69OsUA4E5
  kkOk59ZoVwnjBKnN7zECrziFFiR9tk5i5GDg5eAVuJ9TcqQeayCKhKHLt/BWwfr4CgxMmZT8B
  sUYFIiX0rz7CC2MICiRKXzm0Ds5kFxCVuPZnPBGKLCBhKzFlwHWp+B5PErp0fwRxmgeVMEvda
  m5lBqtgEtCW2bPnFBmJzCsRKtO07zgYxSVOidftvdghbXmL72znMEJ8qS/zqPw9mSwgoSCxZv
  x7KTpBonnKUEcKWlLh28wI7hC0rcfTsHBYI20FiU9MeVpAnJQR8Jfo++kOEbSTe3tgCNUZO4l
  TvOaYJjLqzkPw8C8lvs5BcNwvJdQsYWVYxWiUVZaZnlOQmZuboGhoY6BoamugaA0lzvcQq3US
  90mLd1MTiEl1DvcTyYr3U4mK94src5JwUvbzUkk2MwKSVUsRcuoNxf89PvUOMkhxMSqK8i/+7
  JwvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4O0U9EgWEixKTU+tSMvMASZQmLQEB4+SCO90dqA0b
  3FBYm5xZjpE6hSjLseVbXv3Mgux5OXnpUqJ89qLARUJgBRllObBjYAl80uMslLCvIwMDAxCPA
  WpRbmZJajyrxjFORiVhHnNQabwZOaVwG16BXQEE9ARS0+5gRxRkoiQkmpgqlgsaGHFJ9EYYyD
  14kTjR47VixJrJh+arXTnHWdp6iP7q9LVf7kWBJb9ct41j+no7guy8aevHZjVk67+8W3vzs81
  Vn0mqeFpTMcWv9E6dt1t2mKvCfUC35MXJE5Kkkj7JtObZB7zO3DJRdmd196e7Gjap8Z4+YJts
  dalnpvh62QPdtg3R5cX/tKLZVDW1Z38WUdP0niV07u3287W6ZgHbG2e/skzdTvLX8G2m1MPOM
  glAFNb9Lwt0rHeUawsa6asMdrps3tiKl9E8/pVc+PYuDleBR+tqxeYLf5RSOXYxrp81y69ZWs
  YGe1drx0KvjJF64u7qNamrdU3g9n+zusuLZDMllXQSj224vmSFSJKLMUZiYZazEXFiQCfAze6
  YQQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-4.tower-686.messagelabs.com!1665669208!36222!3
X-Originating-IP: [104.47.110.41]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1596 invoked from network); 13 Oct 2022 13:53:31 -0000
Received: from mail-tyzapc01lp2041.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.41)
  by server-4.tower-686.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Oct 2022 13:53:31 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJc3q1GxI7Mln8Al5189YrRmpFeeqYbZnMfQ/4dLcQdiEr54/gOKQ1Dm/Wrr92Rg4iHT3DuF7NbkfNPuY8D0spQEWXYYdATgSfCZPCHW5rnxico0kuih0Jopq15PxdzWP3Y22WkHsmoJlqaaHY9Kb9z5Z9JT5ks5TrYJZRJzortJjUnXt8EQ0tkO2DM2DwID4ZMC+6uTsVD7appDv2RtGbLWR4dTULaKofr5KJU5FW0XBSIZ3/8QsiQZoqll4PiaQNwCppX+CMhPuDeigbyazQIqq9YqKDm2aaKv+5pYFcW25/thMuGMB7EI3kQBY8enMTPw8WGjc+HABp8QkGVX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UXSds2EGORX3oJAy25YJn+ywW/dLT9Pru30SIV1K3g=;
 b=hsKorPfls93mrVgvnTW7eyw+/K4Bo1TP91fa2VMt7vJP4jLKDYYdgb3YBxxrwx/8K4Aj8Lx+Ib4ZpgdFdntxS7/qmUSlxQGteiREsKEFZD0BgDGuuvPsiS26QFngZUMpw/gOLAg9KXOjtuJg10J7PVU6BlS/tgXuwONYoS30c7CP8ksaYLH4VD3x4aXCMD+gJu8iRP6oyiEpgfRB+bqjshC7JypXr3l5FXcM9/aN0dd48TgEEf58e5cnebQ4icDYo6bHwFPJq6R9eH4sWV0GfJfjqyAxgjL9xBt96NGJVGuGHYy06jl9NrrkJY2TelMw1NhOH/FLLy0/3HPKRlEV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23) by
 SG2PR03MB6658.apcprd03.prod.outlook.com (2603:1096:4:1df::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.6; Thu, 13 Oct 2022 13:53:27 +0000
Received: from SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:b6:cafe::19) by SGAP274CA0011.outlook.office365.com
 (2603:1096:4:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Thu, 13 Oct 2022 13:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0057.mail.protection.outlook.com (10.13.36.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 13:53:26 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Thu, 13 Oct
 2022 09:53:24 -0400
Received: from [10.38.55.218] (10.38.55.218) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Thu, 13 Oct
 2022 09:53:24 -0400
Message-ID: <df1c3d64-7255-0b7d-51a4-01a615a8c07b@lenovo.com>
Date:   Thu, 13 Oct 2022 09:53:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Fw: [External] Re: [PATCH 1/1] pinctrl: amd: Add dynamic
 debugging for active GPIOs
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
References: <20221012221028.4817-1-mario.limonciello@amd.com>
 <20221012221028.4817-2-mario.limonciello@amd.com>
 <CAAd53p4sKdFL-DcPet2srtisiX_Qr9qpiV159Xj9YSUM9yiLPw@mail.gmail.com>
 <TYZPR03MB59942B6A03B43132DADF1C5CBD259@TYZPR03MB5994.apcprd03.prod.outlook.com>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <linus.walleij@linaro.org>, <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        <renjith.pananchikkal@amd.com>, <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <TYZPR03MB59942B6A03B43132DADF1C5CBD259@TYZPR03MB5994.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.55.218]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0057:EE_|SG2PR03MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 457d89d8-3223-4b68-6d51-08daad224dd5
X-LD-Processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvVjk+nJIfZ9kAJ/jamBojRhfAo4evati625BNdF3ABVPzyZ9rYop3pDRiEAL1cg14D9b6AAqn7vn1N5/6yMD1iP5Dc+XcKhr6Ocx1ZLSB4pqVeh+zsa3X2Wo6GQdXPPODB0NWJ996nYe65cKCNIkfb5y80t0Wx48W9pFx+bWRo0ma/iHPOqDiu98hWHfUzAGL9j/S3HbFlCfk6J9vcqhYid7yLWWdE6MMj3LJjfmSE6sZ1VfP/SlaxIBXE7xTOGaVkllp5rapZJD0uGIopmMI+Yf5cr9xodo8pKVaj3VCvHYEjI/qps4IrCm90o30YW5402jVoWM5tc51E8LSx0fyVFcdpq1LfccvjDvS4OM5c3v5Zd1Ald6clhd0SNvoSQeko0T8i4KlbmRHofqAYba2jAFmb0zWbvskJcSeZqk95nN3L26MeX1iP6zpKmoAjRAERESw74tLDmP7tkKtsqs8UbHrTMNjZqnue1gnopT9N26EmzBm+kK/U1a3CeP7bOcK46I/c8xKawfLlkV4pZubx1V9ustY5FwKBK0ryIT1HLXN84+Vrr/fRGsjZSzbQ9RB8ocsFMBwTMiDUQVZjIe7m7r0vs/9xDx0/koyzxIEKiBhDmMaEWbRsHvQ990EbTEIqAgrl2/ZrEG66ls8aCCnaIwK1znOFxPL+k4SvDsv5g+E6xJW1nXKvhw745mb4GeibFLpk/StpzQHMm7hDj7+QaBnBC0ZYegr7kqK23m+3H/ar+QhT6kRN66xJvgUKjwE53WZE/gNn6WQmwKlB8eHGo5SQg8PtYZwzJwSW0gXW2T+wjwhXm4jvkvoKBe6tvsryMA4sOjpCddI7He6V1Taa/X3Suroz+iA0iyLMAu5k=
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(31696002)(86362001)(2906002)(478600001)(6916009)(54906003)(31686004)(8676002)(36756003)(70206006)(70586007)(41300700001)(8936002)(26005)(5660300002)(36906005)(16576012)(426003)(47076005)(40480700001)(186003)(336012)(40460700003)(16526019)(2616005)(356005)(316002)(4326008)(82310400005)(36860700001)(82740400003)(82960400001)(81166007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:53:26.7514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457d89d8-3223-4b68-6d51-08daad224dd5
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6658
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>
>> Some laptops have been reported to wake up from s2idle when plugging
>> in the AC adapter or by closing the lid.  This is a surprising
>> behavior that is further clarified by commit cb3e7d624c3ff ("PM:
>> wakeup: Add extra debugging statement for multiple active IRQs").
>>
>> With that commit in place the following interaction can be seen
>> when the lid is closed:
>>
>> [   28.946038] PM: suspend-to-idle
>> [   28.946083] ACPI: EC: ACPI EC GPE status set
>> [   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
>> [   28.950152] Timekeeping suspended for 3.320 seconds
>> [   28.950152] PM: Triggering wakeup from IRQ 9
>> [   28.950152] ACPI: EC: ACPI EC GPE status set
>> [   28.950152] ACPI: EC: ACPI EC GPE dispatched
>> [   28.995057] ACPI: EC: ACPI EC work flushed
>> [   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
>> [   28.995131] PM: Triggering wakeup from IRQ 9
>> [   28.995271] ACPI: EC: ACPI EC GPE status set
>> [   28.995291] ACPI: EC: ACPI EC GPE dispatched
>> [   29.098556] ACPI: EC: ACPI EC work flushed
>> [   29.207020] ACPI: EC: ACPI EC work flushed
>> [   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
>> [   29.211095] Timekeeping suspended for 0.739 seconds
>> [   29.211095] PM: Triggering wakeup from IRQ 9
>> [   29.211079] PM: Triggering wakeup from IRQ 7
>> [   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
>> [   29.211095] PM: resume from suspend-to-idle
>>
>> * IRQ9 on this laptop is used for the ACPI SCI.
>> * IRQ7 on this laptop is used for the GPIO controller.
>>
>> What has occurred is when the lid was closed the EC woke up the
>> SoC from it's deepest sleep state and the kernel's s2idle loop
>> processed all EC events.  When it was finished processing EC events,
>> it checked for any other reasons to wake (break the s2idle loop).
>>
>> The IRQ for the GPIO controller was active so the loop broke, and
>> then this IRQ was processed.  This is not a kernel bug but it is
>> certainly a surprising behavior, and to better debug it we should
>> have a dynamic debugging message that we can enact to catch it.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> This is very useful, thanks for the patch!
> 
> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
Seconded! Helped tracking down some issues on our platforms. Thanks Mario
and AMD team.

Acked-by: markpearson@lenovo.com

>> ---
>>  drivers/pinctrl/pinctrl-amd.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
>> index 4691a33bc374f..8378b4115ec0d 100644
>> --- a/drivers/pinctrl/pinctrl-amd.c
>> +++ b/drivers/pinctrl/pinctrl-amd.c
>> @@ -628,13 +628,16 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
>>                 /* Each status bit covers four pins */
>>                 for (i = 0; i < 4; i++) {
>>                         regval = readl(regs + i);
>> -                       /* caused wake on resume context for shared IRQ */
>> -                       if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
>> +
>> +                       if (regval & BIT(WAKE_STS_OFF) ||
>> +                           regval & BIT(INTERRUPT_STS_OFF))
>>                                 dev_dbg(&gpio_dev->pdev->dev,
>> -                                       "Waking due to GPIO %d: 0x%x",
>> +                                       "GPIO %d is active: 0x%x",
>>                                         irqnr + i, regval);
>> +
>> +                       /* caused wake on resume context for shared IRQ */
>> +                       if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
>>                                 return true;
>> -                       }
>>
>>                         if (!(regval & PIN_IRQ_PENDING) ||
>>                             !(regval & BIT(INTERRUPT_MASK_OFF)))
>> --
>> 2.34.1
>>

