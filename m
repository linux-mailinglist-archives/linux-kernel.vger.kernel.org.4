Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883465B87A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiINLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiINLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:55:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FDB17041;
        Wed, 14 Sep 2022 04:55:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az6so11436213wmb.4;
        Wed, 14 Sep 2022 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=SyPBTrJvHzMyaHLtvwyxvW+j90fbMR931wFMQdu37/o=;
        b=BWHcjgqBlG2T3NBIzOfGGpZmejALUegR++FTvrF6X0D3HK8XJD04xKg9SN/VicszsD
         yEu18tlS4LVLHvsP+1+w1ZSlWCCUft/xk38vFKFomHB55CPeQFzJd8wFJYJNGGrWJAui
         6ifXPxDExUaYiYRJZhpgZlFeObvj76DWwHt/E8a/Y4mUKRuuGL0CubY3N2FItO5r4284
         UFg4UEtGnJ6hLWVZ3S3h4RH9QiLA6xfqgvdM+82GhScwlbi22Pt5OxofzGDwVAuhT2a9
         psCrmRLCu8NB0xZZyP1IONNj91J3WvPeRAruZkXvd43nEoHMVzDQQf47dLsZvvlFuepb
         zEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SyPBTrJvHzMyaHLtvwyxvW+j90fbMR931wFMQdu37/o=;
        b=VAnjeW9IJRmSN3qFh9nk6ifmnlz/l4+KwhRr32pgY6lLgmfGWjkbY5hnc/7417R30Q
         u6hr2pwxJuJc0qtDFiaFNxmRcQu/X2aiXmd6nGSImDphq7QIiTmCKVUkjw9Q+6yhKKJj
         aFO5Tmad7uPYq/75IsTwrnKVRz5ZgIhDgnOodFOe/wbs+URfK216VPjeX09iGjtMF0Ho
         0UO3EYnIZXl3UDST7SdSsWDNSQXK18kAtPfVMmWK94isYQ1LmVQ743+8BRBLkXNUng2D
         3AA6xUduQ+zJTrAPIMkPq6P5YWK2zlzEm8pokfkQww9HqMOo2pcS6xWQhhmikble6ekh
         IS1Q==
X-Gm-Message-State: ACgBeo348A0Glh2Sng2Q2loplVa1ucZq5UBZVizuprjQ1ITt6whlZ6fD
        2YdqU+pbuy/1VcFkqtYwfUc=
X-Google-Smtp-Source: AA6agR7HMGDwDBAbBTgUT/pwa8dlEi72q6ixKfarSZZfGWkX7uH9vOdKskGexIeULnCicwW5B9SFbg==
X-Received: by 2002:a05:600c:4a9a:b0:3b4:78ab:bae5 with SMTP id b26-20020a05600c4a9a00b003b478abbae5mr2918176wmp.114.1663156505798;
        Wed, 14 Sep 2022 04:55:05 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c47c400b003a541d893desm15968258wmo.38.2022.09.14.04.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:55:04 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:55:03 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: build failure of next-20220914 due to 64c11570d64d ("f2fs: fix to do
 sanity check on summary info")
Message-ID: <YyHBF99sC/vQdI3v@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of arm64 allmodconfig with clang have failed to build
next-20220914 with the error:

fs/f2fs/recovery.c:509:17: error: variable 'ino' is uninitialized when used here [-Werror,-Wuninitialized]
                        ofs_in_node, ino, nid, max_addrs);
                                     ^~~
fs/f2fs/f2fs.h:2376:35: note: expanded from macro 'f2fs_err'
        f2fs_printk(sbi, KERN_ERR fmt, ##__VA_ARGS__)
                                         ^~~~~~~~~~~
fs/f2fs/recovery.c:475:11: note: initialize the variable 'ino' to silence this warning
        nid_t ino, nid;
                 ^
                  = 0
1 error generated.

git bisect pointed to 64c11570d64d ("f2fs: fix to do sanity check on summary info").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
