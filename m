Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D563561D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiKWJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiKWJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:25:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761917417;
        Wed, 23 Nov 2022 01:24:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b4so679770pfb.9;
        Wed, 23 Nov 2022 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUxMWImFdFlFIDOsCEiIbn33y9KXI+sgMRS7gd08XCc=;
        b=SPKnNkM3UoDe6C+kiqTEwh+QimzFLMn0A1LJjNzD/Exd6JKDBm+ubEFhJANKMMYJ3n
         noT8hlInwGISr4G6CiEahZhsh7RroNaZn7UfXDsKWtE1jsLva57fbOgzjcDzRGN69D0h
         OVdy+wXU5/UY0wDwV6D9cCJBNnrkwz1mzPWQIO0xMi54d5UaP2rAGASNJZCR4G6cXGnA
         hVF/e89azTZje+O5I89YUmqZ8AYe6dHAdXFbxJ+8h0R9SL4qiabUAKiAxE0IkafKce3k
         23zbYmFR32Zuqb7hBZs6X9PhZI1619ktfIJc2TYisHsnCNgSs6f1E7df4cGq3wbxrJAU
         5YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUxMWImFdFlFIDOsCEiIbn33y9KXI+sgMRS7gd08XCc=;
        b=61xRYL3ZFA16PunqttCp9dgI19IXSHPGi0f33PCMitwLFIeT0EJYxLhgkXjEMRUVvV
         4WlMrDeBDP6iZ2j9xUICdt8RbzX5wrBuaQR5IBlXbzBRBIH0jnxvRV5iXAroWQ/gr5mJ
         G5LTHQ2ssfboYWKzPaYYrm+rLiBheHR1WiWyYnLL2zYBkVADKAwTAApL5uhXziaDhRbl
         esNei+31ASepGU7rJ26Iv4/47H1iNMEjLpNlAEX87Ix/qzbIKSNHEvIORkGBOylp42ig
         lBZbMU6b/6WE6DLFVh39ONFLgNj/SiQ3D/Lb2lP5PuSqGAxZZX/RKG1lnm4aZ9H08ZUw
         wWaw==
X-Gm-Message-State: ANoB5pl+/S3AVJH+SBgJ01QJAvJuhnCHijybtBbYLFBoes2Zf6Rvp8aa
        AQ19hyXpS1R+9fxOPvrVV2UJP97oddTp3XClZPI=
X-Google-Smtp-Source: AA0mqf5HYg51oCkzTJ1zaC5Ac1wFnubNUWUChJon4uOPQ1vg2i7wbWSyWM/3nLNe7Z5gaUZROV7ECIihFH8LDIZ/kjc=
X-Received: by 2002:aa7:9af5:0:b0:56c:b5fc:9167 with SMTP id
 y21-20020aa79af5000000b0056cb5fc9167mr9451242pfp.40.1669195475987; Wed, 23
 Nov 2022 01:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221116214655.1116467-1-robimarko@gmail.com> <20221123023027.487A7C433D7@smtp.kernel.org>
In-Reply-To: <20221123023027.487A7C433D7@smtp.kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 23 Nov 2022 10:24:25 +0100
Message-ID: <CAOX2RU4xzOH_EHBWvA86L5Agmyvub2Uu1dpgQBiWmnx26hYN_Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qcom: ipq8074: populate fw_name for all parents
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 at 03:30, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Robert Marko (2022-11-16 13:46:55)
> > It appears that having only .name populated in parent_data for clocks
> > which are only globally searchable currently will not work as the clk core
> > won't copy that name if there is no .fw_name present as well.
> >
> > So, populate .fw_name for all parent clocks in parent_data.
> >
> > Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> >
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Add fw_name for PCIe PHY pipe clocks as well
> > ---
> >  drivers/clk/qcom/gcc-ipq8074.c | 52 +++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> > index d231866804f6..8374cc40915a 100644
> > --- a/drivers/clk/qcom/gcc-ipq8074.c
> > +++ b/drivers/clk/qcom/gcc-ipq8074.c
> > @@ -680,7 +680,7 @@ static struct clk_rcg2 pcie0_aux_clk_src = {
> >  };
> >
> >  static const struct clk_parent_data gcc_pcie20_phy0_pipe_clk_xo[] = {
> > -       { .name = "pcie20_phy0_pipe_clk" },
> > +       { .fw_name = "pcie0_pipe", .name = "pcie20_phy0_pipe_clk" },
>
> Is there a DT binding update for these firmware names?

Hi Stephen,
I have that name documented as part of series for passing the QMP
PCI output clock directly to GCC instead of global matching that
I wanted to send after this and PCI fixups were merged.

I can change it to match the global name, but that is a bit confusing
as pcie20_phy0_pipe_clk is actually from the Gen3 PHY but the GCC
driver was made for v1 of the SoC which was pre-production and then
it got updated to support v2 which is only supported so the name stuck
as it would break backwards compatibility.

Regards,
Robert
