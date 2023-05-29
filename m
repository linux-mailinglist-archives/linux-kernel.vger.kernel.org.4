Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B78714A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE2Nrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE2Nre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:47:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E78E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:47:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so3233344f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685368051; x=1687960051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3MBVzyz5ClMF5aICaa7vMyvAT/IC0dyXt43K5OjoLY=;
        b=o9wLXwelBFl7Ru2d+4ZBF0d+UM8kQk0Ty9HT7u7LblB8dftdxLvbS4r1f78W0p1qJ7
         /UEczLNG8d1y5i81fI+sgYsLv99pV5DCwYlbfbXGBGmJzn5zHhprsMIfdEUL/Cr4RDGC
         X5lNL03ILwdwOoCYIuWKRS/bqHAFz6auXNkKVibDy7cL/EHkz69pg1b03loNRIqRbUDB
         UHnRShXQKIU1hzacfVu8nNovRNDBsyJ0dtBpwi8fnx7NXyoY3Erhu/1eOPxjjzPPFrbf
         HEaknxfjHVM297/XjIy2KkHIDtiE/9yVb0NDtlbBeyv6CnSnLeDz8HKrKcVYPlED+JQA
         vOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368051; x=1687960051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3MBVzyz5ClMF5aICaa7vMyvAT/IC0dyXt43K5OjoLY=;
        b=G4WkEu+b/1wLUyXPFpcFLp1Tfga6JJGCFXETp10fO9xIbd9R8QwWWW2SLCDyhBOIrC
         6cTEQvb6nPjt39QjyGtLjIiVNF+PWSdl7U8+Wy9WnIEkdSbnH/T/vkNxk+FPnmL1+Beq
         d4zQSaL6WbK5oh0WM9wvwH9LoxlQE/gMsb7ANCwTVf9AlHsbNRjgGCv+MbTE9koNjciR
         7xqUERRXZ2QKoLsnlQV9Yo28UDC8w1PdjKEjQ8qOXv77UOkiFoxkuipZDPsRQlcjH4PO
         GhH5fjParC7hCYZ33ICnLanv4aiz3ZKesRLunMevmlL9cixvjwQ6xMeQgTVyHLZfgKnD
         IceA==
X-Gm-Message-State: AC+VfDxKXYmL3UT3mA9IGtNm7cJZuuCSLP/djwAJw1A4zTerx25jRt+k
        /DohZc9iEKZP/1KGlr5kum9MMw==
X-Google-Smtp-Source: ACHHUZ4MQhFDLFSmWH1yAj11VSEFMQ9+yPfqvIqWCrlvYQ9qZnx5Rb3A4fcJ85QQe4rzGCAtit5hdg==
X-Received: by 2002:a5d:44c8:0:b0:306:41d3:fcb9 with SMTP id z8-20020a5d44c8000000b0030641d3fcb9mr10067938wrr.27.1685368051591;
        Mon, 29 May 2023 06:47:31 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003f5ffba9ae1sm14403618wml.24.2023.05.29.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:47:31 -0700 (PDT)
Message-ID: <e1f5e719-5b38-a258-2778-5dfe9a7dcf5e@linaro.org>
Date:   Mon, 29 May 2023 14:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: pm8916: Rename &wcd_codec ->
 &pm8916_codec
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-5-bec0f5fb46fb@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525-msm8916-labels-v1-5-bec0f5fb46fb@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 13:47, Stephan Gerhold wrote:
> All definitions in pm8916.dtsi use the &pm8916_ label suffix, only the

That's a prefix_ not a _suffix

> codec uses the &wcd_codec label. &wcd_codec is confusing because the
> codec on MSM8916 is split into a "wcd-digital" and "wcd-analog" part
> and both could be described with &wcd_codec.
> 
> Let's just name it &pm8916_codec so it's consistent with all other PMIC
> device nodes.

I'm not sure that's really consistent throught the dts/yaml TBH but, I 
do think the pm8196 name is more meaningful and clear.

What is wcd supposed to stand for anyway ? Its probably obvious but I 
prefer pm8916_code since that *is* obvious.

> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Seems like a valid change but, consider amending your commit log.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

