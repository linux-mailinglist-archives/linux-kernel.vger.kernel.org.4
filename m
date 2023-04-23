Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128D6EC170
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDWRna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:43:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A914E10C9;
        Sun, 23 Apr 2023 10:43:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so6076344a12.2;
        Sun, 23 Apr 2023 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682271806; x=1684863806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boPNwPXDV+qAr9JOET7iHlOkvk4+Unuh3FWe7icywd0=;
        b=Sxua/nMMnTZeEwziy+jevLbv19qaFNKXz2TPRsXtdJrhfyCsBet19/0ac60XZWaBTC
         y61gknuZFKNq8WxQTEU01KPsGEozDjwn8M1BwWGvx9/nhGTKJnUmMlzXiOdqCvZ8Zs+x
         cjGHQGs1JynN06nNmgeO1E+yq6pQtd2osGsZzBprZVbkVGI0DXmk0BYUIgLSPJSCBfrK
         NxmZrFczMxZuxRnSczImIGPZvaG4Y0vM8p8SCriVI8HxEdlXIgeuzFEPhfQQNn6HTKBL
         oBtEX4HlaRRPBvqBJ4hWIB06fx3O6ggRvN8hUa8H9wfQ7lifvWnid1OuwyORPMsvqir5
         quHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682271806; x=1684863806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boPNwPXDV+qAr9JOET7iHlOkvk4+Unuh3FWe7icywd0=;
        b=fSolLJxyLkuJClktL7S+YWdK+l/N/pSaL3HpFBVbx+Aq3csbY87Nh0IQHMWhHjiKwt
         66rBWhiV1VFCPyyUoZ2z9mo6bNU18GB8mCCBcEX2/4VJGuZtg7PhwqSxeqyA4+PzY82J
         fQyctF0G7PXp8UV3vBrjtMpUXbcDzmGSn2FQHvEjC3ow3f5Zs2IVb4nQukxwNi15xUzD
         arGmsMQrpvYINq3QOyZ5Exu8ayogmzqzm+dJjNOxzO/Rvqvh4L4iJBteTJR5uXJSDYcL
         v0vJV6a5/7k75JlgUa8uRMWg7wt5FrhCnveRDDhEw9rysEZ5GDdboH1/X2ewutUOosVO
         tlXw==
X-Gm-Message-State: AAQBX9d6pgTzZXrR3q6yTKR+VaB4F8hbg49b3ip9sJGPEt3SiOIPu7Tf
        9xkIN8X7ms0zytLansBqWZJvVF6ycpKny7B40ZU=
X-Google-Smtp-Source: AKy350b+rfcZSBXFVrPMeZIZ34NYbHGitfLG40FUHBfpHAR34Fx4U50cReVePdmiqDw3D/1BLLoOO92vqLkWn/OUNj0=
X-Received: by 2002:a17:906:a101:b0:94f:558b:ed7f with SMTP id
 t1-20020a170906a10100b0094f558bed7fmr7952132ejy.18.1682271806113; Sun, 23 Apr
 2023 10:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru> <20230418111612.19479-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20230418111612.19479-4-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 19:43:15 +0200
Message-ID: <CAFBinCD1211x0aAjKPe5BVQDfcCMXWysH_JT8m96Vtmpq5YvfA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: dwc2: add support for Amlogic A1
 SoC USB peripheral
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 1:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> Provide the appropriate compatible string for the DWC2 IP that is found
> inside the Amlogic A1 SoC and used in peripheral mode.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
