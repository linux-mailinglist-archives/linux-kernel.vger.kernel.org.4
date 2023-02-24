Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE56A2122
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBXSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBXSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:06:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B663DD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:06:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso3644505pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqymbtir1wxBswrnIYSIP9JVKM4bPs/fGcPWQikKC3w=;
        b=a4WxdS3D15t+NFnKGYxP5Gu4m2cn0yrhKp4kzgSflEqrNn6ctHKMnPgz+Lm/a98B7S
         FgytwKetxKkp4e1kcHyG8/P3bF02J3I4EP7/9wVP/ofDc4WfZicIAvXYKnWix4rt98m9
         KC8jJRJGbxmWWSFptNJwdv0wsvk72rvIu82B9950lKDfwRnkWWHoVN5scksbEyc+1Pwv
         mbxPhaSnZy1nIPpl7H+w3kIe5ivOj/EkcF4j3sB2/pwvB8PX3NCSRG+MYul6zPmPcLQB
         8yDi1RZrAGTqIMCxALPJ9QhFfyJ0ghxrJEolf3UtKnQ1GZJo4uq6N3Rgec/I9gXXK4yH
         S3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqymbtir1wxBswrnIYSIP9JVKM4bPs/fGcPWQikKC3w=;
        b=orLubCaozYm6IhUSeMAloVpf0Ws5fe6WVXD1nZesmbBXbNFIHHiDqv9/zv6xyVTp01
         v7eCgPAQcvg0dUBnwgFFN3orfMpoY+/gl42P3qqNtwMP8p5tKYrE64ZYhg8GnJYy4uGl
         XUPCvaJPTvsrOxgB9d1aNA0eO9E9EMjAhpfYM8WXXl6m7rh3e1HBTqhVx3Ixp+Y8Re9h
         YKh7EpPRlBuVVxi1JGL6hjN2Tbck5taPJWVsN57ivH9Vx1x46XsTySIhJjaliqBv/MY2
         lEVgQc5smpW9ULFKJgE1UrZLIaMP7KYShJCSoLR1r5ZCGOKfCTF8CVOoG6yOnpSLQiZl
         Z9Jw==
X-Gm-Message-State: AO0yUKU6XrT45cIylRDn8lZNzIfA7kJn14VCvkVRURODgrbH0zol4dl8
        wBdC35zZJu3P5sVIohNfWFfOMQjYMc4HvQ28+4qpIYjQCpGZlIhrzLk=
X-Google-Smtp-Source: AK7set/Ho5RE83SzbTV71i2R5H8sPpiG7uthy6qNCk6YeHb0ja4+QUHiYKO7MjC8a8NuLywGOIujfqSiFLeBqdfJUMU=
X-Received: by 2002:a17:90a:df85:b0:237:29b0:fb95 with SMTP id
 p5-20020a17090adf8500b0023729b0fb95mr2091228pjv.5.1677262010030; Fri, 24 Feb
 2023 10:06:50 -0800 (PST)
MIME-Version: 1.0
References: <87f7b3f4-8586-4c10-d4f4-643ff5f0cf62@inwind.it>
In-Reply-To: <87f7b3f4-8586-4c10-d4f4-643ff5f0cf62@inwind.it>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 24 Feb 2023 13:06:37 -0500
Message-ID: <CA+pv=HOSysost0YYeq4pw9VKjhtQDH6MvERrYpWyisme19b7dA@mail.gmail.com>
Subject: Re: Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
To:     Valerio Vanni <valerio.vanni@inwind.it>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:46 PM Valerio Vanni <valerio.vanni@inwind.it> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=217083
>
> I got this error after upgrading a Debian machine (x86-64) from Stretch
> to Buster. Upgrade is successful, but the next boot it crashes.

Thanks for the details. What was the last known good kernel version
that did not exhibit this issue on your system? Bisecting against that
is your best bet to try and find where a change was introduced that
might be causing this issue to occur.

>
> The machine is an Asus B360M-A with an Intel i7-8700 CPU and 16GB DDR4.
> My kernel is 4.20.17 (from kernel.org, not a distribution kernel), but I
> tried with 4.19.273 and 5.10.169 with the same .config.

Also just a quick note, since I noticed you mention it here: 4.20.y is
not supported (see kernel.org for a list of supported releases).
4.19.y and 5.10.y, however, are.

-- Slade
