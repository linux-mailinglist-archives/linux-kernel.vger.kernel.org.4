Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28E763A28C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiK1IPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiK1IPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:15:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B456151
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:15:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so5676719plw.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41dMnLlQhVdjKXFxljKHhsQK7EgN1jbnFbZkDumWU3k=;
        b=NCmqK9rQ94cfbvI1oGd7hVmrNMvAbjRG3S0lUj+b8ld9Mr0X+bVPi1WKUzclB49N2R
         5eQps+vIbFLhlk5P2Z7NmEP/q8Bkra4og1rIheAvILOHGsCsXSo/R6WagfoL8DMlXoni
         SQqY9LYvVjLdl6sqtSkjt9AEwvJWMAGdW2rSj9qJB9igzYjtfLpWMqMkxkhm/F9adD51
         JkWuj0AkF4hofIsGXNtu5nhAOIsMUBPYyjeTG56bDvXVXz+JJDk7m/Mq4eTohbQy0nCi
         qQum4GPrOKMwOH1OWDhLE9g9HzmSi2xHfYRx01zN7ahDenswr82aF3IR74gBh2qi66Tj
         AOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41dMnLlQhVdjKXFxljKHhsQK7EgN1jbnFbZkDumWU3k=;
        b=YMBCEwjlN5peESD1sZyJGPEpzMhBlDGGHo1G3I5hDde332ZHaXdovfY/XwqabqAjxL
         kILw5XXie6Nm+yGblWv8yMnaEoksa8p2+6ahkr3LB7TsiHVH/07RpLTZlJ+O/J2/c12k
         eNAsxeO1EsBy3+Imrm4efnFNTSr7f0yplqV+Ll1fbikmRojSkjcPvGxHaVkjUl3C6Snn
         TAmUC4Twy68JgdHZoyGqBuHlcQjpYG0wYp3ctRE8UHKPDzXnRseCJL8WvOEj2gJzseh2
         wBsSVOOR8/nbGtvjHRBRcIuD/G8yxGQTwdxKJaeXelGp8iHf9MfH6Mf6cCjXlnfaZeq3
         LssQ==
X-Gm-Message-State: ANoB5pkSHBHezMqEI465MnStx7YnJM9KRCFp6WVw2flVLXva9lIx4Gqz
        3cxN39fIuR0wQ7d414Ugv1Kw
X-Google-Smtp-Source: AA0mqf6mLO+PCP/hLz4RzLO/qKBWBH5saTD6FZRHSdv23lFs82iecpQbnFjLPZdDntZseE5lX6lfOg==
X-Received: by 2002:a17:902:aa06:b0:183:7f67:25d7 with SMTP id be6-20020a170902aa0600b001837f6725d7mr31064610plb.164.1669623339852;
        Mon, 28 Nov 2022 00:15:39 -0800 (PST)
Received: from thinkpad ([117.217.177.120])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b001868ed86a95sm8085387pld.174.2022.11.28.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:15:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:45:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221128081531.GA60329@thinkpad>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <6a5b523d-711b-d809-06b9-fdada64c9c65@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a5b523d-711b-d809-06b9-fdada64c9c65@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:44:13AM +0100, Thorsten Leemhuis wrote:
> On 14.11.22 12:03, Manivannan Sadhasivam wrote:
> > This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> > 
> > As reported by Amit [1], dropping cache invalidation from
> > arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> > (most probably on other Qcom platforms too). The reason is, Qcom
> > qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> > for validation. The modem has a secure block (XPU) that will trigger a
> > whole system crash if the shared memory is accessed by the CPU while modem
> > is poking at it.
> > [...]
> > [1] https://lore.kernel.org/linux-arm-kernel/CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/
> >
> 
> I have Amit's report on the list of tracked regressions. I also noticed
> the proposed change "arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency":
> https://lore.kernel.org/all/20221124142501.29314-1-johan+linaro@kernel.org/
> 
> I have no expertise in this area, but it looked somewhat related to my
> eyes, so please allow me to quickly ask: is that related or even
> supposed to fix Amit's regression?
> 

The proposed patch doesn't fix the regression reported by Amit. But the patch
itself fixes an issue that might be triggered more frequently by c44094eee32f.

Thanks,
Mani

> Ciao, Thorsten

-- 
மணிவண்ணன் சதாசிவம்
