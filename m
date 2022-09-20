Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEE5BD8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiITAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiITAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:24:48 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEE11440
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xPCCZtFhO4/9ElHoLG9vT6yQx6BWRaq0LwG/AcBe7IU=; b=qe4krgfYn1noHKvBg0kUBEDbdR
        Cd+rF+JTfMPslVNDKybGwwosN2HKm+9udwnc1oxRTIVQNTViQqJSxXNFQrs2eWx+dqLrd2Og2yokR
        aBRzp+f51f7o27bZqhIh9zRDVX9FjHm1GOcYSm7OV8Qdb8mbIktlldJ9FWYS9UEe5nXbtQogvcjVp
        VlnEGopHTruLX3omebLWiY1ZvM2gM6/HvWxHijKVOuwlWb4DQL+jfXEgJDu8vzfZCjzdW5mc17Is9
        5O/VkUcnj9HPGpLYV5AWo58wMsMHqyUKr+eN4g/omY4+1tm5nW7vmDmwcsPas5N1VptPdnlHFwbSH
        IbmUYCIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaR3q-001PWu-21;
        Tue, 20 Sep 2022 00:24:26 +0000
Date:   Tue, 20 Sep 2022 01:24:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Message-ID: <YykIOg0ApQycqOxu@ZenIV>
References: <20220919023314.3622391-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919023314.3622391-1-13667453960@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:33:14AM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> It is better to use __func__ instead of function name.

	Why is it better?  And why is it *not* sent to (active)
maintainers of fs/erofs?  I'm not going to apply that behind their
backs and I would ask akpm to abstain from taking that one.
