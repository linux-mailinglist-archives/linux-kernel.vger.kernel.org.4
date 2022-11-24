Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25952637E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKXRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKXRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:24:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480A55A8D;
        Thu, 24 Nov 2022 09:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DA2620DD;
        Thu, 24 Nov 2022 17:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CEC433C1;
        Thu, 24 Nov 2022 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669310650;
        bh=sLYI5P+ZMh6NxKkyycCPNxF1W3y95huQkPC5wh9Z+BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHDCmUPTpdPyA5Tg3IK3OXznFOan1VCT1MRQ7qhxKjwENU5j79bPbPmpg52mY7V4Q
         HyCBH9cYFLtacgn5jrDMs8doE+XfDPwtPAPrWi7RcA1ZoQ1Fx5OXFZJDXMtXyh/xbS
         2ZbP5pyTgRsoSQamSIRkehcXlvAuvN0XRMWZZHLfqpQGmcWOC0N2BGiJgf7nLGzm/Q
         e7leJylr/PZeYM4kyxbyHQ3VbLIsyNTNr9bzy1DPRGX0XnLppzqjJnZR8j8bbG6aGA
         TWuXq1D33eelYRx2froKY8e/SJ54Bq5+TOcvcy30IqDpsLjHcIJ3Ynm8Dc0PpKUSj2
         fNSP+pVlolX/g==
Date:   Thu, 24 Nov 2022 22:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom-qmp-usb: drop sc8280xp reference-clock
 source
Message-ID: <Y3+otgofTu8izmgz@matsya>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111093857.11360-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-22, 10:38, Johan Hovold wrote:
> The source clock for the reference clock is not used by the PHY directly
> and should not have been included in the devicetree binding.
> 
> As the new SC8280XP binding has been merged for 6.2, we should get this
> fixed as soon as possible.

Applied, thanks

-- 
~Vinod
