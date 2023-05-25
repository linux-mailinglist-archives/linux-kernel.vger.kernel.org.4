Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0D7106CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEYIAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjEYIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:00:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B3186
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:00:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f655a8135bso1887905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685001600; x=1687593600;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx6/AkchhhsIk24IhJ++7ZLwXy7ijhSBwh/BY8UUZQc=;
        b=c9mNv6qaak/+jqDMGn3APvrr0+w5ES0c1AXI6yC9/c9lAG4EPwi49Txcj5wWxuApZr
         ksHgUxODxOTedlSiCT7b4eHmnSiLO/9tL8AME3h15Z6ar5myK9hI4dYRDxnvjHK50aCF
         Rsjpw/xs7XIBDEhTu00iegVvL2gf8NDKn2Anjnm7tsPydrfChLCRa6VhBAfl6FBECjG5
         a0dbx99g1URkUvbhsvZ5y4DDF1VHEY3x0OL4fYijdjkNPzJxU4K14wdQ8CeVjaout3Gw
         jsjhN8/zjx99gvNTg+vyp9I5cuLrvAJ6u7il4vyi+KSKMg9rRuddb3Ff/AeX991jC8h0
         KRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685001600; x=1687593600;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rx6/AkchhhsIk24IhJ++7ZLwXy7ijhSBwh/BY8UUZQc=;
        b=DUUWIqblOj8Vg9HXH+RovkmbGQ6MjRKPsmhrCYYnuK8bK7J7Oi0hwkxQyp7aI73BkA
         9EF8/0TD4v6Q0fTN38eKEUEgu6uD+h2nXfjXBll/tOFfhjYOOl4y9SucCRsIaDnO5eeu
         Y1fnEr894Ocheh6O6wKiFuq3aUnn8wTPmNEbMC5LuTvN7v3f/yZ/PM0DJCX3HMZpvCSG
         e+nujUTIeg2XpVCgmfe1/phs81VrE0Xl5uZ5gqnfa38htfgSMqzCeComEZf7QNjjXmyN
         zuFmra2+gfQb2zmxrlQjT4enXjYTfj7E0YEiQxV7CzXgpqIXcDj5NTguNsOroH2cV+5w
         zRpg==
X-Gm-Message-State: AC+VfDyB4Xw2O0wMPlPvJfga+VrjYFPsvaAXAa1zZTw0VPdfuZ2R/aQQ
        c8YvFsSTw5eSKkvJ8b05Q+yhPw==
X-Google-Smtp-Source: ACHHUZ4TryZ8bkmN1UsFCBXfEMWzWC55lUiNfaVtlNpCYURcJisdCMit0DGkffnluVcPdw3cG+osKg==
X-Received: by 2002:a1c:7913:0:b0:3f6:770:fafd with SMTP id l19-20020a1c7913000000b003f60770fafdmr2037330wme.7.1685001599877;
        Thu, 25 May 2023 00:59:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6? ([2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c225200b003f60a446fe5sm1178490wmm.29.2023.05.25.00.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 00:59:59 -0700 (PDT)
Message-ID: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
Date:   Thu, 25 May 2023 09:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [v3 0/4] Support Starry-himax83102-j02 and Starry-ili9882t TDDI
 MIPI-DSI panel
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        dianders@chromium.org
Cc:     airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hsinyi@google.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, sam@ravnborg.org
References: <CAD=FV=XUuzjjLq3YP3683jOd06odwk5Dox5MS8oY8goB-_8T5w@mail.gmail.com>
 <20230525025000.3692510-1-yangcong5@huaqin.corp-partner.google.com>
Organization: Linaro Developer Services
In-Reply-To: <20230525025000.3692510-1-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/2023 04:49, Cong Yang wrote:
> Compare V2: order of the tables match the order they're
> referenced.
> 
> Cong Yang (4):
>    dt-bindings: display: panel: Add compatible for Starry himax83102-j02
>    drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel
>    dt-bindings: display: panel: Add compatible for Starry ili9882t
>    drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
> 
>   .../display/panel/boe,tv101wum-nl6.yaml       |   4 +
>   .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 471 ++++++++++++++++++
>   2 files changed, 475 insertions(+)
>

Please resend without Conor's acks on patches 2 and 4.

Thanks,
Neil


