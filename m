Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618DE6007DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJQHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJQHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:41:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2813DDF;
        Mon, 17 Oct 2022 00:41:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so22850104ejb.13;
        Mon, 17 Oct 2022 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jp8HrSCso1cEfmmqdQBEdUtj0Bbq01HpoZXdky0tskI=;
        b=fbtJmyV8qM0M7KbwD36UBnvc5tzo0doZXFZ/rKdCDx8J3dYTtTSn/IYu+gZtMCBLgp
         lQvG5PJDQN7Yrzkbc8NJ0q6iGhSvRMMKQnlQjzKIbd5V+AF6ny6Pwsvs2V4+pWCEFIC+
         gaqbTTfnIQClaSTJVTF71H9Mfc9yqtRPvqIm4F7sHF1JaXtTiuW99vHpazTA9lqm9za8
         ac8ZWPMB+cf0oq+dp0GoqNYrZj5ldg8eZLQ2JVAoG+z9Bk47MrXDNLLf3OX+ung1X3aK
         an7QqerLK5UB69vodObQcJB8xyhiv2AjbIjDY2RkhFo7jLrkwK4gz5XJ1u36pFoNZY2z
         AQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jp8HrSCso1cEfmmqdQBEdUtj0Bbq01HpoZXdky0tskI=;
        b=m0QRq3sghvRHaNL0NC7WBMqf+0UxmOpaqStSWPA5icmxipCRqPzFwr2auLnPAa6iUx
         v6bY8RXPgTie1BuHEMim+1UusAVDoS78M83d13pAdeQ6WYlHWGizwa1+vF3F4Wdj9yub
         uuoedS1y36rGIX82vKaE0nwFADTBhKVtGlsWgDU6LZWXBFCGrqpFk8GdZazP+PQTrPUk
         YRyBV1wO9M74nzhJUYaKo+Hi81QssttjzBb6qN44YHW20COmOKXdOWDjU0x5Mj2OnbQX
         w4Ooak/cK1kEIF3navrqDSPuoccIg4kAPLKLbZD5kdEdw97rhw5PZ+YyIp9sqg9XIu5R
         jMqA==
X-Gm-Message-State: ACrzQf36H+LSUAmIsVCxKH0afZkR+5hlecvEzfv2A1bSd51dxhz7F373
        7HLG0tD3/fckhI/7acacLwIW8r6FoFT/zYo+iUY=
X-Google-Smtp-Source: AMsMyM71lZzbP/LAJp4Ui5wekihf0780L8XnOegyGGstUHtaFcNanS3NyUllyd/7igndW+Z+Um8u8n5p2XT0oK/PrJA=
X-Received: by 2002:a17:906:5a4b:b0:78d:4e5a:d101 with SMTP id
 my11-20020a1709065a4b00b0078d4e5ad101mr7459289ejc.196.1665992475700; Mon, 17
 Oct 2022 00:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com> <Y0snkMEp9WqGtzom@paasikivi.fi.intel.com>
 <Y0tA4cZBdwCOkaOs@pendragon.ideasonboard.com> <Y0xnXM+Iw5OkdKj6@paasikivi.fi.intel.com>
 <Y0xxlTP53dwx8VD+@pendragon.ideasonboard.com> <Y00ASntfSkMsWTN0@paasikivi.fi.intel.com>
In-Reply-To: <Y00ASntfSkMsWTN0@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 17 Oct 2022 08:40:49 +0100
Message-ID: <CA+V-a8vtAAkmV6BfP0azNOTcxDbs2yaCbKQ4M_hrsTmRv+OQaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Sakari,

On Mon, Oct 17, 2022 at 8:12 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Mon, Oct 17, 2022 at 12:03:17AM +0300, Laurent Pinchart wrote:
> > Hi Sakari,
> >
> > On Sun, Oct 16, 2022 at 08:19:40PM +0000, Sakari Ailus wrote:
> > > On Sun, Oct 16, 2022 at 02:23:13AM +0300, Laurent Pinchart wrote:
> > > > On Sat, Oct 15, 2022 at 09:35:12PM +0000, Sakari Ailus wrote:
> > > > > On Sat, Oct 15, 2022 at 09:25:37AM +0300, Laurent Pinchart wrote:
> > > > > > On Fri, Oct 14, 2022 at 07:34:58PM +0100, Prabhakar wrote:
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Always return zero while stopping the stream as the caller will ignore the
> > > > > > > return value.
> > > > > > >
> > > > > > > This patch drops checking the return value of ov5645_write_reg() and
> > > > > > > continues further in the code path while stopping stream. The user anyway
> > > > > > > gets an error message in case ov5645_write_reg() fails.
> > > > > >
> > > > > > Continuing all the way to pm_runtime_put() is fine, but I don't think
> > > > > > the function should return 0. It's not up to the driver to decide if a
> > > > > > failure would be useful to signal to the caller or not.
> > > > >
> > > > > If the function returns an error when disabling streaming, what is the
> > > > > expected power state of the device after this?
> > > >
> > > > That's up to us to decide :-)
> > > >
> > > > > The contract between the caller and the callee is that the state is not
> > > > > changed if there is an error.
> > > >
> > > > For most APIs, but that's not universal.
> > > >
> > > > > This is a special case as very few callers
> > > > > check the return value for streamoff operation and those that do generally
> > > > > just print something. I've never seen a caller trying to prevent streaming
> > > > > off in this case, for instance.
> > > >
> > > > I think the stream off call should proceed and try to power off the
> > > > device even if an error occurs along the way, i.e. it shouldn't return
> > > > upon the first detected error.
> > > >
> > > > > Of course we could document that streaming off always counts as succeeded
> > > > > (e.g. decreasing device's runtime PM usage_count) while it could return an
> > > > > informational error code. But I wonder if anyone would ever benefit from
> > > > > that somehow. :-)
> > > >
> > > > I think it could be useful to propagate errors up to inform the user
> > > > that something wrong happened. That would involve fixing lots of drivers
> > > > along the call chain though, so there's no urgency for the ov5645 to do
> > > > so, but isn't it better to propagate the error code instead of hiding
> > > > the issue ?
> > >
> > > I also don't think hiding the issue would be the best thing to do, but that
> > > wouldn't likely be a big problem either.
> > >
> > > How about printing a warning in the wrapper while returning zero to the
> > > original caller? This would keep the API intact while still leaving a trace
> > > on something failing. Of course the driver is also free to print whatever
> > > messages it likes.
> >
> > While I think error propagation could be more useful in the long run,
> > printing a message in the wrapper is a good idea. I like centralized
> > error handling, it has a tendency to go wrong when left to individual
> > drivers.
>
> I can send a patch...
>
To conclude, for v3 I'll continue down the code path upon error and
then report back the error?

Cheers,
Prabhakar
