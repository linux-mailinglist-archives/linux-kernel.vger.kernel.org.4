Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82DD6E8B46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjDTHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjDTHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:21:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9073ABD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:21:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-555e170df98so28584857b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681975299; x=1684567299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLbT5hVhYcV02p3hHaLqxtmtmMCjvhRv1rYkWERXbeU=;
        b=QTGK+dypK6k2S08JVTdVcQRTWk6/eAHMseMqP91CuXmixFJWePFEeMJTR1JKJl3tJ6
         Xaas7YsA+R/QNyA4Au7Y8APlHjS6HsFTAHr6FHEWnnNzWQKFg08OU/v49w+DjubKMxq/
         aQRVPhrmsASYTDubT11E6/dIq2FMLNHZmdCrAJr3wvIFPemb5VSgBtkDhEWPk/Vlp6Eq
         6un9yjjDJB3ST83t8czmvJy5WrMFspT816Hg8d7nUv8sZV8FU32xaoGsE5LdLcgioPoe
         ICmLHfEXxdmuOzbDAElK0PewT0pLo39klytZTkbOJo1nU6XDeihrs+UJeuRG4B+y1Ia5
         vlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975299; x=1684567299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLbT5hVhYcV02p3hHaLqxtmtmMCjvhRv1rYkWERXbeU=;
        b=V662a2KfY4Dx8EsiA5iIPckawDmHbi9+KDAuqv8oxHPNH8H6guuN75Fe5DmX3vd5zS
         k28BcG6NVsPL7064jjPicF9M5ahXZ8l2O9Dr5oRRyIeksCoIOnaNGvGSjaH1IEWq3Sfr
         r0+ZNfO60fTNTaYGS4BqOjx4JHGp7NUq07KHhw5FoSpzI1vYZ1WREfOeSLwoBYDFQ1vE
         LwaLIj5ZNTtRJsMC2jjkaNHhRH46vjRzBDol48a01sgtDkFZauRyOTIxbRp5TpZclJgn
         Yxe0JGwuX3H0EiOJM/EVJT6utg1+siySO40x9Xs3CqRBaRdZgo6nnnGicYquX2UcTFzX
         k+Ig==
X-Gm-Message-State: AAQBX9cooffo5PXjGb4I8gXCbkh7DDqhTPxcdTAXOywkzeE+IRNwSh0S
        jzjKehSlVwN3Hoyda56WlfSyILmdTT4CZfttmQ2X5Q==
X-Google-Smtp-Source: AKy350blgwHrEXE1ikzHbGGCBYjw9RVxglmRRKRDHlD7rvl6NARuY+TiiVgY2n0UW18b27VzRbT9IE9XH88uAfbAHfc=
X-Received: by 2002:a81:4f89:0:b0:54f:9b17:c7db with SMTP id
 d131-20020a814f89000000b0054f9b17c7dbmr160494ywb.10.1681975298893; Thu, 20
 Apr 2023 00:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230416131632.31673-1-aweber.kernel@gmail.com> <20230416131632.31673-2-aweber.kernel@gmail.com>
In-Reply-To: <20230416131632.31673-2-aweber.kernel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Apr 2023 09:21:27 +0200
Message-ID: <CACRpkdYhPSK40QOcsMry8yvKy_iP7cyX-=sHOw-N50N+q1qqrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

thanks for your patch!

On Sun, Apr 16, 2023 at 3:16=E2=80=AFPM Artur Weber <aweber.kernel@gmail.co=
m> wrote:

> Add bindings for the S6D7AA0 LCD panel controller, including the
> S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
> of tablets.
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
(...)

> +  reset-gpios: true
(...)
> +            reset-gpios =3D <&gpf0 4 GPIO_ACTIVE_LOW>;

Since reset-gpios is always active low, add a description: to reset-gpios
saying that it should nominally be tagged GPIO_ACTIVE_LOW.

Yours.
Linus Walleij
