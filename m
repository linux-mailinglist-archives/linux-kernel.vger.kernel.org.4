Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF186615F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjAHO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjAHO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:56:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A736248
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:56:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so5752631wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faUR7WXI3JJAlq5Fj/7y4nlra1VV+37QFyTpQC1/6Os=;
        b=UhMMC5LDsUxyd0s+U1tiT9D2xjSpDzkdVdvSkLIr4Nyf04n0IWW5JprfKC0gxkLFvF
         NnyOUGVPxWGC2OAqsoXhifV+cGpbPvdnpuaIyRIpPw0mb1c5hDIfsK7A8Pvd/A4ErLfA
         EmVn3SZhrBNAAtmzlMdYbz9eurNx/Lg8XPuXjbigIAigh9cd19NvIfQPCDj25KaMOnfu
         F1Ujoco3nSOEgTVmI5ZTfF/8tordADV1/A7i13oog3WRXMQPyHXX+LxeDCxniqCMNLoB
         0+7+mMamyDfmzgII9sLYWIxzJ1uaeaEBHJMp67wNb5TpseFlaPp+/KhKTyWwKMuGuHXL
         r25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faUR7WXI3JJAlq5Fj/7y4nlra1VV+37QFyTpQC1/6Os=;
        b=GkuU3KDUbqs8KYZb/hB2MdinOtyOl4VVpGU62GnPoSgCDhFTgkNbvsahuae3MIJuyE
         9+Tig81n0BEGdUZg4MfSsBeHmmCJIMdrvq9fCP2SE72Div2YTTbGOfbcSSpXzzUrDNeF
         4E4dazG75hi/MyTaxMgbHBSixbK2T5dx9JZhnIN1D5kU2dH+tGrOUvRe1bgbVislftgL
         YaMPiRbnPjhVOu54DRBOVeijUhsHHr48R54h0jSzmIGC2EBpYOvUDC8QG4457sB8Q/qO
         VFccA135wCUkncl2WOY2D/FqSZA5tSu7TFQ2akTV3T6QCndAQnIblxebPpO7KDD56Wwc
         dLxg==
X-Gm-Message-State: AFqh2ko+dcpLF7Hjyletxc/J+pIHy6uBwf0onYdIMF2GuiZXwYZvhQWR
        jNCBL+hvMnaLtvo48nXcg8rpGA==
X-Google-Smtp-Source: AMrXdXvypNaFaV4VApj/5n5B4KrLo6cyzJa/11iv0JfanR3VXSlrcyN4o5PjaNplkSLduvwAAY0GyA==
X-Received: by 2002:a05:6000:10f:b0:286:ad19:731f with SMTP id o15-20020a056000010f00b00286ad19731fmr24871172wrx.19.1673189775638;
        Sun, 08 Jan 2023 06:56:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d678d000000b002bbe8686d6fsm2046811wru.117.2023.01.08.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 06:56:15 -0800 (PST)
Message-ID: <3f7e1afa-d445-453d-12fb-7c87b04c8756@linaro.org>
Date:   Sun, 8 Jan 2023 15:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 4/9] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
References: <20230107102231.23682-1-treapking@chromium.org>
 <20230107102231.23682-5-treapking@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107102231.23682-5-treapking@chromium.org>
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

On 07/01/2023 11:22, Pin-yen Lin wrote:
> Analogix 7625 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Also include the link to the product brief in the bindings.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

