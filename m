Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C568617E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBAIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBAIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:20:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B645DC34
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:20:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so723642wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHijNrxsmFVl6xQqOdyyzxy38kClml8wWDt4vdhWN7A=;
        b=NEAEqVC5hjNMnavSu565K5QcGCm9fJ77EKxxbHh9he6vt3OEbu2I/Jxu4X46CAR6DB
         9XMjjsVY1ML2hgAS94vWVfk6p8pAj8DBW66jSqEmuOpAdl5jPb6/jk1+N7LQx1gRGXfz
         8mZQb8BV3+oeG2x8ns9wqDf8Fw9z+lCc8XG2dC2CZ9lSNr6GKfPflpEW9I0g1hdEmqDu
         SAED1K2SO9BpYTh/LpVAT5sUOqzXg62zIu2aKtpp98/k7JuyBfZUQyjhvrwRg2DltC0N
         ly+VAdSEgeCL9Y7MdG7GkWmYz/6iRqWc6YY0B7dtCdfjrdq0D5sZblI53TLuHmYv5g7K
         /x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHijNrxsmFVl6xQqOdyyzxy38kClml8wWDt4vdhWN7A=;
        b=bvPZoHdigLEKEWuvc/QF7mFdKCNpItvH8WeyS+KzhZV7x8SUcb6uPY38pGPySzqOnk
         UhQkHDA7yOVL8qWUKX6N3RCHFKKZnS1CZTsan+2MmV8noaFnmXYa+46mkaPLRAD68axS
         kkcKHx/9G1Qzh/Xv3xNRSewWtBKh1K8rsw4zlL9Cl8Fg6zAYGN47yG5hYwXZELTgVipD
         axXFPQgmoLADQVq0X8kxGqkWb3qbiJaAXcq0iMThvQS20RmbvGCkwRtkODNbtDm3RpKn
         D8L1Q8rfAYwDI6LEpY9ANWsilhSZnRR2WZ4xJW68G7OUMyKsMywgswNNmlK1aTXc7wpS
         RutQ==
X-Gm-Message-State: AO0yUKXBJfbw+Gp2E/1/HcOKOIyR/3OL/e3rCOC/+hg9nANDuo5MHj3W
        Ql+PV7Rr+gidjluPfB594pik7w==
X-Google-Smtp-Source: AK7set9knuYzmtAKlJdlX6kTGKrf7DB+woOldSZFKeX1Wp8sVsfxsWquaaxGjdz62RdmxuuUCkXVHQ==
X-Received: by 2002:a1c:f307:0:b0:3dc:50be:9206 with SMTP id q7-20020a1cf307000000b003dc50be9206mr1217756wmq.4.1675239642145;
        Wed, 01 Feb 2023 00:20:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c05d100b003dc521f336esm964883wmd.14.2023.02.01.00.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 00:20:41 -0800 (PST)
Message-ID: <1670489b-e4f0-7328-3dbb-d849d1d6bd7e@linaro.org>
Date:   Wed, 1 Feb 2023 09:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131151819.16612-1-ansuelsmth@gmail.com>
 <20230131151819.16612-2-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131151819.16612-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 16:18, Christian Marangi wrote:
> The qcom-cpufreq-nvmem driver supports 2 kind of devices:
> - pre-cpr that doesn't have power-domains and base everything on nvmem
>   cells and multiple named microvolt bindings.
>   Doesn't need required-opp binding in the opp nodes as they are only
>   used for genpd based devices.
> - cpr-based that require power-domain in the cpu nodes and use various
>   source to decide the correct voltage and freq
>   Require required-opp binding since they need to be linked to the
>   related opp-level.
> 
> When the schema was introduced, it was wrongly set to always require these
> binding but this is not the case for pre-cpr devices.
> 
> Make the power-domain and the required-opp optional and set them required
> only for qcs404 based devices.
> 
> Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")

Fixes go as first patches in the series.



Best regards,
Krzysztof

