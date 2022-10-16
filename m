Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E3600037
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJPPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJPPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:01:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2ED32EC6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:01:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a5so5335175qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amt1GcyyLIW0QnNBSbjIgHAOdLrVTZL2/YCB2Zv2OVY=;
        b=sBa+mSCSUWnjA7IVedfndMBcKZ4W9RwVQvLkP4N9YfrIPTP9ausR8mYLrwupVWDD4X
         8V5H/JYbHPVf7Nkss1T+sjNZCk0F70nQQ+dLgULeS4QKOINTAdAOdfkGZDKyDBHYNcQQ
         2dWbELgSQY06AaAU6w9H+dF0AxI6Qs5qKz4rq7I83ef7wCszesDFVoN6eMVLOeww8aGj
         V/Jgv8Gs1P4RWryBwTnbf61EL+/HibxDv3rWTydlLC4tMonedD8qo4z4zmVMcTtLQu4v
         N1gNFPaUiollhWGazuvRpGZlg0qKKGLkNOArYxE0Y0C/4Ph2qK9qXdSp5mt1jvITuQGz
         UYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amt1GcyyLIW0QnNBSbjIgHAOdLrVTZL2/YCB2Zv2OVY=;
        b=8I81z5NVbn2270xFfAZUtO7cg8bYj2kBoeb+qfp+TS6AL3X21QGSsODvHTlKZLzSaj
         bQobxfSZxMGjlCuo0t9ZzKfnL4jIQbUT833wD2g+vH9fMIm9ATD4skI8wWV3lIucRyZI
         XkgFX2CifwaNg5RptiDphTmIMEVG0KXbq+ZAt9gupWXNeAuTgDdZFXmp4KvaU4Bz0LG5
         /xMrEeRZWjyuY0/Xio7OzCVUYs4ZP7RAa/B4Ug4qcdXpgRJuJTLuTZ+eqyxvAPvbAP9U
         SAHaltvLrV5lzuZMMzBCbh/2Q7aDNlqXEgBdqbVs2R/SX8f8Tr0SFWPzNRm4VQZtd4OO
         zYcA==
X-Gm-Message-State: ACrzQf0/3x14sqcm4iZrgmCAK7P5dibaf50OJJs37leqm85InzoQSt4f
        gbTEwRhp0UNC7hCNrVIH29/PCw==
X-Google-Smtp-Source: AMsMyM5ejcI+y4zLpk7NYGr5bXjw4rMh185TQdIRMdCF/4O9fx2xJO0pFEGm4v8Zra/IazMgQcViKw==
X-Received: by 2002:a05:620a:454e:b0:6ec:61a0:1865 with SMTP id u14-20020a05620a454e00b006ec61a01865mr4950760qkp.414.1665932491853;
        Sun, 16 Oct 2022 08:01:31 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id l16-20020ac848d0000000b0035cf31005e2sm5901846qtr.73.2022.10.16.08.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:01:30 -0700 (PDT)
Message-ID: <6d889f69-3ef2-3188-b5d8-4c2458b93fe7@linaro.org>
Date:   Sun, 16 Oct 2022 11:01:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 compatibles
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016090035.565350-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
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

On 16/10/2022 05:00, Luca Weiss wrote:
> Document the cpufreq-epss compatibles currently used in the tree, plus
> the sc7280 which will be added in a separate commit.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

