Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA5713AA6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjE1QoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1QoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F6EBB;
        Sun, 28 May 2023 09:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 718156112A;
        Sun, 28 May 2023 16:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5867C433EF;
        Sun, 28 May 2023 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685292245;
        bh=vPiEsXsxqj7FwfUAfRpELfdfg6c/BAZcopzWPbwiS0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=stZAK/UceGGE8mxKF1r5cxeJM4VpOnZKw3EDxoUjBcktWug8dL3J5uuhf9APdGiXW
         YWJxMAE2Gex+3Gql4fWAlY+u+B+QA95wuGHBKyAGKCaUhdcQ7j/9878RuCm3xJZuyq
         9mblZTmLaiDcXfcMX+BVlbSw9e+3+IpYxL3fSz/eLQfQroBFUGwOmeuRR6tOD7BJ6n
         z1cvCd04VBiOrIVvGYCzvkDnaPcXIeeetalQDY0QRLoFj2Fv5PIfNUI+F5wurn9mqJ
         admg6brf/SyUqsM1raw5sDZz6ihE4Holi+jU7rG+DriwvlJvQ2p5OEX4Ec18MCm+xZ
         PuLbDvCaZrTHQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-19f675022d8so106896fac.0;
        Sun, 28 May 2023 09:44:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDx5kVd0CDStob+JCZfrnvECd0lsY/FsVz9g/toM1V6i4/QJ7bnL
        UeVrMpPusNpGayh8Di2Q3l/jsSB2sXibgNPnd4o=
X-Google-Smtp-Source: ACHHUZ6bTTcpzvO5NDM8O8Jj8V8Y0z1KU+GLszgB1I8JpDBj1t3+imV/uQNhXtfn3Rnf9ShG+DpI9iYjyQHiOdyW78E=
X-Received: by 2002:a05:6870:e145:b0:19e:ae04:95ae with SMTP id
 z5-20020a056870e14500b0019eae0495aemr4433622oaa.40.1685292245137; Sun, 28 May
 2023 09:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-18-masahiroy@kernel.org> <CAKwvOdnv-=eXtgwuZ8URz_FjnUansgg3MeuGGRf2C=Wr+VGkrA@mail.gmail.com>
In-Reply-To: <CAKwvOdnv-=eXtgwuZ8URz_FjnUansgg3MeuGGRf2C=Wr+VGkrA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 29 May 2023 01:43:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-uraV=p6vDiPZJAX4DDHCA=OawWyabKDai6rtEOuvMQ@mail.gmail.com>
Message-ID: <CAK7LNAR-uraV=p6vDiPZJAX4DDHCA=OawWyabKDai6rtEOuvMQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] modpost: merge bad_tosec=ALL_EXIT_SECTIONS
 entries in sectioncheck table
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 3:36=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > There is no distinction between TEXT_TO_ANY_EXIT and DATA_TO_ANY_EXIT.
> > Just merge them.
>
> Can something similar be done for ALL_PCI_INIT_SECTIONS and
> ALL_XXXINIT_SECTIONS? (as a follow up)


Yes, I think so.


BTW, the enum does not have a sensible name.

Commit bb15d8db7cce7 should have added
PCI_INIT_TO_ANY_INIT instead of
ANY_INIT_TO_ANY_EXIT.







--=20
Best Regards
Masahiro Yamada
