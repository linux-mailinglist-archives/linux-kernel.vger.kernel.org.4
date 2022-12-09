Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793EC648921
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLITlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLITkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:40:42 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1ACACB3D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:40:41 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-14455716674so938998fac.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zGn6KivLY25LJk2g3sxCVo1L7o+xhikldKkeAUAvIlc=;
        b=LiMvxlBbnKBIzm6FV9mDlnga7ChotAwc0RrduxtXlBqps+immcfb64lwrBGu9y7WRp
         +LqAxf/3hXG9mOe21P/YNWYp8SfiqXPDwj9qttYlidMJRkTGy9BoEaFpCxMRPSNUDSi5
         aV1gAxQH7Fp4BYnzpappk+Q1r55u1HGDBxS0iHAof/2SOe0Qo/lzYaeMsW2M4XzunOhB
         e/ihb9dYKwUSbWThL6m02YfUGUPls9lJg78lAVecuHDuufu5uUsgNzBoVaWPR+tKpB5z
         4SNSbpFDxAr/TGlvT0E1+I8iosWIPKet6R9NW8hiuZ8izKIhcxPgAkPDTk8cNz6V3Dg4
         0Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGn6KivLY25LJk2g3sxCVo1L7o+xhikldKkeAUAvIlc=;
        b=FaNyuXGVCttSwFaL0e0En9oyF8fcqjOmam2mURw43WPFJOQQ6Q/9wG4Ys154xpRfEq
         UaUC6PRrn2KAmjTS7bSqd+k+jX9hngAiLV0FZfgHk3r24u3zY8UQN0D9zVibEmc1bcTL
         zUMsbiKd/TqbaySDCu7b3MmC3a9bQF/0ZrQJb9Tp/fz5waBPCw9DA6UsGLJiYvirXeYJ
         qcGnhU+2AuIlpdFlxzaY/A2h746b7AYOHPePyWcvFrKG0YT5NMdzGlejSKoYsjqxqFZF
         xTufMh7q+iVDKmcOfMP4hrKCzOnYo2o42nDeeB94KpuT7ZgDFfJFkUPWMqmp0Y+5BtbT
         zYpQ==
X-Gm-Message-State: ANoB5pn+CAvbvFIIio+Hpdjgej6SIKHr0Y+ySOREW8d1cy7fPUNqH75J
        uy238btc3VVe+nvjPLD1ZUhUF5U/Fw1UhOHJJCs3yPzp4u5ti2o5
X-Google-Smtp-Source: AA0mqf6OUoEEOtMgVtH1kGdKupnfgrNqYWjRgntACJ9IuosD8O/hOvHa08+6xf/jF7Zsrk5zfx141N5/Foq4kS+kfgM=
X-Received: by 2002:a05:6870:1f13:b0:13b:d898:8aa7 with SMTP id
 pd19-20020a0568701f1300b0013bd8988aa7mr41360346oab.14.1670614840597; Fri, 09
 Dec 2022 11:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20221209171553.3350583-1-robh@kernel.org>
In-Reply-To: <20221209171553.3350583-1-robh@kernel.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 9 Dec 2022 13:40:29 -0600
Message-ID: <CAJe_Zhe-XZsz9oJuxBGsD-qiHagPEbHK7GnEUwW2M1Q3YK9GRA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: Convert Socionext NetSec Ethernet to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 at 11:16, Rob Herring <robh@kernel.org> wrote:
>
> Convert the Socionext NetSec Ethernet binding to DT schema format.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
