Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127368A188
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjBCSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjBCSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:21:25 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B638A9D4A;
        Fri,  3 Feb 2023 10:21:22 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so1612399otj.3;
        Fri, 03 Feb 2023 10:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKqTtd06uef5ibtsjMifbrRQEy2r/fkXlh2L538fCSc=;
        b=qsjHrZgIOec4fWogb9P7PcPZak2vJiQW9feXSYS2k4Xw/tKnqBazvooYTj9JOEL/jO
         ikxg1Nw2W+N4jSpDIzszgdz+PEjk4kwiciTQyQzRpsEFlH6CwCNJnXeZ0Z/+bYKTkBs3
         GkavRiPMh4/omY1JLMRwEFG/BoVQa0MKMp9slAZRA7qsaAHk7iq/8R7whtwl6yYyX+9p
         wvcIE/HGke+fdW2r3OxCo8766zbhrl8qFtyPGB4qlvLNxjS1RXmTLSkMj0jTqPt94wJp
         E9Wp7tuP89WNsL2KA2Qaw8DPMeD0rpJUIOsU1To6fLn3GMCtkBp5TP3YVHaOjek6yRJd
         +JeA==
X-Gm-Message-State: AO0yUKUHeDpJ7FahIHaIIw0M28qrrtsBx/ekJSOXrubZlrCCKO0U7/IG
        UX7NQQorJp9JJ/BHU+X6UZQ5hb0few==
X-Google-Smtp-Source: AK7set+8hw6nat6H4DhyX2Limgqmen5W+zGdMAXZEu5LDxHEuhE4wlDY9lWj4NXoZichwA+bz/wc3A==
X-Received: by 2002:a05:6830:1e84:b0:670:9610:1ce4 with SMTP id n4-20020a0568301e8400b0067096101ce4mr6394077otr.24.1675448481741;
        Fri, 03 Feb 2023 10:21:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a05683022cc00b0068bcf7995aesm1367341otc.64.2023.02.03.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:21:21 -0800 (PST)
Received: (nullmailer pid 617539 invoked by uid 1000);
        Fri, 03 Feb 2023 18:21:19 -0000
Date:   Fri, 3 Feb 2023 12:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 01/17] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Message-ID: <20230203182119.GA615242-robh@kernel.org>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:22:14PM +0100, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changed V3:
>   Filename matching compatible style
>   Drop "Regulator phandle for "
>   Specify properties and requirements per SoC
>   Sort order and restyle
> 
> Changed V2:
>   Fix title
> ---
>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>  2 files changed, 170 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt

What's the plan for these patches? Don't see them in linux-next still. 
Do you want me to take patches 1-8?

Rob
