Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A26306FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiKSAVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiKSAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:21:04 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A40BA69A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:36:57 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso4000880otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK8gQKj2Jl7lgqDcBBKtTJvHs8EABYLYSyaTEIcYmn8=;
        b=gucqMw6zdttGL7YGH/8VFFsmO13p+jIbO4x5eL3c+cmf4/jxVzILWPhiYPujfkDohm
         0w9mpRCNZ8HSf2dvG4zeekZjFC0cjfx3WUsw40mocxDfIL7dCXgR6r5N5r7OgS6d1qy/
         yIfD3nIxVKHHKKlVFc0YpC3ywwSYeWWL6x63gjSYHBVRSs3BJ1ihStr0Z0ksgBlMTIXc
         1EtM/pqqaeEC8RzweIHsSwa50em+eHim1Hixm+xkr+1Wtpzxh5+Nm2z/llcSjaMItmIb
         z+hUPa8oeORr2ItK8aEhU6r6TfSd9eAPzmE4O8LiRv2uallTu99ZRAixUgCDrk4Rj0NX
         t/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hK8gQKj2Jl7lgqDcBBKtTJvHs8EABYLYSyaTEIcYmn8=;
        b=yc1JUqHjfqq9PeL9NmznZrlN9LOD2Pjq5rAZPbLY9CZm2IHmdQhf3yx3CjWRCb1u9W
         DXBZdDQMVBRM79oLp8nAC25ewTz+goLTHe0SnVQIFnrWsqnSm7+KE2hxHAfnGqMoRWLG
         Of0fIsUndpc/2aKkfdZng7aUF4izAF/u2mSWHj931kMuDOvVkB5Wo7vz5wsVtCY+ymda
         kVvE7MEgoBmwh/TH+03i6AZZiSBeHmQZP5ylDAwDd3tCXcSjdP7M2wPd5jNo+ZcwGA/K
         S67z2aGzmYkmv9YODWZoULtTMBlVfymv2nTHJJMFS3pCg7mDEikQV9D0D0QZk2HD2ZIk
         314A==
X-Gm-Message-State: ANoB5pn+aL4S3Cf6jqkkcEjw6x2ZeLFK3tTizhcmKEBRPm8zH1+KbGRc
        n4R/5K7SQNeJNhZ80iUYDmfXRRuarnQfr2JTqyY=
X-Google-Smtp-Source: AA0mqf5MPQOnb33bdpqWOSrKtrxpaGaIUmAZtusUI9ZD1VLYYeccdeusP7kv/eDVu1yJ3GUn5v8pUmRgHBNfokbu+Bo=
X-Received: by 2002:a9d:7d8b:0:b0:66c:63ec:339c with SMTP id
 j11-20020a9d7d8b000000b0066c63ec339cmr4956776otn.332.1668814586407; Fri, 18
 Nov 2022 15:36:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:7f06:0:0:0:0:0 with HTTP; Fri, 18 Nov 2022 15:36:26
 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <kontajean@gmail.com>
Date:   Fri, 18 Nov 2022 23:36:26 +0000
Message-ID: <CAGJkU199dd6rSeEQzJY4DP3DmVDGuEYE2s_WJmG9s4baR8bHUQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo lieverd, alsjeblieft, heb je mijn vorige bericht ontvangen, bedankt.
