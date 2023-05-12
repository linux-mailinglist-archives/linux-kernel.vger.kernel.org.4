Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F4700FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjELUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbjELUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:30:00 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DDDD8C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:29:27 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4501ca552a3so5207882e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923303; x=1686515303;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SezH11RjgiZiPc8xElE34MQQ1YO5W8+swLZLuUSSwng=;
        b=ZiSexfmR1xEZUTcgb+u3BBVv17b5XY+LMcMx1jOr4kx0rrG8ouHYgOimEv1agAvnWK
         8Ixb4aFOSBcG8cgAM4Y0YrAOh1wpYU6UW9RDmInTSUED3YBouxbgmwcYWsixxrdmMSY2
         LEMhvBbD63CO6aRTtiH2mjPFIuKQ/I4U4LpMt/++W3joQU+6IMfMrTOXZNdgtpLdM1ST
         FMZ4OPxw57oIBk9tkW+PYnH9G+wjmIf50urocRM2rYb20gdeKbYT9E0XMAHVu55Y2DX5
         jo6i3YHRqVFoRjvlS0Yf2IaYGBxQQ85yjYgnx/3FDDUiH7up1NYEom7O8mr3jSrL7t++
         pJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923303; x=1686515303;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SezH11RjgiZiPc8xElE34MQQ1YO5W8+swLZLuUSSwng=;
        b=PZnx/DSQvFqcR8dkt2o5ORTyOUJbDEvEYGiNkmwSL7iBQlqUzzZyR9OmhiLYo+khho
         Jj0tUuvw/aDM0/sN5xxJnQyfRivWV/nGj30Ic7gBDeeCTyZyXTE7hPhFORZKQlILs7Dn
         QjNumuqHf9UdU/xWW76QvqRalyOKZC+3sXP9gXWbcPkSQkgm/KltA2G0mW6TaSZqvARz
         4GjDKRg3NdpTO2Nku0TN1+nDiqDN4w6062xu0JqOZXUlcwCA65lVApA69iLEOLSPjPwe
         RXvRN6qEou4qbzs1SacCzrgOvKSi9mOpRCSRjmTCqqCejhpjYTypvZdvF9Xu4u0EZLgq
         M67g==
X-Gm-Message-State: AC+VfDyh2L6KJDxd5drjHbEJnIX7vFqv9/enjRjXBlyOsMCGHJfevrvD
        gpA9GqqhE9AuOS9/IQsdksR/MJ5c6RvP1nfQRHtoNbfp
X-Google-Smtp-Source: ACHHUZ7vQl35taEAWF0ae5jqnanrsK2ZJicWi6Ki1V4BtHH1w3unf7dAPV0qhN1vTrpZ3rnQs+t832z+uFd752vJEJY=
X-Received: by 2002:a1f:e601:0:b0:44f:be41:267a with SMTP id
 d1-20020a1fe601000000b0044fbe41267amr10125489vkh.13.1683923303179; Fri, 12
 May 2023 13:28:23 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 12 May 2023 22:28:11 +0200
Message-ID: <CAA85sZvJBTR8GdAUJwB9KqHxgw3RtL7vnz6JWrvgPBe648KLYA@mail.gmail.com>
Subject: HP iLO (intel gen8, gen9) and intremap=off
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On older intel HP servers, as in Gen8 and 9, there is a issue with
interrupt remapping and iLO.

I have been thinking of patching this, but haven't read up on the
quirks system enough... And it keeps hitting me in different ways.

So, if you boot with a ilo console (web) on a gen8 it will work, but
it will be REALLY slow. If you disconnect it and reconnect, iLO will
break (dmar errors).

While not good, itt's mainly just annoying...

However, on gen9, it can apparently cause memory thrashing for virtual
cds (as in attach storage via ilo).

I wasn't expecting it but I've been wondering why a gen9 machine
couldn't be installed all day - with issues like packages failing
signature checks when they are on the "local installation media"...

What kind of information would you need from me to workaround this?
PCI ids of iLOs?
