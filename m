Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301996FEBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjEKG0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:26:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF6CA;
        Wed, 10 May 2023 23:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHjy2m/SNn+tmYuPDh5PdPBDb7692+Is/xA9MiR8q4U5yWdkXP7A/i5den9X/4CWZ0g0ZgQYgqoftmKjlFe7dcaEFW9qQDTzSpGuZx+xrULAdxNrQ2De8EiaLYN4totD06rEKKs8a+T9sAjsDskBdwt++oAC06hIYRAWo7fWBKW9eOItfLIoSefk3urOPCBroXOnjRso6zyFNCPR4kciA8Z1Mhsu8mdgTxdZsyhsAqbnQeKpisqCokBTzQ1g714ErUnsK1K0U9uDu3xVybZkqiCtT/cphosg/PuntXXqg3q6TbW0W80K/XQOK/oWC8ZU6r3I487FR4t+5LGSh7LrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiKikkBQ1cUYQEoh0hmTm9wCkjytOKFu8JX1L4h0LSg=;
 b=M+sbA3+d01swmN7bXuEG8B7YvAtvZfEx+2963B5di9q4hbD+T9vQEWDWQPxA4qoRr7g/TF8GbjCSP+/qw0uiFPGceThDJC6VIM6dOiddhQ55BUGgH/TjmGZ3mcU5ysdtyuwDIaIcm3RMN4hTa35K3uM5zmq1oN/+rFjNDyt1FNDhd9DNQgP1CPXoTKb3KVDN7HFnzgtMqaJrD3IxxWRa3yuobsKyivlYNcC3U5tGtQa8st9U1+4sykxeVQElFeAuBqCQSjHn2478F2ScIzc1f+P6nzmgSqYUAd22rP0S3yQOPcB6SZ2w6K3Be2R/z/8da2m3Q+k/SFaMCIEhH6pIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiKikkBQ1cUYQEoh0hmTm9wCkjytOKFu8JX1L4h0LSg=;
 b=uezgHSa3s7+6suXbZmOIewV57YlaEA9QhvSgQrf9fHqPIIONxljYv8m7qLa5Nc6npM+j2vTgedM9KRBzZ3+myrIPA7qAwEKwUnGT5Djw5bKzkHQBUGQQ99Mf9Kkbploael9bmpkpcq8iCf94Y9GU4JS6Y/bhXzKgcFavImoyil8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB7895.eurprd08.prod.outlook.com (2603:10a6:150:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 06:26:31 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 06:26:30 +0000
Message-ID: <0ce38757-c714-dd3f-3713-3b938eec4e22@wolfvision.net>
Date:   Thu, 11 May 2023 08:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] dt-bindings: input: touchscreen: st1232: add example
 with ts-virtobj
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-4-5ae5e81bc264@wolfvision.net>
 <20230510145911.66jxevntvzrghoct@krzk-bin>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20230510145911.66jxevntvzrghoct@krzk-bin>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:800:90::15) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d419e8-94d3-405e-8c98-08db51e8a88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQHJLVXSEjqeKiys4Bfs08YvNi8u10iS3cOUlbjpusdue+rh0RxSZZZ637Bhee1velgDXQ0+u22Tm+I6QpyUChsFgsWDvyhoFL8UnrQE4dPm1vGAO6ItLVHkoQsPEEsYOClMl9iUpVdw9Q1ZR2Ubg8NJKsUv8vf23+e5xr1XsiUDT0HO1DFy2yCB4TRUbeIMAZYJ9jcuQaMbq2GhT37sPsvfwVjuDeWUe4f/X5x4w7LM+6mKA8A5dmbUODdhrCfIMREsMQg61YmYmBpWMbsOSQGHBN7GdbHRbp2Nit1Ng3DhQPRqIzr10Xl/Vphk+9Ly6iBgP6vaGiWEWIs8E/cJNq3i3dAqH90dSCm9iHDaehDRDH83srm1Cg7yg8SZbiYa55K87wuNgEvYtWhKgGd4I49q8jcKx6PS54GwOqT/lRhIxJsQI4jYnhU5zDhXTiD8I/40LDVuhlt4OuzYuuTVRldC/NIkpd0cPTI26fdtsI7Jlk+vsiD+ePPZJjM+g81HFAX5tQJnl086tRfMcupeM1mP3kKE8M20tPO/w2SPNtKTECYgc9BAuQtcTq8fJ0FBL0LPrb3um2nfsOR2ctOBGrJg3egOpcqLdIqErGqHtZ28MkkYoDwxxe4f52FYpnncazqnoeR75sFsbRbMtZmk4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39850400004)(136003)(366004)(396003)(451199021)(66946007)(4326008)(6916009)(316002)(66556008)(66476007)(83380400001)(7416002)(478600001)(44832011)(31686004)(54906003)(41300700001)(2616005)(38100700002)(8936002)(8676002)(6512007)(26005)(53546011)(6506007)(966005)(86362001)(186003)(36756003)(5660300002)(31696002)(6486002)(45080400002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJDT2h2YXZjWjc5NExDK0FnbnZ5blhnR0FSbVRRNTF3WEJDVTlQcHovVTBl?=
 =?utf-8?B?TkQ4T0RGSTBRY0VUek11aE1HU2xWTWhPQ2JzS0pIQm1MeC9Gd0tXYVYrTWVn?=
 =?utf-8?B?enFnSTlUNWwySVk4ZCtHYlpJdFBZa1YrZDRpSGJmZWhZc1hwZGxRQy9HbGph?=
 =?utf-8?B?ZmVqc1VIYVVGQmxZSWFxL2JZbVQxckc3cURGYTN4S2FhYUFvY25lcXlvMUJx?=
 =?utf-8?B?REo5NDRWTExEOTdLVXVtU2lML01qQzlHQitUUzRCWERjeDZ5UUZEUEtNeUNo?=
 =?utf-8?B?RmsvT0E2U0hWWTdKTThjYnBmc1NYeXE2TEFxcG0vNGV4L1ZCUkZ1NzlyUnRk?=
 =?utf-8?B?Q3g5L1hCdDhVOStIeDlhcXVxVDRicTFPWXN5dVFQNHRGL2x2NGJHLzl0QUZX?=
 =?utf-8?B?Tzc2K1Fndkd2dHRDeVA4M1pCZ2ZybC9kNCtwRkJSMDdYd1ZnTTNPT0hCOGpi?=
 =?utf-8?B?QzczVmpmcUp6SmZYK3FzOFhCOXAxR2tSa1NqV1M4eDBBSVNXaFU1NFNQeHdR?=
 =?utf-8?B?VWxqUkxtSTdaY2FQSlMyeDlqZ3hoK1FaWnFBM1pVTTNuK1FUWHJURGt6Ui9q?=
 =?utf-8?B?RUpRMXA2RnJmSWgrTDdLbEc3aDVkVktqd3g2dTZmVXJTYlp5LzhiTVlYLzZj?=
 =?utf-8?B?SkxscktWTUFWanRRaWhNR0Y2ZWtGUzltM1h1RmthYU9DOEJyTnE1akZLUU85?=
 =?utf-8?B?Vlh3aGU4M2cxSno2MzdzWkdGelU1ckU2OGVuamU2aGJ0WUh0U0R0WVF5a1Zi?=
 =?utf-8?B?NCtJRWo1S0ZhNzBRajUrV0duOEtiTlpZNElSbXZBZFpQU05mMmVuY3NZV1Vn?=
 =?utf-8?B?ZnJHS2M0QmdKOTFyRDZZN0pWWjFqRmJyTG02c081Wjg1dFhKNGNSdlJYWGtw?=
 =?utf-8?B?VHU4TmRLQzFTZ2lnVFVGd040VmNBZVdlUmE3aEFET2J2bStqK3BwVXJtS3JJ?=
 =?utf-8?B?cnZpNVJoU1JjeDNzVXQvNTRFNDV5NlhDWGROSE0wZTE4dmZINGdGazhqcENm?=
 =?utf-8?B?djV6Mms0aDZYYTdCWUxweUw2U3FLT1FQaW4xYmFReUQ3b3lTZDZKU2pCajI4?=
 =?utf-8?B?RlFmbUFKYjRuNTE3K2UySnQxVFp2eEhDZGY5blFCVVNXVjFJQlB2Y05KaXFK?=
 =?utf-8?B?TDFzRHRIRGNFNmlBYzUrVWdVNFF3aTBISlV2NzBJenhaM1hzNXl5eDMvMFJo?=
 =?utf-8?B?TVhJNkZITTdjOExHK0NTbTAxdGg5d2xwUGlHY3o5SzBjN3lONmN1T3M2a0hY?=
 =?utf-8?B?N20xWG9IVEw0RHpxdHJjeGZWdk9QekY1cnVPcDdrU09qc0NPdytIUDFQd1Js?=
 =?utf-8?B?bGVvSHRPOTU1SUloNFJydzRkY0F6QzVZOUREblhaWktBcDl3QjB6ZWJJY2hj?=
 =?utf-8?B?S1A1d1Z1QTJGZWhuREF4VmltbTVqazAwTk5uYkFrQ1R4aDZpajNvN3JjZW1z?=
 =?utf-8?B?NVVIVERNd1dWai9IVnh2a0tLeGNtWnRNaWg1bkRCcHV6S2IxdDl3MThoNlVa?=
 =?utf-8?B?anlqQWk1dEo4bkxucG9iZkRUTWtKN3kyY0NETWJKcWZKbFh5TEhvejBFanJs?=
 =?utf-8?B?OUJZdVNIOVE2eDdGcVFuV0Z6RkxwK1hiNjRiRTFlM2hURXNEN1hNZVd1S0Jm?=
 =?utf-8?B?NTVsbXJzMlFhTDlHZXRIZlpJbndsUnBqR2RHWG5OaEw1Q0t3dWJsTWtsa3dF?=
 =?utf-8?B?UHpleEttb2JlOHR2eHVoSXQ2L0lQdGtLUEIzOGlINVIzdjR2dGpwdEQvUTNv?=
 =?utf-8?B?RFFJdEFhTWVGUHM2SjMyMVpqSy9JZnVkMjQ1L2VYVHJCSTdTZW9NS1FOdVpx?=
 =?utf-8?B?T21FREhGWVZIY01ZVGM5M2VaeWt4dXRxUVVrVEk0eXl0MHF0bjNza05IZGMw?=
 =?utf-8?B?ZjNhdkNHU2tLbXRBaW9xWFBDNnpDaWJFTUltOGpheExqMEpvWFVva1YwSEJx?=
 =?utf-8?B?UjlmSUJaMVdBSWdEZ2d5Mnk1a2J3V0krbTAwcmUxUmRXdUhVLzhNTThRYitt?=
 =?utf-8?B?ejcvL3RjaXJzZ25EWjFDQU0xeUFVRmZEaHRxOU51TWkrdzlhOXVFSzFaSlIy?=
 =?utf-8?B?M2tSRFpCcVFXclM0d2lmZEZ0bm1IdGVBRWxIT2hYV3VndFlFREQram5uRmZR?=
 =?utf-8?B?SWJBZ1UxMVVrSzFRVW5TdjZXd01kVEtpOEc1eTJ3ajNPQVZNZ1VncDJ0UmYy?=
 =?utf-8?Q?KDwKI1m/k8agjPkdXn57xns=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d419e8-94d3-405e-8c98-08db51e8a88f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 06:26:30.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OWgGyX8P3UDo3q1OEvwOZZQr1Si7PbnliYTZ46pjDCYGe6dvP3KuNLJnQUFk/K+9M2jeCuE9mtxosoKssCItJe/lv3lhtXL8NVGJ5TX/Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7895
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 16:59, Krzysztof Kozlowski wrote:
> On Wed, 10 May 2023 15:50:49 +0200, Javier Carrasco wrote:
>> The st1232 driver supports the virtual-touchscreen and virtual-buttons
>> objects defined in the generic touchscreen bindings and implemented in
>> the ts-virtobj module. Add an example where nodes for a virtual
>> touchscreen and virtual buttons are defined.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  .../input/touchscreen/sitronix,st1232.yaml         | 40 ++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.example.dtb: touchscreen@55: Unevaluated properties are not allowed ('virtual-buttons', 'virtual-touchscreen' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> 
Thanks for your feedback.
This patch depends on: 'PATCH 2/4: dt-bindings: touchscreen: add
virtual-touchscreen and virtual-buttons properties' from the same
series, where 'virtual-buttons' and 'virtual-touchscreen' are defined in
'touchscreen.yaml'.

I could only reproduce the error after reverting the patch it depends
on. Otherwise it passes the tests successfully and with no warning
reports with dt-schema 04.2023 and yamllint 1.31.0
> See https://patchwork.ozlabs.org/patch/1779521
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
