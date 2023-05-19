Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAB709870
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjESNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjESNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:38:15 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF8AA;
        Fri, 19 May 2023 06:38:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19a16c8d70cso1375142fac.2;
        Fri, 19 May 2023 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684503493; x=1687095493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOs4suB6MnnzG1pHzOuyNVjRaMPdw2D6u8onPNTnXCs=;
        b=FyiwmVotfX881qqJXvXVr8I/37+f/EwH62uArJP45i32hidV08/PPKTbtCA1segTtl
         Hx6T37WppSRmIVsT4MffeX3QQ6S+L7jgBBuAo8bGdLfrZ+lWZj61nsXNkPTJsMUfBp9G
         LHKpN2iYIpOaQxuI9No2KfChAHa895xtaVzsxhiV65mlV0YQqOAwdThgl9KZubW2yjLN
         PD+zDW1g+9kj0seIQgnldZEvF76NrB6Zg7F/AtwQk2bQAoXrHFPtf3EyO7xjyP84NR02
         6xNptIJDgKLnmzPCd+ho7Zt9OVL0XX+mJ5W03ZsojX8dFWgH95rhq2TJ5Zt4yAw02LhY
         YI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684503493; x=1687095493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOs4suB6MnnzG1pHzOuyNVjRaMPdw2D6u8onPNTnXCs=;
        b=JESi/nIYdX9Sb32TNS8uUv9xOp4QSk36YSH613T3uSKBolQYD5Fv1ud2tJWV8WWLVf
         9oGNk7fURNHT3t2nm5MZ0Y+kjEkWI7AtluLoz940KYDtzBnp7YoiXwvuUnWy94EFs80L
         izqkkDNko8+rdoUN+robswJIY3YD2w4IMJ4puLqTovvf8ODIClcG3MeMZz80g/gtePMp
         gxpnXxwdh8x7BQIUlFMfSHfp1gL14NGnYz0SLG1blIGEjl+sRTOb4u0P1YHh27AbM/6+
         7hmFE1TLN8UQuMp0De22QAUTw/77SFT23qyA7fnM3SVjp5EBSRGJpwpPnajwLvAvTGqc
         YsSg==
X-Gm-Message-State: AC+VfDyEVAiyxRldWI70npLEEvCAGR8mKNpgNXxa0ZdQHPWe33ekEphV
        E79h28YlNpuWLC6ePoZlm/rq8yAtSKp1SMr58po=
X-Google-Smtp-Source: ACHHUZ4sz0CZP+JY5qG77XL/A750Zj2aQw9ysamuG3u/ML3pICVKykNXTg73YqKJ7Gsz2M8heIGluGdMNNlLCX8Yg1s=
X-Received: by 2002:a05:6870:a2c3:b0:19a:229d:3f71 with SMTP id
 w3-20020a056870a2c300b0019a229d3f71mr1250186oak.6.1684503493507; Fri, 19 May
 2023 06:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230519100608.7e836126@canb.auug.org.au>
In-Reply-To: <20230519100608.7e836126@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 May 2023 09:38:02 -0400
Message-ID: <CADnq5_NFvQgca9_YzY49-SpVRh51AQ9KfYOxOA0p1PTcxAx_ZA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 8:06=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c: In function 'amdgpu_ctx_init':
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:348:26: error: 'fpriv' undeclared=
 (first use in this function)
>   348 |         ctx->ctx_mgr =3D &(fpriv->ctx_mgr);
>       |                          ^~~~~
>
> Caused by commit
>
>   2458393a4e98 ("drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure")
>
> I have used the amdgpu tree from next-20230518 for today.

Lost part of that patch in a rebase.  Fixed now.

Alex

>
> --
> Cheers,
> Stephen Rothwell
