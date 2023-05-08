Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEE6FA2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjEHJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjEHJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB822710
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96652cb7673so156579466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536411; x=1686128411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR81nPwaCr4C10BV8ivo+db03YSPv3Ny6SRcD/Mlixw=;
        b=Q+F/Dj3K+/ZVUA5DlV9QlWKHBULqtu8TyuC+BoojM1SaKqLKmGAIciMexdS/293rz3
         +sWgaxsYcHN+6+triNC3jKb1i+rBX5cR9aa5E6HYP0M/05p6CNoeYXyhLt3lJCjbXZwZ
         s0ijrGKqF5AQJauBuI3lTvN2b1RlQSs7G7gWPbcB2Q/AdeS2SATPfzNYIU7ABkMesPm3
         W/qiqvpIm30ud/MA4H55nUb+/m2J3DBwo4p7dxTj+58EoXQjt53mEDJbh654gcFD9Y/i
         RKqzvYrzropnaBEzU8PwvAYKFaKIyTiUMIjcIkg3yOh5M1NEL8sWh2DtER5PWaK49hKV
         G6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536411; x=1686128411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR81nPwaCr4C10BV8ivo+db03YSPv3Ny6SRcD/Mlixw=;
        b=DSkdMhNaFtTP/Za5y9Il3pN4mYlM47OlICZUfoqq4lWgj2kYARVi/c3HzhGpwGKVc8
         Ex+KMagxHIcRbQq7pWP2wtcwxHOaWniNluJzz7/7Yduf35mIVAQNG8aPKlLKJwpLPsWX
         pSRjtcsp41z+pAeGkYlJ1k4JmMWQm8BPdm98IizLBBwxkEonGRAVDKxLc06nl812EmwW
         IzV8omoMjxgM+GA8ue5lAfIzgL+kfzHfGk/6JFeezT/Y0gS0Hc856FCAZQiTzi5vskqR
         obSnHDW6tJqhuxzeDhbUp91FtjfUi/FBZ4pgXAXyXOdZrBIEn1YKPvrDYsSEm+GgO0VB
         pkkQ==
X-Gm-Message-State: AC+VfDwX7dk/5xr9Z1+m6K6udwfpq4bsn7B6qXcCJU+7MXmieOBuazOn
        nzZukSWmMHV3jV7CJcMy/MSuqg==
X-Google-Smtp-Source: ACHHUZ68X9LAY/RyqtWwE2o3s/Nyql8JK+cmll6xeUUZlU8WbLwA/5wMqXXGESkmShmvR1r+xsN6lw==
X-Received: by 2002:a17:907:9347:b0:933:3814:e0f4 with SMTP id bv7-20020a170907934700b009333814e0f4mr8745661ejc.16.1683536411592;
        Mon, 08 May 2023 02:00:11 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zbr@ioremap.net, Lizhe <sensor1010@163.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] w1/w1.c : Remove driver match function
Date:   Mon,  8 May 2023 10:59:44 +0200
Message-Id: <168353638584.78189.8714033036687552091.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319044107.311555-1-sensor1010@163.com>
References: <20230319044107.311555-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Mar 2023 12:41:07 +0800, Lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().
> 
> Drop the bus's match function that always returned 1 and so
> implements the same behaviour as when there is no match function
> 
> 
> [...]

Applied, thanks!

[1/1] w1/w1.c : Remove driver match function
      https://git.kernel.org/krzk/linux-w1/c/388f22fe5d91d707352b4b743368b30e21d9d9bf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
