Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD915F2748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJBXzR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 19:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBXzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:55:13 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDAA17AB8;
        Sun,  2 Oct 2022 16:55:10 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 262AC406E5;
        Sun,  2 Oct 2022 23:55:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id A7B6B20027;
        Sun,  2 Oct 2022 23:54:58 +0000 (UTC)
Message-ID: <b5731dab6be760fd226097602cf31c610d69bdac.camel@perches.com>
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate
 supporters should be mailed
From:   Joe Perches <joe@perches.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux@leemhuis.info, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Oct 2022 16:55:05 -0700
In-Reply-To: <de5e732e-4857-dc69-a6c1-f0c1d52f99ef@gmail.com>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
         <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
         <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
         <Yzen4X1Na0MKXHs9@mit.edu>
         <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
         <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
         <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
         <de5e732e-4857-dc69-a6c1-f0c1d52f99ef@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: 739ztpsqp9h6cog7crqsg98xs7trgyy1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A7B6B20027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Zpcgp5sfdCAUOUQAB5sAHQF+3OgtUGCI=
X-HE-Tag: 1664754898-577980
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-03 at 08:04 +0900, Akira Yokosawa wrote:
> Hello Joe,
> 
> Thank you for chiming in.
> 
> On 2022/10/03 0:49, Joe Perches wrote:
> > On Sun, 2022-10-02 at 09:58 +0200, Krzysztof Kozlowski wrote:
> > > The easiest to achieve it is to run with --no-git-fallback and CC entire
> > > output. However it does not mean submitter must run with
> > > --no-git-fallback. It is only for this generic rule - CC entire output
> > > of get_maintainers.pl.
> > > 
> > > If you add such rule "CC entire output of get_maintainers.pl" and do not
> > > mention no-git-fallback, some folks will think they need to CC all these
> > > people who made one commit to your file...
> > 
> > false.
> > 
> > git-fallback is _not_ used when there is a listed maintainer for a
> > specific file.
> > 
> > If there is a use of git-fallback, it's because there is _no_
> > specified maintainer for a specific file.
> > 
> >    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
> > 
> > i.e.: It's not "your file" if you don't maintain it.
> 
> Joe, I sometimes see unexpected output WRT --git-fallback.
> 
> Example:
> 
>     $ ./get_maintainer.pl -f Documentation/doc-guide/sphinx.rst
>     Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/1=100%)
>   <-- ???
>     Lukas Bulwahn <lukas.bulwahn@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
>     <-- ???
>     linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> 
>     linux-kernel@vger.kernel.org (open list)
> 
> As you see, --git-fallback is used in this case. Why?
> It looks strange to me as Jon is listed as a "maintainer".
> 
> Having "F:	Documentation/" in MAINTAINERS does not suffice?

No.  It's not an exact pattern match as the files below the
top level of Documentation are not specifically matched by
"F:	Documentation/".

Just as David Miller is not the direct maintainer for every
driver under drivers/net, Jonathan Corbet is not the direct
maintainer for every file under Documentation.

There are many specific listed maintainer for files under the
Documentation directory.  Jonathan would be cc'd though on all
files in the Documentation directory (save those excluded by
X: entries in his section)

Anyway, git-fallback is used because of the lack of specific
maintainer for many of the files in the Documentation/ tree.

$ git ls-files Documentation | \
  grep -vP '^(?:Documentation/ABI|Documentation/admin-guide/media|Documentation/devicetree|Documentation/driver-api|Documentation/firmware-guide/acpi|Documentation/i2c|Documentation/power|Documentation/spi|Documentation/userspace-api)' | \
  wc -l
2449

Of those ~2.4K files, many are actually maintained by others.

Many are not.  By running a little script, about half are not
directly maintained by anyone.

and lastly:

Using git-blame on that file, it seems to me that Mauro Carvelo Chehab
would be a good recipient too.

$ ./scripts/get_maintainer.pl --git-blame Documentation/doc-guide/sphinx.rst
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:8/8=100%,authored:1/8=12%,added_lines:5/42=12%,removed_lines:6/23=26%,modified commits:25/25=100%)
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> (commit_signer:4/8=50%,authored:3/8=38%,added_lines:12/42=29%,modified commits:12/25=48%)
Akira Yokosawa <akiyks@gmail.com> (commit_signer:3/8=38%,authored:3/8=38%,added_lines:22/42=52%,removed_lines:14/23=61%,modified commits:3/25=12%)
Randy Dunlap <rdunlap@infradead.org> (commit_signer:2/8=25%,modified commits:3/25=12%)
Bagas Sanjaya <bagasdotme@gmail.com> (commit_signer:1/8=12%,authored:1/8=12%,added_lines:3/42=7%,removed_lines:2/23=9%)
Federico Vaga <federico.vaga@vaga.pv.it> (modified commits:2/25=8%)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)

