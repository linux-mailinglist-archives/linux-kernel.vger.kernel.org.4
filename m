Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706596E4C04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDQOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDQOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:55:19 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6FBB92
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:55:10 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-552fb3c2bb7so12063067b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743310; x=1684335310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiUW6ouT9eU7cEEuvLNBJj6uCVyb9oxwSNWWSEtoZY=;
        b=N1jBHyHqYo2w92EqHmVUYcqBX4h2RId2T4ePUICUx/e+tLVf1KI9NpbNnJj+s1/cU4
         jIl8qnM1JZFPP5l4afG5sTu77Z5BL0hFslayWrJv4Huimz6RFjxlTwvHTMUDSehblB2z
         DWrmIcK3yreuICY1Bs+TV59BQiSZKQzzUiH0me6+fst2jMe4hOcG5qPVFS6JqSuaNRo2
         6yET/AXWVeD0lJWU+sXkuG8wYmd2U0f8WZVVeejNnRkOfoG4A/6zNeH8fEHwAUM1ALU2
         dHVNOXlwjDJd6L6q8hHWBswsbyW7Qv4JpBEDkOvjLRu41W/uoEoY4wZH0IycfKTyV6LD
         TWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743310; x=1684335310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxiUW6ouT9eU7cEEuvLNBJj6uCVyb9oxwSNWWSEtoZY=;
        b=KpJNnVFrPWCoav4Tu3/6WTTawBYTeyWMvs5JlM/AgFyV29A8Up+hSsiTuZylpTMleT
         k2HenT2zFiZTOelSO9LQcL2xstJeNZ6NeMR3hTwE6tzwLtsPy7C7W61fjugc/teYm4Df
         fI4Kv1bi1dgpG16x/VvF4La4Z7T0jY6x9d3let0zI7I0I6usMVjBtgGENcrcmKGr7Txa
         GF5p5HGTNdeBJc6K6/ZfCdxgLVK1q3s0lQEXYyG2XCVo6MFwrAwEiHzLHaNbBG+0Xcph
         KtzxR07FhSKwCZXSPeSI2PCMIxtF/qIoHWa020dslVYno7Gn1LyFgbcscngjUQOSA2U+
         xzMQ==
X-Gm-Message-State: AAQBX9dgqkfB5dSJhNA3IjHTbOnF0O9NG7wfQCH8hyJrOUQZiMLr9oHP
        VepMFWE+iizxWk5zkMHiFMYetwYV9T4VH+Arr4Zz7w==
X-Google-Smtp-Source: AKy350bXe9bPbnmpUz40cF1jrt++48kzgjsPqD/6o8jjRKYJSOIMahy2BKO61REoJq4aAZfevpMsengqgQ8um5wpTJI=
X-Received: by 2002:a81:b64b:0:b0:54f:9718:1d33 with SMTP id
 h11-20020a81b64b000000b0054f97181d33mr9282038ywk.0.1681743309911; Mon, 17 Apr
 2023 07:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230412084758.2673-1-liubo03@inspur.com>
In-Reply-To: <20230412084758.2673-1-liubo03@inspur.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:34 +0200
Message-ID: <CAPDyKFqcpBqCnzxE7wpM7q1oDfHjaFV=ggnXJTE=hNkPK3=60g@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: remove unreachable code
To:     Bo Liu <liubo03@inspur.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 10:48, Bo Liu <liubo03@inspur.com> wrote:
>
> The function sched_partition_show cannot execute return, delete the
> invalid code.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 72f65f32abbc..e4c4bfac3763 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1341,8 +1341,6 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
>                 return;
>         }
>
> -       return;
> -
>  copy_error_message:
>         strncpy(vub300->vub_name, "SDIO pseudocode download failed",
>                 sizeof(vub300->vub_name));
> --
> 2.27.0
>
