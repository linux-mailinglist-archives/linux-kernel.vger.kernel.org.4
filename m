Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE2631374
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKTKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKTKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:49:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B46881B1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:49:43 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so14995170lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgtWuwFkcJkaOuLoiHMgggWg5foXzqB/fPX1Kx96rUo=;
        b=hhTAnf03uJD39oE2uGJrZ1Tkjq8JwF4u4wSUYc2cEK0/n5n9+vqETXHGdqMGAsXGA5
         XlPbsaFeUKLkCmJBLNTp+UqpYZcrQfTmhELqbu5CGrJDNooUIAaLGRezEsk+LK9XPudc
         UvELYdP2X/OkG8+3ojxuFaiK61W8ugbFSZkZbiYeOWIVw5T0PEliP4BrQqcFyesRq79Y
         zlKDDtHGqOXnhIuKs5IZiIdeW/LakMcDdpaf1XM/7MI+hfmnD2ymGT829fEC7/GX3XMk
         aAJOmcAXuE/NqGHvXLXXTDWEZ93jc8YTx9PTxi7Xcu/G9jAl7jI9f2IX3OyzYKy/EWKF
         ZCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgtWuwFkcJkaOuLoiHMgggWg5foXzqB/fPX1Kx96rUo=;
        b=YIeD82aJINQM48xUdNaGPuPnsk7QG5JTnJdVwkOQ3Hqgw71Oz/AQnTL9j0XSgrZD2q
         lkfMXVn99VBstIv1bKl1O45syvrYAlyOm4ro75Lud9KSf6KyMnZetLzSyatoNzSo9UVA
         KW4FIF5GKDOtvgEdGcPKK1YqL/P+YDCTNtdK/fPmD2cUC3bF6sHh4qILJLt56eE4I5nh
         ShNCUqNowGwF35uNvwU6tSCSaiWDthsWpAmF5o46BNmLk17/XPXLETAcNK2OI66T91P0
         j2wknPisa2vk8N+iB7EK8nWViQAApskL4lKSUHIzYVHWO1J6g9tbgVgqALw4c1WAWJsq
         jsOA==
X-Gm-Message-State: ANoB5pkAw7q3TEr/2/1djaivYcV2/evHeshERTQxd2/vsXUFKD77SIno
        Y6T3ccF+DsA6o6fyIYKP3heoAA==
X-Google-Smtp-Source: AA0mqf73+q/ej7CeqjZQVXnMiCHokyx6RvRHrVi8nwrk2dlLpYjmEAKOp0e04QBwYLJ9215PU1RSkA==
X-Received: by 2002:ac2:4822:0:b0:4a7:648d:a7a6 with SMTP id 2-20020ac24822000000b004a7648da7a6mr4406936lft.588.1668941382121;
        Sun, 20 Nov 2022 02:49:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00499d70c0310sm1495655lfo.3.2022.11.20.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:49:41 -0800 (PST)
Message-ID: <6a7c834b-6a4f-186f-25ff-e6e9a99a2711@linaro.org>
Date:   Sun, 20 Nov 2022 11:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] dt-bindings: qcom: Document bindings for new
 msm8916-acer-a1-724 device
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221119204209.94125-1-linmengbo0689@protonmail.com>
 <20221119204405.94233-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221119204405.94233-1-linmengbo0689@protonmail.com>
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

On 19/11/2022 21:46, Lin, Meng-Bo wrote:
> Document the new acer,a1-724 device tree bindings used in its device tree.

Subject: drop second, redundant "bindings".

With above:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

