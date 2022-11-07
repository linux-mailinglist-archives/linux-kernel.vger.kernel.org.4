Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3661E825
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKGBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGBLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:11:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF67D79;
        Sun,  6 Nov 2022 17:11:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v17so15272446edc.8;
        Sun, 06 Nov 2022 17:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YtejbzhU7+rB8ATLX2lQOLzKCtVFeldHSGlD4jNTHnI=;
        b=L6mid4IzF/yHvgPxjRljnRYSaLOekU7gWBUB50OQGLptTXXCT+JuyzLu1DNCBqac5/
         JfibO9kne21ENthMVG4mMuvDCIlqf0DmEPhmEfh+oVijBesd0VOoUz14RWx15Fe1yYdB
         1sRA08d6beXmuqrxeggHf82G2AsCopEP6Z1t10zYK9+H06zLCiUfJJox0ceS1Y1wpmQJ
         f8l9xQH85s7niqGaGxxRelQsZtyxC0iVD/KKs/7eDjgU+LMHCrZk7MVGdCPTYfO+lVQC
         OuE+B2eEJmVqy/AvvS5zvr5A62uDY4azw3catWvhmZxGco9RnFmQe+LAocJ3zMn1RL9/
         yQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtejbzhU7+rB8ATLX2lQOLzKCtVFeldHSGlD4jNTHnI=;
        b=rYkL9HxazKOUGNP4+QJkS6KVbOLdWimqZoCka6pl094gSMnVbpDJgHF78Qz2ILQwJO
         ygk4r34KFib2K7wviFK4R3Qf0x0/aSyBvV3vD7MCCq1ncRvpfddj/LU02nkySaZdi1Q7
         Bez4PjkgcmvA12+E2WzsQBcx+8gmw6D6UxufdfSMXvnfAEDOzrfGgcdtk2bqu1wHxJfj
         scmZPbsJq3BVvFvc6IfQegCFLVJrPWthmx3/08JaYKkp9PmxV3JfvTM4QPqxqrKBOWG3
         l2TtbcUP9XH/8I6XuYwCTaXvkRdlAif47ifgUpY6sgGUfDDUW8/0xrS/45Eky4cKnEWB
         XV1A==
X-Gm-Message-State: ACrzQf2Dd25nHyxhcXdyY8mjZFHyiA3eU6HiKbuD5i7dDeL+DEnfk4DT
        5pAZT0FUG09Zl+VtDuisnTMI5yMHUCSEe2WKJrY=
X-Google-Smtp-Source: AMsMyM5bV+j1C3yG+4u5/WgV15jap7UklbYjGIS9czpcjDt5jUSpvMQC64rj72PXoBACxerF2CC267QVqcpPl0P6Ygo=
X-Received: by 2002:a05:6402:5296:b0:461:b6e5:ea63 with SMTP id
 en22-20020a056402529600b00461b6e5ea63mr47300945edb.248.1667783460888; Sun, 06
 Nov 2022 17:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20221107081159.7ba208fd@canb.auug.org.au>
In-Reply-To: <20221107081159.7ba208fd@canb.auug.org.au>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Sun, 6 Nov 2022 17:10:48 -0800
Message-ID: <CAJx26kX_fb6RMyVWQO7TntVTn9i3z2SzR0uXjUf4_zQczsmEeQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the phy-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 1:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commits
>
>   5b679072af07 ("phy: usb: Fix clock imbalance for suspend/resume")
>   219ec4e8f7b2 ("phy: usb: Use slow clock for wake enabled suspend")
>
> Fixes tag
>
>   Fixes: ae532b2b7aa5 ("usb: Add "wake on" functionality for newer Synopsis XHCI controllers")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
Apologies, I missed the "phy:" in the beginning. Should be this.
Fixes: ae532b2b7aa5 ("phy: usb: Add "wake on" functionality for newer
Synopsis XHCI controllers")

How should I fix this? Can this be fixed in place?

Thanks,
Justin
> --
> Cheers,
> Stephen Rothwell
