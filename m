Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB4676821
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAUSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:54:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F62D4A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:54:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m15so6297591wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHlRS4tTUF+pE273cablIaIcmSDSf47IWgdXnZSwkGE=;
        b=KjHbVHatwK0tD8m7Hx+j+EgCOIfiVXtw1NcSb3VFwxQfQfrXjgCX9iquP0dlcY9Bsk
         orgCLHG1Q12CSP5J89vrFm/S4r4SXv8o1v+/i5fzZrBYThFLbxhdzN/HWzRlX8DB9Wa1
         CFa9MSHdOgnAUXQ7K9b6N7pVR5agu5gNZLaY32JjYBPkTccbCe3baSUPfk+Yup2yga9i
         wWpAVv/R1x96OoAjty4W1p2PmXQFQsihqXlYORwrOQfbvj2X7vas9cLGbGeowuAhCEml
         /DJwgQ/4E5vDj2bF2pGP/WWcGGRYjVYKzfM1bGhzvg2yFi7jbAKVE57N6JHu2vbDsz6r
         3IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHlRS4tTUF+pE273cablIaIcmSDSf47IWgdXnZSwkGE=;
        b=2/Dk6cIEPCIoxhtgBBQGgLxtH2e9iBnuGsc6fH9fSzJfFpSDtSnRt5PNijbqLt2jrn
         4e7Gj0no0zICtUE+he7ybq4fCG2BIoGe+Uf2HiP93u6fsRw6jvsuocMmPCQ61NyqfB3/
         jk5yY43ZUtI8j6aWqoKQdZi17cHOl5zKK3CluwFFP9aZ+rvg06AxElUMkdvHaunHKGf+
         NMMwk8/xuk6J/kj9NajrmNtP+TEWk0q+J3CdWhnx1XwaQ4ZXvqPafXs7UTkpdnh4dhRe
         xejzrdEK2duoJUQif3kpdc4S4c/Hi3eX0xcL5y8iam3E+Zag91qeDc7iurL4IkXLP7yt
         GqcA==
X-Gm-Message-State: AFqh2krUNdFzvXGE0HImQxeoDRNbaBHnJeawobUR1bgnzx238GB2+gvz
        wVC2pYFQuq31bX0I+fJpqWNsYg==
X-Google-Smtp-Source: AMrXdXvWfDyS7nCTlBLmBYH8ggLkgqo3w/dFfyJArIkg5qVFrZbPE41kcAlomNxkx5x9YS9O9pTpvQ==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr17693396wmc.7.1674327263619;
        Sat, 21 Jan 2023 10:54:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8468327wmg.27.2023.01.21.10.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 10:54:23 -0800 (PST)
Message-ID: <65e15459-16ce-bb5e-a523-6ad35b1fcfb6@linaro.org>
Date:   Sat, 21 Jan 2023 19:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 1/2] dt-bindings: display/panel: Add AUO A030JTN01
Content-Language: en-US
To:     Christophe Branchereau <cbranchereau@gmail.com>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230121162419.284523-1-cbranchereau@gmail.com>
 <20230121162419.284523-2-cbranchereau@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121162419.284523-2-cbranchereau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 17:24, Christophe Branchereau wrote:
> From: Paul Cercueil <paul@crapouillou.net>
> 
> Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

