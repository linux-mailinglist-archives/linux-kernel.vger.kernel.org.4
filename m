Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03311669044
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbjAMINv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbjAMINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:13:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B434262D;
        Fri, 13 Jan 2023 00:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5236662231;
        Fri, 13 Jan 2023 08:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398CCC433EF;
        Fri, 13 Jan 2023 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673597497;
        bh=DJouDT5lhPUbU7anaQI3h0jmuQGiHZvzy1TF8vdqLbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cC4GXKs1uAhxo4jHFGJrBIVvOlBUpnn3TsYxxkupYC1jhNg5dBa4TCQSFxvBuuDyd
         qNfVmqTolmY7h1mXpwyzFJtHLGXhYj5hpxJbJ46qvqRkuMqnDOGX2iq1Wl2OKQIl6k
         W4ITasqcS8Q05Pmh779uygdHcz4ZipZb4SOq2zQQsjWgDR3IRG35SZjeFbfr3UmJ8g
         vPwRF/wfDiMHG8gE2Ej6JNMIO3uVJIt9JBV78vp5P11JQAAY33MQ/Eudag6enremfY
         0rjdN3wsJjJeRjxhgqP/OVeS4LnbRrdXDPRJFN4U4dYDHIThiHBBpYRuLKZxAbOnxM
         BjueR1WOmL2rQ==
Message-ID: <13262366-49f3-2a34-6772-9500461512d4@kernel.org>
Date:   Fri, 13 Jan 2023 09:11:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 2/6] dt-bindings/thermal/mediatek: Add dt-binding
 document for LVTS thermal controllers
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-3-bchihi@baylibre.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230112152855.216072-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 16:28, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You skipped several lists and maintainers. Resend.

Best regards,
Krzysztof

