Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4E6D1AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCaIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCaImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:42:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCEF1E707
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:42:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so14832744lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680252112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09swxF+Nj+Xdb2rdxxkyYt+YX5gFiLq7X+YfiiWATXU=;
        b=QqMdhWIYeCm7i8YTYpM6RTk4uC3USAlhTr1cbH11KJzV70SFd4sr2hgHWMw2UjUj/U
         z9fnbpijZSSSITJsrKuqjMYuvd+ru/dyQTxa9YMHLNEdILQnpyPXtXlO6iGnl2QY329h
         W5qR4DcjiGRpZmHCwQg0gyllLQivP7vSYPu2Ai9hLrfj2Su8eCmUv0j5ZAviYJ2sryxN
         kizDPi1nH8rNUNBNnoZfKQT7Qr1BBuRF5/NXd4l0RJAHrZAj/SZ3DJiIMMBRIMI5zr7u
         tjZIxMfkczi6OIUJO0GPfbXsSXtnDgwwhToBLl5sigKMFUejTJp5IuTaqgUGa+f7T4So
         QZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09swxF+Nj+Xdb2rdxxkyYt+YX5gFiLq7X+YfiiWATXU=;
        b=oJC/2CD0ux8FYlX2yoA0OQ1cA3IZP5QW/6Ukns3toQkvOfHZE+rRIKCeBbymqW3OTx
         svJhOpV+nYUNEK4IYY1hFGe1TBXIa/ZCiW4HSCVDGWibDLMVy6UrJKTXVoYs5JoOS38D
         cAKR2qgeil1dC5yIPXPz53nsal5lCuE5xViuEh0lZnFm8tgXrN7dJghvAQgYEMzdCZkW
         7GNf7paoZzIipwge3tbTUK7uSOmDO67cqpRjfMvlAhuRMTX5AGVu9Uc/2JY0x+YdzabN
         EadUBBK2ZIGl3KQjK2RFEQkS38cOh+NeOFK4LmTYjXO94tRiTJZh2tOfsCNjE6HMHV+y
         nq9w==
X-Gm-Message-State: AAQBX9erlMoyKHRqW01x+AJplnD3yD3Q8FybbJIAHNGWGXp5Xd0Va1TB
        PJq77WkHWCXhMjfby6PgGIalxA==
X-Google-Smtp-Source: AKy350ZEcpE2BiiN8ZXisNpNjVKAac7e7IUuT1hTuHLZ5NdGEbP+EmXcWQS8P1hRsVOlFWGNCkkPSQ==
X-Received: by 2002:a05:6512:513:b0:4dc:790c:910b with SMTP id o19-20020a056512051300b004dc790c910bmr2583994lfb.20.1680252112037;
        Fri, 31 Mar 2023 01:41:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u12-20020ac2518c000000b004cb43eb09dfsm288838lfi.123.2023.03.31.01.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:41:51 -0700 (PDT)
Message-ID: <e775c230-7092-df3d-35bd-77fd83a41529@linaro.org>
Date:   Fri, 31 Mar 2023 10:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/6] dt-bindings: display: bridge: toshiba,tc358768:
 Fix typo
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-2-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330095941.428122-2-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 11:59, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Correct Toshiba spelling.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

