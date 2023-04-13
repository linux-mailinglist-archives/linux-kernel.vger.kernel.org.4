Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB26E0D85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMMge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FD8A4D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5993563DF1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE1C433EF;
        Thu, 13 Apr 2023 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681389390;
        bh=LoEGX2Z3YUptAb6xSCS3cfhXYCB+E8s+8UgkCA270j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHKmrE7CAAy+w9za97JIYr/o0Co8xfXUUtfcIVx0JjW4PMWhvyIFTNnt5SrXGIYjB
         Qwj/AOAf7T1Cvicndb1gX/831kbY6bBP57agekcwtMkx458Z2pPhOqPFD+TWbmyKA4
         WQ/vywzSXV9HMvqMGJSnTqzxZ9a5naDipiidxtm0=
Date:   Thu, 13 Apr 2023 14:36:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <2023041347-abdominal-bronze-34be@gregkh>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
 <2023041302-uncut-tutor-0e6e@gregkh>
 <CAO+dPF9KFJe5h4wO47ypL2-__3+1mnzurdRcj6OCQ1wdku_7cA@mail.gmail.com>
 <2023041359-marine-uninsured-bae9@gregkh>
 <CAO+dPF-YNtaZvVax8Z1QD9VtG36uc2C=uus4eR4H_vipEzu8Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO+dPF-YNtaZvVax8Z1QD9VtG36uc2C=uus4eR4H_vipEzu8Dw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:34:06PM +0800, Chuang Zhang wrote:
> On Thu, Apr 13, 2023 at 8:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > And how are pid namespaces being handled here?  I know it's just
> > debugging data but showing a pid from the wrong namespace probably would
> > not be a good idea as it might get confusing quickly.
> >
> [chuang] Do you have any good suggestions? thanks

I do not know what you are using this debug information for, nor how or
if Android uses pid namespaces (I think it does?)

Maybe the binder maintainers can help answer this question...

thanks,

greg k-h
