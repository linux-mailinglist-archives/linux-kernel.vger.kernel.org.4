Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8E6D6335
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjDDNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjDDNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:37:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46F1BD0;
        Tue,  4 Apr 2023 06:37:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so42465624lfu.5;
        Tue, 04 Apr 2023 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eXqdv5R87UkWerUpADSYoTnH9yUbvTu+QxPfj9tLIA=;
        b=U0zCF63H3O415nTgouxCcn5kmjVydu0JtlOM4Di2O9rMVKWCuU+SscNmFFUnV9zUl+
         UnbmaZHgCOQ7+Ab216xHn5DLH3RCQSFSpMzGayzRMohf4jbY2XhBbWPU6XHMgd2Pxzsz
         hk042GrPpRNijD3iOjVVEwvKONZYbrlVOZW045OZSGx6eUkKNNo9xMf9fxiXfRhZlAcA
         v4YBubXVdnd9y8MWBvYwLljGHt46B82qtO5FJ6ZF/6lAitKwMlZNoKEcEbjTlGSdMh6R
         ARhSOrWbMupM64rs8NXMiYZlW0eaQ64A2k6gP6/pb7cZ2uoG4RGlL1MhfEpMWB+bhGQr
         GfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eXqdv5R87UkWerUpADSYoTnH9yUbvTu+QxPfj9tLIA=;
        b=jk45b5Tguf3X9t/Tthm9ML8PsqFpG5+H9zVPzrfTdzXK6zi7tv0+/GAwxEPymc0y7P
         n6M2MW07N35TNtrfXNwIOB9a9GV3q7GX4TEg2az9NtHgoVOWgekEsCGCSl2kcwL/PezX
         cIO3exgKNk66mZyrYosOohaHv8rLgIFl/2hi5YiaV4YJamPG7VqLSfSUPdMLZloMq8ZM
         FW/zpC9vEpmpYLcwU//p8ygQ6BnPSXOK3QF33ct116AGVWC4SzAV8rcQgfy3z0j543eD
         +IvaDs4ttdTUgbhCm58jW8TJcImukd/EjtlhANJUg0M+tvBRdldd4o+G1bIk63vsh1KW
         y3WQ==
X-Gm-Message-State: AAQBX9eC9YpqL+xPyl8Hq6MtLE3SeL+EA39aXqARF1eyQiIYhcoZT6un
        NRcAGqEhzlJXbYdIG/nRYi36G5Tcb7Awa7DdZIc=
X-Google-Smtp-Source: AKy350ZEAT1iGbbnRn4oiCOcUJdthP/lFaoMOdybQzNCgzOXKAR70jKI+paKyFbAceTGtY/nCUeMaRW8ef3QjV4FsNA=
X-Received: by 2002:ac2:592b:0:b0:4d5:ca32:9bd6 with SMTP id
 v11-20020ac2592b000000b004d5ca329bd6mr741155lfi.2.1680615468201; Tue, 04 Apr
 2023 06:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230403211548.6253-1-jorge.lopez2@hp.com> <ZCuMkdb6jeL4S8hz@debian.me>
In-Reply-To: <ZCuMkdb6jeL4S8hz@debian.me>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 4 Apr 2023 08:37:30 -0500
Message-ID: <CAOOmCE-5NHkYcmBP1GGpr=sEoxF9jkjj1LevekEm8R0wbrM4xQ@mail.gmail.com>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     hdegoede@redhat.com,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

>
> Where is the rest of patches if this is a series? Had they been merged?
>

There is only one change as requested by  Thomas Wei=C3=9Fschuh

> Feel free to ONLY submit the patch with the documentation for the next
> revision. Then we can nail down the interface and initial functionality
> and you don't always have to adapt the code to the changing interface.

Perhaps, I misunderstood Thomas request.   I will address a few other
comments and will submit all files again.

Regards,

Jorge
