Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004446B054E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCHLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCHLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:03:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E8BAD31
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:02:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so64071388eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k80FxeJerPUTe5+cMAy1ESh6Ajb9kzwQ2sNMq2PHkUE=;
        b=y6J1U+DEAr44b6ONBQvcjwqRCpi6ifaA7Ef8AKQHLdwv0HFwCmxo6klNVD4nFasBMx
         LXQZ7D7Ybilz/jkKjemDBIiBkY4C+J1lPIedVjxBtRQ23YCCA+5f6Ye5bQ1FKu23mtZ/
         MPIHcd09Et10Hc3yUzkidzidbTo8K36CuYNWc+/FOwcA+URltJDXcfrJ449+0hyYTX9M
         hQEkM0karO7uCHYz8suCFzMvI+Zj4DZDDUxOSRVS6aXgRmgvtu2Ai/pTuJ/dB+VA2scL
         hyzyCNtmlrgJDDo93pDtLKe0jaSqMvXQuznR3s3PVt6hHg3ysW3UFpot7JCyCmbWcCzI
         5v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k80FxeJerPUTe5+cMAy1ESh6Ajb9kzwQ2sNMq2PHkUE=;
        b=fMtDroSv06gLco211MU+YNY2ucmUpFSu7ZJbGlwxvrQi8A2r5w309NtZL5OGJ/D/5s
         eTgqyd8UV8QFLj1ikJ+dRND0cpn9xA2z3WoLvrpiJsUgSumWGBlpns7DbINb2PdfStNW
         WELgoQ3wywG4yC4AGaSqA8Ot4Qkt23SN4+eiTdSs1MsE8SyD60AjSQOXgBmnDfe+dXWI
         lRlfAtitifLTwSRqTvpjPq0q/w3vm165n3t0BZAsxiDhJdxxpX28IxfqgCmvDVqwyfhB
         EOF+Sskct0Awpr4OJCHBSAjexT5WL/q8N5n6GrZNfWnQdE1VNzOe4nuAt5N49MIJzwRw
         staQ==
X-Gm-Message-State: AO0yUKUORwzuTJ63OdrJUMg/YKUyB+KTOWMpWr70BvtsTfkP5rm6TLep
        J4M014unkHhBRe26GMxDDUZvHA==
X-Google-Smtp-Source: AK7set/ArpYmcUcM28cuvqr+z9jdgU4VQTOPhT9VclgPwbZWgL1KJjomKcNhXvek9qwmGUU38jNmlQ==
X-Received: by 2002:a17:907:9493:b0:87e:9441:4c6c with SMTP id dm19-20020a170907949300b0087e94414c6cmr24160431ejc.49.1678273367175;
        Wed, 08 Mar 2023 03:02:47 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id lc9-20020a170906f90900b008e34bcd7940sm7274120ejb.132.2023.03.08.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:02:46 -0800 (PST)
Message-ID: <ebc59782-4cd0-ad0d-e8a9-15008d93a7c8@linaro.org>
Date:   Wed, 8 Mar 2023 12:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for G12A
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
 <20230307222651.2106615-2-martin.blumenstingl@googlemail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307222651.2106615-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 23:26, Martin Blumenstingl wrote:
> Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
> (we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
> Add a new compatible string for this SoC so this new bit can be managed
> accordingly while keeping "amlogic,meson-gx-uart" as fallback compatible
> string.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes from v1 -> v2:
> - make meson-gx-uart a valid compatible string for meson-g12a-uart
> 
> Changes from v2 -> v3:
> - don't add extra oneOf as all of the entries are enclosed in oneOf
>   already
> - don't allow amlogic,meson-g12a-uart as standalone compatible string
>   (which slipped through in v2 due to all of the formatting changes
>   that the extra oneOf required)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

