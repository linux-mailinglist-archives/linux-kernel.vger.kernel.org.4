Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D560B58B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJXSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiJXSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:31:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD85D8F50
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:12:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u15so11524549oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHZiogCmLEgrbZXwJ4SEXDeSCsbCBF+dnczglI3cIkM=;
        b=sFC+R5Zfk1TSR7kl6HWKBZNYr46JzH79qruoNybgynbpVV9vmUYC4gIBYYwv+ODWku
         1MoEl6QsGUIfI01blbY1qPYJBIc6Fl4aPM8H8DrWkp4EuZeijPPX0C6Zmb/z+CZjDxGI
         2LWXFxfEH6hcX9Vd3RCYHjWbqm0PdAgNwpCmukTVaRq0IEi1zitWuzw2+7u2acfHVdKX
         LOyraHKQlnu167HWOt8Gow6uVpK/UIKJCL+f0ovmK74VvjhSrvo+5LMpKGjlF9rNzeR8
         m6v7Duq5L06IUv8LV9wL91H2bSyk01HScPAGVdowg5uhkkWHGz9rTmyXn0Nr4dsxHlK4
         4uvA==
X-Gm-Message-State: ACrzQf3mZjH8ZxZLdScV2nAIMlQCTX0f0dCF8RYCxnkEs+s8z7doLAbR
        RcJWtU4fu6ori2+scCFGKajs3CTGbps=
X-Google-Smtp-Source: AMsMyM7CMNNidB9v2x1XBYXmR7tlmfi1ln27OafIvYRQdns+rLF+U5tvIFSJAKQw4P04a/8kDRIX0g==
X-Received: by 2002:a17:90b:3a90:b0:20d:a54c:e5cd with SMTP id om16-20020a17090b3a9000b0020da54ce5cdmr66852951pjb.183.1666630989080;
        Mon, 24 Oct 2022 10:03:09 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id m126-20020a632684000000b004588814ca73sm5872pgm.21.2022.10.24.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:03:08 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:03:06 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 7/8] mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
Message-ID: <Y1bFSoZuPOI3Tuxu@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-8-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:34PM +0800, Baoquan He wrote:
> Since commit 40064aeca35c ("percpu: replace area map allocator with
> bitmap"), there's no place to use PERCPU_DYNAMIC_EARLY_SLOTS. So
> clean it up.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/percpu.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index f1ec5ad1351c..70bc17db00a6 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -37,11 +37,10 @@
>  /*
>   * Percpu allocator can serve percpu allocations before slab is
>   * initialized which allows slab to depend on the percpu allocator.
> - * The following two parameters decide how much resource to
> - * preallocate for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or
> - * larger than PERCPU_DYNAMIC_EARLY_SIZE.
> + * The following parameter decide how much resource to preallocate
> + * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
> + * PERCPU_DYNAMIC_EARLY_SIZE.
>   */
> -#define PERCPU_DYNAMIC_EARLY_SLOTS	128
>  #define PERCPU_DYNAMIC_EARLY_SIZE	(12 << 10)
>  
>  /*
> -- 
> 2.34.1
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
