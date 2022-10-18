Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD294602014
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJRBCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJRBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:02:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F679EF8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:02:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a18so7834865qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orFSqE2BEwIkJmytrqiupr4Ypb+zklxtz9GR5dOGZmQ=;
        b=aTnXXdxYPx1sRm6BnUdhvTTcYSj2rnidRY1jY422VxRv+ju+i5PvJhvC7aU4LuS97S
         GhnlLAPkozGf77rnwSXRmEl/yWM9ZRqpZ+vAxWEjR5dAtH1uyqSMSc11hwcpJrN2Y6u5
         bwOxesqYiQYSiMId2oo8GoKKu55lUoAKWMRLLxM4mnTXYCYhOOwSkn/U8mVei5iJW32s
         DHUj+zkWoW6mOWi/Fq6BtAnYmOkgwxxw2gCYgr/YlbE7+l7HAqHcx75ED0/lc3k4DGiU
         3GQaEeCtFeHrnnea6HqOiwZae4AN55tkKyxYudvnLHnepQ9Yu/nPPx4xAJEDd4OrOEZq
         haYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orFSqE2BEwIkJmytrqiupr4Ypb+zklxtz9GR5dOGZmQ=;
        b=hpZqHSgnB1tKPc0YDvpUHch41fAx4PEFatqJfsck4+1yOYZLRyFYF5qiFxA1hn52pB
         RKgoFDcSXSV5mukUwrGKGaksB8OfzZ35b4MhNS/eHl6MxiN68twpRSccVedTZtgb2LmE
         vDBtvYqdcRmcPxjOE8WaV62Z14KB3gb4qXmJIIY8oGx09VpgRuevFHRdDl0hYO7jzMmL
         +Av+4Kh4V0Y0iVkjpsR37FmqOYgXiTrmjRzpDV3HejkgY/yhJ61ivpYM5yjThcfY2NdY
         9yKKu7HvYj+lo9KMbstclzfi52kuZ+O0ixbYZoGDGtBwo+x+/QmMUybwPblQuKOhs6yq
         kmHg==
X-Gm-Message-State: ACrzQf33BB+DVSDzHBKrMDdqfyWX86S8jfBIyBmZPD9xXqIbkvpfrXfk
        3Aawz3ccP3o1+cRLrpN99putpA==
X-Google-Smtp-Source: AMsMyM6eRS8wZHL6RHm2zlZvUxxzBYUanEWE+zoFfrmAR2ebdTHaD+w8Xc9EJYj4McYsAAJUD9ENcQ==
X-Received: by 2002:a05:620a:244e:b0:6ee:d8f2:6d56 with SMTP id h14-20020a05620a244e00b006eed8f26d56mr267023qkn.380.1666054952664;
        Mon, 17 Oct 2022 18:02:32 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a0bc600b006e6a7c2a269sm1224306qki.22.2022.10.17.18.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:02:31 -0700 (PDT)
Message-ID: <c2aacd7c-1773-2ca7-415e-0b3ec7b5ef02@linaro.org>
Date:   Mon, 17 Oct 2022 21:02:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] clk: qcom: Add SC8280XP display clock controller
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
 <20220926203800.16771-3-quic_bjorande@quicinc.com>
 <a8bf3887-b4fb-1f60-14e4-998f71b84181@kali.org>
 <bc96324f-c560-3baf-a771-beef6955a537@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bc96324f-c560-3baf-a771-beef6955a537@kali.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 20:51, Steev Klimaszewski wrote:
> Round 2 because the patch is too long for the mailing lists, I hope it 
> is okay to strip out a bit of the patch

Yes, it is okay, actually expected and much better way. There is no need
to scroll a lot of message looking for a tag.

Thank you!

Best regards,
Krzysztof

