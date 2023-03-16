Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853F6BD86D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCPS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPS5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:57:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5ADCA61
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:57:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so11458262edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678993030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISoDwGmCZfIt1++Qrq4EaM3UW6i2EJ00oUlk42ZAa4k=;
        b=V34nuHzb1E1n6ArHtHa/MyOWRtt1PmPMxzBmbNZ70ayTY98fyYvgyrBPtlxZTjt10O
         lcuHVx7snGom/yUxsRx5nKqnb/yl03a4EWJTrGqyjjo68Aqsy/DQRWfmH0L322qjXkGZ
         YjDrMlA56pufnTtXHbENe3k35Br34XL7XIt6c+nHVpCgUU+HYpwxYx0CnXzmoW4cVZew
         oKJl3xnnxfcomJvZQc3MUZDsx7bqVXIanxILdL7nKWbL6VJfpIGqwQRmRtHzNy+ayTDD
         NehCB+jT9oMLIKdvSeqa2/tp5E0ZbFN4UP3ZoIzXLCtYfzk8Cs2RRd3Pi3Fcz52Be0Ry
         JcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISoDwGmCZfIt1++Qrq4EaM3UW6i2EJ00oUlk42ZAa4k=;
        b=5F1Njshb/+i1bEudB1BoTXbJEGW0/+TnYJahhzZvrxxfJ9MNIvbYZ2FDJSX7bTSSBN
         XPfzuxPUyASu9fkdm58AnvSnZ9q+WiZYhW462Wm3fZSdw2k4SGkZ7kD8MC7IOV1KnDEo
         kqJibSk2DGy4FSLRN8C+7nqyB8l/71j3Urw72C4vOEfGXJpGuCZSkMcC2bwio8rSGdb4
         YwJs+ddoqb4jjaeLncGh5TEonvlo/GMCkJm7VlpNKwgRXmrcmKROkjLBScfukwk5FwwI
         YSVEE+6ZmK3Z4Hh0XE778lB0hR6L+eX0TW9zAfGqwXtRLZmmE8w7c7kV38Is/JLbQZ1g
         qweA==
X-Gm-Message-State: AO0yUKUJ4dgsPlKWEXbDY47fHald0xUgHYj5D1XtYkyXr/Y1Gk7B9yWk
        H0ig0mFeHWQviSMa5OdsXZT2Tak3L+NQimA0o/zZLQ==
X-Google-Smtp-Source: AK7set8R6MPvl1jYDipFYGi3DvPwtseUsQ8EVHZ1VfSLTTmEQjtyKWaAM4IDrmaaOglEDFXN0af7mz8G306mXMeEY84=
X-Received: by 2002:a50:f683:0:b0:4fc:473d:3308 with SMTP id
 d3-20020a50f683000000b004fc473d3308mr360427edn.8.1678993030292; Thu, 16 Mar
 2023 11:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230316034759.73489-1-steev@kali.org> <20230316034759.73489-3-steev@kali.org>
 <f7be8db9-0bdd-644d-c7a0-4321041c5028@molgen.mpg.de>
In-Reply-To: <f7be8db9-0bdd-644d-c7a0-4321041c5028@molgen.mpg.de>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 16 Mar 2023 13:56:59 -0500
Message-ID: <CAKXuJqiPKJ_Jus2gwA94gQAb-7-PBAZL4CSaFcxpx3+UXBYS-A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth
 chip wcn6855
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Tim Jiang <quic_tjiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 4:58=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Steev,
>
>
> Thank you for your patch. Some nits.
>
> Am 16.03.23 um 04:47 schrieb Steev Klimaszewski:
> > Added regulators,GPIOs and changes required to power on/off wcn6855.
>
> Please add a space after the comma.
>
Good catch, sorry about that, will do in v7!

> > Added support for firmware download for wcn6855.
>
> You might want to use imperative mood (Add =E2=80=A6).
>
Bah, I'd seen others mention this, and still did it in mine :/

> How did you test this? What firmware files did you use?
>
> Maybe mention, that the assumption is, that it=E2=80=99s identical to WCN=
6750?
>
Are you wanting the firmware used in the commit message?  I think I've
seen similar in e.g. ath11k patches like:

"Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1"

something like that?  The firmware itself is already in
linux-firmware.  I figured it wasn't imperative to the patch and it's
in the cover letter but I can definitely throw it in the commit
message!


> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > Tested-by: Bjorn Andersson <andersson@kernel.org>
> > ---
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul
