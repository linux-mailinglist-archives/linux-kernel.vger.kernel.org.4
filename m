Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64772C97E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbjFLPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjFLPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:14:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1398
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:14:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4261038f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686582853; x=1689174853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8WbS+210v8G03MzlGBuYK+XYEf8w/Cdebf/Mx2BbmI=;
        b=m1eCYswoFitwiw/jC74aoHUgHdkLz6mbrnkX5SA82V64dxCm7BmGQd2HhJr/jC7DY0
         7d0vGR1/Cua2Zy7Z5+8tvkNe+SXx8U82lmIluvIL/KkcWHYz0dobk6YChryomcFLFfDT
         is8wf/izE7S2xTRmdMkjzbawkofOH4oBE87MfEk/kE5FLyc2YYOR1rK4Ntaw4rgSflEf
         zhn/4R14+FMCUFvp782EBuh3ADZb/AetyWDOkFymYbvKFXmlhouZHZWeqbxngSWYfR2x
         AIIQCQzXfdH8BO2RDV9ElQskiaIlaLEiZCqV31tVbXKvqpp5jxUTvSQ4/vrj+UTquRPq
         1lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582853; x=1689174853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8WbS+210v8G03MzlGBuYK+XYEf8w/Cdebf/Mx2BbmI=;
        b=PY17bIMHtngW0HMBm7A/6L/ZxuhhTX+rVygo3v2Vy9unMXk+Whvz1wY6UXRKt/DeWm
         jbXnhbIEAtP5gCgm30IgRbDxQ4WsKOdh4u7WkO50TijqPDM0gW1HFi12Hp2WjCMyd0BC
         w137o4FuLZoaUZNV5n8BP3fWpkG8waNbWAV9GpmlRv4V/yD0vPEFqiFD0yZRb3KK8luq
         wpxMTc/lBGJCGDhjfy8lX6fTbbHqpnlYrhOcSrwQqFqGg7zPHh/hWF/6A1dwxxbZbn9/
         RzJMoeqW11LKs9uSxnBLrx/OgrQQyIgCCIX5J1RvZcNtCcysnfwOA56BoXqNNb7TjBdH
         Xjcw==
X-Gm-Message-State: AC+VfDxzA8xHU6T4MofA5pbum+1DM1lblnA95/JacGpNcvg7YGFunx7v
        yeURKbGTyBzBIHXjTT1ca031lA==
X-Google-Smtp-Source: ACHHUZ54oAZ2IUMxfcuwC37kmRwW619wSTurCxwqhDgsKHn5pPBTUewLaBTWzt9RSMKl1t2Euf4QkA==
X-Received: by 2002:a5d:490f:0:b0:307:9194:9a94 with SMTP id x15-20020a5d490f000000b0030791949a94mr4439660wrq.17.1686582853157;
        Mon, 12 Jun 2023 08:14:13 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id t12-20020adfeb8c000000b0030ae6432504sm12787964wrn.38.2023.06.12.08.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:14:12 -0700 (PDT)
Message-ID: <7bb5a15a-d4a1-21ed-5fed-9f5269c1926b@baylibre.com>
Date:   Mon, 12 Jun 2023 17:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] clk: mediatek: mt8365: Fix index issue
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
References: <20230517-fix-clk-index-v3-1-be4df46065c4@baylibre.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230517-fix-clk-index-v3-1-be4df46065c4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Gentle reminder ping for this patch which fix a regression introduced in 
the v6.4-rc1.

-- 
Regards,
Alexandre

