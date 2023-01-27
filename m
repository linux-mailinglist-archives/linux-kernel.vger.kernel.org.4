Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94C667F252
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjA0Xjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjA0XjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:39:23 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F84392E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:39:21 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h18so186864ilj.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qC2O9NPNEzdAPyb1IUtqKUtkkYa/FrSrBbMsmbadOAc=;
        b=TCccdnp/B/kJgkBYWvZ8XcCiErjQ/EUHgCY2donnzfHnjjKWjV7RNxCzqtAY9da8+u
         tbYa0mRLGY5mo3j+zc06S5rWJyJCQuZUok0PgexI7acT1iyd52FNScoCAM7FA+blVEqX
         1kJDDF20EJ+9z9oY+uEVrZWZOlEH5hInHYyhBGepauKfa89YO102Wu+dLYYZDRvwHOCe
         1FyITpVywWHQrZ5v4d94C/WQx+N+wRPDfeE7s8h71X8+lOb/3lp8gK6SoIQ/zQoJl/LE
         Kjj3m1ZgvxG8YgLVXe3K8uZdsY4oc8l7fJnqP3yeCR3Y36df5Hs7JzkkpBnVoi+QKqPs
         I6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC2O9NPNEzdAPyb1IUtqKUtkkYa/FrSrBbMsmbadOAc=;
        b=kndbxhrttjlX8DKXKHMUDlQiQN7bAkzjwQZAzkEnlIPyMTw6mNx9CSCImhYlxo6NSY
         TvgQ5PsQKcfwmqz0+IchT5qV+pNGO/KpobjwYg4j5KvvSK9M5CwNI5Mg+wr/XrPhaxLY
         qbsZUbiOhoZyjJ7ftMNtKQRcwV3Vp8c78sn9hod/2kE2IubX19E3MsDnvvKn7r/rOmKp
         7JL23EvOxs9OuYBm6zOCl4pnyZRawJSXTAN5/I0YcwW3VawYtOpIK3r5JFMB2t5nThVm
         E8o04o65AuihJwB3cZqrKSxnyrwoYQHm++uOQnCwWMTUxqYpKroy6fsd6BBM1eLAbDsV
         9iEw==
X-Gm-Message-State: AFqh2kozsOazg9nDyblti2ykyEplDbGHrzi3MBIlr1OkXkerWXthe1lb
        nV14+mhVhehprae+Lvrsw6c=
X-Google-Smtp-Source: AMrXdXv54ud0A99UAP6z1a35z7uAJk8q39WFFHpjuLV9+HvtXFLhG58afTcJmeITQc4Tjc3zub7lDg==
X-Received: by 2002:a05:6e02:1608:b0:30f:6088:5dcf with SMTP id t8-20020a056e02160800b0030f60885dcfmr25822898ilu.1.1674862761365;
        Fri, 27 Jan 2023 15:39:21 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id ce14-20020a0566381a8e00b003a7d0c20f0bsm1920947jab.97.2023.01.27.15.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:39:20 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:39:18 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 04/37] dt-bindings: nvmem: qfprom: add sdm670 compatible
Message-ID: <Y9RgpmgNyhe5CSdn@radian>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <20230127111605.25958-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127111605.25958-5-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:15:32AM +0000, Srinivas Kandagatla wrote:
> From: Richard Acayan <mailingradian@gmail.com>
>
> There is some configuration in SDM670's QFPROM. Add the compatible for
> it.
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Sorry for only noticing this now, but this was originally Acked-by:

https://lore.kernel.org/linux-arm-msm/5190e9be-1ac8-6ef8-83f1-e6ec0df9e0b7@linaro.org/

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 48cfec0c9ece..b7811bbb0e71 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -28,6 +28,7 @@ properties:
>            - qcom,sc7180-qfprom
>            - qcom,sc7280-qfprom
>            - qcom,sdm630-qfprom
> +          - qcom,sdm670-qfprom
>            - qcom,sdm845-qfprom
>            - qcom,sm6115-qfprom
>        - const: qcom,qfprom
> -- 
> 2.25.1
>
