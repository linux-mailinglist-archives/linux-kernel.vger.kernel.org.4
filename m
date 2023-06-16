Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED7331EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjFPNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjFPNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:12:50 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919F273F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:12:48 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a991886254so765840fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686921167; x=1689513167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gzGwVe8x7ZuBanrhWjQ7TnmvtE448GKJfS1GvT+/zo=;
        b=BjbrjqFOhuzIMoaGLiqeb1jR3CxwWMmj2xxOEVU/otqD5EeCBlv1li6YiB3+Qw/QDH
         SYpcRtrtUciQ+QShIRgcqSJdjccGiswXthCcB5Dg4kxdTNULvDvsBd015ulwimBEQDep
         A+W8CTD+1u+CBPL8MUGzfRDasGnWcWVpsU4QGhUpW7/mWJbJ7kYV0TA3gdPLhDTIEzjW
         g/liIIgwuLMtJkKX/LapyH2PVOIgpUincuJUen7RzFqwf7+12XVM+W+ltNd+OZ8Jzgrb
         yR9L59lOLFzD5ysg/L3Q/1G9mEnkUTH6+f1MkMoijxODJ+WApvPk5UfFTt+TKqi1NJIM
         Nigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921167; x=1689513167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gzGwVe8x7ZuBanrhWjQ7TnmvtE448GKJfS1GvT+/zo=;
        b=B9K7NZxTIXpZtWX1V2SY35rKebhFKnAw3H+L0lEvX49t0kPnnWCGruW9VNuGPxcKMj
         UEzgToowPXU0ThJaSkgbliDO9j++VZvwTZhonEf0YcZxLwSgZsiBrvXkuwUYeCTMnQcl
         b6Xtz9PPiq5vlkzaHWpHSuSOT+40Cd4Mro9S04Cw1k9kxhS+X9H34ZT1TtCS+BIbT9pC
         sBJAz/aYpUQ/oGS5m6QW71wjg0eP+2RT4+nSDzjE1/+q7INYuKYZ1PhT9RTFBfAu2IqY
         AbvImy9RD7KxtqlCoNrQXYxkAWMBe4BnCXM8Aen09x+rFon6atz7hWzX6P+KR4yuG4ot
         zghw==
X-Gm-Message-State: AC+VfDzIVd/5ZTb/zKH7CA84OldSBMkpNG08lZS5WjIpCXlyLhRPVgOM
        z0HmDV+IDRdhYUfMm2dJ9L0oz8XztPQjEaoUbl1+LQ==
X-Google-Smtp-Source: ACHHUZ7iS39YuSl/RSeNmhbqNsxRpKekD9BgLO5dsEZz8fbn7Qf5HfKtHueR6TV+I5Tau106K5d7uZHVuYnJx/jFpdE=
X-Received: by 2002:a05:6870:3403:b0:1a6:a28b:6e4 with SMTP id
 g3-20020a056870340300b001a6a28b06e4mr1578243oah.37.1686921167245; Fri, 16 Jun
 2023 06:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org> <05c6aa93-68dc-f0e5-36ea-1ea73b9f4055@linaro.org>
In-Reply-To: <05c6aa93-68dc-f0e5-36ea-1ea73b9f4055@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 16 Jun 2023 08:12:36 -0500
Message-ID: <CAJe_ZhdvejBLSKFN5rEAuQMxksMaMbAz8n2jVg2T08X1Y7ksOg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> > Specify bindings for the platform and boards based on that.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  .../bindings/arm/socionext/synquacer.yaml     | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> > new file mode 100644
> > index 000000000000..72554a4f1c92
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/socionext/synquacer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Socionext Synquacer platform
> > +
> > +maintainers:
> > +  - Masahisa Kojima <masahisa.kojima@linaro.org>
> > +  - Jassi Brar <jaswinder.singh@linaro.org>
> > +
> > +description:
> > +  Socionext SC2A11B (Synquacer) SoC based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - socionext,developer-box
> > +          - const: socionext,synquacer
>
> Last compatible looks very generic. Too generic. Are you sure it
> uniquely identifies one specific SoC (not family, not generation, not
> series)?
>
Yeah it does sound generic, but Synquacer and SC2A11B are
interchangeably used in s/w. And the dts in u-boot use this.
Kojima-san may have the final opinion.

thanks.
