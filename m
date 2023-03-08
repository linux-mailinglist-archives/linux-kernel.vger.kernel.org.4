Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27686AFF9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCHHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCHHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:24:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C0C5550D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:24:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 16so9062863pge.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678260290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQc7CAsTKOJjZMBNjLgh8fMUOuZomOoWr2XcnNoS/7Q=;
        b=P2UsjBYvxzIn/XkZe/qA+ewHk/RYUradsV5wapw2t4/MXUlY996SHWntxOLfD3Xu5Q
         WxprnHIkswK9pPrWYePrgqZx+MGxTUE5RKmYsEWzoqk2m9Ow7+fgkZGXc2J1juyDYDvB
         +WVnZMcw8dRNxSiCI2I37AEbHnbxu1IGXFXdsEboHiQHc+0/ZbN9MkBr7pKpQuw+pj5F
         yd7m7zXPnzN6rBquyIBjffNffVgftK+JdFA2sP2IqeqPn6VBJaTDSsPxzWH0qRN4Fr0Y
         aTezEyZxeSKAt8WvAmeTAGmyBwtcPwv1eoHaa66xx3yxg8kYSGIea+dX9PeTrqEMl+cn
         lKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQc7CAsTKOJjZMBNjLgh8fMUOuZomOoWr2XcnNoS/7Q=;
        b=OZifjbBp/nDVfYNsJLAECjZlZG6DBkthkpuPwq7A9qM7cHLsMIn7QE2UwsE/SsHTkY
         Sx51wPZd1dQyWj40b5HJZH4iREmTaSJ9ko3WZFproU1XiaeXYQkdZCBknuRcRPQfnxca
         243rZJdP6k4LgeQF3NYHOiU+y18QcWytH7zHRLtOctqkMOeUUkT0oAyzWhlJjAkZpE9f
         0fguHlC8Y4s31qjZTaV3z3OuKnzFhSPqfvyAcb1qXzXShZaLdgknqEcsj86FtaU3LE9X
         lhUfPYissfZnbWoD93zr5IYuD4TIXl4hbPm+7tpQchzMaOFOkcdXRnwK0HKVSnd6eYR0
         /b2Q==
X-Gm-Message-State: AO0yUKUlx/KnEmcY4XojGo4IOq21rbBEIGl3NOurYfnAvNlIWsFOSNFa
        VtDw5FfLC9vBwPHpsOm0t8VFLB4cL3jT7SQNYyRlGQ==
X-Google-Smtp-Source: AK7set8PT4b7GPLMPJQ/gWYMowNcMok2Y2rgbNkVB5uyal+ySQwZLgR67XsEEmEY3nJtoGw1U2d9T76TL8SScICx5O0=
X-Received: by 2002:a63:931e:0:b0:503:2561:6fed with SMTP id
 b30-20020a63931e000000b0050325616fedmr6084269pge.1.1678260290507; Tue, 07 Mar
 2023 23:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20230308011705.291337-1-konrad.dybcio@linaro.org>
In-Reply-To: <20230308011705.291337-1-konrad.dybcio@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Wed, 8 Mar 2023 15:24:38 +0800
Message-ID: <CAAQ0ZWSXP59cgyHNkR8UfXRHqRrJGLxuNwMBh2N6=W_x18-BTg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Allow #power-domain-cells
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:17=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
> MPM provides a single genpd. Allow #power-domain-cells =3D <0>.

Indeed! It was missing from the initial submission.  Thanks for fixing it u=
p!

>
> Fixes: 54fc9851c0e0 ("dt-bindings: interrupt-controller: Add Qualcomm MPM=
 support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,=
mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.=
yaml
> index 509d20c091af..4c470dc143e5 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yam=
l
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yam=
l
> @@ -62,6 +62,9 @@ properties:
>          - description: MPM pin number
>          - description: GIC SPI number for the MPM pin
>
> +  '#power-domain-cells':

Should we add it to the "required" list and examples?

Shawn

> +    const: 0
> +
>  required:
>    - compatible
>    - reg
> --
> 2.39.2
>
