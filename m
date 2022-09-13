Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD65B671A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIMFC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIMFC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:02:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F733D5B3;
        Mon, 12 Sep 2022 22:02:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p18so10637521plr.8;
        Mon, 12 Sep 2022 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=vW96GP+LcjmYvNYZPF0OIKJXe9RJDazIOcQUwB+CerY=;
        b=IB6nDo8sVUQSlixgMIhpHrjVK0aMqqs1g6RuhTpU+x8juJwzLNVfG2jXzoieS+mfMU
         VQTH0JrfuWb3n7j8ecdWqEGBZwiqcOC7T2AInnuYUj2305mEHYFpG+GcJH1luvHizRiq
         /4h/5llBX4mIbEYtQTY2daoNOy+thlVN92tMOmQWZaEceSC8WQoxiVi9quX1bfhWr+oY
         qOGasZkb9t6juVvb31WrGfQpSxgXqoy0GXQnBBymkFyV/f3FgWcraFxfjOJEjep9Ez1z
         A8Sw0kdxtdCLlHpUlTf69QdFlh90bbFUdxaQvR+tK6BaPvW/ERfkVktw5+VPs9njgyyD
         Parg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=vW96GP+LcjmYvNYZPF0OIKJXe9RJDazIOcQUwB+CerY=;
        b=Tb6+oWxpmpTwZp/xbDYxNNHrSLqi7c+XlJRZRwZ+aRQlNqLOj9PAxX0kBe7frVQCEa
         kTXxIulvdkZnPwHpIwjQ0112K1w1bkE/Rx3eQykyylq8IEtrqN22TWct1/qrb1y4s5jL
         My0CH2fnONefkbQZ+VxP8ARMhoz1K2MFkI8j0IS3AMS2CfAHV6DaUUz/BvJUyP0ob6Y9
         pVb35jYfsNOvJqQQpvNAtdEqmdW0oz3Tr85sXpHD9EzbrqBLJwPHi9TfKoQAE4CDsUeH
         RO1gAFQoH8f6NG0Alv5zisPqqYYdscfLUhFJfdl9oijqjqoi9cUrYBe8/CWFpNO64NN3
         D4TQ==
X-Gm-Message-State: ACgBeo3QqvOT5UAnYREdbiFLdguOPWRoxAzpn5CbNvvLPSJAKbR23Cz9
        nAtp4BhN6e5sc5dcFut51Xk=
X-Google-Smtp-Source: AA6agR458msDthiaH+iRKzjTTphQzWnj6+DbfdBOlK9wTfg70f7amIckEJX1sKFz3QlB6x0JnF5t3g==
X-Received: by 2002:a17:90b:1bc7:b0:202:52ce:a1d with SMTP id oa7-20020a17090b1bc700b0020252ce0a1dmr2097314pjb.110.1663045375612;
        Mon, 12 Sep 2022 22:02:55 -0700 (PDT)
Received: from localhost ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b001743c51123esm7072373pln.72.2022.09.12.22.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 22:02:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Sep 2022 10:32:47 +0530
Message-Id: <CMV0DQVSWHA3.17RXTFSU0NRI4@skynet-linux>
Subject: Re: [PATCH v2 3/4] dt-bindings: remoteproc: qcom: wcnss: Add
 qcom,pronto compatible
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Cc:     <bjorn.andersson@linaro.org>, "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.12.0
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-4-sireeshkodali1@gmail.com>
 <ad201ee7-d83c-9ebc-3619-64632f1f266e@linaro.org>
 <CMU3V4NK164X.1D3TDJPALGIDD@skynet-linux>
 <79c11b6a-8f34-a5ee-373d-f88d5a980039@linaro.org>
In-Reply-To: <79c11b6a-8f34-a5ee-373d-f88d5a980039@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 12, 2022 at 4:17 PM IST, Krzysztof Kozlowski wrote:
> On 12/09/2022 05:33, Sireesh Kodali wrote:
> > On Fri Sep 9, 2022 at 1:30 PM IST, Krzysztof Kozlowski wrote:
> >> On 08/09/2022 20:49, Sireesh Kodali wrote:
> >>> The qcom,pronto compatible is used in the wcn36xx driver to determine
> >>> which register to access. However, this compatible was not documented=
.
> >>> This patch documents the existing compatible as is, since it isn't
> >>> immediately clear why the wcn36xx driver uses this extra compatible,
> >>> rather than relying directly on the regular compatible string.
> >>
> >> The patch does much more - messes entirely all compatibles...
> >=20
> > Is there another preferred way to handle this?
>
> The one which does not introduces any other changes than what you wrote
> here. You wrote here, that qcom,pronto is being added, so why some
> things are changed to oneOf or to enums?

I think I didn't explain what the patch is doing properly..

Right now, the remoteproc driver expects "qcom,pronto-v2/v3" for pronto
devices, and "qcom,riva" for riva. This has been already documented
properly.

The wcn36xx driver expects "qcom,pronto" for pronto devices. I am not sure
why wcn36xx was written like this. But it is the current state of the
driver that I am documenting. So the device tree will have compatible
strings like "qcom,pronto-v2", "qcom,pronto"; Both need to be present.
For Riva it would just be compatible =3D "qcom,riva"; Hence the oneOf.
I will add a comment explaining this in v3
>
> Best regards,
> Krzysztof

