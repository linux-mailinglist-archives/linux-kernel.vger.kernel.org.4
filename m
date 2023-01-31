Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B993E682B93
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjAaLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAaLe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:34:57 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A26E87
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:34:55 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id bs10so7215199vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2XA9F8dT5La7FNowNfZ+ob9NzupifQzUI33ZbhcRFf8=;
        b=gwtEvNWV1tJLRrrSnYDPf62/TGYX7LvOhCahv9HSd3JPsVxBl1vfbriv4DYEU7MEuV
         pmU8HkhzQB1hOCxObX/7G5iErNclUZBaTWKa/2NMwjo/xoCvdSozjdF7I5Gww5fzM+s5
         TwSI9cF0x/9jcWd0cF8MizVOnjUnLamxnElCNdXZUZN7KxQC2yjqKBFJ/6I5spWARpA+
         vSFDg1gvct8qAGWmDbkzRlKCn9ciCpnEUuEQAoeOtg2Ni6b5NdgfTCUo1ppU7NudSUol
         SjLiacYX1tNNN1pfYxrYH1Wg7pSzH+2XUq1bs9IkKNVJukMkEi/s/WZtfG/PK8FKeUH8
         A6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XA9F8dT5La7FNowNfZ+ob9NzupifQzUI33ZbhcRFf8=;
        b=ilsxst419P2XNVt9GGuPsCVlSxGaajVPkOMncl4HtSYXWSKuYvhI999uFbTpOyivja
         G8lbdzGd8y1R2CiT9azOQnos1Q7NwD590i3LVrL4CKDc39PIj/Tx2YLTQXpR3Ek+K9em
         LFYXEwLT4xlcN26bPOvkEiPPhcmLCoXksVF6ANtBD/jIdoLDRoa//HJkmD9RauHZbz9v
         T2ZBx4L9JXTAc+IiD7FJtiZfet8gI/mey+uaHDv7faI9PvpuRgFYMxBQ8rdp8uK/xKGD
         ynpY4+/uJGc30g8af/6N+h9QdnTyNS6iAY9+ure1Zo/4W/2/i592ov9QWQG9NPb+SXqh
         4EOw==
X-Gm-Message-State: AO0yUKVf+01Ymq9wkuqPL8jWQi261Y508ojKYkhs1ELAtayCQF6y3d+X
        m+2crb1ud5btkugDqSmPlPUtH+VPprnl6hV0bEAJWg==
X-Google-Smtp-Source: AK7set/W0WmNEw8E54o2t/mlgZtsc+pm/8wqkXV25xInC/mfTFGPTkEFHWp/0vcxWdmx/J6EnFIyGTPsEdfv7eTJaJA=
X-Received: by 2002:a1f:d187:0:b0:3e7:295d:64d8 with SMTP id
 i129-20020a1fd187000000b003e7295d64d8mr2731185vkg.35.1675164894961; Tue, 31
 Jan 2023 03:34:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <b756e381a3526c6e59cb68c53ac0f172ddd22776.1675111415.git.andreyknvl@google.com>
In-Reply-To: <b756e381a3526c6e59cb68c53ac0f172ddd22776.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 12:34:18 +0100
Message-ID: <CAG_fn=UN-K2W9E+q=tHheda8BGCzoPg5-riXpDyiSaLqjekNkw@mail.gmail.com>
Subject: Re: [PATCH 10/18] lib/stackdepot: rename init_stack_slab
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Rename init_stack_slab to depot_init_slab to align the name with
> depot_alloc_stack.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
