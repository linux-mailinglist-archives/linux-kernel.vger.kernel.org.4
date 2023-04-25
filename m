Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB06ED9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDYBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjDYBVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A03AF2B;
        Mon, 24 Apr 2023 18:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B36D62AA7;
        Tue, 25 Apr 2023 01:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D61C433EF;
        Tue, 25 Apr 2023 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682385662;
        bh=v//103zktW+KRAFVWHcAVD9l53YozrBZU4dBe3nF8Os=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LIx60s20ICfNxrpjPUlY8JsZ4eKnCbOwL//cn8DLX8TI430TELNtVzrENVHUhmHLN
         mMLgH/CPOFXsBfz2Fs+mjoXcp83uvePzyVaKyrq2rG63Z4xmrGqteEP0QQC2nixwSk
         4Tsl5z83qHSsGHAnAYuc7enTvLjHBI1B4g6KsJ0k0tYM5InSHwjLLsdClbQ+B8Q2ww
         HIKJDAjP/avENQsN4/NzlSF0wE+ruP/E5/HwEcXRZszkqU/JLH5Z2tGeLQBsuUJq3d
         9OyIOGVUsrD+V2G4AjvLtsDpoav7z63KfywOfex+OXNpCQZI5Y8Jh9swc5Jj1ewlFG
         nvrzSqlhD6NZQ==
Message-ID: <732840a4fd807fa4fbf2a458716fc68a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJprthTKxCDsMHTXZrLCyhGgTfF3LvqhkrF2-b6XFygKJ2A@mail.gmail.com>
References: <20230420115520.16472-1-quic_tdas@quicinc.com> <CAA8EJprthTKxCDsMHTXZrLCyhGgTfF3LvqhkrF2-b6XFygKJ2A@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_cponnapa@quicinc.com
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Mon, 24 Apr 2023 18:20:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-04-21 06:42:06)
> On Thu, 20 Apr 2023 at 14:55, Taniya Das <quic_tdas@quicinc.com> wrote:
> >
> > Mark titan_top_gdsc as parent to all other camera GDSCs.
>=20
> Please expand the commit message. Your text describes what the patch
> does, but it can be observed from the patch itself. Please describe
> why it is done.

+1 and also add a Fixes tag because I'm guessing this is a fix.
