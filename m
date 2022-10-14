Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163C5FE866
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJNF2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJNF2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:28:08 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92A3617D847;
        Thu, 13 Oct 2022 22:28:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29E5Rumk021809;
        Fri, 14 Oct 2022 07:27:56 +0200
Date:   Fri, 14 Oct 2022 07:27:56 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <20221014052756.GA21730@1wt.eu>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
 <20221013161813.GI16609@1wt.eu>
 <406260e46943493781891c480e4f8b17@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406260e46943493781891c480e4f8b17@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:28:10AM +0000, David Laight wrote:
> From: Willy Tarreau
> > Sent: 13 October 2022 17:18
> ...
> > That's also the model where people routinely do:
> > 
> >     $ curl github.com/blah | sudo sh
> 
> Anyone doing that wants their head examined....

Most of the time they have no clue what they're doing, they just
copy-paste installation instructions. You find hundreds of projects
documenting this as the installation procedure, often in the nodejs
world it seems, and the fist complaint in general is not that it's a
bad practise but that it doesn't work on Mac! Random examples from
google's first page:

   https://gist.github.com/btm/6700524
   https://github.com/rclone/rclone/issues/3922
   https://gist.github.com/andrepg/71a15e915846acd41370e275eadb0478
   https://github.com/shellspec/shellspec/blob/master/install.sh

This one looks like a trap, it searches from local vulnerabilities
and suggests to be installed like this:

   https://github.com/carlospolop/PEASS-ng/blob/master/linPEAS/README.md

> I'm not sure I'd trust any source of files enough for that.

That's for a targetted audience.

> Maybe some things get run as root, and maybe they might
> do nasty things, but running random downloaded scripts
> is as bad as clicking on links in outlook.

Yes, or even despite a full end-to-end trust you still have the risk of
a truncated script, which you'd rather not face during rm -rf /tmp/blah.

Anyway we're getting out of topic here.

Willy
