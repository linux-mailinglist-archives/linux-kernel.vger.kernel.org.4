Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F1B737881
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFUBEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUBEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:04:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2062.outbound.protection.outlook.com [40.92.99.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DE10CE;
        Tue, 20 Jun 2023 18:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKAq0+b6gMXAhXc5vFeSTnej9t94nW3M8fT5tHHRvDbEhbwMtCtfy7JaXEJ0vX/YpQ5NxHi1YuUCVvrUeXRsaL7SxV6C3gkYgNqVmEuvybk8Q2VS2y0Ey+2GAgK5zwsGCSkaj9/PeAS4EEGRsHILOj62luQvSuzOy4+wR+m5OKuM1IQM/6ugKVF8DHdIO4v75RUyd3FB1K/oBJf2Wx2ONRLyGPlnhy3b1q0Qqi1sYCY8YYxwGvsfJrUXUz995R687fI9QAxOK+6DC/3eokcNvdQ4w6+6vsEgwXKuyUFKaCB0TIJHUYcM3GJbLtrwqWj8DQmEwlernUnVT63yF6TpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpy8TtOhiDM9BKeWvI8gUSgJfwVq+vYA474HpMHQqsU=;
 b=MDyo3iXrGlVcjFlw/kWg1AA7P9uXtWJaqSoaqaJDTl8B/KruoMw6iyCDk788NQ5PXAYZ0MDpBoybkHI6GqEeFRSnKUIimtlGBpxhoSPEa/Vwpigq2sPFgBxoNgBYJgGnOWsyBc3EX1kfEfD8Tw1T5FYr7nazs7LO/vDGrqTEDlL+pZUymjm9Xfcf4gcZWZDPmaMzEsBPiHsHq7nL7VL8j4/IZ1kwMXpT+iljwaiaSYfJm823fPaH1zy8Xmibo5IJKXnHKt6Tu8ccyxxR6aafJncAZoZ4j0dxZrVFUBsfxEbGflM78I0vhDp/LzOpEY87Hymdi/U073MAQFVYGgq8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpy8TtOhiDM9BKeWvI8gUSgJfwVq+vYA474HpMHQqsU=;
 b=c02PRwF+TV66FSLaRpSf49GSz9rD2x/pcRA0CgmVxk7wUJoXYd17vAIqrbBJiAmLGRRkbeACIdCCiJ4CNyY+QgtWm9tlmPyKDDqbbkHR92GU+TffI2B1U11XeeyJYJSEkLwlyw0ns13ExI0QmMOCsW247snZtXoF9+W3U/cKYNYaYzMneXSgJOyG8KBByhhZOgt6NPivYyX+5VFizXVE7soKPNK5FXoG57duxA38yVNpVKAFFuCx8RNKqpP42XeDzuyCLg9WceBcsA4IzQb6/LLGRlWzT4dcSL5GKPjBsE0udxvHDxonrlz8km5Rs6kqPjDLd0MREza+RBLEnSzOPw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OSZP286MB1999.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 01:04:09 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 01:04:09 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     sergio.paracuellos@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/2] mips: pci-mt7620: reduce unnecessary error logs
