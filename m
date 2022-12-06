Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA3643CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLFGB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLFGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:01:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442372657E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:01:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c17so10288868edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDMHuKzYemXlSB6fQWpbDf55Rj0jk90RmhjuZJ7HYkE=;
        b=pYy/zcbtTkQ9+dHmoXIWktL0pcsTtdoeCmZhyLFed13KFWf7iPTR8sG9PIMQY0+nVA
         +IBTpdgr6g5I+SQPKGV+uFOhMcbTcW6eaP0KkXK4I71CYYeaPo40IkCw3cDuOlDur0pd
         BhHCHWgTcQ4HpkJo6cqbpoWraZZuPcKJRY2Tj/0H811ozME9fGo2K5QNfwpYwkMdBVE6
         v3kW6+gKpA1DTrLP8qM3vLDlADhsBilH/whsXES3nYhrMDJAuICUrQbUENePH8iQUBfx
         5cAWewb76r6eNMz4h7CKr0JooDc0zZvvHL5DeVN68Fv1KYKWZhLB5CrjAG9d+O0EDm2M
         Rztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDMHuKzYemXlSB6fQWpbDf55Rj0jk90RmhjuZJ7HYkE=;
        b=yBWUUCxc5kUySo1ECwlZtvMl+mQ9aoo6/F8VaaY9OP/T+9vXcFUYedLxbcNc2mo5Up
         /iF5mWlGCVMtPN362aHTZzgFCojRZsL16oyX/gGQ9q8hEdTmmsbzj6lwqO3YKcMgRefC
         eX0TzO4fxGMSF9JvdRcd5uQ/k+y08lEvz2QxU9Rmi10m2v2AhERZauHV1v2dio7SkWBp
         cgfP8usHVYDnnCQsVrOe7hdATTMSayCttxuP8HZlHpQ5OGLgTv8dsR6YYNoHlkKkr5lR
         DuJKF0UBCfHL0dZGdM3V4wL7rVeDiVKsJCQFPyM1yHPxGcp14iKxqsJVRpDlgbsyb//x
         b0IA==
X-Gm-Message-State: ANoB5pnIuzghPqOHT4Ibyk/aHPp/KGwSYgSb9RCIVdibcMRiWR4+9seu
        RsqnNBBbuaU4xM9lkLtkSVlB7lrV2MNkDR8zTJJNeQMbr+k=
X-Google-Smtp-Source: AA0mqf7D1V5oCKRRSedi/O0wOC++Vx+LGDgA0Cx5EJaG33zkV2pvWEnrhTqgd8Y5O65a14qZtFnux73wp+40tRTkUcA=
X-Received: by 2002:a05:6402:360b:b0:468:f365:dca with SMTP id
 el11-20020a056402360b00b00468f3650dcamr9926151edb.41.1670306475781; Mon, 05
 Dec 2022 22:01:15 -0800 (PST)
MIME-Version: 1.0
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org> <CAEYL+X8KAg58c32LXL8ksfxnDvPPLwJwBRxMFdu6wB7HU+kXBQ@mail.gmail.com>
 <5c01fe50-a975-f866-87d1-0343ad2ae520@infradead.org> <CAEYL+X8SuUvaEG-ouGdCUBpe5DS0j0rPw7XedtcCocn1ZJFX2A@mail.gmail.com>
 <ec629996-fcf5-a0da-4c90-ed374f63d012@infradead.org>
In-Reply-To: <ec629996-fcf5-a0da-4c90-ed374f63d012@infradead.org>
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Tue, 6 Dec 2022 17:01:06 +1100
Message-ID: <CAEYL+X8rrrAgi7JO=38-=3GbrRfUokHSJ4qA2NzxNLRwNX=Hcg@mail.gmail.com>
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver (GQR)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (for the latter part:) Do you mean when using the gmail web UI?
> I've never seen that protect whitespace correctly.

Web, yeah, using plain text mode. It doesn't work on mobile though.
