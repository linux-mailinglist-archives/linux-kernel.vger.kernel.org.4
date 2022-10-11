Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06E5FAB99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJKETP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:19:14 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278273C2C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:19:13 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so14560117fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwFKSGNDkHGgFwaYbMK1edZVlCyT6HU0qnyYOuABxaM=;
        b=Jqt2I71DlapaGAjgnNF3xp4Lgh40cOMsOegOkwJMCNbZ+SnQUXVpJ+NEbgRdGQdONf
         i6Bh4T8Zsx3ocMc0GueMXXsU7CfQOQ0U85CyjStKryqM9wib++tpE/9JT9tNREScH/rU
         PwKw9Ty6xXUBEZs+W4lzLlNFRzB/LCCHR9pL4/+8tzRAxpqWDPDvFTmkH/ZUVNNN8Ryl
         Ns0sKi6V4f6BI043y3vSx+L6VVjHlh9yex1mGM1imui0m1tCSmIamTijmMryroUAQZBQ
         5ZabdREaJ1y3bfMnr9EZSJS7Qwf9i2ths2W0+G26NeDHoQtI9K11Ar44HCTaYKyLFSY0
         7bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwFKSGNDkHGgFwaYbMK1edZVlCyT6HU0qnyYOuABxaM=;
        b=pMuan/wyLQsclI3E6kDitYnEYwsgYNaL+CRcAHDlIY/w4mjorXHNvfxYvW2I/dKjZI
         wyPMFsVDnoews2R4qvchiJYT4C4V7mbyKhQjUIg3AWrR9O2RnkfpHT8S1xVlNR9z59Tc
         L8birr/lHxduziml53iE907bhDe1Le9lSkdvtHghBfaljAMNDUDTYl9H8cROwatVFSVv
         ccvWcvikKrjmOoCGHS1oa17wlSx7e33E0gWyBVPwFTQFWK78cenUOmovVUtGGzmn+V1z
         aP0CoJX9INv3Aji+0F5IF6bAJI469S3RZ0JP29ChuS+rksgedH5nUE95diJ7Dsw75+0n
         IrvA==
X-Gm-Message-State: ACrzQf1/7LEHRHxgg08d6mV54+gdgiFgNBQvL85Xb6b6UIRG2RjCgp8B
        tTucMU/zfVRmR7fjyvSTuE7i3Sadx9o5ng==
X-Google-Smtp-Source: AMsMyM5mJXEZy8ZKbImI4UALR0tPYRNr5onG8MB6Iv5tXfSNOBm8mhW8mlQs854WcEn7/qDCB3I2HA==
X-Received: by 2002:a05:6870:42c5:b0:136:4add:e0e7 with SMTP id z5-20020a05687042c500b001364adde0e7mr6625934oah.240.1665461952607;
        Mon, 10 Oct 2022 21:19:12 -0700 (PDT)
Received: from sophie ([206.217.205.57])
        by smtp.gmail.com with ESMTPSA id c21-20020a056830315500b006619701dc1csm2283429ots.54.2022.10.10.21.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 21:19:12 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:19:10 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] memblock tests: add range tests for
 memblock_alloc_exact_nid_raw
Message-ID: <20221011041910.GA7782@sophie>
References: <cover.1664753534.git.remckee0@gmail.com>
 <c73a6fd7fc3fa4529a6e444b9602d9c63ded91fd.1664753534.git.remckee0@gmail.com>
 <b44eee1a-0d61-f5bb-7b0c-a01f13a0b297@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44eee1a-0d61-f5bb-7b0c-a01f13a0b297@redhat.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:16:03PM +0200, David Hildenbrand wrote:
> On 03.10.22 01:41, Rebecca Mckeever wrote:
> > Add tests for memblock_alloc_exact_nid_raw() that are very similar to
> > the range tests for memblock_alloc_try_nid_raw().
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/Makefile               |    2 +-
> >   tools/testing/memblock/main.c                 |    2 +
> >   .../memblock/tests/alloc_exact_nid_api.c      | 1208 +++++++++++++++++
> >   .../memblock/tests/alloc_exact_nid_api.h      |    9 +
> >   4 files changed, 1220 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.c
> >   create mode 100644 tools/testing/memblock/tests/alloc_exact_nid_api.h
> > 
> > diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> > index 246f7ac8489b..2310ac4d080e 100644
> > --- a/tools/testing/memblock/Makefile
> > +++ b/tools/testing/memblock/Makefile
> > @@ -7,7 +7,7 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
> >   LDFLAGS += -fsanitize=address -fsanitize=undefined
> >   TARGETS = main
> >   TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
> > -		  tests/basic_api.o tests/common.o
> > +		  tests/basic_api.o tests/common.o tests/alloc_exact_nid_api.o
> >   DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
> >   OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
> >   EXTR_SRC = ../../../mm/memblock.c
> > diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
> > index 4ca1024342b1..278f9dec5008 100644
> > --- a/tools/testing/memblock/main.c
> > +++ b/tools/testing/memblock/main.c
> > @@ -3,6 +3,7 @@
> >   #include "tests/alloc_api.h"
> >   #include "tests/alloc_helpers_api.h"
> >   #include "tests/alloc_nid_api.h"
> > +#include "tests/alloc_exact_nid_api.h"
> >   #include "tests/common.h"
> >   int main(int argc, char **argv)
> > @@ -12,6 +13,7 @@ int main(int argc, char **argv)
> >   	memblock_alloc_checks();
> >   	memblock_alloc_helpers_checks();
> >   	memblock_alloc_nid_checks();
> > +	memblock_alloc_exact_nid_checks();
> >   	return 0;
> >   }
> 
> 
> memblock_alloc_exact_nid_raw(NUMA_NO_NODE) behaves exactly the way
> memblock_alloc_try_nid_raw(NUMA_NO_NODE) behaves -- which is essentially
> memblock_alloc_raw().
> 
> So do we really need a separate set of tests for these?
> 
Instead of a separate set of tests, I could add a flag for
memblock_alloc_exact_nid_raw() to test_flags so that the range tests in
alloc_nid_api.c could be run with that flag. Do you think I should do
that, or omit tests for memblock_alloc_exact_nid_raw(NUMA_NO_NODE)
altogether?

> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
