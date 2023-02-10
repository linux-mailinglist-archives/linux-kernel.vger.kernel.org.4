Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F92691F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBJMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBJMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:54:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBC6BD17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:54:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso245021pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=jK+1yZ1ceJ7MA7R96Vv2sbNU6Z7Jcje1AnWDbCXC/KTBOf6vzobvz1pU20Vg4RlHRj
         wYCBgw5Cc06nysymE0D7Tf6Zv+pzxjXeiL+t5rdkJsprN1cXAVOjHdgkCtR7rMJkFYU/
         FnvWxbEPIaVSlMTE82Zhb0i4dbBmn9XyeVZD3zE2l6FD+zdmDN322PwGsnpLYY12N9wk
         Y+YAmxhfzIzFPGftklhYpqAEvWmKV7gG4wYHfIS0OvblZ1na4ZcVIBmS239dvpTKipYQ
         RtS2w0kS2WBOeVX0tk3esxnn+SbvtDSoi4NxFfdzJDR3G/iiQALPmh6DbxG2VqdpnwnC
         vcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=aYyIB6JtzeqNWIDhug47oiVDvbN35slXxz0sjrm9tsEUrHd6TTgESNipt8/Ynxp3/w
         BsrlVpwe0z+6jy8JVQILUJQamQV+DN7mqOAhCoChILxUFupmnRPaKCjbsXI+L5e6GK//
         KVLC44AMpmVn5wAzQKJpAXF34JooIe1JM2/fZTYBFGjvVRgUkTBmMcGCiBrJ4ZshAyaA
         3FVNfU/s2xuiQVvkyhr6x6e2rVNMNW8cWXsU/pabXk+efq/bA6V/7cooc0x9YapmD6BF
         fzUnsBeAVnN6vziM0Ubagl6pA2gxbqPnonN/jJQYmUddH+L21geoPXPEImoaGOOELJ5a
         4R5g==
X-Gm-Message-State: AO0yUKWS1MptAlYCwcOLhE5X7arKjNh9QNZ4Jv5CP1iv3Ar2Ed6Jm+0P
        ZPZ5PTNxsDhZz75nqVdgSKJnlAM7MslmvixuCPg=
X-Google-Smtp-Source: AK7set8egNfccSYTnCF4LaILqJQ/DtfmALlLYTEGxY+TEygfbhBc2dGhdEtWLmkkxfW7UyZG7Or0kYlR5gLU7lM8zn0=
X-Received: by 2002:a17:903:32ce:b0:198:b624:f4c2 with SMTP id
 i14-20020a17090332ce00b00198b624f4c2mr3767712plr.6.1676033684648; Fri, 10 Feb
 2023 04:54:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ea16:b0:40a:a618:d387 with HTTP; Fri, 10 Feb 2023
 04:54:44 -0800 (PST)
Reply-To: peterwhite202101@gmail.com
From:   Peter White <richardwilson19867@gmail.com>
Date:   Fri, 10 Feb 2023 12:54:44 +0000
Message-ID: <CAJdDmFVsAAByjC1UrW8oy4uw+=BuehFgrpxAW9e2FQEKu27g4Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from here.

I want to know if this email address is still valid to write to you.
There is something important I would like to discuss with you.

Thank you

Mr. Peter White
