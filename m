Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267F6D60DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjDDMhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjDDMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:37:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D0710A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:36:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y4so1285417qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680611769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSpzJzf1FOM6UnLnSTOqyKayxzDBWTCflEqOjyBSbCo=;
        b=aROFRSMiUndfVZ0M+rPTRZvKbg0G3SrN6evNiK/VNwVed0c6Iio2IGw7q5tfNenTi/
         ZYscQ8HaLXqbzKe6CtmHbNUUREysb2gwejhFwHpm/uSgW3TIKjFciYcG9KJwiDzBcBLD
         ECIA0MoDBox8gBNQHDEB3ZwvKdpvw4ys0qypU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSpzJzf1FOM6UnLnSTOqyKayxzDBWTCflEqOjyBSbCo=;
        b=owM451i3vAS6lm3391+brG5FdAsBoLIzb4gJ1ZlwmAOnSxLU3o8fPpwqWYF/1D/xDl
         QXOHtvdNgBNrgNUhhS/BGy2H6yEmA9JZ1PXprLWk8063e85h8HsiDWXc+njd9AHvMq6U
         WvJjLld60wFJN3iWBLmebUjkBGbV6SssN+QzSdqwczWiLQifvyYFeYq8LMXYJGm2lgcu
         mjJuHHsOuKrv0UDupQDNgo4qeazSs5vUgEjLrMumWQOf5xpOOYz/9m/8lEBHpbTV9OkD
         RRCaqRQ+amJG484KI6i7d0DoFAKfS7rm5T1HsQkVB7I8kRAnVXHTzf89pc/pqKa8GlLE
         ObzA==
X-Gm-Message-State: AAQBX9f41SGHS/9WmemQPh5bBWzvbREiEfG6Seh/K0XSaKQab4k+e7th
        DEhAoYTThJTLKpgUyxMRbLL6hw==
X-Google-Smtp-Source: AKy350bmIBXc+urbVoIz0HcgJ/oIEa1NP49n3CJPHcmGi2xKjny3EOfz6eI161rjIxZ0tXl+zYAJGA==
X-Received: by 2002:a05:622a:148a:b0:3d8:6b0d:f9a4 with SMTP id t10-20020a05622a148a00b003d86b0df9a4mr3121325qtx.44.1680611769053;
        Tue, 04 Apr 2023 05:36:09 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id q19-20020ac87353000000b003e387a2fbdfsm3226631qtp.0.2023.04.04.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:36:08 -0700 (PDT)
Date:   Tue, 4 Apr 2023 08:36:07 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org
Subject: Re: Introducing bugbot
Message-ID: <20230404-bacteria-refinery-a97393@meerkat>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <b38de7ff-3de1-cd4a-a532-66642aea587c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b38de7ff-3de1-cd4a-a532-66642aea587c@leemhuis.info>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 07:58:40AM +0200, Thorsten Leemhuis wrote:
> Would be great if bugbot could CC the regressions list for all bugs that
> have the regressions flag set to "yes"

I'll see if I can add this logic and make it configurable.

> How does one make bugbot forward a bug to everyone in the signed-off-by
> chain of a commit that caused a regression, which might or might not
> have a bugzilla account?  When the reporter performed a bisection these
> are the primary contacts that need to be reached out to, but the
> maintainers and lists for the subsystem obviously should be CCed.

I can add a cf_bisected_commit field that can take a commit-id. When gathering
recipients, we can check if we know that commit in one of the tracked
repositories, and get the author field out of it. Would that be sufficient, or
do we need to run get_maintainer on it for a full picture?

Note, that you can also add addresses to Cc: on the thread -- they will be
collected behind the scenes as each message is processed and any bugbot
notifications originating from the bugzilla side will also include them.

-K
