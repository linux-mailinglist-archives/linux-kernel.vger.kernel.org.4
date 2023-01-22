Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC626772DF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjAVVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjAVVvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:51:09 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBC420B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:51:08 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-15eec491b40so12061670fac.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40Rmkj5g3cvg97kxah5sFiX7jVih95G4nCiDetrLKPU=;
        b=VVR0e0bcJbIrdkK1tLNiHw20DB41mQjAsNp72mvJLQIU1CDbu48KXrIK7sXfXrHxqY
         baCoJb25n99/HsqfcxlHIf0hZraUcY7UYecsGMUGfWEPEmkhYaX0m8yy0OAUcpJzn1UC
         Bw6nDEEX/cPNR16oI6OmOgx0LINHSgI7RPUQq00Fyqjm3Bb5ZJVBmHhD7Msu/jh5DwNQ
         BP4stx33k2xQXG08dct350qJvA21UIyagazE1YqK8wvtzssYhO/3nXlk5FPQKw87R6iR
         TwoB6oBaiqY0KrX4JrhFQxHgS4XAXwoZwzJiFURQm00qjHeL9CNN5saiAjSIVdtD8ZHr
         hDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40Rmkj5g3cvg97kxah5sFiX7jVih95G4nCiDetrLKPU=;
        b=JWHqmENrSW+/Jd3F/ByynFhxYviQliA9HPRiSG2ueeV9Da6b/krOnIp1jJY+/Xf6XX
         QbT0xZ6KW2MVNN2OebheO8Nn93y64y+pCcPy8HdmpaPyy9/4MaRsYSh2Od9EaFoWRMSX
         5LIi9ifTqrwp1mFxG1ATl+oxarogKkOezd8y/IT+AjmuBU/vh6wCCbYt3k9Xv+VKmiO4
         gWa0AUGtJZwxMTSCT4VkfULCsRHh0Rm8fkkGYrNaalNXLeEctUM2xlHBshvuLz2iCnRe
         o/Z7FABr89JvqjESFVlG3CbKS0slgTOj8yJypOrlaEjOeYPZhsLGLaBMAme95T+/qYbc
         6dVQ==
X-Gm-Message-State: AFqh2kqVymhbBT5L/YxDXOvw9+SnPsMd/TmPYUvrmi/8l87wIuXMpRR0
        Q+VsxYDnackddFPNM5U5HHX0OM5lf28=
X-Google-Smtp-Source: AMrXdXtLPlRpOoXou27NVl1VXfy4IEcdst/ssHJRGQesmKgknaqHJwHijSt8icQZtNlN/6K7VBjuuw==
X-Received: by 2002:a05:6870:7b8d:b0:15e:ec05:4cd7 with SMTP id jf13-20020a0568707b8d00b0015eec054cd7mr10460161oab.40.1674424267167;
        Sun, 22 Jan 2023 13:51:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18-20020a056870e75200b0014866eb34cesm9888225oak.48.2023.01.22.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 13:51:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 22 Jan 2023 13:51:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc5
Message-ID: <20230122215105.GA1788657@roeck-us.net>
References: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+E9tTCrSqBOxejUX11f8ebyRWQ+4exC=cmOEupX_d7Q@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 04:44:06PM -0800, Linus Torvalds wrote:
> Ok, so I thought we were back to normal after the winter holidays at
> rc4. Now, a week later, I think I was mistaken - we have fairly
> sizable rc5, so I suspect there was still pent up testing and fixes
> from people being off.
> 
> Anyway, I am expecting to do an rc8 this release regardless, just
> because we effectively had a lost week or two in the early rc's, so a
> sizable rc5 doesn't really worry me. I do hope we're done with the
> release candidates growing, though.
> 
> Anyway, there's a bit of everything in rc5: various driver updates
> (gpu, rdma, networking, tty, usb..), some architecture updates (mostly
> loongarch and arm64), some filesystem updates, some core networking,
> and tooling.
> 
> The shortlog is appended as usual. Nothing particularly odd stands out to me.
> 
> Please do test,
> 

Nothing to report from my side.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 504 pass: 504 fail: 0

Guenter
