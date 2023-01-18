Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3587671F42
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjAROSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjARORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:17:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC2E4ABC3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:58:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t5so29606393wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eLXjIIkGxSWck2rfXalXrjV4Tcekid4+HrHVV2bJUI=;
        b=h5KVII21vPcPL3fR6M1fg3D+onqYYCwo4zUrpSCLBLZ6xIVp0yG69uVCJ2VNg2YdL4
         AgKr9YwquFqfIYYcTFgypADk2Jlm56G0Mg6XdowFxZ/4u+Me/2easAjXhG129xmvekLI
         CBsomj3qcpzaz7/v9x0A6JzcyxXMsFFUEpZSbCNXkuq1cr2WANs4NcTOFBo/5gCvvioZ
         skOsijdJLMPovlTGsk2tgaFM3w7eJ9UDVv1HjnnSylg9wjxRtYMUtBrb046P7HytX9SB
         SUsdxUQeSVBMAAlvoB9JxXWG05rwYtnT2vI+ktdRuAmgIIaJgLWRTxM/kyRf0iGRp4fS
         YnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eLXjIIkGxSWck2rfXalXrjV4Tcekid4+HrHVV2bJUI=;
        b=mNL2rfT6yvOizGxuk6dQvUfclVJW81afllImDhNDm+lMMUDG8Iw40JEtwoiP0lkrRv
         Poc2eJdfKXcEwsV/WylRxTgW9Mpv7FwsyzX/6TfZr4cMeGkqKOdFKC7PpnHrNZFXmQG/
         P4tjdpxP83Go7s4UHIZLT42wWmsrMnKRNDZEDZq6sCLCOfG/tLOpZseZqSm6l2IZ8LJf
         g+NZSSNS4Neipxbvj+TK4psn5YVXlmHVIuub+c+GJUX6v/smLxRME1Eu//dUIKF/3zXb
         EE8CN6JEFXj38heD6/N9WcFO6o0rR7QWncJ+4VnAog5gMYuAbT6k+Mrt/J8SUytHlXyB
         MdzQ==
X-Gm-Message-State: AFqh2kreaZdIvquWocP5q7Eh8NcbLhD3GVGnFIL73xLnr14rNhZkgndI
        wwNx3560Wvaie20HqW7KV7ViCA==
X-Google-Smtp-Source: AMrXdXt6uFCwG2EH88QCNDC2WYsNbM7syJyZ4vhQQnwzg6CKguCKJztsbPjggsrSyCcohTsX8LaIlQ==
X-Received: by 2002:a5d:6b09:0:b0:2be:110d:5d59 with SMTP id v9-20020a5d6b09000000b002be110d5d59mr5784786wrw.51.1674050283340;
        Wed, 18 Jan 2023 05:58:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d64e2000000b002be063f6820sm10807752wri.81.2023.01.18.05.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:58:02 -0800 (PST)
Message-ID: <5b1f757c-92af-f91f-3fd4-ad23622add7b@linaro.org>
Date:   Wed, 18 Jan 2023 14:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 07/17] arch: arm64: imx8qm: add can node in devicetree
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230118072656.18845-1-marcel@ziswiler.com>
 <20230118072656.18845-8-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118072656.18845-8-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 08:26, Marcel Ziswiler wrote:
> From: Joakim Zhang <qiangqing.zhang@nxp.com>
> 
> Add CAN node for imx8qm in devicetree.

Incorrect subject prefix.

Best regards,
Krzysztof

