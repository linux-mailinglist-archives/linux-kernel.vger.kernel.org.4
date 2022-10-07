Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F45F73A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJGExz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGExx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:53:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2101.outbound.protection.outlook.com [40.92.99.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2ABEF8E;
        Thu,  6 Oct 2022 21:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPisCov5ujOra4dT0gIp9aVLVbbPjVl27LcSHszcKxQtzUZ4lmpA9b8/Zlv/9/XyZ2Cq43wRz4V9u2aXs0npUDzrKTic1jU6rAQzB2nSWceF8G9ShjfVs5t3iQTwp9Zv6eFgPPHAAqv0wB009jw/qw/9VsmjXshm2pSruibp5V1r4b3R7byQzzJTRz3RkabNiDIhpW6x7c5sZ5Wl/Hx7DO8yXTas2S9rihpXRLIRMaJGtwWyV8PjSW3Hq5E57EOi9z7aSzcIqZCUSD+k2Cu5G4kVkUbY0St2qolLGgHpkPxADW+V5dF2UjBQz6jxK/GTQfllm03wiLuNeaYyWgm7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBgcEtGSwfrmAXMTFxX3P8TCc/LuaVFAUzlc2/vlMes=;
 b=nrAp4vvAio4WMO1FiZdsY/6/ZVO5gZNFaXU8mqPGngQ0jb1gFHPHazsKJfSaefqaLKsNF3fM2IoM8pZyFjCd2zgFMx1uabiLhS+HAnnZ8QtartxwjeV0K/vn1MSHDN8xFEiLwe1EjvCAd96EGA7voEpwhicMpv3TD45EnWKukMz6OWzbINvC6aitKqwkZCu8RVxL0g5cf4b6ij3pko6gWbd6B4aJ3Quq6+GZ+d+9pODxa2dYWGOMqm1+2PO3Mjd8mRm457J4ssM9v5JAzgUt4k/O9j3lmpe/eSC3J3Q+Y4gVj9yOlGRjBoZq+zJ4kbStqvoL50cy3we9Go0fRUKoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBgcEtGSwfrmAXMTFxX3P8TCc/LuaVFAUzlc2/vlMes=;
 b=ohmz6xXHGdb5EwWFjyv6+LiEcVqrgDyjG02eAu0G2fXE4FZoyNC8AJsMRafBTH/SZtAOHQNjp+bYdUzMxRqxNLC69nJpOhlg70sOXxZARMd2KHQFpt5zMEB7DuXNXT0i1uvpacd4SxZZJrt8OohMvgyBL7zir7Vz/Roglo6HTuDgCbd12LbVbaDNwO3Vy+t+d+qXBlQqHFTXqpkf8RgK5nxn/pR4+gC0vqWe5UlE+p+uc7OCIFwgeDbgfWHI+jIDiUBBitAXys8MfHUnak5d/OTDlEIqcHtTvZjzbgN+hXjqZ91OpAmNfNe3Rm4Q6bJ9ovN6X3yedX6yLiIKluPNPA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2234.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:171::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 04:53:48 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2260:9c8e:887:2057]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2260:9c8e:887:2057%6]) with mapi id 15.20.5676.031; Fri, 7 Oct 2022
 04:53:48 +0000
Message-ID: <TY3P286MB261125CD3D2FCB6F390F34D1985F9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 7 Oct 2022 12:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     clabbe@baylibre.com
Cc:     davem@davemloft.net, devicetree@vger.kernel.org, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org
References: <20220927080048.3151911-5-clabbe@baylibre.com>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH RFT 4/5] crypto: rockchip: support the new crypto IP for
 rk3568/rk3588
