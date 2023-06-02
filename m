Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D819372072E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjFBQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFBQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:13:52 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094CE4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:13:20 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-653843401feso233184b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722337; x=1688314337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftaj+c92Xn+0VrlPMhENnH3kgEcuY1Ij1rlG3ylIX94=;
        b=SbHV/raSAqNb/ugGPvUx1HpfrpuTKrN34pcklzYzOiTL0F5uRwrctM9lJlVjcPhTyu
         3glByiMyzb2lNZVG7N3TkU67YWRAom6qiFJ3HwpdBGdq+7o0UzRsgDLA+mvenPfvIPZU
         +QjHcXFhlVKh81QqwlE54getp85UJALQXIroL6pIGM8IMdHFdfILNYGYn3IxK+BiCVKT
         J1nbKJkFdB3LsYb3eQGfdAfC/Vdn6HNCrTzp2mSOFIfAp3LSqXx0vC71IAjEICLagiaZ
         pDCoVvLs1fR5RlRMMP4ZPnjXRMiaurNZTh3CEuEA5xdhWHVToQCFKeIZ1O5CnFtxN2iM
         Sl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722337; x=1688314337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftaj+c92Xn+0VrlPMhENnH3kgEcuY1Ij1rlG3ylIX94=;
        b=JYcNing1+euWuHvqO3DM+N4Y1PzmKlH4jsR3Zq//CwQKNFS+JS1iGa9SkrVn5D43su
         a9MVLo5UV2LxjLOPet1z8LVIbeaMIGR7UoCwk4scl+tORLqUXkfcD6uhq83zpU8Ri6Sy
         opD56doINKW/F1qo/CkkwUtH0oWpLk1osW8ZjvcH9dZB9PS9UR2nxtZiHaZLisApD+kw
         kOvVXB8VFSI22qxts/vL+g4uN7j+NMo4ZE9Bq8Sl+WajN8oV2RcJT7bh7hBZp7JROK/X
         grY2JwRCsTDIcQBgwhpguB9LFmxKlAiaus6jr9SBUyOxWNMuxgSSxxXkPZXZO7+2IGy6
         +viQ==
X-Gm-Message-State: AC+VfDyehKx1sf4RySskaAn7R4kHBikrLY6yAG1y7iAlbYTj1HTKm8b5
        haKGQwVNW1MziISoiW0eAE1Kj5k=
X-Google-Smtp-Source: ACHHUZ7COymU82+/Vl32ll+Pu3rSqvalAVsy0BKHkj4J5EjAZEh22ie0WU8LSeyg/SXeoXTYWZoTS8w=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:234f:b0:643:92c0:5dd6 with SMTP id
 j15-20020a056a00234f00b0064392c05dd6mr4703194pfj.6.1685722337597; Fri, 02 Jun
 2023 09:12:17 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:12:16 -0700
In-Reply-To: <20230602030842.279262-1-gongruiqi@huaweicloud.com>
Mime-Version: 1.0
References: <20230602030842.279262-1-gongruiqi@huaweicloud.com>
Message-ID: <ZHoUyDMJ8xq7ENnX@google.com>
Subject: Re: [PATCH] bpf: cleanup unused function declaration
From:   Stanislav Fomichev <sdf@google.com>
To:     gongruiqi@huaweicloud.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02, GONG, Ruiqi wrote:
> All usage and the definition of `bpf_prog_free_linfo()` has been removed
> in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
> jited_linfo"). Clean up its declaration in the header file.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  include/linux/filter.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index bbce89937fde..f69114083ec7 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -874,7 +874,6 @@ void bpf_prog_free(struct bpf_prog *fp);
>  
>  bool bpf_opcode_in_insntable(u8 code);
>  
> -void bpf_prog_free_linfo(struct bpf_prog *prog);
>  void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
>  			       const u32 *insn_to_jit_off);
>  int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog);
> -- 
> 2.25.1
> 
