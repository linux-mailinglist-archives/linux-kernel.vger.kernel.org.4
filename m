Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3875617557
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKCECx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCECv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:02:51 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE7AE5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:02:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e15so602350qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvcYwR6HhsBfz3fA/MgVdCJOD7H5kWqLZ0DNtCa1bXs=;
        b=pJMpfNEJrA2CehpIjUwinR7p2WMsuy+2j6hvBReGR3hhzY7N3p5Vj+V9thtKvgM/PE
         JwtVGBfxbYR55hhNq49gughCUSLgl7BFwlDuoJhceurGmmwU6vaJu0Wp6WmpiUFjjr6r
         lDlbRZbs+1b16KlbO1dczoZ+dDdzG2Hep3k1AOgwsBThlhrrmcftKSQ7z/Y341oJZqhM
         S60UBqksAqmkDbIjbbsY62DLAi7nsUN12R2Ew2wZMhwPGuP9Qquv2m/omaBYrgHW/LBx
         pGnzMW2l6+64EcqGJzR7O/akTJeWBAiWdmQpCHTz3ZeFAz82s2kJwE+Oy4hjY+zNg66n
         Vgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvcYwR6HhsBfz3fA/MgVdCJOD7H5kWqLZ0DNtCa1bXs=;
        b=tWu1vLFa2MyzTG/8Uxp8naU0MFZAzKZsCWa6b5FaJ+0FcsZo1dp1vSuJ7HMp7vXHlM
         24EVsYK2M5MJ/lzrP+eF66CZOTBa/VmiPKwMeid2mSOvNq+adwoC+zl/Bzodd8C5VOZu
         VMBnAluGmK7ffrTreEP3F1DMsw2hCCF3t9YOlu7igd8bVgZdlfvJPr5C2ZHqR27VM5A8
         3iH9itIbW9WDwzPWT9rUcutBUsh4OIGfG1g8CUpgrFnNa2Azmvzbo6SzlwNwldNCr7Ap
         RQgMvK8SQelwbqjZrdiAu/goM8BX3bqSCpl9E4uUIX8PeOCv19rJeRqg2V2ka9OrUlMT
         cnig==
X-Gm-Message-State: ACrzQf0lv+XhuGxiHwmd67wovOcxGfk1GmQIls7rioUcz+29yzRgX2FI
        IKXRiHKYGn3WVwoiMHdM5OG1K0WzXgzt0g==
X-Google-Smtp-Source: AMsMyM7LE3kqx0uYAGU6Wd/tJyG5u8djFzJr0qQYhFh2OZMFogfuPXy7jiE0/KgrPaHdnwqyuXmBzw==
X-Received: by 2002:ac8:5c4a:0:b0:39c:f9dd:ee3d with SMTP id j10-20020ac85c4a000000b0039cf9ddee3dmr22712405qtj.443.1667448168740;
        Wed, 02 Nov 2022 21:02:48 -0700 (PDT)
Received: from sophie ([45.134.142.212])
        by smtp.gmail.com with ESMTPSA id r5-20020a05620a298500b006eeb25369e9sm5870636qkp.25.2022.11.02.21.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 21:02:48 -0700 (PDT)
Date:   Wed, 2 Nov 2022 23:02:47 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] memblock tests: introduce range tests for
 memblock_alloc_exact_nid_raw
Message-ID: <20221103040247.GA10663@sophie>
References: <cover.1666203642.git.remckee0@gmail.com>
 <d5481026b5b75e919e6497968453e86ab79b77d0.1666203643.git.remckee0@gmail.com>
 <b60e55de-46b7-3eeb-4ad1-914d8cc5f25b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60e55de-46b7-3eeb-4ad1-914d8cc5f25b@redhat.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:28:15AM +0100, David Hildenbrand wrote:
> On 19.10.22 20:34, Rebecca Mckeever wrote:
> > Add TEST_F_EXACT flag, which specifies that tests should run
> > memblock_alloc_exact_nid_raw(). Introduce range tests for
> > memblock_alloc_exact_nid_raw() by using the TEST_F_EXACT flag to run the
> > range tests in alloc_nid_api.c, since memblock_alloc_exact_nid_raw() and
> > memblock_alloc_try_nid_raw() behave the same way when nid = NUMA_NO_NODE.
> > 
> > Rename tests and other functions in alloc_nid_api.c by removing "_try".
> > Since the test names will be displayed in verbose output, they need to
> > be general enough to refer to any of the memblock functions that the
> > tests may run.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> 
> [...]
> 
> > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > index 2c2d60f4e3e3..df8e7e038cab 100644
> > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > @@ -18,18 +18,27 @@ static const unsigned int node_fractions[] = {
> >   	 625, /* 1/16 */
> >   };
> > -static inline const char * const get_memblock_alloc_try_nid_name(int flags)
> > +static inline const char * const get_memblock_alloc_nid_name(int flags)
> >   {
> > +	if (flags & TEST_F_EXACT)
> > +		return "memblock_alloc_exact_nid_raw";
> >   	if (flags & TEST_F_RAW)
> >   		return "memblock_alloc_try_nid_raw";
> >   	return "memblock_alloc_try_nid";
> >   }
> > -static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
> > -					       phys_addr_t align,
> > -					       phys_addr_t min_addr,
> > -					       phys_addr_t max_addr, int nid)
> > +static inline void *run_memblock_alloc_nid(phys_addr_t size,
> > +					   phys_addr_t align,
> > +					   phys_addr_t min_addr,
> > +					   phys_addr_t max_addr, int nid)
> >   {
> 
> I think we want to assert here that TEST_F_EXACT without TEST_F_RAW is not
> set --- because there is no API to support it.
> 
Good idea. Thanks for pointing this out. I will add an assert.

> Apart from that
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> Thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
