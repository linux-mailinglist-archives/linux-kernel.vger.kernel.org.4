Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C46938DF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBLQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBLQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:56:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA05EFA4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:56:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so9704763wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Eru5lWHw1YT6wGcDm/Y1zHrSXGWrUQ4j4UJ9DI8DhY=;
        b=YhD7GXsOXf/ZWNNEyO00bn8lrwtUXD0yCHYuK9vhLDg4CcjCbF4hZB4J2MkSDNdkFT
         lli22RfskaAd0tjyVvv/eCE/A0kVfJJv6nhqQqc26MXOljkyZbNqrHjnfqdNWEySaiMM
         OhU0YNoHpJ86obFkfdDoN6pHWjPLyOcsbbjMOnE+RRAqkKFOyrWe+qd6P273rOyiMjVY
         ygM3aeImD6ysrIa/nNzpMvWJksRW5mw3YxbvfzdLOiR81/rW6Zupyi19qEBOiB8cFNb1
         igrIb3RaWYveg9152PB91GfpoICjpEGpVp0/nS7Ao04ik1JjAr7q3nfNTtdUd70J5DJG
         Gymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Eru5lWHw1YT6wGcDm/Y1zHrSXGWrUQ4j4UJ9DI8DhY=;
        b=ghyOK4aT92BtbgQgog9x30MWwQdzkPsQjULSIodKyeE2lHIC/Gimqwzlnagd8R8qlk
         liSILASdeP1FWh9FI3zY/ymG1W8/csDVnEwEGSq0qLJ3ITQVFMyPnW8fmYM5vmgXmFPB
         Iw9FcjqJciY5IfwXnp/B7x/7J/skIw3tB938Ky47fqLsIRgMPZktLaQq8qJH1RXMkIXw
         Dd4YQhwUetr1R4rdoQ9MOEpuXvucij/l5TcdALuhhcMrXH4L7gYJ6NCMJjsh2w09ZpE6
         ruPOqxFSbZKEArg4J0zwMjiwaa6rUDzi4f0/Y8bgBt/4ndtVQheY4fvD0JMNHb6072Y1
         ErtA==
X-Gm-Message-State: AO0yUKXyHhTHs62XBD42Vg7OZs6jrxYt7M/ffwunMJ+AAfD9ZX7cc6pt
        0mqRIVznKSP2RCd6s5m5olA+Xw==
X-Google-Smtp-Source: AK7set9zT0F9F59wplZJome4tcnMKXDw3AXx1E5Rklu8HGmYaTSV/UpCGVDTm5PYo0A91G/GlbNlkw==
X-Received: by 2002:a05:600c:9a2:b0:3dc:576c:ab07 with SMTP id w34-20020a05600c09a200b003dc576cab07mr16942584wmp.14.1676221013326;
        Sun, 12 Feb 2023 08:56:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b003dd1bd0b915sm14369327wms.22.2023.02.12.08.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:56:52 -0800 (PST)
Message-ID: <7adf2cf5-dcd0-748b-9aaf-7e5abc45d2ae@linaro.org>
Date:   Sun, 12 Feb 2023 17:56:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add BOE
 EV121WXM-N10-1850 panel
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com
References: <20230212040843.231934-1-victor.liu@nxp.com>
 <20230212040843.231934-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230212040843.231934-2-victor.liu@nxp.com>
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

On 12/02/2023 05:08, Liu Ying wrote:
> Add BOE EV121WXM-N10-1850 12.1" WXGA (1280x800) TFT LCD panel
> compatible string.  The panel has a LVDS display interface.
> 
> The panel's product specification can be found at:
> http://www.onetech.com.tw/files/EV121WXM-N10-1850ProductSpecification_20180801.pdf
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

