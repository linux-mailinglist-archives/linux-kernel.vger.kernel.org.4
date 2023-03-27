Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7CD6C9C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjC0Hgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjC0Hgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:36:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9554EDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so7581823wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902581;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YEIQ17cReUpj3NLdD60sp+mWH9LUrjuCCZwl6mkty+4=;
        b=ejG9zLMXk6/eBK4wOchabkPaYZFwSBGMD6FwSgyyaLlkUIDDZNV51XXgPX4rF2iUVC
         RJDLJgHzgsa+d4gF9Bn9bhqBWZL+NmcZ0PYw/3URdGHNkmdSPa8HuNhAyfEIXi5qwqpV
         XafX8UVtABErLiSKKAHVXYgGARqUJlUvubSCb1F0g2TybPVMWtnhj7rBoz5Cus6Ooo4a
         I92pYMWPnAxMnvd3GDKGwv/kElbFrs3HacTjXlnsrFmaP68e0+R806FNplTZp2LE4nXO
         N2mgoT0pK0cqm8QadXLVFcgcsctOy+Pa8/5Qm2BYGImJUH5eFlFInjiTofHj0brO8xlR
         nNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902581;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEIQ17cReUpj3NLdD60sp+mWH9LUrjuCCZwl6mkty+4=;
        b=1fB/YxOs6Fb3Rirb4CjFlqIh25ui1kZBSab5xRJmQ/kkkt8V1+t82k4utOI+grFHAG
         HXzl4o/Y2U45lOL+R+KZ0smUE/e84y8kQ0p3vU+tPvzcBkN0JQw5Apy5ztmPSHdqzL/V
         meaHo3GeFLQLeFBLaR/SWLqVf+PIN9JcPWpLuwytLxrU9+q4UZPf5GF0Mzu0jhKIzw7F
         o2PDB7dtH6+bbCDhdT5u7BOTVvmPcBTKnikWe36x+zh7HXNpqfoMkzej1chShHWKL1o1
         Zpkgfj8pN20HwUdzbelTdMLOx09iS7TcNj8hH7KCiTlv43gziaG4jYsYUmCgy0eqhvd8
         ByNQ==
X-Gm-Message-State: AAQBX9fkuSWHh5Nxbg0C/f7jZ+8lSxnyyn13pxzx7X+Li8jvcelqs1Vv
        UH3VHJXTHfFH5OPjywaaNZLD7A==
X-Google-Smtp-Source: AKy350bl/w0uNx6XXsDNl7Qwy6QFuHNfbmfO1G/roslYiDFypUOyNTdLEF/7yzLyhJpAc9X3uAd6Pg==
X-Received: by 2002:adf:fd47:0:b0:2dc:cad4:87b9 with SMTP id h7-20020adffd47000000b002dccad487b9mr9462425wrs.68.1679902581210;
        Mon, 27 Mar 2023 00:36:21 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id h6-20020adfe986000000b002d09cba6beasm24530620wrm.72.2023.03.27.00.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:36:20 -0700 (PDT)
Message-ID: <4fe8f6b9-86af-c57d-1c0d-7bd831b8732f@linaro.org>
Date:   Mon, 27 Mar 2023 09:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] dt-bindings: display: novatek,nt36672a: correct VDDIO
 supply
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
 <20230326155425.91181-2-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326155425.91181-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 17:54, Krzysztof Kozlowski wrote:
> The nt36672a bindings were added with a mistake on VDDIO supply calling
> it in one place vddio and in other vddi0.  Typical name is rather vddio
> which is also now used by DTS (sdm845-xiaomi-beryllium-common.dtsi) and
> Linux driver.
> 
> Fixes: c2abcf30efb8 ("dt-bindings: display: novatek,nt36672a: Fix unevaluated properties warning")
> Fixes: 9528a02430df ("dt-bindings: display: panel: Add bindings for Novatek nt36672a")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/display/panel/novatek,nt36672a.yaml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
