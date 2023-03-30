Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A996D03C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjC3Lry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjC3Lrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:47:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635C97;
        Thu, 30 Mar 2023 04:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EF27B825D9;
        Thu, 30 Mar 2023 11:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27D6C433D2;
        Thu, 30 Mar 2023 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680176799;
        bh=clSL+UGy01ws/HQhz1HCTq8F58A+a5HRjcjs1QoDg7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1NKkrW5bw0MkBPWLr5Gh2hTEqbEUGf0nScpj7+zZtfQAe+9AbDgDPDd+QOA8CHgF
         5+gXNxltDJgblXHxdXrMnXa3dbASpvZQo1RalHjrnljyIe6EGPfZY8GfShKEWmFNrV
         DedfmJ8ChGbe6egCYo6d4dqPMLRadYw1kEGuCanflyd045uzoDoZjZIgCtEStnkzYN
         fZ6zoqAP+Q+rQuhL1s9l+ewdYAnCZWSy301MHmKKXN+5q0FewOPEskWljkz09mJAiJ
         Pcgo14W1GMCawR9tL9hYX9KXuOep4lLDOO8g4A9e88+oWGdMQrX7aX/StgjeH4VzfZ
         gQ1LQNGmwfzKw==
Date:   Thu, 30 Mar 2023 12:46:33 +0100
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
Message-ID: <20230330114633.GD434339@google.com>
References: <20230320141638.3378-1-linmengbo0689@protonmail.com>
 <20230320142103.3440-1-linmengbo0689@protonmail.com>
 <ea673f62-f462-a559-d0dc-0662efc60f9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea673f62-f462-a559-d0dc-0662efc60f9e@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Krzysztof Kozlowski wrote:

> On 20/03/2023 15:22, Lin, Meng-Bo wrote:
> > Document vdd-supply, a regulator providing power to the "VDD" pin.
> >
>
> No. This device does not have VDD pin. I checked in datasheet.

I'm confused.  This patch set much do something?

I guess a better commit message would help.  Let me request that.

--
Lee Jones [李琼斯]
