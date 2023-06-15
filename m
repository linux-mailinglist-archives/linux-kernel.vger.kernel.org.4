Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFC731924
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbjFOMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbjFOMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:46:06 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC92125
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:46:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b2e9c015d3so472050a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=constell8-be.20221208.gappssmtp.com; s=20221208; t=1686833164; x=1689425164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAhWnlZBkdO91/8vFM8fT8F4do+BSFxNrVt41AXDoto=;
        b=OxwFv1wf21aNqoyzeQWxzGh1yDdqEy8dF3pZ5ObtQbwejbO9PTFPJ7RwGKPQupeYRc
         iD1V6K+bKXJxYkDS3sq9W03vJuZZFgqMwv2cfE1IK3pEWwaZ/1mfhgzEGJww9F0RzLyv
         NSikgR5Lwu6qBtnn/TqBN27BchJAUI4BztNPWj3YCZAfGBfMMq+Eac23GpZWstY58Uso
         AaHfiPeylY+ncnIxua+4lhBjzp7MvVW3CFM4J4yP8y8jLrRBtJ+DrUDA270nnDE69Tlp
         Rk8oN8LezCh+pGBwD+NQGfTdc/qiXkq1Bnf3X7unq/li7ZLTO4CtOatrpf0/nZAPM5eL
         /MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833164; x=1689425164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAhWnlZBkdO91/8vFM8fT8F4do+BSFxNrVt41AXDoto=;
        b=bPQD8kap50cq1dE7WJtUcaXIn9cn3p7RyUuj3VvVmvXRlcXnHzZ/2ibNB/YFQlLDgq
         pJukr7HgZX4tFErPF2qwFWHArYLxinltr3U/Z1u3K/0RVvgbiNTbT85d0QWLVLg07YQr
         NXf0UluZ3TBbHei90MzvKFHepRBCuYgQ4axlmT/SVBMdqEe2/XgqfcmIroqqX1ojptel
         cKXT+pIgQabDRz9kWXwmjYDCdkIK2U632tI7YoR7NPrWyiEiJPdloMU3A3xUcx2V0DXQ
         WpCLtkhxte63eczE9l/XRNfejLbziBqAJSKN9c5qh/h+qOUGSfOIcqYoi4R79twTTCzI
         b6XA==
X-Gm-Message-State: AC+VfDxRQq9s1GrA2aMO8YE9NsjkSn67+Lpk+XkExAtox3FmwwosIsyK
        85hX/aDr8b+oBn+GTrH7lCPeEzwbyI6hBzslwEOHGQ==
X-Google-Smtp-Source: ACHHUZ7hMuZ4EaQdJXL2G/QFjU2ZncPgCI4wxW+vxAf1U6DMzIAq5Pd8M+JW8k6L4F1bvWMz0pEL/dJVAoF2PB2lIKQ=
X-Received: by 2002:a05:6870:148b:b0:1a6:8911:61a9 with SMTP id
 k11-20020a056870148b00b001a6891161a9mr2695495oab.29.1686833163860; Thu, 15
 Jun 2023 05:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230612075945.16330-1-arinc.unal@arinc9.com> <20230612075945.16330-6-arinc.unal@arinc9.com>
 <ZInt8mmrZ6tCGy1N@shell.armlinux.org.uk>
In-Reply-To: <ZInt8mmrZ6tCGy1N@shell.armlinux.org.uk>
From:   Bartel Eerdekens <bartel.eerdekens@constell8.be>
Date:   Thu, 15 Jun 2023 14:45:27 +0200
Message-ID: <CABRLg09hXm3=mca70TdZLuxA1d8YzOcWj31NvFG0ZWoStn_w9Q@mail.gmail.com>
Subject: Re: [PATCH net v4 5/7] net: dsa: mt7530: fix handling of LLDP frames
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     arinc9.unal@gmail.com,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 6:42=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jun 12, 2023 at 10:59:43AM +0300, arinc9.unal@gmail.com wrote:
> > From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> >
> > LLDP frames are link-local frames, therefore they must be trapped to th=
e
> > CPU port. Currently, the MT753X switches treat LLDP frames as regular
> > multicast frames, therefore flooding them to user ports. To fix this, s=
et
> > LLDP frames to be trapped to the CPU port(s).
> >
> > The mt753x_bpdu_port_fw enum is universally used for trapping frames,
> > therefore rename it and the values in it to mt753x_port_fw.
> >
> > For MT7530, LLDP frames received from a user port will be trapped to th=
e
> > numerically smallest CPU port which is affine to the DSA conduit interf=
ace
> > that is up.
> >
> > For MT7531 and the switch on the MT7988 SoC, LLDP frames received from =
a
> > user port will be trapped to the CPU port that is affine to the user po=
rt
> > from which the frames are received.
> >
> > The bit for R0E_MANG_FR is 27. When set, the switch regards the frames =
with
> > :0E MAC DA as management (LLDP) frames. This bit is set to 1 after rese=
t on
> > MT7530 and MT7531 according to the documents MT7620 Programming Guide v=
1.0
> > and MT7531 Reference Manual for Development Board v1.0, so there's no n=
eed
> > to deal with this bit. Since there's currently no public document for t=
he
> > switch on the MT7988 SoC, I assume this is also the case for this switc=
h.
> >
> > Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT753=
0 switch")
>
>
> Patch 4 claims to be a fix for this commit, and introduces one of these
> modifications to MT753X_BPC, which this patch then changes.

Let me chime in on this one, as mentioned by Arin=C3=A7, I am one of the
requesters of having this patch (and patch 4).
Patch 4 enables the trapping of BPDU's to the CPU, being STP (Spanning
Tree) frames. Maybe that should be mentioned, to be clear.

>
> On the face of it, it seems this patch is actually a fix to patch 4 as
> well as the original patch, so does that mean that patch 4 only half
> fixes a problem?

This patch then also adds trapping for LLDP frames (Link Layer
Discovery Protocol) which is a completely different protocol.
But both rely on trapping frames, instead of forwarding them. So
that's why the enum was changed, to be named generic.


> And I just can't be bothered trying to parse the commit messages
> anymore.
>

I do agree some parts of the commit message could be omitted.
Especially the part of the R0E_MANG_FR, as it just describes a default
reset state of a register.
But it adds confusion mentioning it, as it is not even used in the patch it=
self.


Bartel
