Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2586F6C8ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 05:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCYEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 00:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 00:23:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E58769A;
        Fri, 24 Mar 2023 21:23:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q102so3136873pjq.3;
        Fri, 24 Mar 2023 21:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679718182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgpYKWXzjJN2Yld0pg3hkQUZovUKmsnyiCz0x9041pc=;
        b=BQwlA3JxKsQ/NLXvTODQe/+kSL6/LDn89Lmh56eesDRtuy+wVQTjWJlTKlwCDOOMlN
         ZrRNOCCTpch/KSblLe/3f4byk/RvuV38W96Te2n0NtDp3M6xNg/kwzLyNsJtzqVeeqR8
         PxXy7h8IwhIjfZ4oeopCboNZftkfOlxaXSH1TDXGd/XP2PkaJ2OuWu9omxztCMiApdvE
         98uC3F/PTxJkXVPkr5kZze0MQ0IrJxuvPB73GdELSyCcROzgZGzlfi/mgMJtm6WED61V
         ld/U/rRVX6eRH4YVzWOD5H8HOO1ULHzeqE1vEHvaY4dKxvUlKhcoUC4etBHguOR9X+cx
         4VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679718182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgpYKWXzjJN2Yld0pg3hkQUZovUKmsnyiCz0x9041pc=;
        b=Ae28txzEticZketdBu796+VAbmhLgSWq/PCINeRfMJ2FfL0SENvAtvJNR2ecywsG/A
         sX43U1CondUc057ER0woRpnHqQDgxr9PQMYty8RYiPQCluwfW1hMFtuZnRuZyxiPdGnr
         zj+Li30iaoWF/GL7wKgQU+oNTrmW4VVzqxcl+W5f1jEUH5DlwsrvjXaBD+W9gaN05qTP
         dqBnfmAnxuGuvIkUElLw9H9T3emfSu/GO739q2HtMSWsZp10L02BdV2Vi/pAodEK1y8C
         Ah5uclN6qF0zNMVxMTNNsyBiBQsymM75pl3xlk8Xgw6AHOL0r1fyweFSSeBZ61L0ue4K
         0QTA==
X-Gm-Message-State: AAQBX9f/JlFYRKnUNv2Dj5Clnx4bRIj6LTYMOQ9/usWa6YVhwkoU9zc9
        FN1r2xQII1IFjnS3v935XrU=
X-Google-Smtp-Source: AKy350b7n1hQhN2FdXuCHfv3E6Y+Fsn7JSY9rneZKs9hhy/ARsctLJ+8hbMgU1asbkLh4/wW0M+fUg==
X-Received: by 2002:a17:90b:4d81:b0:23b:3422:e78a with SMTP id oj1-20020a17090b4d8100b0023b3422e78amr5152241pjb.6.1679718181842;
        Fri, 24 Mar 2023 21:23:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a2ec700b0023b5528b8d4sm3786553pjs.19.2023.03.24.21.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 21:23:01 -0700 (PDT)
Message-ID: <fd643854-d687-1dda-f0ae-a6ef06432394@gmail.com>
Date:   Sat, 25 Mar 2023 11:22:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] docs: process: allow Closes tags with links
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
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-1-f4a417861f6d@tessares.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v2-1-f4a417861f6d@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 01:52, Matthieu Baerts wrote:
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 7a670a075ab6..20f0b6b639b7 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -217,6 +217,15 @@ latest public review posting of the patch; often this is automatically done
>  by tools like b4 or a git hook like the one described in
>  'Documentation/maintainer/configure-git.rst'.
>  
> +Similarly, there is also the "Closes:" tag that can be used to close issues
> +when the underlying public bug tracker can do this operation automatically.
> +For example::
> +
> +	Closes: https://example.com/issues/1234
> +
> +Private bug trackers and invalid URLs are forbidden. For other public bug
> +trackers not supporting automations, keep using the "Link:" tag instead.
> +
>  A third kind of tag is used to document who was involved in the development of
>  the patch. Each of these uses this format::
>  
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 69ce64e03c70..759c99e34085 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -134,6 +134,15 @@ resources. In addition to giving a URL to a mailing list archive or bug,
>  summarize the relevant points of the discussion that led to the
>  patch as submitted.
>  
> +It might be interesting to use the 'Closes:' tag to close issues when the
> +underlying public bug tracker can do this operation automatically. For
> +example::
> +
> +	Closes: https://example.com/issues/1234
> +
> +Private bug trackers and invalid URLs are forbidden. For other public bug
> +trackers not supporting automations, keep using the "Link:" tag instead.
> +
>  If your patch fixes a bug in a specific commit, e.g. you found an issue using
>  ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>  the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
> 

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

