Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73A6D06CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjC3NdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjC3NdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:33:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340D8A5A;
        Thu, 30 Mar 2023 06:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC98AB828BE;
        Thu, 30 Mar 2023 13:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B80C433EF;
        Thu, 30 Mar 2023 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680183187;
        bh=ueJ6g58nonlydTG2XRzsjypG+2jmhKGZXl7ZfODnL/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQSvnufoj1HiOkfAHWXE8F50NbkvxU2+kOshWqBTOV5FOS/JGgHYaT8nFZS2BodsP
         FaGErFJRBM5/+iT489dE0fvJruIKGN51HAJzLRfQklZXc3JJIJRAz9vmj54BAO/xYR
         uP0lnhF+LbcGzHaRRtfyqIsEnYrWY5zj2vCw1LdEtG5cebtqMqo2yTNizMhT3sfhkc
         TcGEUmVNmGyLJUj5DzVN19UuveMexAbZv8isXIhYI09ZDFCJlIiLVqSSE7cC62J/vX
         OHmORfhPNH2FOBnAT93UyDarbyd4IOBvq6CZBAIrRkJF+Ikua7VkNghQrtTRG8VQ4t
         xQAS7U3BSWMig==
Date:   Thu, 30 Mar 2023 14:33:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: simplify disallowing
 properties
Message-ID: <20230330133303.GT434339@google.com>
References: <20230325114353.50293-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230325114353.50293-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023, Krzysztof Kozlowski wrote:

> The syntax to disallow x-powers,drive-vbus-en,
> x-powers,self-working-mode and x-powers,master-mode for certain variants
> can be made simpler.  Also this produces much nicer warning message when
> the condition hits wrong DTS.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks

--
Lee Jones [李琼斯]
