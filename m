Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427156BC910
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCPI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCPI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:27:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD6B5B60;
        Thu, 16 Mar 2023 01:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9664B8203E;
        Thu, 16 Mar 2023 08:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB789C433D2;
        Thu, 16 Mar 2023 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678955184;
        bh=NgUS58GmW+i8yIfVrY1drApGw1/rlD4OS5rKuGglrbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsApAqpZm4vtw/O1LSs5lgI95u9llxrl4wtn38Y0BX2hoQrkMLJ6MybP5qjA2WtgF
         gWwiu2U2O+c4DqPvMuRLmfqQhBXDV8bS1ixwsiVYP8+oYnNapqIkarRMJCRhrypolj
         hMhivaOiA5Lz8I19gEznyDBFmLeVF2LaaeN7IXf4=
Date:   Thu, 16 Mar 2023 09:26:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Documentation: submitting-patches: Disqualify style
 fixes from Fixes: tag
Message-ID: <ZBLSrXrxrV4dRjak@kroah.com>
References: <20230316082034.14191-1-bagasdotme@gmail.com>
 <fe15da9c-d03f-ccc3-ea6a-2b6401496aad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe15da9c-d03f-ccc3-ea6a-2b6401496aad@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:23:28AM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2023 09:20, Bagas Sanjaya wrote:
> > An interpretation of submitting-patches.rst regarding Fixes: tag
> > interprets that the tag can be attributed to all kinds of issues
> > (including coding style ones). However, from the discussion on Outreachy
> > mailing list [1], Greg noted that the tag should not be meant for
> > patches that fix coding style issues.
> > 
> > Clarify the position on the doc.
> > 
> > Link: https://lore.kernel.org/outreachy/ZBFPnZbvdI46Ah6r@kroah.com/ [1]
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 69ce64e03c70f8..564418e42ffc01 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -568,6 +568,9 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
> >  patch candidates. For more information, please read
> >  Documentation/process/stable-kernel-rules.rst.
> >  
> > +Note: Fixes: tag is appropriate only for real issues (e.g. reported bugs
> > +or compiler warnings). Coding style fixes should not bear this tag.
> 
> I think it is pretty clear already. The doc says:
> "If your patch fixes a bug in a specific commit,"
> 
> and you are now repeating this.
> 
> Coding style is not a bug, but that's obvious.

I agree, let's not make this file even longer than it is if at all
possible.

thanks,

greg k-h
