Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC464AB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiLLXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiLLXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:01:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D01580C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154C761267
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C7C433EF;
        Mon, 12 Dec 2022 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670886082;
        bh=9oAgjcdDOYAHUDkoGMnxE/ESGaH+GAmrrh+m5qqxu00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmBZCjpYmZak8jMVAv7HENvrL+ypajMzY+nHvmi1I3fGWSkjFL3EQ1Pin5euLoH7O
         9MHcga12zkzVQymQw5Sn+0KiVady2ch3jeKGRI/61f9LYWKYQc+m5XSAPF+9QEZHhG
         /u40MRTpOTODV8Ay1+qXErV5BUQPJ3daK3dw3hbnaW0dIg0F9HUvoWheKDVwZ/QERg
         5ZA38QvasZ9it/7RuoNAiKxj4QSy15/Pa/szer2s1MVM/1bD1nwrS1pjI8uEZTX5hU
         LG1tgWdxOtUvLEUog/McIOaYGvoCvbvIyNoNsNMTuMcrkkityIx0lxkzDDgGpqOF2R
         OG7lbWGCdzgKA==
Date:   Mon, 12 Dec 2022 15:01:20 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add iostat support for FS_DISCARD_IO
Message-ID: <Y5eywH6M+2si0fRE@google.com>
References: <20221212054706.65579-1-frank.li@vivo.com>
 <5cc534fc-1192-887a-91e1-2f1c2283b212@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc534fc-1192-887a-91e1-2f1c2283b212@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check the previous comment.

On 12/12, Chao Yu wrote:
> On 2022/12/12 13:47, Yangtao Li wrote:
> > Just like other data we count uses the number of bytes as the basic
> > unit, but discard uses the number of cmds as the statistical unit. In
> > fact, the discard command contains the number of blocks. In order to
> > avoid breaking its usage of application, let's keeping FS_DISCARD
> > as it is, and add FS_DISCARD_IO to account discard bytes.
> > 
> > Suggested-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
