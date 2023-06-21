Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B65738204
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjFUJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFUJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21819B;
        Wed, 21 Jun 2023 02:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87099614D0;
        Wed, 21 Jun 2023 09:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D283AC433C8;
        Wed, 21 Jun 2023 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687341223;
        bh=hbYSGhPNihESibj0GLzopXILEUIpPsXw1kgApj2/L9A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J3CSndaeTkQTTZKxs4ETpM4EIwIydrK8+HXZVGJ5rJiIMf95B9/bP8UC5OAUStMdD
         LcKGYNC1uUqIgak8KtT4zO1yRAwEIORHoUFzI63j3NCqu8RT+GC0Z2TjUbeURwmako
         hwf2pZRiNGOPaLEVGOMvkyywPwJ8Zh+39dMUiGlqfsz/HZ9C1GjA58Uu807NoF83YV
         imdezZTKRM3TfW6/FF6k44fY86+JBEIx2fx33T4FX/IPT0HMB5jNlQmc2c4RAbw1K2
         xHbqa0XMSJDO758M8IaF8uy6G5+XKoqGhSmuzFb9IK1HSmDfvJSQwJ9ZCqkO0VKStF
         rHtPcI8vrJm9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: p54: Add missing MODULE_FIRMWARE macro
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616121917.1034761-1-juerg.haefliger@canonical.com>
References: <20230616121917.1034761-1-juerg.haefliger@canonical.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     chunkeey@googlemail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734121983.549389.14943663338589626944.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:53:41 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> Add the missing MODULE_FIRMWARE macro for "3826.eeprom".
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied to wireless-next.git, thanks.

8d0c7e1901d6 wifi: p54: Add missing MODULE_FIRMWARE macro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616121917.1034761-1-juerg.haefliger@canonical.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

