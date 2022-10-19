Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3EC6040ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJSK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiJSK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:28:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DD12D81E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:07:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o64so18640374oib.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0xI0nbo0MHnr4iuZXyqYhGrXx+2wVnfpvEinKBcYFY=;
        b=tymmDUXjynXSs53zmj+smAFkdbd95+Tkssf6zwIQcfGMNnb419is3GkJz9/3FadiQR
         h+yn/0Hgxo3n9zdDNY182P9VElJ+PNvzNoFeGIbELNbaV6AcmqMVFpm++RnkfAkytqT3
         1Lj606+559qGN/X7V4LyyBZxums3kCxDAYe/7gNJJHBIUI0qOsCJcUax9a6HQQnlmHrB
         0zG6kctGuwQAidj67oG2OzPFp+u+iZPy73GXTS5Jsx6zlZ+BeaADt8nB4aHWzXqHd+bB
         +uYgf+Anrg8y5myjqHJHU7eHSDoio+3EmYsrnz6kiSNclZx/udz3PxRUcUn5sMefuoST
         z+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w0xI0nbo0MHnr4iuZXyqYhGrXx+2wVnfpvEinKBcYFY=;
        b=4soaHl2dyBvEH9H6aXP24wYGo3COnieuNvjV3NL5TxJXPE2HNKGL3UcWFll/QrEvkL
         TFQa6g3y7fMvOJzratRTNaSm6XgCPloDagXRxjdkb8/v0aOQQls3pRJZAdDppxmcGUyQ
         YmaBYOX5H6hansAMQJ1oVCUXI5Ve68/O6GFEDA5CyIoxskVw/u0xKM81KO0AVOy4xdxL
         8LppkEI6VK8dek5lMPmRhZovuTm6kHcQ/u+x8UEPhuyUbmbwGDz6SL+eZPSDPLw15xHd
         VFDUQ8xJlLxH6fwNDYlWfb4PNNREWBJfxgQNNKrDRG92kTtCwQl72nhpo1+qJXDW+G0R
         xw0Q==
X-Gm-Message-State: ACrzQf3ta9W15xL4TD0Uj0ekQGLcTStJxaf0Mf3ASfrxJz3oyM3uW8TQ
        WNjQKdphJidBcK433pI24NOVkGr9+KdXShxE
X-Google-Smtp-Source: AMsMyM5NStD5utieNX5leh6GWOJvY630eJBogchV0/ohXuPfbLScPa3ijo1uIpAvvYHn/Ybiy/NNbA==
X-Received: by 2002:a05:6870:c214:b0:131:c125:bcb2 with SMTP id z20-20020a056870c21400b00131c125bcb2mr21390162oae.292.1666173444516;
        Wed, 19 Oct 2022 02:57:24 -0700 (PDT)
Received: from ?IPV6:2607:fb90:c2fc:ed44:8e8:baff:fe9e:92c6? ([2607:fb90:c2fc:ed44:8e8:baff:fe9e:92c6])
        by smtp.gmail.com with ESMTPSA id z15-20020a4ade4f000000b004767c273d3csm6229227oot.5.2022.10.19.02.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:57:23 -0700 (PDT)
Message-ID: <4ddd695d-af3d-f3c0-67bf-27d9ef6b91ac@landley.net>
Date:   Wed, 19 Oct 2022 05:06:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: make all modules_install -j 2 breaks on modules.order.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ make -j 2 INSTALL_MOD_PATH=$PWD/blah all modules_install
  HOSTCC  scripts/basic/fixdep
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTCC  scripts/kallsyms
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/sorttable
sed: can't read modules.order: No such file or directory
make: *** [Makefile:1483: __modinst_pre] Error 2
make: *** Waiting for unfinished jobs....

Missing dependency somewhere?

Rob
