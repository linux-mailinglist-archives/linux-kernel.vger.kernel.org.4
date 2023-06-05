Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C807372308D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjFET4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjFET4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:56:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBD4103
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:56:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6683478e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994962; x=1688586962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idaUBqVeErLky4F1j+heLBMP/TcoaCa3uvkOaqMKVks=;
        b=jB2mTZhpHSkaKfna/9C4EkxRefLNVSzOE97EH/giJXs1JDAR+sl5Uvol5xS3AtIc7K
         oP0eoqMJdaFo2MOPPT/gzn7E7jWUw1/C3yDQ9DwbIrOrZnWe07z2SrVIqLc/Xo33v8Gr
         w/iL4jPlgtm3zErEcqnJ4LmrtQz45wfH+ba1n9MEC0KNGkh+xh6dbbQs40ibsfBNN8YL
         KKvrvR50bDv7H2EBVnE8TIpGQo/3f3H6ug8HgKVgv8Ym4Pw9TM1X9rQ2S6Yyw1cam97F
         OjrZvgsaGL/m5yR/+Bc8MZSbX45FbV5aPlo3f5SUttqe6o7rzbVFS0abvyit27+sT/I9
         3OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994962; x=1688586962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idaUBqVeErLky4F1j+heLBMP/TcoaCa3uvkOaqMKVks=;
        b=fFtM2isqYnplv7bQ4v9gTb1ukgQPbjjDq3biA0fda680GbKwSAJjebEN7K7nPskTWb
         0secx6ThgAo4CjDxIp1sSnFPT3yqr7uQD3uI10ifYKJwfwT0fnmCGZagWaEOaZ9LzbbK
         bqlwvosxk67Gx9CZJ8es+/P1JiDLfs8urZcmmr0Yw3aMP1wpKhs1SUGhqrMHs6friF3J
         CgWUkeH7dYSNu3pg9Y5XhQ22/xmLL5pi5/cgJSaAsU8Q5/fl87Src6MwXi0RN7m69QJ6
         oU4VYQfzOBhVJyWE/3hHUmhO9QnSL508ayNd8OWVZL0GPRvrXl9GAaSe55TMv/qtH+2l
         knHA==
X-Gm-Message-State: AC+VfDzSQXtSBsoR8Q0NjCPNoZ96FnY0g37Hlx+ceyyBu4RyJ9ine41S
        F/O6RCAw9HmQhG9XjmUnmtAVKw==
X-Google-Smtp-Source: ACHHUZ6BoyY3MVTqSMuSx/F/qQNLLVXqNBfbuqwyzyxkwChn+u65546zFt0qtqmbpGYPkK/Vr2m4gg==
X-Received: by 2002:a2e:9215:0:b0:2b1:a810:e442 with SMTP id k21-20020a2e9215000000b002b1a810e442mr118835ljg.49.1685994962241;
        Mon, 05 Jun 2023 12:56:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e8e87000000b002a9ee18e9c7sm1517279ljk.69.2023.06.05.12.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:56:01 -0700 (PDT)
Message-ID: <ce80b713-3c42-9cd3-73b1-9dcfb194140a@linaro.org>
Date:   Mon, 5 Jun 2023 21:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
 <04745990-d270-b37c-7ac8-dff24b03e02b@linaro.org>
 <ZH480vq8iNgkoK78@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZH480vq8iNgkoK78@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 21:51, Stephan Gerhold wrote:
> On Mon, Jun 05, 2023 at 09:06:54PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 5.06.2023 09:08, Stephan Gerhold wrote:
>>> Add a simple driver for the qcom,rpm-proc compatible that registers the
>>> "smd-edge" and populates other children defined in the device tree.
>>>
>>> Note that the DT schema belongs to the remoteproc subsystem while this
>>> driver is added inside soc/qcom. I argue that the RPM *is* a remoteproc,
>>> but as an implementation detail in Linux it can currently not benefit
>>> from anything provided by the remoteproc subsystem. The RPM firmware is
>>> usually already loaded and started by earlier components in the boot
>>> chain and is not meant to be ever restarted.
>>>
>>> To avoid breaking existing kernel configurations the driver is always
>>> built when smd-rpm.c is also built. They belong closely together anyway.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
[...]

> SMEM is arch_initcall() so at least for the SMD case it can never
> succeed probing in core_initcall() and would likely just cause
> unnecessary probe deferrals. That's why I chose arch_initcall().
> 
> Are you sure anything will really benefit from core_initcall() here?
> 
> I'd just like to avoid making things worse by using a random way too
> early initcall level. We have some really weird examples in the tree
> currently, e.g.:
>   - rpmpd: core_initcall()
>   - smd-rpm: arch_initcall()
>   - glink-rpm: subsys_initcall()
> But they actually need to be loaded in opposite order...
Yes, we should make some sort of dep graph and clean it up..

Konrad
> 
> Thanks,
> Stephan
