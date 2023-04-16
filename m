Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3E6E39C8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDPPZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDPPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:25:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA431FC7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:25:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id xi5so57881844ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681658738; x=1684250738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rkr16/2uhjc5xAZo5cEHlNc3VpIEgJzarzHwERFHq0s=;
        b=haCdf9+BR/j8VQG3dCbrLnnCA31UGr+Aa4I9A4PoSXkSnVJACLUgsZ4QSDWdmOoLJD
         QPHeN2ybyOyUzFiPutyNO6gCu7KL+SAYlkB9LwSbh2rmWEMccsdPqYu+sPMTn6Fur3mg
         id33jhveF/A0GGFCpSlkXZ5ae348JtwL5g4AtY6kLpOgy+vCFPl0+nmMzMdow3ovSzhw
         alyVJnQihCV0erBSBIqrDOeNI0JkZRXhuzsWRIqkoazSHRRDQsp+1P6Rh9sjN7Ry4HwK
         EXsPRodppOWvl7Bq1bGFToTFqjpTitsEkNlp9Wib9HTdJ/UVMU/skVgyOP5qsN8trFgx
         qo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658738; x=1684250738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rkr16/2uhjc5xAZo5cEHlNc3VpIEgJzarzHwERFHq0s=;
        b=Wz4s5+xEfM2vopDpqmk5XIVo4gSUjoWQJT7zFxDalNkBj78ze9xbB0d+kPFjyt8g9C
         8nC9cNP9OiCi+hox3MhEWhBw/ZHu1JafKzZEWv5SePirFJeYc+6QrnB3t7xuvCG1I2+9
         GNtqoJ4Y3fLW74OemyH42EhYwGZJbbdeEKZOamHPF47aYrdThFjc4CHX0G2OglSd6TN1
         +fukdSol0p1bqsqvtZiMq2yzkbaXmQEUhE56gwa4q3uNkfDdx1CTIXybcuNpIWQkCQmy
         fAbWkxWGPgZFDVctqk+1Mymd9mWHWNgnwvNM4mzPGuee9wMEKL4/BjyhQY1Hxc/7BKO2
         NVpw==
X-Gm-Message-State: AAQBX9cwW7jD7NhaK1rBJKaj8ls2VZATjPDrUWSqdnNrwWAnMxcKGW8j
        rwvW02WewfZfS1tfZ2nwT37KCQ==
X-Google-Smtp-Source: AKy350aQyYzT88ojqae6iSJ5BPreKSx12yrrdDie3wOuoF4ooIab9xHL7T/FyJ0Q9oL9tGurdDL62g==
X-Received: by 2002:a17:906:b202:b0:94e:d688:c36d with SMTP id p2-20020a170906b20200b0094ed688c36dmr4229913ejz.38.1681658738030;
        Sun, 16 Apr 2023 08:25:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id hf3-20020a1709072c4300b0094f1b3eb42bsm2261976ejc.1.2023.04.16.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:25:37 -0700 (PDT)
Message-ID: <897f65ac-3aaf-b5c2-d888-c2100069d53a@linaro.org>
Date:   Sun, 16 Apr 2023 17:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: display: panel: nt36523: Allow 'port'
 instead of 'ports'
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
 <20230412-topic-lenovopanel-v2-1-055c3649788e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v2-1-055c3649788e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 12:09, Konrad Dybcio wrote:
> Using 'port' instead of 'ports' for single-DSI usecases allows for saving
> a couple of DTS LoC, including a level of indentation. Allow that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/panel/novatek,nt36523.yaml           | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> index 0039561ef04c..38f4f986aef1 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> @@ -33,15 +33,26 @@ properties:
>      description: regulator that supplies the I/O voltage
>  
>    reg: true
> -  ports: true
>    backlight: true
>  
> +oneOf:
> +  - allOf:
> +      - properties:
> +          ports: true
> +      - required:
> +          - ports
> +
> +  - allOf:
> +      - properties:
> +          port: true
> +      - required:
> +          - port

If one is not connected, I still would prefer to have ports node as this
device in general supports two ports.

Best regards,
Krzysztof

