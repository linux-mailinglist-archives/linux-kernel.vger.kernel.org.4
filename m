Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397B06294B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiKOJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiKOJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:46:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4D22511
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:45:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so23566458lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ip+ISJDAcRTM2ug+Duw+wqq2o/8yZP4Icjagift55aA=;
        b=RGMas0JKwW6JdI5Hdx3B6SyrvA9IiiTRGXDFwvCHO2N60721dGjkxyB5FcI/mOIO/C
         W8wNpqQnPmReKfhyN8ITZMFjIB13qAElu1DfcQN+vKxbPScL8TmvxvOmUMFDoSi3fhE/
         DOuvujOpPuXmaSJ1uH6dGIGS2cVRvVT++5PplZRhpQxS0voVHLXUTqCia9FKSxR5Go7S
         EWCT872gHmXqYVGILlpLpPU4ZJq+0sywRRB846zl/m/g7H/fmR3Xnd2GYxdwCDfx02vn
         Iv3EVERSxk9AE/kOtI0c2+KbO7O+HZ5ia7jb4VJQHuSiP0gbJWUIsIAig2i2Q6beMQ5a
         urqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ip+ISJDAcRTM2ug+Duw+wqq2o/8yZP4Icjagift55aA=;
        b=BbPnLRw3V953HyC+7VOFwZW0inZpLXuF+eTJBsMnxgWz0Brmg2QxjDl7MyLqNDwrgN
         sm0RAmnNj4R/7c5MhQvP8UB82qdCd9gtGXtTp0/bDBjpHkJENiN7EMsvEFS5O1rEpcgj
         zCVim13LcNxvZUp9tofCU0QWKGJ549olea9w49obFXRVF2I7xTSc8SC1THgWkyly7iFf
         v1ssZPPChFWR6J7+jhpv6KvQt7u2ZRrfXvumjC+Av7fzOLUMMBZMwT4AN5qRbqu12fR9
         KK9yU+Ql9fSI4cGh+4QQfSD5Ixk+vuS8Ib9siU+IgLD8ErPG6pjSjr1XaNDM7/LD6cl5
         hY3Q==
X-Gm-Message-State: ANoB5pkvKnhNSTTeX7BXBi2YIDeLe+9NR6z9Hpj3dshCXf6N3UiiYcq0
        L9+Bqfn8TzvhaxiX3A0sm2DpDQ==
X-Google-Smtp-Source: AA0mqf6Zxkah72gQYNvUKzWMofrokvA0XwHdVi/kGdatNa7PbNXD1xN+922wNh/4l5cZQUa848QSxg==
X-Received: by 2002:a19:5056:0:b0:4b2:2cff:8446 with SMTP id z22-20020a195056000000b004b22cff8446mr5444661lfj.572.1668505556802;
        Tue, 15 Nov 2022 01:45:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a19-20020a2eb553000000b002776eb5b1cesm2441776ljn.8.2022.11.15.01.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:45:56 -0800 (PST)
Message-ID: <cbed5f5f-f372-b9ba-5208-62b50c61464f@linaro.org>
Date:   Tue, 15 Nov 2022 10:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/15] dt-bindings: mfd: syscon: Add mt8365-syscfg
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-10-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-10-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

I am not going to review this - please go through comments you received.

Best regards,
Krzysztof

