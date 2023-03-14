Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1586B98C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjCNPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCNPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:15:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A729150;
        Tue, 14 Mar 2023 08:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3267FB819CD;
        Tue, 14 Mar 2023 15:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C6C433EF;
        Tue, 14 Mar 2023 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678806853;
        bh=c2TJqS8W+B0g4JRj+rGC5PdEclNbRx9UA+lgQVe2LVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2UzzvZCQtUJxCwJIxMbgaf9po4rIXL/0aFkJlJaD70B+UREvcQro8eOsmGNsYtxV
         KxZ9D+PNa2ExtMsXwAxVPDjKGNX8otgwt7yuCOXaljYiyjYx7V3Y5c+Dq4v/cUKuXH
         7AcPG+7isz0k35q5A11zdLZz5JNSBL/lsKbczvuX91JRWdX0IEIukdC+A3tykwidJD
         gJQawPOm78rzQgKpzJtM3oFy6slizRk8+xsMsj8Z/FLnVDG7VKqs/xTAk0HTYgwUY2
         QYkiUvK6y12Xzuxc7SuwzEUshBjaTN3VRv8XNDRD4U9zS+OVnjUnkLQcIFYu6+Tkxx
         f1jjOc90hQp8w==
Received: by mail-ua1-f43.google.com with SMTP id 89so3969789uao.0;
        Tue, 14 Mar 2023 08:14:13 -0700 (PDT)
X-Gm-Message-State: AO0yUKXSUgKtysrJOZj5VTfIyR9u0/ss+ahOIH8gbD30TgV5bgerfqHc
        zSps15/CxwxA7dWRec8BwwtVcGbSJJzBeZdJcQ==
X-Google-Smtp-Source: AK7set/ZmpG1rB36/Z6MCiIR/CeMGhiVMZRwL1tUB2TwTqQhqEnpG0TTpKQTPTVQF6rP/t1ewB4wB2m1c7fBgd9nv5Y=
X-Received: by 2002:a1f:1d13:0:b0:401:184:339c with SMTP id
 d19-20020a1f1d13000000b004010184339cmr22537392vkd.3.1678806852681; Tue, 14
 Mar 2023 08:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230309233945.1199358-1-echanude@redhat.com> <20230313124923.iwaknvrnitqal3wa@ripper>
In-Reply-To: <20230313124923.iwaknvrnitqal3wa@ripper>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Mar 2023 10:14:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCM59bZakpq3sp0oR06Kv7aCN5LSA7tNwO-89Tx7SaQQ@mail.gmail.com>
Message-ID: <CAL_JsqLCM59bZakpq3sp0oR06Kv7aCN5LSA7tNwO-89Tx7SaQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
To:     Bjorn Andersson <andersson@kernel.org>,
        Eric Chanudet <echanude@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Mar 13, 2023 at 7:46=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Mar 09, 2023 at 06:39:48PM -0500, Eric Chanudet wrote:
> > ABL uses the __symbols__ section to process the DTB before passing it
> > forward. Without it, the bootstrap is interrupted.

No clue what ABL is... Put this in high level terms, "I want to be
able to apply overlays", not some unknown acronym and low-level detail
of how overlays work.

> >
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
>
> @Rob, @Krzysztof, it seems useful to be able to use the upstream
> generated DTBs with overlays.
>
> Do you suggest that we enable this on a per-board basis when it's being
> requested, across all devices, or tell the users that they have to
> re-generate the dtbs themselves?

It's up to you whether you want the bloat in the dtbs or not. Labels
become an ABI when symbols are enabled.

If it was my platform(s), I'd require the overlays to be upstream too,
but I'm just paranoid about the modifications people want to make.

Rob