Date:   Wed, 21 Jun 2023 09:03:56 +0800
Message-ID: <TYAP286MB0315167833A9801E56BBFE91BC5DA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAMhs-H96z65X5L-8=ouuKS-fkBUS4Uo4GTaYYgMDkw5G+v73hQ@mail.gmail.com>
References: <CAMhs-H96z65X5L-8=ouuKS-fkBUS4Uo4GTaYYgMDkw5G+v73hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [N2S7f7sQ6fR3LUoAaMGybKIRdke9ZuEE]
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230621010356.3017-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OSZP286MB1999:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc3913b-ff71-428d-e138-08db71f36aef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCIG0+2ikeznNsQoQGzaOuges14z3MyL7TAVZaIHyMj9SCyRtlLhnYmY7u5A++hmcOQ4U8CsGSPZPxoFp5/clv1kCg7MqfZTnJndGd0VBvDLMetIJaTs8Udy+abUyrsKJlUVFTm27sRZIxfv406NGte6NkiRDXkt7VwRXvrQAcWqrxRfv0vL1m9Jg69pTdfhpKBUAU035noqbYZp8xkCmfNvppJFH3in7Hw875vQfIB2RU0X9Ald55kQ6yElSoWUql8uTP0Qm9P/jVM6+lCmTFVldimgabqJGksFC/NV2EvinrFMyZuSBQo2nVCk8+urRUPWtRL2ReBm8PIeUxrZ9j/eglCX9UKf+pEjat5dRRQLo+Zdsyu5lzgXyqhZH0I9loikE5nXkUVs23tdJRrgFerBeIS7ZqzddNny6XPoIHv10+PHDX8oUFuDc370Sz2RF/bHMQ/vfxpjYEPTo1OOsNj8GjgQCY7tvqUoWJZVq39ukVkSP6f1oRJLD469MjGsqnl4avS7hI2f9K2n0TrR5Cwu+esKHgXRdWGbdrJ9BzleMroHxKhFKyqpKujO6coozCrCZbhWolWaQXjfMi6m8qpvffI62/eQChTtq3LX2Rk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBybmp2YW1SYVprM1NuZ29jcllWVU1Lb1daQkd1bG9Ga09EM2hiMVJFUmpk?=
 =?utf-8?B?QWFaQ3YyTTJDTDhLRDA4eXBpc0RQVkxSL2RtQzZ3Z2pGeUd4NmxUd2kyMlZG?=
 =?utf-8?B?Y1Q1ekpIVWpQMGR6SDBwT3hjR0RqSXlIcDBvMEYyTSt0N2V1NTNPQnVFczdp?=
 =?utf-8?B?TU5RRGUrNjRoY2JESUNoT2ZQbnZQSVVzN1BFbER1Mjh2NURteTIzdGFWbjBK?=
 =?utf-8?B?elkzYzJDVzNLMUxkbkY0NEF2NXZaVk91NURHVzdNWENaQWlDNzZjWDkvWFRk?=
 =?utf-8?B?SjdUS2ZXRnhjc2cyR3BONXBKOG8zMnpxVW1NOHBaM2NWOHpuRFZFeGZHWXVR?=
 =?utf-8?B?Y1dLL0JKbUhpSmNEUjF5d3grK1BsSk1ydVJBZXNGMHExaURvQ1BpbVNLbDhE?=
 =?utf-8?B?Yk5oMHhOa3pZQVh5WmcvUUs4dkdhQVVoaUx6eVN1ZEYyN1poZ3NBSjlyUGtk?=
 =?utf-8?B?OFNKaVBZemlqd2EydVFUd20wdktVQktxWGRYM2w5R0h2TnBGZ3BzeHBDWXlT?=
 =?utf-8?B?RVJaTDBzZjdxMGZLMjVKNnlFK2ZpZm9iSlJrdURHVGhEcWd1eVkrUjhPUmZY?=
 =?utf-8?B?OTNuZHg4ZlEwa2wzWk1nUGpWVkFTakRQbkFvNit3VXRQRWNic3hMUGdRVkEr?=
 =?utf-8?B?T2ltYjFVc1pNb2lzVUtVMnd6bEE3UEFDMkNlcmp1aGJIcUJBUlc5YXZJSHpX?=
 =?utf-8?B?YUtUei9wc3pKSHVwRHJzV1NkVGk2c3B4ZXl6c0hVeHdiaHl0UnVqdFJyaG15?=
 =?utf-8?B?RHowR2Q2eXE2RHFxN0JlSlhKcTJyYUxJblVSbytwekU0YXY3c3Z0R0JublVq?=
 =?utf-8?B?RnZWZW5DUzJjSDNiVitLSGxZMXEyZnVESzhIMk5WN1hOUzB6Slk0QytaK1hQ?=
 =?utf-8?B?OHlHTWxGMXY5UEhzdTMrRnVqaVVkeEFQTVRodjh3NGt4UFVaWmw1VWxPT0dR?=
 =?utf-8?B?NnMrbUYyTmdHNVRHeWppMjRKeGpMRTYyNFN5SjdtTXA5blR1bEpzYndDR2FI?=
 =?utf-8?B?QmhaNWhSUHZWY3FyVWV6VGJOSkhRM29RbkVlaXFtUWI4MnR3RE9CbUZXWXBW?=
 =?utf-8?B?YzFmMzhJUWozczA1aFJrMzQ5bXlTOElQQ3RwV2VrWXZybzNlZVZONStvTXd2?=
 =?utf-8?B?S0ZQeDQzVVVBQXgrU2xkalBMcDlGWEJqWUM3YmNHa1BuZGhwOFkrMlpUMFRD?=
 =?utf-8?B?OThYWlhYZ0hMcExaVmozNHl5WVdJelR1ZVlvV1cxNzdNZk9wNENlU0wvMGQ5?=
 =?utf-8?B?NmpKSC9uUWJ1cStNcWxLd0N0SzZCcGJjNUJlRkJDS0NaQ1pXRDYzblJWTWxT?=
 =?utf-8?B?UHVSSFFManFhS2t0dUt6RnphNVFDRjR4NnhYclJJNW5QdWlCOGsweEpEbkJS?=
 =?utf-8?B?bTdQaWlzR0c3VC9vcmVXS0hHUlN2UlU5WS9iam5BZVhEZnpiOEgzSElJUERC?=
 =?utf-8?B?bU9scm15c2VLZjZpQkNDcGdKVm5zaDhvV1krWTdxajU0NmQvWVR4MlZCTE01?=
 =?utf-8?B?Mm9Rb0czK3FrdTNKNHFHaFMxQmVEb1V6aERoZm9uYWZ3aGVTZlhJbFVNOGJK?=
 =?utf-8?B?YUNjQzFPR2QxT3A0NVdUSnI0RFd3VTFPekIvNFAxdklqZUtITE04Myt6enlp?=
 =?utf-8?Q?9Ef+hA+3Dp2ZPNfxQI86noiVr/GE72X9omVNJWPUuFO0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc3913b-ff71-428d-e138-08db71f36aef
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 01:04:09.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1999
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jun 20, 2023 at 12:48 PM Shiji Yang <yangshiji66@outlook.com> wrote:
>>
>> These patches silence some mt7620 PCIe driver error messeges by
>> removing the useless debugging codes and replacing incorrectly
>> used 'dev_err()' with 'dev_info()'.
>>
>> Shiji Yang (2):
>>   mips: pci-mt7620: do not print NFTS register value as error log
>>   mips: pci-mt7620: use dev_info() to log PCIe device detection result
>>
>>  arch/mips/pci/pci-mt7620.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>
>For the series:
>Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
>I'd really love to have this driver ported to PCI_DRIVERS_GENERIC
>moved to 'drivers/pci/controller/pcie-mt7621.c' since they are pretty
>similar just changing that mt7620 and mt7628 init the hardware
>different and only use one virtual bridge. My problem is that I don't
>have and cannot find hardware to test. Do you have interest in helping
>me to do this?

Thanks,
    Sergio Paracuellos

Thank you for rewriting these drivers! I am glad to help test them. Please
let me know at any time when they are ready.

Best regards,
    Shiji Yang
