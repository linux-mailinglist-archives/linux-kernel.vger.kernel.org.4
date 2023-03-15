Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB36BBB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjCORrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjCORqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DA92269;
        Wed, 15 Mar 2023 10:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C92B81E9C;
        Wed, 15 Mar 2023 17:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963F2C433EF;
        Wed, 15 Mar 2023 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678902369;
        bh=8U1KeZG03Ow3KVU0j15mrAjaqQkBdjzIml80jRNHhkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANYNSWvcC4tu0REcd8AsR2zmRJlRgu0AcZTjW8QczPzNqKA6Jm8MsN0uokYNVEA55
         yPfo0Bkmqc7pPwSTG1LHFvfeNPNuDI6YbFVlo24EBMcxvqTCIMOfn70W47jHQkPZ+r
         65D3LBAhnqZw3Spdii9k7TMfnIiEDNz7SBzd7uCzYL/fw5JQW+n/d5s5ryRwVeRBul
         nxuux9xQ/k+mraa7oMdBN8FQ/JNVl6tNCVQ9hNBY2JS5n3VfKK51rsMFaODQaiAhdx
         oG4KhmZXFIYKo2yu9TDOu6NBRS9LPUT+rtOkuGQWiJVKXFmrQ0RlHUNgFx+EwMUUZ7
         dQp6Sm0ddZ8xQ==
Date:   Wed, 15 Mar 2023 17:46:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Message-ID: <20230315174603.GG9667@google.com>
References: <20230307121246.127425-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307121246.127425-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Naresh Solanki wrote:

> From: Marcello Sylvester Bauer <sylv@sylv.io>
>
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ...
> Changes in V12:
> - Update title
> ---
>  .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml

Applied, thanks

--
Lee Jones [李琼斯]
