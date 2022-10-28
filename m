Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251236106C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiJ1AYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiJ1AYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:24:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86495B0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:24:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j14so6301283ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG8vNqu+yOnidTThsRRaGZjoea/P4g3Vo3zqFSDgNyo=;
        b=l8rrr8Z85GFAmVl1MYomr5u3ZX297sQGN4+2wABZM/iRfD+r2T5n7Nngwech8/gi0t
         05hJL/dAm9TOv8+IbW3z3IOl3Euj2WAJRAp/xVWlKhwIT3+Q7qinLIaY8eBZWCE+Rojs
         +2ag0ajmdC5pmF1zNiyJ0gliOJJ03ok1/dR0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG8vNqu+yOnidTThsRRaGZjoea/P4g3Vo3zqFSDgNyo=;
        b=N7xZlD/bt7in30MB8NHofahgHq1j+kUb5lYtTdg/rZsATFDdc4lNBfcugxkWPcrUF9
         uqpWR8iWtWH+UqnLRQPrZ6wuySvFbHxqIxTuf1hPnaBZXwemzLXKMnWG+ysq8thqHyP1
         pFy7HJ2cTLsyOJ8cY9b8lg2+pm02jR4v7zGGmu4xUNGj4foEUzFM8zPYoBKmUVn7w1bV
         W+39IB+2yCVqk/v9c6frW74nnMyzRWRTtJ79R8jpx7O2nXvGCxCm2TUGYaBbvXm/P5Wc
         E2gLr/FEcuhqPPQttoThFkIMEXSBc0Uf4g46YHqOYHfw1B3RlNsCApzWIbF66yPfxF3w
         xnvw==
X-Gm-Message-State: ACrzQf0F7Uwr6f95N39+LOiYLKhDBAk/v6z8rO/FHgHQVb2cfnu5Dy7z
        awr3LPfFJ580+edvXfa1H4WfYAdRdzshUHBisgGTcw==
X-Google-Smtp-Source: AMsMyM6a19Ff+UZWtCjteZZ3KxTuJu0T7yhL5jb3q9l4sm2lLlt2HHa3p/naIEz1+VA2IO+Fp6GOG466ZtOwZ2jwpxw=
X-Received: by 2002:a2e:8081:0:b0:277:b:33db with SMTP id i1-20020a2e8081000000b00277000b33dbmr11474019ljg.228.1666916669276;
 Thu, 27 Oct 2022 17:24:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Oct 2022 20:24:28 -0400
MIME-Version: 1.0
In-Reply-To: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 27 Oct 2022 20:24:28 -0400
Message-ID: <CAE-0n52N6oxSLoU_=Cq1xK9bVX7H+AvPsR3dLepMNjKywdffvQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Update the force mem core bit for GPU clocks
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-10-18 23:05:35)
> From: Taniya Das <quic_tdas@quicinc.com>
>
> There are few GPU clocks which are powering up the memories
> and thus enable the FORCE_MEM_PERIPH always for these clocks
> to force the periph_on signal to remain active during halt
> state of the clock.

I take it that missing this causes GPU to lose state when it suspends
and that confuses the driver?
