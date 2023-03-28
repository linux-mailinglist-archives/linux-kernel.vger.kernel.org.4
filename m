Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF76CC9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjC1R7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC1R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:59:09 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DAEEC78
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:59:00 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544787916d9so244420427b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680026340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iCOvJgCRVS4iOzBwVNjZMAZpoPWvfTpuT2EPiIysIw=;
        b=Ch0LQwXMp6+HwADzQ0NyJIAzXIVM0pylhCRxEWpJYjJwkvYRNIhx5XKxJRBwplWCRU
         IIqZ8usKRRmvYYH+OUDZF0pn54PJpweLG5zaHaa/2NtfeBzbKHjsMwZGQD7MSv7pMRIp
         FPgNABLopYdKEfj/eFjrl0iUcaP8lxrzEk/qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iCOvJgCRVS4iOzBwVNjZMAZpoPWvfTpuT2EPiIysIw=;
        b=Xrx64/zSsS/QISjry+8SKiAHhjEanVjoCkmmi0qNNYYMaWkboTqW8+EheQCJYmsEHT
         Y/ct1fWUBjfZYUwO4aWZg89NZZaJRtod/MAc0gzGPVfA/eoB/AMsWysHfs7UGCTvWnOV
         OE6NI3HIEVJD8+MJv5CoWAG5P8wpoIWRsRrb1UYzJcIfe/OSskmZGl8b/1zrtfa+65qO
         0a315ll4xnZwU+XiXlRbpwsrCG98OIrthow9yJWdBgntozB6k1M3YX3GiMs3w1Iv8H5x
         JboLQJuLLrjRlavr1UnVw156Jl1sKTokM860EAn8nN/nfeZR1Dy4+EipbqaJv52K4MtO
         20rA==
X-Gm-Message-State: AAQBX9fdJ6pYR5kaJKZJCEhH2pGKbTivUMMYR+CkQbz8+/QjpEzzvqsI
        l5wl8slYjRa2TU9fiT7rXl6IaDSbEyX7Ahxf0R5I/Q==
X-Google-Smtp-Source: AKy350aHWwgQPBqpJInSBfeAdf479+XA9a6tNgHYvVa5TMgjAFjuSiry7nERAIRBJfEqPmVlwGR+2cS8y4t/5dYPOs8=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr7950759ywj.0.1680026339915; Tue, 28 Mar
 2023 10:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230325074022.9818-1-cnsztl@gmail.com> <20230325074022.9818-2-cnsztl@gmail.com>
In-Reply-To: <20230325074022.9818-2-cnsztl@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 28 Mar 2023 23:28:48 +0530
Message-ID: <CAMty3ZCvzD8hOsHfMvzMsoj10kXuMitF_Par4v3fxDov7crjTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 1:10=E2=80=AFPM Tianling Shen <cnsztl@gmail.com> wr=
ote:
>
> Add devicetree binding documentation for the FriendlyARM NanoPi R2C.
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
