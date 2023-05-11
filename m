Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237666FF053
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbjEKK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjEKK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:59:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB2E5B84;
        Thu, 11 May 2023 03:59:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso7983207a91.0;
        Thu, 11 May 2023 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683802781; x=1686394781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7WwGv5KdS3JZFK3LNUp5MC3xbE7T89T2fedtq/0oXc=;
        b=N26j+VMrYeUL3Ark717FdrXcfToyaCqMS6iY+FeQsEcpY7/CRFjD3pm8JXhDkmG3rx
         JV0ZiQt4bw3mexLUenLy6ujL4q3ujgm8A+Ky29XFZV3Cj5OOPV1IuAYRDbLkbE8gSwNP
         ywrBKf0PMdL1wJ+gR09fiRNI/cpEZtY7GuL8jWl0vqi1X94S2LgmJC1/evJ1HdjdJC0K
         IYgieE/37snCsLXQaF8f5r4cL6BKYkUXVhwaUOBe56uWmG0bvuwHgLD/s6OIf2Tm5q8K
         NgRDEHB2S0dD5M7Cq5Tn85z0vO5dJ6Om9XNEau6HgDD8HJ0yPSUvBO8Z3w7n6dthvgh3
         LIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802781; x=1686394781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7WwGv5KdS3JZFK3LNUp5MC3xbE7T89T2fedtq/0oXc=;
        b=BItbdS9mgDU3PuCUwT91l1oKsxqHaM6N+Zpwi5SP3z7jmm6+ZJrU6NWv59CtprUrJZ
         pFcQlBZuHWKiYz3/vS6TRAlLoWFyT3kProSTcRyZ3bLRje4jfb1XBFshqDe7XtHCUNpW
         VAc4w2/RNz9zsAXoQUo+FXQBYBzsFwXd+yBZcOPQ3x1XCiEV4iXKS0Ybyes++iAFQWT4
         b8Cm/N3UMJ15XZssNPTWrT5sjBId4pnXuLSFkHNzggu7PTVtPipufEGW7RPYSZW+Va/k
         8rYYghqXQUz6RGEOfK//XmpHjTCl64qkJKtquAY9A/3Kn5U9eFuryxv8UfMPA11l7Xei
         6d2w==
X-Gm-Message-State: AC+VfDxZ19aCFhhH9EuDRmVplHosnS/hhQuUnduewqGcep2rMmxHSyhT
        Omml8tkuq34LywBZ4eK39rvp5MprpFs+YfxBs+0=
X-Google-Smtp-Source: ACHHUZ4GERe0mUrXPvRcXq786LmJzoOQzwlw+H1gHijJA7ExVdrv/E5/FTfzxC5+hMYC4qyX3FLDtumdrE0sbuVolo4=
X-Received: by 2002:a17:90b:1296:b0:24e:596:624f with SMTP id
 fw22-20020a17090b129600b0024e0596624fmr20866667pjb.22.1683802781153; Thu, 11
 May 2023 03:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-8-quic_srichara@quicinc.com> <8f5040e0-169b-554b-c9e6-479b8f098bc6@gmail.com>
 <daff6818-525d-7a99-de08-e289848cadf9@quicinc.com>
In-Reply-To: <daff6818-525d-7a99-de08-e289848cadf9@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 11 May 2023 12:59:30 +0200
Message-ID: <CAOX2RU6_TmOfv5298fs6zgCvivdA6=GK5SnhGu7cDsmGQ2-ATw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] arm64: dts: Add ipq5018 SoC and rdp432-c2 board support
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 12:54, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
>
>
> On 5/11/2023 3:54 PM, Robert Marko wrote:
> >
> > On 10. 05. 2023. 15:41, Sricharan Ramabadhran wrote:
> >> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> >> rdp432-c2 board.
> >
> > Hi, does reboot work for you with this patchset?
> > I have tested on 2 different IPQ5018 boards and they wont reboot,
> > I get the:
> > Requesting system reboot
> > [  321.005977] qcom_scm firmware:scm: No available mechanism for setting
> > download mode
> > [  321.006128] reboot: Restarting system
> >
> > And then it just hangs there.
> >
>
>   Yes, that is because SDI disabling using separate SCM is still not
>   there. I will add support for that in a separate series.

Do you maybe have a workaround for this, as it's driving me crazy to
have to pull power?
Also, it would probably be good to note this in the commit to avoid
more questions like this.

Regards,
Robert
>
> Regards,
>   Sricharan
