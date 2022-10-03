Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BA5F2801
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 06:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJCEfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJCEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 00:35:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEEE1CFE2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 21:35:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f14so2690925qvo.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LpPI6vkXD3u2g8wDKjzxtIs6vUGFNi5qEVKe3v/ympo=;
        b=fAtIWIJeHlZykZKQWtXE2NSSCZBGrGPJI8sce70DmtFPe424BlQLCWO+InRzHGQUjc
         vr0vv3UkXXpr6OMb3T+ch9Db/z5couvpHG0so0UGCBFFkD4eozDrwA/C0HoUM3GuTh31
         Eq44MAQnbTtz1c8LVi4JOCxEQ+tvQNl4/xe8WforWCqy1dmyYd2zCuASF9JFzgT5i+3w
         QohCmk+NmKmS9an1LP0BnT+NesZwmM689EqncpqVoF3/ShOKXD51Kh5TyibEc/E+Ph86
         uMsewo+ngX03uDH0a9jU6CjhmUWvxqE7zEMUaQZpUkdeh62TR+GeK5UIM31WkFMD/ND2
         bBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LpPI6vkXD3u2g8wDKjzxtIs6vUGFNi5qEVKe3v/ympo=;
        b=sGo6P0RMMv5ebS+sBq+SQAKcG95oA0IJQ9IQlvt9VFVF8y1Q9spKbiU/Ppt58/uuHw
         bE5qM2kkR24bC57wEGWhlftukp8Heiy4uhZ5t9pmzQGWI8JA5LBgZV2b0eWKFtoJ7n7H
         t6F8PUHn1jcts+q8R7/M0c/k637Y4mXj8lKIxk41Qoj6+yORm+Yw/W22gl8sPEM3DmF0
         QluZLg7YTAevYI0z8f9d4F88pHpC3mg0HhU2UEZQJlSvcwespddxdXpHBXk8f51mgF5+
         gIxD5nKEXax6Natqwf5SMsxYAjO3cFl5AsTE+jJ33id7s+kyss2mGSnKTHdeKRg2QfBQ
         VfUg==
X-Gm-Message-State: ACrzQf2kfVTNPeeQEb157YzPmxxOf01KUB7NaOYusCfxV2xpl+NPLL58
        +8okOshXvvsj7uOBBfvYh2RMRXwfWhnZzTN+Fsc=
X-Google-Smtp-Source: AMsMyM4ojQjDKDyNSlMH77OrFfBwVA/YWEjxjjv04FBfo/fr8JceCRUELXzwfu5AyIiD71mfB88xMdFTDDivPO6hc3s=
X-Received: by 2002:a05:6214:21eb:b0:4ac:7ac8:345 with SMTP id
 p11-20020a05621421eb00b004ac7ac80345mr15042920qvj.90.1664771736942; Sun, 02
 Oct 2022 21:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220926043618.566326-1-zyytlz.wz@163.com> <YzFkpRfkdnwgDDw6@kroah.com>
 <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com>
 <YzMmp9llFUN1yUDH@kroah.com> <CAJedcCxjjNFsHibTO3-M6a8vay3-2LcSN=0dNkqCicLakG4wOw@mail.gmail.com>
 <CAJedcCxjYDj5s2XbGDYSVMkcdZPOLqz5joN-L6P3aJzQ1Jy2_Q@mail.gmail.com> <Yzmc0kAQQeiUZkq9@kroah.com>
In-Reply-To: <Yzmc0kAQQeiUZkq9@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 3 Oct 2022 12:35:26 +0800
Message-ID: <CAJedcCxpyCeBBkg48xDeJRNT6Cs9yqQAqvqHoCcUs_rcgBNCYA@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Sorry for my mistak. I thought reopening another theme is fine. I'll
read it carefully and send th pach again.

Regards,
Zheng Wang
