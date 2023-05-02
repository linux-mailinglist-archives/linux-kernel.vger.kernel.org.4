Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0526F4506
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjEBNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:32:23 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2359F6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:32:22 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a2691637bso35831887b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683034341; x=1685626341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEifqtnMTrtcoeS67itQipSer+2n7onRwiAW4RhQHdI=;
        b=wZJQ5UzpljXf1eCbyFM0D2ZaH1xQ8kbvUGpcpL6GcMG3qtFuDqoW/LvxNboGiQdM8T
         4MnIXumfRl+OFqwXami9J1nXLF3WfVT1gK11GFDaozf9R17vHwoOnZL4K658cyy+jpea
         0qweCFZJ+TqF8X6JDlhXd72Zv1Ei4aR6XzQ9AOWJ39jvkMrJewf0yBDskzPVHBeXWtYy
         PULRPuO2cbY/j2XYCq6Cve1UymBjiTFLffJw5wQSpzTYF/84sLygf+4kTV5iQu4KUsjR
         56zblnSYy6l4IT9XM9BS/ilGlvFMa+ihiCDFjn0Ifheh6eGALnIKICOy7/7pVFJ3Aj8Q
         ivrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683034341; x=1685626341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEifqtnMTrtcoeS67itQipSer+2n7onRwiAW4RhQHdI=;
        b=dCspRO8TiWyOBJfGorezoEsDWlPegs3SdkgYaXwkAUnKsTLSsb7YTxec9iASFdUIzP
         73ViB4QhoucJzYBLy8NKBilLyXNIyj26CeQfRzKeWBIqYRCQdqXDHrVRfAur5iYFcWdN
         Bhv+meKSSIzE/iL+Rh3Gr3Bpb9anP3z6vH1Y555jqpEFudUtAZfx+ti8MhaquMYykymr
         a+A4pbjjRZxFpDauhAzNvazjdf+sbu0ERjfyH2yr0d7U/8iKSDzFN6C56l9s/QtJP6JB
         SAhpOqoMFjGk3UjzJpwRDJvfPHMJbf7vhF4j0z+Ru4bqyAjh/IxH8lwgn15GusuoxrFb
         +qvQ==
X-Gm-Message-State: AC+VfDwWK3bfxGokOjkVGCJEreL1TNXtJbF8oD1vEXS48HtKdUkGSs8V
        LYTOZgpoyx6FaRf3dgbhVb7P0Mi4cLfdnb5P+6m8oQ==
X-Google-Smtp-Source: ACHHUZ5V95M8/JRQGpHNWzkNrRd5TqNUB/QD8i5EdVCh4hUbkIclbxYwsU9teNdG0BaYnENSu5IrlG27Ezbscnc3EqI=
X-Received: by 2002:a25:f405:0:b0:b9e:2f81:d525 with SMTP id
 q5-20020a25f405000000b00b9e2f81d525mr5015978ybd.14.1683034341558; Tue, 02 May
 2023 06:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230501230517.4491-1-okan.sahin@analog.com> <20230501230517.4491-2-okan.sahin@analog.com>
In-Reply-To: <20230501230517.4491-2-okan.sahin@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 May 2023 15:32:09 +0200
Message-ID: <CACRpkdbcyne7ssRQSEocoe+mj9qQBZRQ-wyOU+uipvcyF5NoBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 1:05=E2=80=AFAM Okan Sahin <okan.sahin@analog.com> w=
rote:

> Add ADI DS4520 devicetree document.
>
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

Looks reasonable.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
