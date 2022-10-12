Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C25FCCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJLU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJLU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB110C4EB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:56:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so7831edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dm6b6gBfiPZrLotsvvUKVkZh38+Fl7lVX2AUFcunJYA=;
        b=ntBHfF1LSOuWwNbB0lPlQrc937PKzrGTO3/Ooy7NMnwFuN4atxNMr4k/TvwHjcrG4j
         n5SYbc5fFycrT9yo/YoSpz1uUnmy+tCEiwRpdTrgFEFPFnYada0pNy2x/B9yn9GsfnaE
         luHC4yjdDKtwVF2ow8uqNfYro8zp0gabF0XJdUD6kzfOzAGY7nxB4h12jJu/uCD/QJnM
         sGFYSEs+jOlKkdYIrQjReMZDO39FHwzCfZCBY4BGB9ntyXlHbr9oQjXaXqEIEOqysSVL
         oo+kIbo26izaoeSTWQD7OuFvWum6bQaZeu7j35V7okH3w4R5pF2uYozRKPfdSDR69tZR
         tWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dm6b6gBfiPZrLotsvvUKVkZh38+Fl7lVX2AUFcunJYA=;
        b=4bHMDJDsPrJjkApl15VRo1RCD4b9njXSzTbdnhdCTPiDtmZgHEeq6jv2/JxRJbVSyP
         KkNw7mDelNYgiQEa3EXHZHJuD0J26+iRCBhga7Org7/s77NrFnauXLFrW2v6aSPlqHdO
         k4RNO98z7qNeMfsSD/svqploA2ys9VhmBBlEiEyrowP9AlBIDTj6ox5RI1vIXHX10B8d
         /E8rkWwDu7KEKOUfvqm5gEvrf/h6RplU2ejFXcx66+gU+8p4XlhufFfVEYHslwmxQPnm
         uRwIKcMhVJNUz4mSETlp8g4qHjU3aVCHmsDE0rJMve+YfOnWf63cTCV2+SC/C2DqtCLV
         XXAA==
X-Gm-Message-State: ACrzQf3R3Phau895HFb7WfwNWG9idrD+GuNH53C9dGubOgfFFW6FLJXL
        y2P/7vtDxqLOOxwHlrmrgInv6OPRjtrDiIQ9ufA=
X-Google-Smtp-Source: AMsMyM79laBRdMtv7f4w0ayOg3X9yNQvXENguKGsfNc9m/R3NMxIxxMGbK1c8wS37D04CG+tfO2G0xY0gGn2L1E3M1U=
X-Received: by 2002:a05:6402:2146:b0:458:15d7:b99a with SMTP id
 bq6-20020a056402214600b0045815d7b99amr29377107edb.24.1665608197776; Wed, 12
 Oct 2022 13:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191201.GA3107702@bhelgaas>
In-Reply-To: <20221012191201.GA3107702@bhelgaas>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 12 Oct 2022 21:56:01 +0100
Message-ID: <CADVatmNcUwZO3fmi=gU-ShHYCdQDwoWGcYWFg9oMVxdZdA98qQ@mail.gmail.com>
Subject: Re: Add linux-parport archives to lore.kernel.org?
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-parport@lists.infradead.org, Tim Waugh <tim@cyberelk.net>,
        linux-parport-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
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

On Wed, Oct 12, 2022 at 8:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> The linux-parport@lists.infradead.org mailing list is listed in
> MAINTAINERS.  There's not much current activity [1], but I suspect
> there's some useful history that we might want to preserve.
>
> Should we add linux-parport to the lore.kernel.org archives?

It would be really great, if it is possible to have the list and the
archive in lore.kernel.org

-- 
Regards
Sudip
