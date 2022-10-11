Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF455FBB59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJKT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJKT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:29:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA37B2BC;
        Tue, 11 Oct 2022 12:29:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15so13372012pje.1;
        Tue, 11 Oct 2022 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9o2w1TYXttFTTjml30YJIaN8TXEmaRFT+y/H7e7rsw=;
        b=dC1wzGp766abb0SfwXPsfebOw9HgWgXNqdpO6qpq7s+LBsK6ZNz+dWTdOUE0tLXYVq
         GY/O2+yVras3FbMVGMWt3JdzCTKO7bNfZNG3NDgCN+vlBbUtxBEo7TelNiyziE9zKYZz
         gD3wad0/0h9AnobdjeVX9HWbet9eL3k5IkGF5FKKtIu9kioahxh3jveXgMObXth7QKcb
         g5sVAz++SdUCt/kBGLrtAvZrEF13eim5Vbo2T8/o1xvlrDxwQWtXABM/JBfxurXQtWsa
         puUfMKJnQPMNGqN4BzvD9/8JzZ4gGAr7a3Z1ZQF6e/2XvWbtubCnyBcW4hZGEFL4mT/j
         jnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9o2w1TYXttFTTjml30YJIaN8TXEmaRFT+y/H7e7rsw=;
        b=xTHMZDYSXYiTkCa069+LL2Xh3tvdgv1yRbT8KrPnrMa6iml3UjV/EhhS03Psd3gUwz
         mUEvXix9ynlkIfv5wCeBcr0C5pQb2oYE8MEyY2B8PqECC3KYyjTKuWIMEXfZIifnVWKK
         tol8wV4Jy/SUQxXsPjF8OJtclcoGV+GBBWfIVIDE/DCPiT0irwquhOQGDUQfW+GyXgaA
         fmUPGjiFVIrEu/RuoqmEx/stqE1I1d8lZYvhezyq/nmhUdCq/0bDX6UrPDek3teRD57L
         GEHZwL9nX3cqAYJsPPMl2LdM9WUmODhsUMXfYSQe2jWnUKNsSxxQlestPUauEH0ZeuZL
         29eA==
X-Gm-Message-State: ACrzQf0mtKHi1nWVXQPRpdkgrChnXVS4oFWsv3yFHx1gJo0Xl89ka3W6
        3nEsWNhnBiiBPW7nfycVLkQ=
X-Google-Smtp-Source: AMsMyM7dTD9RlFu9H5B9jEVB/wKJRWOR006AKjiJYpzVFTj2wSDi2tFyAjbzJJ45g1ETN/A6035lbw==
X-Received: by 2002:a17:90b:4b48:b0:20a:8ea4:a18d with SMTP id mi8-20020a17090b4b4800b0020a8ea4a18dmr775859pjb.75.1665516540714;
        Tue, 11 Oct 2022 12:29:00 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090a628a00b0020aaa678098sm553263pjj.49.2022.10.11.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:29:00 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:28:54 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XD9tTd0ahj2jRZ@mail.google.com>
References: <Y0XAxX4g/9N6qdnD@mail.google.com>
 <Y0XDAtQ4eYTgwIgM@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XDAtQ4eYTgwIgM@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:24:50PM -0500, Gustavo A. R. Silva wrote:
> On Wed, Oct 12, 2022 at 08:15:17AM +1300, Paulo Miguel Almeida wrote:
> > One-element arrays are deprecated. So, replace one-element array with
> > fixed size array member in struct dlm_ls, and refactor the rest of the
> > code, accordingly.
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/228
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> > Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> 
> I think this should be versioned as v3.
> 
I didn't add v3 here because the the patch got changed from 'replacing
[1]-array with flex-array' to 'replacing [1]-array to fixed-size array'.

Let me know if you still want me to send it as v3 instead.

Paulo A.
