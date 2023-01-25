Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB21867AE91
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjAYJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAYJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:44:12 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54230EF;
        Wed, 25 Jan 2023 01:43:26 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id bs10so439998vkb.3;
        Wed, 25 Jan 2023 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tCWq+O0xtWDJHVp9bnvZ8bZvWJE8EClyj5Mz1s1LVAk=;
        b=mUwAYcLaNrppfQcwh05lO3E3QaFdYZ8abbOiVVnpMSLbUgXnWW69RtPVAfx0YneHy2
         aDUwBPweqhpiqI+eXKojNHwb6jAQ1UryvMXXJCUsqw6Ts8b07tjIYZQrOZMNkG8hcabA
         KlgYcQNrrGWnsodJ4xguLCOWia2jAd62tbXCXMbxT/6IrQH3v8diJEf1N1vxDXc0NneR
         XJf5GaV971kcO4LWC6n0waLeh4cPPrYiip7Fi8t7JDL85yoNhWfRHBpiDaAMUN2AZGQY
         7aMkAQ9brYs+7voMxIe2UTOrYCXikCKaIuAb+pGXHHKzSbtn0WZb95JvkEalGlCJB6Ah
         WkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCWq+O0xtWDJHVp9bnvZ8bZvWJE8EClyj5Mz1s1LVAk=;
        b=FK23G+Mn81N2ivZT3Ecx7FG6uw/6CUuERdkRfn111rrAkkHntq7QLL7C2LBDWlG+xU
         hiPgiIL9TwAiNBzwbPTNKd78eVH1H9F2NmjTNEpxKKyow4E9PzIEq9qm57e7Y2csNPI1
         XBIYzBGrAzSsx8yMdA6GqJRmAb2vgRjrJtfV8ZJ7sY6xaCAbp0/3QHkARuFub5MZt+2w
         ETZsIuxN9pRKafl7HYKKY6zWd1gu+JMwbckzdYPzDuwtnasx1lB+nF4U9p/LgBeuwYPK
         5fKXZW9Veb2djqsu1ZMXXmXRd1cnIV7l4wqXrK+a66I7JCdNfJpAO7tZvaVZdOedBiGp
         L7Yg==
X-Gm-Message-State: AFqh2kok46iZwoAyUbIOlvMxjhQnQQbKHDibfql1mI0IENuVLxP9ciVu
        VKUWz83HF6MWQSSIMltbJQ6z+84Q8mxRrD3myjk=
X-Google-Smtp-Source: AMrXdXtMVLT1VlTS1zRfr4VvTCh4w9CLfTixYp7P7YrgIEhZomqQqx1c9GChF38RhFcxN2G1ULW3+FtsbfY0jEDLQS4=
X-Received: by 2002:a1f:90cd:0:b0:3c5:db35:9288 with SMTP id
 s196-20020a1f90cd000000b003c5db359288mr4108132vkd.32.1674639805550; Wed, 25
 Jan 2023 01:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20230125072605.1121-1-linux.amoon@gmail.com> <20230125072605.1121-5-linux.amoon@gmail.com>
 <bd29cba9-fb1c-051e-e10e-cb3e73ec5ff9@linaro.org>
In-Reply-To: <bd29cba9-fb1c-051e-e10e-cb3e73ec5ff9@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 25 Jan 2023 15:13:08 +0530
Message-ID: <CANAwSgRWVPghhEwvQgzQicJHcjgAv_d5nYfE0Ni90butc5ouSQ@mail.gmail.com>
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

On Wed, 25 Jan 2023 at 13:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/01/2023 08:26, Anand Moon wrote:
> > Cleanup by removing unneeded quotes from refs and
> > add maxItems to reset-gpios and fix the required list.
> >
> > Fixes: 31360c28dfdd ("dt-bindings: usb: Add binding for Via lab VL817 hub controller")
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> NAK.
>
> You ignored my feedback. Please help me understand how my tag appeared here.
>
I have followed your feedback and modified the below patch
I thought you review these changes see below.

[0] https://lore.kernel.org/all/df1c8545-01d0-3821-0c19-07a369e40472@linaro.org/

> Best regards,
> Krzysztof
>

Thanks
-Anand
