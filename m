Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3F615FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKBJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:27:31 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150104.outbound.protection.outlook.com [40.107.15.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBC128;
        Wed,  2 Nov 2022 02:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvNspOJz3i1Na89TXE1Ji9aoE8V1BCaIsGFjWTTZ7oVbkFwAOsKDAx4FLjBdTVJUNEthTw/j+LEJOAL/vOSfcD+mZmB4gSGXK5afuKEHh45V/7l/1to3YN5s0hwl+iEBq5HaGshs9M9KUqgc2cMkesTvzYMC2DLEsEQ6ZchZQXPtzfzizv4ZJQ+K/3j29o5vMAxKaz0ICkziiwq6q6BAOCzsMshlzVqxaBdC9CD2wExzuZN5tWijZWpZ/DLlnPAx/r0tnJw5soXBCUZNjZBDhuP6RzWMFnKJ8HzfFVg4zOREgFUYVB/Mk6dBCOw2EAwIaB3DY4MFwzWhaBrZUV+mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kAUC0bl2QROL8JD9dwS0CsoUN2T41FHjYnid0OGnGg=;
 b=doI+PD6y8aaUNTjR61+ssy/Br+fR15xfVMAQAkNA7n4OfFP1rOOrO0/YEwQ7iqF36JmFPuyCOgm9RGB2YZm2j7rYpWTLh4s/6Fjxc/QZPEOE1i9z0jQYlcamEF+9kAwVgb2c/XysEE8adH68inkhQTmLy44mQN66RUYjZiBPoBL2Aa23xXMUU7h+srw7oaN9muT30PJECgSAwPsv2iSHvpHNZ5DG4NdU08z00E9XWkVvE0q6qMwkuHDaH4e/GaJDRA6nMqwu282MJ4zGp58pp8yrCsZ4NHWJG4qGCYDjX7C6hymGduQ+Mx3MsepH9im37AmLzZ8V4qHeYT6zAtx7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kAUC0bl2QROL8JD9dwS0CsoUN2T41FHjYnid0OGnGg=;
 b=CTvRPpvhfewcbhiJFpStj8NQNWVx4ZjOFj0plUk9SYOI4MQVMwyr48625DY6RPlI/fOE3WeBkOTiTs8iRf+r9xx7KBBsw1nXtpiku7tGgMAtbjuO1aMGjrkQdq1L2GagMHLkbS7PuqAaA/w6F6i1o6AQrUPIJ4XeQ2v+PJEpDAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 09:26:43 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5769.016; Wed, 2 Nov 2022
 09:26:43 +0000
Message-ID: <b0289429-8779-643a-07da-3cda83c8ca9d@prevas.dk>
Date:   Wed, 2 Nov 2022 10:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] string: Add __realloc_size hint to kmemdup()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-4-keescook@chromium.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20221101223321.1326815-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0035.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:13::22) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|DB9PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 302d2995-5a07-4091-e6c0-08dabcb45af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIY0aDzmL0PAhRo8Ms6gNG4AgemXBdDGUsa0jRWuSp/1/HRFXLDRTWD2ERzdAAAXbMxsgFhKlw5jsZAOBepYH0e2ZEyNN8uSzyyZkPvmbm8DBrOUk4w22XrZc89TXYaMwjB/y70BoTHpa5nftVtz7EzlIhFBPMng2z/QfZ5sQXDOFFW8g1/DVp5qt22cV8lQwiwgwIFo07ZNvA0zZfenYf6Brx1eLwJt+G/vQ4Ei6T0CKtdEN9TwC7fjg3BOtOZ6yGkzD9zppOe/JaqnyrNAr2c0E2/vEH6yTyqY3BuKAjF9WNPnzZCvXebgJg1jS8rOyZkC5KCtD44WGnKvxjYa3I+Q0beZH2NxLaKTxXXIB1dPtTnr2hOKwgAyMvwOll6Wt399PBd/DRV33d9r0FKJJH6GGljCZFVvvUIHIQeIlR8d8XCKt71DQcPGmFiU2TOSMcExediTU4LJZ2dAtZfKzL2s3RrIdf5p5PkRKJSnGXaXkVc4/Ks1CqQtBxJgcq18k9+c4SaTy066d0yLzGJiabqrxrLDnjViWEud7iTJZjbUCQ5yNzIChx42egxEj2hEBQwb5ufc2TLnQVRry+lGp6udAd/Bov62DXoSYI71HGSz/DKTAroCYqjbWBx8WadLrKskuix8dMY5cqHjVg1iDXTCNBDTtivw11HW17RYqU6jtMRnQi06a+8E+9QyosQ2fl5F4BOX8geSB897irneELlXoRKOFerNxQp93Y2FqnF6TSGkDhEP2YGT7LZ5T21BaqyFLl/eY6EhsW3KihIvvf+TSSCAre+k2KK501Vbxl1/hDgqa7/iLafqjDFkc/7BLbXewkgs0DS1PSLvHKsiii/ZPMS6z8kcvHw7z0nS4CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39850400004)(346002)(451199015)(86362001)(31696002)(31686004)(36756003)(38100700002)(38350700002)(4744005)(44832011)(2906002)(478600001)(52116002)(2616005)(6512007)(186003)(26005)(6506007)(66556008)(6486002)(966005)(7416002)(5660300002)(66946007)(41300700001)(316002)(8676002)(8976002)(110136005)(4326008)(66476007)(54906003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNOblJwa243Qi9sZysrd0RlN1hPdk5PZVd1NDd0YjdYKzBTWEJrREw1RDNr?=
 =?utf-8?B?SGtzWUVCRGNFNUttQzduamZ4Z2JFaHltSnc1ZFRhWFVhUU5BRkFpczVvUldD?=
 =?utf-8?B?bCsrOEVmckNxdDduTjZZU3hQVVptZmY4RkU3SjUzOE1uWndSRWQwVVNsUWFQ?=
 =?utf-8?B?WmNFZmREZVpFcFAwZUtTcWVqOTJpTTEwMTZ4SnZGTUlOZk11aTlsdVlab21m?=
 =?utf-8?B?d0lsOWovb0xvcEtZdW5SMHNzVjZ4cXNUYlB1QnVQcE1QRmIrQmViQ3lJcllK?=
 =?utf-8?B?M3U1cXYvRi9lSUE0YnJINWRKcS9wVGk0N0JpZTNCMmtBTmVBcmNBMzZBQ3FK?=
 =?utf-8?B?L2w2ZDhkTExSOXNuRDk0YlQxUmhCK0RnR3pWcUJ3a2pVOWZraXc0bktLd25q?=
 =?utf-8?B?MTNhOTdEYUF3eTlpZk1nZHNuWlRPVFBJS2U0ZDI3WkdCOWFnWXhnUmI2T0Nh?=
 =?utf-8?B?NVdSMncwOWsyQ2had0c0cVEyY2pYTlVsS3k1WjRoUnkwaWkxSTk1a2crdFFP?=
 =?utf-8?B?MXcrWDFFaU1aZzdOa0tZTHA4WXdFNkxHWVgwQWxjaS9RcVdZNzQ4dXpqcjk1?=
 =?utf-8?B?REFheEsxWndLeU0zOThncWpSSU1HU00vMUdjdlIxR3ZnbFN5WlEyTkZTakwr?=
 =?utf-8?B?WG9lWi9xeWRJLzd2V0EvTlpmc3N1ZTJLbE5ocGFXcm82d25OTVltemJROC93?=
 =?utf-8?B?WitpVFpZU0pqYzFUZWNnem9wd3BURXZNSTBnUGRLUXpLQzRNZitoTDNwMVJ4?=
 =?utf-8?B?aTNldGtNL08vWjFTUHpNZmZSZUwwS1JacmVqcUxab3JjKzIvaWh5WlRPMHRa?=
 =?utf-8?B?V3NJRFZUZXFXTXE2Y0gwY0NjRk4yZnd5RG1hNDc5ZlNWeWxjNSsyQ3ZUN2w5?=
 =?utf-8?B?cG9iamxFWmk4OXdOUFZNeVE2aTRsMlU0TkpRUVg5NjRGVjhSQ2wwVEVuSkZz?=
 =?utf-8?B?anBqRkMvYnZDSW91dDVrbkZtNkp6QUNjQ0dtQzBWV2w4V0diZ1J1L2JScVla?=
 =?utf-8?B?R3lCTGFXREMvSzZlY3FFZCt5a1MrWEZhK2NRaXJMUDdOdFJxOWdqSCtWSXRZ?=
 =?utf-8?B?eE1XR1dyTzdFTklRekZxUHBRUnR2N1lnNzlRYkcxQzhTMHYwbDFoK25uYURi?=
 =?utf-8?B?SGRrWnQrbS9jOTlnTkwxTWJWTS9mMjlJbVE5NWpRRStlWkRUaWpEOWFTYWZV?=
 =?utf-8?B?d09QMHdPTlZ1T2FjeVJDRUloMHlORFgwVWNncGN3cTdTVHdrNG1YVW84ZWpa?=
 =?utf-8?B?UG8yYWh5U3BIZWxBellQZUxFWW5WM0ZpeGthaUVMYmxnWUUwaGIzS1lkSkJP?=
 =?utf-8?B?TjFvNXJjeTRCTlBzZUVlRE1ySUxiODBmK2ZQNHVoR1hUL0RpK0xpdkRacjMz?=
 =?utf-8?B?VmJFM3dtb1AvMklkMjN4NGltYkdKL2tIWWY0RUdxZEFWU3kvKzlNbU84cXVz?=
 =?utf-8?B?YkN0SXZkS2NkNExTZ1paZXE2bGovSEJZTmxXSEhHVEg2YTV0clAxeXhRQTVW?=
 =?utf-8?B?YUVNQnZwSm4zVFRsSHRLZ1p4ekNmSWdjaWwzaGU5N0JTUnVPcDNubUV2NDhy?=
 =?utf-8?B?Z1NsRUhrRjFlWWhzZGdQK0V6SjRSdEVaM1VvMmpTWk5STjhxUnN1emJMUE8z?=
 =?utf-8?B?RHhieFRXcmJOWkpuMDcyRkk0UU9XTFZrUUtsSU1zTis1Vzk4NWg5SUR3TERC?=
 =?utf-8?B?M2JmZnlqU0RBcUFGM0RyK0FFeC92SkIydGEvWDRxVG1GeUVLKzIyQmsrZHVW?=
 =?utf-8?B?RUlWY21udmx3azh0WUV1eWZ4QWx4cGxjV2xac29wQ3ZJNm53TU5XdFhielc4?=
 =?utf-8?B?bVdmRjJFUWdEYy84eVZCV0NVcXpyRlRNaWhzd05vdjlPQkZLY0ZxTHB3aG1u?=
 =?utf-8?B?SWd2WS84Y2NpYUVjZ0JtQXNLK3ZCNGttTXhDOHd5TlV2UUY4RlFaZGo1b3pY?=
 =?utf-8?B?MlhueFBmRXpBVGQ4S2ptUXA0WUpGczIxTGQ3akMrZ3ZBTnFPSmRWSEFUVHE4?=
 =?utf-8?B?RVFwVloxa2dEdE15MjE4MUM3MTFoeG84MWdzOENpK3EvV2dPZjVZQ1BKQmRp?=
 =?utf-8?B?ektZZXlWbWNLV242c1dLYjNTRGRMTVlLcHNOVG1XaHM5MEhWVTJWMGQveGpr?=
 =?utf-8?B?VEh0S0tMTEtZZlhRZ29CTnJHemRtYWFHQVlCRmRCaTNUZFlkMG1WR1FKV1Ft?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d2995-5a07-4091-e6c0-08dabcb45af2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 09:26:43.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/2MbWYp5jT+cn/MVKDm77U30eBYFwUWYw+3YX0u1f98et5dUrt2R+aMQG03Gp2hEY5QFe3cTWFL7XZj3CxTkIEYPC8fzeTmksckw5uhsok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 23.33, Kees Cook wrote:
> Add __realloc_size() hint to kmemdup() so the compiler can reason about
> the length of the returned buffer. (These must not use __alloc_size,
> since those include __malloc which says the contents aren't defined[1]).
> 
> [1] https://lore.kernel.org/linux-hardening/d199c2af-06af-8a50-a6a1-00eefa0b67b4@prevas.dk/
> 

>  extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
> -extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __alloc_size(2);
> +extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);

What tree is this based on? I see that kmemdup() has grown that bogus
__alloc_size in next-20221101, but in next-20221102 this commit seems to
DTRT, namely

-extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern void *kmemdup(const void *src, size_t len, gfp_t gfp)
__realloc_size(2);

(i.e. there should never be an intermediate commit where kmemdup has
__alloc_size()).

Rasmus

