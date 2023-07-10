Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BECD74C959
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGJAzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 20:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:55:36 -0400
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FACEA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688950535; x=1720486535;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=byXT/xFmqDD+CZsNnq9g4TTQ5FLhdllwCHHpJVlkyxA=;
  b=G71rgdTSOUJnfx1qrFp6rM9Djzfmg+XLTQzmYJiesOGkvNWdPx+H9ifo
   /kNXf7br6sCW2HWOP3hRi2LBPfGvEmaN9H+3jr15QvNJRk64KyMwXrpqx
   L3gIZsi8Rp4ZWuChobvjCPlWqmm02a37ftbp6fZgfNAbFjcs7nVva8+q/
   Xy4vEEt12N78tTpAidZ+NYSuzljlXX4vpZzDPFsWFOjBM6lWPZ9HZo8ah
   EPhYB+fTeEzdViF2aEa3JT7FuSrASE6CBJvdM2MMhXv4+qpr8uKOpZrBM
   DBVvD1IVzmPrL1igw/G0lp8jVJ/enkhm/HS+0nf5hy2tofzzi1I/fY0bg
   g==;
Received: from mail-wr1-f69.google.com ([209.85.221.69])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 17:55:34 -0700
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so2728613f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688950533; x=1691542533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCDKDJuhMe/luM3VFI5ib+K9xMOi0C+lL24R61nDELU=;
        b=E5yAXUur4ozLmLijl5wf9gsUVFry5Mi0buAfkkuxU82pMwaEK+nEGz82sa1z22nFTy
         0lpTFvX9C4wxp3OJSS3qu5i3WphSDO3hRNERLr6Qx0iHQuPodZxlxgLrDoMh1TY802Zc
         UKVKywJVkXqSjMCyFwhF03VBq6XtA1iRWSzSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688950533; x=1691542533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCDKDJuhMe/luM3VFI5ib+K9xMOi0C+lL24R61nDELU=;
        b=EmJM+geVX+m6YRd1JcMWuorIUhUJHvEANwbdGtz2NWcwPRinelNwBm9G/nwrHrQ73e
         Rq/OTRj8ggho2SGhxhsut2fpEwYRCCpmCWFdNJL2NwTZLhmgWVBAcglmqy5S7DHWTqSh
         j8nWL6/+JTkOLdfFe3TPOGPN3bJivb0688efYwCL9/WPZ9QJKGm5V2b01eaK6omNkfZA
         0R/OLOFNvgn9qLdI0QMXFBsQk+GyS3BKt1ysslQ0EQYreUOlUZyJ9zLwX2N7p4gew+Ju
         afxWlOH9ST6C+becCsrLyP0kPo43H1ybvs7VN8HmEKwls8SLAJMnJLVUPwtCsn+qzjEn
         GevA==
X-Gm-Message-State: ABy/qLYJrsX0mQ0eX/vwFgnOOZOVXfe+YwdTMm4jKLtGNdzscxnNjYoT
        JI6SLkeOOSnYRgl5fbyb5n6bUSSPyiMJBN/PDlO5OyjTi5QulJ/Fiv0T8Q8XDT6noJmg8PpFHJ4
        nzzVP/lhNLq/rMNnwV4j9II7GSViRTS3Wg+CsXmInXg==
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id a13-20020a056000100d00b00313ef246ff2mr12720809wrx.2.1688950533265;
        Sun, 09 Jul 2023 17:55:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF77PbPgC2orYPAxraE+vB+6gHcJRG+ezUH+qNiru1V7ZNzxhdB+WTVUrRGi5UhCucCnyJwvy3hOvQxpdaOpKo=
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id
 a13-20020a056000100d00b00313ef246ff2mr12720796wrx.2.1688950532984; Sun, 09
 Jul 2023 17:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
 <9fff2b17-0b66-93a0-87aa-ca6479cb0663@intel.com>
In-Reply-To: <9fff2b17-0b66-93a0-87aa-ca6479cb0663@intel.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Sun, 9 Jul 2023 17:55:22 -0700
Message-ID: <CA+UBctDVMXGcCi1ZVepNCGSZvhw4OR8fqWOOQjLkOQ6NXNAnJA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ethernet: e1000e: Fix possible uninit bug
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
        "Edri, Michael" <michael.edri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think u16 phy_data =3D 0 would not hurt us.
Let me submit a patch which just initializes u16 phy_data =3D 0.

Yu Hao

On Wed, Jul 5, 2023 at 8:47=E2=80=AFAM Neftin, Sasha <sasha.neftin@intel.co=
m> wrote:
>
> On 7/5/2023 03:10, Yu Hao wrote:
> > The variable phy_data should be initialized in function e1e_rphy.
> > However, there is not return value check, which means there is a
> > possible uninit read later for the variable.
> >
> > Signed-off-by: Yu Hao <yhao016@ucr.edu>
> > ---
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index 771a3c909c45..455af5e55cc6 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
> >      /* report the system wakeup cause from S3/S4 */
> >      if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
> >          u16 phy_data;
> > +       s32 ret_val;
>
> why just not initialize u16 phy_data =3D 0? How did it hurt us? (legacy)
>
> >
> > -       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> > +       ret_val =3D e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> > +       if (ret_val)
> > +           return ret_val;
> >          if (phy_data) {
> >              e_info("PHY Wakeup cause - %s\n",
> >                     phy_data & E1000_WUS_EX ? "Unicast Packet" :
>
