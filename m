Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3596B0E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjCHQIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjCHQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:07:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7755838A9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1939661476
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA98C433D2;
        Wed,  8 Mar 2023 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678291634;
        bh=TkylqFak7vZZsSeE/sFaN6QWkOyeNoj88OqtgJhVEnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnVe4f1U0ySARhRvz0POBdWwCF9g073DYKdRJWFUUAX/dy2tZFhEAm/N0KCaS/E4A
         JawrAG7PJSHqX3dtQDCtY9y9UPhGbX6g4xmc3geCVG3tXoXtEbDrh1LjQ+2hl2/U7z
         gCOdfA6rydggeccce/+8Y5UBVhTgqAqkdGq8PdZI=
Date:   Wed, 8 Mar 2023 17:06:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Remove function
 ..dm_check_ac_dc_power calling a script
Message-ID: <ZAiynpIQKYs246z5@kroah.com>
References: <20230228202857.GA16442@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228202857.GA16442@matrix-ESPRIMO-P710>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 09:28:57PM +0100, Philipp Hortmann wrote:
> Remove function _rtl92e_dm_check_ac_dc_power calling a script
> /etc/acpi/wireless-rtl-ac-dc-power.sh that is not available. This script
> is not part of the kernel and it is not available on the www. The result
> is that this function is just dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> I found a hint in this blog about the content of the script:
> https://www.kubuntuforums.net/forum/archives/eol-releases/-9-10/network-
> support-ai/41269-realtek-lan-connection-timeout
> 
> If you know more about the purpose and the need for this script please
> respond.

Good catch, that shouldn't be there at all.

greg k-h
