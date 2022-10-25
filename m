Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96660D26B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiJYRYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiJYRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134613DE0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 945C561A56
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25F9C433C1;
        Tue, 25 Oct 2022 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666718684;
        bh=lRDe6mwjhPn7J61JXXwHsCNe1A76EBCUIZYYfOKlSHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao6FLjwQu+bhereJ1gJzeqiQcKFRq9tekXZpuU3/NZhL115cTjgVetfn1Dbtfkwuc
         bAmlHu20p2jujGA96eYc/0DywrFKaR7i1MT0tPw54YuvMdEQT9GNVpwtU3R6EYGAOs
         6Ev+AQmZmHSRXNLtpCsQw5Gx8prueBI7nnDsXqx8=
Date:   Tue, 25 Oct 2022 19:24:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v4 2/6] staging: vt6655: refactor long lines of code in
 s_uGetRTSCTSDuration
Message-ID: <Y1gb2WmbYTD7aGWk@kroah.com>
References: <cover.1666605225.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666605225.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6a307052d3a354a850a502e509f46baccdbe1e.1666605225.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:01:48AM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_uGetRTSCTSDuration

Again, you wrote a changelog comment that is too long, for a patch where
you are fixing up too long of code lines.

Please fix.

thanks,

greg k-h
