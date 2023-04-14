Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E46E2357
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDNMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDNMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29321AF19;
        Fri, 14 Apr 2023 05:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF7C961FA3;
        Fri, 14 Apr 2023 12:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3919FC433EF;
        Fri, 14 Apr 2023 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475586;
        bh=Y69wMnPQS9vYEGsWc6rHU3GfHiIE/Dgo33xdBBfWBQ0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Vew1os5awK/kNZH7RGwefay6icS6yRfzxH4BJLlyuKm7xLVIPDzRDTO2Kx8S/4bzi
         +Zm6v8hNYVnkBHY7KX1eLVg/lD9oZScQP2Kdo26bNysnCncVP+79XgJfVAKHlfwhG3
         uNHK7A7PzL8S61TSgxd2RNaPGGhXksInvZIAAwmqffARGsHQFknSrNUrpVNy0gQN1i
         dqNbjD8yThQSa+SNZ8vd5CGKXnhLwk+IPIZIWAdJYKLiPxP8hPR5QScaMfnNopUuwX
         NLHY2Gl+v5IYIkd9gKbBRkg2SCryo/jLedFj6+zz1VdIYKw+ti1/nIlmJ4d8guD4y/
         NlUu6NNeDomnA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: Add explicit of_device.h include
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230410232701.1561613-1-robh@kernel.org>
References: <20230410232701.1561613-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147558198.16522.6525405237382366801.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:33:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote:

> bcma/main.c uses of_dma_configure() which is declared in of_device.h.
> of_device.h gets implicitly included by of_platform.h, but that is going
> to be removed soon.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied to wireless-next.git, thanks.

666f4ab26c2c bcma: Add explicit of_device.h include

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230410232701.1561613-1-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

