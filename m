Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E080D6C7354
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCWWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCWWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0E2CC59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso3446465pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679611880; x=1682203880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0OX40ehjV5gIkQr/Q9nraxMiJdzGjqFLifP7n6ggXk=;
        b=TTqPzThDGMupB/gagrp+rTbV3eHSKSSrLjeATpLujyP3BjQhyLVdJPW0nFqfh7lx4X
         /tL5/prrRpFJnHz7NO9yWbSZYuEIbhgoUu+hIfGI0YCk0HO1n6FyPw4xLxD9b87pvVSL
         CK4W5AVwxkz0p8kq6QRhUEa31VKANW6YLLR5YwZwnuwvYDUbDeFzkaD1tIbclly1k12L
         ahS0F94a0rnpiFBIxQyHIiS7ylZ5k+o/htcVsn/9Ucp/a9U4M5NJTvX5L1BCfVR3S3RX
         8wl5iIN2tmHyYrx+Vw8BnXwd2RfKOSW3OFEYaEwQz3LNenf0o4ch+tpXJBuJgtXi4Taf
         1V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611880; x=1682203880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0OX40ehjV5gIkQr/Q9nraxMiJdzGjqFLifP7n6ggXk=;
        b=m4DtUebK2PYC9CiybMTlehVje6Sma+BfBW2DNqGIS1xiCDxh1dzQFOaEU5zH/hI5uK
         +VqSYDGXv1V/MphpRjeQpZflIgsJ5uHTpO5LmTyeqIKrEHgLeUgcdgVHNEP9DDH/1cFX
         eN3yZpbMg3UH+nwYC2WdZWmuPQww1LvVRQ8Hog/vLujpD57tvBECu943cv605pDqih1Q
         PTymZFgcj1THESQ7+5LThgV77xYQDmw18RYXVzuxbqWQqGe0cl1eFnxjimlAxc7chb/6
         t0Xwfo8pKjCwqafJZwLNHz0VxqmrBkxn3i/ojF2SwK7r0kBYNjZIC8NacwjVGc+ExpPn
         hAHw==
X-Gm-Message-State: AAQBX9c8fH2pWeWTwTffJpjUNVl9KG2iQzk8VjVnDebDHRtJ7SbUAc8f
        wFWB0gmqprx4jUhosxiYF270Wg==
X-Google-Smtp-Source: AKy350YwB4kYOrekaxdEpI+hPuVho+rJnXECPnSPxRKXmlcV0fNHAsS4nvedwv84jZJ4QD01oSfi+Q==
X-Received: by 2002:a17:903:788:b0:1a1:bf37:7c2e with SMTP id kn8-20020a170903078800b001a1bf377c2emr225398plb.4.1679611879706;
        Thu, 23 Mar 2023 15:51:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019b9a075f1fsm12871828plb.80.2023.03.23.15.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 15:51:19 -0700 (PDT)
Message-ID: <6c507b78-35fb-fe23-51f0-e5bb754679d0@kernel.dk>
Date:   Thu, 23 Mar 2023 16:51:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND v3] nbd_genl_status: null check for nla_nest_start
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>
References: <20230323193032.28483-1-mkoutny@suse.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230323193032.28483-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 1:30 PM, Michal Koutný wrote:
> From: Navid Emamdoost <navid.emamdoost@gmail.com>
> 
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source code.
> Update: removed extra new line.
> v3 Update: added release reply, thanks to Michal Kubecek for pointing
> out.

Josef? Looks straight forward to me, though it's not clear (to me) how
this can be triggered and hence how important it is.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
> Link: https://lore.kernel.org/r/20190911164013.27364-1-navid.emamdoost@gmail.com/
> ---
> 
> I'm resending the patch because there was apparent consensus of its
> inclusion and it seems it was only overlooked. Some people may care
> about this because of CVE-2019-16089.

Anyone can file a CVE, and in fact they are often filed as some kind
of silly trophy. Whether a CVE exists or not has ZERO bearing on
whether a bug is worth fixing.

So please don't mix CVEs into any of this, they don't matter one bit.
Never have, and never will. What's important is how the bug can be
triggered.

-- 
Jens Axboe


