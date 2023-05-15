Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C5703227
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbjEOQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbjEOQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:06:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C219BA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:06:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so113167281a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684166765; x=1686758765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Xl3tAHibeX0ELv4ZWI2CzRgdcAwmc/SPOqklbvU4ZE=;
        b=p4qdt4DmHBDJVpl7TwM9UqEhN8F+WOuunchLFSvy0uPZkHhjgEcfWaZNnzeazpNcjA
         bxqSKZDwKK5uQGI386j1VDhbeeUPlQNp+Z3BsdkZv/UwaHB2TXGgc+sUAw3EESGlFg5h
         7WLtmCsGkoTFIJKMPejpqLjuPB/wozpx1W50LWnsUzK1uqJdESJMmtwsreIbGXKVuNXl
         0ete5BfWjj8OjZu1wn2Dvex1PKr7LqoRilqsQBUdQpcFqgytL+6UWdcDHbUVdLBm6u2D
         p1ctnvc1myHoqw3ndjSPDzowm1xmdGJKnGvWPxIsSe+duXVP+t/jI0WGSGHwbvpEfkO6
         Y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166765; x=1686758765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xl3tAHibeX0ELv4ZWI2CzRgdcAwmc/SPOqklbvU4ZE=;
        b=Wn1VTVaEPDTyuIIuZJW7nUjZ4d7ci9zmaYjPskThM6X7U0ILjDwGHIoAGC7YgOlzKl
         GsSwkfYuVly5UlkzDcVaTr1zUVTnbC57qDJ70RT+1iqA2RJBXn70Qrw1p58HdJBXBjT8
         aGr+mDhl8eom34q0PvjcXzTAegMzhuD4SlS7oRUXpEnIF27znk66QvTag1+ll50WBGoJ
         zSHBXV9j2dyefp4ixU+9BSY8dpB5AOfjWbL4x+MswxAMAkFjvQ4RqYK6V8ts3UySaUH7
         elXeGV25BtImdcWrK9OIAzfHp+1wBNy/zlumwU1OPuEJu+BwcfgdtQBnnvcwHlPqa90p
         1JCg==
X-Gm-Message-State: AC+VfDwxAoxL0emx9TTJW+tDWD698XmoNWFTNeOfHJhkHHpXH3qPmPmS
        JuED+VQWZEF5RV4DndJRFrsmKGBT9JNEqx0oJbU=
X-Google-Smtp-Source: ACHHUZ5p8FKApy29QMLH43WyYHiijGbaF1MMvRkWy5MurkL/GUG+BW+9C92IdUT3huvJzEWMLQkVpg==
X-Received: by 2002:a17:907:7289:b0:96b:1606:f015 with SMTP id dt9-20020a170907728900b0096b1606f015mr4494583ejc.18.1684166764843;
        Mon, 15 May 2023 09:06:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm7221788edp.25.2023.05.15.09.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:06:04 -0700 (PDT)
Message-ID: <b1e3a89e-1d5e-9fd5-814e-1a3bce0dff0a@linaro.org>
Date:   Mon, 15 May 2023 18:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size
 type
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, shawnguo@kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230515153710.2799008-1-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515153710.2799008-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 17:37, Frank Li wrote:
> In cdns3-gadget.c, 'cdns,on-chip-buff-size' was read using
> device_property_read_u16(). It resulted in 0 if a 32bit value was used
> in dts. This commit fixes the dt binding doc to declare it as u16.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - new patch

This needs fixes tag and Cc stable.

Best regards,
Krzysztof

