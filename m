Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A96C48C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCVLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCVLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:14:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A1A4C6F2;
        Wed, 22 Mar 2023 04:14:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so71273185edb.11;
        Wed, 22 Mar 2023 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679483678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQMPrXeAiv4ATfaNwsUCZoGnla70bhGZgF/+CvtNnY=;
        b=leR6cYRJoRYPMxJsQhkSc+xnpejhTD209af42m9+kFja/4+30O6K1Nsvq3a8Gxh5wj
         WVk/7FVhDN04q4mMOob9+apU9EYplmUOEUiY6vBJ0HukucA74fwIlLVaBsVzw6P58RYk
         FI4zaoMMKwGtj3abvTlbWkl6h61rixvz5UX++HmyqLE3a6K7hWVhDVz4jrvocDKfUpaP
         ygJiV4YnKPHk22gwG3ZSary/PoCFZX77ubbGqoJ8EmAB7sQTRsNVO2I35GFMqVLLo6jD
         8q6szOxy/3cEbO4+wafZeIFgPqsuMGdivXqUBEgAoMkCnj2ED+KfWMfkPH+3CHx1LdV7
         gyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNQMPrXeAiv4ATfaNwsUCZoGnla70bhGZgF/+CvtNnY=;
        b=GVtClTB+CeC1ibYFPGGO6I80dP5s6pnUqbN4OB9ELx5DH6C64Fo3vjIJgsJOxxvirf
         elevPo/rafRgS3yxoXSN9BATA3ic4bxCUmLdWA0WTTxu/3ORgfKs5wU68OjJpDTRQV7r
         tpyTQDZGJYHzRvz5mmUL4/PPhUSaYe4/s0WvefeKnszQFuf6G6TC8KbEJv1XkkepURR9
         Iz1ut0AF7Lp7a5hyi4T62px/9P7szGyutPe0yKGA2qQFaC3nOKjf+O1cniOsbYIekjWI
         779yl+qdhWaFBdxGGA1F/Elc4bwMJ6Yp3Y5SEvZAqnpvIWTLl0HwGFZWScemPzXgLaz6
         QvIg==
X-Gm-Message-State: AO0yUKVtrmCAYq6uCpJ/t57pFNNWKZ9I4EXUqM8emXsO9ynXttCMFRi6
        JeDbiJxMXNA/haPJpJ4+b09oG4io1dlmSOxF1ehWa2Vz
X-Google-Smtp-Source: AK7set/vzRkpZMD3B/M4QL5rTBBvj3PbxXlggp07G+keSkvrHFE/5iOVPQ1EDTrw6B7Brkrom2QDqG4MLwq9BwtHWaE=
X-Received: by 2002:a50:f683:0:b0:4fc:7014:f91c with SMTP id
 d3-20020a50f683000000b004fc7014f91cmr3281812edn.5.1679483677879; Wed, 22 Mar
 2023 04:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com> <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com> <20230213175006.GA310433@p14s> <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
In-Reply-To: <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 22 Mar 2023 13:14:25 +0200
Message-ID: <CAEnQRZC5t=qmo+OJLW+dqZg4gH9cAN=paWDSGbrJb2AvkKBqxg@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Second, there should always be a segment that adds the right information to the
> > TMCL.  That segment doesn't need a name, it simply have to be part of the
> > segments that are copied to memory (any kind of memory) so that function
> > rproc_elf_load_segments() can do its job.
> >
> > That pushes the complexity to the tool that generates the firmware image,
> > exactly where it should be.
>
> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
> >
> > This is how I think we should solve this problem based on the very limited
> > information provided with this patchset.  Please let me know if I missed
> > something and we'll go from there.
>
> I am not sure how to proceed on supporting the current firmware. what
> should I continue with current patchset?

I'm in favor of merging this patch as it is. Already gave my
reviewed-by tag above.
