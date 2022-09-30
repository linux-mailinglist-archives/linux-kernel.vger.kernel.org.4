Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E175F020D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiI3BAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3BAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:00:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAE659D8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:00:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso4149960wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1klmxQyoQ7Z1f314Zja9Sjgy0tmjH/XaiV3zDVIoQHs=;
        b=XI8KYj5dLJxFAFofaYW+xRpEpAj1ujGNYAnpGzsuJvtIkAr1syLezosVDhz5btD647
         zZc5tOX0k8Jg7k8afD2AkKjnsIG6gzq1VKg0+LhJ7JvoGIy5i2tCvaqUPl9IgYnKZ3CT
         7sZ/SQpQgRp5VX3fWPXgLKLSCz4iiGfarvhCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1klmxQyoQ7Z1f314Zja9Sjgy0tmjH/XaiV3zDVIoQHs=;
        b=HQSTNjIAgkDOjp6tNW6cmvaI7K+VAWUoO0NhgUR5tyFxwNFfdO2fVeutvh+k5GQ2Q4
         IEkrsoXCzkXOta41QpLyBAeSN5BJcobxNkgDdPo6QupvSzvFMrmwE60YJPazwAUQy0bj
         gQ4adkselPTBCVIEy6GcMcIwjniC7mSmuL+F96HCPClXGhWnrshgKo8lmtxjIte5ph/b
         te22UkQ0a5Kta01zBX+hT7n4zURxhleghgil8+zimoJ6xuxV3p0r3gW2Vl71eDfgRMcg
         NXtaKljuAAW6p3JO3yp1L5dN8631fW9KZG9N4IUI19JtZxJARBLdZB+LzNtjNo7ZQsQG
         UxbA==
X-Gm-Message-State: ACrzQf3/2PYEOThs26JB/tilSa7yLOD/tsVeHn90WoPyPj/d9qJSSgJa
        KalY8tjU/6nypzY78/AhsSWcxYBl+ovntZ+why9IKiQZB1Y=
X-Google-Smtp-Source: AMsMyM5+D4vYBTiZRj3AeTP3eULEdBa2tV7LoM0nIs2FbKPY+i88lmhjzh3pEwk9C6Ol08Ph9ABn68uCh0tZX33QrKo=
X-Received: by 2002:a05:600c:1d11:b0:3b4:7644:b788 with SMTP id
 l17-20020a05600c1d1100b003b47644b788mr4419138wms.114.1664499628756; Thu, 29
 Sep 2022 18:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220915003222.1296421-1-jwerner@chromium.org> <20220915134407.GA1168889-robh@kernel.org>
In-Reply-To: <20220915134407.GA1168889-robh@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 29 Sep 2022 18:00:17 -0700
Message-ID: <CAODwPW8=+a0oKeqeFz-Nf-RX2gir1=0Y8B-PvufSYM+_T_ZUvQ@mail.gmail.com>
Subject: Re: [PATCH 1/4 v4] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jian-Jia Su <jjsu@google.com>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Just wanted to quickly check on the status of this patch series, are
you good to take this or do you need anything more from me / is
anything still contentious? Do you want me to send a v5 with Rob's
Acked-by/Reviewed-by tags (apologies for not gathering those up
earlier)?
