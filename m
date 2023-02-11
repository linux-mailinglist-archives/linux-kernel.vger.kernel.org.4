Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3C69337E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBKUGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:06:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721BC18B17;
        Sat, 11 Feb 2023 12:06:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so569154edd.10;
        Sat, 11 Feb 2023 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnqh2DLP0np8pTj2BQOmeoswoqFE/C1tlKJL7Qk99hM=;
        b=jqa03l//+OZWkVyEyhhu3gyjhfV9r2RVrkv1RbDe5GvohjbXjGBxXW+8rYm79v41nL
         hM+3DHLNREFTd0LZ08PHOH2dQS/TdEs7BHlXcxLUJ0NBVWUtadArp88KxqOHgd81IlX8
         96Jw4KRqKQch+/NbX7fztSygE18gsupVnXmsMBulOf4KwALB1knlC1AhStNeonF/J9g0
         2fIlUyjqX4iMHeeOU4hY2CYITKc5KR0jvsxIxy6ORBU8KKfQi3duPKQqCLEnzeLZ9sAp
         x2Bdv5ch+vcS3+do/Bt6KQA7nBDCe0cpg2VWBxwoCo3Jji/88e1pi3EwSpFZxO/4Pa2n
         6xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnqh2DLP0np8pTj2BQOmeoswoqFE/C1tlKJL7Qk99hM=;
        b=ytqPf8tsbpI3A4LtpAlu50b34gDTov2TKi7BhxMP6hSUPEHJnC0kXLGbj2L7wbh3VT
         laLi+q84ocoSsJLFAbsNJ2ZYZRKedGrLKqF98fhFrOjbNY/ESXtqv7yDSIBATRDJrX4+
         LntphZ1IQSGPX1BFnNnqg4DH30+hWqonI3pP/zubEJA4hGUrYbt1YyzBCp2dUcmnIXFL
         V/cPW5460sBPz1YV42GkQPk/cXgNw9MG2ZFUOO1colG9rXrX2sOUkHeQhtLJNUQ5mGov
         ESKoalgpBeRzSW5Xcbm5gMjm1if5TuiAPLXj8RcXM7zZuwMMUQsAzWs6ff3wNWYBTXXC
         IFIQ==
X-Gm-Message-State: AO0yUKW6UJtqqpu37jN74BHmVF2h8j1ARrVO3EGFSLlgh5co89SRfyfH
        MTN4/bpF/Ap7ecY0uv6FIcJsBWFPB+yH+6gEiZ8=
X-Google-Smtp-Source: AK7set/vi99W3ZhR0iZH1E7CNMEgROCLeXaJIwHv4BojbNk9z4azaJ6NweCU9GbZaJmaAUzeji4SHBl6OptG89Q1as0=
X-Received: by 2002:a50:9ecb:0:b0:49d:ec5d:28b4 with SMTP id
 a69-20020a509ecb000000b0049dec5d28b4mr4808743edf.6.1676145999968; Sat, 11 Feb
 2023 12:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-g12a-usb-ctrl-bindings-fix-v1-1-c310293da7a2@linaro.org>
In-Reply-To: <20230207-b4-amlogic-g12a-usb-ctrl-bindings-fix-v1-1-c310293da7a2@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:06:29 +0100
Message-ID: <CAFBinCBHNTj_NAJ_PgProduVdi0BqUvzYLMfMzEjWsUniVJdRQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: make G12A
 usb3-phy0 optional
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 4:02 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On the G12A USB complex, the USB3 PHY is shared with the PCIe controller,
> thus on designs without PCIe enabled the USB3 PHY entry can be ommited from
> the PHY list.
>
> Fixes: cdff2c946f06 ("dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG Families USB Glue Bindings")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
