Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70605B9DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIOOuV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Sep 2022 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIOOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:50:17 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEAA15827;
        Thu, 15 Sep 2022 07:50:13 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E26B1C0012;
        Thu, 15 Sep 2022 14:50:09 +0000 (UTC)
Message-ID: <5d890576d10cda7dbeef48f0eb13aa6860ab7d44.camel@hadess.net>
Subject: Re: [PATCH v1] HID: logitech-hidpp: Detect hi-res scrolling support
From:   Bastien Nocera <hadess@hadess.net>
To:     "Peter F. Patel-Schneider" <pfpschneider@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Thu, 15 Sep 2022 16:50:09 +0200
In-Reply-To: <e9526860-b77e-8cc0-7421-91fe5370918d@gmail.com>
References: <20220914132146.6435-1-hadess@hadess.net>
         <c56c4053388baa5ea3db8bc849c5a420859347f1.camel@hadess.net>
         <e9526860-b77e-8cc0-7421-91fe5370918d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-15 at 10:23 -0400, Peter F. Patel-Schneider wrote:
> 
> On 9/14/22 11:41, Bastien Nocera wrote:
> > On Wed, 2022-09-14 at 15:21 +0200, Bastien Nocera wrote:
> > > Rather than relying on a never-ending stream of patches for
> > > quirks.
> > > 
> > > This change will detect whether HID++ 1.0 hi-res scroll, HID++
> > > 2.0
> > > hi-res scroll or HID++ 2.0 hi-res scroll wheel is supported, and
> > > enable
> > > the feature without the need for quirks.
> > > 
> > > Tested on a Logitech M705 mouse that was unsupported before this
> > > change.
> > > 
> > > [    9.365324] logitech-hidpp-device 0003:046D:406D.0006:
> > > input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-
> > > 0000:00:14.0-4/input2:3
> > > [   57.472434] logitech-hidpp-device 0003:046D:406D.0006: HID++
> > > 4.5
> > > device connected.
> > > [   57.616429] logitech-hidpp-device 0003:046D:406D.0006:
> > > Detected
> > > HID++ 2.0 hi-res scroll wheel
> > > [   57.712424] logitech-hidpp-device 0003:046D:406D.0006: wheel
> > > multiplier = 8
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216480
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > For anyone on a recent version of Fedora that wants to test it,
> > those
> > packages should work:
> > https://koji.fedoraproject.org/koji/taskinfo?taskID=92008550
> > 
> > Cheers
> 
> 
> 
> Using this kernel I tested several Logitech mice - an MX Master 3,
> which 
> already supported hi-res scrolling in Linux; an M310 and an M185,
> which have 
> features but no feature for hi-res scrolling; and an old-style M510,
> which 
> does not have features.  I used evtest to show the events that were 
> generated.   For these mice the patch does not produce any change in
> events 
> generated, as expected, both REL_WHEEL and REL_WHEEL_HI_RES events.

In the future, it would be awesome if you could mention the tested-by
tag as mentioned here:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

As the tree maintainer can then use it directly when merging the patch
in their tree.

So, for Jiri or Benjamin:

Tested-by: Peter F. Patel-Schneider <pfpschneider@gmail.com>

:)

Thanks for the testing, much appreciated!

