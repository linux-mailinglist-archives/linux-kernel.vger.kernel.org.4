Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730E71F4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFAVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFAVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:45:13 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8619A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:45:11 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 9420d65d-00c5-11ee-b3cf-005056bd6ce9;
        Fri, 02 Jun 2023 00:45:09 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 00:45:08 +0300
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] pinctrl: qcom: organize main SoC drivers in new
 Kconfig.msm
Message-ID: <ZHkRZNpYE8fQNfma@surfacebook>
References: <20230601152026.1182648-1-krzysztof.kozlowski@linaro.org>
 <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601152026.1182648-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 05:20:25PM +0200, Krzysztof Kozlowski kirjoitti:
> In menuconfig, some entries depending on PINCTRL_MSM are indented and
> expressed as dependening but some not, because of other Kconfig entries
> in between,
> 
> Move all main Qualcomm SoC pin controller driver entries into new
> Kconfig.msm file so they will be nicely ordered in Kconfig file (by
> CONFIG_ name) and properly indented as PINCTRL_MSM dependency in
> menuconfig.
> 
> Functionally this is the same, but since entire file is guarded with "if
> PINCTRL_MSM" drop this dependency from individual entries.

Cool idea, maybe I need to do the same for Intel case!

-- 
With Best Regards,
Andy Shevchenko


