Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736077195E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjFAIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFAIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291B12F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9321461CE1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA94C433D2;
        Thu,  1 Jun 2023 08:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685609090;
        bh=3w3vmVOiVOSwq89LqXs+KywCndxXLf9hKX+g+h8HTzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3xQ0yETPtsHnwVdHaM9/zYQPT3N7Klq5UG6I0la0Jx/lFib+xUwcnM+fQLymvDss
         dcvz6OgNOTldlS7mS4y7yvabN17vA38grTOv2sMODIQrx0puhPaRoG9+IPFereuRAp
         da45jzqrKpoJkg97vbisiXfMQTQmRUfy7Fe7MqEs=
Date:   Thu, 1 Jun 2023 09:44:47 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI fixes for v6.4
Message-ID: <2023060125-reconvene-prankster-c014@gregkh>
References: <f8506bf66b8bdaa85b5a2bec48bcdcc6a2853da7.camel@intel.com>
 <2023052904-platypus-mower-0e01@gregkh>
 <1693fe7002af39c4efc899a6e60dbafc906d6b25.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1693fe7002af39c4efc899a6e60dbafc906d6b25.camel@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 08:34:21AM +0000, Winiarska, Iwona wrote:
> On Mon, 2023-05-29 at 14:53 +0100, gregkh@linuxfoundation.org wrote:
> > On Mon, May 22, 2023 at 09:24:26PM +0000, Winiarska, Iwona wrote:
> > > Hi Greg,
> > > 
> > > please pull PECI update for Linux v6.4.
> > > 
> > > Thanks
> > > -Iwona
> > > 
> > > The following changes since commit c21c0f9a20a963f5a1874657a4e3d657503f7815:
> > > 
> > >   Binder: Add async from to transaction record (2023-05-13 20:38:12 +0900)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-
> > > fixes-6.4
> > 
> > This includes some random Binder changes that do not belong in my
> > char-misc-linus branch right now for 6.4-final
> 
> Sorry - I based it on char-misc-testing / char-misc-next.
> 
> > 
> > > 
> > > for you to fetch changes up to 849b391254bf64796655868dbb6dee23551ff7d3:
> > > 
> > >   peci: Constify struct peci_controller_ops (2023-05-22 22:16:16 +0200)
> > 
> > Why is this a bugfix that needs to get merged now?  Shouldn't this be
> > for 6.5-rc1?
> 
> It's a small fix - it can wait for 6.5-rc1.

Great, send it now as a patch?

thanks,

greg k-h
