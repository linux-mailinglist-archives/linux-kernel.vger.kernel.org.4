Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7673B21C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjFWHvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E7AC;
        Fri, 23 Jun 2023 00:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF896199A;
        Fri, 23 Jun 2023 07:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E5C433C9;
        Fri, 23 Jun 2023 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687506696;
        bh=9VFdWVWwbLn3p4J2wrXDQnimbA5VKMS6GfKhZtNReWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F04qvja89062lB4KpZKrixU6yrFcScQMDlpDniy24qATMPPdk6Su5h3fzlbYJ7qRi
         5mUmF+BEdwBdPvdGc4SNLqTJcBMTWfG1AKtPMEhz/s9RbMzOZ0Ub3qBuhUa77Lrvpn
         U/NuARBRW1XkRS5KoKeO1L7bordg0Ml9Qgbg+FZI=
Date:   Fri, 23 Jun 2023 09:51:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the
 string
Message-ID: <2023062345-hassle-septic-b8b4@gregkh>
References: <20230622150423.3726894-1-kyletso@google.com>
 <20230622150423.3726894-4-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622150423.3726894-4-kyletso@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:04:23PM +0800, Kyle Tso wrote:
> The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.

Why?  Are you getting warnings about this?

thanks,

greg k-h
