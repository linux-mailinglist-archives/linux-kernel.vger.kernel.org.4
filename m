Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3C737D81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFUIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFUIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:14:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1ACC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:14:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso7329210a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687335278; x=1689927278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFzwm0k+gSaYbrmuFD+Ct/zQgWpL6tZz+YLkGnIfg6I=;
        b=a76tJNOALkltAqWqgtPCU0wkn5mbUJV2rsmN+PBeKjidPCp+KRcctMQIsbMnOFXqL/
         XER5GsRnI7gZFjKcMcHgU3I+/zpLLnKSlHODP2Rss0DWWOHR8uYHMkkC3CCRZ7NCPX1F
         52d5DkJEg8COvAfOVtYEL/WcdEHsV5qzr9k+utruZmLC/aqazzNlQqonr6t44o+X4EtV
         Ooz+L2BbiADCJVa9bx3lCwsrppzQuF3aG/tb2G/E+2f//0aGeTmSV03uM8q6wblwg4j8
         1FZqvXCB6lTayJCICqlwWiL15Nz2wSWsYJV5VvKzuiWikRWEwTF8vaVYXzb1t24exUqF
         kjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335278; x=1689927278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFzwm0k+gSaYbrmuFD+Ct/zQgWpL6tZz+YLkGnIfg6I=;
        b=ZCX3xdb3zUrSTI8Udin8xEMc7FuQeJhml+lo1R719ZAKWe29plxOABxlk570fyofLv
         i7mpaSY7G40xQHKONMIGQmyFhWlsAhGRlbj64+AeOSuIEi2jUu4fofrJygbET+vGkFdz
         KLcLRb+naABJ+PcSpTKoWHliMLj+4Gg/38Z/okjrLV7uNbf9uKFqRctnruGW5jTqG28J
         L0PlYwtIdmlAoe0sHLN3T9pI98JT8cl6sELgI6jNKJrYETS9qFdEFSChr1QGInIces2Q
         eoqenisG5brZW+TWpNDYPz6EMGscdrh6X3o1fj59SKaOrka/C8mpSqEhukbxbgKISCtW
         wKyw==
X-Gm-Message-State: AC+VfDzwngxgz/Ki3UTcBHVuYzYQioAxjy0YgONp4odhS3FohF16mRqt
        dVvD+JKMKcpAM9BEGwfDyAmyqg==
X-Google-Smtp-Source: ACHHUZ7UrcFS6J/tH2I6gNeCns11XWXlOjvCQUWbFjRheU0+56SHXKbV3CU9w/ukLC9Ee3IUJHyMhw==
X-Received: by 2002:a50:ef19:0:b0:51b:ac91:9f58 with SMTP id m25-20020a50ef19000000b0051bac919f58mr4448024eds.4.1687335277701;
        Wed, 21 Jun 2023 01:14:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q26-20020aa7cc1a000000b005184165f1fasm2230331edt.5.2023.06.21.01.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:14:37 -0700 (PDT)
Message-ID: <d0448caf-413e-912a-93b8-d76e976259b9@linaro.org>
Date:   Wed, 21 Jun 2023 10:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXT] Re: [PATCH v6 2/8] dt-bindings: display: bridge: Add
 Cadence MHDP8501 HDMI and DP
Content-Language: en-US
To:     Sandor Yu <sandor.yu@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Oliver Brown <oliver.brown@nxp.com>
References: <cover.1686729444.git.Sandor.yu@nxp.com>
 <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
 <20230620154856.GB3637514-robh@kernel.org>
 <PAXPR04MB94485F6E2DC5CDDBECED425FF45DA@PAXPR04MB9448.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB94485F6E2DC5CDDBECED425FF45DA@PAXPR04MB9448.eurprd04.prod.outlook.com>
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

On 21/06/2023 04:23, Sandor Yu wrote:
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - cdns,mhdp8501-dp
>>> +      - cdns,mhdp8501-hdmi
>>> +      - fsl,imx8mq-mhdp8501-dp
>>> +      - fsl,imx8mq-mhdp8501-hdmi
>>
>> Is DP vs. HDMI fixed for a particular SoC implementation or it's a board level
>> decision. In the latter case, the type of connector should determine the mode,
>> not compatible.
> DP or HDMI is bord level decision. 

Then it's a connector, not compatible.

> Because DP and HDMI have different initialize process and less functions could be reuse, so they have different drivers.

How do you organize drivers is independent of bindings.

> Please check it in patch
> [PATCH v6 3/8] drm: bridge: Cadence: Add MHDP8501 DP driver
> [PATCH v6 5/8] drm: bridge: Cadence: Add MHDP8501 HDMI driver
> 
> If use the type of connector to determine the mode, hdmi and DP driver have to combine into one driver.
> So the compatible may the better choice.

Why? Because one driver implementation tells you to do that? Bindings
are for hardware, not for driver, so whatever you have to do in drivers
is not convincing argument.

Best regards,
Krzysztof

