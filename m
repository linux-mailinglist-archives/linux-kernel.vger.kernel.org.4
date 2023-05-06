Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9136F9121
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjEFK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEFK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:29:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2D9EF9
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:29:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-956ff2399c9so494220766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683368953; x=1685960953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q89WWNqgDfTX8XQe+iwDXWhftOpjNe+SVaLkM27Jjlk=;
        b=pmATmgnNBn1vaw2zFc9jefVTFkd0dnlE2vqaWyus03GIzYhi4HyzVnyelO40yuG4Nf
         FbsLdOYL+TPWBZlc0TzBjLv23EisWOaFqVtJ7I8hyRdQkIJyGxnKJWf8U+17lEnl87UF
         nk5FPFUIX9YjFAbDzbOwMQxx/W/figOX/gCjvtt/cHh4kuwHBv699IQhnIP1Th5OsiD4
         qSZ4Flnl9RaMHEnbxZyUcucZD7QgTsn44dLXogGymzjwvrMwJP1njxSDT/gl5FqAFwMA
         +xJPkkV4fuyksFjlazHpTM9bvRGVUs2rEmA75iCMNANIdV/MyaVhtx8GrJiSrrhlgeiN
         QHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683368953; x=1685960953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q89WWNqgDfTX8XQe+iwDXWhftOpjNe+SVaLkM27Jjlk=;
        b=cmDE1RXLW0i9mpBY0msB1G32WvAvOsQew/gbu+8UHZ2dDK2wisU5NrA3ZDazWTwz0+
         nQNKhIpRi5n64vsmL81L1LBZfHB/QW66qJU+5AnQaN6FHo3DUVAfpviAprTLTwUb/ivl
         jFhsaELrEnToxHRnxOEkmF7MG++mHF4xMyK579/mTxJVaSRORf1BPn0qUVO1zohG8Cox
         hLCbrBjstwajNUcaBuS8EwDsAxDKCbqxyOfacwwyvsQFvQN9/p9jysaazVHLHB7TbYWF
         EIl3599ooIhfDuQ2iveXwWjzMWVPcPRSg7wdf+nzPBMdllV8h6U2r9UUqFCqMumPO50R
         froA==
X-Gm-Message-State: AC+VfDwYjxiCafkwhin2pjv2PWk7WKypZPai3p9jU+v71BCRTznIsbKm
        o0kGVVoCp2uEuOewrHdAdfUeBQ==
X-Google-Smtp-Source: ACHHUZ6/wPqlS3DByla0DrxWiLfSctxz7UcT+4RZsEyKv1NRwAVpbGbddpmZMuF0gSHXShBQ1JQNRA==
X-Received: by 2002:a17:907:709:b0:961:69a2:c8d6 with SMTP id xb9-20020a170907070900b0096169a2c8d6mr3030336ejb.69.1683368953421;
        Sat, 06 May 2023 03:29:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id hx1-20020a170906846100b00965f1f4bac5sm1532711ejc.124.2023.05.06.03.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:29:12 -0700 (PDT)
Message-ID: <2dd9f9bd-c55e-a887-2e9b-61b2b66512ef@linaro.org>
Date:   Sat, 6 May 2023 12:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] phy: cadence: salvo: Add
 usb2-disconnect-threshold-microvolt property
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
References: <20230505185247.1854677-1-Frank.Li@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505185247.1854677-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 20:52, Frank Li wrote:
> Add usb2-disconnect-threshold-microvolt property to address fake USB
> disconnection issue during enumeration or suspend state for difference
> platform.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8x-mek.dtsi |  1 +
>  drivers/phy/cadence/phy-cadence-salvo.c      | 30 +++++++++++++++++++-

DTS and drivers are always separate.

Best regards,
Krzysztof

