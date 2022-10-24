Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE360B406
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJXRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiJXRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:24:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE3EA98D4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:00:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so6325769qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D2qC8JkQWqg5OtsTeOnj08o8r3sOjBd1D5QMgS0xg8=;
        b=yYWOASGG8+yX8Jd0BSwaMrWaTQaF1idwVNY9mplB3kPADoF+qgXoP3xMZt2A9V4TMD
         U8KddUVeATgg0qHYSkx0ptmnMJq7I2xDfmVm0+IBUlBoGOikVUg9Jpwk5eMz6esfv7jd
         83x4lC2Sofq69o2tabvK/ys18bnZTnxdJABSz6ze4rVJYCwyxsa8HjsNkCqKRG0uNWvH
         N5ZJIeh9g+g1wjKWyOrYXlqKbl6NMW5lGWnwyj4Qpy1FoakM8J3AxonU/CD4QtVkm2/b
         Sfzabawmy1yKvL7B1nOt26XSLMopqoxqsGUmf+DS1zqXfy0gy4qzL4TDgyMmUgOehaeE
         ykeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5D2qC8JkQWqg5OtsTeOnj08o8r3sOjBd1D5QMgS0xg8=;
        b=iInMmzk78bHNXU7WIJGVe6N1cJjr2IVpsGS5FluYUtHkM5BB6X52t3g5CtJ+9AcqJp
         Aq8pP1dTIpZaWdRO3VoUIDVfRKNtpIVJk28bUoY5XTEywdM7hhvj2n9RWlR/2wMCvWsD
         qCJWcT0JpRd/KEU3hDa4u7igAU+HNc011dU7XlEO3sy3ekQCfPArFqFlwblyTF6f/SDj
         syOFMX+sjGbKuSqq/HXTClkfBA+ay7+aFv92CRKUEJG89SCeJwx0MNqLaOxjARkxJUGS
         53q7OJwlsqS62PhUTM09j2tbr/RNcis5pKeLcM/vzawpc+GBWqIXvPAp7wFD9RJPfloT
         VeWA==
X-Gm-Message-State: ACrzQf1EYGqaqDUU8WM3a4Mc1/lftX/U2yiKssteos4GUQOo2BBC3flF
        Gm1YMLchYvRx5cS1VbJKmPUXKfCVRyJgZw==
X-Google-Smtp-Source: AMsMyM7WUD0Ah3DfBvBkzwZxZHjuXsIf/fAn07VWLqQ/iLKoKdePrhROBZ1MPk4ROCGiJJD/VF+9mQ==
X-Received: by 2002:ac8:5894:0:b0:39d:13b5:1afd with SMTP id t20-20020ac85894000000b0039d13b51afdmr16699085qta.127.1666614142269;
        Mon, 24 Oct 2022 05:22:22 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a44c500b006b5e296452csm15355428qkp.54.2022.10.24.05.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:22:21 -0700 (PDT)
Message-ID: <10e29fa9-e1b5-9d3d-1dd4-8914c4444099@linaro.org>
Date:   Mon, 24 Oct 2022 08:22:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 1/3] dt-bindings: ingenic: Add support for the JZ4755
 CGU
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221024044057.4151633-1-lis8215@gmail.com>
 <20221024044057.4151633-2-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024044057.4151633-2-lis8215@gmail.com>
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

On 24/10/2022 00:40, Siarhei Volkau wrote:
> Add documentation for the clock generation unit (CGU)
> of the JZ4755 SoC.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

