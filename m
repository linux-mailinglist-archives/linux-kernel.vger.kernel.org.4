Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192FB5FE43B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJMVcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJMVcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:32:02 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC6155D83;
        Thu, 13 Oct 2022 14:32:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 73238100006;
        Thu, 13 Oct 2022 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wotLAn9Y/tgrzdjHHjyX4s8UgxnfSdgqfyh8m/tlV90=;
        b=JoAxFnRjKUppqryZFKpmfQDdXxzfGEEnzaWwwKBB1g64emZZ/TpMAq6gL5j8fr7SZYKrlG
        d0jzYXsBLictduzWoW5HqdWJ8ohWqpYLAVpkFI3hWCgH65MZMw1qodyLVj5QVbicrQtQ/P
        zQ+/Q7W51T1AGhOHAQQExaOHxz+3OJaPRrPkjkdfu8DB0ejvBdNhQavKJToq9+k62lo3Gi
        8Kb7R6TRrYu6kry7/Rl7XJ5/16d6PFOdKAPeNHFeqAvOdNfcHQz7/vqT6szOdm9cCK1DvS
        NfTpOpuGyK8w0EwdJJKQAkMVkxD9reJ6HsZBEqLJSLcD/I6DIxQ5gHfGCr9t8Q==
Date:   Thu, 13 Oct 2022 23:31:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] rtc: jz4740: Use devm_clk_get_enabled() helper
Message-ID: <166569636075.1226796.16519109798726060370.b4-ty@bootlin.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 10:42:29 +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> [...]

Applied, thanks!

[1/1] rtc: jz4740: Use devm_clk_get_enabled() helper
      commit: 94e4603d1a262f8d79f6186d0df0379243613b95

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
