Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02B6680536
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjA3Es5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjA3Es0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:48:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D01040C;
        Sun, 29 Jan 2023 20:48:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k13so10418006plg.0;
        Sun, 29 Jan 2023 20:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTLyRNwRFrx2Q5AN4Pjbxlov1ziCaPESqhin2NfMj78=;
        b=YHDnknCYusTNNghO0MKUybz4fnBRSOcvyT/u8hgZ0aRYOtaax43zT93OuM7AJRpshD
         GmvVUw9E1iZdH6F5TrTIJ4nsJi6En2ODZWjaJXpfw6zcYyNX/Bm54X42gLqrvBqBsQus
         HUZ3OcdAXLeA/z2ngXpa9uMgpR7lca8Jg+yTn8WoO+o7lBwmHNUHdPR8Ql9l4/cJ2854
         Y7tIQ1hOmuHQ2qM+YbOGXO7EQAt/riU0ebHFZb2kOJYTcGEdCOwuxwCucdOVSb7gsB7J
         gc2rtFnWxrkUtJTQOy3dZQyR9o8tfEqmOTpY5r6Bpq66bjayDtNcJAqg0J0YWFKbOrIV
         Be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTLyRNwRFrx2Q5AN4Pjbxlov1ziCaPESqhin2NfMj78=;
        b=THxqLWHHkIb1wQ/2dveP3HqwMXH3d53A+1TdS7Jx9Kvjad5gbEWchbRs1wkS/kRl/6
         taiBbgcgxdtjJayJ1xIfGgffOCueZ9V/pSY8WvrDewCOwidP62FW5SZ4DgmTK+NWBboz
         Rh206LItYKOtXgYcDASkhlJvxVGGeJ0BGEgqU3EfGkwLWZT6+g2Kq1fVoZzA8s8dnwEz
         sNr+0rMKamgaHr/tLyT+uVhRGQ/9hcbn6hJh3Hcv/HGAXRLkAmkNOfdJulnQ6XPLYFV1
         4tKL6lVQB8aunW+fOGYh/vaftpQNa6yjmIqpm8XO5A0cgd7qY1I5tUGTdYf5Qeu1UNgA
         dlFw==
X-Gm-Message-State: AO0yUKUEw70H5d3d3Tj2vOhj9FMG4nia+4VAov2EooLEAA1IvXCwPRss
        jM669PFMR+YpZ87HURl0JZMs+ajamGQ=
X-Google-Smtp-Source: AK7set9Tuuzi1gArb63EEJ5mkqFEpZliIxJuFnGOJHc/jQRL7Je0kxCK1X4HApuMStEQJ+y2GgGb0A==
X-Received: by 2002:a17:90a:1909:b0:22c:4b18:4ebb with SMTP id 9-20020a17090a190900b0022c4b184ebbmr7629416pjg.29.1675054098295;
        Sun, 29 Jan 2023 20:48:18 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a728b00b00229094aabd0sm8391179pjg.35.2023.01.29.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:48:17 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:48:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     jonathan.cameron@huawei.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?spear-ke?=
 =?iso-8859-1?Q?yboard_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fres?=
 =?iso-8859-1?Q?ource=28=29?=
Message-ID: <Y9dMD/SrDbmLKY8Q@google.com>
References: <202301281609576851394@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281609576851394@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:09:57PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
