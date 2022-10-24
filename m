Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC3609F36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJXKkV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJXKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:40:16 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE033B463;
        Mon, 24 Oct 2022 03:40:11 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 51226AB064;
        Mon, 24 Oct 2022 10:40:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id E2CF96000A;
        Mon, 24 Oct 2022 10:40:03 +0000 (UTC)
Message-ID: <6b9b7f9d835a271312bd5955d96b83bd14c9e6fa.camel@perches.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
From:   Joe Perches <joe@perches.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Oct 2022 03:40:01 -0700
In-Reply-To: <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
         <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
         <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
         <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: r4mtm9zbjpfjaacgghcjpwpq8aruqopy
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E2CF96000A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+NCoWF+QkD4EYH2wNG31bmSVo7//aomnU=
X-HE-Tag: 1666608003-170265
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 07:24 +0000, Vaittinen, Matti wrote:
> Hi Joe,
> 
> On 10/24/22 09:52, Joe Perches wrote:
> > On Fri, 2022-10-21 at 14:23 +0300, Matti Vaittinen wrote:
> > > Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > >   MAINTAINERS | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index cf0f18502372..3ab9c5f97dfe 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
> > >   F:	include/linux/mfd/khadas-mcu.h
> > >   F:	drivers/thermal/khadas_mcu_fan.c
> > >   
> > > +KIONIX/ROHM KX022A ACCELEROMETER
> > > +R:	Matti Vaittinen <mazziesaccount@gmail.com>
> > > +S:	Supported
> > > +F:	drivers/iio/accel/kionix-kx022a*
> > 
> > How is this "S: Supported" without an M: maintainer?
> 
> I am currently paid to work with the Kionix/ROHM upstream drivers. Hence 
> I add 'S:' to ones I am looking after.
> 
> The ideology why I have 'R' and not 'M' is summarized by my earlier patch:
> 
>  >> I can also add myself as a maintainer instead of a reviewer if it better
>  >> suits iio maintainer. I however don't plan setting up my own public
>  >> repository and hope the further patches will be merged via IIO tree.
>  >>
>  >> So, as Geert once explained to me - In that case the difference between
>  >> me as a maintainer vs. a reviewer would be only really relevant to the
>  >> subsystem (in this case IIO) maintainer. The subsystem maintainer who
>  >> merges patches is allowed to take in changes acked by downstream
>  >> maintainer w/o obligation to do thorough review. (Downstream 
> maintainer is
>  >> to be blamed if things explode :]). If ack is given by a reviewer, then
>  >> the subsystem maintainer has the full responsibility and should always
>  >> do the review. Or - this is how I remember our discussion went - feel
>  >> free to correct me if I am wrong :] In any case - please let me know if
>  >> you'd rather see M: not R: in front of my name for the kx022a.
> 
> This seemed to be fine with Jonathan:
> 
> https://lore.kernel.org/all/87ac9a5e-b5ba-82f3-c00c-75d5e6f01597@gmail.com/
> 
> I've also written a longer version of this in an LinkedIn article:
> https://www.linkedin.com/pulse/should-you-linux-kernel-maintainer-matti-vaittinen/
> 
> (I enjoy writing small stories. So doing an occasional small LinkedIn 
> articles on working with the upstream is kind of an hobby for me.)
> 
> Anyways, I don't see a contradiction with 'S + R' compared to 'S + M'. 
> Well, please educate me if I am wrong :]

The subsystem is one thing, someone outside of KIONIX/ROHM may be
supporting the subsystem.  If this _particular_ driver is "supported"
there should be an individual listed as its actual maintainer, not
just a person that might review submitted patches.

	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.

"this" is this particular driver, not any subsystem "above" it.
