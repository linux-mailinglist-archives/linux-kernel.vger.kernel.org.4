Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DD6E0999
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDMJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDMJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:02:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764FF4489;
        Thu, 13 Apr 2023 02:02:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id he13so13035374wmb.2;
        Thu, 13 Apr 2023 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376537; x=1683968537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hePEpcTr4MAQXnMqmGvunBUBaXlfTQunP3G36DUCNCs=;
        b=i384PkJRVYCYGBvDYMZG66hIP7oQMpQ+MeQp/fPjllVefZwhzkl3kDUOGFu/vypz8T
         D6tL+cedlOpEaUDl2/IgVaOdz7L8MEpodY9vNHfqICdYqG8q7ChwsFNgjN7fZtv3mDSW
         gJPmjsKow89Ry8rWAXCZGQao+/+nYq7MLq6ne7d2RLTRxdBNxPufaWEPyI38RV8QShp/
         qlKh7Oq95ZAXhbB+RFkVTwXyyKtwMH/zm3QUHdzXfM3TxZAWK0FXb+dVTv1NMJzdjfTa
         +IMnx+ov+3BB/U97k1VQNoHS0DRz6SXfXLtn1HBSl0R/hCTO3meFsJhRVNi3SSLWq6JN
         XYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376537; x=1683968537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hePEpcTr4MAQXnMqmGvunBUBaXlfTQunP3G36DUCNCs=;
        b=JCBiBHWsEG8OvwuA1TIeQahi0+mqVzgkkjgV8jj3UxH6raFp5+YnU4fLQUTKRSbWXz
         qSJFSl4NF709AGTgiWobiK6CkAmM7raRFItpJkqRzrrgU3GIciZy534e/idD3/TnkiDp
         YU4Ba2Z23iyqlvE8G9N9juMdVK0nv9f3TyehIUAEceow3KZal0So5N5b6msPCiqS4ccA
         pCbIeKZhpvFQXF1nb3yMkigKvhmagycieADra17oJWPpjBIMGN28Qe7varg4zJ/h0Y69
         lj2G+hdApyT9zoYrazb8r3J6itJUcmLXd/Ti50WfnPOyW5hw5LF5nduhGZYFnaHASCmR
         jWqg==
X-Gm-Message-State: AAQBX9c9j15C+yhCO55kfGIUBvJRK0LC+c6gJDtUv0pwfgGuzU6OjKXx
        6ysKGuptW4VPiJ/O2u7PLno=
X-Google-Smtp-Source: AKy350aPIkSil2eNqxWa6pty/dkpEVy0N3KQzirw3H6p8KpaxSec/NGQXd6t3JGm8Dit1W6dKyunfA==
X-Received: by 2002:a7b:cd0b:0:b0:3f0:310c:e3cf with SMTP id f11-20020a7bcd0b000000b003f0310ce3cfmr1204986wmj.37.1681376536720;
        Thu, 13 Apr 2023 02:02:16 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003ef5b011b30sm1267080wmc.8.2023.04.13.02.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:02:15 -0700 (PDT)
Message-ID: <83323c24-304c-b129-88fa-f001c0d9e04d@gmail.com>
Date:   Thu, 13 Apr 2023 11:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: dsi: Add compatible
 for MediaTek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jitao.shi@mediatek.com, shuijing.li@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
 <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2023 08:09, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dsi for MediaTek MT8188 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> index 4707b60238b0..13fa76299254 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> @@ -29,6 +29,7 @@ properties:
>         - mediatek,mt8173-dsi
>         - mediatek,mt8183-dsi
>         - mediatek,mt8186-dsi
> +      - mediatek,mt8188-dsi
>   
>     reg:
>       maxItems: 1
