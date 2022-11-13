Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555E626F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiKMLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:32:58 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F5BDF31
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:32:56 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id e26so2814659uaa.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QZvRyD4M5+zFkbDYVhqBnw+Q9GmoKf7/UeDVhKpYoo=;
        b=dPIz6bgV7rDD8gW2kNtZ+bKKj7qTFHbJbnAwN/sPkcbIclY5/ZrLy8rQlfcn38C5wl
         CyPzOiqhGAYcAfyQd2fQ26hgxFtFuN4MCp1rpKbwkzzzFHpu1vaVMeTk8otm9mRHQhLs
         oAOLHum09VrK7MelP/FPKwfv8xggfW5xHEikdEh66xBHEcfAe6q18azDyzSTE4lF4Cs+
         WnygNKcRqyf6F3o+UNgMRqKMTmE7tkul/w6XB0rugqKwQSfl/BQ/jpwKlta0vVyiBAzI
         tCM9nukH8PWin8iEzjioKCjN8Cj36eFnhYy/DkwzIokja7+6bFTvkbwI3Zy0qnSsszfk
         vPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QZvRyD4M5+zFkbDYVhqBnw+Q9GmoKf7/UeDVhKpYoo=;
        b=porVmxL67aOwFow3Ui3EWizXPSePSHSUDI47+xOGV7NmAGdlVl7WpGj3KR+YH6WjJF
         tnyO5kcFNx3igyOoOgdw2R6n/tk6zB9zHzJ9d5uimFFMFhU0XziCjZJnJTFGjVWd8+x+
         GFQBr0ns/Gcq3/DCRzn6rSlgB3SZvMAiLSocg6Sszl7thpdkAazxNagbMSbSFzxZBgMC
         qkg27pSIc8/tqMmPav01AOXIR3KkJ994z23CzFjoEEjuZ1TkarHUBn2ngI+3J6GoNAFY
         7nhs5ggU5d4p4zuSrBya8xp4i3iwm4T+M+wVMzwBFtzQOGB7XwVqvTI/kj7D+s6fZHLt
         8eJA==
X-Gm-Message-State: ANoB5pkj06jybjpUi931mMn6owkpuTb76iSQUqw2mmTDGynswMfuO3Ub
        Q96RGt8qSssRtFHNH3apIKtmlzm3/JUWFem9TNrRD/4H9+0=
X-Google-Smtp-Source: AA0mqf6lzzI7oOuLBkJTezEkfY4Josaj54aJ/MqWrp2JaM0BbPQwqbTXOMVJz9M8+sGJoNOx7/7X3yDibtJ9h3Jc0fY=
X-Received: by 2002:ab0:3b5a:0:b0:415:8954:bd51 with SMTP id
 o26-20020ab03b5a000000b004158954bd51mr4455074uaw.97.1668339175936; Sun, 13
 Nov 2022 03:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20221113112653.12304-1-tegongkang@gmail.com>
In-Reply-To: <20221113112653.12304-1-tegongkang@gmail.com>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Sun, 13 Nov 2022 20:32:44 +0900
Message-ID: <CA+uqrQABhoUAoJ8S4iAKn-=zouDJu=jaB29BgL4oLa5jxtGeCg@mail.gmail.com>
Subject: Re: [PATCH] ndtest: Remove redundant NULL check
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 11=EC=9B=94 13=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 8:26, =
Kang Minchul <tegongkang@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> This addresses cocci warning as follows:
> WARNING: NULL check before some freeing functions is not needed.
>
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>  tools/testing/nvdimm/test/ndtest.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/te=
st/ndtest.c
> index 01ceb98c15a0..de4bc34bc47b 100644
> --- a/tools/testing/nvdimm/test/ndtest.c
> +++ b/tools/testing/nvdimm/test/ndtest.c
> @@ -370,8 +370,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv=
 *p, size_t size,
>  buf_err:
>         if (__dma && size >=3D DIMM_SIZE)
>                 gen_pool_free(ndtest_pool, __dma, size);
> -       if (buf)
> -               vfree(buf);
> +       vfree(buf);
>         kfree(res);
>
>         return NULL;
> --
> 2.34.1
>

I just found an earlier discussion about the same patch as mine.
Please ignore this patch.

Thanks.

Kang Minchul
