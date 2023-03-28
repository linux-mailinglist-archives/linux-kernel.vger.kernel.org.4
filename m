Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828C86CC0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjC1NZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjC1NYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:24:55 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A3BBB6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:24:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5419d4c340aso229037947b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntULfQJggmdaqbZLqK7ncFbPSNSEXt5TzQS/aFU/5Pc=;
        b=iLIlR3VysUqN2n+K7Rz9WKfCcJLSTSx4NXO9I1yXLrlfhLgH5+IkJOW/OExv+tAp2p
         KLwmq425It8H20dpM0ac09a+vLFQBsaodZP50nnSdn4NPSgU/FnP4IoWbe2linipSeqz
         gXPndO8BQ9boGvc7auVZsdo8oEo2nNNubeOewSk0lDqJmSYfpk9BL0NvDdeBZ/+eYbYt
         vCoep2rw0xDCxlAUelFlpn+OMs11ce2T2shwo+AdP9qIAH/gH8oGDJNKaJLz4JCsPJcy
         3O/lx+x7RQmoTNPuwkKIytNaDqU/QTxCL4tT2Daz/Dep3lWyEoL5WhB/cC0yuxcgmIG1
         Cdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntULfQJggmdaqbZLqK7ncFbPSNSEXt5TzQS/aFU/5Pc=;
        b=wqW+OcSkBZFR5g0sE+djwDK6o6EctzpceqGbvjghPPLm6rQnOfLb9b8hX3qK6s3y77
         Fp8z+Ut1t7pJ/rq5eA4tW0aQLi09J7eRb/SvHr+TKNAWTfIaPxxCxkbTUjK4YgPbR2d6
         V21TKq+vRhHOKyMTmKEtcheAl8ObdY+Ub+F1fj0dzWgQ1TSLV5Vv7QY4YnKGatl95rFo
         u7MU+GYj2N0N2NQJFUXVuzevQHz4WmQoMXY/AuVtghaZCRYCsgs/2HWFtpuOk3u2rAwz
         l/QwkQ/jvdvy+8uaC2PrA8aDZIAy4Nz2xv2OV/rA/nySpFUu7On6+MXQHlnalf+i+nBd
         inVA==
X-Gm-Message-State: AAQBX9d8xN4F/iM/+aDtJ2hMo8Qwcl5YcoQV8TiRm8+/zq+aA3A0JMPg
        wkKLqRKGZfsZlm9MPzOfbWCnvANL+EuFJssJP/tfXf31IZiAY8/C+nk=
X-Google-Smtp-Source: AKy350ZbQ5L3cvQeH+/uAiEzez0+L4i4KA3mwR2j+xMSO9YwlPgoHcvCiIw0v9a5U7lB87sYMPJen1Av3A82DPd1VBw=
X-Received: by 2002:a81:af60:0:b0:544:b8c2:3cf4 with SMTP id
 x32-20020a81af60000000b00544b8c23cf4mr7307084ywj.1.1680009887781; Tue, 28 Mar
 2023 06:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-2-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 06:24:36 -0700
Message-ID: <CALvZod7st5ZFZ317fJxV05Wa4yLYC53s6MwFS557ULEZx6EW=g@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> cgroup_rstat_flush_irqsafe() can be a confusing name. It may read as
> "irqs are disabled throughout", which is what the current implementation
> does (currently under discussion [1]), but is not the intention. The
> intention is that this function is safe to call from atomic contexts.
> Name it as such.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
