Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652D36FEB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjEKFoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbjEKFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:43:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89E4695;
        Wed, 10 May 2023 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UQgMCGljUJ7oMQ6mf0JD66p8AV+Pricx3j0/87/rFdI=; b=WFSwWicA7I6QjunjDTmUY/mBBw
        +OdqCiSVAaq7AwaAq4xZwY4gnB6pwGU8tQc4ONz5S15zuLHUMQbn7bCAh3yX9KB2tW33Fi5qb/eNS
        Ibs3/aYjdR4ROBC4C6Rcpqz7tTp98buzqxNITntt/3+CYEKoWUPKu1fqkOB1mC8XuReJAS68gGjkX
        SnsCLss8J9Y/ITZE3AKEDHYnQq5uWprxBpTvPQ/Uqqza8xGPleWXp7iK7hqmV9R01T8UVSQ5XW2JU
        69Cz2ghJ3IVIrfmd8Mmi5c3t55/GrzzZ2POKZ4HVXMJUOrderW05675mtR+tt6C9dnZIJSO7lzZG2
        /az9cJXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwz5E-001cjL-19;
        Thu, 11 May 2023 05:43:20 +0000
Date:   Thu, 11 May 2023 06:43:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     sumit.semwal@linaro.org, gustavo@padovan.org,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf/sync_file: Use fdget()
Message-ID: <20230511054320.GL3390869@ZenIV>
References: <202305051103396748797@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051103396748797@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:03:39AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget() use to fdget().

NAK.
