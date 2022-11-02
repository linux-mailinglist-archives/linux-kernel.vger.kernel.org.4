Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6F616FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKBVbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKBVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE8DE0AC;
        Wed,  2 Nov 2022 14:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D7F61C35;
        Wed,  2 Nov 2022 21:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DBAC433C1;
        Wed,  2 Nov 2022 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667424671;
        bh=uj1On4sityXve9n4oIzQfWoyfP20tL7E6nqXIQO6hhw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=oYtrJabWAjMaLg5J+fC3o6K0oFCrEWf26yhgKJCiSrdQtwF+TJCOjcouJBAOSzI3x
         4fTtxtWi9RvoQAr5P5aVrzeTur9p8up8mJOvRCejPHrizZex2j4HYwGsgdawOakUhU
         JGevFV4YUbIZOnYgsjHP8+bVNBxm4z8gTY+YoEtLoqnCk0e6AWJHVX378VaXDHEbNi
         viPEqUpSe39UNJ4NkcCfMkTvexrizdxXxTw2PQfj/NbRXoQ1cVmcBVMRhK1vuIBt/w
         nh+I68opL2yfL6mXlYSZ37gQkzgja4t27OiDJQdu4mqqhvJNlinU/ZSy7j1TlKqCP2
         bkcQiGQWgh92Q==
Message-ID: <2854316e-0874-c8f7-b090-96217dd4a4e5@kernel.org>
Date:   Wed, 2 Nov 2022 17:31:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [v3 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221102083601.10456-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 04:35, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 48 ++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++++
>  3 files changed, 188 insertions(+)

You sent several versions and still did not Cc me...

My previous feedback applies.

Best regards,
Krzysztof

