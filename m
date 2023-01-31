Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E369C6835DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjAaS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjAaS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:58:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E41422D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:58:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so15434724pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TP6A9+wpIMvqF2KNq6LBjoVcO3DYja8lhfZN/jsXFAw=;
        b=ksnvyCeU1RyWc0VKTsa9dgJxB59yOHGjX1cproOM8Mp0Y8nfkqnlmuozL7CBe/ZWah
         rdN+MiiIujwE1kfpwsxFPDD0y+gVSFDktlxpdznzekylT+20RXCpZNiIXcnQCaFguseq
         tFH6vGwpn9pNSCCsauN/XDtwxc4eoBEEjz+ejaVgpAwghYyA3IWL0pwH3I8tzq0Rucrt
         PXswITHQJ0ByasV3kA7AuZbl6VHFqoGX1PewA9mhOdGXX4YmJPMM1Di/KszXCtQ9jLU6
         5ThiCtMJKnxDsPlUPhvRPGqaM3xWakLsFrTNwXIubYdud+su0oPhnZc7EF4R5Ba8kue4
         d0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TP6A9+wpIMvqF2KNq6LBjoVcO3DYja8lhfZN/jsXFAw=;
        b=I1bAqXrmDViW5xArxa/bH/1vERsNKYv0dSc7LzKraxeCIkzMUUvpgPOg+UZXTYPoE9
         txgxaFCWfjAzmIC+3huoR+ziXoU/pOMLKItdoG//TLF+d0Gl9433tsG+tBDe+evn7s6y
         /YmKo8dNd2G2jrqVMZWnKaRLc76rMP7yZFTHNcEz+mdjYJw9zcB6WdWMxiypw4iLSdUF
         fIwE4aFs+GHHUo5KT3Mac9xzkh//C6N4nVJRCh6jfpG5vtVXBSPk3EMgq0/p/dvUXb2P
         ZSMDSbQQ4oTyosjyM6Iwj/o0IZ/iJnM2fB2fPM6kzcY8+9iLfyN0sIWRcJo5RQp7AvXV
         IwOw==
X-Gm-Message-State: AO0yUKWeGOFnTlceRZFPNzhl79ip4P4884cqoJohI7gT98PSGlLix4T3
        6feKq2cn0H8FW7/RVivRSCzNc2gwfFvWn/42Hnk=
X-Google-Smtp-Source: AK7set8XCyt+bK6u6JefsBlIVz/6EymxzMOrBX8XuUIRF3cIGW2hgOy0wXlEZ2nWAqBijXJWrNFkg2XkWsSCoGHya8I=
X-Received: by 2002:a17:90a:6ac1:b0:22c:697a:e056 with SMTP id
 b1-20020a17090a6ac100b0022c697ae056mr2201922pjm.85.1675191534976; Tue, 31 Jan
 2023 10:58:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fbe58d38b7d93a9ef8500a72c0c4f103222418e6.1675111415.git.andreyknvl@google.com>
 <CANpmjNPakvS5OAp3DEvH=5mdtped8K5WC4j4yRfPEJtJOv4OhA@mail.gmail.com>
In-Reply-To: <CANpmjNPakvS5OAp3DEvH=5mdtped8K5WC4j4yRfPEJtJOv4OhA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 19:58:44 +0100
Message-ID: <CA+fCnZeOs6R_Wk=Da-aC5ZUzz_tOPVQWu1DoPsYVORS=dJ6cQg@mail.gmail.com>
Subject: Re: [PATCH 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 9:54 AM Marco Elver <elver@google.com> wrote:
>
> > +depot_stack_handle_t stack_depot_set_extra_bits(depot_stack_handle_t handle,
> > +                                               unsigned int extra_bits);
>
> Can you add __must_check to this function? Either that or making
> handle an in/out param, as otherwise it might be easy to think that it
> doesn't return anything ("set_foo()" seems like it sets the
> information in the handle-associated data but not handle itself ... in
> case someone missed the documentation).

Makes sense, will do in v2 if Alexander doesn't object to the
interface change. Thanks!
