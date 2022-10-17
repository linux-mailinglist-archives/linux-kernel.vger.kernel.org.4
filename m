Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04C600B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiJQJtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiJQJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:49:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042845E661
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:49:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so10448787pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiNO2iX3w6Ebqf5hgxwoC6O28Jx095niafyH75mMHrI=;
        b=5z3Ma+XTzjMI+JItfQQcn270o1heB7RXNi7BZIXHmEafQSvh8SX105c4RQ7XMSSQmU
         6AbNP3D+rnITcplb+TUktMna2d8BMYET4eWeLj1GQzZljJ9foV3LAd0AWBe/8xKPONYi
         zO34m+fmuDDesmWI0FhSc+5re79ZJgmd2lPQAMtX4dGphYEuTzaqEp+ULt8AbC5p9qgS
         L3mJBwe2XU3mhKYOjmdT9e2foMU7x3KF6cwtMISQ8CBGR5JsL0ym9TC6IacwzDsk/Q+Y
         bYvtKiLcGutGQ75YWlolse3qmnwva/LXbO/YgNBENmS4Ei41wv5siSw5A5cP6k4B4FYu
         9bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiNO2iX3w6Ebqf5hgxwoC6O28Jx095niafyH75mMHrI=;
        b=k2FJlN5AWzGoCTKo7JX3snQVamf5Tb+YO4V9SuLxNVIfjsB0GCSKXCt1DGrR74DIM4
         0KtpZfkPgLzlvAzahCZ1WKMgcR35Z1YNF5UqsCtlgXafBvDcZ5DPlrXIWItsqHHOTsPV
         v/zvjMJk6chvNi814+gOTPRSlFQkzjiAL4+8Vow7k+P8dP6hH/lb8wbzMOltz0C9VHaV
         zdTJBFSRxC95S33HR0a7a0iNYOXDD7wZoCxPQjbzFZNkFhQ3mZ2FHq0hX27KdXh2qgKO
         QNpLP1dZo2G597vmqZvDVByeop2whn7ZPhuVz/FiWO9nuOyU3+qha7nLpfD0qKUAMHfN
         Fa4A==
X-Gm-Message-State: ACrzQf3M4A5MdZB9M8dtk63n+t859z0qH5dNLiQBJnhq0Nh+NKwcKYlV
        ScGlC2V35p80TMQMJwy/SUe4IDhxaWjFaEyAqWxZ0g==
X-Google-Smtp-Source: AMsMyM4jnANCd+NmgqUcAiPWiBfoXMuHaRQexECzurlEDbdLyekl/kxpsxBQHDF5VqOg0aS49ip8tGs4YIe0TxYZCaI=
X-Received: by 2002:a17:90a:460d:b0:20c:1147:bf32 with SMTP id
 w13-20020a17090a460d00b0020c1147bf32mr31749482pjg.24.1666000141979; Mon, 17
 Oct 2022 02:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com> <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
In-Reply-To: <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 17 Oct 2022 17:48:50 +0800
Message-ID: <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     David Hildenbrand <david@redhat.com>
Cc:     songmuchun@bytedance.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 16:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12.10.22 10:15, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >
> > implement these two functions so that we can set the mempolicy to
> > the inode of the hugetlb file. This ensures that the mempolicy of
> > all processes sharing this huge page file is consistent.
> >
> > In some scenarios where huge pages are shared:
> > if we need to limit the memory usage of vm within node0, so I set qemu'=
s
> > mempilciy bind to node0, but if there is a process (such as virtiofsd)
> > shared memory with the vm, in this case. If the page fault is triggered
> > by virtiofsd, the allocated memory may go to node1 which  depends on
> > virtiofsd.
> >
>
> Any VM that uses hugetlb should be preallocating memory. For example,
> this is the expected default under QEMU when using huge pages.
>
> Once preallocation does the right thing regarding NUMA policy, there is
> no need to worry about it in other sub-processes.
>

Hi, David
thanks for your reminder

Yes, you are absolutely right, However, the pre-allocation mechanism
does solve this problem.
However, some scenarios do not like to use the pre-allocation mechanism, su=
ch as
scenarios that are sensitive to virtual machine startup time, or
scenarios that require
high memory utilization. The on-demand allocation mechanism may be better,
so the key point is to find a way support for shared policy=E3=80=82

Thanks,

Albert

> --
> Thanks,
>
> David / dhildenb
>
