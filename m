Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1C74FBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGKXzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:55:22 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35DE170F;
        Tue, 11 Jul 2023 16:55:20 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5700b15c12fso72300627b3.1;
        Tue, 11 Jul 2023 16:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689119719; x=1691711719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l0eHGvYiAjOvtyvlgCffZ7LMt7sWot3qzaN4MmhWSwE=;
        b=MSfjWEV84b6m+wWASrmm8K6FRsBtMeZS3FlTe9y4uvc1YIBJjTuCZP3KFHss/DtA5c
         LvcUBDcq/TBFSzX8SXKmDnKdOA0r0iq17ka12owKtEE2Je3WwoUvP0GJqqB5KKFge0Zq
         ucmcyjo/BjsGAzLRCkbw4sZksSw8IDXbSI/sEIqzKXOqgqLfHpgdEx47ytYuTJIQXerO
         dffN1kB3r4kLLai3L2D8IFO3RDR2j8os0AqoEKX4TUO2sVAoEJvD3JGzBm5rQdnw7R83
         FmiWA/NzH6BntazM+8i+lFYtbIEsmt0DBlWs6dO/dZ3o7RKinmYo6qCh5AQgFf5Dbh3D
         IjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689119719; x=1691711719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0eHGvYiAjOvtyvlgCffZ7LMt7sWot3qzaN4MmhWSwE=;
        b=ekt+dF9JXC428ZO8HKqLPsHSkwS9nguu+FirvmoHFIQPBRKvq20FgvsEcmdDzdUUcg
         /LK6+rhI8tSpgCyfBqQXOhCzap9OjoXqhTx+BkErv4kDl6/uABLiefpBHQvATU4EHVUW
         i/osEiYmUs18pQ/NF20iT8Nepef4CmX9CgsOkjE8KHNJP5dDtun1pxpXyLXbl5mRi3Ad
         grfiyrKj5tUS8SPXD26/YpcU55lRtvL4UX8v/8QfzhUnHNqgnU3A88bI2lvHnG/sOen9
         sdNLOyiFTK4kGaiDOGC5l5Q58jyQj4K7A6CIHkoe1kYxxY1yS9ZGF5DBb2fl2IPrGVSG
         fD1w==
X-Gm-Message-State: ABy/qLbnNiw6OgbkM5DnoE7vk6FrUxdPmJ4Be8989VY7RtcsJB0b8EM9
        XnsAvx9PRdWTCMeY7zARX5ENr1eBH+xrANHnLD0FICapKNY=
X-Google-Smtp-Source: APBJJlHO7JQH+4wLoUl6AYA0Mh0njxShJB6/nHwg1DNX32M6H9lyeiBsJcVDVsV5Gf28FRFr1PQL1GcRjUrWma+QFkc=
X-Received: by 2002:a0d:cec3:0:b0:57a:4719:859e with SMTP id
 q186-20020a0dcec3000000b0057a4719859emr14085154ywd.50.1689119719362; Tue, 11
 Jul 2023 16:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
 <202305231020.37C95FD@keescook> <CADmuW3UAHODqC5YAmjK1sOuo3C56noOa6hsHA+2Es2R9MT36_g@mail.gmail.com>
 <AM0PR04MB62891F29BB182FA2B24A37098F30A@AM0PR04MB6289.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB62891F29BB182FA2B24A37098F30A@AM0PR04MB6289.eurprd04.prod.outlook.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 11 Jul 2023 19:55:08 -0400
Message-ID: <CADmuW3VO5nrpkYuRDur74w0DZFPWJP1ErXzCgxOCS+Z0DjFbzA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
To:     Leo Li <leoyang.li@nxp.com>, Kees Cook <keescook@chromium.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for the late response.  But I found some old discussions with the conclusion to be not converting old users.  Has this been changed later on?
> https://lwn.net/Articles/659214/
>

@Kees Cook what's your advice here?
