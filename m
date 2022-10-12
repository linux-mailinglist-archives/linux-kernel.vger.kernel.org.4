Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF845FBF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLDW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJLDW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:22:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF883042
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8A6B818E9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8143BC433D6;
        Wed, 12 Oct 2022 03:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665544943;
        bh=spFmPBRqcV+GYdNQCmkZ1Bc9xAluaVttej0PBHObPyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJeaFSk5NWnJjKKoBGg03bsM7jPR30b1vODZFWpRe3yoDnC/sgwvM6IP7VmauYtNY
         x9JgzXdm9Wk8LM6AfEPSOCG6Y8hcPR8Vnq+N/uR2ljxe8a/5yeVTz8p5/ypxLsRJLA
         8DpH2qYL6OXe9b7Po8XG4RxX9zCdR+oP9DpBmrUfE88A92eDlxh6EUgGWFjEagXqvw
         fgky8qRSIzFErfuHrSMDh7/aMCviWDGJ9q++OWFyz00sG/YaD1lcOhxpXJGTOGlvcg
         4e5//w3Ss0f1JH/UgMml4/c5NkrWTc9QSw1jSad03jed9y12uNw06XjbaVFx8C4A25
         icn+eAkIGcfiw==
Date:   Wed, 12 Oct 2022 06:22:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] memblock updates for v6.1
Message-ID: <Y0Yy4FkJiZxBskOe@kernel.org>
References: <Y0VHfYkFUqYwVAru@kernel.org>
 <CAHk-=wjogDKrppyQ+NxMn-oBuHfB1qsbbJPLKTxB+2JvXN3L3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjogDKrppyQ+NxMn-oBuHfB1qsbbJPLKTxB+2JvXN3L3w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:37:05PM -0700, Linus Torvalds wrote:
> On Tue, Oct 11, 2022 at 3:38 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock for-next
> 
> Hmm. This doesn't look right.
> 
> Did you mean for me to pull the tag, not that "for-next" branch?

Right, this should have been 

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.1-rc1

>                  Linus

-- 
Sincerely yours,
Mike.
