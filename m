Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6C5BE1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiITJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiITJVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:21:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA1642E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:21:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so3190604wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vNQe2GtbiEbNlyf2XnFRT7jFM6dqwBbNb6DV8g2UnnE=;
        b=D7/EMxpeYN6SPsHGRc8F2hFpJxBQAg/IykN2uBhVB9perr+IAjGrXbGSmKU7FZGEcO
         axEyuJbqExONBLYsx6gqpk8nor4dbJ5Ti755Ggse1oe+G53iFq99Y0guwdkNjN/zmOFN
         81N1UdkZ6lnTvQBhluQOHrVifo1i4K5CUZgfsKeh3Jg5bN+f47dBkYGvOANDUcXYMysM
         4xVlvnY+VXxFqG9UNzDTPalIUP3YyfsJFuqivvGP1scON1OmkCulgfhk57l3FzotXePv
         4mRsRBEyB1LOGPSqNOEDDpf4IS7qRQNTViuJrFvLqxxXzIh/KPvaQWNBrI5Mr6pKteim
         Fo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vNQe2GtbiEbNlyf2XnFRT7jFM6dqwBbNb6DV8g2UnnE=;
        b=q1Q2s4ZV0L+45mCOJikJVkLD9EUa8z2c2lY8OUbv7nH5RLo78kEanvM9cNqiL4VpGo
         5068lR5VpgCwObstzIT5091xQMj2AyPasVFt/8jHXB3Zbxdpcx/+pWnKYBn9rUM5j+mO
         k67ZmIR21VJibnEIMxgnHmFLJe5wOkChWdoGknThG/11rSYpGiOa1ri/PzxK4GZBkkSF
         Dp/EAUXr0eP2Lgo+dfvMGEE9dVwLjDelZbvj/tkXYrHPUEoTVlUFx6wCqjj5EluHhEGu
         LFzRaEvmAg8xt65PPXsKFferkRjIN9mlO3rAtthmFkNy32/DsWtU3B41eG1Vl9vnWbIB
         aJXw==
X-Gm-Message-State: ACrzQf07RxMX+nnku5v8FlAgyySpQHw/sblxZ1ISm4YG2vU4J+p4tnW3
        MX4pWIlUz+SqFl0/0bCN1uEINg==
X-Google-Smtp-Source: AMsMyM4gXAKw4BsWYZM4GahwvUJElzZY87R7sO9Q/AEA/+PDUm7seHM2obUaC4y0w0grBuuBguRA7g==
X-Received: by 2002:adf:d1ec:0:b0:228:d9ea:cbd2 with SMTP id g12-20020adfd1ec000000b00228d9eacbd2mr13347043wrd.609.1663665658829;
        Tue, 20 Sep 2022 02:20:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4cd1000000b0022a297950cesm1063507wrt.23.2022.09.20.02.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 02:20:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     cgel.zte@gmail.com, andrzej.hajda@intel.com
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, robert.foss@linaro.org,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more robust and safer
Date:   Tue, 20 Sep 2022 09:20:56 +0000
Message-Id: <166366564178.3256514.17123212725949451194.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919030401.211331-1-chi.minghao@zte.com.cn>
References: <20220919030401.211331-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Sep 2022 03:04:01 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> That's now the recommended way to copy NUL terminated strings.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more robust and safer
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=110ae8a21bbe779a133c1672a1463105c9d50590

-- 
Neil
