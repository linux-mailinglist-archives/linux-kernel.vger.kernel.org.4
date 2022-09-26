Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD95EB270
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIZUmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIZUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB351A38;
        Mon, 26 Sep 2022 13:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA61612D3;
        Mon, 26 Sep 2022 20:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46145C433C1;
        Mon, 26 Sep 2022 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664224842;
        bh=XHkjD1Ua4xRVl0ytvHErEfjoIu00Zswq5iaGIsqdnGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kRdQmE5ugzszXcqqMS47mTFMEkx0Oo0+trSYogQGp0OaYHDF5iorE47e1jgSq7DLv
         BX+uO6R30SdtmLxeAXetrDxPWCuUaNYdMGcVBQYfoLDmwRM4mk2b/DsPOyOeTNWqi1
         QyD9XXhGI0J3AbXwvs6fuUjtcSDD2FTOBrOFUvZa4RCcTqzNpKHxQd2owy6KRd6kZV
         cb9dVopgynTuimhaQ9AyrxgzFZB9ItD3QzhH3gGRXqhMZ8MhgMA0FrJr5d5sKoAlr9
         c61VgqZTFbYNYO56cFl+E3eOmmeIxcgcPPS3QJZ4oj4E4SEajyJsaY6rCnjrv/vmab
         J3bbf6E/b+5xQ==
Received: by mail-vk1-f177.google.com with SMTP id h5so4008565vkc.5;
        Mon, 26 Sep 2022 13:40:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf1WpvtH8BhPbD7iKmvwTqb15P7GYBH/jffUm4eWLALudLzGoaLa
        +iH6QDXSGSR90LpL2LxdP/u5MBxI3/+mO35xSw==
X-Google-Smtp-Source: AMsMyM7bK/AZmn0HEKZVdXE5fA2YoeMuPCMz0btsuRH+hr7RdppOuaqM3mGE6kY/JJJFHzAEgvdjGXOVvHk7kmkKjco=
X-Received: by 2002:ac5:cfdd:0:b0:3a3:449d:7d1f with SMTP id
 m29-20020ac5cfdd000000b003a3449d7d1fmr9806847vkf.14.1664224841227; Mon, 26
 Sep 2022 13:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-2-krzysztof.kozlowski@linaro.org> <20220926203340.GA2752484-robh@kernel.org>
In-Reply-To: <20220926203340.GA2752484-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Sep 2022 15:40:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+XeqHO-C1GXY6pHQrsXSm=YkSdTpkjV9bHZGpFU=eJw@mail.gmail.com>
Message-ID: <CAL_JsqL+XeqHO-C1GXY6pHQrsXSm=YkSdTpkjV9bHZGpFU=eJw@mail.gmail.com>
Subject: Re: [PATCH 01/12] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix
 gpio pattern
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 3:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 22, 2022 at 09:56:40PM +0200, Krzysztof Kozlowski wrote:
> > Fix double ']' in GPIO pattern to properly match "pins" property.
> > Otherwise schema for pins state is not applied.
>
> Huh? The schema is applied, but would fail, right?
>
> Perhaps the example should have some child nodes to demonstrate this.

NM, I see you've done that in subsequent patches. So other than the
confusing commit msg:

Acked-by: Rob Herring <robh@kernel.org>
