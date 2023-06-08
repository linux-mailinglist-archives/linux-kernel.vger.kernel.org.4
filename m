Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD172865C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFHR3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjFHR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AFB1FCC;
        Thu,  8 Jun 2023 10:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24FF464E7C;
        Thu,  8 Jun 2023 17:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBACC433EF;
        Thu,  8 Jun 2023 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245337;
        bh=ThoL6fzVB88JMlcXBLBufAfFLmPNoKStcU+9P8fl0V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx19WCzbYxrT+XlhZtaBIlPEHUm1QDlr6Sh6w9xqkWf4KzzdFvDIzZkR1of82JKx4
         cRReA+mUG3eEax8urHp/GM0WeUEwa61W3M7c0gqM7Qk3TWmQdaITEKRSxRBkb/RKSl
         JyxZFNdA4A69lbV0dkybGQQl0e+E1mGWteRxDRvrwWVKb7RVTA8bo8Y2yJfzsS2r9Y
         py5Q7kbemFRQNNkqw51jREvKGRqsokvhpKngnrVUypjvbJcxPONupB7E7SGehb22v5
         kFdzCPu+yVproPKDBRaRuVRBKbbYM3CXfX+fT2rpOLqT4Xad38m+4K+2mnmiZgI8jl
         VGu3qEoLoROWw==
Date:   Thu, 8 Jun 2023 18:28:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 4/4] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <20230608172852.GK3572061@google.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-5-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524124628.32295-5-henning.schild@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Henning Schild wrote:

> To describe the dependency chain better and allow for potential
> fine-grained config tuning, introduce Kconfig switch for the individual
> GPIO based drivers.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
>  drivers/leds/simple/Makefile |  7 +++----
>  2 files changed, 31 insertions(+), 7 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
