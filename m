Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022566C77C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjAPQbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjAPQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:30:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3E274B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:19:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q64so29582553pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkZ6p1sWM6e327+u9DFI968nqnYYqypY+VMbq4nZJio=;
        b=MM9f3TBYs7nt1Q8xbmpAJTyQBecU4RriGQYs/0dBETh7Cgc5eZyZ9KBS+PmrmBcru7
         vInyI9hzCwkbyTn5E+pyKBiXc0RMkbSfUIYZR6NRcdBeTCwhF9GTfOFgmtBaTrq5nh0y
         Wx7259mb4fb8vICNaTBBjkkvlg9NkSbmi0O3q1PwpIAqFPtxi1SBSrp87r5PxXyWv0ps
         skST7AGo0lL+n+eaIz9/Nb4IsE4VRc8BXeTCQSBN+gmcIvrdjK7sQLjCt6OQvNRg6YRE
         0aINg7ClTouUIDmOt2Lz/pEr+CKy62u4Omev9TMqi2ec8ZtcBtCB1yR0108e16q6D7KQ
         3dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkZ6p1sWM6e327+u9DFI968nqnYYqypY+VMbq4nZJio=;
        b=3FPQ9yZgFyvCKSHe4Jm0x2mRJTsMgRPaHuNAxUW2L1P06K11ldIeaI1HQZ5sNGrKmF
         xTPnl1yIVDu8xNkov4drJd6DLEmFwYqydeqO3e+JkA4zjhmBqNuWZbf0mgkjjQuBd+T6
         wDrvOupnmZFLTpj2oQYP/7O9UCvTu0g/OAzQNiSjfEIRK+ePu7Rgdwg5JTRwjJLRR3/C
         pzfJqGSFhFIzV4ECmzr/vhcqWH0SzvihX6edNsnZ5Bv3HNOf8IiopK5U/UiSHWC3Y+58
         orPbT7BfyBC6T3J7afbebnou8+NdrQl1r2TmFpOgAaNV1DKhzcqwXj/zF8mxNFpJTp8s
         ve2w==
X-Gm-Message-State: AFqh2krhlPGZt2Ej0bQOeVJcHXi6/64oY4zypRhrbpipbmzlRamvCoK9
        OH+YBWqPCrppdXMCaOkWdZR5Aw==
X-Google-Smtp-Source: AMrXdXv7lZMThAWNboYgauo+mDkEGcyy7Jml1WsBvoJ/U1kb1cvMKZyTC0crrdxBz09gXiqSYr049w==
X-Received: by 2002:a17:902:c401:b0:193:e20:a5a9 with SMTP id k1-20020a170902c40100b001930e20a5a9mr398065plk.15.1673885943235;
        Mon, 16 Jan 2023 08:19:03 -0800 (PST)
Received: from ?IPV6:2401:4900:1c60:63d3:2d69:9f71:187e:f085? ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001943d58268csm13200862plb.55.2023.01.16.08.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:19:02 -0800 (PST)
Message-ID: <3e18a79b-fdd8-63f8-c27a-7515bbb6cb9b@linaro.org>
Date:   Mon, 16 Jan 2023 21:48:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.sharma@linaro.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
 <23b4551c-db79-d859-c037-6ed3c8a11883@linaro.org>
 <6f08d466-9589-ebff-c38d-bf9015a0f6ad@linaro.org>
 <64e4b3b0-fc71-1876-9de8-e51d503d6183@linaro.org>
In-Reply-To: <64e4b3b0-fc71-1876-9de8-e51d503d6183@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/23 9:35 PM, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> 
> 
> On 16.01.2023 17:02, Bhupesh Sharma wrote:
> >
> > On 1/16/23 9:24 PM, Konrad Dybcio wrote:
> >>
> >>
> >> On 16.01.2023 16:43, Bhupesh Sharma wrote:
> >>> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 15/01/2023 22:33, Bhupesh Sharma wrote:
> >>>>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
> >>>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>>
> >>>>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
> >>>>>>> Fix the following '#address-cells' & '#size-cells' related
> >>>>>>> dt-binding error:
> >>>>>>>
> >>>>>>>      $ make dtbs_check
> >>>>>>>
> >>>>>>>      From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> >>>>>>>           arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
> >>>>>>>                 #address-cells:0:0: 2 was expected
> >>>>>>>         From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> >>>>>>
> >>>>>> Don't we want rather to unify the soc address range?
> >>>>>
> >>>>> Well, the assumption in the original dt-bindings was that every reg
> >>>>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
> >>>>> #size-cells to <2>). However, that is not the case for all of the
> >>>>> SoCs.
> >>>>
> >>>> Hm, which device of that SoC cannot be used with address/size cells 2?
> >>>
> >>> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
> >>> be used with address/size cells 2 (See:
> >>> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
> >> SM6115 (and pretty much every other arm64 msm platform newer than 8916)
> >> should be using addr/size-cells = 2 along with (dma-)ranges of 36 bit, as
> >> that's what their smmus use and otherwise some addresses may get cut off
> >> in translation, or so the story went with 845 N years ago.. We can either
> >> pursue this patch or I can submit the 2-cell-ification if you don't plan on
> >> adding more nodes shortly
> >
> >
> > Have you tested this combination on SM6115 like SoCs with various IPs? I have tried a few experiments in the past and not all IPs work well with 36-bit DMA ranges (atleast not on the boards I have).
> Can you list any specific examples? I've been using it for
> quite some time now and I see nothing wrong..

I remember seeing some issues with SDHC controller booting (uSD card use case) with sm6115, but I cannot find the appropriate dmesg right now.

> >
> > So, I think it might lead to more breakage (unless we are sure of a well-tested fix). A simpler patch to fix the dt-bindings looks more useful IMO.
> I'm not saying no, you just have to convince Krzysztof :D

:)

Thanks,
Bhupesh
