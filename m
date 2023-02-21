Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225069DE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBUKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBUKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:50:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0A1CF7D;
        Tue, 21 Feb 2023 02:50:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ec43so14842392edb.8;
        Tue, 21 Feb 2023 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti7UZf6h2PEzAVjtyfvwktB9sdr7x+Jsk9SvJUAXHH8=;
        b=Odw06A7IWOgv1wMzR/k2gi2d/wgwWDDyoTVtlceNORqLIOi3lr+YBBcmQQ+1i5H5mS
         GF/rnZCC5D5YLctdcDpf7H46AIwLAIBDxX+baW9xbFjw0wc+uQCG1WMa4usFssR7kcv/
         adXn7BUMq5kM3W7uYFMl8JV9aGL8jKMOkv/Qk/KFLBO5zbCNxZKbQa3MjVfup0mjcq2r
         xvqrL+jFm9TfGI1woYL4tNj37KQyZULDu2xYUZDlPpYgu7waQPUZDk01+ooVrsLM7c8Q
         yOnc16Ge5WPsfzlHNqy/gyFWBiajTYwHTy0bskOh0OUEesmaXhCfjm8nSdmyizGR9kPX
         CxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti7UZf6h2PEzAVjtyfvwktB9sdr7x+Jsk9SvJUAXHH8=;
        b=mZt/d59Y+t4GvxSc14H5u1LCvTQbvOt0NRgGpFMM0NzcSYlg+hsSSR60XAmWDERiRI
         mIS/IYzd8zM6z9nbM7OyeksjeJhsDq9KvBLISBf1P7Suip02UoIE7kt+2m8OA/hx7dfs
         yO6f4QTV1geMAMY/vbk4IccGZyX3XoqKt73T5EJqDBvuxf3M1ws1qwZzc+u/pCfW9iKf
         h1dCS3+pn81Rk4W18Yfc7M33nFI+hCFEH3e/fUJdiS1vZziJHJM7upM6OeLQnmDxgJcG
         GxHaAIcEapIIWcAE+pNOTKOEamS2SDoP8KC3+qnUPHngXoQcUeiY6RITugev9QVrw7EJ
         NMFw==
X-Gm-Message-State: AO0yUKXEEnHVkQKrM6l18kFO6kGPgS1LBpax7YMkNE6eVdsChkxNfR5s
        7S9Qce7xBF5J4aCsJUZnzXzsuR/Y8eQH/fWgXPA=
X-Google-Smtp-Source: AK7set9GOkHPo3E6kkUlfj38iSQDlt4z0IpFgJqNIOaMXIzjnIbbkvBbwZsMSETWjyfpaKmlsqbmIGKCnJvJTM45mWY=
X-Received: by 2002:a17:906:a292:b0:8b1:28e5:a1bc with SMTP id
 i18-20020a170906a29200b008b128e5a1bcmr5601187ejz.5.1676976634408; Tue, 21 Feb
 2023 02:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20230221102605.2103657-1-keguang.zhang@gmail.com> <cc0c458c-8c4b-c187-8b65-5943499ddf94@linaro.org>
In-Reply-To: <cc0c458c-8c4b-c187-8b65-5943499ddf94@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Tue, 21 Feb 2023 18:50:18 +0800
Message-ID: <CAJhJPsV87yw3HkagW3c_q4tTBFeTE-5sAQ2_OT9=4Eyq+Bb-2A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mips: loongson: Add Loongson-1 based boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Tue, Feb 21, 2023 at 6:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/02/2023 11:26, Keguang Zhang wrote:
> > Add two Loongson-1 based boards: LSGZ 1B and Smartloong 1C.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Add the according vendor prefix
> >           Change the board string to enum
> >           Modify the board description
>
> Thank you for your patch. There is something to discuss/improve.
>
> > ---
> >  .../devicetree/bindings/mips/loongson/devices.yaml   | 12 ++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml         |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> > index f13ce386f42c..15a43ce51bbf 100644
> > --- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> > +++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> > @@ -37,6 +37,18 @@ properties:
> >          items:
> >            - const: loongson,loongson64v-4core-virtio
> >
> > +      - description: LS1B based boards
> > +        items:
> > +          - enum:
> > +              - loongson,lsgz-1b-dev
> > +          - const: loongson,ls1b
> > +
> > +      - description: LS1C based boards
> > +        items:
> > +          - enum:
> > +              - loongsonclub,smartloong-1c
> > +          - const: loongson,ls1c
> > +
> >  additionalProperties: true
> >
> >  ...
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 0e57ae744199..47565ebae4d1 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -757,6 +757,8 @@ patternProperties:
> >      description: Lontium Semiconductor Corporation
> >    "^loongson,.*":
> >      description: Loongson Technology Corporation Limited
> > +  "^loongsonclub,.*":
> > +    description: Loongson Club
>
> Are you sure that this is a board manufacturer?
>
Sorry, that's inaccurate.
Let me update the manufacturer later.

> Best regards,
> Krzysztof
>


-- 
Best regards,

Kelvin Cheung
