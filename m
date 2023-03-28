Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37086CC1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjC1OMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1OMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:12:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B4C179;
        Tue, 28 Mar 2023 07:11:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so50318836edd.1;
        Tue, 28 Mar 2023 07:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LthyIzALMSb7MR3hF5OpQlky9r9tzct5FXvwlLfwIU=;
        b=MFU3XXfUvgdx1HLz/Z5dzLkKMTZuOYZke/Tx6t7HxsVAY8bLPXfKLLtzzmflWGoZCM
         aceKcgSDybr8zyTfrzs+9kg1ICoBI+X7Lhnw5xnVVxfH5J7fXe61MB0jAzqCjM78t3br
         Mk7Tc7GbGu+ZN/ZQeH05zv14aC3rlAxjHzgI9GacOGy7MX6/LkMvDI4MbC1M/jCY6fWe
         DbsjFMvpicnFKc5EkOlbLfch1kmCXXLeG3MLLbQH3mvo+wKs0nO6PiuSLrgCW2GV9M3S
         XTaMeS4AMfcXwyaBNhy+EUTh2t7jitctOhHEhdL3gbiSR7CTpcfp6uAxdodRmWKuVJAD
         qmrw==
X-Gm-Message-State: AAQBX9eZT8zBBPwhXESVqJJmIQ37LKtR3KRC+/O6//D9usUKhAqH/ueQ
        2mXeZb4TdRvZk4gT2QUdsyEJbDSzKTm1tQ==
X-Google-Smtp-Source: AKy350aTDpgX5/AnXbBbGtY9splQUoS5BWPJgLJ60joad6YaiZ+uXRPivdu+MSV9Se3+GBTa0yG31Q==
X-Received: by 2002:a17:906:81d5:b0:93d:ae74:fa9e with SMTP id e21-20020a17090681d500b0093dae74fa9emr16004471ejx.7.1680012537040;
        Tue, 28 Mar 2023 07:08:57 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id gt6-20020a170906f20600b0092a3b199db8sm15171380ejb.186.2023.03.28.07.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:08:56 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id v1so12377149wrv.1;
        Tue, 28 Mar 2023 07:08:56 -0700 (PDT)
X-Received: by 2002:a5d:5966:0:b0:2e0:cf3d:6f38 with SMTP id
 e38-20020a5d5966000000b002e0cf3d6f38mr1185244wri.7.1680012536372; Tue, 28 Mar
 2023 07:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230325114353.50293-1-krzysztof.kozlowski@linaro.org> <20230328150316.16d880f4@donnerap.cambridge.arm.com>
In-Reply-To: <20230328150316.16d880f4@donnerap.cambridge.arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 28 Mar 2023 22:08:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ARQ7tuFpnF7sf4TkGWVeBeFk8yz2hCCxxw1wwJzdjJA@mail.gmail.com>
Message-ID: <CAGb2v65ARQ7tuFpnF7sf4TkGWVeBeFk8yz2hCCxxw1wwJzdjJA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: simplify disallowing properties
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:03 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Sat, 25 Mar 2023 12:43:53 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> > The syntax to disallow x-powers,drive-vbus-en,
> > x-powers,self-working-mode and x-powers,master-mode for certain variants
> > can be made simpler.  Also this produces much nicer warning message when
> > the condition hits wrong DTS.
>
> Ah, indeed, that reads much nicer!
>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
