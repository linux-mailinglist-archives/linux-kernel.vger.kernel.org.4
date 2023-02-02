Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14968814C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjBBPJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBBPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:09:47 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06023C5E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:09:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m26so2094318qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2E9zn+ToMChqAJjV6ZutpFgHJwReTtRL04XKbEEuVxs=;
        b=D49Pub0oFsmtKDM+i0yPx5so8Ey3zPdGciQUAqRywZib+NU6H7wy/1YeZxnSSJ900T
         4VlJ8WBppvk/tgpBZI2WF/NTs+72iuBZhDamCm8/kkdFDmhX4QVCQRWiosDors4rb9Sg
         TLM5pGFd53nuEIkcDqCPeJ3klihOCtUuW0c+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E9zn+ToMChqAJjV6ZutpFgHJwReTtRL04XKbEEuVxs=;
        b=wjOVpTFkzTYijngxiBmnDPWUHHZOGzzZFpSeXZkDR6MP+doAUVgMpR0iogS1XmEb3K
         cWMWCT+UqURNfRc8lDgQajTd7RHx2tNV3feTbFalbtnlT+JiDQ/bRNPqkfBD6bJuwqLe
         roJ/j8w2Vv14ub1CPT053Gj5if0nwaZaoe/B4VsbidPlaf13YReUQV8r5EQBI/fWlQ7S
         dLF+UgTssZaKk8zAqSh/Nar5soCnfuQlYXpitPNFIM05wnp8weBrmId/2zj/GhQSxua0
         5EA1+ovWNacWNrjR7NwPzCxUUrczebillMZDAkR1dm+XebFIp0tUuI9eB5jicLU4E2CF
         q/ag==
X-Gm-Message-State: AO0yUKV4aP+DkJAUEjdZyBbqg+WA4VkcKueVwWp9bxyfxiGrdSOX7qVq
        /ijCDBub8e0qaNRE66Hg45tYQ81Uvjkn0HH9
X-Google-Smtp-Source: AK7set8aPKmpgGjXY3zfRDCd5eMrn6Kx/DhIpyqMfqTzahBlYTampPz0k3hZtc5+Tdob1MQmTWPEbA==
X-Received: by 2002:a05:622a:1998:b0:3b8:3a7c:d204 with SMTP id u24-20020a05622a199800b003b83a7cd204mr12152621qtc.58.1675350538326;
        Thu, 02 Feb 2023 07:08:58 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id u15-20020a37ab0f000000b007049f19c736sm1521378qke.7.2023.02.02.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:08:57 -0800 (PST)
Date:   Thu, 2 Feb 2023 10:08:56 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <20230202150856.lchr76nqih3vdul6@nitro.local>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:15:36PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> Then I tried creating a shallow clone like this:
> 
> git clone
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> --depth 1 -b v6.1
> git remote set-branches --add origin master
> git fetch --all --shallow-exclude=v6.1
> git remote add -t linux-6.1.y linux-stable
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> git fetch --all --shallow-exclude=v6.1
> 
> This took only roundabout 2 minutes and downloads & stores ~512 MByte
> data (without checkout).

Can we also include the option of just downloading the tarball, if it's a
released version? That's the fastest and most lightweight option 100% of the
time. :)

> Not totally sure, but the shallow clone somehow feels more appropriate
> for the use case (reminder, there is a "quickly" in the document title),
> even if such a clone is less flexible (e.g. users have to manually add
> stable branches they are interested it; and they need to be careful when
> using git fetch).
> 
> That's why I now strongly consider using the shallow clone method by
> default in v2 of this text. Or does that also create a lot of load on
> the servers? Or are there other strong reason why using a shallow clone
> might be a bad idea for this use case?

As I mentioned elsewhere, this is only a problem when it's done in batch mode
by CI systems. A full clone uses pregenerated pack files and is very cheap,
because it's effectively a sendfile operation. A shallow clone requires
generating a brand new pack, compressing it, and then keeping it around in
memory for the duration of the clone process. Not a big deal when a few humans
here and there do it, but when 50 CI nodes do it all at once, it effectively
becomes a DDoS. :)

-K
