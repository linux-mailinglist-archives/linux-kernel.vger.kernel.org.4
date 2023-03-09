Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3A6B21BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCIKml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCIKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:41:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B759801;
        Thu,  9 Mar 2023 02:40:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so1532649plg.1;
        Thu, 09 Mar 2023 02:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678358441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyl81I8ADQB7ZEDVkfI8Lf6EZZv8XRoJjGLTIx+4w3Y=;
        b=X2DxsFWO7354x7Wcg2S1XxO6fQllb+Ut9X5C/gCorM/8OaoPrDIFI4aSH5CVgv1d26
         4SHeRn37N8SpdOoHFfZGP08RjJwoQ8NqHlnVCKPqr0ZYAgoT41kKadTZS1HP3VfndaSd
         4Mo5OwlQjVhqypCfikgkP2jQVeqxLdgHMlh2L4STrFQdoxL5U8hz9dYSOojeDjZ/ry1H
         XIjY78Z8YgljvpSUo0kdXwAFJxDsghqsGMTAd9j6XeOtYGR5hnMBfUsb6NRuDcGkiYCc
         f7KUGlDQ8DBwIOfevA9/vld+JnKOMX7ySvqZjueHURfdgd0zNbqNEM0dhFy4Lj3DUym5
         3/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyl81I8ADQB7ZEDVkfI8Lf6EZZv8XRoJjGLTIx+4w3Y=;
        b=n3iWj3nU6gDZ+3P1wlDIeMwZCYGrjeJy4nOTZnOifQHimpwYyjEn81guki3ZrhMXNg
         SwGJ2jI5GsOk9gcqQn67aX9qCMilmhbpzCFQ+FeOPbMdGYij2eCJ77ceM0f1In7RKNE5
         CAIxWoQyFPF4nCmE3R+RxfhSuRzYAQUBhcAcxIHGLgT5UBav9YORB5ZTGr/jYoHtHWun
         F9pgllqeHEm47zFBD08eTzKjyNgIQkc+hYeaf4glj+7r12C04Xb8k+ZzWkSWU/9G7A2h
         EPTCQj0BVDXNGBcwZGLiw5ZxbYkLozvZeN3ln64zsTYyKQcmN9hztmJ3IeDPOr0aZcuw
         8ZVg==
X-Gm-Message-State: AO0yUKXnxg+o1zvNKzMOVVJjHGyoda2Klb7+cqH7Biarr/CIF9kycPtc
        VFEBU5mmdzAYWeutSFuDQZA=
X-Google-Smtp-Source: AK7set8dJtkAozR27n4w+Dp/CLZ6CxAmWHkP6lUx1GXw2VrnzQzDrGp5AVjBGZc33bBEYEqs0TCH9w==
X-Received: by 2002:a17:902:d492:b0:19d:abd:bb7e with SMTP id c18-20020a170902d49200b0019d0abdbb7emr26319563plg.34.1678358441477;
        Thu, 09 Mar 2023 02:40:41 -0800 (PST)
Received: from redecorated-mbp (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id az11-20020a170902a58b00b0019aa8fd9485sm11256199plb.145.2023.03.09.02.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:40:41 -0800 (PST)
Date:   Thu, 9 Mar 2023 21:40:32 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20230309214032.3683db01@redecorated-mbp>
In-Reply-To: <4c63d660-1105-9a8a-1010-cc05125d06d3@redhat.com>
References: <20230309122822.77435e33@canb.auug.org.au>
        <4c63d660-1105-9a8a-1010-cc05125d06d3@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 09:48:58 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi all,
> 
> On 3/9/23 02:28, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the drivers-x86 tree, today's linux-next build
> > (htmldocs) produced these warning:
> > 
> > include/linux/apple-gmux.h:99: warning: Function parameter or
> > member 'type_ret' not described in 'apple_gmux_detect'
> > include/linux/apple-gmux.h:99: warning: Excess function parameter
> > 'indexed_ret' description in 'apple_gmux_detect'
> > 
> > Introduced by commit
> > 
> >   fc83fbc80e1a ("platform/x86: apple-gmux: refactor gmux types")  

Thanks Stephen.
> 
> Stephen, thank you for reporting this.
> 
> Orlando, can you do a follow-up patch on top of your
> latest series fixing this ?

Yes, I'll send one soon.

> 
> Regards,
> 
> Hans
> 

