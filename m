Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC464BD76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiLMTn3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Dec 2022 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiLMTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:43:26 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF32C3E;
        Tue, 13 Dec 2022 11:43:22 -0800 (PST)
Received: from [127.0.0.1] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8593F202F7;
        Tue, 13 Dec 2022 20:43:20 +0100 (CET)
Date:   Tue, 13 Dec 2022 20:43:19 +0100
From:   Martin Botka <martin.botka@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        martin.botka1@gmail.com
CC:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/1=5D_dt-bindings=3A_mfd=3A_x-po?= =?US-ASCII?Q?wers=2Caxp152=3A_Document_the_AXP1530_variant?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1e0d86ee-a832-642d-c835-df1f6505940e@linaro.org>
References: <20221213182743.3087889-1-martin.botka@somainline.org> <20221213182743.3087889-2-martin.botka@somainline.org> <1e0d86ee-a832-642d-c835-df1f6505940e@linaro.org>
Message-ID: <C2E9D93B-96DF-49BB-B75F-27D621BF2501@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is very much my bad.

I understand the purpose of them :)

I just straight up forgot to add them.
There is also ordering issue in mfd patch which was forgotten as well and was meant to be included in v4.
This ordering was corrected in regulators patch so i do apologize.

I will be sending v5 in a day or two with your ack included and this corrected and other comments that may show up during this time.

Thank you.
Best regards,
Martin

On December 13, 2022 8:37:48 PM GMT+01:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>On 13/12/2022 19:27, Martin Botka wrote:
>> AXP1530 is a PMIC used on board BIQU CB1 SoM
>> 
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>
>This is a friendly reminder during the review process.
>
>It looks like you received a tag and forgot to add it.
>
>If you do not know the process, here is a short explanation:
>Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>versions. However, there's no need to repost patches *only* to add the
>tags. The upstream maintainer will do that for acks received on the
>version they apply.
>
>https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>
>If a tag was not added on purpose, please state why and what changed.
>
>Best regards,
>Krzysztof
>
