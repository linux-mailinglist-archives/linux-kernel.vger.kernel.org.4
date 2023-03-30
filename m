Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7A6D0C89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjC3RTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjC3RTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36523DBF5;
        Thu, 30 Mar 2023 10:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE7D362120;
        Thu, 30 Mar 2023 17:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1624C433D2;
        Thu, 30 Mar 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680196737;
        bh=1LeBbleOCYcy9cFdM70WZ9DDOCH0XV/JPlHXpaI5JEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUpxhbXlnlcr8wrSFDFWiHzEp05KmlgPa7UlngjkD4OaLd+NxwbRo6Vas131VM9bo
         eyWi38UORkBXjKE71wIb1YxQvYVQijaaviYS9UOju+L0W2aUYKEo9L+asfv6TCsxCa
         arOpTjDgwOoL3OizYxGh9KtLA0XzR7kcJwXvL9bEUmqL+k4ogZvNVhlgev33lCPJbh
         +FGKaXk5Xx5Cu/EZwhZbbmc1OeOEl2yi3mkO1dmzpzqZevHuwgIUjYMUapdUvqPcSC
         iC3bB1lGA2OqoiKwV5mVp6dK+zkYCCzCBMzPl6H7YNSMXcBoYpbCowPbyPjbk5Rpr0
         BwVqDusDexozw==
Date:   Thu, 30 Mar 2023 18:18:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: leds: aw2013: Document vdd-supply
Message-ID: <20230330171851.GE548901@google.com>
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
 <20230320142103.3440-1-linmengbo0689@protonmail.com>
 <ea673f62-f462-a559-d0dc-0662efc60f9e@linaro.org>
 <20230330114633.GD434339@google.com>
 <5eb0b699-47bb-ebb7-2ea5-0cf05ccf29ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eb0b699-47bb-ebb7-2ea5-0cf05ccf29ab@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, Krzysztof Kozlowski wrote:

> On 30/03/2023 13:46, Lee Jones wrote:
> > On Mon, 20 Mar 2023, Krzysztof Kozlowski wrote:
> >
> >> On 20/03/2023 15:22, Lin, Meng-Bo wrote:
> >>> Document vdd-supply, a regulator providing power to the "VDD" pin.
> >>>
> >>
> >> No. This device does not have VDD pin. I checked in datasheet.
> >
> > I'm confused.  This patch set much do something?
> >
> > I guess a better commit message would help.  Let me request that.
>
> There was a v2 - with a discussion - so we wait for v3 which clearly
> indicates this is supply on controller side. IMHO, this is still wrong
> because it is controller's property, not device's, but Rob gave here
> green light, so v3 with proper explanation would be fine.

Understood, thanks.

--
Lee Jones [李琼斯]
