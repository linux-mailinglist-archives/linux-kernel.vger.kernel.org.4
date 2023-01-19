Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B60674B16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjATEoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATEne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:43:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F8BAF35;
        Thu, 19 Jan 2023 20:39:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E2EB82605;
        Thu, 19 Jan 2023 16:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8674C433EF;
        Thu, 19 Jan 2023 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674145783;
        bh=2CGo6MUeSZ7cSbKHwltFF0tzdR+/UGsGolPUn92FYuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j47a+lFNk0FfSt9ALeU5fk9lrc84iRnIhQQSN/Pd1ocUaaj294V8UYniRT5lc6Ame
         GLust0H/eL1qxiHzh5aICEvQkE5lKvpTvzmYEmFpv5V9p1c4ZGXHqEf4Snb4kwamvX
         1Sc6pUyKkudmqYXEefWAi4Mfz+oBN5oG7obR1rj8iAYa8HNdeDBHmUSEONJlt7u6U/
         AOUXva3aM2LiCh6tNoS8TtCBXD0CQQP67DrEFOS8Quo6spm5OPXNvXrZsEXlcQCQ4W
         ALppT3Dm2zi/bCxgBYry1J320cIsJ7NGs1kiImcL7JjlDuAb+5d1i/n+9lYKERD5vX
         UIJj6/tNBMGBg==
Date:   Thu, 19 Jan 2023 16:29:36 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd/syscon: Add resets property
Message-ID: <Y8lv8FyaI0RPXVuC@google.com>
References: <20230105005010.124948-1-jk@codeconstruct.com.au>
 <20230105005010.124948-2-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105005010.124948-2-jk@codeconstruct.com.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Jeremy Kerr wrote:

> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. This change adds the `resets` property from
> reset.yaml#/properties/resets (referenced through core.yaml), specifying
> a maxItems of 1 for a single (optional) reset descriptor.
> 
> This will allow a future change to the syscon driver to implement reset
> control.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
