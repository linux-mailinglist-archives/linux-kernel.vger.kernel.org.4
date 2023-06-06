Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D907E72490D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjFFQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjFFQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9410D5;
        Tue,  6 Jun 2023 09:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F42663585;
        Tue,  6 Jun 2023 16:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8F1C433D2;
        Tue,  6 Jun 2023 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686068761;
        bh=l0TwkmD0wdgbtQLh9PHpe3cthZ6I+Cvy/LxgM83nceQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXwlPtxxrvj4DRGL9PtwAxt/0qqL+5ILgPWfopfjykAEykAiPQPatmOvJrtF99jrp
         7pBmSxH39ziEsCHJtQM9oIfI3XMh/j1+yqMt6xUm6OJB1QhPFxHOJ3IzdA+Ebv/PQ2
         Bkv1Fr2sqmolIcjFVdI0fPFBB8sIv2OVmFjqMpfw=
Date:   Tue, 6 Jun 2023 18:25:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: Stock image illustration (licensing)
Message-ID: <2023060629-monogram-nursing-e9f5@gregkh>
References: <e6047201-7cf1-ecc4-ca68-490142f6f40b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6047201-7cf1-ecc4-ca68-490142f6f40b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:21:23PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Imagine that there is a new Linux kernel contributor, contributing
> documentation patches. As it is the habit from her company, she adds
> stock images from various sources (which may or may not be related
> to the doc), e.g. freepik or pexels [1], as illustration.
> 
> However, on the source file, the image requires attribution. Yet,
> the attribution instruction doesn't mention image license (she
> attributes as "Illustration of foo by bar on pexels"), hence
> all rights reserved. Can that stock image be added to the kernel
> docs (which is licensed under GPL)?
> 
> PS: none is lawyer here.

Then please consult one if you have questions about licensing issues.
Would you ask a lawyer about dental problems?  :)

thanks,

greg k-h
