Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5072A2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjFITKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFITKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:10:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B673A9E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:10:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bb15165ba06so2060463276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686337836; x=1688929836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ900G5ij4y/xYDI1jpd13Sc6P2wvNe0duR8GNRArV8=;
        b=QfyL3qoBJKLLtm2liQhJFd0F3QPq7oedhrkFEUG0a1S5VO1Ot5UrGcY+/I59134gVM
         QazOr3Z9EvDQXGisE8NGyHHpnYlDDkNQOyZUY6m1xvSEEUp5Lu9PMykhY9Z9KYeswDQo
         ofore2Ow0b98fAdDhaeBEoZDNcYdkzPlgSc0Mr+InFILD0wRvDUQIuFpcoInPudheOIx
         AAGKV9tH7aIVB5uglcsCEGoQwp9IIJoCoZvuTCLoqpg9DCNjGhPHANkq8fq08i9/beQ7
         3hP+fDzl0t82qvEguizUTJc/AS064FC5pSKpgreWcJpluswLT5bAT5c8J/YEn7HcSOFS
         xYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337836; x=1688929836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ900G5ij4y/xYDI1jpd13Sc6P2wvNe0duR8GNRArV8=;
        b=HlIg8RbDQbMPDms/21hmPw1nFrMD+XGVUBB39UBOTEHxJz/54181b3jM6ZTud2xcUP
         GUX1GL5jmPPnO0+XLyTxY/QNRa5rel5xaEM9QwNMsIdecXQ3lKqrz/W1DbAuv+nUc6Q5
         9g8xioJAu+q9X112a7RWAlcNoV2H0QlIZgkzQtD+i5c3K24M+BhrOoNH5g1b9KPSaUJ8
         va5WEyaCG0pLl+Q/o52QW/eYyMFI4pOmxo8qZpLdhkALx5np1ob1Il/UdHG4lcLm65M5
         1ZT2JNozaMc9hB3eGchO2BSL2BfH584H76X1HyLbe6ZSjxfDAlggZHB1IqGJZsjzLU5/
         lyDQ==
X-Gm-Message-State: AC+VfDwFIAQ+bTFk8lD5cx263M64yWguCgN9xb5plgToANsUg563T3Vp
        ClH2Q4eEZD00We842YvwAy8a7347ARl4lOPENHR4Dw==
X-Google-Smtp-Source: ACHHUZ5ETmM9CNHbxrtXFT8B+QGPBNspHfep2ZhFRWOXUKhbuqUHQDU1oTD19drFiTgk70dOzTRUdOtEZ3nSfvaxFOs=
X-Received: by 2002:a05:6902:149:b0:ba7:ad38:5707 with SMTP id
 p9-20020a056902014900b00ba7ad385707mr1781664ybh.50.1686337836352; Fri, 09 Jun
 2023 12:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230609140745.65046-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609140745.65046-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 21:10:24 +0200
Message-ID: <CACRpkdZzC7ttFbprrsaQgnUkdaEgSBA_Uw6fkhrHYi6LjJekjQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: crypto: intel,ixp4xx: drop unneeded quotes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 4:07=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
