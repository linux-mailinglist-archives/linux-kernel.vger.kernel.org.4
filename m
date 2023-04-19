Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242E6E7A24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjDSM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDSM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:56:45 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C867CC1D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:56:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fa9da5e5bso299096297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681908991; x=1684500991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwUSUxrJ9n6AQrEeowk7hNCvh5UL4qrEBOKtDjo0eUw=;
        b=eCtJmeJit9+ac5bYw8F3QMfZkxb9T5aVO3o7IyVuLXE7HvXvXyKBk2jUvjMALcUBrl
         c8CbYgu4qJF0ToozMrzenOUHi8/PekCmWPWK/VxJRDPMlq6cSvawR843Z6SvJZJSvBB1
         j8nGqFTyagxSvC4sLdljQMaZZsGt7tMyCxLlTCYFb27yRlDZf0cUWaPG5rNThnjL3JL2
         P3ZG9C0uBFTJ7iG1vra9kkSVFSenl6d4wjfdHrml0Ozp28Krj78M682d3ZmIMoGlDf7s
         MKbjQtfyd8td2FPSxtn7L2stAaZTA3fPjSe4r/ExlgYEFBtNux6KGDJlVM5kckatzhPK
         XiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908991; x=1684500991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwUSUxrJ9n6AQrEeowk7hNCvh5UL4qrEBOKtDjo0eUw=;
        b=Eb0j20mjbSKXcCxrm5Hd7qnQZdCdt4qty6lUrw7dnxb/DGgMjZ7xT0jQp1/8wfQI2X
         LCWpsVdoehl/oO0WCW95bWpvatBo/1zqlxV0J7dTtSs5rJx+exxYfwDCsOTK6Hi46ia1
         zYw9xJOWV8IYgwIbbRamxbgZzzYO+DEAPfkn7IL80AmB97fX6qJ5Nm4iU3VhQUaipW4/
         P1sdZpPTLkOCq9w4VUwlKkGTnGiNvhaRnekQ0rIq3KNSg5nQtDTALhVjsSQXwc1CnLzA
         Sb1GR35EiGzUQ43tAv/vHrjNyvHF5j83i67k7p1/kUoxBRR3XqZMJNzo88dhIjhqrBNN
         5tOA==
X-Gm-Message-State: AAQBX9ck7yxzi3sKdMDY5fP8RM/LSwyKs0X4h4X3U0VFJxJDbzeIZHuv
        VBU0PI8xKwlaVxgi60oh0mmyVrJHg4CAx875TGUl7g==
X-Google-Smtp-Source: AKy350Z4UaAegtplyIiEokFL7xWoy1hMxn7vXuBKeJQgSawaU1dXY1LmmZCkq+l38q4nNogzRvWoZGg5JPpTTH4kL2o=
X-Received: by 2002:a0d:e68d:0:b0:555:d12a:b5fa with SMTP id
 p135-20020a0de68d000000b00555d12ab5famr1608061ywe.5.1681908991219; Wed, 19
 Apr 2023 05:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230417-ux500-sram-v1-0-5924988bb835@linaro.org>
 <20230417-ux500-sram-v1-2-5924988bb835@linaro.org> <20230418223800.GA2447581-robh@kernel.org>
In-Reply-To: <20230418223800.GA2447581-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Apr 2023 14:56:19 +0200
Message-ID: <CACRpkdaSeLOqZJ=W55AcidpF+CLbJCD9B3tpDnbiC+UTmAsZ+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] misc: sram: Generate unique names for subpools
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> On Mon, Apr 17, 2023 at 09:34:57AM +0200, Linus Walleij wrote:
> > The current code will, if we do not specify unique labels
> > for the SRAM subnodes, fail to register several nodes named
> > the same.
> >
> > Example:
> >
> > sram@40020000 {
> >   (...)
> >   sram@0 {
> >     (...)
> >   };
> >   sram@1000 {
> >     (...)
> >   };
> > };
> >
> > Since the child->name in both cases will be "sram" the
> > gen_pool_create() will fail because the name is not unique.
> > So let's use of_full_node_name() instead of child->name
> > so the name is "sram@0" and "sram@1000" respectively.
> >
> > However if there are two or more SRAMs on the system
> > with subnodes named the same (that exists on the U8500)
> > then this again will not work. So catenate the top node
> > name and the subnode full name to form a string that will
> > always be unique.
>
> Use the naming platform devices use which has the translated address.
> How the addresses are defined should not affect the device name.

Aha just dev_name(&pdev->dev) I'll try this, thanks!

Yours,
Linus Walleij