In-Reply-To: <20220927080048.3151911-5-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [0vdiqqlHM1zUuViTnuXij3RxWTAVsg9W]
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <1ffb32b1-3dcf-593f-018b-54024d437348@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2234:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f666d0-383a-41ae-ab8b-08daa81feb60
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XNkUzoQ6/sNHC7Q+FQLl2y+h2phgAtizg/3hPObNYrvFt/Y2NaXSfjz+THvYmme7PSJm4ebkrgkUnMh9sC//W9MS1y7WFe0UjJjr5Y1kB36Y9AlEwII8yKd0wkqm1MAlFngR9Wxc1a+IFmfBONzkjBxc2deNyWzREJAqpuH6MZpjiAVdxuW7/pG0r+llUub2inOAoEa8UaZwKTGuarEoV8T7MHXPVly5QNyo8WCmIFwTWjbVE9U6L7hp7ffZP7uBt0VldS9ad32efPS9oUYGFjCl6wpnL6pi5SG9wqeqjwW2KItiOoKViKcgds+qRcrLp/4MdcAmzcnQHWTpSUPFcLB5eaCcfXTC53na/d0sRmiGjQMCky7rZlxmUavoaJVEqs8lmjAkh+/XYPuwUpZyF0dVf7R1exnbjx908RAQTT4VR5dqNNyOl2IY8cvQOKvfhS7mym4D6JFicrnP041VGYBCroxP+Wri3aLPI5W3RbltFBOLmYtFAX3LUkIcSbQ9gF2QVSApgkNKVs2FXx+E4QUtiFRAv0J7Lpl9ilI8x8ssnNZycqtlPMErsh1urDHiwWT/IJV8u62rP/khwRmWtkcX62kXm9ccoc28DTelE+U6nQt2+Ab6NLeZl4G8uOcoy+9l6uRzs44H1G4S3PTcey2hWKmOZ6XsbBSgZuKGN8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21WeUJuMWM5dDVFQXRpZXZVZXFBVEREM2MvSytZbjQxaTRLVGF3bDgwQjZG?=
 =?utf-8?B?dFB2NFNnVmZlSXg2THlFRDZPYWxVT3JkWlhlNXpZVFFPVC9yVE54U05qUGRN?=
 =?utf-8?B?NUxETFdSVFVwS1R4L2lJYmtFVnRKeDE3U2tGeTFIeGdYTU5nR0pIeHJBdHNq?=
 =?utf-8?B?ejhkbjBVcTlBRm1yQkdXRStJSUZhOVVjc1U0SnAwdFY4aElMdjNMQVVUbHFE?=
 =?utf-8?B?UU5wbWhVSFQzK1hwcjhQQm43ZTFkK1c2R2dRNFMrMTZTcEVlMk5EWFp2am9N?=
 =?utf-8?B?bU9sYjhTUWJ0eTlLN3FHTG5sMTVELzltSEd6OG1Ia056T2FMRUVGNVZyMTEy?=
 =?utf-8?B?WVA4dkgyVmhWT2xtT3hLQUFMOTZERUZqa0dJRGtPcmNvTW0rODk4cTNNTUFG?=
 =?utf-8?B?ZVRPVVBud1NMRGRlckh0Qk0xYmZlam5jakd4RnN1MUpHcWNLWFFoWGdxZmpo?=
 =?utf-8?B?TENtdjB6RW9ob2FvcDZLbXpFdzVjcFRNcXQyaHBNQmFSczlGT3pjMUpmQTdO?=
 =?utf-8?B?NWxHaFExMk14ODI3cU5rdlM0N0o0MzZJMlhBR0p0MmUwMXNjQXByUXBKcTBp?=
 =?utf-8?B?WDJBWUVuMVVEQ3VMTS95cGtjQkZrOVN1L1pmd05ZVk9uNzlDQkp0RXhUVzF0?=
 =?utf-8?B?NnJIaVEzUEQ3Lzd3U3ZLOW9vWTYyRFNoU2JqQzE5S3FzK3FoNnV1Wll6Tkhh?=
 =?utf-8?B?MndLTThHRlRHTkRIZDZrQXhqWU5TbnZuVDQzR2gzZUREZ3JSTm9zUnF4ZTN1?=
 =?utf-8?B?MTA3TldJZlhhVFJ3bHpUbCs2ZStvRTUySkJ4Sm1USnVhNm1xNHBrWFY3eHBD?=
 =?utf-8?B?N1NpLzhXNjE0d1N4OWhrcFhCTVRlLzBxdE9OeVNyTlZZL0FSZGxBV0IydGlC?=
 =?utf-8?B?aUEvV01FSjFTbmxYMk1wOXhvQ2NtdW1xbTVSTkl0UVZubWF5UXB5Ym8rNUtS?=
 =?utf-8?B?YVNjK0J3UExuM09CUGhGZTFPa0I1Z0R5NzNkZExDNWpXN1ZNYmlyV3pmWEtF?=
 =?utf-8?B?eEYvQWNtcWFWQzI2R1draFh3RXVycks5azNueFAvc1Z2RHVORFNMSWZPVzJr?=
 =?utf-8?B?UGFuekF5S2R4S3hybkFMMnBKSEdJV3dZSFVJdWhRTkRkdzRSUmFuTDNQWEdX?=
 =?utf-8?B?NE1MVlNJRmVybjJTMFZqWU1zcVRMcFZkVFhhYXJ6RitHY0ZSUTNHYjVDbEJt?=
 =?utf-8?B?anU1M3pqRkszQlpEM05pYTRZK1VlejJ6WWRPL0dEbjB0TmlIWldsOGR4QWVi?=
 =?utf-8?B?ZkIraEQ1aW8yQW94RnFURC9RRGEzODdYL1czVlA2TGRLTmEzVzlWQ1hHUWU2?=
 =?utf-8?B?VlNMc3crL3U4ZFc4bnMrcHNVQnduSXp4eWZDdEI2Q3dRUXdQU2ZTc2hMblBY?=
 =?utf-8?B?WWg2b014MXdqcnNVNGdIK3QvZUVJZjJWZFRaVldXNSt6MlZZNTJWRUpSL3RV?=
 =?utf-8?B?SGFnOG16bFhxUVpmTzJyLzRCbTlvdkNjQXVqam95ZzJiZ0FWRlBjZ2JBQjZa?=
 =?utf-8?B?enpWVk81UkNxVC8wZ3gzZUdTNG1WUUZxdTlVRUVlN2ZVb0tjeVJrVkNGK29z?=
 =?utf-8?B?R3FBM3k5cDNQS3c5VldobjJBdG9WZkpVL2ZpVnVvV1g5YXRtekdnYk5sVUV4?=
 =?utf-8?B?TGROK3pYejZBWU83dXJYWUdTZHJBZE50ek5oQXlGNDF2Q3k2MUJRY0JQNld3?=
 =?utf-8?B?MjB2K0pkdmZoWUJWTnRUVFU1Q0NGaWs5Mk5rMXROYkhuM3hZNkowV2ZnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f666d0-383a-41ae-ab8b-08daa81feb60
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 04:53:48.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2234
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Corentin,

According to official document

(https://github.com/JeffyCN/rockchip_mirrors/blob/docs/Common/CRYPTO/Rockchip_Developer_Guide_Crypto_HWRNG_CN.pdf)

Seems they have just updated downstream source to support more algorithms

such as RSA. So it would be better to sync your code with downstream driver

for more feature.

Shengyu

