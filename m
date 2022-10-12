Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA165FC6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJLNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJLNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6A3910E;
        Wed, 12 Oct 2022 06:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B2A61525;
        Wed, 12 Oct 2022 13:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E212FC433D6;
        Wed, 12 Oct 2022 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665582091;
        bh=gS9wxuRyVQOOebK7MIwLmtqB4zEv1W61TkcfnxFrAzY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VaPCfZrrRSpbp0FpZmR1OJ4MlXTMM58CVhb6JBzhst2KoQINIjDTsKQWs70AoHBvD
         M3bC/U76FQYv5IWdX5jE/b+99vF002V9IJHUXShTnyBH3KxhdYLGlq5SnPpwvJEaIO
         g+aj+AeUvIP1GdNd7dFgfUGjRkMGHKJESwegLjIZamG0JgzjA7MQT6IqKo67n3ZQYM
         inTvLp4QLgLGjDYCe06AvlHXrh9a0jLXF4Kd/NXxU6MkBwsQBxkjT3D9E1dNFPeukW
         JEVYEdoAsah/bqeMc5y3XiF9K5cDtR0wjjE9jrJhDzOpGj60odsNvUFKiKKTEXMScx
         4EauRhKk9PsTg==
Message-ID: <bfb59645-17fe-eba9-e244-9e5b639ce2dd@kernel.org>
Date:   Wed, 12 Oct 2022 09:41:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        aakarsh jain <aakarsh.jain@samsung.com>
Cc:     linux-fsd@tesla.com, linux-media@vger.kernel.org,
        pankaj.dubey@samsung.com, linux-arm-kernel@lists.infradead.org,
        dillon.minfei@gmail.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, smitha.t@samsung.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        jernej.skrabec@gmail.com, robh+dt@kernel.org,
        aswani.reddy@samsung.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, mark.rutland@arm.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, andi@etezian.org, andrzej.hajda@intel.com,
        ezequiel@vanguardiasur.com.ar, david.plowman@raspberrypi.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
 <20221011122516.32135-2-aakarsh.jain@samsung.com>
 <166558064414.1937173.2124012536890566845.robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <166558064414.1937173.2124012536890566845.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 09:19, Rob Herring wrote:
> On Tue, 11 Oct 2022 17:55:02 +0530, aakarsh jain wrote:
>> From: Smitha T Murthy <smitha.t@samsung.com>
>>
>> Convert DT schema for s5p-mfc in yaml format
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>> ---
>>  .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
>>  .../bindings/media/samsung,s5p-mfc.yaml       | 163 ++++++++++++++++++
>>  2 files changed, 163 insertions(+), 75 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 

All these must be fixed before schema can be applied.

Best regards,
Krzysztof

