Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D238676DB6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjAVOeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAVOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:34:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995141A486;
        Sun, 22 Jan 2023 06:34:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so24513608ejb.11;
        Sun, 22 Jan 2023 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZriZiMPIU2WK8xR5zBjT7oOvj2SaNCefYMZvu5k7X8=;
        b=GYvBOT4U6mq8mXSWEu79oAfL4WBPJOUdBXg7VtPqRTqAOYR/xCFAr7jjl8SGUWtl2V
         b/mSlsbxi6nPbCA5x2Xf1Ip4sITsQ+31z1BleRe3YJe0vRc/qb8ZEUjy0sDUIom24e8M
         rGy/nrDp7Iz53WCD4DIm1JNB29j1MKHaWjAIg642bm821DRv/5mKrNXI7ptkAylpHwfJ
         uIswh2lago45/QcOKab/n1WheVdje+FyrXJD4HZk8O9kohPjbbA8vcQ/TPxApQb0EIuA
         N6U5CAuP04BmjHjJ5kySXouQ/llhoB0FvCoHSei1kv10XPTD86Wcgrso1y+X0WSu0JyG
         eoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZriZiMPIU2WK8xR5zBjT7oOvj2SaNCefYMZvu5k7X8=;
        b=NG3e2q0AKGq4HiZc/USL3em8Dzo9XZJX5LC/uprypaLHAdtlyhQLceVQEBU2AQx+Gw
         pctTswRN8U61Qc0fT9Z8mFqC3oB9PXBYN1frCmFbd8hOQS4Kb0fRwTwUKg2/pIyC83bs
         orbTqARmvPNYGxv5IUws0VlZ7tqssLOfzYRLd3Sc1IG/bCnbdHQv+x5B+yadUU4FMp3D
         kCgKGFn6HsWVVvRJssPd6M5dtmG3bDXp6HdDq4Mt3JGcTs39f1rAtpZye3pI5GOysD2z
         bMsagCzSOX3B13RTVPZ7jI0qcHX3ipiwU3/ltJiiWTQxGpG1+3AlSjzYcmJfa/FAB/zi
         jRCQ==
X-Gm-Message-State: AFqh2kq8a3x/s11NX1DEMe2G0KuuYPaEa3x5OHX4/i3ZhiAFfWxfsd4p
        OgcG/G7fYF2jtGaFBldpXdE=
X-Google-Smtp-Source: AMrXdXvR2IFO43ZwlaCswWZe5DBXi31YXU8sxZ3b0MrZCxWvpaMFvy2OUdfm3unbyNhTA44GtdP7iA==
X-Received: by 2002:a17:906:95d2:b0:7c0:a6a9:64e9 with SMTP id n18-20020a17090695d200b007c0a6a964e9mr23141308ejy.36.1674398060953;
        Sun, 22 Jan 2023 06:34:20 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b0084d4733c428sm18369508ejb.88.2023.01.22.06.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 06:34:20 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 49626BE2EE8; Sun, 22 Jan 2023 15:34:19 +0100 (CET)
Date:   Sun, 22 Jan 2023 15:34:19 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: amd_pmc module not autoloading on Thinkpad X13 Gen 2a
Message-ID: <Y81Ja5Y/tgPXk5FA@eldamar.lan>
References: <Y80NXKyaj25CtSBt@eldamar.lan>
 <MN0PR12MB6101ACCD8A5003CBB4BEF58DE2CB9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101ACCD8A5003CBB4BEF58DE2CB9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thanks for your followup.

On Sun, Jan 22, 2023 at 02:08:00PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> Salvatore,
> 
> The issue has been debugged to be an s3 issue not an s0ix issue.
> This patch series has been submitted for it.
> 
> https://lore.kernel.org/linux-gpio/20230121134812.16637-1-mario.limonciello@amd.com/T/#t

Yes I'm aware of that (and planning for Debian to queue them up after
acceptance). Sorry I was unclear maybe. The other part of the question
is, would not autoloading amd_pmc be an issue, and what information
would be helpful to gather to tackle this?

Regards,
Salvatore
