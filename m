Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E26B14C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCHWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCHWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:07:25 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3588C0DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:07:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p20so19040581plw.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678313244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQb53TQ7jWjrEo8sZG9DhLdkMLNjitlbjL6y90s2PWY=;
        b=WNYUrIdGov1iosyvhxsB05hEOX1arj5iNydmRhSR05hYSii/ViznbO+kJ+b21SXEcZ
         nGPIXZ43YPKacoug3TO8/A1TBv51suiAGU9zZkGJiy24nAson5EfbbJHsSrG0Y4H9176
         hQyrLAicG27qJ2ZkYvl6unImMvE14J24MOR4UmxNlK6bclU4dbs2FQ6ObngCi6yXsbXu
         zZDAjX5cp0MtuHB5dGEzrZUyEVBUZxIATdVmRs8XFoGo/dQYwReRo06xYlbKQCc3Q/yi
         xhyaB4Nl3zf6HngiZgGeCRTTww+ATRf0yCOLTQjX+YnvL8WoTbC/+c+Nh2nEuiHkVWCV
         KxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQb53TQ7jWjrEo8sZG9DhLdkMLNjitlbjL6y90s2PWY=;
        b=JbVIshuqC5B8z9eqnDQrv3hsrAfZoFCn2vUHqtkBnCzWaCkhNli6NaxsunsTQ16l5M
         eYbBCLRyQkHxnu48dGs/s7kPVqpQEcbUxr15xVRTJofQCJ4VG12+1proLVIR4ewcxNhr
         iTU0ly/wF7viPnr2519URolOB6uk02CBpEHYcbFJjpHIHtTTlWPKeMv9bVfFKcvaABJk
         ThkCS7aXpiZ38Yajj/3TseLiRq0nPnVWevhqVWqgWxvWX3wEFGDDYf9vFqw726q25Ykn
         dxG6xf18Z3BLHwNHtaOfLEAlQqWH53SfKHjAN2jl3/ES5+mqlHH7bATYct8AyMbd9fyn
         02wA==
X-Gm-Message-State: AO0yUKU6MMrAppnc5ON4bOGXZj74mkWz5fdshmbyLVMfeCXX+pbbUw+P
        EgPtFpPndBWDBFXg0ySWtbifZtmHDFQyzPQciBjf
X-Google-Smtp-Source: AK7set/uRNoQjUWqSPoMNt4AAqS3kc6Wxz67c+jaYkuinhju+8pfMGgIn7RSzk0NA4o02KGBfzlRWxZ3MCnbIQ14WmM=
X-Received: by 2002:a17:903:4285:b0:19c:da35:6699 with SMTP id
 ju5-20020a170903428500b0019cda356699mr7579863plb.7.1678313243799; Wed, 08 Mar
 2023 14:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20230304072923.286534-1-kamalesh.babulal@oracle.com>
In-Reply-To: <20230304072923.286534-1-kamalesh.babulal@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 17:07:12 -0500
Message-ID: <CAHC9VhS_uvWRK+AuvoDLrAJrbjWNmnnC2MLaBnMpDEFv_y-zkQ@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Fix typo in devcgroup_css_alloc description
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 4, 2023 at 2:30=E2=80=AFAM Kamalesh Babulal
<kamalesh.babulal@oracle.com> wrote:
>
> Fix the stale cgroup.c path in the devcgroup_css_alloc() description.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
>  security/device_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/next, thanks.

> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index bef2b9285fb3..7507d14eacc7 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -216,7 +216,7 @@ static void devcgroup_offline(struct cgroup_subsys_st=
ate *css)
>  }
>
>  /*
> - * called from kernel/cgroup.c with cgroup_lock() held.
> + * called from kernel/cgroup/cgroup.c with cgroup_lock() held.
>   */
>  static struct cgroup_subsys_state *
>  devcgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> --
> 2.34.3

--=20
paul-moore.com
