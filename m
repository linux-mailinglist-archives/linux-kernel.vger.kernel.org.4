Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CD73E05E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFZNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFZNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:17:12 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0B186;
        Mon, 26 Jun 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687785423;
  x=1719321423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=unWynOqTM0AggM5eRJKo11DT1f5Uzm2VZa/s4gzWaDc=;
  b=LJW3ocx7IXDRV45kptwqGyVOxdC6i656FPU9DJ97PKuu96i2ME7KDTHF
   FDGmcZqZJAIUA3/EpU7VutBFaO/3h+ezpZMINbBaWT2mtBMhqbpYqkEzL
   nmLhm2/6/PGmgacV5VdTZZelcZQg/pdrteV91jp9Yg82D63b/QgT0SkmJ
   +19INdrDmBMbRhL4QU8yKQG0jvv9f3YjM3b5mPKENWCBniCB40vc4vaII
   TAjh6+iHLFz7zqsqyuGTAO8nQRjs+bK06fTlJu0cbNn/VqjcrOj8lQc8b
   CWtU3OKHBtVckMB99td7YnnTfSCHBxLcwg5pvdZwvYHfxLflPlclGa87p
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om2ZS+FPvJG9pbFk/gN3GbmvGiPcftIjd7vjSQwyyR+QrvaoX7DTjgEsczDtgEV6wirmo6KI1VDEj0+MizYndpway7W8liAj1RBv285XFhfkXbTdh/HXziHF5DxNbFgSaak2HAZOfKjw65gXtmvCqD6BfqHxnHuEudwqPo3tGvpgnth3OoxStOPME0NfIfsKRehzZuXeIjaXgy5A9hckzPs4rjvNf+mGk4wDdhlojKWaKVh7oQ1e9zxdVgLpJ4MHWinv1aW3eK9w0SYl5rPHUw4c7QX7jsT/h4PfkuFbLoh7SsEETvE2wRCL4ZsH2N7GjDoEWzCIVLBXiCgGVyg4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWynOqTM0AggM5eRJKo11DT1f5Uzm2VZa/s4gzWaDc=;
 b=jEZ0lSKhpurqHEl+h6mEIA2CUQwbeOdu+g11uP+l9w4mmcr8dMEQJPnIf9S0Efw/HUC4cEs8/ZveIUhQTZcJdDpJbllE8KKUvkMkE8qjXcMcedakrPRC7LkUT+eUy5oYc8gmq0qMIe0m67lWdlhOARjlpK81fqVgYmC39yIIEMvwp/9X7QL2w4QlkMnhQMOrebAB1aJtK+KAihiHfABRsMrlGf3xUQqHKZ9pE5lAVaoylfEpZd4d9eQ+Q+/8rN/zYeha0goy7djzu0hNn3pxrmr+ZE+DbZXfeJFbqj832KKdMoPCnSrTazBHikvT1y7IE+F5aQ1unT7a5Pc/UZeckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWynOqTM0AggM5eRJKo11DT1f5Uzm2VZa/s4gzWaDc=;
 b=HJ2uorOmXuBIZp4ELtxsGJKrnW3FT14xGKstfc8irMsUggVx0/Vpr9QZqTzCVkT74erz0klk0ncDb738Ooo0mYnsWku6T/BlRMIRN9UxJYAxdmkPObQbkk5TGyFf5K3bTSa8RxKOYacssHY4RA+M9iO2xpcDsOudP5iKSZinjfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <d45cbede-dfd0-baf4-d64d-e5ed6425d342@axis.com>
