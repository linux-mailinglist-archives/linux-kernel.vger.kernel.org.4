Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A55F38BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJCWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJCWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:21:20 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F366352E5C;
        Mon,  3 Oct 2022 15:21:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CA6898ACAB2;
        Tue,  4 Oct 2022 09:21:05 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ofTo7-00FIZp-FA; Tue, 04 Oct 2022 09:21:03 +1100
Date:   Tue, 4 Oct 2022 09:21:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Stephen Zhang <starzhangzsd@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20221003222103.GM3600936@dread.disaster.area>
References: <20221004072302.345bfd4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004072302.345bfd4a@canb.auug.org.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=633b6053
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=7-415B0cAAAA:8 a=XUpTMShAIXX1mNgMT1AA:9 a=CjuIK1q_8ugA:10
        a=-f18ZA1R998A:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:23:02AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   ece9d1c54c23 ("xfs: rearrange the logic and remove the broken comment for xfs_dir2_isxx")
>   7ee7a280ea9d ("xfs: trim the mapp array accordingly in xfs_da_grow_inode_int")
> 
> are missing a Signed-off-by from their author.

Say what?

I just pulled them w/ b4 via their msg-ids. Have a look at the email
here:

https://lore.kernel.org/linux-xfs/20220918065026.1207016-1-zhangshida@kylinos.cn/

And the commit information from the XFS tree says:

author	Stephen Zhang <starzhangzsd@gmail.com>	2022-09-26 10:36:11 +1000
committer	Dave Chinner <david@fromorbit.com>	2022-09-26 10:36:11 +1000
commit	ece9d1c54c23c316219c19c4c7091495007e149b (patch)
tree	f4bc7747e2b604cf7718c584126e3e9bc8d5a51a
parent	7ee7a280ea9d3208c075151b06190630b8c20775 (diff)
download xfs-linux-ece9d1c54c23c316219c19c4c7091495007e149b.tar.gz

xfs: rearrange the logic and remove the broken comment for xfs_dir2_isxx

xfs_dir2_isleaf is used to see if the directory is a single-leaf
form directory instead, as commented right above the function.

Besides getting rid of the broken comment, we rearrange the logic by
converting everything over to standard formatting and conventions,
at the same time, to make it easier to understand and self
documenting.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Dave Chinner <david@fromorbit.com>

----

The commit matches exactly what was sent to the list. It's just
that the patch was sent from a personal email address with a
corporate signoff.

Since when has that been an issue?  I -personally- have been doing
this for well over a decade and I'm pretty sure there are lots of
other people who also do this.

Hence if this is wrong, then we've got a tooling problem with b4.
Why does b4 allow this rather than warn/fail if it's not actually
allowed in the linux-next tree?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
