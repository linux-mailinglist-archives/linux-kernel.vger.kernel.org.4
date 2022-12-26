Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B665608B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiLZGxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiLZGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:53:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A311105
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:53:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so7138968wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6Bjyq3PbciobfHplcIqHi8GfNd0dEieI1UmWpyNQ6A=;
        b=Fj7+aTaGeZ1OWqiOzCXj6wkcKchXkxXTx9RjgW3fraSv5+Ren1F7xTzO/kI6Vpebb6
         rduIP8kgYsyZnxOqsPY5zY91+KXEAFWHPpCEF8DvshlBvxisqO+gtdUMJwtftx9ngJAi
         s7E153x/B7fysxAjmUIs4OI95KjQ76qlnrRN90m1z0aSc81X5Mmsj0RU5FfwPTLTnoEp
         61xcSucY9A1KUmXeOvTz/veoxdDMG3BBH+lWwfYKpXifs4aBbWzzQPAL9NS7yJ+LOFVM
         TR0912mdRnBhhkk2doKzXsIQwaYw1wzhK+rfdCLBJ8envYY0NfK4EPZffehVWTKeqRqS
         IofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Bjyq3PbciobfHplcIqHi8GfNd0dEieI1UmWpyNQ6A=;
        b=OzU96MzAUo7HE3Z70YJKzIJxutkV+9lrxXdlSDtps84m1cMPbG/o+3pejlyE48SM+B
         JvyZMYNE4TJxpP/tDH9bGmRX4Dl/7SMavrcfBoEFsG2ZC04eY1N2PNqQu07VkKEzDXu9
         urX6qCt2wJ4h8vC0AjIgq1jHq8H7a1dglyaSa0AFpJbZhfw81UB6ko/bRoon8bD5PPcl
         GEKtvKg1xPJZTcZbIHWkEthSMq5n1xQZnQTH+citwhngNGWvoDpH8og8PM7FX0AQU+he
         WILhQHHSDIYXz2QVYpNR23oFHTZCRWovuga1kBVPE53X3qdEDwjemGtzJZFAInLYblOa
         S9Mg==
X-Gm-Message-State: AFqh2kpaQ+h1Cesb5nMZEURM9y8QdxU2GCj/xprj8joF835TbHQdC/8U
        08fyZbxpDrqgwgKizGPg/VQ=
X-Google-Smtp-Source: AMrXdXtQPgBmtSPhx6oAqH6QhBicZ+d2CSffh+eEps9w12f7PsnrQKaeB7CxpPudPEwxwXmwxPtUMw==
X-Received: by 2002:a05:600c:2e44:b0:3d3:4406:8a3c with SMTP id q4-20020a05600c2e4400b003d344068a3cmr12037558wmf.32.1672037583299;
        Sun, 25 Dec 2022 22:53:03 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003d04e4ed873sm1624763wmo.22.2022.12.25.22.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 22:53:02 -0800 (PST)
Date:   Mon, 26 Dec 2022 06:53:01 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/4] mm: mlock: update the interface to use folios
Message-ID: <Y6lEzZtcbpp+OgvD@lucifer>
References: <74874865335885dabe0751c1140a6d198dea333d.1671738120.git.lstoakes@gmail.com>
 <202212260802.sZoecM1D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212260802.sZoecM1D-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 09:05:42AM +0800, kernel test robot wrote:
>    mm/mlock.c: In function 'mlock_pte_range':
> >> include/linux/page-flags.h:273:43: error: '_Generic' selector of type 'void *' is not compatible with any association
>      273 | #define page_folio(p)           (_Generic((p),                          \
>          |                                           ^
>    mm/mlock.c:323:25: note: in expansion of macro 'page_folio'
>      323 |                 folio = page_folio(pmd_page(*pmd));
>          |                         ^~~~~~~~~~
>

OK so this is a product of motorola_pgtable.h defining pmd_page() as NULL and
the type magic in page_folio() getting confused. Easy fix, will spin a v2.
