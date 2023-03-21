Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22A16C31F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCUMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCUMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA64D42E;
        Tue, 21 Mar 2023 05:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D7361B80;
        Tue, 21 Mar 2023 12:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123B6C433AC;
        Tue, 21 Mar 2023 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402557;
        bh=J20LlY5TbVnPM0z5FlTNCPp5ZAh4UVG6euTTWc5LkUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FdVixEWY/0QvALciIzaXMuyjtTuctDu5uQnZAkKUVwbR8UBXJtwUnyxQtT/p/30ic
         zpl55Nm+hUpZq5XJiO53LWzTvqQltae2LMbqInH9aGehkHNAgTJ164pX4YQxll3KMy
         TD2ug+AYx3+44yAUcXSFocaJgG/jig0Jy18j4H5xsbdoMjB9gU+8MwEJ0DkP5ks6eT
         KCLNhOoO34XSRvOPyEnyvii8NdivuEDpea1bCdkez29ZJqdilkcKgnBSN/Qfu6vbBe
         soG30ERWWcrojAZnMfrIwsqxFHO8VOzwjVm6uKlK0AbKWOD4M/k7pMnLwbWFhV/Dwd
         V04BWarn/LWkw==
Received: by mail-yb1-f176.google.com with SMTP id z83so16892638ybb.2;
        Tue, 21 Mar 2023 05:42:37 -0700 (PDT)
X-Gm-Message-State: AAQBX9eJgFzaDRWA/HkJoeYF2lRLHj0ex4B7hgaaPRfdZAOYUyvoqJes
        kVYWAKeEJJrMj9fRTSB3udSDF1XTBsnP2A9ybw==
X-Google-Smtp-Source: AKy350ZhCPEnnrwloI2VYkVonvOVRbKLguR0+fCqDHc7mDqtOx67pDwKgadHRUXyovXV1023X8BMqxVSAgSWqc8/Yn8=
X-Received: by 2002:a05:6902:150c:b0:b6c:f26c:e5b0 with SMTP id
 q12-20020a056902150c00b00b6cf26ce5b0mr1453538ybu.1.1679402556021; Tue, 21 Mar
 2023 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233904.2920197-1-robh@kernel.org> <ZBlTJbdAmh5H3PD0@kroah.com>
In-Reply-To: <ZBlTJbdAmh5H3PD0@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Mar 2023 07:42:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL9LYOpk88RCBJcsX5DnroOUdvXXtpwDPoabt3A1S7SVQ@mail.gmail.com>
Message-ID: <CAL_JsqL9LYOpk88RCBJcsX5DnroOUdvXXtpwDPoabt3A1S7SVQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: Drop unneeded quotes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 1:48=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 20, 2023 at 06:39:02PM -0500, Rob Herring wrote:
> > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > checking for this can be enabled in yamllint.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Or do you want me to take this through the USB tree?  if so, just let me
> know.

You can take it.

Rob
