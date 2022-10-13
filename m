Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A185FE423
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJMVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJMVTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:19:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2136328
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:19:11 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t25so1323502qkm.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdQa4Sc6lXPDk4eLVgKrBJoxIwtdDyftfTuzXhtgqag=;
        b=xXiLtrZxmTJB0QUjoV2MP5lRyPH9qYiv0ttgpO9VVSoyoWFECmEGWcP9HH/6IL+6i6
         XU/Is8HVR8PbwCHLAAyAp4GCfrWse7/omn3aEEzTdy8GUQyjzffw5RkSnNNphDS+S02F
         pVq8itm6asblEVoFLtJ84jkH7yHO66BoFnyzHimOR5Y2lluV8mCR3DBkUPp3QZXSU8gz
         5L/9LFdXgWh6Quic86DuupCKA62r3xtj6/renFCxaXKb7WPgtJ36wIEXOS9bPxhB5lzI
         4UeNQdze9t69+l2na90cg7iS625zDyb1Fd15Te2pm/+8/eago27aEi6Ew0Jl0kdHlH1O
         gWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdQa4Sc6lXPDk4eLVgKrBJoxIwtdDyftfTuzXhtgqag=;
        b=XawDW3F7+xCkTHAuWF2cdmtOe7JnyTnErUwiz9+/n1n5lWeQp7xnmLu8l4vM7z4olJ
         h8ffowJiiRpuzEmjzU0sLX1EK8rNb+Lj2qIazYDIaPgczuLQoMyIQn8vb9V+Q3MRg5K/
         xlSc8Lvo0DdAWEOnZ1nOxFVKlXF+c9D9VduI/Ks8B8vacFxmlHfg3jECU5aWpG/Uu1lI
         RyMJnJuOl/Ip33tVjGrtdfBH0QA/qsWl6EhcJNorulVWcRuDHD0dgfH78kjkBoNzkUis
         9kkP3w38EJuJgj3srgVSNaR2n4Sn9S7uIXE89TqOlYuhaPuGzjfrP/YuaNmOhjb0qZgi
         z1Qg==
X-Gm-Message-State: ACrzQf1CDNDxGiO7cldg2sIYPjihFLqsjcSVcZJzJ4wie08TZAXgw3Pl
        4gu/oKJg1SKVnT2EVsVQze8QmA==
X-Google-Smtp-Source: AMsMyM5FSEL4ZcJOm04pRm55VzmthYq47dNfsl4AJ3TG7oDdZBUrvCAwTXawIX1+kP1G3VxgQ/pFvg==
X-Received: by 2002:a05:620a:4622:b0:6ee:bd1f:fef1 with SMTP id br34-20020a05620a462200b006eebd1ffef1mr1569030qkb.778.1665695950902;
        Thu, 13 Oct 2022 14:19:10 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a0bd300b006bb8b5b79efsm661373qki.129.2022.10.13.14.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 14:19:10 -0700 (PDT)
Message-ID: <f824335c-893e-33a8-5889-df817ab5362a@linaro.org>
Date:   Thu, 13 Oct 2022 17:16:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/3] ARM: dts: qcom: apq8084: fix compatible for l2-cache
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013190657.48499-1-luca@z3ntu.xyz>
 <20221013190657.48499-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013190657.48499-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 15:06, Luca Weiss wrote:
> The compatible "qcom,arch-cache" for l2-cache does not exist, and all
> other Qualcomm boards use just "cache" for it. Fix it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

