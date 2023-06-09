Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CE729320
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbjFII2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjFII1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:27:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4493A85;
        Fri,  9 Jun 2023 01:26:53 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1A27218;
        Fri,  9 Jun 2023 08:26:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E1A27218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686299212; bh=WaPG7DwnD32LkmCEdtCUKddBgRvYsZsun2KNcuARbmo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IVY11HqfRCWDyOg8qljp4qcQBrVLEbTk3NbyrI95aW4rJiUPH8tjdaRnGf1bFPHGe
         eksPRpYTVdTDQE+fh8rfRJJybUC9/ZPZPzZ7tnjuBrACN2m1bQasdsZrN8UhgZmRPO
         k7XkK+aCDH6jpdwJBl/tufpF7j+oIThgllF9rR40t6bmKLAicuxB0uvXC3QvjNpzQ7
         0N2cTKDMImuw6kTAUIsMqZRNeW4ROruDmwIHf3gbMEgVPlJwmDCyjeeF6/s842d/+K
         lswHkiI8g28ex4qgNmUDbKb6N3a/SGrcu6aTcLE8UJCxIgu23ts7kGPwZptHlj1t9C
         SFjVDcy7ApHXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
In-Reply-To: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
Date:   Fri, 09 Jun 2023 02:26:48 -0600
Message-ID: <87edmloxbr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The kernel-doc script currently reports a number of issues
> only in "verbose" mode, but that's initialized from V=1
> (via KBUILD_VERBOSE), so if you use KDOC_WERROR=1 then
> adding V=1 might actually break the build. This is rather
> unexpected.
>
> Change kernel-doc to not change its behaviour wrt. errors
> (or warnings) when verbose mode is enabled, but rather add
> separate warning flags (and -Wall) for it. Allow enabling
> those flags via environment/make variables in the kernel's
> build system for easier user use, but to not have to parse
> them in the script itself.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: - parse environment variables in build system rather than
>       the script itself, as suggested by Masahiro Yamada
>     - fix indentation

So this change seems fine to me; Masahiro, if you want to take these,
feel free to add:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
