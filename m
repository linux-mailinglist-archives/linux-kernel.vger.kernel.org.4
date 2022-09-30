Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0B5F12DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiI3TkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiI3Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:39:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FB14B4B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:39:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z4so8374841lft.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kexj9jmleBsDfwwkBkPxMkuYeCJgJWx87FEOimL3smo=;
        b=Uca6wRSaQ314c1mD7HkDNYsz4BMz6hhG7In9DSHxzGoav9Tb6deaTYOo0isa9dQuBB
         ikrmmvvE6RiFZaRM87b7j+3PDgJJPUJfFhMqjMNmj4kTRY8N44mpeXNyJkIVqzooiO0s
         5vRvfu1dJ4zREQm3TAhiDpRIas2s24Kyr8bCpKmzeoUXG3QGwINcPEZybJiRHJPMo5gD
         3X5IjW2EG3PcE3pNwR9D/hS32aWLlcTRmL98HXZLdKTiBTuRSp5EDgWJYcc8071HGzaZ
         ojrWmsRZSwkgvldQiNuL70nenXhcFeTrSeTZdthH314Dw8cHDqyPyc170RkmO62TvaPq
         6dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kexj9jmleBsDfwwkBkPxMkuYeCJgJWx87FEOimL3smo=;
        b=MYmul+ZWCKxPRHvsaTUV9OjIb3SFkToLa27BNX4Fmwqxpc2QrbPTzyghTpWlWg+6wH
         yt9ClkhSisGAE6bfrOt6nFPGDY7ef+s3ZbGO+D1W39j3AqHw2KUaRybr6dwrA5Gy1/30
         LBrGD3jruX/LeVx61IQRONR9FQ15t7kHaNzZO1XSmxoP/ajboqnqmVhRDGJKcUKLMfFG
         iYlV1sOwSbSxNiudmtkIYrhSNjuQBwxFesmEtIJwBEI1z90a73Xkuxc1jgOoGHUSt7VR
         zTMjsjMmrGJny7QSyoXo9lj9ryslPdftmwYKRqW6Uqx3jW3AF84+v+GRza75Y8Hbus5B
         t6zA==
X-Gm-Message-State: ACrzQf15Zc1U3BcYuGVlM8Rc4o6NsOom/rrbXzQpPJdPH6NP2Uwdl2pS
        2h8DlpMNZCZ2TwaGjxT4hLDQO6rAKaVEug==
X-Google-Smtp-Source: AMsMyM6iPftXl0sBmyr3SGVuGUUJ2CmeWU/2q985iI5wBYIe+9XgA9De0+untg6lJyt12XABEPRsMw==
X-Received: by 2002:ac2:5317:0:b0:4a1:abe3:93c3 with SMTP id c23-20020ac25317000000b004a1abe393c3mr3641763lfh.527.1664566794909;
        Fri, 30 Sep 2022 12:39:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512308d00b00499b57032c1sm396418lfd.144.2022.09.30.12.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 12:39:54 -0700 (PDT)
Message-ID: <f525a6e7-c2ca-f8bb-95ba-7297d8d6f55e@linaro.org>
Date:   Fri, 30 Sep 2022 22:39:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] clk: qcom: kpss-xcc: convert to parent data API
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914144743.17369-1-ansuelsmth@gmail.com>
 <20220914144743.17369-2-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220914144743.17369-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 17:47, Christian Marangi wrote:
> Convert the driver to parent data API. From the Documentation pll8_vote
> and pxo should be declared in the DTS so fw_name can be used instead of
> parent_names. .name is changed to the legacy pxo_board following how
> it's declared in other drivers.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> v2:
> - Change .name from pxo to pxo_board following other driver
> 
>   drivers/clk/qcom/kpss-xcc.c | 26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)

-- 
With best wishes
Dmitry

