Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8163BDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiK2KOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiK2KOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:14:25 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CF52D1D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:13:35 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id p9so2276455uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/QzDW2d1Cs4mC6YU3nOgkgXahHnX/LojCaovyJcwNQ=;
        b=biYhLlnFfQu5qbIvH6K6dxXUh9531anxej8Wa6rlutOAmz9PFvMAzbQJCn662NBeZ/
         Qf34dK6UJ0inR8mxfyAZKbXX2yOLX1Do2iYoCK+AozJJj75XsoNTkrrkdwGw6hqUugiz
         kc7X7SrrXxeqxCmymm7/aZe/DyG2J5xfkxBxMxcdTsUhoRRNe37KG0tJ06q3EBhp9UnR
         nHz+d4F44d9fluRwRUVQN/IDqvFfJlsnnqGU0gv5K6UsAlZou4NobkRUaNzAE5g4EUtq
         qXNTTUDFqAIN8o4WaIVz7JuBdQlkik53HgjE5Ng+nDwEDXNYyaj9gqidMEdRnexgQ7zv
         AN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/QzDW2d1Cs4mC6YU3nOgkgXahHnX/LojCaovyJcwNQ=;
        b=dSg3ni6uQEhqpDlydO+EEywqVjcBXWnppthIbC+zNLSGsn0yDOdzoddRSJ8kQtb2QF
         kRWr+NAN5PAW34foiK8/afWiElYVE3fjC9rWJw4zjKGdkHctngfdhBPxxHDIRucxJPIt
         EKAGKTbFf3bndKRtpCS6j4Fbh277smjebT3Df4oK5yO5mdpbgCaPhlN+KB+ziMXZk+Op
         VV1evzm5GWiVb5zUgihVzwDd8kSEYObOtbVwP+jrVgx+1WGlk9bBB0l+CM5Uk9b3dX44
         M3XPIdeE07S+Bc4FUdBSEywt/HbqjYjGxoaaP3B0CKB+V0MeJkAHhti+yOu9BSZ0wt6w
         33yg==
X-Gm-Message-State: ANoB5pmNcmwQ3GgQL4K8QsAHqjBLFj4SViDOvwztmUNJsWzdbLsMqbxK
        i6d2nzLG6N5tZxTx8LR/UMZvMQ0TYx0irARVsGp1xg6l5Jw=
X-Google-Smtp-Source: AA0mqf707P6Kmly5KCwDCM/FQLqA7B2S9xjQRRs0Dqoia9yp+q8vbzEuqLIgGiZas6uFYrbC0zJH3q5ugx2zYpdsYGE=
X-Received: by 2002:ab0:5a6e:0:b0:415:715c:1e70 with SMTP id
 m43-20020ab05a6e000000b00415715c1e70mr24352734uad.81.1669716814427; Tue, 29
 Nov 2022 02:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20221123110759.1836666-1-brgl@bgdev.pl> <20221123110759.1836666-14-brgl@bgdev.pl>
 <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
In-Reply-To: <426d1f07-0a5d-b740-dc93-77c5a8bc6d23@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Nov 2022 11:13:23 +0100
Message-ID: <CAMRc=Mdo-a3sxaTg=AM_dMMNyV_sw9VxGF-T5RPD2Vhxe2pQOw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] tty: serial: qcom-geni-serial: add support for
 serial engine DMA
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 3:37 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>

[snip]

> > +
> > +static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port = to_dev_port(uport);
> > +     struct circ_buf *xmit = &uport->state->xmit;
> > +     unsigned int xmit_size;
> > +     int ret;
> > +
> > +     if (port->tx_dma_addr)
> > +             return;
> Is this condition actually possible?
>

So it turns out, it's possible that the subsystem calls start_tx when
this is already set but the main engine is not yet in active state (so
we can't simply test that bit). This needs to stay then.

Bart
