Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878E067E080
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjA0Jku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjA0Jks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:40:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067F31B9;
        Fri, 27 Jan 2023 01:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A4CB81FFC;
        Fri, 27 Jan 2023 09:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B7C433D2;
        Fri, 27 Jan 2023 09:40:39 +0000 (UTC)
Message-ID: <019f6407-a7ca-3129-d4cb-2cfed7519369@xs4all.nl>
Date:   Fri, 27 Jan 2023 10:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/9] media: dt-bindings: common CEC properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, Joe Tessler <jrt@google.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-tegra@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, Jeff Chase <jnchase@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
 <cd803c70-faf0-963e-fca3-0edd13fa8a29@linaro.org>
 <c092c11f-870f-6520-ad89-001468ed59dc@xs4all.nl>
 <7e941a2d-25d9-44e0-7438-13225c87d8ac@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <7e941a2d-25d9-44e0-7438-13225c87d8ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 10:37, Krzysztof Kozlowski wrote:
> On 13/01/2023 10:04, Hans Verkuil wrote:
>> Hi Krzysztof,
>>
>> On 13/01/2023 09:59, Krzysztof Kozlowski wrote:
>>> On 08/12/2022 11:31, Krzysztof Kozlowski wrote:
>>>> Hi,
>>>>
>>>> Changes since v3
>>>> ================
>>>> 1. cec-gpio: Add missing SPDX.
>>>> 2. nvidia,tegra114-cec: Correct path in maintainers.
>>>>
>>>
>>>
>>> Mauro (and maybe Hans?), any comments here. Can you apply the patchset?
>>
>> No comments yet. I plan to review and likely merge this next week.
> 
> Hi Hans,
> 
> I hope they didn't get forgotten and you still have a plan to look at
> these. Patchwork shows they are waiting for review:
> https://patchwork.kernel.org/project/linux-media/patch/20221208103115.25512-2-krzysztof.kozlowski@linaro.org/
> 
> Best regards,
> Krzysztof
> 

They are on my todo list :-)

I hope to get to it next week.

Regards,

	Hans
