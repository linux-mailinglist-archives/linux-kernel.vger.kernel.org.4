Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4F6EE7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjDYS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjDYSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:53 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226A17A1A;
        Tue, 25 Apr 2023 11:55:25 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-18ecdb1f2aaso6604312fac.1;
        Tue, 25 Apr 2023 11:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448918; x=1685040918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUVIEnaXOkJ1tFgH9AeXar4KfvKOEaKKLJ3vhZHk8mY=;
        b=MOUmdNfV5qervCoporLCriFOim8zzoDuBprn/RyNV9hTBP66N4vRYbztdT0JQJtqCA
         nhTjWi6ubFdF09Cgq8fzKcnnMlepCvw28J+sQnyIIpVafeHuCOwarroxNgpVus2WJtxD
         kmczL5HmgiNhYlfSSU+YAdkgBMPhrW+2EvuQz+oQZW8GUO2gEy/yNH9GqRAJStscgBSS
         4bo1DJpv8+lddZbAIg5qEVjRluWu+P9Ie1s57/voBwJPxhcpt0GjFECDu0cOAayHOJNq
         WuCfUc2xagzONawGHwsOgILtx7n5jcDs0OK2ccclTtviFjCaOtRVaCKZgPoVF/T9RbOl
         p4PQ==
X-Gm-Message-State: AAQBX9d64/H7JLHvEt2vQK8Bk90q/TvObHHFdeP0qtbKLtb9L1iJ7sT8
        15IEXHj9SYqWZoxBP7/tQLXzPECikA==
X-Google-Smtp-Source: AKy350YhPbP4S0aK9DNndj5vp2UAbhUr/VFFpoNmKCnoLDBKVTCrqXLdcK5AjOK9AB8lNe10G1smng==
X-Received: by 2002:a05:6830:1e75:b0:6a6:463a:1a0b with SMTP id m21-20020a0568301e7500b006a6463a1a0bmr6587841otr.1.1682448918510;
        Tue, 25 Apr 2023 11:55:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683004a200b006a43519523fsm1418611otd.1.2023.04.25.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:55:18 -0700 (PDT)
Received: (nullmailer pid 2080148 invoked by uid 1000);
        Tue, 25 Apr 2023 18:55:16 -0000
Date:   Tue, 25 Apr 2023 13:55:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Marc Zyngier <maz@kernel.org>, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongson-kernel@lists.loongnix.cn, linux-mips@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH V4 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Message-ID: <168244891614.2080093.10385024053617861631.robh@kernel.org>
References: <cover.1682328016.git.zhoubinbin@loongson.cn>
 <c45c402c1a524c89cbde6e1e42caaf04650ee480.1682328016.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45c402c1a524c89cbde6e1e42caaf04650ee480.1682328016.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 20:49:11 +0800, Binbin Zhou wrote:
> Add Loongson Extended I/O Interrupt controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../loongson,eiointc.yaml                     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

