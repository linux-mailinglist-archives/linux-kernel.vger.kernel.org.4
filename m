Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449DB5E5B76
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIVGgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIVGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:36:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B773FB602B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:36:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so13075962lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/sdjh02mE/SwIBy9BvwTWzCrb2uaUdQhgWPujtLokpI=;
        b=jDX5A4bzS6ImCNWPXKQIbzs984rLqA8YysFxfSRnRDcn3CzqXbW4jMLq3JC4h6hBh5
         kKui7pP5Q+YbOpqzjDnCHCvQWbRnHbmNe319BJrUU6pWzZ2EZXClOjUiilupN/o7kkio
         8hXkRs5c2CnKWvPu395WLgBdFUa+LNUaOPxR5U9IrT/q3E8MJT65eDGQYlU4zGpgJuzb
         eHHODAlppEs7ve0NuXo4ULr6ao5YTUQG35eqzMxK/TGXb2nnZGVeGM/11NjoW1hMMNdw
         aSl5BAoCStMkRmz5tLZDlNn/zD6h511AmZNTURFphRtQtP4WwPFWRHAt4p+m35U1yOhy
         Qn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/sdjh02mE/SwIBy9BvwTWzCrb2uaUdQhgWPujtLokpI=;
        b=HC+98BfJO1umoV9ExEuGWfY5ikAQXoJi5GiBi0zB1QydOhk5ZD5HaxkuzYPJn51qQj
         iBtrZ7yMrrDYRZolFOyDdHI/557JloAt962lvZ8PAuP9T/kVJVaHXfprIfbbly3cVrHF
         ZTNK47aBqNvNbZD0CK6llqRNSQxQ/7M84P5BqL9GfCRReQ+R063k/hJzG2okcuuRFQ0R
         PtT3GPIuQQ54jkILcOEeJSm4/Q3iQbR1+zAnU66uZq1zHP1GO7KHVLh1YLkRIvXrTBAq
         Ich/xekZbAYmDSw4eov8mxM6O2ubw1807fD9J1H+RWmpmGM6RhhDI0pfut9Gkxe6sR7f
         a+/w==
X-Gm-Message-State: ACrzQf0ivfcFBs8Ck2SM8Uv0L4Q8cJDYJVK47FeWnnP7z+UIyhEN+fUe
        kdZ2ZOiMBfVm2BFiq7i/b/9VcA==
X-Google-Smtp-Source: AMsMyM7eMr3Jw/nqeC8AFHLZsJf1omxJggP3TBkTPQDhdmwYiKmFT0oUiIBa+iv5nrnw7FzDDHn44A==
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id bq14-20020a056512150e00b00492d9fd9bdfmr619586lfb.583.1663828571965;
        Wed, 21 Sep 2022 23:36:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b0049964f68457sm773293lfr.262.2022.09.21.23.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:36:10 -0700 (PDT)
Message-ID: <10415506-306f-6090-feae-b255c810d462@linaro.org>
Date:   Thu, 22 Sep 2022 08:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM6375 SCM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <f997cd3d-95c6-972f-032a-7646855371e1@linaro.org>
 <df1e64e8-93e4-48e9-f49d-d85360ac006f@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df1e64e8-93e4-48e9-f49d-d85360ac006f@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 23:07, Konrad Dybcio wrote:
>>>> allOf needs to be updated.
>>> Does it? I did not define this compatible in the driver, so it does
>>> not consume any clocks.
>>
>> It's about hardware, not driver. Hardware has some clocks. If it does
>> not, then you need allOf disallowing it. Otherwise what do you expect in
>> the clock entries?
> Ok, so if I understand correctly then, all the compatibles that are in
> the long long list in /properties/compatible/enum: should also be added
> somewhere in the allOf: tree?

Yes, because the clocks must be specific/fixed.

Best regards,
Krzysztof

