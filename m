Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4C72EB97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjFMTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFMTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:06:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37337199B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:06:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9823de726c3so167673166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683205; x=1689275205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSQ2Ofm/5XwGv6mSESlDU0Nj2cG4DNgNPbhJQeoIQpY=;
        b=QSiA3oWxQopV30s9esmyHII8qfyptsy4AJ77FmiljXjuMB+0bljKoCZOckLJ5XFNq5
         2H8GC2BdnKMUUU6vddQuN5mLZnpgeDwQ7vDBRu2hEEwvmTwFVL3qHucJ2YRJ7BI/qXku
         A9t/uMT8TPCRFrnGAUqA1a94Nxz9hwBspi3yqDAUAb9TBk0m6D/gyKGN7hJcld8gVqkR
         /E1dAJGQAGczRh7++GsflHxD6eHgZNnVmywiBKaqV22yAMD7Twy13+JdUTzyeMOBS0WN
         HbOu4DgKNf4oA2YaCcmJvX5FWYt6HTrswBfo8/ykrCK533CHFxjBP1lT83O5HjamNoFJ
         qvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683205; x=1689275205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSQ2Ofm/5XwGv6mSESlDU0Nj2cG4DNgNPbhJQeoIQpY=;
        b=bVh31peFo5CRQA/rSsBtDr4/rryx6PDfdSdXd9icb1/PMlzJFGvzsurmJ7Olfp86xk
         oUQfbqRNlGzqwC+yvcImzMXSbcRb4EjiuXThJIzd7KRG6wJk4jgX7yBYKUpvdmKIL1zs
         OG5JcTNavN/iwNwdcrx7apvXLWgwYKLfbRLLRP1iUrnstmNs+V4rQw+PXplct6hgj2Ul
         xtpr7NwgWZm3ev91e+LKS9xCaeNqtO6ZYIWQ/0eMs9a58u+NKOf/2Q+L0fF3BvNDCKRa
         bTp8SdBLedkRTH1O8CuzI/xKr/sYCJwOixEUY/GtQOOjSPIpy1NjI5uHV2WoYEmJ2NDz
         QU7Q==
X-Gm-Message-State: AC+VfDzifQJ4NevtjXUCqW4k/ty2nUNluZ6W26JR4q4ONXsIXvZstuAu
        gDlzWhx4btBdrSfxyFLQJiSxUA==
X-Google-Smtp-Source: ACHHUZ4cw2V0nsGESs9QYxJaXsXNVZS7vmLLuxbygQj5JAHQqeGBOQrgl1IoPhdeGZBViBjevxGozQ==
X-Received: by 2002:a17:907:86a4:b0:970:1a68:bacc with SMTP id qa36-20020a17090786a400b009701a68baccmr15992858ejc.67.1686683205725;
        Tue, 13 Jun 2023 12:06:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id rs15-20020a170907036f00b009823e62ca91sm1130002ejb.189.2023.06.13.12.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:06:45 -0700 (PDT)
Message-ID: <89fb41d1-9cf8-cdab-e4ae-d5eef480242e@linaro.org>
Date:   Tue, 13 Jun 2023 21:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-3-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613130011.305589-3-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 15:00, Rasmus Villemoes wrote:
> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
> intersil,isl12022.yaml file, in preparation for adding more bindings.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../bindings/rtc/intersil,isl12022.yaml       | 45 +++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>  2 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

