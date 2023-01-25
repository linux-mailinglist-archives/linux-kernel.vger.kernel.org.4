Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04DD67B454
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjAYOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjAYOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:25:01 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19803561B4;
        Wed, 25 Jan 2023 06:24:52 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id n190so19899676vsc.11;
        Wed, 25 Jan 2023 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MUqrk3GP/3DhSmWkuOs8ye3NG8xp7aQ+gekfrX4lQc0=;
        b=ZdftSwjj1akDmWaqauSggV71jW2O+HXguAfnqr6NnF30jtnzzC1QbrFAJEAxUiPUC2
         2EwQgfL9avUaF/FtKblPe7764ZyUIxLYHv0Ujvu8Reailrj99ot/mgUfGb4JG+v+cjR4
         0SImZT+cU08V9+a3xPMyJcCz1utBX6387Ol+k6GkHKtU7qt2s1EUL5cyxY60aQxvl5PP
         NTajtuHRDbtB+MutOWPhxu48bOLX/7lEAGsvYdGQG6IChaxsLzMCRDLMl6IfJwMZhk2k
         X2oYHLmyalFzic/odZzxSnfPTqtwyXgzb5ywVXsjjqXFZIGwDRlVlf/79YqGj3LiA/01
         nFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUqrk3GP/3DhSmWkuOs8ye3NG8xp7aQ+gekfrX4lQc0=;
        b=26CmU8Bz0R0Dzk4J1iQHF3ipxJ75CZeDMwkngwl0pwvYBplikURH6JXeFO4GroUD/G
         cVWMSD3X74Oukm9kQrSb+LQcs9/uGjEqNqI0fQ2G23GdeLMMnt7TeiF6oqJixIQ8XrZU
         5jAroi8FZY0RJRqKbbg1UxyPeEZkyM2jaWhcsGMudmC2xCxjgV9K303FErkGa5Q79eUJ
         6o4Pn5drQA3zKvdEIFZ7/fSw/fmvnz5njbDaburoChdGfEjMalae4/m6dAKpgWTPYmFe
         3Em3ZxmunvctB80bRDvDriWjV0XbbF1ADfxR4pwmEzAoNxXo9M3vyD/LC7XP1a/YEKeF
         I1Pw==
X-Gm-Message-State: AFqh2ko6VXP1Lx74oyFRskDZjehz0q5SDjNYBEIZ3Mj34mD7Dm8VRjjh
        pMuYCuwoUyZaygtOnF3NVLHJQiJDwNG2Wkd7Dp211+TL
X-Google-Smtp-Source: AMrXdXtp+1+l0V7eBzDbpTKwsXlca8z4HTN//sBpr4Dtwdc6Xx/uxZgT00JsWeAYoFgKAlb6wawZbQI7lVXyFEiKCm4=
X-Received: by 2002:a67:d097:0:b0:3d0:cb3d:ad47 with SMTP id
 s23-20020a67d097000000b003d0cb3dad47mr5095413vsi.76.1674656691211; Wed, 25
 Jan 2023 06:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125072605.1121-1-linux.amoon@gmail.com> <20230125072605.1121-5-linux.amoon@gmail.com>
 <bd29cba9-fb1c-051e-e10e-cb3e73ec5ff9@linaro.org> <CANAwSgRWVPghhEwvQgzQicJHcjgAv_d5nYfE0Ni90butc5ouSQ@mail.gmail.com>
 <d2ce0dce-eaa0-12e9-e250-bf948d2ce9e1@linaro.org>
In-Reply-To: <d2ce0dce-eaa0-12e9-e250-bf948d2ce9e1@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 25 Jan 2023 19:54:33 +0530
Message-ID: <CANAwSgRDM87oHsVSkxieD6C-+eAV__TKL8e2P22ucQ+iJEooZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND linux-next v4 4/4] dt-bindings: usb: Fix properties
 for VL817 hub controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Krzysztof,

On Wed, 25 Jan 2023 at 15:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/01/2023 10:43, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Wed, 25 Jan 2023 at 13:10, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 25/01/2023 08:26, Anand Moon wrote:
> >>> Cleanup by removing unneeded quotes from refs and
> >>> add maxItems to reset-gpios and fix the required list.
> >>>
> >>> Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> NAK.
> >>
> >> You ignored my feedback. Please help me understand how my tag appeared here.
> >>
> > I have followed your feedback and modified the below patch
> > I thought you review these changes see below.
> >
> > [0] https://lore.kernel.org/all/df1c8545-01d0-3821-0c19-07a369e40472@linaro.org/
>
> This was entirely different patch. You cannot take reviews from
> something else and apply to other patch.
>
> Best regards,
> Krzysztof
>
ok, I will keep this in my mind.

 Thanks
-Anand
