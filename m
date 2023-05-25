Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8F710AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjEYLXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEYLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:23:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33038A3;
        Thu, 25 May 2023 04:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8C1644EC;
        Thu, 25 May 2023 11:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27048C433D2;
        Thu, 25 May 2023 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685013810;
        bh=W7wlD+IHC8RXCDrHAZUMoJQSoR45E2axZWzfPYa6p58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFCBIiqURyfWVEObng7jUTK57iS9/2MhyAeFmV1PKxnQL6uas9LdZEa0H2p+rFJKE
         jMkKQLLIVQEW1eJC+fXNzsg/21uCnVR26lPpm7DgZBHTkcLSNSjtdMOBkhOAWDlJXP
         C+tmfYqd/h95DafkdshR2YuHub4oRTG47JFuAoqMzOSLxnjaVo6vpjSczH/0N1bZHN
         CsUqELmYJOT92S7Bnu0dJ+Rw55trpcbIffmvdySFp9o+moA+QmZKACz2Hd+VncOFPQ
         wHP7S7rJf3IhAlXZqoHbsjacQXdN62lFRf40RTIUxY4SzHrinZcidMQmibjGRwf5ZC
         Ls2/M+aqk1txg==
Date:   Thu, 25 May 2023 12:23:25 +0100
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: qcom-lpg: document PM8550 compatible
Message-ID: <20230525112325.GF411262@google.com>
References: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522-topic-sm8550-upstream-pm8550-lpg-v1-1-f016578d9e63@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Neil Armstrong wrote:

> The PM8550 PWM modules are compatible with the PM8350c PWM modules,
> document the PM8350c PWM compatible as fallback for the PM8550 PWM.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 30 +++++++++++++---------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Doesn't seem to want to apply.

Please rebase onto:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next

-- 
Lee Jones [李琼斯]
