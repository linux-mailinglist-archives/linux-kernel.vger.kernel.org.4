Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF26113C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJ1N6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJ1N6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BB1DC4DD;
        Fri, 28 Oct 2022 06:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1406288C;
        Fri, 28 Oct 2022 13:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13DCC433C1;
        Fri, 28 Oct 2022 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666965516;
        bh=rQJmDiZBQTvN+g8AYTpf+XHiQUInYFOXGygbIqa2AsU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Af0m17xuZbTwWJqFBcBchtYBwTX/56llbV2SIn2WSNwl1mLoC8OdZ7+E7NFVcWUN4
         kHU3nx14HQnf5PEdu9K4vQTHTrZwof0mBKZqzA2PJrA5M3LJ5wEDwELVZBu2mcGZLv
         xwf3IOJcEm2W3WCPVKz/zUBSUsF7AqmfQW2WnpH/ZbwnG15NywL4edG6GDGloQ1sRw
         4U1ky9Ba50lOevZ24IP1+Si/TUH8EUty3RPLufXJxaL5IsUBS3MViTbbNcRU8uI526
         g6YSHEmWIlO5Mab9VeNE/f+XGytiTDzFWxFiYfNQF0PLMPAJhU9ope6ucNvD85B+/N
         7fL+SHtZiCMWw==
Received: by mail-lf1-f52.google.com with SMTP id b2so8427331lfp.6;
        Fri, 28 Oct 2022 06:58:35 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ixzpUkFsEbdlyBE04LEMWO/S6LgYWxUvWHgil2/WG3a18q5cu
        go7zJrgOYLNknQQRFMVeQOvXKWzOocIBCs9zbQ==
X-Google-Smtp-Source: AMsMyM5SqS8RL4UBDJ7wHzAgyFAfsN0Ga0Spzui6yy/w0QIc3g13LZNL9RwHD1TAhaNWFBTshMh260o1G1EYejE0xgA=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr19546204lfv.17.1666965514048; Fri, 28
 Oct 2022 06:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221028134407.19300-1-johan+linaro@kernel.org> <20221028134407.19300-12-johan+linaro@kernel.org>
In-Reply-To: <20221028134407.19300-12-johan+linaro@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Oct 2022 08:58:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+8OXb_0qE20wA-+Dkjqx1UjDTXiWG2CKp7=GkKeis0A@mail.gmail.com>
Message-ID: <CAL_JsqL+8OXb_0qE20wA-+Dkjqx1UjDTXiWG2CKp7=GkKeis0A@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 8:44 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The current QMP USB PHY bindings are based on the original MSM8996 PCIe
> PHY binding which provided multiple PHYs per IP block and these in turn
> were described by child nodes.

Missing the DT list, so checks don't run and it's not in my review queue.

Rob
