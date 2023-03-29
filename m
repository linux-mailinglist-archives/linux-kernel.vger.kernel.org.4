Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63316CF0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjC2RRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjC2RRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:17:42 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84139126;
        Wed, 29 Mar 2023 10:17:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D5357378;
        Wed, 29 Mar 2023 17:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D5357378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680110261; bh=BGG/uIHYnOzF0ono2kbW+HeIrfKt11QT8bEELbMG11g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RL715xBMG27ao6GRi94EK571XzuQw+jhp4r0d8Mbih8o49eOQsn+hKDl8kb3AyYDi
         7fzPwo/F6H2lvsKNn+ZrWmAh3g3EH8AJV0V7JYqHM/Xe+RW6Y6vXm+Oy6Lwdo7PM6Q
         RBiQ8PH5nOziJnAnU5liGic+LvM6OpiYI5QpPHkDSVDwHTETsbH2h3bqYOgfzCAQMU
         Fs/PKk6LpYIizryN/vfvBwxrqsq/iRsWb6896hD2EU0JxU5vtylqtmWVCW/HMMALmD
         sdnPwH5wZ/isC+FSLbwK1cK+VCn606hOD/rxnaJtXI5xNRoQOxwll7w0FEEXMJS2tf
         kA3UMygljsOng==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>
Cc:     Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Documentation: kernel-parameters: Remove meye entry
In-Reply-To: <20230315100246.62324-1-bagasdotme@gmail.com>
References: <20230315100246.62324-1-bagasdotme@gmail.com>
Date:   Wed, 29 Mar 2023 11:17:39 -0600
Message-ID: <87sfdniij0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Commit ba47652ba65523 ("media: meye: remove this deprecated driver")
> removes meye driver but forgets to purge its kernel-parameters.txt
> entry, hence broken reference.
>
> Remove the entry.
>
> Link: https://lore.kernel.org/all/202302070341.OVqstpMM-lkp@intel.com/
> Fixes: ba47652ba65523 ("media: meye: remove this deprecated driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  This patch is based on staging-next tree, because the driver removal
>  touched drivers/staging/.
>
>  Documentation/admin-guide/kernel-parameters.txt | 3 ---
>  1 file changed, 3 deletions(-)

Applied.  I trimmed the hash in the Fixes tag to the normal 12
characters to keep checkpatch from whining...

jon
