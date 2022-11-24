Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F25637148
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKXDx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXDx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:53:56 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078EE7C467;
        Wed, 23 Nov 2022 19:53:56 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id v128so430352vsb.13;
        Wed, 23 Nov 2022 19:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibvFTSt0J4VAYeyVXQ5CCnRzpDJ2HRj4/uCZvBQlKYQ=;
        b=lIZI1ea90GspCmSWdAPh4eOcPS1DxW9yRWLMR6G4iXgO83Lc/x0YffzED6mXMJXHfn
         In1uhGPB5V2aDlZT93f+y1YF7hCZQUjaRafTAALHO/yxInrl77Hkape1vuUGl3Nl/FlS
         ZqP+tR9NcNWC1iCoeyKstZltZ6G6g2hiP+0oSzn1RYrLo2K6PbsDw7hKoeEg4pl6BVDz
         pQEIDnK9lEGEXGNcvT8AJ9VuvVlcEvDSAQmUZ9sk0Uxykb0gbXkJtHy9RMQNFNVUgIdV
         CbIeCD7w6NabTK1ifrYDwgXr4/6r7CVS/sTC14EX0/11Sy5ibQnU+k2ZWsqBzviOk/HN
         XZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibvFTSt0J4VAYeyVXQ5CCnRzpDJ2HRj4/uCZvBQlKYQ=;
        b=uA9MPExFVUp967FkW6PcogGvsDu0GmZXFFMLtfXX4ibjzFQ9cWbqVlqnQy/bZcSA4/
         THg5OzMuWMNrx8n6jfJkmCkEl8BfVbI4j8Zp4qxyVtyLoLIwDb093R2nVa80e5X58Lam
         w7JecWdg3P18JTe1lq5wqFrPuTWhgJEsX/Bdgu3R2rovGj/eQcDhnUQSRt+7cFya0yZP
         +llfzxQGpd/D5zfiGpc3Y4oWphHP+MgxH8FHkBpMrQ3TVUh16yhrn4CZ9FfKuoHusHV7
         ZTget2Pg7Y+FgvAKGfWyS+xoMs2di6+rS3poX5ecMZQHT2Dbwtgc5hll+XJfGfsnJWyU
         vc2Q==
X-Gm-Message-State: ANoB5pkyeeToUsU4fbnnCGkg2fqkZuSAsjexnAb38C9Fk4vW5kPBgX34
        qG/+wCgmV027Qh+9TUI+BxHPzSOcYHE//KcyUuY=
X-Google-Smtp-Source: AA0mqf46Lbr7HB0RPmlqiRZNVfHotrGzS/F6SPn8v8oWlPmdEytMF+SJBhDHo89CVisCAK3HAM8etqwMVWS/sR+swbU=
X-Received: by 2002:a67:fe52:0:b0:3ad:c930:b9bb with SMTP id
 m18-20020a67fe52000000b003adc930b9bbmr8761570vsr.10.1669262035023; Wed, 23
 Nov 2022 19:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20221122085724.3245078-1-milkfafa@gmail.com> <20221122085724.3245078-4-milkfafa@gmail.com>
 <7561a0c3-c63b-a3f2-efeb-4bb0f4ad03e4@kernel.org>
In-Reply-To: <7561a0c3-c63b-a3f2-efeb-4bb0f4ad03e4@kernel.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 24 Nov 2022 11:53:44 +0800
Message-ID: <CADnNmFqswx3VEFBAxUPbznyct2L880H6i6LghF_tAzZ=wS5T8A@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
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

Hi Krzysztof,

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

Thanks for your kind reminder. I'll check for this again.

> > +description:
> > +  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
> > +  that analyzes Graphics core behavior and provides inforomation in registers.
>
> typo: information
>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - nuvoton,npcm750-gfxi
> > +          - nuvoton,npcm845-gfxi
> > +      - const: syscon
> > +      - const: simple-mfd
>
> That's not simple-mfd, you do not have any devices.

These problems will be addressed in the next patch, thanks for the review.

Regards,
Marvin
