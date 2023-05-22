Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F100770B827
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjEVI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjEVI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:56:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F89137
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:56:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30950eecc1eso3528870f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684745759; x=1687337759;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2g8LwJZM8KGfhtnoH1qIOIMLZ0KOrIyccEYwFZJvPJI=;
        b=u/WPWtnLe1zhYynZyJx6cLlZmD7/iJhiZZferm/FeN2pTM0Sso2KIDyHuWyhCsIhyN
         ft7HxRR5Nfk+kZZlfifi1EA7cfB8Afl/rJFmc6fzaHHStCN0HmqL4K8hazl8r2CJgARD
         HU+x2yxZ6grpKPb3ADtqJsqIqwVL5yM4Uqv2Shs4Nygn1jTP+aT96e5aOFiOo1sp05xJ
         NXONRxz1sYgETwrC8Av2gN2E4W7FO+HNjWSKn2AHvdaWckze+TETDwZf6TF0GHrnHxo9
         HD3fheBk9CVQxKEO+zxlTfinSZ0XBYoujd4qj7SuoHLaNipr1ooTqwdPQSCdDAXbuoyH
         dzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745759; x=1687337759;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g8LwJZM8KGfhtnoH1qIOIMLZ0KOrIyccEYwFZJvPJI=;
        b=T1S/D6mqZmgUQrUf6fbhRCOrRX3J8LD5zZxWRAW/4t+X3snwRs+a+4qeW6MNraOKq6
         Cmu8kPYjF+ifuekVCOzZGVcg5dQ3R8QQ47Tztr3OiXEvncbBUClag5f/tM3LH30j/tuk
         mAjUrfpolFufz37Maery7sakA2m2RSF6wnf2WTbRMEmLDUXu4sdI3SVv2NRpBlszyoMN
         77z++xt6jRgwnBDdWwlW+LWUFlCAjqlXVzENhrWP3qjNphFZwscObJd+hRBMQD8lAjfZ
         8G+9xHyvHSve/meFkobTV5rhuAuOXmGMSXDzP8AvKz8BY+f/2q9NZ/8Z38qii9ozeQVu
         ZQKg==
X-Gm-Message-State: AC+VfDw0fiNnFF/6IdJEr8/NIUkctiY3U9jNUMBUC5vPuXlgwUVwMQyH
        cN/2swiN5jZVsMClnaJ0ce6xcQ==
X-Google-Smtp-Source: ACHHUZ7gRgnuE/zET6SwgFQjgi6Lss+jLfYgRbSsHZFIEka9heDi5yUaGk0eucTuDO7GPW3aFwsktQ==
X-Received: by 2002:adf:dd89:0:b0:306:45c0:f070 with SMTP id x9-20020adfdd89000000b0030645c0f070mr6842962wrl.39.1684745759560;
        Mon, 22 May 2023 01:55:59 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d4dc5000000b002fe13ec49fasm6938803wru.98.2023.05.22.01.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:55:59 -0700 (PDT)
Message-ID: <c0932a06-175c-3294-98ec-b26e961e34c1@linaro.org>
Date:   Mon, 22 May 2023 10:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] drm/panel: add fannal c3004 panel
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>, sam@ravnborg.org,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230519142456.2588145-1-pavacic.p@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230519142456.2588145-1-pavacic.p@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 16:24, Paulo Pavacic wrote:
> Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS commands. After some commands delay is required.

By curiosity, on which board is this panel used ?

Neil

> 
> In previous discussions for device tree [1] [2] and device driver [3] were named mipi-dsi-bringup.
> 
> [1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/CAO9szn3t-giVipb5oH_3mzQZbnXbDqqz0WEg8uAmo-1W2uKzFg@mail.gmail.com/
> [2] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com/
> [3] https://lists.freedesktop.org/archives/dri-devel/2023-May/404775.html
> 
> Paulo Pavacic (2):
>    dt-bindings: display: panel: add fannal,c3004
>    drm/panel-fannal-c3004: Add fannal c3004 DSI panel
> 
>   .../bindings/display/panel/fannal,c3004.yaml  |  75 ++++
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   MAINTAINERS                                   |   7 +
>   drivers/gpu/drm/panel/Kconfig                 |  11 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-fannal-c3004.c    | 405 ++++++++++++++++++
>   6 files changed, 501 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
>   create mode 100644 drivers/gpu/drm/panel/panel-fannal-c3004.c
> 

