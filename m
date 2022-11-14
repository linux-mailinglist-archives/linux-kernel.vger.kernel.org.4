Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4676284E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiKNQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:17:45 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3E62ED63;
        Mon, 14 Nov 2022 08:17:16 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id a27so7033567qtw.10;
        Mon, 14 Nov 2022 08:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MG2DwBbr5dqsaW3mK7dHyLfa8FobjN2Nv6cl+aBJihI=;
        b=IuBBeZv4T/VFSqIlKlzqrzBGs3PC4LBj/H8tnI2boma8ku0MO9PtFi36v92WQexVg0
         aBq9mY2a3cjMP1pIrOu5Kfn0HVh5fjhWZPtH2L1XWK8an8OO1R2v2LsBarR9afLPDBht
         AVHGZvC8qU0qpI0XO7n/Gh6xhOhe1Rw7555UOPBduitgTxQlkU235HIWMEd7NE9WGuKd
         IEDUGBPX3dHX8/3NaJ1UdEqVx4TyqkHjroHBAScKRSnm1jPFLIvaTtIKcCslPXbVScEE
         rHLSdjkZUx8MGbbcvAJh2ajKrgYG4hQmrW861GfrNfgtOO4OWWj859YDS+DCzZtb11wj
         Of2A==
X-Gm-Message-State: ANoB5pmH4OqpKMvBhbNn+vop5LHGNqOZO1qhlOvl8eaISKZRB3UbhE8l
        PRz5nNhivouqZs0qHeaZheFDz6bJRsT00K3GF8A=
X-Google-Smtp-Source: AA0mqf5sZdpMhkd0wSOTKDrCn1eXwtNpTjnqcyf1w5SxwNQFnlr2SV7SIPNwFVaytbUhruPMS0Tc9i7h5fIr+T1l9R0=
X-Received: by 2002:a05:622a:8cc:b0:3a5:5987:42c6 with SMTP id
 i12-20020a05622a08cc00b003a5598742c6mr12559271qte.147.1668442635838; Mon, 14
 Nov 2022 08:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20221109174720.203723-1-jeremy.linton@arm.com> <20221114161206.5sspq25v57ddco4o@bogus>
In-Reply-To: <20221114161206.5sspq25v57ddco4o@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 17:16:59 +0100
Message-ID: <CAJZ5v0jHk9eEj0EnH-hWnRsabAs+E3LiudTPE+KFhcsZARaw5Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Enable FPDT on arm64
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org,
        linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Nov 09, 2022 at 11:47:20AM -0600, Jeremy Linton wrote:
> > FPDT provides some boot timing records useful for analyzing
> > parts of the UEFI boot stack. Given the existing code works
> > on arm64, and allows reading the values without utilizing
> > /dev/mem it seems like a good idea to turn it on.
> >
>
> FWIW, this looks good to me.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Hi Rafael,
>
> Just saw this marked as "Handled Elsewhere", do you prefer to be merged
> via arm64 or other tree ? This doesn't have any arm64 changes, just Kconfig
> and doc changes. Let us know.

There is arm64 in the subject, though, so I think it belongs there.
