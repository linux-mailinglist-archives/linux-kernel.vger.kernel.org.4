Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32DE5FAD98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKHgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJKHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:36:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FD52E59;
        Tue, 11 Oct 2022 00:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 582CCB811FC;
        Tue, 11 Oct 2022 07:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9200FC433C1;
        Tue, 11 Oct 2022 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473759;
        bh=VGwbnwa0/fCPxMP3a8oZj0gH5+LUNxV0BWgcHwnp0zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyV0f1vtUNsXkAdmTe5Q4v7zOKBy/PlXnFiY6cTCPRCxZjEXLKCEH4iUTCBrT95nD
         UDiMyeRYDoMlCFb7i6GQso9LkXV3wbQk/1MLtORZPafCoLj1vGW9t6fk8mHKIkmM+4
         35yNIM1nGErAyzGCOUWvVBXAodlw2aH4y8Kv3/hbQ4KBbonAHc/5QyeFFlTNdlNzCm
         j4kJ45jQwYj7sA9B1tO8QzNKtT/btsw+oLGjTjTOJYTCTINgWmHU20blYPmMsE+WSV
         STmrgbvPPWfrdYsVwq1WZg7AwwIC0hF0MDHtxaJ7NDIclpc8Yi1jDT6TAcMjWwPmfS
         bR/mKSLTXJQvw==
Date:   Tue, 11 Oct 2022 08:35:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v9 0/3] SDM670 Pin Control Driver
Message-ID: <Y0Uc2L3s8vx0Bfsh@google.com>
References: <20221007213241.84962-1-mailingradian@gmail.com>
 <Y0POmQ+xrQ/HT7RF@google.com>
 <20221010232225.209700-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221010232225.209700-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022, Richard Acayan wrote:

> > On Fri, 07 Oct 2022, Richard Acayan wrote:
> > > Richard Acayan (3):
> > >   dt-bindings: pinctrl: qcom: add sdm670 pinctrl
> > >   pinctrl: qcom: do not reinitialize gpio valid mask
> > >   pinctrl: qcom: add sdm670 pinctrl
> > > 
> > >  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  127 ++
> > >  drivers/pinctrl/qcom/Kconfig                  |    9 +
> > >  drivers/pinctrl/qcom/Makefile                 |    1 +
> > >  drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
> > >  drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++
> > 
> > And I'm receiving this because ... ?
> 
> You wrote a patch a few years ago, then supposedly changed your email, and I
> wanted to know if there's anything we should consider before removing some of
> the code you wrote for it (in patch 2). After I added you as a recipient, it got
> a review tag, so I don't know what input you can give now (unless it's
> important). My bad for not removing you yet.

Actually that is a perfectly valid reason.  Thank you for the
clarification.  I (used to) receive 100's of reviews a week for
drivers that either have nothing to do with me or because I conducted
some basic clean-up / fixed warnings, etc.  Since I changed my email
address, things have improved a great deal, which is why this stood
out.

So I believe that patch was written to support one of the Lenovo
laptops booting in ACPI mode.  Please see sdm845_acpi_reserved_gpios
for reference.  Please ensure your patch does not break this
use-case.

Bjorn (who has now reviewed) would know this best.

-- 
Lee Jones [李琼斯]
