Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754D6619A0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjAHVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjAHVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:03:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B74C771;
        Sun,  8 Jan 2023 13:03:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gh17so15607485ejb.6;
        Sun, 08 Jan 2023 13:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WLT5A0J6hO3d4KVLI6EF1C1Wnk0AtqyO6OnmLJxI90=;
        b=aXufoqzsAilrFysDcJVYURLOcCAxf1e3KrQ53HuICGeBBXDSetVZ3ZrdyrU6rwW4jb
         7VrHlw014i0GhnrB7Tij+EbJytkzzNSDf+0Qnm6yls9GMoM6qvXH0oxgGapOTtVBTAId
         U7nvcpQ74hwlKGOcebnQLfsAwba5sCc4vHaTu2zBEE5nyGNlhRGJbA0k3+FEko1trhe4
         y7t3JFk0up3uKGJBqP5xYVxaz1r4uEs6UQc0SmndWUcx76wNuFObyJFDg7o6YhqIhTpb
         2CHpERTyTqzvMrGHOma7mY0T3F0By3DkKqIEqCHLuJAVii7zi+EQ2CVHF5h1LvvbwdQw
         W8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WLT5A0J6hO3d4KVLI6EF1C1Wnk0AtqyO6OnmLJxI90=;
        b=gUisJ+0CB02mrIY4429Zg84/k7p20Y3Zkp4CBWnv20QCgi6/cHYc/O5m/PXX9J/S2p
         xr3mQPtvhWoTWaWM2dRDbiQHJMMlsl5Wovz9uiO6cjEP41wAhB2rltgvvgDBqbLBZ4QJ
         9qL/MOJoUyNVVDHcBXWke8TlYl//nKh8qJk17iF60a21hJuwAybvDRSNfBTqMCHkt83p
         pFJ+8pRloTGrj/cRQVkc6kK5crj5aey6W/qe5FaIHZkw6AXcTa5WsZNE8LgEA46Kx4NR
         bVmC+DdX5FMsVcZEwgqiXLUeXh8tR7khQB4bv8UkFzauL987oXD7sEPsmEGQtoSpgYvA
         +faQ==
X-Gm-Message-State: AFqh2kqpaJa0jRdCnuHa3hGoor1etRPXBwTV9gU4LRM79No1XTL6bUiu
        +pfJUJr9FlI+Up1GsoiPGis=
X-Google-Smtp-Source: AMrXdXvLb84qUoRiC4Q8ySgquZqxigGYSzUI/z915ir8dQbQIl+fouYy8pcNuXgmYMRPC2mPwWmrtw==
X-Received: by 2002:a17:907:7da4:b0:78d:f455:b5dc with SMTP id oz36-20020a1709077da400b0078df455b5dcmr65634196ejc.28.1673211782779;
        Sun, 08 Jan 2023 13:03:02 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0084c723a626csm2877680ejh.209.2023.01.08.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:03:02 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] ARM: dts: sunxi: Fix GPIO LED node names
Date:   Sun, 08 Jan 2023 22:03:01 +0100
Message-ID: <22960501.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20221231225854.16320-1-samuel@sholland.org>
References: <20221231225854.16320-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 23:58:53 CET je Samuel Holland napisal(a):
> These board devicetrees fail to validate because the gpio-leds schema
> requires its child nodes to have "led" in the node name.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied both, thanks!

Best regards,
Jernej


