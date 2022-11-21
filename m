Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5B632498
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKUOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKUOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:00:48 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184191517
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:00:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so7345161otl.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/D0Lm1KS+Ja4fWDh0HXcyKEC5n+mGQEJvv8NjLbp6E=;
        b=mhsRCNIgoJwDgD7wijpmV/cC4SffsmqvWCtN5JEXBAGW4nbz9TGNqM0DPZp4Tm/MtP
         cxjFhE4aajYdpQkWio3/w/PgSr2WqWe74bfpHjJU1+CXfm85RzosdHw6S6wALtWqBth4
         G3CSVmekmy4tfkBP3Z4btTcb4AcAlsfHpIGPZhNtOjptjvbdcEjQq/HRUPoAPEDyoLkX
         JxHIeHrfYoUEDZUDtnns+ujIaNSR4B8QNkZyXrM3PmfJsWnd/zWs/rObL7+fH0I0OUYQ
         xnqtpGFWSUq1JuYXzvUmuaSirKuw6jPWBfu9TElSHBUUAwOvJr7aJwlYow3d0XFjs9wj
         7Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/D0Lm1KS+Ja4fWDh0HXcyKEC5n+mGQEJvv8NjLbp6E=;
        b=gfJ95c38mU851vzURInYlPIe9gZMaYreh1/z1mfDe0sfv80OEWlc99/YBl0hC8bCs2
         ZaWc02pj7WRd3dV6pD/AqT3xj1RIihqKi7PKWxEd4R8Pqpn+XDphXXgBPXd+ofk/McQv
         tXZNFRUl6RScNoTyXPZx3DpG92Q41l3mF10xIzYqS3m2CAw9OMg8fTA6vHO2oRJPJFN1
         qg5Eh9zg/RTfzqtCUWf7AUkNewkLh+y/ad1ZUJ+NP0kqo+pCUwRDsp5tPpnnW7BCQMiK
         abGYTXQSPvQrzrFaP9serZyJj/IJazn/TI2rIwp5DSdih4zlynMKX3E0qdyDhUeBiZqI
         vB4Q==
X-Gm-Message-State: ANoB5plAxa/tglVEEuM7eR8EUiRFp1ntRleflAVJQ6Th6wYrAEew7V4R
        Kt3HUYwloksiainjjP0w6l+WlWFf1GsY9dvTBIaUs6v1d8ydYg==
X-Google-Smtp-Source: AA0mqf5BBa2PKPMYJem/LoHXdxVCb1OehGLc+5aj9oWm/51RTtd1l1fHN/q7VmI1VvvrRxwget0GZoJdRGAKK5U9UMs=
X-Received: by 2002:a25:cb42:0:b0:6da:32d3:c2e3 with SMTP id
 b63-20020a25cb42000000b006da32d3c2e3mr16876176ybg.66.1669039228487; Mon, 21
 Nov 2022 06:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20220924142154.14217-1-luca@z3ntu.xyz> <2122234.irdbgypaU6@g550jk>
In-Reply-To: <2122234.irdbgypaU6@g550jk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 15:00:17 +0100
Message-ID: <CACRpkdZLVYfrZgyO=uJX1jm9cdGrkSr_=2CmPk5Rf_eccwa-Dg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: bluetooth: broadcom: add BCM43430A0 & BCM43430A1
To:     Luca Weiss <luca@z3ntu.xyz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 6:13 PM Luca Weiss <luca@z3ntu.xyz> wrote:
> On Samstag, 24. September 2022 16:21:55 CET Luca Weiss wrote:
> > Document the compatible string for BCM43430A0 bluetooth used in lg-lenok
> > and BCM43430A1 used in asus-sparrow.
>
> Asking again if somebody could pick this patch up, it's been sitting around
> for 2 months.

Repost it and include Marcel, Johan and Luiz on To:, maybe add all three
of them but Marcel and Luiz has certainly applied my binding patches
in the past.

BLUETOOTH DRIVERS
M:      Marcel Holtmann <marcel@holtmann.org>
M:      Johan Hedberg <johan.hedberg@gmail.com>
M:      Luiz Augusto von Dentz <luiz.dentz@gmail.com>
L:      linux-bluetooth@vger.kernel.org


Yours,
Linus Walleij
