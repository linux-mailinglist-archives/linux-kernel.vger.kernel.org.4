Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EE67F487
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjA1EGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Jan 2023 23:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjA1EGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:06:52 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E936DFF7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:06:51 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 1279FA0980;
        Sat, 28 Jan 2023 04:06:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 4DE5B6000C;
        Sat, 28 Jan 2023 04:06:48 +0000 (UTC)
Message-ID: <9be6b6d57745452b66c4e96c40ead74cb1eabdb9.camel@perches.com>
Subject: Re: git source files with rw permissions
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 27 Jan 2023 20:06:46 -0800
In-Reply-To: <CAHk-=wgSH8Dqfp2XVTeBrtAxf+2ZN_4pMjYOHwUt9i4NOGTkBg@mail.gmail.com>
References: <1522976022.11185.53.camel@perches.com>
         <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
         <3de4cbc2198105bcbc09ee355cd69a8b8756b89c.camel@perches.com>
         <CAHk-=wgSH8Dqfp2XVTeBrtAxf+2ZN_4pMjYOHwUt9i4NOGTkBg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4DE5B6000C
X-Stat-Signature: zp8cfd3ec84pjuq1bg6m14p6qiymrabr
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19fsniEYXHwkJG8pDga2ndv7TcQf4zabFQ=
X-HE-Tag: 1674878808-41437
X-HE-Meta: U2FsdGVkX1+MbsrCDv9pIc35ay+pNn6jXILJM7eaCmohHnZYPKo87a1WVWnFzry1Zed8vIx5QpPMyWa+h60rlQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 10:19 -0800, Linus Torvalds wrote:
> On Thu, Jan 26, 2023 at 8:07 AM Joe Perches <joe@perches.com> wrote:
> > 
> > Maybe time to do it again.
> 
> Thanks, done.

fyi: there's one more straggler:

100755 07781408e78820ad49d093d4bddcfd14eeadfa39 0	Documentation/devicetree/bindings/sound/everest,es8326.yaml


