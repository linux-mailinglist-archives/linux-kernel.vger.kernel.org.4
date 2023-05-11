Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3386FF32F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjEKNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbjEKNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:38:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A2120B6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:37:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so41582235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683812222; x=1686404222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5QAZdjVLVbI0V0MOBRrdkRCmTAX1lGamqSGOVwZZl0=;
        b=zubWSEySVwG6S1WwoZLBWgivEDgrrzpKil0UxQQUDmONjZVJJ66SUzH6iqu/UZ92C4
         +hlbxJ96105mAyduA6JTwgws44lxdd852RvVr315fRGKjNohoW5SLTP6/EM9bHVPlOiI
         kIJ919cEGf4RC2+gtmTHhwpmGx287fjpu4Sc7zfrIgZiJvlww7cFIJLI9MSpa+coIu0o
         xfg5fh/NpUI7GoP8cc7fcV2vVvvICrLjFnzs/djvhtdYJIjepx8zBZZCiJgioqiGTr5Y
         z9QVyTRHxW4+K1XSv+jXLo4a5bxfOCbneTdQzgQ5KAe+W18VKNr/4HiJLVjcVLy0IGmT
         yhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812222; x=1686404222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5QAZdjVLVbI0V0MOBRrdkRCmTAX1lGamqSGOVwZZl0=;
        b=B4zMpAIdzLlhyyiEUnpjQz8y2dTkvUrdLlTS6EbVphF7qnqbQZKzbOKsQPHv4fGn7t
         yC2rGHMe6crAJjrKRIHL+Cf7XYiTEU2AA3QsmY3LcNMGZfOpnflPEaVwL42bGjVKG75e
         fmXlOPyeJw/rp6LQj3mi46DKVLMUIZZ9CtGqRjxFEuujsT2QXb7O5ut6scaglSF+wYV0
         MAWjlbh6KstFutP1AD0F+X9DXp74oHUrOgTpG+VCjic+rag6hpw4nkxA17BdLviGMhrI
         kw+B7MeTB5qDzuOlGEe2uLqLTpxCUwp0Ij63OfXKmvCPDqcGNq2HaBbzQTt7QusIo+f/
         iorA==
X-Gm-Message-State: AC+VfDxIPOOH1cBjnSzR36gAnuy/1p5IEy4ZLKheqzGMrQOvm21KVE7e
        dRYXFQZMI+f7u2Dkueqag4LViw==
X-Google-Smtp-Source: ACHHUZ6durEogDyWOruj0uja6YyUtEd+bw8P/5czqWQsSh8N78YTOQerfYFo4L6J5TKmEd7dsLzRXw==
X-Received: by 2002:a05:600c:383:b0:3f1:93c2:4df6 with SMTP id w3-20020a05600c038300b003f193c24df6mr14526564wmd.12.1683812222586;
        Thu, 11 May 2023 06:37:02 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f4b6bcbd8bsm4469844wmi.31.2023.05.11.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 06:37:02 -0700 (PDT)
Message-ID: <6abfd685-e2cc-ef0e-188a-4fb6c243ab81@baylibre.com>
Date:   Thu, 11 May 2023 15:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230511133226.913600-1-msp@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230511133226.913600-1-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 15:32, Markus Schneider-Pargmann wrote:
> The given operations are inverted for the wrong registers which makes
> multiple of the mt8365 hardware units unusable. In my setup at least usb
> did not work.
> 
> Fixed by swapping the operations with the inverted ones.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

