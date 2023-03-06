Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6406B6AC951
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCFRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCFRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CA64AB8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4527161047
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C8C4339E;
        Mon,  6 Mar 2023 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678122400;
        bh=qGdVAD4ZkJ8tf7kr29quaFsf4ncMyN1P1BEMi/uGyZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f90ZNGNUeDRqh7KYRadR5jHUcHCaMA+cx6zqvk3k3YAvXwlyYwTnZEXFYR7Q6zBYl
         gU8qwICJ7gQqTr03jUcpJpl0Y2ml3YqJo9wRlNpN5SHWsUnqsa3GYpyfqYVqm0zH52
         dbCLXgvCajopkfhWvndAwjatOIlk3PIW2KW9Nv7l63tWOIW1tEwmwCzuu2CaQURK7S
         eYzmeyMk+b2A81QmV+FwBtlUpB8VaM72zhgPRD7kvfDvoYw0XNjF5z+4f20swXcKH+
         HCfoRB7DX+aRTcu8+x6Frt7mkZBYKgHKY/n3ObR1eE1nkO19vbS3LPoWGT0nGAtg25
         eXvmQ2DAnFzlg==
Date:   Mon, 6 Mar 2023 18:06:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] shmem: set shmem_writepage() variables early
Message-ID: <20230306170634.logjdhk7z25sivpn@wittgenstein>
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302232758.888157-3-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:27:54PM -0800, Luis Chamberlain wrote:
> shmem_writepage() sets up variables typically used *after* a possible
> huge page split. However even if that does happen the address space
> mapping should not change, and the inode does not change either. So it
> should be safe to set that from the very beginning.
> 
> This commit makes no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
