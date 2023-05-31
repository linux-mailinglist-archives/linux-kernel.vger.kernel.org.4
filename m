Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817D7187C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEaQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEaQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112112F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE3860F2F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CFC433D2;
        Wed, 31 May 2023 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685551822;
        bh=c8AM8KsOgUagWlWpj+sTPlk2mJ63kIyZPZfU2JCKe/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyGJrG/IcqOwjR+AcaYiXtoTQ2Et9wksrGooQxTmBaGblalN6ZDWe73W9ipwQ90Rd
         M4qSyc+RfbGWWedmKMGIzK9kYYAqltP834/LRHxwFxbldL3vxNfnvml55jQqs9Ewe9
         Z8Yz5DKpVmK2hMHufKG2ndzxGeTxd51gmwCF2YDE=
Date:   Wed, 31 May 2023 17:50:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [PATCH v6 0/7] refactor file signing program
Message-ID: <2023053148-ahead-overbite-863d@gregkh>
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
 <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
> On Wed, 31-May-2023 20:08, Greg KH wrote:
> > On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
> > > On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> > > Can you please review the latest patch series? I think I have addressed your
> > > concerns. Thanks.
> > 
> > The big question is, "who is going to use these new features"?  This
> > tool is only used by the in-kernel build scripts, and if they do not
> > take advantage of these new options you have added, why are they needed?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for the response.
> 
> We use it in VMware Photon OS. Following is the link for the same.
> https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
> 
> If this change goes in, it will give a slight push to our build performance.

What exactly do you mean by "slight push"?

> Can you please take these changes?

Why would we take changes for something that will not benifit us at all?
You are asking us to maintain code that only benifits your out-of-tree
usecase, which is not how kernel development works (and you don't want
it to work that way...)

thanks,

greg k-h
