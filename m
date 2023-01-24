Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E967A607
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjAXWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjAXWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:41:20 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 14:41:16 PST
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FB41B77
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:41:15 -0800 (PST)
X-KPN-MessageId: 0e97acc9-9c38-11ed-afdd-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 0e97acc9-9c38-11ed-afdd-005056abad63;
        Tue, 24 Jan 2023 23:40:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=L6glmyUZ+2dU04cQ2NUrTwJxRoxB4X87X3zHqEOZ5Os=;
        b=IeeXLYXxxyUPqzgOTrTNNQ1T8ynMdOQjoCJ89SZR4BCD/8Y1wDTPmPgw9uHTpqvyn4H3TIv1hpUed
         Bon3e+/iolzyhHX6hZE19DrGw0NlS5ecEowzsjgaon3Vj/dVqUz3WJLrHoyNNY4yGOK/ddpE5ilRNa
         vxdR4ckCWq1z9UO6Km7RKuVJ77BqFFoRbHzMHfCFUDZy6JQfWMBKhwi3sUGIbZfKTamB61frcTucqz
         yGCtX1uRC4WqjEh23ip/T/u5QwhgYGkdhM9KoQugY1EhPwExPDSO+Sv7DEu/z2uwhMjwPCqPIBl+OV
         HWQxm8D9WNZH7NBmsu6otw5Cq79z3gQ==
X-KPN-MID: 33|3KKlKri1nkBL8TqHIcjLzJ2dyGYh/IBaflgv1KjPZL+n1vP5TrzliD3afdeKejM
 cM4dS3z0OA2i37p3mBYRtA0pUMsNTRYTfJmtmD38Iimo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0T69v9+hHuU5aayyAHIu47lf8RCCYCM8CPZMJjsF4QKjVfVCI+8HbKk/nSknk4r
 zH3hg2oOokeegIwLbtqGRfg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 0ee65400-9c38-11ed-927c-005056ab7584;
        Tue, 24 Jan 2023 23:40:10 +0100 (CET)
Date:   Tue, 24 Jan 2023 23:40:09 +0100
Message-Id: <87r0vjmu9i.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     robh@kernel.org, dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, daniel@ffwll.ch, airlied@gmail.com,
        devicetree@vger.kernel.org, hdegoede@redhat.com,
        javierm@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
In-Reply-To: <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh> (message from
        Rayyan Ansari on Tue, 24 Jan 2023 22:19:09 +0000)
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
 <cdf32cb0-4529-6bbd-fdda-ae641d141ee5@ansari.sh>
 <20230123175339.GA2019900-robh@kernel.org> <3d448210-e9d2-b0ee-e009-535bb0bb760d@ansari.sh>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 24 Jan 2023 22:19:09 +0000
> From: Rayyan Ansari <rayyan@ansari.sh>
> 
> On 23/01/2023 17:53, Rob Herring wrote:
> > On Sun, Jan 22, 2023 at 05:25:38PM +0000, Rayyan Ansari wrote:
> >> On 22/01/2023 15:36, Rob Herring wrote:
> >>> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
> >>>>
> >>>
> >>> Why do you need this change?
> >>>
> >>> The 'simple-framebuffer' contains data on how the bootloader
> >>> configured the display. The bootloader doesn't configure the display
> >>> size, so this information doesn't belong here. The information should
> >>> already be in the panel node, so also no point in duplicating it here.
> >>>
> >>>> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> >>>> ---
> >>>>    .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
> >>>>    1 file changed, 8 insertions(+)
> >>
> >> Hi Rob,
> >>
> >> There is the usecase that Hans has mentioned, but I have also mentioned
> >> another usecase previously.
> >>
> >> Adding the width-mm and height-mm properties allows user interfaces such as
> >> Phosh (https://puri.sm/posts/phosh-overview/) to scale correctly to the
> >> screen. In my case, a panel node is not available and the aforementioned
> >> interface is in fact running on the SimpleDRM driver (which binds to the
> >> simple-framebuffer device).
> > 
> > Why is the panel node not available? Why not add it? Presumably it is
> > not there because you aren't (yet) using the simple-panel driver (and
> > others that would need). But presumably you will eventually as I'd
> > imagine turning the screen off and back on might be a desired feature.
> 
> It requires more than using the simple-panel driver: first the SoC side 
> display hardware needs to be brought up, then a panel driver that 
> implements the proper DCS initialisation sequence needs to be written 
> (which is currently not fully known).

You don't really need a driver.  You can just lookup the panel node
from your simple-framebuffer driver and get the values of the
properties there.
