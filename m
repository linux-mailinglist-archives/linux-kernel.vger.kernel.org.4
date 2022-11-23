Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335B6352E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiKWIjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiKWIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:38:58 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70097.outbound.protection.outlook.com [40.107.7.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4FF2C01
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz8wB9kP7IEFQlZyvyaPWmQKtQqVMMoLc2LvOW7Tnc7ZwK2ZrAymWBM3D0jziQjMP9Mc5BujUj9hDGhya9NTC1T0gu4MR+asrtABNc1cTBTrPigy7ZMrbwyGm5R4Kw0kbEtTTz1PCwVF+f6CnUaxBw1G6SOZ20e1Al0Qn8pfSm93rGr6BtLuRrixJu6v9bKk1hHMD9QGleA8zbGJKF9dHn8TOBcNxEi9EMlGLv8xZlDZumqiJfGgu11vNKAmQtkNVN05qhLK4h2E19LF72ziQUyKcXtNjlj+jCgXMndQQVGfzT+42mjz+z0fnOdHGrCx05RwqOHqBeJbr/NLrAswRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+97YQ8S7laUuakKnJYPA2MRZoRY37mjXih/IxfAEDTU=;
 b=JjFjA4ZR16HaO1uWs2GDC9svu4Kd4xNiMEtr2938LsiJUJhfxNqHhMEbGmKG03Xved+k+iJ1oIIpkdP/AG3TwR+BDsbsXMGDxxh7bh44rUZ5ryQOMbzURCfaufUKNF18DYoFXDh2VBHJsQ1CJCUZ5r/3krsLmN/KoSVefVeKifn6n3ZfShvIepJjlUKrPeHianklA62LVCvh5PY7oNu5jsprQazpn4CUP0ZFzisU9PAM73nl/IUFKIG4PVIIIakE5rje7nB43WATPPf0VlD90Cp5fnBqzRLT26BQElUcomfhCAF8SwWQ23fjr8hyk5+jFlwfTk3jDiaLOVqm2JXUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+97YQ8S7laUuakKnJYPA2MRZoRY37mjXih/IxfAEDTU=;
 b=DLUi2IdLtvFIC/mMBey96ajzLaCq7I0UsQFcdwTmTmkgYdyQSU8QR0niewajgsNwQudK1AiccZg8mo/fJXGthu/sfif+SEhmggdWUzQOnN02GqTS2YNAiyd2olh5ZApmP4xbLrxjn0PRip/uWfV0tkS4pWFD19dmjUXQ0/RSfaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DU0PR02MB9798.eurprd02.prod.outlook.com (2603:10a6:10:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 08:38:51 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:38:51 +0000
Message-ID: <f3ee38ad-61b0-1069-9000-4d125d3bfa25@axentia.se>
Date:   Wed, 23 Nov 2022 09:38:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, clement.leger@bootlin.com,
        regressions@leemhuis.info
Cc:     alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
 <075d8c0f-5448-73aa-bd3f-0d4e1216e87f@leemhuis.info>
 <20221122181452.6a386296@fixe.home>
 <a961e0a1-5373-e2e0-3acb-7ef3cc32d846@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <a961e0a1-5373-e2e0-3acb-7ef3cc32d846@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF000013EB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::17) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DU0PR02MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c9aec3-2cd7-4688-84e2-08dacd2e2517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf5kWYxCM8ESbX17Tfqa3rWzaMqN16j73daEHfU8eguASMx2KQ+F6B5l1RErk/KWW/XY/YLYZx4VlOle+P/iXO2WbAb7DE2CODSqWeOZ9/VyW1zgJ8oIgiXfChyr+XSndye7DNKyUZWlJJMuO3cGUK/uVDv2sfSl5QgPl1vFcS8YHYBFgGRNIlP8Oxw+5LkfhEd6Y9tyQR1b/a3aaF4k5D+Pc517B0lI11uPix6N09dXYXFjKb+oS4opleso1UgyIXH7ba4zmpGK/leFVNF78C2M3gEX6e61V3S2bgXN2xw4wBv/Ldu2qNBCEkGullbPrqYvLRQZuPoCqp+TIV91Kk4nR1QuY2luKhpLrPtRRbFQYmv0NfpuhTSH7HmzZ0fFrsEw9aQQZnrh5aAQpa+hIHdKWxY13QYNC6HUEhMU9TIuAjI9y04bHWEaJDWcI2XmfuIfssdmOv+e/u48DJPZW6+YF3sdQ+flA/Q7LrSMn1sL8uoBcolnOssrEfn7O829CYiufkU7PzUwu5R2wCzPpOfuW1lafpS3FXsIKFWa+NeMaZWHHn1BufbyGgXYRfBCyRRhfx8zW3dbbipJdoSNpL4I/XvHrgRqDK1Cw4oPRpUC35N//4wr8gqhjCzCs861h9EHzjs97RoqZRoBP74w29cKgsISh0dPUkUBN8YXAwgxiqlVh5skGZQd9AWIlZPNDOqmnFTA29qO1Wtl+5W7FqZXkxG+vS7oEzcYkQ0XZQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39840400004)(346002)(396003)(136003)(366004)(451199015)(8676002)(66556008)(66946007)(36756003)(66476007)(4326008)(2616005)(6486002)(2906002)(316002)(53546011)(6506007)(31696002)(38100700002)(6666004)(86362001)(4001150100001)(478600001)(26005)(186003)(6512007)(41300700001)(31686004)(8936002)(5660300002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxyYSswODhQYUc0a1VqQlpqU0pwNnJpNHVWVXc4M2gvZ3RrSitZbVljVzFo?=
 =?utf-8?B?TW5DeTFiMDdLV0gzVVhCdTA4eXhDeGpaL2hCSCs4Njd4emowY2xzaU5hbGhH?=
 =?utf-8?B?a1pqMUp5ZnBvMytWd29hWXdhaGZzQk01VHNuZTVScVBZaFRsY3RMa0VnNTRI?=
 =?utf-8?B?SnhSL0plZGhDVXErYWQwQTVGVENqQ0RJdkdPTGNHSHFxME9YWjZVd25wUmlP?=
 =?utf-8?B?OE45NnVZTXBtSTZmUXJsYmJNMEEyTlVHeFZvU0YzZDQ3bnVpK2prTHFVTGdo?=
 =?utf-8?B?cFIwVE5mMyt1eTVpak9FYSt2YkhFTzRhWGoyTXRMWDFHQW1qMnAzL1dhdCts?=
 =?utf-8?B?TXNlek5WWWpiVmJTdlJqNEp2bW9QMTFYbTZBRi9UUkRYSkxtV1dRc1JCcUx6?=
 =?utf-8?B?Z1Z2TjRzOFA5ZDJ1Ry8xR2NSeUw5UDVFKzdFMGhHMm8yTGExZTVPUStncy9y?=
 =?utf-8?B?WTdLcldhK0E4dlU4aFhkMnlxSVRNc0xDU2grM0lUZk1BNVM0alVtK0w0czIy?=
 =?utf-8?B?dmYyZ0hSVWJHS3pDYlovekRlamRoejJoUFQyaFJxMGszTFdGM21pTVV4Q0ti?=
 =?utf-8?B?WVo1SThveHdkaWJhSGszcG1xcHFnNExiMjNnenI5ZUJpZitpRzlwT0xjMXFZ?=
 =?utf-8?B?Vkl2VXRJNUNPSWFIeVJ4K3NneFZWRXVKU1FZeU1nRVAxaFU4N3hnT3MzUjRu?=
 =?utf-8?B?dXJLSEpyVmRoaUplRk1IcmYwczJNU25YN2JxbGxvNCtxZ3A4T2cwdzR4QjNG?=
 =?utf-8?B?SU9SOUhQc1c4SDExZ2Rnc3I3RVIwa2J1UE5VRVN5VWUvcUUzUFdBUlovNHpi?=
 =?utf-8?B?RGtUR3RVVjF6R09GRWNPREQ3UFVyUGRIQUtrVnRJMDBDbmxDNENsRWwrK2RB?=
 =?utf-8?B?dmVzZEVDRDZVanpnMTFDMzVXaHJMRk9veElZSjJScURFOExqS3RXZVVuM1Zs?=
 =?utf-8?B?ZjhTUVowdXo4NjZDQzV2R2lKeFdkTUpQNGZ1czJFNm0rRWhvZDRHQXN5U3kx?=
 =?utf-8?B?aVhVdmlCbHdBdHAvbTdCM2plZDRCa1U1cmN5cnVkZ0lHR3drUDlDdTQveVo0?=
 =?utf-8?B?UFU3c0syM2IyTFZTVjQ1TEFZYVZySUlxQUNHQWxMZGpIb25raGtaaE1FSlF3?=
 =?utf-8?B?TDM5bEpFbEpLMDIyanl5NnZhZWROOE5iWmNteEVGNXkyMVYwUXBReEtraXpn?=
 =?utf-8?B?L3h5VTRiS0k0akhxa2szd3A5aGNEMStmVFpLUy9ybWZjSFNhYWx2eGlOU3Rl?=
 =?utf-8?B?cXVhWUJvWkkvS0RhQklqK2R0YnBjZnpYRGdjZmZMdVY3azdPMUhvOWVQRVd1?=
 =?utf-8?B?RG41T0UwYU9IaHlsZTFGL1EvaXNzWW9OaStDVE0wbFh6cjNJVUpoN2xIQnRl?=
 =?utf-8?B?NW4yYUhNY0xFUnhCVy90clJzMGo4dTBWYnVCRm9POHpHQ2hodzJMM2MrQVFW?=
 =?utf-8?B?NDJuRHhKTTZDcEJXRGl0OEdnM3R5Zm0xNWs0M1RadTlhK1c3aTNBSTgwY1Bh?=
 =?utf-8?B?NDBsYzgvalQ0NFRuaG8yZ2wwUC95K3RDMENCSHdyOTBWWlBtWFp2dmF0bHNl?=
 =?utf-8?B?Mkd2SDBXalpvRnN2blpEZXBHUC82d1ZLRFdFZlpsQk9OcjFoL0NFS0Z5UVlu?=
 =?utf-8?B?d1cvbUx3Y0VPbjFFRUI1cnFzRVZxaFgxRVR3RVEwWHRoVzYwdEFSdklFQzN6?=
 =?utf-8?B?UnVvMHRRczZtTks5T3NBWHhEYlQ5bTU3TWZSamlGUVJvS3BzTGUvZkxCVDMw?=
 =?utf-8?B?aVhteC91SlZqOWY5VC9IQ01oaEdvdHJKZXpyRlRjdWY3OEpZUzJvRkJBd0tB?=
 =?utf-8?B?T2llVGxEMHcvbTZEVXhmcVZHUnB0cG1Oa2JGWnRobVBydDhLTFpvVk9CNU1N?=
 =?utf-8?B?cnd1MGtXSUliK3JXYTMvVkRETk1xMjBWRGQ3UW8yVnBMZ285cWJ3T05rL0ZI?=
 =?utf-8?B?TWJvSkNHdmxhektlV2Ryb0RTVXpyZnc4RXVjdTBxMXR4Z0M3YWtJQ0Q5K2Qw?=
 =?utf-8?B?dW11R0ZlK0xLNXcvWGpQRGM3SHIrSFhSYnZwTU45UzRFZnhGQ0JJSUttc2JJ?=
 =?utf-8?B?b05idVBvVENNSGJsYUI4SHcrSG1EaU0yVTFoMHdSbUV2dmpFOGRLREJidDhO?=
 =?utf-8?Q?tkALM1m23sSaF5AKql3j5IgT8?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c9aec3-2cd7-4688-84e2-08dacd2e2517
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 08:38:51.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJaSlh64WJXI5J6xXeKlHHYuDOFSY1wLcoJFWQQi83w2dr+f3+EBCTbyBsbcUGP4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-11-23 at 08:19, Claudiu.Beznea@microchip.com wrote:
> On 22.11.2022 19:14, Clément Léger wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Le Tue, 22 Nov 2022 16:13:40 +0100,
>> Thorsten Leemhuis <regressions@leemhuis.info> a écrit :
>>
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> On 12.11.22 16:40, Peter Rosin wrote:
>>>> The L2 cache is present on the newer SAMA5D2 and SAMA5D4 families, but
>>>> apparently not for the older SAMA5D3. At least not always.
> 
> Peter, what do you mean by "at least not always" here? Are you talking
> about the OUTER_CACHE flag?

I'm not familiar with all options for L2 caching. I was just being cautious
to not exclude the possibility that there could be some variation within
the SAMA5D3 series (I'm on SAMA5D31) or with an external L2 cache or
something such. If there's simply no possible way to have an L2 cache on
any SAMA5D3, feel free to edit that "At least not always" out while you
commit.

>>>>
>>>> Solves a build-time regression with the following symptom:
>>>>
>>>> sama5.c:(.init.text+0x48): undefined reference to `outer_cache'
>>>>
>>>> Fixes: 3b5a7ca7d252 ("ARM: at91: setup outer cache .write_sec() callback if needed")
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>
>>> Clément Léger and Claudiu Beznea: what's up here? 
> 
> It will be in the next AT91 fixes PR.

Great, thanks!

Cheers,
Peter

*snip*
