Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0AA70AE32
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEUN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEUN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A250E72;
        Sun, 21 May 2023 06:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B5661128;
        Sun, 21 May 2023 13:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E29C433A0;
        Sun, 21 May 2023 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684674874;
        bh=E2d+33UYaa4xhZVYOHR7/gpjS6xOhkMZIKR/3QOHYq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MXydhgeK9yZJQWwOWNqU/hDiQD2uy+yRHB6jrRlkO39M+qURKbz6yzagC/tj4Hz9Y
         CTqhWmqXc/3nc9xbNrYlO0IlaC3b0K5wh6GvkWn9EEZodoRZdXw+4HLqT1IylOS9nU
         IsEm0tA+uD5kSA7oN0l9XhmrN8dgjxk1rjTJ9SQ8FINLvTrdH0ixOB/qInNTZhnfiW
         kKDDm2PdzYx9dKFHUnV7mVw/aT7nYdvJEw1VeUY9Ahilp+wfeFkgaE+XV0xtENCzIg
         oKFrgE9eNZb2IQeWPQ/RkBAnFNBwZq8/DieTomnCwXnVVg2p/W1ODhl5bx6LwODqZr
         24FXAnIomip6w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so7814861a12.0;
        Sun, 21 May 2023 06:14:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDxV1fPpxkIg4XWT07cf2F3tCsa0NgzDyKKCnsXflNNiTZHX1iiU
        E5bYXe7VFWpbIOv8qjO5tSKvDt2IgDP/7Y/a+bA=
X-Google-Smtp-Source: ACHHUZ6F4bq7gnmXgk4DHliM3eXPYZGZMQeX8BHBoK09/HSSiyrFHatVn1p041ERnshQyyBbeA/rylT/aOEaT2CKw3o=
X-Received: by 2002:a05:6402:148d:b0:504:80d8:a034 with SMTP id
 e13-20020a056402148d00b0050480d8a034mr5465085edv.40.1684674872443; Sun, 21
 May 2023 06:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230518184541.2627-1-jszhang@kernel.org> <20230518184541.2627-2-jszhang@kernel.org>
In-Reply-To: <20230518184541.2627-2-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 May 2023 21:14:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTx4q1x7rhzWNO6Frw+7ggFGAKzTRpd+TcCv67AoA+xGw@mail.gmail.com>
Message-ID: <CAJF2gTTx4q1x7rhzWNO6Frw+7ggFGAKzTRpd+TcCv67AoA+xGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: interrupt-controller: Add T-HEAD's
 TH1520 PLIC
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, May 19, 2023 at 2:56=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Add compatible string for T-HEAD TH1520 plic.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index f75736a061af..0fa9b862e4a5 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - thead,th1520-plic
>            - const: thead,c900-plic
>        - items:
>            - const: sifive,plic-1.0.0
> --
> 2.40.0
>


--=20
Best Regards
 Guo Ren
