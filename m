Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316462EABA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiKRBIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiKRBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:08:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BBF1A21D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:08:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 130so3675570pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7wOWdHI31hy7EBMQrrsB5hR61tKYMye+C/35wMG3ps=;
        b=ABt6RibAoZrmDLxUcH2jEaHrPuXM9rvuaG8PCEoAkId1r7upys1gd1AHaeRM9+UffU
         7ohQ94wmUWuo1Fkw/DHNPLvYuLpNVFQ4EF3QvyXCz8AmzKcZq/6hmaqqQLq5i8uUJQwL
         69XQ3jCZ9gzbKOSw1cpKV0sGzktqP/qX5u6UQHz5b4ccOJjZrM1nwfF9/f0OpINI4KSP
         Tsb9NmCxobmZ0wC6SK8Rt5bpLzZ2kcc6BVBNEyzQ2Vcng/vwLx/GCGDugzG81qinVCDF
         Z40LhHKiUJm9ktmPS4EZpmc2SiC/S93hy7D1/XtQtM/dIJj/u62j2qi91b4Nfwm9RPcI
         Knag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7wOWdHI31hy7EBMQrrsB5hR61tKYMye+C/35wMG3ps=;
        b=xdX8qdX8lhMkPOQLNBiAR3gM6b706rd7BpoA7OM+y60/JrK/TtNfQUN43Uy38jfkcy
         isxyyUTCWd8UtJiVLuLCZccoKCXedAWH1mQz3SNgCyTGq/qzdStWdlGJrPgct4JidPcE
         un8mIlA1yGBHsgvR7z92UZUBV0gGVJTnimoWUpUqTABJpznELavH608PYdRki6vTo/kY
         +Xui4d/wfztzNsYh4wOaSIiHGgs+3Nbfaew38KFDLazrPxHn7PgQOcBl7Lxhykj8SRch
         nYl6lKurow8mar81X8q1ipZH94e1xW2HlWMN05MT3r0VPU4/c3mJYocp1mWOYFJCgz7P
         NF0A==
X-Gm-Message-State: ANoB5pnMkQKrtcH7bb5KwBFcyscTTGJ4y0pQBu5WQ2imJWDnQGiakBel
        hN02rIJXZFUYARv9gs5VrP8=
X-Google-Smtp-Source: AA0mqf6Ozsgro5E/eK5IOwcXMtVtPC9Jce0ZKfPnEdDcS6s262BF6zE8rHstUfvV6kVC4V3QTreNfQ==
X-Received: by 2002:a63:4b16:0:b0:476:d0b8:1117 with SMTP id y22-20020a634b16000000b00476d0b81117mr4409332pga.104.1668733717115;
        Thu, 17 Nov 2022 17:08:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6bbc:b70a:8f80:710d])
        by smtp.gmail.com with ESMTPSA id t6-20020a656086000000b0047722bc3016sm515281pgu.80.2022.11.17.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:08:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 17 Nov 2022 17:08:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/ABI/zram: document zram recompress sysfs knobs
Message-ID: <Y3bbEtzUV7rBzra6@google.com>
References: <20221115020314.386235-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115020314.386235-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:03:14AM +0900, Sergey Senozhatsky wrote:
> Document zram re-compression sysfs knobs.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
