Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51B86210BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKHMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiKHMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:31:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B334CE3E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:31:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt23so38142678ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sm+oC/YPWF/iZNcfGahmynT1lvQ6GZ85C3/IGkCpcBg=;
        b=uOF5AWIk4QTXqHhAviukr3WgFBbqJAthELAkouqC5SPAKtYa2dhvPvalBKk8aQIhOA
         C6QdxBUGCZD8XHA2Tcb+stvMx6RD+jEN1FXcMt8EUTde5Nqt/yPwiziVSrIl6FRzAKGw
         7WHs+gNB2Eo04TurLhyHF8DQsMsnUTszhbPTkNgxpNrM9TQLoVL2g/ipepIsbu42c8f/
         Ucsk2YPk64Le/SK6lOoCE7EwcTsmdJPRGngxdwSP/My16Inn864TipaOy4Gfu0AuQAB3
         PQn8l9hT4+yg8dGyptmbz+Gw0qSt+XZfk/9UDi4UyA1YUFJ8WhLyl+ztp8lueLoPPHRo
         dc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm+oC/YPWF/iZNcfGahmynT1lvQ6GZ85C3/IGkCpcBg=;
        b=PWmY8fU7WB3YjSY0oNrPN6e1xM9OIL/4Jxazaq/YscFd3k8fNUe0eLEty8JB5ceb5N
         gekJ/KfwJtNyL3DOYjD336oS3kQM9iAeNYMaqxDfyWVh5EIv5A2VTc73yYyRVu27eW4Q
         Rx2RP7yvVGqrMnCWc2gh2kv/OawAA7GbcuSqBDQB7Zqwh4Vkq91a7cLsQHrDH5C4KihZ
         yaKeEmppl27TCX7K5aCqd8ZsPXoJ+hCZdICS9878ROs5BRbbU9rrkZNXPfvLXLc8PIaJ
         T2Sjab6/WOxEZEf/VPIIko1IPKfwe/mSz7Hf0gdH7HhzbcrB82PmoWuC5ac6LboEIjq+
         8QSw==
X-Gm-Message-State: ANoB5pkRoCeTFIdknOwkJZWN6LsLGDQlKBrf3aAwW4IHdV0OzJGiFyiH
        Sa3afIsqfDzJvnV5uGVroDqtGxRA1mOXgdviMMfauOP3IK0=
X-Google-Smtp-Source: AA0mqf6mScTI8wfSGbpo+cE2WOMgktUG3GbfO4kwbhqKSf/NX3F8x3YQuNjKwU0wd/caXHpjY3fm9Kvzkc0l9DucqnE=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr10953313ejs.190.1667910688158; Tue, 08
 Nov 2022 04:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20221031100843.14579-1-clin@suse.com> <20221031100843.14579-2-clin@suse.com>
In-Reply-To: <20221031100843.14579-2-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:31:16 +0100
Message-ID: <CACRpkdY-uaQ--vFM+vVPbwa-q9nbSU0rQB+qbL=9m0wVMwA3Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

thanks for your patch!

On Mon, Oct 31, 2022 at 11:09 AM Chester Lin <clin@suse.com> wrote:

> Add DT schema for the pinctrl driver of NXP S32 SoC family.
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
(...)
> +  nxp,pins:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      A list of [start, end] pin ID boundaries that correspond to each of
> +      the register regions reserved.

That's an interesting approach.

But what about just hardcoding this into the driver instead?

If you have the compatible, surely you know these indexes from
that compatible string?

Yours,
Linus Walleij
