Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF43609FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJXLJA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJXLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:08:54 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3F6DD5;
        Mon, 24 Oct 2022 04:08:53 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 79AD1AB063;
        Mon, 24 Oct 2022 11:08:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 733B02002A;
        Mon, 24 Oct 2022 11:08:32 +0000 (UTC)
Message-ID: <e72efbf7a80cae08041e4ff7be8630044c989c92.camel@perches.com>
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
Date:   Mon, 24 Oct 2022 04:08:42 -0700
In-Reply-To: <57582495-210b-f9c2-db80-e2ddbc76e7c3@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
         <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
         <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
         <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
         <6b9b7f9d835a271312bd5955d96b83bd14c9e6fa.camel@perches.com>
         <57582495-210b-f9c2-db80-e2ddbc76e7c3@fi.rohmeurope.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 733B02002A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: u34dxm34bxifdbdufa5u3fzdrk6yibc7
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18wOOIOmP0JikBbFObxF4cZ4V5fSQ+Yo5k=
X-HE-Tag: 1666609712-932372
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 10:56 +0000, Vaittinen, Matti wrote:
> On 10/24/22 13:40, Joe Perches wrote:
[]
> > 
> > 	S: *Status*, one of the following:
> > 	   Supported:	Someone is actually paid to look after this. > 	   Maintained:	Someone actually looks after it.
> > 
> > "this" is this particular driver, not any subsystem "above" it.
> 
> Yes. And as I wrote, I am paid to look after this driver as well as 
> other drivers I've submitted upstream for ROHM components (Kionix being 
> part of ROHM these days). I have used this Supported + Reviewer 
> combination for all other IC drivers as well. This is why, by 
> definition, the S eg. supported is correct. Question is whether one 
> supporting a driver must be a maintainer? If this is the case, then I'd 
> better review all of my MAINTAINER entries. However, I (still) don't see 
> the problem of having a reviewer supporting the IC.

Please do not conflate a "reviewer", someone that "might" look at
a patch and offer comments, and a "supporter", someone that actively
supports the driver/subsystem.  I don't have a tree that is pulled
yet I am the get_maintainer and checkpatch maintainer.


