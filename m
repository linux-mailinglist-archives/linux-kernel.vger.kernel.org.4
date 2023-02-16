Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12B8698F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBPJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBPJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:20:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E751C7E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:20:22 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gs13so1021983ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DotY9xq4boB/Mcsod0xacR2OaK1YPcZWDgZTfKhuQo=;
        b=COx7dzf+G7Cv2iqPmtOmPEe+ZgNG15bQAacMWsBJbP2y0W2jWn1qquysgqmRjOhLmC
         AopDclPFTZbLeoFmmUwR2TDd21Quss0eg+F56ZNoxsToV+zmhKslS2VjcguZVHh+Tzyv
         6/hXlfdUjEnBZQWDwjxCPmM18JKp/TAlhfPcO2mdWPJypBMYL5GSXXpP+Cyzp4jqSxJL
         99CMjp/v5Xm1sBeymnjD3jv+nIZDNYmrMT29GVSdeWAlzdwJVfN/AmX57ynRZ57yCmg6
         Io1CuTOL9s5sGu3j5JhohvinCfW+1BBsd56tFTDSZCSvgXNih1sv378I5D+EISsWtHdh
         eAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DotY9xq4boB/Mcsod0xacR2OaK1YPcZWDgZTfKhuQo=;
        b=Lc3VYO09B/ZLHhiKpAj1hzUewvGvhIabwmMQkuCIkLsKPAKrsntW/SNiM4LmN29Xvx
         YEDxXY8oufysCHiHnVLBG82xyjI4gDM1mo9MjLZsaQ/UFVE/fO2TJP+iKgufU5+dXZn4
         0eUBjDlhxGlPqfUv18V7eBvUrQ9dFuXNdySTEe9a8kPixTwUBRkz7+YDEPj7SaLD9Ejb
         ccN2mwvS//XbEi9Blq42zU3b59CdcXu+nBYF4pv13Pu5UbX2WaW31h7Wt25+r1ZrXKE5
         /EpsJqKYR3Tuh9bZjx7flaT/7f3DZ7frZl6c73Vr0+QXGUpfxxry9Oi5cAKLVHUKLcjJ
         mjlA==
X-Gm-Message-State: AO0yUKW//9OFluCgqyEa3t0qEbLeglqVnLgIEdiWoi5HD+OTXuEwfnvb
        Yh7N59v3F4USuUPh9WEDuO/4Hg==
X-Google-Smtp-Source: AK7set+rX7Ybm1ymFLZH5r/hHPJgeLcoeop735NHEWRkuDpbuddXMRK+3E24gNlQtBTojxSYvdgI3A==
X-Received: by 2002:a17:907:9892:b0:8a9:e330:3a23 with SMTP id ja18-20020a170907989200b008a9e3303a23mr5657316ejc.26.1676539220889;
        Thu, 16 Feb 2023 01:20:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qw13-20020a170906fcad00b008b131861890sm558183ejb.62.2023.02.16.01.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:20:20 -0800 (PST)
Message-ID: <cf375c2d-cb73-7d24-1394-c0eeb10ea048@linaro.org>
Date:   Thu, 16 Feb 2023 10:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,ulpi-ext-vbus-drv
 quirk
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        balbi@kernel.org, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, git@amd.com
References: <20230215093146.5812-1-piyush.mehta@amd.com>
 <20230215093146.5812-2-piyush.mehta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215093146.5812-2-piyush.mehta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 10:31, Piyush Mehta wrote:
> Some ULPI USB PHYs do not support an internal vBus supply, to drive the
> CPEN pin properly, it requires configuration of the ULPI DRVVBUSEXTERNAL
> bit of the USB ULPI PHY OTG_CTRL register.
> 
> Added 'snps,ulpi-ext-vbus-drv' DT property to configure the USB2 PHY to
> drives VBUS with an external supply.
> 
> When the ULPIEXTVBUSDRV bit is set to '1' in the Global USB2 PHY
> Configuration registers, PHY drive vBus with an external 5V supply source.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

