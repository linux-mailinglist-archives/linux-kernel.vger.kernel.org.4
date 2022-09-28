Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F95ED389
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiI1Dcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiI1Dco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:32:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392613D42;
        Tue, 27 Sep 2022 20:32:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so564043pjf.1;
        Tue, 27 Sep 2022 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5IUmqNkNBw6dRpG6ZEomA1DspemF9lwJ7nLqg2d/+UU=;
        b=KIPWQJXqYb5m7RKiC0jM9a/OXfbywkFlOOWm3eqnVPioTbYoED+DWfTR7W08d/NQQP
         pyCcX67eYiyJLYJY1qxbYjkTHCBbhVrKChVAHvmEtwmds8Z9DEgFp3F66ADbK9G4Mkxo
         jxcChVu5y6IKnRKunt3SWJVHU3gv/+bf+8+sMb3mmaSUGT58y2MaPoWJe5+W90F17tQt
         ecUmTQIqZO7MEkLLq9j8TrcwNMo7fWeaZqV4l3Wvqj+ge3N/9V/NdCCfeOCupJQ+YMyq
         7ir20h2EMAu909NaBXxpVTRuY8YKEPZkG0ZmrNqoBC6UJTIT1tMdHp1aFnlB0dmpgAGm
         d0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5IUmqNkNBw6dRpG6ZEomA1DspemF9lwJ7nLqg2d/+UU=;
        b=VnPbZlhr9tZHzGkRcdUaw8LipGteT0pgVsLIWNRj55TXELFV+aQa7Kh1TVPd/NkMl3
         5ip3uE2x67EEZAfPaYovJH+MDzJP9EkgFJV6L1Ckt4z7lzl5sB//vW35KqnObgk/epcw
         2n8Ij8zjHS1IKFbGnm4nErKNvpAyMA6X7t3kBjK0TrTPr23LmC3nZRpRCM95kE97egjj
         DpeVv+gNBF498e2SRtM/Pu5yZsVhSKU/apOsUe9IzeXBOPRKUqlANfu8bBhIof+9UOpb
         rY3gAWOOk24vp4wA4Kxy+2Kk4DpEyuP//GUPBW9Yj7nPyjZT2XUdfVbJCo3Th3i41h8R
         CbhA==
X-Gm-Message-State: ACrzQf2Qs2SHuyvwI7Qwgc3gEcSJ0Zj45FFLrDgIazuw27EKo9rqZ2OR
        ix6dpgTctuAz+hBcK4FkIX0=
X-Google-Smtp-Source: AMsMyM64Fxxk2OyDmcxVzf7BacTyV2aMJNuNG7JHkkHSrIszveVLeYILTTyTSKz/smAEvlSxaZf6TA==
X-Received: by 2002:a17:90a:1b2d:b0:205:e395:841c with SMTP id q42-20020a17090a1b2d00b00205e395841cmr4713697pjq.28.1664335963424;
        Tue, 27 Sep 2022 20:32:43 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b0016d6c939332sm2379139plx.279.2022.09.27.20.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 20:32:42 -0700 (PDT)
Message-ID: <396ba5b0-64e6-a9a1-c6e1-4984506c9c3b@gmail.com>
Date:   Wed, 28 Sep 2022 10:32:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/7] docs: Rewrite the front page
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Jani Nikula <jani.nikula@intel.com>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-3-corbet@lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220927160559.97154-3-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 23:05, Jonathan Corbet wrote:
> The front page is the entry point to the documentation, especially for
> people who read it online.  It's a big mess of everything we could think to
> toss into it.  Rewrite the page with an eye toward simplicity and making it
> easy for readers to get going toward what they really want to find.
> 
> This is only a beginning, but it makes our docs more approachable than
> before.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: David Vernet <void@manifault.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/index.rst          | 148 +++++++++++--------------------
>  Documentation/subsystem-apis.rst |  58 ++++++++++++
>  2 files changed, 110 insertions(+), 96 deletions(-)
>  create mode 100644 Documentation/subsystem-apis.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 4737c18c97ff..bc492e79f1be 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -18,131 +18,88 @@ documents into a coherent whole.  Please note that improvements to the
>  documentation are welcome; join the linux-doc list at vger.kernel.org if
>  you want to help out.
>  
> -Licensing documentation
> ------------------------
> +Working with the development community
> +--------------------------------------
>  
<snipped>...
> -User-oriented documentation
> ----------------------------
> -
> -The following manuals are written for *users* of the kernel — those who are
> -trying to get it to work optimally on a given system.
> +The essential guides for interacting with the kernel's development
> +community and getting your work upstream.
>  
<snipped>...
> +User-oriented documentation
> +---------------------------
>  
> -These books get into the details of how specific kernel subsystems work
> -from the point of view of a kernel developer.  Much of the information here
> -is taken directly from the kernel source, with supplemental material added
> -as needed (or at least as we managed to add it — probably *not* all that is
> -needed).
> +The following manuals are written for *users* of the kernel — those who are
> +trying to get it to work optimally on a given system and application
> +developers seeking information on the kernel's user-space APIs.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
> +
> +   admin-guide/index
> +   The kernel build system <kbuild/index>
> +   admin-guide/reporting-issues.rst
> +   User-space tools <tools/index>
> +   userspace-api/index
> +

Hi jon,

Why did developer documentations list first before user-oriented ones? I looked
the rendered result as if the former was given more spotlight than the latter.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
