Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A5600848
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJQICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJQICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:02:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B995B795;
        Mon, 17 Oct 2022 01:02:50 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso5350989otb.2;
        Mon, 17 Oct 2022 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfE3up6VgNTTWa9yiUMmzD5AKoPfLVEMcdq8Cdqv3hk=;
        b=IHUNdKS/DlgIvFA0O/sugHNtql08QxjAMqDfWhpJ2cJAvlpIZ6Sn1jgvgHXJluhwsE
         SNeRvQG+f+UJJzk/G5tb8FSSOyH8piBsUVbVTA6lwAW5xvtJ+HSDQSvpjqyyuq7PVa8K
         lNkDAb1knwurPLteSYHsUkgNn4sSH8B08JJcKu6dPJiYTp65osgUABftJbX03LwFpIfN
         1GVpvmXGnH1xc0EIWeZWpcqLQOMJS8T2KhkGy7SsKzZod77gZsbJlRZjgiQLdtCO85FT
         qnI3wkFBgcr95sJTVTuLXzGLahIicWPJL4DCNA6fQyzesHXJkNPfQ4JpbNIzlinQIGRf
         UEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfE3up6VgNTTWa9yiUMmzD5AKoPfLVEMcdq8Cdqv3hk=;
        b=uTddwf9AhjzyF4gx2yNlakhEmiXsTJMwuKK+YH1t2JYLbGhmjV8p4l/zDpwyDrbriy
         5TP9+qrhhKJnnt5Hj6/A9hZx7WD8A1+HXsUQJrRXzGqKlwMfAY6+NcNPRQFNuwrI4+iB
         InP0Ljiw0HTbIe6CYYQVjYPD6tPnSKUgmRb+nDikmxnFx5+4BejY02wf9oZBdB2YRNFV
         yV7aVqVixxXueBqW0nvdQD0OOKwSfamFF3TGFCNgin68KxDe1pOENQpUT8T8E3qtmai+
         ffv6ZT68IMWh2PhRGdr0gUJ46chvFZOrg0igcm+t9uffS0YT66BKzRKLKrISJbHriMiB
         OdlQ==
X-Gm-Message-State: ACrzQf3+K42cz6bv5jbBBI1EkDag5QKI5YYgvPnvd94YpynKTghXncB0
        fnD7sGdiU+ex1xdFmzhaNNo1bBwSk3lV6sPVHmY=
X-Google-Smtp-Source: AMsMyM52fpVNjwUfJRM6iEkYH9bNJCgCpfMH0xKQqNjH3yGNPUf46nZzC9eyDSBsQi2UTF5KUbOWoAI83lcoR3vg3VM=
X-Received: by 2002:a9d:7204:0:b0:65e:5e5:310d with SMTP id
 u4-20020a9d7204000000b0065e05e5310dmr4498939otj.214.1665993769662; Mon, 17
 Oct 2022 01:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221012185411.1282838-1-dsankouski@gmail.com>
 <20221012185411.1282838-2-dsankouski@gmail.com> <99652775-8921-9d4a-193e-20d1487e6759@linaro.org>
 <CABTCjFDDEhNo0OVk+87kU93xwvXNR3tMuinfLXzZ6PeyweCpag@mail.gmail.com> <8c773f11-1c00-1856-daa7-250a4ec37d23@linaro.org>
In-Reply-To: <8c773f11-1c00-1856-daa7-250a4ec37d23@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Mon, 17 Oct 2022 11:02:38 +0300
Message-ID: <CABTCjFAajiT7QpyA9mG7i4XzWxtLsvRsDLPtWTvwmJbMYEr1SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: add samsung,starqltechn board
 based on sdm845 chip
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 14 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 19:13, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 14/10/2022 07:01, Dzmitry Sankouski wrote:
> > =D1=87=D1=82, 13 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 16:43, Krzyszt=
of Kozlowski
> > <krzysztof.kozlowski@linaro.org>:
> >>
> >> On 12/10/2022 14:54, Dzmitry Sankouski wrote:
> >>> Add samsung,starqltechn board (Samsung Galaxy S9) binding.
> >>>
> >>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >>> ---
> >>> Changes for v2,v3: none
> >>
> >> Where is v2 and v3 of this?
> > I've been told it's easier for maintainers to resend all patch series,
> > even if only 1 patch from the series requires change. So I decided to
> > keep versions equal in all patches, to clearly indicate those patches
> > are from the same series. Please, correct me if I'm wrong.
>
> This is okay, but you wrote here there was a v1 and v2, and you changed
> nothing against it. If there was v1 and v2, we would ack it, I think.
>
> Or this changelog is for some other patch? Not for this one?
There's no previous versions of this patch, since it was born in the
v3 patch series. The empty changelog for this patch indicates that
there's no point to look for previous versions. I think I'll do it
differently next time to avoid confusion - just a sentence that vN is
the start version for patch.
>
> Best regards,
> Krzysztof
>
