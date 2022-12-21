Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61700653935
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLUW6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLUW6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A3B164A9;
        Wed, 21 Dec 2022 14:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 843AFB81C60;
        Wed, 21 Dec 2022 22:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA9BC43396;
        Wed, 21 Dec 2022 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671663521;
        bh=xPJyAttQv186mOKKFQAv7hbL1F6VtzkjKD1tNd/7IjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c9LX/mATG1E4rUdpQf5lc00FMzlYrmQlGYnyGcdjKs8G80wg6uxgSaLmXYovKzMIn
         6c53uqNXWNr+CER1vROnf2V/dFSrm6+jEzDJPWZ/sYJOY5c4BSVM/Xm8ak9yttAuIm
         VU+y+jSFnHf5VESA94PMTn2SMb4p05Nwd8pkyKxle3UxxilLqoOsp9Uw8iysNP6ynQ
         tQSqudhn21Kv4B72fL2qO1UGwGg4TJ+XL9rFX/abIxNqNCojhxGzTJRfGk0x/Tb7kD
         0ktJgIRBGwsadLRtBb22sj6OlUFNovAX72Glq4jmLa99tYizdmadq0h2GLWBeI46Zp
         DqJlNbJMWY/Rg==
Received: by mail-vk1-f182.google.com with SMTP id q7so207772vka.7;
        Wed, 21 Dec 2022 14:58:41 -0800 (PST)
X-Gm-Message-State: AFqh2kppbiTa3fU9NIuD+6nNnYPx0JIlCHIqeVyCEdHHPtwz1pnbU+A/
        2NZr7G/ACZcigo+X6rpXdKqUZq8CakJap7eXYQ==
X-Google-Smtp-Source: AMrXdXvkVofoFLUCiiX0oMRt1lMmY+lF5kSdN/xdjD5N4p1/NYeUecqLznUCGN0lyIXoU5dqbSZVNpdmC1dh3bDlsnc=
X-Received: by 2002:a1f:1e50:0:b0:3c1:1c3b:c4d9 with SMTP id
 e77-20020a1f1e50000000b003c11c3bc4d9mr402043vke.19.1671663520158; Wed, 21 Dec
 2022 14:58:40 -0800 (PST)
MIME-Version: 1.0
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com> <899d3a39-19bf-519d-a863-bd7ca1e7c033@gmail.com>
In-Reply-To: <899d3a39-19bf-519d-a863-bd7ca1e7c033@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Dec 2022 16:58:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5EFwqNU4YB3yYPn8x=FAv1jR6vMKhFrS-cqyuO2cRyw@mail.gmail.com>
Message-ID: <CAL_JsqK5EFwqNU4YB3yYPn8x=FAv1jR6vMKhFrS-cqyuO2cRyw@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] dt-bindings: display: bridge: snps,dw-mipi-dsi:
 fix clock properties
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:22 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Fix clock properties from the common snps,dw-mipi-dsi.yaml file,
> as they don't match with what is used on the SoCs.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../display/bridge/snps,dw-mipi-dsi.yaml         | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
