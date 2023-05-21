Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C550970AFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjEUSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:50:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB0B6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:50:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94ea38c90ccso38609666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684695006; x=1687287006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI2OZ0N4nxc5zSXdubBHtpF/Q49iYURNNqXU694p3gI=;
        b=iJUtLlz5l2yY4W2Re17UxWiap3Yk4g6Se/jwUmS7mex83jT0BK0QWnAejk9d6pysh+
         0NsU3wKaPCiP7rC0YFVYUpnRgV0eqqLE44EzlGxjuWrQlCVpLMUfqf9uxLUq4aO9fr5u
         ZNNMdgAfzbD4iqgAdjhTHNGPmSXgC6Ok7F0qeLUyVhbOe7eBLSYXLvNrGw4W5pXNO63E
         ryLkJNHtNHilhOZQmMqA03levPKW7brOya9nFz4hCkn0+V6HawNkv9U0V7oBUFWVCvmo
         iRspEbjelQA8vOvEr3GXD+p3wBF8hPOjLyhgc87V9CcnL+E9XVjhoXBhmtEBxPhz0kWm
         rTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684695006; x=1687287006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI2OZ0N4nxc5zSXdubBHtpF/Q49iYURNNqXU694p3gI=;
        b=E4SMNVbfEDdCyAswdj+g3jBc302ulTSxm9BRKn/H+qMKqaxnJoMSQsq1q6QLUn2wKb
         41bFXqoTTfrXq43x6U1ErxgTWi6V8bjED7J/bCE2kah1x4aF9aZjcEN1pmIKHKWrvt4G
         sXxQUkV46Fd3twmMqzmdpKrjhXuT9GLc4FPUoyg281DlPesFGqNhoHFCkPFqOyRap3wQ
         ndwGNTSVN2edJO+gTQd6VY0JuhqeSiAossET54wwsvk+oed06GJe7DsSviIEbgDsyphy
         5wC8x4oCWAtbhutEpXtKZ86dXBua4u4W89UH+LUGQyExyNJz4ioJSJ4h+dMqN8zQtqZ6
         teVg==
X-Gm-Message-State: AC+VfDwLJ0I1BpAkmZ6YKxIr+u4ciXoD4m/cQFeOi0ZUiFKaSgMv6/1W
        TsgwyXVSb6+ld/czuFStMImmr5bdoDlQw4KANwc=
X-Google-Smtp-Source: ACHHUZ4MWtCIpB7vMXxMrX9K8FrnFSbCfBYgMsPz4RrWJaYDSByS43l7zvDsy/zfh8ijxApdqiH8sX8WOlilJXWcQ4I=
X-Received: by 2002:a05:6402:4307:b0:506:c24e:667d with SMTP id
 m7-20020a056402430700b00506c24e667dmr7006173edc.4.1684695005838; Sun, 21 May
 2023 11:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230509183301.1745462-1-olvaffe@gmail.com> <CAPaKu7TqUt1L-5RUuwEagr2UUs8maOO+FSoS2PEoP9eO1-JJSw@mail.gmail.com>
 <CADnq5_OsGqg7CoNVgtgr91a+pyBtJzoUOBXHKmGMcOM9hLFkwQ@mail.gmail.com>
In-Reply-To: <CADnq5_OsGqg7CoNVgtgr91a+pyBtJzoUOBXHKmGMcOM9hLFkwQ@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 21 May 2023 11:49:54 -0700
Message-ID: <CAPaKu7SQ0NkDVN3NNRoJxGRQ8x2T2uXcxZJEkt7g2CkEzVU3Sg@mail.gmail.com>
Subject: Re: [PATCH 1/2] amdgpu: validate drm_amdgpu_gem_va addrs for all ops
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        amd-gfx@lists.freedesktop.org,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Mukul Joshi <mukul.joshi@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, May 18, 2023 at 1:12=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, May 17, 2023 at 5:27=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wro=
te:
> >
> > On Tue, May 9, 2023 at 11:33=E2=80=AFAM Chia-I Wu <olvaffe@gmail.com> w=
rote:
> > >
> > > Extend the address and size validations to AMDGPU_VA_OP_UNMAP and
> > > AMDGPU_VA_OP_CLEAR by moving the validations to amdgpu_gem_va_ioctl.
> > >
> > > Internal users of amdgpu_vm_bo_map are no longer validated but they
> > > should be fine.
> > >
> > > Userspace (radeonsi and radv) seems fine as well.
> > Does this series make sense?
>
> I think so, I haven't had a chance to go through this too closely yet,
> but amdgpu_vm_bo_map() is used by ROCm as well so we'd need to make
> sure that removing the checks in patch 1 wouldn't affect that path as
> well.  The changes in patch 2 look good.  Also, these patches are
> missing your SOB.
Indeed.  kfd_ioctl_alloc_memory_of_gpu, for example, does not validate
va.  I need to keep the validation in amdgpu_vm_bo_map for it at
least.  I guess it is more ideal for kfd_ioctl_alloc_memory_of_gpu to
validate, but I am not familiar with amdkfd..

I can keep the existing validations, and duplicate them in
amdgpu_gem_va_ioctl to cover AMDGPU_VA_OP_UNMAP/AMDGPU_VA_OP_CLEAR.

>
> Thanks,
>
> Alex
>
>
> Alex
