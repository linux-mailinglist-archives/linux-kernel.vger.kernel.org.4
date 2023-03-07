Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473956AF90A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCGWlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjCGWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:40:46 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF25494A48;
        Tue,  7 Mar 2023 14:40:15 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1767a208b30so14917277fac.2;
        Tue, 07 Mar 2023 14:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m681k60yBR9G1e4ddgAcYPVhjkuNmgupl9H1oxL9CT0=;
        b=ohI0rjTJ+o8GRDk8Mj8/3nxO/MsIzsPX3Rr9lQWfHOmj3+qT88jzt7NjIqBnKWW9yL
         8Zz5Dx1cSnKuRreGHsHqNP26Sexlx0jxbu+YlNXJDKD6g1ZeF4eOVy9KVVeBcaJTMzEi
         RgCkriZ2Pw7gZDvdo1twqeya9xH6SPDN7yt55/3B9yY45vXAZOgRI0g4eZUZe1WwqOMa
         FEE70QQyZ0/yf9co0E+cQBM6mWLfnhTcok3kC30UPoJd+ReLSFKtrf62lGSzr5CLHA5K
         h+XdiFuBIbkRoP28nxsllIXjZ8JjoziSu1TJXT075OY4/QiDCdNBAOiWmQKvjQ+agpz+
         JHqQ==
X-Gm-Message-State: AO0yUKXjT0WL/cGGpcM1vRw0MfylDdJa94S52CQSdhfmyvwOmIi5GAkX
        D1rPLu1+Xj5LLZQ+s94/UA==
X-Google-Smtp-Source: AK7set/xZ30XN+BA1GsEblPFRbqsoeJFhDL9vcdRJzgWM3rL5Ii+xjed3wQRFdgg8vTveAkTVcygpQ==
X-Received: by 2002:a05:6870:808d:b0:176:4bc1:e5b5 with SMTP id q13-20020a056870808d00b001764bc1e5b5mr9743301oab.7.1678228815080;
        Tue, 07 Mar 2023 14:40:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a05683020c600b0068bcc902b82sm5796088otq.71.2023.03.07.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:40:14 -0800 (PST)
Received: (nullmailer pid 279339 invoked by uid 1000);
        Tue, 07 Mar 2023 22:40:13 -0000
Date:   Tue, 7 Mar 2023 16:40:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Message-ID: <20230307224013.GA276357-robh@kernel.org>
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
 <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
 <e5ed284a-77ac-df6d-1473-e4d96955f65b@opensource.wdc.com>
 <bf6d6b20-8479-80f7-1899-d58e03e6c6c8@linaro.org>
 <f800c8f5-d6d4-8a93-f8e2-3ea46e6d7d31@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f800c8f5-d6d4-8a93-f8e2-3ea46e6d7d31@opensource.wdc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:02:32AM +0900, Damien Le Moal wrote:
> On 3/8/23 00:52, Krzysztof Kozlowski wrote:
> > On 07/03/2023 11:42, Damien Le Moal wrote:
> >> On 3/7/23 17:13, Krzysztof Kozlowski wrote:
> >>> On 06/03/2023 02:22, Damien Le Moal wrote:
> >>>> On 2/23/23 00:59, Kunihiko Hayashi wrote:
> >>>>> Add UniPhier SATA controller compatible string to the platform binding.
> >>>>> This controller needs three reset controls for Pro4 SoC, or two reset
> >>>>> controls for PXs2 and PXs3 SoCs.
> >>>>>
> >>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>>
> >>>> Rob,
> >>>>
> >>>> Are you OK with this patch ? I can take it for 6.4.
> >>>>
> >>>
> >>> You got Review (which includes also "Ack"), what are you missing here?
> >>
> >> By the way, I am not seeing/have not received any Ack. Hence why I checked with Rob.
> > 
> > You were on Cc... Did I end up in spam?
> 
> I did get your review email, but I do not see any Ack with it. Was it a
> different email ? I do check my spam folder from time to time but didn't see
> anything in there that would not make me rich :)

Reviewed-by is more than an Acked-by, so if you have either one you can 
take it. And Krzysztof is also a DT maintainer, so no need to wait for 
me.

Rob
