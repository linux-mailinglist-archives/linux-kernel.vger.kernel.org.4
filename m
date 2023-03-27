Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE86CAFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjC0U2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC0U2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:28:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D31FD6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:28:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so7795208wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679948882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Po9uD791nQbaXm9W7+4oFtCweTkYKUU0hLgFh7aJEkQ=;
        b=IqxBax1XAB63nS7fBzVbRV2WZIAC9O5jO82mQsi+VqE+x6KjkB0J5HzIN5DKv/xGIG
         DXM5+LafMOCQ7+xArekI0CBltHd+/BU0ZFlPNGBcoZUZBSWfTid/1NPDAjDBJbC1sKs0
         bkVVCyQviX7s9bb3ZdcYuwNRnUAArCIjU706IYTIgZPdhsEjz8FXRfFaaJ4SXecyzDnr
         3m07XTBGgO3CD832wwvcZswYYcf4Px0PwZnQ9VyFEPC0dhchuyWp4rLMkHT5PAAxidCw
         LQe5gyopX3yV9Rs5rUrB4nnmxhnM/xQyiKwTG6uIEAPHTBPEm+P3P8KLcbgT5pfz3P2I
         1x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po9uD791nQbaXm9W7+4oFtCweTkYKUU0hLgFh7aJEkQ=;
        b=HNFplMI5CqJOJk5U6jeIZtmu4842zQ/6uFs031AuQk0E8EvGX8E4k2PUM7XI9GYP61
         k82NucLE0aeiloSjJV3UVhsAm2XnxVmX0oPLr8bhV9gKYFPoi+73pZBxz4r7paBfUhlV
         sIV+0Ayp6/WYux5bKrIEgv2sEld5qtg75Df4cGM+c/wUCA86QGahgVYAE7rvXJFlJKCA
         luAQTEBJLx4xzBUEKgVyZPf6fPpkByHnKbnNipd4AGC9pEEFNDQ6OfDT7ObUCWyUwj/B
         X/6kwUu2BbDAZjSQtj3yVU9PLQtGwywdDK4PjGp5zZ9Y4eTEeN62aViyNt9txjnAwwz9
         ORIA==
X-Gm-Message-State: AO0yUKVdV2GHy5lwnLn11fNxFf9vIzw+3j7tNzWOe/cMI4NoiJWQ40dr
        KVP37VI2x9jSUATJqI7Hwh0=
X-Google-Smtp-Source: AK7set9mD6lXaNOZvYwMvOd5ec93Gn9CP1rLn5Tx0hnDQrPmjkwtvG36jq5rlkZfT9ajDxYfFIvAsQ==
X-Received: by 2002:a7b:c4d7:0:b0:3ed:a07b:c591 with SMTP id g23-20020a7bc4d7000000b003eda07bc591mr9993738wmk.1.1679948882241;
        Mon, 27 Mar 2023 13:28:02 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003ef4cd057f5sm10070583wmp.4.2023.03.27.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:28:01 -0700 (PDT)
Date:   Mon, 27 Mar 2023 21:28:00 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 2/2] lib/test_vmalloc.c: Add
 vm_map_ram()/vm_unmap_ram() test case
Message-ID: <68791932-5e23-4afd-9b36-6cc9a310fdd5@lucifer.local>
References: <20230327170126.406044-1-urezki@gmail.com>
 <20230327170126.406044-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327170126.406044-2-urezki@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:01:26PM +0200, Uladzislau Rezki (Sony) wrote:
> Add vm_map_ram()/vm_unmap_ram() test case to our stress test-suite.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  lib/test_vmalloc.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index cd2bdba6d3ed..6633eda4cd4d 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -53,6 +53,7 @@ __param(int, run_test_mask, INT_MAX,
>  		"\t\tid: 128,  name: pcpu_alloc_test\n"
>  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
>  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> +		"\t\tid: 1024, name: vm_map_ram_test\n"
>  		/* Add a new test case description here. */
>  );
>
> @@ -358,6 +359,45 @@ kvfree_rcu_2_arg_vmalloc_test(void)
>  	return 0;
>  }
>
> +static int
> +vm_map_ram_test(void)
> +{
> +	unsigned int map_nr_pages;
> +	unsigned char *v_ptr;
> +	unsigned char *p_ptr;
> +	struct page **pages;
> +	struct page *page;
> +	int i;
> +
> +	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> +	pages = kmalloc(map_nr_pages * sizeof(*page), GFP_KERNEL);
> +	if (!pages)
> +		return -1;
> +
> +	for (i = 0; i < map_nr_pages; i++) {
> +		page = alloc_pages(GFP_KERNEL, 1);

Pedantry, but given I literally patched this pedantically the other day,
this could be alloc_page(GFP_KERNEL) :)

> +		if (!page)
> +			return -1;

We're leaking memory here right? Should jump to cleanup below.

> +
> +		pages[i] = page;
> +	}


You should be able to replace this with something like:-

unsigned long nr_allocated;

...

nr_allocated = alloc_pages_bulk_array(GFP_KERNEL, map_nr_pages, pages);
if (nr_allocated != map_nr_pages)
	goto cleanup;

> +
> +	/* Run the test loop. */
> +	for (i = 0; i < test_loop_count; i++) {
> +		v_ptr = vm_map_ram(pages, map_nr_pages, -1);

NIT: The -1 would be clearer as NUMA_NO_NODE

> +		*v_ptr = 'a';
> +		vm_unmap_ram(v_ptr, map_nr_pages);
> +	}
> +

Reference to the above you'd add the cleanup label here:-

cleanup:

> +	for (i = 0; i < map_nr_pages; i++) {
> +		p_ptr = page_address(pages[i]);
> +		free_pages((unsigned long)p_ptr, 1);

Nit, can be free_page((unsigned long)p_ptr);

> +	}
> +
> +	kfree(pages);
> +	return 0;
> +}
> +
>  struct test_case_desc {
>  	const char *test_name;
>  	int (*test_func)(void);
> @@ -374,6 +414,7 @@ static struct test_case_desc test_case_array[] = {
>  	{ "pcpu_alloc_test", pcpu_alloc_test },
>  	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
>  	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
> +	{ "vm_map_ram_test", vm_map_ram_test },
>  	/* Add a new test case here. */
>  };
>
> --
> 2.30.2
>
