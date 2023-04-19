Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3A6E797B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjDSMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjDSMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D57ABA;
        Wed, 19 Apr 2023 05:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16F363E66;
        Wed, 19 Apr 2023 12:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF20C4339B;
        Wed, 19 Apr 2023 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681906606;
        bh=vOvpQ3+rrqqBbRbFydKvDIk2cD9E7nojPBzJyQmBXk0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cyhuUwYyxGrRnhpnJNKUmB2sLN+ILUiL3k2p5uymTI8TyF0qlEXMrFD/ScUc0oMrZ
         GOa8Ej1IygCtjkQV9HJv0GQGQxkYh5W9CpLWS7CQaoe7zd32g5AdBtj6wQAs1fsvMe
         Xs3Yl9QM6E8HFxjlMUcL2pWsHc4VWOWTYEPojmby9HP/la1IRfQGwQFOwJBrk5O0BT
         wPW/vT2Ni3Xycgzc4bsdZLQvzK74iY8ps7WJ3B3wZrHnnC7mjCjALIgrDQbAsoizpK
         2Ex2gBSZISO3GMmoZw9W47dCcMUd7JOqs3/ytj5AGxM5FQ3g4m2dSZ8haQwWdXEb/A
         tEwzrAuO2vtYw==
Message-ID: <8744edbb-45f9-d4c5-245b-6c820512a981@kernel.org>
Date:   Wed, 19 Apr 2023 15:16:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Add SoC
 chip ID
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230418010019.1222431-1-nm@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230418010019.1222431-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 04:00, Nishanth Menon wrote:
> The system-controller node also contains the chip-id node that is used
> to identify the SoC specific properties. Add a pattern property to
> match to the same, and add to the example.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Reviewed-by: Roger Quadros <rogerq@kernel.org>
