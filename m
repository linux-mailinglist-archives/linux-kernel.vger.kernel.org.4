Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38A69E921
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBUUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBUUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:50:55 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DD2916A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:50:54 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d11so2275113iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5B8CwFjIlduPhfUcOnrYrohsnN6UDiGn3WQOkB3REk=;
        b=O0mAq6G2PEH7QqEa6nGbO0AZSMLn66Jtoq9LYk+DsQzEEnKP7y6uVwtUpCGqYolxWJ
         poi4Vv3k6yc5cq1DkRK3QWZ2SBqPvdhAKD0O/6vWrCxbEISRjZeUOK4nnCEw9rvPPgdy
         3jNwmMMvFkA1wXydNocr9NLTPRFlsDvscy9ivYfMSCjJxWUpZBG2T6ZTlEOGF+yrK4li
         ZHTWZDWd4OFaN32fn/AM2FOLMmSiqNiLE2LX+xL8Jfe0YUo3OVaUfbm80FcCObf++jcr
         cQGl6OkjzK2IJrpneoqRXsRxECKnmbv6RcpLvBztjnpf4xOZWlSb3rxjoxamS3nw/eW3
         DHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5B8CwFjIlduPhfUcOnrYrohsnN6UDiGn3WQOkB3REk=;
        b=diSWco5tyBnu6kYs0hVMSrsjxVIM83T/x2F4Oj52nSfa/BjtrYhVrJL4izkIGIwxx4
         zonFMRjMiR4tvaqFz31NOeV3u6QBRvlIotckrP1rKVdlrcOCVYJhcD/QP1nuLHElGOE6
         tTB7XFVeQGyceK9Mnk6ANNJCM0JP7oOvgBTaHGbdgwYwXsfABZRBMWtqtLo1XdNmlQ01
         DjqayioNZ9WG5dXxbGiJfipb+MDrhS5KUJLYCU0AERbQqxrrVRKHAQ55otl/eEFYruoB
         2IysME/nDgMZ9IfJmY5h4joyfkL8+BX+Q4JCYEBSa5/MD0T70SUzqyxJKT9uAfa3x68v
         yBZg==
X-Gm-Message-State: AO0yUKX7iaSt7w3yONQN/LhSvs2VLMnHNDm5S4KJs8+1medIrAISZ38W
        4hn0rZOe6vyWBCvqtjxZykMf7WkN/qC4Uqqm1VE=
X-Google-Smtp-Source: AK7set9hdkKjRu8LNWWSZzwTSOmNOeDIEbe8oWb3C/008fkvebr3OGSD/4l9sHF1SrbzMJtFUn9JTA==
X-Received: by 2002:a5d:8184:0:b0:746:c45f:f151 with SMTP id u4-20020a5d8184000000b00746c45ff151mr9388380ion.3.1677012653497;
        Tue, 21 Feb 2023 12:50:53 -0800 (PST)
Received: from [172.16.32.78] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id t17-20020a6b0911000000b00745a82f892bsm188888ioi.15.2023.02.21.12.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:50:53 -0800 (PST)
Message-ID: <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
Date:   Tue, 21 Feb 2023 15:04:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
In-Reply-To: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up rootfstype=tmpfs to force rootfs to be tmpfs even when you specify root=

Initramfs automatically uses tmpfs (if available) when you DON'T specify a
root= fallback root to mount over initramfs, but some people can't NOT do
that for some reason (old bootloaders), so let rootfstype=tmpfs override it.

My original code tried to do this 10 years ago but got the test wrong,
and nobody's corrected it since, so here you go...

Signed-off-by: Rob Landley <rob@landley.net>

See https://lkml.iu.edu/hypermail/linux/kernel/2207.3/06939.html
---
 init/do_mounts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a8..01d80fb828fd 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
+	if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? !saved_root_name[0] :
+		!!strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
 }
