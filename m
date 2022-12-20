Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6103651884
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiLTBtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiLTBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:48:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4DBB2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:46:15 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jo4so16934254ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYjnEnJJb87KvwDIqj1JDJuk+IOhVDh6BHpW/97A9v0=;
        b=WfeQv+e4uWeVrmKqH/xLMq9YgaOTmLJa//oirZEsO267EKMkYXlO79d9PIrSr3m1Ra
         xgZIHipAq2ArawVZt9/gEY/iyyt/yiUllaIXXBuF2M0vbHHZn5/3+PJfIv99UGtlVKma
         cF+ynq4zTep5UHA3kBOosggg6gSmY2pb8Jt/9SPZHLzJIMl6txHI32ipJsxRb3esIkWt
         Vf5yANWTiErbjfZfcqhW+4gwoyYyd9c16TUHMEC6Bwj1TiSuW8kfS9TPLlA53N2BjkvQ
         kRvJ74qh4sgVk6oxEy5XnjDPfWmmUCP9blLRM5MteAxbgf/Z/2UIjlzUQAqGEn9HjK3y
         IKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYjnEnJJb87KvwDIqj1JDJuk+IOhVDh6BHpW/97A9v0=;
        b=TOclFIGzQqi4fvzQNFeiGkd7TZZNMOaAGnLNQn2KiDXVg73Y1BOv1GyZVs17PPnjjg
         pbdeZlXv1h8Ye6Yb1EATka2kflmNbgPSM22vl6djvYjWqUze55hYkINJ8GaJzcohdRbr
         V8DlKWwMHEGzl/dscTnJnU2FGfIxZs6s/3Pnel1VvMttC+dyZytRkhc1c5ypcC81iZ2L
         nbPsf0dM9fQqhByahhrHMGwH+mAAEEA8Vqkvjy6KFwP/PW8tp1lw54mkxTzdxDUilHO0
         BJPMCoD6UH3pcMxNbgy83UXoFSEyxW/XyGePBbISWg24Fa5BpkXomJngr8+c4cCcJIzB
         jX3Q==
X-Gm-Message-State: AFqh2kprTVi7jfTGpLJRLxu+mtUOK2pMVmSAD66l8ceNRCFkQT9Z+6QV
        b5WP6XzpwczBcvTl5z4qVbaXNH3D9fyuSxzF2r8=
X-Google-Smtp-Source: AMrXdXssgPX5itOSHtxGMMpkvUxxyxOV4F0wKrqQWYw0DJ9T0YbqCXDFlUioyQvxrf+FNu2pYysGcO4vFzE48aUW0ZM=
X-Received: by 2002:a17:907:8b97:b0:82d:e2a6:4d38 with SMTP id
 tb23-20020a1709078b9700b0082de2a64d38mr305444ejc.729.1671500773327; Mon, 19
 Dec 2022 17:46:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com> <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com> <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
 <20221217164059.GA4724@1wt.eu>
In-Reply-To: <20221217164059.GA4724@1wt.eu>
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Tue, 20 Dec 2022 07:15:56 +0530
Message-ID: <CAPDLWs-3HiK_rNxfh=teQhGN2ZOaQE_NksKbzdRr3GcSBPJTfA@mail.gmail.com>
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Dec 17, 2022 at 10:11 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Sat, Dec 17, 2022 at 07:14:14PM +0530, Kaiwan N Billimoria wrote:
> > :-) Got it.
> > Taking your point into account, I'll rephrase: as the _convention_ is
> > to mark the last release in the year as LTS, is there any visibility
> > on when, or if, it comes about?
>
> What Greg tried to explain to you is that the convention is to pick a
> sufficiently well tested kernel to make sure its maintenance will not
> become a huge burden, and that it cannot be a single-person effort,
> testers are needed during that period. As such companies and/or users
> engaging in investing some resources for testing are extremely
> important and if some have a good reason to prefer investing that time
> on a different kernel, their choice will count more than just a kind
> request on the mailing list. Now you know how to make your voice count
> if you want/need 6.1 to become LTS.
>
Willy, Greg K-H, thanks for your guidance,
Kaiwan.
> Regards,
> Willy
