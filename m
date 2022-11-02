Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603C615D02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiKBHcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKBHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC602529B;
        Wed,  2 Nov 2022 00:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB7461847;
        Wed,  2 Nov 2022 07:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD82C4347C;
        Wed,  2 Nov 2022 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667374326;
        bh=Sd6R/ym8ws6SxrD/mYxuzF8VqNqBSQDKnssEk4S3V2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbi8L50r+tfSWll0Znbf2IqWd2h8Jzhl89gD3gCpS+eepwf5O7zk5H2NvDyQslIyu
         QUkiM8wM4sE/XGXyxC6Vv1ndXvpVIlAgKXiawWfIudJifZS39JoHeSH/8GuOk8BhcF
         1HVdkqzU5as5Q5V8GY99NQupqRaJ2imXaKBz2Lkm83f9zgJ1kVOpGY4DvHs0eThWZ2
         MjSFyu9nwUxQmeGhI9DjpNCohhP/QWZH9NHM7nEEuPbRgAxYOjHNEzlAlnJ0KyY53X
         QbwIxF2fl95qXPekzPcjsM/1pp3UNGFE4MsICTCLfyU3C2zGQZNMsEMIZ4gFckXaHH
         tsqresGf8fcFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oq8E1-000248-Hv; Wed, 02 Nov 2022 08:31:50 +0100
Date:   Wed, 2 Nov 2022 08:31:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 11/30] greybus: svc: Use kstrtobool() instead of
 strtobool()
Message-ID: <Y2Ic5U176qptH08t@hovoldconsulting.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <ebf1e6988a53a455990230a37cf759ee542ea7ec.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf1e6988a53a455990230a37cf759ee542ea7ec.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:13:59PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Sure, why not:

Reviewed-by: Johan Hovold <johan@kernel.org>
