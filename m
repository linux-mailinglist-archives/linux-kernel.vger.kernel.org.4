Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED00F60283F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJRJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJRJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:24:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEFC47
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:24:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f23so13263962plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKnlUfrKHH6eOsaSmAJUO+I2fU7S/gAKrbUxCi3SJ3I=;
        b=I0hgQCxv1YK3Yx7MFIoanQtnbRRU/q/Y9nwkex3L3rTzpV5SrXcyGeV/YoETuDGWxm
         G9SDoKCYuz/Hj3Afo74j1JWjtWJJpRJdmpIbRsDQfBP+DpvWwqG7hBtvkUzwVES0N5HF
         A6RJP6ihHhRL8P48d6btxHJHMFVY5oPdhpem07EVYa5mxuFcfMtxhMPHlYl4MI66DQpX
         SD+iuorSg6VvYfvrtT3rubN77vmvFwxljc7G3hzsEoxXJyC0rfb6t2KtRsW9HceT81FV
         /JYxN9xn806WrlnJTrq3VQ7gtxfhHy1kWq/wgN0wrZ0qpFgPMwK6ABNEReJ0xrw57ZiA
         oeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKnlUfrKHH6eOsaSmAJUO+I2fU7S/gAKrbUxCi3SJ3I=;
        b=IcvhNZgR1vaRGyMJ5EDOit9XWcmntV3Cvp/VWzXwl32b4kcBy4Fmyeb3He4B0bv5S8
         XIhsGjxGctN12K9tlYeARMTf9YhwPMrVd4iLUuMju00vwMDPNsUerQUVCNvFWftplrfF
         Re5QMHwTYdBeGj5NwYpRMMSQgKeZnJm2aeoXMeVkGpbTFCsY2X6EoJsRxCJr9q1Zxsd1
         dKCzsu+q+hB63WhQ1NaBSuMbIvzq3L4Vp6zDWnusWFNzkdkG7ycJVovTuRI4lPJOx8Z0
         F83aj9binH8c/V3jKqhQfUqsmAbyOiEfdHrFMIkgdsJaJxYG4a97i59RdvHE7XIjT1uh
         F7ug==
X-Gm-Message-State: ACrzQf3EnwL99DZcXyFswSf5zMdcYHwRe+9YFZe6oDUBNuLY7fNMes4a
        wuMMEPXJXIQ65tlb2gyEMIquWMaj/nQ/MdhCsWX0bg==
X-Google-Smtp-Source: AMsMyM6Al+UeqXMjxbQCJZ1izxgxVdWd1ECaLrmokKJkXUMrTkefqJRBaUMrjKi1IV7vAPEotVrwTE9p2hL2gHSCHZw=
X-Received: by 2002:a17:902:ab89:b0:17a:67c:b9e9 with SMTP id
 f9-20020a170902ab8900b0017a067cb9e9mr2037192plr.55.1666085082721; Tue, 18 Oct
 2022 02:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com> <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com> <Y02YAyE1TnU6/dkA@monkey>
In-Reply-To: <Y02YAyE1TnU6/dkA@monkey>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 18 Oct 2022 17:24:31 +0800
Message-ID: <CABKxMyPtm8qHRMZfetUaanqVpLCL6cVC7OJ-bdgEedz=8YYdGg@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=8C 01:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/17/22 13:33, David Hildenbrand wrote:
> > On 17.10.22 11:48, =E9=BB=84=E6=9D=B0 wrote:
> > > David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=B8=80 16:44=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On 12.10.22 10:15, Albert Huang wrote:
> > > > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > > > >
> > > > > implement these two functions so that we can set the mempolicy to
> > > > > the inode of the hugetlb file. This ensures that the mempolicy of
> > > > > all processes sharing this huge page file is consistent.
> > > > >
> > > > > In some scenarios where huge pages are shared:
> > > > > if we need to limit the memory usage of vm within node0, so I set=
 qemu's
> > > > > mempilciy bind to node0, but if there is a process (such as virti=
ofsd)
> > > > > shared memory with the vm, in this case. If the page fault is tri=
ggered
> > > > > by virtiofsd, the allocated memory may go to node1 which  depends=
 on
> > > > > virtiofsd.
> > > > >
> > > >
> > > > Any VM that uses hugetlb should be preallocating memory. For exampl=
e,
> > > > this is the expected default under QEMU when using huge pages.
> > > >
> > > > Once preallocation does the right thing regarding NUMA policy, ther=
e is
> > > > no need to worry about it in other sub-processes.
> > > >
> > >
> > > Hi, David
> > > thanks for your reminder
> > >
> > > Yes, you are absolutely right, However, the pre-allocation mechanism
> > > does solve this problem.
> > > However, some scenarios do not like to use the pre-allocation mechani=
sm, such as
> > > scenarios that are sensitive to virtual machine startup time, or
> > > scenarios that require
> > > high memory utilization. The on-demand allocation mechanism may be be=
tter,
> > > so the key point is to find a way support for shared policy=E3=80=82
> >
> > Using hugetlb -- with a fixed pool size -- without preallocation is lik=
e
> > playing with fire. Hugetlb reservation makes one believe that on-demand
> > allocation is going to work, but there are various scenarios where that=
 can
> > go seriously wrong, and you can run out of huge pages.
>
> I absolutely agree with this cautionary note.
>
> hugetlb reservations guarantee that a sufficient number of huge pages exi=
st.
> However, there is no guarantee that those pages are on any specific node
> associated with a numa policy.  Therefore, an 'on demand' allocation coul=
d
> fail resulting in SIGBUS being set to the faulting process.
> -

Yes, supporting on-demand requires adding a lot of other code to
support, I have thought about this, but there is currently no code
that is suitable for submitting to the community.


> Mike Kravetz
