Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9660C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJYDmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYDml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:42:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BC510C4E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:42:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h185so10383011pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WbmuswAoHQuCNp2CesRwt42cGiiOTRlBOynr3E+R9w=;
        b=PT4udrigcGeJ3X2AHStIO+52/FsHb7hFXojaot8KJI4Ct70t+/4k8mfmzZsIWhf4FS
         ZVf1YX8mKqu0QiwRnyvVgkKoeGc3biudRC45wYitSVsL9fRxT9GJGicMSpvTQO7uXI7n
         oJong7uUFZ1iO8ZqMydeXzcjNHX2Bvox+nupA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WbmuswAoHQuCNp2CesRwt42cGiiOTRlBOynr3E+R9w=;
        b=RIWxK1uwoSY5+Vm9qxqykmVnB4pP/dzrQ7s4AH0C4oRx39gRLsCBOZnjQaHj5qmA1B
         CCUP1cqbto45fdqsVVj2oDjX+y5yX3iCRF6sXbsp4zH8ifvYeX1PE2les5blI06BzjJx
         E1uPl4iSXqu/1a/umdB7M3zRZ0x5rKZl1OUA18qVI/h1XykZJsJujgfQjQjxE+P6K1gE
         8iTh7v8au8LlcCm6L+ajk5PFOm/VlWp4mW7NZWRt7DyqihqRWZK9LaylZS0T6t/VY5G1
         1rF8HQBaHhqtWeJ1e7my6yIKMYXgPsSt10nDVp91tlHjuYJS5GG8GVUiYQx+i+dpj8Ik
         76uw==
X-Gm-Message-State: ACrzQf2k5RuHcJd3abPnZxU3UfkW7J9YDXa3xNUQYfh4TCoCF4rkb5Q0
        b4Zn79U1XWAP2fx4tNsXcF8jSgHlllHjew==
X-Google-Smtp-Source: AMsMyM4hcO1yvcRRH6mQn/jWGz8OLrQuRx46VDXJDpLLkAVPEyV2zPQkFn0uvekPoS9o695B5zsfyg==
X-Received: by 2002:a63:c145:0:b0:44e:9366:f982 with SMTP id p5-20020a63c145000000b0044e9366f982mr30486345pgi.584.1666669360676;
        Mon, 24 Oct 2022 20:42:40 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b0056bc023d608sm526171pfh.140.2022.10.24.20.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:42:40 -0700 (PDT)
Date:   Tue, 25 Oct 2022 12:42:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/6] zsmalloc/zram: configurable zspage size
Message-ID: <Y1dbKxlwiaMx9E4u@google.com>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
 <Y1dXSeqwX/WfUcjt@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1dXSeqwX/WfUcjt@debian.me>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 10:26), Bagas Sanjaya wrote:
> 
> Sorry, I can't cleanly apply this patch series due to conflicts in
> patch [1/6]. On what tree and commit the series is based?

next-20221024
