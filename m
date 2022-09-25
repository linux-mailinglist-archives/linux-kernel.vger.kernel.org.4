Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5895E9635
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiIYVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIYV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 17:29:58 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B894512606;
        Sun, 25 Sep 2022 14:29:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1EFDA723;
        Sun, 25 Sep 2022 21:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1EFDA723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664141389; bh=ONNQd8KveiywOQpmayhqYuyDTEkN0Sy2yVG979SfAkI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oZtmf0byZxxJPGLuHRkzURQXpnqDKVv8MF2U30FW4bMOap1SIymZUzr/Dm+9R+qUF
         IVENjXHONSxYeaLWrB5YZDNGhiXnecvuvgFvlS8E16ciUwNs+VyRwx9hpWCAK/vbPZ
         YVhVF4QT6iKkLJsc59ynxaq9NBJUq53IFwPphemD6fvkmbn+2B25JqGxjjWDLkxdv8
         WW3p2kUKIwP3FnaAz/9KPnbdMC2R2G0iiknY8fDKcFQO8NYMN6CY7Z01V5g0Ysgu1b
         aAkZUXSyRc5zMsuLQDTuEJm9Jvu/mzHDyfHX2QrEToSdTe+0Z+NqTIaQjwbDON2vrq
         6lhQt/uPwhL2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux MM and miscellaneous subsystems list 
        <linux-mm@kvack.org>, Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 5/7] docs: move asm-annotations.rst into core-api
In-Reply-To: <Yy/Q5lcP127z8p3S@debian.me>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-6-corbet@lwn.net> <Yy/Q5lcP127z8p3S@debian.me>
Date:   Sun, 25 Sep 2022 15:29:48 -0600
Message-ID: <87h70vrvlf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> kernel test robot reported non-existent reference ([1]), so I have
> applied the fixup:

Yeah, I get those emails too; already fixed in my tree.  I was clearly
in too much of a hurry to get that posting out...

Thanks,

jon
