Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20F6AE744
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCGQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCGQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:51:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3A96C3F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:47:44 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 82so12038641ybn.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+b420gW8EvDq5mtxL/dde8yBN+aFEeDMlpeU8M2B68=;
        b=q05+e5MmNr1ul7D03tP0p/MXc7tVHR0I5rxWn95iyrvA/T40k2SwqSDbakgBJOQKsp
         ONN27cqeFoXTX4CY/MbLXSWMHDRrx9p/lMgSrsqpHzv5hDJ0caPXi++whsuXqyo3rgGx
         oZaIoVXKHQ7l1nqhjnQ3zublfIiNuIuH2NpZzT8V2PGdzN1RXzZSflhTtxBFdJHMW22r
         NyKZxc5hhjRc4zFj1nP1htgUlBcA2gWCu4S7OsCn0gONMKYMdsCPhBXQb/FDZgu27EHS
         Ja6ACCUqVq/j0oX7gR/BLiSjklR8o6FtdbVklsVre7D1D/FjDBj/k6NiIQQWIZW2Sd0B
         nrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+b420gW8EvDq5mtxL/dde8yBN+aFEeDMlpeU8M2B68=;
        b=zwigk1Utr4V1R6S+KiJmYMvclpJyzFZAFq2boH1yJQG8KLbCeNbkDA12pcRZzosy4G
         nnh2XnVwZa42URCF5CtysuEBLvY1mVlgZHEEAZml+DQFzjbf3lcA833ZLu9sMKNvnR1K
         ysRU2s+7tSxEp9FKtU2P4PD+fzjg7XH+8d92wM+Qzre6cT97KN113K0tUYj8R8G94O8O
         ijmwlMUdsPp973K/2gp5hr7nRy+ERl4ZRdPqZ3UwL+5PX4IEesKEaSS3wv4wVcxOiA5k
         ZLHusmk0yE4OdNEXxkSPfWKL8WMyE2GDGUDeg8MdrwionJcbXv+9B1XCENIncVhP4vqk
         XlQg==
X-Gm-Message-State: AO0yUKX7WJ3fcYhWGU5ZxmNy6BeGLS//IIf7iX8IpY6CCdfW39IYOWNf
        QyRv8y2ieUUtgicnE8lwPLWKVuI3HXWaRqMWxMsKeA==
X-Google-Smtp-Source: AK7set9ITIlXcKiPBX7mIBhFoF8sgK/EPHcgfTAk/YTpopZ8SEIfEN0OooNEuok6S589ITq05t0K4xgaMQpkW2PNIdA=
X-Received: by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr8920750ybr.6.1678207658437; Tue, 07 Mar
 2023 08:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20230307164405.14218-1-johan+linaro@kernel.org> <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
In-Reply-To: <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 7 Mar 2023 17:47:27 +0100
Message-ID: <CACMJSesztZbB53QPaiLg+GKghJ-8MbiS60t8CbN_m8Wcph3-9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:44, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Tue, 7 Mar 2023 at 17:43, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > This series fixes some of the fallout after a recent series adding
> > support for DMA transfers to the Qualcomm geni serial driver.
> >
> > Most importantly it fixes a hang during reboot when using a serial
> > console and the getty is stopped during reboot.
> >
> > Doug just posted an equivalent fix here:
> >
> >         https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
> >
> > but the commit message only mentions the regression with respect to
> > kgdb, which is not as widely used serial consoles generally, so I
> > figured I'd post my version for completeness.
> >
> > Either version of that fix should address the immediate regression, but
> > fixing the underlying problems which have been there since the driver
> > was first merged is going to be a bit more involved.
> >
> > The rest of the series fixes a few bugs in the new DMA support that I
> > found while investigating the console regression.
> >
> > Johan
> >
> >
> > Johan Hovold (4):
> >   serial: qcom-geni: fix console shutdown hang
> >   serial: qcom-geni: fix DMA mapping leak on shutdown
> >   serial: qcom-geni: fix mapping of empty DMA buffer
> >   serial: qcom-geni: drop bogus uart_write_wakeup()
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> Hey Johan,
>
> Douglas and Srini beat you to these fixes but thanks!
>
> Bart

Nevermind, I read your other message now. And also patch 3/4 looks right.

Bart
