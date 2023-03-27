Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7CF6C9C52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjC0Hhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjC0Hhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:37:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F255BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so7590047wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902609;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NbYmGbS5uaBCRcMwyPZQrI6VMogdLbv4M+SG8lk+chs=;
        b=wg0cLRtGHOzjEqnn6wJzNGYyPEk33R5HZsMfaePIN5X0eiVdVpdFvDQ8JEL2He8pJO
         n5ya6PKRhQN/Ewi/PR+1J7nkFYcTEhevMdjfkiDfvTLYtsN8RvWs6wgWBwfnRQDldA9S
         pfkVZLtYllCfaCnihAzkkyxrxDsWoIhakvQqiyZ9a0aAiZVAMBaDqFrUFIimaAj90pVm
         u/IyC7go5tYf8uMRJNDk27tNmUxwUQ36z0Es2Q/Mmnbdg+k54WwCLu/dab7nxFakyXra
         xmDeDegoEXX5sSPBj+nghbQropkNAvw0woUyMGdTNbqTO1Rg1bKA4CdwXQDC7JUOO01J
         gmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902609;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbYmGbS5uaBCRcMwyPZQrI6VMogdLbv4M+SG8lk+chs=;
        b=Xp4F4oQeInXOwdNaYB7I2dMYhw1hRkGSF07E5r8MloO91gr3zyf4V6JLsQgfcpbLuR
         rcxcL72bHqadNJPXTOuKn6snHjgf+Bph8cf0DwrC7R6Mxfiul04DfC1BaKEIFsHri9bZ
         aUDZ0VKuR+0ZsB3rHKYCyJSKfQChg1DNRwu4qq93WrEv7qyIYDcRaj+DSJn8XvnMQY9u
         NbTZ7voZW0yCgcoe8aJcx10G/jCLlXe6bh0VQVdwCLy/gq7hCgTS0j4EPdzj5KeYiWyH
         DHhyVsuEGx34+4v15YQl3ZDtfVWNfA4/5pxLFt21TiqhTYXwBAOyuCJONeIFPHHTOop1
         zHTg==
X-Gm-Message-State: AAQBX9cEZCURodBBHHysWFVTes+Qjl278b/ldnIzC/9iUOSsD5SUBLDe
        jooABXajzxXYUmoVRYn8bljNCw==
X-Google-Smtp-Source: AKy350ZR+iZ8CU4+6lZ0dAb/tRTaCxmQCiUUBubE3HwF5ZsO/o1ChMh3bOjSEzu1DgEdtZg9H+j9yQ==
X-Received: by 2002:a5d:428c:0:b0:2d3:3cda:b3c6 with SMTP id k12-20020a5d428c000000b002d33cdab3c6mr8427206wrq.40.1679902609335;
        Mon, 27 Mar 2023 00:36:49 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d6903000000b002e105c017adsm872386wru.44.2023.03.27.00.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:36:49 -0700 (PDT)
Message-ID: <d538eab9-a97a-25c4-f4a9-fe3f1e1ef449@linaro.org>
Date:   Mon, 27 Mar 2023 09:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] dt-bindings: display: panel-simple-dsi: allow vddio
 variant
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
 <20230326155425.91181-3-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326155425.91181-3-krzysztof.kozlowski@linaro.org>
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
> Few panels like Samsung s6e3fc2x01 and sofef00 use vddio-supply instead
> of power-supply (in DTS and Linux driver), so allow it to fix:
> 
>    sdm845-oneplus-enchilada.dtb: panel@0: 'power-supply' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../display/panel/panel-simple-dsi.yaml       | 24 +++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
