Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33845BF835
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIUHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIUHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:50:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA464F388
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82FAEB81055
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34316C433B5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663746621;
        bh=nVIQxsI1fDK6fXn9zNbWd1QMba1kdG0XRFSh5nV6HV8=;
        h=From:Date:Subject:To:Cc:From;
        b=thUkHxVCjYu82LJhVtAbgKj5l+kx1dKwyCRGe2PL0HXfLBrJmy2dy5oVgnmO9+FOJ
         wlNGEvI+Eu9OToFcm5fmrDIwndb2/cj+NilaE2i8IO6Ah4obooRY6N044nOcNcOMS2
         RJgRoaFWq6YMfFyr/eCZPvKOJBFtdeoU7FERtI7BNNivSwxc/N1XYb6p3XquFg+Q+e
         816gnO7z5F2TwxPottDa/A9zzB73rhHYOf3rVGKtwsum56RAuYHzMuuEy7wEamhRcl
         9hzFkyZHLJP+NJy/BLjmyGbeMYQHY2QXtNaWIQidGP9evPbqkQwZcuTs9y0KyywwOb
         b1ROFWjrUxSfg==
Received: by mail-ot1-f51.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so3396629oth.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:50:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf3UeTXLGGz4iX/xd/mqFIA42s1Yyo8VlEvWnthUhQZMDQsktUTe
        yCCVKsEnYSFzXqYeStp5KAE2+h5moHoD6oCD0B8=
X-Google-Smtp-Source: AMsMyM60zxGFkKQfMHKedmO+VXjF1y625raOQPUAdapQBfu9n3jGkg3W45NArjRWCRjQjrL4FatZpYIV3O7TJx6V9ic=
X-Received: by 2002:a9d:da6:0:b0:655:dd4e:7afc with SMTP id
 35-20020a9d0da6000000b00655dd4e7afcmr11680961ots.339.1663746620280; Wed, 21
 Sep 2022 00:50:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Wed, 21 Sep 2022 00:50:19
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 21 Sep 2022 16:50:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ns2vr_JHJ9ZBvS43Mng2s-xDoV_4rMz2kvJf65zs16w@mail.gmail.com>
Message-ID: <CAKYAXd-ns2vr_JHJ9ZBvS43Mng2s-xDoV_4rMz2kvJf65zs16w@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.0-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v6.0-rc7. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 4c612826bec1441214816827979b62f84a097e91:

  Merge tag 'net-6.0-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-08-25
14:03:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.0-rc7

for you to fetch changes up to 2e9ceb6728f1dc2fa4b5d08f37d88cbc49a20a62:

  exfat: fix overflow for large capacity partition (2022-09-04 09:38:40 +0900)

----------------------------------------------------------------
Description for this pull request:
 - fix integer overflow on large partition.

----------------------------------------------------------------
Yuezhang Mo (1):
      exfat: fix overflow for large capacity partition

 fs/exfat/fatent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
