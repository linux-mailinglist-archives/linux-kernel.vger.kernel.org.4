Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37726D050F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjC3Mmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC3Mmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:42:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54576A6;
        Thu, 30 Mar 2023 05:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 414BCB828B6;
        Thu, 30 Mar 2023 12:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3703C433EF;
        Thu, 30 Mar 2023 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680180147;
        bh=8ljhk+gS4RLw7KgzR295UUFEWiAH/g4lZHGORdKR5Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kxu5n2ocEgar0oYCuVKDeHs6PORlO50xNwtUxYP0rzBb+YEKi1HoeAhtNn4mIEL5H
         ma6hZal2GJCMgVnEWoV2EhiLNU6WzPtrf48/XgFjHaqaSnJbyjWUPOhKi/2A0YKhch
         BiN8OKj15vzmMQleKiSiMV74Y6WpyE8fsfneQKJt+6VVsI1ls0S98QCeIvMLtIGdkT
         CskX+nYs/gspjax9puDLwqIbuCIPsLgKAPOzWWgA/B42CcxsCsokk1Dw6KO97eMIFT
         2B2sBx20zlCdOadg4V0e5fzXfh1DuIwto+9AcIuh3UB4X1ShRhG3q2BHFdou5ZI4TT
         6JlVwtQZioqmQ==
Date:   Thu, 30 Mar 2023 13:42:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] dt-bindings: mfd: Drop unneeded quotes
Message-ID: <20230330124221.GJ434339@google.com>
References: <20230322173519.3971434-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322173519.3971434-1-robh@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Rob Herring wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/canaan,k210-sysctl.yaml      |  6 ++---
>  .../bindings/mfd/google,cros-ec.yaml          | 22 +++++++++----------
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       |  2 +-
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  2 +-
>  .../bindings/mfd/rohm,bd71815-pmic.yaml       |  2 +-
>  .../bindings/mfd/rohm,bd71828-pmic.yaml       |  2 +-
>  .../devicetree/bindings/mfd/wlf,arizona.yaml  |  2 +-
>  .../bindings/mfd/x-powers,ac100.yaml          |  4 ++--
>  .../bindings/mfd/xylon,logicvc.yaml           |  4 ++--
>  9 files changed, 23 insertions(+), 23 deletions(-)

I made the subject message a little more unique and ..

Applied, thanks

--
Lee Jones [李琼斯]
