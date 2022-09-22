Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1E5E5F38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiIVKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIVKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:02:25 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D671B7E034;
        Thu, 22 Sep 2022 03:02:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 198so12029245ybc.1;
        Thu, 22 Sep 2022 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=46WsTnH5ccNyRkMXYOObMQszQI6d/3B1gqlNg4zGq6w=;
        b=nVTNGq2CMW0LwvvlSXN/KOnp/37iI7xSNaFrA9XbITuGnnjmJSnnY9GDu18y1aXxOz
         /gmR4aOUW2Gy1yNEucIiF3DIdIhi319Gui9QY2tj075u72eupvwa8JC/0QbKWkK2U/gy
         +qGdFZh+Z4R5lTjUo6Us2d1CsZnqBgfshFftr6mozaYr8sFOlqooMO5LNfqE2Nj+b+/x
         rgzLfatp9uV9LGufGTnO2ckk8IxtZH7SZW9w/FWWTM73SeW56DNPzk4qLAB0P4XCL2L9
         lONZ9zOpRo/A6ezxzCTxQLiFXePdvgNueJwIoypkdb3Dt66elZ8T+nhni+QWOf5rDyZt
         vOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=46WsTnH5ccNyRkMXYOObMQszQI6d/3B1gqlNg4zGq6w=;
        b=URFAktS/azlutAvAze8qmOHt9RcxyRnAaNvXCwangpG98fmihhAxx0qPVPAjKmPMUw
         Ejf/Re7gNik4tYHJaFHg6kzf5n+DIErpl1ISompcvHj+f+o/tHm5Xcr30pZ3500Xnap3
         /1uHgPQInScNgRdF/+JoDlit3iPusTbZVdD9MSFRp4gJh0PHdqdJ3EIT831EHEybab2q
         a45MtBU8NMpQgWK1heSgq7tQ7a72OLAmxAhxxJMFUmKDgHtMju1i5YLXaXwOI3+cOCHE
         Hw1I6C6YyRgzlSe/f47hvfOTgVN9baC4efQvbyj8HI3OBwpV1Ej6drCV++6T9j5z8TGH
         PWpg==
X-Gm-Message-State: ACrzQf1QRfyhbx1mFNZ0Q/m+cnmRNkPkA10aBBho3U8MIzWxKXbvKCPm
        8IXdqExEONPn4QEDukYJPck1mIleRVJSAisb8yoq9Th3agg=
X-Google-Smtp-Source: AMsMyM5LzWME31dkryngzwq4K/qwIch4VrMtIzr27XxPwONL39453ZiIwLkMDNxO2AlqITApER46nnvdEVeWEIdvmg8=
X-Received: by 2002:a5b:842:0:b0:6a3:cf26:755d with SMTP id
 v2-20020a5b0842000000b006a3cf26755dmr2526623ybq.608.1663840943987; Thu, 22
 Sep 2022 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220919084744.3043-1-lukas.bulwahn@gmail.com> <20220920064332.GA17325@lst.de>
In-Reply-To: <20220920064332.GA17325@lst.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 22 Sep 2022 12:02:13 +0200
Message-ID: <CAKXUXMx=7oonR05W0TXW+AAN5FmD86mfiTS=QGFnvUMxRWFa_w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections
 after refactoring
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 20, 2022 at 8:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Sorry for coming up with this only now, but what about just dropping
> the separate swiotlb entry entirely, and just add include/linux/swiotlb.h
> to the dma-mapping entry?

Sure, great idea. I just sent a patch v3 doing so:

https://lore.kernel.org/lkml/20220922100001.12964-1-lukas.bulwahn@gmail.com/

Lukas
