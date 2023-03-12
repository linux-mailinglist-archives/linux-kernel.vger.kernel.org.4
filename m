Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF26B656A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCLL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCLL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:27:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421B52924
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f18so12280838lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678620405;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEmUoydFZk8zGB/4kLGG/3XvXToT0AP+al834P9gqxo=;
        b=E4ooxJZv5i2m+uhuQeMVkfMmCnYvv5Gsek4kk60rike1uz26Y61h3biiYEdPAGMxut
         PRv5mNV2ou76/7QCJhu6GDwOTEuAL6W5tnAwVxwUa/eEtqCw57aU4gvZAx/lggtFId3r
         V8udv0e8aNsB6dFXJrBfA8Vvb8lL8wPCw2RNy3HqBoa7M3ScmH6YWzaXP4HD8zQTVuDh
         zwZI/ZRpxyhNVJszN/g/3Kf8LsS/KmUkc5FlC5lIGjSsgu2cB5AKSMOjxV6fatGyjL/f
         Q2myWPYfZS6TMWeBBHA08CwFJ8EXyP5ecMpnDVZj1vIwIqxSj9iHkyGnjN3ro2b2tSR6
         pt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620405;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEmUoydFZk8zGB/4kLGG/3XvXToT0AP+al834P9gqxo=;
        b=5B7GT8/FH2S2+1bsyjclljwHQT1kUFYKB9aK9OLb8lF282lm7IxwdmEz+iCp2bdQEK
         yABR5JnEUheVAZi45rr+Ci2guP1UD2r7Ugufxc7aWrXhSDD+T7SMz3WkqtYDqp7rv70g
         L9+u8P25gIEVHch23QJYumBklRLZBW3GZlB4bleMX2A0/m9AJ8BJDn4zYQ3VkC5qzPPd
         4orV9QQWpod/xaUK+mawFVRmv90ARAaMWGFxu98xXzlN5M6jZ6v3yo9ftMYiEpF4F7pG
         8PP7CDKwgFBkoijxVimPbHsPA9rT49nsNL0CqXUjNSVKHs8aicH1pj0qqBrg09sH5C1J
         v/XQ==
X-Gm-Message-State: AO0yUKW3xyErFwzMFBMtrdPFjNWd1+9FQKHPmyg6UaTg9yvtkBJ0Tkow
        aId+pNMM8AUc1e/azKW0DhOWGyQ/ufeg/cWO
X-Google-Smtp-Source: AK7set/tyX+YWE6Sg6xa9QRPNe1HDABxFrSjr8PXgm/GjQXzQDI79arHcB1HnNEf5u9lMKGHcZta0A==
X-Received: by 2002:a05:6512:21cc:b0:4dd:749b:2d5e with SMTP id d12-20020a05651221cc00b004dd749b2d5emr8171768lft.13.1678620405049;
        Sun, 12 Mar 2023 04:26:45 -0700 (PDT)
Received: from letter4.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id w1-20020ac25981000000b004e1b880ba20sm619802lfn.292.2023.03.12.04.26.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:26:44 -0700 (PDT)
Message-ID: <640db6f4.c20a0220.3a82d.1661@mx.google.com>
Date:   Sun, 12 Mar 2023 04:26:44 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <98f28de3-20b6-dd57-0c95-69c31f8bb76c@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no way this is board specific. This is SoC specific. I
> mentioned it last time.

The same compatible string ("samsung,exynos7-dw-mshc{,-smu}") is used by
several devices on different Exynos SoCs. And I was only able to find
a vendor kernel fork for one of them (exynos7885-jackpotlte, it has the
workaround, but it depends on a configuration option and I don't have the
config file for that device).

