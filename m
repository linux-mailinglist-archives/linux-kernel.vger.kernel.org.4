Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A9749103
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGEWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGEWfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:35:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F721732
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:35:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-56fff21c2ebso1292107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688596534; x=1691188534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGcxF4BR9idnjfupGfZyCZ3tDVPU/xSvJaiVs/YzQCI=;
        b=AhF64Ii2K3KiAB2gOnjbOyZ2KDgXL21Paphcf+V6zGa/QuHpJea1/xzEJLgRT9f7Tz
         ycFWBUn5vsbvhng7jDBvf2TYWTgw444okXaPCq1iV+JoosRrWCXS599JtHWwSOndp6Tc
         BaZ6pr5CZDXozxVYXszGuwh2tGdGIzQHWRDHYTiXs4aul+5PVvNagQO+Z5EgLsIHLHhS
         kOUeZ1+lACxN9vS1dmF1Spc/Qridb+y+YW1hf8pXncsf29xA3THa5GUWVxFUFAKYOPUt
         zZRX04zIQwUEEGzo0bt08MTS7yiLEmZd02vhwyW6rAlvf3hxvU6uJy5HLM3wJd62Rhug
         lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596534; x=1691188534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGcxF4BR9idnjfupGfZyCZ3tDVPU/xSvJaiVs/YzQCI=;
        b=kXuZMwWbWvd1/k8l2EHRghHGpgKlx7xyrZswnPw+0x37K65S8WnvD9ntz24Rf5i7X8
         SWt9SEQ0jYpQUrlEbpmff2njIXi62wc5kmHG/1qhEW6DCFH7KchM6iJLrkPsyHgvrXos
         IW+BuAV3g2G7D0lbldVzePSkTmX6Rdh0F1Dp3+4KFtv1eFf0iucObmMNOVIAgDy6J44S
         vmWWkXguXmaKsljrva2JqElE2y2tTpcV3dMyd4kVJq+iQ1lAf5LRbziTU1So6NkPKxXL
         R9zhs5/8FFFAbtvIQEu4uBaL95i01NalWOvjdgk+M9Zv9NcAg1fo8wI8djs84x/DeVNK
         kfUQ==
X-Gm-Message-State: ABy/qLbxQJe9V/GzZ7n88msclWhWAijwLOeGuxEKY1t39QBtW2u23ws5
        KOqiFlbv59HNy8IdCHzZwoSw/WAcBXb4wj2bs5S1
X-Google-Smtp-Source: APBJJlFUIN4oesag3UOXr7IMZjuy9McghVh2XL5utXpAKB8uwjlvAhYonStnTo3EudkZalVMNi0oXRA+5N+I0AAJsss=
X-Received: by 2002:a0d:da41:0:b0:568:be91:c2b1 with SMTP id
 c62-20020a0dda41000000b00568be91c2b1mr336115ywe.9.1688596534388; Wed, 05 Jul
 2023 15:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230702170857.15603-1-pairmanxlr@gmail.com>
In-Reply-To: <20230702170857.15603-1-pairmanxlr@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 18:35:23 -0400
Message-ID: <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
Subject: Re: [PATCH] LSM: Fix typo in a comment
To:     Pairman Guo <pairmanxlr@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 2, 2023 at 1:09=E2=80=AFPM Pairman Guo <pairmanxlr@gmail.com> w=
rote:
>
> Hi maintainers,
>
> In the description of function definition security_file_lock(),
> the line "@cmd: fnctl command" has a typo where "fnctl" should be
> "fcntl". This patch fixes the typo.
>
> Please merge if it is the case. Thanks in advance.
>
> Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks good to me, I'll plan to merge this once the merge window
closes.  Thanks.

> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..adaa7043c172 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2717,7 +2717,7 @@ int security_file_lock(struct file *file, unsigned =
int cmd)
>  /**
>   * security_file_fcntl() - Check if fcntl() op is allowed
>   * @file: file
> - * @cmd: fnctl command
> + * @cmd: fcntl command
>   * @arg: command argument
>   *
>   * Check permission before allowing the file operation specified by @cmd=
 from
> --
> 2.41.0

--=20
paul-moore.com
