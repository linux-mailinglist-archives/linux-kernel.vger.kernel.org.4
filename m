Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520416D0E01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjC3SnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjC3Smy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:42:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF022CDEE;
        Thu, 30 Mar 2023 11:42:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so20074427wrp.3;
        Thu, 30 Mar 2023 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680201758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2fPzEeGQfGKvHIpXtPehtZ0JbbS+swuQ9EVmGDwLLEA=;
        b=HtX6Y03xeHioKLx988e7xQQTyhBoTywZuRNy6+OykxZQBG5iRT44BecKWnsodswzHS
         BRBk6JAs6fcVQPxzviOyWoLE/5Hn4mcTelCx6DMpFosKX8gwIlWIOhgw1eG9lfmR3i6/
         7IaqyAxWjpo2XirEuGXrbU47ZVDiRhy8D06oZyhDaRwqK0oCC8I6yway9QTohJjGRJ5r
         XrTTBPlqsVCzwoT5nC4dSWB2A+I/9FuopwgBoXIyBhGDCXghl6EyhJ6pYj3/3k1EBPBl
         pGLb+BbaeoyXUNUDtRx88GIDER/WTZVP0rr89eo4RnEXS2Z/v0F4Ql7fxC7Js3gHe4AB
         +L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fPzEeGQfGKvHIpXtPehtZ0JbbS+swuQ9EVmGDwLLEA=;
        b=5HYA2UYVgXMO3B1XCC7KQIrv64ftWGyuIug0aLGBNficjFM970NQCJSxX1fHTbKPPL
         2Pj7C0Uf/BqCS2xBtRdshRfBGCqblQAN68kAbQZnRd+bdaGwjrENoKXUqUo41WqNw3MR
         wP0MBkieh2W+Tfdt2c/WMwvseXi0o+1OmKACsU7ympA8p41OolwSjqSW77EGp+anIB5N
         b6sAb3mwkkDE5UIkkUU9tVlIGBNaBuf8MYUHjCPG/hInw5B755y8JWTyiNNkm4MLhxod
         nzJHfrW39ZGLBLTyc42OGCv/UpwP9hEIC/xuZ2N4gJfWJidlBOnOeKjfHXSHkA+NfgMe
         InKw==
X-Gm-Message-State: AAQBX9cWCwo6+XnRVqYfPhqgMAekJmzkTM20wvv7ePSKp0PXy/oquPmI
        CJzTjHOlUMbokzcaPhENI6Q=
X-Google-Smtp-Source: AKy350Y5DDfVY64K5seLH5yUFT65ouB/N/TVyyiwQ6GJYaZBgTP1CSO3OTSCDVHGopJOmaiElejokg==
X-Received: by 2002:adf:db4b:0:b0:2d9:eb77:90d2 with SMTP id f11-20020adfdb4b000000b002d9eb7790d2mr17610492wrj.70.1680201758038;
        Thu, 30 Mar 2023 11:42:38 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002cfe3f842c8sm70489wrv.56.2023.03.30.11.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:42:37 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:42:36 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     stsp <stsp2@yandex.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: MREMAP_DONTUNMAP corrupts initial mapping
Message-ID: <498d7a19-2b29-46ea-9c34-ec8fb7394e6c@lucifer.local>
References: <aee53ac3-6d25-5009-7416-3f7c5fe1f989@yandex.ru>
 <38c80313-ba1c-092c-ae31-f58fe6ffa82c@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38c80313-ba1c-092c-ae31-f58fe6ffa82c@yandex.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:45:14PM +0500, stsp wrote:
> Add a few CCs.
>
> 30.03.2023 17:38, stsp пишет:
> > Hello.
> >
> > Attached is a small test-case that
> > demonstrates the problem.
> > The problem happens if you change
> > some data in a file-backed private
> > mapping and then use mremap on
> > it with MREMAP_DONTUNMAP flag.
> > The result is:
> > - destination copy is valid
> > - source copy restored from the original file
> >
> > So the 2 copies do not match.

This seems to be a case of the documentation not quite being correct in the
case of a MAP_PRIVATE file mapping, from the mremap man page discussing
MREMAP_DONTUNMAP:-

    After completion, any access to the range specified by old_address and
    old_size will result in a page fault.  The page fault will be han‐ dled
    by a userfaultfd(2) handler if the address is in a range previously
    registered with userfaultfd(2).  Otherwise, the kernel allocates a
    zero-filled page to handle the fault.

This documents what happens with the combination of MREMAP_DONTUNMAP and
_anonymous_ mappings. This is accurate in the anonymous mapping case
because after move_page_tables() the VMA remains the same but accesses
cause page faults which will map the zero page.

However, MAP_PRIVATE file-backed mappings have different semantics - if the
page table mappings are invalidated in any way (typically due to file
truncation) then, on fault, the mappings revert to a CoW of the page cache
entries, which is exactly what is happening here.

I think this is probably the behaviour you want because fundamentally the
VMAs in both cases map a file and these are the semantics associated with a
MAP_PRIVATE file mapping. You'd otherwise have to either change the
original VMA to be a wholly anonymous mapping (which would cause surprising
behaviour on truncation) or you'd have to explicitly zero the memory and
CoW it in which doesn't really sound appealing either.

Overall this strikes me as a problem with the documentation being a bit
outdated since MREMAP_DONTUNMAP was extended to non-anonymous mappings [1]
and ultimately needs a slightly tweaked explanation to cover this case.

CC-ing Michael, manpages/api lists accordingly.

[1]:https://lore.kernel.org/all/20210323182520.2712101-1-bgeffon@google.com/
