Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FED739836
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVHgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF71992;
        Thu, 22 Jun 2023 00:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A4061774;
        Thu, 22 Jun 2023 07:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C30C433C0;
        Thu, 22 Jun 2023 07:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687419378;
        bh=ZWrCFgqmihuCMGRJGk9CO+Jii1OUP8eFbh80OhazlUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogM3vez/qRJpKBep/KOgroBr/ESUIpzWzXciLJyYQ1OmRNAb7ewv5k1qx+u9TzlMB
         w0REC0fe/cZmb01bnsJyiLfXeI+5lgJoaLaoCyH7gQHAlpEdMEEqH8wiEESxL2P7jk
         fgWjstFhmEA9VMDd81kdaE/Zi2f1gilXub2TXCK4=
Date:   Thu, 22 Jun 2023 09:36:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tim Lewis <elatllat@gmail.com>
Cc:     osmtendev@gmail.com, open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
Message-ID: <2023062256-walnut-pettiness-f4dc@gregkh>
References: <CA+3zgmsC2qKph_wDfknSa5eq6EnJqxzzj4K7G4_ZxGr5ZQTqbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+3zgmsC2qKph_wDfknSa5eq6EnJqxzzj4K7G4_ZxGr5ZQTqbA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:25:52AM -0400, Tim Lewis wrote:
> Is it intentional and acceptable for dmesg to now log 14 "Failed to
> create debugfs directory" messages?
> 
> I assume it's related to "regulator: Fix error checking for debugfs_create_dir".
> 
> dmesg 398 lines: diff ./5.10.184-rc1-dirty.txt ./5.10.185-rc1-dirty.txt
> 19a20
> > 12V: Failed to create debugfs directory

Do you also see this issue in newer kernel releases?

thanks,

greg k-h
