Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF9721E03
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFEGVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFEGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:21:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947BDE;
        Sun,  4 Jun 2023 23:20:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75eb918116aso51833085a.3;
        Sun, 04 Jun 2023 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685946058; x=1688538058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFAORiJMTRPxVEgeh1ndTFRmu3jSfy3cuQSdwmDzjko=;
        b=EHIkgTAmvEZmMwuAmuxuTPnBbWnXpbEf5cvOvLV1l+4CdkBMC4sEnPA3GgIYwWC3NZ
         PAay1CpIBJ8jFUPXGTXHnwYnX+Vcz/SWeMQUymzqOTqLHFHVvuY65LLdD96K61BoyBI7
         TLPNd5qXpe428zvQcaVm9BrPU/oW2rxnz5LGabcIFqmUdJJDETcaBzA5wIRiDPkaRla6
         irpbQ5BTqg+o/prUzE4Lmj6zDZLTTpGA5mXdDNvvY0miZb0S3Se8M0YNVB/Afnr6Argp
         7mXeUwqxIOrJznYQ1Jc14SBOwcsOev536Zr/PU60E+WP3IVWzcGi93aOiPr9ljRz2tYt
         qx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946058; x=1688538058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFAORiJMTRPxVEgeh1ndTFRmu3jSfy3cuQSdwmDzjko=;
        b=ldtvf3Q0Hoac+nx8cmg0L20RdSJNBRYPZJbcrkvQtT/kAloT1iGJPEFQ/FdNB8Ja50
         xgQDHZ/sUYBIj8rGSjcrP8LWE1Tm0+melbc3bBqsVfd6af5xzG2C4Tl7WWgFADK9Qdbd
         JrvqubZb8h2exfX4heLtj8de+vdAC5KIJa1CoG+xmGVo9rBiqJITKfKNibe2IPAgljL7
         Ccl1IyV1I1Na5zHhcztIOWdRECaA4XdC7Y7uzfZSWmZO0zILaKuCcdiEmXJCZupnzBRP
         w16MdP9mbugKYOIGvi+sm4Iz/APFkaOs8xnG+fzj1Cbw1632QoYLwDCOtP/dJyKfx604
         bk3A==
X-Gm-Message-State: AC+VfDwZWWcCHGBxRUaBJjppAcUUsFBjqCWaJTJCFJmwpNmfch/XNIG/
        Jf+66q2xcik5zaGkUK9y09VSFQSW7msfwxwfhVI=
X-Google-Smtp-Source: ACHHUZ7P1EX463Cq2OTmYff9AZF4wLx5SggxZnUfVSs+Sw6MnDyLjOnQXMaSct7979Y0PkgmHPmA8yvPPU3usGND0/w=
X-Received: by 2002:a05:620a:8f16:b0:75d:8e67:52d3 with SMTP id
 rh22-20020a05620a8f1600b0075d8e6752d3mr2614517qkn.73.1685946058695; Sun, 04
 Jun 2023 23:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230531093206.3893469-1-victor.liu@nxp.com> <20230531093206.3893469-2-victor.liu@nxp.com>
 <bd257ed0-71a7-0504-0bfe-14775ac93571@linaro.org> <CAOcKUNWkubMK1MJS73tpbm4bafQv2GAMuq_JOTFbvB9EVDRvxg@mail.gmail.com>
 <8c0b1e70-382d-669c-c0ee-438fada6e78a@linaro.org>
In-Reply-To: <8c0b1e70-382d-669c-c0ee-438fada6e78a@linaro.org>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Mon, 5 Jun 2023 14:20:46 +0800
Message-ID: <CAOcKUNUtXK==K4R2OHFz=_dUjTu9jwiYbcoG412qRxT35yWWmg@mail.gmail.com>
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

On Sun, Jun 4, 2023 at 6:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 02/06/2023 05:54, Ying Liu wrote:
> > On Fri, Jun 2, 2023 at 1:45=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 31/05/2023 11:32, Liu Ying wrote:
> >>> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> >>> configures parallel display format by using the "PARALLEL_DISP_FORMAT=
"
> >>> field. Add device tree bindings for the display format configuration.
> >>>
> >>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >>> ---
> >>> v1->v2:
> >>> * No change.
> >>
> >> How did you implement Rob's comment?
> >
> > Should have discussed more in v1 about Rob's comment, but
> > let me explain why this dt-binding makes sense here:
>
> "It needs to be defined as part of the mediamix blkctrl
> schema though."
>
> Where is it defined in mediamix blkctrl?

I've sent v3 patch set out to define it in mediamix blk-ctrl.

Regards,
Liu Ying
