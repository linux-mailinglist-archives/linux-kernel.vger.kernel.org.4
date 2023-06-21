Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5797273829F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjFULqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjFULqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:46:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483371AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:46:43 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62ff3ee0ca5so11769926d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687348002; x=1689940002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKmjvZ24aJdHR1bdzRQxTNrzufTEY8kILc9JOoDk14M=;
        b=eMiKE2VwS2KmuUPH4gJXiHvgieWLDL4GVs8E7kzRp2U1YIKAnHeCvTdUHMjA68M7SC
         KAn4K8PENtVaC+7J0oroyQWb6bES1B0yGDMamSfaHs5oJDLlkpR9ZEWtogYDC//YrG8E
         PFSkCstcoiPrmoJRtkiGK9wjvy19ha7AQj4oZEtb82P69xO5W3neFVAdkeclKur+vEP8
         zgegRK1/YIv8gjw3KE4C7PlY5FAoxYIfBMxyIXD0I28kZuFzV7jMsCHdHoKN6+FW5YBP
         HdLwERQFCv+uqGgUkMWEt0R1dE0ppQq5TiZTcamPpCO/bgKlZ6YRw/PF5deD/pXh+FEv
         X8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348002; x=1689940002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKmjvZ24aJdHR1bdzRQxTNrzufTEY8kILc9JOoDk14M=;
        b=GJ0buAyzdZ9+HpIIWblE/IuAJInG0NurPTidrZKdLTcQiivNI933gqhPH4c6HBBqND
         GHgNV0k0ulyEMWIWROgfhBCo++p1+5AllmTI+oxvcWzHxaD9uM1VovEcjs0Q9oltR/Nu
         uWRqEbCBCRUTpkhUqhWCKtH6RqhRQh2Q+5AP2nk7yL2dqze+YYIQLtO+GO4kza+5i86i
         mA8KUL0hJkLnmS8+Ti285LwvbG3ge8tTkQm0+OnUizr/P8NWkm/H6S3IB6OKCc3YlaVV
         Gcu56K5kSDgoll/MqopvgYLAZmB5Iw/GwgDeh9M295oPpVSN672JShXTp55rhD2rzlN0
         9usQ==
X-Gm-Message-State: AC+VfDyS26yanyXuCJTAKMRaqoH+1LBmmLdDNAvMR/N2QBttvxcim4zg
        03j4OLtxvETBeXZNtViEPka9t3dK/bfhKD43/pQ=
X-Google-Smtp-Source: ACHHUZ4xB6P/YWDE2+izdYoWeA38aODQI96tFF30JsCUbilR3DI+SosDXP+qWI9Oo60qnfvL/DZBab4JdOvwDt78Yns=
X-Received: by 2002:ad4:5de8:0:b0:621:65de:f60c with SMTP id
 jn8-20020ad45de8000000b0062165def60cmr18455206qvb.3.1687348002251; Wed, 21
 Jun 2023 04:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM5TQpnGkk7pvmrwayDytGHszYm4Vz-UgFGDMERu3UGSw@mail.gmail.com>
 <DS7PR12MB63334DD6E7153A0BB89762EBF45DA@DS7PR12MB6333.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB63334DD6E7153A0BB89762EBF45DA@DS7PR12MB6333.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 21 Jun 2023 16:46:31 +0500
Message-ID: <CABXGCsOSvuHYXdBnptW=eYaN6QNKcW1q5cEQLAdOJZ4Nwu8=Mg@mail.gmail.com>
Subject: Re: [6.4-rc7][regression] slab-out-of-bounds in amdgpu_sw_ring_ib_mark_offset+0x2c1/0x2e0
 [amdgpu]
To:     "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 12:47=E2=80=AFPM Zhu, Jiadong <Jiadong.Zhu@amd.com>=
 wrote:
>
> [AMD Official Use Only - General]
>
> Hi,
>
> It is fixed on  https://patchwork.freedesktop.org/patch/542647/?series=3D=
119384&rev=3D2
>
> Could you make sure if this patch is included.
>

I confirm this patch fixes the issue.
But this patch is still not merged yet in 6.4 that is a problem.

--=20
Best Regards,
Mike Gavrilov.
