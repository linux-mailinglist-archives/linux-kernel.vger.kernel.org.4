Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC04A65886C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiL2Blp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL2Blo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:41:44 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1D262C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:41:41 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1322d768ba7so20356150fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5EkBJQD/c68RJVZGXy0HKcVQWj7dlCTAB7HBSkm2xT8=;
        b=VJnM6/MLfCtzy4OB3sFx1Fm7iBipjbNMb2bH5oEcXDaiIJPjND9L+3WJIgG/vFFhdI
         qBuLikVKrZnlHITAQvDh4N3bTmwMcAzQqMSNxpU8NHjF47ldKXk+zimbXI02FFiSUND0
         1+mpRYOhDCWk7W+yndOYj7lJkMeDBUUUPHTw30/zGwHL2GnNTsyScpTJDdPrtW7PCzX3
         GjaShPwnLDygudFk2DbOz3dCPIq0QR9XvNdauuAaFZ7fn5iaWdcM/JZk8OHcsfzXUWlu
         lPRdYCvK3/3MzT+ppjlbYRQ4iIdzfQ1GsoAevaR8JN+alytdO7ZXeSHcjJWh5xdaanAw
         8nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EkBJQD/c68RJVZGXy0HKcVQWj7dlCTAB7HBSkm2xT8=;
        b=kVtju8tfwpFUufexC+hS4A//mzjoxZ4rfps2skMw9SaJsgZdBxaTj7Firh2JrXUUN7
         6MiTudRqNDY0BlIA8r/rUS8lZqcUZfphCOu+91AInTcFiI8efJrz92sV6oxanfvrDnUn
         MwtWrSdfLhL+A6qRki3AjySDdzicy1MZ+GTL5HIxmy0iifp5xFVeMoHQJzKXID0mblCc
         JbNwlw8r0GxbMwc7EXMDV7zbVhSowta8JTFFn9rCF0NP92iueDa+cMC87Pcfusvdtehn
         9XZdRFJQEvc0bRPp8iTG82mD/JC/+WfmOXgYb+EOlIvtfUSXdA6dhyJDBlR9b5EwXBGG
         vrZQ==
X-Gm-Message-State: AFqh2kpEksnjWE159HmgWI3rtnokjNRTcfa+Cb+rLYpNGo2mIGxWndDC
        URUfvsX3E/BWhTj8bI7MY2k0NUecofLwbtuxoGe7aA==
X-Google-Smtp-Source: AMrXdXuwaw7kd2b2t7tpaXaGkV5+98Jws9Pf+vV4ef7pixGviYj7YGU4fswLGw0TrQJnzv3W0zkI3SVwb8V1GdFKOkk=
X-Received: by 2002:a05:6870:fd89:b0:14f:ede2:db25 with SMTP id
 ma9-20020a056870fd8900b0014fede2db25mr909119oab.42.1672278100651; Wed, 28 Dec
 2022 17:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20221220090248.1134214-1-haibo.chen@nxp.com>
In-Reply-To: <20221220090248.1134214-1-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:43:34 +0100
Message-ID: <CACRpkdbmcyO+QMbvAVC7Wm+u3btcAebiGQySSb7jG9J8gYNOnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: vf610: connect GPIO label to dev name
To:     haibo.chen@nxp.com
Cc:     brgl@bgdev.pl, stefan@agner.ch, linux-gpio@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:02 AM <haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current GPIO label is fixed, so can't distinguish different GPIO
> controllers through labels. Use dev name instead.
>
> Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
