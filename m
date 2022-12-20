Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D336523E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiLTPoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiLTPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:43:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBECF11A08
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:43:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so2501413lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XXm3ehVw7jrm3viWPruU6g1/o3468ZLAkGL+jb+KseA=;
        b=GAvP7CYjU5YZu9KfvJDtO2XdFcK02W9T75Ue1qWCbvvkHjJ4rSng7AFoc66apIkhJl
         qgHn4Ddi+HeYW9p9x/UNCCttqBUmLXPoDgvy+w8zXkSFFSDkEawh/4NPN9KZmF9pLjMl
         c165HgVhP9MJuTDxG/YdcMPm8RimvBpBWTy5Nz3Ou+BeRA/YblbkYUrLAkFUSLZnJtgM
         O/0w5jOKvAcEiDvfCT2icovrwe4aXNJJ6w8JFa2h//sjyOEkS984HaViQf1ML1S5KyG3
         xOyvM0K7gV8Q008PUE/qn5hioTCaPKJ6X9/hmj/eiVjyrQeugSFbVKnT+4lr44b6QSYc
         JiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXm3ehVw7jrm3viWPruU6g1/o3468ZLAkGL+jb+KseA=;
        b=IoS8fu6Il/+dVnv8yuuKOz35tnxpjP3b1d7hLg/dZ0ZtvsC0BzT/wIx+aYyuIKCdSs
         eh/0L8oJKH3jP8LxLduRCHCnbqyXwaq3GXmVmQEZunaOxbKThiBaYlL/UDS3ukWPHLCU
         MaFDEkLGf8hDVOn9YTlXNnc/FUiU26AFzNC2Bt4c8X3bFbLnQs7hD02m+UAEgFaHDh+h
         GL1tZWFYI35wZnMCuMq8XWZU3itLz0RV6V0LwAgDZXm4N0M4DAdaNEliqhVRO7Yzizlo
         XxMLb4C7NOF/lliymOiYtU4ocqABQjoyFClJTtNpdOPU9V0Dxbcnh2ccohkXZD+V+nB8
         ZHWg==
X-Gm-Message-State: ANoB5pkG57zanHpAqA3dfcWw8GkXnQrVf0sdj/V0MgDk7BSHKwIJIWsM
        2ucFBDiUuGygPVB7UcCS0B/vfB6L1WS7PMzDfZlA9A==
X-Google-Smtp-Source: AA0mqf7ctVcuo3+IQBmTOqNH1YV50lLyDFdhREJWuJeakjXTQIPAz7PpODRrU1Mu3AP68oqP7fRTqZmrFiuRyMVDZ0E=
X-Received: by 2002:a05:6512:a8c:b0:4b5:a843:58cf with SMTP id
 m12-20020a0565120a8c00b004b5a84358cfmr5381314lfu.531.1671551033206; Tue, 20
 Dec 2022 07:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20221219190915.3912384-1-dennis@sparkcharge.io>
 <20221219190915.3912384-3-dennis@sparkcharge.io> <a3414477-eb9b-83ee-ab11-b2b629b6d23b@linaro.org>
In-Reply-To: <a3414477-eb9b-83ee-ab11-b2b629b6d23b@linaro.org>
From:   Dennis Lambe <dennis@sparkcharge.io>
Date:   Tue, 20 Dec 2022 10:43:42 -0500
Message-ID: <CAKYiA1C7Gaw3XYYum2VUSxn=qiCzSJQ=KsSa1hx9c1MGGuv6Fw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: m41t80: add xtal load capacitance
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexander Bigga <ab@mycable.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 5:52 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > +  wakeup-source: true
>
> Why do you need it here? It's already accepted in rtc.yaml. Adding it is
> not explained in commit msg.

This shouldn't have been included in the patch, my mistake. In the
next revision of the patch series I'll take this line out. Sorry about
that, thanks for catching it.

Aside from that, does this patch look good to you? It passed
dt_binding_check and reflects my understanding of the logic needed,
but dt-binding yaml isn't something I'm super familiar with,
especially the if: not: properties: contains: enum block. The
intention is to indicate that the `quartz-load-femtofarads` property
is only applicable to the m41t82 and m41t83, but not the other devices
supported by the rtc-m41t80 driver.
-- 

Dennis Lambe (He/Him)
Lead Firmware Engineer
sparkcharge.io
