Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7E74B97B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGGW0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGGW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:26:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA42128
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:26:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401e285a615so5157421cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688768802; x=1691360802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERPvct9F+gdPXMff8zw9isxkWp5br9C2rmUHZh0fgec=;
        b=YkW+I0EPtZZH1y4qcBZkBcpiYK9+S4n74L7CY2CZ+xZveGNYPzWxMJzISKdIzKQf+c
         Qi1rJySyuwTGziqyT5iCNCNAAu36O79mDh2ocu7kAxXb2YjBvPftnv1vtmBKO1qp03o8
         ZThKoHjNQ4epnJ7sJj1A5SfZx1gqlJKyNz4IDhNHp40CYqTI6Od4Vi0BDH6GgHrPzmHR
         J1MNu/r8x3dX0ZMd7s5jqsdFqM2E5xsBHIamMCFl8FxDEyRDk1ICP6o2IdA0Gl5v2o1F
         otEoICtnek/eVZ2iGL/G4y22bwJBiclJ7rxQytZVRXtkE9F9YqthFgAFfjQp8FCPCyMg
         NLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768802; x=1691360802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERPvct9F+gdPXMff8zw9isxkWp5br9C2rmUHZh0fgec=;
        b=elIthTHgR3rIBITfHlc8pkjLDJVyVBKF6CiutstyXMXtwcJu9Z8wLy/KF1v0acVdEC
         HsXGh02Q81Dd9XaMlOJut1WMhD6l9hrRmXD3hEgN8y27RN+ePZWmLFktCqx2MQ1gnnuG
         vw786uq0X5tfmqAAYBaevJdLznfO1Rw6QWumwj+IQUw2lC665oKB9FxX6F6PskTu+btJ
         trbc78A7kYs0VNMvDPJkRp/sGmeYDisO+h2tFpMzLaGFXWv2EJtM+drvP/V1POgjGo6k
         BYavMNgdTguAZGiKbsv71Gh4NsAPA3c1tMjw2ovel/rbAQKRMlBeep/jatrTxlk3csO7
         MRig==
X-Gm-Message-State: ABy/qLblgvEi3K8tOS7rInOD2qEXwb63WVn80bTWOkamd+bNpY25iYEF
        q4P+iZYBvCFwusZKYLYM//4yrZyUY3bXh8K/9x46fw5G3sQt8Y/s3G4=
X-Google-Smtp-Source: APBJJlF1jFXvxyTjjffEw9OCYrfWavrUWjtRagAx3ar4G/YT3YK9BR5srT+MOnZwvvnV6tgTBK6QNUnzBvfmpxRkmp4=
X-Received: by 2002:a05:6214:ac8:b0:621:65de:f60c with SMTP id
 g8-20020a0562140ac800b0062165def60cmr6658128qvi.3.1688768802285; Fri, 07 Jul
 2023 15:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN3LS2mvXOe5g8WFC=b3N=bF1u4RCQYJN-u+k=ZEWWrcA@mail.gmail.com>
 <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 8 Jul 2023 03:26:31 +0500
Message-ID: <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com>
Subject: Re: [regression][6.5] KASAN: slab-out-of-bounds in
 amdgpu_vm_pt_create+0x555/0x670 [amdgpu] on Radeon 7900XTX
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, Jul 7, 2023 at 6:01=E2=80=AFAM Chen, Guchun <Guchun.Chen@amd.com> w=
rote:
>
> [Public]
>
> Hi Mike,
>
> Yes, we are aware of this problem, and we are working on that. The proble=
m is caused by recent code stores xcp_id to amdgpu bo for accounting memory=
 usage and so on. However, not all VMs are attached to that like the case i=
n amdgpu_mes_self_test.
>

I would like to take part in testing the fix.

--=20
Best Regards,
Mike Gavrilov.
