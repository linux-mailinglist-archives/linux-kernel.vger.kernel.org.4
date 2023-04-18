Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF76E7018
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjDRXyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjDRXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8D93C7;
        Tue, 18 Apr 2023 16:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D6C60F40;
        Tue, 18 Apr 2023 23:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C107C433A0;
        Tue, 18 Apr 2023 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681862070;
        bh=Hrd+BNjFqHGurELBooQNeXrU6jy+H2YofJkCRAdEr88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DY4UxslVrS6DGCIKSNzrKxGqV6zpRp6YF1kt/ChfHqYr659zNA7OQ9oBYZbUD3iDi
         wG8zZ4v9agbA4cz1vzhlU5ju0ZudCGUTUk1st/oF74RbUcL8bB+QtQktW5r9dmS5LC
         YwuI0ZeR9fIUy64FbOW06TBq4sQwGfCSSXknVi4ENrKvmrS0eqfsAZDTzUaw/dp4l1
         PkDA6j272nQc//MMFJs9hcFOjRefF6hIj9VIthrn2om/MN3fAaAfJX6gsmiMZ8cgux
         SSjZgCx6MxiL/8FM+jXRqMkxHKArndXw7qmn1ZI65D1TutEAKbMNq0SMA+kmfwIhb+
         W2CVpNonSYfaw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54c12009c30so586836247b3.9;
        Tue, 18 Apr 2023 16:54:30 -0700 (PDT)
X-Gm-Message-State: AAQBX9dKvoc84iZpVBM6bHaU7YHqGvUEU+chIXfM+nt6HbFUpPa7SODK
        ltMlfvmfzX0AIaFzIY2ssrARQBigscdLQdxnVA==
X-Google-Smtp-Source: AKy350Y084U1nwyKppbXIlL2RS/Z6Hww1cnVbHVDZ+rXFFjHyB6vawS8i6+IJtgSejhuf7P6xMbQltLxdQsq9hhBFGA=
X-Received: by 2002:a0d:ca43:0:b0:552:a30e:c180 with SMTP id
 m64-20020a0dca43000000b00552a30ec180mr1638536ywd.25.1681862069580; Tue, 18
 Apr 2023 16:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz> <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
In-Reply-To: <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Apr 2023 18:54:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLB37Y-V-8uWPdnc_YaActtQUhJArv50Rz8K_CF5cbNhw@mail.gmail.com>
Message-ID: <CAL_JsqLB37Y-V-8uWPdnc_YaActtQUhJArv50Rz8K_CF5cbNhw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Thu, Mar 23, 2023 at 12:58=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Convert the text-based dt-bindings to yaml.
>
> Changes from original txt:
> * Take wording for various properties from other yaml bindings, this
>   removes e.g. volt amount from schema since it isn't really relevant
>   and the datasheet is a better source.
> * Don't make reset-gpios a required property since it can be tied to
>   DOVDD instead.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
>  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 102 insertions(+), 41 deletions(-)

Now warning in linux-next:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/media/rockchi=
p-isp1.example.dtb:
camera@3c: port:endpoint:data-lanes: [[1]] is too short
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/ovt=
i,ov2685.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/ovt=
i,ov2685.example.dtb:
camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/ovt=
i,ov2685.yaml
