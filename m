Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0665B91A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIOAc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIOAcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:32:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3886FD5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so28305982wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dz9tsS8elxq9og28IGklCelOy9Sisb8W1F/oNIjLxiU=;
        b=moEu0i/uygSuFbV5JmZEZCbwvk/x73oFHEgFjcXP1AmwWH78x9Opaba5lssZxvZFR5
         PpsPlaZlQMiEB7FcHQKWDMJMzbiHOfcncFNTGyUCpyNYqolIDwtqry1BiTNeaFdpBsae
         KnnRDBmguHyjwLotQ/avNo0U827Gu2sEhJXPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dz9tsS8elxq9og28IGklCelOy9Sisb8W1F/oNIjLxiU=;
        b=3UPW8aQs/W+fGffXU3F4EmavjxRn5Irdvioh8aXd13pBcklYs88uX/mPyoXbxtnSg9
         Tit+mFYLC/klt++FHV3CSiYSNeqlQyTK2z3FG8/wqZ79BnkbnD7j0LiZj/XAZfgtOiqE
         msMGpo/qamLkKthN/IxbIi4S8huYibozxWBDaM7BAXq1SyFhY1JgXxi6BhstqSicOa12
         3fBk4EKfYnzPWprbIv2RMQn/Mfn88Uw8ACtUT4olUYgkjrxM1sbYS3N2YEnRjFuR7IZD
         glJvlPeHFUxji8EqHrOni1hG0JI7EMOm0ZlXkYJTygYD+PJ4J378LyueiFoKRgJXQOZO
         NCVw==
X-Gm-Message-State: ACgBeo0oA04rX1w+68hjl7YeEX59yMvqLqM8g0qNvPJZRcvEBVJ5xuF5
        p3cpMaSkjlGI0m4jJxLH/qjxmAqrPlvFmh4+Qv/8CQ==
X-Google-Smtp-Source: AA6agR7M6Li7cQBAC6bsau3oKtIKLxv2MCvX0mNjXym64NEQFpVtE5Zspd/g1zAuiKcQymRsq7KQ0UZ7/4qmScb2wqk=
X-Received: by 2002:a05:6000:11d0:b0:228:8d5d:f2e9 with SMTP id
 i16-20020a05600011d000b002288d5df2e9mr22856534wrx.207.1663201942792; Wed, 14
 Sep 2022 17:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220909232139.645945-1-jwerner@chromium.org> <20220913143024.GA3620595-robh@kernel.org>
In-Reply-To: <20220913143024.GA3620595-robh@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 14 Sep 2022 17:32:10 -0700
Message-ID: <CAODwPW8a7gkuTFQUUO_XUH_nez2V49vnTtqx-ahT-Mio5mhzzg@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I only see patch 3. Please only send complete series.

Sorry, I thought it would be enough to just respin the one patch that
changed. Resending everything as v4 now.
