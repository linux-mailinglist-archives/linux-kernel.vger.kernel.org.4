Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F3746996
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGDGYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDGYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:24:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C750E72
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:24:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso4833299a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688451846; x=1691043846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWFUlsEWM6LUTEKFlGXkFc84bK86cV1j9iAdDl9uNGc=;
        b=WGwRIGoAvFDCqweJ7wCE2NBT95Q63+B6qTTMVfmQRMV0Jx09r+XE5zrV0a+bWjyQU9
         ug59LfPQqgSBHHYf6qmHHSIwhQuHesJliEw2xYzW9Y6hf4hypN2/tGoDslVzQZ5KCckf
         FKrnZzNhb54Tpn3lCgHk0LjQPqtIWaxYpndC0JMPXgsrUBJs9vkhqiLUJtGjd0pGd1CM
         3H/gd1R2QITincQqghx1jMFWT7iEEaggjLOehpUG4AyMz1WUampBCnvXkA1FgajrwKtC
         QeUKvLDgFri+IQmNFWj5+aAMnF+2PvKZiknHLqXlG4gcTmUhKzNo+bnhHEIpI9DUK39n
         oxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451846; x=1691043846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWFUlsEWM6LUTEKFlGXkFc84bK86cV1j9iAdDl9uNGc=;
        b=SRS81xxaE/fIfaJVyOv88VCN7TWojoT6jL/lLK4tfqkNAA6DlOYdTQdLnXFCskD9Y0
         KIpYN5hx/6zNRUwlsyQURoJT8yomPyQg4osYeZWntLDv38YolZEnddH1bYR/vVh+yxS6
         Ik/2bLsq9vyb0pPdqfX+HmvYO3LEG0Zg+W9q1jEM6Na3w82JbgVLuc5d+W3NfUA/YElT
         95u80KZU+9t9XwLevjKguhBYUOIDNbtsiZIoKsgxzAX6u3QVoXDZU7UHouv9JJJNeNkL
         MOo9Q/KIlPXDn3nLGdzTiggMYcqk2Z045+QwEZzWBuBeZRACSkXFCojJkchZ6k+dZrhZ
         gPDw==
X-Gm-Message-State: ABy/qLaPOBjtNlR/jgdCLB/Op+fIuKXLs/rjUMRtxOvX2a1plDrMAy5P
        8h8/hDV9NsG0Q+isyNS0H5A25A==
X-Google-Smtp-Source: APBJJlEY0XWYgDSAhdw45aIa3oaKJt+o1v0iVIp66yO1S3yifs0c/CpXkHFdZZcFNbuSNwN86bQmww==
X-Received: by 2002:a17:906:a289:b0:992:6362:8866 with SMTP id i9-20020a170906a28900b0099263628866mr8728353ejz.18.1688451846687;
        Mon, 03 Jul 2023 23:24:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906829600b009931a3adf64sm4530706ejx.17.2023.07.03.23.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 23:24:06 -0700 (PDT)
Message-ID: <07825f72-b2a0-ccf8-7806-0b74a21a3364@linaro.org>
Date:   Tue, 4 Jul 2023 08:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/10] dt-bindings: mfd: Add compatible for pm7550ba
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688395346-3126-4-git-send-email-quic_rohiagar@quicinc.com>
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

On 03/07/2023 16:42, Rohit Agarwal wrote:
> Add compatible for pmic pm7550ba used in Snapdragon series.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

