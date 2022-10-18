Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109B4602FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJRPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiJRPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:32:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C5D4A12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:32:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t25so8866599qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1/uDkzke1I9MIXgJReSc/5yrjYBWTdhHs4pK5HuUcU=;
        b=eU7bFamSLI28JsgdEar8LiWEMX6cc97/5zuKhkJeJI96D4MPCqmHgaUXqVhvD47bW1
         A+wxdY1mbuEqCwwaHmNlZz5jqMtpS6XfsJg4eyRrmKtvtutpHVZfeeeU82AKjIcRHwbR
         zBspuDGnsCBnr06GRU9iP4HbzQk7me66qHm4DBgl1ZjhJjdT0+8FZB/doPw7kNA1O4fF
         R13sZi9dqR3SHx8H9/9woXnOdBZHbS4bro7KjScFRupf4n35o2J1ij8CPtYJ5sVYAjRw
         GWqwqj5FxwAQXMka1zN5L0WlOFNgCTFxjwQK1Hql7oFnh1JI1sg6F/9Sag0qsJsaJwhO
         TGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1/uDkzke1I9MIXgJReSc/5yrjYBWTdhHs4pK5HuUcU=;
        b=kCcZt+FJIZeNBhG4RIz/hpOLMeO/mfMjwh8y6uLfEswlaKzRQ3eHVa6y25E5jdj1Rs
         b18zvxulUhwLAAoQh9TJsqGzGx7PtRFThAd8fDrslOg+zo0duMCoEOq3NNgzt89aAK3V
         c/skZcwPu1nbD/S0JesMdVmewur3DDfIVpWj7mMRN1axcj9NCbKf6KdA+u7yuG2ajAoI
         dEMZV4oj0dRshmGGIVxDxh8xeg2DTEr3ImR2Kqu6e/B3RaWHdYfNC7JL7pcSmAqdR+dK
         A1nkSgjRKgbw1WyDBnxFR6tkNAvJQYx64by2FHkN/FdxXix/i3Kb/ZEPZOM1VI1/Ka0e
         EIyw==
X-Gm-Message-State: ACrzQf3ntQE+gp9/5OQJzswkkFhO5kGFFaE00jp2dz+TKKK73fZzRPX3
        4RZuKUrS4Cz0RIFTYsV9y1GQbw==
X-Google-Smtp-Source: AMsMyM7eVweGu17+jtxN0kMIKkC2qER56wGixOvLXX1kSLjhAlxUlN+fkkmcKGJrQWP5eMoSC3HGQQ==
X-Received: by 2002:a05:620a:46a7:b0:6ee:dea7:cc1c with SMTP id bq39-20020a05620a46a700b006eedea7cc1cmr2303292qkb.506.1666107129262;
        Tue, 18 Oct 2022 08:32:09 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm2043401qtj.97.2022.10.18.08.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:32:08 -0700 (PDT)
Message-ID: <b0c1bdfb-4a31-9deb-1f0a-0ed813707464@linaro.org>
Date:   Tue, 18 Oct 2022 11:32:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
 <CAA8EJpqSWmy5Z4cmJnsdjMjkmACW7HSi-k5JxZ0gLCeUAWEnxQ@mail.gmail.com>
 <Y05+E90tmlq2tNFa@hovoldconsulting.com>
 <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJprwhEvUfUr-zDir4zFh_NAyr0qPbrHi6Hf8=2HC1dAhaw@mail.gmail.com>
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

On 18/10/2022 07:37, Dmitry Baryshkov wrote:
> 
>>> And yes, I think we should also upgrade
>>> older DTs, keeping drivers backwards compatible (for some time?).
>>
>> Possibly, but I'm not sure it's worth the dts churn. As I mentioned
>> elsewhere, supporting both the old and new binding in the driver is
>> mostly trivial, while encoding the deprecated bindings in DT schema
>> sounds like it would be painful.
> 
> This is probably the time where Krzysztof can advise us. I'm still not
> sure when it is expected to encode both old and new bindings in the
> schema and when we can update both the schema and the DT.

I do not follow what exactly the proposal is. Are you asking whether to:
1. keep existing DTS compatible with old driver?
or
2. update existing DTS so it is working only with new driver (and not
compatible with old driver thus having ABI break)?

If so, it is less question to bindings but more to the usage of DTS in
other projects (like bootloaders, firmware, BSD) and generic
recommendation is: do not break other users, if possible. It is however
up to the platform maintainer (Bjorn) to decide on this, not on me.

Best regards,
Krzysztof

