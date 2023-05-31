Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B071884C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEaRRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEaRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D147101;
        Wed, 31 May 2023 10:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8037637A7;
        Wed, 31 May 2023 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99BFC433EF;
        Wed, 31 May 2023 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685553456;
        bh=Lc9aV1jEt8i3CdEwvzcpzynje9AUAwOlZQfhVg31Ui0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lqyKcCNCNDSOuaSlBhCWudrOfjCWmceoKXpNUISZa1dw/gYquNx7W+dToOPJfX83n
         soLPEOPyb2q9bJHwpk47oOEDEEocGmcBj2Mg0qr3nz65iqGuAVw9G3iVz+KLcO6yi0
         oAqZHlwX6Rlw9IUkPlGokJ92Wx6kl1ALusae6c0/HFGWbd3c5eSqz+c/aqyorePB+I
         m2fdiXhXLvEhnWs9mEKZvigaaN/2EeE979MfZkkJCmgDKUb5unONGSWkDg4dmPHngz
         gjftnyPMCZeaFsuCnTZgQe6AyQlj5PU7CdcqMDmawlkau+jruHWamcc/nTUSTxooi6
         NH/x1NT38fyZA==
Message-ID: <bf776d38-00ea-f256-2b20-b0aca9b5a577@kernel.org>
Date:   Wed, 31 May 2023 19:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence
 watchdog to yaml
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        radhey.shyam.pandey@amd.com, git@amd.com,
        neelisrinivas18@gmail.com, srinivas.goud@amd.com
References: <20230531052812.2221823-1-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230531052812.2221823-1-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 07:28, Srinivas Neeli wrote:
> Convert cadence watchdog bindings to DT schema format using json-schema.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Best regards,
Krzysztof

