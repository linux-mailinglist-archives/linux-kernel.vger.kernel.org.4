Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8796032B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJRSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:48:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFA79F363;
        Tue, 18 Oct 2022 11:48:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so25203373wrh.5;
        Tue, 18 Oct 2022 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B4uQFomqZcKA1aWhx4jMpHwleRSccFekx+UVfGhW1E=;
        b=Fhk2zU4yzRCoc/3UIGYe5w0pV84U6qJ8Ld8XEaWQ8sybzJCy1HIyLm2B7BSODnaZA7
         gsyA7BOJFAD/VmT9jD+zMU1j07DTLgYUWX03+OBkrxMVfQwzVF7bSrL5E+BSyfYLg/U3
         6Ba5BtxuOCVEfWxjPXppcOL3owBTQvzL9WSqFsPkLk470/ljamx4GWtDnu8FSOkPHYkO
         SU9fkEAyairO7hQX3zz1N9K8VFlygwFxvpf26wyUhY4Y0e/pfjjE4+iOM4aZTw/0H11p
         lDtdOWmkTbfIGyIXLofPSczMhHVeIS+Z1I+sphY/gryiBVgvCClSU0ZpCTt19/GmNOZy
         wVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B4uQFomqZcKA1aWhx4jMpHwleRSccFekx+UVfGhW1E=;
        b=Ue4Qu4s6xwcCn2J2xDWZDiiy3pTiJDlB/XeUcBZ22fDfoQB4RFVJXvKgpfhWEP2t8w
         T7Nj+ED3ZFXa9Yzgg1AJ2Cfq91ct/Yrb8psa/IHBikzeqCVFSQW29LFAQobEfPrsqv5E
         H4DKMMny+u1p7rGSU5MxWBD/yU0p+f5Tb+cbHYaUsSSjfqPWxP3792CYqiLBzaE/yRHr
         cgsonrmD4oAwzDOY6DDg8Zb537qD1J8Us9i6u29SpzA402LNwj5NCYvZHhiF/+s+voDR
         QAGJN/kGKBX/2yAK7FAWykJNgb2XROyO2yoIQeV3Lz+vRkqU0UuV/iRNuy0E3A3TOHCQ
         VQQg==
X-Gm-Message-State: ACrzQf0lLdUFadTbU7KUR+WB5cs6tByito1c2MFfP2rExtnxw8E7qjrO
        4skCQwgb5HFLK0A+lrWCbMg=
X-Google-Smtp-Source: AMsMyM618G4qNRFWj1h5K+/NYtPnnh0r7INysWssGfChFVQGZmZ2UNQUYGajcgmJZD940vn0eBO/bg==
X-Received: by 2002:a5d:6a42:0:b0:22e:6706:647b with SMTP id t2-20020a5d6a42000000b0022e6706647bmr2801236wrw.58.1666118911351;
        Tue, 18 Oct 2022 11:48:31 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b00230b3a0f461sm11581949wrb.33.2022.10.18.11.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:48:30 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
Message-ID: <4ba6c215-6d28-1769-52d3-04941b962ff3@kernel.org>
Date:   Tue, 18 Oct 2022 20:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        Marcos Fouces <marcos@debian.org>, Sam James <sam@gentoo.org>,
        Pierre Labastie <pierre.labastie@neuf.fr>
Subject: man-pages-6.01 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday!

I'm proud to announce:

     man-pages-6.01 - manual pages for GNU/Linux

This release results from patches, bug reports, reviews, and comments
from around 16 contributors.  The release includes around 14 commits,
and changed all of the pages.

Tarball download:
     <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
Git repository:
     <https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>

The most notable changes in man-pages-6.01 are the following:

- Build system fixes.  These were quite bad for distributors, which is
   the reason we released 6.01 so soon after 6.00.

- Document EOF, FAN_MARK_IGNORE, STATX_DIOALIGN, and a few feature
   test macros.

Thank you all for contributing.


Cheers,

Alex

==================== Changes in man-pages-6.01 ====================

Released: 2022-10-18, Aldaya


Contributors
------------

The following people contributed patches/fixes, reports, notes,
ideas, and discussions that have been incorporated in changes in
this release:

"G. Branden Robinson" <g.branden.robinson@gmail.com>
Agostino Sarubbo <ago@gentoo.org>
Alejandro Colomar <alx@kernel.org>
Amir Goldstein <amir73il@gmail.com>
Darrick J. Wong <djwong@kernel.org>
Eric Biggers <ebiggers@google.com>
Grigoriy <grigoriyremvar@protonmail.com>
Jakub Wilk <jwilk@jwilk.net>
Jan Kara <jack@suse.cz>
Matthew Bobrowski <repnop@google.com>
Michael Tokarev <mjt@tls.msk.ru>
Mike Gilbert <floppym@gentoo.org>
Nicolás A. Ortega Froysa <nicolas@ortegas.org>
Pierre Labastie <pierre.labastie@neuf.fr>
Sam James <sam@gentoo.org>
Steve Izma <sizma@golden.net>

Apologies if I missed anyone!


New and rewritten pages
-----------------------

EOF.3const


Newly documented interfaces in existing pages
---------------------------------------------

fanotify_mark.2
	FAN_MARK_IGNORE

open.2, statx.2
	STATX_DIOALIGN

feature_test_macros.7
	_FORTIFY_SOURCE=3
	_TIME_BITS


Global changes
--------------

- Build system:

   - Update manual page dates (TH 3rd argument) when creating the tarball
     with 'make dist'.  this removes the need for a tstamp commit before
     each release.

   - Don't print spurious errors from the Makefile that are not relevant.

- Manual pages' sections:

   - Title (.TH):

     - Remove the hardcoded date (TH 3rd argument), and replace it by a
       placeholder that should be changed when creating the tarball.
       This removes the need for a tstamp commit before each release.


Changes to individual pages
---------------------------

The manual pages (and other files in the repository) have been improved
beyond what this changelog covers.  To learn more about changes applied
to individual pages, use git(1).


-- 
<http://www.alejandro-colomar.es/>
