Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9F6ECF55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjDXNj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjDXNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295193DD;
        Mon, 24 Apr 2023 06:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C7A62465;
        Mon, 24 Apr 2023 13:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1E4C433A4;
        Mon, 24 Apr 2023 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682343554;
        bh=rXGRtK2yKJG+bFJVFtymdFMLD3QsZKJnV4GFQWgqO9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXVLzZyRxR0BZBDiD5m/KAHAXK6TRKWn9eek6wdVRyDAWdpq+8jXZ5fQQHnF++opl
         HrQ4alhJxgwhn+9q3JYFFEcTh2KRIDwZb7y5Jqze3XLxo7L4pjySH4JE+gIECj92nx
         FomDgrLNe2ZUCeea7ttNOtfk39rsJVsfww0zwfuo=
Date:   Mon, 24 Apr 2023 15:22:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <Peter.Enderborg@sony.com>
Cc:     Mark Brown <broonie@kernel.org>, Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <2023042431-crook-stable-5749@gregkh>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
 <3164e897-a423-3948-d50a-f2bdd4ad05e9@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3164e897-a423-3948-d50a-f2bdd4ad05e9@sony.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:17:09PM +0200, Peter Enderborg wrote:
> On 4/24/23 14:53, Greg Kroah-Hartman wrote:
> >
> >>> We can do things with the debug information without filesystem enabled.
> > What exactly do you mean by this?
> >
> >
> We can read out data from kernel with a ramdumper and analyse with crash.
> 
> See https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide
> 
> If it is useful or not I can not say, but the dws->regset. is lost and can not be read with a post mortem debugger.

What is "dws"?  What is "regset"?

What is the root problem here?

confused,

greg k-h
