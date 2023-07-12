Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC5750B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjGLPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjGLPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2F81FEF;
        Wed, 12 Jul 2023 07:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE27A61830;
        Wed, 12 Jul 2023 14:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F0C433CC;
        Wed, 12 Jul 2023 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689173970;
        bh=XSDSo2eH1AfgkPqH7BHPmxIrzico4gDoZXNfNGXJy6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZRkan4mTpKdCvvBsz/CUFRmG4FgNdpjYLc50I1YXxurW64vUYZYbxYA3at31IR3A
         X+zhMIpgW1hRHw4EOQeTYjKhM0TK/IqZXfWR047WyZyhYmM8G7WQ3lcQtdVGAfg0T+
         V//EpVYRPRpqDzlWFuqAplyziEJ6z+4DtmBpFoiuiqxccpm8Dvryqv6U4YQjboMj/U
         1t5GsodJrwdCZIVAIDmmHhxiEtJYozKtiEXZ2RXX/IM9ZTRWP6UvCaSPGjghikwKJt
         7C6ofjyGMwa3FYEhu2f7ppYvAru7ZAivHUNNmEmUzKvGh5WQS7My2sqzvek2s9b12U
         52W+kiKhsRNyA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b703caf344so110418381fa.1;
        Wed, 12 Jul 2023 07:59:30 -0700 (PDT)
X-Gm-Message-State: ABy/qLb1uTHk6kSFjt2m4CSAatd/hYG0ikzU3uY/sAY046gI+fDxV+0g
        25riEPTwuob/Oh6Ou3s1zfGtAw1fJ+S8isphow==
X-Google-Smtp-Source: APBJJlH5uKlJrU/2bJ6EcKGheFiQh5satiiMPhfSYYXicIC8UkCHmsWM3SC5mMfAcsb2DXj7ekay3N4+o4QFoX/CBD4=
X-Received: by 2002:a2e:a414:0:b0:2b7:18ff:ba63 with SMTP id
 p20-20020a2ea414000000b002b718ffba63mr10508148ljn.37.1689173968279; Wed, 12
 Jul 2023 07:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org> <168917384908.183505.328888758911691646.robh@kernel.org>
In-Reply-To: <168917384908.183505.328888758911691646.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jul 2023 08:59:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+MNsxnNBdDQJEy5qEraQMTyu_nHHEJNAvWM0bQ8p7Kig@mail.gmail.com>
Message-ID: <CAL_Jsq+MNsxnNBdDQJEy5qEraQMTyu_nHHEJNAvWM0bQ8p7Kig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ad74115: remove ref from -nanoamp
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Cosmin Tanislav <demonsingur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 8:57=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Wed, 12 Jul 2023 10:05:12 +0200, Krzysztof Kozlowski wrote:
> > dtschema v2023.06 comes with support for properties with -nanoamp
> > suffix, thus bindings should not have a ref for it:
> >
> >   adi,ad74115.yaml: properties:adi,ext1-burnout-current-nanoamp: '$ref'=
 should not be valid under {'const': '$ref'}
> >
> > Cc: Cosmin Tanislav <demonsingur@gmail.com>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ---
> >  1 file changed, 3 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Jonathan, Please pick this up for 6.5. Or I can if you prefer.

Rob
