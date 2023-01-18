Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14B67156D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjARHud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjARHsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:48:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D847095
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:17:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so1315354pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlGLOX3kvbi0nv44LsUa95VHx4097O3WTrtdzV1AG3s=;
        b=JQCxHE4KfFHbikWJo/Oni+upZgpSWezCK0E/6I3LxP/vmkbtuUQxBvaT9Hisrp71LO
         cmA2rTWhznuUvIwoe/6EBVh05f3RyPQHhXEGxjSLVhx6/sVoNPwI0TS/N8ZaO8uYVxx9
         2AIsN/U8y3HvMh8e+ehbceSZglVNf6CG+LuIdAVUxUiltZtrebEaPuA6RD57yu+M5CZa
         liTKUztWBmXdQR+0FR4jKTJAu/H7BlIRxWJZL2IBqsW/YI0Ru7L8HVgO36MOKY7zD+Nu
         Ve/6lD2P4DgiMWQYGDHGJsyloL2w3byXeMty1H3WqbkHohPsCbPZvVU5AWyjEQAVvLo/
         9b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlGLOX3kvbi0nv44LsUa95VHx4097O3WTrtdzV1AG3s=;
        b=KcW9yWHmUJleOqFxlAbGRFBtQhPJwyOm6HP+Sdnei8T+X19vhOVaUs78PeUyMWLv7o
         yCl9/AGGX37tN80mn3CoyPIYOsKAiUGpQG2mamyuMIpQz3tGi2IGU7VNRsFW4afDtP+V
         omJ7eFZovutuqoXOH61SBCCLujGS8xrhyMBWPXUJK0X/E1mUrdavmn0qfrizk59FKp6N
         +Hh9tAX+XW3XrQTUILh5VJxQjhzW8GyouxIulkYs8AQKcpT1EJWdWGvjtmrqfniI6rbh
         yHk+pdy5kAnVMT4Ibc+jIKdi71d4yGRM9+xeDjmZTiuB/rDwR5cekHkygS857ukRyRop
         x86A==
X-Gm-Message-State: AFqh2koynJ+tFD8owvBwFxIb9Lo5pefm4iPyLnh2tRhUbNHkhnp66ntK
        0X20BpBMUWqfAQVXhDcgf6zSrhn20vFmLDfqv5FGXA==
X-Google-Smtp-Source: AMrXdXsSf635kWaEdT87NA+Fag35LYvXH7hAEMvH8lwHWmn7V/p4Chr+K2kQgI921+06RfAdmgYZGsHd10jKu7NVmXY=
X-Received: by 2002:a17:90a:17e2:b0:229:6a83:f3f0 with SMTP id
 q89-20020a17090a17e200b002296a83f3f0mr614370pja.79.1674026257128; Tue, 17 Jan
 2023 23:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20230115210535.4085-1-apantykhin@gmail.com> <CAGS_qxpoGCXAK=q+unFoYKN0GtH8V9Ojmntz0YZrae8zBeX-qw@mail.gmail.com>
 <CAPi66w-D-x_rhv+eQBSPqmqpK3nF2_VuizZPA9dZ0kL1=XAf-w@mail.gmail.com>
In-Reply-To: <CAPi66w-D-x_rhv+eQBSPqmqpK3nF2_VuizZPA9dZ0kL1=XAf-w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 17 Jan 2023 23:17:25 -0800
Message-ID: <CAGS_qxq_ab-O_K=MOMS12PVL-vR-RZJtULicm9KJhDj3ye-dAA@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 9:33 PM Alexander Pantyukhin
<apantykhin@gmail.com> wrote:
>
> Hello Daniel.
> Thank you very much for your review!
> Could you advise me whom I can address the V2 patch "to"?

davidgow@google.com is the more active maintainer right now.

But since you've got his Reviewed-by already, as long as you CC
kunit-dev@ and linux-kselftest@, whatever you want to put is fine. We
can make sure v2 gets picked up.

You'll ultimately see the patch go in through
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
and hopefully merged into 6.3.

Daniel
