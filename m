Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442197246FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjFFO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbjFFO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:56:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D741FC3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d0288fd2so444338566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686063370; x=1688655370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4ao4E8ClCEWNvR/XfEvDsYDmrnpxfLNmNLp5Yh1CHk=;
        b=nINoPzYlTVe7yYH34kDcl+sgZ1ePQgiPcymueXgFUaG7N4MgSG5GMoIgagNZ+nnvFq
         UViVwp8fbSQ4wdffYJ3oNHXFj+v+Ny+K/XknxVgOQRYM0wQ9ywPg1L+8S31eAn3CuP6L
         wUTb8G+5JVJ5uCwkBIC/68rsGP4veIQ2D+m1ida1zi0lW6xDqlgFuD2TBzXqyOJ/6Yq5
         W7uTlUJZqnH1cCsK87hcxhEPCYTiWOO/2b3UVDsPw6jCyEr7Tlov4V+dnS108gEg3u45
         uaLqIO8F6v+KB5h1hwM1+VhUQ4mkHBx1fVUutLn4qHTo22Vue95wISexnQs3fIFsWbkN
         wz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063370; x=1688655370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4ao4E8ClCEWNvR/XfEvDsYDmrnpxfLNmNLp5Yh1CHk=;
        b=GyAT1xaDaVBrBhMtVk1AqIcaarL8vpPCXGNC8jnwG3+ruqtxUXRoB9r5F4P2BcEv32
         l4dE3SYqLgJmZmsJZoJLR2M7YYtNbXlPXz5jNsF6vQOCoh0zRll45gJAgR987KmbZrXY
         LI4dtgEe73Scuh8B3PXtInQvm453XDulGib6O2p/h8VAknuQYv0JqXIYxnyarsjLYi5y
         QqfTHC3rL45euEKvZqXV8IGZNuITC5UfTQ/ZGjB18O7jIKvtiduVU8Lbfj11kijXGiuU
         m7RX8N6gZKFQZD+07tAp4l7S655alRSy1rHwMLfEhByUkMG0hXfQpatGK73Y3iyWS5Mi
         qVtA==
X-Gm-Message-State: AC+VfDw+/ARBTPmeSl7SekJ2m4lruTdQT7M1/Pq0Jwg9PHweJ8kK5aM+
        RVMzvYNTTrqLzUrR1VCDchjRMzMe2P1PEFuvGRnoXw==
X-Google-Smtp-Source: ACHHUZ6uHm1nli0JlYRJ1g5RUUe8qv6iEShPapCQiVoIL3rCcR37gQfcDi4sApHVba6lUE1nRKNpSw==
X-Received: by 2002:aa7:c492:0:b0:514:9c74:4cdc with SMTP id m18-20020aa7c492000000b005149c744cdcmr2128278edq.15.1686062523794;
        Tue, 06 Jun 2023 07:42:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906374a00b0096f803afbe3sm5606895ejc.66.2023.06.06.07.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:42:03 -0700 (PDT)
Message-ID: <b1a7e0ea-02c1-ee83-dd20-814d257f908a@linaro.org>
Date:   Tue, 6 Jun 2023 16:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: add fannal vendor prefix
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606140757.818705-1-pavacic.p@gmail.com>
 <20230606140757.818705-2-pavacic.p@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606140757.818705-2-pavacic.p@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 06/06/2023 16:07, Paulo Pavacic wrote:
> Fannal is a one-stop-solution provider for touch displays in industrial
> application, committed to delivering a variety of professional high-quality
> products and technical services globally.
> 
> Website: www.fannal.com
> 
> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