Date:   Mon, 26 Jun 2023 15:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] Input: cap11xx - add advanced sensitivity settings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
References: <20230626113740.809871-1-jiriv@axis.com>
 <20230626113740.809871-3-jiriv@axis.com>
 <a980885a-3379-9278-2652-1a1b68983709@linaro.org>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <a980885a-3379-9278-2652-1a1b68983709@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0062.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::15) To AS8PR02MB7254.eurprd02.prod.outlook.com
 (2603:10a6:20b:3fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7254:EE_|AS8PR02MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: de4edbf2-9612-4559-01d7-08db76479f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+bqk6AFezAAK0i1GeGayj4KS7y3URmv9rTSSQCubJ8Fj5+HoW72k8znWR6SQlWeinnmhVFkhgGJ4xPN6ibg6IktVOe2zpj7tkEDmL7o/w7PPJJTd/ryJuHO929QsNvpp+ZbcV1AmDM1fYp0jYMS8CBrOWBIN9kj0BLeS9EZxmyIAVYwgWle/SSkGYmh2Ad82k4fJldG80/zuZP3bPSJUESuTF9gKf04M4ltvlqhEM4QhJbso6jg3qV9N3siFpsRBBt61MHuKLjo5poDYNj0T1xhWrAzPlV3+4LJ1aG1jI/PZOFw2fGw+fuUmz6tmHrZIa6E8smftQyOfzbxb9YfbXQxYzKX5Y46R9PVxj2P3RozMLurbV7MXpcNAyj/XqeaNgED1RRQLZ49o6tgKDrir1zjHPfhhRKfHj7aoQ3ZDmy6JSiMMKP+SFGA+HELeZSm/9JYlN5mQhyi0ryK809dDrtIB0NJpwTS7mnAwvak4HCU0JXMywdJNzyxS2uGNRPK+1TIVZm3z56UBu2nOCbVIXpMULM5RXTFEl5336zUDcHqTOBpl66XSf201yZxRyzQ46QEIw7KeGCPSbEUhucsPoqNTb3C5369H0fGpN314A8ILuZitrxAmEeplxnGw/CxBQOKox4Bklza6XLpZo0fzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7254.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(6486002)(83170400001)(38100700002)(2616005)(6512007)(6506007)(26005)(42882007)(53546011)(4744005)(186003)(41300700001)(31696002)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(31686004)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVucndBYXZqcU9WcE0rSHpndGlDYTFjRXpWQTFibU9JVmtacE5hclVQRnlJ?=
 =?utf-8?B?RStxWGE3a1BLV1NKMFJxbmRQMEZYL0dyR0U1T2RQSnlOSlBkcDhIakhubTRU?=
 =?utf-8?B?QW9BOHhTcnJzRVVTSXdSaUo1TU93S2VVUDdER2VlQ25BNmZTbTZ2aS9wNC8r?=
 =?utf-8?B?UGZqUFhYUzNVa2cwZ0pVU3JZOFplTEQraUdDMG9sTVhJTDVZbFNINURGci9H?=
 =?utf-8?B?Mis1SVZnRkR5emxabzJzUGx2dlZMWW9EcVVoSGxMUWh4ZXc5bThJaTR3Zjc0?=
 =?utf-8?B?aWhLWlo1WE5GdVAvdVNFZ1NyR0phb1pkQlRHNk5aT2Y5aGpLcGR4aC8zeUtK?=
 =?utf-8?B?amdqOFhaT1BKczRNQUdhaXFpV0NvS3cxQnNQMUMwRGU2WlRsSjJOY3FhcHBn?=
 =?utf-8?B?anlIYmxCK2lUcHRCeXdUR1RlZVZTa0pwOG9xZlFiMlpiOXM5OTVrY2gwOVVB?=
 =?utf-8?B?N0VRQjZkcDY1MHVZaW9qdkJNYjZYTkJKcG1yVUMzbUZYRjdNanpsTGJ2aU4v?=
 =?utf-8?B?YkxKK1pJalNiQXQzeFRDbWg5d1ZQaHYzdWhVL05TYVU0NTY2ZUk1SXRhdTZt?=
 =?utf-8?B?R3FJMDRVMFBybkREUjI1NkJlWlpwYTNuakF2QUxVV25MOTZ6Ykh3ZHFWclQz?=
 =?utf-8?B?a3FwS3VEMW9tdldoYjAzUnFQeCsyZEdiSThDVGw4Wk5wNUw0VmJHQXZ3WUd4?=
 =?utf-8?B?K1pCU0tTYWxkckdVQ1dxM0JqQm1IUldkRWtmMWIydWxaRG5DTDlYL1ZXWks0?=
 =?utf-8?B?c3AwNTFBcUdGMzQ2bFBLaVd5QjZCRWlwb0Y1LzRrRFU1TFFrWmNYV3l4VE4y?=
 =?utf-8?B?ZkQyZnFUUlVUTWxtTEZOVldCM21paWkyZzRRdkZ6NGVtL2wzMlF0cHVaSWJU?=
 =?utf-8?B?WkhXQWdUODI5eHZ2d0tTaVY3emFjQ0hwUFNDbGNEMjJtMmNwemRhNHZaclBo?=
 =?utf-8?B?WTVURWhmZlFjb1pBZkNmbGxwaXA2bGdqK3BYNVQzdGdVTXhmSUQ0OWpBMGhF?=
 =?utf-8?B?ei9VYzJJanFhbHVNR1grVStHYjY3OTZOTDBxZXVrZHRFVWpTa2pwa3p3WE1r?=
 =?utf-8?B?NXRRbmFNbFYwTm9NMEVwQVJpY1NneHZORWhHU1l1QitPVXBxajBNcDV5dlBK?=
 =?utf-8?B?OENHR3JxUTcxOHZKelV3aWJrU25JMGIrcEFaaE1iWHdVNUlYVzdBOFpDYXVO?=
 =?utf-8?B?NHJtZTd2U3hlcGpOcTBFbmwySnJmR2p6L1pIYTVnb1JFQzFMSDVpV2VtdXk1?=
 =?utf-8?B?amMwU2xWSmwvMXR0a2RDdkpLWFdva3plYW9zTnZPaUNYL3Q1ZGN2ZGt2dHF0?=
 =?utf-8?B?Mitib1o2Zy93SW1TZnFEQW5VWXM3dEVON0dsS0dMa0FQV0JhZVVtaEpJK0Uy?=
 =?utf-8?B?bGVpMStzQVFTK0hRdGNldVI3K0xKUnhUdVhkRmVzcGJLSWdGRExUOG1BY3lF?=
 =?utf-8?B?ZUw4bTRKU3EySndmUHBxaVFxSDV5cTlvaDRtb0NwYkczL1FoWjhEUHZkNzVY?=
 =?utf-8?B?dnViVW1jc3o3KzlBb0lNZEZLQjRCVTE4dTFHN1VSVUV3V0pWaUNneEREWVlM?=
 =?utf-8?B?WnErT2xGQzE1VlFUcFhvVmU0SlJldngyZXdJTmtTSUw3WVMrUFMyQ01Jak5C?=
 =?utf-8?B?dTlJcnFQTEtyV0lTeW5XQy80dUNESjlXUE1GN203RXRLa1hjYm16bE80Nk4w?=
 =?utf-8?B?RmdNUmlkL1VsZXdteXlOR0x0Mms1T1IxR3VjS1RkeGhTMkljMmtCS3dJRW5v?=
 =?utf-8?B?enNKLzlJcWRZMWtub2RsWVljb1UyMC9ZUmE3aFdZbDhXYWlYZVU1MUtyV0l3?=
 =?utf-8?B?MEd2THRTUjJ2K1hJRlc0MFdhYjBhZ1ZGU2VaWktockZEVnVkMzRKMS9EbnpI?=
 =?utf-8?B?MEFTcENJMnA1S2V2OUJpam1aMDZYR2d5RzNGZmloQ2E3QmxocWlGNmh5L01Y?=
 =?utf-8?B?RHlRdWY4OEVFZE82bkJqbHJ2TE5yK1g0YnBZZmo2K21uWml1bG53NlVCc0lP?=
 =?utf-8?B?WTJvZW9sYWNxSFpOaUNwN2pvZjVVRm1NdEQ3RmlFTlNkR1Vqd3A4Z2l4a0VZ?=
 =?utf-8?B?b2lUVnYyWnFJaHR3ekw0VHpOZGJrbGlnR0lEYy82OUFTVDRQZGlTcDdxMHRt?=
 =?utf-8?Q?TL2XH4+PpjJtBnx/O7D9Ti7sE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de4edbf2-9612-4559-01d7-08db76479f49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7254.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:16:59.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3t67VtLaINS4MirPXQKeH2Dy9pXvZEjUDa5eUn1uPXZ+v6iVaf187GrEKx+oqEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9628
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 14:37, Krzysztof Kozlowski wrote:
> On 26/06/2023 13:37, Jiri Valek - 2N wrote:
>> Add support for advanced sensitivity settings that allows more precise
>> tunig of touch buttons. Input-treshold allows to set the sensitivity for
>> each channel separately. Also add signal guard feature for CAP129x chips.
>>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> NAK. Stop adding fake entries.
> 
> Best regards,
> Krzysztof
> 

Sorry to you and also to Dmitry, I incorrectly used "Reviewed-by" tag.
I wanted to add Dmitry as reviewer and give him some credits.
I hope that "Reported-by" is better, but I'd rather put no tags.

BR
Jiri
