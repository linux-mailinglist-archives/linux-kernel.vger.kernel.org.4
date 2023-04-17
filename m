Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61716E4BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDQOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDQOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:54:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20786B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fbee98814so172158127b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743274; x=1684335274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VPTp9pLtoK83vzBdHbJwGD09vD5n+Kah46Y+6l1pPHo=;
        b=qXlpTNbKjYd9j7JF35iS9MqpAz7/EeNRZpV4ZRepG5qeLIfk3qSDPWoV+XYnZ3EXgQ
         pxItLm+GcdpemiQb89zPKVTBn4YB8Oy/UilB+13ei3sXvLFL2GjaO4fBRegGunDXX+jE
         ZzeijtrRYb+ohcnno3P/5zr0HneDn9WfQTLiPXsiDbcOviB4AXl499EvjUQlLK81BUOc
         j554cezsnO/VF8kqp1kJnxQoLkpjg539DkdcjzG5pjmv3CxMa7++D0FWOUDTzPC02Jku
         aZTdHwDogv83MOaToq8DyXumbW1FsgvBG+61XrP2Jpl9NGsEXFBskYbkcZkdZnjD+qZ4
         xshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743274; x=1684335274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPTp9pLtoK83vzBdHbJwGD09vD5n+Kah46Y+6l1pPHo=;
        b=MHZT6eq/B7MKTilFUKmF/6XqHMHAwUdJ0df8BjjqcB0DXaAf0DcbdPwbtKvpYIbv5C
         92xCJJ4Rw7A1dP+WNsWjDeJ9XDu8MwzupODMJRab2m/TEWMZc4hO5en8KAc7hrNB8MFX
         WmGst8ixzQPOB1Jw/lSuneom0Gm946iw2PHlmD6ThPLUz15Zsh+BxAiuS0IX7Z8SkEqw
         FkH/nMVQ9maIc3XAsLBLgKH47j21DZLnC5OmRMc0XfyGcnJN9duMrj/JIdtjort9iX20
         4QF0ACsKc6ybKOZmhbJby5ntwdBTXgEGFHXwDG4P6esRU5WytRMsFWdwAKPouzhRUomC
         GzFw==
X-Gm-Message-State: AAQBX9fQrjGrxjZmhekGcup4Rm6SeuotQlRiH/9VxGmpA2Rqz4w7udZZ
        T6mwRlgazWfvug63q+dPAJakD/XhBshJJVdRRU3f4g==
X-Google-Smtp-Source: AKy350aAxekeGoflqce7doM7UjMhpCqdeInG4hZhUS7lQvZEbqwiJubjsOwYkhzODLIwH9EUnKpL6x65JrX94Qe7Tbg=
X-Received: by 2002:a81:ac19:0:b0:53c:6fda:835f with SMTP id
 k25-20020a81ac19000000b0053c6fda835fmr9059487ywh.0.1681743273850; Mon, 17 Apr
 2023 07:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230403221754.16168-1-beanhuo@iokpp.de>
In-Reply-To: <20230403221754.16168-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:53:58 +0200
Message-ID: <CAPDyKFqo-gcnRpg8jzXtAtDZRSFvm44S7sSZFk59Gpn_9Jm8Jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove unused macro mmc_req_rel_wr
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     CLoehle@hyperstone.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 at 00:18, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> There is no user for macro mmc_req_rel_wr, so delete it.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..00c33edb9fb9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -76,8 +76,6 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
>  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>
> -#define mmc_req_rel_wr(req)    ((req->cmd_flags & REQ_FUA) && \
> -                                 (rq_data_dir(req) == WRITE))
>  static DEFINE_MUTEX(block_mutex);
>
>  /*
> --
> 2.25.1
>
