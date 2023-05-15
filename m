Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78737032BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjEOQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbjEOQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8192D7B;
        Mon, 15 May 2023 09:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3E362731;
        Mon, 15 May 2023 16:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AB4C433D2;
        Mon, 15 May 2023 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684167553;
        bh=wGmHjULaB4K+d9rVSqKFuZ2TbAXjbfXY9XsUoCw450I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohhblgiF2++69aGSjknukLerRP/MQGOr1owztduLX5ditGEHStBumSO6qS8yGN6Ou
         1c+DN3kHn/TnKuxP7d4u4wdXUV5iEj3J8PZiAYqlbUkBFRq/ErzOlCLjSpFSnRWX0v
         3X18fv4TVt7kSmcb2Ve7GIwbsgY7om/CdhNle7txiMLMSy+9Xn8u9x5lMx1+F4S+Ze
         2Z5GfnMzNsTEG6N5E1HJCxrLcZDDy0LiSavNGGA8DnAPkfNIl0jC7wrCm0e+b4UchC
         SMBxp82hdJUgiJweaneu4HAw4Ci0uJ9k1g5At6f1BLTgGKY/r/grD9JjjalkxWRdw0
         njHOKUCw3aGEg==
Date:   Mon, 15 May 2023 17:19:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     pavel@ucw.cz, quic_fenglinw@quicinc.com, trix@redhat.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: flash: leds-qcom-flash: disable LED when
 changing brightness
Message-ID: <20230515161907.GA10825@google.com>
References: <20230507172941.364852-1-me@dylanvanassche.be>
 <20230507172941.364852-3-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230507172941.364852-3-me@dylanvanassche.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 May 2023, Dylan Van Assche wrote:

> The Qualcomm PMI8998 PMIC requires the LED to be disabled when configuring
> the brightness. Always disable the LED when setting the brightness and
> re-enable it afterwards.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
