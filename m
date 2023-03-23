Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC46C5E60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCWFGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:06:43 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5318B14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1679547980; bh=S+uqErVyJkzz4n1QVzjO1/HkYrFW3SD+hKC0FjAnjpQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ba1lIJSY/bHFjwDpebtoqt9ECrtbQk2RTlB76H82Be6JT9wmTWJaiG3D6XU4N8HZZ
         uO5NOGuhWzHlb20bQf3qYlCHbX9n5d2j7r0KyPWqvVoA2En/MqnFVdAh3FuYzWV3P+
         vseZtjAH1S5HZfLMgOYyRZlmr18FMS9OW8WTEyq4=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 23 Mar 2023 06:06:20 +0100 (CET)
X-EA-Auth: x0hDPzU8TaWpIUg/LIBGQaCa74TJKUC8rvzPKoljQwtzLawHT5P7+rMyNcGYbGDsaUlz0C+kC9tkB9Oa3L284UXtdOJavh1a
Date:   Thu, 23 Mar 2023 10:35:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Alex Elder <elder@ieee.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
Message-ID: <ZBveN3HT96/cktRI@ubun2204.myguest.virtualbox.org>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
 <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org>
 <alpine.DEB.2.22.394.2303212140480.2919@hadrien>
 <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
 <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
 <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
 <eabacc6f-c7fb-ff33-26d1-271537fb4760@inria.fr>
 <ZBvcWkpMJnxea78L@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBvcWkpMJnxea78L@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:58:02AM +0100, Greg KH wrote:
> Nice, that shows that it is the same both ways as the compiler version
> you are using is smart enough
> 
> Which compiler and version is this?  Does it work the same for all of
> the supported versions we have to support (i.e. really old gcc?)
> 
> For the most part, sysfs files are not on any sort of "fast path" so a

Hello,
Is there a guideline/documentation on how to identify if a code is part of
fast/slow path?

> function call is fine, but as I mentioned before, sometimes we are
> forced to move calls to container_of() to container_of_const() and that
> can not be an inline function, but must remain a macro :(
> 
> thanks,
> 
> greg k-h
> 


