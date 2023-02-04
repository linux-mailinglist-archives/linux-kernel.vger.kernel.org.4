Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5868A98A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBDKo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjBDKop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:44:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666B1CADA;
        Sat,  4 Feb 2023 02:44:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so288536wmb.2;
        Sat, 04 Feb 2023 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ly5ijQBNFVq3smW6orlt5Wr7gXwIy9zweHNGHA83Ufw=;
        b=IpiF50O/epVa10UCv64uD7jTgaqivhzQIVVdd/+DbtjAogrXB1pnDxEY5Va8VixgDw
         K61+QMikRA98IJsfVqkkszuQKwP9UV9A9vnxXOTyXd9XLLkEyu5hl0EJyvFt5ITkGnZS
         iYHVR5heoWWDUi0ESM+BBchDzWq64gHtpw0CjXZnGheqx1Urlt9WbdQfvbBxWrgo7aTf
         B3YDyokcd09j15wUkpCPhyV9oUI0doH6Y4W8aeoPPYcJ6ReogKwfi2XmHNbb2DCX7ROw
         DvzDNl4+xrwJBM+w0LIbFc4TMIY3QUmEoPVLL89E9ayAmmTH3pRvPnrcE4P6+UUkbLyx
         nXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly5ijQBNFVq3smW6orlt5Wr7gXwIy9zweHNGHA83Ufw=;
        b=h4L50YuquxSqt5Ye3ROqODoOktogv3W7QpRq0cQhsZD9fRUbtfGwqTq6pQfF7+XBxr
         5XZLYYNOoMxMgUI7Dn3hxfqC0koBZEYu/C+IuIJ9OQ8tPPPFE9ymvcBnTjtR3vB1czsz
         cb6frmvyEimn7lvjwz+Ud5CocDd90KMsKaydce4Y0r1Vce2gw8vaEv5LTBzi1dXGsABs
         hf1VaCifuf7LsV1qshzLwvRaBeH1svfRF7ahuyQPt2cOlfNhlLfSYatVpn4xTdlC7AyH
         LGI573E9zkh0NbRDvY+WN2dz4kbL+ETTBwq8fHsyAQYFlH1vK0x/6MFa5I5G1u88UyGT
         mCJA==
X-Gm-Message-State: AO0yUKUQNRk9C31bvgURRSzVXeGn8nok4+dIUykU01iS9Xz4TIf7iU2f
        oSiqwOR+STnjAA++3z09hiiNqN9FdD4=
X-Google-Smtp-Source: AK7set9F3PvPBVLMf66Ka5HFBOaiO2dQ2srwjrqzs2kND9sls9MZV62PkbfyFfkXI9LsUVloS3Y2IQ==
X-Received: by 2002:a05:600c:3795:b0:3dc:5a13:c7d1 with SMTP id o21-20020a05600c379500b003dc5a13c7d1mr15305127wmr.16.1675507482756;
        Sat, 04 Feb 2023 02:44:42 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003dc4aae4739sm10143129wma.27.2023.02.04.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 02:44:42 -0800 (PST)
Date:   Sat, 4 Feb 2023 19:44:41 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC update for v6.2-rc7
Message-ID: <Y943GbieOKnXz1aE@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider for pull,

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 0a2742bf5899bf3bc46d16e4cc7dd7352ce771fd:

  MAINTAINERS: Update OpenRISC mailing list (2023-02-01 00:48:30 +0900)

----------------------------------------------------------------
OpenRISC MAINTAINERS update for 6.2

The old mailing list for OpenRISC died due to some infrastructure issues
and the people in charge decided not to keep it running.  We have
migrated this and the users over to kernel.org infrastructure.

Sending this out now to avoid kernel developers getting lots of bounced
mails for using the old list.

----------------------------------------------------------------
Stafford Horne (1):
      MAINTAINERS: Update OpenRISC mailing list

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
