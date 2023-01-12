Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A702A668435
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjALUry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjALUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:47:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97972BF7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F29C6218E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9763C433EF;
        Thu, 12 Jan 2023 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673554567;
        bh=eX5ZWuSUR0K83csyvAk0A5Qj0w1tW4Rflq3o7igZHPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVeaK1rrnQUJiJnEXyPKYCMTJIRAA+nCByqX4rrsA6nvgJqpxSud87HJXZPhrhMg2
         5E5ApLFKjoJjYPkwTfnBRX+4g1WiPh/NWjqaSQW8lQJriAVpkvCDDx0pPYnG9if1qX
         1zFexUjspXKjtna5GI7xf/cX6ralnP44o2wCI2LE=
Date:   Thu, 12 Jan 2023 21:16:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     jan.kiszka@siemens.com, akpm@linux-foundation.org,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, rppt@kernel.org,
        vbabka@suse.cz, x86@kernel.org
Subject: Re: [PATCH v4] scripts/gdb: add mm introspection utils
Message-ID: <Y8Bqg3vbQK53EtlH@kroah.com>
References: <16280f8e-31c9-7b0b-b0c1-4d180c4d0045@siemens.com>
 <20230102171014.31408-1-dmitrii.bundin.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102171014.31408-1-dmitrii.bundin.a@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 08:10:14PM +0300, Dmitrii Bundin wrote:
> --- /dev/null
> +++ b/scripts/gdb/linux/mm.py
> @@ -0,0 +1,223 @@
> +#
> +# gdb helper commands and functions for Linux kernel debugging
> +#
> +#  routines to introspect page table
> +#
> +# Authors:
> +#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.

Please use a SPDX line at the top of the file.


