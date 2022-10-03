Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75505F2781
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 03:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJCB2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJCB2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 21:28:31 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB73DBC9;
        Sun,  2 Oct 2022 18:28:26 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id B947B16084F;
        Mon,  3 Oct 2022 01:28:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id D2A3C20011;
        Mon,  3 Oct 2022 01:28:05 +0000 (UTC)
Message-ID: <7c6cbef1e9bac94267113a4c722f265b43573810.camel@perches.com>
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
Date:   Sun, 02 Oct 2022 18:28:21 -0700
In-Reply-To: <92ef6be6-dc99-555d-8263-77484b7d0f12@gmail.com>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
         <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
         <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org>
         <Yzen4X1Na0MKXHs9@mit.edu>
         <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
         <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
         <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
         <de5e732e-4857-dc69-a6c1-f0c1d52f99ef@gmail.com>
         <b5731dab6be760fd226097602cf31c610d69bdac.camel@perches.com>
         <92ef6be6-dc99-555d-8263-77484b7d0f12@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: c15sbosoea1tute7j655pjpy7xzaabt6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D2A3C20011
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+H7+Vkcd5CPGjNrRcZXSavSLuzcr1318Q=
X-HE-Tag: 1664760485-274211
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-03 at 10:17 +0900, Akira Yokosawa wrote:
> On Sun, 02 Oct 2022 16:55:05 -0700, Joe Perches wrote:
> > On Mon, 2022-10-03 at 08:04 +0900, Akira Yokosawa wrote:
> > > Hello Joe,
> > > 
> > > Thank you for chiming in.
> > > 
> > > On 2022/10/03 0:49, Joe Perches wrote:
> > > > On Sun, 2022-10-02 at 09:58 +0200, Krzysztof Kozlowski wrote:
> > > > > The easiest to achieve it is to run with --no-git-fallback and CC entire
> > > > > output. However it does not mean submitter must run with
> > > > > --no-git-fallback. It is only for this generic rule - CC entire output
> > > > > of get_maintainers.pl.
> > > > > 
> > > > > If you add such rule "CC entire output of get_maintainers.pl" and do not
> > > > > mention no-git-fallback, some folks will think they need to CC all these
> > > > > people who made one commit to your file...
> > > > 
> > > > false.
> > > > 
> > > > git-fallback is _not_ used when there is a listed maintainer for a
> > > > specific file.
> > > > 
> > > > If there is a use of git-fallback, it's because there is _no_
> > > > specified maintainer for a specific file.
> > > > 
> > > >    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
> > > > 
> > > > i.e.: It's not "your file" if you don't maintain it.
> > > 
> > > Joe, I sometimes see unexpected output WRT --git-fallback.
> > > 
> > > Example:
> > > 
> > >     $ ./get_maintainer.pl -f Documentation/doc-guide/sphinx.rst
> > >     Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/1=100%)
> > >   <-- ???
> > >     Lukas Bulwahn <lukas.bulwahn@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
> > >     <-- ???
> > >     linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> > > 
> > >     linux-kernel@vger.kernel.org (open list)
> > > 
> > > As you see, --git-fallback is used in this case. Why?
> > > It looks strange to me as Jon is listed as a "maintainer".
> > > 
> > > Having "F:	Documentation/" in MAINTAINERS does not suffice?
> > 
> > No.  It's not an exact pattern match as the files below the
> > top level of Documentation are not specifically matched by
> > "F:	Documentation/".
> For me, calling this is "not an exact pattern match" sounds
> inconsistent with the explanation (quoted below) near the top of
> MAINTAINERS:
> 
> 	F: *Files* and directories wildcard patterns.
> 	   A trailing slash includes all files and subdirectory files.
> What am I missing?
> Does this explanation needs update?

Maybe.  Suggest some text.

Read about the pattern-depth entries (basically, it's the
count of forward slashes '/' in a maintained file pattern)

Look for MAINTAINER entries where there are <foo>/*/ entries too.

For instance:

MAINTAINERS-INTEL ETHERNET DRIVERS
MAINTAINERS-M:  Jesse Brandeburg <jesse.brandeburg@intel.com>
MAINTAINERS-M:  Tony Nguyen <anthony.l.nguyen@intel.com>
MAINTAINERS-L:  intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
MAINTAINERS-S:  Supported
MAINTAINERS-W:  http://www.intel.com/support/feedback.htm
MAINTAINERS-W:  http://e1000.sourceforge.net/
MAINTAINERS-Q:  http://patchwork.ozlabs.org/project/intel-wired-lan/list/
MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git
MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
MAINTAINERS-F:  Documentation/networking/device_drivers/ethernet/intel/
MAINTAINERS-F:  drivers/net/ethernet/intel/
MAINTAINERS:F:  drivers/net/ethernet/intel/*/     <<< Here >>>
MAINTAINERS-F:  include/linux/avf/virtchnl.h
MAINTAINERS-F:  include/linux/net/intel/iidc.h

So this entry is show that all of drivers/net/ethernet/intel/<foo>/
are directly maintained.
