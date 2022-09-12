Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67635B6154
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiILSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:54:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D911A065
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:54:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y17so17288790ejo.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s6eyAy8fsLw07yjiJG3Y3WBiJuoGSCNuzrzQdigxyeM=;
        b=askJsOGRMViVP9TH+eLx5gdy0vVV+seDJ07sDVdRCd9w9rv5EorVk3WrM6eBPX1GDv
         1WVho2cEul8r5RZBSPX60xC7/NDqWE3KXxOCf+UjpLVSLoN7HjaXhPDO6OkP2YCfRWLo
         im4RTcL6sR8LhO08eUFsuAgPRipICzT3OrczorC2ypefvcgyxi1gTWfM0iT/tK5mXIAi
         d4uB5Ir82U0Kpgm8wEsK0FSCfoP0IlPdy3mqkIIXF11zWxDIigtwQijzCxOHne4zt+NJ
         3OdjOeGNCljXlTUUYbmpEUY/mBnEoDL2H/+6Fhe8XNAE3GvUSeTx/Kk5fl/KyoO3CgAu
         BM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s6eyAy8fsLw07yjiJG3Y3WBiJuoGSCNuzrzQdigxyeM=;
        b=qlmRGBqJ77yraReywfhGmn69FaLpOtvEqzbPursMc907XlTwoZTNv38uWdGUzBcWLy
         UjABAMrFzeFSoZDl+wfu6DQAm4EPBBM2optX6YfIIzJPK/QCY1yyGMZMktBzj4a7ha+U
         FfMyieGx6EugLAy+CEhWWp9m6hpUBtBSe88pNb7TH+I7BnrOukvkvF1AOeHfCqZPj+QU
         TKhOtVGPig7EbG3Q6w6qNqn8+rCGKOEQ/Xqmuf/zUKe+w6+I61Rx0GSdZYnCh7ZwrRER
         PRYKR3IN/k2cHky5egx+apzEL3yKTLlrFX5k9u3UPonxJhoIuKoq7JXLiTC1GQm/2io6
         6jsg==
X-Gm-Message-State: ACgBeo2/B77srPmliEu0C2QIFWFwReSPmt4QB6uugBU9LL2JB49zTPnt
        rrutIoFtTJVFXo4q3mYnjX0PJUpul8ckmUWHpDIoDw==
X-Google-Smtp-Source: AA6agR5PZCpqVbSoRQoHff6UH1Bvdy/S60yTjJnaKok0R7uO2OjDQm9D8qrinN9WiJdngWGpT8DHhphXW/nHH2w44Uo=
X-Received: by 2002:a17:907:1690:b0:77c:37be:2345 with SMTP id
 hc16-20020a170907169000b0077c37be2345mr6515986ejc.359.1663008858057; Mon, 12
 Sep 2022 11:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220817202538.21493-1-leoyang.li@nxp.com> <20220817202538.21493-2-leoyang.li@nxp.com>
 <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
In-Reply-To: <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 12 Sep 2022 11:54:06 -0700
Message-ID: <CAOesGMjsegmLUVxbjZJ3kgxnDkVTyxy5BB=is2CM_7Se7TQrWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
To:     Li Yang <leoyang.li@nxp.com>
Cc:     shawnguo@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:05 AM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Wed, Aug 17, 2022 at 1:26 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > The original dts was created based on the non-production rev1 silicon
> > which was only used for evaluation.  Update the PCIe nodes to align with
> > the different controller used in production rev2 silicon.
>
> How can I confirm what version of silicon I have on a system?
>
> My non-evaluation commercially purchased system (HoneyComb LX2K) has:
>
> # cat /sys/bus/soc/devices/soc0/revision
> 1.0
>
> And I will be really grumpy if this system stops working. It's what I
> use to do all my maintainer work, even if that's been fairly dormant
> this year.
>
> It's overall setting off red flags to update an in-place devicetree to
> a "new revision" of silicon instead of adding a new DT for said
> revision. 2160A has been on the market for several years, so it just
> seems odd to all of the sudden retroactively make things
> non-backwards-compatible.

Confirmed that this patch renders my HoneyComb unbootable -- PCIe doesn't probe.

Shawn, please revert, and be on the lookout for similar problematic
approaches in the future. Thanks!


-Olof
