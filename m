Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5606CEF80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjC2Qdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjC2Qd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:33:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456A4236;
        Wed, 29 Mar 2023 09:33:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D47537E;
        Wed, 29 Mar 2023 16:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D47537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680107599; bh=vol0vvvhGjAXnQgJjKN6stpyWJ0f2d8ePSYRTCwAwYA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ihosdN4WItM866ffFQWb3ysY0HQ+4JNv0Ex277nQD7s1iwV7Ulo4JTQlIucat+l6b
         0pyoIZazWgoW+FW8biDU68LMOFVKxo2ZXDLEbHBSmVI60VgPV+flrRP8TLZ6p8GXS8
         KNsBbi0iQb73UAuJ9CwRJM6Vw2oZcqVl/JYbG9M5MsCQ3uuth6q20gPlPRKBazMuj6
         PY0hEe3zL1fgFUsj2Y4WJEu9GXMXjlBTVu5tUd7Hp5/K/GnfLFwYXAEVQVTt+idKh1
         Adh78kfNcl+tEwXwBTUnLL14XhtMv4xyQo91CLXdMsR/0OjKC04JjaUnBlpFmCTQwW
         k/qiiTu4H5aOQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-doc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH] ARM: stm32: add initial documentation for STM32MP151
In-Reply-To: <20230329095600.1355049-1-roan@protonic.nl>
References: <20230329095600.1355049-1-roan@protonic.nl>
Date:   Wed, 29 Mar 2023 10:33:18 -0600
Message-ID: <87ilejjz5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roan van Dijk <roan@protonic.nl> writes:

> This patch adds initial documentation of STM32MP151 microprocessor (MPU)
> based on Arm Cortex-A7.
>
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
> ---
>  .../arm/stm32/stm32mp151-overview.rst         | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/arm/stm32/stm32mp151-overview.rst

You will need to add this new file to .../arm/index.rst or it won't be
pulled into the docs build (and will add a new warning).

Thanks,

jon
