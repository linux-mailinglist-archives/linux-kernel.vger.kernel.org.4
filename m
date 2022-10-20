Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57528605FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJTMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJTMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71CD5754D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7032C61B44
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BD5C433D6;
        Thu, 20 Oct 2022 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666267819;
        bh=GSMUH/eKqQMbqK1l7nYp1UCGLQtEoTNiAh7Rlt1uY9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5A1jK4BQ42KagOR/wKCbGOQlubNCVinPE6Za8e4Bw3EN2DiPX+hcwycpArEZOaZ9
         Fz/PJuEp+b1hq2oi4E1LyAdnZVca234Daq2g5oiyEUkx3K9rnf6xESVp+0NP3fy28V
         L8Y9Uky6xYlkePWpxBPY4E6wFZwdaVxp0kSxlM2k=
Date:   Thu, 20 Oct 2022 14:10:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: Request for assistance
Message-ID: <Y1E6qYkzkRxlloNp@kroah.com>
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <CAOkYk0iU0B98JsH77avky--AS19V=GhQox2f_b4PAG3ZBB+SVQ@mail.gmail.com>
 <CAHJEyKX=yyuyYFajs880CuPdc019dBOm_LCkgXHzjFaA-Jgt2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHJEyKX=yyuyYFajs880CuPdc019dBOm_LCkgXHzjFaA-Jgt2A@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:34:02PM +0100, Tanju Brunostar wrote:
> On Thu, Oct 20, 2022 at 12:27 PM Bhaskar Chowdhury
> <unixbhaskar@gmail.com> wrote:
> >
> > Use forward slash at the end every single chunk or piece of that line.
> >
> > Example :
> >
> > Veryyyyyyylooooooong. Linerrrrrrrrrrrrrrr
> >
> > Veryyyyyyyyyyyyy /
> >
> > Looooonggggggggg /
> >
> >
> > Linerrrrrrrrrrr /

No, please do not do that in normal C code.  That's only for rare cases,
like in a #define, that this style would be needed.

thanks,

greg k-h
