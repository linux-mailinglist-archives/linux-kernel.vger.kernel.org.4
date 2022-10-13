Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D85FE495
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJMVzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJMVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:54:59 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294F303D3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:54:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-358bf076f1fso29987677b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMIVAykxBe38/iC/E6uc7T7wvmS7tw/OTeZ758Y5Y7o=;
        b=P9IbXagKldqPlhXR/Ynxm74++40pPNmrIoKj68/ZaL40Wbei+ACwPUSuWAl+FrQ2So
         B7tQeT+IPJtEryxCbbTzWRzvxaKKFxqqkupLRDwCRZ3Rzvup4fin04QZw5pR8Szdkttz
         xLoGJmkmhX0lqgAFM8sBVqC8PBZpSnq9vZKRUv2nel9s8FTBihHQdUm+ai3lfUbStLCN
         Ilt1ZF2yLG5ZHPbw78eV5Bmfs0dBUr4RBQd2m8lybcBxjwGo3hEZFzfZTo7uSyP415AA
         IlafW7O47qwp53T7yWpEmIoiTGNoiW3iaa165UcV/apUNWyGhMcWNdgl7i7SkiNQ0lb3
         Ko0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMIVAykxBe38/iC/E6uc7T7wvmS7tw/OTeZ758Y5Y7o=;
        b=Q6GIU+RtkofETRTtMsWkPhh2bQ2rk7tBFwZAbgA6he3L2SuNnaTR+Ju0g3dPK7xjCt
         yNto3qVOXboygJR5NrdJmq1DeMufMSWwWao+WH77VNFHarUgAGo7fEJTpfQrzgJXxxZh
         7SQD4NsiJjmkBhzkIGnPO9aRJpKHxnnbqV3UeEV17DiZgqXkuZVx7AS5R3wKMfQKQkv2
         zpInYuAavz4Qkk3ExihQIPYP3ZvLOOM/oMbzMcCWsVIHO137qwERwD0yJ3/TdKQ2lVan
         n6HWYJBXGRIfZBgfNmNlTegswLIBlP9obAzaPLvou+FSav/DRrefSi+TR9PFqivcfYpE
         oStg==
X-Gm-Message-State: ACrzQf37wcBEIhxeJtpFLVLfggVnkKNOlKqeWbl3Fp0u4V6lIu4D6qEQ
        fnI4YtFuWtkmrGP72rO0ijoH8hwwq5/tekEMfJRWA+yA7A==
X-Google-Smtp-Source: AMsMyM4JEMdMZBfMMOEelszS2FpP9sTFphB2c0U7BQE0LEIVEYbWEkduPrNlOO6ZaZ5zQ40oGab8VSOjZhfOIxy4NMA=
X-Received: by 2002:a0d:ebc1:0:b0:360:5a77:4d78 with SMTP id
 u184-20020a0debc1000000b003605a774d78mr1942006ywe.336.1665698052305; Thu, 13
 Oct 2022 14:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214637.30807-1-palmer@rivosinc.com>
In-Reply-To: <20221013214637.30807-1-palmer@rivosinc.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 17:54:00 -0400
Message-ID: <CAHC9VhTPt40PFC5NASOjOK+fqJym5JOyb8UrwAL7DGDQWqVwqA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for cschaufler
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 5:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Casey is the one who needs to ACK this (and he has an email delay at
the moment), but the URL looks good to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index daadd0de77a9..019cdb48e254 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18723,7 +18723,7 @@ M:      Casey Schaufler <casey@schaufler-ca.com>
>  L:     linux-security-module@vger.kernel.org
>  S:     Maintained
>  W:     http://schaufler-ca.com
> -T:     git git://github.com/cschaufler/smack-next
> +T:     git https://github.com/cschaufler/smack-next
>  F:     Documentation/admin-guide/LSM/Smack.rst
>  F:     security/smack/
>
> --
> 2.38.0

-- 
paul-moore.com
