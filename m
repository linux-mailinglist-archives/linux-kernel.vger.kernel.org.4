Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A103E676B66
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 08:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAVHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 02:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 02:04:26 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6A227AD;
        Sat, 21 Jan 2023 23:04:25 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 12so4549006vkj.12;
        Sat, 21 Jan 2023 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wSHyX0ABKy6xRv7EWotuZ/V83E4MGkAANm24o1WeLUw=;
        b=d3PR0Rzh7ea7fxDUksSd39xo/nyHqV80m0PXYV2IzQaXnDPD4Z4DKj2id6eWEb8qTW
         7kUYDxM4RnXho1DRNqs7x+nXw5dND40MtM9v87ZINruh+yCEBgd//AYhdRGel7gZrZWM
         saeZFtW8wzWvrEu7FF+FF6M03zx0vLqkoZPpexhxzR3nyKiC7mvvAWiKeeG3M0kNLUSz
         zY1xr13K0t1h4ut5nE0iRG+fq0zb+ZYokB2ifbHBpncJtNcVQPJyNj8XCRBeUnjc0Y8E
         IC3P/oiMnOqMj9eWzLcVzM/zNr84Ui/peCk3cWtLwHgD0rrCCfnsb2i6cNq1yiFuOUVB
         rd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSHyX0ABKy6xRv7EWotuZ/V83E4MGkAANm24o1WeLUw=;
        b=8AuVkOwLRmGAl7zqi51lxWJXK0xKuLDWAdphO23qLXjTz3oXDyJ6oLBow168NhN2kV
         NIzsVkB9epojV6nksoLvtYqbM17n/je++OB5jnn+zb614qKo7AIOb9OOXuZ8Mkg6XMKu
         cczqB9/ZxjDMBwGVqjvBcHLlL+dauU743+NPAfgmY3qdd/6Af+Nta06fWYLIKP8q1ceB
         bERCP/htx/d+BJcz4uGP2wjrhsyy5HBbiXOg7Xzh6uoMSq4ZzD601cA9fO6CL9N/Qo2/
         HX+uQ3aM4XcmVvuHSM/+AJifrg0KS0bqPJ3NevdOGLbf5MdcCdJHQpCIKNMbPSDwwnBe
         e1vw==
X-Gm-Message-State: AFqh2krdEWq4rntt/aJiNi+F3jMTu5utOKdIDK2oR8Pyp+ksfU1DrJOV
        rwVlGzgbgaSyHFrlK2UnGnW2s3LVTgaCAl44hWE=
X-Google-Smtp-Source: AMrXdXukPFFOYF/qcvgiJmjZfQKsMV7ZehX/gcgF2chIf++qopIzbrt2jDOFPqnWLLg+DmKNiU4J2qdbjl64YHwmFUY=
X-Received: by 2002:a1f:90cd:0:b0:3c5:db35:9288 with SMTP id
 s196-20020a1f90cd000000b003c5db359288mr2716558vkd.32.1674371064425; Sat, 21
 Jan 2023 23:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20230121175639.12818-1-linux.amoon@gmail.com> <20230121175639.12818-6-linux.amoon@gmail.com>
 <d0bdc8f9-5ea8-5c77-3193-a2932c87156a@linaro.org>
In-Reply-To: <d0bdc8f9-5ea8-5c77-3193-a2932c87156a@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 22 Jan 2023 12:34:09 +0530
Message-ID: <CANAwSgT4P544a2MeybV_hXkDfc_HXiO4Rnxt4qG3RM1-X-KCEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] vendor-prefixes: Add VIA Labs, Inc.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, 22 Jan 2023 at 00:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/01/2023 18:56, Anand Moon wrote:
> > Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
> > of USB and USB Power Delivery controllers for multi-functional devices
> > and platforms.
> >
> > Website: https://www.via-labs.com/
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3: - None
> > V2: - drop Drop marketing, so without "leading".
>
> Wasn't this merged? Didn't you get email?
>

Yes, it was merged into USB testing branch.
I have rebased it on Linux master 6.2-rc5,
I hope this series picks up again.

> Best regards,
> Krzysztof
>
Thanks
-Anand
