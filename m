Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B867C887
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjAZK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbjAZKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4113400D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so807688wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/94PqYgPHWGOImoRxKRiH4IHfRW9uDk/cP1RssrHas=;
        b=QqaV9TZnxaSBVJiBvHJYig4lzjj9eQti0DYO66mfDCkITk8dGQ/VoZ60LhhLyJPjRp
         gqd35uzsA/5tH4OuBHK0iqegrbCIHUc9atnyMOomgMGHEPKfyHWUDpAl6W3HHYMM4LFH
         nUPmHcHH213wJAWdYtdBAnsmwGmCqaO7UDAIGOGUsk8v4FsR0tW2l12txpS9Ehma0j94
         6rlRfbAYpp36OyNQSAaPfOi82VJL16VsnSnFdZNw+IiptmTMlsTEg0/Q4VqmumudcT32
         k/jG2AtazCqWbUNA8DNGpFPUIB7rgn9VLohJk6hbjTfM2WSSCYYq29LlHiJW92F3o0uu
         yqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/94PqYgPHWGOImoRxKRiH4IHfRW9uDk/cP1RssrHas=;
        b=dNJ4c0aFAGQun1L0ZWKmm5c+zj3mOrObqtv4KP51FO0vWltRnCkRqpDoMgYDsrsK1f
         Byb8FVLFd6/G2lJidapaqM/CxSgrel0FD8NHxWufcjCq2O/0PeUrTSmmS/NOUu41Rwaf
         xiD2ldZNHz0LzD4MhRIea+57lCkHS5DMoUGK721tAPpL4nJ6+nSbCD9U+jyb5qelwlwy
         he+zLo9MjvT6S78opMI1ifzxNF9Ng0FCin96Navqe+UPbw/vqTBFJhjRm0ZLXCCmAuuj
         2n9cBGDmK9U9Jpu/g/mqoVQKWuQllQZbVqHVgmo8sI8DZU8C62q+z4hMX6CswzPF/D2J
         C3LQ==
X-Gm-Message-State: AO0yUKVHsU/UNVPHg90Ud8nNTg4lIJd6Myi8rageqYmJwlQjWvwUtHTy
        Zon2RIiw4KNBEMoIuXScw8geN58rYIBbN2zK
X-Google-Smtp-Source: AK7set9dKYqi9MWEV0YyErYOSyX2VYkqnLwcd43TsDub8iLQcXKb4BrQUoOeyle/MMBmtswwVrBVJg==
X-Received: by 2002:adf:dd12:0:b0:2bf:afdf:13db with SMTP id a18-20020adfdd12000000b002bfafdf13dbmr8046113wrm.47.1674728746829;
        Thu, 26 Jan 2023 02:25:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: dm814x: align UART node name with bindings
Date:   Thu, 26 Jan 2023 11:25:31 +0100
Message-Id: <167472873010.13092.11648343089928485949.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151536.369623-1-krzysztof.kozlowski@linaro.org>
References: <20230123151536.369623-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:36 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: dm814x: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/0f36161a9a140b1d30bf0935e4166fcbf8c8b847

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
