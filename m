Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E125BD8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiITAws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiITAwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:52:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05843A4A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GsyuJEyGTQUlcJnmfE1YJDF2mpgzgHgl9QFEIz41eSg=; b=ZUYfVRyU5HRVCB81/GeQDjmsps
        zT9aLLTOwK4WyTqRuXJwkesEX24nzFepsywlptDLoTWmHETqjC94C6ZTc3JXW48x9JS+51FnWYdeD
        MO8spSzjqg180h328hEcpjvIxps6I1p2ipk+NtegFnfwBCpw9MfcD9dGZSLb7C+0wUcJHMfevSO3S
        i+V0bsNM19ELWN1xBNglhlx4wbsZAGADHSh3AaQGa4mq+XK3YWAq5pMClXssphuJSZ4xic4BgDYeh
        09xt5ntzCNCn5rYJvt3bgAy1EnMffWgoNJTxc0umJGrTeg/nrC9BTW5xqYbgivC1jhP2qZoIQmjhh
        qELCrMgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaRV6-001Q9E-3C;
        Tue, 20 Sep 2022 00:52:37 +0000
Date:   Tue, 20 Sep 2022 01:52:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jiangshan Yi <13667453960@163.com>, akpm@linux-foundation.org,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Message-ID: <YykO1A0CDGwsEDZT@ZenIV>
References: <20220919023314.3622391-1-13667453960@163.com>
 <YykIOg0ApQycqOxu@ZenIV>
 <YykLOUfit5r6cqxq@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YykLOUfit5r6cqxq@debian>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:37:13AM +0800, Gao Xiang wrote:
> On Tue, Sep 20, 2022 at 01:24:26AM +0100, Al Viro wrote:
> > On Mon, Sep 19, 2022 at 10:33:14AM +0800, Jiangshan Yi wrote:
> > > From: Jiangshan Yi <yijiangshan@kylinos.cn>
> > > 
> > > It is better to use __func__ instead of function name.
> > 
> > 	Why is it better?  And why is it *not* sent to (active)
> > maintainers of fs/erofs?  I'm not going to apply that behind their
> > backs and I would ask akpm to abstain from taking that one.
> 
> It's efs although it also starts with letter e and ends with fs ;).
> I have no idea who actually takes care of it now.

*blink*

I plead obscenely low caffeine blood levels.

And I'm still not taking that patch - IMO that kind of stuff is absolutely
pointless from anyone other than active maintainers of some code;
the rationale for using __func__ is based upon the possibility of
function getting renamed, and that's not going to happen on inactive
codebase.

IOW, *if* somebody is starting a serious work in that area - sure, might
as well throw that kind of change in, as part of the series.  Other than
that, though...  No.
