Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6707304E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjFNQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49542121;
        Wed, 14 Jun 2023 09:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD776445B;
        Wed, 14 Jun 2023 16:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3E6C433C0;
        Wed, 14 Jun 2023 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686760133;
        bh=taHlfmTHbyA4kjnhWhKMvypSdQkfUB5XeJCmI6Q5t3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0QWpBBCidDmBCUd6r5tpmeo/JVlfBdrfrFcslRpAOQktdBN9IsHS7jZC0SYXqmsiP
         GWkVwSxka46pkbiC5GVJK6TLKdcBLoeP/9ia1jAI6fWd+iZHfb9fN/ZRrBDy/ZWwBy
         Cza3iN9hYxwF5Nq3o9KmRyyEMx5j086fzA5jqrvg=
Date:   Wed, 14 Jun 2023 18:28:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpss: Fix missing check for return value of
 pci_get_slot()
Message-ID: <2023061402-resilient-chafe-3a24@gregkh>
References: <20230614153226.117768-1-cymi20@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614153226.117768-1-cymi20@fudan.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:32:26AM -0700, Chenyuan Mi wrote:
> The pci_get_slot() function may return NULL, which may
> cause null pointer deference, and most other callsites of
> pci_get_slot() do Null check. Add Null check for return
> value of pci_get_slot().
> 
> Found by our static analysis tool.

Please read Documentation/process/researcher-guidelines.rst for how to
do this properly.  Until then, we obviously can not take these types of
patches.

greg k-h
