Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F399373F47B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjF0GZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjF0GYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:24:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92DE5F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:24:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso16407125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687847084; x=1690439084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C98sJ4ODjsZ+PIPWAYUbo/b94g4oGT8VWWd+gYZdC8Y=;
        b=uv3jvPbk6CbFCNFmndl4tn3daErP8c9c+QwKX1LiovcdtenXucdTjrfhHEwnPFk843
         dweIw/aef9loL0yiVDr0Vf7L/7Bfg1dKHeWQt8/xdo+fgvBpiekVo4CWxJYbeHkLZ4jT
         NLEOr0TsDrmJHcERtGoeICW2oyedjRQFfES5Q4+QD08PCzrfHUjE5PQB4OwmrjKkfqL5
         XjPVw9WjVfgsypASqiH88mQG2CQgXBBynh7WWyRujqsUMeYLMSeqDiP86a96/V0yKSsz
         PSiVVnd9ZBRQsl14hAOhOw7kg7a5DcewJW3X2ofiGv/cpFQ1gM2eScgFsMxDKENvUOAM
         +vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847084; x=1690439084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C98sJ4ODjsZ+PIPWAYUbo/b94g4oGT8VWWd+gYZdC8Y=;
        b=KYjFrOmDnip0V5pgFjsfpljLxlSCqZyAKjsncz7R1gGfvmplexBr7FLVGYF8fv3ca4
         BXiSoWnKgplG+PLL/Oi6eNN17ZLZ0GC3DDTbK/K5Fr5q6YHv8g7fc434XGuX6BbB+9jW
         alXgfm9+6zlSZe+a2y1f81+yMGqy6Mfk/t961+0+oyJZ2+RFuzJqkdBCKm5mwI9kDUKu
         XIx5vMWm0Kx0QTYEhUiJSl+9l9FpTVX/138Ui6w/xBrogBeCI/MCWZzG7+/FtJrFc7Gk
         fGi7pm+a9m3IGUxHTXjLM368VDhKtIWTdAoBvGx/NeGmHquxt4HBu+v6Mw9qSKbwaNq8
         JGsg==
X-Gm-Message-State: AC+VfDwYQeYCAFBaEJBtIrnIpvH1rjCqwnNKjNEu5FKiuhLpo1zcRTpo
        UcgdTvqSvKLml4tqn9vfGCGHig==
X-Google-Smtp-Source: ACHHUZ5m0+fZBZC74PuVSF50TNZrU4lB5BVimIJf0UB/moRgkUGOinN/zs+UsF+XR3uW/d//lA5nWA==
X-Received: by 2002:a05:600c:213:b0:3f6:91c:4e86 with SMTP id 19-20020a05600c021300b003f6091c4e86mr21721010wmi.3.1687847084390;
        Mon, 26 Jun 2023 23:24:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fba80535a5sm226240wmi.24.2023.06.26.23.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 23:24:43 -0700 (PDT)
Message-ID: <16731023-7dc7-d43d-1b16-fda44c0948ed@linaro.org>
Date:   Tue, 27 Jun 2023 08:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
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
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-3-1d5a638cebf2@somainline.org>
 <c9681bce-efa8-9b79-4bf6-837dd6a2dc12@linaro.org>
 <55b0ca89-8f2e-5383-59d4-6809e813abf8@linaro.org>
 <vnp263d43flny2ibt3n7fbloyi26enqrejnobogplfu5fcj6l3@s7zkxrsi2rde>
 <52c57cab-10cf-2e7e-2c1d-fa6506786d45@linaro.org>
 <jmtjuya4c423rmdlo4ubvvqndbxvgapal5otjqnejdpdd25izp@kewbjmqdu2xs>
 <6311f26f-79ee-c471-649f-5e0b4629cfcc@linaro.org>
 <uuy5prkjhhs66te7h6z3pu4lzj2cfbiqk6ftjijwoeqpw573av@ogs6cboanvzc>
 <ziykmixskqkgheigefvyo4q3katbc4uix6jtcg7mncs25z4tj5@5gykrfgns4bm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ziykmixskqkgheigefvyo4q3katbc4uix6jtcg7mncs25z4tj5@5gykrfgns4bm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 20:53, Marijn Suijten wrote:
> On 2023-06-26 20:51:38, Marijn Suijten wrote:
> <snip>
>>> Not really, binding also defines the list of clocks - their order and
>>> specific entries. This changes.
>>
>> And so it does in "dt-bindings: clock: qcom,dispcc-sm6125: Remove unused
>> GCC_DISP_AHB_CLK"?
> 
> Never mind: it is the last item so the order of the other items doesn't
> change.  The total number of items decreases though, which sounds like
> an ABI-break too?

How does it break? Old DTS works exactly the same, doesn't it?

Best regards,
Krzysztof

