Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F76060AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJTMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJTMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:55:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B88A1E0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:55:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id i17so25251275lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fh5EydRcU3nZz8dXo/oBnTkKwNMvB8kiOApoxijExX8=;
        b=HeTBqNE4swL/K8pvHH639ImHABXhtkTLwOqZljezeVYlOZR4/XVUSmwDd7tsSYbBlN
         OdEd3bvZhZrXKVkU9mVGY4bA5GJfEfOimPEJzgvtYq6sA7NIx933zsk7WRsCWprPAQpZ
         NCKnprNzweEgUr2CIvk4uKQiVwV5CIs6l+8hCWDm9JK5IjJM1W6XxJrQJlRoT7HkUvmv
         71f+snUydhPOPFoaudHSwdFS7zH4z/uAc0d0Xc48pehjDDtPCD7WEXC/CIjb7Na68nBw
         rOV8XHTVSMPi0ezTvmC9ybd1j6uu5+cxEdzdtf4gc74ic0JY4iGqWR3AKVkaf9fDhsDy
         LzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh5EydRcU3nZz8dXo/oBnTkKwNMvB8kiOApoxijExX8=;
        b=PvKuz+XhAOCc+OK62daoeqNtmT2c9K+H4/8BHO9ZmEIqPRYyTvDdsr2GY8GNbFqtCd
         jePlxxVlhCeZrW/kyNSLWYZ5IdU2/rEHVY/G4PXFFtjDJSe7WTFQYFlY2mKI+XzWBZ4Y
         Cgf8fs7DXCwJUxgGZyFMHbB5vhX6C+0CqN/m/y+viNlqFBw4XlxGe9ulR70t9fwrtPq4
         4DarWDzNtKdqJi9bPbDbbDs0TJX8T7+eYF+sb6ZuNEs59TBdflsbCGJ/HwGu4GjO3bmQ
         QKKK0pan3+nliMivY/JLXslP2Nhg21X8Dp3GmepdlUX6FbnMASJ0JyZcHkJo56J12mns
         ogDA==
X-Gm-Message-State: ACrzQf2nAXnj02wBLbRW3mQb3/JjeGdxUypGGasfzRe+kpySl26lPZR4
        ISmf7wAn/uzy6JK1oyZJ7kw=
X-Google-Smtp-Source: AMsMyM4K1q2fbk2/EjEtHDfPjSOFpoqqw6n56Jdtjj9jZ/8feXn32GxKS5/Hd6sfzxQsPsk5LAo3WA==
X-Received: by 2002:a2e:9ece:0:b0:26d:ce1c:624 with SMTP id h14-20020a2e9ece000000b0026dce1c0624mr4876090ljk.119.1666270507239;
        Thu, 20 Oct 2022 05:55:07 -0700 (PDT)
Received: from pc636 (host-90-235-12-162.mobileonline.telia.com. [90.235.12.162])
        by smtp.gmail.com with ESMTPSA id d21-20020a05651233d500b004a2588520f5sm2708899lfg.166.2022.10.20.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:55:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 20 Oct 2022 14:55:03 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 5/7] mm: vmalloc: Use trace_purge_vmap_area_lazy event
Message-ID: <Y1FFJ9svEOMNHNRH@pc636>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-6-urezki@gmail.com>
 <Y1EwEg7E4OodgecC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1EwEg7E4OodgecC@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	return num_purged_areas > 0 ? true:false;
> 
> The formatting here is a bit off due to the lack of whitespaces around
> the :.  But as boolean expression propagate to boolean values this
> can be simplified to:
> 
> 	return num_purged_areas > 0;
> 
Good point! Indeed it is odd.

--
Uladzislau Rezki
