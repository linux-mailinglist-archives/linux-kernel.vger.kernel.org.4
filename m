Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D3613FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJaVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJaVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:16:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F5F12;
        Mon, 31 Oct 2022 14:16:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kt23so32558463ejc.7;
        Mon, 31 Oct 2022 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDfCd2FuDOvtKfrsSPo+hRMdeUAtRjfZl9QXKPEK178=;
        b=gDGxs1fY5KUO+uyr19HQao3BICcCY4is90BRyK3f+Qh9VuFmnzfq5aLy3Q3fvGZTJO
         C61v10U4g/1PZ8bt+tS0bq7A4KwqdVn3UeFFHwFjpWdh0VGd29Am/Yk0ACZW56v9CXRD
         IXPPtGC08Z5zDluhG1AjoBQyz0RCQv+CxJoWwPCvyQFn6D9xNGUmFkl5xPkG62SWKw2C
         RkwEcJLgcc/bOlETdlZ7insycx1toun3GuwVlwXTJEewPIXL6CHT5alBNo3jCAgdJ1+M
         YEA/jeimfRkqup57/mhP6rbhkUXv4ZXeEiWZ5ER6V8UcaeUy9z90nOOr1YTdmwb+C48a
         QRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDfCd2FuDOvtKfrsSPo+hRMdeUAtRjfZl9QXKPEK178=;
        b=nu/w2lnURiUddvDHcu4E/vMIbVbvTqkeNpIl36iODmq78zsAqQPamewKM1wARW8/YE
         OoIuAuuYByESc3L8NvCGASElwQ7Tv1U5Ka6OVeupDDC1ztdoIHz8kalnSFwk3gXU+kJ4
         YRjdOlTqTdy7/w5zH+7o48rfknrLOFW6Wdtetao7kANd4HNMjXelEPK4Uom82rVs1U0A
         UgfVlr7M4fbL4tk2c+k51pojWncCaQZaxhH+CQ7KcSSiCdqrTHOnOyegOGNNk/DyXm/d
         Dqw8B5nu7Y5GmLHMcocNvK91jJL0C0UZI7K5yun3hKl0zI/DoAOXF3IGh5xTuJPboFZG
         CSlA==
X-Gm-Message-State: ACrzQf1NolZ1oZBLOXaCPgyga62zhETCeyN4a5cphalivjjMAGejqY5Q
        O0A7uKAxtihw8K5JskrHgKhao1QFW3Fdlnjlf8HG9u0DjkI=
X-Google-Smtp-Source: AMsMyM56K441yZsKmM7JuCfanM6BjR8HaEBggpUvIKn0DtcCrLMNid1v1ldjaleJWeq81Dq/vY9m8bv6b80jQVsyIc4=
X-Received: by 2002:a17:906:7314:b0:791:a45a:bc84 with SMTP id
 di20-20020a170906731400b00791a45abc84mr14851850ejc.394.1667251014365; Mon, 31
 Oct 2022 14:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org> <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 31 Oct 2022 22:16:43 +0100
Message-ID: <CAFBinCAQKf9RvRWQTCSg7g+7NP_vbEFBUeCoFbYnyfmqeegy5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: document Odroid Go Ultra power-off
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Oct 31, 2022 at 5:47 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
> to its two PMICs in order, this represents the poweroff scheme needed to complet
s/complet/complete/
> a clean poeroff of the system.
s/poeroff/poweroff/

Please wait with re-sending this patch in case the dt-bindings and
reset experts have more to say than finding typos.


Best regards,
Martin
