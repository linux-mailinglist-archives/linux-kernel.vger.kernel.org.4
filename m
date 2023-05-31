Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7086F717744
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjEaG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjEaG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:56:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8A99
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:56:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so45168a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685516173; x=1688108173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRl18fIDPuzFUH5L1KBy/4v4z8SL7j1KIPt3iFyBt8w=;
        b=O67yMsSBzjied33O/74JPXPKICCdj2Y4FkUaBPd8DbrXNfI+24UFdTQv7J4qNGC3h1
         6sZjBvqHChuKUExcDwsTZ6ZWQrEHxe7L+tN2Sp8AHk3rf8hxA9SGrJbPLtstlemCZhqD
         qCsbkpMFuRMJY9jQUSUHNzN+g9NWA6zRrufUVYja8+DSIBNG/wJchDSf7fYYdWChC564
         sXgdvwG1zVe6olx0jLzHcpujOiyu7VLhgtTFINTHbtNWZD4i32XI4qpZBnhi3i3lutaO
         fVdAqCx9vhyUOeOYtddo7iFjrJeatDKy3sRGlfufpD3jt2qOukADyD2I9EYgJXNm6O83
         YF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685516173; x=1688108173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRl18fIDPuzFUH5L1KBy/4v4z8SL7j1KIPt3iFyBt8w=;
        b=fhDPcCfxDe0WXYk0jHWpPQoQmwrCGNs6nwRADxR+3Y4mtPqiNPgJWp8J+4oFE/Z56C
         DITEJHBPhOI9j/0ntSbIWuRyTLrAnWtSKqFrgJy/Tq3XX0/eNemWZz+SLzWUeGlfZ02u
         uVzb4nVB4Em/54H9Y+u/9GnqH3PZJiiVuq7ZULz0aviiBzBf8jUlJEHQQaqr5FXXgg3m
         njcT5F0PXTRUvybbEyD+gKMFOT93oI9lVrE1hp3DNTSRpP5q6AFERrrZ9ZkCarUXt2DD
         2k25fmL5ajc8vhUQSd33qGXwk7CUkXW58ekEA9UypzPad5dvh2lO9v3BQklW+x2hfOJK
         jIlQ==
X-Gm-Message-State: AC+VfDwez22d4Pomu7zYTHsZkpMF4j2wPzawH8xY7jLTeOYoAeuTavav
        lrc4ji2hAXMZ6fgZHZx3cWCTxWxd7BbmagmgLjAcyg==
X-Google-Smtp-Source: ACHHUZ53PhvEeZRc4PxzrRyja66TSVSRwEUfAVi5qVfcNtueGY6bjR+MKSR4Fi50FMpWZqypa4WQEw==
X-Received: by 2002:a17:907:86ab:b0:96f:d345:d104 with SMTP id qa43-20020a17090786ab00b0096fd345d104mr3377494ejc.38.1685516173106;
        Tue, 30 May 2023 23:56:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906371500b0094f1fe1696bsm8372046ejc.216.2023.05.30.23.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 23:56:12 -0700 (PDT)
Message-ID: <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
Date:   Wed, 31 May 2023 08:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add pca9451a
 support
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, ping.bai@nxp.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531065724.3671795-2-joy.zou@nxp.com>
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

On 31/05/2023 08:57, Joy Zou wrote:
> Update pca9450 bindings.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---

Subject prefix is: regulator: dt-bindings: pca9450:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

