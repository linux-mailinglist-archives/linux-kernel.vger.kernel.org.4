Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB55D5BD8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiITAhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiITAha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:37:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923742AD4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E171B81680
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CF3C433D7;
        Tue, 20 Sep 2022 00:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663634246;
        bh=heePZ7QZ8vqdl1z91+kj41jIj0IOXSC9O4w358wTHLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDHdzC0KC/PA0taYnCBU7pDQQr0CSYsb46eQNyYxWyzyamXbvUJWl2YOpNOwqWK4w
         j0ubfpjeczF/oXFV/TiWq9TpRJwWFCewsiXEJcBzIMY/NAxiT9QYyW14wZWzFoDPRf
         7+ffx8VSg+XFv9m3yIwc4BlABZo5QI6MMV7l+0hHtinJFF7+vpKEd8FNsNSPW6C25V
         jksh/jnp8yFPiPPtSOY1kiqtFCV7q1ODrF2hfjgW2xMbm2rQq5zxk4Ya4W3aVDC6li
         tlMfrzJKMKBF5w+mUbRNZFrv1b4Xz8pkbFiuy7rH/COQFK+MwQIfiRegM88CJBMyGF
         /4QdVouLrQcAQ==
Date:   Tue, 20 Sep 2022 08:37:13 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jiangshan Yi <13667453960@163.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Message-ID: <YykLOUfit5r6cqxq@debian>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        Jiangshan Yi <13667453960@163.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
References: <20220919023314.3622391-1-13667453960@163.com>
 <YykIOg0ApQycqOxu@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YykIOg0ApQycqOxu@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 01:24:26AM +0100, Al Viro wrote:
> On Mon, Sep 19, 2022 at 10:33:14AM +0800, Jiangshan Yi wrote:
> > From: Jiangshan Yi <yijiangshan@kylinos.cn>
> > 
> > It is better to use __func__ instead of function name.
> 
> 	Why is it better?  And why is it *not* sent to (active)
> maintainers of fs/erofs?  I'm not going to apply that behind their
> backs and I would ask akpm to abstain from taking that one.

It's efs although it also starts with letter e and ends with fs ;).
I have no idea who actually takes care of it now.

Thanks,
Gao Xiang
