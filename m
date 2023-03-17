Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FB6BE26B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCQIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCQIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:00:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66C3A870;
        Fri, 17 Mar 2023 01:00:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so4357472pjt.5;
        Fri, 17 Mar 2023 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679040041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4axSodYm7h/BNJm0GjFw3QPyJy3MjTh4/w9gm29itNs=;
        b=KtHieplKKdSSyt16iknom/A+exf72LbqoTbo1Plr9qrdmCIIBdNcQAmCE8Yb+w97as
         LVJPqArFdgpmOJ4/fJ0t1s6qFvtGTLabP2JiCyT+vI3WdiZ5bcZhTauRzuIe7pORe/0Q
         rvbppjByaSGCHzM8NoHkl2tEDLFReG/mt4z1tFjT5entkbVZUB41eNx8I3FBeBgoFWO7
         d0smyRpLyvdiv17456OiqUxAyFO90oMTx1prS+qSyc+SADpkjK7wN/ryaGSBv/dHp+kI
         ntM99svq2tEIi1RjrbFrXH2wXPWe1qkrnxB/nlnonzQk4c+lynfC4BnDkKb45/WzS/dM
         nTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4axSodYm7h/BNJm0GjFw3QPyJy3MjTh4/w9gm29itNs=;
        b=a0tARbW0FL1foyJbKDnmw+a35e44pxoIXQFG4bvg8ZUU5eM1KB8I4xjwthMc4n9NJE
         NPRLvDPzaszeX8pwB2JuvfC7RkSkA9DjjU53Dfk+5IJ3acK4Laxp8TUkVw09dNgGf0hE
         lasTJBXEUfukGgcGmjomx5kzwFKsJfWlZ5CntEdwckzNq28UqZwahOAN2qBpMnemZPGt
         45QTsLU0j7BYiDTfZ2fNj3vlgDVF7JqNW2L8J6ziFmRh2TwvRwiXwgSSbiaZ9VHmpRVU
         V6JcJj0+0E4C1ZzmygMilYaZGLXWEjG2tmHkSJ1elEGr+g154RsGBuipVbS0w8HgaaM0
         bBVw==
X-Gm-Message-State: AO0yUKWl0tuOBJnY9Xq489zl0jDsPjX+MU7EhMIIx6AAyFJzeuK+ulaI
        47v8gCsx5zpRgtW2rVe/Xnw=
X-Google-Smtp-Source: AK7set9idfKEqSGsgoRA/rnz8q66k0EBzjhwQ6SP+vXw7pPC5h+sM/sKFKJ5l21t8O4eu3wRNw4c5A==
X-Received: by 2002:a17:90b:180e:b0:233:f394:d83 with SMTP id lw14-20020a17090b180e00b00233f3940d83mr6532920pjb.48.1679040040917;
        Fri, 17 Mar 2023 01:00:40 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ab38d00b00230b572e90csm802922pjr.35.2023.03.17.01.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:00:40 -0700 (PDT)
Message-ID: <4822168e-85a5-e507-9429-21d9a222406c@gmail.com>
Date:   Fri, 17 Mar 2023 15:00:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Content-Language: en-US
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 00:44, Matthieu Baerts wrote:
> +In the same category as linking web pages, a special tag is also used to close
> +issues but only when the mentioned ticketing system can do this operation
> +automatically::
> +
> +        Closes: https://example.com/issues/1234
> +
> +Please use this 'Closes:' tag only if it helps managing issues thanks to
> +automations. If not, pick the 'Link:' one.
> +

What about:

```
Similarly, there is also "Closes:" tag that can be used to close issues when
the underlying tracker can do this operation automatically. For example::

    Closes: <issue link>

For other trackers keep using "Link:" tag instead.
```
?

> +Note that it might be interesting to use the 'Closes:' tag instead of 'Link:'
> +if the URL points to an issue from public bug tracker that can automatically
> +close tickets when such patches containing this tag is accepted upstream. For
> +example::
> +
> +    Closes: https://example.com/issues/1234
> +

This one LGTM.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

