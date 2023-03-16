Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAED66BCD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCPLJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCPLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA964AB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA5FEB82105
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D45C433D2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678964986;
        bh=VfPC5VKx2oVWtngJw76NtBCJ44uq8j3AAfOFLh7Nvso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ot1uiIqCRdvbzUCUvor586j2NbaqealDUs/54l3q38YibKgzGjgWgtM6SrmT94Xef
         UjR0FcucXSghxtO+zFLUT/K5cOAGJyKP0SjIFlBY4gPK6XbZfwIasTM52za0QLh6E9
         DGwE1mm9HOKG43pPPbk7aCDPzhwP6ck54Nl/aObd8+vTQf0ogdCcmCntXrvm2pjFEe
         xhvNo0ldz+uRPnoeUJYI4qHLS5/iWLTkI+w+BaPiTM+buF4IopmCvu6JDdbgRx+7Ll
         ZITHZfj2ObpatIchjL1Ql6SoqNzwcpJqD2EIYsPaeSO1VXTeAac9+zID1etwC+CA4B
         X8IaM/pdCXGgQ==
Received: by mail-lj1-f179.google.com with SMTP id z5so1226699ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:09:46 -0700 (PDT)
X-Gm-Message-State: AO0yUKWWjgqxcJX0qCWIDNf3bnUPTj3bJI3AEpa/VdGbdgxbJNl2waC/
        z0/KTwkZK5pN5EEWceCzCpQxkaRiTbyhZPLbvQ==
X-Google-Smtp-Source: AK7set8Uait8tPk1OmPFdx09+OFJ8l/Lh1GbWVJppjXlK8js1MN+hKB5QFvJbeFyKKPywkVWSqe/eCCX6VpDoroIM1U=
X-Received: by 2002:a2e:a30b:0:b0:299:580a:9473 with SMTP id
 l11-20020a2ea30b000000b00299580a9473mr794092lje.10.1678964984542; Thu, 16 Mar
 2023 04:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230306080659.15261-1-jason-jh.lin@mediatek.com> <490e5a70-885d-4214-c6b4-91ddd59db883@collabora.com>
In-Reply-To: <490e5a70-885d-4214-c6b4-91ddd59db883@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 16 Mar 2023 19:09:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9snhUYJ7Ox7w9-efARjToAa0ZaXDzQOMfFSuPEmuz-rw@mail.gmail.com>
Message-ID: <CAAOTY_9snhUYJ7Ox7w9-efARjToAa0ZaXDzQOMfFSuPEmuz-rw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Change mmsys compatible for mt8195 mediatek-drm
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2023=E5=B9=B43=E6=9C=8816=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:0=
3=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 06/03/23 09:06, Jason-JH.Lin ha scritto:
> > For previous MediaTek SoCs, such as MT8173, there are 2 display HW
> > pipelines binding to 1 mmsys with the same power domain, the same
> > clock driver and the same mediatek-drm driver.
> >
> > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> > 2 different power domains, different clock drivers and different
> > mediatek-drm drivers.
> >
> > Moreover, Hardware pipeline of VDOSYS0 has these components: COLOR,
> > CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture Quality)
> > and they makes VDOSYS0 supports PQ function while they are not
> > including in VDOSYS1.
> >
> > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR related
> > component). It makes VDOSYS1 supports the HDR function while it's not
> > including in VDOSYS0.
> >
> > To summarize0:
> > Only VDOSYS0 can support PQ adjustment.
> > Only VDOSYS1 can support HDR adjustment.
> >
> > Therefore, we need to separate these two different mmsys hardwares to
> > 2 different compatibles for MT8195.
>
>
> Hello Chun-Kuang, Matthias,
>
> Since this series is ready, can you please pick it?
>
> I would imagine that commit [1/2] would go through CK and commit [2/2] go=
es
> through Matthias.

[1/2] has been applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Thanks,
> Angelo
>
