Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAE65E908
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjAEKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAEKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:31:30 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2894559F3;
        Thu,  5 Jan 2023 02:25:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d13so25281785qvj.8;
        Thu, 05 Jan 2023 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TOfkL7MyOeQeSrJ2F21ekedGlSVWVhq+E3DdO0nm1r4=;
        b=c3GVsPT+wysvPStVKkYnBNMJlfpAT8IQ29T6m2mBmXZfX1sVJts/3K/QOPnib88xoe
         DbBI1krlALLHuqtaDPBh9iKcRDT5sbvXKDixd3n4JLKplH7ln1Vqn/4GsnqlGNheXgDc
         yuUt6UhqoMS3ynCFK0mbjy31O0Wyl+abWSim81r3HI/tYzijPDH7HjrNkEVb745g1C/7
         irJToeSxFZ7wRNrfARCNuYpF5IgliaPOT+wPgG4qBctVMsjpU1PhTPbSlzJWqsRvnsAJ
         wkhThC2XyIN2joFBPZQOgeX1+hLd8HUdKg5CnR+gcPxDb3jH7vtxFDhWitKan8ZKbRAS
         +FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOfkL7MyOeQeSrJ2F21ekedGlSVWVhq+E3DdO0nm1r4=;
        b=OFqoJKcIlCNYo7Vxuk0+98oB7bORgmAj2XKJflm2gPbsG+alwNQNs5scnAku3Qosgn
         zr4FV0Kp9a+LNRGyXP1vmH1dcqUrccEvu2JbeLFqMV31aglug2DfA9jEiiyZeru4nCmN
         o2isfAxBxl3anRyQHJ76kaTSy6Tsoufo369l7Vzs0zvcsYAtOtXTWaDnPPZonlARKf/z
         LmcunHwq2ih2JbU50nr6DBanJQarZy9A/amkNVN4gTdycKa49UaqC8QGl0t8RKsVKRce
         gZlybVWRpXMvgVuUydcteG8rhsF3sUwohj2uQFB51PZy3eIvaZ9NdVx5+DErb1pCq7gg
         KExQ==
X-Gm-Message-State: AFqh2kqZhTfrehX4sYc1/sOo+Ut882Y9dNJuvxmXNZ2Qe9uvTQyEK8z+
        D5IT3AEznh0CRL++Ev6bBDK4WhXPFDnmMpUxot+Cnn2XEww=
X-Google-Smtp-Source: AMrXdXtvC0Bt/DBCsyOcP0u0xHxoN3Qc+QonoeKkfiWauqM5Fa1hRedoh3ln8itCPshJjSL8zDCzwwy9cTcze4ueQ6A=
X-Received: by 2002:a05:6214:3313:b0:531:c954:a557 with SMTP id
 mo19-20020a056214331300b00531c954a557mr522380qvb.13.1672914337262; Thu, 05
 Jan 2023 02:25:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672728620.git.chiaen_wu@richtek.com> <c1c6d3e51c93c15620ded0e2a53dcbe5de066ec9.1672728620.git.chiaen_wu@richtek.com>
 <Y7QoNpbFRsK3bW6V@smile.fi.intel.com>
In-Reply-To: <Y7QoNpbFRsK3bW6V@smile.fi.intel.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Thu, 5 Jan 2023 18:25:01 +0800
Message-ID: <CABtFH5KjksZ6GSOMafU8aS5mJzGkd8SDGEzH5irFUEFceQTWtQ@mail.gmail.com>
Subject: Re: [PATCH v15 RESEND 2/2] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     pavel@ucw.cz, lee@kernel.org, matthias.bgg@gmail.com,
        chiaen_wu@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Tue, Jan 3, 2023 at 9:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> >  obj-$(CONFIG_LEDS_RT8515)    += leds-rt8515.o
> >  obj-$(CONFIG_LEDS_SGM3140)   += leds-sgm3140.o
> > +obj-$(CONFIG_LEDS_MT6370_FLASH)      += leds-mt6370-flash.o
>
> Can it be kept ordered?

hmm... I found "mt6360" actually did not keep the order either...
Do you want me to put it after "max77693" or after "mt6360"??
Thanks for your review.

-- 
Best Regards,
ChiaEn Wu
