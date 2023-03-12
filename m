Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D76B659E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCLLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCLLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:48:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B32D172
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:48:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n2so12253751lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678621717;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGGE51YjPiREb0P31xa6FciLF3LLNAYLO3pthF/8pcE=;
        b=UkollMpMPwObTqUsmqrO3GgJrdyrRXjmhq3J+C8f2QyrhahCLGTGOAOPrpctvFiBoB
         LnHTPwSZ/qBWvVN5djf0h/DdXRwOu3YRy2J43xPVIYkMd8t7wkm/8g+8NCcFdJP2ZrGQ
         a33jAwdrUZwm9BcFMFYQyBSSiE9rm+VqrZlrLyWEBdo7mIrnZoZYNlJA7MThz/G/gKlA
         2omTHiKyVYGIj2gFvNwWoZv6uGQQrM9/+j1L2S8SLutOe/p82JBy9zHpRA3wFfl4i50u
         fTgnNd5a50BBomS+cQjvMoI51ZmzJFtTbVPrfrdqC+RZcgfQunikOCtdQG0xYSXNB1EM
         mzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678621717;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGGE51YjPiREb0P31xa6FciLF3LLNAYLO3pthF/8pcE=;
        b=pScRxjOdUPA927J+xUZ0M2VNUTE2W2MKKDgIKfeyh3eqvt7CV1t1teHuiKcywMRM9d
         uRvxVcRslCDmW8UdASfpXQGb8hHYopxD2vVX2o7wEbYTma5pxhIduzr5tmKRPb9v6lFe
         gSppdHhZNV6PBeptuBXxYkjrEiF6l4ZMn6fsylCpNnyYl2aXlV8SVm0wkz4vxJhloiEP
         VzMfaSYZqZ9Bu5PN1D7kmj4aMDJ4QHcj3pokrMtKzvIkq2Pvak2Cvz18UHKehxM90Zvh
         Fq9ILeQXYeHCjRuHebQkpilFM2AmU5XeTPONvTc+F7U2VZONK0szmtEZKSrXhNhcJzM3
         0KIA==
X-Gm-Message-State: AO0yUKVmp3BmGa/TQ0FDXOd6hAmDI5v5U1MICtKUHsI6FJyPzok6re2X
        xD5xVE2hxtZ7SMCXBhj+C/SY9ttIiu/CTWBI
X-Google-Smtp-Source: AK7set+52MckCdJN0TZ/SRwTIsa+I9ZtxiLosdyrzdFVVwXYSrFM2GqLhJUcDygmJeho4UcQDmYZBw==
X-Received: by 2002:a19:f011:0:b0:4db:5122:2099 with SMTP id p17-20020a19f011000000b004db51222099mr9008889lfc.32.1678621716755;
        Sun, 12 Mar 2023 04:48:36 -0700 (PDT)
Received: from letter5.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id p19-20020ac246d3000000b004d8729d4150sm615617lfo.145.2023.03.12.04.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:48:36 -0700 (PDT)
Message-ID: <640dbc14.c20a0220.9755a.1615@mx.google.com>
Date:   Sun, 12 Mar 2023 04:48:36 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <951dec3a-1a3e-6d17-20fb-9e5915606c40@linaro.org>
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

> ... and should not be. It should come with a specific compatible
> followed by this fallback. The specific compatible then will define
> 32-bit access.

OK, I'll then make a new revision with this baked into a compatible
string.

