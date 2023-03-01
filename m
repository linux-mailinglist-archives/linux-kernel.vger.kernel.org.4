Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13B6A6BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCALcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCALce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:32:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F03BD9A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:32:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso6108514pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ZirgB4Yhckrz+KQPfBVSWT970rRQ3ZJ8hkrrrImAKU=;
        b=fRUdo55YP+kpu+u7n/mRlMz0zACEsCL0MUGAInvz87WT0+d7aF0Ewv90GNOD4R7u+E
         /uNIPY+sgorcaWXpnxnvf8Xg8VZXF/M4YovQEl3xc4m1tqjMDAWstYEllwUHHrIZ/bq2
         koEz4VPy+FeqN/Hew4KCEZJxO0xRZyaEQk1R78gH45QBRrFmGyUMViWLky6KCvkOi/Ar
         FxbIPMEZT8qY3fDLNO5PC1sbYTAE0zRwe4n6Q3fmeOQlqxcNn4/rEswo2cSqPtwh2+rm
         jmPpmqT87oqyDEyljODM4JbQcIf8l8Pun1lIkLGGOyuLHXQb5OMYQEzLr/+Pyaz4JzSO
         TKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZirgB4Yhckrz+KQPfBVSWT970rRQ3ZJ8hkrrrImAKU=;
        b=6fkhcxFoE8B+aRwqbDMzIGbnUSuJHi1NHBLObGKbT19AFPPWviqCU1ZKYSkLSruGKU
         DXzAIGFOTS8beELYTYEFD4K4tmLaj4cNS3t6WaTaqDAvZcwSAHPFMjuClXz3+DUR1aMI
         NPIg+VsDxVakEZd0PVBwM9jss4jzhHuP0Z2fAkSbTAOIMbmIeArthvaja/iagzGqmuth
         W/s4PFUQXfnFZhT6XZxeBUF8oHOx1X69I3ftAnqISY2egu/v6h5ZLRfavMSgr1yVe79u
         65wzxkCNCKUNmKmtw80jNkgNQqZCM1yJfE4IGDyGoPi7RJndPrUsyydqzSMA4/PJzhDJ
         AkUA==
X-Gm-Message-State: AO0yUKUkxP4MWfaERloCPs249CJU4gw21rU4gLy3YAjonAs/PWV+EMb/
        UfyX4WSNMvAf4m7ZciXucsPn
X-Google-Smtp-Source: AK7set/5zhlQ2n8EhkA2dk9M3y3CXiNyF31mQ7rxzlsC6LRSNjj/8Hi1X8Tcre/ZzbggK6znrmiM4w==
X-Received: by 2002:a17:90a:190f:b0:233:c9e7:c885 with SMTP id 15-20020a17090a190f00b00233c9e7c885mr7009726pjg.36.1677670352586;
        Wed, 01 Mar 2023 03:32:32 -0800 (PST)
Received: from thinkpad ([220.158.159.248])
        by smtp.gmail.com with ESMTPSA id q26-20020a63751a000000b00502e6c22c42sm7122236pgc.59.2023.03.01.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 03:32:32 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:02:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
Message-ID: <20230301113227.GE5409@thinkpad>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
 <20230228172952.nfjce7cjos6tume3@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230228172952.nfjce7cjos6tume3@halaney-x13s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:29:52AM -0600, Andrew Halaney wrote:
> On Tue, Feb 28, 2023 at 10:17:36PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series fixes the issue with PCI I/O ranges defined in devicetree of
> > Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
> > identical mapping for the PCI I/O range. But the PCI device I/O ports
> > are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
> > mostly bogus. The lack of bug report on this issue indicates that no one really
> > tested legacy PCI devices with these SoCs.
> > 
> > This series also contains a couple of cleanup patches that aligns the entries of
> > ranges property.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
> > 
> > Manivannan Sadhasivam (16):
> >   arm64: dts: qcom: sdm845: Fix the PCI I/O port range
> >   arm64: dts: qcom: msm8998: Fix the PCI I/O port range
> >   arm64: dts: qcom: sc7280: Fix the PCI I/O port range
> >   arm64: dts: qcom: sm8550: Fix the PCI I/O port range
> >   arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
> >   arm64: dts: qcom: ipq6018: Fix the PCI I/O port range
> >   arm64: dts: qcom: msm8996: Fix the PCI I/O port range
> >   arm64: dts: qcom: sm8250: Fix the PCI I/O port range
> >   arm64: dts: qcom: qcs404: Use 0x prefix for the PCI I/O and MEM ranges
> >   arm64: dts: qcom: sc8280xp: Fix the PCI I/O port range
> >   arm64: dts: qcom: sm8150: Fix the PCI I/O port range
> >   arm64: dts: qcom: sm8450: Fix the PCI I/O port range
> >   arm64: dts: qcom: sm8350: Fix the PCI I/O port range
> >   ARM: dts: qcom: apq8064: Use 0x prefix for the PCI I/O and MEM ranges
> >   ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
> >   ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
> > 
> >  arch/arm/boot/dts/qcom-apq8064.dtsi    |  4 ++--
> >  arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi    | 12 ++++++------
> >  arch/arm64/boot/dts/qcom/ipq6018.dtsi  |  4 ++--
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi  | 12 ++++--------
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi  | 12 ++++++------
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi  |  2 +-
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi   |  4 ++--
> 
> Would you mind giving sa8540p.dtsi to similiar treatment? I will admit
> I know next to nothing about PCI techically, so I can't even comment
> with confidence that this is needed there, but it looks similar to other
> descriptions modified in this patch series.
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sa8540p.dtsi#n197

Ah, I didn't spot the separate ranges used for this SoC. Will fix it in next
revision.

Thanks,
Mani

> 
> Thanks,
> Andrew
> 

-- 
மணிவண்ணன் சதாசிவம்
