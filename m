Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50274D60A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGJMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGJMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:54:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E8E6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:54:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313f1085ac2so4227145f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688993685; x=1691585685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abv8RbjDLsB7qEHaf8MGMChzo7Az5wZJp4aotAIPofw=;
        b=b2IwCjppmUDIKW7ZIaF0KTVBe2UZDvxxN/b3hBOykv4/OjDBsrpSaTVMty/DwdZd2g
         d3IiIqQUVBoiIw5iq2qhak5rlUTZKp60BPw7nfrdTWzkeQndrdVBPqyje40q8Aty2vU5
         hHO1PV5Aui/ycRm4xA/lBcY5kJCvWU5VOwcEA1XjvzJhGvnJE5o7JxtA+JzppYUfBb5S
         5JnyngwQbPD0GF4/WltI+XBcw+55akHyWsyxPYuxVncUx15DQXHMJR7QGYEXDvv/aKIx
         jS2e01lA/HONXz+/9XytOyRNrPd8c+wa41F1g5TM37u+XOQLLksG/dfsyIkCA148DLNP
         NfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688993685; x=1691585685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abv8RbjDLsB7qEHaf8MGMChzo7Az5wZJp4aotAIPofw=;
        b=koyhb/j+xZbwiIgONWOhX9j7Mltd7c6A+DrlE4+vqowlbth7hp9SVPXeMCovrTsJ/e
         AkTm+4eWu/8sWHcKSwPapA7CCha/TldYxLeKB96TU+MCTJhXUzr7c3mpxt7gafCJmB4r
         JHAIvA5MvR+1Qec1YDtUsFf7k9FgYxabA+i0b1h9lCGn9XaQBiFWs1vYqwccsZsBIB25
         23IeuXigo+F7du+IbL7wbjVWdgWztnB74mg6xfB5ift6ybLiz35TgJnJmAvO6LmGXnCm
         ogsimIzH4gQriamYWV7yObEUeSiGn561ODX7IZl3vPIZe2CdnhEuXAZp0ehbvux+sRIz
         7oZA==
X-Gm-Message-State: ABy/qLbD9+ADTEFI894d1+XclUTSm/o4vwJgo/iAiq71KkvXESNjS0d7
        V33GSen85deLHeurnzENmgAtaA==
X-Google-Smtp-Source: APBJJlHCI4auE2IEOjXBCxZiOjauKMJU0L917s49nJJx2e4LjmSAQnLYSQYOsSTxBjhnt4Aw1NVolw==
X-Received: by 2002:adf:e34c:0:b0:314:3b17:d7c5 with SMTP id n12-20020adfe34c000000b003143b17d7c5mr12183853wrj.43.1688993684720;
        Mon, 10 Jul 2023 05:54:44 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b003142eb75724sm11636974wrx.24.2023.07.10.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:54:44 -0700 (PDT)
Message-ID: <fd1c1034-c54e-2e9d-0c9e-f62b0bcdc3cf@baylibre.com>
Date:   Mon, 10 Jul 2023 14:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/8] dt-bindings: power: Add MT8365 power domains
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20230627131040.3418538-1-msp@baylibre.com>
 <20230627131040.3418538-2-msp@baylibre.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230627131040.3418538-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2023 15:10, Markus Schneider-Pargmann wrote:
> Add power domains dt-bindings for MT8365.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
