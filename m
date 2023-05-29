Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F70714D87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjE2Pzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjE2Pzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:55:35 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73063CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:55:33 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 3ad30867-fe39-11ed-a9de-005056bdf889;
        Mon, 29 May 2023 18:55:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 18:55:26 +0300
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robimarko@gmail.com
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Message-ID: <ZHTK7uEzO7kcx_cV@surfacebook>
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
 <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 03:58:09PM +0530, Sricharan Ramabadhran kirjoitti:
> On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
> > On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
> > <quic_srichara@quicinc.com> wrote:

...

> >    depends on OF || COMPILE_TEST
> 
>  Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.

Standalone COMPILE_TEST will give you definitely NOT what you want.
And actually it's strange to have it standalone.

-- 
With Best Regards,
Andy Shevchenko


