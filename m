Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4646F94CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjEFWrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:47:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901541816D
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 15:47:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f389c21fe8so1848471cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683413238; x=1686005238;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YO27Se99ehD/Ym8yzls9yQjFi3VcwamKc/L6zoQXd2g=;
        b=iEKimL+6GK+44PyKoWWpQVZS2Cn0EAvEw052FCmOUb1SDDb2+q8yKaZVLGVYN/T3j3
         j/vrqbCU+OlKc0HO9RHYruIKUsZdjdgIvL0szOXy1ZtoHRjxYCMq9dp5g/sv74r4vcqZ
         6eTyn+6xClqMfRIYaV9HOSmdR0i+z7sbYg2bnCzNORvKhFkKyV7hBg95ixtdOHgFd9TC
         EClIblYNdiwWSNp7n12Qk4vZfDmWa2RThqmtWRRHZURL7r45ZnxG4yxS7q0UTiXSKp21
         HNxKqJyr3iDda455dnKigD4xuJ47cqh09MrvGqsQzjjWFirKsRBLuwsDnAlJjxqqiP7C
         Vbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683413238; x=1686005238;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO27Se99ehD/Ym8yzls9yQjFi3VcwamKc/L6zoQXd2g=;
        b=ACzGLmGl/LpYn1XFzTB/RKysufn+KTYVwTVicVUkwTDhj0oeE3LzxaQmz1dAK1UM6E
         J4uPZ19MmBnnQba1D+2L4er3bBoznPObC3rsG2MBmQZgy7kaBlibgX8P9339DexqCHz2
         d3jfPh+vhu09NfDpSVqtaMvMmKNTflKJYffYxsnVrldOHTkopWTEfoWJSl9LrEmbrfk9
         np3DRmCjlt1FTUY77q4dfR5IiFqC+sODjb4rmw8Bljn5lbxhfkCoI/CKiQhTBnvaKXek
         xc7TO4mZUfk3uoiLmO2+NIrI8Dibm+JB4DlvJGv4nwUdL4vP05Ia4Sj3G6ZCpTw1jxa0
         FF5Q==
X-Gm-Message-State: AC+VfDxp5kIb6vhW5DRRyxVsrqS2wCNcl1jZaxziXUZTZd192eNiiqNg
        WEyr8dWuce+cbA4SStleD2ApgJDDxhS+1pMS
X-Google-Smtp-Source: ACHHUZ6AhXC00JwOB9ov6AP8sELlqrWfrN8q91SYClA/RfPNRdKCE/T5xxkeHn/YxTXJIjM5S3BkCA==
X-Received: by 2002:ac8:5b0e:0:b0:3ef:4a0f:96ed with SMTP id m14-20020ac85b0e000000b003ef4a0f96edmr7659998qtw.6.1683413238088;
        Sat, 06 May 2023 15:47:18 -0700 (PDT)
Received: from debian ([191.96.227.48])
        by smtp.gmail.com with ESMTPSA id w22-20020ac843d6000000b003edf043048bsm1781242qtn.9.2023.05.06.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 15:47:17 -0700 (PDT)
Date:   Sun, 7 May 2023 04:17:10 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Debian package build from upstream source need git repo?? Failing...
Message-ID: <ZFbY7siXjm9hhpUB@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
While building the customary kernel from from source with my frivolous script
and it is now failing with this error:

/usr/bin/make -f ./scripts/Makefile.package deb-pkg
# GEN     debian
   ./scripts/package/mkdebian --need-source
   error: creating source package requires git repository
   make[1]: *** [scripts/Makefile.package:40: check-git] Error 1
   make[1]: *** Waiting for unfinished jobs....
   warning: Not a git repository. Use --no-index to compare two paths outside a
   working tree

  I can vividly remember that it was working fine few months back...in fact
  building the 6.2.2 kernel. I am certainly missing the updated information of
  change. The damn script just untar the tarball and build.

  Masahiro?? Git repo requirement is mandatory to build from source, why? Was
  it the case??

  Or I probably doing something horrendous, but I can assure you that I haven't
  change a single word in my script, as I mentioned it works file with last
  release build.

  Please shed some light.
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar
