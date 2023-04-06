Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF616D9DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjDFQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjDFQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:38:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD9977F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:38:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sg7so2826057ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680799113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWDcJ97FBFl4hgq5OIfJLSKl2wEKzI1QT0yr2K4Znq0=;
        b=Fc0NYTJhxNCIycKuaHx871vbDcmCb2OqHdnPGEljFbriQiWpw0JegRVZ5TANfwqjyz
         sZrhpt1isg5mXafdzTWWjhh/HL2N9+gHUDFBgLbCu6mNxSztgWAQp4TVOJg8WZPEg8nR
         YUmjjBbZ7CdTDBFKFlUXfw4DYf03HqjY2Pl13dN2f4Oxoe8iciebvDy9LmhsOos/MVrV
         8vZ4shuaAIfWyJvy5SuPBi3egDIVk7t+FHhVBvLMqZ+L3j1EPqRd2USXDe0M5TGpRJCI
         qkCUZpXdkBuLmzxhr+tpC3d7ql/BgeI0oEbDBhuQxWLzAkNt8jbp1FJZ5+1eh9bOkcPL
         5HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWDcJ97FBFl4hgq5OIfJLSKl2wEKzI1QT0yr2K4Znq0=;
        b=7yKJD4dL0s+oLDkEfVym4+pAGalzIZ2RcUMyl4/UDori0AVUOazncCjUqw3E0dWAoo
         oMijSifSOgqlx2k/dj/jxzojSuzhH64Pg3s1atHAY1fCq0n/oy+0gb01fyFDcnShzJIu
         sY0bdC615Az+IqF+5N5cdmjaw2IFTZNNeVXATsrSC5Ja8Kh7vraBtqa/BSf3mPTPbMB1
         cqm8pRXyi0CSjlLb9igBDQMMBCj+NIaGMcDKHkHVgsRtazgsHWa3NuY/fhIYIRpOhIIO
         t1PtQPQWZAfZXH3nuXbXGhu8bAt4UKfS3Bfu0AWGFtYjSQXa3Er/J2tbLz9A6ryAnT0o
         7Kcg==
X-Gm-Message-State: AAQBX9eHB5E0bHtIQCQGA4U2iDnzCligiMmYlpw/FSZY4lYWl9XxxbvB
        JDIunUUrvaXWTyWEunZ/JEu/DQ==
X-Google-Smtp-Source: AKy350aS0NEwtDEBHk40rYZEAEjF2aRpnkTgWNwXWWFdGehYULwO3FfJ2tZdOw08E+5EhCOmWpY/Jg==
X-Received: by 2002:a17:906:5a73:b0:862:c1d5:ea1b with SMTP id my51-20020a1709065a7300b00862c1d5ea1bmr7110646ejc.8.1680799113564;
        Thu, 06 Apr 2023 09:38:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id oz8-20020a1709077d8800b0093120a11a5dsm1019971ejc.92.2023.04.06.09.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:38:33 -0700 (PDT)
Message-ID: <a8234f66-d214-ee46-2455-a1ad8650bd26@linaro.org>
Date:   Thu, 6 Apr 2023 18:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 2/3] dt-bindings: arm: fsl: Add Marantec maveo box as a
 DHCOR i.MX6ULL SoM based board
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406154900.6423-1-cniedermaier@dh-electronics.com>
 <20230406154900.6423-2-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406154900.6423-2-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:48, Christoph Niedermaier wrote:
> Add Marantec maveo box. The system is used to get a smart conntection
> to a door drive. The core of this system is a soldered i.MX6ULL DHCOR
> SoM from DH electronics.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

