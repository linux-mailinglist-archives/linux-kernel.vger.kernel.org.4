Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C1710B68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbjEYLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEYLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E212F;
        Thu, 25 May 2023 04:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 578926451E;
        Thu, 25 May 2023 11:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D35C4339B;
        Thu, 25 May 2023 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685015314;
        bh=MExGojQkgxoeIHiIHcvzGSzC19ymT1IWiQQd/Qw53Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxfXio6w5BwU67iRTvPfYGISqfMsH+uaZwNaueJd/7lYUtbkf8EcHroOKtgyIZSRq
         jROwYmWuM7uS+vebz3BMjavM+MeggRKC1DzgbbtzZx/dKCVLdTJo42Qfams1Wg71hs
         R++2SypL56h12eek3+PdSgZvaw7gXoFdvhttPflhGalK7Xy5rWu/IsX2IuAsTmdEoD
         Ul0Mx5hquBDCJ4ZYt0C4ogbYD9DQiNe0gNsPgebY6SzTPEpT8lE6eAIgrOC7pjd9kA
         RJV3ZFEAM5wTZoenLjAXjRBA6cuTOUg9LdLnmq53PTFo00e1Rz6bziEYYsxInsmhej
         v9eHV6/jmEgpA==
Date:   Thu, 25 May 2023 12:48:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Documentation: leds: Add "rgb:status" path
Message-ID: <20230525114827.GM423913@google.com>
References: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
 <20230414-pmi632-v3-3-079d2cada699@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414-pmi632-v3-3-079d2cada699@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Luca Weiss wrote:

> The path /sys/class/leds/rgb:status is already widely used with the
> qcom-lpg driver and others. Document it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/leds/well-known-leds.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
