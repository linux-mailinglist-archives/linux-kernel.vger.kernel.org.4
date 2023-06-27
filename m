Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8773F845
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjF0JIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjF0JHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEFF99;
        Tue, 27 Jun 2023 02:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7E86108C;
        Tue, 27 Jun 2023 09:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EEC433C8;
        Tue, 27 Jun 2023 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687856855;
        bh=TjvnIUutoha4FVKthOxFxk086EeAI1ezUBKjYwysZoo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AplOOHE1phsv72enJdweaK2cufs9vTT5p4XmJvTMx26ObcBWxbTpca6FNhJFe/KV/
         EEPlrCnR1o0kL8oI5JBbTS8d1Vxu0epX0nxaiIzJQ27BSOlX6TGVLbSGjuRAeUbLMV
         nsHAWlfsiXqzB6dl27IZEqDwfomcLh9tKSr8TxD4e5d+DqrJOanhB2zYiIBADBJEcd
         DOwWojLp3PizZ+bhpQP09tbglrQXTGghIca1sC6blgvR5tOZsw69S9OApcZi+8wxm5
         Y8LDPhKxHIclXxvqrtU7rtlShrWJon4CZPaz5lGPPYySIWGvgNlReegwYOK89YI7oZ
         uDbHcIqIS8aIg==
Message-ID: <e1c53cd8-9875-08dc-5662-58f868c40628@kernel.org>
Date:   Tue, 27 Jun 2023 11:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Lux Aliaga <they@mint.lgbt>
References: <52c57cab-10cf-2e7e-2c1d-fa6506786d45@linaro.org>
 <jmtjuya4c423rmdlo4ubvvqndbxvgapal5otjqnejdpdd25izp@kewbjmqdu2xs>
 <6311f26f-79ee-c471-649f-5e0b4629cfcc@linaro.org>
 <uuy5prkjhhs66te7h6z3pu4lzj2cfbiqk6ftjijwoeqpw573av@ogs6cboanvzc>
 <ziykmixskqkgheigefvyo4q3katbc4uix6jtcg7mncs25z4tj5@5gykrfgns4bm>
 <16731023-7dc7-d43d-1b16-fda44c0948ed@linaro.org>
 <yofju7jp7vmv33x7dzvzoelpumfsz3fjqy2ozakfphsuysunon@pglt2wzlsjex>
 <683a6f7e-bf1a-aff2-070b-472fb14e0353@linaro.org>
 <3nnk4xvmpnum2q6g6c6crjlqq3ra7j2z5zis53xcqbvevymuhz@mkffvs45n6ut>
 <145ab255-b3f8-1c6c-824d-5f1b40568d30@linaro.org>
 <makhh4ebdmoa5f6r4mbx4g2v2cpcsi74wqf3622dxuli4w7tb6@els2rvqcnvgz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <makhh4ebdmoa5f6r4mbx4g2v2cpcsi74wqf3622dxuli4w7tb6@els2rvqcnvgz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 11:02, Marijn Suijten wrote:
>>>>> So deleting a new item at the end does not matter.  But what if I respin
>>>>> this patch to add the new clock _at the end_, which will then be at the
>>>>> same index as the previous GCC_DISP_AHB_CLK?
>>>>
>>>> I think you know the answer, right? What do you want to prove? That two
>>>> independent changes can have together negative effect? We know this.
>>>
>>> The question is whether this is allowed?
>>
>> That would be an ABI break and I already explained if it is or is not
>> allowed.
> 
> How should we solve it then, if we cannot remove GCC_DISP_AHB_CLK in one
> patch and add GCC_DISP_GPLL0_DIV_CLK_SRC **at the end** in the next
> patch?  Keep an empty spot at the original index of GCC_DISP_AHB_CLK?

I don't know if you are trolling me or really asking question, so just
in case it is the latter:

"No one is locked into the ABI. SoC maintainer decides on this. "

Also:
https://lore.kernel.org/linux-arm-msm/20230608152759.GA2721945-robh@kernel.org/

https://lore.kernel.org/linux-arm-msm/CAL_JsqKOq+PdjUPVYqdC7QcjGxp-KbAG_O9e+zrfY7k-wRr1QQ@mail.gmail.com/

https://lore.kernel.org/linux-arm-msm/20220602143245.GA2256965-robh@kernel.org/

https://lore.kernel.org/linux-arm-msm/20220601202452.GA365963-robh@kernel.org/

Any many more.

Best regards,
Krzysztof

