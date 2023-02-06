Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A236868C684
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBFTNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBFTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:13:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203320D33
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:13:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso11547539wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TTlok+DKoN6O3XZ3ZYCY2Q6A1YUCFwItnfjnPnLbF4=;
        b=yy7PWPFv5Tvm3H5w1E3b3zkysD1tPRSBhTCWpcA8S4HvTxKLmgaRWjLKcCENv+I3xz
         aMSNQLk0FXCBaDkAx4Av5pJOnx0gz4trqrppVpPitRTro3gGWSYTZo9Jr0nk88FjAwoY
         gWDgmq6e+Tqe8KChXgXnSngzlFSNrD7xgoUPxr17rqf0DZD9iazVAXxDMDzxksiRplk9
         OmMPgpDv5Tixu7Ha7eYCJTSJySWSXVsa6mZMwY9We3IgxenX8VGKnpwSE22vMeDW3MAR
         1apdIyrHfUKzsyTlRhJH9+K67/ChkoEdYxA/wdpMlFbtoJQI/eu0Ae2ECk7QsCElTPOH
         UnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TTlok+DKoN6O3XZ3ZYCY2Q6A1YUCFwItnfjnPnLbF4=;
        b=23Qdq7n4uFz8rDuMZgulyXMWXVNTUa5/opflXgLhjfln5ZmYwD2eUQ80C92Oei5kzj
         kFy0moNbdZGIYQ81JjQT2kC5ml0BcRjHiWst7RNnGf0D+x/lHpiQ+NnuRcvfl/DX4Sz9
         oAQnQ0IG2vTaX5W6mlVO8akBRVFXoKajj4sHy8dikMc8Zm2V0KOXFsf+mtrPGbgZx8vq
         yMpD+hSno+nSGqKcVl18soCFUkuRa/Q6J7FeJ8xePy1+/iuNlK/weGvEwe+33H3QWfu4
         /gl6fBS3Adoc0nqZY9E54vxBDqUryjXSVm8wKpsQXTNbtidu4fLI16ODL0n/T7yWUEEX
         iztw==
X-Gm-Message-State: AO0yUKXdTdgh/lhgeBI9YBnPMJP36SKKsSvUur5hw9GmCFLp+kOpqs3x
        4WHgZQLT+lr4XQidg+nsbTe6imUOY+RgPGzO
X-Google-Smtp-Source: AK7set/KRsDcK/zxUA5o+jJRPiuSJzcbAHawtsC9iDyjpBSn2QTjdcP+RmSVBEYfYRqjBTipYJQWyw==
X-Received: by 2002:a05:600c:927:b0:3db:2098:17c0 with SMTP id m39-20020a05600c092700b003db209817c0mr965208wmp.29.1675710819068;
        Mon, 06 Feb 2023 11:13:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003dffe312925sm4980723wmc.15.2023.02.06.11.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:13:38 -0800 (PST)
Message-ID: <54cb8869-3d71-367a-0790-323ee0906614@linaro.org>
Date:   Mon, 6 Feb 2023 20:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: meson: convert axg pdm to
 schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-4-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg PDM device to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

