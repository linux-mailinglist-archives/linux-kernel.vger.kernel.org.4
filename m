Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149215FDE98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMRBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJMRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:01:11 -0400
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BABE09A8;
        Thu, 13 Oct 2022 10:01:08 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
        by hop.stappers.nl (Postfix) with ESMTP id E82DF20107;
        Thu, 13 Oct 2022 17:01:06 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id 7069B304049; Thu, 13 Oct 2022 19:01:06 +0200 (CEST)
Date:   Thu, 13 Oct 2022 19:01:06 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Olof Johansson <olof@lixom.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Stappers <stappers@stappers.nl>
Subject: Re: [PATCH] scripts: rust_is_available.sh: Provide hints on how to
 fix missing pieces
Message-ID: <20221013170105.kqmdxiuvi3ltnddd@gpm.stappers.nl>
References: <20221004184625.10076-1-olof@lixom.net>
 <20221005072743.vfanu2mgj56wbdmh@gpm.stappers.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005072743.vfanu2mgj56wbdmh@gpm.stappers.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:27:44AM +0200, Geert Stappers wrote:
> On Tue, Oct 04, 2022 at 11:46:25AM -0700, Olof Johansson wrote:
> > This might be a bit bikesheddy, but it saves a few roundtrips to the
> > documentation when getting the `make LLVM=1 rustavailable` run to pass.
> 
> Yeah, I have bin there    :-)
> 
>  
> > Stick to the rustup options to avoid too much verbosity.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  scripts/rust_is_available.sh | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> 
> Reviewed-by: Geert Stappers <stappers@stappers.nl>


How to prevent that the patch gets lost in the mail?

And how to avoid that reminders like this get contra-productive?
(When to send the next "Please approve or reject the patch"?)


Groeten
Geert Stappers
-- 
Silence is hard to parse
