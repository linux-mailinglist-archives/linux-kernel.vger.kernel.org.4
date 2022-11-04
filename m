Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE5619F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKDRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKDRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:47:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E914B98C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:47:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j12so5556867plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrYnS8JhNYA90twtP47L3ZwTLaMR8mnWvEeKOdrs1f8=;
        b=qaYgQ7+1jZ1Kv2W+aHiz6Kyz3YuGKVJM0RtjnDFo2QSZasn3G8TGm+oQ58wjjeJVai
         7Jft6TyegA/Rd5fZCMwfqe8/SNQU1uZN/FBEoB68vmgJZZ/wUP5FvHCSUZCgmOx6YE2q
         M42JzyglrT4gTBDnizSB/SRKAY27UUpzUoZGeq3yMU4FDp2EFspffIA3Uw93bdCLzlOr
         EsxBtdarf34/G2fFIdsyhZK/Vg8SLubX9iHokolm83NlNa3sQCBm9gS59W15zlAmWas9
         71ynldxLFiFB9HNPfRV6qoLeP6dengYdmcvBYEfiBOLgNDzM4lPp/PEnp23u3DBzZW93
         czSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrYnS8JhNYA90twtP47L3ZwTLaMR8mnWvEeKOdrs1f8=;
        b=xxAqF1BTU/z+Bq2V7dOTGbZGs5//a/df9TW5BSleul5tS2ayA6hIHFpWRX8nJn3pSp
         rCW0paa+uoRwL5F09B4sMK6YVmziFumtcf7cv2okrG1pzUK7kG2tD46Q1NnwSQatu/s3
         HjDfRIo9nGiZabVWFokq+gA+ktgqdFCCafpbubgPft8XALmaf57z/dKYiLvcf9sp1fH+
         IwYVKhFfvSVWzVcy95K/igaZ4wEFtIKXxIPRbAZ3TBDuHy6HrootjBLQB8lbBTsTnjPF
         kG2gfDwIegvqZvAeCM9MBHNlsHUclW6W/OgGWI9mGeS9MjD39ofMY6L+zvBkALdr6o/+
         SSmQ==
X-Gm-Message-State: ACrzQf2sYaewP+pKEEYiPFbaL+LHxMt2gSfwabRtRFHYD4jORXlXRLZ4
        SvF3Wzgj7+DPPF5iUY6fbBc=
X-Google-Smtp-Source: AMsMyM7e+teCQsHQh4ualKatwWqt+w0DB4v/hwUDBsU/YZpqILIOVcY1yYQ3Jj5CkN+sFYoBPbeacw==
X-Received: by 2002:a17:90b:2393:b0:213:ecb2:2e04 with SMTP id mr19-20020a17090b239300b00213ecb22e04mr26271755pjb.100.1667584045165;
        Fri, 04 Nov 2022 10:47:25 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001785fa792f4sm24852plg.243.2022.11.04.10.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:47:24 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 10:47:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2VQKwizB5MY0tKg@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2TE6XSTkyXVF+kB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2TE6XSTkyXVF+kB@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:53:13PM +0900, Sergey Senozhatsky wrote:
> On (22/11/03 10:00), Minchan Kim wrote:
> > zram->table[index].flags
> > 
> > If we squeeze the algorithm index, we could work like this
> > without ZRAM_RECOMP_SKIP.
> 
> Something like this?
> 
> Allocate two ->flags bits for priority and one bit for RECOMP_SKIP.
> Two priority bits let us to have 3 alternative algorithms (01 10 11)
> plus one default (00). So 4 in total.

Looks good!
