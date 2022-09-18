Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5146D5BBCB5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIRJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIRJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:15:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5D21262
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:15:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r12so29012651ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YAmWSRe5Gq0WUlezroDaVszGCMPa6MPQZqhM455jkZs=;
        b=yWULXnlzzU9J9JFAeAFHcF4ohsKBDJNPio3e5WVpj7TeY7ISuhXGsB1YUVhTFR1kL6
         PA7lrJ+I9T76dxdfG/Qr0jn0xmX5+ELWU4NKDmek9LNGmJI+nEc4g2t3xioT6ZFFA4Xn
         ephNeXdxFl2Ppd5TXOeWykGJeg1WKXBA0l1aMssxavcPQYnBNxfXVts0WqNRVyCtG+M9
         lf3CnmJ6f40dabdeO9YEydoIxvZX7hBgVq6GZaJKdJKq6xKLIqu5FoqhDZ+uK/abu5SP
         1hZVXt1KuZJqH5Sx9IDishvXBFA6U+0HVmqNof7RYbCOmnNLZhJ8acuAySvjyE176M88
         ULvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YAmWSRe5Gq0WUlezroDaVszGCMPa6MPQZqhM455jkZs=;
        b=uZPmoHTjEP+YEmdWrCM8jyLsSc4L1c1hZmqI7RLwCy2k8+aR1Zruexfz7sfv71Th2f
         +qi0A7b9b2zQHzdv+kxNV+QYNhqyHUBEBk6ZR7WKgfaxTkb2Tv0oH979f/36M2T0WBi1
         mbyDssz3JGpiYNjE5/iTiowaGkvoSERCGHkBO3kgCzHAcGdd/XTHQ07cd/YWlRa3jn9s
         bVRu59BnPb8G0FmsCYtw7ZG+RumkR97sjFkLq1EfPc6w3hJONazcIl3ppYKzDVgpxF/C
         jLag+F1D28VveH8/Z85OZbPA7Zc6AgohxMA/OFmGMcQiH7Zo+D5GS3kST/lriCCAv1jP
         58BA==
X-Gm-Message-State: ACrzQf02fu+aRMX0a6OwOMSoKwuMorSgnLEETSpCnjTaw8vsm+hNqTqI
        3RcVHL3Izh4FFoYX4lXEenv+Aw==
X-Google-Smtp-Source: AMsMyM5FhRow4sbIo6dhZeJi0VQSwzplmq2oYHdLZ1viQXHQIF0nIoRivXMABx3g4iq92/PvNdreVA==
X-Received: by 2002:a2e:9ec3:0:b0:261:c893:679c with SMTP id h3-20020a2e9ec3000000b00261c893679cmr3516027ljk.378.1663492517667;
        Sun, 18 Sep 2022 02:15:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v17-20020ac258f1000000b00499b1873d6dsm4486157lfo.269.2022.09.18.02.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:15:17 -0700 (PDT)
Message-ID: <d8950be7-7b8b-6ad0-5825-c090e0c9b04d@linaro.org>
Date:   Sun, 18 Sep 2022 10:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/5] ASoC: dt-bindings: qcom: sort compatible strings
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
 <20220916132427.1845-3-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916132427.1845-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 14:24, Srinivas Kandagatla wrote:
> Sort compatible strings for consistency reasons.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
