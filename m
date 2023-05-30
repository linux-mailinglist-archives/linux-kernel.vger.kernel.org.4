Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DA716091
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjE3MxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 08:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjE3MxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:53:13 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C20106
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:52:43 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 8CFB3ADC20;
        Tue, 30 May 2023 12:52:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 02B452002C;
        Tue, 30 May 2023 12:52:12 +0000 (UTC)
Message-ID: <3b3e3a96c9377a11b3c2e4eb6dbc8f90995e5757.camel@perches.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?=CD=F1igo?= Huguet <ihuguet@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux@rasmusvillemoes.dk, willy@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 30 May 2023 05:52:11 -0700
In-Reply-To: <CACT4oueo817fw31Wk7UXv7bpdSAZfUCVet4JUK1hZ-X6J6m_wQ@mail.gmail.com>
References: <20230414101052.11012-1-ihuguet@redhat.com>
         <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
         <CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiWEebNg@mail.gmail.com>
         <CANiq72njUr2wv7CA7W9ziRUf8mrVQPFEQfS7=it3zTVhJFvf3A@mail.gmail.com>
         <CACT4oueo817fw31Wk7UXv7bpdSAZfUCVet4JUK1hZ-X6J6m_wQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 3gdbx14hmuosbsk6u8rjjp3senmaoi8z
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 02B452002C
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19vwYTya5uk1+HZT83aviU2T+8tjmWjVDI=
X-HE-Tag: 1685451132-109305
X-HE-Meta: U2FsdGVkX1/MAP0Aq3pA1G2n62x0pavIXPr9Gn7wo5vMULBC+58vSH7p1ixZLWosvcvOiaiPUKWFGC0lx58tYA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 09:52 +0200, Íñigo Huguet wrote:
> Not sure what to do with these 3 (sh, bash, pl): a big majority are
> tab indented, but there are some files with inconsistent indentations
> within the same file (i.e. scripts/get_maintainer.pl). Honestly I
> would be tempted of adding them too.

I'd be annoyed.  I believe that file uses emacs perl
indentation rather consistently.  4 space indentation
with 8 char tab, maximal tab fill.

