Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7253B619DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiKDQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:55:28 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BB2F8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667580912; bh=hK6mqgJ+sOVpRgVX06v+zmV4Tw1LFEgTKYWKc1OCxOU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=KMvnN5sopXVCGeEFEYViuop2afWaMmcxcYKF3G8fuUNrIhtTayo0N/FTszpEii0iD
         lwsUr/CswOSCtaRWP+O6nKx+s8xTj2bAXJFtu88rekt/qX6+qR0OSG0Mrtsh5I6XlX
         YAFNMdRPLUP0TRmWXKTw/DjFVcL2CL11JUfquGxQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 17:55:12 +0100 (CET)
X-EA-Auth: /omeScJ7L58w8McXgv460L47f3glzT4opVlNXbZp8Yq58W9dGImxfJjOe3K13s7qAoWmdE4gpkgpUfxlP/b/bTrajVVo0I5h
Date:   Fri, 4 Nov 2022 22:25:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused struct declarations
Message-ID: <Y2VD6qTxXPpuufOo@qemulion>
References: <Y2LYvhr74ng+xFbz@qemulion>
 <e76c5fd4-442b-0f0e-73e8-c17acf11b471@gmail.com>
 <Y2OOM8g0Qj1o6dRI@qemulion>
 <2aeb10bc-178f-836e-eecd-c77f3eb2f0b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aeb10bc-178f-836e-eecd-c77f3eb2f0b5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:19:05PM +0100, Philipp Hortmann wrote:
> On 11/3/22 10:47, Deepak R Varma wrote:
> > Hello Philipp,
> > Thank you for testing the changes.
> >
> > Request (not urgent):
> > Can you please help me understand how do you
> > test such changes? Do we need specific hardware for functional tests? Is there a
> > documentation available to know more about the testing? I am interested in
> > attaching a physical device to my machine and be able to debug and test the
> > changes. Can you please provide details when you have time?
> >
> > Thank you in advance!
> > ./drv
>
> Hi Deepak,
>
> I do have one device for the following drivers:
>
> vt6656
> vt6655
> r8188eu
> r8192e_pci
> r8712u

Wow... that sounds like a very useful set (and a lot of testing time :) )

>
> Minimum test is to measure the transfer speed and see if that is as
> expected.
>
> When I doubt that the changed code is used I use ftrace to see if the code
> is used. But of course I do not test every possibility.

Okay. May be as I gain more knowledge, I will be able to apply it as well. I
hope it will be okay to connect with you in future if an opportunity arises.

>
> I hope you have the money to be able to buy hardware. Without it is not fun.
>
> I would choose r8188eu (USB) or r8192e_pci.

Thank you so much for the recommendation. I will find out the cost and see if I
can buy one of those.

Have a great weekend!
./drv

>
> Bye Philipp
>


