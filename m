Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2DE70EA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbjEXAk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjEXAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:40:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A3B5;
        Tue, 23 May 2023 17:40:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so2888575ad.1;
        Tue, 23 May 2023 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684888822; x=1687480822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trKRfcDGr+UR7gkMuKtDFEQjYswjXvkOJhL1MG6567A=;
        b=qbStn/Ad8soPmKFUZjYOVfiADRK+isUmhGEo769hNj+Dqm8xD56T2etNtAQ/y9jbem
         agqGTIPCNeiOajArZN68eYjtyDnkRGpQFg0Qa1McQ3VxImqIAFXhzvKGx50cHtzQSmEg
         LcRkGrfZyLOKeLCq+KlvS6g15e9tkO0L5ifVSui/IfPQ4A5U8C+HuKmjsNfd3GAPk/JX
         FgDpG8TSjrlkmsnIbisL4F9aGmAyskIbIzrNRgNFB9ux3QbLw8bn1Qkd7o3ZrktQI/gS
         m540qP0deIyN5Qm4aQAX3aFXd749pNF4MdxsfbhfmEKoZ6dHijN7txCCrKJrjJHsLjrD
         6Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684888822; x=1687480822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trKRfcDGr+UR7gkMuKtDFEQjYswjXvkOJhL1MG6567A=;
        b=gtiYkhqIx1kbNNhjFAr2GHpLXMTj6EiGzWcXuHSbCrFOBok76b/QFFN0/eqk3iYCHd
         1xFtMc8meYK+qCC5wizuFrqaYC+kWK40lzwGl7zZYFFyGmYfXjEYSEmGRzdEo7na5f7H
         cUsJhaWRRjSCg6/dbtlPvz2d6nTMUvrfQvHEIbSvrxjUPEjPJBxsVcmS4837pxwplBTj
         rS+EamRgbXBYgletc3Sv+miwxlJWen68ycyfNrC8eDNQDo2K4CjchdQm+qg1LQnvIyPs
         xu0IqKeV1ZDAFwrfwRwKxPaG5kaXX0Ne7s4AyrcUBZL/plUmBh9Iu2zeVcUDW6CfxqzT
         VziA==
X-Gm-Message-State: AC+VfDyRgFegJhlOhU62hNFBAqtEKjOyz5Sr+ywFr60Um+l20px/zaeO
        jKTsLDbfq3d8DEsArqa2J5cr7DFxcno=
X-Google-Smtp-Source: ACHHUZ6j5X8hlybPIWuAdXe98KhefGgHvJ6LKOuRtwDc8JPZhQ1R0Er2bFqzqiqh3/K5fo3AwxGdOA==
X-Received: by 2002:a17:902:e5c8:b0:1aa:e425:2527 with SMTP id u8-20020a170902e5c800b001aae4252527mr16412547plf.21.1684888821819;
        Tue, 23 May 2023 17:40:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001add653dba2sm7371327plx.108.2023.05.23.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:40:20 -0700 (PDT)
Date:   Tue, 23 May 2023 17:40:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the input-current tree
Message-ID: <ZG1c8l8uprzkcjBP@google.com>
References: <20230524081200.1badf8cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524081200.1badf8cb@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:12:00AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   feee70f45686 ("Input: xpad - delete a Razer DeathAdder mouse VID/PID entry")
> 
> Fixes tag
> 
>   Fixes: f554f619b70 ("Input: xpad - sync device IDs with xboxdrv")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Oops. Oh, well. I do not rewind my for-linus branch unless in extreme
circumstances, so it will have to stay this way. The tag still resolves
to the right commit, so not much harm done.

Thanks.

-- 
Dmitry
