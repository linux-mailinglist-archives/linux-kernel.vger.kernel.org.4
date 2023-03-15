Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDC6BBD07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjCOTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjCOTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:12:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27C584AB;
        Wed, 15 Mar 2023 12:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B2F6B81ED5;
        Wed, 15 Mar 2023 19:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A97C433EF;
        Wed, 15 Mar 2023 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678907537;
        bh=gVjMyvOh4fTj825PVq+a6hHO/8cZbwlfteXkDmUpkso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qooRDyk6bKSqHOJhCBJYQPBJNBhFH9jRPwwreHD3bywDgXEKexbdTK+Vw7c30YGdI
         spu0DlRsH0lBvUbUzy4nzXlAQAQ2cY291e/8wY9sQQfb9cbaYMEIDCRJopbmBlnXNk
         ASQxErPIt2V+q+q0zD2gpjA+OBZWyPr/e+IL3fJ4=
Date:   Wed, 15 Mar 2023 12:12:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Message-Id: <20230315121215.5e7d5d6c879e23506cb37a5c@linux-foundation.org>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
        <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 18:44:56 +0100 Matthieu Baerts <matthieu.baerts@tessares.net> wrote:

> +        Closes: https://example.com/issues/1234

I (and a few others) have been using "Addresses:" on occasion.  I think
"Addresses:" is a bit more general.  And more humble - "I tried to fix
it", not "there, I fixed it".

But whatever - both are good.
