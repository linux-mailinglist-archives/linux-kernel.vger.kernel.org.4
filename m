Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46C610805
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiJ1Cd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ1Cdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:33:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97910BB3B3;
        Thu, 27 Oct 2022 19:33:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so9858744eja.6;
        Thu, 27 Oct 2022 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53s4zP1UbHrZ8BLuZgRVSbCBJDm3/rz9JXrjUQqbB5E=;
        b=WqdwLO4ke2DgLv0opSrzgJZjZHbK0QD8uH4ZNd0x7dk3s52U+rbOWgudpTkvlrbc2C
         njU2wtGfrvV8/NUss1r1BUe0ygYP0nWdf+rRnRW4iOhcdq4E7JgmNeYcpaER62C++10W
         Rf95LXFsaYGzr7yodO/XgAhLvDQCLx8jb/r+Lbn8kK25e1uSti9JV5ceofWXWDnK8EcB
         YS6XfxG28QdlWzh6VvM+B2fo1ubnZXeMEk8Mb9SzWDrUtTO7k2d0V+BYHU5dJS8+BN3+
         yEEOJUGLXKRULSBtEfLR87dRCV4abkoy+j9klKG9rdJkiEPKgQeaxGkRnSYHdqmIrymv
         xEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53s4zP1UbHrZ8BLuZgRVSbCBJDm3/rz9JXrjUQqbB5E=;
        b=U8Jtmcy38yxUc8qvv5x1r2eqnCwiCtD/R/L5YSzhSw9LRhDiQgZrmjb9XaotDAniF3
         LFq0szL7s3HOTSrVxIWO6F02gASuNkaZNrteHKcVXnyGWc/fV4PrOf/5KuueliETh36m
         q6gVgdIT/lnCWl73bqWtclpTj71s8qYoZWFKf5DcsAjcTx/96PJhQiNuwHHOLuNhAxTF
         uIAWPHW7XpQto9SegXVyBZtk+eX2KndSA4QeR4oyLyGF5PHLIIZpbvTRhcZaHz1CM+Gr
         QB406B9Mejkp6SkT+SsVUYahOstnnMJZX6USvZ8VoEOvpca8HoKsBALPWc6xAX5q7Poc
         xX3w==
X-Gm-Message-State: ACrzQf17HgvU+MrFTVCBc+bRL7Lx1GwJuMDcM3FRqJjOvpe5WaLTmCKD
        kKZ/jFuUxj9tmLpj9aIRtCunsrcFva5hB0/hn/4=
X-Google-Smtp-Source: AMsMyM7/yz23JjtCZZBG4XioO8LLTMkgQkesu0H7ASDVCHRK0f36BZw2OFvG1P/5ZVpCqSaVcLKXWKDgKFVy6fpso9Q=
X-Received: by 2002:a17:907:2bdb:b0:7ad:95e5:ce80 with SMTP id
 gv27-20020a1709072bdb00b007ad95e5ce80mr3390491ejc.625.1666924431113; Thu, 27
 Oct 2022 19:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com> <20221026185846.3983888-3-quic_eberman@quicinc.com>
In-Reply-To: <20221026185846.3983888-3-quic_eberman@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 27 Oct 2022 21:33:39 -0500
Message-ID: <CABb+yY3JVNPG3dcyHNFxEeGEu3MN_pAOh3+cwexPPe2YG6SNUg@mail.gmail.com>
Subject: Re: [PATCH v6 02/21] dt-bindings: Add binding for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 1:59 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
.....
> +
> +        gunyah-resource-mgr@0 {
> +            compatible = "gunyah-resource-manager-1-0", "gunyah-resource-manager";
> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> +                  /* TX, RX cap ids */
> +        };
>
All these resources are used only by the mailbox controller driver.
So, this should be the mailbox controller node, rather than the
mailbox user.
One option is to load gunyah-resource-manager as a module that relies
on the gunyah-mailbox provider. That would also avoid the "Allow
direct registration to a channel" hack patch.

thanks.
