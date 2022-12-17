Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449964F8DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLQLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLQLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:44:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6013EAD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 03:44:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg10so3475526wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 03:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBSVB2Oi5TbTIwwaOpRKfNJzplXssZ9oR2ZKAZimo4E=;
        b=k0fpKgaZIUGDT6X0DZ06jlzs25bISKhHU8bB9iJXybs6SUxcmHz9r0S8xiebXfjzX8
         THW+vbhhcdK+2AP0ygoxLy2aURFM1ZisP7eBv1m0Y1yBXewI5nBtOl+ZZ3jOn+lBcoTr
         T4jbe7AmYMuKIgpOr2CCC7SsOZMuIbfKb52WMBhhAxowekO3hr9891cassApDuvzcSYV
         NfOWeLj2rP1/jdtA1r6KV9xpZmrQW3OBh4AT1J8oMES7ixoKtzYbANxIlTaYyYyQM3Mm
         npGVkj3MjY/3JPn/uDpJJNcLMuoSN+UR1B3jVLSvmYo2UqF30KFUzfh7M5c+5EVTv6Zc
         1d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBSVB2Oi5TbTIwwaOpRKfNJzplXssZ9oR2ZKAZimo4E=;
        b=mbe3h3CmkBpL3aIgAz6EI0T7Gi/wr7otr+dNpwivDoasrUGWBLLGPLSrwzbnt2T7C4
         k6PSHSgsN699Vu8jcrW/31NgQGKwaDZxebyd1I/PAJxVkWG7ZCQ6x5d+jk/C566IuaYE
         atz/dmovx+Hi29UdI6Se/rnEFg/KM7jRZ1w/SKcNQTuNWbc5rYrba3x+TaUm516f6/WD
         OI8ALT5cDOaenJtOkqH+5cd4QYk3AOJ8BA7YHVFQWr5p+YNnz7HJoiCr7cTJH5plPNMZ
         4sOM1zDaelsuUPnAXriO4ZJk2IbBFlisO2PC6ZUDLf4jfgwsotjiXnOcfEa/g4nRvEys
         Pr+w==
X-Gm-Message-State: AFqh2krLI2SzyrdOO8naALlEu9cb6SYSjWwS2jb3vJtdq5wjQ/Tohq3J
        wcFEi2iJ5jUNrTZFatZ5b/M=
X-Google-Smtp-Source: AMrXdXt6sqQP1NtKTr05MgB5iN/MzMucgIdOEJXOXRqsztLP+6QiRv2Fa9AnrwbtJV0dBnZ1y4jSWg==
X-Received: by 2002:a05:600c:210f:b0:3d3:4406:8a3c with SMTP id u15-20020a05600c210f00b003d344068a3cmr4380165wml.32.1671277463842;
        Sat, 17 Dec 2022 03:44:23 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003b4935f04a4sm6505486wmi.5.2022.12.17.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 03:44:23 -0800 (PST)
Date:   Sat, 17 Dec 2022 11:44:22 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y52rllbXHMwbpJ8K@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217015435.73889-3-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 09:54:30AM +0800, Baoquan He wrote:
> @@ -2229,8 +2236,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  		return;
>  	}
>
> -	va = find_vmap_area(addr);
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
>  	BUG_ON(!va);
> +	if (va)
> +		va->flags &= ~VMAP_RAM;
> +	spin_unlock(&vmap_area_lock);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
>  	free_unmap_vmap_area(va);

Would it be better to perform the BUG_ON() after the lock is released? You
already check if va exists before unmasking so it's safe.

Also, do we want to clear VMAP_BLOCK here?
