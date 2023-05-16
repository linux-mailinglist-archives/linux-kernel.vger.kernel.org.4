Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62197705469
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjEPQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjEPQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:54:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877DD72B6;
        Tue, 16 May 2023 09:54:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-62382e9cb8dso1945996d6.2;
        Tue, 16 May 2023 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684256069; x=1686848069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+IKvHr+Qv/reK+iiMKXtFvdk8tZMUo94JX5PnpoJb8=;
        b=q4qBiNGZgIJSY3urHsTTQA7J9yflOfJ9/ap1bVIBsrQoRtqK3oV4otSz0FYY0BvcTk
         V+IjSGstVNieUTBxeuW1kcMOuIdIKHwGd+MWLEIcopt76I3hr691v8kLd9mxVJk/1BJc
         3JVbiiIwggFbVqiSxqbKxKkNow3ImCA6siTZMGfUIknc1qVwS3WaWR6TYdIeUl6TtxNS
         QuXCQO6o63h1TneclInQX49R4W0RurFChRJMYwL4mFSqVUI2jGqJ3E5Q+2Y5qGfM3YWz
         oc/4Pn5pHUqaZOJcR2wxRrRXBF4OAoRKFAau7Wo/FYzuRGPiVyYNVnnGedkax4MCPod9
         QA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256069; x=1686848069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+IKvHr+Qv/reK+iiMKXtFvdk8tZMUo94JX5PnpoJb8=;
        b=NdAJR8ixJt6LZARoWRb40rLXwwCNq9VcFoTvhnqDIGudriUV/QVk2URSB3BHEBPLcH
         aRzNCokFBpgI/hXCehxCDNzBM8p3K/MQJTKA/w0AFdGecym6SATsfV5OLhIFOUIjt4d4
         cgIGnOl5Ik8NdlZPNbddiFVwY5AlbVJECS+5XBUF1aBqENuv7zW0lmEXkKhbtUibCg2O
         LyWB1VGt7xmZMRBC7ImkWJySWelR0WDsprhnzVT1uZt23OlAyWej4iXh+VON7fa1HzrK
         ZVSk5QRtlRSLfRAYFQhOF504uy8SBVvFJy/8lMeNQOBFbG7n7VoP//B3iVYIkCgYzg+R
         D+6g==
X-Gm-Message-State: AC+VfDwjvglQz8dJetxLUSCsNuCEqM2i5VfbCNoypVNsl9GUu2b/CNCG
        63m7GsoMNHp4c9oj93UrSpe5ltqqZMeBAmom+j0=
X-Google-Smtp-Source: ACHHUZ4L/H9GbFy84MmkYmOL6YCRHWnatpThEhzYtSHWWsd931XXmUJMNpAEB2uMhi69U0bfnIS5Nw0flC1l4j3Qmqg=
X-Received: by 2002:a05:6214:21ae:b0:621:48be:bab5 with SMTP id
 t14-20020a05621421ae00b0062148bebab5mr35804718qvc.8.1684256069595; Tue, 16
 May 2023 09:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230516114523.3266419-1-quic_srichara@quicinc.com>
 <20230516114523.3266419-5-quic_srichara@quicinc.com> <02d1f821-4b1f-e4f2-0732-026f9b0b7ed9@quicinc.com>
In-Reply-To: <02d1f821-4b1f-e4f2-0732-026f9b0b7ed9@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 19:53:53 +0300
Message-ID: <CAHp75VdLm7o83x9keZEUv9pDK2ZkWkQtMcLU148KyHZgf_6VUw@mail.gmail.com>
Subject: Re: [PATCH V5 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com
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

On Tue, May 16, 2023 at 2:58=E2=80=AFPM Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
> On 5/16/2023 5:15 PM, Sricharan Ramabadhran wrote:

...

> >   [v5] Rebased patch on top of "Add pinctrl support for SDX75" series
> >        and fixed other comments from andy.shevchenko@gmail.com
> >
>    I rebased this on top of [1] series. But if that takes time to merge,
>    can i post this without that dependency and get this merged ?
>
> [1] https://lore.kernel.org/r/1683718725-14869-1-git-send-email-
>     quic_rohiagar@quicinc.com

First of all, please remove so-o long context which is not related _at
all_ in this conversation right now.

Regarding your question, you need to talk to the respective
maintainers how to proceed. The best is that all stakeholders pull an
immutable branch/tag with that series applied from pin control
maintainer (Linus W) and your series on top of that.

--=20
With Best Regards,
Andy Shevchenko
