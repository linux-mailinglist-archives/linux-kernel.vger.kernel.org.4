Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D360F951
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiJ0Njp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiJ0Nji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:39:38 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D263E4E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:39:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w29so1085260qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXI7ttHruh1sJniS6TpJJRJcjXoXJ/dSqy2SyC1F0VA=;
        b=kFiekM9BXanfNbGJ5MdCQMWLy47GZ83U2h7aw1Tkexy8Og4ISelKH6cwszpIaHA0Sn
         UXWTWABH5vUlkqWPV+WnKg9dzn4l7TXcALRIK7R8yCOMuFBVv0bGAKUeI7CcZEJdBRgy
         xb1YUGNzU1emvfumth2zWqCLpKT/CaY6ND5L0c38JMmy8alEEXliM2K70ggS868CB2iS
         zwPkkYPwAjSk9qUYiLG4nNRfpJRkhft4FTF0ql+xTLwAS/wdIYxaUhXx03+IptlDjC2P
         dRHoHCjmnjMseI0U9DEqBxqrhy8KlexvY8sxOHcxKh7lZJTXwuaUSJPGy9QbdUcYk6Mi
         +7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXI7ttHruh1sJniS6TpJJRJcjXoXJ/dSqy2SyC1F0VA=;
        b=LWPWBcdnnTjUw2mxPfIy1TDjCi3VklleabIczc3Lsc/eESvXCP8PzI5RYwb/J868G+
         1DesYtLZ792Bod+AfuqzBB169KcOuZUphCo0sghl8K1HNLRXnD5zDosHnqKdL/U0Rh3V
         FTNyvDu2/2A8cn/JeAVn2/mg0GRNMkHdBQRoWvZ9fFv3A7Ro5LoNo39hIJc/xqQ3Wu32
         7icIMYo1EEPha2L8YM5f/BdqQo1V+XKVzGrf9xB7zG0tgFW5iy8k1AOf01WVeO0QPy2J
         yi1IDJAKW/yHen6I/jU+2JmB6Dnh28YAAadi5Kk18ki/SLj3gZE8dP2z7BfooB0YdEOP
         s+rw==
X-Gm-Message-State: ACrzQf24feUKXiZhNpPx1biOaQLmGMbKKx+PRKCtBeH24KNet6BzJ2On
        vXqOadcFjcWIFcVXR3OcO0RySQ==
X-Google-Smtp-Source: AMsMyM51EC06AFkH8LuvtXEBIHaCz7EHTGzSieB15/F7HnjFlhWODFvVB5sLxkSNNGmH6+hxPN3k2w==
X-Received: by 2002:a05:622a:1903:b0:39c:e308:ee1a with SMTP id w3-20020a05622a190300b0039ce308ee1amr42153049qtc.469.1666877975306;
        Thu, 27 Oct 2022 06:39:35 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k25-20020ac84759000000b0039bfe8acff6sm887391qtp.58.2022.10.27.06.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:39:34 -0700 (PDT)
Message-ID: <0cfb3da3-99ff-31b7-d3e3-cf425296af67@linaro.org>
Date:   Thu, 27 Oct 2022 09:39:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: mediatek: Add compatible for
 MT6795 Sony Xperia M5
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hsinyi@chromium.org, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sam.shih@mediatek.com, andrew@lunn.ch,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
 <20221027095504.37432-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027095504.37432-6-angelogioacchino.delregno@collabora.com>
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

On 27/10/2022 05:55, AngeloGioacchino Del Regno wrote:
> Add a compatible for the Sony Xperia M5 smartphone.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

