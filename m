Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840564D9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLOKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:55:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E835E6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:55:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so3364910otb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCza8Y681Ao9e1rZQSUK5V1OXCO8eMctom4dqQfNHfc=;
        b=fAB7Z9WfgmVcTkFWFzFuxR5lftYNCATZdu+ycm3oWGD8yZFVfpvyn2b90dZwd4q5Ro
         BW1pBNqTY9SzYkA5f0b6VeyLzdjPdH6Jblhf4sNHuuv/jmwhNFN0YJnXFZEskaVWkl1J
         B2LXpmfUf9OVko8KgujbHoKBZ5c5e+KTwwEz9tHHvvdNY/RFsnevCNf9OgCuQF4ZGey7
         wYn3oFQlUB7vhJPBprKglwdDE+owiBu5VKppU+IT9ix8tFrlQS8pG+5hldjeUzoLkPvL
         9puEy4LT93lvLyr3H843v84+otu09aBiATP0M17x/5P9l5EMJ8o03PYjUfx6ncFVIoZD
         unQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCza8Y681Ao9e1rZQSUK5V1OXCO8eMctom4dqQfNHfc=;
        b=lw8tyReDrOW/Yf8BailpNd2/cQdYH86aBU/KZld0MbzkDtycEkd/A17qjDGnMfvtwD
         igiAfLhKzNmrsSrRk3HlZKJ4zbzhs5NAY8t0UgMzElNMckQb6MlYetG85X+MPtnAogVX
         Qrth2VkCnaEVADfeVRvePKqjG/oyLFdwEz77irtffaxNJpZpR8FGD1s7NNd9ZJcw71Kb
         Ee8dazab+edQsFY14DYXYD+e5umye1gZgEvS3O0sGAukBKyWCZ5UiVxmSTboXGN+dxJm
         m5eF9jvIA6zdrI/z3BeMpdSe5rq4xFonC/EWGbVuVWuZ2I83evYJQao8VZM4yZRPlcfU
         UtAA==
X-Gm-Message-State: ANoB5pnnRMib+APwOTnCEax8PKpeeNueN1KKOEWUnHN9jzBE9JYZkO9J
        bUFYa9rKhesru9aV4xsEucvQA2gTk9NIF2bNo+TgVw==
X-Google-Smtp-Source: AA0mqf6vsiFLO4/fq3hCYI2rVV8TLsFliRqkLUvOPWWBRTNBOF0C+HX+cqTaN7IbwDGYSImtaqxOh0Nf19rdCpKkX+Q=
X-Received: by 2002:a9d:6a42:0:b0:66d:a838:aa60 with SMTP id
 h2-20020a9d6a42000000b0066da838aa60mr46266563otn.104.1671101735831; Thu, 15
 Dec 2022 02:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214125821.12489-2-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-2-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 11:55:24 +0100
Message-ID: <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: display: bridge: it66121: Add
 compatible string for IT6610
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 13:58, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add a new ite,it6610 compatible string to the IT66121 binding
> documentation, since the two chips are very similar.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/display/bridge/ite,it66121.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> index 1b2185be92cd..72957be0ba3c 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> @@ -17,7 +17,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: ite,it66121
> +    enum:
> +      - ite,it66121
> +      - ite,it6610
>
>    reg:
>      maxItems: 1
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
