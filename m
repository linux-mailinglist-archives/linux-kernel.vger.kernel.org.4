Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8671F90B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjFBDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFBDyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:54:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8618C;
        Thu,  1 Jun 2023 20:54:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2566f66190dso1345264a91.1;
        Thu, 01 Jun 2023 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685678085; x=1688270085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFYRa2oit8Kb04mbuiimeCpNVm02GagiFFjOTHBNe/E=;
        b=DyjwxaLk7AueeisR6yISmADRKlAHBLdbHCQxJgnZxXyaRSC4Ln0ymZBuV5GNb8izsY
         BGgRFHURLha9A++oTaDl4vGKpLH3br3cColD7VPoRCL7FFmmQ9+thgITD2irfws1WyP7
         8z7kq2jO+Q1lqfanDHsw8c6o38bMu2Gv7dWKuEnKtAWBAON6c0cqANMkIkWgoj/La9im
         AgPIII4nTTAZofuQU0B5FcNGpzOg9Q3BETfrB6RZNzGYBOS25Ae8JUsQNwp7oKsq6qqH
         JIp6LFPKgHvj8pR5T2aUYszEbnwhSQQgZ9lqiRwAZqD5xjPaXoxNmbB5bQ3tj+LtzNsN
         BxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685678085; x=1688270085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFYRa2oit8Kb04mbuiimeCpNVm02GagiFFjOTHBNe/E=;
        b=OCiP3ukFtzLKs0pjo7HTHAKgON3LEjxkoiqiNjQNcNKe02pMnUbVukc4Vc/7FA9TpD
         awaylnuGoSwV+XnCKlHDMt2AOsLpnYWU3DIaYfcUKNjBj7YY7TtCKcs/S2PAqcEuZ6UI
         cwtZgYfVyZNCPyz/nwcpu/Hw++BKOtMpEhrpqxOmk2K7/kEDlf4gD4NR6SFSAKpjfUDM
         +jl/bQGJN5avwP1Iz2j8JjXwymFfbv8VG8R0+12IVZDsRTQ7+lbkohtkRY0bSbiVP4XY
         r9FLGkavbnAiR0V1udlLrIGfsxS8ceI0DaQD95BChkDQkSTGfZCy/lh+WkK2Ephnw83h
         AJAg==
X-Gm-Message-State: AC+VfDzcVKLKo1Dh2hqL8Y8+PG5sLZtQHmX6x/xW1db3RfiHVB0X9UaQ
        tZdFlBvXMdUhsTXZooVqNNS8pKMT+RyoUdp/IMU=
X-Google-Smtp-Source: ACHHUZ7bFV1KjjBpBrQzVDLhlCusRk+BBNxv53GfvPOJzwSHNjAxytFtkFPQE+TCkYjIZVWXIk2piLSrw5WZpmltkF4=
X-Received: by 2002:a17:90a:1d46:b0:256:bc96:45ad with SMTP id
 u6-20020a17090a1d4600b00256bc9645admr1073489pju.40.1685678085392; Thu, 01 Jun
 2023 20:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230531093206.3893469-1-victor.liu@nxp.com> <20230531093206.3893469-2-victor.liu@nxp.com>
 <bd257ed0-71a7-0504-0bfe-14775ac93571@linaro.org>
In-Reply-To: <bd257ed0-71a7-0504-0bfe-14775ac93571@linaro.org>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Fri, 2 Jun 2023 11:54:33 +0800
Message-ID: <CAOcKUNWkubMK1MJS73tpbm4bafQv2GAMuq_JOTFbvB9EVDRvxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add NXP i.MX93
 parallel display format configuration
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        conor+dt@kernel.org, rfoss@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonas@kwiboo.se,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        jernej.skrabec@gmail.com, robh+dt@kernel.org,
        Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        kernel@pengutronix.de, linux-imx@nxp.com
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

On Fri, Jun 2, 2023 at 1:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2023 11:32, Liu Ying wrote:
> > NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> > configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> > field. Add device tree bindings for the display format configuration.
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v1->v2:
> > * No change.
>
> How did you implement Rob's comment?

Should have discussed more in v1 about Rob's comment, but
let me explain why this dt-binding makes sense here:

Both i.MX8mp SoC and i.MX93 SoC media block control devices
contain a LVDS Display Bridge(LDB) child device. The i.MX93 block
control device additionally contains this PDFC child device.

LDB dt-binding [1] is written in a separate file and referenced in
i.MX8mp block control dt-binding [2].  So, for the sake of consistency,
it makes sense to keep this PDFC dt-binding and reference it
together with the LDB one [1] in i.MX93 block control dt-binding [3]
in future, doesn't it?

It seems good to have a separate PDFC dt-binding in case it can/will
be referenced by multiple parent device dt-bindings.

[1] Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
[2] Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yam=
l
[3] Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml

Regards,
Liu Ying

>
> >
> >  .../display/bridge/nxp,imx93-pdfc.yaml        | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/nx=
p,imx93-pdfc.yaml
