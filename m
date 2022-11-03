Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A48617960
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKCJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiKCJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:07:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7071AD2D0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:07:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o30so661829wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unhrFH8KkVkYlmG3d9VK30QU1SnWcx+DMPZZ8t33VeA=;
        b=eykOshLZdPwVg7kNj2/XjdMRrqvJkNU2bgqUC9a+A5HpkNo3uuBk7vPRWpVI1UFp0O
         YTbUfywaA13ctdXDWldEXngFVGXBqrt8FU5ce22InQL3upticmCA0bBnU+8cyFMkMeXZ
         jH1jM/3laZX10babJyFreeG3USWkmyMyK0TsBUzBrMS0tTcBCtsDdMyfI++QJ9Kdlr/P
         OeQhiOYPYwc7v6dPGU846JuNYcVAPDQyesCcuQYah02qyAxqXw7JC6HyHgTHwRkfAcdP
         vkUZQhudw+H22y3GxsBCx2WOG2PTpCAzZcOvBRKrDy1XcQ5+xNJp/lH7ZpUlN+QI0yuN
         S+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unhrFH8KkVkYlmG3d9VK30QU1SnWcx+DMPZZ8t33VeA=;
        b=H2TeXKOLZ56cdU38cCtDcTR15XbFrTZG4yh0BOwZKlUTn86TWOiKoe0Nqh5eHSb/TQ
         QLl4TJJjjBqNPs6b7nTt+dWzbSu7zpa7DWXAdkoP4zK4gvmEzFAcIj9+M+wKBSsU4eME
         p/dvGlLXnEGOHAMNIaZ11gKOjkN7H9Buxtt9T2fJkXb/YQxT9x8vYu0s1ZtGsUVkwZh/
         HdoEjlxoqRBoejcc1RMcVNrYqUxGuHW3NE4fV1elUn5LLbnWvnYS1SAVGqUfsKo/xU+B
         NYnH9pmhZGZEozcNBfAMFl45XlfIgfkZuz5aEAnSVJR94GxASEwpxPU9Kwu3wGF3YeTQ
         TJpQ==
X-Gm-Message-State: ACrzQf1X4N6hQHPr/uvWCLMZZIS0EujzZvlwunku+FP5StEf7I/W470u
        fii8vSeqlF/Pgd0vYo5g2q8=
X-Google-Smtp-Source: AMsMyM6tEzB+kbe8MQ/mknrRYprzWgtORJ1OsuSoeRTCssvfoDnIJYk9BRxr94lnj4gpUSTVpQELww==
X-Received: by 2002:a1c:5454:0:b0:3cf:7521:3543 with SMTP id p20-20020a1c5454000000b003cf75213543mr12390334wmi.172.1667466443864;
        Thu, 03 Nov 2022 02:07:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y10-20020a056000108a00b0022cd96b3ba6sm296326wrw.90.2022.11.03.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:07:22 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:07:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH V4 1/2] staging: vt6655: change the function name
 s_vFillRTSHead
Message-ID: <Y2OExzH0QJqHEfNf@kadam>
References: <cover.1667397591.git.tanjubrunostar0@gmail.com>
 <5a0649c6019f1717cb2e2e8fc4e262f3747d73a5.1667397591.git.tanjubrunostar0@gmail.com>
 <bfc8e714fbe80a16428a447768def5764083526d.camel@perches.com>
 <CAHJEyKV75q90E1OU2YOGK70EBLm8dQe181m_nS_qmPRsPaB8TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHJEyKV75q90E1OU2YOGK70EBLm8dQe181m_nS_qmPRsPaB8TQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 09:48:59AM +0100, Tanju Brunostar wrote:
> The second commit under this patchset resolves this. please take a
> look at it and let me know if I should change anything
> 

Please don't top post on email.
http://www.catb.org/jargon/html/T/top-post.html

Don't break the kernel and then fix it in a later patch.  Just fix it
without first breaking it.

regards,
dan carpenter

