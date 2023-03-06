Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5466AC935
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCFRGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCFRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:06:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523846188C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD8D60DD0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6F7C433EF;
        Mon,  6 Mar 2023 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678122327;
        bh=SzGuuldXDSypwzcSvDtfrNS0kCnjIS0XQ+ud/id4d/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8/tBAoT+YYRwYkiVKxurweDU2/y9Fys1/QQX0dkcYyAzwunuAXlJF1wsm8jce4jm
         mEijJxqfVNyWM/ttz7vCMqmrHdAI5fMGSukA533TxiDXOfQSmcIBOgKjjRdtS0McRa
         YIrEnoaWjTKacUiPH3K4YXYH4Ws3FWj4dBZxCgTdr3O4wr2xkXHK+L7VWkqkZzCE06
         Ntd/15wQF3h93Z/kg9qB+hQsZCfm8B69mihF9s8CvhXvNuWvOVBd1pOUMEfCtALbXz
         F3lXLh3hUSdjyJ8LihTL0s/Uhna0SrLswNPUpERb4KteGHhWZVaOaxe9qnO+oPt2p0
         2sTJ7cVtwQ98w==
Date:   Mon, 6 Mar 2023 18:05:21 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] shmem: update documentation
Message-ID: <20230306170521.fphuzhblaxjzs4r6@wittgenstein>
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302232758.888157-6-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:27:57PM -0800, Luis Chamberlain wrote:
> Update the docs to reflect a bit better why some folks prefer tmpfs
> over ramfs and clarify a bit more about the difference between brd
> ramdisks.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
